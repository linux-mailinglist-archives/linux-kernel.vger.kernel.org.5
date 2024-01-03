Return-Path: <linux-kernel+bounces-15052-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 00B828226AF
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 02:53:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 29ACCB21068
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 01:53:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C083F4A1C;
	Wed,  3 Jan 2024 01:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="crm+aD/M"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF5B4468C
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 01:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1d47fae33e0so73115ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jan 2024 17:52:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704246775; x=1704851575; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=9EZuImka5YRzZke3ZlhRWW36OaCkie43Uhpr5ROyDyE=;
        b=crm+aD/M9D2jbUs0mufpN3Miu1X3PwKa8AWPbtLxtKCyzhNyMKZuhn/z5+Vr06BRW7
         FJDinhMGM0KDaPInrSsOjNZoFapNWjHdxcuCmaS/hVtJMG27XLLSVDcoR8Vyr8nTm2mV
         Fjr7zk2X8JG4BN+u3AIys+GkhDi0Cpdar+H9USPLXUGkHoHddlGNid1CFc/5TrkU/+w6
         QfshoziZDuGsXtUN6msF4oG2eMi1KrpqdDK4KrJ7MOf3NZy+MtmuyFv+TwDYcS84LNRG
         CnJVuJzbtoEuZSn27dO3InUwzOiu8GU4Qahwx+AI3UNiu2KWM3DMVmXE4JwM2iOZ1kLh
         oDlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704246775; x=1704851575;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9EZuImka5YRzZke3ZlhRWW36OaCkie43Uhpr5ROyDyE=;
        b=M6P6JJmW/XRF7qxv3auGA4nULOUtwGcxw2ry1SPDgU/LL3/suiqaTie05xm/quhCzH
         bXg0ewo/3ZMDZw64KZgWczRrl11iyB3W2QRxlWWe/9LCNt7+PDZKPZkyZLlKmdeJnbMv
         MHeGchVlHyl6DkIbMmfYYJWayLvpgpMYi6lb7GfhJles06gJcpcZptCXKuhfC1hUesRS
         Ok6YoAU3YAoc5J8cPBYlYe0HlAOAiEAv+usZ2ASjN5W4MBBg29nAPToGZtCosBCp3EHW
         Wi+IuQ4OAHRfPpyc8fUur49jiDSckpNpvlOhAjPHi7xLLhVIJNIt/NkttrH9x/dLu/wC
         JjIA==
X-Gm-Message-State: AOJu0YwIGU9oOaWFLuppQ+hrt5fYk4IBCV8gS4xIUM8lVEcjGIWpTjnp
	ygymwOlab+Run/G2S0ltgl+8pEmry+5O
X-Google-Smtp-Source: AGHT+IFBMbIPwvwHQWt67pApon40peNGM8MP0vJQu5XBJVjX/jKeI2Jwu/rTVR13REHFhBno8Yu1+A==
X-Received: by 2002:a17:902:dad1:b0:1d0:9fc7:6bdb with SMTP id q17-20020a170902dad100b001d09fc76bdbmr84674plx.0.1704246774807;
        Tue, 02 Jan 2024 17:52:54 -0800 (PST)
Received: from [2620:0:1008:15:c73b:7876:89ec:9102] ([2620:0:1008:15:c73b:7876:89ec:9102])
        by smtp.gmail.com with ESMTPSA id r29-20020aa79edd000000b006d9c65cc854sm14458398pfq.26.2024.01.02.17.52.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jan 2024 17:52:54 -0800 (PST)
Date: Tue, 2 Jan 2024 17:52:53 -0800 (PST)
From: David Rientjes <rientjes@google.com>
To: Gang Li <gang.li@linux.dev>
cc: David Hildenbrand <david@redhat.com>, 
    Mike Kravetz <mike.kravetz@oracle.com>, 
    Muchun Song <muchun.song@linux.dev>, 
    Andrew Morton <akpm@linux-foundation.org>, 
    Tim Chen <tim.c.chen@linux.intel.com>, linux-mm@kvack.org, 
    linux-kernel@vger.kernel.org, ligang.bdlg@bytedance.com
Subject: Re: [PATCH v3 0/7] hugetlb: parallelize hugetlb page init on boot
In-Reply-To: <20240102131249.76622-1-gang.li@linux.dev>
Message-ID: <5c30a825-b588-e3a9-83db-f8eef4cb9012@google.com>
References: <20240102131249.76622-1-gang.li@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 2 Jan 2024, Gang Li wrote:

> Hi all, hugetlb init parallelization has now been updated to v3.
> 
> This series is tested on next-20240102 and can not be applied to v6.7-rc8.
> 
> Update Summary:
> - Select CONFIG_PADATA as we use padata_do_multithreaded
> - Fix a race condition in h->next_nid_to_alloc
> - Fix local variable initialization issues
> - Remove RFC tag
> 
> Thanks to the testing by David Rientjes, we now know that this patch reduce
> hugetlb 1G initialization time from 77s to 18.3s on a 12T machine[4].
> 
> # Introduction
> Hugetlb initialization during boot takes up a considerable amount of time.
> For instance, on a 2TB system, initializing 1,800 1GB huge pages takes 1-2
> seconds out of 10 seconds. Initializing 11,776 1GB pages on a 12TB Intel
> host takes more than 1 minute[1]. This is a noteworthy figure.
> 
> Inspired by [2] and [3], hugetlb initialization can also be accelerated
> through parallelization. Kernel already has infrastructure like
> padata_do_multithreaded, this patch uses it to achieve effective results
> by minimal modifications.
> 
> [1] https://lore.kernel.org/all/783f8bac-55b8-5b95-eb6a-11a583675000@google.com/
> [2] https://lore.kernel.org/all/20200527173608.2885243-1-daniel.m.jordan@oracle.com/
> [3] https://lore.kernel.org/all/20230906112605.2286994-1-usama.arif@bytedance.com/
> [4] https://lore.kernel.org/all/76becfc1-e609-e3e8-2966-4053143170b6@google.com/
> 
> # Test result
>         test          no patch(ms)   patched(ms)   saved   
>  ------------------- -------------- ------------- -------- 
>   256c2t(4 node) 1G           4745          2024   57.34%
>   128c1t(2 node) 1G           3358          1712   49.02%
>       12t        1G          77000         18300   76.23%
> 
>   256c2t(4 node) 2M           3336          1051   68.52%
>   128c1t(2 node) 2M           1943           716   63.15%
> 

I tested 1GB hugetlb on a smaller AMD host with the following:

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -3301,7 +3301,7 @@ int alloc_bootmem_huge_page(struct hstate *h, int nid)
 int __alloc_bootmem_huge_page(struct hstate *h, int nid)
 {
        struct huge_bootmem_page *m = NULL; /* initialize for clang */
-       int nr_nodes, node;
+       int nr_nodes, node = nid;
 
        /* do node specific alloc */
        if (nid != NUMA_NO_NODE) {

After the build error is fixed, feel free to add:

	Tested-by: David Rientjes <rientjes@google.com>

to each patch.  I think Andrew will probably take a build fix up as a
delta on top of patch 4 rather than sending a whole new series unless
there is other feedback that you receive.

