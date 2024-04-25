Return-Path: <linux-kernel+bounces-158802-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C065F8B2516
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 17:28:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78058283CB3
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 15:28:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FA7E14AD32;
	Thu, 25 Apr 2024 15:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="cpj7wH+H"
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 004DD38398
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 15:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714058906; cv=none; b=gHV3CBkRXXXyFvOnu4Ou1fRCisD732Yf5OY0LVk5DdqFpXrTTGxX1JwPRHGCqMx1i2wIr6TQWYEk5kgzNW9EXjSTMo+5Z9SSh2kvWF+th24pbNNt4l3e8dVvHDBsOS3kR5QMu4++ejUHIBhLY3q+Twq/2Pns2XdZbro0aIacRD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714058906; c=relaxed/simple;
	bh=0MbU3ChM8J2OnKuV3kYt/AmgV4Mh4O7LMoj+BzpMwiE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nDCM3hNtCVbPUy7bLdmPJbqBoW8Ijvi7+1FxBBYLkLZV9dTWvYU2bqbt6zeWG+5p7o1gakyWUpxya5yODOcfBgaIcPPug3E1+nIObUfIODcNRpOE17Al4M5FMm741f/uU/40bbW8srdXwNbF8D0yp52hme3oa2P0DSjj+Fu7shA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=cpj7wH+H; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <2ccef0f9-dc56-447c-8220-7f18a51c9db6@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1714058902;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nBajfC+xmlQaaxn7hJsHEIxPtAljDf6touR8fnAKxjs=;
	b=cpj7wH+H187fHQiQfp90z7TICktZ24vTxEcDC9zXA0sFZx45advxDNu5mwJQ2Zkpb+eoc7
	XB9nDYGroVl8qm4WZ8Txcl11q8eJLEVbAeapwkZBXsZkFNLikeXmJNn3Fy+WDN75/fyatU
	77uv30kEuOYprLa329tqZh4gqknfZ4c=
Date: Thu, 25 Apr 2024 11:28:17 -0400
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
 <0a57a33b-62da-4a8c-9f07-52c45cd5c57e@linux.dev>
 <4c625bb5-4f2c-4cff-9d65-7b6aa26a52c4@amd.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <4c625bb5-4f2c-4cff-9d65-7b6aa26a52c4@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 4/24/24 02:38, Michal Simek wrote:
> 
> 
> On 4/23/24 17:02, Sean Anderson wrote:
>> On 4/23/24 02:25, Michal Simek wrote:
>>>
>>>
>>> On 4/22/24 20:58, Sean Anderson wrote:
>>>> The phy "type" is just the combination of protocol and instance, and is
>>>> never used apart from that. Store the instance directly, instead of
>>>> converting to a type first. No functional change intended.
>>>>
>>>> Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
>>>> ---
>>>>
>>>>    drivers/phy/xilinx/phy-zynqmp.c | 107 +++++++-------------------------
>>>>    1 file changed, 24 insertions(+), 83 deletions(-)
>>>>
>>>> diff --git a/drivers/phy/xilinx/phy-zynqmp.c b/drivers/phy/xilinx/phy-zynqmp.c
>>>> index f72c5257d712..b507ed4c3053 100644
>>>> --- a/drivers/phy/xilinx/phy-zynqmp.c
>>>> +++ b/drivers/phy/xilinx/phy-zynqmp.c
>>>> @@ -146,22 +146,6 @@
>>>>    /* Total number of controllers */
>>>>    #define CONTROLLERS_PER_LANE        5
>>>>    -/* Protocol Type parameters */
>>>> -#define XPSGTR_TYPE_USB0        0  /* USB controller 0 */
>>>> -#define XPSGTR_TYPE_USB1        1  /* USB controller 1 */
>>>> -#define XPSGTR_TYPE_SATA_0        2  /* SATA controller lane 0 */
>>>> -#define XPSGTR_TYPE_SATA_1        3  /* SATA controller lane 1 */
>>>> -#define XPSGTR_TYPE_PCIE_0        4  /* PCIe controller lane 0 */
>>>> -#define XPSGTR_TYPE_PCIE_1        5  /* PCIe controller lane 1 */
>>>> -#define XPSGTR_TYPE_PCIE_2        6  /* PCIe controller lane 2 */
>>>> -#define XPSGTR_TYPE_PCIE_3        7  /* PCIe controller lane 3 */
>>>> -#define XPSGTR_TYPE_DP_0        8  /* Display Port controller lane 0 */
>>>> -#define XPSGTR_TYPE_DP_1        9  /* Display Port controller lane 1 */
>>>> -#define XPSGTR_TYPE_SGMII0        10 /* Ethernet SGMII controller 0 */
>>>> -#define XPSGTR_TYPE_SGMII1        11 /* Ethernet SGMII controller 1 */
>>>> -#define XPSGTR_TYPE_SGMII2        12 /* Ethernet SGMII controller 2 */
>>>> -#define XPSGTR_TYPE_SGMII3        13 /* Ethernet SGMII controller 3 */
>>>> -
>>>>    /* Timeout values */
>>>>    #define TIMEOUT_US            1000
>>>>    @@ -184,7 +168,8 @@ struct xpsgtr_ssc {
>>>>    /**
>>>>     * struct xpsgtr_phy - representation of a lane
>>>>     * @phy: pointer to the kernel PHY device
>>>> - * @type: controller which uses this lane
>>>> + * @instance: instance of the protocol type (such as the lane within a
>>>> + *            protocol, or the USB/Ethernet controller)
>>>>     * @lane: lane number
>>>>     * @protocol: protocol in which the lane operates
>>>>     * @skip_phy_init: skip phy_init() if true
>>>> @@ -193,7 +178,7 @@ struct xpsgtr_ssc {
>>>>     */
>>>>    struct xpsgtr_phy {
>>>>        struct phy *phy;
>>>> -    u8 type;
>>>> +    u8 instance;
>>>>        u8 lane;
>>>>        u8 protocol;
>>>>        bool skip_phy_init;
>>>> @@ -330,8 +315,8 @@ static int xpsgtr_wait_pll_lock(struct phy *phy)
>>>>          if (ret == -ETIMEDOUT)
>>>>            dev_err(gtr_dev->dev,
>>>> -            "lane %u (type %u, protocol %u): PLL lock timeout\n",
>>>> -            gtr_phy->lane, gtr_phy->type, gtr_phy->protocol);
>>>> +            "lane %u (protocol %u, instance %u): PLL lock timeout\n",
>>>> +            gtr_phy->lane, gtr_phy->protocol, gtr_phy->instance);
>>>>          return ret;
>>>>    }
>>>> @@ -643,8 +628,7 @@ static int xpsgtr_phy_power_on(struct phy *phy)
>>>>         * cumulating waits for both lanes. The user is expected to initialize
>>>>         * lane 0 last.
>>>>         */
>>>> -    if (gtr_phy->protocol != ICM_PROTOCOL_DP ||
>>>> -        gtr_phy->type == XPSGTR_TYPE_DP_0)
>>>> +    if (gtr_phy->protocol != ICM_PROTOCOL_DP || !gtr_phy->instance)
>>>>            ret = xpsgtr_wait_pll_lock(phy);
>>>>          return ret;
>>>> @@ -674,73 +658,33 @@ static const struct phy_ops xpsgtr_phyops = {
>>>>     * OF Xlate Support
>>>>     */
>>>>    -/* Set the lane type and protocol based on the PHY type and instance number. */
>>>> +/* Set the lane protocol and instance based on the PHY type and instance number. */
>>>>    static int xpsgtr_set_lane_type(struct xpsgtr_phy *gtr_phy, u8 phy_type,
>>>>                    unsigned int phy_instance)
>>>>    {
>>>>        unsigned int num_phy_types;
>>>> -    const int *phy_types;
>>>>          switch (phy_type) {
>>>> -    case PHY_TYPE_SATA: {
>>>> -        static const int types[] = {
>>>> -            XPSGTR_TYPE_SATA_0,
>>>> -            XPSGTR_TYPE_SATA_1,
>>>> -        };
>>>> -
>>>> -        phy_types = types;
>>>> -        num_phy_types = ARRAY_SIZE(types);
>>>> +    case PHY_TYPE_SATA:
>>>> +        num_phy_types = 2;
>>>>            gtr_phy->protocol = ICM_PROTOCOL_SATA;
>>>>            break;
>>>> -    }
>>>> -    case PHY_TYPE_USB3: {
>>>> -        static const int types[] = {
>>>> -            XPSGTR_TYPE_USB0,
>>>> -            XPSGTR_TYPE_USB1,
>>>> -        };
>>>> -
>>>> -        phy_types = types;
>>>> -        num_phy_types = ARRAY_SIZE(types);
>>>> +    case PHY_TYPE_USB3:
>>>> +        num_phy_types = 2;
>>>>            gtr_phy->protocol = ICM_PROTOCOL_USB;
>>>>            break;
>>>> -    }
>>>> -    case PHY_TYPE_DP: {
>>>> -        static const int types[] = {
>>>> -            XPSGTR_TYPE_DP_0,
>>>> -            XPSGTR_TYPE_DP_1,
>>>> -        };
>>>> -
>>>> -        phy_types = types;
>>>> -        num_phy_types = ARRAY_SIZE(types);
>>>> +    case PHY_TYPE_DP:
>>>> +        num_phy_types = 2;
>>>>            gtr_phy->protocol = ICM_PROTOCOL_DP;
>>>>            break;
>>>> -    }
>>>> -    case PHY_TYPE_PCIE: {
>>>> -        static const int types[] = {
>>>> -            XPSGTR_TYPE_PCIE_0,
>>>> -            XPSGTR_TYPE_PCIE_1,
>>>> -            XPSGTR_TYPE_PCIE_2,
>>>> -            XPSGTR_TYPE_PCIE_3,
>>>> -        };
>>>> -
>>>> -        phy_types = types;
>>>> -        num_phy_types = ARRAY_SIZE(types);
>>>> +    case PHY_TYPE_PCIE:
>>>> +        num_phy_types = 4;
>>>>            gtr_phy->protocol = ICM_PROTOCOL_PCIE;
>>>>            break;
>>>> -    }
>>>> -    case PHY_TYPE_SGMII: {
>>>> -        static const int types[] = {
>>>> -            XPSGTR_TYPE_SGMII0,
>>>> -            XPSGTR_TYPE_SGMII1,
>>>> -            XPSGTR_TYPE_SGMII2,
>>>> -            XPSGTR_TYPE_SGMII3,
>>>> -        };
>>>> -
>>>> -        phy_types = types;
>>>> -        num_phy_types = ARRAY_SIZE(types);
>>>> +    case PHY_TYPE_SGMII:
>>>> +        num_phy_types = 4;
>>>>            gtr_phy->protocol = ICM_PROTOCOL_SGMII;
>>>>            break;
>>>> -    }
>>>>        default:
>>>>            return -EINVAL;
>>>>        }
>>>> @@ -748,7 +692,7 @@ static int xpsgtr_set_lane_type(struct xpsgtr_phy *gtr_phy, u8 phy_type,
>>>>        if (phy_instance >= num_phy_types)
>>>>            return -EINVAL;
>>>>    -    gtr_phy->type = phy_types[phy_instance];
>>>> +    gtr_phy->instance = phy_instance;
>>>>        return 0;
>>>>    }
>>>>    @@ -756,14 +700,11 @@ static int xpsgtr_set_lane_type(struct xpsgtr_phy *gtr_phy, u8 phy_type,
>>>>     * Valid combinations of controllers and lanes (Interconnect Matrix).
>>>>     */
>>>>    static const unsigned int icm_matrix[NUM_LANES][CONTROLLERS_PER_LANE] = {
>>>> -    { XPSGTR_TYPE_PCIE_0, XPSGTR_TYPE_SATA_0, XPSGTR_TYPE_USB0,
>>>> -        XPSGTR_TYPE_DP_1, XPSGTR_TYPE_SGMII0 },
>>>> -    { XPSGTR_TYPE_PCIE_1, XPSGTR_TYPE_SATA_1, XPSGTR_TYPE_USB0,
>>>> -        XPSGTR_TYPE_DP_0, XPSGTR_TYPE_SGMII1 },
>>>> -    { XPSGTR_TYPE_PCIE_2, XPSGTR_TYPE_SATA_0, XPSGTR_TYPE_USB0,
>>>> -        XPSGTR_TYPE_DP_1, XPSGTR_TYPE_SGMII2 },
>>>> -    { XPSGTR_TYPE_PCIE_3, XPSGTR_TYPE_SATA_1, XPSGTR_TYPE_USB1,
>>>> -        XPSGTR_TYPE_DP_0, XPSGTR_TYPE_SGMII3 }
>>>> +    /* PCIe, SATA, USB, DP, SGMII */
>>>> +    { 0, 0, 0, 1, 0 },
>>>> +    { 1, 1, 0, 0, 1 },
>>>> +    { 2, 0, 0, 1, 2 },
>>>> +    { 3, 1, 1, 0, 3 },
>>>
>>>
>>> Do you think that this is more understandable than was before?
>>
>> Yes. This better matches the documentation. And now it is easier to
>> programmatically access the index. Before we might have
>>
>> protocol = ICM_PROTOCOL_USB
>> type = XPSGTR_TYPE_USB0
>>
>> and the instance is there in the type name, but we can't access it. Now
>> we have
>>
>> instance = 0
>>
>> and it is easy to determine which instance we have.
> 
> Numbers itself means in PCIE, SATA and DP number of lanes used but
> there is only single controller. In USB and SGMII case it is one lane
> per controller which is different information pointing to controller
> ID.

Yeah, the instance is really just to validate the devicetree binding.
It's not used in the driver except to determine the lane to wait for PLL
lock on in a multi-lane configuration.

> I didn't look at this driver for a while but at least for this array I
> would prefer to extend comment above to describe position of
> controllers and connected lanes and explain what that numbers really
> means.

OK, I will expand the comment for v2.

--Sean

