Return-Path: <linux-kernel+bounces-21019-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EDCEE82889D
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 16:00:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 80826B22BFA
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 15:00:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE91039AEB;
	Tue,  9 Jan 2024 15:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VoQnDp0G"
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D49B12C865;
	Tue,  9 Jan 2024 15:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-2053f5e97b2so2079932fac.3;
        Tue, 09 Jan 2024 07:00:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704812400; x=1705417200; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RyKP7ndLV+Kcpm0EuaGv/5soSY6fBfB2g6ZMXyiQm6w=;
        b=VoQnDp0GgrI+Rfv70IoMhZc7Qy2b79/qoAQmtD030f9YlewByUb9KRxI+bhp0OIbsA
         ywX/httSYheMLVkEDvMs94IOQUQHHwmcEMRNf3GFdM+QUc2SFPQFLsZ58fUIu0f116+W
         5zeG0fJ0Xs3h3xD0XH302jceryTm40oyC+9vMX8nF4MHPXv5W8vmD5aphNlyRMCgQurD
         irt+jNBdBA3tEVJlxhUdYPgS7OS7Pzi8RUywVdvgSgVAyh+wltMZrGEaGfdAXoqZ2vEZ
         NI0n3qUJve7gH27bIRtITtSFbMuziRIZUAu/b46RLbMDTq1DNTm7TR5SFJ3gUpOANpG+
         adYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704812400; x=1705417200;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RyKP7ndLV+Kcpm0EuaGv/5soSY6fBfB2g6ZMXyiQm6w=;
        b=BdOKRl4wm/IWHPX4wlj78pY+p1L1emlydYGus5x6NOXn3AQnHnvKEjVeNQz04ZCsd4
         hfbtwRFT554DraFAcrEcwriGUg++9cGZZw+pVjRsQE4C58iOl02Pa6S8AaZUTCuVUdOm
         ouPcEbBLDMZxgZPlhO1Opd3OsGkD/DOXYWM5+MxoX00pYNnG6S53ie+PWBFDvlde4hqc
         0UCIZczjFSY+4+Xs4NcBWNH7iAc8YeUL+xDOle3qeYtWhFY15ehQmAJDI8u5aNeI18/n
         zR/zm5nIUvZNo+ORirm19XWZOKwi1C3aDRonophMPl5SAVW2hl+p3StHTCIUvSLomDEI
         KCcw==
X-Gm-Message-State: AOJu0Yw+nDomnOSir6viO69X8FaRNy4N5fong6yVdb1Kf/iELCJ+cVg4
	S0FUrwJGaUHNBUc5KRzATfk6RWKu9R3zXEbUWQw=
X-Google-Smtp-Source: AGHT+IF5A6wFdIUUU7b6vSsTGwHl0nkFfXfXW1v7m4SxCgxxBpfAHVhg3uo5Z79+TXU1DRG6qXWF0HnFsAg45RlC2Ss=
X-Received: by 2002:a05:6871:8009:b0:204:1590:2044 with SMTP id
 sk9-20020a056871800900b0020415902044mr7142787oab.5.1704812399799; Tue, 09 Jan
 2024 06:59:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240109140345.3344094-1-daniel.vetter@ffwll.ch>
In-Reply-To: <20240109140345.3344094-1-daniel.vetter@ffwll.ch>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 9 Jan 2024 09:59:48 -0500
Message-ID: <CADnq5_PspPP6DcCQm_kro+KRiSAo2y2XX6mEA4vF4gCBgTwnxg@mail.gmail.com>
Subject: Re: [PATCH] kernel-doc: document object-like preprocessor macros
To: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: LKML <linux-kernel@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	DRI Development <dri-devel@lists.freedesktop.org>, Randy Dunlap <rdunlap@infradead.org>, 
	linux-doc@vger.kernel.org, Maxime Ripard <mripard@kernel.org>, 
	"Steven Rostedt (Google)" <rostedt@goodmis.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	Daniel Vetter <daniel.vetter@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 9, 2024 at 9:16=E2=80=AFAM Daniel Vetter <daniel.vetter@ffwll.c=
h> wrote:
>
> I had no idea this exists, but Randy pointed out it's been added quite
> a long time ago in cbb4d3e6510b ("scripts/kernel-doc: handle
> object-like macros"). Definitely way before I started to write all the
> drm docs sadly, so there's a few things where I skipped writing
> kernel-doc since I didn't know it was possible.
>
> Fix this asap by documenting the two possible kernel-doc flavours for
> preprocessor definitions.
>
> References: https://lore.kernel.org/dri-devel/dd917333-9ae8-4e76-991d-39b=
6229ba8ce@infradead.org/
> Cc: Randy Dunlap <rdunlap@infradead.org>
> Cc: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: Maxime Ripard <mripard@kernel.org>
> Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
> Cc: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: linux-doc@vger.kernel.org
> Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>

News to me as well.
Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  Documentation/doc-guide/kernel-doc.rst | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
>
> diff --git a/Documentation/doc-guide/kernel-doc.rst b/Documentation/doc-g=
uide/kernel-doc.rst
> index 6ad72ac6861b..a966f1fd5c30 100644
> --- a/Documentation/doc-guide/kernel-doc.rst
> +++ b/Documentation/doc-guide/kernel-doc.rst
> @@ -341,6 +341,32 @@ Typedefs with function prototypes can also be docume=
nted::
>     */
>     typedef void (*type_name)(struct v4l2_ctrl *arg1, void *arg2);
>
> +Preprocessor defines documentation
> +----------------------------------
> +
> +There are two ways to document preprocessor defines. The first works mor=
e or
> +less like kernel-doc for functions, including parameters::
> +
> +  /**
> +   * FUNC_NAME() - Brief description
> +   * @arg1: description of arg1
> +   * @arg2: description of arg2
> +   *
> +   * Description of the preprocessor function, may have multiple paragra=
phs.
> +   */
> +  #define FUNC_NAME(arg1, arg2)
> +
> +The second type is different and for object-like preprocessor macros wit=
hout any
> +parameters::
> +
> +  /**
> +   * define MACRO - Brief description
> +   *
> +   * Description of the object-like preprocessor macro, may have multipl=
e
> +   * paragraphs.
> +   */
> +   #define MACRO
> +
>  Highlights and cross-references
>  -------------------------------
>
> --
> 2.43.0
>

