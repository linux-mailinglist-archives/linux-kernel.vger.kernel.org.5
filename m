Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C14078BA68
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 23:39:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232905AbjH1Vii (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 17:38:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231415AbjH1ViO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 17:38:14 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7FBD106
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 14:38:11 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1693258689;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NnRnRtBVRXEiVd5nK3Y8FaQXhhjR20vw2GnvdfoXL2c=;
        b=JKP1E5tAJum0l2hu5GwWKLrVriW2x/qNfwVnhLuh30bgsw6q/7NxnQdCvFu4e944faeBLv
        hGAxTIs6E977vYBRT52A7nvT/5+uq4Lxe/jbsxgoA/5VBrjOKEKN2Lso/CUcLzDvhsia/U
        QDAQybwjYWOQ5F+B62Pw/Wo5jziqKyvv0bsjOsMIv3BiX80KfgKMPitC27zR9ylF607k2m
        /bhfwYZDV/4PbhKntwNv/NgpuG2BOHpqXupGTq1QFD6Ixg4gHsFIKUQtA+lq1FjAWkI3Su
        vGitXIzGqtl1ztS80GbK/8jxKCQo71BF3sGoKhMAmrKRLjNTR+bAREXMSkkM9Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1693258689;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NnRnRtBVRXEiVd5nK3Y8FaQXhhjR20vw2GnvdfoXL2c=;
        b=EbuxlkdW9Zny7yTPexad/1hjfeiSyMRpGIrK9DDi3BBO4+VTv7wWfbf44X5c0SL3emojb2
        ek81bBiy5G4NBbCA==
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [GIT pull] core/entry for v6.6-rc1
In-Reply-To: <CAHk-=wjomZiu4QiyjAH=RSTsdZCpcjq-0yD42dLMN2+rcm4_cg@mail.gmail.com>
References: <169322654636.420889.373907562030292433.tglx@xen13.tec.linutronix.de>
 <CAHk-=wjomZiu4QiyjAH=RSTsdZCpcjq-0yD42dLMN2+rcm4_cg@mail.gmail.com>
Date:   Mon, 28 Aug 2023 23:38:08 +0200
Message-ID: <875y4y97b3.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 28 2023 at 14:07, Linus Torvalds wrote:
> On Mon, 28 Aug 2023 at 06:01, Thomas Gleixner <tglx@linutronix.de> wrote:
>>
>> A single update to the core entry code, which removes the empty user
>> address limit check which is a leftover of the removed TIF_FSCHECK.
>
> Heh. Lovely. I wonder if we have other cases of #ifdef's that just
> aren't #define'd anywhere any more.

I'm sure we have.

> But I'm too lazy and/or incompetent to write up some trivial script to check.

There are a few people out there who are constantly trying to chase
those:

  https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?h=x86/microcode&id=4d2b748305e96fb76202a0d1072a285b1500bff3

is the most recent example. But obviously they miss stuff too. :)

Thanks,

        tglx
