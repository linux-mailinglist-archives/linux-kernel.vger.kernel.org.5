Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D839C793324
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 03:04:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239476AbjIFBE3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 21:04:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230062AbjIFBE2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 21:04:28 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33F881A3;
        Tue,  5 Sep 2023 18:04:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=I4LuFZe0C31aTkwoiiTrzV8Te/Obu7XjlrKLi4Ak64g=; b=Wa6w8sBYTj/+zNLxaid2hLPmaU
        q8NGEBn3Fjcw+bOozeC9/i2qNg6RDeswb7HeCoyucusjv8rmjRiAvqLS+SXBLUJ8sjaXV3JIY8AwD
        mHg8oMxSig2ImQP/4sqFqQYPuajGVe4Z2CuEdnGcmHy7qicTpvodCHgsCr1grieLJLH5CW+K7S6pa
        Dn8Zac3CN6RzHChIv+PRL/g9vksKstsMA01nqtobynH3MkKWw+KbJMbzwJWWJFFs6S5zWvRDTeA76
        xmYNgDkaP+oXKridmjxTYEssBS2CkzZiSf8Ks+xaE4UOtd+vKFsr6aUEUFPHhmvGCJtLZWlDc1IlJ
        LU7U4ZOQ==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qdgxv-006zS6-1a;
        Wed, 06 Sep 2023 01:04:19 +0000
Message-ID: <d8e0dd0f-ce37-2dbf-8ac3-a1e26a18cf45@infradead.org>
Date:   Tue, 5 Sep 2023 18:04:18 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH] MIPS: Alchemy: only build mmc support helpers if au1xmmc
 is enabled
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, tsbogend@alpha.franken.de,
        manuel.lauss@gmail.com
Cc:     arnd@arndb.de, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
References: <20230905070656.196274-1-hch@lst.de>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230905070656.196274-1-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/5/23 00:06, Christoph Hellwig wrote:
> While commit d4a5c59a955b ("mmc: au1xmmc: force non-modular build and
> remove symbol_get usage") to be built in, it can still build a kernel
> without MMC support and thuse no mmc_detect_change symbol at all.
> 
> Add ifdefs to build the mmc support code in the alchemy arch code
> conditional on mmc support.
> 
> Fixes: d4a5c59a955b ("mmc: au1xmmc: force non-modular build and remove symbol_get usage")
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  arch/mips/alchemy/devboards/db1000.c | 4 ++++
>  arch/mips/alchemy/devboards/db1200.c | 6 ++++++
>  arch/mips/alchemy/devboards/db1300.c | 4 ++++
>  3 files changed, 14 insertions(+)
> 


Acked-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org> # build-tested

Thanks.

-- 
~Randy
