Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B44567F3E4D
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 07:45:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232593AbjKVGpS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 01:45:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbjKVGpQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 01:45:16 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B783797
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 22:45:12 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-a013d22effcso241321166b.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 22:45:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700635511; x=1701240311; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5xwyYye+wQlYnjpBJCOKYjPSHv4hsDlpq0YhFNQKNEc=;
        b=2WkCZLXzYuuveXZ84dV9zKkCS1FevV3r5g5+QywBiN3I/bEcbwadb4MF46Z/bceZrn
         4prNhqCytYXjrrYQhDAfEqmYAi6/9O2sBICAhol+KouaTxcLLynJWVgAiDphxjM4g92U
         HhWr8pmCAi79QYReu9b36Sf3WFQDY+EfiaOVR1laSIxpkz2XwNdg1nPJ/Jt/MUZPgzvI
         eZJT3cLHHW/LiXDQK/NGxVAgyLQpjnbjKrCf+5QJLtTEJG+lOSMgNSE+86zpXWeBXnzD
         GQxNpBNfCBWatUpgzQ6H8Y6S08dR3zAspQeFVOk4w6ivA3VjEZgr5vXUbv45Di+VSVm9
         e9XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700635511; x=1701240311;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5xwyYye+wQlYnjpBJCOKYjPSHv4hsDlpq0YhFNQKNEc=;
        b=RCp1CtrTwhyYq3N3Lyb/97/dYEQzJ+0hQjLiqr3wV2zi5hzd1TCuNavO5OeP4yL//A
         8MzEPnH2knBLISb/jJcvEIUVaD0Gb208sRMsAJSBQt0DwN0IEKDzPUVMo4hDm9SKIgst
         KAIaMjb5wT6/23IvpwWODewc0MqQZQxoUyczwVslJhBoV/4dLw59hIplQBDuGQyDGV3W
         3rjLp41HcKtY4jUyYCat+CJffIeCUs7aamQIUarR4Xj9a0dg+g8+Tqy2Mylxd9vrmfhb
         DOJLxXCe912vdj3VsuKDENjui55jGiG2lKpnzbbseounQ0IwA6L3vZsEFk6tSXwMEUBR
         LbLw==
X-Gm-Message-State: AOJu0YwmAJdfqXvul4KYIUte/e9bQQeGhKytlFVGBX1nCcz4Vs2AK7zI
        Hr9jmA3EzQwmBixcJCeeezEb31RMayb9pNODY5NkKA==
X-Google-Smtp-Source: AGHT+IFeHPawSGxU4UWzIS3J233xNDbTVcl8jRgj9Wuu8H+hsttAxcgpq7Z9KOdt6bDg4cLcSsG1Tc+VOIbGpxwl+Gg=
X-Received: by 2002:a17:907:9158:b0:9df:bc50:2513 with SMTP id
 l24-20020a170907915800b009dfbc502513mr824738ejs.65.1700635510928; Tue, 21 Nov
 2023 22:45:10 -0800 (PST)
MIME-Version: 1.0
References: <20231121090624.1814733-1-liushixin2@huawei.com>
 <ZVyp5eETLTT0PCYj@tiehlicka> <32fe518a-e962-14ae-badc-719390386db9@huawei.com>
In-Reply-To: <32fe518a-e962-14ae-badc-719390386db9@huawei.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Tue, 21 Nov 2023 22:44:32 -0800
Message-ID: <CAJD7tkbC=Z6qAE+b6Ch5eVxNY7k0p98i_=RY0m4_3yg5C_zv+A@mail.gmail.com>
Subject: Re: [PATCH v10] mm: vmscan: try to reclaim swapcache pages if no swap space
To:     Liu Shixin <liushixin2@huawei.com>
Cc:     Michal Hocko <mhocko@suse.com>, Yu Zhao <yuzhao@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Huang Ying <ying.huang@intel.com>,
        Sachin Sant <sachinp@linux.ibm.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Tue, Nov 21, 2023 at 10:41=E2=80=AFPM Liu Shixin <liushixin2@huawei.com>=
 wrote:
>
>
> On 2023/11/21 21:00, Michal Hocko wrote:
> > On Tue 21-11-23 17:06:24, Liu Shixin wrote:
> >
> > However, in swapcache_only mode, the scan count still increased when sc=
an
> > non-swapcache pages because there are large number of non-swapcache pag=
es
> > and rare swapcache pages in swapcache_only mode, and if the non-swapcac=
he
> > is skipped and do not count, the scan of pages in isolate_lru_folios() =
can
> > eventually lead to hung task, just as Sachin reported [2].
> > I find this paragraph really confusing! I guess what you meant to say i=
s
> > that a real swapcache_only is problematic because it can end up not
> > making any progress, correct?
> This paragraph is going to explain why checking swapcache_only after scan=
 +=3D nr_pages;
> >
> > AFAIU you have addressed that problem by making swapcache_only anon LRU
> > specific, right? That would be certainly more robust as you can still
> > reclaim from file LRUs. I cannot say I like that because swapcache_only
> > is a bit confusing and I do not think we want to grow more special
> > purpose reclaim types. Would it be possible/reasonable to instead put
> > swapcache pages on the file LRU instead?
> It looks like a good idea, but I'm not sure if it's possible. I can try i=
t, is there anything to
> pay attention to?

I think this might be more intrusive than we think. Every time a page
is added to or removed from the swap cache, we will need to move it
between LRUs. All pages on the anon LRU will need to go through the
file LRU before being reclaimed. I think this might be too big of a
change to achieve this patch's goal.

>
> Thanks,
>
