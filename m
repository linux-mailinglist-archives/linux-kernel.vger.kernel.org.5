Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D9CC77CC74
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 14:19:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237020AbjHOMT0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 08:19:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237106AbjHOMTS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 08:19:18 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34E9612E
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 05:19:18 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id 6a1803df08f44-637aaaf27f1so15144346d6.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 05:19:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692101957; x=1692706757;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tp5Ij2LV/uTOWS+Y8dmmKUQgxJEtwU2IYb3qITnVExM=;
        b=Yo687ldn5jYOG/Isrq/qLIOstH0yTyk2vbkSLCUqFJM3LJyfM4ZR/KGH6c+fcsbzrm
         gBSvAKohAdhVHXgEhKz94n2i3rhCpUuVBtgGP9mjMePOUjeKFekjaGpZmiqEh/bYSb6u
         WHXEXFg1DuALPGPlGB/g+4Z2Nf7IxeUMsrhLCdPaJPjkA33Mv9ykTXgiEXyl6tslel8A
         gYrNfRLAUQAE7o5YSMdT8RV/UGBYvCp/gYM19aLEXSsltC6O6rcWosC1InudwcExOwtZ
         7mMupjPXdCmDP+f6xtmt1wPdhEPAq/2qRMcPPrtkMf3PY03fd3n3O6Wrxr7s0+IOqfSP
         GaPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692101957; x=1692706757;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tp5Ij2LV/uTOWS+Y8dmmKUQgxJEtwU2IYb3qITnVExM=;
        b=ZWVhJ1lYEq6waLB8nP6zpq8lHVkBGY+CPm8k06RE53sVf1K9Ku9DpXjJIjtVSj/E+s
         CWpiztN3V9EnWLGZk+Wjl4xt11Cly75QxWAaH0bG8LzxOWaPNs1oG4fijsEasdxGmHoV
         jjURdi6yowDr80IP7PtQ2mMNa0vexL+r5D2RGZ38ilRawzI5fBQtA30QDhNMlefeBzpt
         ffo14vE8KpC20E9pHvKdQaZVzUxJ0vC/nGYvzRnnkSwieZTLddDRDENjIFn8SXMtCJjm
         t4jpiHKuXFw5qLYsS8jK+P3ohKLmaSTVrF0NfXVNRm5/pPfFh+MSHsOnM/4MGLbmA1ai
         W3gA==
X-Gm-Message-State: AOJu0Yzd07Guw6OA1t+Va9vYGZqJfd0geL242jCfyz6K/oCJRapMAZNF
        oFNXqsYFa3MXPqHVLrdeQYjlDcvbCap5/JgIQcTyOXl62qlKqO13YSE=
X-Google-Smtp-Source: AGHT+IG7R0DVQ6nWtDCprMFF74FVWtvfvmEzXES+JWhEqh6YzpX0BtH0yRNBfE6Rz8s4//PSPYjZv7AKNPg+OgRFz44=
X-Received: by 2002:a05:6214:19e7:b0:63c:f852:aa3a with SMTP id
 q7-20020a05621419e700b0063cf852aa3amr17863905qvc.4.1692101957026; Tue, 15 Aug
 2023 05:19:17 -0700 (PDT)
MIME-Version: 1.0
References: <CABXGCsNTaNw3q1OciYq111vdr+-ouaRVmwVqVJH4iT0NqxFAcQ@mail.gmail.com>
 <20230813082413.GAZNiTLaOxUNUHPvlf@fat_crate.local> <CABXGCsNoNaGLsuvHLRA7aG9FCckQpnXaXWoUGvRwzfRKNB4xzA@mail.gmail.com>
 <20230813093502.GBZNijxgueFxBTxWwG@fat_crate.local> <CABXGCsMrNz2SPYN=zLZTT7jU4axSi-XLm4bTm7K3NuWnc=yr9g@mail.gmail.com>
 <20230813111425.GEZNi7EXyHOLQTNzFg@fat_crate.local> <CABXGCsO5=tEB29apcnPRF92yLQR-LD--vSGYPfLWAm0Z+++HRw@mail.gmail.com>
 <20230813141945.GFZNjmgZbHvMhLYtJl@fat_crate.local> <CABXGCsNSZD8GG1ZbpeNg54rjnsa9HQ3MumTgprLo8n5WE2VCoQ@mail.gmail.com>
 <20230814123713.GI776869@hirez.programming.kicks-ass.net>
In-Reply-To: <20230814123713.GI776869@hirez.programming.kicks-ass.net>
From:   Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date:   Tue, 15 Aug 2023 17:19:06 +0500
Message-ID: <CABXGCsNFUYH5BEpWmmhUqVpaM+QQh2RfbtDKKH_77ycxPTm67w@mail.gmail.com>
Subject: Re: [regression/bisected] Add IBPB decreases performance in two times
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Borislav Petkov <bp@alien8.de>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 14, 2023 at 5:37=E2=80=AFPM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
>
> Why do you care about speculation things on a dev box?

Because this dev box used as the primary workstation for everything
for work, for shopping, for banking, for watching films and playing
games.
This allows me to find bugs in hard-to-reach scenarios.

--=20
Best Regards,
Mike Gavrilov.
