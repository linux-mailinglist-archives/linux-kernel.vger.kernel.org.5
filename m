Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33EA777BA98
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 15:51:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230319AbjHNNuy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 09:50:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231661AbjHNNuY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 09:50:24 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AD2110FB
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 06:50:22 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-99cdb0fd093so597643566b.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 06:50:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692021020; x=1692625820;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=h8OPGW4e9NC10NDchxEU3Fww0ji4s/MwbD4JKceGo9s=;
        b=exBtjx4plgLrWpWvDxnmoIel44QiimXMrb6ED/7yZfOQRpxhsLNrBpBXFp2jPsB5U6
         kSKfOAKyxYO1lu30RA0c9EA5A1Z37MAtxrjn36oOJ1BOQd1C8z57xn5JeEWHAbPkwP9M
         JpbDtB8rsNXAK2p/IRNrSTNRTWkpWFyWAHVN7iQIO3xqQ3xnV9Ml8c9flASnvkGgY8Xz
         GBSwJCHigbIeOWjYQA2Om6aKkHgiYMkFYwjz6FVv0bcV26Q7ABzJaa/YxcyV3knNybsI
         o8HY19mbC6HJfGpQDUbb5pyvebnj248zifKggn8fG6CTZVloCu/rGCnkqaI6QSnDWGnI
         OylA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692021020; x=1692625820;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h8OPGW4e9NC10NDchxEU3Fww0ji4s/MwbD4JKceGo9s=;
        b=dAzMzVkFq/lixAHfpbYbo7bTmPmlYLnOsGwkIL/z+gQVboOt3+b6Of7Du+aCfxup36
         kvjUCI3PPO/c+bMgO6l8Qjn+43I02146pbQjtH2JLjhgYPiXLbbiPzzhbaWzsnX/RYwP
         WSqpx1rzVbtl0BYESW+gDmEqDShnV3P7VRAqdtWIrQR64R8M4KaxdRhYTXrXi6/cO6OV
         VWrtdwIVVniwg1IzbE293noreYxZLQMwRyCCqXyENQ3Aopa8gA1lyWHdE5gdMPvYxtcD
         Ucw92gmIhBWQKeARJwwD1/Uw8x/ZJK3AFQJfLJzBFYXLIQNWT7Gdsi2JpCkjwvBVkqSp
         mqSg==
X-Gm-Message-State: AOJu0YxhV4NS7D5v04kA9A0xntj7p6MvPsY/k7p22jPcQe37HKmzBQ4g
        9WbsFSfdMZNoDPg2ouoQQ6jj9kWxdIi1rg==
X-Google-Smtp-Source: AGHT+IHJhOwE/X/OVV6jGMjthjGfM8VwDblBa+ZweMorP0hfzZ3t7EMvei4rkxHqKxKUcdJAeHFAew==
X-Received: by 2002:a17:906:5dc1:b0:991:e24f:b288 with SMTP id p1-20020a1709065dc100b00991e24fb288mr7303027ejv.26.1692021020280;
        Mon, 14 Aug 2023 06:50:20 -0700 (PDT)
Received: from nam-dell (ip-217-105-46-58.ip.prioritytelecom.net. [217.105.46.58])
        by smtp.gmail.com with ESMTPSA id d2-20020a170906640200b0099d0c0bb92bsm5656966ejm.80.2023.08.14.06.50.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Aug 2023 06:50:19 -0700 (PDT)
Date:   Mon, 14 Aug 2023 15:50:17 +0200
From:   Nam Cao <namcaov@gmail.com>
To:     =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: test code for kprobe
Message-ID: <ZNoxGXcK9QOfAfbW@nam-dell>
References: <cover.1690704360.git.namcaov@gmail.com>
 <fc71730b9350026427fe1c2bdbce9b993d8bc6f5.1690704360.git.namcaov@gmail.com>
 <87il9hg65g.fsf@all.your.base.are.belong.to.us>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87il9hg65g.fsf@all.your.base.are.belong.to.us>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 14, 2023 at 02:28:11PM +0200, Björn Töpel wrote:
> Nam Cao <namcaov@gmail.com> writes:
> 
> A RISC-V specific kprobes test -- much welcome!
> 
> Please add a proper commit message here.
> 
> > ---
> >  drivers/test_kprobe/Makefile      |   3 +
> >  drivers/test_kprobe/test_kprobe.c | 265 ++++++++++++++++++++++++++++++
> >  2 files changed, 268 insertions(+)
> >  create mode 100644 drivers/test_kprobe/Makefile
> >  create mode 100644 drivers/test_kprobe/test_kprobe.c
> >
> > diff --git a/drivers/test_kprobe/Makefile b/drivers/test_kprobe/Makefile
> 
> Architecture specific test code usually reside in "arch/$ARCH"
> (arch/riscv), and is part of Kconfig.debug.
> 
> Have a look at:
> * grep for ARM_KPROBES_TEST in arch/arm
> * grep for KPROBES_SANITY_TEST, and in arch/powerpc grep
>   test_emulate_step
> * grep S390_KPROBES_SANITY_TEST

Sorry that I wasn't clear with this: I just wanted to show how testing was done.
This is not meant to be merged.

I do have plans to clean this up and send upstream in the future, but not with
this patch series.

Best regards,
Nam
