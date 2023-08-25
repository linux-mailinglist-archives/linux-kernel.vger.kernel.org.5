Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C798788F04
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 20:56:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230014AbjHYSzj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 14:55:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230454AbjHYSz2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 14:55:28 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7E56212A;
        Fri, 25 Aug 2023 11:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=Gq1KATW+MR1e+UH1wuuhwAeoEshi/Sr/8ZzDp1gC4Jc=; b=LfbGpUjWA8sFlVDBJGMUfaooQT
        M3gnS0PL+cblqa24tE4mJi/OBZpUunZA0kcFLcgSF5079YJCHPyFYVbe+cpv8TNd6qx8+CkhuYkSd
        t8va1sd5Dy81oXz5WseVMPPEh0orQnLfjrHs7chxYe1EMqq0R49S+7ZKLoUDAawuZcfos3cnVLwx5
        koZNfCzYLgax70xyzH6uSrEO+NzvqnmKImt5++mHtUmZgcuVjUeGbviZGEg3e4DJk2G6eEIFHUHc0
        iPN9FQc8mz4defJn4jq60C59Pjhcr6kpinGwZy8D3vmqpAGiX6ppYvYpuRQziNhXbfJQMB7d9GZVA
        tBLkNOmQ==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qZbxm-005ttW-1m;
        Fri, 25 Aug 2023 18:55:18 +0000
Message-ID: <2077d280-2a94-55b6-4372-6a58735ebd22@infradead.org>
Date:   Fri, 25 Aug 2023 11:55:17 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH] of: unittest: Fix of_unittest_pci_node() kconfig
 dependencies
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Lizhi Hou <lizhi.hou@amd.com>
Cc:     kernel test robot <lkp@intel.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230824221743.1581707-1-robh@kernel.org>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230824221743.1581707-1-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/24/23 15:17, Rob Herring wrote:
> of_unittest_pci_node test depends on both CONFIG_PCI_DYNAMIC_OF_NODES
> and CONFIG_OF_OVERLAY. Move the test into the existing
> CONFIG_OF_OVERLAY ifdef and rework the CONFIG_PCI_DYNAMIC_OF_NODES
> dependency to use IS_ENABLED() instead. This reduces the combinations to
> build.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202308241954.oRNfVqmB-lkp@intel.com/
> Fixes: 26409dd04589 ("of: unittest: Add pci_dt_testdrv pci driver")
> Cc: Lizhi Hou <lizhi.hou@amd.com>
> Signed-off-by: Rob Herring <robh@kernel.org>


Acked-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
>  drivers/of/unittest.c | 16 +++++++---------
>  1 file changed, 7 insertions(+), 9 deletions(-)
> 

-- 
~Randy
