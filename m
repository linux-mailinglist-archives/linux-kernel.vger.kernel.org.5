Return-Path: <linux-kernel+bounces-147674-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 869B58A7790
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 00:11:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 410F5284789
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 22:11:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99DB41386D6;
	Tue, 16 Apr 2024 22:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S4ru7LsF"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85864137929;
	Tue, 16 Apr 2024 22:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713305490; cv=none; b=gJGX287f8XzSU1A5+9Jh/m1ktTOJCLKYUuTX0X4WREDI/zR2NV/T4ViQv8UMvy+8PcMqjwXVOB60TOTaTb5CC45LGvXZzBaAJSfuI8Bz9fj3fq5Bt+qlkyvzSU8uZThjndTRwidR5UEzfe/+TnvIhflS7qZC7uYOaBrqNYO8EYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713305490; c=relaxed/simple;
	bh=mDdK5vMC8I6b1Vc9V/T8fYNEtDgXWHi+/xh3aGmHsvQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cJcNnfc+rIrd8kCCxY4A7xFFogZqsPEYbDzQoGlAhsLYzBqguDSJBvMc7JQYOcHEgd+glEUkEQuYFOJ270+DmPwl2xOuq2yMFIXtcEf5gzaGqOjjE0ye6EpoSPKakYX78qV3PBPUxgy/7qdCZydZHcS0F082x/gcx3KlzEHQ4KI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S4ru7LsF; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-6ead4093f85so4133057b3a.3;
        Tue, 16 Apr 2024 15:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713305489; x=1713910289; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oIj8WgMRKHee4tuvtSr9tO4cl4nz8ULKjFmAAJ/tVQA=;
        b=S4ru7LsFcan6BftuHbCuMzkBVYAu9KbNUSGQxet/7clS1I3GmTxx//keYsQmJ8AAUn
         zod4hrKNVTXnWnV7/L7ZEKyOIJ0BkBbK/mBOxNU2WpSECJXl9t7MoraEyy52b/szmxqX
         XYJZIlla9TaX+MdtVGM7UwTi/C4ElwDvQOpsg8jg5CwyvW5k6eVhE1gAlfCCOnJDkHvB
         0B5MKUAvJiSbjr3J6m8MoDy7bNNWuaOs69eKaqHBmMhhLoVeEebAPq3Lcgx+gRIMduKo
         hUIbQc3loJgybxp7tu+PqdUkjVC1qisyJAendN6TW+XdP5mxBHX7yFcQMwYsJVJPhY34
         SOJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713305489; x=1713910289;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oIj8WgMRKHee4tuvtSr9tO4cl4nz8ULKjFmAAJ/tVQA=;
        b=W7XidrYqHbOZ7neyEPWjS3n5juVlgAK6qJt7yHIZyfxKaJQtk3/LmJOXuzWVjfwiJ/
         ItneehhAGDI3me+WBZmbRErCckbqES4uOz7a1htlvZAjxgWukgvZt57QHtwMs64NqeoI
         rVWLHRO8DO6RRtQ1Iko+hf5KQK38dMRy97U6Xb2UcJXGWpkhK4n+Zvc+7/UyUCzyRXZh
         2NjlHCifU099agtXZbXo45kKoYs1eUlxpbdJ8x3DtHCCd/tVIhcEZQCgEQB4DH4Za95B
         16+DYKr1TZl43g1lGwifaB7CfbdA5KOoADE3+HRp0jlTE1ZyNriSh/ZDKI07TyUAC2jV
         auGw==
X-Forwarded-Encrypted: i=1; AJvYcCXuCXKN0R41oSkljTb7XSciRpXNHIW+2BotrxH4102Crjopb7aZ9hKSSFX192ltrlhjgHOblAv0AYcqfoQQfyt9nFkhrm//JZ9SqhvZF3AUrRaPhtaG3Wwqsf67DtVyTWdN9HwUC4rZwA==
X-Gm-Message-State: AOJu0Yy1E6h3PmqFVpP13NJY7k/KITSihYXD2g7M6R98qM63fS9gjjU+
	H4i/+SOmtc2BG1a1aC/ETbSuaSrDKTTFzI77rxe6uWbKuabxASaucopGalAo
X-Google-Smtp-Source: AGHT+IETmlw6sGQ9gPTD1OC4hTBPHl7RMK9F8C9YsvPcEg1+h/+RkGIBfBAB0KNOxlpcYZmq9/4jOA==
X-Received: by 2002:a05:6a00:9391:b0:6ea:ed70:46b4 with SMTP id ka17-20020a056a00939100b006eaed7046b4mr13464311pfb.29.1713305488766;
        Tue, 16 Apr 2024 15:11:28 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:6f51])
        by smtp.gmail.com with ESMTPSA id gh8-20020a056a00638800b006e6b989514bsm9437543pfb.60.2024.04.16.15.11.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 15:11:28 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Tue, 16 Apr 2024 12:11:27 -1000
From: Tejun Heo <tj@kernel.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Jesper Dangaard Brouer <hawk@kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: Signed-off-by missing for commit in the cgroup tree
Message-ID: <Zh73j0NFns7vciVi@slm.duckdns.org>
References: <20240417075803.2dcaabb0@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240417075803.2dcaabb0@canb.auug.org.au>

On Wed, Apr 17, 2024 at 07:58:03AM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> Commit
> 
>   669ef339bbf9 ("cgroup/rstat: add cgroup_rstat_lock helpers and tracepoints")
> 
> is missing a Signed-off-by from its author.
> 
> Actually, is just has a typo "Signes-off-by".

Ah, thanks for pointing that out. Fixed.

Thanks.

-- 
tejun

