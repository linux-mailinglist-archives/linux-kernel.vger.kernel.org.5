Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DE837CEDE4
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 04:15:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232340AbjJSCPm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 22:15:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231950AbjJSCPk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 22:15:40 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7AA1114
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 19:15:38 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1bdf4752c3cso48875695ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 19:15:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1697681738; x=1698286538; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=niLjjAUj5a4EXQp0TXTLkkgUyeeKsYWhUxQ9/gmkyLQ=;
        b=YrmEM+7P8bLZYXWTEqZI87YGvWFOt17nEtPWGaJNohzxGoN+eUKPi7z6LjORDetqsX
         fPmEvmzXAyGmcGbKWTFOWFImGg3o+nF3Nn1ZU5CI1X2UBRFpcurvCnZg3jE0/f2DrtCg
         aiPBBF2op2Ro375zAlobEcwQk9p/lb7T0ch7E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697681738; x=1698286538;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=niLjjAUj5a4EXQp0TXTLkkgUyeeKsYWhUxQ9/gmkyLQ=;
        b=EfdDqE1GD/mtguIN0YXELlzNQ2Fmac5ffTRHh6IEorxP9NoyHZY0wo1Z0soobxtZMR
         EMLpZKC7Eal6QOUg6EzXltjdSAG5gVrohG4TXRzZPOKupEhE02LkCv9MpEHYZcPJ+IAu
         mRRFJUzvFOlVIdsQWSyYBj4Q0GycNoJrfr9yN/HcgzwhFmcFwJ4oprEccxNZky78WJz6
         tNbPVV/A2g+diC8esix3yLH+NhpA7vIwgUxqurC7TXyPB6kyQnEX9g7VHpZE9+rYw7S1
         3VBYvDln3TdQWnBG+DTNRJf+YtnhOIPI+XJYd9Uyh+JUzs3jrQdfOlKHwebjzIgC09EZ
         Lcog==
X-Gm-Message-State: AOJu0Yy47n9ZRQIUssDsNHVOT/ymBEW1f+NFLXrSBwymAgj5+QiFlusC
        ASQmxWa0QPP4EJaV9ECjDeR3yQ==
X-Google-Smtp-Source: AGHT+IGBufB2sRx44xEVb94mH1ssc3le8I0CPEOyROcc2uKW7JkZCh0i1+WbmHF3ddLS0KMnCiP6pQ==
X-Received: by 2002:a17:902:f685:b0:1c8:791c:d797 with SMTP id l5-20020a170902f68500b001c8791cd797mr1168062plg.56.1697681738067;
        Wed, 18 Oct 2023 19:15:38 -0700 (PDT)
Received: from google.com (KD124209175111.ppp-bb.dion.ne.jp. [124.209.175.111])
        by smtp.gmail.com with ESMTPSA id jh1-20020a170903328100b001c9ab91d3d7sm624470plb.37.2023.10.18.19.15.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 19:15:37 -0700 (PDT)
Date:   Thu, 19 Oct 2023 11:15:32 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>,
        Joao Martins <joao.m.martins@oracle.com>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Oscar Salvador <osalvador@suse.de>,
        David Hildenbrand <david@redhat.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        David Rientjes <rientjes@google.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        Barry Song <21cnbao@gmail.com>, Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        Xiongchun Duan <duanxiongchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: Bisected: [PATCH v7 2/8] hugetlb: restructure pool allocations
Message-ID: <20231019021532.GA14965@google.com>
References: <20231006032012.296473-1-mike.kravetz@oracle.com>
 <20231006032012.296473-3-mike.kravetz@oracle.com>
 <20231011064756.GB2866435@google.com>
 <20231018224422.GC5181@monkey>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231018224422.GC5181@monkey>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (23/10/18 15:44), Mike Kravetz wrote:
> Hi Sergey,
> 
> Sorry for the delay.  Not ignoring your report but chasing this in
> another thread.

Hi Mike, no worries.

> https://lore.kernel.org/linux-mm/20231018222003.GA21776@monkey/

Oh, interesting.
I just read the article the other day about some of unexpected optimizations
that clang can do [1].

Setting h to NULL seems to be fixing the problem for me.

> Quick question.
> Are you using LLVM/clang in your builds?

Yes, clang 14.0.6
The kernel compiled with gcc does not BUG_ON().

> My guess is that you are hitting the same issue.  That BUG at mm/hugetlb.c:3180
> should not be checked/executed unless you allocate gigantic hugetlb pages on
> the kernel command line.  Suspect you are not doing this, and loop code is
> being run when it should not.

Looks very similar indeed.

[1] https://research.swtch.com/ub
