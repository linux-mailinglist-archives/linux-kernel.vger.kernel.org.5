Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 442497690E7
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 10:57:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231497AbjGaI5L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 04:57:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230005AbjGaI47 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 04:56:59 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BF801BEE
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 01:55:11 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1qQOfr-0004jn-6K; Mon, 31 Jul 2023 10:54:43 +0200
Received: from mfe by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1qQOfn-0004Bl-Pb; Mon, 31 Jul 2023 10:54:39 +0200
Date:   Mon, 31 Jul 2023 10:54:39 +0200
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     kernel test robot <lkp@intel.com>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        peppe.cavallaro@st.com, alexandre.torgue@foss.st.com,
        joabreu@synopsys.com, mcoquelin.stm32@gmail.com,
        oe-kbuild-all@lists.linux.dev, devicetree@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH net-next v3 2/2] net: stmmac: add support for phy-supply
Message-ID: <20230731085439.yj3iakjparweziis@pengutronix.de>
References: <20230720072304.3358701-2-m.felsch@pengutronix.de>
 <202307220459.2gaQtSqH-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202307220459.2gaQtSqH-lkp@intel.com>
User-Agent: NeoMutt/20180716
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23-07-22, kernel test robot wrote:
> Hi Marco,
> 
> kernel test robot noticed the following build errors:
> 
> [auto build test ERROR on net-next/main]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Marco-Felsch/net-stmmac-add-support-for-phy-supply/20230720-152642
> base:   net-next/main
> patch link:    https://lore.kernel.org/r/20230720072304.3358701-2-m.felsch%40pengutronix.de
> patch subject: [PATCH net-next v3 2/2] net: stmmac: add support for phy-supply
> config: x86_64-kexec (https://download.01.org/0day-ci/archive/20230722/202307220459.2gaQtSqH-lkp@intel.com/config)
> compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
> reproduce: (https://download.01.org/0day-ci/archive/20230722/202307220459.2gaQtSqH-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202307220459.2gaQtSqH-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):
> 
>    drivers/net/ethernet/stmicro/stmmac/stmmac_main.c: In function 'stmmac_suspend':
> >> drivers/net/ethernet/stmicro/stmmac/stmmac_main.c:7706:32: error: 'struct plat_stmmacenet_data' has no member named 'use_phy_wol'
>     7706 |                 if (!priv->plat->use_phy_wol)
>          |                                ^~
>    drivers/net/ethernet/stmicro/stmmac/stmmac_main.c: In function 'stmmac_resume':
>    drivers/net/ethernet/stmicro/stmmac/stmmac_main.c:7790:32: error: 'struct plat_stmmacenet_data' has no member named 'use_phy_wol'
>     7790 |                 if (!priv->plat->use_phy_wol)
>          |                                ^~

The fixed v4 can be found here:

https://lore.kernel.org/all/20230721110345.3925719-1-m.felsch@pengutronix.de/

Regards,
  Marco
