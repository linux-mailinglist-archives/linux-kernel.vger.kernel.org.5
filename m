Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15DCA767DE5
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 11:58:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232022AbjG2J61 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jul 2023 05:58:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230369AbjG2J6Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jul 2023 05:58:25 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2118.outbound.protection.outlook.com [40.107.93.118])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09E2A129;
        Sat, 29 Jul 2023 02:58:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kAjvWat6+C1BrnrTjBZafNDDBeL0M5bogd1ZgJrjpjq3Y+FMXWijzVMCbDFbbdPZAVai30QUyxWsayraCgE7qNggXnYiJG/EwpeXQ3w+cQQLxZeyc/hqRv5nMnMY2skaLrmIcdzBWXNO3PeF3GMKHbti38hp3tJa8RPoWm/vYT+nRynnswHXDlVqkKPEpk/zw0Tak1/yUPGJYVUJJQycewsG+8mClblrGnaH54mqeY+GiVHPvkLUw94WM8LzMKs7mKXS57oUDd33Uyx1GRWvfyYOTP6qJ0Do+d4zduujyHyDD8qrWa3kF62cIl5qqcyQXEeIg+VnH+XiBd/IZkJZFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0VaS0VXvkqFyy3/JYNGUDh9ejao0VPFJIBS3yDJ25/Y=;
 b=GvDPOQJRyOzPbq9C6Nn6yBOwXZYXHIxbPZqlSAc7sTXwKgJHVH1V/ExcXfGPZAEzeop6t5WzfnDSfHIjT3U/I+Mjr2ZznxfF1mxwIoPSgOaTxwVy9d5baYAfM4CSSjQoKmFcD/elX3Y2CgWndf2v8DkMgXJSBdRD64ckyv0vxBYOa5t80+6LhpAiyidHq7RAqGKq2P9EEmDACXUfpQ5YifiEHsl5RiKvwsiIZcoOsvQZQHXsbyd6gL9d5Iy3pXR3sEhDDDhEgVkVGmS5M6JkS2Qaf9x9eAL7LJEzLXUmEQoRjnCia9A2W7t4PEmZPOOZdtHfWzRBU+lpFq5pXmuu7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0VaS0VXvkqFyy3/JYNGUDh9ejao0VPFJIBS3yDJ25/Y=;
 b=JsbykddI5VkY6ZFSO931vQEmOyieYi5r2+IamB+1/6W6WkHPwfnQcyqvCi+/R9qjo70Ohef7zCrFJCrXPDTO7Ozu195uthYEjqdkivmcgMi95ht2Y5AZ1IMVJqfOMFH6bmI7OX19FTMq/umzJJ2xTWqHw24VyvJMYkAkX45VtYQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by SJ0PR13MB5676.namprd13.prod.outlook.com (2603:10b6:a03:403::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.32; Sat, 29 Jul
 2023 09:58:22 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::fde7:9821:f2d9:101d]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::fde7:9821:f2d9:101d%7]) with mapi id 15.20.6631.026; Sat, 29 Jul 2023
 09:58:22 +0000
Date:   Sat, 29 Jul 2023 11:58:14 +0200
From:   Simon Horman <simon.horman@corigine.com>
To:     Suman Ghosh <sumang@marvell.com>
Cc:     sgoutham@marvell.com, gakula@marvell.com, sbhatta@marvell.com,
        hkelam@marvell.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, lcherian@marvell.com,
        jerinj@marvell.com
Subject: Re: [net-next PATCH V2] octeontx2-af: Tc flower offload support for
 inner VLAN
Message-ID: <ZMTitp4+oc3+/D1U@corigine.com>
References: <20230727051252.2779804-1-sumang@marvell.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230727051252.2779804-1-sumang@marvell.com>
X-ClientProxiedBy: AS4PR09CA0013.eurprd09.prod.outlook.com
 (2603:10a6:20b:5e0::19) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|SJ0PR13MB5676:EE_
X-MS-Office365-Filtering-Correlation-Id: 953fe6fd-0c0b-4bd8-3e8f-08db901a576e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9IOl7384xg6m2x1jtlKm3tpUWnR7aBX/IAhxwvhB+H5aX68O058zwb+KS4DeHTd6lvT9+q4CVgwvgufwF0+mWtcU/+8+PGSFvM5n+SKiuEL+feyghcozq8BPwb4nUnTTb/8H2gNNjf7WQEOTebnH8qWblgCcyTeI2bLFevQRGfttegOpOTn0CaFfIrMWThDqjU5xVHFpdnBubvMdPHitfMO+eN8aKgTreLBB8l9ewZU3ywC0lT2KeYChdoBP+5GwSa9Xf1Pz/9HabjStMZd9oDwgZXqS9oSDSIqGlFXaAZe+Dp0bkOMTnTQPVYLDXTn6tDCwGBIEkIMjUf2e4CBhbdJ+sGOYk7ngC591kk5X+5slvRRzKjNSRa8rBmmvTyNTfMbBXwqecOP7I1l3p0gF+3WpCkJ8RBwLKRc2kuRpL2LLyHQgrm4dcU1h+E9j6OTMOV6vsZdZankWczU/MzGGIkZbL5/ODytKZHBiIVFCUrWugwLy2eVsW4c/CJE59jTaRnczxS9aIUXBMFdTyADhvOajmxfXqPcoKoxmurQU8/MVNjTc/ptIqoCLFxbdprCDGsySYdZqHoBnMEIfPjctMj0OiK/iV5eAt56MMnQ/Dwc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(39830400003)(366004)(346002)(136003)(451199021)(6506007)(478600001)(6666004)(6486002)(6512007)(36756003)(186003)(44832011)(2906002)(8676002)(2616005)(6916009)(316002)(41300700001)(7416002)(5660300002)(38100700002)(66946007)(4326008)(66476007)(66556008)(8936002)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Ib8pJXvF1oWqGqZaTecQ/nD8aveWhEm1fHyOg/oXP7Sw9R+oOvcVejij1a8D?=
 =?us-ascii?Q?CVtJP2tGCgWZrFk3C9umMX7VWUynlLHUqFVyM2q1uNRzTwgHsgcF5heqGDbP?=
 =?us-ascii?Q?XgDwoJUfi1UxNp28gu4/X3JdCZ/M0zVHygKi50ASyINlb/AjMtywC3j9URbO?=
 =?us-ascii?Q?IFtU7n13t3hoMHZHx+qUGpqjNVsCRjYIgp3YnH66GDnsWrxk4tQYO49yASYg?=
 =?us-ascii?Q?p3PSUcnDGCAdHbZYckLHRJ8Q4y7i6mCzOYgh3asLF0LTIntuum7+jDTfoQbb?=
 =?us-ascii?Q?lGCEmnWr4PJ+wFmtq5AI0BT2vIL1/+J6qWkcbkoK+IyaOCjLFN6l8reay6X7?=
 =?us-ascii?Q?h6CLst0S1dhwniPXK1AO91X+OKbfa8pFm9FmIhUgeH6fbajIizX3h7DCr4SW?=
 =?us-ascii?Q?qJJusd3qqm9cqRy+GvSYFGCFTHPGhc0L7Bn6O2W3LC1H9TZLHFtDWhy/HOLi?=
 =?us-ascii?Q?F92YNdKXvmItUm3iiqa87pxS1G/It4O+ERWjzFwQUFpc0Y1FUT0bsOVMyXTQ?=
 =?us-ascii?Q?2Hl+RqyPsnxCpZc/NqM+lNuAcsz9qAR34HjXVuQo/tdsn6zoLZjhRCYfBO1n?=
 =?us-ascii?Q?tNSvYT5PAkQnqZiRgBC2ASk0uscwBrY/tik34VcqTpEu/Aji3BfjPTWckhoc?=
 =?us-ascii?Q?S47OGm+E0fzPlsUjNpRs7mtO/MII7upGnSK2YHudw/lidIxtjd4sC5IITyLH?=
 =?us-ascii?Q?dz9tAbLrCoHcBeeVQGU/0OKwq8kdZH149Yp2BJ6rh//jpWBjiUkWIisL58Rg?=
 =?us-ascii?Q?fNGAX2ZQOpTnp7uD+XeGnlQzpnyz2sjjqIr9zBtUfMpE1C/nkvu1qmi5U+M1?=
 =?us-ascii?Q?C+22GkeK8XRjwrTuLpaTR54FVPMc1l0kzEYTExT++J/y1waJy53mlUlHnLVv?=
 =?us-ascii?Q?Lqa1SDqjwaZUmheMlddn6Hvi8edBvr6KDRlVy9o3w/zdLpEzt+C/wDQNQhxI?=
 =?us-ascii?Q?0TTceONHdhCBvyipl8NEiFRnVoo/yt6K3J0/ipP39NwMtuAAT4mUgiPp7kfA?=
 =?us-ascii?Q?vdZLgzYNYaNNORidRFWUx/CA2z4+VEn2Defxo/8sVPtOzCy8s9JM6b3Upifq?=
 =?us-ascii?Q?wG4FK2ed/FuyL3HcKSc2Ozh4B0+NVBX0aLzvpb6BvcCHPJeVRY4d4fxqZBkk?=
 =?us-ascii?Q?bSrJa1eWjpmANIeK0Xa1QkvlGRX2rmvRLdOvQ1Jqv/PdqWrJZcfzn9A0SPdA?=
 =?us-ascii?Q?rl1Kr0rPdJmYLw/He8X5DmU7IgoSkU/B3pItzihag1TaMyRmMaxiIHJL/mmK?=
 =?us-ascii?Q?tgUlMS2ENdP6Y0RUNmev4WXuRE4YX//IrBDyjb2r7mQM01gHBdlUS+SQgXMK?=
 =?us-ascii?Q?fiUa29bgHgqdZ02c80fVUCWk+AxlVFAC//nTrfNi0ABx8KbA5VxHHa8+smWW?=
 =?us-ascii?Q?j6jWMdvgbvJS97pDJs3wc9S9ZerG3GM3xm6GUW/DkPyV9rdac1xVhQ0LhHRo?=
 =?us-ascii?Q?FLAi8m9Oh9Wgx5Cn842UK9QMU3rurTFs8D0HcdccgsdFOipWYyJLmA+xIPE5?=
 =?us-ascii?Q?bkiCqgJLbnYgpLRvGyYb1JclaUVd+yXDg/v0g4OAnM4gv4whovNrWo1dsF2o?=
 =?us-ascii?Q?ZNP44RdSp3qtuMJb/jWXzzTcFtPcb5UX75PwU3z045psN6JkLcZmOlW9Vc5S?=
 =?us-ascii?Q?eECPLwOZT7vIuBzfATZrIgcEEM1M6e97p+EySsIsfrqutpVw6W262y2HAOfk?=
 =?us-ascii?Q?x98HaA=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 953fe6fd-0c0b-4bd8-3e8f-08db901a576e
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2023 09:58:21.7835
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k7tooZWkU6ozSnBhFOnSOFaXBqlnSgEBeHG1UbdHMdDaRiVEqEGgTAyuP+ZPKOZCjJTEQ2+11L9CEJ1loovUP1yUnXWxrzP+MTkdYTe42fw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR13MB5676
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 27, 2023 at 10:42:52AM +0530, Suman Ghosh wrote:

...

> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c
> index 1e6fc23eca4f..89836cd299e4 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c
> @@ -439,6 +439,64 @@ static int otx2_tc_parse_actions(struct otx2_nic *nic,
>  	return 0;
>  }
>  
> +static int otx2_tc_process_vlan(struct otx2_nic *nic, struct flow_msg *flow_spec,
> +				struct flow_msg *flow_mask, struct flow_rule *rule,
> +				struct npc_install_flow_req *req, bool is_inner)
> +{

Hi Suman,

Most of the code in this function seems to be moved from elsewhere.
It might make it slightly easier to review if there was a patch
that moved that code, then another patch that modified to
support the inner VLAN feature.

> +	struct flow_match_vlan match;
> +	u16 vlan_tci, vlan_tci_mask;
> +
> +	if (is_inner)
> +		flow_rule_match_cvlan(rule, &match);
> +	else
> +		flow_rule_match_vlan(rule, &match);
> +
> +	if ((ntohs(match.key->vlan_tpid) != ETH_P_8021Q) &&
> +	    (ntohs(match.key->vlan_tpid) != ETH_P_8021AD)) {

I think eth_type_vlan() can be used here.

> +		netdev_err(nic->netdev, "vlan tpid 0x%x not supported\n",
> +			   ntohs(match.key->vlan_tpid));
> +		return -EOPNOTSUPP;
> +	}
> +
> +	if (!match.mask->vlan_id) {
> +		struct flow_action_entry *act;
> +		int i;
> +
> +		flow_action_for_each(i, act, &rule->action) {
> +			if (act->id == FLOW_ACTION_DROP) {
> +				netdev_err(nic->netdev,
> +					   "vlan tpid 0x%x with vlan_id %d is not supported for DROP rule.\n",
> +					   ntohs(match.key->vlan_tpid), match.key->vlan_id);
> +				return -EOPNOTSUPP;
> +			}
> +		}
> +	}
> +
> +	if (match.mask->vlan_id ||
> +	    match.mask->vlan_dei ||
> +	    match.mask->vlan_priority) {
> +		vlan_tci = match.key->vlan_id |
> +			   match.key->vlan_dei << 12 |
> +			   match.key->vlan_priority << 13;
> +
> +		vlan_tci_mask = match.mask->vlan_id |
> +				match.mask->vlan_dei << 12 |
> +				match.mask->vlan_priority << 13;
> +
> +		if (is_inner) {
> +			flow_spec->vlan_itci = htons(vlan_tci);
> +			flow_mask->vlan_itci = htons(vlan_tci_mask);
> +			req->features |= BIT_ULL(NPC_INNER_VID);
> +		} else {
> +			flow_spec->vlan_tci = htons(vlan_tci);
> +			flow_mask->vlan_tci = htons(vlan_tci_mask);
> +			req->features |= BIT_ULL(NPC_OUTER_VID);
> +		}
> +	}
> +
> +	return 0;
> +}
> +
>  static int otx2_tc_prepare_flow(struct otx2_nic *nic, struct otx2_tc_flow *node,
>  				struct flow_cls_offload *f,
>  				struct npc_install_flow_req *req)
> @@ -458,6 +516,7 @@ static int otx2_tc_prepare_flow(struct otx2_nic *nic, struct otx2_tc_flow *node,
>  	      BIT(FLOW_DISSECTOR_KEY_BASIC) |
>  	      BIT(FLOW_DISSECTOR_KEY_ETH_ADDRS) |
>  	      BIT(FLOW_DISSECTOR_KEY_VLAN) |
> +	      BIT(FLOW_DISSECTOR_KEY_CVLAN) |
>  	      BIT(FLOW_DISSECTOR_KEY_IPV4_ADDRS) |
>  	      BIT(FLOW_DISSECTOR_KEY_IPV6_ADDRS) |
>  	      BIT(FLOW_DISSECTOR_KEY_PORTS) |
> @@ -564,47 +623,19 @@ static int otx2_tc_prepare_flow(struct otx2_nic *nic, struct otx2_tc_flow *node,
>  	}
>  
>  	if (flow_rule_match_key(rule, FLOW_DISSECTOR_KEY_VLAN)) {
> -		struct flow_match_vlan match;
> -		u16 vlan_tci, vlan_tci_mask;
> -
> -		flow_rule_match_vlan(rule, &match);
> -
> -		if (ntohs(match.key->vlan_tpid) != ETH_P_8021Q) {
> -			netdev_err(nic->netdev, "vlan tpid 0x%x not supported\n",
> -				   ntohs(match.key->vlan_tpid));
> -			return -EOPNOTSUPP;
> -		}
> +		int ret;
>  
> -		if (!match.mask->vlan_id) {
> -			struct flow_action_entry *act;
> -			int i;
> -
> -			flow_action_for_each(i, act, &rule->action) {
> -				if (act->id == FLOW_ACTION_DROP) {
> -					netdev_err(nic->netdev,
> -						   "vlan tpid 0x%x with vlan_id %d is not supported for DROP rule.\n",
> -						   ntohs(match.key->vlan_tpid),
> -						   match.key->vlan_id);
> -					return -EOPNOTSUPP;
> -				}
> -			}
> -		}
> -
> -		if (match.mask->vlan_id ||
> -		    match.mask->vlan_dei ||
> -		    match.mask->vlan_priority) {
> -			vlan_tci = match.key->vlan_id |
> -				   match.key->vlan_dei << 12 |
> -				   match.key->vlan_priority << 13;
> +		ret = otx2_tc_process_vlan(nic, flow_spec, flow_mask, rule, req, false);
> +		if (ret)
> +			return ret;
> +	}
>  
> -			vlan_tci_mask = match.mask->vlan_id |
> -					match.mask->vlan_dei << 12 |
> -					match.mask->vlan_priority << 13;
> +	if (flow_rule_match_key(rule, FLOW_DISSECTOR_KEY_CVLAN)) {
> +		int ret;
>  
> -			flow_spec->vlan_tci = htons(vlan_tci);
> -			flow_mask->vlan_tci = htons(vlan_tci_mask);
> -			req->features |= BIT_ULL(NPC_OUTER_VID);
> -		}
> +		ret = otx2_tc_process_vlan(nic, flow_spec, flow_mask, rule, req, true);
> +		if (ret)
> +			return ret;
>  	}
>  
>  	if (flow_rule_match_key(rule, FLOW_DISSECTOR_KEY_IPV4_ADDRS)) {
> -- 
> 2.25.1
> 
> 
