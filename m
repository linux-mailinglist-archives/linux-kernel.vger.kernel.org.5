Return-Path: <linux-kernel+bounces-152141-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ECC48AB9C8
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 07:09:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B899E28170F
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 05:09:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D568B10788;
	Sat, 20 Apr 2024 05:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lxS7cqu8"
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4464205E31;
	Sat, 20 Apr 2024 05:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713589765; cv=none; b=jgK7MdiVOQ2WgyDkNzdxPcnwm3a248mdgoJItWyvw20j/xdmnRf0KxrXnJftWUD1ptw571Uk9RFj2rGq5Kwu7xUDyrVjCP6ut4gXH1LIkEgAP9cfKAGI3EMzXZ3K0WjT/nDd9bc6+KpRv/113B4uJm1bQwQ0NKbr2rqvu2yfAGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713589765; c=relaxed/simple;
	bh=Zj2LiikqunHRasRXmuEtpJTW1RcqRjmmWOahD7pquLo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SDmOxae3EW5wKV7/XzLkFrQiLV2KwWc7pWoL6wNj0rlTr8xr9OrJhpMlnm/7k9EXntjcZRfgFZ/CvEElWspYh9cEngQjl3sp85UCe00Z3p7jtJv2z9ka/XgxHc4HQBf1nw7iSf37wznhOLoxQR94nrOs5D+ywkxizD1w7lZfI+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lxS7cqu8; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3c749aa444fso796435b6e.0;
        Fri, 19 Apr 2024 22:09:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713589763; x=1714194563; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zj2LiikqunHRasRXmuEtpJTW1RcqRjmmWOahD7pquLo=;
        b=lxS7cqu8wGuNU/NyjjUHGeTzS12de651NScx8Mwzy7lPg7p9K7LaYEqBsBQKJAqQwZ
         +SW8Qy3HRpgqXV5ckOn1ZG8XwPxEv3dRvly3XecQnZwsA3evMV/NgTAbrdEWZ5Jb5oau
         HXLfThsOZ1e4wvue27R5hQ5D3xuO/l3W8kXAkCL+1yAxSEISFCDqfCmbfe28QPCa/yij
         yGIyh3N/hm8fFbBIZcGPUnOsxwPZoZ9m6boPNlFQEHlt4MZv9JDmLVDqliqNfX0VWNzF
         N9CLN+FFdAdNKpTSnvGB2czrIbzSRYgXJ+eCkmDk0JpcoKoSZL5D1XiGEU5F0lrgeva1
         gPXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713589763; x=1714194563;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zj2LiikqunHRasRXmuEtpJTW1RcqRjmmWOahD7pquLo=;
        b=ejuT8rphpCjReNo9EMxP09Vqc5CdRm3fQ2K1M08T179yXLLog37Vo1UaeeNs6qAIS1
         AoJBB37aOsYW2y0/JzYuoZvfWtHpbj9CfSxZ8Q0HFRPMo+dWvKDiwv68Vlv46pyS8zLe
         kbVhcKJdwdQ9E9IbgUc9Fy+S/mijnK4IgV+8G3H2UpxWirHH9NbXAYyiu3H6j9cDceHV
         x309gBTzWuhM1/f3LQZxKgq+aGeEwdAVMGrKkRBAyhAQn1B75p9t4dkuzBubGrOFQKJx
         FHVyAYi6Ktu318Dyb3lFIEx3+bnXYiSmu9FmSQAF7RV+UAKW7TFOVTq9hIS5GP60jbAr
         mdwQ==
X-Forwarded-Encrypted: i=1; AJvYcCVVPkyI7+VeOk0jx9YfC7oL3ZLTXBgKS6fkdxbJxyFoNElrWgf0mRSFcC1mbkSoI3qr6pLjKqRmvCxqUSIJ7yvG8/2oansok1LKTnrlHOWSjhcmAlpdclZ3iKBpLqeagv7IXuJJfB/HtPSqWZHtZ0NiztlJJwFxQs7uS19x5lCQtaLkBp4m
X-Gm-Message-State: AOJu0YwlHX8+FDVtWPMpTBayqteCXjDknzDd4PUPshrE8LQRcToDMj6R
	A4b0pRGO8ggszZdlNlyruKJTrm1FfsWp9tT1zSrjsaw0ksnsG+Ar
X-Google-Smtp-Source: AGHT+IELx6scJmOUwJTe62jFJmVk1DSdsGKXwe8jKcqr9G80zsbl4g4GQihKDnGL7pqimIyBqUykEA==
X-Received: by 2002:a05:6808:15a:b0:3c6:1500:abef with SMTP id h26-20020a056808015a00b003c61500abefmr4704701oie.55.1713589762720;
        Fri, 19 Apr 2024 22:09:22 -0700 (PDT)
Received: from localhost.localdomain ([221.220.135.251])
        by smtp.gmail.com with ESMTPSA id g25-20020a62e319000000b006ed59172d2fsm4127949pfh.87.2024.04.19.22.09.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 22:09:22 -0700 (PDT)
From: Jianfeng Liu <liujianfeng1994@gmail.com>
To: sigmaris@gmail.com
Cc: conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	didi.debian@cknow.org,
	ezequiel@vanguardiasur.com.ar,
	heiko@sntech.de,
	krzk+dt@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	liujianfeng1994@gmail.com,
	mchehab@kernel.org,
	p.zabel@pengutronix.de,
	robh@kernel.org,
	sebastian.reichel@collabora.com,
	sfr@canb.auug.org.au,
	nicolas@ndufresne.ca,
	linkmauve@linkmauve.fr
Subject: Re: Re: [PATCH v6 2/2] arm64: dts: rockchip: Add Hantro G1 VPU support for RK3588
Date: Sat, 20 Apr 2024 13:09:13 +0800
Message-Id: <20240420050913.182225-1-liujianfeng1994@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <B9F108CF-4BC5-41A0-A28A-1CA1F4D2CD3C@gmail.com>
References: <B9F108CF-4BC5-41A0-A28A-1CA1F4D2CD3C@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Hugh,

Fri, 19 Apr 2024 18:28:01 +0100, Hugh Cole-Baker wrote:
>The register range at 0xfdb50000 length 0x800 includes "VEPU121 core0" encoder
>regs at offset 0 and "VDPU121" decoder regs at offset 0x400 (referring to the
>TRM v1.0 Part 1, section 5.5.1). So I think the "rockchip,rk3588-vdpu121"
>compatible isn't exactly correct to use for this entire device.

There are five vepu121 cores for jpeg encoding. And Emmanuel is doing work on
them[1]. And at the moment the driver doesn’t yet support exposing these cores
all as a single video node to userspace, so Emmanuel only exposes one single
core.

>IMO "rockchip,rk3588-vpu121" would be more appropriate if including both the
>decoder and encoder. It also raises the question of whether the decoder and
>encoder should be modeled in DT as one device like on RK3399, or separate
>devices. In the vendor DT [0] they are modeled as two devices but they share
>clocks, resets, IOMMU, and a "rockchip,taskqueue-node" value.

Now we have 5 jpeg enc cores, one from 0xfdb50000 and other four from
0xfdba00000. I tried to add a decoding only core 0xfb50400, but that does not
work. So the vpu should be defined as one node in devicetree for both encoder
and decoder like rk3399.

This vpu121 should be exactly the same as the one in rk3399 which supports both
encoding and decoding. But the current hantro driver has disabled h264 decoding
since there is anthoer decoder rkvdec on rk3399. This vpu121 is the only
decoder which supports h254 decoding on rk3588, so we can't just use the
vpu_variant from rk3399. Maybe we can use rk3399_vpu_variant back when rkvdec2
on rk3588 is supported by mainline kernel.

At the moment we can keep the compatible string same as the one from rk356x.
Since there are already jpeg enc cores at 0xfdba0000, we can ignore the one at
0xfdb50000. When rkvdec2 is supported, I will change "rockchip,rk3588-vpu121"
same as "rockchip,rk3399-vpu".

And I think changing "rockchip,rk3588-vdpu121" to "rockchip,rk3588-vpu121"
should match the hardware correctly.

[1] https://lore.kernel.org/all/20240418141509.2485053-1-linkmauve@linkmauve.fr/

Best regards,
Jianfeng

