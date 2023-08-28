Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 061FB78B34F
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 16:38:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231831AbjH1Oi1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 10:38:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231743AbjH1OiI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 10:38:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CD3EA1;
        Mon, 28 Aug 2023 07:38:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0F3226297F;
        Mon, 28 Aug 2023 14:38:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8646C433C8;
        Mon, 28 Aug 2023 14:37:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693233484;
        bh=Vm4Wb10pnSJCprThUHs5sRplOiiwrW2ZhbukDVPepoI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=TYjeuUkx+aBA69jTjQfy6/BIxSzPSHe+d0f+4zKudk/jmte2P4kq6DsjofEu4Z3Sd
         S2HHRHN++ZGbURWqIMNUpfYSXl3C1ks83yUFQ6O9uMpUq3OvkAq6fVzgjT0pXFe+hP
         8sRfRo5AFNQI87b0+rqK2Fz0HhxIkvhfociXqBQru7L5gyWEmSI4gZSGesZCC3Q6Hf
         UZq8aoYF1eqkCNE7o3dASUVY98qxumRELPlOcCHwWcDtv1aSK9DlZyAc8bu529UJpe
         ExVNeWYtChP2/F2NVXpBpKKsdwlEF74QxtSVWojgbvvgRhMteW+8AxfU/NNfTbOAyU
         96jKiKtVk+eeg==
Date:   Mon, 28 Aug 2023 15:38:21 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     kernel test robot <lkp@intel.com>
Cc:     Mingjin Yang <mingjin.yang@unisoc.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        oe-kbuild-all@lists.linux.dev, magicyangmingjin@gmail.com,
        Ling_Ling.Xu@unisoc.com, Jinfeng.Lin1@unisoc.com,
        Yangbin.Li@unisoc.com, Jiansheng.Wu@unisoc.com,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V0 2/2] iio: adc: sprd_pmic_adc: Add support for UMP
 serise pmic adc
Message-ID: <20230828153821.51705a00@jic23-huawei>
In-Reply-To: <202308162143.UjXhwiRf-lkp@intel.com>
References: <20230816080225.21482-3-mingjin.yang@unisoc.com>
        <202308162143.UjXhwiRf-lkp@intel.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Aug 2023 22:07:15 +0800
kernel test robot <lkp@intel.com> wrote:

> Hi Mingjin,
> 
> kernel test robot noticed the following build warnings:
> 
> [auto build test WARNING on robh/for-next]
> [also build test WARNING on linus/master v6.5-rc6 next-20230816]
> [cannot apply to jic23-iio/togreg]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Mingjin-Yang/dt-bindings-iio-adc-Add-support-for-ump518-pmic-adc/20230816-160754
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
> patch link:    https://lore.kernel.org/r/20230816080225.21482-3-mingjin.yang%40unisoc.com
> patch subject: [PATCH V0 2/2] iio: adc: sprd_pmic_adc: Add support for UMP serise pmic adc
> config: m68k-allmodconfig (https://download.01.org/0day-ci/archive/20230816/202308162143.UjXhwiRf-lkp@intel.com/config)
> compiler: m68k-linux-gcc (GCC) 12.3.0
> reproduce: (https://download.01.org/0day-ci/archive/20230816/202308162143.UjXhwiRf-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202308162143.UjXhwiRf-lkp@intel.com/
> 
> All warnings (new ones prefixed by >>):
> 
>    drivers/iio/adc/sprd_pmic_adc.c: In function 'ump9620_ch_data_init':
> >> drivers/iio/adc/sprd_pmic_adc.c:530:1: warning: the frame size of 1320 bytes is larger than 1024 bytes [-Wframe-larger-than=]  
>      530 | }
>          | ^
> 
> 
> vim +530 drivers/iio/adc/sprd_pmic_adc.c
> 
>    506	
>    507	static void ump9620_ch_data_init(struct sprd_adc_data *data)
>    508	{
>    509		struct sprd_adc_channel_data ch_data_def = CH_DATA_INIT(SCALE_00, 0, 0, RATIO_DEF);
>    510		struct sprd_adc_channel_data ch_data[SPRD_ADC_CHANNEL_MAX] = {

Make these both const and I think the compiler will move these off the stack thus
solving the issue seen.

>    511			[0] = CH_DATA_INIT(SCALE_01, 0, 0, RATIO_DEF),
>    512			[5] = CH_DATA_INIT(SCALE_00, 0x1, 0x9, RATIO_DEF),
>    513			[6] = CH_DATA_INIT(SCALE_00, 0x1, 0x9, RATIO_DEF),
>    514			[7] = CH_DATA_INIT(SCALE_10, 0, 0, RATIO_DEF),
>    515			[9] = CH_DATA_INIT(SCALE_10, 0, 0, RATIO_DEF),
>    516			[10] = CH_DATA_INIT(SCALE_11, 0, 0, RATIO_DEF),
>    517			[11] = CH_DATA_INIT(SCALE_00, 0, 0, RATIO_DEF),
>    518			[13] = CH_DATA_INIT(SCALE_01, 0, 0, RATIO_DEF),
>    519			[14] = CH_DATA_INIT(SCALE_00, 0, 0, RATIO(68, 900)),
>    520			[15] = CH_DATA_INIT(SCALE_00, 0, 0, RATIO(1, 3)),
>    521			[19] = CH_DATA_INIT(SCALE_11, 0, 0, RATIO_DEF),
>    522			[21] = CH_DATA_INIT(SCALE_00, 0, 0, RATIO(3, 8)),
>    523			[22] = CH_DATA_INIT(SCALE_00, 0, 0, RATIO(3, 8)),
>    524			[23] = CH_DATA_INIT(SCALE_00, 0, 0, RATIO(3, 8)),
>    525			[30] = CH_DATA_INIT(SCALE_11, 0, 0, RATIO_DEF),
>    526			[31] = CH_DATA_INIT(SCALE_11, 0, 0, RATIO_DEF),
>    527		};
>    528	
>    529		sprd_adc_ch_data_merge(data, ch_data, &ch_data_def);

>  > 530	}  
>    531	
> 

