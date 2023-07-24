Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEC5675FF9F
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 21:11:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230417AbjGXTLX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 15:11:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjGXTLW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 15:11:22 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD242F3;
        Mon, 24 Jul 2023 12:11:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ukFXm9LjVouF4sTkaQ0Peg6EJLKXJvg9PuXymtzQWeU=; b=3FLzdREMYs6LJ/EPDLQL7Pw5L1
        AbKhJ2ApmLcYJsSxl70sOMMwz6uo1kZ7TvfEwgtVkk2x+DjMrjBJ3uadWKlDjT7/SoNqUlzCjxV0g
        Mlq92+8lN/kzF5PCyjMWmsC6+fvj1M0QBBF4m84s0dXyV+2ZCVYLpM4zSdEGf9EExoyZnOGtAdHus
        1h49Di2C3q1kgHZeBeaIPygYEX7EYcsmM+2PRiMXob6WARt17zTwyeuzB4Ovow3kej68AMS2T86MK
        5GIFS6Uj8QGaAE0LtOph+3vYqNbwbHU3eOdusEHoHe3PyVvIvNgS78CUIl58Gb6M7Iw8hwuSvBTsC
        cbLJnU8Q==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qO0xi-005HcY-20;
        Mon, 24 Jul 2023 19:11:18 +0000
Date:   Mon, 24 Jul 2023 12:11:18 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Palmer Dabbelt <palmer@rivosinc.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: Fixes tag needs some work in the modules tree
Message-ID: <ZL7M1kK+uGsJg4p2@bombadil.infradead.org>
References: <20230724083348.5f7cd58a@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230724083348.5f7cd58a@canb.auug.org.au>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 24, 2023 at 08:33:48AM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> In commit
> 
>   3d917b5d3ba5 ("modpost, kallsyms: Treat add '$'-prefixed symbols as mapping symbols")
> 
> Fixes tag
> 
>   Fixes: c05780ef3c1 ("module: Ignore RISC-V mapping symbols too")
> 
> has these problem(s):
> 
>   - SHA1 should be at least 12 digits long

Fixed, thanks.

  Luis
