Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 095047E692C
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 12:08:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232053AbjKILIa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 06:08:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231270AbjKILI2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 06:08:28 -0500
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2041.outbound.protection.outlook.com [40.107.8.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38F87273F;
        Thu,  9 Nov 2023 03:08:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MNS1XpxwE4pLFI46Dj88xySfVYl7gt2z74j9XbWJ0LMxCTG9QSXRRHiXI6bVuiYrGO9imhd8wJ9s1kQBMPpBGLWGBeo1tm8m7az3lYQVOXiT+tam6ASl2O4tat9OWFMHdbKvVkPmTNIDC45nS3lSoORY424tbWaGEMXJXa+iHQbrqB19cVYLa0ovrZcOiZCRu2X6sGlFnTtSAtCuqMzb39YjcGm1lsz5mWASzv2zjp09SAyzF7wx7EGW7IWVz97DF0fQJi64rca0Q8zqh7K0zXF6OLNLF0AZQd7yXkcEI0Vdetgy6C2HF1aIQOnUPedvkW8oZ7suzKxPSaJxBk7bOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S22PyeNf5ZQzC7NT8yLbH+T50xlzuLZbHRpbC0e0VC0=;
 b=a/Q17dVnlkupnMinYdU8hzfjphj9iSLRDloU8SnuDlclDlloIVLeCE87TUmPuQc7IcrnaLOhpgMHQdfQCUTmZw5oov7eGm6nGYIJ7HUB1SnZ0oTT/zHAaf76blrQeFXU6QXI7Yl6kzDu/33o7pG64NmlZlWHJ3QJvtVVwB1GDlC4mfmOINBGPIaFOxD6nC0P4BCSpFXjHEfWzc2M+rLD8X5WGODiRFt2hg8MTOkzhW3U4vsNjHKGasUfsxv5zHeHcD6t3Bz7pHKyFGXftYduzSN8OueKw5+EM9kPqIDc37S2CF6R+147sZh+pUHbo98pPHG/CrBIDr1otCFq7TFrNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S22PyeNf5ZQzC7NT8yLbH+T50xlzuLZbHRpbC0e0VC0=;
 b=fpK1kmIK96Xr6daGsMny/mp2ZWvACT0uRtoIw01fxgazHC3hxbGRiF6LdmsSx+bgaN5S4mqRdAQ9gBSu66Le4kdLSBSxSkVVlr37evpn+yl2hERcCYLVAKpmP4U2yNo9h+0aDse7He4dArv1grqAaF/umYKr5X1AXdW/RVuDMgyKScyemyberd+dc7iNnl5ltLt4c+L+NkxXXbpLItJVJDqqbcq+2PAzbW/xHlDutowtxTEUnf+P7jlw+pQF5hdx43jy8clzYonBgCOf4EECN2gVU1LlHWY4TERv6iAc65NU8HgR9ZB8xgNpOAPvi8WqqjGe4Dtg0OwJ7/ZHD4AlOQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB4PR10MB6287.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:381::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.19; Thu, 9 Nov
 2023 11:08:23 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::96c7:d239:1723:8761]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::96c7:d239:1723:8761%4]) with mapi id 15.20.6977.018; Thu, 9 Nov 2023
 11:08:23 +0000
Message-ID: <502a27b6-e555-42d2-bb0f-964a58f81dbe@siemens.com>
Date:   Thu, 9 Nov 2023 12:08:21 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3] net: ti: icssg-prueth: Add missing icss_iep_put to
 error path
Content-Language: en-US
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        MD Danish Anwar <danishanwar@ti.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Lopes Ivo, Diogo Miguel (T CED IFD-PT)" <diogo.ivo@siemens.com>,
        Nishanth Menon <nm@ti.com>,
        "Su, Bao Cheng (RC-CN DF FA R&D)" <baocheng.su@siemens.com>,
        Wojciech Drewek <wojciech.drewek@intel.com>,
        Roger Quadros <rogerq@kernel.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>
References: <b2857e2c-cacf-4077-8e15-308dce8ccb0b@siemens.com>
 <20231107183256.2d19981b@kernel.org>
From:   Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20231107183256.2d19981b@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0095.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9b::17) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB4PR10MB6287:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e0b9d16-9806-43d0-e932-08dbe1143079
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Is1G3R2+v7c2Og7UOc3oRxyM6U+hQwHLPgBHPw9Reabuha5CTeS4hwLj4Jj+0ea5W9Q4luJq6Dl+ZuTGJZfMLc3QTGTIde+IASfFyPgjc+jBcSxM6Aqi7w1e2mtqYnl3iJwF1lV64Bd+/ipJDihW4cWXoas+GaBqSlOfTWA8zJtJVuf7HH82LKjprO6pQCq+H0MUgcgZJCboNIij/pwRbBtGWp6cJdY3HwXevXHCiY1/6McRc0dU75xNrQJooNePe6AxdZBkr64eS2NZkODSodtciBc2pKT+LqADG6qS1bIfAN+h6EncTRng2lYduGu1zEOQ1m9n03NwEbnQX1DcvP4vpTV1q5qYkY+H0aSHQiC46e3lhzV/p58uRQMlxMDNQ75iR7onWorV8S2v0L0JO2DLA3h42qPK5dkZfO0zcA2IxDYc2dh2Zor4Q/yxSBJDXyNVli5wmSdvgs+ssbbMPr70Ocd+g31cSu+NC7pmrJicd7HetFkEfX/uidpYW2f1+qugyGPLCHCoVnidGpjptY9Ggs8WtqfPWWJcjCaf8pJ1DdHIJOP0F8pcb4FrNNi0CQEhFeNnzCpx+ei42i9BVoEqpJrixarYG3gqNvGRsj6QfVwUvvBM2hOPWPPZ/46oVtDncjvLJmIBB8o1tekpKw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(136003)(376002)(346002)(39860400002)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(26005)(53546011)(6506007)(2616005)(6512007)(83380400001)(7416002)(44832011)(41300700001)(8676002)(5660300002)(4326008)(8936002)(2906002)(4744005)(6486002)(478600001)(316002)(66946007)(66556008)(66476007)(54906003)(82960400001)(36756003)(86362001)(31696002)(38100700002)(6916009)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WWJ4Y2dPOUhwYm81TTRwZGd1cGc0dXV3SEhzQ3FUSGhIYk01enFQVmxTYmZF?=
 =?utf-8?B?SlVJKzdYbGhnSzVrWlBTWFUwNU5KUXZPYmoxVnIyT0VzUHdVWkZKL2E5d2tC?=
 =?utf-8?B?eWxjUGgrcTdUTzBVY0JhemMvaVBTZWtJSGpoSzJMQ2JVdG9veUxlVDRxUkdQ?=
 =?utf-8?B?c0FJQ0dOOE9mbGlNbkdacEQ2VWp2TjlCMVBkZVNPSi9GZm5zdEowM0JIbHZM?=
 =?utf-8?B?R205NXdpbzRHOGc5YTR0bGI5MWVhNUgyVW56OGhqZ3RDdGFnc2ZydTBhOWEv?=
 =?utf-8?B?ek1UMHpzQnlDSE4xcVhYOG5kNmtPQ3dVSGVYLyt3cDg5TUsrTlVyellLcDFK?=
 =?utf-8?B?djdJU20wZFk0Qk1pVWpNUHZoU2prdFRPbStrZDIrRHMyNllRREhPNUlnam9T?=
 =?utf-8?B?MlBtaForMU1IVGNwZGhURnJkQ2VyVDlTNllGbmxYSk9KNlFiNHdVQmVuWVh2?=
 =?utf-8?B?WG1nRFpkcjdKTUxkOGxNYmZDYVdOUGRpQzFkM0ZYYnBGSmRMQmVXMktnOHNX?=
 =?utf-8?B?ejQyV2c5anQ3d25qcGI2T3ZTdE9DUS85V0VxT0FKU0dDcmorN3FNa0lmVW9z?=
 =?utf-8?B?UU5yRVRNWldOR2E3RWdMOGNuQ05VanE3dDJJY3YrSEZZaUtkUmNBUGtWMVkw?=
 =?utf-8?B?b2VZM0pKUW8yTFNTOE0yclZSWkdZM2IvL2xTdjg1RHBDRTZKREo5cUtqanhk?=
 =?utf-8?B?eHBWdnFUZ2NSODBBRHpYRER1VWpmYWVpVE9FWXkzS1lzSDROWGdRSktPZkJ4?=
 =?utf-8?B?OGt0akZiRHFGT0ZaMDdFY1padmgwUzhwOC8rTURwaUFTM2dlSG96cFM0VHU0?=
 =?utf-8?B?K2VXenFueGl4M3VHVEdkSEROdTZFQTVkL1VCNzJEdlgvTVJyNlZVekQ1NlZM?=
 =?utf-8?B?RVp4cnNzTHhNNEhSdnY0ckFUbVJpRDJta3gySlJ2Q1RaSC9TUlVCM01BU3VU?=
 =?utf-8?B?OFRteWlGOG0wVFBGR3haa08wZVo4ZytKT000K3pTN3hLYytUL3RPbE1USnhZ?=
 =?utf-8?B?TFEwOTJ3d2FWQ2Y2WGp0ak02MWFBa3RvNm5YQ085VURVWlJIK3pzZ2phNXZi?=
 =?utf-8?B?WFYzdWk4SVdNZjYxcjNxWXU5a1MvWDl3YU1MM01oTDF3K1ZtY0NvUEN6aU5r?=
 =?utf-8?B?dGJjaDYxVDk4SVRSdFJhTnp5cDRaZ1V6a1g4SHVLYk54NnZUd0dldUtzRmRZ?=
 =?utf-8?B?VGh4SzZhZ3M0WC8zL2xBZUVSd0I5cjZOUzkwNXFIYVE3Rmg1aUVneVBMUU1k?=
 =?utf-8?B?aVUzQlM0aTJhdzVsR2ZXQklPOEZQVlJMc0Zpdjdaa3lZWG1mekVHYU1NK1N3?=
 =?utf-8?B?aVFNWUVnelNWWEFNT01lTUJBSjl1UWZYbzI2RjE5SVR2V3lSNCtvSVNxOEht?=
 =?utf-8?B?cEQvMUFUOGRJb05QTmlOaEE0TmpVYVpJemNuY1hDUzM5OEtYb1ZEQlpWM0Qw?=
 =?utf-8?B?ZFFVL2pxdFh6NkxlbGxvbklmMUo2c3NsTktUNFlNNHB2UC9aU05CRTc5dkti?=
 =?utf-8?B?QVVQMG1pSXRUMkMweHZDMk42Wk1Ya29GVkJnWFo5UWZmZUNnaEl6ek9aSUNF?=
 =?utf-8?B?OVZ6NHBLdHMzUm53UkRVdTVTa2NqdStBeUw3bXFTQnhpUGdPRU1ja3hnVWhQ?=
 =?utf-8?B?QU8zd1I5WUlOOUNkZzRONHNaMjZrMU1tRHg0Z3lLN3JZYUM4aFZ4U0FZTXFw?=
 =?utf-8?B?S1ZibC8rdzBlL3Q5MkpOdEt3cVIzQVZDaXkxZ2NhUkpaRXd1VDNMekMrbDc1?=
 =?utf-8?B?bENRdkhDWkxWRktDemJnQjNLanRSNzNIcmliTlovSjcwTWRSek1zaEoyNTNm?=
 =?utf-8?B?ZTM1SVhhbnZRdU00SDFHMkJlUTlYSTY3VjhxQVRubEdKOHdVeGhZenExRExX?=
 =?utf-8?B?ZGVaNm5HTUs0eE0wWnpBYTlIeWd0ZGQwbUc2RWorLzMrL0pGMzllUFlIWEg3?=
 =?utf-8?B?VTFPMjZVbUtBdkZRc0pGeEEwciswdjJ4N1FacUNMMHkxUC9TUUlhYXN4bnZJ?=
 =?utf-8?B?WExNSjJwTitnZ3dVQUs1djl1WlZ3Z0l5UTlhNjdhMnJDVm9RUCtFT2t0M0wy?=
 =?utf-8?B?TERhUGF4NUxsQ0JsTkR5US96a3g3UW4zT2MvREZPWFlyQnNLdzFpdzlGTnZt?=
 =?utf-8?Q?WAwLWk0Rk8i0VBN3mHtkSzea9?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e0b9d16-9806-43d0-e932-08dbe1143079
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2023 11:08:23.3019
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fDwCw+kZb4DDtKV5500gX+j7QV4WlIgEQMW5WqXuCk5Gd8I51QpMH+cE2XntOmibyarhfEy2xlpD8WIR+81/Fg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR10MB6287
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08.11.23 03:32, Jakub Kicinski wrote:
> On Mon, 6 Nov 2023 12:47:42 +0100 Jan Kiszka wrote:
>> Analogously to prueth_remove, just also taking care for NULL'ing the
>> iep pointers.
>>
>> Fixes: 186734c15886 ("net: ti: icssg-prueth: add packet timestamping and ptp support")
>> Fixes: 443a2367ba3c ("net: ti: icssg-prueth: am65x SR2.0 add 10M full duplex support")
> 
> Is there a reason you're not CCing authors of these changes?
> Please make sure you run get_maintainer on the patch, and CC
> folks appropriately.

I was only interacting (directly) with Danish in the past years on this
driver, and he also upstreamed it. So I assumed "ownership" moved on.
Adding both, Roger with updated email (where get_maintainer does not help).

Jan

-- 
Siemens AG, Technology
Linux Expert Center

