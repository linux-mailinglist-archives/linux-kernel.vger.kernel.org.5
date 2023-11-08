Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DB6F7E546E
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 11:49:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344416AbjKHKtF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 05:49:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344181AbjKHKsn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 05:48:43 -0500
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2078.outbound.protection.outlook.com [40.107.247.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0217125A9;
        Wed,  8 Nov 2023 02:45:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mN0oh3684McgqVgP+j2vfo7nDUihUG2VSEdQC4dV9wf8TAcBJfguVaV0fC8/S1imPw8voEAT81W6lKmkqy2ZENy68fcEvJp8KoTrtVr+7VTUtX4tw1dM2dJwR05+xH/5SdSlm5xdIg3Jbvh9Jy1hfaGOpn3zOXLNRW8DMjrN+L1I4g3LddsVNvlHPHf12S7IxLQJqBYCVEAF6zpKQospssOs+RpTf7gsKcV4sLAw0NvZpjLLh+mZC3//SvT0lhOXPSJhdJ5Ag1k5+ruXBPTmNv/GRqh7U/VFpwBWWi8CyDOtsx/w18JBUf6hjYVdTqYX6zf0Yc2nSq/fKb2OVUdwjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dMDNOHv6cALsF8FKbL7GEhd7O5puP80Pw2S6mfPW0DY=;
 b=TOooKtfGhpZ/Xj8GuJhWJUQUr8qvXML7Z8L8hZXKBRG2cuq5cHsz3YAWF56P1f2u3XMzm7aEjhFQsWvqnaYehr7a7LBgQ/JENPbelSvN/kvLnuR1fdRUBojH3RqhRLZUkEJy77dx90Zu4bkwawHsLyPpVwcG3ozaI0Lqxagnym6ANKtdhUzDKawETDSvUnP9kK7VJf1/hoPYLXnit+6+KRv0z/wZPXd9ZZQuPp9B1qmImweFMY8TR+UPR9c7EtmxLtDmrHJImwcmZsFR0qOhpJ0JS/UVqN6S5VSmSTXiEiMilAZKXzCci519XVKxytUOpmjfxb8AHcjIIhPOTSNYEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dMDNOHv6cALsF8FKbL7GEhd7O5puP80Pw2S6mfPW0DY=;
 b=WIz3ya+A257hKmSnQFFlmMOsz70VvxOyrkOjLWCP4iQNouMBv8EYb1475t3ho06QgnFuF64yxGDABVzecFyn8x0VJfdes5vqzQe814IxodyKtS9buT+kkoLUz0HjHbZ4s1fcXBDlaYYhYWPRpUjjQl3uF7rVvkoQRFQwc5cVo00=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com (2603:10a6:20b:409::7)
 by PA4PR04MB9688.eurprd04.prod.outlook.com (2603:10a6:102:271::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.13; Wed, 8 Nov
 2023 10:45:45 +0000
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::e083:450:470f:fb48]) by AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::e083:450:470f:fb48%4]) with mapi id 15.20.6977.018; Wed, 8 Nov 2023
 10:45:45 +0000
Message-ID: <6907d35d-cff8-4abc-9570-0a1fa0796e97@oss.nxp.com>
Date:   Wed, 8 Nov 2023 12:45:40 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v8 5/7] net: phy: nxp-c45-tja11xx: add MACsec
 support
Content-Language: en-US
To:     Simon Horman <horms@kernel.org>
Cc:     sd@queasysnail.net, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, andrew@lunn.ch,
        hkallweit1@gmail.com, linux@armlinux.org.uk,
        richardcochran@gmail.com, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, sebastian.tobuschat@oss.nxp.com
References: <20231023094327.565297-1-radu-nicolae.pirea@oss.nxp.com>
 <20231023094327.565297-6-radu-nicolae.pirea@oss.nxp.com>
 <20231104113506.GA891380@kernel.org>
From:   "Radu Pirea (OSS)" <radu-nicolae.pirea@oss.nxp.com>
In-Reply-To: <20231104113506.GA891380@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM4PR07CA0002.eurprd07.prod.outlook.com
 (2603:10a6:205:1::15) To AM9PR04MB8954.eurprd04.prod.outlook.com
 (2603:10a6:20b:409::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8954:EE_|PA4PR04MB9688:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b76703f-8f92-4e08-43ba-08dbe047db0d
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OZ26PATPDUiL105F3YzMH+lJOFQBETN8XwwVeRUyieWxc21mx+8MM9fIwxpXs43Mk5ek9mWx8XHfH2mQkkphnllF1kTRSdO/PBsxwH+F/wlbE2SAE6/SPXP6Tg6GAqJTZYR0381eGJHTrbySE4mF9b7R3smuSqukftrUVabz7bA2uZQLzUdj6b7Bna+9dMhfZvX5j+X+zYZ8yoa1zSkZvTGK16Jomm/6bp5u6iqUn4V2O+pJd/aGOqh9nkn2yMV2WEdPkOJu5inEi1aJTCzxaBQ/AkBii/xSE1niU6A8j9Lx4iEaYdOUxfLsHZF9GXhXg9FeirEl1ab5tqXTVMssqxW26/LkQURqYonSxTFvmlWCMf7g+qszqCW/S4anZRc34OhSXZnVEydClV9myyPQfwtEzScSw5qxhSWpF2etc1Q0zZ8QWFVMpbc0xJIXj+ivXDut/oSKyeW+DtoXU+oa1BL1T41oAKtY5keWd+EqMQnDuyWdBuIHoyV0gXuTFDQl/wYnwYiqqwGZ7DQB0MgzvJzcYplwlvpFC5MybHlGNnDflffiTyWIxEHuwH7y62J3YoO3Mi6hzjRLnn1BpBSzTTdc/w3is2Nt1gIBFFlcAD/4cd29fKjAA3fny6ATYRI9rGn/2JlZaISgeut34pBE5Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8954.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(376002)(136003)(366004)(346002)(230922051799003)(64100799003)(1800799009)(186009)(451199024)(31686004)(26005)(6666004)(53546011)(38100700002)(31696002)(86362001)(6916009)(7416002)(8936002)(83380400001)(8676002)(2616005)(2906002)(6506007)(66556008)(66476007)(6512007)(478600001)(5660300002)(66946007)(6486002)(4326008)(316002)(41300700001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M0RyUzRHYTU1bGxLOXNqdkhvdFQ0UndKYjlobzF3TXRWLy8xN2kzSVc0bFVv?=
 =?utf-8?B?aGNZUjBpSFRSVGJ3bkdmVlNYNXRpaTRETHJZZkFSbzYydXpiVzJmY0FwTlpR?=
 =?utf-8?B?U2gxWExpMnJsTy9aSUEvY0R2VmRCMVR5blZvait0ZWpxRzVUdEtxNklUQlQx?=
 =?utf-8?B?OWh3L1J4Zno4UXNkQ0xnSXg5R1FrZ2tKZzJTMjNaUUdURmVhYlZZUzQ4UGV3?=
 =?utf-8?B?NEVzSXg2S0FFRkJseE8xMmlORHpTdnlRNTJEbmhCb05HSC8rK0dLbDh2Ull3?=
 =?utf-8?B?R05NUURxL01wWVhaVlB4OW9FVDlHam94VVU4UGFYWEZxOEFsTk5sVVdjeEJR?=
 =?utf-8?B?TlB3b3dLWFljN3VrbGNQY0kxWmhFVm5LSzVHQ0YyMXN1cVJzWDJOay91enJ2?=
 =?utf-8?B?YWFHbk1VV0JTZlM5WUV1UThHRzF0b2h6UytJeXJkdFprdXplNUVqbUQ3a1Y2?=
 =?utf-8?B?ZjZ4a25uNld2OEdGQTJDTW8xUmhqMEh3QzdFZ2ROSlJ4dWdma21KbzJYK3JK?=
 =?utf-8?B?ejBFdVRSN0lpaDMvZ0Fya3drMnZFTjExSWszNW5WeThnUHZBOVhGcmV1amEv?=
 =?utf-8?B?T2orOERKZ0JnVUhnamt4bkEyRlVTcjV1cFBxQjIybzBsc21KZTY3TjBDcmZL?=
 =?utf-8?B?bWc5bGJMaENDVURkSENNcUhZUk1Oc0IzTm1TVjc2SUdDUEp1ak1ZbVRVQlgr?=
 =?utf-8?B?TXl1bHJBS0E2VXRFR3pHNFVXWmltUGNJdFF4MVdJNGNOZ09abDB1M3d0RVZm?=
 =?utf-8?B?OFB6RzcwRm1hRzQvcU5FbDlra2M5YTkvbTBlZklJdER6Nm9VR1cxSnJPYldx?=
 =?utf-8?B?dDI5YXVnTGtMbEh6T2l1WjBPYVhOWlQ4QUE1TUhXY0hvQm5qMWhPcUhxWkI4?=
 =?utf-8?B?cUlueGxlUTE2N0dYcnVtL3dFbEl2RmNHU3Q3Z2NRQ2J5QlBjanY3bWxCalE0?=
 =?utf-8?B?TFRsdWpmQnZ0VTd1cHFQeWZXRzhzbURpcm9VZmNDK2cyS3Zmc1JRUjEzM2JE?=
 =?utf-8?B?NW9KM0J6SzZjdlQxQmhLM2hFQUhKQStaM3YzakZFSWdmNTYyZ1o5ZkZwTDJJ?=
 =?utf-8?B?Z0JISmtqZmdGd0swMDl1NUNScHMrVzk2TTBYQVJXdnFLWDNaakEzSzdXRVM1?=
 =?utf-8?B?NENCRVBaYUVjWUVnYjVlazJSNWNIU1hHbnBsN2I2RjFiempGcVdxTWpMcWZM?=
 =?utf-8?B?N1Z3K2RiMXZ4WlYwUHJ5d3NpNGZVUXpwVE94VmoyN2hBNE1IQVFLcHZQazdN?=
 =?utf-8?B?c0xiTkFJcjdUNVdLays0Z09OQ1Faa1JNcjdzYUVSWmZSaVdwYi9kSE9Vb1dB?=
 =?utf-8?B?RGdrdlNLUVJjeU5zSG9YbTlHKzQ0b3Zncm5vb1dRejJpWSt0S0lUZnFXVmpL?=
 =?utf-8?B?TkhRbXJxQndIMzRlU1A4eTN2YUxITUNYYWpkbkNPTndLajBsTHAxQUFJdFJk?=
 =?utf-8?B?QWVVdVkySjJaVDRsV0N1WW96R1BxdFZWejBjZjBnNCt6YWpXVnVvSEt4elh2?=
 =?utf-8?B?ck9TL2VVN3JQN0VJaTcwZk8vVzRZcUFMMm9qVmc2VGZOVEdMUmRta3BrU0pP?=
 =?utf-8?B?U1dyMHZGRkQ0ZnRuYU1vOTRCWkJrZFAwRGxmYisrWStGZHpqdTJ3VGF2UGZZ?=
 =?utf-8?B?eUt4am12QnJ2K21oSndiZWJZUFhaT1VITWxZSE5NY2EzNVFjUXJ0M2p1c1JR?=
 =?utf-8?B?eWNqTENqaWEvWFlIeVhiZHNScWNCb0o0MGN1QzJRVHhhR1JBLzhWYXcrdlZw?=
 =?utf-8?B?OS9DMzlEV2NaWjl3TVlER3k4L0paaDhzRXR5dXIvRWRNL2N5VG1YV1lBY1F5?=
 =?utf-8?B?aDRzanNiczVWZWw3UDk3ckJVMm5RUjl3SFhldVFKSFJ4ZjB0SzYxNjRiYXl1?=
 =?utf-8?B?Z3dmUzBhYXdaNE1RVDVHVVZRcUJ6ajR6dmpzMml0MjQ0dmNwVXJLd0NwU2VX?=
 =?utf-8?B?OTJZZVU4V1VLZVN5ak0vZlpzV3d2eFB1M1dYcGIwd3RkSEpMTXlKSFVVeUkw?=
 =?utf-8?B?aVJWNEFubWFldGRoTWt6VWt0NXhjTWVCeWY3VTFkcmNNQkVVaVNZdk1KVU1F?=
 =?utf-8?B?NU8xRWxzdDRQNUcyZEdGOEhWWEtTQXZ2aE8zbTFZNWNUNVo3SkVEdFoycDNI?=
 =?utf-8?B?eDdCL0pCR2hjemhyRXJ6QnhHcDJxYWptQXlNRHZJaHcra0NENWpId0s5NHJW?=
 =?utf-8?B?L1E9PQ==?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b76703f-8f92-4e08-43ba-08dbe047db0d
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8954.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2023 10:45:45.2002
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JMifNDkRwOCqhNkddYPbKXNmQCVCfAI22JFLG0C+xx1t2T1LKXSogMvW3/hKFjDQ3LiW/2bM9fL2LnQPpmfpsd8DD5aYOtmqdgnay9xazZk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9688
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04.11.2023 13:35, Simon Horman wrote:
> On Mon, Oct 23, 2023 at 12:43:25PM +0300, Radu Pirea (NXP OSS) wrote:
>> +void nxp_c45_handle_macsec_interrupt(struct phy_device *phydev,
>> +				     irqreturn_t *ret)
>> +{
>> +	struct nxp_c45_phy *priv = phydev->priv;
>> +	struct nxp_c45_secy *pos, *tmp;
>> +	struct nxp_c45_sa *sa;
>> +	u8 encoding_sa;
>> +	int secy_id;
>> +	u32 reg = 0;
>> +
>> +	if (!priv->macsec)
>> +		return;
>> +
>> +	do {
>> +		nxp_c45_macsec_read(phydev, MACSEC_EVR, &reg);
>> +		if (!reg)
>> +			return;
>> +
>> +		secy_id = MACSEC_REG_SIZE - ffs(reg);
>> +		list_for_each_entry_safe(pos, tmp, &priv->macsec->secy_list,
>> +					 list)
>> +			if (pos->secy_id == secy_id)
>> +				break;
>> +
>> +		encoding_sa = pos->secy->tx_sc.encoding_sa;
> 
> Hi Radu,
> 
> I'm unsure if this can happen, but my understanding is that if
> priv->macsec->secy_list is empty then pos will be uninitialised here.
> 
> Flagged by Coccinelle.
> 

True, this this should never happen. No MACsec interrupt should be 
triggered if that list is empty. The IRQ for PN wrap is enabled only 
when a secy is added and disabled when the secy is removed. I added a 
safety check anyway.

-- 
Radu P.
