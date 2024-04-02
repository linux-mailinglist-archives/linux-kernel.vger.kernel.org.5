Return-Path: <linux-kernel+bounces-128354-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A17988959C5
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 18:33:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 131A31F2328B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 16:33:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C8FD159214;
	Tue,  2 Apr 2024 16:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EalIXek4"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02ED35B692;
	Tue,  2 Apr 2024 16:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712075569; cv=none; b=OkNKhVjXQpcvC9pBtc8nsV/+/PuoBZdOYiWZCCi+aXbevXXETv9RXpINvOhJGxTertJR2h4IA5KgNwRbSRCwTQCFRoBFyacG1aocbttiz8YBBtlvGmU+ySjDu88xn2B03uGN9fRkfQq0I4hy07OZ7JGZ9MrQS7x3ROkF2r+A+rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712075569; c=relaxed/simple;
	bh=OhhVIjDcqe8g+hQ+LDlCyECZheLKdw94N9qys8UDy/c=;
	h=From:Subject:To:Cc:References:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=a51FOXWJejLnrZPmlMpPWXERPs4o/LvSsqFOxntVNp5tkBLEkW+hXaKgmREQnScZkQgXmKFP7bB4DiVkz74wtx9UivNLhw6G271y71zgtql305VNmHy4ytl1ww3Z8yp1snyzbusEvHSccsWoy9qDTtXLh0ZsAaHRWCIalaxtc3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EalIXek4; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4161d73d855so5548015e9.1;
        Tue, 02 Apr 2024 09:32:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712075566; x=1712680366; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:references:cc:to:subject:from:from:to:cc
         :subject:date:message-id:reply-to;
        bh=47eBT3ynKSSdXwM18wwMFfMaKyRoZYguxUBUem9SbTM=;
        b=EalIXek47nJ8yVUy7Smr0hy3bXJVrP84/pB4/W/zfD08uhHTz3dGmsvOhOlszBdNsq
         FN0KHY5zeYiwVXHPRixwFox1A0CB6RKQPSMED2uQI1tQmWxDgA0lWavZUmpqCexGDTe9
         4BM9DqdyxzYVcv9wL3xS1q2CTvtDFYR7XsMdTbc+i8r631A5KdKu4zt2EcmjoOa8ChuD
         E14Lhtk4jgCSm8seVbaWe65t/ppM8zJyPkHHQEvv8inc5mVC6aqLHMUCxEMDKWL2O8Ld
         EqDsRt76cpmrpEPRpWMvMnWBWnBEt8H921Eonsb0S08ivwadqjiYIkemQCJawqwKhyks
         d54A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712075566; x=1712680366;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:references:cc:to:subject:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=47eBT3ynKSSdXwM18wwMFfMaKyRoZYguxUBUem9SbTM=;
        b=ZEhzVjoWDTxr4ZD1La4moRHt4Z/hwnoy5LkunalJSuhORTgHbI+YyfAzvBPu4kyOyt
         OCmHCx8Is4m4paRwlVOk/wjpA8yuHCh/0eBuLTMnUAokjAUjSlryOy0pF63V/8cBgqED
         d0FvDaEEpZ5pITXGRRSyvNXMDPWzGa0GU3k2+hSrCAyqFnC84JWlosabXE73Eg41OKAo
         a4x4FJ/JESoFnbAKj/A80iUE925ouoh8QE5Ss8sp/y5f1Wank8vXjWeQTMzEcNtHqcEj
         bZn/+7jJgWBrXOkIqWD2tEUqSZckUvbjAE39lK9e8qxDvLoQ/Qn5ebC2dK+A1VnLu5gm
         V11Q==
X-Forwarded-Encrypted: i=1; AJvYcCVCrCXDkh5VP8TofhRAqfxyYZeFD9rWEYkHCXyJNvwMfm7Hlb0BTd+tu+6HexR5ekQNWxhwvdHB6SRQ70CjaIGmPADofsu6jjYxEJ+lAW81p/byxksfHy22N3zw3rGKfC8wv4OU
X-Gm-Message-State: AOJu0YxR+alPwDps13FoOLUI3nCdJGgrjAND4ihty3GAuuCGwxocq44x
	dPp15dG4G6deudiQTNkOa7fy29WKNdNWQ/RQrCVwfjGjOzQG4m6f
X-Google-Smtp-Source: AGHT+IGJZydWlDRfkV7i4KmZOfZhCIWU4rygkI2aJzYNZ6RuLcECuhBO0pmLlMAmX8y0lweAhjl42w==
X-Received: by 2002:adf:a494:0:b0:33e:bf34:4af1 with SMTP id g20-20020adfa494000000b0033ebf344af1mr2034206wrb.39.1712075566032;
        Tue, 02 Apr 2024 09:32:46 -0700 (PDT)
Received: from [192.168.1.122] (cpc159313-cmbg20-2-0-cust161.5-4.cable.virginm.net. [82.0.78.162])
        by smtp.gmail.com with ESMTPSA id r8-20020adfb1c8000000b0033e206a0a7asm14639052wra.26.2024.04.02.09.32.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Apr 2024 09:32:45 -0700 (PDT)
From: Edward Cree <ecree.xilinx@gmail.com>
Subject: Re: [PATCH V4 0/5] mlx5 ConnectX control misc driver
To: David Ahern <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jason Gunthorpe <jgg@nvidia.com>, Christoph Hellwig <hch@infradead.org>,
 Saeed Mahameed <saeed@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Leon Romanovsky <leonro@nvidia.com>, Jiri Pirko <jiri@nvidia.com>,
 Leonid Bloch <lbloch@nvidia.com>, Itay Avraham <itayavr@nvidia.com>,
 Saeed Mahameed <saeedm@nvidia.com>,
 Aron Silverton <aron.silverton@oracle.com>, linux-kernel@vger.kernel.org,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Andy Gospodarek <andrew.gospodarek@broadcom.com>
References: <20240207072435.14182-1-saeed@kernel.org>
 <Zcx53N8lQjkpEu94@infradead.org>
 <ZczntnbWpxUFLxjp@C02YVCJELVCG.dhcp.broadcom.net>
 <20240214175735.GG1088888@nvidia.com> <20240304160237.GA2909161@nvidia.com>
 <9cc7127f-8674-43bc-b4d7-b1c4c2d96fed@kernel.org>
 <2024032248-ardently-ribcage-a495@gregkh>
 <510c1b6b-1738-4baa-bdba-54d478633598@kernel.org>
 <Zf2n02q0GevGdS-Z@C02YVCJELVCG> <20240322135826.1c4655e2@kernel.org>
 <e5c61607-4d66-4cd8-bf45-0aac2b3af126@kernel.org>
 <20240322154027.5555780a@kernel.org>
 <1cd2a70c-17b8-4421-b70b-3c0199a84a6a@kernel.org>
Message-ID: <0ea32dd4-f408-5870-77eb-f18899f1ad44@gmail.com>
Date: Tue, 2 Apr 2024 17:32:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <1cd2a70c-17b8-4421-b70b-3c0199a84a6a@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit

On 26/03/2024 14:57, David Ahern wrote:
> The proposal is an attempt at a common interface and common tooling to a
> degree but independent of any specific subsystem of which many are
> supported by the device.

[ Let me prefix this by noting that I'm speaking personally here, and
  not representing the position of my employer. ]

You can't have a "common interface" and yet be "independent" of anything
 that could give semantics to that interface.  What you have is a common
 *transport*, used to connect to a *vendor* interface.
If you can't even bring yourself to be honest about that, it's no wonder
 you're getting maintainer pushback.

Do we need to go all the way back to operating systems 101 and point out
 that one of the fundamental jobs of a kernel is to *abstract* the
 hardware, and provide *services* to userspace rather than mere devices?

Frankly, this whole thread reads to me like certain vendors whining that
 they weren't expecting to have to get their new features *reviewed* by
 upstream — possibly they thought devlink params would just get rubber-
 stamped — and now they're finding that the kernel's quality standards
 still apply.
Complaining that devlink params "don't scale" is disingenuous.  Patches
 aren't languishing for want of reviewer resources; it's just that it
 takes *submitter* time and effort to bring them up to the quality level
 that's required, and occasionally the vendor has to (shock! horror!)
 tell the world what one of their magic knobs actually *does*.

If all the configuration of these Complex Devices™ goes through fwctl
 backdoors, where exactly is anyone going to discover the commonalities
 to underlie the generic interfaces of the next generation?  What would
 configuring plain vanilla netdevs be like today if, instead of a set of
 well-defined cross-vendor APIs, ethtool (say) had been a mechanism to
 write arbitrary values to hardware registers on the NIC?
These commonalities are key to allowing a product category to mature.  I
 realise vendors in many cases don't want that to happen, because mature
 products are largely commoditised and thus don't command huge margins;
 but Linux isn't here to serve vendors' interests at the expense of
 users.

On 23/03/2024 01:27, Saeed Mahameed wrote:
> It is obvious to everyone that in the AI era, everyone needs
> customization

It's always possible to argue that the New Thing is qualitatively
 different from anything that went before, that these "multibillion
 gate devices" need to be able to break the rules.
But the truth is, you aren't that special.

-e

