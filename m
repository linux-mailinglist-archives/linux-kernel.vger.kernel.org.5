Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B9AB7DF70C
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 16:51:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376977AbjKBPvG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 11:51:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377052AbjKBPvC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 11:51:02 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 979E3182
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 08:50:43 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id d75a77b69052e-41cd52c51abso5447721cf.2
        for <linux-kernel@vger.kernel.org>; Thu, 02 Nov 2023 08:50:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1698940242; x=1699545042; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1wB7K/cyK7ekdFksdqw2ZnrHbBqOSSiCpIC9jyTtwpo=;
        b=HnPsTwndmznOfFuVOWXHx8ct/WrvBsPK5x/xLIx5VeUKtyb62e+cXmBq3CiPuVdLjN
         a2jpmZFUz/l+eCljwhEANCYRD36X2YtOA10ZRrpxipMD5rta6iiEh1nPAeg6557YEGDf
         7IW5o8OhO/mIuevLjUaz7bfhXTP+ej6/fn2pWFSvuBpwP1QOojfV0G0fD3d01PJUdPUV
         LvRGJHkEoo+Lnw53MAhNEYaxQxi/3pb3Ar78Q0ZstWFEzAEqDQVawsWQS2r42rT2mexC
         PDQUPO4R2WSiFFVWcUrxTKxLuDEQGuKt8Z2hTAggmQlUvTBWKuAqT1PWYEU51+5iiT1b
         MYVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698940242; x=1699545042;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1wB7K/cyK7ekdFksdqw2ZnrHbBqOSSiCpIC9jyTtwpo=;
        b=Cg2ZynUwJ/kzhKw26QrkEJf48wUKVg4tDrBWrtU1tbZx+wNJBFWgatlF6WFEtIzLTR
         prS/REdqvCLxs0LAflWjfbYbZfymzHn66F2IUbeqTFq1zyQrNAbNUw0e/NbHzQOm4NJe
         Kx+N8JtLM05wSdr/oWRB8GcWsK4DButCjRWnAichGuv70uWVXzjLxcVtxg0OZ5SsSTQF
         1eYvWqYzqsmkPMadflpDSWCj9Iflnh7aNJaG9YOMbvwv3ySJeAhczCw5Rw2qUE0NJA2U
         CgEXU9ANkdXH0fgxEjPgjHzEirH2NCj4K66l69imJ9FmpOv7/g6FyrFP5J1hkvemn2yD
         JNNg==
X-Gm-Message-State: AOJu0YzNyrp1XR7qpz42ef1gXS6EoZBlWAVc1ebuq6kTwjsAAQd+z72U
        9CgqtAM8ZOCrwnLiK0O2AX+JqoYKn3ZhMSo3WRf+wQ==
X-Google-Smtp-Source: AGHT+IGeKyqz4S48dOlmrzV0IcLt/Pz5O88FAxRlS/vj9uMFuB0NwFTsg8gf0j3/eylhtue3lIsgsrkZbl6P7Iv8sPE=
X-Received: by 2002:ac8:5f06:0:b0:418:797:20b6 with SMTP id
 x6-20020ac85f06000000b00418079720b6mr19045388qta.5.1698940242486; Thu, 02 Nov
 2023 08:50:42 -0700 (PDT)
MIME-Version: 1.0
References: <20231101230816.1459373-1-souravpanda@google.com>
 <20231101230816.1459373-2-souravpanda@google.com> <CAAPL-u_enAt7f9XUpwYNKkCOxz2uPbMrnE2RsoDFRcKwZdnRFQ@mail.gmail.com>
 <CA+CK2bC3rSGOoT9p_VmWMT8PBWYbp7Jo7Tp2FffGrJp-hX9xCg@mail.gmail.com>
 <CAAPL-u-4D5YKuVOsyfpDUR+PbaA3MOJmNtznS77bposQSNPjnA@mail.gmail.com> <1e99ff39-b1cf-48b8-8b6d-ba5391e00db5@redhat.com>
In-Reply-To: <1e99ff39-b1cf-48b8-8b6d-ba5391e00db5@redhat.com>
From:   Pasha Tatashin <pasha.tatashin@soleen.com>
Date:   Thu, 2 Nov 2023 11:50:05 -0400
Message-ID: <CA+CK2bDo6an35R8Nu-d99pbNQMEAw_t0yUm0Q+mJNwOJ1EdqQg@mail.gmail.com>
Subject: Re: [PATCH v5 1/1] mm: report per-page metadata information
To:     David Hildenbrand <david@redhat.com>
Cc:     Wei Xu <weixugc@google.com>, Sourav Panda <souravpanda@google.com>,
        corbet@lwn.net, gregkh@linuxfoundation.org, rafael@kernel.org,
        akpm@linux-foundation.org, mike.kravetz@oracle.com,
        muchun.song@linux.dev, rppt@kernel.org, rdunlap@infradead.org,
        chenlinxuan@uniontech.com, yang.yang29@zte.com.cn,
        tomas.mudrunka@gmail.com, bhelgaas@google.com, ivan@cloudflare.com,
        yosryahmed@google.com, hannes@cmpxchg.org, shakeelb@google.com,
        kirill.shutemov@linux.intel.com, wangkefeng.wang@huawei.com,
        adobriyan@gmail.com, vbabka@suse.cz, Liam.Howlett@oracle.com,
        surenb@google.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-mm@kvack.org, willy@infradead.org,
        Greg Thelen <gthelen@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > Adding reserved memory to MemTotal is a cleaner approach IMO as well.
> > But it changes the semantics of MemTotal, which may have compatibility
> > issues.
>
> I object.

Could you please elaborate what you object (and why): you object that
it will have compatibility issues, or  you object to include memblock
reserves into MemTotal?

Thanks,
Pasha
