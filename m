Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81BBA7AB551
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 17:54:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231740AbjIVPy6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 11:54:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230051AbjIVPy5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 11:54:57 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2067.outbound.protection.outlook.com [40.107.20.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 742E383;
        Fri, 22 Sep 2023 08:54:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WDUPFOODJveProtHth7SmYoEnWIN7XKIgARYh1my9c4F3PoNOVTyzIoQ+3BxQlJTca/oREJnJa31CRqi79Johdj+O3FrrQvDtw1LDhyGIUgqzObhdZ7Dv7vaKN00Hz2jEGi82iknTdNJMt5euUn+Mmnb62r/XAH/++J5PTT58i/jgBCLDlIcHkkWW7eBHUOrFYKPpspL5CD2FMresnjQgaBiGto9yUnHGYdg3r0QfsYdb4NbL41oO4AeaPvL6y+GFm/q33R0VqLB0RQgkDdK7spFWf3qPuKY8D66NsQ3fx3PkzahvD9TTFaP6w6ehSq3SoYo9mlxGVHXf+my4srEAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FcdVrtpkKXfr2R04cmYGO4Y45/LnG3O2UUDl4dmp9Aw=;
 b=Fh0u+a7r3u9YBzDAXFwq7vd93Yzzh6n/xGBhMbwkd9B7axLvqBaaoi2LliKEZH7Z0VhFZPliiwIypKf9sOiqYMRnG3nfSVQ1tx7Vf75XRCw3Oda11enr+r1MJeqgGQLJ+YHVBb1bI3zl85lf4QM75nbGmfC6wLGxKKTu9kibO9f0m4H2L4hh1Bh8/HjHBEezBlu/yql7ARIY5EjGZ6x8SlFWzsXFo7/T6dCYu2BawWm7OcFL4OtF8wg8JiOxv0C0l/tZz7YAnMDormaJbMsLzVp062fr3PznFUTNhhn2y/DWSYXiGUShIeiKPH4NqqQWoOYtCJfAWyXt5y+6iSSJYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FcdVrtpkKXfr2R04cmYGO4Y45/LnG3O2UUDl4dmp9Aw=;
 b=b5LrzcmQjafDapF5bT0EOKjRN9yJuYdpP+Km3J4rObkV++rwe9P9tQ2JrrC5o0n7Hx61u20h+FOxoyvsimZg9ngeKrmsISHP8mDfKw8qoN53PKfuvn9DC8/BDw2i3zUe3K8ajDk9ZU4Z6cuXRaukmYfrolUFap7iHb4jldcDXqM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com (2603:10a6:20b:409::7)
 by AS5PR04MB9875.eurprd04.prod.outlook.com (2603:10a6:20b:652::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.20; Fri, 22 Sep
 2023 15:54:48 +0000
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::e109:7026:7d76:5617]) by AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::e109:7026:7d76:5617%7]) with mapi id 15.20.6813.017; Fri, 22 Sep 2023
 15:54:48 +0000
Message-ID: <040a3ede-22f7-bed4-0dbf-10b68a9c7fe1@oss.nxp.com>
Date:   Fri, 22 Sep 2023 18:54:45 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH net-next v5 3/7] net: macsec: indicate next pn update when
 offloading
To:     Sabrina Dubroca <sd@queasysnail.net>, mstarovoitov@marvell.com,
        irusskikh@marvell.com
Cc:     andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, richardcochran@gmail.com,
        sebastian.tobuschat@oss.nxp.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230920092237.121033-1-radu-nicolae.pirea@oss.nxp.com>
 <20230920092237.121033-4-radu-nicolae.pirea@oss.nxp.com>
 <ZQxdLZJa0EpnxpCl@hog>
Content-Language: en-US
From:   "Radu Pirea (OSS)" <radu-nicolae.pirea@oss.nxp.com>
In-Reply-To: <ZQxdLZJa0EpnxpCl@hog>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR04CA0030.eurprd04.prod.outlook.com
 (2603:10a6:208:122::43) To AM9PR04MB8954.eurprd04.prod.outlook.com
 (2603:10a6:20b:409::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8954:EE_|AS5PR04MB9875:EE_
X-MS-Office365-Filtering-Correlation-Id: a697f82e-b9e8-49b7-93a0-08dbbb843f52
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bHIOkTrFLznojwpTVIl+D8I3W4C6rzDsQMRWScbaNn/OEAcyp8opHKHOQC+Od4k9QgtuiFS0n+M8cboWEdZZGBrEVGlu+ya++57Zuu9mfzNXB4LXCPnvt2KNvmIuSXmcPqfubezZ5UP+Dzau7Qot8GPiM2zKmrtPfEqImxscunKJ/aDuP7ifeoyTC740aWR8Kk7Dw8nP8ZMlem7AepJr6XGT1agjqjMbVRd+EQRWUIzzWRQf60opZfqbkfDc0BA9evs6kRk8PVMwhGczI4WCwvnQnI+JgztVnSXC2P+KAxobcrTFG/teSSMr+UZVd5yDhmLdscDOnzQGMGnnto3+AHyoO9zs7ytqto0tF3+ix8/ZDhx+5Dl5zmiTTSrzBb8xZnw5NFfLflAJNPkMA4rv/rErGIlHN+dIWYFM+vSUoa8bjN7jicP0sNgnmwoPY9CklOZMNQs7qsc36DN8/7RZhXPRxCABpC82IdE60XGKm9qqjzE4AcHQlVqK+i2nupZ+sADOOA15G3dPk9hO7jGqnK1I1oc2/lyozHu0cGjNdm9sNWBI4xAJ3G89azNat903oEBS4JlEvCytc+nxI7Iizw7yMZvvG6ilObm2ggUGhJbXSBL2OrWKj7sK+IK4xvpg8DWrAGwVA6i8fRyAkVbW+w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8954.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(366004)(376002)(39860400002)(136003)(451199024)(1800799009)(186009)(41300700001)(15650500001)(2906002)(66556008)(66476007)(66946007)(316002)(4326008)(5660300002)(7416002)(8676002)(8936002)(478600001)(31696002)(86362001)(83380400001)(2616005)(26005)(38100700002)(6506007)(966005)(31686004)(6512007)(6486002)(6666004)(53546011)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bi9WN21HM09kdzg4R2FiK0ZGaE81YnFVampnUy9yWXZuajIyYmNuVWxmbkdx?=
 =?utf-8?B?clBiMTBiV3piTE9KSFBHVVpsQS9ZcnkxT0tNSCtOQU56N0Q4UGJmU0hIZ0tV?=
 =?utf-8?B?c3NSOU90cVFVekU2S1VQM0YySmxPRDNGNnNvejUzOXU1MzNGU3NwcjdlK3k1?=
 =?utf-8?B?OFAxajhWWFpRbDRBSmFLNEhOeVlwTmozWmY5VHE5SktSdUFzZzlUNGpiUHZy?=
 =?utf-8?B?bHVUblJOa3BoS1JXVk9NblVYdFF5Z21aSVhLQnpmRjNKMUV3b0xUcUJkTG02?=
 =?utf-8?B?MHZkZ2hacVAvS1o1dnBJSC8rblRuUURPZWwrbmZHTkR3ci96Y1VSZ2lDaDFB?=
 =?utf-8?B?b0Y2Z0QwRkx0OVFkK1pPdTgyc3p0Nkx3c05vY1RQWEVzMGZTUW41eE1PM050?=
 =?utf-8?B?N2U1cGVVOUhYT0lnRTUwL1c0Nk43WUVDNjgvRTJwVE1HQzNicXkwL0pyN0dy?=
 =?utf-8?B?b1ZhTkJkcWd4ZEI5c2cvOTNQQ0FNQ3YzQkU0RW5TSFJWZ3hkaUJoaHlha3Ru?=
 =?utf-8?B?KzZhU1QyckRQOEtKKzVwdkZGckMvMnJYUkY3K1dJRzdlcGxlNWhoZUl3cFFa?=
 =?utf-8?B?VGFZZVFVcW9ub1lzOW1KcW5Db3o4d1RGQnJkTUJCNklSMmp6a08vOFBKMVRt?=
 =?utf-8?B?TUJtT3Z0dnQ0c0c2eFYxZzhXTUZWRmsxNytwanFCeXNXaUtFc3RPaGZKWE8y?=
 =?utf-8?B?ckVCZFF4RFZGL003Vkx3WUlPYWc3VkhtTFhmQWxidlBrblFYMHBaVU05eXRx?=
 =?utf-8?B?WWZodFJVaENNU0tieFRRazZFcjY3NzhkTU1RVm5Ba1Z2LzJTZkc3bWowOG5K?=
 =?utf-8?B?ZDJvMEtUQzFhN1FXYzBRWXZyanBFblFGSW1WUU9kQ3o1dlpTZFg0eTFTSG5u?=
 =?utf-8?B?dXROd1FENER5Z3NMWWxMa0E0SWRFS2RnaE1Fcmk2Uzc5eUY0NmVhYTFPSC90?=
 =?utf-8?B?QVl0SUdsb2YxeGtRcTAwSGdwbDBlRks2NzlPU1BQR3UrL3FWcG42eWR2aGc5?=
 =?utf-8?B?RGY3VklEcUlKV1l4dkUwT2RNMm9ZckhSem1wbzd6b01qWUpsYkVVNzhlNmEr?=
 =?utf-8?B?TXl6REpjYjJENXhXUTF0QjByU0lUa2NVOEFvN24xV3hmNzdDSm1BRjFRVGtp?=
 =?utf-8?B?cHJqOEJUZmM2TmY0azZFbWF0RzM3RDkwZU5OeVF2aElTNDNUYi9rWGcxVnFz?=
 =?utf-8?B?dksvNGdBeUh0L0hMaW9qOTJvVEdVWnhnTjhrd09ibnV4WDdqMGZoMUNtZmFB?=
 =?utf-8?B?OTJZazgzTXd5eGZGdVMzUmlWeVd5SW5WZVgvU0JjOE1QeE9HbHNrWXdIZzlW?=
 =?utf-8?B?Y1poWGh3VUl3YS9rQ3g1RTlrSDY4M295UDVoUEdRSU9EbFBydzREdnlIOElv?=
 =?utf-8?B?NWE2OFpYSkVsZ3VRS2FBQlk4SFJBK2JwVFU1NHIyYVFOY2JEUUxMMGc4U00y?=
 =?utf-8?B?aVdoQm5YQU4vaHZYY3cwdm5uSVp0REE0ZDlYa0l1Z1IxemNFL24xWDZXQ05a?=
 =?utf-8?B?TlZLWkZPWmhiQXVtcy8yS05JWkIrMVc0eC9yZW5nR0s0Y0ljc3JqejVRL2xw?=
 =?utf-8?B?YWY3SlkzMitMSWpIYkg4LzdqM1lPNDUwNUZMMEVSUkNXUmRhZDE0RUlGSmsr?=
 =?utf-8?B?MU9USFlrMWxSSGtZYUJ3NHZQZUhPendOc0NTNy9ZbkdlQmF3anlBanhZWTF2?=
 =?utf-8?B?bC9sMHM0MHNzQUVsa3lRMmdtM0ZZYTBsNzhKNzBEcnFTc2s1ZUl0aS9HSkxa?=
 =?utf-8?B?UFBkVTdrSDZPdXFMQXpPVXpuY0l2b3FwaUNrcDMrVDB3WXd1WFlKdUozeHpQ?=
 =?utf-8?B?R2JtM3h0eWhCNTFQamFHcVdiSVlrZ1U2Wm51bGpsYXMzbm16cHJPcmlaaEM5?=
 =?utf-8?B?WXdmRXNLci9oOTdUVGtOdi91RmpKSy9iWXR3dHZwU0F2blR4RnNtbHNJRXoz?=
 =?utf-8?B?YVpwWXFna3RnZ2F5dm9lMWluNHFaNHNCOGl2UWJQSEZXbTJ5WnRpQjdBODMw?=
 =?utf-8?B?L0lycE56TnFTaEUyUytNZzV0VFMzWE9xUlpiZklETjg5eWp1SWVsVE02TEF5?=
 =?utf-8?B?U2FmSHcvM25NM3V6bjFMemloaTRrR1VBUjVrRTVDUkZBb2kvQmVkUUhuR0JZ?=
 =?utf-8?B?MWx2Q3dVZGFPeWpZV0dZWHJtZ0ZLWmw3MW9mWWRuQVhoakUra2xxNWltQTlY?=
 =?utf-8?B?QUE9PQ==?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a697f82e-b9e8-49b7-93a0-08dbbb843f52
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8954.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2023 15:54:48.0354
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U2NjI94WbZDj1W7P+2JKBS7KGmUe6fZR3NrbfggRHj4weTxv4jC/RNv5VIilLutBuquBRefpiNp8FVhNqCKBtaGQ/JwmwSFtBRBsSz7e9+E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB9875
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 21.09.2023 18:11, Sabrina Dubroca wrote:
> 2023-09-20, 12:22:33 +0300, Radu Pirea (NXP OSS) wrote:
>> Indicate next PN update using update_pn flag in macsec_context.
>> Offloaded MACsec implementations does not know whether or not the
>> MACSEC_SA_ATTR_PN attribute was passed for an SA update and assume
>> that next PN should always updated, but this is not always true.
> 
> This should probably go through net so that we can fix some drivers
> that are currently doing the wrong thing. octeontx2 should be
> fixable. atlantic looks like it would reset the PN to whatever was
> read during the last dump, and it's unclear if that can be fixed
> (AFAIU set_egress_sa_record writes the whole config at once).  mscc
> doesn't seem to modify the PN (even if requested -- should it should
> reject the update), and mlx5 doesn't allow PN update (by storing the
> initial value of next_pn on SA creation).

I updated octeontx2, mssc and mlx5. Atlantic is unclear.

Mark, Igor, in the atlantic MACsec driver, can the SAs be updated 
without a PN update?

https://elixir.bootlin.com/linux/latest/source/drivers/net/ethernet/aquantia/atlantic/macsec/macsec_api.c#L1641

https://elixir.bootlin.com/linux/latest/source/drivers/net/ethernet/aquantia/atlantic/macsec/macsec_api.c#L678

> 
>> diff --git a/include/net/macsec.h b/include/net/macsec.h
>> index ecae5eeb021a..42072fdcc183 100644
>> --- a/include/net/macsec.h
>> +++ b/include/net/macsec.h
>> @@ -254,6 +254,7 @@ struct macsec_secy {
>>    * @offload: MACsec offload status
>>    * @secy: pointer to a MACsec SecY
>>    * @rx_sc: pointer to a RX SC
>> + * @update_pn: this flag indicates updating the next PN when updating the SA
> 
> nit: "this flag indicates" is not very useful, thus:
> 
> @update_pn: when updating the SA, update the next PN
> 
>>    * @assoc_num: association number of the target SA
>>    * @key: key of the target SA
>>    * @rx_sa: pointer to an RX SA if a RX SA is added/updated/removed
>> @@ -274,6 +275,7 @@ struct macsec_context {
>>   	struct macsec_secy *secy;
>>   	struct macsec_rx_sc *rx_sc;
>>   	struct {
>> +		bool update_pn;
>>   		unsigned char assoc_num;
>>   		u8 key[MACSEC_MAX_KEY_LEN];
>>   		union {
>> -- 
>> 2.34.1
>>
> 

-- 
Radu P.
