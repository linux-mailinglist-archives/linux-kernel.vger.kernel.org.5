Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DC687DFB74
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 21:22:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344138AbjKBUWg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 16:22:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbjKBUWe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 16:22:34 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4F5318E
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 13:22:30 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-32d81864e3fso743273f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 02 Nov 2023 13:22:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698956549; x=1699561349; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I2OmO/cSIWcHLs5m9Fp9R9ncrDst5FOA+aif1w7pvlY=;
        b=VVXw20Ck559qbFs8nOTmwLTg3VE6Z8QGY7PQOXI2emiI6FfSearhwJGE91XsXH/LHJ
         PV1O6YQ+5QyE2feTXU5dGonPqp68rzG83VTM75gHXFcW5Fdk7E1+9FnITs+rwAXOIVOQ
         wJF1hZ/X3aq7eZsAhdoXiDr6a99IH9n5/trPQimDxmavKwim5WGKUTA1c47Gto49/jqu
         bSmHF+kVgyqISE4xdsP6z3G4Z7wVER0N260qFgx09FNFSmwhjPaZQDswaD2xh5h8e8sP
         pQb4NCjityjzx1ywpFJyA7fyS9ZzLn6iHGzZCQmG7r6WpaB04M+d/g87+gHA7iXUpT6n
         FBGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698956549; x=1699561349;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I2OmO/cSIWcHLs5m9Fp9R9ncrDst5FOA+aif1w7pvlY=;
        b=UPUZkRIdyhjh5Cn4li48Z2wkC+JoeniJ+ZFUwyVnkjVfZws+Kue9D2IUoHvja8ns0b
         ekOALL4EYQwcfouYSaFmVfW7bjb/6y5zcGIDGh93viH5Jlv60Iy60/8qcEzZh7Z+zFKs
         O5Kr1FSAU/BDGUMR7kzAzhT/+XqxXemf0u5cdfuBFEps4X2pLtWHMcQqsiE/Uwa6Rcml
         x9RIximizjjiGWfzlx/f/rTY9XJ6srWNbxEAX8uL48UlypB0K4iLsCa89zqPdcLzdLku
         SV8Jy+jmKRWF6WvEPVDi+hUnDfbxZaFbOrhhrn1m32g0YBJ8FENWfsCGKv1BnJSC7L6O
         WGOw==
X-Gm-Message-State: AOJu0YxSpkadbr3I+xc2AKC7kdXPjSIRXxNlz2XqvEkPIuxaafcjlQjA
        DiOnjDpchUe1OQtoArtrh0zPW8XnBxgdCSDWCMge4g==
X-Google-Smtp-Source: AGHT+IGWJTOQ+YhYnai3xZ5GlBXEVrHAqeGyrw5YY2JPOXTz5UPWJyE0CwKm1+LwoDz/xF/C9pX5+Zcy8M468XbZ27o=
X-Received: by 2002:adf:f6c5:0:b0:323:36f1:c256 with SMTP id
 y5-20020adff6c5000000b0032336f1c256mr15140662wrp.11.1698956549087; Thu, 02
 Nov 2023 13:22:29 -0700 (PDT)
MIME-Version: 1.0
References: <20231101230816.1459373-1-souravpanda@google.com>
 <20231101230816.1459373-2-souravpanda@google.com> <CAAPL-u_enAt7f9XUpwYNKkCOxz2uPbMrnE2RsoDFRcKwZdnRFQ@mail.gmail.com>
 <CA+CK2bC3rSGOoT9p_VmWMT8PBWYbp7Jo7Tp2FffGrJp-hX9xCg@mail.gmail.com>
 <CAAPL-u-4D5YKuVOsyfpDUR+PbaA3MOJmNtznS77bposQSNPjnA@mail.gmail.com>
 <1e99ff39-b1cf-48b8-8b6d-ba5391e00db5@redhat.com> <CA+CK2bDo6an35R8Nu-d99pbNQMEAw_t0yUm0Q+mJNwOJ1EdqQg@mail.gmail.com>
 <025ef794-91a9-4f0c-9eb6-b0a4856fa10a@redhat.com> <CA+CK2bDJDGaAK8ZmHtpr79JjJyNV5bM6TSyg84NLu2z+bCaEWg@mail.gmail.com>
 <99113dee-6d4d-4494-9eda-62b1faafdbae@redhat.com> <CA+CK2bApoY+trxxNW8FBnwyKnX6RVkrMZG4AcLEC2Nj6yZ6HEw@mail.gmail.com>
 <b71b28b9-1d41-4085-99f8-04d85892967e@redhat.com> <CA+CK2bCNRJXm2kEjsN=5a_M8twai4TJX3vpd72uOHFLGaDLg4g@mail.gmail.com>
 <CAAPL-u_OWFLrrNxszm4D+mNiZY6cSb3=jez3XJHFtN6q05dU2g@mail.gmail.com> <CA+CK2bBPBtAXFQAFUeF8nTxL_Sx926HgR3zLCj_6pKgbOGt8Wg@mail.gmail.com>
In-Reply-To: <CA+CK2bBPBtAXFQAFUeF8nTxL_Sx926HgR3zLCj_6pKgbOGt8Wg@mail.gmail.com>
From:   Wei Xu <weixugc@google.com>
Date:   Thu, 2 Nov 2023 13:22:17 -0700
Message-ID: <CAAPL-u9HHgPDj_xTTx=GqPg49DcrpGP1FF8zhaog=9awwu0f_Q@mail.gmail.com>
Subject: Re: [PATCH v5 1/1] mm: report per-page metadata information
To:     Pasha Tatashin <pasha.tatashin@soleen.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Sourav Panda <souravpanda@google.com>, corbet@lwn.net,
        gregkh@linuxfoundation.org, rafael@kernel.org,
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

On Thu, Nov 2, 2023 at 11:34=E2=80=AFAM Pasha Tatashin
<pasha.tatashin@soleen.com> wrote:
>
> > > > I could have sworn that I pointed that out in a previous version an=
d
> > > > requested to document that special case in the patch description. :=
)
> > >
> > > Sounds, good we will document that parts of per-page may not be part
> > > of MemTotal.
> >
> > But this still doesn't answer how we can use the new PageMetadata
> > field to help break down the runtime kernel overhead within MemUsed
> > (MemTotal - MemFree).
>
> I am not sure it matters to the end users: they look at PageMetadata
> with or without Page Owner, page_table_check, HugeTLB and it shows
> exactly how much per-page overhead changed. Where the kernel allocated
> that memory is not that important to the end user as long as that
> memory became available to them.
>
> In addition, it is still possible to estimate the actual memblock part
> of Per-page metadata by looking at /proc/zoneinfo:
>
> Memblock reserved per-page metadata: "present_pages - managed_pages"

This assumes that all reserved memblocks are per-page metadata. As I
mentioned earlier, it is not a robust approach.

> If there is something big that we will allocate in that range, we
> should probably also export it in some form.
>
> If this field does not fit in /proc/meminfo due to not fully being
> part of MemTotal, we could just keep it under nodeN/, as a separate
> file, as suggested by Greg.
>
> However, I think it is useful enough to have an easy system wide view
> for Per-page metadata.

It is fine to have this as a separate, informational sysfs file under
nodeN/, outside of meminfo. I just don't think as in the current
implementation (where PageMetadata is a mixture of buddy and memblock
allocations), it can help with the use case that motivates this
change, i.e. to improve the breakdown of the kernel overhead.

> > > > > are allocated), so what would be the best way to export page meta=
data
> > > > > without redefining MemTotal? Keep the new field in /proc/meminfo =
but
> > > > > be ok that it is not part of MemTotal or do two counters? If we d=
o two
> > > > > counters, we will still need to keep one that is a buddy allocato=
r in
> > > > > /proc/meminfo and the other one somewhere outside?
> > > >
> >
> > I think the simplest thing to do now is to only report the buddy
> > allocations of per-page metadata in meminfo.  The meaning of the new
>
> This will cause PageMetadata to be 0 on 99% of the systems, and
> essentially become useless to the vast majority of users.

I don't think it is a major issue. There are other fields (e.g. Zswap)
in meminfo that remain 0 when the feature is not used.
