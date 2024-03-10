Return-Path: <linux-kernel+bounces-98341-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D74E87789B
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 22:34:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BA7EDB20F3B
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 21:34:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 100083A8C7;
	Sun, 10 Mar 2024 21:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OXVT1pEp"
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBBD43A8C0;
	Sun, 10 Mar 2024 21:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710106459; cv=none; b=gkjxSoYsn5ydgQ5TYFvnN355TfLawF3Fj7Y/eP7lILYv16pbda8gGk54NQgq8Dl0No+h52NQcat9qPEX2RqhU6KWJcQ5XSDYUEF8TvoOPJmlpi4pbc0tFk7nQANKaMjRSthgnJmL8148RBiTWmAM1UNQqO74ynYeAv7j4XgWdmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710106459; c=relaxed/simple;
	bh=8bUV68Q5s5RvpER0dCwK5YJCzkTZNGuP1xPI/F9j9Wo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qwVSqM6OGJ3swL5uHMZk06GzgyfVW+sXhM8jxGyU+nQ8aD3HIyz6f6ji4Uz0yzykK6wdjFlLteb8aFMxdQFPTMRfwPLs56OX4BGl+jSizvAvOG1FkmixTNul3LGppHgRtC1onAdxx+vONopP+LlyEeb+ERBJXIv28gu+e90vNiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OXVT1pEp; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3c1e992f060so1597963b6e.0;
        Sun, 10 Mar 2024 14:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710106457; x=1710711257; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ND+nuIGRJ12vGBTQjoZ/CxcUgpIVs6mQOKjwcppR7ZI=;
        b=OXVT1pEpYr/B+5SiC2nhSdzBiP/LDkZbUQUAx7YJx5aNblApahL6VVqUEjnnJsqJoV
         wz2RQHTcvQM+RzrY9nUMRaXJCM44MtSPnricl5SZPHdXh63shumAu9v0bR1jdwci/aA1
         vvwQNa4nX8WZiVJcxqLZ/H4iSBfrGuh8t2APLZdOzuAnSMpBQqj0xSrXnLTp+B11oMvr
         NKzDb/RaMM/sAV4aKa2mkD4JIx8Nu3chNQEsIMHqgusxge0ZYBAIad+JIEqTreIgNcn0
         mfGeaToIQaLbGLCv2YbjAWUPe3jBYRWKYBeNeT4K6y0v/tYHbpzTR7/CQelJAPWWwvwz
         5HnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710106457; x=1710711257;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ND+nuIGRJ12vGBTQjoZ/CxcUgpIVs6mQOKjwcppR7ZI=;
        b=G81GS3ria5gEcU9h5hAb8TybTxCK8IjoDNrjapp8C1InYWbFsCtltXsdWowyD+qltL
         dn9PeGOVpRPygHRop7wXOGM415XaIJupjOBUPqFX6rwHu/oNe2LV8YY9OvnEgkOhtwQL
         ojWqZ03uRvt+VwoLdhfE+QudyOiVl53TONkiNJmuH1xL5Av31QIpsVBco1h72/JDogI6
         HfZcCFuG2PAqsCBGiNAnaP6hkbw6QXs5xJAoh5Kn+BRdDBDV1yFsRysBI2nAPm1l0GkM
         dzhTr8RmlC1DOp9rk4V6qXebyJjGBWpY2MmP0ka699DAzvP7mnA2D+bkBy6uHn9Ig/v1
         G2aA==
X-Forwarded-Encrypted: i=1; AJvYcCUglJtC4gtU6cdeAFNx/v2iRBqUlKBGI61oiFZ9m8TyVzyt4vWE/TjUcgS7l5kPq/2Sf+hGXfA5jyAurbPhpt/b27i1ISxmLimURZlf9zDYBvBs2RNT7BEZP+QSQvxMDle4NJxJgtkjgtMYmFOL97eP60WXjr7nyMc4WQHnCkbu9+xB1EUUhtU0wAJ/IyQ2
X-Gm-Message-State: AOJu0YyHwa9vi7SO2f8p3dIKf0l4dmCgjs/gHwDhbJQCmgYhVwUkbXgy
	g7fja2S5hyHiFA3Q5a7PxtB+US9nC03xRsNYIkY/WVe7JcHXINk+
X-Google-Smtp-Source: AGHT+IGc0Bj46AyQYYE/IkHFIMg/paIDGIOnXaU7E/SxDEwF3pj4nXkv+icahsb8gDuJLIqi/pGpZg==
X-Received: by 2002:a05:6808:2124:b0:3c2:39c8:435f with SMTP id r36-20020a056808212400b003c239c8435fmr6665279oiw.51.1710106456759;
        Sun, 10 Mar 2024 14:34:16 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:fa9b:d52c:840:abd4])
        by smtp.gmail.com with ESMTPSA id l66-20020a633e45000000b005b7dd356f75sm2998812pga.32.2024.03.10.14.34.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Mar 2024 14:34:16 -0700 (PDT)
Date: Sun, 10 Mar 2024 14:34:14 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Gergo Koteles <soyer@irl.hu>
Cc: Ike Panhc <ike.pan@canonical.com>, Hans de Goede <hdegoede@redhat.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org
Subject: Re: [PATCH v2 1/2] Input: allocate keycode for Display refresh rate
 toggle
Message-ID: <Ze4nVovvIV97Ydt7@google.com>
References: <cover.1710065750.git.soyer@irl.hu>
 <15a5d08c84cf4d7b820de34ebbcf8ae2502fb3ca.1710065750.git.soyer@irl.hu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15a5d08c84cf4d7b820de34ebbcf8ae2502fb3ca.1710065750.git.soyer@irl.hu>

On Sun, Mar 10, 2024 at 12:31:41PM +0100, Gergo Koteles wrote:
> Newer Lenovo Yogas and Legions with 60Hz/90Hz displays send a wmi event
> when Fn + R is pressed. This is intended for use to switch between the
> two refresh rates.
> 
> Allocate a new KEY_REFRESH_RATE_TOGGLE keycode for it.
> 
> Signed-off-by: Gergo Koteles <soyer@irl.hu>

Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

> ---
>  include/uapi/linux/input-event-codes.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/uapi/linux/input-event-codes.h b/include/uapi/linux/input-event-codes.h
> index 022a520e31fc..03edf2ccdf6c 100644
> --- a/include/uapi/linux/input-event-codes.h
> +++ b/include/uapi/linux/input-event-codes.h
> @@ -602,6 +602,7 @@
>  
>  #define KEY_ALS_TOGGLE		0x230	/* Ambient light sensor */
>  #define KEY_ROTATE_LOCK_TOGGLE	0x231	/* Display rotation lock */
> +#define KEY_REFRESH_RATE_TOGGLE	0x232	/* Display refresh rate toggle */
>  
>  #define KEY_BUTTONCONFIG		0x240	/* AL Button Configuration */
>  #define KEY_TASKMANAGER		0x241	/* AL Task/Project Manager */
> -- 
> 2.44.0
> 

-- 
Dmitry

