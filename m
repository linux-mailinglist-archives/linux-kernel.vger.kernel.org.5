Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FA7F75CF19
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 18:27:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232918AbjGUQ1b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 12:27:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232938AbjGUQ1K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 12:27:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C216165AD
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 09:24:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 52DC361CC1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 16:22:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17C49C433C7;
        Fri, 21 Jul 2023 16:22:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689956578;
        bh=Ew/4v1UbqQoZb20JkMzVmOCzBgdeH1pynDMmIlPkrEM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=eQZfFq4H2O53duuZx0xDupi2JgSJ+w6qoYQwPDqw0N9WeaLxg0UDAhgWguoUy+HeH
         6kR3WQuNy1RtWqPJcV9+jAlF+QSl/ZdNN2rjEDzw56/aMxO8u6jQ2G9sjT+Vo/Abco
         JS3TF41A4nHUJbhiKGBM971t50MOf37nEgb19kUNbMSEVuPicvcQ7dV1e6Uf2LWInW
         q5SyIEgjyzCdBJQtwtPR5afInW7MJXZcSFQ4TlQ21fSQfmNLRAB/z0pxkDr/xPwbWT
         PFG7vztmFl/tr2eI7+N13atfihHYhofUnv81z5uu9IKb+5+rtlRsiaUpbYqKXHE6rN
         U/bKoy49yJHOg==
Message-ID: <68485bf5-0550-4954-cbaa-7f6a5443e4aa@kernel.org>
Date:   Fri, 21 Jul 2023 18:22:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [Enable Designware XGMAC VLAN Stripping Feature 2/2] net: stmmac:
 dwxgmac2: Add support for HW-accelerated VLAN Stripping
Content-Language: en-US
To:     Florian Fainelli <f.fainelli@gmail.com>,
        "Ng, Boon Khai" <boon.khai.ng@intel.com>,
        "Boon@ecsmtp.png.intel.com" <Boon@ecsmtp.png.intel.com>,
        "Khai@ecsmtp.png.intel.com" <Khai@ecsmtp.png.intel.com>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     "Shevchenko, Andriy" <andriy.shevchenko@intel.com>,
        "Tham, Mun Yew" <mun.yew.tham@intel.com>,
        "Swee, Leong Ching" <leong.ching.swee@intel.com>,
        "G Thomas, Rohan" <rohan.g.thomas@intel.com>,
        Shevchenko Andriy <andriy.shevchenko@linux.intel.com>
References: <20230721062617.9810-1-boon.khai.ng@intel.com>
 <20230721062617.9810-3-boon.khai.ng@intel.com>
 <cfba8fa4-47e5-7553-f40e-9e34b25d1405@kernel.org>
 <DM8PR11MB5751E5388AEFCFB80BCB483FC13FA@DM8PR11MB5751.namprd11.prod.outlook.com>
 <7549a014-4f5e-cf87-f07d-c4980ab44dc1@gmail.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <7549a014-4f5e-cf87-f07d-c4980ab44dc1@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/07/2023 17:59, Florian Fainelli wrote:
>>>> +	/* Rx VLAN HW Stripping */
>>>> +	if (of_property_read_bool(np, "snps,rx-vlan-offload")) {
>>>> +		dev_info(&pdev->dev, "RX VLAN HW Stripping\n");
>>>
>>> Why? Drop.
>>>
>>
>> This is an dts option export to dts for user to choose whether or not they
>> Want a Hardware stripping or a software stripping.
>>
>> May I know what is the reason to drop this?
> 
> Because the networking stack already exposes knobs for drivers to 
> advertise and control VLAN stripping/insertion on RX/TX using ethtool 
> and feature bits (NETIF_F_HW_VLAN_CTAG_RX, NETIF_F_HW_VLAN_CTAG_TX).
> 
> What you are doing here is encode a policy as a Device Tree property 
> rather than describe whether the hardware supports a given feature and 
> this is frowned upon.

That's even better reason...

Best regards,
Krzysztof

