Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F101775D8D6
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 03:56:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229832AbjGVB4D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 21:56:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjGVB4B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 21:56:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98B173C03
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 18:56:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0618761DA6
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jul 2023 01:56:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DDFBC433C7;
        Sat, 22 Jul 2023 01:55:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689990959;
        bh=YIMeHkWDQz0s9WX+GvHlnTsrUYqiF/JbCOjQIvlM93w=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=QtG+EqkDWjYmXfT6W2+RRIIw3VCT7iNprPoryweITTLIZQAFRd3gVufVMWUxmmsul
         HCKR1AN0lxPA3hmXAiLaXAVRuKsI2gc+opDB2OjYyOMIdj3TpUcB4uZAXG84LT8AiK
         Ris27qqhb6z6/DcvMi6iORTY3J9T2iSD6evm9sIK4BvedCmlTyRcPW+QhpL4MA5ki1
         tiYrRGQaOBr/oeJ9jfuUtH1bDrayxlOTcNcAMpk5oNHYJKqSvVAz6YFQnU6zDNti4W
         5+SDb60GfJEblfk6305HyRSK2/rf1QC2g91xGVXnUyhaq9GCzeaU6tQ3SZv4zmLkO+
         VMBF6BtTXD6YA==
Date:   Fri, 21 Jul 2023 18:55:57 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     "Ng, Boon Khai" <boon.khai.ng@intel.com>,
        "Boon@ecsmtp.png.intel.com" <Boon@ecsmtp.png.intel.com>,
        "Khai@ecsmtp.png.intel.com" <Khai@ecsmtp.png.intel.com>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Shevchenko, Andriy" <andriy.shevchenko@intel.com>,
        "Tham, Mun Yew" <mun.yew.tham@intel.com>,
        "Swee, Leong Ching" <leong.ching.swee@intel.com>,
        "G Thomas, Rohan" <rohan.g.thomas@intel.com>,
        Shevchenko Andriy <andriy.shevchenko@linux.intel.com>,
        Joe Perches <joe@perches.com>
Subject: Re: [Enable Designware XGMAC VLAN Stripping Feature 1/2]
 dt-bindings: net: snps,dwmac: Add description for rx-vlan-offload
Message-ID: <20230721185557.199fb5b8@kernel.org>
In-Reply-To: <8e2f9c5f-6249-4325-58b2-a14549eb105d@kernel.org>
References: <20230721062617.9810-1-boon.khai.ng@intel.com>
        <20230721062617.9810-2-boon.khai.ng@intel.com>
        <e552cea3-abbb-93e3-4167-aebe979aac6b@kernel.org>
        <DM8PR11MB5751EAB220E28AECF6153522C13FA@DM8PR11MB5751.namprd11.prod.outlook.com>
        <8e2f9c5f-6249-4325-58b2-a14549eb105d@kernel.org>
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

On Fri, 21 Jul 2023 18:21:32 +0200 Krzysztof Kozlowski wrote:
> > $ ./scripts/get_maintainer.pl  --scm  -f drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c  
> 
> That's not how you run it. get_maintainers.pl should be run on patches
> or on all files, not just some selection.

Adding Joe for visibility (I proposed to print a warning when people 
do this and IIRC he wasn't on board).
