Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 443797DF734
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 16:58:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376918AbjKBP6d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 11:58:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347658AbjKBP6c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 11:58:32 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9425113D
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 08:58:29 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id 3f1490d57ef6-d9beb863816so1120551276.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Nov 2023 08:58:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1698940709; x=1699545509; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XNEPrHtpWZXoQfJIOfV77wIMEMFhpxTl9HwUi1VWxhY=;
        b=QwAwY1wIe135pS/OaQpCwtgjlp8PckcDf+c1gf/XsP5B6nOnM3yxZiB3IdcOKZdKO5
         AHIyjpbuzhlTgZeP2Ha4U4/lhv/YQCR45woC8I8dV/J0PKIUV1Vyb53B0jYHROAbtk1h
         FEGPXO4JsrRwIKSrR0mNSDw8aQpOoEF3GogsgYQA5fUthxg0TE3wv/4uItKFcnX6VNbQ
         scNxlS2+jMyWAd/h8W4EHwg15ifDfmOB7V+31Qv26kCliwvrDPjEui3FCxt4J6IcBBqp
         SWGmd1mpy43wpbrBq6rbKuRZl4cIE1JD6kZMCgs9/l9AGeWiQaxTfzSCx4b6wlSUub+C
         VjaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698940709; x=1699545509;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XNEPrHtpWZXoQfJIOfV77wIMEMFhpxTl9HwUi1VWxhY=;
        b=escD5CHYcWlpHI1SaGnmL2AKgilztUcX3ZOSQbJfBk4G0/xcmsMjXaHxLvR4YzXJHd
         zWwJep49lkpYQOFz14F/BIOmfYPEW98p6jVmE6gUxtX96oNT7WT3zA9HYkeATMtmV5yG
         IwquiAnp/jQZwK4lQAH99rk4fe9wtQ8iyGm5DeesREBYsjjAVPhSLh/53gKZ4/zOHe0n
         k611F6u0hbY0P6Tqfi4cXwOsr4PSubJWjdBlc1+2hJumdy35fQgFE92vlFFuLwONFd/L
         uQfYufWsndD1bmq9ATX0WpAoi+GCHBpXFNtYOkraLKQOMiD1KxjQM/9zj/7L1VAc1pHY
         HsHQ==
X-Gm-Message-State: AOJu0YxUnzudrcssOpbcIL0m9AgUtOz1qxHdoAjJAeyETWFlnimMUAN+
        Dr9PSo5PuJ6fTGMPXJwffJx+w/JqbrNoDyP1mE4deg==
X-Google-Smtp-Source: AGHT+IF1f4Ty+Vh8knd8cOh5yMOedkwEBaET2+CuYstsFQXP9Qws7opMHu00sYoRsA3vWpGcDnE57SVqvvlBibRBQiQ=
X-Received: by 2002:a25:ae10:0:b0:da0:5b63:d062 with SMTP id
 a16-20020a25ae10000000b00da05b63d062mr19548830ybj.35.1698940708790; Thu, 02
 Nov 2023 08:58:28 -0700 (PDT)
MIME-Version: 1.0
References: <20231026233837.612405-1-debug@rivosinc.com> <ZUPEDWofcqgzsgMS@debug.ba.rivosinc.com>
 <20231102085609.39a22424bba9a75a1523e23b@linux-foundation.org>
In-Reply-To: <20231102085609.39a22424bba9a75a1523e23b@linux-foundation.org>
From:   Deepak Gupta <debug@rivosinc.com>
Date:   Thu, 2 Nov 2023 08:58:17 -0700
Message-ID: <CAKC1njQH_WgvQOonme8bgWm9FXvayBQKR1536Z8G_yX9LuvCcg@mail.gmail.com>
Subject: Re: [PATCH v6] scripts/gdb: add lx_current support for riscv
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     woodrow.shen@sifive.com, Andrew Jones <ajones@ventanamicro.com>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Kieran Bingham <kbingham@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Glenn Washburn <development@efficientek.com>,
        Jeff Xie <xiehuan09@gmail.com>, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 2, 2023 at 8:56=E2=80=AFAM Andrew Morton <akpm@linux-foundation=
.org> wrote:
>
> On Thu, 2 Nov 2023 08:45:17 -0700 Deepak Gupta <debug@rivosinc.com> wrote=
:
>
> > Ping
> >
> > + CC: akpm@linux-foundation.org
> >
> > Who should I ping to make sure that it lands up in mainline?
> > It's quite a trivial change to support lx_current riscv arch.
>
> I moved it from mm.git's mm-nonmm-unstable branch into the
> mm-nonmm-stable branch earlier this week.  mm-nonmm-stable is what I'll
> be sending to Linus later this merge window.
>
Thanks
