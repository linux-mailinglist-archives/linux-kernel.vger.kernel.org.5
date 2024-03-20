Return-Path: <linux-kernel+bounces-109325-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AB7D88179A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 19:59:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D35C51F22F47
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 18:59:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EE8785620;
	Wed, 20 Mar 2024 18:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i+SyyCFp"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C3C485284
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 18:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710961161; cv=none; b=VI7w1wvGL2UcTRXDOu5V7wl1ynWvhXjjF1PfYBOGej+KUwbWcmC9InTxPNM8teCAAhOZMtf23QxtKqlm6Dk7Z8QllNwfVg804oHu6amRcG4PBdR0chii9uxtfEgACgYFrtvGarltWTZT7vxeZKZHZJBsycQktKW8bmGysmYVU2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710961161; c=relaxed/simple;
	bh=qHYvAsPrMnD2iQSDXxs8ogFl4UxWVh1x34JOLemgsD4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aUiWCRPYP50JbcAwQt0L3zed8VtW2KPWnKGck3MM1pky+R5HxyZk5yV2325w4XeszutEyLwbFSCSriglLiEVhwVZrh2IrjFplg1FiKQu5VZiK++IJ3PywQmVhg7U4sw2wqHsdr4WAW/EJBLMwTqwtWG4pLQQOenmjKzAo1yNjYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i+SyyCFp; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-513ccc70a6dso389366e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 11:59:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710961158; x=1711565958; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uDx69RtQxFyew2zNRPx2nT1ZQv12YYyDo+1YlWLy1Kg=;
        b=i+SyyCFpI4DGb4P9e0EbO7Vn/9giwbs1cyl6ajrICc9XiHNlzrj9B9oXphQusnEmc3
         UKQof02Hd4tRFQdQnGu2d2giX9tUuzYfZiRmqvPOKUnM2MVAdX+BaaF5P6SZtSzpFOm3
         4PvheUHj06JhC/j0NzROC5fyngmMRF1r3z8RclqUOWNplsV4mMh05RHSDpwwHC9lwTHt
         KBgssf3chez1llXCbqSjRRMpuu2kA2d6nGTbVfCAgWXzG8MpMemMra9BCfaePIQ/6fFT
         BBmz5G2j0P+sD+Xw2EPrAbPZkr9OwoCuaTzYkLjh1nvQ5S99vkzjYUdzHZCE604iNcQd
         4BQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710961158; x=1711565958;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uDx69RtQxFyew2zNRPx2nT1ZQv12YYyDo+1YlWLy1Kg=;
        b=O+seEPuAAMux7z6MSZVJn45eS6i5tfpopNPnPCPvaEdhT3o5U7RA8LZmNAI88hKBZp
         A1x11NyW0SpVtpQ8omQKxymhCxYVrkhjHfaaz0SuG11NVtbdNJmn76wUJd9ekoJ/LyQy
         sRprcWLtCulBppIvZNO6cujjkiQKTFFR2yPx9bwegZC3tDVlauzblFqRz8kHgKz9xMpO
         k0QrlBJWtHZTTjVoLFXPx8aLTJHpK5np+KDTVOAumQdvn3sTKHUFD02qmlLn6Uz03DI+
         TjCz9GMZS+zVXztsdPJcdBcGSFUoMElARoauDfplJ83He/bFRwZ/8Bfx+mfzavnnWqc9
         Rz1Q==
X-Forwarded-Encrypted: i=1; AJvYcCVIX3kiYxFZtUcPYxTW6/kTH8JUY/7VJpEMwhM3WuEjj+Myu2GD7lYEP+NAGxe1l93UpHffB0SSY2rFOaASF7MK+JEem3kgDcOifZkK
X-Gm-Message-State: AOJu0YxnJGpSoY0Mau/W69BYXFxOnHjZsEJ3XlZEdKVpX07lGP0FT6FR
	QDpTij2vXR7W4mAr0PX+bmWd2GRhnovT54znbWqyWn70HctZRvYd
X-Google-Smtp-Source: AGHT+IH/ceP2Pxa/IuRZRDzz0Pwy3ckqKVMWSsWh5JN5WyzR1CEU2WVpYfRZlMZa1f7TIzgH0F5dCw==
X-Received: by 2002:a05:6512:32a9:b0:513:d976:496a with SMTP id q9-20020a05651232a900b00513d976496amr11193764lfe.50.1710961155907;
        Wed, 20 Mar 2024 11:59:15 -0700 (PDT)
Received: from mehdi-archlinux ([2a02:8109:aa27:2d00::e094])
        by smtp.gmail.com with ESMTPSA id jl27-20020a17090775db00b00a45c9ea48e3sm7586136ejc.193.2024.03.20.11.59.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Mar 2024 11:59:15 -0700 (PDT)
Date: Wed, 20 Mar 2024 19:59:13 +0100
From: Mehdi Djait <mehdi.djait.k@gmail.com>
To: Javier Martinez Canillas <javierm@redhat.com>
Cc: Thomas Zimmermann <tzimmermann@suse.de>, daniel@ffwll.ch,
	maarten.lankhorst@linux.intel.com, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: Re: drm/tiny: QUESTION: What to use instead of
 drm_simple_display_pipe ?
Message-ID: <ZfsyAXPCRX5hXBc0@mehdi-archlinux>
References: <ZfiTbYAa7qxXlrPd@mehdi-archlinux>
 <da7cfff1-e147-48ea-bcda-9ea913e5feee@suse.de>
 <87o7ba1u3x.fsf@minerva.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87o7ba1u3x.fsf@minerva.mail-host-address-is-not-set>

Hello Javier, Hello Thomas,

On Tue, Mar 19, 2024 at 09:52:34AM +0100, Javier Martinez Canillas wrote:
> Thomas Zimmermann <tzimmermann@suse.de> writes:
> 
> Hello Mehdi,
> 
> > Hi
> >
> > Am 18.03.24 um 20:18 schrieb Mehdi Djait:
> >> Hello everyone :)
> >>
> >> I am implementing a tiny drm driver and I am currently working on the
> >> V2: https://lore.kernel.org/dri-devel/cover.1701267411.git.mehdi.djait@bootlin.com/
> >>
> >> I got a review on the v1 telling me not to use the
> >> drm_simple_display_pipe. Can someone please explain this further ? Or
> >> give me an example drm driver that does it the right way ?
> >
> > You can copy the code from drm_simple_kms_helper.c into your driver file 
> > and start inlining everything. For example
> >
> >   1) Your driver calls drm_simple_display_pipe_init(), so you copy that 
> > code into your source file
> >   2) drm_simple_display_pipe_init() uses drm_simple_kms_plane_funcs and 
> > drm_simple_kms_crtc_funcs, so you copy these into your source file; 
> > together with the drm_simple_kms_*() helpers that they use for their 
> > callback pointers.
> >   3) Mayb do this for other drm_simple_kms_*() code.
> >   4) Then start inlining: inline your copy of 
> > drm_simple_display_pipe_iit(). Instead of using 
> > sharp_ls027b7dh01_pipe_funcs, inline its functions into your copy of the 
> > callers. And so on.
> >   5) Rename the resulting code, so that it fits you driver.
> >
> > With careful changes, you 'll end up with the same functionality as 
> > before, but without the intermediate layer of the simple-KMS code.
> >
> 
> On top of what Thomas said, you can check 622113b9f11f ("drm/ssd130x:
> Replace simple display helpers with the atomic helpers") that did this
> change for the drivers/gpu/drm/solomon/ssd130x.c driver.
> 
> The driver is also for a monochrome panel controller and it does support
> SPI as transport, which means the controller is similar to yours in many
> aspects. You could use that driver code as a reference for your driver.

Thank you both very much!

--
Kind Regards
Mehdi Djait

