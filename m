Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFF9E7DF5C5
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 16:11:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344505AbjKBPLv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 11:11:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjKBPLu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 11:11:50 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F7AF13D
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 08:11:41 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id d75a77b69052e-41b406523fcso5652451cf.2
        for <linux-kernel@vger.kernel.org>; Thu, 02 Nov 2023 08:11:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1698937900; x=1699542700; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cAw9sv/T68KQfbkbViSCXGIX3HBnIacj63UFeeK2mDo=;
        b=k5GtqmgIetQC+bLlwfHCHMHhhhPrSzC/+VXFqILAjNBSj2ivUOKMmdTww8BL4waky0
         Kb7gO9lLLL2aGWD/5kA4KVIiaUNrhNAFgwAYY7vWhqYXWzciryo540xOoRQ3v2VoTkIm
         9vrPft4TRSHG73aD4ecg564Y8Rrn2UvCP/2FGqXhPrkpMFhsGsnasz/j2lvrZtTkwS2Z
         KuuIM1lsulAFBcu6mE7DsJqW55c2i24g4lg3zAGan0wVBGKyyKfM2Kh+sMZecJTPvxv+
         OPtNCB3vJkp8OleOizYkZ4542JeD3rRevI+jIQ3/X+5V0sVWrWlVP3p3h3O59jmtJFux
         yWww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698937900; x=1699542700;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cAw9sv/T68KQfbkbViSCXGIX3HBnIacj63UFeeK2mDo=;
        b=iLCLcSNaEOaoYh0kFURKpmmXSKJU1TGxu6v9M4JH128PyCSgzOjDlOFdH/ExGS5i4v
         b+fpMTfozcrXYbnBa2deBWfzUl8jspk44CaOT+1QjZB8wbWH8bmcl+6bN3RkuLmLoKWk
         jKhCxZ1RIwZOkJi9mFWuihJasGvXNY7sDtT1bTOA4yxyCAoYs3MIQ/bSs2HpgqJjtn6i
         H5luvYOKdj1gBrDqjqg+c9hUSJHX3qAi5ABXqZ01FVIuIrXIGT1+/CPuHka9AL2eYsQJ
         OBU8hUyLIQqApdx5zEiV8PGIEwoDSVsgqRNxPgLCMquIuPWRTw2hUIH/FYRBTPswApZG
         lidg==
X-Gm-Message-State: AOJu0YwtxTA+l3zH+vdhCLDbPzANS6XiZxpMvi2eTsSVMxKYnUiQqFRq
        jNW6gsqdQnGnF2grGgUcpVc+V1DHE+b0TL+Fu1SI5Q==
X-Google-Smtp-Source: AGHT+IHcYzPWiAFmBoXSyJoDI64wpvja1WI+ECLeWeUah15PFIwLSppZZtojijKSQdF7suJdY1SYkg/gdOmnHPwYHJk=
X-Received: by 2002:ac8:5f06:0:b0:41e:2112:611f with SMTP id
 x6-20020ac85f06000000b0041e2112611fmr20358911qta.39.1698937900089; Thu, 02
 Nov 2023 08:11:40 -0700 (PDT)
MIME-Version: 1.0
References: <20231101230816.1459373-1-souravpanda@google.com>
 <20231101230816.1459373-2-souravpanda@google.com> <2023110205-enquirer-sponge-4f35@gregkh>
 <CA+CK2bDUaQDwgF-Q0vfNzHfXmn-QhnHTSE32_RfttHSGB7O3DA@mail.gmail.com> <2023110216-labrador-neurosis-1e6e@gregkh>
In-Reply-To: <2023110216-labrador-neurosis-1e6e@gregkh>
From:   Pasha Tatashin <pasha.tatashin@soleen.com>
Date:   Thu, 2 Nov 2023 11:11:03 -0400
Message-ID: <CA+CK2bCFgwLXp=pUTKezWtRoCKiDC41DqGXx_kahg0UcB53sPw@mail.gmail.com>
Subject: Re: [PATCH v5 1/1] mm: report per-page metadata information
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Sourav Panda <souravpanda@google.com>, corbet@lwn.net,
        rafael@kernel.org, akpm@linux-foundation.org,
        mike.kravetz@oracle.com, muchun.song@linux.dev, rppt@kernel.org,
        david@redhat.com, rdunlap@infradead.org, chenlinxuan@uniontech.com,
        yang.yang29@zte.com.cn, tomas.mudrunka@gmail.com,
        bhelgaas@google.com, ivan@cloudflare.com, yosryahmed@google.com,
        hannes@cmpxchg.org, shakeelb@google.com,
        kirill.shutemov@linux.intel.com, wangkefeng.wang@huawei.com,
        adobriyan@gmail.com, vbabka@suse.cz, Liam.Howlett@oracle.com,
        surenb@google.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-mm@kvack.org, willy@infradead.org, weixugc@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 2, 2023 at 10:29=E2=80=AFAM Greg KH <gregkh@linuxfoundation.org=
> wrote:
>
> On Thu, Nov 02, 2023 at 10:24:04AM -0400, Pasha Tatashin wrote:
> > On Thu, Nov 2, 2023 at 1:42=E2=80=AFAM Greg KH <gregkh@linuxfoundation.=
org> wrote:
> > >
> > > On Wed, Nov 01, 2023 at 04:08:16PM -0700, Sourav Panda wrote:
> > > > Adds a new per-node PageMetadata field to
> > > > /sys/devices/system/node/nodeN/meminfo
> > >
> > > No, this file is already an abuse of sysfs and we need to get rid of =
it
> > > (it has multiple values in one file.)  Please do not add to the
> > > nightmare by adding new values.
> >
> > Hi Greg,
> >
> > Today, nodeN/meminfo is a counterpart of /proc/meminfo, they contain
> > almost identical fields, but show node-wide and system-wide views.
>
> And that is wrong, and again, an abuse of sysfs, please do not continue
> to add to it, that will only cause problems.
>
> > Since per-page metadata is added into /proc/meminfo, it is logical to
> > add into nodeN/meminfo, some nodes can have more or less struct page
> > data based on size of the node, and also the way memory is configured,
> > such as use of vmemamp optimization etc, therefore this information is
> > useful to users.
> >
> > I am not aware of any example of where a system-wide field from
> > /proc/meminfo is represented as a separate sysfs file under node0/. If
> > nodeN/meminfo is ever broken down into separate files it will affect
> > all the fields in it the same way with or without per-page metadata
>
> All of the fields should be individual files, please start adding them
> if you want to add new items, I do not want to see additional abuse here

Sounds good, in our next patch version we will create a new file under
nodeN/ to contain per-page metadata overhead, and add an ABI doc file
for it.

Thanks,
Pasha
