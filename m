Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D9527DFDAF
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 02:09:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377629AbjKCBHV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 21:07:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbjKCBHT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 21:07:19 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10FE7198
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 18:07:12 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id d75a77b69052e-4196ae80fc3so8665801cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Nov 2023 18:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1698973631; x=1699578431; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qCr2uTXG4daALtyBbHvIpmUdOFTLryhu1H0hnelXOT0=;
        b=XKxCFFDeeN4XCu7oEb5OzGwM130LRWaKEVYMtCoaNDWaprwONDq0/R1Zt6RthysOsy
         6yM4TS09Kv0B5LigRjPnF5f9hPTj6g6wRAN+HSYNwdYX7/FAboOGugIeVTleG+j3to+r
         ywaCxtYSQ/etLnwRsxPHAcNyp26ZBThhSeWYJypMe9cHdWPXNs23PlomMAKXDhwtBeEl
         +F+0u1MM6EHziRVGjVGRoYPTy9mETqE+Ox4gvGODSCszwic5FdChvuQwJzxD1EmqeozH
         EOuz05V2vugDTYc6J2RBDY11NqCJQWEsaV59zerHTxk2GHiBmZaYBRN74CRc8BNo2E/R
         jIdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698973631; x=1699578431;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qCr2uTXG4daALtyBbHvIpmUdOFTLryhu1H0hnelXOT0=;
        b=dBQ9kQVwWgPbo48n+3domzDQ5/BGItCo0S91tMQhkWHCNs/0qkiTKBFtimCZoKFpPv
         GGtCXhsBowPTRVoNcFKocQuIUEimhdC0PElLK2qiEGPD1anR/nFMZLaVYVEZPUBxwli+
         5Pszz6+kBVircTXBoeaObkZ7gT3Bv2xJHLnyaOmgZ5l3z1bMl+lm80GdBCxegMVsuj3J
         JurYnJE61/8sNHk8MabJSunuGl8M2O602kFjHpeRkdn/9hick8xfierPOC5j1JbOUR84
         XVHZbOoMZFYJ98IDxqPBchQcVCnxoJTrGoZQiHcE02QfqKUk0jNNppli+y8oW7+tVs6q
         92jQ==
X-Gm-Message-State: AOJu0YyrES1mVcUuB6ujJZcoamqOeUxgxTxw/DI+7ViT/TroHdlIr9h+
        8ffWYEJ+PdIbu+tn3nwKzD+D8u65lICD0qAtKOsiBA==
X-Google-Smtp-Source: AGHT+IEqYrzRZ/GFNvFXxoK50vrQQuq1A8gYWJ3fw0CyeAan/l0SmscOwqpyx5yApNc02+deo9lEbx2+K5Z9OdVf+gg=
X-Received: by 2002:ac8:5a8f:0:b0:41e:37cf:8661 with SMTP id
 c15-20020ac85a8f000000b0041e37cf8661mr23002590qtc.12.1698973631023; Thu, 02
 Nov 2023 18:07:11 -0700 (PDT)
MIME-Version: 1.0
References: <20231101230816.1459373-1-souravpanda@google.com>
 <20231101230816.1459373-2-souravpanda@google.com> <CAAPL-u_enAt7f9XUpwYNKkCOxz2uPbMrnE2RsoDFRcKwZdnRFQ@mail.gmail.com>
 <CA+CK2bC3rSGOoT9p_VmWMT8PBWYbp7Jo7Tp2FffGrJp-hX9xCg@mail.gmail.com>
 <CAAPL-u-4D5YKuVOsyfpDUR+PbaA3MOJmNtznS77bposQSNPjnA@mail.gmail.com>
 <1e99ff39-b1cf-48b8-8b6d-ba5391e00db5@redhat.com> <CA+CK2bDo6an35R8Nu-d99pbNQMEAw_t0yUm0Q+mJNwOJ1EdqQg@mail.gmail.com>
 <025ef794-91a9-4f0c-9eb6-b0a4856fa10a@redhat.com> <CA+CK2bDJDGaAK8ZmHtpr79JjJyNV5bM6TSyg84NLu2z+bCaEWg@mail.gmail.com>
 <99113dee-6d4d-4494-9eda-62b1faafdbae@redhat.com> <CA+CK2bApoY+trxxNW8FBnwyKnX6RVkrMZG4AcLEC2Nj6yZ6HEw@mail.gmail.com>
 <b71b28b9-1d41-4085-99f8-04d85892967e@redhat.com> <CA+CK2bCNRJXm2kEjsN=5a_M8twai4TJX3vpd72uOHFLGaDLg4g@mail.gmail.com>
 <CAAPL-u_OWFLrrNxszm4D+mNiZY6cSb3=jez3XJHFtN6q05dU2g@mail.gmail.com>
 <CA+CK2bBPBtAXFQAFUeF8nTxL_Sx926HgR3zLCj_6pKgbOGt8Wg@mail.gmail.com> <CAAPL-u9HHgPDj_xTTx=GqPg49DcrpGP1FF8zhaog=9awwu0f_Q@mail.gmail.com>
In-Reply-To: <CAAPL-u9HHgPDj_xTTx=GqPg49DcrpGP1FF8zhaog=9awwu0f_Q@mail.gmail.com>
From:   Pasha Tatashin <pasha.tatashin@soleen.com>
Date:   Thu, 2 Nov 2023 21:06:33 -0400
Message-ID: <CA+CK2bAv6okHVigjCyDODm5VELi7gtQHOUy9kH5J4jTBpnGPxw@mail.gmail.com>
Subject: Re: [PATCH v5 1/1] mm: report per-page metadata information
To:     Wei Xu <weixugc@google.com>
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
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 2, 2023 at 4:22=E2=80=AFPM Wei Xu <weixugc@google.com> wrote:
>
> On Thu, Nov 2, 2023 at 11:34=E2=80=AFAM Pasha Tatashin
> <pasha.tatashin@soleen.com> wrote:
> >
> > > > > I could have sworn that I pointed that out in a previous version =
and
> > > > > requested to document that special case in the patch description.=
 :)
> > > >
> > > > Sounds, good we will document that parts of per-page may not be par=
t
> > > > of MemTotal.
> > >
> > > But this still doesn't answer how we can use the new PageMetadata
> > > field to help break down the runtime kernel overhead within MemUsed
> > > (MemTotal - MemFree).
> >
> > I am not sure it matters to the end users: they look at PageMetadata
> > with or without Page Owner, page_table_check, HugeTLB and it shows
> > exactly how much per-page overhead changed. Where the kernel allocated
> > that memory is not that important to the end user as long as that
> > memory became available to them.
> >
> > In addition, it is still possible to estimate the actual memblock part
> > of Per-page metadata by looking at /proc/zoneinfo:
> >
> > Memblock reserved per-page metadata: "present_pages - managed_pages"
>
> This assumes that all reserved memblocks are per-page metadata. As I

Right after boot, when all Per-page metadata is still from memblocks,
we could determine what part of the zone reserved memory is not
per-page, and use it later in our calculations.

> mentioned earlier, it is not a robust approach.
> > If there is something big that we will allocate in that range, we
> > should probably also export it in some form.
> >
> > If this field does not fit in /proc/meminfo due to not fully being
> > part of MemTotal, we could just keep it under nodeN/, as a separate
> > file, as suggested by Greg.
> >
> > However, I think it is useful enough to have an easy system wide view
> > for Per-page metadata.
>
> It is fine to have this as a separate, informational sysfs file under
> nodeN/, outside of meminfo. I just don't think as in the current
> implementation (where PageMetadata is a mixture of buddy and memblock
> allocations), it can help with the use case that motivates this
> change, i.e. to improve the breakdown of the kernel overhead.
> > > > > > are allocated), so what would be the best way to export page me=
tadata
> > > > > > without redefining MemTotal? Keep the new field in /proc/meminf=
o but
> > > > > > be ok that it is not part of MemTotal or do two counters? If we=
 do two
> > > > > > counters, we will still need to keep one that is a buddy alloca=
tor in
> > > > > > /proc/meminfo and the other one somewhere outside?
> > > > >
> > >
> > > I think the simplest thing to do now is to only report the buddy
> > > allocations of per-page metadata in meminfo.  The meaning of the new
> >
> > This will cause PageMetadata to be 0 on 99% of the systems, and
> > essentially become useless to the vast majority of users.
>
> I don't think it is a major issue. There are other fields (e.g. Zswap)
> in meminfo that remain 0 when the feature is not used.

Since we are going to use two independent interfaces
/proc/meminfo/PageMetadata and nodeN/page_metadata (in a separate file
as requested by Greg) How about if in /proc/meminfo we provide only
the buddy allocator part, and in nodeN/page_metadata we provide the
total per-page overhead in the given node that include memblock
reserves, and buddy allocator memory?

Pasha
