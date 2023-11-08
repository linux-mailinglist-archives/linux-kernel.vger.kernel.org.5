Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B98467E5820
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 14:50:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232501AbjKHNuM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 08:50:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230467AbjKHNuJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 08:50:09 -0500
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2049.outbound.protection.outlook.com [40.107.6.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E25F1BEC;
        Wed,  8 Nov 2023 05:50:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DIhbSaX9U/1QwK8w7t+i78DBxGtChXAnt0wPQ37xy9/+GuA7BzIJ0V640T0FgjX1uoJQGcmNDQ976QtK1RhR0xIKO8x1g7ewz3FIz6meWd+JfS3hZU5BUEwG0ccVi7/55qKEMGQSOYY7O8VFD0ZqupvvPE6okL91G3Iq2fTSfxVjct9n0Seh8f2ada6Vx8w6eSYA4n6SQx9EJGeWnSiKq7o+i3wk4yLBzVfUj3Nwa+SFJj8uIm5aosLUCt9WuZFnMPzdtYplVQDUCG0yWMakz9Cy5Y2lUMU08JaZkBWmuDCUeA5bJ742NkkvsNZJC7XlS6Er5CR5CDmAcaQXRAXPLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jtdHq8M52MEIfPdA2+hFBZyYlSil/cX6NVXpyCoBd5A=;
 b=LmeI9NRQ7n2yP3Evg70uzQ+depF8466/+rLDEvC/ejRpHnQi191URZ2V+8W+W5425cG3UwYfBj4tyro2KMlK/CpPbZMLIGVwirBNDD3XSdYcOTeZ3NPic53RnTaRHfd3hqQ3dwh2mJzL/4B9a//MBK/J+uMP3CIJq43OwrfyNLO1kXNgwKQhII6K8O5Cm6qsu8An6Xfpp6zO/Snxd8xzt4PCYVHgHBmTkcxSFoXcQFBaRnyNmdKJs0bhNNrqKuvmJr/97KbGzPeVoxmq7Rp7BC45ISf9NNSYh5FJfpY640rsV6Jg1ljNVjmDeHQ9OeWoY33YfyuLogNWweRNcoqNBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jtdHq8M52MEIfPdA2+hFBZyYlSil/cX6NVXpyCoBd5A=;
 b=l304vIhXh0NCsh4DdivW7X/arrd+euV3FBiEm81dIOf6Xlh8PcnAWHYyH9ue0IwPeBzAlLvpM4CJRJb7z4OIkDgCiMIRCkUYLbhQIVUqzwO0r+6NrHzlPhC2GrylhBp1LaxX9lI07O40iWO3+UTN78Q6mN/gxwtZJenhgS0uyAI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com (2603:10a6:20b:409::7)
 by PAXPR04MB8221.eurprd04.prod.outlook.com (2603:10a6:102:1cd::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.18; Wed, 8 Nov
 2023 13:50:04 +0000
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::e083:450:470f:fb48]) by AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::e083:450:470f:fb48%4]) with mapi id 15.20.6977.018; Wed, 8 Nov 2023
 13:50:04 +0000
Message-ID: <1424ab1c-8e4e-47da-bacd-5b30b6d10c60@oss.nxp.com>
Date:   Wed, 8 Nov 2023 15:50:02 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v8 5/7] net: phy: nxp-c45-tja11xx: add MACsec
 support
Content-Language: en-US
To:     Sabrina Dubroca <sd@queasysnail.net>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, andrew@lunn.ch, hkallweit1@gmail.com,
        linux@armlinux.org.uk, richardcochran@gmail.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        sebastian.tobuschat@oss.nxp.com
References: <20231023094327.565297-1-radu-nicolae.pirea@oss.nxp.com>
 <20231023094327.565297-6-radu-nicolae.pirea@oss.nxp.com>
 <ZTuE99jyr9gW3O1S@hog>
From:   "Radu Pirea (OSS)" <radu-nicolae.pirea@oss.nxp.com>
In-Reply-To: <ZTuE99jyr9gW3O1S@hog>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P190CA0037.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d1::18) To AM9PR04MB8954.eurprd04.prod.outlook.com
 (2603:10a6:20b:409::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8954:EE_|PAXPR04MB8221:EE_
X-MS-Office365-Filtering-Correlation-Id: c0cc5237-0b80-4c21-43f2-08dbe0619c52
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 580jwoicWju+ayzDcvUIsiRkAw6pRnMJbD8OQGZMsIpCLbsHjY4rUyKJgdvhqCqZWZeViOgEqtooZbqhzEe87k+fPg6gaZETlJTRFwJepSADua2Vt597Kysr6OL8SyXrTnvzrq3givN0QDDA7XcMVApMogmG14VHJPU4cWnGWAZOfwQDrAAWK6qAmhULeVS1Jdrm8BY74PpTMebRB3felpCoXt/wfejRTpJtMcMwR6zSRBoDKABWrbFLfNCr5VoZcjNRi1HlkMPihJd4bYjyrJcbC1XptcPZA9s8Lyk29iLE8Z+TFZqh9NFiII093+3dSJfdJRygrSMkBU6WRFTSA9QqEuGnJP3Ti/cuKk549/B66YpF6wmXp169yu2JJvd9uvecyxIZxwyaUOjM+HmC5xHihaNbIJYlLdz2VDLkmWMkbHkDoOEfJk8spflrYpC4QJS7XoOIGgqnFBnL0215+qZ+KYqswWp+ksg1kg9xdOO+KlkNSFZ/CpWkJmXmouLb+QLwaF3wMrBtXuW7pkNPaD2YfuQjLod/WC2jMAkcAeIDD5h0bhiIedBtQElL/Zj8lXbFAztsDB57W0OmLDXqRaavZYxRrgJBh/9VkcNZrQWM09HfOzFAHF241FSs8UMND1IOrqfZBH3t/2DJB+tY2Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8954.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(136003)(346002)(39860400002)(366004)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(26005)(2616005)(66946007)(66476007)(66556008)(83380400001)(6506007)(53546011)(478600001)(6486002)(6512007)(4326008)(8676002)(8936002)(2906002)(7416002)(38100700002)(41300700001)(31696002)(6916009)(316002)(31686004)(86362001)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RUowZHE2MVlNK3lObTlZbTI3OHFva1VFcERBVEFhMnBxUWQ5SFNMZEVZWGtQ?=
 =?utf-8?B?ZEUyUWhQVXhQTWlHcGRUcjI3SzJ2eFVDcWJiQml3NmRYcmlGNmdwemJTZ29O?=
 =?utf-8?B?WU9FcEVGSjVORHJBMUUxRXV6RG9RcnY1ZEhMMzdyb2NoVW5kczhpKzdzRHJI?=
 =?utf-8?B?Z2RYTmtWb0JublNHNXRQVmRCbFltNHQxaUlqRW96dDhHSXZRR2NkdElSbCtF?=
 =?utf-8?B?b0Y3cUNpaGRhb1dzcFJ0OHdJdnk2VzlGM3VFZjdGNjRybUxMQUVnQ3NZNkU2?=
 =?utf-8?B?U3NjcGN3aVFHVHo0YUZNeld5SEpiSG5Gd2VOMWgwRFN1b3A0ekt1ZGkvRmhF?=
 =?utf-8?B?azFJNjJUNXdqaUZhR2JXZFd4RVZiTUtObTZReFpyWGVqeURxK0piK0tiUnYv?=
 =?utf-8?B?S0gvV1Z1dXgyT2srT1c2eDlaa0ZvWDdNV2lMV1R0dEY3SGtucGFZcEF2clFz?=
 =?utf-8?B?eGw2WlV1dk5yZDJpS1U5NmhWTDZVT0pGQjBhalNUa3RDWVM5VGZkWUZvcFdv?=
 =?utf-8?B?YitENEtOajg5ZjhjTnRJT1V5eUNRY2I0MWUwdkpmajJHNVJJK2lJSENLL3VX?=
 =?utf-8?B?RytIRjZXYzlSekpYY2pTSXBRM2h3cTF6TjRXM1BwWERxZ1FWQVcydDhHMGw0?=
 =?utf-8?B?QjJ0Tjl0akFJNFFLRTBMWGVjVDNLYjJUSklhdmlZckpLQTdRdmx1Nk1GN3BR?=
 =?utf-8?B?bU5RZVE2N1oreFVjL2EzMzBVNEVoUnQ5dDkrdWtGbEMxQzF3RXFCVFBXbjQr?=
 =?utf-8?B?L0wrR3pQc0dtREJ6OXFtQ3U2V1lqTnBnVjR6cUNOSmNrY2dpS29jaTJRdDN4?=
 =?utf-8?B?a1dUVWE3aGlXL2hvOThRRDRxd0lmMUhzNS9zV3ZVWkNpUXI5Ny9OQlNySEh1?=
 =?utf-8?B?dkRzUkVaOURvYWFxcFBFSFNHZzV5SDRiajBmSlFpN0pDN010WEJ2SXNLazNo?=
 =?utf-8?B?ZDZyQ0VXdW0xL2F1YzhWTUUvNlFJWmYxNXdUQ01GbDhIUlRjYkhhL3hnaVJI?=
 =?utf-8?B?M1UvZVpLRnhVeVJrenNFWk93cndMNXl2UDA0Y2RBanNMV21FcnMxekFDZFBQ?=
 =?utf-8?B?MEh6NTdUdVIvaEszS0VpQnBWLzUzYk5PdExjQkNVczJvenZDelhldlNQRnI1?=
 =?utf-8?B?L0FlaGhaM3VQem9IMXZnTVlrQVM0NXdTN0xQU2FHTjNLZys5bTZrczFaa3FP?=
 =?utf-8?B?eE9hVGpIZER1UHZaMVpXQ1BNMVZ6ZmxwUGl5TXNRUTk1bzZwZTV0di9DekJv?=
 =?utf-8?B?K3dnNnY1R0xtTEtYWnVqY1MyRy9PcFlKeFZPSmZTVE0wajNOSGNReXFJcGdu?=
 =?utf-8?B?TkF0TUxZcHpEcUZCYzdZY2ZQeXRmU0NCWHFLTnVEY1JMN3E4ejN5NUtEMkJo?=
 =?utf-8?B?S3V1eEVUY21teGFNZ0Fha2sxUVBPT1YxeGdEUEZjQld6Mzg5QXhScmk1eDFQ?=
 =?utf-8?B?aWpUY3RWSFQyaHM0ZnR2SVRkMmUxN1RVSEtjS2FFWTFJZ0hUMjdITEROeEhH?=
 =?utf-8?B?Q2dHQ1YxdFJ3YURtUFFQWTRjV2txSmphdUdHTlNmOWpYanFmbkZVRm1EaTF5?=
 =?utf-8?B?eTRaWWhmdDRVMmlOeElQak55Ry9tZlYrSDFBMkYvVXBKODd6elVGM0JrSVNC?=
 =?utf-8?B?MVVOUlRUbG40RVRTYzNkQytYZ0lEOXd4REV2eTgrSmowRjFtTDJDQzljYnN2?=
 =?utf-8?B?ZUYwQkptanNvS0huZ3dBV3ZwVGRpNExYRVlDMHYvMlZ3N3JlZWNjdU5reHRJ?=
 =?utf-8?B?M004cmJHcFFZRWx1WUg4K2kxWlBZN2RkbzNFdldPOVJBVktQVUp5SHlBYnJa?=
 =?utf-8?B?c2lNMTROTW56Z1EwZHpBZ0ZsUTZvRU42MUl6dmgreG9XRXpwR1QzWHNHVFl5?=
 =?utf-8?B?N28zSWFJeE5SUEsvMGNic2lRQndNcFNpSTVDRHlJYUNXZHg1V1FYM2laWkRE?=
 =?utf-8?B?ZGtVM2dJcGFvUDlNUE9NeDV0cVdFR3FTMXphL2FKdXRpU1dNcXlpWXZmZHZt?=
 =?utf-8?B?UjFoalJMUkxuSnp4cWsrc2FkeDM2R092OHAyelhRZGZLMnM4WE12T0dJRWVN?=
 =?utf-8?B?RUF3M3lHOXQvakV5OHJBQVRDeW90QlBRRVNoVk4vRWlkeVBadzhYb1VMUTdX?=
 =?utf-8?B?d2kvTFNaemlWWFptMGc0a09UZUFibEdQRjRHR3o4a21YSHJ1MWtkSzVzdktY?=
 =?utf-8?B?R0E9PQ==?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0cc5237-0b80-4c21-43f2-08dbe0619c52
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8954.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2023 13:50:04.4555
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g7Tb9eujI3ttCXXuLOfyNx0kiF25sjIOQrfpTXGVD3h9XvZ9pvCIqXa12jk31Z1/kTat1F+v/c3QMIQXVMSapiOmxAVQghgzZsodp1+Ed3I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8221
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27.10.2023 12:37, Sabrina Dubroca wrote:
>> +static int nxp_c45_mdo_add_secy(struct macsec_context *ctx)
>> +{
> [...]
>> +	phy_secy = kzalloc(sizeof(*phy_secy), GFP_KERNEL);
>> +	if (!phy_secy)
>> +		return -ENOMEM;
>> +
>> +	INIT_LIST_HEAD(&phy_secy->sa_list);
>> +	phy_secy->secy = ctx->secy;
>> +	phy_secy->secy_id = idx;
>> +
>> +	/* If the point to point mode should be enabled, we should have only
>> +	 * one SecY enabled, respectively the new one.
>> +	 */
>> +	can_rx_sc0_impl = list_count_nodes(&priv->macsec->secy_list) == 0;
>> +	if (!nxp_c45_secy_valid(phy_secy, can_rx_sc0_impl)) {
>> +		kfree_sensitive(phy_secy);
> 
> kfree is enough here, no keying information has been stored in
> phy_secy.

Agreed. No key is stored in the driver. Changed kfree_sensitive calls to 
kfree calls.

> 
>> +		return -EINVAL;
>> +	}
>> +
>> +	nxp_c45_select_secy(phydev, phy_secy->secy_id);
>> +	nxp_c45_set_sci(phydev, MACSEC_TXSC_SCI_1H, ctx->secy->sci);
>> +	nxp_c45_tx_sc_set_flt(phydev, phy_secy);
>> +	nxp_c45_tx_sc_update(phydev, phy_secy);
>> +	if (phy_interrupt_is_valid(phydev))
>> +		nxp_c45_secy_irq_en(phydev, phy_secy, true);
> 
> Can macsec be used reliably in case we skip enabling the IRQ?
> 

IMO yes. macsec_pn_wrapped will not be called anymore if the TX PN 
overflows and no frame will go out via controlled port reusing the PNs, 
but this should not be an issue. The MKA should not wait until 
macsec_pn_wrapped is called and should change the keys before the PN 
overflow happens.

-- 
Radu P.
