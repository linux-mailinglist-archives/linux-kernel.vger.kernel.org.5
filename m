Return-Path: <linux-kernel+bounces-13051-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F19681FEFE
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 12:01:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81C141C2231B
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 11:01:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCB7311185;
	Fri, 29 Dec 2023 11:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lkywn9zR"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A253410A25;
	Fri, 29 Dec 2023 11:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-50e68e93be1so5823677e87.0;
        Fri, 29 Dec 2023 03:01:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703847682; x=1704452482; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=i0ULouMbZfbNQIosOC2sdx22KVaZt1+H52YT662+sxE=;
        b=lkywn9zRGfhNMlvglUV1wD6BnXQtf0ADLQ0ppxD5pdZ7q5rePnSQKHvlQFa91C6Bmz
         yKjvSLrrfxe1lWS5rvnm2BhgMz0i8LWZ7bQHDbYpbxrMaIxLN/WRZCR3NgkPUU9IcF/0
         26AfLW3SKw1PLgukl5yK8qtGTfUOuTWQMElHc7Io9jNspmd+4vQY2rCJFiNXccEBRp2s
         J1sX/iZdw3lVBio+dQBLT3SEtpqhn0Dek+xn2XnhWtvz1D6pXIXgj9lLydf2Hh1AV1XQ
         +T/RfYgWCNM64wZruecfPutSLE8wZNJuDgOA2jywIPXhHMddnW86rFq4cROGBbxH8CqZ
         jVDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703847682; x=1704452482;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i0ULouMbZfbNQIosOC2sdx22KVaZt1+H52YT662+sxE=;
        b=rnI7MTWUMTBzfSz+hy/HQTIzj1dKyixk1NyPVa2zkhukrEQBlhOKZYeq5mBIDTG3x1
         RJt8OkNYXIZwzp/91+6JiBTCKkqOY9EmlW9+NSBvq0NQuY0n9BZ2jPlrLy8H3/9Nn19T
         QthLoHR39UlnL0CkGxpIGVBsLmtoDwhzm/wyL1If1P0CfKn7WDOMqNPRNUodaF0qdIjY
         uYgHQwIs49VLX7yZ15BuPjONyMA+Kqy65LnpqpntLm2y66W8LPWUp5zlt34UOiDcND1Z
         yAe6f7yUwK42KEdfUgOmdcZrE1+AIbJQ3Ry3lwO/dmskiA2T9eemT+Js3bvLdrF9TPJP
         EgVA==
X-Gm-Message-State: AOJu0Yy7+om35Bd486VAJUAxNgD73aozjabRJgLNTHzTyo3WKG06edPA
	PILghPWsOiR2Q3GaCLI9hYdKoE77V9FsrYxUuNocVjvbWpeM4A==
X-Google-Smtp-Source: AGHT+IFYmZYcuaNbniJSBscSzp9FFsmSNpN2Lf6ogu42hEQ/b84GJyhHVpKT54sM7Bzbn6T7OweYzUudjSyuZqxMlQ0=
X-Received: by 2002:ac2:5934:0:b0:50e:7673:54d4 with SMTP id
 v20-20020ac25934000000b0050e767354d4mr2872352lfi.29.1703847681448; Fri, 29
 Dec 2023 03:01:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231228131617.3411561-1-liujianfeng1994@gmail.com>
In-Reply-To: <20231228131617.3411561-1-liujianfeng1994@gmail.com>
From: Hugh Cole-Baker <sigmaris@gmail.com>
Date: Fri, 29 Dec 2023 11:01:09 +0000
Message-ID: <CAAXNxMT3f68-ptM7Crhrfmn7iwTyJc9pwz4Beob+5beVODaSHQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] Add hantro g1 video decoder support for RK3588
To: Jianfeng Liu <liujianfeng1994@gmail.com>
Cc: ezequiel@vanguardiasur.com.ar, p.zabel@pengutronix.de, mchehab@kernel.org, 
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	heiko@sntech.de, sfr@canb.auug.org.au, linux-media@vger.kernel.org, 
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 28 Dec 2023 at 13:16, Jianfeng Liu <liujianfeng1994@gmail.com> wrote:
>
> This is the v2 version of this series adding hantro g1 video decoder
> support for rk3588.
>
> Changes in v2:
> - Fix alphabetical order in patch1 and patch3
> - Sort device tree node by bus-address
> - Drop rk3588_vpu_variant fron v1 because that is exactly the same as rk3568_vpu_variant
> - Link to v1: https://lore.kernel.org/all/20231227173911.3295410-1-liujianfeng1994@gmail.com
>
> Jianfeng Liu (3):
>   media: verisilicon: Add support for Hantro G1 on RK3588
>   arm64: dts: rockchip: Add Hantro G1 VPU support for RK3588
>   dt-bindings: media: rockchip-vpu: Add RK3588 compatible
>
>  .../bindings/media/rockchip-vpu.yaml          |  1 +
>  arch/arm64/boot/dts/rockchip/rk3588s.dtsi     | 20 +++++++++++++++++++
>  .../media/platform/verisilicon/hantro_drv.c   |  1 +
>  3 files changed, 22 insertions(+)
>
> --
> 2.34.1

Tested H.264 and VP8 decode with Fluster on NanoPC T6;

H.264 JVT-AVC_V1 test suite:
  Ran 129/135 tests successfully.
  (matches FFmpeg-H.264 software decoder)
H.264 JVT-FR-EXT test suite:
  Ran 44/69 tests successfully
  (some failures caused by lack of support for Hi10P and 4:2:2)
VP8-TEST-VECTORS test suite:
  Ran 59/61 tests successfully
  (matches FFmpeg-VP8 software decoder)
Full results at:
https://gist.github.com/sigmaris/d3d8586bfced5ddc021aa9dab94d4ab8

Tested-by: Hugh Cole-Baker <sigmaris@gmail.com>

