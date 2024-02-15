Return-Path: <linux-kernel+bounces-66860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3705E85628F
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 13:09:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB1441F23486
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 12:08:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 566ED12BF15;
	Thu, 15 Feb 2024 12:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="tpSBuAoa"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBC8B57872
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 12:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707998930; cv=none; b=H9GmLtDFMA6wmzzSsy0pZ0HWq/x4tVhSvDU2j9NfCvTmfP1SRfWMH/GYR1s2NvXM7X5WIfrg6VKxREDgwa/2Y2FLFXkgCuBYm82g4esGWBIaRdNSS7CRu2pBE5KjyrP0CRs4TROgG4VP4EXMD7FeXvK+iboWi8mosu5V3UJBJZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707998930; c=relaxed/simple;
	bh=2R+2SYI+vDxPHDhMyo/AhefkTHa62dvSGCCw3EsDWiI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gvHlnq9jNe6Z0lQyAxOuVUlaX2hVbIKUGSq1XE8YBNT5yiAvd5xDnDZDHRYJlCupbNnBPJQtdBz8JKuKA9zcx0maYAowvngPx75aUsVqFSyltu3wd1F1cGiHwQG5VN5o3DBRGd9McN/NS4bM5900Nu0t179cakV3IdrywTzbbDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=tpSBuAoa; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-33934567777so424345f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 04:08:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1707998927; x=1708603727; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BASPsZRieoQj9jYTUskhFfUS6hYoPGwKU3/AwR9xS+w=;
        b=tpSBuAoaCppegz3MUOQInY33MjMUga28yQcmBtj0wgMjuKx6C54AUnYscOI2MSRzLu
         clnB4IOA4X1t7m1Z71knnBIwyIjrkZgn/r8C3Kbpr0lVf4VPXgee8HFKKm5usiB9RV9d
         /6Fwp8RCTcIoAJTHjmVh/GtqEUuR62X7UNQCUp8AsNDYnnQSDLBeEpEpdwNFkK2bFBpZ
         8X7ONyvhlwFOcbDpsTUJS/AGLjotLymSDUOFGRwT4dpgWngnO+SoZKooloE5ZF17uzV6
         GsGIhs0U69huG9gSJzHUergMd9ao3g+uLBI696lBJu4RAnCmf5f8OSLSEYq1xAZKUBwo
         S7rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707998927; x=1708603727;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BASPsZRieoQj9jYTUskhFfUS6hYoPGwKU3/AwR9xS+w=;
        b=tXTliStPjO9telLQF0lk4arj2vmOICfNuT3fh4MU5vW8jkHpgeMwFm3tXnJC2+xOgS
         IxGfLU5/RHWr5va/OBFoP3TJrerm0iBULKkDk1fklO1gOOl1MkrRhY3SmDtMC4vvbedv
         LmrZ8uzpojmt+5WqwOe6672B/x735UDtvMeapiJIn2Fy8p+CX8RAOPv5GoVEHKAjNTt1
         of9/PTex3LsGswaUYvwHMxspUkUwAEYCStFE7q2WJ+HDE5+bmNK/0CgkuTyRzHX7w9xr
         QtqmSLsNYvF9J9PkxeFs63Yk2Kgp5wDJN6G3e1vf48G5pcGVAvzaXdIX/JM5IYlImgZE
         3ASQ==
X-Forwarded-Encrypted: i=1; AJvYcCXTrwt/kd5UPb+kgX09hVLjoyx8fl5CqFi04O5kBPD2uZ+bkFv5n+vOeVHMNEb07BLVCu9ERUnIyUxlEv+yjIPnpZ8Nl3VtyJQ80GjR
X-Gm-Message-State: AOJu0Yx+yV4ovziop0mfkOQi4/Cl2fyxTZYWFKhxeP+V8Duw+ZK0x16W
	W9h+xLHnl2ujH+O0byJAXbFKqn3i7JyBM5kR8InLP2AL19pN3W0obPK0bu7W+3Q=
X-Google-Smtp-Source: AGHT+IGDOXaVHge1pDULeXoNelmKSM5rpkJ5GMZV50wGfG+qBDJR7lHWGWA/AhhqA7QP5Hi+iNfZHw==
X-Received: by 2002:adf:f28d:0:b0:33d:1153:f428 with SMTP id k13-20020adff28d000000b0033d1153f428mr239073wro.17.1707998926687;
        Thu, 15 Feb 2024 04:08:46 -0800 (PST)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id x13-20020a5d54cd000000b0033cf5094fcesm1626405wrv.36.2024.02.15.04.08.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Feb 2024 04:08:46 -0800 (PST)
Date: Thu, 15 Feb 2024 13:08:42 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Christoph Hellwig <hch@infradead.org>
Cc: Jakub Kicinski <kuba@kernel.org>, Saeed Mahameed <saeed@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Leon Romanovsky <leonro@nvidia.com>,
	Jason Gunthorpe <jgg@nvidia.com>, Jiri Pirko <jiri@nvidia.com>,
	Leonid Bloch <lbloch@nvidia.com>, Itay Avraham <itayavr@nvidia.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	David Ahern <dsahern@kernel.org>,
	Aron Silverton <aron.silverton@oracle.com>,
	andrew.gospodarek@broadcom.com, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH V4 0/5] mlx5 ConnectX control misc driver
Message-ID: <Zc3-ynqAEaVvGua-@nanopsycho>
References: <20240207072435.14182-1-saeed@kernel.org>
 <Zcx53N8lQjkpEu94@infradead.org>
 <20240214074832.713ca16a@kernel.org>
 <Zc22mMN2ovCadgRY@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zc22mMN2ovCadgRY@infradead.org>

Thu, Feb 15, 2024 at 08:00:40AM CET, hch@infradead.org wrote:
>On Wed, Feb 14, 2024 at 07:48:32AM -0800, Jakub Kicinski wrote:

[...]


>> > I think all maintainers can and should voice the
>> > opinions, be those technical or political, but trying to block a useful
>> > feature without lots of precedence because it is vaguely related to the
>> > subsystem is not helpful. 
>> 
>> Not sure what you mean by "without lots of precedence" but you can ask
>
>Should have been with.  Just about every subsystem with complex devices
>has this kind of direct interface for observability and co in at least
>some drivers.

What about configuration? How do you ensure the direct FW/HW access
is used only for observability/debug purposes. I mean, if you can't,
I think it is incorrect to name it that way, isn't it?

