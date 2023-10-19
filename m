Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7352C7CFEF9
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 18:02:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346461AbjJSQCF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 12:02:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346499AbjJSQCC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 12:02:02 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFD50138
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 09:01:56 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id 3f1490d57ef6-d9a4c0d89f7so9454533276.1
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 09:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697731316; x=1698336116; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QAEbVxck7NIMOPFoyufkI7+poSNQZD0kt5lDnU1GmDY=;
        b=wWcQIDL39rUsqDiUSrhQesgnzs++1sOmT2AoGZrzDEHpC54Xf4PF5W+6I54F8wl48j
         vSBv6uBvlD8ph/3X/5lBMzExPF1JTS6nrfITdCQVZMyhTt3j/e/yvchiZCBj6vdyaDPh
         XYejc/h1rMFyc//XMgw9foepsVhh4rqBS0xBYFcRpBxfpvOMUMqxtireJdDFfdwPCY/Z
         MoOFXj4BBDkybxTC6R56DbyCACXUSEyXfC7wV2tT7ONbfS9mlowZgk3PRz4a42s4Adh7
         5SP/xuJ3oQmuiqU2qzrRpWB675P9oMtGRiv+HsZK83dsq76fWpRFoyJDLXSe8EKvpMQZ
         5f4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697731316; x=1698336116;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QAEbVxck7NIMOPFoyufkI7+poSNQZD0kt5lDnU1GmDY=;
        b=d2a/SN5gzgMkCeIR0gqHk6uoNVuyGK53F61WaWdZi8qB2GZka99T7EVNJ7eCPkSF1X
         tMeVkCuEdpNtUhMplY4KWXGRPJPVH6RFpAEKNb92RGzeZVSU3kE67/3tX5016Po591Sc
         rQwcMnI0LHwNYSL+2iVdgM4ne5bynR7t4/8wzyIUbxZiboNpZfjAXA9iaJ9J2Xh+HJbj
         W02qh8X/iLtGiw/DXqOcckB4CUq54fGd1X0QRn3y/15oZwVyDlLNhVbntan5LE++bdzW
         wvqV2jYzCJ8gcarIe2HZ+esOiATiI6rbFlw+8WGwQFht0y+hB6uCb7UdBFwkm35UcHSp
         CNnA==
X-Gm-Message-State: AOJu0YxJHUoH8eClGX9SNnTQlkFrCcqgf1nlXwZjeG7E3admhYCQeK+O
        5/Aunz46kHcQ4mEKI08WC6xYE6qSnfZi8D9UPklxqg==
X-Google-Smtp-Source: AGHT+IGcA4f1SZU3KuXOFAud9yeTFGruISOrerlndO0A2eRzNDv5uXbJb5LMllwxmz+k5CXCF6OOr1VBQANuxlqvmBw=
X-Received: by 2002:a05:6902:c7:b0:d9a:e6d6:42f8 with SMTP id
 i7-20020a05690200c700b00d9ae6d642f8mr2773004ybs.29.1697731315891; Thu, 19 Oct
 2023 09:01:55 -0700 (PDT)
MIME-Version: 1.0
References: <20231009025726.5982-1-link@vivo.com> <CAOUHufaX35Y6MfwKj_XUWXJwdC=9M=g1gXpQpQghBZ2fXrkEAw@mail.gmail.com>
 <CABdmKX0xevnJfcgsDEWsfX9J5T2x0EV7x-p4ommq_Deg98WwYA@mail.gmail.com> <d9b31019-9374-4531-8967-d289af3f4f06@vivo.com>
In-Reply-To: <d9b31019-9374-4531-8967-d289af3f4f06@vivo.com>
From:   "T.J. Mercier" <tjmercier@google.com>
Date:   Thu, 19 Oct 2023 09:01:43 -0700
Message-ID: <CABdmKX21QfTDXJ2o=CbATmeX1OSgB1XnM=escE7xf8gMrvMhGA@mail.gmail.com>
Subject: Re: [PATCH 0/3 RESEND] Per memcg lru_gen node stat
To:     Huan Yang <link@vivo.com>
Cc:     Yu Zhao <yuzhao@google.com>, Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Peter Xu <peterx@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        "T.J. Alumbaugh" <talumbau@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Ryan Roberts <ryan.roberts@arm.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Suren Baghdasaryan <surenb@google.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        "open list:CONTROL GROUP - MEMORY RESOURCE CONTROLLER (MEMCG)" 
        <cgroups@vger.kernel.org>, opensource.kernel@vivo.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 18, 2023 at 7:32=E2=80=AFPM Huan Yang <link@vivo.com> wrote:
> > Android can't use debugfs in production, but I
> > think we'd prefer to use memory.reclaim for eviction anyway because it
> > respects memcg limits and reclaims from slab.
> Yes, shrink control this actually can use proactive reclaim.
> >
> > So maybe it's possible to add just aging functionality specific to
> > MGLRU? It'd be nice to know how you're going to use the aging, or why
> Due to debugfs not always mount, if we want to now lrugen's info, maybe
> nice to offer a memcg's node to show per memcg's lrugen info.
> > you want this version of eviction instead of what memory.reclaim does.
>
I think Yu's inquiry was about whether you will look at the lrugen
info from the memcg file for a production use case, or just for
debugging where you don't have debugfs for some reason. Because it's a
long term commitment to add the file.
