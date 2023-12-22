Return-Path: <linux-kernel+bounces-9315-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E4FF581C3F4
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 05:33:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3E352867A3
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 04:33:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D7B0568B;
	Fri, 22 Dec 2023 04:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1K120uFY"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D20153A4
	for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 04:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1d3e4637853so92905ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 20:33:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1703219621; x=1703824421; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=GA0LF+TH67vOM4P5TpVaVyEWXV6dMRzuEiBhEutJCz0=;
        b=1K120uFYWBLETflhPjeRest3UoQQ5lsdzyJ0AyUGIbBiC+vLnuCTT83/+Qwx9hfppL
         UXsxpfnmQxqTF5lKB846bt1qOcwVkTeUsLLAjK7g5naUHtFl0CubFjE9yDcbQ47SRY0a
         Zjm8krED34MWvT53vjMd/R1HqGZ/f/0KXiF5cutFkt09TOZEGJe/NuFeEIs7uExlT5XS
         jnWrnPJ+bRdhSVFx8o5nZ/2eSiXQrpjY98y4bh/v2mKQfAT2iHpEoFTUOYolZIaLmXKJ
         VwQPCLeuzC6ZYCyJyE/87TwUYb/M+bN2j3G95kzn7hoNl1GcG6evy1zoGGpxeQ/NHfPi
         DE2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703219621; x=1703824421;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GA0LF+TH67vOM4P5TpVaVyEWXV6dMRzuEiBhEutJCz0=;
        b=EWVnScuc8Hw5+71VPTnBOPR1aygMr5ZmFyPTCFSQy0o1S1GCacj7BGBDmhXV028HU8
         2dJDUVHERY6rxcfND9fDm7kBOgPMo3wc+TF+WAa8n0cvnpqx7GecDags/HHeE/0IArKX
         OBd2uAuiqzsNj7TXd8BJoB+TzVLtEw5zlfmDAm9pX6jci/o4COhGmfkLghbM+1VuIJjj
         rPNs5SxpmjjwFQEr5248QpQjbrtLliYx7GQn4aFfiPlnFM2w9DY5uJlEuUHCMj48eB+o
         5Yv2O5ExDEH6QrMUgqhiy3gWD+SFdIiexujph275btDRi1/CTbHSdjJMZM17h+S4N0xr
         617Q==
X-Gm-Message-State: AOJu0Yw/2e1hmS2D8FfzbC5udQu7PEdfjzELiwkLtjP9y6iyNpRCKCUd
	u/qZGHMRkYdPfg+3GEPwmCJnm7sZCXtF
X-Google-Smtp-Source: AGHT+IF59iV03cmnoQfQU9deMi9peyv62zV3m/O+RgYi5B5ku1UmnZcmZNsuRl3TOFw43MhyceyCQw==
X-Received: by 2002:a17:902:e5cb:b0:1d3:ce75:a696 with SMTP id u11-20020a170902e5cb00b001d3ce75a696mr57154plf.5.1703219621002;
        Thu, 21 Dec 2023 20:33:41 -0800 (PST)
Received: from [2620:0:1008:15:184:1476:510:6ea1] ([2620:0:1008:15:184:1476:510:6ea1])
        by smtp.gmail.com with ESMTPSA id a3-20020a17090abe0300b0028bc09a5e1fsm2613387pjs.12.2023.12.21.20.33.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Dec 2023 20:33:40 -0800 (PST)
Date: Thu, 21 Dec 2023 20:33:39 -0800 (PST)
From: David Rientjes <rientjes@google.com>
To: Gang Li <ligang.bdlg@bytedance.com>
cc: Mike Kravetz <mike.kravetz@oracle.com>, Gang Li <gang.li@linux.dev>, 
    David Hildenbrand <david@redhat.com>, Muchun Song <muchun.song@linux.dev>, 
    Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
    linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 0/5] hugetlb: parallelize hugetlb page init on
 boot
In-Reply-To: <46bc7aa3-4b08-4e5f-9563-485ee17e2785@bytedance.com>
Message-ID: <4c6de257-ebb4-e9ad-4092-b81a8039aff4@google.com>
References: <20231208025240.4744-1-gang.li@linux.dev> <996ba32c-78f0-1807-5e64-af5841a820e7@google.com> <20231212230813.GB7043@monkey> <55c6c1f6-0792-61c3-86ed-4729d4a3fdf5@google.com> <46bc7aa3-4b08-4e5f-9563-485ee17e2785@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 18 Dec 2023, Gang Li wrote:

> Hi,
> 
> On 2023/12/13 08:10, David Rientjes wrote:
> > On 6.6 I measured "hugepagesz=1G hugepages=11776" on as 12TB host to be
> > 77s this time around.
> 
> Thanks for your test! Is this the total kernel boot time, or just the
> hugetlb initialization time?
> 

Ah, sorry for not being specific.  It's just the hugetlb preallocation of 
11776 1GB hugetlb pages, total boot takes a few more minutes.

> > A latest Linus build with this patch set does not boot successfully, so
> 
> Which branch/tag is it compiled on?
> I test this patch on v6.7-rc4 and next-20231130.
> 

It was the latest Linus tip of tree.  I'll continue to try again until I 
get a successful boot and report back, serial console won't be possible 
for unrelated reasons.

