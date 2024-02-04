Return-Path: <linux-kernel+bounces-51725-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A30D848E9E
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 15:49:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3C939B222A2
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 14:49:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2547B22EF2;
	Sun,  4 Feb 2024 14:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RXE9ZS7E"
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED86C22EE9;
	Sun,  4 Feb 2024 14:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707058082; cv=none; b=AtgEJWTq+8c97lMIvYK3tk3nOE8Ukdx20UAlgJCqAHx1+Hpit3EjUinpJDbCdHDc/IIswLSsmvkAW0yscrPInt3uDG0RDJoAtl3K6oGhgiEa6kXeRXkFHtG9B/wnWNOdx3xJl7DZVkkgJwBwYDqKzdybqEtGY+sHpl+KxaoBB20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707058082; c=relaxed/simple;
	bh=90KNTWxfgeziFDQ/3TZ0B5vtg7ngUvLnBCrxOucvty4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g5bRrDhoH6eiT3zOPkPUzQvZed7/aF4wlcLu6cmVOOiAHvRGzVVocuAAoHfoBGbKU1oHJjnd3ZNduyP3m7c5bxbRW3LvqlHYdjQ2oX6Zlsh76z1RK2XDwIGgdN6X1ooEfVByujK40mIYNY5QLT1nLgyl9Ar33i7dQRQfnp8NlX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RXE9ZS7E; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-53fbf2c42bfso2997919a12.3;
        Sun, 04 Feb 2024 06:48:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707058080; x=1707662880; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z+SGUHbr9Bwe1092OOL4Vmw2wvzHSTzn/lVZ6fgcAdk=;
        b=RXE9ZS7E6Qqs7H3IGsJuEnsDw9Ffx94WjKYmvtKQr/NAjXdQmIBpoXC6cY7NG+QSOa
         4hkOoRKWe3oLvAYBL/2RPuUoGtVVP/UShzMOVWFRn+S2N20v+aLV1LHMYTwkhU1ovs2M
         HzJB2FIQF41ryhyg/CMQonf6aQuH5CZCMoPQNhnvL8DsGoY5Ssi5AUiYFM/WbZq17a5a
         TudGOXi5vUuZO5fZYrXtW8C8WgnOMK5uaawxwY7PC9/EqEqyEZu6/71zont/VlOe8N+L
         CrgdRklOx5VDwyOcLxQ6X0vhlsJGTlN8d7Oes+lGmSP3L12XIaqgMzhK9uZGXz683iLI
         aryw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707058080; x=1707662880;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z+SGUHbr9Bwe1092OOL4Vmw2wvzHSTzn/lVZ6fgcAdk=;
        b=tMWeP5ry61eYwMNtGychwgPsrX6HN+UezZCz7FBACbRJdMLHbPdqUx8P7ahNP7kCSl
         BSLC8ZZXfVMhwHR9c8rKqB0EkQsGzxBxFd633s2xsIeWA+CjoOhsNAbCN7noL4lr2+zo
         O4PZJozK6z48wepfjXx2hwVJG7hELn3SWmAa5rTK6olZGKcqXiWoQtAtCDgKCEjmCIay
         A25pBBMB/9BzJ5JFX2jZaQ4yngrAoFnAB5PW1qS8MWeVPDvsop44/pU5ks+za8QVaUu4
         FwB9+9tSPvsfHTsvlyyc5iLkaixb67784rxoxYPOAnSb4RM70g46aNIBV+rkcRO+DMBe
         e2Lg==
X-Gm-Message-State: AOJu0YywiVe8DBcSJnwQItwhRWjuBE9CRDzHRULYA7FePvfayhB9mvMK
	niR/sn2eKxXegEki7+RN05gmHi0ZlCBsVHW97LMOQ6DoCVm2P9Pfxw0delnX
X-Google-Smtp-Source: AGHT+IEKP4BNyWXwpmnAU/mHdFxdUYuAINsrQSzHRyZtNaT2Jij+W9Qba7oFgZmcVHeYBuA05o4xxw==
X-Received: by 2002:aa7:9836:0:b0:6de:1d46:1fa5 with SMTP id q22-20020aa79836000000b006de1d461fa5mr10660201pfl.13.1707058080198;
        Sun, 04 Feb 2024 06:48:00 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWUAgaXESL9XM7mQry5j0qM6YMcVKNlkkdM6qLJu5roLhXds4kCzGYxMjEFEQwsn1jwPFlOcLJgS+IMVV+0qY872o2U4A5cH6XIfpTkGXHnOH1peZfWkMhmdy4hOqcJGV3pM/yuIARQtFrgtFN1blJekHo/ZOqmaYjpmhC1z3DG
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id y18-20020aa79e12000000b006e0418993cesm512599pfq.8.2024.02.04.06.47.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Feb 2024 06:47:59 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Sun, 4 Feb 2024 06:47:58 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Zhang Rui <rui.zhang@intel.com>
Cc: jdelvare@suse.com, fenghua.yu@intel.com, linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 08/11] hwmon: (coretemp) Abstract core_temp helpers
Message-ID: <717bdf59-4556-49d7-8c73-5e02c0f3df90@roeck-us.net>
References: <20240202092144.71180-1-rui.zhang@intel.com>
 <20240202092144.71180-9-rui.zhang@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240202092144.71180-9-rui.zhang@intel.com>

On Fri, Feb 02, 2024 at 05:21:41PM +0800, Zhang Rui wrote:
> coretemp driver has an obscure and fragile logic for handling package
> and core temperature data.
> 
> Place the logic in newly introduced helpers for further optimizations.
> 
> No functional change.
> 
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>

Applied.

Thanks,
Guenter

