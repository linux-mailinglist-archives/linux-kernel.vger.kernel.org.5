Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1DBD769D9F
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 19:03:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233861AbjGaRDt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 13:03:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233765AbjGaRDZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 13:03:25 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBFD01BFC
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 10:03:20 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id ca18e2360f4ac-77a62a84855so196667139f.1
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 10:03:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690823000; x=1691427800;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D3We0Pjfeto6x+8/3+vWSKZAky3jpjh0KVMoTtJoMJk=;
        b=CuRZBemxY3kxHUoWe2ipqpPyM+HmelTNdj6+wEjLS9QawjKxa4ZFLvvR2DVeKNyeD5
         gjg5yBejpkzRxMFLRtYmLJP2YiS+AalU2+zAembiGEu97PS3b+Rx8tqgzdhrrZZ3kmWn
         1jM20qwCiZLLm7oUXRtRfLmUm+u/FVvNej+JZYnF4lYSbgIvBXtM5UOHya41r+hB6sjc
         2UA5sduWy1XPJO+3jxx/wqxVk8YdiO3fyMQE6u4vNXoOaDotUZ4Ng0SYFpHLeE2pJpzw
         DwZ7MdXfM57hdGw/lksO21WGP8ff+rb5ntSZ1EwMtC+aGmEB+8yJsbM3gT6s6YUUgygB
         3XVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690823000; x=1691427800;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D3We0Pjfeto6x+8/3+vWSKZAky3jpjh0KVMoTtJoMJk=;
        b=PkY/EYi0cgbLBPPLjftuT2EvLIIURSVDe1d9HFgDBCVkZznPN2op8QCrDB9BJCtSWA
         hFchdP830Jhn6fcyyYWSqq7p0z5fokHzg9yonB9joitcpjG8n/K1vzIUfEgPbyfP5t7i
         9s4YvrD2HmmBPOFHBhMXqa5ABZhRo5C2IFuzyLvH9V5kwglpwq5pMcQDAw/gkhXCw1DX
         2lveSgBhl/WOV/QyXuD1OGKrfFhcJOcE5NKpAB4smHO62m4IExK3UzX0qNSouQQT9a7J
         xiVzI5S5gahhlhKdILEUqhobdc5L6yg13TkmGFML/SV49fuR69oZlw13klPNdA0/Fl5q
         jeKw==
X-Gm-Message-State: ABy/qLYXRkPe9eYHiZrzdhgQlQCx4QAipSBuO/LEKkmz41K47gCbJdVx
        M/0N1pT6/0OOsmG2z+sAoH/YzC0L2eVK2Mdi6EL36A==
X-Google-Smtp-Source: APBJJlEvDDa00vuUmNtFT5f1pqL9ZR6XTOF/J1p+DtZaCik5UdmXeUhRrnA749pGHWwReQuvm5L/XhRN4lx1Gkg86as=
X-Received: by 2002:a6b:db01:0:b0:787:5ca:d4f with SMTP id t1-20020a6bdb01000000b0078705ca0d4fmr8694429ioc.8.1690822999821;
 Mon, 31 Jul 2023 10:03:19 -0700 (PDT)
MIME-Version: 1.0
References: <20230727011612.2721843-1-zhangpeng362@huawei.com>
 <20230727011612.2721843-4-zhangpeng362@huawei.com> <CAG_fn=WK4Wyh-xeV_-71p3Yms6ZyXbSduAqMZknh1+3XHbgYfg@mail.gmail.com>
In-Reply-To: <CAG_fn=WK4Wyh-xeV_-71p3Yms6ZyXbSduAqMZknh1+3XHbgYfg@mail.gmail.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Mon, 31 Jul 2023 19:02:43 +0200
Message-ID: <CAG_fn=Vi3WH1fTQRT_KGvRxGmBg3b8pd29OgLRvxHB3556Ffrg@mail.gmail.com>
Subject: Re: [PATCH 3/3] mm: kmsan: use helper macros PAGE_ALIGN and PAGE_ALIGN_DOWN
To:     Peng Zhang <zhangpeng362@huawei.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org, elver@google.com,
        dvyukov@google.com, kasan-dev@googlegroups.com,
        akpm@linux-foundation.org, wangkefeng.wang@huawei.com,
        sunnanyong@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 31, 2023 at 7:02=E2=80=AFPM Alexander Potapenko <glider@google.=
com> wrote:
>
> On Thu, Jul 27, 2023 at 3:16=E2=80=AFAM 'Peng Zhang' via kasan-dev
> <kasan-dev@googlegroups.com> wrote:
> >
> > From: ZhangPeng <zhangpeng362@huawei.com>
> >
> > Use helper macros PAGE_ALIGN and PAGE_ALIGN_DOWN to improve code
> > readability. No functional modification involved.
> >
> > Signed-off-by: ZhangPeng <zhangpeng362@huawei.com>
> Reviewed-by: Alexander Potapenko <glider@google.com>

Thanks for the series!
