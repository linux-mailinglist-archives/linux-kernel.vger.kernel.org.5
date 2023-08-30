Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EB4978DF5D
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 22:14:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240574AbjH3TT2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 15:19:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242258AbjH3HmC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 03:42:02 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA5FECD8
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 00:41:56 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id ca18e2360f4ac-7951f0e02ecso11037639f.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 00:41:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693381316; x=1693986116; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kwOnzp96+NaUMFkX4e+N6heHm1OXXvklEEOWXELjx0E=;
        b=ggMBlLWyN6rBvWDA/oq0ihmWqnkLo8JJzeG2QxLP0AyFHQBcF43o9f7F8SF49RHNVE
         /Qm1ltHGGW4pGIO/To49DNz80KwmBKP3jSdA2BOQpzWkKWdFV+U/c3O7oCk9V+qRiWYq
         2nfyjfOQQR563XyxtwEF/RKwZKmB1eh3vNswjRHGegDFPvsO+gzzNdq+zOiMmNMCopuC
         Ruy2yfbZdJ2AaeF0dfOa9gpPlbB/oQ19VZ/+ern7zS6DWKuTS1VccXfQ4OdODe4bQVtn
         buVzDrUS9TDpc01vLRHlsmSWiQMDYKAiduxI/nIYN9rUgoBwxPMu0hV23L/XLMF6YPte
         67zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693381316; x=1693986116;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kwOnzp96+NaUMFkX4e+N6heHm1OXXvklEEOWXELjx0E=;
        b=DNLA13JGtG847k0DVXvtyVnsnT7o/3b8yxY0oGucBmU+X1AsOblQiFooDJ3G4xLOuE
         MpWqbxRfWLCj831YsL2Z2//0Sv5xDBr0LhVc+/JJOABzfVKf4hdUUYwFCOiDeFUIvi+1
         n2yJ3ndGs9bF9YE++vfShXx9I8VoG05KfyikSrxwsK0roB4PoKgonGphMmmCJKaAzrUI
         +i9EZGZxuo5M4EAjGhrKd2+JHEVeqZrGFyr7P24GWodRLOB3+wocB/eic4q8GGakOFA6
         5VCnPNaJLMQyRPmTR9B232wYWznfxQ0TaZX1ByKM6+oCkbPXzMz96PLlSeatChVAB6kR
         OoGA==
X-Gm-Message-State: AOJu0YxvahSrhKZsOgK5lVpEk6y4752wk0xLxu2pt6UvDlFvDJlLOEjT
        AfclyVdkW9+6EgXire6iwDpO5rkLqsh3XpDyWlydIA==
X-Google-Smtp-Source: AGHT+IHnlH8T841/U7zxVM8rzI6aAaHgJzNBrhwH1VTR1KHTectxQpR+q8ReMBiLUaJN7OO5qlZqQA0EiGXPHuIwJdo=
X-Received: by 2002:a5e:c91a:0:b0:783:7275:9c47 with SMTP id
 z26-20020a5ec91a000000b0078372759c47mr1716516iol.7.1693381316001; Wed, 30 Aug
 2023 00:41:56 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1693328501.git.andreyknvl@google.com> <20dbc3376fccf2e7824482f56a75d6670bccd8ff.1693328501.git.andreyknvl@google.com>
In-Reply-To: <20dbc3376fccf2e7824482f56a75d6670bccd8ff.1693328501.git.andreyknvl@google.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Wed, 30 Aug 2023 09:41:19 +0200
Message-ID: <CAG_fn=UB422b6KP-BLKKyCNuRORGtBWF6kY5mHHJfFQ14779DQ@mail.gmail.com>
Subject: Re: [PATCH 02/15] stackdepot: simplify __stack_depot_save
To:     andrey.konovalov@linux.dev
Cc:     Marco Elver <elver@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, kasan-dev@googlegroups.com,
        Evgenii Stepanov <eugenis@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 29, 2023 at 7:11=E2=80=AFPM <andrey.konovalov@linux.dev> wrote:
>
> From: Andrey Konovalov <andreyknvl@google.com>
>
> The retval local variable in __stack_depot_save has the union type
> handle_parts, but the function never uses anything but the union's
> handle field.
>
> Define retval simply as depot_stack_handle_t to simplify the code.
>
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
Reviewed-by: Alexander Potapenko <glider@google.com>
