Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85FE57DA8BE
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Oct 2023 20:52:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229454AbjJ1SwT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Oct 2023 14:52:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjJ1SwQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Oct 2023 14:52:16 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89597ED;
        Sat, 28 Oct 2023 11:52:14 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39SIplOc022763;
        Sat, 28 Oct 2023 18:51:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=AIBuF5R35nydW31qoIZkSlUrG3Fgj1StioZkA4q80KE=;
 b=gyT2QwIN+hBJGTBtu010dFPLSM26/3nO3M1KG4HjHKrVaLsrrOGHFkiv5D6y/yk5XfgN
 qbZGBpLkoyn/br9D99hREeW2CktGmGUUVO6ZJMcmEOt0X8nnvQw66+aVYqTIKlBe07Kb
 toC/F8MlBCzyf//qIkyCW74Y8aQJG1IK7nnuUD9jQIoWActdCDdDo0CpnnGhMMPb7OYC
 zm2a0febqMg/KleOhjxSFuesrQWyFT++8beeD2BAeLyL3TxfB3feyoMpeLK+3mL2R523
 rVRDBcnvcC33clTsiPA2GcyP0Ljdn+wR+852XJltmohYcDsPIdBSopqquIkhGoSgg3T3 8w== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u0rw20p44-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 28 Oct 2023 18:51:46 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39SGedfQ030596;
        Sat, 28 Oct 2023 18:51:45 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3u0rr90ycu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 28 Oct 2023 18:51:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J4E296uWI48TMlBeXsyb1yBCKCZ/aOuK3Bv/zhnUMOj14vIy7c9pdiI+bSFPFdUfD5hwhPUmEedyQ1GaourkhoZDmXh50z4WdGdL6zB1EslfJpkkWQtQoML0DVeNK597CYOhXN9M4E5/rF0sU8nnP5FL03dtvaF5I2AbkRMAQQqGYXLt3NSmKMRcrmztROC2wGhQQpoE6kQ6w8B2pD3vmzdSvA48ARgoZGWT3nzI7VXj4JXbQF1dMuBP/CrkNRLC5w9XryeoSGajzkOCAgmkr+G97cvwDfDJH6fQVzgqEuzJ1awJ0oaLnibG3h7RTOCjeGfSMzZjrDPBXPJe7uSQPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AIBuF5R35nydW31qoIZkSlUrG3Fgj1StioZkA4q80KE=;
 b=EGJk7NiW33IjrDFQ8Cvdo6lq4nuN8Xj8SgYriwR9H2jZxm0yZ8i0V/Qdx+3DqMN88TxlNjGFqJ8FZXDDUsaCd5ly/znEmWuOztf2S2I+3gZuqswFPIanPzHxPCut66EsSl249dCsQeeOyIMrnZNtMZ75x/sVfFqBKRjsqm2TsgrA+8NyQQ4dZsnewXeZ6n4+LvOgFY91VIz7DMe43fcl8jWKqbBVSM+nQA3ybHSfPBp14plG2j2S9tb1Lj5aYMtOupo3gG9dAAjuN3kh/70MHikxB5NotdPVt63zGJTjUbWsiNUqbaaYLmc2mVDc+xtzN7AG8Ohtr6xrZ1cgFC1Siw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AIBuF5R35nydW31qoIZkSlUrG3Fgj1StioZkA4q80KE=;
 b=RKs/PGmiOqDuaG+AHHOvw5hrBl1GIJQ1xPEESsViHjcX35TBPopAp16/me/MqPx3lCYEmCBAO1GIWAFXEPN+hSS++fY8yPcX+Epgnj3M0STACDTdR6w4ZoV/rjuywv9dU37f0F8HDVZpD4fnSVt0iWfcEB0yJFVcFszcaQuTJ1M=
Received: from PH0PR10MB5433.namprd10.prod.outlook.com (2603:10b6:510:e0::9)
 by DM4PR10MB7505.namprd10.prod.outlook.com (2603:10b6:8:18a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.19; Sat, 28 Oct
 2023 18:51:42 +0000
Received: from PH0PR10MB5433.namprd10.prod.outlook.com
 ([fe80::a39e:b72:a65a:a518]) by PH0PR10MB5433.namprd10.prod.outlook.com
 ([fe80::a39e:b72:a65a:a518%4]) with mapi id 15.20.6933.024; Sat, 28 Oct 2023
 18:51:42 +0000
Message-ID: <bc41e32e-e899-427c-9aea-eba411e5bcef@oracle.com>
Date:   Sat, 28 Oct 2023 20:51:36 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs: translations: add translations links when they
 exist
Content-Language: en-US
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org,
        Federico Vaga <federico.vaga@vaga.pv.it>,
        Akira Yokosawa <akiyks@gmail.com>,
        Carlos Bilbao <carlos.bilbao@amd.com>,
        Alex Shi <alexs@kernel.org>,
        Yanteng Si <siyanteng@loongson.cn>,
        Hu Haowen <src.res.211@gmail.com>, linux-kernel@vger.kernel.org
References: <20231028162931.261843-1-vegard.nossum@oracle.com>
From:   Vegard Nossum <vegard.nossum@oracle.com>
Autocrypt: addr=vegard.nossum@oracle.com; keydata=
 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 8A==
In-Reply-To: <20231028162931.261843-1-vegard.nossum@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PA7P264CA0186.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:376::8) To PH0PR10MB5433.namprd10.prod.outlook.com
 (2603:10b6:510:e0::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5433:EE_|DM4PR10MB7505:EE_
X-MS-Office365-Filtering-Correlation-Id: 91e4685a-df2c-48a9-2b7d-08dbd7e6ecc7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NKL9vtJHN7yPd/OvuMlRWMpa2W9hAAUZlkbxoFo3p8gulrlNA8UU2nF9Aycf2ucO3tHU0r0wBL3AuIk0rAoGlKdgWcv/h9heU6ta9eC+YM9me7uOlRNA6Vi+UVeyl3TREQoHod7URGj2QgbAuiLlOa4e2MyQM9b4CaJVmIIdpVy0Cn60OApcawTy5V0ZanJ3K9TeVYn4lprpJNXNmuDO4t8rTKyoaOcUfv9qCxFuhRU4s4rqVkXVi+wdxaBiwKCFG1iqtrv2G6aCcVv+40YZAA1+8t5UvOeyC1GCp5Yvax8KqTQBzKrD0MDe3pWc0sjowaDDAJcf72PSO82dbJ7TnLXDNWEdDlAL3/s/y6OLQD7wyXo6IVVYsHpxWFZtGdGGTtlOKkuttCDEE5PWXQTMSxJ+gu8Ra2MofyEInQst7GfJr4iiLAp9ZuVg6RoQodVUxqZjXbOnNlIHTlU+YTNhy8vKtWNNQSeMrGeBisZQ0bm6LPLU8530B28I4KoscAgSnia+GZcxiiNarQIHJHdMJqq43zC/o37jQ673bEMS1mjUWpC1W9jeonevkjkDrLgle0lLtKPkmz+j6yh2TfT68sMHm9B/hh1yQdcpfPNVEhmIkEzKvXlDz+Uk52/hkrB66lSphABeSyhHYU8JMN8enA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5433.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(396003)(39860400002)(376002)(136003)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(2906002)(31686004)(6916009)(316002)(4744005)(5660300002)(44832011)(66556008)(26005)(4326008)(41300700001)(8936002)(8676002)(38100700002)(6512007)(66476007)(53546011)(6666004)(31696002)(36756003)(66946007)(2616005)(478600001)(6506007)(54906003)(6486002)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OWhEMFNxMENnN3kwU3IvSDErVktuYithVlovM29wSlA2VHVQZnA3VXIrUGFu?=
 =?utf-8?B?TzdBbk9aQXZvOFJYYlpEbWk5N2oyRnh3RkhWZlQzMGp0bmhkczVrS0hyK3Zr?=
 =?utf-8?B?ZFZQN0RDcDV4emVCMmpHS2diNDg3cEZOWHVNbUpHR2NRS0dQMEFHSEt3bUZj?=
 =?utf-8?B?eGo4Z3ZrK2dVazg4aVRIc1lOSzIyWUl4bGhIbXZZVmtsdnF1K2cyU3hUd1dE?=
 =?utf-8?B?ZEFib2FnQ0UxSDZmbUY0NDdJSEdKV3JxSk5BM3UreEs3S2NJVWZvTCtyZmdp?=
 =?utf-8?B?SFl6d3dlWDB0NGZUTW5rTzNrUktweE54WmE0MVlyUTRGb0R6SDdCSUo5Rllt?=
 =?utf-8?B?NGVCcmx6RGprSkxwYUpuYk1UTjdmcGQ2dWg0TWxvcGFFakptNVZ6c2RnckxU?=
 =?utf-8?B?MzlnOVdDYVA5Y2wvT3pGVTVuZGg2cDJlRTV2MWc4UDhKeEtDWUhreGxxM0g4?=
 =?utf-8?B?MWtTek9ZQnJCTU00UDNnNE5DRkRPcTJuZDI4TS85dUFqT1FlZkp2ZnpuQ3NO?=
 =?utf-8?B?dEFUSVNzZGxxaXh1N1VLVFRpVjNBdnAraEhKdFNUTHd2LzFUaW54akZDMjU5?=
 =?utf-8?B?cHk0TFdlUW9jV2pjdWNIZ1BaY2tYMFU5ZWtGdXdPbmc5YTd5anp3YjlTTjFR?=
 =?utf-8?B?bitvRmVXK05xWis0U0dtZk82am9FNURzQ1J3Y1QvQTFNN2xLMDFQWHkxbmpC?=
 =?utf-8?B?OEpzZGVLcGZBb2RqY0NsaVZyVGJjZXk5NkFQa3JmeC91TmhCSmpVT0lFaXNr?=
 =?utf-8?B?MERCSGt0M2xlUlVBT0xxd3lQcXBVOG04T3ZxQmI0T01IZWZYQkN0STI1QUkr?=
 =?utf-8?B?SVZia1FqOGp6d2dxNW1sQU5JUW5tVmFsTk9MVG4ycTR1UEcwSzJoaHgyU2pt?=
 =?utf-8?B?b0lhVVVoL3JKWE5zZHdMTndpN3pCRFQyR3BYS3VmYVh6VGREcTBlTldiYU1y?=
 =?utf-8?B?ZTJSdUN6ZEpMdUhvNmY2VHNoVFlXcTRjUUk2bklVU2RHK3YxNDZmU3VtRmJj?=
 =?utf-8?B?SDVWVzFkY3JrNWpDS0dKdGlMenFGRmxLREtubTRHRlc0ZHdPZWpTSFA5a3py?=
 =?utf-8?B?S0h2RkZrcWVkOXBrZFQrcUZubGdBMnZ2cFozMjNDRkZubGppRHNwK21DeWp0?=
 =?utf-8?B?SG95ZlpmZDIxanVGOHkwYkFWMFE3UW0xSEFLNkpBcXkybkFqeW1OeVB6czZr?=
 =?utf-8?B?cHUwSDU4eEU5cnFEK0ptN0lpdjJ4blVsWGNvOTJKK1JjR3B0QW9kYyswT0lC?=
 =?utf-8?B?REVPbXk2TGhRdlEzU2M1c1VrYy8rM3FRMlpJelNEbGcwREVLL3Q3Tm0wdmdT?=
 =?utf-8?B?d2xoampUNWpFb1QxTHVVUFlnZUNxN3AydnZvS3BGSmNma1BaOVFvSUZPMUdY?=
 =?utf-8?B?Q1kwWUpiclgwMEorTW5iYkpudVNVSHZ2Z3VOWkZIV2dxNUppaHZYaTJreXBo?=
 =?utf-8?B?U1BETkt0K1JOOVI3MExrZHJPUXRHSFRUdStsd1pSSzJxVXhzdjFjRmREWEl1?=
 =?utf-8?B?eWZSazE2WXdBK2J0RXB4MUxIUTJYbGxNU1BMOHJBRVZybFlIUVNPTHdjN3lG?=
 =?utf-8?B?d2YrdTByalNJMjQ3T0ptNzhubnNrVFFuK3U0TFVWS0RnbzVIZHd3ZS8wUzdw?=
 =?utf-8?B?Zy9FU01obUdEVmkzZWNjbGlwOEpRaG1mVHVLWXRRZjY2YTJ3amc5eXhvWVZU?=
 =?utf-8?B?aEJ5YlYyTzVpSUVZZGV1eUxpVnFoeWMrQm5tZjNRbjVhZmhjV0p6REF0MFhj?=
 =?utf-8?B?dlljaVN3azN6N2lzRlBLbFJmWC9zVjNGZ2dnd04zcVdERHR3VVZ3ZjM1WTJl?=
 =?utf-8?B?KzRBeGZqMVA1bGFKQStEWkJBUEZVUkdrNHpmbkMwK29aTnREbjd4NWYvOWVL?=
 =?utf-8?B?d3N0NWdWMW13b0YvZzlTckxUcHB3amVqQm13RmdEOWM1dTJDY0UramgwUFJO?=
 =?utf-8?B?VTV5cXMyV1V2UW5QSVIrZk9KbGIwV0RrQ2JrSzVPNm00MVJ5WWpHQ1BiU0FE?=
 =?utf-8?B?VDZwNk95RGtvODZnYWtNWFFVa1FXbk9qcFFMUlFrZ1cyZkpSdExxSzhPOWU2?=
 =?utf-8?B?andneElGTmM2OThlZ1NYNHdKS0dRell4Ny9WYWVSMS9FSW1MeC92ZjlPaGpL?=
 =?utf-8?Q?1ZeISVcCg17SV/54Ypl3c77pX?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 1rA5bZoc0r1nOTCKGGmSBm63rezYVPwlzajvG00A5ULcDVSp1lDdSz8/cMw1E19ajfITDzxbSulGjYSNRqTmLfjExVWFwSqb4rGfDk/1k3ogCxIlzGVhP54Qo0vNdfSnm/G9dIgGhMy4GyRCucJec7ydNC92idcMO4taNTJzxoKf8NPgQ2csKgKr5vAxUBT2U0K3/OG+6kGijaMrp2esYgzRrwv/gq+vMPZB0GK9Ajo2WLS5voghO3NfbPKiIBosY8EVDFnMucl3eH2ItqZ2kt20EuuPrcICTczqhij+565m7M45CkmBLN6E4te/kcglhCjn0/VsYiyOoA0+9JkJst9VSpwjGoeRsjwBbTexgUtvLuAAOBNKHfg73iweDdgCJwzAjRk2naRWS+wenWsK1ziCNneZIowUm/51cp9qbrrVPHP5OYRQbFBMd2EGlExdxG54WXz0KpzRsdnEmA6/fFDC92dFqsv7Vz7zT6pDsAhB7VfwYoJcmyXEHL8bty60tiMFbb5zkoD4mczc/74C5xcUIHVTRCXdxmMua+BaJAlFqXX6SXzPyCORVDNDfans1lZRS00+wrjdouqihugDeeg7lG0a26SwL4eHZ+q+uZ4yQmOJigeUHpaG0sFNj/bNs428DCBWaIUXTWorZ0hHv6yIlqB9NLfawwNnHYKXFljEGkEeOy4l4Kqnk/EU6Aqq+eXt2wSYKfsqlLA4a8RSvevgVr6feoecGjLZMTYkdyyljd2k0vdXwpqRHTKM1wUs+tACE96NpInoVFWXTjcP3sAg6cVW9Npsw8mW3ZxQUk8WsoOQ6wtl5r2X6OrVgy2yvRSrMbpw6FJ3Zbh6/H8ySrv8iUl0muKV8FBk3eoZohOOlebmfx6DaJRxxDncm+e2OleCY0JfBPxqtLpJ27C8a8zL2pZZiuL4apG4WsDOMco=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91e4685a-df2c-48a9-2b7d-08dbd7e6ecc7
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5433.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2023 18:51:42.0672
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VAPxFksJ3TgpgjIa/mS2n/OSqJIu7nTnKKlEQtwqD8q/0Cx8cvSMp3Hcjz36nPkootdaFyuc3FElvj8oZyMoPZqA6jw/Uoh4Qj/C942nrEQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB7505
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-28_18,2023-10-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 spamscore=0
 phishscore=0 mlxlogscore=825 adultscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310240000
 definitions=main-2310280153
X-Proofpoint-GUID: yJxwwcN6DdSmkVDgQNkhnYJ_gq5nGXdk
X-Proofpoint-ORIG-GUID: yJxwwcN6DdSmkVDgQNkhnYJ_gq5nGXdk
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


This went a bit fast... corrections below.

On 28/10/2023 18:29, Vegard Nossum wrote:
> Add a new Sphinx extension that knows about the translations of kernel
> documentation and can insert links to the translations at the top of
> the document.

[...]

> Testing: make htmldocs with v7.3.0.

*Sphinx v7.3.0.

> +all_languages = {
> +    # English is always first
> +    None: 'English',
> +
> +    # Keep the rest sorted alphabetically
> +    'zh_CN': 'Chinese',
> +    'it_IT': 'Italian',
> +    'ja_JP': 'Japanese',
> +    'ko_KR': 'Korean',
> +    'sp_SP': 'Spanish',
> +    'zh_TW': 'Taiwanese',
> +}

I went with my naive understanding of the language codes without double
checking but I think these might be better names:

'zh_CN': 'Chinese (simplified)'
'zh_TW': 'Chinese (traditional)',

Thoughts?


Vegard
