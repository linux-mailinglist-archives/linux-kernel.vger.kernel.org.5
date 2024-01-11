Return-Path: <linux-kernel+bounces-23998-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 60B0F82B50C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 20:05:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 02821B22B9D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 19:05:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83B0754FB4;
	Thu, 11 Jan 2024 19:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vbEVo1cf"
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E2E954BD7
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 19:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-5ebca94cf74so57130387b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 11:05:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704999917; x=1705604717; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=70TTwy7LzJ9GVDP1sBtk+/a7RwgjO7meqYg7DVI2Mn4=;
        b=vbEVo1cfRNUWDL/9Z0uC33NP/KMt+x6vkpE3hiAg3gX7lxp7yUiQm0ywUOYVRQgdlB
         17zhnqnx0dkk7Jcdlb/yhtNsISvpGIqMpnPxReOY69eBnjNaWPBdTm5sFlWCZKOsjSXV
         lgYAvDIl/S3DwqmNiXmJGMY74TKaWaNZzNV1Q4l/TFLIKPbSehhZYya0G1y0krAxXImM
         MCjZUOSM8y49tW84GeiKCTIMqF1VzFUua6VKZBymxFQo+XmYjEz4R6v/HkFqHf21RjcD
         YRzR+C6mSQgBYPtG5bZhZT/mgQ9U3s8oD7ECBn44e51CjHtD7Udyy30e+V4kTdRf95I5
         YhYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704999917; x=1705604717;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=70TTwy7LzJ9GVDP1sBtk+/a7RwgjO7meqYg7DVI2Mn4=;
        b=opWTlaj4cTJncZy4g2nSIABOBuXzPcrby5ixWRwts3WQS+/UM1aELQEHFrgqOfHy6I
         12g5B6OVgOxEJHBBIGWvUatUa+IyeKEJJk12fhaD7A8z4PP0qWQOPNh2/l9lWN8zGPa+
         pAqRqG/kNkaFo2e5EmkJ0W5goi8KjQo/FrlnJzWXHYzNHUUElqWfl4gG9f2+TAhGtdT3
         gY2ZbSEC4ahmEt56FvNaLvr0LcvHMt6IKnDhJI++AXprUZw+8m4rXOlpasb6x/LhL1fK
         1bcLnI/eOqSodxLROEYI4p68pPJV3lWOiOVR4mBkPVb1/oBbCnlJI7CA4QcH/xQssuFx
         Ggiw==
X-Gm-Message-State: AOJu0YwFdZYBla6SiR4i8P8pfOdurEgld6LhbrEPYve+A4zyc5fHVvH5
	bm4r1pDt6iwXcXdQavRnWtJeLE0DO8AP6qIKMa4iMGcWIsVLIg==
X-Google-Smtp-Source: AGHT+IFMkYvl2Wa5/NCqZqn4cbISrWXSUz1HnKOQORQuB44S6pFNOTZlV/+yw0l5PId0r0Bl0UycfcQ6y7eCvxaNdSU=
X-Received: by 2002:a0d:d5c3:0:b0:5f6:7816:f330 with SMTP id
 x186-20020a0dd5c3000000b005f67816f330mr264155ywd.94.1704999917362; Thu, 11
 Jan 2024 11:05:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240110-fp4-panel-v2-0-8ad11174f65b@fairphone.com>
 <20240110-fp4-panel-v2-2-8ad11174f65b@fairphone.com> <CACRpkdaWTfPDCin_L6pefHsokjNyO8Mo6hWPdzPLLi1EUkKUuA@mail.gmail.com>
 <CYBZEZ4IM6IL.VR04W7933VI@fairphone.com>
In-Reply-To: <CYBZEZ4IM6IL.VR04W7933VI@fairphone.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 11 Jan 2024 20:05:04 +0100
Message-ID: <CACRpkdZQbVXfBa70nhDOqfWPbsh-6DgX-uvZOxr19pzMmF2giQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] drm/panel: Add driver for DJN HX83112A LCD panel
To: Luca Weiss <luca.weiss@fairphone.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, Jessica Zhang <quic_jesszhan@quicinc.com>, 
	Sam Ravnborg <sam@ravnborg.org>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Andy Gross <agross@kernel.org>, devicetree@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, ~postmarketos/upstreaming@lists.sr.ht, 
	phone-devel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 11, 2024 at 4:28=E2=80=AFPM Luca Weiss <luca.weiss@fairphone.co=
m> wrote:

> In some internal documentation it says "LCD Driver IC" "HX83112A" and I
> don't see any reference to Truly 5P65 anywhere.

In the Android directory I pointed to I see this file:
HX83112_Android_Driver/Truly_5p65_module_fw/UpdateFW.bat

(Notice the 5p65 fw dir is *inside* the HX82112 dir)

And in that file:
adb push TRULY_5P65_1080_2160_HX83112A_D01C01.bin
/system/etc/firmware/Himax_firmware.bin

Clearly indicating that they are pushing a Truly 5P65 firmware into
the Himax display firmware directory.

To be fair, that is the driver for the touchscreen part of HX83112A,
but ... Truly is a well known manufacturer of display controllers?

But... given that you have a @fairphone.com mal address and
a working relationship with them, can't you just ask?

> On their website they have this sentence:

All OEMs want to look like everything is their own product. It is
business as usual.

Further on the same note since I guess you have a datasheet)
please bring in #defines for the commands (the first byte in the
write sequences, for examples:

+       mipi_dsi_dcs_write_seq(dsi, 0xbd, 0x02);
+       mipi_dsi_dcs_write_seq(dsi, 0xd8,
+                              0xaa, 0xff, 0xff, 0xff, 0xff, 0xff, 0xaa, 0x=
ff,
+                              0xff, 0xff, 0xff, 0xff);
+       mipi_dsi_dcs_write_seq(dsi, 0xbd, 0x03);

Clearly 0xbd is HX83112_CMD_SETREGBANK?
(This is easily spotted from the similar structure in the
existing panel-himax-hx8394.c.) So please add #defines
for all commands you know, especially if you have a datasheet
because we reviewers don't have them and "it's just magic
bytes" isn't very compelling. It adds a lot to understanding.

I strongly suspect other Himax displays such as HX8394 to
be using a Truly controller as well, hence the similarities.

In a datasheet for their TFT800480-84-V1-E display controller
Truly kept the init sequence name of void LCD_INIT_HX8290(void)
for example.

Yours,
Linus Walleij

