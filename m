Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F0697BB636
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 13:17:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232008AbjJFLRH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 07:17:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230232AbjJFLRE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 07:17:04 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2DC6DB;
        Fri,  6 Oct 2023 04:17:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=Gm+VgLFmfaUcxePYZphxP5D8oIaodpLSUc8xz+s6lsE=; b=GOPGExPOcy3kKnpip8nne7bOai
        +qMF1We5bmweWVtGrxSGiPbssfmnPgxcOpHTNiXp9+/Xy5F0AbTnmREu+liB7Umfdd+G6XaHYBSs7
        B/Dqg9N+hpIN50kYFTx/eQ+RrVPVrTwAdhYs9evcO4Fw1yJB9pi0quBn2Jj1OtsRIjYFm1+Amy9PA
        hqO6Yhhqpsw3Obr15F9Ze+EV4iQSD26LZNYRswCijxn6o57ub0Vj3Lj80RO//PlU5J8rIA/V6rXV2
        dK7SlOrUlBfJjaacGHdcjSV6jMKIY3eqRY3zBgTPG6tgq+7VOPwoVMq4ZnYJjE8WUEcwPCKulT0jV
        rhF0RXKw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qoipI-00CZi9-0L;
        Fri, 06 Oct 2023 11:17:01 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3566B300392; Fri,  6 Oct 2023 13:17:01 +0200 (CEST)
Date:   Fri, 6 Oct 2023 13:17:01 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc:     Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
        linux-tip-commits@vger.kernel.org, x86@kernel.org
Subject: Re: [tip: locking/core] locking/futex/selftests: Remove duplicate
 ABI defines
Message-ID: <20231006111701.GF36277@noisy.programming.kicks-ass.net>
References: <20231006095539.1601385-1-usama.anjum@collabora.com>
 <169658834039.3135.4395839213523782496.tip-bot2@tip-bot2>
 <20231006104325.GC36277@noisy.programming.kicks-ass.net>
 <ZR/oKYY7R52wKYC5@gmail.com>
 <ZR/ptQMWKxHCeXyp@gmail.com>
 <1b9a4e52-cfa3-4f56-b259-41c94abed362@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1b9a4e52-cfa3-4f56-b259-41c94abed362@collabora.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 06, 2023 at 04:05:31PM +0500, Muhammad Usama Anjum wrote:

> These days a error should appear if the kernel headers aren't found at
> build time of kselftests. After building headers, kselftests should be build.
> 
> ➜  functional (06bc8fe4bfc4b) ✗ pwd
> /linux_mainline/tools/testing/selftests/futex/functional
> ➜  functional (06bc8fe4bfc4b) ✗ make
> 
> -e error: missing kernel header files.

Obviously I don't see that. And I would consider this a regression.
Since it means I can't build tests anymore.
