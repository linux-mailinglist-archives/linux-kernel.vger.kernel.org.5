Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BF0977E425
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 16:53:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343806AbjHPOwl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 10:52:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343846AbjHPOwg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 10:52:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB93F121
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 07:52:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 58A596446C
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 14:52:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A2CAC433C8;
        Wed, 16 Aug 2023 14:52:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692197554;
        bh=/VrFeNd6P2bZrXsUoUgvGF/6yGQy/1jlfunGhRdur7w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cyMuaqGW1I2WiVlf5tJq5dbbLvvg6Cwcz4cgTEecf4IZ/elHKbIb2IJWlkam4Nxhs
         3eqPANpWfUB2pHL9Hm2JmC+l67zk8/BIIDBdWHX7PtvT5mgLVol85sRbrdbPnFn0n7
         UF0fawFK0D99hyJCl+MERv6B2OHX+LUBiUFl/NPMmsYACCX3n2OGuvdwuA0zqn2Rki
         YTr23LrzsbmfTpsPbD7BNCE0g+JP49LbAZO2kv3JHC7+KD9sR+AE/pLFje/uBQVjKu
         EYkQB472qFWKoRvAyFGJSuFBHKIlVT6iWoNJlre2VRGYJb1Y1iCQQm2YRVEsNaPzd1
         PLfL7fkbQosYw==
Date:   Wed, 16 Aug 2023 07:52:32 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org, David.Kaplan@amd.com,
        Andrew.Cooper3@citrix.com, jpoimboe@kernel.org,
        gregkh@linuxfoundation.org, nik.borisov@suse.com
Subject: Re: [PATCH v2 05/11] x86/cpu: Clean up SRSO return thunk mess
Message-ID: <20230816145232.GA1535486@dev-arch.thelio-3990X>
References: <20230814114426.057251214@infradead.org>
 <20230814121148.842775684@infradead.org>
 <20230815212931.GA3863294@dev-arch.thelio-3990X>
 <20230815224348.GE971582@hirez.programming.kicks-ass.net>
 <20230816073828.GAZNx89HT8mYCOxvV1@fat_crate.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230816073828.GAZNx89HT8mYCOxvV1@fat_crate.local>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 16, 2023 at 09:38:28AM +0200, Borislav Petkov wrote:
> On Wed, Aug 16, 2023 at 12:43:48AM +0200, Peter Zijlstra wrote:
> > Yeah, Boris and me fixed that yesterday evening or so. I'm not sure
> > I still have the diffs, but Boris should have them all somewhere.
> 
> Even better - all the urgent fixes I've accumulated so far are coming up
> in tip's x86/urgent.  I'd appreciate people testing it.

All my configurations build and run cleanly in QEMU at commit
d80c3c9de067 ("x86/srso: Explain the untraining sequences a bit more")
so I think we should be good here.

Cheers,
Nathan
