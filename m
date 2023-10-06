Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7CA57BBFD2
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 21:47:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233295AbjJFTrs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 15:47:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233279AbjJFTrr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 15:47:47 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B3ABBE;
        Fri,  6 Oct 2023 12:47:44 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48A23C433C7;
        Fri,  6 Oct 2023 19:47:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696621663;
        bh=h0DLLJZqCZlG+/BaIeE1qTGFs+lWvxzxYNkN6b5g38E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ni0MjEaHF+7SUg/jgNB0F/EFSlY5Rx7mXGORS93Lqm3ftLmTcwLCTzd8Gj3ruGldL
         Lp/tD0zEJ7E2NsimLDKVwqvPLnk8PlIVT1e+7M0mllsQOE/T7g2WtRMMWLWsZ+2Ws/
         /tCU2DcJj30lTM0LW/PcN29PoAihSRX4H53qCt/3vYxUlVG8zSglonRkAGGkQCkMN1
         07wZT274f7iTthdaoWIxvTbtG3KpcNHnR9S3Sh9OafhmqXN7Ou49vBhfrJFThEO93L
         L0MaK2akLYss4R49XnIF4jU+84tUjM/ZJNNqiN+itv3BJg+2s9SZSjVgej0wBh5Epz
         5hIq5w+jxbbmA==
Date:   Fri, 6 Oct 2023 19:47:41 +0000
From:   Eric Biggers <ebiggers@kernel.org>
To:     Jerry Shih <jerry.shih@sifive.com>
Cc:     He-Jie Shih <bignose1007@gmail.com>,
        Charlie Jenkins <charlie@rivosinc.com>,
        Heiko Stuebner <heiko@sntech.de>, palmer@dabbelt.com,
        paul.walmsley@sifive.com, aou@eecs.berkeley.edu,
        herbert@gondor.apana.org.au, davem@davemloft.net,
        conor.dooley@microchip.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        christoph.muellner@vrull.eu,
        Heiko Stuebner <heiko.stuebner@vrull.eu>
Subject: Re: [PATCH v4 00/12] RISC-V: support some cryptography accelerations
Message-ID: <20231006194741.GA68531@google.com>
References: <20230711153743.1970625-1-heiko@sntech.de>
 <20230914001144.GA924@sol.localdomain>
 <ZQJdnCwf99Glggin@ghost>
 <3A0F6A71-C521-44A5-A56C-076AF3E13897@gmail.com>
 <DD3113B1-AB9F-4D6D-BD6E-8F75A83DA45D@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DD3113B1-AB9F-4D6D-BD6E-8F75A83DA45D@sifive.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 15, 2023 at 11:21:28AM +0800, Jerry Shih wrote:
> On Sep 15, 2023, at 09:48, He-Jie Shih <bignose1007@gmail.com> wrote:
> 
> > On Sep 14, 2023, at 09:10, Charlie Jenkins <charlie@rivosinc.com> wrote:
> > 
> >> On Wed, Sep 13, 2023 at 05:11:44PM -0700, Eric Biggers wrote:
> >>> On Tue, Jul 11, 2023 at 05:37:31PM +0200, Heiko Stuebner wrote:
> >>> 
> >>> Hi Heiko!  Are you still working on this patchset?  And which of its
> >>> prerequisites still haven't been merged upstream?
> >>> 
> >>> - Eric
> >> It is my understanding that Heiko is taking a break from development, I
> >> don't think he will be working on this soon.
> > 
> > We would like to take over these RISC-V vector crypto implementations.
> > Our proposed implementations is under reviewing in OpenSSL pr.
> > And I will check the gluing parts between Linux kernel and OpenSSL.
> 
> The OpenSSL PR is at [1].
> And we are from SiFive.
> 
> -Jerry
> 
> [1]
> https://github.com/openssl/openssl/pull/21923

Hi Jerry, I'm wondering if you have an update on this?  Do you need any help?

I'm also wondering about riscv.pm and the choice of generating the crypto
instructions from .words instead of using the assembler.  It makes it
significantly harder to review the code, IMO.  Can we depend on assembler
support for these instructions, or is that just not ready yet?

- Eric
