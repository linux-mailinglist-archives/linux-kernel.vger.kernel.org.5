Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D35176F176
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 20:10:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230153AbjHCSKS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 14:10:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230039AbjHCSJ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 14:09:57 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C85630D5
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 11:09:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=0dEImclfLlmfTU0yTnFzJTof7y09txrCVp+rAtpvb1A=; b=Q3HG/IqrxhjbWVUPp+QxIv0M1M
        CQDRO12DZSkGS5jgxTy1lTzGCbAt0VPfKVjWzx5PwJFoM/CNjPu1pDLEfCKrZzwziQHSLvWxbeM2f
        BZ8VxSXklUYAQlj3+f5Kz6bnN3jqkTjocUVE0SjFPJlb2l9IWU4vM5eSnb3jwpN6adAOIOFzz4A3t
        9qzqv/mIFVddvR1Tfe8iJx+/ypoasiZODYZhfoMRX0KxmslYD3qhhSKSiKolEpT/6fWl+1OgkK7B0
        mtQvVTVyt9n9GKsLnj4XvXQ5Iztv4LIMmjLDNSO3r7x5tw6sR0i65zXcsWUMUZ9Hjv55m8RG7LbEo
        Q7F/U0lg==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qRclc-00AXuC-0M;
        Thu, 03 Aug 2023 18:09:44 +0000
Message-ID: <63bc327d-999a-1654-e7b5-6bcfd7477a32@infradead.org>
Date:   Thu, 3 Aug 2023 11:09:43 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 RESEND*3] ASoC: fsl MPC52xx drivers require
 PPC_BESTCOMM
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Grant Likely <grant.likely@secretlab.ca>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Shengjiu Wang <shengjiu.wang@gmail.com>,
        Xiubo Li <Xiubo.Lee@gmail.com>, alsa-devel@alsa-project.org,
        linuxppc-dev@lists.ozlabs.org, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>
References: <20230803025941.24157-1-rdunlap@infradead.org>
 <9581313f-5340-455d-a75d-dc27d2eb3ec0@sirena.org.uk>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <9581313f-5340-455d-a75d-dc27d2eb3ec0@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/3/23 04:27, Mark Brown wrote:
> On Wed, Aug 02, 2023 at 07:59:41PM -0700, Randy Dunlap wrote:
>> Both SND_MPC52xx_SOC_PCM030 and SND_MPC52xx_SOC_EFIKA select
>> SND_SOC_MPC5200_AC97. The latter symbol depends on PPC_BESTCOMM,
>> so the 2 former symbols should also depend on PPC_BESTCOMM since
>> "select" does not follow any dependency chains.
> 
> Take a hint, it's not clear that the patch is tasteful.

Thank you for replying.  I'll drop it and just report the build errors.

-- 
~Randy
