Return-Path: <linux-kernel+bounces-20388-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8696827E04
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 05:58:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DEE201C2358F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 04:58:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82A4A17C3;
	Tue,  9 Jan 2024 04:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="HSn3aEKW"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2118.outbound.protection.outlook.com [40.107.22.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06AD8631;
	Tue,  9 Jan 2024 04:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=virtuozzo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FyMLkCSO2PgTqI4MXSGwet4lTh6+0SIhKZqMKTknXcsHCvXS7fKkZbfphgoQU6TWTv2BQbB6cL0KmSfhKcuMZzmKcfsY4G0goWDp1Dyjb1DoB91SAnnm4TVdyZ3LQJYmsWsXyFcIcUOXhVRFfsU3eXtIU12SFJIcnFUFDcS+Le056LAIki/jPYFDvNXroIFyyUghLKBUfcGOIftCBHlWP8ptRw3ABaOfEYUyLU22cBSakkf7tF1NMhKbpB1FA8gV0FgVJ8kd5lu+VN2/y9BXsXam13u9EKh3KBfHw+ctsJzfH6gYq/ed5xvLENYA00pjB1BZWG8TCw+5H3kh8wHDGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=coZUox2VA3Yj6OPRWefoYLX7u6RyGIcxYWFhrxVWQhA=;
 b=O4SNaVsG/BSjHl06vC3SUdXtateic0t+ffhScCYThP4IpM/F3q5E90ZPSuyKHt8B7VXZIXj8GgcTRBS9uH1CpFt4i5jgNDle0tHiHRi+o4iTCtvmQqqIqlAwRKIBQsELq25NTbRlqt2xABAeRCp6qTYzRrwNOa7//T72EuiYeldPfxcMIYIaY5xleqYdNiwvPKzVAloW6KsTs1VnfPkTCpino2NWpEU8VX66rwzUqhVVjXYZMl1bUfADXKS1KNm3baqIl3GrCYHuhhL6rPc21mudBDqccLUSz9JMWlHY3lcsITa8PB4kG7ioYeVPCpqdnCddqDq7TnoTuyWFiF9pyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=coZUox2VA3Yj6OPRWefoYLX7u6RyGIcxYWFhrxVWQhA=;
 b=HSn3aEKWHPFtxngg8/hcBE1nhbTGR5bfEEQNV+TeXMZifSP+HB8TAdKmuqQK3hX800iI/67+7SYjcjjCF8GyypUQawSQqrQaSDkfkgNPbrwEn0QX8ir1dCehQEFLUMIhKZ25plxVCM7V1CzU6gu/ObDSciIN1FipGkB2/OZil3qab7RzjnHzsYQ1gMeyVPoUTNhTC9DZzwAjGQYDhZMnaXZ0BUpqj7TFKYD/OOYsjUB9f6p8x9AKM85YzWXAp9w3HdXYXJBI9pBArPKgZgQuNXGnTz/5Xiyy0kMs811Y5+08So4pqUND4x+OT2MxxiUxToqBaunPZZX09tz7RT785w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from DU0PR08MB9003.eurprd08.prod.outlook.com (2603:10a6:10:471::13)
 by DB9PR08MB8410.eurprd08.prod.outlook.com (2603:10a6:10:3d6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Tue, 9 Jan
 2024 04:57:44 +0000
Received: from DU0PR08MB9003.eurprd08.prod.outlook.com
 ([fe80::72c4:98fc:4d1b:b9ba]) by DU0PR08MB9003.eurprd08.prod.outlook.com
 ([fe80::72c4:98fc:4d1b:b9ba%5]) with mapi id 15.20.7159.020; Tue, 9 Jan 2024
 04:57:44 +0000
Message-ID: <07490c75-86c3-4488-8adb-7740b14feb30@virtuozzo.com>
Date: Tue, 9 Jan 2024 12:57:36 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] neighbour: purge nf_bridged skb from foreign device neigh
Content-Language: en-US
From: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
To: Florian Westphal <fw@strlen.de>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel@openvz.org
References: <20240108085232.95437-1-ptikhomirov@virtuozzo.com>
 <20240108111504.GA23297@breakpoint.cc>
 <a84b2797-2008-45d6-9ca3-c72666d3c419@virtuozzo.com>
In-Reply-To: <a84b2797-2008-45d6-9ca3-c72666d3c419@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: KL1P15301CA0027.APCP153.PROD.OUTLOOK.COM
 (2603:1096:820:6::15) To DU0PR08MB9003.eurprd08.prod.outlook.com
 (2603:10a6:10:471::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR08MB9003:EE_|DB9PR08MB8410:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e75c128-3fde-45cc-555e-08dc10cf843f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	M3x2iArSltbkTjoRfHUMMxoneg7zdcokyrLZAD1C1Fo/JoK+yqpzzTIqRw/4jfBRNA9RB4MzYjXVz0O3o6dRBwh3piHYbWFQdwRlVoR+AzkWNg0tXo8GK1P4SzqRxZ+Pb97V3gzXL9znSZPv8LJ6ND1L1WJUNdJT20ByjStmI2wC/lrOTJdYG9834PF0jjfeNaFTYk0qqk2nNL7o9fheKxnQ4fW2O2phZeih2N/y2xx/RtHWV9q5afLiaPsFLW+7jnFQjLi21K98wGsbbctIOs+c1j77MAIDxVaB08lWIURjamNCHL7Plm6rPFZdp/O915ur+0Rk87w263lVc96squTn+May/DIaDILooAo266vZyVUri25+TbAjnsZoVqgU+Exf7L2dptp0FaXy9yUPq1HCk7Y5t/lNjO8ywH9YrMZI8rlqoMYJFyQp1EOG9SPNbjeu53e0WNpgL0bq/VzQpTZ8esl3RsNwsAOHMIU78idXrhvZ2RGeuipCxnxSzxNa8eJdymqYCNrB6ZohkhYvCV08M7wq6HWNuzTAoHusfnG9cmwZQOXtKZa3QJFxStDs6BvDN+nm3R8mo5vOCatUv2pzwpzcVanRFe5n4wwy9A3r6h/FctBPZ05xHoGLsRJ3FgpVJhpytQ8kqpXrQMEfXw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR08MB9003.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(366004)(376002)(396003)(39850400004)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(2906002)(5660300002)(38100700002)(86362001)(31696002)(41300700001)(6486002)(2616005)(107886003)(66476007)(66556008)(36756003)(6916009)(66946007)(83380400001)(6506007)(53546011)(6512007)(478600001)(31686004)(6666004)(4326008)(8936002)(8676002)(54906003)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y0lrUG94N3FPam5Wb2Q3Q0JIOC9UYzd0UVpYbTBqWXNFUnBONWoyUjNEWU5m?=
 =?utf-8?B?ZCtJdkJ6WWFESHdteXBrcU9OMVBRYmRlTlRBOGt1M1lKVU4zRnVkRTlleHpW?=
 =?utf-8?B?c3pLRU82bEpvRWhjblFkWjJxLyttdTNPZkhXdmlIV011bVIySGJKRlltTjFN?=
 =?utf-8?B?MkdnZnU4UWdjVkJwd2ltb0NnKytkL3E4NXVBUVc2UWNZQjJhOXRNN0wwT1Z4?=
 =?utf-8?B?K29Fc2RUeG44YXN3d3J4YmhQK09ZQ21BcStkMGc0ZjNIV0crd1RJODY4TVNw?=
 =?utf-8?B?VXhaeWhibWFrK0pKR09pekYxWXpvaWpPOHY4OGIrQnFtWGIwYksreWpQZUZi?=
 =?utf-8?B?TXF5QXg5YmVWWUp6dmpwZGxyWWxsbEpsa2d3bjNLQmZIbm5Sb1ZLcE40amlC?=
 =?utf-8?B?S2djODE5d2lYbnV5WUQ3QjNSVTVCT2RjT0tzUmlZSlVRL1VocXArNk1BaTZJ?=
 =?utf-8?B?YW9OVlhteUkyejZIK0tkZitKVDRKWlFqSWVqMW1XaWVucHJNZmlTMEFaVnVI?=
 =?utf-8?B?dTdGZFRjUVBySUhpM08wcXdWaHhWVWJ1V213emhqeUZLVjNha0JnVm4xdFow?=
 =?utf-8?B?L0pDc1dKNEQ2R3JWY25GaWV4cFR1eFJQZ0s5K1ZBd1g0Sm9lODlpaFB5NTE0?=
 =?utf-8?B?a1Jnd3llOU9iRno2c1BRcE5QMmdmWFBraC9KZWM4QVpWWG4rQ3NDSEdVMW8v?=
 =?utf-8?B?c0MrcWY3RVJpd2F2Z1RhTldnOTVldkdPZStaYTBHZ0hJRGpHMkdDSGdXMTkx?=
 =?utf-8?B?bEFPTE9oQUIzZWx3TDErTDFFV2o2bEFaNlN1dVBINllhNXozRGJsSUVDeGNH?=
 =?utf-8?B?SXNSSnh0ZWxmQ2FKMjk4SWJzL28yRFBlRkdHWHVlanJFVDJBcE4rL3M4aFRP?=
 =?utf-8?B?L0h3NjZMaHZPdXBqck9jNklCSTB2aEd2VkRiK0JpdGQ0eXNZckFRckxjMDdO?=
 =?utf-8?B?RHBqejlFS09HWU1IZDMrcElpbmpLTnN5ZzNWZDg1QXp0dmp1dG84L2l4eE5I?=
 =?utf-8?B?WVJMS1RDaU1Idm1SWmtMcVRyZW9HVWN0dXdxWnhYOUVHczA0ZkcyZHJHenBV?=
 =?utf-8?B?cmhVL0wzTlFoNWpocjBlVlRwQUxEWFJ5ZVFPc0lpSlNMUFNHelRYL1BGclkz?=
 =?utf-8?B?ODVId1dzT1F3N00yWkt2NStDY2dFNXZPa09zVEtTdWdvOUk0amdGT3ozV3pp?=
 =?utf-8?B?cHIzZy82TjlvdmhnZWlUTml0d1hhajFqNlNTQWhJU2gxNStXazdFenc4VHNt?=
 =?utf-8?B?SzVDdm5WNi8yN09qMjJoMkhybXVaQ21ZUDhhL0pxbUNzeW16Szh2dmVmWi9l?=
 =?utf-8?B?OEpEc3ZEOEhGYWRjc2pkKzBHZENpZHNqRHl3RXlUcllqWitTNTZkN2ZNLzFU?=
 =?utf-8?B?UDMxVzJXcUgxNmk1bjRKU3RhUXVMK1F0YnFkcXFuVnUyeDZsQXB1V29BRXZL?=
 =?utf-8?B?MEs0cGovZUs4cUxtd2Q2RDBYT0lna0c5RkdhdVphYktkWmxSZ1liRUdvVS94?=
 =?utf-8?B?MUVYWEhDbWNmY3Z3cXNYRnRzMEM1aUN4TStKYis2c0d5QXc3ZklZUE1udDdB?=
 =?utf-8?B?WXViNk1OWVMxbGNXSWtMcm1lN1NpMGxXRHlabjRQbFFWd05BeUREZGlGMDMr?=
 =?utf-8?B?Rkh0QkZyMzFqcWkxVDJqOUphNnFwcXVNNms5OE03R3pxUGVpUVREdC9KOE8v?=
 =?utf-8?B?emIrUlNHeldEbWVNUG83Y0VZUWYvMUxzNUo5SlhNSjA2Wm1MUnRxRXdKMXZR?=
 =?utf-8?B?OWtPR0p4ditnUk11RmZ1Vk5MMGVHQnlyb0prQndPcGYvL1Fad2E2MWFDNmRK?=
 =?utf-8?B?dHNuQWlwVy90bS9UenVoekp3RFU4NkpPWjVzcmYwVDhWUmUrSk5ybHFRd3NV?=
 =?utf-8?B?QlpNV2dkcHdTVE1CZWhCZml1WW5iUnNGbWF5OCtGaU1XM3pnd2JPS21TaXRY?=
 =?utf-8?B?WGp0WkNudDU5VlpaNDBIMDdKRVNkYmRVM3kwdWRGaWUrdFV3eERHaTU4ZEtY?=
 =?utf-8?B?Y3lsSW01ZGVseWI2Y3hhMHpWTjdwd1hMNUg3K0VhaWZPaHEyR1FYZTlWSHhX?=
 =?utf-8?B?ZDE0VEwxL2RPaERMVWJCVEQ0c1NqOW96aG1TYXhyRkhIOUd1ZFpBNGR6QmhR?=
 =?utf-8?B?K3QrNGFCaEp5WUxILzVueXJkN3lsbGRNRFRGN3k4NzdNS0RGRjhlbkZpUFRU?=
 =?utf-8?B?OVFEMlJLdmxvU282VDdBZ2FieFQzNTNKRzVKelM3aHJITThqQ2trTGlFSjRG?=
 =?utf-8?B?Y3BYQWpxWE92cVVyd3JSc3JJck1RPT0=?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e75c128-3fde-45cc-555e-08dc10cf843f
X-MS-Exchange-CrossTenant-AuthSource: DU0PR08MB9003.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2024 04:57:44.5697
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xpznPKVfWDSCzhNnkpkYJGclaTrsdYbbZgkmxWMZOjN/FDpa7NxRMmzuG8sxpqvPRYBRk40uuOvEcUqrHS82asoc+4Dfzl2Sci0kXbh+gmw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB8410



On 08/01/2024 19:26, Pavel Tikhomirov wrote:
> 
> 
> On 08/01/2024 19:15, Florian Westphal wrote:
>> Pavel Tikhomirov <ptikhomirov@virtuozzo.com> wrote:
>>> An skb can be added to a neigh->arp_queue while waiting for an arp
>>> reply. Where original skb's skb->dev can be different to neigh's
>>> neigh->dev. For instance in case of bridging dnated skb from one veth to
>>> another, the skb would be added to a neigh->arp_queue of the bridge.
>>>
>>> There is no explicit mechanism that prevents the original skb->dev link
>>> of such skb from being freed under us. For instance neigh_flush_dev does
>>> not cleanup skbs from different device's neigh queue. But that original
>>> link can be used and lead to crash on e.g. this stack:
>>>
>>> arp_process
>>>    neigh_update
>>>      skb = __skb_dequeue(&neigh->arp_queue)
>>>        neigh_resolve_output(..., skb)
>>>          ...
>>>            br_nf_dev_xmit
>>>              br_nf_pre_routing_finish_bridge_slow
>>>                skb->dev = nf_bridge->physindev
>>>                br_handle_frame_finish
>>>
>>> So let's improve neigh_flush_dev to also purge skbs when device
>>> equal to their skb->nf_bridge->physindev gets destroyed.
>>
>> Can we fix this by replacing physindev pointer with plain
>> ifindex instead?  There are not too many places that need to
>> peek into the original net_device struct, so I don't think
>> the additional dev_get_by_index_rcu() would be an issue.
> 
> I will work on it, thanks for a good idea!
> 

If we replace nf_bridge->physindev completely, we would need to do 
something like this in every place physindev was used:

diff --git a/include/linux/netfilter_bridge.h 
b/include/linux/netfilter_bridge.h
index f980edfdd2783..105fbdb029261 100644
--- a/include/linux/netfilter_bridge.h
+++ b/include/linux/netfilter_bridge.h
@@ -56,11 +56,15 @@ static inline int nf_bridge_get_physoutif(const 
struct sk_buff *skb)
  }

  static inline struct net_device *
-nf_bridge_get_physindev(const struct sk_buff *skb)
+nf_bridge_get_physindev_rcu(const struct sk_buff *skb)
  {
         const struct nf_bridge_info *nf_bridge = nf_bridge_info_get(skb);
+       struct net_device *dev;

-       return nf_bridge ? nf_bridge->physindev : NULL;
+       if (!nf_bridge || !skb->dev)
+               return 0;
+
+       return dev_get_by_index_rcu(skb->dev->net, nf_bridge->physindev_if);
  }

  static inline struct net_device *
diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index a5ae952454c89..51e7cdf9b51c9 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -295,7 +295,7 @@ struct nf_bridge_info {
         u8                      bridged_dnat:1;
         u8                      sabotage_in_done:1;
         __u16                   frag_max_size;
-       struct net_device       *physindev;
+       int                     *physindev_if;

         /* always valid & non-NULL from FORWARD on, for physdev match */
         struct net_device       *physoutdev;
diff --git a/net/ipv4/netfilter/nf_reject_ipv4.c 
b/net/ipv4/netfilter/nf_reject_ipv4.c
index f01b038fc1cda..01b3eb169772e 100644
--- a/net/ipv4/netfilter/nf_reject_ipv4.c
+++ b/net/ipv4/netfilter/nf_reject_ipv4.c
@@ -289,7 +289,8 @@ void nf_send_reset(struct net *net, struct sock *sk, 
struct sk_buff *oldskb,
          * build the eth header using the original destination's MAC as the
          * source, and send the RST packet directly.
          */
-       br_indev = nf_bridge_get_physindev(oldskb);
+       rcu_read_lock_bh();
+       br_indev = nf_bridge_get_physindev_rcu(oldskb);
         if (br_indev) {
                 struct ethhdr *oeth = eth_hdr(oldskb);

@@ -297,12 +298,19 @@ void nf_send_reset(struct net *net, struct sock 
*sk, struct sk_buff *oldskb,
                 niph->tot_len = htons(nskb->len);
                 ip_send_check(niph);
                 if (dev_hard_header(nskb, nskb->dev, ntohs(nskb->protocol),
-                                   oeth->h_source, oeth->h_dest, 
nskb->len) < 0)
+                                   oeth->h_source, oeth->h_dest, 
nskb->len) < 0) {
+                       rcu_read_unlock_bh();
                         goto free_nskb;
+               }
                 dev_queue_xmit(nskb);
-       } else
+               rcu_read_unlock_bh();
+       } else {
+               rcu_read_unlock_bh();
  #endif
                 ip_local_out(net, nskb->sk, nskb);
+#if IS_ENABLED(CONFIG_BRIDGE_NETFILTER)
+       }
+#endif

         return;

Does it sound good?

Or maybe instead we can have extra physindev_if field in addition to 
existing physindev to only do dev_get_by_index_rcu inside 
br_nf_pre_routing_finish_bridge_slow to doublecheck the ->physindev link?

Sorry in advance if I'm missing anything obvious.

-- 
Best regards, Tikhomirov Pavel
Senior Software Developer, Virtuozzo.

