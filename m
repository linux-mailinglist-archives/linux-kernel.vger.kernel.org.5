Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CA0C7F36A2
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 20:09:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229566AbjKUTJh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 14:09:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbjKUTJf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 14:09:35 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5742110C
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 11:09:32 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8B9FC433CA
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 19:09:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700593771;
        bh=wQqDKRQjn6844OW3n/w7wb8sy0SLbW225b2srtOadSo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ccc0iYNA+ruXpCZTeJMcDBc51/1dKabUqQNxc1hQCOJOE0SuqptNQJe1wJv5Q510b
         q2XMuR7kafI97/r18kF9PbcfVbEEVblgXkOXCFftu56SAtex33D+ruTxY7Qc+pQncP
         InGXMnq10VNG4SuRP/P9CBrOm7J4gWpOeDKGgZIcDJhilKFxlftzF2I4I4ROwa0FxL
         djc/+3iPXe6UHcCU8SlbCvB3klXvFSIxt8myvJtJDFKKNSKRLZUlNzjOS+3X5RfqXp
         LS/dsD8to3j15y9frxouKwUbNVBxG64IXomRxa1+yzO0Nrtp/yzo+Mr/y7125FPS6f
         VvP252hKUHCgw==
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-41cd8bd5727so34392511cf.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 11:09:31 -0800 (PST)
X-Gm-Message-State: AOJu0YxE36Qko7ByTy20QV6FIx4M8dGNN22aROvJFnccO5g+BiQURhst
        75zgaiGw0fSlU454bzlWonIhcizeZJMHarJn11NpZg==
X-Google-Smtp-Source: AGHT+IFj6T6qFwD847PxtZzKZN0ToGw/PjQQlEJhOLHFQIM/P89jcN/ZWDs7l4ENV/joAGnZgLeRSADwaWkhZ9aimOw=
X-Received: by 2002:a17:90b:1d92:b0:27d:5964:4ee6 with SMTP id
 pf18-20020a17090b1d9200b0027d59644ee6mr163589pjb.2.1700593750122; Tue, 21 Nov
 2023 11:09:10 -0800 (PST)
MIME-Version: 1.0
References: <20231115172344.4155593-1-nphamcs@gmail.com> <CAF8kJuN-4UE0skVHvjUzpGefavkLULMonjgkXUZSBVJrcGFXCA@mail.gmail.com>
 <CAJD7tkZ1U+YuvoBAnrXFxQDiQV2hXdbMG-gbzu64R8GLAtNAPA@mail.gmail.com>
 <CAF8kJuPTNwQM413UdeQTkMQ8HkJFyF4OWVrxJSf7uWbege0CXQ@mail.gmail.com>
 <CAKEwX=O5M-vZE5YhYQ5_CbCmXovS1XECO4ROXKWo06K880M1Mg@mail.gmail.com>
 <CAF8kJuOD6zq2VPcVdoZGvkzYX8iXn1akuYhNDJx-LUdS+Sx3GA@mail.gmail.com>
 <CAKEwX=NdFjemcmf27PVpgHpVHWQEo19KfApepWJBRYeyVCWvCw@mail.gmail.com>
 <CAF8kJuOCyd5r0LQ3m8fQp0GtxxNUKSmwURJH6V9aApefvX8xCA@mail.gmail.com>
 <ZVrHXJLxvs4_CUxc@google.com> <CAKEwX=MR6a-u87p=Oqm+zvwB_1zhrsM_n2=xW1kJz0_AoVwkPA@mail.gmail.com>
In-Reply-To: <CAKEwX=MR6a-u87p=Oqm+zvwB_1zhrsM_n2=xW1kJz0_AoVwkPA@mail.gmail.com>
From:   Chris Li <chrisl@kernel.org>
Date:   Tue, 21 Nov 2023 11:08:59 -0800
X-Gmail-Original-Message-ID: <CAF8kJuNFQn_e29YEPy-G29FR2RnrPzZNWR07VuadOTNask_Rig@mail.gmail.com>
Message-ID: <CAF8kJuNFQn_e29YEPy-G29FR2RnrPzZNWR07VuadOTNask_Rig@mail.gmail.com>
Subject: Re: [PATCH v5] zswap: memcontrol: implement zswap writeback disabling
To:     Nhat Pham <nphamcs@gmail.com>
Cc:     Yosry Ahmed <yosryahmed@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, tj@kernel.org,
        lizefan.x@bytedance.com, Johannes Weiner <hannes@cmpxchg.org>,
        Domenico Cerasuolo <cerasuolodomenico@gmail.com>,
        Seth Jennings <sjenning@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>,
        Vitaly Wool <vitaly.wool@konsulko.com>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Hugh Dickins <hughd@google.com>, corbet@lwn.net,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        senozhatsky@chromium.org, rppt@kernel.org,
        linux-mm <linux-mm@kvack.org>, kernel-team@meta.com,
        LKML <linux-kernel@vger.kernel.org>, linux-doc@vger.kernel.org,
        david@ixit.cz, Minchan Kim <minchan@google.com>,
        Kairui Song <kasong@tencent.com>,
        Zhongkun He <hezhongkun.hzk@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 21, 2023 at 10:13=E2=80=AFAM Nhat Pham <nphamcs@gmail.com> wrot=
e:
>
> Hi Chris!
>
> Thanks for the patch. Would you mind if I spend some time staring
> at the suggestion again and testing it some more?

Of course, by all means. That is just the minimal version to be
functional compatible with your zswap.writeback.

I might consider a follow up patch to add "no_zswap" and "none" to
convert the SSD only swapfile, which can't be expressed by
zswap.writeback.
That should cover all 4 combinations of zswap and swap files without
creating a custom swap tiers list.

"all": zswap + swapfile
"zswap": zswap only
"no_zswap": swapfile only.
"none": no swap.

All keyword names are open to suggestions.

>
> If everything is good, I'll squash this patch with the original version,
> (keeping you as a co-developer of the final patch of course), and
> update the documentation before re-sending everything as v6.

Great!

>
> Anyway, have a nice Thanksgiving break everyone! Thanks for
> taking the time to review my patch and discuss the API with me!

My pleasure to discuss the swap with you. We should do the online
"swap meet" and invite other developers who are interested in the swap
area as well.

Chris
