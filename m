Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B3737F4995
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 16:02:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344308AbjKVPCH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 10:02:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344284AbjKVPCG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 10:02:06 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88D6B19D
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 07:02:02 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CC07C43397
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 15:02:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700665322;
        bh=ITSc+8CASPasYP6znHkBBoTMN83PkY3DBR4mulSAaMA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=gBIaALKo5PKhE+ei/4YB8j0v//Nut7Yo9/Wz+qI0bB8bnKEnDq51Vl8xudFniLYxk
         cEo+HrMxP8EbqJfSxdPdMJf9JWagxHRoOqYJr+h8NUjcoOAs0K2BG6sDcwEvu5O5TC
         nQyXK3dLDMVuHy4r/nPFkmNUWq4WFRpW1QSJakrNEjsk7WBQYO1MbBPitv3O2Q/htj
         U7pFOF6jA9wtUhfPi2uO9osF2vykKje3lxcKEaR0xGViSz93XVPaXHEPH7Sps2floJ
         1jGiZlhxw5bz7lM4AqJTNpXj2WWT/qG/aIB9XwVXuvQYOQtNGTPO2xawPj9XUjOLgg
         ZLLu6CzRSkSGw==
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-77896da2118so443285385a.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 07:02:02 -0800 (PST)
X-Gm-Message-State: AOJu0YxO9ZbnIV7CGr8HhD6ltJEeJ5wfn8a1eWv7E9zDi6iHI7Oh8hC1
        JMFgL/Ai6F1owWpGYn6xQgcWuv1J/v3uiKDyp5N5jg==
X-Google-Smtp-Source: AGHT+IFy5n023alBBXB1iA8ZpwW7jnBHcI3sDn8m69jiAiT2qvEEZDnxtwU2dwZoa/Mc5NTf+3/xDdhG38NTgZSqkoY=
X-Received: by 2002:a17:902:8c8c:b0:1ca:e491:f525 with SMTP id
 t12-20020a1709028c8c00b001cae491f525mr2640784plo.31.1700665299383; Wed, 22
 Nov 2023 07:01:39 -0800 (PST)
MIME-Version: 1.0
References: <20231115172344.4155593-1-nphamcs@gmail.com> <CAF8kJuN-4UE0skVHvjUzpGefavkLULMonjgkXUZSBVJrcGFXCA@mail.gmail.com>
 <CAJD7tkZ1U+YuvoBAnrXFxQDiQV2hXdbMG-gbzu64R8GLAtNAPA@mail.gmail.com>
 <CAF8kJuPTNwQM413UdeQTkMQ8HkJFyF4OWVrxJSf7uWbege0CXQ@mail.gmail.com>
 <CAKEwX=O5M-vZE5YhYQ5_CbCmXovS1XECO4ROXKWo06K880M1Mg@mail.gmail.com>
 <CAF8kJuOD6zq2VPcVdoZGvkzYX8iXn1akuYhNDJx-LUdS+Sx3GA@mail.gmail.com>
 <CAKEwX=NdFjemcmf27PVpgHpVHWQEo19KfApepWJBRYeyVCWvCw@mail.gmail.com>
 <CAF8kJuOCyd5r0LQ3m8fQp0GtxxNUKSmwURJH6V9aApefvX8xCA@mail.gmail.com>
 <ZVrHXJLxvs4_CUxc@google.com> <CAKEwX=MR6a-u87p=Oqm+zvwB_1zhrsM_n2=xW1kJz0_AoVwkPA@mail.gmail.com>
 <CAF8kJuNFQn_e29YEPy-G29FR2RnrPzZNWR07VuadOTNask_Rig@mail.gmail.com> <CAKEwX=NpKqjApRKk2Qp9Hp63xSjRwD-DEu9yX4BvbMd86x2b1g@mail.gmail.com>
In-Reply-To: <CAKEwX=NpKqjApRKk2Qp9Hp63xSjRwD-DEu9yX4BvbMd86x2b1g@mail.gmail.com>
From:   Chris Li <chrisl@kernel.org>
Date:   Wed, 22 Nov 2023 07:01:28 -0800
X-Gmail-Original-Message-ID: <CAF8kJuMp_BNauZzOuqXNiViuY2JH=JKWid2-_BwQjDTWptoryg@mail.gmail.com>
Message-ID: <CAF8kJuMp_BNauZzOuqXNiViuY2JH=JKWid2-_BwQjDTWptoryg@mail.gmail.com>
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
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 21, 2023 at 5:19=E2=80=AFPM Nhat Pham <nphamcs@gmail.com> wrote=
:

> > "all": zswap + swapfile
> > "zswap": zswap only
> > "no_zswap": swapfile only.
> > "none": no swap.
> >
> > All keyword names are open to suggestions.
>
> SGTM! There might be some functionality duplication between
> memory.swap.tiers =3D no_zswap and memory.zswap.max =3D 0, but
> otherwise this seems reasonable to me.
>
> no_zswap sounds a bit awkward, but I can't come up with a better
> name.

I sleep on it a bit. I  should apply my own suggestion of using the
positive words rather than negative one to myself.
I actually define it as a non RAM base swap device. How about "disk"?
It will include SSD and HDD disk.

The current 4 combination will be:

"all": zswap + disk swap file
"zswap": zswap only
"disk": disk only (including SSD and HDD)
"none": no swap for you.

Chris
