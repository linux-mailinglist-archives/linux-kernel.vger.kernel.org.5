Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39FFF77D657
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 00:45:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240453AbjHOWo2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 18:44:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240434AbjHOWn5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 18:43:57 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC9F610E3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 15:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=QT42XdEEVo4BLbAixchsAL2gKpdt5jrf2r/OqlWgNYE=; b=pPf5mLgdE/560renaNEbwVTFKl
        r0HfpkpVwFbQ44yLVvPyJB3C71fgunoQIcBcuLHP3L63os9l9aEMf0i0htZIVs6fv/Xk3C5dF6XRe
        XMC8RHsRuPB+rn1g8I+Pay7oAKDzA2aqgKvo2P1UGtGs08jDzI9SPr18JeQji5UE5JWNfT+5wUWnC
        7yqC3zeP00JofdFnEAP1ssldqaIKlpNkTVFXuCtNqjwzb47jweKrIWmASRwooeyMP5ExaWc4Z76TW
        7/XvmBQEpxJk2bVUTgRvkzqzGtOjyWjIrghYcdf+kOnT81gzuy3l6RJK5L/45ze2duJjrcuA/GybL
        krkuzByg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qW2lR-00AxOC-5c; Tue, 15 Aug 2023 22:43:49 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 52DE93004AF;
        Wed, 16 Aug 2023 00:43:48 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3B4E2206A36D9; Wed, 16 Aug 2023 00:43:48 +0200 (CEST)
Date:   Wed, 16 Aug 2023 00:43:48 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, David.Kaplan@amd.com,
        Andrew.Cooper3@citrix.com, jpoimboe@kernel.org,
        gregkh@linuxfoundation.org, nik.borisov@suse.com
Subject: Re: [PATCH v2 05/11] x86/cpu: Clean up SRSO return thunk mess
Message-ID: <20230815224348.GE971582@hirez.programming.kicks-ass.net>
References: <20230814114426.057251214@infradead.org>
 <20230814121148.842775684@infradead.org>
 <20230815212931.GA3863294@dev-arch.thelio-3990X>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230815212931.GA3863294@dev-arch.thelio-3990X>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 15, 2023 at 02:29:31PM -0700, Nathan Chancellor wrote:

> I applied this change on top of -tip master and linux-next, where it
> appears to break i386_defconfig (I see this error in other
> configurations too but defconfig is obviously a simple target) with both
> GCC and LLVM:

Yeah, Boris and me fixed that yesterday evening or so. I'm not sure
I still have the diffs, but Boris should have them all somewhere.

