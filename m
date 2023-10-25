Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 773F67D6085
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 05:27:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232439AbjJYD1N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 23:27:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbjJYD1K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 23:27:10 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9C4190;
        Tue, 24 Oct 2023 20:27:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=t1eCFwlywTSauENKR7sUNIvBsE1/8EtL14Kry+4k1DM=; b=DjeYgJ9Kv7XNEnGugU2ROOluyt
        PWmSN52GZrwhh9jf3kOcZn0zgKBTaolv9OSNDj8qIlFrBRdh9bRzLmO1ZSwJpe9MqnqVQYfQHFHi6
        us4+KnF5gt2IJaCsqPNINxDnmdlq6ubEkyUBIcR4ni3SXGCVoreDU3ZFrHqQOqPsJb/SePBW72Z9d
        HIFzSbGR677Fc/bbNbBF9eK8259ps9NFUYxSK1H+XhBrBIjEblXey7NA7CI6v73IkeeAX09WQrG5p
        BGZCuVyA5vHkg6Pk4dDAzw46aczD7RBenAvpDhqPW9vmMybFoHpkCDHE5ir+Vi0Lky7rIKpkSdmle
        yA6mzppw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qvUXx-00BGRH-1B;
        Wed, 25 Oct 2023 03:27:05 +0000
Date:   Tue, 24 Oct 2023 20:27:05 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Conor Dooley <conor@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: Re: linux-next: Tree for Oct 24 (drivers/soc/renesas/Kconfig)
Message-ID: <ZTiLCfrAimsnogzX@infradead.org>
References: <20231024174818.1137914a@canb.auug.org.au>
 <31264b8b-4509-4972-97f8-0926bc843147@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <31264b8b-4509-4972-97f8-0926bc843147@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 24, 2023 at 05:22:43PM -0700, Randy Dunlap wrote:
> WARNING: unmet direct dependencies detected for DMA_GLOBAL_POOL
>   Depends on [n]: !ARCH_HAS_DMA_SET_UNCACHED [=n] && !DMA_DIRECT_REMAP [=y]
>   Selected by [y]:
>   - ARCH_R9A07G043 [=y] && SOC_RENESAS [=y] && RISCV [=y] && NONPORTABLE [=y] && RISCV_ALTERNATIVE [=y] && RISCV_SBI [=y]

This is known and just waiting for the fixes here:

https://lore.kernel.org/linux-riscv/20231018052654.50074-1-hch@lst.de/T/#t

to be applied.
