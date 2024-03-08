Return-Path: <linux-kernel+bounces-97326-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAA858768CE
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 17:49:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBE3A1C20B41
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 16:49:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B06218E03;
	Fri,  8 Mar 2024 16:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b="Tfa+BseJ"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E757A175BE;
	Fri,  8 Mar 2024 16:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709916553; cv=none; b=Aya2QnrqQSFUbXGhbVVTDFXu9iFpYNxLhH0VYbacsQ1JAUBJrcYi/0c+IptbStMaKrtdbGYmRbp6wA7rWjErrm658Tcn4n0DiPTQwSFbEpJYT59IB7gVemf78zto3OqdA+F0X79HL7kXp0UWsW/m5I2LokQfcWAacJx2AIwTvYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709916553; c=relaxed/simple;
	bh=dp4f7tpqFRN9XFjkTecp9FwtbYISiPJKREb/NnDaXg8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XtKaucQjtECEZaU9mP7VpocB7LwBPjAuxqfZw64r4knwJ8azqUAdUQZrl9icsqnmRd7jmdKZfxqim6/yWMiG6DX3tP/fxstHxGbqSKheWKM+du8WW3wjawZ2JlKeKt38EGvkJCxVB++UFE69A63pRx+3TxSPryctr9rctLNHI9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b=Tfa+BseJ; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1dc13fb0133so7911905ad.3;
        Fri, 08 Mar 2024 08:49:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709916551; x=1710521351;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:dkim-signature:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jQzlRemqcpG/B25dEVwxgd2nqjD2iV1Oc0H8JZ1sMs0=;
        b=SJImZleCZ4u+vh1HgnHtvoziy9mFDANDwgzCjjiU6MM05+PVhdCbsfdrnyydqAE1Hi
         nkQQEKx6KJeT/DnnCrsn7+3tfWdjbyTF0S+NSlomiVDleZrn67Vm6RmE92mzYY8Td/YV
         wbWw/ptSL75AjmuV3jST+P9AbIZA905E3WObU59pq7Do/DtNGlIep/1b8xFxULPHSXzM
         oj6IUou+X9HKGwf5yAZZVZtAzpS53KrouiX0kKh7e0x3IhM55Jgx22Rmir1Qz++C3NFg
         IUaHgx2+CzgrTt5GHUbL2DHIOMB2edy0trCIsoFLepuG639PwMdsqKQN5rz2NL6yihRG
         YB2A==
X-Forwarded-Encrypted: i=1; AJvYcCVdd3M4o4b77uQ76OQhkAkNTQssFYGLqa7dYjoszBusGy9vtTeGIlnyBZla8XtOKFrHWfomX7tRl3MyqxI6tq1myjWo78hcF7guCJ2Jsnl4xeq9SXb5ETzWwaEJBjRfH8XYeYBq8UV9dg==
X-Gm-Message-State: AOJu0YwgIqSGW7dh5TGaVjYiHOf/94fKYIn3Y1X6mV5dXz0j3l/tDR5u
	UqL2Evm7ZGLsYRaMx9MNgezo33SK0S6b8+a1Tg0h0o9oOUaAcVNI
X-Google-Smtp-Source: AGHT+IFWG1EplbtVMvjGJC2PomQuFgrore7TK9HZk0oyPLTXlVX6SwtEk6/eMj9Sjm7MfkAr8kC9ow==
X-Received: by 2002:a17:902:d511:b0:1db:be69:d037 with SMTP id b17-20020a170902d51100b001dbbe69d037mr13299032plg.46.1709916550959;
        Fri, 08 Mar 2024 08:49:10 -0800 (PST)
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id 2-20020a170902c10200b001dd69a072absm1356614pli.178.2024.03.08.08.49.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Mar 2024 08:49:10 -0800 (PST)
Date: Fri, 8 Mar 2024 13:49:04 -0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2024; t=1709916549;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jQzlRemqcpG/B25dEVwxgd2nqjD2iV1Oc0H8JZ1sMs0=;
	b=Tfa+BseJHRha3HkgFzAZDzu7GoxGFFkFq1Rl9HUGs+rlI5IHYOSloTFJQhbg4kBBHJm63d
	2lsM51Wkn+uxJTmhLEG1AsOLybfQ/VLPVS3E2Fg5/aHjvwdW4ShoPBePTDRw+uKYVSChQ1
	lb/Lk92oO+R06frfzA+cXOgiIiCYpwlPUbSdzz8riwN7U296YB7ACBboMGTjmCjlbhgQzp
	EMn2Tt4CZR36eFcTrDmRiKOHs3MXS+8NGoHCnYIhdFT5CF1JiDTIrXIQwDt+s6JJ+ml3Hz
	oqLYg4AdmW0/8ESeMPhEz+mHWVOVu6JrU7U9+TeIHvlOYj+oNxP6JPKCChwg2w==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
From: "Ricardo B. Marliere" <ricardo@marliere.net>
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Harald Freudenberger <freude@linux.ibm.com>, 
	Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 1/6] s390: zcrypt: make zcrypt_class constant
Message-ID: <lznbxodysy66hssioarbe4ugfezri5dwdyuyvsxgfbbqu4h2xc@7wyzf2txq3ua>
References: <20240305-class_cleanup-s390-v1-0-c4ff1ec49ffd@marliere.net>
 <20240305-class_cleanup-s390-v1-1-c4ff1ec49ffd@marliere.net>
 <84263def1d38584cd83558a33bb52f22@linux.ibm.com>
 <nh5d7ock5gb4zttfmq354si3iewm4u2zxqquzg3erl55jxjhuo@5yveroq4li4s>
 <20240308144437.26074-G-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240308144437.26074-G-hca@linux.ibm.com>

Hi Heiko!

On  8 Mar 15:44, Heiko Carstens wrote:
> On Fri, Mar 08, 2024 at 11:38:14AM -0300, Ricardo B. Marliere wrote:
> > > Thanks Ricardo, nice work.
> > > The only thing I would do is to rename the label "out_class_create_failed"
> > > with "out_class_register_failed".
> > 
> > Ah, indeed. Thanks for catching that. I will wait for more feedback on
> > the other patches and send a v2 if required.
> > 
> > > 
> > > Who will pick this patch? As this is part of a bundle of fixes, Richardo
> > > do you have a way to push this into the kernel? Otherwise as the AP/zcrypt
> > > maintainer I would pick only this patch and forward it to the s390
> > > subsystem.
> > 
> > I have no ways of pushing this, sorry. The series is based on
> > s390/linux.git/for-next, so perhaps the s390 maintainers can pick this
> > one along with the others with your Acked-by: provided? :) 
> 
> I will pick up the whole series, but need some more time.
> 
> There is no need to send a v2 for this patch - I'll change the label as
> requested by Harald.

Thank you for this.
-	Ricardo

