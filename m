Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2167577EEB3
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 03:26:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347503AbjHQBZl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 21:25:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347518AbjHQBZT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 21:25:19 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1D922723
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 18:25:17 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-4ff09632194so6889761e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 18:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692235516; x=1692840316;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=avXiTIG03toHWdc7WMPS+YtjXMBqex6QzMUCbC7BK54=;
        b=Cxp0DVlHWbizHDV6rQuGcgSj47HHAzAvDbqrVzjrBtZ1ezjHcdiLb44UPA1ZWEJauS
         Q9hxNrZtHFO0q2zQOF0AXwOGqvGspGkKUOafw5O8rswmwI1DyYSelTMyqh4xfNODhEAD
         PBRAEMGJhQr+q+JoLQcVhuV8SB061qKjEFcRpyvcB3C3QC0PdAIMwgc5834p6yoanKkv
         SShdqMQLcz2dIwK2tCdPXaCNxo8R7e8ZdmHsyVeS0Rch3y9YN5dzwJVvILYBkpktF3pC
         92WuIhoveVhRJFlfwqkM4BNZ93Xg+Hb6MMZ/oLL3bJhXbbUsrrqONUfZpeYleVyd54jr
         fMpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692235516; x=1692840316;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=avXiTIG03toHWdc7WMPS+YtjXMBqex6QzMUCbC7BK54=;
        b=PIDCGv+luH6iHtpjmligt2pZMJt7FC3MWRi77rz8jeV1aTmKSefoCWsS9akvCwzWxh
         ID96pI0fYo7OE59TXp7MGLo6XfW7mqCrm1nkAuSpX5uL1npCMu/fgsIy2rjJpTl8zznO
         +38FRXGk4XUrTh+QRjAXuRhlKVQwli55L/8aXxKsx+Y/bNIjfdJDZIbN2ItCWEoOMfEf
         HAD1ow2B0xLtrYIPHRcYQ+Ihpb9cEy4u3rc0kT99F4EB20SB5bdwSMWkmFLyKtOVNz1z
         khMlSyyDE7LeEXCJg6n3yQ7PWxWND4NJuHillV9KTcCGNBXlwRm8GelXY6D7n7lj+ILG
         t9Ng==
X-Gm-Message-State: AOJu0Ywq2WvnPw4D3Hkkpq8zr9Ycg6FgGjb/JbElPVdg7q/MwO88SHRM
        rUOYRM4Bv36taQgg6X6ESlA=
X-Google-Smtp-Source: AGHT+IGS4aL3nfWLiddTUcmAdSQwWE+pVjKaJWyLChFPwOA+uVrg8z3TLx+83k6d70RGQLhZjnp9pg==
X-Received: by 2002:ac2:5b85:0:b0:4ff:834b:e01b with SMTP id o5-20020ac25b85000000b004ff834be01bmr2705975lfn.19.1692235515892;
        Wed, 16 Aug 2023 18:25:15 -0700 (PDT)
Received: from homer.fritz.box ([185.221.151.99])
        by smtp.googlemail.com with ESMTPSA id v10-20020aa7d64a000000b00521d2f7459fsm9006678edr.49.2023.08.16.18.25.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Aug 2023 18:25:15 -0700 (PDT)
Message-ID: <5f12fc76188cc664ce27606b34152f6c3f4d295c.camel@gmail.com>
Subject: Re: [tip:sched/eevdf] [sched/fair]  e0c2ff903c:
 phoronix-test-suite.blogbench.Write.final_score -34.8% regression
From:   Mike Galbraith <umgwanakikbuti@gmail.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Chen Yu <yu.c.chen@intel.com>,
        kernel test robot <oliver.sang@intel.com>,
        oe-lkp@lists.linux.dev, lkp@intel.com,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Ingo Molnar <mingo@kernel.org>
Date:   Thu, 17 Aug 2023 03:25:14 +0200
In-Reply-To: <20230816200405.GA998718@hirez.programming.kicks-ass.net>
References: <202308101628.7af4631a-oliver.sang@intel.com>
         <ZNWKuccyWnS3UJjK@chenyu5-mobl2.bbrouter>
         <ZNWgAeN/EVS/vOLi@chenyu5-mobl2.bbrouter>
         <20230814132935.GK776869@hirez.programming.kicks-ass.net>
         <bd96d883d0d1575ebbee4323f4396596adb0ad09.camel@gmail.com>
         <20230816123716.GI980931@hirez.programming.kicks-ass.net>
         <20230816134059.GC982867@hirez.programming.kicks-ass.net>
         <3d10fbfb0171cc017e19adf39fa97a3160a76206.camel@gmail.com>
         <20230816200405.GA998718@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2023-08-16 at 22:04 +0200, Peter Zijlstra wrote:
> > Here's hoping test bots don't have a cow. 
> 
> You want to write up a Changelog for this, or should I attempt to write
> one?

You write way better changelogs, you took the sting out, taking the
basic notion to solid ground.. and I'm at least as much of a lazy sod
as the next guy, so am all for you making it a real patch :)

	-Mike
