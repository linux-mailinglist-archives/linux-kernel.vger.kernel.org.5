Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C8D9791D82
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 21:11:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241277AbjIDTLo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 15:11:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233255AbjIDTLn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 15:11:43 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F6AE1707
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 12:11:36 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-40037db2fe7so18049405e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Sep 2023 12:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693854694; x=1694459494; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N4f6P28VPyXCYBikWvlnwCAAUPktzMnywAo5GqC9gYk=;
        b=ggGMbjTBCT99RhrkHVkqJWYgLBVgAayemTAVhTCeQHHPl/gqib9nKFjduvpXyUnRzR
         Vm/Bhl6RARHGQEtuZa0UxtTCVNhQJtSbs9/uA4+0EvUIOmpWANKwY2MeRo6gADQCtvNr
         R7PjjS+ozKvRlZuVoPCU+OvmVgOxFSyuG3zTkLT779zwVtlmfLnGyzYe8tRqxl0J4tMp
         BLCEnHvnl2mrJC5f4oZwKyJvFPnrnhnt3+gR1Eqx6XnnGCcMhjv1q63gqm0WM3BJbkbi
         GbxdV9gKkAJa5ZSSjGiea+FShd1GRncTD2zf3KVbvmSzxEnf15jV6eUAacaG+XcW6SkF
         ppmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693854694; x=1694459494;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N4f6P28VPyXCYBikWvlnwCAAUPktzMnywAo5GqC9gYk=;
        b=hfHjiAKmEcOzmEfK1ezRw0b4paA1jf8WUK3a2eP8dZXOHaXddIBklANdXrlSkkr7T9
         C+x9Eirrl7dyk+nSHc1v2py0jW0vR/Ly99Rfg1KxRPcbob7e2ac5wGfej93RnHSz7zeK
         O8nlIKV8It1D7K16dbRJydy3wfNWXc5iFYm5NcShIfpE+04o2W/onX15svX0DyUzd5RC
         ilIYNkGEd/RUT0UPlqsS2g6motCeDEXHfqU2bK44J+NGqrUL6ij6Jm0mM38+P57Q6Xox
         Qf2k9ptwoxhjfjemihZFaLC5WT3vGFpn5tVTfP0fA6xId8Lu5M09dsfhSDOgeJ2Ajg/K
         rl1A==
X-Gm-Message-State: AOJu0YwvDex5W+Wsym0YuthyFvZBAgzQS7V1zLtwfsuGtc5sqMJnv0+e
        L6bBw8/Ej5mtwQp0mD1p0Yk=
X-Google-Smtp-Source: AGHT+IGf7CWEVAyMN78Enrsi6jocXZ2nX2wgaHVClC5M6lxqpSPdyOyE6kV0KAKOXi3GZmpf4uQEVg==
X-Received: by 2002:a5d:6142:0:b0:317:6cd2:b90c with SMTP id y2-20020a5d6142000000b003176cd2b90cmr8808958wrt.13.1693854694332;
        Mon, 04 Sep 2023 12:11:34 -0700 (PDT)
Received: from gmail.com (1F2EF6A2.nat.pool.telekom.hu. [31.46.246.162])
        by smtp.gmail.com with ESMTPSA id l10-20020a5d4bca000000b003180155493esm15228687wrt.67.2023.09.04.12.11.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Sep 2023 12:11:33 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Mon, 4 Sep 2023 21:11:31 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Bongkyu Kim <bongkyu7.kim@samsung.com>, mingo@redhat.com,
        will@kernel.org, longman@redhat.com, boqun.feng@gmail.com,
        linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org
Subject: Re: [PATCH v2 1/2] Revert "locking/rwsem: Remove reader optimistic
 spinning"
Message-ID: <ZPYr4z/h2lZLtqoZ@gmail.com>
References: <20230901010704.18493-1-bongkyu7.kim@samsung.com>
 <CGME20230901010734epcas2p1a0d3698e76590637f9175fca40ad9eaf@epcas2p1.samsung.com>
 <20230901010704.18493-2-bongkyu7.kim@samsung.com>
 <20230904151008.GA25717@noisy.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230904151008.GA25717@noisy.programming.kicks-ass.net>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Peter Zijlstra <peterz@infradead.org> wrote:

> On Fri, Sep 01, 2023 at 10:07:03AM +0900, Bongkyu Kim wrote:
> > This reverts commit 617f3ef95177840c77f59c2aec1029d27d5547d6.
> > 
> > In mobile environment, reader optimistic spinning is still useful
> > because there're not many readers. In my test result at android device,
> > it improves application startup time about 3.8%
> > App startup time is most important factor for android user expriences.
> > So, re-enable reader optimistic spinning by this commit. And,
> > the later patch will make it optional feature by cmdline.
> 
> I'm not seeing any mention on how this interacts with all the rwsem work
> that has been done since that commit, like the handoff rework.
> 
> Why is a straight revert a sane thing at this point?

Yeah, so this should probably be titled:

   locking/rwsem: Reintroduce reader optimistic spinning

... instead of the double-negative 'remove removal' thing that is indeed 
confusing.

Thanks,

	Ingo
