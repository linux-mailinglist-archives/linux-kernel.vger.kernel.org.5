Return-Path: <linux-kernel+bounces-9216-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B644D81C265
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 01:45:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49AA72847E0
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 00:45:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB7CA322B;
	Fri, 22 Dec 2023 00:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dionne-riel-com.20230601.gappssmtp.com header.i=@dionne-riel-com.20230601.gappssmtp.com header.b="OURh1luH"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FFAF28FD
	for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 00:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dionne-riel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dionne-riel.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-67f3f602bd5so7415816d6.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 16:45:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dionne-riel-com.20230601.gappssmtp.com; s=20230601; t=1703205925; x=1703810725; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :references:in-reply-to:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vO72U8OhvgCsTxx/aC8/ALqxbW9fKG0Z3MExzKQqln8=;
        b=OURh1luHDdCDbQLbgAG9StWD+9sw5oiJdWHGls4ZyPiStr11DGqvVqN69SCmAQzkqh
         GZTN8RY8wm6oyWnUYtEvVbKj0fmwHXyTGPmtBZSc265S5gWGaVrbNFGTeqO+tE5f1h/J
         a4Yf0VqiDc6TXlbF5IWHUUrGKp3XzeiP2vhiQGX2V1w0yUCAOBsixX0EnJj3N0Ut2Tb7
         eo+Zp5AwI1NgIA1spXicasdjFRSL9AM7bXXFN+p11pPsWxktS753bBSnOlNWo+OYA0vv
         YbUlYx9jg8ijVgzI7TAx0KO0Uq5PS1eDB6ffAXy2jrWDmrVnO9MFux+SosJnK4KTIHij
         GKtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703205925; x=1703810725;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :references:in-reply-to:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vO72U8OhvgCsTxx/aC8/ALqxbW9fKG0Z3MExzKQqln8=;
        b=CNkDguxLC37X+U0cyBQT2Mhdw/RzLcYSUIMmAabTM/JKIxi4QrW4UovFbIjobvsAsG
         cr0+AwCF7sjdBR4HBRacv1d784Y+buz+txdw3eSp1y9ZiG/hzS8uP4kDkB/idA9+NEer
         Cx30zYh9ZjcIvCvcIcLcJokJHGyQir4kfx2MBoCJBDX2FFICZF7lpVZX3G+kdim+ExP0
         8XNIXpUd7T6tb/qQvxfUeZmxz7SEi96LCBYl6Mus/qE2eWhEt8QnC7nfdAWuqGEiUskV
         lis0myMn/MBeXLOo3P0KlBA+/daxucXpprCfo5kl9TI9LTuJ0OLP+XheKW+gsHDMdE9I
         8wYg==
X-Gm-Message-State: AOJu0YxlVn//l6+U2mG6ZilMb6KnV8yvJd48sqPJa252DRT+zC2pFqU6
	GMJfYF4NsGxz21hKwk19anSkCmzNWoYZTWpBPfi3agkVmynO
X-Google-Smtp-Source: AGHT+IGlXvi3g0g2VEeP4AL+AxR5RLB0jBCBrh4ZfaNIWy6p/3fXWWJfTWzmA43P7UWukKd7BgYhkilgv+25o8qOUYs=
X-Received: by 2002:a05:6214:27c1:b0:67f:7aa:2b75 with SMTP id
 ge1-20020a05621427c100b0067f07aa2b75mr546603qvb.104.1703205925444; Thu, 21
 Dec 2023 16:45:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Received: by 2002:a05:6200:3989:b0:52b:9b0d:f9a8 with HTTP; Thu, 21 Dec 2023
 16:45:25 -0800 (PST)
In-Reply-To: <20231222003830.3733310-1-samuel@dionne-riel.com>
References: <20231222003830.3733310-1-samuel@dionne-riel.com>
From: Samuel Dionne-Riel <samuel@dionne-riel.com>
Date: Thu, 21 Dec 2023 19:45:25 -0500
Message-ID: <CAN1fySWi_QJt8ufUc99vRiE17-SfQOGfMsxFqH+TJC1PgjRsDw@mail.gmail.com>
Subject: Re: [PATCH] drm: panel-orientation-quirks: Add quirk for GPD Win Mini
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc: Samuel Dionne-Riel <samuel@dionne-riel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Sorry, I was preparing for sending to the mailing list, and sent
before I should have.

I believe I have the orientation on the wrong side, though, so please
wait for a follow-up here or the v2.

Sorry again,

On 12/21/23, Samuel Dionne-Riel <samuel@dionne-riel.com> wrote:
> Signed-off-by: Samuel Dionne-Riel <samuel@dionne-riel.com>
> ---
>  drivers/gpu/drm/drm_panel_orientation_quirks.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/gpu/drm/drm_panel_orientation_quirks.c
> b/drivers/gpu/drm/drm_panel_orientation_quirks.c
> index 3d92f66e550c3..f730886ae10df 100644
> --- a/drivers/gpu/drm/drm_panel_orientation_quirks.c
> +++ b/drivers/gpu/drm/drm_panel_orientation_quirks.c
> @@ -279,6 +279,12 @@ static const struct dmi_system_id orientation_data[]=
 =3D
> {
>  		  DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "G1618-03")
>  		},
>  		.driver_data =3D (void *)&lcd720x1280_rightside_up,
> +	}, {	/* GPD Win Mini */
> +		.matches =3D {
> +		  DMI_EXACT_MATCH(DMI_SYS_VENDOR, "GPD"),
> +		  DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "G1617-01")
> +		},
> +		.driver_data =3D (void *)&lcd1080x1920_leftside_up,
>  	}, {	/* I.T.Works TW891 */
>  		.matches =3D {
>  		  DMI_EXACT_MATCH(DMI_SYS_VENDOR, "To be filled by O.E.M."),
> --
> 2.42.0
>
>


--=20
=E2=80=94 Samuel Dionne-Riel

