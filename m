Return-Path: <linux-kernel+bounces-54424-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D1CD884AF11
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 08:36:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E61D281E67
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 07:36:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D591129A62;
	Tue,  6 Feb 2024 07:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F2my4gcc"
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46DF7128810;
	Tue,  6 Feb 2024 07:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707204973; cv=none; b=W7x84Ly+/XYlE+N9M9t89B1KYCamWltxLxdqi3H+Y9aGEmt+6sEVwCDz+IIknAvn98nj3D6Ia5uugjY0EMfT7XZfXDO3nSShEY12SUAAlFuSAQ8t6BQh7/74+7bLnuQ/i+WwbFssL2eIxY+XEMTtiCahDmAow2kVfFoi9yV30JU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707204973; c=relaxed/simple;
	bh=5AVucqvHHQeCB5i+pnqtLwGPQwdCwI6har4PBPr+VRc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gNZ6BC58ERPdescGAkHgCbGRV+MJe4EHzPf/0eqOio0UzA/xkAr/nBfE7sd0AgcaOPL+fiYf2lc6eRPlxL0lPl34MqpbJ6rDowfRLNzIij5bK83M8uJRQmQKb8CCr7PWovl7a9GNFWy3YQMvKVEb3vb+AqDi6vvTCscUOdDzcAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F2my4gcc; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-5ce2aada130so573192a12.1;
        Mon, 05 Feb 2024 23:36:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707204971; x=1707809771; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RHs7O/QopkuZxQ4Wui33o3EXSlPxuhBABpxuVZjKt2M=;
        b=F2my4gccVMOUojuN7KvBEso1YBYEPqVW6BTNa7usMR6VL9Hq2fSADFdhUewubb10aa
         P60CDB+jKk22lyR7hxKsFPcKqDFr2JDNldOG09P4W1EJh+NKolxt451pizQkhyx3yAJ7
         3dOSvhx2b/o0PARGrPuC0tLokMOi984Yv6q9JI2/lNtRAgG3mz+d8YWTiDrDAlg/1oY+
         6J4iu+A1Qj4/mxNzM2alGoUBkFr7IFlazdh8NhLHrXXNszd4ky33HM9yJGY1H045/e3K
         a0kaD0WVFbBNakDifQi6k35F+DuhrFTwc1ml3Jbb3R2VfRg2xwB3YXnX9VTlQMpghvr1
         eaZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707204971; x=1707809771;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RHs7O/QopkuZxQ4Wui33o3EXSlPxuhBABpxuVZjKt2M=;
        b=u2hsL/DWwoqNoQHeKVCbFVugmaiQaaM02PzhJfLDVccrH0eofqiWQrlptSfyWeszYq
         5CqTRC4RHGJR+jgByd1f2JlkLev3+EHeGjUgP6FPbWd+YUMDEFaO4lRp/VVseVfPbsK3
         knm1551XLORt4rSkLUZiJPCKg+PXCx8SOse+JKg28s2S6N9jZe5lxn678HYcQjasVLDd
         gipunCWrxPfQb6f752HufvD6AZhmDqEanvVKXUpEUDl5MIePdQID391KzQzVSuI4MQ7z
         HTsV2tiNCVM5mN/5JJE/9/en/M1bWhUg4HT21zp2kHvswdErc7QbvOaSLfgM4VZ63d/F
         XryQ==
X-Gm-Message-State: AOJu0Yywp1WB4JT2GyX2V2qR06atvGAQ/LkiTF4+7btmoGKRSZZlIhIj
	TXbDkQtP1Q8qtjnWHA/JFOqfUKE2/eiFRQ0nNSaEu/K9i4TWo09h
X-Google-Smtp-Source: AGHT+IGGXt9+HwT1MkhBUFPAsWZA4hFwSGBKEEzw3Os0sJtoWdrRD5UexGVClpsSNHTzuAgUfpCbYA==
X-Received: by 2002:a05:6a20:54a9:b0:19e:982e:c402 with SMTP id i41-20020a056a2054a900b0019e982ec402mr860449pzk.59.1707204971562;
        Mon, 05 Feb 2024 23:36:11 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWoam9MBSL5DCdTFJEakALYkte3pG/Kwe5nEoLMVYXQn+Ng7iS6pXbZ6Zyz4HMxU47R0KJtms5WwP5eHa1ptKckQqH0Kd4dyBii3OxmI5OXsXrIGm8Vca4NhSByHH2JgceltX7lTG+6lOgZDb+Hkv3gZAuvVftUxt1DhCdN6BH4f+IjF210hdKal8yj8YeGTrDbpa+99AIChLQreIWDA2n0AMpuMDkZAhkS4P5DmwmX9mhT7WSWYKUUoLIBPnjBvpH4pbs9RJT6WU4fCixBbbYgoCZ2T5vCyECj95srjzopxrZQ02k1dhIaZXdHuidauMx6Wd3WnTDSjsPtBW+wEbiWVU6Ah9QUUEKO0lMcYVSwBmba0M4vHeGl8XJGBUz//iGT5JNm8463eQ==
Received: from dragon (144.34.186.27.16clouds.com. [144.34.186.27])
        by smtp.gmail.com with ESMTPSA id hy9-20020a056a006a0900b006d9b2694b0csm1128899pfb.200.2024.02.05.23.36.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 23:36:10 -0800 (PST)
Date: Tue, 6 Feb 2024 15:35:58 +0800
From: Shawn Guo <shawn.gsc@gmail.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	kernel@pengutronix.de, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	NXP Linux Team <linux-imx@nxp.com>,
	Fabio Estevam <festevam@gmail.com>,
	=?iso-8859-1?Q?S=F8ren?= Andersen <san@skov.dk>
Subject: Re: [PATCH v1 1/1] ARM: dts: imx6: skov: add aliases for all
 ethernet nodes
Message-ID: <ZcHhXosBK4obwNYW@dragon>
References: <20240124124455.738187-1-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240124124455.738187-1-o.rempel@pengutronix.de>

On Wed, Jan 24, 2024 at 01:44:55PM +0100, Oleksij Rempel wrote:
> Add aliases for all ethernet nodes including the switch. It makes it
> easier to find this nodes by the boot loader.
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>

Applied, thanks! 

