Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00D517814AF
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 23:22:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240380AbjHRVVu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 17:21:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237820AbjHRVVf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 17:21:35 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3F212102
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 14:21:34 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id 98e67ed59e1d1-26d4e1ba2dbso670132a91.1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 14:21:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692393694; x=1692998494;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PDdRXfFo8OYMPr0y93l3ZVcVprg7m3HhjM+IdZB1vaU=;
        b=SYbmBWu2Wn3hvv3c9n2pmtY7M54NOu0B26DrUbAEzKcIZNH/zTyREYj7DO0J1OWhJ+
         J4PjaX4YZM09BGsGnVMsl8KsTRbQEXepz2iv5aUSreUQs+7y1XqbTO13AkRracFRT015
         QSvVD9FciJHgXo3/r7TMUd3kfE04hj9l176b/nQ/lfhRoY280vwT5HGYTwCRcPB9wJ4j
         RzfOOmubSeJjIO28mwXyXZ4k4qNkzWrO/gh2LAuKvxddDfXwcGM9J4MMD8a5ibSXMHPl
         VOyzEFgddaJI/IQGPrMqmnlRJ1iYLWgJaay4b6+DPFsQ8a0o+3BKdSZku1j3Kq5sgXTb
         0BYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692393694; x=1692998494;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PDdRXfFo8OYMPr0y93l3ZVcVprg7m3HhjM+IdZB1vaU=;
        b=izO6w2dmLmtg1e45+wLMbD8NyxrO1C0ufRh2MHcSZzMXjicJ3GvPNxu9iUb3FE31Sj
         q2xR199kNKqp2XFqAV3LS/N+LazBaIEog9C+J2gl/vGFpP1dXfXt2jSE6QCDY4MQVkUW
         oRp6YeTDb5jac+BG6jp9oWc/xYej2yK2StBTwSDBfaKM/mL91/0KT7+CbASAe7jBvhy2
         oDfwxSC89ET2Q9klmoTwa84VzKCnjqerFXxiafvo4iPf+bQcb8C821YGg6hy4Z9Ex8xn
         F5+59djGhABDHrYi+XyWJ1XjeGddkvGg9tmcGgzDa8g2K9raa/bLlZpfnzpa8g3E98Sj
         NSRw==
X-Gm-Message-State: AOJu0YxFo6rDpNGG9fIpxbQYaiAvJm+FGd83AB8//i2RQTzp9QYcKRJq
        dZ+sgl/upuM1vjEBwiFWsNilZb8HiZK5Q07NBY0=
X-Google-Smtp-Source: AGHT+IGCjyzFTYzzi5LLgjQkruSV/gCOTW2PcU9tXGOAocTUUcTPjnGJH1dst/iJO7P2h//marGMfqaThMDGNpgZFNU=
X-Received: by 2002:a17:90a:498a:b0:268:7ec:51ae with SMTP id
 d10-20020a17090a498a00b0026807ec51aemr367900pjh.41.1692393693817; Fri, 18 Aug
 2023 14:21:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230812210053.2325091-1-zokeefe@google.com> <PUZP153MB06358FF02518EF3B279F5DD4BE16A@PUZP153MB0635.APCP153.PROD.OUTLOOK.COM>
 <CAAa6QmSrwe2m4MjS9mGO+DeGNGSv=B2uZ72EAxnZk2jsDh39rQ@mail.gmail.com>
 <ZNp7JDaPhT3Se4de@casper.infradead.org> <CAAa6QmSN4NhaDL0DQsRd-F8HTnCCjq1ULRNk88LAA9gVbDXE4g@mail.gmail.com>
 <ZNrh6w9ICu4rMrhV@casper.infradead.org> <PUZP153MB063529C4869A7A666C275B23BE15A@PUZP153MB0635.APCP153.PROD.OUTLOOK.COM>
 <CAAa6QmRrnRHEEQMMYe20GLXj7g+LVVHVRAKUdSLy=jUW=khb2A@mail.gmail.com>
 <CAHbLzko_xLiqkNgjA7DhVFBSW6qJdAwgfk557YKV+ZpwS2x16w@mail.gmail.com> <CAAa6QmSxab2-m-RopQtZnBpxTLX25K=KZE+EPmA+wWb_yTqf0Q@mail.gmail.com>
In-Reply-To: <CAAa6QmSxab2-m-RopQtZnBpxTLX25K=KZE+EPmA+wWb_yTqf0Q@mail.gmail.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Fri, 18 Aug 2023 14:21:22 -0700
Message-ID: <CAHbLzko1J9ds_JfZe83JwEx=395sPExB7mQ0faju6OSaQ2tmnQ@mail.gmail.com>
Subject: Re: [EXTERNAL] [PATCH] mm/thp: fix "mm: thp: kill __transhuge_page_enabled()"
To:     "Zach O'Keefe" <zokeefe@google.com>
Cc:     Saurabh Singh Sengar <ssengar@microsoft.com>,
        Matthew Wilcox <willy@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 17, 2023 at 11:29=E2=80=AFAM Zach O'Keefe <zokeefe@google.com> =
wrote:
>
> On Thu, Aug 17, 2023 at 10:47=E2=80=AFAM Yang Shi <shy828301@gmail.com> w=
rote:
> >
> > On Wed, Aug 16, 2023 at 2:48=E2=80=AFPM Zach O'Keefe <zokeefe@google.co=
m> wrote:
> > >
> > > > We have a out of tree driver that maps huge pages through a file ha=
ndle and
> > > > relies on -> huge_fault. It used to work in 5.19 kernels but 6.1 ch=
anged this
> > > > behaviour.
> > > >
> > > > I don=E2=80=99t think reverting the earlier behaviour of fault_path=
 for huge pages should
> > > > impact kernel negatively.
> > > >
> > > > Do you think we can restore this earlier behaviour of kernel to all=
ow page fault
> > > > for huge pages via ->huge_fault.
> > >
> > > That seems reasonable to me. I think using the existence of a
> > > ->huge_fault() handler as a predicate to return "true" makes sense to
> > > me. The "normal" flow for file-backed memory along fault path still
> > > needs to return "false", so that we correctly fallback to ->fault()
> > > handler. Unless there are objections, I can do that in a v2.
> >
> > Sorry for chiming in late. I'm just back from vacation and trying to ca=
tch up...
> >
> > IIUC the out-of-tree driver tries to allocate huge page and install
> > PMD mapping via huge_fault() handler, but the cleanup of
> > hugepage_vma_check() prevents this due to the check to
> > VM_NO_KHUGEPAGED?
> >
> > So you would like to check whether a huge_fault() handler existed
> > instead of vma_is_dax()?
>
> Sorry for the multiple threads here. There are two problems: (a) the
> VM_NO_KHUGEPAGED check along fault path, and (b) we don't give
> ->huge_fault() a fair shake, if it exists, along fault path. The
> current code assumes vma_is_dax() iff ->huge_fault() exists.
>
> (a) is easy enough to fix. For (b), I'm currently looking at the
> possibility of not worrying about ->huge_fault() in
> hugepage_vma_check(), and just letting create_huge_pud() /
> create_huge_pmd() check and fallback as necessary. I think we'll need
> the explicit DAX check still, since we want to keep khugepaged and
> MADV_COLLAPSE away, and the presence / absence of ->huge_fault() isn't
> enough to know that (well.. today it kind of is, but we shouldn't
> depend on it).

You meant something like:

if (vma->vm_ops->huge_fault) {
    if (vma_is_dax(vma))
        return in_pf;

    /Fall through */
}
