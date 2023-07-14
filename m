Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1088875327A
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 09:03:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233740AbjGNHDH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 03:03:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235114AbjGNHDB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 03:03:01 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 917C01727;
        Fri, 14 Jul 2023 00:02:58 -0700 (PDT)
Received: from i53875a50.versanet.de ([83.135.90.80] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1qKCp8-0001dj-Am; Fri, 14 Jul 2023 09:02:42 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     palmer@dabbelt.com, paul.walmsley@sifive.com,
        aou@eecs.berkeley.edu, herbert@gondor.apana.org.au,
        davem@davemloft.net, conor.dooley@microchip.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, christoph.muellner@vrull.eu,
        Heiko Stuebner <heiko.stuebner@vrull.eu>
Subject: Re: [PATCH v4 00/12] RISC-V: support some cryptography accelerations
Date:   Fri, 14 Jul 2023 09:02:41 +0200
Message-ID: <5036521.5fSG56mABF@phil>
In-Reply-To: <20230714062708.GH913@sol.localdomain>
References: <20230711153743.1970625-1-heiko@sntech.de>
 <20230713074042.GF2199@sol.localdomain>
 <20230714062708.GH913@sol.localdomain>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        T_SPF_HELO_TEMPERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eric,

Am Freitag, 14. Juli 2023, 08:27:08 CEST schrieb Eric Biggers:
> On Thu, Jul 13, 2023 at 12:40:42AM -0700, Eric Biggers wrote:
> > On Tue, Jul 11, 2023 at 05:37:31PM +0200, Heiko Stuebner wrote:
> > > From: Heiko Stuebner <heiko.stuebner@vrull.eu>
> > > 
> > > This series provides cryptographic implementations using the vector
> > > crypto extensions.
> > > 
> > > v13 of the vector patchset dropped the patches for in-kernel usage of
> > > vector instructions, I picked the ones from v12 over into this series
> > > for now.
> > > 
> > > My basic goal was to not re-invent cryptographic code, so the heavy
> > > lifting is done by those perl-asm scripts used in openssl and the perl
> > > code used here-in stems from code that is targetted at openssl [0] and is
> > > unmodified from there to limit needed review effort.
> > > 
> > > With a matching qemu (there are patches for vector-crypto flying around)
> > > the in-kernel crypto-selftests (also the extended ones) are very happy
> > > so far.
> > 
> > Where does this patchset apply to?  I tried torvalds/master, linux-next/master,
> > riscv/for-next, and cryptodev/master.  Nothing worked.  When sending a
> > patch(set), please always use the '--base' option to 'git format-patch', or
> > explicitly mention where it applies to, or provide a link to a git repo.
> > 
> 
> Hi Heiko, any update on this?  I would like to review, and maybe test, this
> patchset but there's no way for me to do so.

sorry about that. As you said, this should've been mentioned in the
cover-letter.

This patchset goes on top of the v6 scalar one [0] which in turn
goes on top of the arch-random patchset [1] and that in turn sits
on top of 6.5-rc1 for me.


Heiko


[0] https://lore.kernel.org/r/20230709154243.1582671-1-heiko@sntech.de
[1] https://lore.kernel.org/r/20230709115549.2666557-1-sameo@rivosinc.com


