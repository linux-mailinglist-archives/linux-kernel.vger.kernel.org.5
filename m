Return-Path: <linux-kernel+bounces-5499-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE018818B65
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 16:40:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A58E286D4A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 15:40:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 758B21CF8A;
	Tue, 19 Dec 2023 15:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P1VTHwne"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA92620319
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 15:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-54c77e0835bso5780919a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 07:40:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703000414; x=1703605214; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=z28CWlKNnNm8FLZVai7/EGWCqrY9/wHM89gG+Y7cx2Y=;
        b=P1VTHwneQtgWh1ZsSl+Ks182i3X7ao27dPKWSKP7ZYMWTn3V486f7Okdr4jVRIVgg7
         dTzEk89y/VtF4Mh6O+yXZPIDvNDt5S6FHm1mvXiwsBNcgsWSDUHXmVWbb2zTNmquHhB3
         iZFX1vjyutnHbbahXn6WXd764yhP1FrNRQLfLuah9ZHWGtjaxDjkHoNmxIy6XuL9XMYF
         j532sX/tJYCUPdYgbh3f4Ej4/POyRPCYvahEg8fIwTOhUBjlQKejL2GsXkGqCa5r4oMg
         tXqFzPUWhePR3a56ZfrgJyhhgifR5THssneqf8EgZk4n0N1gnbOAHz5OfYXrIJzNREfn
         lk1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703000414; x=1703605214;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z28CWlKNnNm8FLZVai7/EGWCqrY9/wHM89gG+Y7cx2Y=;
        b=MSUdQ8ZXFLpPiQ8QS1GryZiiVr3l6F+XeIqI9t4zCdGdf2Nx5AGz5i9bIdCHlPnR3K
         5S7YiZ4+13y1SG01gxnUu2L9eGeXmyTvWOVzN948xcRI5CCwTkfZJ+7hLBo6bWvjJ/Jv
         RKsiBrwoKvqSD/SfGlssy1AJVXzj7O0ReJ93DaPS6G15vkgBnGNY9N0PZ+GFjGr75t2k
         gJcas2q4QR9LDMtztrlSKGrelzHIJ3nPB/Fkwn9U/nKmFL6iZTKVxN3gojZhj59xUGOF
         qeJH0O2N+VglcKFQuxz752MVcESBKn1KYyw+F+tzPTTPa5a/o9uNAdlfR/fZ9T3UK3Gj
         Bf+w==
X-Gm-Message-State: AOJu0YwK47xj5FlpWkArbZ3bGL4Cb5gZEktg0XMJbN+qPvxEwM8TRSOU
	1l2itpO+v8z/FkWz3NK+JCY=
X-Google-Smtp-Source: AGHT+IHMdPQ2QtW5yU2b2dt9f2R5tCBBY9cZcDjn3kOiBkH32eq4Hro3OHpjk2HifsZJuPKZ+LswRw==
X-Received: by 2002:a17:907:6194:b0:a23:8918:2399 with SMTP id mt20-20020a170907619400b00a2389182399mr608683ejc.130.1703000413674;
        Tue, 19 Dec 2023 07:40:13 -0800 (PST)
Received: from [192.168.2.1] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id wg13-20020a1709078f0d00b00a2687065e28sm307346ejc.45.2023.12.19.07.40.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Dec 2023 07:40:13 -0800 (PST)
Message-ID: <4aeef6df-2616-0741-00a3-6e45ec63f920@gmail.com>
Date: Tue, 19 Dec 2023 16:40:12 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2 2/2] drm/rockchip: rk3066_hdmi: drop custom fill_modes
 hook
To: Maxime Ripard <mripard@kernel.org>
Cc: hjc@rock-chips.com, heiko@sntech.de, andy.yan@rock-chips.com,
 maarten.lankhorst@linux.intel.com, tzimmermann@suse.de, airlied@gmail.com,
 daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <f86ec29f-194a-800d-0aaf-9e16e551b37d@gmail.com>
 <410b116b-cb63-7ba7-3689-4f0832ab5796@gmail.com>
 <evaq3yfbqf4gchsps2qoojemtii7tmcss24aruiuze5kkzlnhy@mih7rky7viqz>
Content-Language: en-US
From: Johan Jonker <jbx6244@gmail.com>
In-Reply-To: <evaq3yfbqf4gchsps2qoojemtii7tmcss24aruiuze5kkzlnhy@mih7rky7viqz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 12/19/23 13:55, Maxime Ripard wrote:
> Hi,
> 
> On Mon, Dec 18, 2023 at 04:49:06PM +0100, Johan Jonker wrote:
>> CRTC size validation for the display controller has been added with
>> Commit 8e140cb60270 ("drm/rockchip: vop: limit maximum resolution to
>> hardware capabilities"), so we can drop the custom fill_modes hook.
>>
>> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> 

> I'm not sure those two are equivalent. CRTC and connectors usually have
> different requirements and capabilities, and thus different,
> supplementary, mode_valid/atomic_check implementations.

Rockchip RK3066 CRTC and connector resolution max_output are equivalent.

From Rockchip PX2 TRM V1.0.pdf page 17:
- Video Encoder
  Maximum frame rate is up to 30fps@1920x1080

- Display Interface
  Support LCD or TFT interfaces up to 1920x1080

- HDMI TX Interface
   HDMI version 1.4a, HDCP revision 1.4 and DVI version 1.0 compliant transmitter
   Supports DTV from 480i to 1080i/p HD resolution, and PC from VGA to UXGA by LCDC0 or LCDC1 in RK PX2


Compared to the drm_helper_probe_single_connector_modes() this function added an extra max_output

Checked in rockchip_drm_vop.c is:
https://lore.kernel.org/linux-rockchip/20230216102447.582905-2-s.hauer@pengutronix.de/

+	if (vop->data->max_output.width && mode->hdisplay > vop->data->max_output.width)
+		return MODE_BAD_HVALUE;
+
+	if (vop->data->max_output.height && mode->vdisplay > vop->data->max_output.height)
+		return MODE_BAD_VVALUE;

For RK3066 VOP max_output:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/gpu/drm/rockchip/rockchip_vop_reg.c#n506

This patch was made with HDMI in mind.

	.max_output = { 1920, 1080 },

This first part was added by Heiko, but not was not part my patch that I submitted:
-	if (maxX > 1920)
-		maxX = 1920;
-	if (maxY > 1080)
-		maxY = 1080;
-
-	return drm_helper_probe_single_connector_modes(connector, maxX, maxY);
-}

Original patch:
https://patchwork.freedesktop.org/patch/msgid/20190330095639.14626-2-jbx6244@gmail.com

+static int
+rk3066_hdmi_probe_single_connector_modes(struct drm_connector *connector,
+					 uint32_t maxX, uint32_t maxY)
+{
+	return drm_helper_probe_single_connector_modes(connector, 1920, 1080);
+}

Rockchip RK3066 CRTC and connector resolution max_output are equivalent.

Johan

> 
> Maxime

