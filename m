Return-Path: <linux-kernel+bounces-151821-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 88C8F8AB45A
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 19:28:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B38A287C5E
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 17:28:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6B3F13AD02;
	Fri, 19 Apr 2024 17:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UJDvtBOr"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4742977F13;
	Fri, 19 Apr 2024 17:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713547696; cv=none; b=S/bADADt8v69FeNFH1RPrY5TK5ds373q2ZckMbjCp+ESCK+lEvRFZcB6tvgD/9wxuJi+6APJFZ6SyD0dyXpdTmg9TTYv3/EplFUz0DmeRi6lXcafH+aWmHF38kqEHSgRnQKW9A33wUZ6XHTIYgTPJb4kDe6cx6yOCmETl29+0iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713547696; c=relaxed/simple;
	bh=CiY8/nAJ94vQ5TldCY4pGhgSrPvSqfEp6YEoeLDubQM=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=ZadozfQQuc9pzZ0ZAxlL43zYk3is4ciAt+1uniedKQ5OCyGry4wkUBcwFpPQRAx8Cclm4Q2kVKKmTUw0qX97oyX+86esgAKHJnrfkxqXaU91i6t719FT+jSbw+6RPDN7sZCoL+w9ZEznUJr2ZybjEOzVhB0p6Xze3bya+eu16h0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UJDvtBOr; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-343cfa6faf0so2106113f8f.0;
        Fri, 19 Apr 2024 10:28:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713547693; x=1714152493; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Atbe4MPhJuRT7fbR5tzI2HH3PRwHbiVkk8k6A1FcZ4s=;
        b=UJDvtBOr7K6tjoIEL0OrynSPH1ca8rHjfuEim2Ok2LHR17MoUSxuptkTm9ie7SOEVA
         ng5HWcLF8pkS+cQRqmTvtYNcXDnHZ735EE0jholiGgQcxni418Mf+vtSv2RcAbK0l+hw
         gewu1pizpktt1kmH/Bn+GFFsqpcPiLpNmxOuGMSysh24pJsOPdy7o63MRUUBrxdck2rx
         FtDJoGKy8J0cMJ0/hHSzaS5tDCuOo2z9fXf3iGPj20XOgT8AFUxbOtN7qTP7zsgB8x3I
         M1Lw/a8yz03ZWdcG0OI8xl0HtvHUlfkx5MBQVkCYKKzLNrxKO7zCTunFCUs3FuZiuHOw
         pNsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713547693; x=1714152493;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Atbe4MPhJuRT7fbR5tzI2HH3PRwHbiVkk8k6A1FcZ4s=;
        b=r7LSTY5KHBbFUaZzDkN22shwemr25EtA1HUGEeGAfUmO5Ecs7vColfI9+Vw+hNy8tF
         8gaSwiWFKxOAm0eNZW1o44PkKvf5TTwIi+5duavZUnL1S0mAdLR7UPwmL+2ZIxVSljmL
         XnCNS+A7xYbNxAfeBlN5wcLpZJmT/FQc6Fsv+l9DlK2DUV+jx3z137IOR8kobqWsPR8y
         NWGMe+nkXF1umhfpwfjB5O+dHs8cAKzzbGc0/rx+upJbBsjdwcBFjOaAXIadaqVfBLRE
         0afrk9uGqrL428kXzrhZ0U6dp6m3vukP48b1B/RstK8yIxugQJcUwC2WJIYMvAb9prxs
         YVRQ==
X-Forwarded-Encrypted: i=1; AJvYcCVq/WlrUGo2w9uVFA9vx+CKFAbhm1/XQS2gmyCx/k8OgEBUU8IspJzdVh8NN7lGEMHlepKKDElgZuP6atU/4qsl2m/c24azReqzMSn2Wy/LazGVRGgRkzFvpZN+87Rz9PUwjM5RqexZZw==
X-Gm-Message-State: AOJu0YwpTGVRhKYXq2uiOZdtR8uyUV/U7ACUlugsGZdI6pHIq95Tp5wa
	9J3OHFcFEzwPhu4BpOA2qTzyND/XpYVNrqYTKrKGFg0R/l7XJiCH
X-Google-Smtp-Source: AGHT+IF6A+v0NN01QBnz5fAkXZW88z/35Cm0aPRsMcAa+BCGpAJrxeXuNMaFWA8mTEjVyx/z7j97/Q==
X-Received: by 2002:a5d:4e0d:0:b0:33e:c91a:127e with SMTP id p13-20020a5d4e0d000000b0033ec91a127emr2289532wrt.63.1713547693290;
        Fri, 19 Apr 2024 10:28:13 -0700 (PDT)
Received: from smtpclient.apple ([2a02:8010:6606:0:8130:9b6:fda5:3b16])
        by smtp.gmail.com with ESMTPSA id fj3-20020a05600c0c8300b00416b2cbad06sm11117515wmb.41.2024.04.19.10.28.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Apr 2024 10:28:12 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.500.171.1.1\))
Subject: Re: [PATCH v6 2/2] arm64: dts: rockchip: Add Hantro G1 VPU support
 for RK3588
From: Hugh Cole-Baker <sigmaris@gmail.com>
In-Reply-To: <20240418111002.83015-3-liujianfeng1994@gmail.com>
Date: Fri, 19 Apr 2024 18:28:01 +0100
Cc: linux-media@vger.kernel.org,
 linux-rockchip@lists.infradead.org,
 devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org,
 ezequiel@vanguardiasur.com.ar,
 p.zabel@pengutronix.de,
 mchehab@kernel.org,
 robh@kernel.org,
 krzk+dt@kernel.org,
 Conor Dooley <conor+dt@kernel.org>,
 Heiko Stuebner <heiko@sntech.de>,
 sfr@canb.auug.org.au,
 sebastian.reichel@collabora.com,
 didi.debian@cknow.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <B9F108CF-4BC5-41A0-A28A-1CA1F4D2CD3C@gmail.com>
References: <20240418111002.83015-1-liujianfeng1994@gmail.com>
 <20240418111002.83015-3-liujianfeng1994@gmail.com>
To: Jianfeng Liu <liujianfeng1994@gmail.com>
X-Mailer: Apple Mail (2.3774.500.171.1.1)

Hi Jianfeng,

> On 18 Apr 2024, at 12:10, Jianfeng Liu <liujianfeng1994@gmail.com> =
wrote:
>=20
> Enable Hantro G1 video decoder in RK3588's devicetree.
>=20
> Tested with FFmpeg v4l2_request code taken from [1]
> with MPEG2, H.264 and VP8 samples.
>=20
> [1] =
https://github.com/LibreELEC/LibreELEC.tv/blob/master/packages/multimedia/=
ffmpeg/patches/v4l2-request/ffmpeg-001-v4l2-request.patch
>=20
> Signed-off-by: Jianfeng Liu <liujianfeng1994@gmail.com>
> Tested-by: Hugh Cole-Baker <sigmaris@gmail.com>
> Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> ---
> arch/arm64/boot/dts/rockchip/rk3588s.dtsi | 21 +++++++++++++++++++++
> 1 file changed, 21 insertions(+)
>=20
> diff --git a/arch/arm64/boot/dts/rockchip/rk3588s.dtsi =
b/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
> index b0a59ec51..b0817382f 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
> @@ -1135,6 +1135,27 @@ power-domain@RK3588_PD_SDMMC {
> };
> };
>=20
> + vpu: video-codec@fdb50000 {
> + compatible =3D "rockchip,rk3588-vdpu121", "rockchip,rk3568-vpu";
> + reg =3D <0x0 0xfdb50000 0x0 0x800>;

The register range at 0xfdb50000 length 0x800 includes "VEPU121 core0" =
encoder
regs at offset 0 and "VDPU121" decoder regs at offset 0x400 (referring =
to the
TRM v1.0 Part 1, section 5.5.1). So I think the =
"rockchip,rk3588-vdpu121"
compatible isn't exactly correct to use for this entire device.

IMO "rockchip,rk3588-vpu121" would be more appropriate if including both =
the
decoder and encoder. It also raises the question of whether the decoder =
and
encoder should be modeled in DT as one device like on RK3399, or =
separate
devices. In the vendor DT [0] they are modeled as two devices but they =
share
clocks, resets, IOMMU, and a "rockchip,taskqueue-node" value.

I've tested the JPEG encoding functionality of this encoder with [1], =
and it
seems to work, gstreamer produces a MJPEG video of the test pattern as
expected.

> + interrupts =3D <GIC_SPI 119 IRQ_TYPE_LEVEL_HIGH 0>;
> + interrupt-names =3D "vdpu";
> + clocks =3D <&cru ACLK_VPU>, <&cru HCLK_VPU>;
> + clock-names =3D "aclk", "hclk";
> + iommus =3D <&vdpu_mmu>;
> + power-domains =3D <&power RK3588_PD_VDPU>;
> + };
> +
> + vdpu_mmu: iommu@fdb50800 {
> + compatible =3D "rockchip,rk3588-iommu", "rockchip,rk3568-iommu";
> + reg =3D <0x0 0xfdb50800 0x0 0x40>;
> + interrupts =3D <GIC_SPI 118 IRQ_TYPE_LEVEL_HIGH 0>;
> + clock-names =3D "aclk", "iface";
> + clocks =3D <&cru ACLK_VPU>, <&cru HCLK_VPU>;
> + power-domains =3D <&power RK3588_PD_VDPU>;
> + #iommu-cells =3D <0>;
> + };
> +
> av1d: video-codec@fdc70000 {
> compatible =3D "rockchip,rk3588-av1-vpu";
> reg =3D <0x0 0xfdc70000 0x0 0x800>;
> --
> 2.34.1
>=20

[0]: =
https://github.com/friendlyarm/kernel-rockchip/blob/18fd1215fee01daef16b6c=
ed1c0c3c3b83a4d8df/arch/arm64/boot/dts/rockchip/rk3588s.dtsi#L3630-L3683
[1]: https://github.com/sigmaris/linux/tree/rk3588-hantro-vpus
     with: gst-launch-1.0 videotestsrc pattern=3Dball flip=3Dtrue ! =
v4l2jpegenc \
      ! matroskamux ! filesink location=3Djpegtest.mkv


