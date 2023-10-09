Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 426547BDB72
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 14:19:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346498AbjJIMTx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 08:19:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346742AbjJIMTl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 08:19:41 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BC6AD4C
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 05:17:46 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id 6a1803df08f44-65b162328edso25603846d6.2
        for <linux-kernel@vger.kernel.org>; Mon, 09 Oct 2023 05:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696853865; x=1697458665; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m6/vE8g+hycoIkP+nnT3t3DO9SbrtMni1szfWJaCTpw=;
        b=Ksmgt78eZCTVL7OvUzBCZMR3vY8PA9pxzs6jKdssmGzByEuoa7acNQtWXG02WSwI/c
         wSKpWJZbiGJBjpGrGxFbDVjAZqLS+jlqm9NRq/XJ/lz6Gu4Rx8+jC1fEI+SLfKVNDTwK
         tYrqCxzGVijOKKtLTpTTOjEAF8K4h8qNow08q0OxJbj7QuBRwl7lDAoDVU+AgpUmgIqM
         A61Jc+DWXAGIZzb8WD2Ra/MtDYjjzUFspEpHqlcy6A1/71YYOJoPy02qYWARwD19EQ/q
         qsFnZENxttHYueFdrEcwhVnZZa5QW1H+aqRgZtIxj4AyaoHcP5d3feDC8bq1kk2PPXCh
         dXiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696853865; x=1697458665;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m6/vE8g+hycoIkP+nnT3t3DO9SbrtMni1szfWJaCTpw=;
        b=HSZIB9zlULbR8pTZaonsR5A/1LhgbdrsxIe9HLmQf50AS/xY5BRmde0/87XutUq7Rj
         iFJYcl4G0OHjhS6mL/46spWTrOO/VinlF8+GZFudt+4Rzzf5CVvBlCs2v2pz2DH5MHEY
         m1CfusEccVrjdPa/sqbkz8Yqr2QInpkWEdbtLhszj9xmiZT0o0igEi+P6p1lBN2/9WMn
         nz4L6FJ4c/ENQkb+4t7FAppMWQPcKnv4N7yornHLWaFbzy8rUKrtzF7/+aH7q0Su/Pp6
         Fy42E4QxUuyuSSkQSWx2YqWRJJjAmaNumbeoiWhLINskVcoDDmPsmgndA8UOeTLwE2c3
         GfEA==
X-Gm-Message-State: AOJu0YzVsMqd0UeEQLoLSb/yUlpjcv3SGhAdrNBjZ6e1a1M2tajWwGlc
        n6b5lU/xtUo1CEJSdBd1frSfsrWUTtmWvy5DHEe8VQ==
X-Google-Smtp-Source: AGHT+IFhs2k/TyDD5/iYV5wL0FKoOo8JCqhjS3ftDlVLdIFQFD2KcrFVPFOVAQBtol3VEqZjU+BgtyCTsjO/wD4H1M4=
X-Received: by 2002:a0c:c409:0:b0:64f:3699:90cd with SMTP id
 r9-20020a0cc409000000b0064f369990cdmr15621669qvi.42.1696853865508; Mon, 09
 Oct 2023 05:17:45 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1694625260.git.andreyknvl@google.com> <293d73bcd89932bc026263d3df8ee281ad3f621f.1694625260.git.andreyknvl@google.com>
In-Reply-To: <293d73bcd89932bc026263d3df8ee281ad3f621f.1694625260.git.andreyknvl@google.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Mon, 9 Oct 2023 14:17:09 +0200
Message-ID: <CAG_fn=WXiE1=NjE-NHsXwttJuMmqu1nQURH5ZeTknK0yT0cpoQ@mail.gmail.com>
Subject: Re: [PATCH v2 18/19] kasan: check object_size in kasan_complete_mode_report_info
To:     andrey.konovalov@linux.dev
Cc:     Marco Elver <elver@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, kasan-dev@googlegroups.com,
        Evgenii Stepanov <eugenis@google.com>,
        Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
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

On Wed, Sep 13, 2023 at 7:18=E2=80=AFPM <andrey.konovalov@linux.dev> wrote:
>
> From: Andrey Konovalov <andreyknvl@google.com>
>
> Check the object size when looking up entries in the stack ring.
>
> If the size of the object for which a report is being printed does not
> match the size of the object for which a stack trace has been saved in
> the stack ring, the saved stack trace is irrelevant.
>
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
Reviewed-by: Alexander Potapenko <glider@google.com>
