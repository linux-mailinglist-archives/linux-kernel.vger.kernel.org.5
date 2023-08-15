Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE0AE77C44C
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 02:06:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233605AbjHOAF3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 20:05:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233784AbjHOAF0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 20:05:26 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E22B6124
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 17:05:25 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-3fe2a116565so21075e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 17:05:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692057924; x=1692662724;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qNAjR5087SyIRll55Tg36V4TelXhAR59suyGWAJNzX8=;
        b=3fV8hMPZoERTZqelkQR6yMePUDw1HupWVsdS05m/eVlEIQbwYerQw570ZbEIGRLIXJ
         MGSLJ5s0UQ/hZOFrW46Cx4U+bDxv9PakJkfhmokntY7Sl4BC/JH344Sx5HlEarMHVE0L
         8niUx6CLzy2xpPkuw9eobdzsLmy1R1qovfKrOfxBUo6IziwiYbcZtqoL8jP7fWnPFw4d
         cu923CWrrLe3U2eUx4Tts6yVDT+9Od4Sc/UxoBqtRzYWRzS73EPEWGxYuJIeUqEhgx9D
         7CHfB5tu9AdtjKQ501QMyQKG8tRECMn3ijrNXSFx1zi8lXAjh4rxgXp0Sih/50xihe1w
         5qBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692057924; x=1692662724;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qNAjR5087SyIRll55Tg36V4TelXhAR59suyGWAJNzX8=;
        b=Eo8zcvuS3bOQ9j8ORfnt7K0k/vJgoB677FYudTBUTLI9sUdhyeBqgqbOXVp+LgWBJO
         oFszIWf6QBbJ4uo1YHhown7n2TUdvtCt2TVjYUBy1Kj6uPABW1yAJ8S2Vkp1NCE/C12r
         sUOvCf9YDD6TsmOp6JZ6ytSH9wFXUp1/DHx752wSB3fEwvXmeEEzT5mPOofreaB96G+r
         4ejpLojTjXWhQ/btkvNtFniDCdAudv9aD9/kwGyiODzn4fxdQ4lzUQMpcXlbvR+rw5KS
         B8axcSdjs+m0OP61ed45gLW0PMwV7DlBSx1NpbCHliGTvwyBI/T+UE+zaGHnLxmzLe5U
         eprQ==
X-Gm-Message-State: AOJu0Yxz7tMl9UGMaRiMkgp94hTglOEx7paxJPvoG6tE7JI+F1mTnecE
        pGCZYUeyaMK3RKDoEPPMb3s0fdtqkbs3lXQHuYpVlA==
X-Google-Smtp-Source: AGHT+IHe0RGOqaXy/zODryo9gaeKhb84uQYlaJaiaOBpufpAS/ZSJ7FSpEGgz/bwN9alEn8z85+2XyQImw0PYosguTk=
X-Received: by 2002:a05:600c:3ba2:b0:3f7:3e85:36a with SMTP id
 n34-20020a05600c3ba200b003f73e85036amr334971wms.7.1692057924274; Mon, 14 Aug
 2023 17:05:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230812210053.2325091-1-zokeefe@google.com> <PUZP153MB06358FF02518EF3B279F5DD4BE16A@PUZP153MB0635.APCP153.PROD.OUTLOOK.COM>
 <CAAa6QmSrwe2m4MjS9mGO+DeGNGSv=B2uZ72EAxnZk2jsDh39rQ@mail.gmail.com> <ZNp7JDaPhT3Se4de@casper.infradead.org>
In-Reply-To: <ZNp7JDaPhT3Se4de@casper.infradead.org>
From:   "Zach O'Keefe" <zokeefe@google.com>
Date:   Mon, 14 Aug 2023 17:04:47 -0700
Message-ID: <CAAa6QmSN4NhaDL0DQsRd-F8HTnCCjq1ULRNk88LAA9gVbDXE4g@mail.gmail.com>
Subject: Re: [EXTERNAL] [PATCH] mm/thp: fix "mm: thp: kill __transhuge_page_enabled()"
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Saurabh Singh Sengar <ssengar@microsoft.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Yang Shi <shy828301@gmail.com>,
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

On Mon, Aug 14, 2023 at 12:06=E2=80=AFPM Matthew Wilcox <willy@infradead.or=
g> wrote:
>
> On Mon, Aug 14, 2023 at 11:47:50AM -0700, Zach O'Keefe wrote:
> > Willy -- I'm not up-to-date on what is happening on the THP-fs front.
> > Should we be checking for a ->huge_fault handler here?
>
> Oh, thank goodness, I thought you were cc'ing me to ask a DAX question ..=
.

:)

> From a large folios perspective, filesystems do not implement a special
> handler.  They call filemap_fault() (directly or indirectly) from their
> ->fault handler.  If there is already a folio in the page cache which
> satisfies this fault, we insert it into the page tables (no matter what
> size it is).  If there is no folio, we call readahead to populate that
> index in the page cache, and probably some other indices around it.
> That's do_sync_mmap_readahead().
>
> If you look at that, you'll see that we check the VM_HUGEPAGE flag, and
> if set we align to a PMD boundary and read two PMD-size pages (so that we
> can do async readahead for the second page, if we're doing a linear scan)=
.
> If the VM_HUGEPAGE flag isn't set, we'll use the readahead algorithm to
> decide how large the folio should be that we're reading into; if it's a
> random read workload, we'll stick to order-0 pages, but if we're getting
> good hit rate from the linear scan, we'll increase the size (although
> we won't go past PMD size)
>
> There's also the ->map_pages() optimisation which handles page faults
> locklessly, and will fail back to ->fault() if there's even a light
> breeze.  I don't think that's of any particular use in answering your
> question, so I'm not going into details about it.
>
> I'm not sure I understand the code that's being modified well enough to
> be able to give you a straight answer to your question, but hopefully
> this is helpful to you.

Thank you, this was great info. I had thought, incorrectly, that large
folio work would eventually tie into that ->huge_fault() handler
(should be dax_huge_fault() ?)

If that's the case, then faulting file-backed, non-DAX memory as
(pmd-mapped-)THPs isn't supported at all, and no fault lies with the
aforementioned patches.

Saurabh, perhaps you can elaborate on your use case a bit more, and
how that anonymous check broke you?

Best,
Zach
