Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BE9878B9F7
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 23:08:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233453AbjH1VIS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 17:08:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233427AbjH1VIL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 17:08:11 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ACCEC3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 14:08:06 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-50078e52537so5609603e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 14:08:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1693256884; x=1693861684;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RRmQEK5WwKSCABpALS8Kzk3ShxzNjvpPaFboLF2ykio=;
        b=PsiGM7xLxOBS2ZIfFkZnq147rbs64ETg/Da1doYeVsHh9zPGkaFb9nKInSt4qAkP/l
         LMwm7OB+U4FIZJasPWz4xTOCue82k6BWus4qWg24thkdAu4tNVbpSbnY6j9a8Y0JS1dA
         nEDIIF9Q+cRu5hEFvHxRlay5JdhNQDkV5cn0Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693256884; x=1693861684;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RRmQEK5WwKSCABpALS8Kzk3ShxzNjvpPaFboLF2ykio=;
        b=U8HWnlGE+spxi4qzX2+zEo5NtTk7LNcCY4oWYe57eYVXfx9mGFs5MZjcmbLMX6IgYU
         vk42F16N1LWjFbzniCTVHR/Qrnzq8XaQnOFsHmMHhxIsXS8Cs5vtHtjSs7MBZo93E/HT
         maBuBlGMa6I0k8g5CfRnUkDdtEN5fbSBHabJV5lprjwLYoWXa6nuRqX8VesmL3Vlub9s
         xkg/4xp5lxDvFPFSztIl73waPCsmHQJryioXiEn7JKTenoiWHq63BDZwxGJ3/ypdAx7m
         5YPZ27hHLBt8KuvwshOnUPMYkSnU4ialg06qm9kz5ITbY5aW3dtnl3vFfArFIlWim7lj
         XbXg==
X-Gm-Message-State: AOJu0Yw3RnoXYA3Hw6dtn0KTv4He3SfNNR9qP4jtyPMsBPt6kOppWU6y
        TmjWBcKdvd3ID0VIyLWbSUwVi2GLakLdytEWehnNP5hJ
X-Google-Smtp-Source: AGHT+IH/pfLzIFioqcAm/jun48Y0P/Pu2M83JmheLgBkaKfySqKKsTI7ej/jmOZTRFzDTLXPsJ06YA==
X-Received: by 2002:a05:6512:3084:b0:500:be57:ce53 with SMTP id z4-20020a056512308400b00500be57ce53mr1728987lfd.42.1693256884621;
        Mon, 28 Aug 2023 14:08:04 -0700 (PDT)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com. [209.85.208.47])
        by smtp.gmail.com with ESMTPSA id a20-20020a1709064a5400b00992b50fbbe9sm5106331ejv.90.2023.08.28.14.08.04
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Aug 2023 14:08:04 -0700 (PDT)
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-52a4737a08fso4766295a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 14:08:04 -0700 (PDT)
X-Received: by 2002:a17:907:78d8:b0:9a1:e994:3444 with SMTP id
 kv24-20020a17090778d800b009a1e9943444mr12705233ejc.3.1693256883770; Mon, 28
 Aug 2023 14:08:03 -0700 (PDT)
MIME-Version: 1.0
References: <169322654636.420889.373907562030292433.tglx@xen13.tec.linutronix.de>
In-Reply-To: <169322654636.420889.373907562030292433.tglx@xen13.tec.linutronix.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 28 Aug 2023 14:07:46 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjomZiu4QiyjAH=RSTsdZCpcjq-0yD42dLMN2+rcm4_cg@mail.gmail.com>
Message-ID: <CAHk-=wjomZiu4QiyjAH=RSTsdZCpcjq-0yD42dLMN2+rcm4_cg@mail.gmail.com>
Subject: Re: [GIT pull] core/entry for v6.6-rc1
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Aug 2023 at 06:01, Thomas Gleixner <tglx@linutronix.de> wrote:
>
> A single update to the core entry code, which removes the empty user
> address limit check which is a leftover of the removed TIF_FSCHECK.

Heh. Lovely. I wonder if we have other cases of #ifdef's that just
aren't #define'd anywhere any more.

But I'm too lazy and/or incompetent to write up some trivial script to check.

            Linus
