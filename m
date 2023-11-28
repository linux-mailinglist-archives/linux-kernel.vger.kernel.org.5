Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F6D27FB07B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 04:37:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234539AbjK1DEn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 22:04:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbjK1DEl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 22:04:41 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 836EC19D
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 19:04:48 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19AC4C433C8;
        Tue, 28 Nov 2023 03:04:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701140688;
        bh=0vxwWk/VtiJW0Rl/IFPmfADKzDSf/OCJueWE5wdyi8I=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=I/5Y4FwXlHyjodxNo0IyDpBLKOgRgfNrb/EIB6ikSZmOTkmzdUneCtLpBvckwvno0
         sqHJ9px9v6GOF6B1V+jUwkkSi60XoCAeNE/8yQoH5TsAmyuBp12pmZYTKU4BZs5iQ5
         ODgbqb5yh33cUJxuyPnWZFuSLT3sQFfdf4ieZrs+rr0fDSHw0Gc6W/FwCPdIUt2vqm
         4cFSdenddOGYWtg2Yvze9OHaawUlbZ1c36aG2bD+PA3FE4f4SVlZMLVGrmUXtt+c9p
         UDjbYPSFslp9SvhPEiw7ZS7RYL9bp3zRn2AsDirTKt7daJDPscV4P1hDPWboXlHH9F
         /N7A9M4FD0hyw==
Date:   Mon, 27 Nov 2023 19:04:46 -0800
From:   Jakub Kicinski <kuba@kernel.org>
To:     Jianheng Zhang <Jianheng.Zhang@synopsys.com>
Cc:     Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <Jose.Abreu@synopsys.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Simon Horman <horms@kernel.org>,
        Andrew Halaney <ahalaney@redhat.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Shenwei Wang <shenwei.wang@nxp.com>,
        Johannes Zink <j.zink@pengutronix.de>,
        "Russell King (Oracle" <rmk+kernel@armlinux.org.uk>,
        Jochen Henneberg <jh@henneberg-systemdesign.com>,
        Voon Weifeng <weifeng.voon@intel.com>,
        Mohammad Athari Bin Ismail <mohammad.athari.ismail@intel.com>,
        Ong Boon Leong <boon.leong.ong@intel.com>,
        Tan Tee Min <tee.min.tan@intel.com>,
        "open list:STMMAC ETHERNET DRIVER" <netdev@vger.kernel.org>,
        "moderated list:ARM/STM32 ARCHITECTURE" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "moderated list:ARM/STM32 ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        Martin McKenny <Martin.McKenny@synopsys.com>,
        James Li <James.Li1@synopsys.com>
Subject: Re: [PATCH v2] net: stmmac: fix FPE events losing
Message-ID: <20231127190446.58f14db6@kernel.org>
In-Reply-To: <CY5PR12MB637218C74342CCAF7AFCB85FBFBDA@CY5PR12MB6372.namprd12.prod.outlook.com>
References: <CY5PR12MB637218C74342CCAF7AFCB85FBFBDA@CY5PR12MB6372.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Nov 2023 07:08:17 +0000 Jianheng Zhang wrote:
> Signed-off-by: jianheng <jianheng@synopsys.com>

Your name and email addr in From are both different than the form used
in the Signed-off-by tag. Please fix that and repost (keep Serge's
review tag).
-- 
pw-bot: cr
