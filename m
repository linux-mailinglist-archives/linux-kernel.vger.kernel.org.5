Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E22B753020
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 05:45:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234854AbjGNDpx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 23:45:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234575AbjGNDpu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 23:45:50 -0400
Received: from mail-ua1-x936.google.com (mail-ua1-x936.google.com [IPv6:2607:f8b0:4864:20::936])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0E52CD
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 20:45:49 -0700 (PDT)
Received: by mail-ua1-x936.google.com with SMTP id a1e0cc1a2514c-794cddcab71so511931241.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 20:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689306348; x=1691898348;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1MJCKHmrv9MaIFGp1+4/vT0KvyvKwB0GqGSw0AuyuZc=;
        b=MWDQLn+/YuEmPjKtEBd3KdrqmVrJEJrXFT8foVc1JOlxUIbuM8aUFU4v8Ouos+TeiK
         HYPPQ7mkRne+G7VE/1a0puBvsrmpXlt161Vzh850QRk1AAH0j2OeGTib34XkcGZiqDhd
         VlQho8wbLyDgllZ0tz1o+FwW2fWg2zyjI+Zn3T/wSKHFaWhXDKPmi93nhDuLbV9q7NrI
         UcejR+iiOJYJt//gEY06ETcZ9TUJO2rLCkjUrpqlUgvI34ixHrGnmGrP4/T2NPS9H/tm
         BVRKZjNqcevOd8yhlNparwykK5Onmwp/jRLeX1hrtaU9TBHIKhzqJRdYXEWpccl2dicb
         UpOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689306348; x=1691898348;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1MJCKHmrv9MaIFGp1+4/vT0KvyvKwB0GqGSw0AuyuZc=;
        b=Hu3gXNNvqI4ALg7+Bfx+A9eppys/Drf3xy74b/8YIpxrhsaCMQk3lEjhaBtc8Ob5TN
         w2Uh0+8RWVApnK37kasSjtiS3Ms++pnxwUlY7kOqTZqwNXX7PFzNP/hOTiNfU4rn8+S1
         jL7dojBJQlJib5AevxAjkSSIt3Lt0n7UQWycRqRwLBzpnQZqp6nOJysGJhHifzb/Whuv
         b7sj2KPZKgLM3zJeR0rmV4UhxhDaWQM61cl72gO2MysTr5u0ucJhGX9Lkbxoz4sXFoq6
         xvBHZsSoDLzK9Z0S2nq5vQHy2HJxh8b8fimUP2AjzFLKUkPgFeIn+HkSN4uuiehr2aaO
         guXQ==
X-Gm-Message-State: ABy/qLYlaecUC2BqsVb6BtoEiqWmbUeAk8Fvj5GfMM90Ahi5FDNcBG8E
        kNlkkfIXnoekKfg7DOIFYlWTMlHqNx4/6NIB0wo=
X-Google-Smtp-Source: APBJJlHQmBukGaFhBTntCDXAQ7gBU5N2OxEFZcaOWnIS3TYj189KcdD0LUxLyadukyLLyjUJIAxEbparLbuVa7Ly8ug=
X-Received: by 2002:a67:f3cf:0:b0:444:57aa:571 with SMTP id
 j15-20020a67f3cf000000b0044457aa0571mr2448984vsn.15.1689306348613; Thu, 13
 Jul 2023 20:45:48 -0700 (PDT)
MIME-Version: 1.0
References: <CAG-UpRQsdL_Fs9HSEv2pDYXehJC+YXcYjiZKFLvkGBTZkkaTcg@mail.gmail.com>
 <20230706120103.GJ2833176@hirez.programming.kicks-ass.net>
 <CAG-UpRTQ-ovVO02HRd5z-9oZGCPvZ0vODJse8oyuA9L-3NV_pQ@mail.gmail.com>
 <CAG-UpRRLFTHg64b0hG4=FbuzhhqNQEU8jGt6TygCVAK1BaT2kQ@mail.gmail.com>
 <20230707125942.GB2883469@hirez.programming.kicks-ass.net>
 <f4e839ac5ecb285b8a9d666f1a73e0a39b698864.camel@gmx.de> <CAG-UpRTur0PHkWNZ0FqLnz5K85P-HQkuO-PCCxOwJ5XVgwgxyQ@mail.gmail.com>
 <20230713125525.GH3139243@hirez.programming.kicks-ass.net>
In-Reply-To: <20230713125525.GH3139243@hirez.programming.kicks-ass.net>
From:   Henry Wu <triangletrap12@gmail.com>
Date:   Fri, 14 Jul 2023 11:45:37 +0800
Message-ID: <CAG-UpRT6j+7LXcTmD9Lgq6Mda3cs7tCTU9bdyiW_DgTd=FGdGg@mail.gmail.com>
Subject: Re: Fwd: Possible race in rt_mutex_adjust_prio_chain
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Mike Galbraith <efault@gmx.de>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Peter:

Peter Zijlstra <peterz@infradead.org> =E4=BA=8E2023=E5=B9=B47=E6=9C=8813=E6=
=97=A5=E5=91=A8=E5=9B=9B 20:55=E5=86=99=E9=81=93=EF=BC=9A
>
> On Sat, Jul 08, 2023 at 01:28:25AM +0800, Henry Wu wrote:
>
> > I will test final patch if available.
>
> https://lkml.kernel.org/r/20230707161052.GF2883469%40hirez.programming.ki=
cks-ass.net
>
> Does that work for you; could you reply with a tested-by if possible?

Sorry, I missed your patch and I will test it as soon as possible. I
will reply in two days.

Sincerely,

Henry
