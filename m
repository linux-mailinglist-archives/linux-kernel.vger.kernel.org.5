Return-Path: <linux-kernel+bounces-22652-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03A1B82A0F4
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 20:19:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5B44286255
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 19:19:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ACA94EB28;
	Wed, 10 Jan 2024 19:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WL8MLbSs"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 458DE4E1DD;
	Wed, 10 Jan 2024 19:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-50ea9e189ebso4828643e87.3;
        Wed, 10 Jan 2024 11:19:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704914367; x=1705519167; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=t5cVSTgOAWnoOzaFpiCIURaVM+zGpRmlLYF3NdjWZwk=;
        b=WL8MLbSsCEw2gnjjZyQGWXfjHXxTLczLT/pGc1ygAhkY5vc7QA35+PWSJS9RUNkmr4
         odKHdL8xqPosZ15DhvdQMIClie3RMCqFb9k26Y1ZWUlk+dl1fOB8I/JeMlhJYur/N1yR
         kH0YSlk2pYflkwtw0YGkCqYQ/YzvRbDcPGEuIv9ng8nFHJr44UVi/iDU+rGpZhhC9F8q
         f/x9HIc+bMfjpX/ZCbxyXD7V5+owf5WU7eNyz5beubAF3hIgf5aNWWHxMLJ32ORFcAIp
         Mj0JaGr4h9WdEmaWaSB0Q0fDpEYZoc7IY4AFnep3CI6GyIEKMdOPq36HsJSe2U1vVTOp
         yslw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704914367; x=1705519167;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t5cVSTgOAWnoOzaFpiCIURaVM+zGpRmlLYF3NdjWZwk=;
        b=u8TWdR67Ass09v+XJbhHWVS7o+gcETAczR/HVQgxCsQVlleTbqo2RA2pZa7jBj+aPT
         rC8bxqcvbv+jiTn6D/JwhOjllWo4+0pCEOLvbnDXbJhobKLdnlXquL1FOMEYniEJ51G2
         3xxkFyH5+HupY6q3AmNrlUr1eV8Vn6wFO4Dsd2UVuEppz7k1zwnmoUnsK5HMimrhuGxu
         83SrmIdc21pHT8LKrMkoPOAdENjv+XArmwBnEYqG5uzjJHBSc1d48853XxTay+PYwM1n
         PGSLeKMuLhx5p1e9NJtXyZBaLZM09cSFI08u3Yd4esRioZB7MaLAYl6MNFmNvWBxxV9F
         Ftig==
X-Gm-Message-State: AOJu0YyhoS8WCMsaXbatUHP2zxOOclH6doM7QIkINPJKaCoFpfvat58L
	LmMwHV7+UVhzk18+zMf4JcU=
X-Google-Smtp-Source: AGHT+IEpPIA3bQflt6grfxy3W8FpVlnhz6kj9XieH8DbDol9R5vip+tGCp6qYJ+pIwTKQ47N+8X4vg==
X-Received: by 2002:a19:ae04:0:b0:50e:d3dc:264f with SMTP id f4-20020a19ae04000000b0050ed3dc264fmr545169lfc.87.1704914366968;
        Wed, 10 Jan 2024 11:19:26 -0800 (PST)
Received: from andrea ([31.189.29.12])
        by smtp.gmail.com with ESMTPSA id gl16-20020a170906e0d000b00a28bf7969cdsm2360182ejb.180.2024.01.10.11.19.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jan 2024 11:19:26 -0800 (PST)
Date: Wed, 10 Jan 2024 20:19:21 +0100
From: Andrea Parri <parri.andrea@gmail.com>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
	mathieu.desnoyers@efficios.com, paulmck@kernel.org, corbet@lwn.net,
	mmaas@google.com, hboehm@google.com, striker@us.ibm.com,
	charlie@rivosinc.com, rehn@rivosinc.com,
	linux-riscv@lists.infradead.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/4] membarrier: Create
 Documentation/scheduler/membarrier.rst
Message-ID: <ZZ7tud+yKHgptGos@andrea>
References: <20240110145533.60234-1-parri.andrea@gmail.com>
 <20240110145533.60234-3-parri.andrea@gmail.com>
 <63046420-264a-4e7c-b45c-17f0486ba4d9@infradead.org>
 <ZZ7qiIDFDEMEfNiS@andrea>
 <a759c808-a14c-4370-b47a-7db908fa3127@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a759c808-a14c-4370-b47a-7db908fa3127@infradead.org>

> > Mmh, unless I get a better idea, I'll expand those occurrences to:
> > 
> >   "The commands MEMBARRIER_CMD_PRIVATE_EXPEDITED and MEMBARRIER_CMD_GLOBAL_EXPEDIDED
> >    require [...]"
>                                                                             _EXPEDITED

Oops. :-|  Thanks.

  Andrea

