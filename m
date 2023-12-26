Return-Path: <linux-kernel+bounces-11578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 50FF981E872
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 17:33:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E506F282EBD
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 16:33:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 643334F605;
	Tue, 26 Dec 2023 16:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=riseup.net header.i=@riseup.net header.b="MaEmQVSo"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx1.riseup.net (mx1.riseup.net [198.252.153.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B9061E493;
	Tue, 26 Dec 2023 16:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riseup.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riseup.net
Received: from mx0.riseup.net (mx0-pn.riseup.net [10.0.1.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx1.riseup.net (Postfix) with ESMTPS id 4T00gM2KLBzDr2d;
	Tue, 26 Dec 2023 16:32:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
	t=1703608378; bh=7Z0QZDUqtUb0SVOcfo3DjMkSg2JZFz632/axgQAClno=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MaEmQVSoMXweeG6+5W2Mg06N6Fakp39z8UUmZ2depCl8R2rvP2IEtrzrUN4ksBkyG
	 k/GSf32vhqwE53amRxZBqMmE5+T2LtY3BeDgf9yQ00KE3t0xgvZxrO9LkDunbCq9s3
	 EsxDTVB9ngyyeVTkX6QVCAKWqeqKVCkJ5xLx/gUA=
Received: from fews01-sea.riseup.net (fews01-sea-pn.riseup.net [10.0.1.109])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx0.riseup.net (Postfix) with ESMTPS id 4T00gD3yZnz9x1s;
	Tue, 26 Dec 2023 16:32:40 +0000 (UTC)
X-Riseup-User-ID: E3266E2FE8A468CF052B0366B6691ACFC63C59369F6E61E12BD8CA58073E2F17
Received: from [127.0.0.1] (localhost [127.0.0.1])
	 by fews01-sea.riseup.net (Postfix) with ESMTPSA id 4T00ft4lBtzJmth;
	Tue, 26 Dec 2023 16:32:22 +0000 (UTC)
From: Dang Huynh <danct12@riseup.net>
To: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <quic_jesszhan@quicinc.com>, Sam Ravnborg <sam@ravnborg.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 Sandy Huang <hjc@rock-chips.com>, Mark Yao <markyao0591@gmail.com>,
 Segfault <awarnecke002@hotmail.com>, Arnaud Ferraris <aferraris@debian.org>,
 Manuel Traut <manut@mecka.net>, Diederik de Haas <didi.debian@cknow.org>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, Manuel Traut <manut@mecka.net>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v2 0/4] arm64: rockchip: Pine64 pinetab2 support
Date: Tue, 26 Dec 2023 16:32:10 +0000
Message-ID: <6875992.lOV4Wx5bFT@melttower>
In-Reply-To: <2905432.tPBmtbmofK@bagend>
References:
 <20231223-pinetab2-v2-0-ec1856d0030e@mecka.net> <2905432.tPBmtbmofK@bagend>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Tuesday, December 26, 2023 1:32:32 PM UTC Diederik de Haas wrote:
> [    5.570059] dwmmc_rockchip fe2c0000.mmc: could not set regulator OCR
> (-22) [    5.570835] dwmmc_rockchip fe2c0000.mmc: failed to enable vmmc
> regulator [    5.616373] dwmmc_rockchip fe2c0000.mmc: could not set
> regulator OCR (-22) [    5.621903] dwmmc_rockchip fe2c0000.mmc: failed to
> enable vmmc regulator
This is the WLAN SDIO, the error shows up when the device is not powered on.

> Both also have an error wrt `goodix_911_cfg.bin` firmware, but the error
> could be because Debian kernel 'upgraded' a warning to an error.
> I've searched online for that filename, but haven't found anything.
> The touchscreen works, so I guess that one can be ignored.
This can be ignored, it's for touch panels where it's config is not on flash 
(typically touch panel calibration data).



