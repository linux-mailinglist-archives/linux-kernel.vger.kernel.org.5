Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E10E576931C
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 12:29:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232031AbjGaK3I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 06:29:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230335AbjGaK3H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 06:29:07 -0400
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C501FE3
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 03:29:01 -0700 (PDT)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout01.posteo.de (Postfix) with ESMTPS id 91CF324002A
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 12:28:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1690799339; bh=UvxyRecDg9IUjbyy6N24jqLaWiWPsex+CRnzVne66tw=;
        h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:
         Content-Transfer-Encoding:From;
        b=MctC08BV328WEy9wuHc42HOtNbB7plF2wY0PoAHFA5rWeyvBVSNoSZXJjmzzPA/U7
         hHE6ThAf5+efRcuhhgJSrixxDztVYhU/+RgnDmgEd6MDl3XIhYKCAYZF2WYUq/Yw1y
         b52ToS/rGKBuTFO8YozHrJjwc0/KKm/Y6bcaaPHaIMrUw0j8NE1TsPe2B/bFk6Sn1C
         PQcVqq2Es8cYNxpiMnzV2ww6mP3PoF/XrVwWgoYj7bT3z6jylNdEAuXxs51B+76+ai
         /xmSBOaGB/8V5p3axo5eLBLojlgh3JIC5FlfZy5xWRR2c/97n03ZR6WQf2W5Ff1flO
         3EsFntNCuDEFg==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4RDvbr5G30z6v2S;
        Mon, 31 Jul 2023 12:28:56 +0200 (CEST)
Date:   Mon, 31 Jul 2023 10:28:37 +0000
From:   Daniil Stas <daniil.stas@posteo.net>
To:     "Jarkko Sakkinen" <jarkko@kernel.org>
Cc:     <mario.limonciello@amd.com>,
        <James.Bottomley@hansenpartnership.com>, <Jason@zx2c4.com>,
        <linux-integrity@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <regressions@leemhuis.info>, <stable@vger.kernel.org>,
        <torvalds@linux-foundation.org>
Subject: Re: [PATCH 1/1] tpm: disable hwrng for fTPM on some AMD designs
Message-ID: <20230731132837.64690d7b@g14>
In-Reply-To: <CUGA0YM7BIJN.3RDWZ1WZSWG28@seitikki>
References: <20230214201955.7461-2-mario.limonciello@amd.com>
        <20230727183805.69c36d6e@g14>
        <CUE1Z76QDX0Z.2K0OU6TPMS50X@seitikki>
        <20230728231810.48370d44@g14>
        <CUGA0YM7BIJN.3RDWZ1WZSWG28@seitikki>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 31 Jul 2023 10:14:05 +0000
"Jarkko Sakkinen" <jarkko@kernel.org> wrote:

> On Fri Jul 28, 2023 at 8:18 PM UTC, Daniil Stas wrote:
> > On Fri, 28 Jul 2023 19:30:18 +0000
> > "Jarkko Sakkinen" <jarkko@kernel.org> wrote:
> >  
> > > On Thu Jul 27, 2023 at 3:38 PM UTC, Daniil Stas wrote:  
>  [...]  
> > > 
> > > This is needs a bit more elaboration in order to be comprehended.
> > > 
> > > Do you mean by "stutter" unexpected delays and when do they
> > > happen?
> > > 
> > > BR, Jarkko  
> >
> > Yes, unexpected delays. They just happen randomly.
> > You can google "AMD fTPM stuttering", there are a lot of examples.
> > Here is one: https://www.youtube.com/watch?v=TYnRL-x6DVI  
> 
> What if you make tpm_amd_is_rng_defective() to unconditonally return
> true? Does this make the problem dissappear, or not?
> 
> BR, Jarkko

I already tried compiling kernel without CONFIG_HW_RANDOM_TPM enabled,
which does the same.
Yes, it removes the issue.
