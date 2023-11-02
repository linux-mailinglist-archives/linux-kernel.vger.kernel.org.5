Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F8787DF689
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 16:34:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376837AbjKBPet (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 11:34:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347588AbjKBPeq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 11:34:46 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D754E11B
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 08:34:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=wldh4gezjkrU0z/9fKXfJvqExOdQVefUxaZaZeV9BRA=; b=Y4eXd5YxMct5Dqv0B3kIvVq/pz
        sqpt1h5CY1L6mdmIRxph/8vtQVCx38kfeN8eVskZ5BOesH9wXfBJkeVb23PJS6d6g5c/8M5od4Prl
        BNXg5iO/VKWFJ6AyG5z3h4pi0rEKgW6Rukn4su6x+fGM2zkQi/rTHRF7MuYHiXeUvI8fw1iTpLaPK
        J6E4VCm5oAse74hto7bj1UFkbUv+yRJmm7aShMpyse9ogOnXAhVGylUADpKNJOHyKPjNp3uyaoPOK
        fLhV/QVIToQcBMo56STx7aaE9f3a8Q5pH3lGRKlaFLX8MsfVCzOnRhUd6uwxoIaa98DejjP5l8smM
        0PP5b2Iw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qyZiH-006gTv-01;
        Thu, 02 Nov 2023 15:34:29 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id AB69D3004AB; Thu,  2 Nov 2023 16:34:28 +0100 (CET)
Date:   Thu, 2 Nov 2023 16:34:28 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Linus Torvalds <torvalds@linuxfoundation.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Jonathan Cameron <jic23@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>
Subject: Re: [PATCH 0/2] cleanup: Conditional locking support
Message-ID: <20231102153428.GD3818@noisy.programming.kicks-ass.net>
References: <20231102104429.025835330@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231102104429.025835330@infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 02, 2023 at 11:44:29AM +0100, Peter Zijlstra wrote:

> My plan is to post the perf patches in 3 batches of roughly 10 patches each,
> the simpler first and the more crazy ones (including the above) last.

For those interested, the first batch just went out and can be found
here:

  https://lkml.kernel.org/r/20231102150919.719936610@infradead.org
