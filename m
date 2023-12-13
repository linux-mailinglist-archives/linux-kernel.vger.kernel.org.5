Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB45780FBFF
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 01:10:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377689AbjLMAKU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 19:10:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377647AbjLMAKS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 19:10:18 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7951E83
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 16:10:24 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1d34ae77fbaso60975ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 16:10:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702426224; x=1703031024; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/awqNNuuBVdOMOwDFb7/1nEW8nsApwi+stmH8yh+pvA=;
        b=L2noTP3GJrJzyCfeQ5/yiu5FlEhFHMY2aRSM6xdpXoi1Nz3KvzqwoNQnz4ddzl9ZMF
         LU5FBFswH996Lu84NVJqEnaVxcwrEr4ZG/hzS+eYT6c+izcNucMhRyBNnEi5WsJze+3W
         dvIHde0PUhitl9ZdA1FKFt/alrD3PQDNF8TQusekMinjspgAJ4Jqf1hmPxWCy7r83EIb
         vFR+UtCcb6acwiCzfJmQDpUIIkcDgDT6kGRKbHBh+HctOf7zaukf9kLNnpA9avN6CHnw
         NYrtLpkRD/J4IuHjIFlbq0LZZUar5QbXJWcM3Hx6Ru06bIvO4hJ1mgVpc+j/quXa8YK9
         aNDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702426224; x=1703031024;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/awqNNuuBVdOMOwDFb7/1nEW8nsApwi+stmH8yh+pvA=;
        b=dIci5eBOizW86/4sTVolgPm5+Ve0wK73Wum7VWWKqsK9WnDp5Ds8UwwNNj9fooF56i
         JTgvvXqv8nxf4OW/sv905JeF2kVQfU7SMQkL00gaJY8Lk6fSnOz8WQrGWHLt6HtXazQE
         7HFIYU2dMojyk4JbVBLDCCt2tAcZcUHKLRXYcpsUrfQTVu9sNN8diNnoBFUmAs45KwV5
         pBfY/+QxftGtsGEyaYh05COZawTMTCrmExdyrY7/0BTyrghKMZMTGoB8EDAcWiUSZqSe
         fJ1bm+FrR/vsiDlY/tznDj8dLjmp1cM3cMaAszHWEXtpTnEdH84ZXVyeya9eltWLmxzJ
         yH7Q==
X-Gm-Message-State: AOJu0Yx044XRHadywUP7TxCESm2xOohcurS+EmVtazhwBnJGXx07dkxe
        45XQI5QfC6kYDBO+m0Tap/U0MA==
X-Google-Smtp-Source: AGHT+IGcYgMZfthZW8oEln3UOI7eJLeysSJbN4H/5YvLwIiX4bJrWyLcr2xf3zrBbGW7JFZ5tRClKQ==
X-Received: by 2002:a17:902:d2c2:b0:1d0:c25b:5733 with SMTP id n2-20020a170902d2c200b001d0c25b5733mr973517plc.18.1702426223687;
        Tue, 12 Dec 2023 16:10:23 -0800 (PST)
Received: from [2620:0:1008:15:fc81:e0ce:797b:3b4b] ([2620:0:1008:15:fc81:e0ce:797b:3b4b])
        by smtp.gmail.com with ESMTPSA id h2-20020a170902704200b001d06b63bb98sm9178392plt.71.2023.12.12.16.10.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 16:10:23 -0800 (PST)
Date:   Tue, 12 Dec 2023 16:10:22 -0800 (PST)
From:   David Rientjes <rientjes@google.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>
cc:     Gang Li <gang.li@linux.dev>, David Hildenbrand <david@redhat.com>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, ligang.bdlg@bytedance.com
Subject: Re: [RFC PATCH v2 0/5] hugetlb: parallelize hugetlb page init on
 boot
In-Reply-To: <20231212230813.GB7043@monkey>
Message-ID: <55c6c1f6-0792-61c3-86ed-4729d4a3fdf5@google.com>
References: <20231208025240.4744-1-gang.li@linux.dev> <996ba32c-78f0-1807-5e64-af5841a820e7@google.com> <20231212230813.GB7043@monkey>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Dec 2023, Mike Kravetz wrote:

> On 12/12/23 14:14, David Rientjes wrote:
> > On Fri, 8 Dec 2023, Gang Li wrote:
> > 
> > > Hi all, hugetlb init parallelization has now been updated to v2.
> > > 
> > > To David Hildenbrand: padata multithread utilities has been used to reduce
> > > code complexity.
> > > 
> > > To David Rientjes: The patch for measuring time will be separately included
> > > in the reply. Please test during your free time, thanks.
> > > 
> > 
> > I'd love to, but what kernel is this based on?  :)  I can't get this to 
> > apply to any kernels that I have recently benchmarked with.
> 
> I was able to apply and build on top of v6.7-rc5.
> 
> Gang Li,
> Since hugetlb now depends on CONFIG_PADATA, the Kconfig file should be
> updated to reflect this.

Gotcha, thanks.

I got this:

ld: error: undefined symbol: padata_do_multithreaded
referenced by hugetlb.c:3470 (./mm/hugetlb.c:3470)
              vmlinux.o:(gather_bootmem_prealloc)
referenced by hugetlb.c:3592 (./mm/hugetlb.c:3592)
              vmlinux.o:(hugetlb_hstate_alloc_pages_non_gigantic)
referenced by hugetlb.c:3599 (./mm/hugetlb.c:3599)
              vmlinux.o:(hugetlb_hstate_alloc_pages_non_gigantic)

So, yeah we need to enable DEFERRED_STRUCT_PAGE_INIT for this to build.

On 6.6 I measured "hugepagesz=1G hugepages=11776" on as 12TB host to be 
77s this time around.

A latest Linus build with this patch set does not boot successfully, so 
I'll need to look into that and try to capture the failure.  Not sure if 
it's related to this patch or the latest Linus build in general.
