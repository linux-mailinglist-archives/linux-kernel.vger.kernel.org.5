Return-Path: <linux-kernel+bounces-55168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EB2284B8C0
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 16:03:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 520111F22012
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 15:03:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A350C132C25;
	Tue,  6 Feb 2024 15:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="WlO6KkSn"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBC491E49B
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 15:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707231823; cv=none; b=G3H/kxSqp2QDklTqBLg2oJ9jWPaeYea2TDNU19r3K8Yq86wQOWPaE0RKjFy5TIy2d2OrVKqCgykFaeKapvDdZ4p4+VBFN10jqQVrRHcu29nZ+quuCgY4j8qZclpUS6HoBt805eENWE2ILdCe4YV46ZV9SHOT2AXQuuWxj8oYz44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707231823; c=relaxed/simple;
	bh=j7tkzKcF5D4hjFwC2+hXqQYUUT01a4RtgVGSHaxJ6Cg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c/UTdVDBV9raDCMf9xUG7zqxfW53ctqmm0TihmaeMStUjdT2tDnntYnUCArPU2UCRXqrb/jlBE/mKQ8QZLy/DpxQc8Ls0lKVOpPXxA8V13/g+7HWn87fq8UY+1Ia9a+IU8pGn30t74Pjinapl5bDOQi3q7+eSg6ii3XHaXTLEaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch; spf=none smtp.mailfrom=ffwll.ch; dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b=WlO6KkSn; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-40fc4363a0aso12672895e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Feb 2024 07:03:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1707231819; x=1707836619; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RKfohJUroV976tglmTRMxraev0qNxAZBgWfmujjqUq4=;
        b=WlO6KkSnkgjbgasLNswv6ByN0KBQ73+KN/yFjzh99M+475OWR/ZhKEUDwjAb59oDnL
         VvhiirGXCW2zDMrRtJL6RNxNbkkJIktom1gz4t3aBExG12FPSXjXkRcSF6C3mRk1Ym+F
         oybV93CzD8BUdmDgYpQLAaXkrqcfoTP4QE/XM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707231819; x=1707836619;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RKfohJUroV976tglmTRMxraev0qNxAZBgWfmujjqUq4=;
        b=i1Uc21/QJfduZdvfjC19ZPMhs0ycRX7uuokjDrFcLFlvoV++jYVc/1FSiEqWG3rPbd
         jPsKPCIo890E1C7r33aSMSmH1SNcfP6FefbB4Qznbx1ArCL47UZzJLmdzLHyRxl6/Xaq
         bKwE8UnR0kYKcCzQ00LBcsopoReLQdpX2llFukKdoX5fUWhGpVW/MQEmg93n+tnZCUq7
         Ko3ZU5rD+Cp1Hqvy5wipXNJRZss4PKeI14aK8jXWB/DIexY0wR7aVwUcTLZE2VCB3KMB
         GmkUMIoRvlZakGc81spae9K+1U9BhDL4zG7sbAHUdEFfZTik0gVRGUsNQkpaoTh4tMuZ
         iLKw==
X-Forwarded-Encrypted: i=1; AJvYcCWPNhulR09ShhYh+Da2q0EGhSf41wvmuNr/f2elScG8u4NDUM+iEpkI+om0A+8ZSI5ENADzdqho6C8jAzlaRbBL5hJUJdpxXbJO8cZv
X-Gm-Message-State: AOJu0YzMNnDF3Yj7NtGAwXzMM/bk8t2FXhC+pb/fy84s51Ih40ouN1+/
	LJxAyTbNfVZSH2A6QCdl6Y15eAMGWuiJ6nTXgPvbOu9RpGP2HHGm/cfG6KKHH2w=
X-Google-Smtp-Source: AGHT+IET7mjYFC9IH5aIFSvUtIwuTpQ4KqBl4fIzq/2q8Y3bCp52T9n2MyZNeBpz2yX0aOfURAq+VA==
X-Received: by 2002:a05:6000:12c3:b0:33b:39bd:a78b with SMTP id l3-20020a05600012c300b0033b39bda78bmr1961940wrx.6.1707231818921;
        Tue, 06 Feb 2024 07:03:38 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWCm44wgTJzNGFJ6SWGW0pCEdc2rUx6nCHTz84pimuYdcQlXPfUYwsXtTv9S+iTBRUO59hmDPFshqy//WnXns0sD4WysblA2zD6gFzOImvirbSSgET/2ijRXh+XnvCNfGAqiGOgBk2TBfq3zAaLjpZ873p6v/WZ+PSivDj5nfzfuTphZ5LjW+L1wOJ84jNhzRDWgEzov4oJcNBMJUxK/UaMI/ROE4HZjpn1xgffol987k0TuU6JWzNTVC37oLpvEI21cB78xnwAqM8KXmn7vI8/lsR/X4ljBXwQ1WerTbEvj4G7ljjS/P4M/ukb1IvSWzi+wOkPNSXxIo0=
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id u13-20020a5d6dad000000b0033b1b01e4fcsm2336097wrs.96.2024.02.06.07.03.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 07:03:38 -0800 (PST)
Date: Tue, 6 Feb 2024 16:03:36 +0100
From: Daniel Vetter <daniel@ffwll.ch>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: "Ricardo B. Marliere" <ricardo@marliere.net>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 1/2] drm: display: make dp_aux_bus_type const
Message-ID: <ZcJKSCbAwm7SYx4v@phenom.ffwll.local>
Mail-Followup-To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	"Ricardo B. Marliere" <ricardo@marliere.net>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20240203-bus_cleanup-gpu-v1-0-1b6ecdb5f941@marliere.net>
 <20240203-bus_cleanup-gpu-v1-1-1b6ecdb5f941@marliere.net>
 <CAA8EJpqYH3CM8exv68S7KU-CK5r=jM81UPjiW09qOiqrg1ThKg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA8EJpqYH3CM8exv68S7KU-CK5r=jM81UPjiW09qOiqrg1ThKg@mail.gmail.com>
X-Operating-System: Linux phenom 6.6.11-amd64 

On Sun, Feb 04, 2024 at 10:24:46AM +0100, Dmitry Baryshkov wrote:
> On Sat, 3 Feb 2024 at 22:20, Ricardo B. Marliere <ricardo@marliere.net> wrote:
> >
> > Now that the driver core can properly handle constant struct bus_type,
> > move the dp_aux_bus_type variable to be a constant structure as well,
> > placing it into read-only memory which can not be modified at runtime.
> >
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
> 
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

Just to make sure this doesn't fall through cracks, I'm assuming you'll
push this to drm-misc-next too, right?
-Sima
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

