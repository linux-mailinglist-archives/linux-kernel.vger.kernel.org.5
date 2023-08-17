Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D80A77FDE2
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 20:32:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354414AbjHQSbi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 14:31:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354484AbjHQSaP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 14:30:15 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECFB13AAF
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 11:29:45 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-5257d67368bso1652a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 11:29:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692296984; x=1692901784;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WkAgdDaWL5fNhn+jmFmfbxUk8CggEcM/uCFAi9gM/RM=;
        b=dc7ZJnjDNn02b6xO/Z1bwoGZ3PD9YuY0apXBEFZl6w+mtfqB8N9amVcCsfKmgS3NSy
         847mhWHHFfAit/4LRpbfu66Uiri9GQLt9SuIbOSRJ0OdRXHHiSctyuQZq/ltoaGjOlIT
         +iveTm+wL7zoltTBdQYgMnGJVxfNddqF5rFdR/dtfi38iDUUKA7fx7NWhnnqefQIi1u7
         RfoYf774AEPpsCoeyopmAjTYF2P0SY+XFYiDmdGBz8bJ/m7Yo29ar6tWtVqjhlrqX83A
         mEy8XeunfSC6tOAIPS230L3XynUWyiQ9f2lJbrKtln+K/pej/PNIkwR8wFynLyucDE4m
         Nq1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692296984; x=1692901784;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WkAgdDaWL5fNhn+jmFmfbxUk8CggEcM/uCFAi9gM/RM=;
        b=O9jbHDNi+wcDiekouIlHkBdycBZ0R+utoeCKpHcMX0Poz+P4K80KJPJGJFhCk/vqz4
         QgLGzat7X75aphgFcNeds8hrkbZrueVNoIFNoIktwPbeqa2JOO9vj7zf27rJn7XKsGYD
         tHBbbtuK7nXn77jWmc4HpFbqpHlpgz4DGF7rjGKmBWSti5+psX4bPryWJ0iIlu7cCA4D
         ZEg0C4+d2E40NapePJV3fW0O1mgDLKx4XOztel7rfoJbPGKpC+IT4TL4YbsFaUEu5ZE3
         /+AB5h311V/K9c/+GVV6J5/tQgbn5OUtJIC8nhQYiOKq2mgi9nGzDh+HL6ZqEP8f19cT
         Lqrw==
X-Gm-Message-State: AOJu0YxE38JsYPnNxXrKoQ3Teo7PheIoPhxU9/0FZAO/GV6n405kOW/U
        cZANw03NYuj0JJ1i4HxsgkVPJ9gT1luMQuyckE2ScA==
X-Google-Smtp-Source: AGHT+IEtIsv+ixBsWLC3dA9EiG1urEOCBhPubzen5tiXTL1APEp6KTLUispQNz5tnl3OlQYlWojaH/Ghb4hu2UiZfW4=
X-Received: by 2002:a50:d4da:0:b0:523:193b:5587 with SMTP id
 e26-20020a50d4da000000b00523193b5587mr15712edj.6.1692296984186; Thu, 17 Aug
 2023 11:29:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230812210053.2325091-1-zokeefe@google.com> <PUZP153MB06358FF02518EF3B279F5DD4BE16A@PUZP153MB0635.APCP153.PROD.OUTLOOK.COM>
 <CAAa6QmSrwe2m4MjS9mGO+DeGNGSv=B2uZ72EAxnZk2jsDh39rQ@mail.gmail.com>
 <ZNp7JDaPhT3Se4de@casper.infradead.org> <CAAa6QmSN4NhaDL0DQsRd-F8HTnCCjq1ULRNk88LAA9gVbDXE4g@mail.gmail.com>
 <ZNrh6w9ICu4rMrhV@casper.infradead.org> <PUZP153MB063529C4869A7A666C275B23BE15A@PUZP153MB0635.APCP153.PROD.OUTLOOK.COM>
 <CAAa6QmRrnRHEEQMMYe20GLXj7g+LVVHVRAKUdSLy=jUW=khb2A@mail.gmail.com> <CAHbLzko_xLiqkNgjA7DhVFBSW6qJdAwgfk557YKV+ZpwS2x16w@mail.gmail.com>
In-Reply-To: <CAHbLzko_xLiqkNgjA7DhVFBSW6qJdAwgfk557YKV+ZpwS2x16w@mail.gmail.com>
From:   "Zach O'Keefe" <zokeefe@google.com>
Date:   Thu, 17 Aug 2023 11:29:06 -0700
Message-ID: <CAAa6QmSxab2-m-RopQtZnBpxTLX25K=KZE+EPmA+wWb_yTqf0Q@mail.gmail.com>
Subject: Re: [EXTERNAL] [PATCH] mm/thp: fix "mm: thp: kill __transhuge_page_enabled()"
To:     Yang Shi <shy828301@gmail.com>
Cc:     Saurabh Singh Sengar <ssengar@microsoft.com>,
        Matthew Wilcox <willy@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 17, 2023 at 10:47=E2=80=AFAM Yang Shi <shy828301@gmail.com> wro=
te:
>
> On Wed, Aug 16, 2023 at 2:48=E2=80=AFPM Zach O'Keefe <zokeefe@google.com>=
 wrote:
> >
> > > We have a out of tree driver that maps huge pages through a file hand=
le and
> > > relies on -> huge_fault. It used to work in 5.19 kernels but 6.1 chan=
ged this
> > > behaviour.
> > >
> > > I don=E2=80=99t think reverting the earlier behaviour of fault_path f=
or huge pages should
> > > impact kernel negatively.
> > >
> > > Do you think we can restore this earlier behaviour of kernel to allow=
 page fault
> > > for huge pages via ->huge_fault.
> >
> > That seems reasonable to me. I think using the existence of a
> > ->huge_fault() handler as a predicate to return "true" makes sense to
> > me. The "normal" flow for file-backed memory along fault path still
> > needs to return "false", so that we correctly fallback to ->fault()
> > handler. Unless there are objections, I can do that in a v2.
>
> Sorry for chiming in late. I'm just back from vacation and trying to catc=
h up...
>
> IIUC the out-of-tree driver tries to allocate huge page and install
> PMD mapping via huge_fault() handler, but the cleanup of
> hugepage_vma_check() prevents this due to the check to
> VM_NO_KHUGEPAGED?
>
> So you would like to check whether a huge_fault() handler existed
> instead of vma_is_dax()?

Sorry for the multiple threads here. There are two problems: (a) the
VM_NO_KHUGEPAGED check along fault path, and (b) we don't give
->huge_fault() a fair shake, if it exists, along fault path. The
current code assumes vma_is_dax() iff ->huge_fault() exists.

(a) is easy enough to fix. For (b), I'm currently looking at the
possibility of not worrying about ->huge_fault() in
hugepage_vma_check(), and just letting create_huge_pud() /
create_huge_pmd() check and fallback as necessary. I think we'll need
the explicit DAX check still, since we want to keep khugepaged and
MADV_COLLAPSE away, and the presence / absence of ->huge_fault() isn't
enough to know that (well.. today it kind of is, but we shouldn't
depend on it).
