Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15D397981F6
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 08:10:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237769AbjIHGKB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 02:10:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbjIHGJ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 02:09:59 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2067.outbound.protection.outlook.com [40.107.20.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0214C1BDD;
        Thu,  7 Sep 2023 23:09:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UB3uxv6me5v1jSHwlt+R40TNSEemSpwvbdKSa/TeRcJ2NweiB6HzClUQDp2aljQ+ijpdU7hcGoJ8bw4Lu+d/gIQzWOOgFRbfdlfEU1cvpFQSPEost5Ui8B3pT5KAZ7l14M0ezN29OaGgQAX0O0MAzPAJzckk3cmsXxsJXCd4Jz0muTk9ybOzwN4ZRngpMSpeMsYDgRo49ypsW3M/vA/E7sQcqFhGOG46OFoECvE6g88NguEV9+eeUtVA0ZSoiZPj/l4qtDrL6rGlcj5P9jifX14Y3fTf3TMwf27W8mApZs7n/5WxxTajtHvYCIFikEo/NymkBdKToqG2g6ONxEeJ1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/vfAdRas7qiGti1Fexru5fvV/Idq0+dbq4JCOS/Ykjk=;
 b=OuQuM48L5M4Bin3b5hbeUpmL3c0Y99dMrgwYSzub+QTZo7bOeJO3Ob7IwVYWApu3xsp0lwK8VtxmDujpbq1b+btECoFzVHhZXBYZjWMpQQKiaE8+6G6/cogFHMAHYvpyCixCPFUNgnuW1LpUjPnYcQ6Osn04CaU/xp8fSO2XRbHkp30A9ZO7CSzanewd02mzPv3Q4zqaYlHV4PvxStrSsIUnxCt0cWVuB7j0ZPYkYIeaKeJQ5qh8wxMzEfIMagYNvW+bi++GLLfAwN3uJwUEq5NTVhsWKC/2cUcTzhgqXiK3ox2U84YUGpwRRgG8g2nE6lzuZ3cDOwWlpqnYYM0BbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/vfAdRas7qiGti1Fexru5fvV/Idq0+dbq4JCOS/Ykjk=;
 b=kqUDzxxpSyyOXzxQ9fmdAKijO1kEkra3OHwT+/8PZBxgdEb8QTGlyISAeL2AGeN5a80SKzOzSdNIVh8cSE+vjTz2JAiUVZNx5l871dlzyhNgVaFtHyGE/QXqhS4idDqbQos7yrDqoPrUhiCmZJjtCwJtna7Z9fI1p0LuxigOroo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com (2603:10a6:20b:409::7)
 by AM7PR04MB7014.eurprd04.prod.outlook.com (2603:10a6:20b:121::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.32; Fri, 8 Sep
 2023 06:09:49 +0000
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::e109:7026:7d76:5617]) by AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::e109:7026:7d76:5617%6]) with mapi id 15.20.6745.034; Fri, 8 Sep 2023
 06:09:48 +0000
Message-ID: <cbb3cca4-6376-a7b5-d10e-4e2d721ce667@oss.nxp.com>
Date:   Fri, 8 Sep 2023 09:09:46 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [RFC net-next v3 6/6] net: phy: nxp-c45-tja11xx: implement
 mdo_insert_tx_tag
To:     Simon Horman <horms@kernel.org>
Cc:     andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, richardcochran@gmail.com, sd@queasysnail.net,
        sebastian.tobuschat@nxp.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230906160134.311993-1-radu-nicolae.pirea@oss.nxp.com>
 <20230906160134.311993-7-radu-nicolae.pirea@oss.nxp.com>
 <20230907150416.GE434333@kernel.org>
Content-Language: en-US
From:   "Radu Pirea (OSS)" <radu-nicolae.pirea@oss.nxp.com>
In-Reply-To: <20230907150416.GE434333@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P195CA0019.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d6::6) To AM9PR04MB8954.eurprd04.prod.outlook.com
 (2603:10a6:20b:409::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8954:EE_|AM7PR04MB7014:EE_
X-MS-Office365-Filtering-Correlation-Id: 88e3c05a-31cc-4927-3365-08dbb03234fa
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: g46QnvNo6WO+EdZ2X21H3Sveu6EnJgTHa9NctoBS7dYTXTsvMu9/fbnr7sxAn7irgkzXyFN4ToFz/gqBOiL9hdTvS2fCkSaW2Bk+psByMFGJfyGkZChyJxv3BztBxwPg/t3FgTPdazMNX3LXVrxXcZR37OgxLogn1kNcFjpx8IEIXBr83C0CAU343OphrFbu8KVYbJ21NdmRCA5N2ScYC0dUA2Um6cYsrIRUqGESm9zFJioTNWs/lEQjr06415oDANGqU0WJJQr75vbXjh+YjC3IOF9onuBVcDTZ+BeuCTdMYJm2zXUnML4eqMSJHXK/eVoOzMYOw+1OPjbV7fZO1BXWDgsTvymFLn/IXeh2i/qs/JSjToTIcZE79O0Uzoa8eDLOE7nk9ECELa4VyY1J/rh97S3xr2uwNrlG974Xe7XwgNWq/Wxm9pZs/Qnoxh0k+gOF6WkXYAeK/Wr7smLR+Ru9Us9QcelEwjDmrTlZE2j7ix39lPED/4ZeNPF2NiLFwnEWQDTUZF11tpdUBMPFtZLsncfyBTvCBXOYpp7mn8IjVwRG9fdyaBTglP4vGwIZh1k+Mxgo3hIoTGibhfZdhrAvAuP7DF/YuLk+CX4fAYzM/nqqSsBQLlsQiTTdmw8WrRMKTWf9rGJTO0HMS66MuQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8954.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(39860400002)(376002)(346002)(396003)(1800799009)(186009)(451199024)(31696002)(8936002)(66476007)(66556008)(478600001)(2616005)(26005)(8676002)(6512007)(4744005)(316002)(6506007)(66946007)(6486002)(2906002)(6916009)(5660300002)(38100700002)(53546011)(86362001)(41300700001)(7416002)(31686004)(4326008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?elR2amlLdnVWNzVITkVFZWJvUVM2Sm92ZUd1S3hWaFNMcVRXR1JaRlBqTXRK?=
 =?utf-8?B?a3F5VjQ2MUVIbG5LRVZaNEN4U0Vjby9BK0pCTmFtdk5YcXlkeEROb21sM3pJ?=
 =?utf-8?B?SXVicGNCMm9VNW93TEM4a0Fua2xROWNwWVNsVm5FaDRNNHlNWDdyYnl1b0tH?=
 =?utf-8?B?NU1VdytURmNpbWJhQlozRXN5WTZPRFhyenJVSU5OZXdTVzUzNFNGNzFQUTFS?=
 =?utf-8?B?QmpQK1o4dXExWm14dmNaWUg3TVZwUmF0T0QzVTkrNXpGMTJzWElKdmpndXlD?=
 =?utf-8?B?SlBpUldmekdrU1d1ZHZnUjVya0FNWnRtdWFKOVdVckM1Qkx6TEc1TlNzdS9N?=
 =?utf-8?B?VU01L2NqQUtuVVVETEhPN2p4NzFtYWliTmZlQ294M3pBS3E3QWJ6M1lOcE5W?=
 =?utf-8?B?OElkLzIwNmtYdFN1YTRGekFnSTZPMWtpRE5mTitzaVJhenc3N3F5Y0pERzMz?=
 =?utf-8?B?L0toNkt2Sm05dFF2dXo1enQzcjNFRDV4REVDcjllMHg4dUtlYjZ1dHBENUtj?=
 =?utf-8?B?TnZTRXlSYWZiYTd0bmxFYUd2eWhCYjdQeWRSbXZvR2pINWxHUHBqS3UxSThk?=
 =?utf-8?B?UC83eU9wTW8yalhiUkhMS3A0dUpoeE1QNHovRXpPeEJGcnBOSmFUZEtFQ1lR?=
 =?utf-8?B?em1obHNYMk01Nk9PMnk4SUdpYVpZdm1INUZFWHc5Q1NhYkFXSzNCdzNPK1h3?=
 =?utf-8?B?NDkzSU9pQm1wNmtCZ0RZWXk4S3RTRHJHNWxEUWhaU0tlcU00c3NZTElqTFFz?=
 =?utf-8?B?czRTakJRUzBaL3RWcG85ZGFKc0llV2VEeHIvWDYzaHd1ZGdOT0JaejhtMzI4?=
 =?utf-8?B?YUxhbUc1R2JVUEJVc29TQ0RzSXVGODByZXVrUGllNCtPdWVBV0FQL090My9D?=
 =?utf-8?B?OXNWcWd3ODRqbGlzaGdxWGhhcnI4SVBGOVdQbzFkV1RGa2czNDNyTUtzVFpV?=
 =?utf-8?B?RzJ4eXNyUDE0dWtCNjJUVjhrWFJZVVdHaGVaTnpaK3pvc2ZPZmlPZmVxNDB4?=
 =?utf-8?B?b0h1OVAwQ2l0dXVPZVBSQ0ZYMGE5L3h1WHFoZnR6ZUFHWHJRQ3NSdUw2aVhI?=
 =?utf-8?B?dmJyM1FiSW91RGZkVFNEakpGSW9UR29jSVBzWkRqbkVWWjdTeUNqZXhkb2t6?=
 =?utf-8?B?SjF2Q2tISE0zRFkwVElTQXFsT1NNR09yb0NQcVQySXUvdDNaT09oYk96SVM4?=
 =?utf-8?B?aFd1anFGSTRKTWRwMWVpTUt2ZzBxWXFpOG9qVVJjV0dxNzNxMklWaE5Uem1z?=
 =?utf-8?B?aTh1STdkRjFnb2wzMFNSRkJsdnZMWWNORGNiQUdOQmRjK0ZqOGthaGM2eTRT?=
 =?utf-8?B?WG5ZOHFmRUF2c1EveitxOGs1VHJicFFTTmcwbjROWVExdmdFUkhvN0UyYjBI?=
 =?utf-8?B?a1pucHpCSEhlbU5iTWU4K1l5VGVZbDJwZ3BWQzJ6bWlweldrUWRyTVRkWHY5?=
 =?utf-8?B?SGpIWFpUVXBJZ0txaVFEemU2M0NxaWYxNVBWakN6NkUxRmVNYzg3eEtXQmFY?=
 =?utf-8?B?anluZWwxd2V4aFVqYmpKNGprREROaWpqYXloZUtHcTYrdTUrc1E3bW9xbit6?=
 =?utf-8?B?Y2lPTmZPRG04TEJ0VE0wRStmd2JMQjlLTkxXK2NyaysyMDh3cEJUUVduV2pO?=
 =?utf-8?B?Sms4empzbWwwVnhFU2ltc0o5TVRuQlJSOFN4aWhFcTVxVEZhUHhQVHo1WHVW?=
 =?utf-8?B?Rm9OaDJKYlZkN1VhUXVIVTl2MEhJbFNqcVBYVGs0OUc0dkYxMGd1b2t6Vkpa?=
 =?utf-8?B?MGRSc3hTOHgyK0Z0WS93TUh3SVhKOEZmV3h3M1RhUDN4dFJYUTNMQmJ0cC9t?=
 =?utf-8?B?YTlIeXBRWVVPdUs2SHl6T1hmYWVWenUxWnhTaktTUE5aNytyUzRIaHRCMlVm?=
 =?utf-8?B?SzFiZWVvbjlHTFJ4cFFNVmhFaGFLTWF6VUVFZHVUb29HTXJuSXljblZBYmpJ?=
 =?utf-8?B?U282S3JJK0RUOStEZENhZ29uWVliKzMzYTZ6TUwzZVc0Z2ZkVGFOTGJNTDRK?=
 =?utf-8?B?MDdTbER1RjBEdUhTOFRVWjU5RzVjdXlrUmp0SzdFYm5aTFhoWlpqc0F1aVV5?=
 =?utf-8?B?SEdoaWt6eStQMlk3dEFGQU9RN1JPSlN0QnkrMWtpSkhwUnpEVWNlQ0Q3bGFO?=
 =?utf-8?B?UjV6ZncxMWVSN2o5cFBJNm1QMWg0NGFicXhSMHg5SnVCQldPMW9MVlFudjdh?=
 =?utf-8?B?Nmc9PQ==?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88e3c05a-31cc-4927-3365-08dbb03234fa
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8954.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2023 06:09:48.9000
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WEypC2oq3tkZtL0zD1aUCyUtbAN4CTQ2L9/MB67Bmm/CHCC224e6Rklj6B20vB4phuZJNZMJdwhE1S9BR9Rfvt3DBzcfipcRR+5bLMC5flc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7014
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 07.09.2023 18:04, Simon Horman wrote:
> On Wed, Sep 06, 2023 at 07:01:34PM +0300, Radu Pirea (NXP OSS) wrote:
> 
> Hi Radu,
> 
> I hate to be the bearer of bad news, but
> I don't think we can accept new module parameters in Networking code.

No problem. I should have removed the parameter, but I missed the CI 
error from RFC v2.

-- 
Radu P.
