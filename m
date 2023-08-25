Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CD3E7888DD
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 15:45:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245167AbjHYNom (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 09:44:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245280AbjHYNo3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 09:44:29 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2065.outbound.protection.outlook.com [40.107.104.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B297213C;
        Fri, 25 Aug 2023 06:44:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KmCrPvk9owNjB497NiuXRauDV5fojNhKGon3i1rJ6z4aXBUMHbwO9LHRPn6b9MJF6KLN+sICSENaj8LoCbKtUPza6l5wIPWBgrB40gHvM+kG9JH3zJNbPqQTIZEVWvCBk+AvfZAeu81TgGzRovVQvGmeKtwtk1yQfj6BlBi3VNcz61yh9/ZtkS0kb+r1X1TmhAt+CFn0TjAOq9EqT/Kd3w2tN1NEwF2Q7eHRT/Da1dfZGd5PvqNV3x+Kc/QEZbNp9d//6jCbSQfxBxASRP0z0alaLBoWwru9BPFjNZtS1ZkY/11kve2dKYZuCe0fwP+DxUO2Mop2ufL/JbqoUFrgNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dnuUanpGCJAPsYE3iycmjf9k4Rk1daPOMwPqtC2+DJ4=;
 b=eoxOhl1Gwf8UpdLqA0jDLtxeV2jHXISz99K99/E6dJ8zLXXQz6P+NAr1ToNe92D2rLeF9KYqDOugcuzNx6xqCypYkPkJUkq0LNpWVWilf/2ombSTCozl/OAnKylEdbq2KyPuv6ZD5C9YxHqIu24Pk5UjpxKPCw8T7esgsXl30XV/o3Rg2bQnHOR9IuNpxs4lLamZv9nH6AmSrE+DcBHsEHx2xsA+Y1EmpQTYkr972RgB0sc8m6lUcg9l7r9ajw56hi2kk+lG8EMGVCjfzYKDVEg7r1EEtb+cH5OkltSq7/ij5/bIb+2H070vtxQs4Z1YxcpqAeiN4fFQCRT7OhBwjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dnuUanpGCJAPsYE3iycmjf9k4Rk1daPOMwPqtC2+DJ4=;
 b=Gu2kXzLafeLkCvpCEFPLpZbVfBwCERp7pkxGYD9yP33u47W6uoQdGLnWnXOPhQZnJkEK92dHeBVWmGNBvZ2Llx3aFWxVWaJNXAquYN5NBDyArUSIMYTohmNm08exglXvIXfMdUuKibi44Nh4P0Gx0hEyHMx3gT4oTnov9pqIDHk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com (2603:10a6:20b:409::7)
 by DB9PR04MB8155.eurprd04.prod.outlook.com (2603:10a6:10:24d::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27; Fri, 25 Aug
 2023 13:44:24 +0000
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::2545:6d13:5905:bf50]) by AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::2545:6d13:5905:bf50%5]) with mapi id 15.20.6678.031; Fri, 25 Aug 2023
 13:44:24 +0000
Message-ID: <a1baef3d-ad81-5e10-6b8f-7578b3b8d5b8@oss.nxp.com>
Date:   Fri, 25 Aug 2023 16:44:19 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [RFC net-next v2 3/5] net: phy: nxp-c45-tja11xx add MACsec
 support
Content-Language: en-US
To:     Andrew Lunn <andrew@lunn.ch>, Sabrina Dubroca <sd@queasysnail.net>
Cc:     hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        richardcochran@gmail.com, sebastian.tobuschat@nxp.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230824091615.191379-1-radu-nicolae.pirea@oss.nxp.com>
 <20230824091615.191379-4-radu-nicolae.pirea@oss.nxp.com>
 <ZOikKUjRvces_vVj@hog> <95f66997-c6dd-4bbc-b1ef-dad1e7ed533e@lunn.ch>
From:   "Radu Pirea (OSS)" <radu-nicolae.pirea@oss.nxp.com>
In-Reply-To: <95f66997-c6dd-4bbc-b1ef-dad1e7ed533e@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM8P191CA0025.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:21a::30) To AM9PR04MB8954.eurprd04.prod.outlook.com
 (2603:10a6:20b:409::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8954:EE_|DB9PR04MB8155:EE_
X-MS-Office365-Filtering-Correlation-Id: 60e95714-141d-44bb-e99e-08dba57164a4
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GK9HQ2fMj7bDr6mDwb3aazqbweHiQR43lPcHUAMpqpRxpjrMRduAtfLvq7D88bugerOFu2rOb7Kb8XfshPT03FUi6GogD3Ore0Hpn5NoeIikCvHaDzWE09hZJXm78L9mRCpKxWSGGB3rXTVco4d+u/CcZ1t1INLDpUIhAcF+AnStPnW1kBphWx4mVfeqQ3i0Pg4CO0QiwBCjSN9O0iKQUdIdwtxACVuGRz4NgY0Qy0KqKUN0K95fk8io9NSprmeNbNkvAsEX4AD0P8tFJwY7/MEfSLGZf4SGii7GUHFP0nnsO7GZrytFIIIjEDtR3MbbzEiCYznxuIvjY2FS0ULp4W2xDbUsxAW8bX1aVF4CrdoUdShSZ1oY6U7OCO0n/Jnt+IdoRVh431A0MM7nsZaayV8KQZXT6IZIiX5MUPsWoWQF3wdl+vT11SvPO3uvtjHVKrxcJ3rxjH9NrlDaps8bqnJLJe+iDlLi5JGQUDC6+t1HtkR6OJah5efexnBt4eDHGn7LEI6Dspf/aL78DRKQKmDsFIh3abU+G1dKLAC/XCdPIuf0uibZ5jX5icSFpgVdTxwxwvlnIcNQ04Lnt+Nx4gNIycJ/YXLREiXU4lE41tTibz/61h1FlrXplvaY+TUtJcypGX0v1IfYkzSWAtNIaA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8954.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(396003)(39860400002)(366004)(376002)(451199024)(186009)(1800799009)(66946007)(66476007)(66556008)(316002)(478600001)(110136005)(26005)(6666004)(38100700002)(41300700001)(53546011)(86362001)(6486002)(31696002)(6512007)(6506007)(2906002)(31686004)(8676002)(4326008)(8936002)(2616005)(5660300002)(7416002)(83380400001)(4744005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YTVYZlhIc3BzbDlNTzUyWHpqWmZJUWxSOFZnM1R4MHVqb3RtbzRWcWdKSC9E?=
 =?utf-8?B?a0xMU3JLeVNlaU1SeEc4aTZjUWU3bFhaUnpCRDliOC9DelVTMXJZZzNrTWpt?=
 =?utf-8?B?UG1NbThrQnE4N2NsbXF2R2xLbmFadXArcW5oOFYrcVdiR1pnT0RXSXlhbE9V?=
 =?utf-8?B?OFBwemtUUDZOa2pXV0RENGtpOUIwdjlLcE8vVUl0dnVvMkd3S09oRW16bldY?=
 =?utf-8?B?RktrQUZ4YnRCUGp3cjFtaUc2dWhGV1BZZGZ3TlhFR1FBSmhydDQxeHliY0Fh?=
 =?utf-8?B?YklUQ1drM2JJMTdDaGoxNU9hNm55RnhGNkRNVkI2OUlHY1NrNmY1SW9hKzBi?=
 =?utf-8?B?b2RvN2s0ZnZGNVpCb09hWnAxMkMyOXk5UFVCM1BiWmtiY3RWUW9LRGZteWRL?=
 =?utf-8?B?NDBFdW5wTWRnYiswREZ5aHVUaUJFWUxLWGZMOEFVMzgzeDNNeHZQSjRsZUxa?=
 =?utf-8?B?STh1eWRxYk9QTXdQVFVpQ0FQTEY2SVFMTHFFd0JwSHRXdjRQdmROWkxaRTND?=
 =?utf-8?B?a2MzRVQybUdDNW16VmN6QmIwTWRObjMxY0YySm9HWnl6bGk4OXoyeU5mUnBK?=
 =?utf-8?B?c2ZOZGlIOW94NksxcXU5bXJUZk5rTDR2MEk1NW1IUXlRK3NySXFlMVdTbSsz?=
 =?utf-8?B?aG9KMHVoNXNDUEx6aCs0UXJneTZWcy9Bd1BWUi96cVZweGJ3YllIRWVQNGRM?=
 =?utf-8?B?QXprcGdBMzBQS2hKRS9zeWx6QTRBdkRrTmxFU2hZZ2RwVDV2NDhPYmc2Ryt4?=
 =?utf-8?B?bUlVUEJhQ2JVSHN5bHNxVHpTYnZpbHJXM3hjY09OMi9ZOThsalpTS0kyWGVp?=
 =?utf-8?B?cEJKVDlnWEZoR1dhT2ptMFpCWXpVVnZNTEtoT1A0V0pYOHVnMXY3R3plL2JU?=
 =?utf-8?B?ak5wYmFDaXhoSUVxV3pCN3pTclVGY25nY3g4TWt2Yy9IY25MRzBrazdqQ1B4?=
 =?utf-8?B?UjVaZzVWa05FQ2RVeU5kaDRTRElxTEVwR01qdU9uRDFXSHNxR0lmYTdBOUpH?=
 =?utf-8?B?N1N3NURIOEJWM0xIVllPTXE0MXpOUzhGTDZCTzM5VmlRRmRNU3RWNGROb3Q0?=
 =?utf-8?B?eThuYXJITXloM1ROdnNMVjdFKzZkMEdvdGFMaVZ2M0VXZHNOclFqK0lKZnI0?=
 =?utf-8?B?ZFVNdGZNNDdoTEpZTGhNZzkvTytjNDZNNFpaRmppV0hGNUJnM1JKZGYwbExG?=
 =?utf-8?B?dFgzRytwbmdqMFc0VkJpYTVGTTYrQ1dnVFNBeHo5VVVTMHhpUjNHb01KQkVE?=
 =?utf-8?B?c0tONVNwMGEvWVBCQ3RoZFJlNS83TVZWeGp3bUJQd2g1SXpwOG5KWFgvZWJ4?=
 =?utf-8?B?MlNNbEtmMmFqdFV3elRUZU9CVU5ONkorU1ArNVM4ZWQ0M0FTOGlVMFhYdVk5?=
 =?utf-8?B?WUhJVjRVUHZDWkl4aVJVV1c1S1lHdnNxQnNtT2Ixc3luWEJKSW1HMmxEUzJt?=
 =?utf-8?B?UWVHcjBaY2xaRnB5TUQ3WUY1aXVxUzRmSEdpWjR6RWVLQk9Uc0lzL01sQUVo?=
 =?utf-8?B?VVlOWFFHZDFaazFyenpvejl2TW1MY0tIV2R5ODBUZjIwKzF2NjZGVTYzZVdF?=
 =?utf-8?B?bzQ1S0tUaWFNWVczdmZzbkNiQVBWK3JwR21wNHVEc2hES0x0K3U3bCtSSS9p?=
 =?utf-8?B?ZUpUbXBBRFh3a3MwSDBDcDBoUG5Qa3hOZGJWVWlkdXpxbVVjbkhOeFN4NjRN?=
 =?utf-8?B?cjBVWGx4YkJ3bjNKamNTZTAycVJ6T1grZ09zcS9wankvOHhwTVRQVTVMdzZi?=
 =?utf-8?B?M2RYK2dDRXE4TFhPVms1SjVkN3kyY21Oa0I4ME5rZmdxTGZpMUlHQzFhNng2?=
 =?utf-8?B?L3NpbEt2d0EzMTJNZnhCVFRFcit4VUk5UlFBWlZZR3N4aURabFpWMTJ1ejZs?=
 =?utf-8?B?OWNXcGRNclJnMWc4S3BKRkxWMlFSMXlxS2JEbWpwM0NWZDBuRWMyeldJTmY3?=
 =?utf-8?B?VENwTGJTUHZvWWFzVFpiaGc1Ly9rTC9tbW9hZEt6ZEF4NG41OHJjZm9OZFFL?=
 =?utf-8?B?clV0N094WGJ4YlRsQmFWaEp1aXJzdlVURjNGWlltNEpyODZaMGNuem00WEN6?=
 =?utf-8?B?eU9EWjJqQkZIRWtRTFE3b0t4cXd5VUQ0YUVTMDRzN2dtS3FSaU5KS2liQ1N1?=
 =?utf-8?B?a1BJNnY5dlQyTzhBZkJvWEprNmJYdGJ3TXJMTmhqeE9Icm5JdEdaQkJYU2ZW?=
 =?utf-8?B?VUE9PQ==?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60e95714-141d-44bb-e99e-08dba57164a4
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8954.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2023 13:44:24.7036
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wojrggHEB8xapo1jHSp3tCwNL1KPQV1CbKRp8YRAHCdCEMFbR2I4vvRYJV8lsGKByfBrW3gT1CJtQrNr3TYNj4KCZrwYNO0TdkVHeJ/E9Z8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8155
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 25.08.2023 16:29, Andrew Lunn wrote:

>>> +static bool nxp_c45_rx_sc_valid(struct nxp_c45_secy *phy_secy,
>>> +				struct macsec_rx_sc *rx_sc)
>>> +{
>>> +	u16 port =  (__force u64)rx_sc->sci >> (ETH_ALEN * 8);
>>
>> u64 sci = be64_to_cpu((__force __be64)rx_sc->sci);
> 
> why is the __force needed? What happens with a normal cast?
> 

Sparse will print warnings if __force is missing.

>      Andrew
> 

-- 
Radu P.
