Return-Path: <linux-kernel+bounces-12495-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3432E81F59C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 08:47:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 665D81C215BD
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 07:47:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B72363B6;
	Thu, 28 Dec 2023 07:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="RVrDiV1c"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ej1-f65.google.com (mail-ej1-f65.google.com [209.85.218.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2433363AB
	for <linux-kernel@vger.kernel.org>; Thu, 28 Dec 2023 07:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ej1-f65.google.com with SMTP id a640c23a62f3a-a2370535060so1212378966b.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Dec 2023 23:47:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1703749619; x=1704354419; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0RD//yf6UNgtamLmcyb9OZoesDiNqj4U6mxrWxzklYw=;
        b=RVrDiV1cYjLK9TKes7faHdAYdWo9cRp1usq0UMq5ojUyr2+8rVm/ugdQ8R0zxGgspY
         eqGdAdz3V1Ta9J+WzvujNcDERMwKAy1zk+Advrg3ncRdDDUgcbXmmbEqP7Ela+I8+Fgb
         mcHb0/rE+Mq5uis8+Gg0MKq0LoVEmgaGmIZIXfLq/ibOSYvR6E15f5nkUfCSrTvwtMO/
         dqKQVV8iF9BSYAEHa/gtGMFsZvPzn/VMHBUdeB1rsbcwzLRTSAt0MoblTXcLY570viqc
         7eBeJJU8ITjmA6CXkzUccg8qHiGdhXa4OqoXAoRYA/qRCWIq/IrGeYUJKqN4zRKfJ3KW
         tv6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703749619; x=1704354419;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0RD//yf6UNgtamLmcyb9OZoesDiNqj4U6mxrWxzklYw=;
        b=xOANrpoLANpyaoyBJ+wPO3WIdU3Ck212L8RzLej5akhk/eEYPWnhe8pe74FdFycPnl
         RdwkDeSevXzb6OkElTGL7joOpo0DySfAOs4Ouuf/PC26Gr6z/eMamskUR9alseWMnyzR
         +rLBDR9F7Z/1NSsUUvwPXastj4ER9yTisW57PPja46tF7JdDk+CliMUGjlnyx18OaffE
         FNEy5qazdKvFCW3D7haAH4eSZ9pv9Yt32stc2dVm6rynmm5HJkqFLfQUSCJKAstakDBc
         pWYI4MUWFTAD+Q2dbeSbnvnfdGZ8z1WrSP9UCTbPomIiE0v6ZlWYY520RyiG/ZjMQqFE
         lV4w==
X-Gm-Message-State: AOJu0Yxfa0rdY0bYtgKCBw3ldmddTdv7nOsl3vKq29A7mCHlp0CEFtng
	G+deccSHxlIHjRLsSB+QCs3181rlMBvEHg==
X-Google-Smtp-Source: AGHT+IFG6PF/vc7PF3AKEea+aRfz6koTBbAHUssv6AR3ZS0xsmEtyr7UmwCARfeI5FwgEs6qU+FfHg==
X-Received: by 2002:a17:907:9483:b0:a1e:5a8a:674a with SMTP id dm3-20020a170907948300b00a1e5a8a674amr13615605ejc.19.1703749619065;
        Wed, 27 Dec 2023 23:46:59 -0800 (PST)
Received: from localhost (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id v7-20020a17090651c700b00a2724560851sm1928937ejk.85.2023.12.27.23.46.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Dec 2023 23:46:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 28 Dec 2023 08:46:58 +0100
Message-Id: <CXZSU1D3YID7.6FE4TR15LF1V@fairphone.com>
Cc: "Arnd Bergmann" <arnd@arndb.de>, "Jessica Zhang"
 <quic_jesszhan@quicinc.com>, "Sam Ravnborg" <sam@ravnborg.org>, "Linus
 Walleij" <linus.walleij@linaro.org>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm/panel/raydium-rm692e5: select
 CONFIG_DRM_DISPLAY_DP_HELPER
From: "Luca Weiss" <luca.weiss@fairphone.com>
To: <neil.armstrong@linaro.org>, "Arnd Bergmann" <arnd@kernel.org>, "Maarten
 Lankhorst" <maarten.lankhorst@linux.intel.com>, "Maxime Ripard"
 <mripard@kernel.org>, "Thomas Zimmermann" <tzimmermann@suse.de>, "David
 Airlie" <airlied@gmail.com>, "Daniel Vetter" <daniel@ffwll.ch>, "Konrad
 Dybcio" <konrad.dybcio@linaro.org>
X-Mailer: aerc 0.15.2
References: <20231023115619.3551348-1-arnd@kernel.org>
 <00e81457-9148-4ca1-8433-4b7cad0652b5@linaro.org>
In-Reply-To: <00e81457-9148-4ca1-8433-4b7cad0652b5@linaro.org>

On Mon Oct 23, 2023 at 3:25 PM CEST, Neil Armstrong wrote:
> Hi,
>
> On 23/10/2023 13:55, Arnd Bergmann wrote:
> > From: Arnd Bergmann <arnd@arndb.de>
> >=20
> > As with several other panel drivers, this fails to link without the DP
> > helper library:
> >=20
> > ld: drivers/gpu/drm/panel/panel-raydium-rm692e5.o: in function `rm692e5=
_prepare':
> > panel-raydium-rm692e5.c:(.text+0x11f4): undefined reference to `drm_dsc=
_pps_payload_pack'
> >=20
> > Select the same symbols that the others already use.
> >=20
> > Fixes: 988d0ff29ecf7 ("drm/panel: Add driver for BOE RM692E5 AMOLED pan=
el")
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > ---
> >   drivers/gpu/drm/panel/Kconfig | 2 ++
> >   1 file changed, 2 insertions(+)
> >=20
> > diff --git a/drivers/gpu/drm/panel/Kconfig b/drivers/gpu/drm/panel/Kcon=
fig
> > index 99e14dc212ecb..a4ac4b47777fe 100644
> > --- a/drivers/gpu/drm/panel/Kconfig
> > +++ b/drivers/gpu/drm/panel/Kconfig
> > @@ -530,6 +530,8 @@ config DRM_PANEL_RAYDIUM_RM692E5
> >   	depends on OF
> >   	depends on DRM_MIPI_DSI
> >   	depends on BACKLIGHT_CLASS_DEVICE
> > +	select DRM_DISPLAY_DP_HELPER
> > +	select DRM_DISPLAY_HELPER
> >   	help
> >   	  Say Y here if you want to enable support for Raydium RM692E5-based
> >   	  display panels, such as the one found in the Fairphone 5 smartphon=
e.
>
> Will apply once drm-misc-next-fixes is synced with the last drm-misc-next=
 PR for v6.7.

Hi Neil,

I think this patch is still pending, I don't see it in linux-next.

It was also reported by a buildbot today
https://lore.kernel.org/lkml/202312281138.PHn1Js8S-lkp@intel.com/

Regards
Luca

>
> Neil


