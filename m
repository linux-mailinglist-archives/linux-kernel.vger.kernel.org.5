Return-Path: <linux-kernel+bounces-92802-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B169872624
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 19:02:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 328A2285B25
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 18:02:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4590B18041;
	Tue,  5 Mar 2024 18:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b="aI8/vsEf"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C79F15491;
	Tue,  5 Mar 2024 18:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709661747; cv=none; b=FcWcpS+ueV6KlUXvsHgyQp97AZPOBiQ2A3XvzM8F1+3fjX697ewYdfsAEFSqOD4inwyv8nF1/cQkBJEVGXsatH3myqUk3ypLHJCgfKJniIeqhz37ceeXF6LvhyB254kM0v+jv8jX2xxSxvCK0mkyF79vFismTniHb5YDEsWugzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709661747; c=relaxed/simple;
	bh=QqWrWCKsxZxMhKdI4i8NVKhYN7tvmXPQ4NdougnitWw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dvnIC0dOQ3bJJ6iRSI3poQTciE78qa1RyvGHRUyuzFuKDR/j2s+iLPRiKBbMfSl1sNleRYe4Ys8ieS1S5yP9wUtgNhnaNlyrTahgl/FAPDzZVNtYvA7vA8cSDzB/y+7zDLrzIN1jOPNGUemI7pejiw9DALX0BoxJU07kK8hdc8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b=aI8/vsEf; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1dba177c596so163185ad.0;
        Tue, 05 Mar 2024 10:02:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709661744; x=1710266544;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:dkim-signature:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=YJ70Tv4h5AKfiBQVV4/s2rwMqfxMbFKTboyKv27NZLU=;
        b=jmN13ZSunDJA/54gEfXJ+43IwAtWBv4bp1+SqvGdCYFx+xltyhbpZect8q5nUXyViG
         293DjHWDyxOTwc4rsUyJu+d7i4Hp7dVJkprXoyLmNt0TEhZIgmYjzjOM4JoN0If+hrO2
         8bMC9BMIT/LqTfEmjQftKhglRDqHN18oWh0Q8lvJ8mq2K+k9cnbk2zajZf90tK6wQY49
         Ww1lfGdMwHFzymyop97rFN1KKQAeOjmtj4vP6r/aDZ28vHZzbEx/BOckMBVZs00TZgxn
         53PqmuBVoi/CT9ybTg0J/o5RWJRunHI/WqxjrzARbu+zxO/PmQ6P26Er8Il4HAAkG6pl
         opag==
X-Forwarded-Encrypted: i=1; AJvYcCVfq23MAUlIZ1H430urlI3yjfCbAvmzJFN39jEvym2cKeubplSmnn1ZDDUdg5OoWa1IOHFL7nLTy4QpA+cMRx1ERwRwtSPsYkX6/8NqOfAnnkwuiWLYiN4zP+sCN89XNjiVHejnLNKTmGQV8stZw9zkyJ0U9qLXE5OMx2QXWT5w7K28kjr1Pw==
X-Gm-Message-State: AOJu0YxnAsG6M7NWxSwaAtC+q+HFjsqHizql7eCilLFcHhoum1ufMoV4
	KtDY+qHAers27cIlUW1FsCibu6cX/9FTpHhlBU9OVMHNOY1cuIeY
X-Google-Smtp-Source: AGHT+IE+QeWdybpOmeVBdSyQw2r7Ej1xSRJHaUNhk4fq9R6Iz6FjMOYAhuLG29kBbDSLUmIvi0ExUw==
X-Received: by 2002:a17:903:1cc:b0:1d9:a15:615d with SMTP id e12-20020a17090301cc00b001d90a15615dmr4010129plh.1.1709661744304;
        Tue, 05 Mar 2024 10:02:24 -0800 (PST)
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id s14-20020a170902ea0e00b001dd38bce653sm28566plg.99.2024.03.05.10.02.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 10:02:23 -0800 (PST)
Date: Tue, 5 Mar 2024 15:02:18 -0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2024; t=1709661742;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YJ70Tv4h5AKfiBQVV4/s2rwMqfxMbFKTboyKv27NZLU=;
	b=aI8/vsEfN/Bld3c1dh2lfn+V3skU5KzIAqhIHcK7NAjAqJBfROsAnrKyK4eQ+UyoGoN+NP
	zzlbhCR32haBdY7hr8R76en3m52BMB2qTNeH1riF0Yo4h/OL1vI/mWmODXCQHNS+kipiA1
	eymqvBd6Un7r1WO2rW64vrCVs1RTBYhhHa5VzXn6zajrWFIiu79tGxfvIsfxqXPmL0AlKs
	N2m7SPUbPh7LCr6ibTBZNTbKPxaVqX5e/9ntlV71Z0VfXAi7iszHHGH6a5F959mB1mZr1G
	gXGLiFS6K0vFVxf9oxGTPFiWjVIUttDTGYfNoknFC+wlLnCrwH6+HqoE0dMHFg==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
From: "Ricardo B. Marliere" <ricardo@marliere.net>
To: "T.J. Mercier" <tjmercier@google.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Hans de Goede <hdegoede@redhat.com>, Helge Deller <deller@gmx.de>, 
	Sumit Semwal <sumit.semwal@linaro.org>, Benjamin Gaignard <benjamin.gaignard@collabora.com>, 
	Brian Starkey <Brian.Starkey@arm.com>, John Stultz <jstultz@google.com>, 
	Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, 
	linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org
Subject: Re: [PATCH RESEND drm-misc 4/4] dma-buf: heaps: make dma_heap_class
 constant
Message-ID: <gdkioaqffaoiocsybn22qwfpkgz6cujy5oklrdicgdcbatlsan@v7qjtak5jacn>
References: <20240305-class_cleanup-drm-v1-0-94f82740525a@marliere.net>
 <20240305-class_cleanup-drm-v1-4-94f82740525a@marliere.net>
 <CABdmKX0VGyBdTo8gzEocyz2HFcqEtu_31PYVjWzioBdCbnXW6w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABdmKX0VGyBdTo8gzEocyz2HFcqEtu_31PYVjWzioBdCbnXW6w@mail.gmail.com>

On  5 Mar 09:07, T.J. Mercier wrote:
> 
> Reviewed-by: T.J. Mercier <tjmercier@google.com>
> 
> Is this really a resend? I don't see anything on lore and I can't
> recall seeing this patch in my inbox before.

Hi T.J. thanks for reviewing!

I'm sorry about that, I sent the series only to Greg before but I
thought it had Cc'ed the lists as well. Then I realized it was sent
publicly only once. Double mistake :(

Best regards,
-	Ricardo.



