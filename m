Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 959917AF215
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 20:00:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235350AbjIZSAm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 14:00:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235005AbjIZSAk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 14:00:40 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22D02116
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 11:00:34 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id 98e67ed59e1d1-2777c848252so1688584a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 11:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695751233; x=1696356033; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QYb6avIf8M4e+cK+Zz75H3gI8Kfh6AcgnO+08GxHbKI=;
        b=PEth+sYCG+hVwLH8+tWxFnmeMTX8lAYlJ6sIVZLF1zSOtzxv1U66RMEGTQXPwnzvkb
         ZJFCvlYaMALb5WX+8euEI9UeUl65dxVMftJJFoXAKuAyHTLnfbnhzmx27j8/frgnNjF1
         olllfU27Yc40mVILo7riB6xw7Xi9XoEN8MAlIGwOh8HIf0SWPcwryVu1G6HTv5cl2PGl
         mxzSnLZ+cQwkYii4ppMTZ1HybzljfNQwY1U3ck+a6qjb4G0LyA6G1fe1jLah8uLE6ukV
         yqIDfUSEobCrp3dukTQUwjYOrnr5EPeiCvQn/4sz97IVcMO1kh5HasSD+vAupalk7c24
         BNhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695751233; x=1696356033;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QYb6avIf8M4e+cK+Zz75H3gI8Kfh6AcgnO+08GxHbKI=;
        b=nmmD+86A+eSzd0IeZQpgqyz5YXK53wyJRRiU6LM/dTz8N2m1hjGIt37/KewIX3B04S
         5egIj+S9f6g4YqOCgo33KI9PqNgv0SzK7Bk8mLZlrssBUvH8lnBgReAsZ1EofqK/SeCM
         jvDgImgfq4wAC+AQDaMdvgtrtWJkixupXqTvFAEJbaSFkDaLkt9sbnftxwvzXXZ13c8R
         6BZErs1KRHu6HOK4dstpGkGeNNEPVSCwOnPLMVDNAB35Bxm8Sc+Vd8ni5zgROj+lOoFI
         36qf7EgiNvyfjrp2Wq2077IKhzMvcAuiqnITHjBHmpj/LRNV0rN8KB+nrVkzWsOpUQby
         1iuQ==
X-Gm-Message-State: AOJu0YwXvWVzitsCSGLc+PISjM/K4yqgG94XYiTIn7bvAdktA7tS4vHI
        V6eu1RLO43+Z0FVO5VzyFM5aXc3334NL8w==
X-Google-Smtp-Source: AGHT+IHVXNyrtHApKcOtUEzjV5PbNsIGnE/iL5rsF6dweH4ZWQD6S+qCN7keSHyWFziwcqOduvYvjA==
X-Received: by 2002:a17:90a:6547:b0:269:46d7:f1db with SMTP id f7-20020a17090a654700b0026946d7f1dbmr10046857pjs.32.1695751233264;
        Tue, 26 Sep 2023 11:00:33 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::4:dfcd])
        by smtp.gmail.com with ESMTPSA id x4-20020a17090abc8400b00262eccfa29fsm11928793pjr.33.2023.09.26.11.00.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Sep 2023 11:00:32 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 26 Sep 2023 08:00:31 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] Workqueue fixes for v6.6-rc3
Message-ID: <ZRMcP7rsGgOEeoDB@slm.duckdns.org>
References: <ZRHTb8ctzeRq0-a6@slm.duckdns.org>
 <CAHk-=wiH+mdeH3M6C1+5gZxoeR4f=Fi20TF8Zo_BEo70p1Ndnw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiH+mdeH3M6C1+5gZxoeR4f=Fi20TF8Zo_BEo70p1Ndnw@mail.gmail.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 26, 2023 at 08:39:23AM -0700, Linus Torvalds wrote:
> On Mon, 25 Sept 2023 at 11:37, Tejun Heo <tj@kernel.org> wrote:
> >
> >   git://git.kernel.org/pub/scm/linux/kernel/git/tj/wq.git/ wq-for-6.6-rc3-fixes
> 
> -ENOSUCHTAG.
> 
> Did you forget to push out?

Yes, I did and missed the warning message on git request-pull. Sorry about
that. The tag should be there now.

Thanks.

-- 
tejun
