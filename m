Return-Path: <linux-kernel+bounces-155412-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BC4BB8AEA0A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 17:02:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E479AB212F5
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 15:02:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 515CE13B7A3;
	Tue, 23 Apr 2024 15:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="q4orp9oU"
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F7A3290F
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 15:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713884541; cv=none; b=pMVJ8FVtUXI9vXCLviTF6gpiyoqvKeXC1Tk9ZohHSKndVj3rVco1GM9OzFuafDA4CFpvVPg3AL6VCQ1iPCav87WSJlg3qsQU12jwMwUDkPgMAdRlI5hiaSj/0kF0ngoTF4o33rhxw94JTxpO+vzqFptr2m8TPYj+eKftjzb+omY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713884541; c=relaxed/simple;
	bh=ComnrBCclNp6YpFAR2jTp48J/cIrS6UPJ0t6m1tnniY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oMaoeEcaZYHDjbYrUQCeG0vHwpbMtwm0iIEzNS6lpvx6rzd2yBzc9STDFpdCdfBBFOBjX4RCxGlrT80mnqzwyB1UHQr/ZKWmedqdX0Vd5TlL1LCGKqkhs37uf08ve4S5STUB1qBivk+lX5hlSulqOLUwbMgxRee8U14zztkoTR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=q4orp9oU; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <0a57a33b-62da-4a8c-9f07-52c45cd5c57e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1713884534;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cfLXIY2uxd/VaQ2Mp5L3agAzyFn2+FCGqgmlpStEFOE=;
	b=q4orp9oUX63kYjDKd43Nimw7ARdfZdwm++K/ltqZggJ2W1rV7ycHuiRTsAmLrws4efzPC9
	P71yNq3bdfWYhkW0mSMHg95duJzrF3J3bqPrOFpkQIS7i+QLxg52o+4QNJLyRYhAeG3cRe
	JvL96Yk8BUzaz8uKCt5IETki3iRp2Jg=
Date: Tue, 23 Apr 2024 11:02:11 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 1/3] phy: zynqmp: Store instance instead of type
To: Michal Simek <michal.simek@amd.com>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 linux-phy@lists.infradead.org
Cc: Vinod Koul <vkoul@kernel.org>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 Kishon Vijay Abraham I <kishon@kernel.org>
References: <20240422185803.3575319-1-sean.anderson@linux.dev>
 <20240422185803.3575319-2-sean.anderson@linux.dev>
 <702f0ca6-7edb-4328-92e8-1853ba010910@amd.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <702f0ca6-7edb-4328-92e8-1853ba010910@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 4/23/24 02:25, Michal Simek wrote:
> 
> 
> On 4/22/24 20:58, Sean Anderson wrote:
>> The phy "type" is just the combination of protocol and instance, and is
>> never used apart from that. Store the instance directly, instead of
>> converting to a type first. No functional change intended.
>>
>> Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
>> ---
>>
>>   drivers/phy/xilinx/phy-zynqmp.c | 107 +++++++-------------------------
>>   1 file changed, 24 insertions(+), 83 deletions(-)
>>
>> diff --git a/drivers/phy/xilinx/phy-zynqmp.c b/drivers/phy/xilinx/phy-zynqmp.c
>> index f72c5257d712..b507ed4c3053 100644
>> --- a/drivers/phy/xilinx/phy-zynqmp.c
>> +++ b/drivers/phy/xilinx/phy-zynqmp.c
>> @@ -146,22 +146,6 @@
>>   /* Total number of controllers */
>>   #define CONTROLLERS_PER_LANE        5
>>   -/* Protocol Type parameters */
>> -#define XPSGTR_TYPE_USB0        0  /* USB controller 0 */
>> -#define XPSGTR_TYPE_USB1        1  /* USB controller 1 */
>> -#define XPSGTR_TYPE_SATA_0        2  /* SATA controller lane 0 */
>> -#define XPSGTR_TYPE_SATA_1        3  /* SATA controller lane 1 */
>> -#define XPSGTR_TYPE_PCIE_0        4  /* PCIe controller lane 0 */
>> -#define XPSGTR_TYPE_PCIE_1        5  /* PCIe controller lane 1 */
>> -#define XPSGTR_TYPE_PCIE_2        6  /* PCIe controller lane 2 */
>> -#define XPSGTR_TYPE_PCIE_3        7  /* PCIe controller lane 3 */
>> -#define XPSGTR_TYPE_DP_0        8  /* Display Port controller lane 0 */
>> -#define XPSGTR_TYPE_DP_1        9  /* Display Port controller lane 1 */
>> -#define XPSGTR_TYPE_SGMII0        10 /* Ethernet SGMII controller 0 */
>> -#define XPSGTR_TYPE_SGMII1        11 /* Ethernet SGMII controller 1 */
>> -#define XPSGTR_TYPE_SGMII2        12 /* Ethernet SGMII controller 2 */
>> -#define XPSGTR_TYPE_SGMII3        13 /* Ethernet SGMII controller 3 */
>> -
>>   /* Timeout values */
>>   #define TIMEOUT_US            1000
>>   @@ -184,7 +168,8 @@ struct xpsgtr_ssc {
>>   /**
>>    * struct xpsgtr_phy - representation of a lane
>>    * @phy: pointer to the kernel PHY device
>> - * @type: controller which uses this lane
>> + * @instance: instance of the protocol type (such as the lane within a
>> + *            protocol, or the USB/Ethernet controller)
>>    * @lane: lane number
>>    * @protocol: protocol in which the lane operates
>>    * @skip_phy_init: skip phy_init() if true
>> @@ -193,7 +178,7 @@ struct xpsgtr_ssc {
>>    */
>>   struct xpsgtr_phy {
>>       struct phy *phy;
>> -    u8 type;
>> +    u8 instance;
>>       u8 lane;
>>       u8 protocol;
>>       bool skip_phy_init;
>> @@ -330,8 +315,8 @@ static int xpsgtr_wait_pll_lock(struct phy *phy)
>>         if (ret == -ETIMEDOUT)
>>           dev_err(gtr_dev->dev,
>> -            "lane %u (type %u, protocol %u): PLL lock timeout\n",
>> -            gtr_phy->lane, gtr_phy->type, gtr_phy->protocol);
>> +            "lane %u (protocol %u, instance %u): PLL lock timeout\n",
>> +            gtr_phy->lane, gtr_phy->protocol, gtr_phy->instance);
>>         return ret;
>>   }
>> @@ -643,8 +628,7 @@ static int xpsgtr_phy_power_on(struct phy *phy)
>>        * cumulating waits for both lanes. The user is expected to initialize
>>        * lane 0 last.
>>        */
>> -    if (gtr_phy->protocol != ICM_PROTOCOL_DP ||
>> -        gtr_phy->type == XPSGTR_TYPE_DP_0)
>> +    if (gtr_phy->protocol != ICM_PROTOCOL_DP || !gtr_phy->instance)
>>           ret = xpsgtr_wait_pll_lock(phy);
>>         return ret;
>> @@ -674,73 +658,33 @@ static const struct phy_ops xpsgtr_phyops = {
>>    * OF Xlate Support
>>    */
>>   -/* Set the lane type and protocol based on the PHY type and instance number. */
>> +/* Set the lane protocol and instance based on the PHY type and instance number. */
>>   static int xpsgtr_set_lane_type(struct xpsgtr_phy *gtr_phy, u8 phy_type,
>>                   unsigned int phy_instance)
>>   {
>>       unsigned int num_phy_types;
>> -    const int *phy_types;
>>         switch (phy_type) {
>> -    case PHY_TYPE_SATA: {
>> -        static const int types[] = {
>> -            XPSGTR_TYPE_SATA_0,
>> -            XPSGTR_TYPE_SATA_1,
>> -        };
>> -
>> -        phy_types = types;
>> -        num_phy_types = ARRAY_SIZE(types);
>> +    case PHY_TYPE_SATA:
>> +        num_phy_types = 2;
>>           gtr_phy->protocol = ICM_PROTOCOL_SATA;
>>           break;
>> -    }
>> -    case PHY_TYPE_USB3: {
>> -        static const int types[] = {
>> -            XPSGTR_TYPE_USB0,
>> -            XPSGTR_TYPE_USB1,
>> -        };
>> -
>> -        phy_types = types;
>> -        num_phy_types = ARRAY_SIZE(types);
>> +    case PHY_TYPE_USB3:
>> +        num_phy_types = 2;
>>           gtr_phy->protocol = ICM_PROTOCOL_USB;
>>           break;
>> -    }
>> -    case PHY_TYPE_DP: {
>> -        static const int types[] = {
>> -            XPSGTR_TYPE_DP_0,
>> -            XPSGTR_TYPE_DP_1,
>> -        };
>> -
>> -        phy_types = types;
>> -        num_phy_types = ARRAY_SIZE(types);
>> +    case PHY_TYPE_DP:
>> +        num_phy_types = 2;
>>           gtr_phy->protocol = ICM_PROTOCOL_DP;
>>           break;
>> -    }
>> -    case PHY_TYPE_PCIE: {
>> -        static const int types[] = {
>> -            XPSGTR_TYPE_PCIE_0,
>> -            XPSGTR_TYPE_PCIE_1,
>> -            XPSGTR_TYPE_PCIE_2,
>> -            XPSGTR_TYPE_PCIE_3,
>> -        };
>> -
>> -        phy_types = types;
>> -        num_phy_types = ARRAY_SIZE(types);
>> +    case PHY_TYPE_PCIE:
>> +        num_phy_types = 4;
>>           gtr_phy->protocol = ICM_PROTOCOL_PCIE;
>>           break;
>> -    }
>> -    case PHY_TYPE_SGMII: {
>> -        static const int types[] = {
>> -            XPSGTR_TYPE_SGMII0,
>> -            XPSGTR_TYPE_SGMII1,
>> -            XPSGTR_TYPE_SGMII2,
>> -            XPSGTR_TYPE_SGMII3,
>> -        };
>> -
>> -        phy_types = types;
>> -        num_phy_types = ARRAY_SIZE(types);
>> +    case PHY_TYPE_SGMII:
>> +        num_phy_types = 4;
>>           gtr_phy->protocol = ICM_PROTOCOL_SGMII;
>>           break;
>> -    }
>>       default:
>>           return -EINVAL;
>>       }
>> @@ -748,7 +692,7 @@ static int xpsgtr_set_lane_type(struct xpsgtr_phy *gtr_phy, u8 phy_type,
>>       if (phy_instance >= num_phy_types)
>>           return -EINVAL;
>>   -    gtr_phy->type = phy_types[phy_instance];
>> +    gtr_phy->instance = phy_instance;
>>       return 0;
>>   }
>>   @@ -756,14 +700,11 @@ static int xpsgtr_set_lane_type(struct xpsgtr_phy *gtr_phy, u8 phy_type,
>>    * Valid combinations of controllers and lanes (Interconnect Matrix).
>>    */
>>   static const unsigned int icm_matrix[NUM_LANES][CONTROLLERS_PER_LANE] = {
>> -    { XPSGTR_TYPE_PCIE_0, XPSGTR_TYPE_SATA_0, XPSGTR_TYPE_USB0,
>> -        XPSGTR_TYPE_DP_1, XPSGTR_TYPE_SGMII0 },
>> -    { XPSGTR_TYPE_PCIE_1, XPSGTR_TYPE_SATA_1, XPSGTR_TYPE_USB0,
>> -        XPSGTR_TYPE_DP_0, XPSGTR_TYPE_SGMII1 },
>> -    { XPSGTR_TYPE_PCIE_2, XPSGTR_TYPE_SATA_0, XPSGTR_TYPE_USB0,
>> -        XPSGTR_TYPE_DP_1, XPSGTR_TYPE_SGMII2 },
>> -    { XPSGTR_TYPE_PCIE_3, XPSGTR_TYPE_SATA_1, XPSGTR_TYPE_USB1,
>> -        XPSGTR_TYPE_DP_0, XPSGTR_TYPE_SGMII3 }
>> +    /* PCIe, SATA, USB, DP, SGMII */
>> +    { 0, 0, 0, 1, 0 },
>> +    { 1, 1, 0, 0, 1 },
>> +    { 2, 0, 0, 1, 2 },
>> +    { 3, 1, 1, 0, 3 },
> 
> 
> Do you think that this is more understandable than was before?

Yes. This better matches the documentation. And now it is easier to
programmatically access the index. Before we might have

protocol = ICM_PROTOCOL_USB
type = XPSGTR_TYPE_USB0

and the instance is there in the type name, but we can't access it. Now
we have

instance = 0

and it is easy to determine which instance we have.

--Sean

