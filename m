Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A4BC796ED2
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 04:13:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239974AbjIGCNl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 22:13:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjIGCNk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 22:13:40 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D3CE173B
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 19:13:35 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id 46e09a7af769-6befdb1f545so374606a34.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Sep 2023 19:13:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694052814; x=1694657614; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lx3iU3GdjmywZiYlfPlbzfKFyv4f5XdEJqpK3WfigeU=;
        b=c54Ovn7aZXODk3F9XiuOi43+Jeg9DIG74BDfxyTC1FqC08fmTNKJIK4RA41QU3a8bj
         IIL6FaqZpFIf6Qg8aSYvtlm4HwQfAGouqwvDpf6QXPFntsUoEkQLbZOicD+UOEjwUljg
         hNDHcfuEjafl4w8K/gs5Z8BJzM1wJEq+/V9IUc8FA/pUogEsHB7mmctMpV5rQLOnz0ac
         L4cP3gBGbRfuKJ8mTHRbWyrDkAsSHmbfJPGIuTitbZ+X+tkC1qqJQdm/AV4DIfM0AOUV
         FzEh1ipnawJolzpze86bmssdmgQxnGRyrnWixvCtFszzPt7kaQcj5BVk/Mm8MJvxglHC
         /2Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694052814; x=1694657614;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lx3iU3GdjmywZiYlfPlbzfKFyv4f5XdEJqpK3WfigeU=;
        b=hFPRketrKJfcTG6cYlSEr3NuVCsAbGLK6Vhvhw1YDMNTQfAfWvlGuM8QtX/KXUuqDV
         mDbIfakhZ+ph/wUYpbASGBxGRIxssFLQUb4sI62cDgwLhDpSu/C3aLvvvx4HaJkPVKh/
         vL3N/zEFU44m/RmtJKnbI9PPwK0Q7oSChp2WwPPvanNSWXszivTIBo2HOj6E2EHBvbNq
         /Znve/j0WsJh3qUElZFBBrJDQEXY91RzCsckVKNaRsn0AWXokwmRALik1YNTfAI6HsGO
         TBg78gkrmJZmmnVtxmAI91PkeZxFaAW4lDPVfgyAyBpHPgqoZUnseSwyCtPGlw1/4SeM
         cUpA==
X-Gm-Message-State: AOJu0Yxj0RNf2dpUTC5qD/Q9fMKrdXEKRQ66MhLNF7dbMo/SRpqcbalI
        iNCp4BXmjwWLVh6JpekW2sxp86IpB1sFaheuWyI=
X-Google-Smtp-Source: AGHT+IGzJwHTwgXqBrqhCE8SkDqpry9q8CocOi2kmFZTEN5/XzR7H2yswHq7LTXFXJA51bSghkSaMxoAAvr7m8qgQaA=
X-Received: by 2002:a05:6358:9924:b0:132:d078:9a05 with SMTP id
 w36-20020a056358992400b00132d0789a05mr5286951rwa.14.1694052814440; Wed, 06
 Sep 2023 19:13:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230902115026.13460-1-qiang.zhang1211@gmail.com>
 <ZPd4yKqbvBNGV7cL@slm.duckdns.org> <CALm+0cVf+E_Y41AdEwLjm2gZAjzeKaZev1Tu1hUS-VpYH0eEHQ@mail.gmail.com>
 <ZPiwaaZaDPVexezn@slm.duckdns.org>
In-Reply-To: <ZPiwaaZaDPVexezn@slm.duckdns.org>
From:   Z qiang <qiang.zhang1211@gmail.com>
Date:   Thu, 7 Sep 2023 10:13:23 +0800
Message-ID: <CALm+0cUytR3-0mcW3t24gcyP27UW3rpP5_+vpLVC3w70+0n6oQ@mail.gmail.com>
Subject: Re: [PATCH] workqueue: Fix UAF report by KASAN in pwq_release_workfn()
To:     Tejun Heo <tj@kernel.org>
Cc:     jiangshanlai@gmail.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>
> On Wed, Sep 06, 2023 at 10:12:34AM +0800, Z qiang wrote:
> > Flush the pwq_release_worker is insufficient, the call_rcu() is
> > invoked to release wq
> > in pwq_release_workfn(), this is also asynchronous.
>
> But rcu_free_pwq() doesn't access wq or anything. The last access is from
> the work function.

The rcu_free_wq() will access wq->cpu_pwq or unbound_attrs,
but  at this time, the kfree(wq) may have been called in alloc_workqueue().

Thanks
Zqiang


>
> Thanks.
>
> --
> tejun
