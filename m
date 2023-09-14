Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC25679F5D1
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 02:11:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233288AbjINALw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 20:11:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232828AbjINALv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 20:11:51 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D632E170B;
        Wed, 13 Sep 2023 17:11:46 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24C0EC433C8;
        Thu, 14 Sep 2023 00:11:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694650306;
        bh=Q33a+2wWr7dpJ3gAuG87/40VlteSBLIbhhTUJrzO1p4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=plTcQBaw9+qFIJyZ3nYgpJcQc1IqLi5pV6NFEvC0Jefi81qUcXvBV8xRPTUkXVKCE
         poPupPhVF3c11ThThzdvEbk/4bFSy26ic/RhIqwWb6fBaoBAw/WDqaVg09hG3lB4Av
         N8/Shpsg5BbPV4FgnnDQ2jtOJn5Sj4a2KQd0q5IJzaBwkxxppyQ/GZrL4yj2MNeM9s
         yR/Mde3Mex0YexAjnmd9NIeBJ748VeEThqZGNnBPa4nzVZg1ia+EnLfciUnNvcD/V8
         yEwd+mRaibHbAc7bf4s0wXgPqE1vsnBwUug2PPyBXCZeEv4eYA0bp4PYYFkWg6TDL0
         XQ4GgV0GEZ3ug==
Date:   Wed, 13 Sep 2023 17:11:44 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     palmer@dabbelt.com, paul.walmsley@sifive.com,
        aou@eecs.berkeley.edu, herbert@gondor.apana.org.au,
        davem@davemloft.net, conor.dooley@microchip.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, christoph.muellner@vrull.eu,
        Heiko Stuebner <heiko.stuebner@vrull.eu>
Subject: Re: [PATCH v4 00/12] RISC-V: support some cryptography accelerations
Message-ID: <20230914001144.GA924@sol.localdomain>
References: <20230711153743.1970625-1-heiko@sntech.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230711153743.1970625-1-heiko@sntech.de>
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

Hi Heiko!  Are you still working on this patchset?  And which of its
prerequisites still haven't been merged upstream?

- Eric
