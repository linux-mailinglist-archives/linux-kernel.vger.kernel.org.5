Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8822E7774E9
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 11:52:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232817AbjHJJw2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 05:52:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbjHJJw0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 05:52:26 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58D7C211B;
        Thu, 10 Aug 2023 02:52:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691661146; x=1723197146;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=0QXCdnIeDvNVhe3zDIXfKLHqjJhkR646hmb6U9XbWSc=;
  b=Pjlp4NDNGMDyCcIa4mvhaYddipIjoLKEoU5aZ743tqoSdWpB/EFe93YC
   PW4KbQoE49DrQauDTH5Zm3y530T+5hZs219c+a0Ped1oK/LL8NUi4hRcw
   Fnv4C39ySNuZo1tD5ygw23FBfajZpb2uxT4Yu48+JWMComWWWKV67RvpJ
   AQbEb8N9WYR3jjAYDVqoF1HwpyNRuRXHkIxBB/1AdPzEuOtVGO0GfU8/r
   cU4Rat2tPxkc93+R6QRwyrVufvSbI+MI+rgowaolTB+5T1TBvy5ZA3Mgl
   LxhgiU0eljl8u1Tx9DcVp6oPhuu2IZKcxRbbyp8R0obCcgQzcB9zDTUnj
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10797"; a="368810604"
X-IronPort-AV: E=Sophos;i="6.01,161,1684825200"; 
   d="scan'208";a="368810604"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2023 02:52:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10797"; a="732142399"
X-IronPort-AV: E=Sophos;i="6.01,161,1684825200"; 
   d="scan'208";a="732142399"
Received: from choongyo-mobl.gar.corp.intel.com (HELO [10.213.42.193]) ([10.213.42.193])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2023 02:52:13 -0700
Message-ID: <5e113258-7cb4-e503-5009-e46cd3aa5bee@linux.intel.com>
Date:   Thu, 10 Aug 2023 17:52:10 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH net-next v2 0/5] TSN auto negotiation between 1G and 2.5G
Content-Language: en-US
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>,
        David E Box <david.e.box@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Jose Abreu <Jose.Abreu@synopsys.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        =?UTF-8?Q?Marek_Beh=c3=ban?= <kabel@kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Wong Vee Khee <veekhee@apple.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Revanth Kumar Uppala <ruppala@nvidia.com>,
        Shenwei Wang <shenwei.wang@nxp.com>,
        Andrey Konovalov <andrey.konovalov@linaro.org>,
        Jochen Henneberg <jh@henneberg-systemdesign.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        platform-driver-x86@vger.kernel.org, linux-hwmon@vger.kernel.org,
        bpf@vger.kernel.org, Voon Wei Feng <weifeng.voon@intel.com>,
        Tan Tee Min <tee.min.tan@linux.intel.com>,
        Michael Sit Wei Hong <michael.wei.hong.sit@intel.com>,
        Lai Peter Jun Ann <jun.ann.lai@intel.com>
References: <20230804084527.2082302-1-yong.liang.choong@linux.intel.com>
 <5bd05ba2-fd88-4e5c-baed-9971ff917484@lunn.ch>
From:   Choong Yong Liang <yong.liang.choong@linux.intel.com>
In-Reply-To: <5bd05ba2-fd88-4e5c-baed-9971ff917484@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/8/2023 8:04 pm, Andrew Lunn wrote:
> On Fri, Aug 04, 2023 at 04:45:22PM +0800, Choong Yong Liang wrote:
>> Intel platforms’ integrated Gigabit Ethernet controllers support
>> 2.5Gbps mode statically using BIOS programming. In the current
>> implementation, the BIOS menu provides an option to select between
>> 10/100/1000Mbps and 2.5Gbps modes. Based on the selection, the BIOS
>> programs the Phase Lock Loop (PLL) registers. The BIOS also read the
>> TSN lane registers from Flexible I/O Adapter (FIA) block and provided
>> 10/100/1000Mbps/2.5Gbps information to the stmmac driver. But
>> auto-negotiation between 10/100/1000Mbps and 2.5Gbps is not allowed.
>> The new proposal is to support auto-negotiation between 10/100/1000Mbps
>> and 2.5Gbps . Auto-negotiation between 10, 100, 1000Mbps will use
>> in-band auto negotiation. Auto-negotiation between 10/100/1000Mbps and
>> 2.5Gbps will work as the following proposed flow, the stmmac driver reads
>> the PHY link status registers then identifies the negotiated speed.
>> Based on the speed stmmac driver will identify TSN lane registers from
>> FIA then send IPC command to the Power Management controller (PMC)
>> through PMC driver/API. PMC will act as a proxy to programs the
>> PLL registers.
> 
> Have you considered using out of band for all link modes? You might
> end up with a cleaner architecture, and not need any phylink/phylib
> hacks.
> 
> 	Andrew
Hi Andrew,

Thank you for your feedback.
I will study the feasibility of the out-of-band (OOB) approach.
