Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C106751A15
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 09:40:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232054AbjGMHks (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 03:40:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbjGMHkp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 03:40:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EE9DC1;
        Thu, 13 Jul 2023 00:40:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C02BC61A35;
        Thu, 13 Jul 2023 07:40:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C33FFC433C8;
        Thu, 13 Jul 2023 07:40:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689234044;
        bh=ZeYQt5UvSlhe1NHH6yAx8d1WYyIsDq5HDEW6CSYAWPU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EoK+UWr4IfpcsXelXoVTZ9cGRoRqml9D8UwN3K89TWkFQ7y2fwKN2Fm7WD/wY33+K
         e4mr2cfZLPLBG/5Kk2AWHqHYwG1Pjs7HnF3y9XzaeF2w781hNI1tY6Qw2XZ5nW/oNf
         EpRXACuRw3cu6A23FPlLs1nW7EWbXesVkfRnA4omLg62G5oBy9uFXSFloplQ2XqPW7
         i0G/QcCLLUhi5q4IYUgFai0KwfCzUMTA88F/TMA31rarA42hdHevIk0gpF05Z+n1WE
         XmtbvKsFqwPI0j4mFdPJO9ZbM3o8AjQ0/wjg/sndP5IvA/5mE7kn33TECEsrBlQg+F
         6WtBKn2iaxvFQ==
Date:   Thu, 13 Jul 2023 00:40:42 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     palmer@dabbelt.com, paul.walmsley@sifive.com,
        aou@eecs.berkeley.edu, herbert@gondor.apana.org.au,
        davem@davemloft.net, conor.dooley@microchip.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, christoph.muellner@vrull.eu,
        Heiko Stuebner <heiko.stuebner@vrull.eu>
Subject: Re: [PATCH v4 00/12] RISC-V: support some cryptography accelerations
Message-ID: <20230713074042.GF2199@sol.localdomain>
References: <20230711153743.1970625-1-heiko@sntech.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230711153743.1970625-1-heiko@sntech.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 11, 2023 at 05:37:31PM +0200, Heiko Stuebner wrote:
> From: Heiko Stuebner <heiko.stuebner@vrull.eu>
> 
> This series provides cryptographic implementations using the vector
> crypto extensions.
> 
> v13 of the vector patchset dropped the patches for in-kernel usage of
> vector instructions, I picked the ones from v12 over into this series
> for now.
> 
> My basic goal was to not re-invent cryptographic code, so the heavy
> lifting is done by those perl-asm scripts used in openssl and the perl
> code used here-in stems from code that is targetted at openssl [0] and is
> unmodified from there to limit needed review effort.
> 
> With a matching qemu (there are patches for vector-crypto flying around)
> the in-kernel crypto-selftests (also the extended ones) are very happy
> so far.

Where does this patchset apply to?  I tried torvalds/master, linux-next/master,
riscv/for-next, and cryptodev/master.  Nothing worked.  When sending a
patch(set), please always use the '--base' option to 'git format-patch', or
explicitly mention where it applies to, or provide a link to a git repo.

- Eric
