Return-Path: <linux-kernel+bounces-37535-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE33E83B15E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 19:44:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B12C1F21C22
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 18:44:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DCB813174D;
	Wed, 24 Jan 2024 18:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b2XCrRu8"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 541738002E;
	Wed, 24 Jan 2024 18:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706121866; cv=none; b=vCGRpdK4EkXivcCDOXrjJiDu/mrHSVBQ9D95l2hvmGDL8q6ekeMSigQHlLq8g/TVfEj/K5lEZ0UgMshso2r1BKsixD0RbN+NqN8JIx7prlhQu6jvN6GnsJLtBDdZN7lCjqoMKUWJwq0smsp1OsJqowW0m66hkhhlbBwMGPp3EBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706121866; c=relaxed/simple;
	bh=oFA54oYHb3NBKTrc3qXkHGy/1hhpChhcaRdit+EJ/1k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DpJ0A7HgxiCVZzfMV/ckHlpZyVcggaY7uPdEok6FbzJ6bBCZkzahyjNXiKwV30NTQv23P5J/ORSyiDQpianHl/3qdeWhK0Ubl//UC4EoipzQRqgkmaeoTaEntgmWjhveaF5KH+TvrfLB/m9/HD6cvvtcK3SEqk3vzxbG8Cbal1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b2XCrRu8; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a3150c9568bso45104566b.1;
        Wed, 24 Jan 2024 10:44:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706121863; x=1706726663; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9ZKG+8C20f7hivz53jJBSHChuZfiFBOGPLHSUtSSkGc=;
        b=b2XCrRu8nsr+SNNbfEeVLEZi1brAAJ2Q3E2uwT66EY3gU5DKg/G3t7MJ0Xbt/K9zdK
         lXOznfnCDLWK/3kLqohwZ4a4+HxvgGYR2BWsqw84owKbadLBFxi7H99JfenPT1xEKhhA
         xM82SufQ/OlhgY45MruUUd1ccYvyLPISM/qAjUCB7bcu8C0V2KhFoeIKkIaYF9f90p7i
         IT+FzYoIhn/8YEiZ21sTDEMQy+Dkoy0e78UghVDZUGUSVm1QmzafMNd+IchH9JfhVkIX
         b10+WrgQxskDduaWvlNtMDAmfTCKL7Ha3PCHBl4HthVQtY8B6uajuH2bbZqp+TuwYgjT
         NYKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706121863; x=1706726663;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9ZKG+8C20f7hivz53jJBSHChuZfiFBOGPLHSUtSSkGc=;
        b=kyJYjy2R3E5Y4lcN/r8KH/kKOba5RAvMj0BwLTChYG8cA3NuDkXzW/ScFFCY8RKRZL
         MLlKzrN6JEDOjv+M8bR8Za+8ne+YUtLhVMdZO+Zyr+BVY3GUD/aKFCIRM02fHhSU46dN
         8blOtKXBn4OxjWezOD9O3+EgoK1Vkt3k565EncFLbSS5pBXOyzr6kEzsR/P/vUs0/ljM
         8FZOv4c0l9tLOvj6S75+Z5NevHNX8exYAjSBylVGj0mzrGguRujv/japEtVJqF8ygGbb
         R6sMhjXlc8nV2XJIC80i3YZoAwOvIsNlTwgazhaGbSMJlLV2cN8os4RnjcSpK1YX20Ys
         O6Dg==
X-Gm-Message-State: AOJu0YwRBXeCrANw9ithDds5qqd17DYEvZIxShjvrWHbSsVsBk+7UcS+
	hLFv5YdzatKPoOLtxa0UiHK74aLWtDK1CVUZ15Azp3AzMBdaUTAc
X-Google-Smtp-Source: AGHT+IEIWgR+2ylkPSWyye/s+x95/46mpCMI5+6fb9Wr5V2XtmpeW8QsUJFkC7/0P9SsQVxcUlIiCA==
X-Received: by 2002:a17:907:d402:b0:a2f:c8f5:f706 with SMTP id vi2-20020a170907d40200b00a2fc8f5f706mr983785ejc.232.1706121863206;
        Wed, 24 Jan 2024 10:44:23 -0800 (PST)
Received: from andrea ([31.189.8.91])
        by smtp.gmail.com with ESMTPSA id qo4-20020a170907874400b00a2689e28445sm151657ejc.106.2024.01.24.10.44.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 10:44:22 -0800 (PST)
Date: Wed, 24 Jan 2024 19:44:20 +0100
From: Andrea Parri <parri.andrea@gmail.com>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
	paulmck@kernel.org, corbet@lwn.net, mmaas@google.com,
	hboehm@google.com, striker@us.ibm.com, charlie@rivosinc.com,
	rehn@rivosinc.com, linux-riscv@lists.infradead.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/4] membarrier: riscv: Provide core serializing
 command
Message-ID: <ZbFahHxi5laA6CbI@andrea>
References: <20240110145533.60234-1-parri.andrea@gmail.com>
 <20240110145533.60234-5-parri.andrea@gmail.com>
 <aabea058-0088-41bb-822a-402669f348bb@efficios.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aabea058-0088-41bb-822a-402669f348bb@efficios.com>

> > +# riscv uses xRET as return from interrupt and to return to user-space.
> > +#
> > +# Given that xRET is not core serializing, we rely on FENCE.I for providing
> > +# core serialization:
> > +#
> > +#  - by calling sync_core_before_usermode() on return from interrupt (cf.
> > +#    ipi_sync_core()),
> > +#
> > +#  - via switch_mm() and sync_core_before_usermode() (respectively, for
> > +#    uthread->uthread and kthread->uthread transitions) to go back to
> > +#    user-space.
> 
> I don't quite get the meaning of the sentence above. There seems to be a
> missing marker before "to go back".

Let's see.  Without the round brackets, the last part becomes:

  - via switch_mm() and sync_core_before_usermode() to go back to
    user-space.

This is indeed what I meant to say.  What am I missing?

  Andrea

