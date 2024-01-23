Return-Path: <linux-kernel+bounces-36027-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B365839A53
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 21:34:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 561381C28117
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 20:34:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1B8A443E;
	Tue, 23 Jan 2024 20:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q/ZA3Nxk"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A05A73C3F;
	Tue, 23 Jan 2024 20:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706042058; cv=none; b=cr+DCKqgBh0AmS9sQ1isztGvf+Q4nrr096qdEV35Q/Dzam9SNR+Jb7NS1b87hvfX3yQBVyU/UkQix+q0P89hVLgEBn/RbHemxpyGPxd6VV75jVIzTlp4NR6N3C8y1VPAAlj3a++KHXU3WThZldIErbN3RAVIcuEtEJKfqYPrP0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706042058; c=relaxed/simple;
	bh=2da1jW9KANuw6fjchfHO301yhnkSvZk1PiqeuqOnrsw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jWMx995Es63Hya9P6/s87rmYzIuyWO9kD5o571MrqERdGa/wjGOXFFM+u0PtXhca+KqDt0yydLINZIA9R6RCom5aAzDeJBDpbcEfSm7jB3YIhD/Y13YLxn3XBkehQyG8mtlnK1qbo/r3HdQQpYvQQMn62QK7JC+QYepht873ahE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q/ZA3Nxk; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1d74678df08so15731355ad.1;
        Tue, 23 Jan 2024 12:34:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706042056; x=1706646856; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2N47SUtvm3FIBug79ylcU0ZQ/mAbDc5eVHRt8/FCY1o=;
        b=Q/ZA3NxknvE9CK3CbTEvmfPhmtMY3H9Cl5185jB3NQyzB0Q8uF85WKhI30xQtbFEQu
         hYv+srzx83M4iHw1ikPAC3nxb5809a40YxMzfADrqfUe38kY3+shTXVXsjNm6foAE4gM
         lTMHS+g4v4bm00EfPfwt5Xkrwuqq2kk35yb94SG32gtqBl+g3GWU6NXorVhMP7hEaEVy
         qopC5mS6cV70gHag6iJHErxhpVGYcIESNfZXQL6VRO6iiu8iaw4JelsCmnm8AELixico
         hrlyGgjKtPWmTpfpk0PjcrcK4+hitJ2Esh9ej5YvqmJtbQTd6HY1y9k/zogdNftHwfCw
         payQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706042056; x=1706646856;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2N47SUtvm3FIBug79ylcU0ZQ/mAbDc5eVHRt8/FCY1o=;
        b=FkCzxdUie715gPEB4kQ3dNP5/P0D3M3bcXEsp8lhSwIjybw8gd7KJEOI+NhnkO9s7c
         b5YkkgcdNVAWflsLkhuicqEVrE1w+4jjKDyPak9+JbB7OoizzhLxtM4u0/D1Dv2lOW9i
         kgZfaSQT/LlXAxCEn3cpMEOWBGCUfGZxgc31oOGMGnMHXQxAbphtgWjCa1AyT0xrRhY4
         Si8kXgAuOYUGUcZVewuVSILWI5xa9ex1WrH2GFWK7wUPJXrkhf1u2BX6Rcd8Y34Blgbd
         5TDLbNhzOBNpx1+O6MvhN5xIJvF0+CFO/IXQg2HNyCrrOt0BGQG3HHShp/HCzPUPz6p+
         L75A==
X-Gm-Message-State: AOJu0Yw1PFM6qeyAm4mvBo4LRrAzAJ7FKDl/TQ+FpIx0rXuMOy6/s+xQ
	hF5/JVCVfqFmwyP+u4k8epbUp/TITsyyEg0GyAwUAuIXumCKk6GT
X-Google-Smtp-Source: AGHT+IH/qCA8Hm6mMcMBTcTs1je4x5DuKNWQ8teZWyXhLTlxR9yWFwwivo9tcGy3gNJgndWnW5eZtQ==
X-Received: by 2002:a17:902:868d:b0:1d4:4fc6:8d9 with SMTP id g13-20020a170902868d00b001d44fc608d9mr3337272plo.60.1706042055835;
        Tue, 23 Jan 2024 12:34:15 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id s13-20020a170902988d00b001d39ced922asm9180315plp.97.2024.01.23.12.34.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 12:34:14 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Tue, 23 Jan 2024 12:34:13 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: sudeep.holla@arm.com, cristian.marussi@arm.com, jdelvare@suse.com,
	linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
	Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH V2] hwmon: scmi-hwmon: implement change_mode
Message-ID: <ef92f93e-b294-4bb3-bcf4-4f674c01f729@roeck-us.net>
References: <20240123150526.3615901-1-peng.fan@oss.nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240123150526.3615901-1-peng.fan@oss.nxp.com>

On Tue, Jan 23, 2024 at 11:05:26PM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> The sensor maybe disabled before kernel boot, so add change_mode
> to support configuring the sensor to enabled state.
> 

As mentioned by others, this will require a better explanation.
It only affects thermal sensors, and the scope is not provided.
Specifically, neither subject nor description explain that this
change is primarily for thermal subsystem functionality, and the
(non ?) impact on the hwmon device is not explained.

> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> Reviewed-by: Cristian Marussi <cristian.marussi@arm.com>

As a general comment, I have not received the original patch, and instead
pulled it from patchwork. I also did not receive the initial version
of this patch.

Maybe it is just me, but e-mail from kernel.org has been sporadic
in the last month or so and I have been missing various e-mails.
I would suggest for everyone to copy me directly if a response from me
is expected or desired.

Anyway, this change looks like it enables / disables individual temperature
sensors. What is the expected result for the hwmon device, or in other
words what happens if a sensor is disabled through the thermal subsystem
and the "sensors" command is executed ? The impact (or lack of it) should
be explained.

Also, if my interpretation is correct, you'll need to explain why you
did not (also) implement the hwmon "enable" attribute for temperature
(and possibly other) sensors.

Thanks,
Guenter

