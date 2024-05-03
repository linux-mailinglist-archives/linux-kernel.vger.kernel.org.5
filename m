Return-Path: <linux-kernel+bounces-167475-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 42F908BAA0C
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 11:41:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7BA41F21511
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 09:41:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 206EE14F9EC;
	Fri,  3 May 2024 09:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t4rsNwSc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5296914F9D2;
	Fri,  3 May 2024 09:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714729289; cv=none; b=kMStaGsP8ArGWAsR85TCYY4CSDnR8AbS9cwQ+2PZ1IRlar1Rt3yxuxxVqD4EQk7mOd1WdDU7f0Mfdt1UY5mr8e8LOIToqhBLKMxgFaWx3KNLk8fcQEHYWsQUgIeBSAJ88fWfkCtLzDRn2YYTcUn/Egg3PtwOBWwQ4vnnY1XuBmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714729289; c=relaxed/simple;
	bh=xkVHQuN0QK1pV6FCvZWwjaK3ABs9JuiXHV7UeLNN/F8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ZsMZwcv/1eti+5X3/sUkOTznv2+SGxSOY8PSZAbGFUXaAau8qaLJLlbSqBTlYdFYAJqqOvawikmCS195x+SSu3atS9prK5r7hVF55X+twvex/WLvd+STGHOA+9ZsxZdLfjHoQBYUZHPYUpJOmIG+p0OiT4G8QPfqeT7R/LQSYYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t4rsNwSc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D8B8C116B1;
	Fri,  3 May 2024 09:41:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714729288;
	bh=xkVHQuN0QK1pV6FCvZWwjaK3ABs9JuiXHV7UeLNN/F8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=t4rsNwSc6Oag1pK5kvocDG3jdrsGrw8xMMHm2DbMC/dAHL/rjP1jasl3fOq3sQ6sT
	 mYcRq41TFgVg2ydSAPH2ZHU71Y1s8oP8fcwa01fViN/4Kj8yLNB/h/N3wZoSTkUxQ5
	 ZS92MJT5rVfxVzRKK5RcU+OlQERguUMiR6nsVQyGG2n759Z8YoVerzxZIKC0KXD70n
	 DbH8POgDU6CBf7YY/KhzUaUWJ20nyfUFKWkwZv9AlZKnPkjq9umNUoAcG/06p28ro0
	 4svbrxeI04Ja42Jtru++TKUyN5kZ8mzKVSEHNeWWTYOarl1Pd8NbZE1LDzRFzzqJ0k
	 dZWkxZ6fnACxA==
From: Lee Jones <lee@kernel.org>
To: Lee Jones <lee@kernel.org>, 
 Daniel Thompson <daniel.thompson@linaro.org>, 
 Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>, 
 =?utf-8?q?Bruno_Pr=C3=A9mont?= <bonbons@linux-vserver.org>, 
 Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
 Alexander Shiyan <shc_work@mail.ru>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Shawn Guo <shawnguo@kernel.org>, Fabio Estevam <festevam@gmail.com>, 
 Krzysztof Kozlowski <krzk@kernel.org>
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev, 
 linux-omap@vger.kernel.org, Thomas Zimmermann <tzimmermann@suse.de>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
In-Reply-To: <20240424-video-backlight-lcd-ops-v2-0-1aaa82b07bc6@kernel.org>
References: <20240424-video-backlight-lcd-ops-v2-0-1aaa82b07bc6@kernel.org>
Subject: Re: [PATCH v2 00/19] backlight: Constify lcd_ops
Message-Id: <171472928415.1323021.3458121588308140519.b4-ty@kernel.org>
Date: Fri, 03 May 2024 10:41:24 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.4

On Wed, 24 Apr 2024 08:33:26 +0200, Krzysztof Kozlowski wrote:
> Changes in v2:
> - Collect tags, including wrongly places Thomas' tag (which requires me
>   to manually edit 15 other patches to drop it).
> - Combine here checkpatch patch:
>   https://lore.kernel.org/all/20240414185440.288812-1-krzk@kernel.org/
> - Link to v1: https://lore.kernel.org/r/20240414-video-backlight-lcd-ops-v1-0-9b37fcbf546a@kernel.org
> 
> [...]

Applied, thanks!

[01/19] backlight: Constify lcd_ops
        commit: 9258e31adebf0ccf0797867841f3f9800695dba2
[02/19] backlight: ams369fg06: Constify lcd_ops
        commit: 8053c4fa200c3fef07859bac9469ad3f26f5aba1
[03/19] backlight: corgi_lcd: Constify lcd_ops
        commit: 18c5d4ab9f6312f2c9c6c409287d552112db810a
[04/19] backlight: hx8357: Constify lcd_ops
        commit: 1d669c1998b559393ec2eaac0449f4989a255049
[05/19] backlight: ili922x: Constify lcd_ops
        commit: e77fef89de954b1557cb91b64696cd4fc06c80ad
[06/19] backlight: ili9320: Constify lcd_ops
        commit: 06cfc92faa1eabb2ea226c58d6fd0b5ab117ee39
[07/19] backlight: jornada720_lcd: Constify lcd_ops
        commit: a54b4999dc204bc5839bb70602078c7c8e4a5010
[08/19] backlight: l4f00242t03: Constify lcd_ops
        commit: 657e6c1b270e9f4a890059f5d08a08ea842fa1a8
[09/19] backlight: lms283gf05: Constify lcd_ops
        commit: 66e5a10818fd332e973d36429e36f4c436a86a91
[10/19] backlight: lms501kf03: Constify lcd_ops
        commit: 31c205d1e8426dd0cce0143c500ff1ff71fe64d1
[11/19] backlight: ltv350qv: Constify lcd_ops
        commit: 24424f84d7568d9d794657622e080b1cba1e9290
[12/19] backlight: otm3225a: Constify lcd_ops
        commit: 02949072ee8fb6141cd8ac2be9867ef466580ddb
[13/19] backlight: platform_lcd: Constify lcd_ops
        commit: d217a8d5a39851caa16996756682715c9debb4a9
[14/19] backlight: tdo24m: Constify lcd_ops
        commit: c7a1809d1982f671e66a4b1c1ffd8bdd5ba260aa
[15/19] HID: picoLCD: Constify lcd_ops
        commit: 238724635763e7c5d82c0581b0c49e5dfdd5505a
[16/19] fbdev: clps711x: Constify lcd_ops
        commit: 55d9a955375af3b3fd5725a9b5cbc658d4bdd244
[17/19] fbdev: imx: Constify lcd_ops
        commit: a6abbb5783345c4c7cc9fbd583b81e167bd0207d
[18/19] fbdev: omap: lcd_ams_delta: Constify lcd_ops
        commit: ca991e8e096c9f0cff0300289e2d4813192b8ef3
[19/19] const_structs.checkpatch: add lcd_ops
        commit: f02aeccbec6108d768f54d31e7cb48b06c0e3814

--
Lee Jones [李琼斯]


