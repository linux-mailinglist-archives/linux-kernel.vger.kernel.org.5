Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5CAF77F20C
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 10:26:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348867AbjHQIZx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 04:25:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348974AbjHQIZr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 04:25:47 -0400
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2077.outbound.protection.outlook.com [40.107.14.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3D1C2D7D;
        Thu, 17 Aug 2023 01:25:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NAM3E2EN++Z3z37e8hLZJ+TGt2cWoOdEte0ui3t3PC4tVXB1lek3r5RkFkDmfF/th0mngqbyRw1pyh4g34MoUdQpwWsR3KZ161MAuQQkYfAJwDsH/51+zP0to/2ZWLoqcdJsE5hZnpXLjUjnFEQhp1fwT+wZQw04Yz8kbpMcIui3HHvr9nRspFGmq7P0UN1kEoZNIm3M664dtq1gfNCgOEAS/t7WmYZxSYFowllYVrP/pHtUvQw5MsqXFUXFBnrw2KhHPxgSNtsTafd+RxyJktmFr+wcTHkzF0+QMbsf40gFyFo6cz/RkIIP01atn1K5zd+aaS90C6vAGcDulg1WzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5HNF6FjgsVzyT30i01pZ9r8pXwV/auhcxperG/PWK3c=;
 b=ij//Cjts0ONSJY2GeKp5eLiIm99XHoQKGFyZK2C8pJJ8r+0iJDxA49FnrC0TNZwEH2ercJm0U4oZY4mlN69paI5k6HZGudBE03t8/ojj+mJkLaWb6GiVzF5dONsvNWYp/27M7/nJcivJiUXHIqxSwxU+vxRIz2JEz4SwRuEL9JDEJOlkY0KgjLD6otvhiKcdst0oMv8VSwcLFvB8vrHoTqKzP1cN3bJHQh2ipk1TJGhPW4gQAB86XquHuKNpX6UKd3jXBPbv5Sw8NKVR9CdLzgSnj1ZUPmfhorW4NgRbgL07i5ddTqijN+aRO2azmm5r3LM2mI2xiRsrpGZFJ71nVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5HNF6FjgsVzyT30i01pZ9r8pXwV/auhcxperG/PWK3c=;
 b=V/z9e3qcKd1WSdti1lOobayEn793B4RcyWkpwNBEk5TgVQPg6C8a0SgdARy15qJT7r39eQWc1cwqDAiwjIabyoZcbvBVwzLTKdcYb4TViBM+XSKhyy4QwV4hWYXdcEVliMFH1uVaq43fmwOWN7nXEb6MuG2VyDgtcRRXsh3qjBw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com (2603:10a6:20b:409::7)
 by VI1PR04MB9788.eurprd04.prod.outlook.com (2603:10a6:800:1d4::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.29; Thu, 17 Aug
 2023 08:25:41 +0000
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::2545:6d13:5905:bf50]) by AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::2545:6d13:5905:bf50%5]) with mapi id 15.20.6678.031; Thu, 17 Aug 2023
 08:25:40 +0000
Message-ID: <c28591b1-812f-b593-ef83-72e972d5b7bd@oss.nxp.com>
Date:   Thu, 17 Aug 2023 11:25:36 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [RFC net-next v1 4/5] net: macsec: introduce mdo_insert_tx_tag
Content-Language: en-US
To:     Sabrina Dubroca <sd@queasysnail.net>
Cc:     andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, richardcochran@gmail.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230811153249.283984-1-radu-nicolae.pirea@oss.nxp.com>
 <20230811153249.283984-5-radu-nicolae.pirea@oss.nxp.com>
 <ZN00NB7RayXAl80f@hog>
From:   "Radu Pirea (OSS)" <radu-nicolae.pirea@oss.nxp.com>
In-Reply-To: <ZN00NB7RayXAl80f@hog>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR06CA0218.eurprd06.prod.outlook.com
 (2603:10a6:802:2c::39) To AM9PR04MB8954.eurprd04.prod.outlook.com
 (2603:10a6:20b:409::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8954:EE_|VI1PR04MB9788:EE_
X-MS-Office365-Filtering-Correlation-Id: 6dd10ee8-8bf4-40f4-79b8-08db9efb8a99
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 52TBhqcG2piTjPa1JlEWzHuFa9ENSvBYdm5WehH13+CjVL2Pozy5GjtqBm45gnNofu3kC+VLUAlTWb9KSapEf0FUJUMZ4rcPoJsiEHLdUkXB94rVoXC5z/bW5NY/WNmnyVBfRo46NpLEfM7nysRfmFSPP09SeLQ3SGftvFYzrXqyf0nckdJsgsNTVISwiJoI7ODtYRMgkPI5mFINQsXTEXxOnF0v7A328N4BfK0Uo/jXZUqX3XXfMQQXOdGHkhDOaXvciaQhQwVY8WNFcbUHoHceDbQTkAQg+Suqonet+vOFUF0zUd9RnXmZR4iInGVkVdoAgI4Ym4StmGJp+6B7o6AdO68qYSNG/fYXBSACWlF57GHHRyhKWaZnRpuW6ida+7xhZE3qHVOCR9/CqA4gq5HH2IMaZlBJbXypN6gCqGLsBsKsvgwc05Tcf7uuZBd4xQ/LEQKDOdaTm7og3cyhEHJMcpw1zfyEaKqJwh6lXheRsNnGcr7gOaPRqz+fJrJI6ZkO0WiCFHqihDsJuT4ORsu67l/dPWXyyOkjrG4mROeGYp19VSIVxYBIK6ZtggIZPdI5lUSPqZgt9NnPMvzM/0Ihn/I+mv62iP6HEMSHniv1YFCvKNyrgE883Lo4ETfJMc7bZQMLin6cjPe96SNJYQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8954.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(346002)(136003)(366004)(396003)(1800799009)(451199024)(186009)(316002)(66476007)(6916009)(66946007)(66556008)(31686004)(5660300002)(41300700001)(38100700002)(4326008)(8936002)(8676002)(26005)(2906002)(31696002)(83380400001)(478600001)(7416002)(86362001)(53546011)(6512007)(6506007)(6666004)(6486002)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VnVWbmJpcXpNb3Y1Y0ZxYVlxYmVlYmx6OXowRmNsaDR4Y252UW1QcUZLYjVy?=
 =?utf-8?B?SjFnVEs1a1ZmcGNKbGVNVFVGdGQ4U3lFb1kwbFpITENiZDVqRnpuU3lWZG4z?=
 =?utf-8?B?TEpTa2t4RDNFeFRWUjNKMlZXaGxWM0E0S0dWUHNvSFVPeHlPWnBIdXlRMjBz?=
 =?utf-8?B?OVhzYjltS25BNzFQUSsweHNJZDZPWUsyZE51LzZjUG5NblVFRERrcVlnOTFK?=
 =?utf-8?B?WXloRnNZQ29paWxmMDhxVy9xMnc5bmxpMk5NNGRuYnU1aWs5ZUdOaGlyWWk3?=
 =?utf-8?B?RHFnZWdrMXFnL2tGa0tnUW5jWllFbkhkS2E2ZDFZbE1PdUVzeDkwMUEwMnpM?=
 =?utf-8?B?dVZJQXE1NlBoSWRabmlLMy9KZGJtZmx1WjdKRDc0MFFMZHJubjk4VGNkaStS?=
 =?utf-8?B?c29Nc2hVZ3NaUG0zSTc3djlJQ1k2SzJYUVhxc0NES3RQalFhZ3daWThrTnF5?=
 =?utf-8?B?ZExZVklaZVlXRmQ3SVk1YnZWdmJCdUsrK0wxd1BpUnBXaEdOZFI1Wi80RTly?=
 =?utf-8?B?NEt6RzlTcG9rQmw4cWRjNkJGUnd5TnhyUFQ0dXJpbDFrNzVTQ2hqRlZQaDV1?=
 =?utf-8?B?TjNtUEpEVWswcXNaTXl1ZStSRUIwSEdHdnhlZzB2TWt6OW5GdDBmZEJLNGxJ?=
 =?utf-8?B?Wi9rUGMxZVh4WDVxMDFNK3A2Y1FZYnUzVTVjOVNyRHNWdy82TUJVczRmRWhL?=
 =?utf-8?B?WlJhd2hEc3NReVQyMytQRkVUeHIzd1BpK08yc083djE3K3ZvOG1kY0tzb0pr?=
 =?utf-8?B?c2M3WG9Ub3N6Mm9DRVozR0llQUsvd2lhajRRaHpvWVZMS3JYV1BlRzFnMmsv?=
 =?utf-8?B?ZTdtcWV1WW5wQ28yMzQxbHdmNFZzSTNLY1RyYno3b1ZCanhiSzJZVUZaSVJM?=
 =?utf-8?B?OEEwNVgveXNCTUpJZlNSMTgvVG1kRU1idk05ZERhYWYvRzk4N3BQcXErWUF3?=
 =?utf-8?B?eW9nWGk3NFZkV2VXQ2lTd1pTUFRlVUU1VFV3WE5lcFpCRm1WTVg5U3RwbmxS?=
 =?utf-8?B?RFlSWHk0ZzBndGFTMkd1RDV1RU5mWncvZTdOZFAwcVpwWmlEcWNhenVWN0dL?=
 =?utf-8?B?bXpUQzNicTFmQUd6bU8wYXF4c2VRK1lKczdScmdyT3Z3d1J5Ny9JK2Jmb2Zv?=
 =?utf-8?B?dDhKVWd6UmNwMkp1WEEzTkluc0xCbTlPQmtORVhtSFF3bHd6bGJTOVRwZlNN?=
 =?utf-8?B?TG1IYTg2eDFjYUhTTk9IY3hqcUhiRWppblM0eUlzTlFSSVFkcVcrR3hZRTU3?=
 =?utf-8?B?cFQ3YVFKYkd1dDMzanNlV0RDdm5lZEpSVXNwYUpzdjI1eXFyZWlUa0d4K2hz?=
 =?utf-8?B?OHhtaHJFK1U0NkkxTGF6ZlJDY1EyeWR2cVVxN3J6b0JPeDBjdk5hNXBSdTRG?=
 =?utf-8?B?cVJ2OGJ1djk1dXY1elNVWXQvSXhXd2k0S281MVprc3RVZjNhL2xnNmgrdlYv?=
 =?utf-8?B?K0I2RDBCamFsczZNWW1FbUg2QUlnV054RldPajdJSkZVakIwdnF5QnBFY0FI?=
 =?utf-8?B?eDJiUTBTNWJNUndVdjBiWHlGUjFXZnVhMXgyVTUxcXVya09ZWkF4Nk1tTURB?=
 =?utf-8?B?dXJ2VXc1blpmcktzeVFBYzNFM2xtZnRFOEhlQ0syODF4UzkrRloyRWQ4dUpZ?=
 =?utf-8?B?WUM5VFNSSllSUVNySWxzREhOUS8rR2lBNDlSQTV5SVJLREp0V0pQMWtQNUZk?=
 =?utf-8?B?eFVHTzVNUG9mU2dvTm83NUhxaG1BS0ozVmM0MDQ5ZlpQMTJML1hTUC9ZM2NX?=
 =?utf-8?B?K2lGOTRyZmM2YkxXaERyeUJNWXRsa2dLcG1zSXBEMUdXK3hIaVg5ZFJYczJy?=
 =?utf-8?B?cEp3Q2ZlbmNZMVBlWDJGQjJrR1lCam9WSlhvNU9KWnpPRGw2RDRDVVc1Tktt?=
 =?utf-8?B?N3JCSGRuMlFlTlBJcDFSVmJHeHhZY3dSeWhheGFqdzVIb0QyTXllWENiMDd1?=
 =?utf-8?B?RFBXM2JHb3BPZ3NwMmhvTXM0YkVBTzBsS2dpcEltN28zQ1R4STlvSjhwZkR2?=
 =?utf-8?B?VVl4N1JscU9mUEZPTHJDNERWTFlJcXNXVXRzcXl2cnhudjZheHJZbjFndFB2?=
 =?utf-8?B?TmtEQW81b3dZd2w5WTlKQWN4ejlRdUtpcmpIa1lvSElpaG1qUzFQRkd1bWdF?=
 =?utf-8?B?cnh2U09IM1lETStpbUVPTXdOVERKK0tJNWdwZ0dvMTFPbHFqYVdGcEdjdkhE?=
 =?utf-8?B?OUE9PQ==?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6dd10ee8-8bf4-40f4-79b8-08db9efb8a99
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8954.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2023 08:25:40.7667
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7pEuK6JEOSoBK1468aA5BWuwaQAQSBERmj8PigMmd+5818A3XmddTZsLPwZYvT8sZwWzxnGKSxKsjmBpbIEya8eg6mfXRWRtJcS3SzCvhRk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9788
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 16.08.2023 23:40, Sabrina Dubroca wrote:
> 2023-08-11, 18:32:48 +0300, Radu Pirea (NXP OSS) wrote:
>> Offloading MACsec in PHYs requires inserting the SecTAG and the ICV in
>> the ethernet frame. This operation will increase the frame size with 32
>> bytes.
> 
> "up to 32 bytes"?

Yes, up to 32 bytes.

> 
> The SecTAG and ICV can both be shorter, at least with the software
> implementation.
> 
> 
> [...]
>> +static struct sk_buff *insert_tx_tag(struct sk_buff *skb,
>> +				     struct net_device *dev)
>> +{
> [...]
>> +
>> +	ctx.secy = &macsec->secy;
>> +	ctx.skb = skb;
> 
> I think it would be a bit more readable to just pass the skb to
>   ->mdo_insert_tx_tag instead of adding it to the context.

Since this function requires only the skb and the phydev, I would move 
mdo_insert_tx_tag from macsec_ops to a new structure called mascec_tag. 
What do you think about this?

> 
>> +
>> +	err = ops->mdo_insert_tx_tag(&ctx);
>> +	if (err)
>> +		goto cleanup;
> 
> [...]
>> @@ -3403,6 +3470,13 @@ static netdev_tx_t macsec_start_xmit(struct sk_buff *skb,
>>   		skb_dst_drop(skb);
>>   		dst_hold(&md_dst->dst);
>>   		skb_dst_set(skb, &md_dst->dst);
>> +
>> +		skb = insert_tx_tag(skb, dev);
>> +		if (IS_ERR(skb)) {
>> +			dev->stats.tx_dropped++;
> 
> That should probably use DEV_STATS_INC (see commit
> 32d0a49d36a2 ("macsec: use DEV_STATS_INC()")).
> 
>> +			return NETDEV_TX_OK;
>> +		}
>> +
>>   		skb->dev = macsec->real_dev;
>>   		return dev_queue_xmit(skb);
>>   	}
>> @@ -4137,6 +4211,11 @@ static int macsec_newlink(struct net *net, struct net_device *dev,
>>   			if (err)
>>   				goto del_dev;
>>   		}
>> +
>> +		dev->needed_headroom -= MACSEC_NEEDED_HEADROOM;
>> +		dev->needed_headroom += ops->needed_headroom;
>> +		dev->needed_tailroom -= MACSEC_NEEDED_TAILROOM;
>> +		dev->needed_tailroom += ops->needed_tailroom;
> 
> If the driver doesn't set ops->needed_headroom, we'll subtract
> MACSEC_NEEDED_HEADROOM and not add anything back. Is that correct for
> all existing drivers? (and same for tailroom)

It should be. However, I will do this operation only for the PHYs that 
needs to parse a tag.

> 
> You set needed_tailroom to 0 in your driver, but the commit message
> for this patch says that the HW needs space for the ICV. I'm a bit
> puzzled by this, especially since MACSEC_NEEDED_TAILROOM already
> reserves space for the ICV.

The 32 bytes headroom will compensate for 0 bytes tailroom.

> 
> Also, since this is pattern repeated twice more (with a sign change)
> in macsec_update_offload, we could probably stuff this into a helper
> (either modifying dev->needed_headroom directly, or returning the
> value to add/subtract).

Agreed.

> 
>>   	}
>>   
> 
> [...]
>> @@ -302,6 +303,10 @@ struct macsec_ops {
>>   	int (*mdo_get_tx_sa_stats)(struct macsec_context *ctx);
>>   	int (*mdo_get_rx_sc_stats)(struct macsec_context *ctx);
>>   	int (*mdo_get_rx_sa_stats)(struct macsec_context *ctx);
>> +	/* Offload tag */
>> +	int (*mdo_insert_tx_tag)(struct macsec_context *ctx);
>> +	int needed_headroom;
>> +	int needed_tailroom;
> 
> unsigned?

OK.

> 
>>   };
> 

-- 
Radu P.
