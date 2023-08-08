Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E0597746E3
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 21:05:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230198AbjHHTFp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 15:05:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230517AbjHHTF0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 15:05:26 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4298826E40;
        Tue,  8 Aug 2023 10:49:54 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 378DAStt023306;
        Tue, 8 Aug 2023 17:49:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=ecUaaaYPiU6X+UaEwOSS3VZ2/DjprpDGlQHjZzy5dpY=;
 b=jOYJMipO/cuTmlHWVWXLOO9lM6FvpmzTm4jutulri7137TVMVRbp1t9qUre544RFaC8F
 MsyDSmFOEeVAdhqZR90IoLYFsLViTrSN4Zgfb9sxXGZWYj+kjHaNAbZzdPVQxySxkxGS
 mYz4UVWwovQ4wBXDNJmqGuY029DScPw93LzYikSDW9xIapKjxuTZ8JejDxRDWw+0zVTM
 rOHo3yfCSp/n2NBJH0zcggH9zWktaijJnOkO6Gs3VdSVTI9QsCGvB1/IWKhZz4TI2uNT
 1tvslaFkPwTd5fdkCCmPY83ysXZpSOHqHkKuCTVsxZ/MvfhOVfkWDez3cMpcW8bRX5Mx nw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s9d12dttq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 08 Aug 2023 17:49:44 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 378Gqg7G022942;
        Tue, 8 Aug 2023 17:49:43 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2175.outbound.protection.outlook.com [104.47.56.175])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3s9cv6cwu6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 08 Aug 2023 17:49:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K0Kf+A3kxAU7Lq58nu6W0u4bRoxE6afD/Ftul4DTyKHId8tiSig6ntgharnbSvDBy8WFY1Jc5zzqMv6GabJFCz3IdPBVRBsX5H77HBin3CwpqDPofpOlzCOaATsbzzYdi4lepOb0bxv3TII9VgRQlOxLVYlEZkokk/Ytmtfl1cKxErtkqQ1l8BQIWIhJzmXZl9jcU0QAJoSKsr7LT5eX5DGkLBgQQSWjlqNHT33e26UJcjBu8RyH/M2Su6txM5BE0B6VvuXJEvGrRyeNtCIGqJDnZxy9qf365btH6IL8jAtrWDdowl78hGKJi1pJXwSCpNZ0prtnSeFnGkg/oY3EiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ecUaaaYPiU6X+UaEwOSS3VZ2/DjprpDGlQHjZzy5dpY=;
 b=m8EPcTDsCn/djM/buJ5e5vCiwcNzbz/t8JVL27fE7nZ8kMIWXLTRkTTDbJO8QST+80NZ2psKncG40y2MCiyWgx5RaZPsg8CEu8WQB95K7lvfI4d6gn4mbH/MWxtY8vS54aHc7b8j9JrA3mPtSZN8TloldG25VzlNYmvRw0XVR6M1L9bpUxcaOmw7BTKWwJoPfGs66IIJQxNpwCXpLWYIfcw9OVauCXvVOdipi0Jx/1lO4jUF8xDNr3kkKOYEExOAsqEy6JSvZ7wo/JUyyUhtvFEpu5aOKzudgWNvK4l4tFA1eduYQbWh3wPZ4aYLiXQhS6ZjfEmDKDnnUMeU3ej4ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ecUaaaYPiU6X+UaEwOSS3VZ2/DjprpDGlQHjZzy5dpY=;
 b=iGacROkwsHPd8C/2zXgHwycbcgz2ODVKTP9cEdI2M+7sZFVYTDRt0ySS6eQbkaqQEn/1/8pmwNROp5ZsJXM8zN/1/yvVySSHjf/7t5U6U+bLPoDf6k6CB7h05p5UWKw5pS3V1FOfNpNA2Dm1WiEXvXbUisKBA9+pM4pDjbs54pM=
Received: from PH8PR10MB6290.namprd10.prod.outlook.com (2603:10b6:510:1c1::7)
 by BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27; Tue, 8 Aug
 2023 17:49:40 +0000
Received: from PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::3ec2:5bfc:fb8e:3ff4]) by PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::3ec2:5bfc:fb8e:3ff4%4]) with mapi id 15.20.6652.026; Tue, 8 Aug 2023
 17:49:40 +0000
Message-ID: <c8cc29b7-834e-195a-36c2-b53be5e17a9b@oracle.com>
Date:   Tue, 8 Aug 2023 23:19:29 +0530
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH next] mmc: sunplus: Fix error handling in
 spmmc_drv_probe()
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Tony Huang <tonyhuang.sunplus@gmail.com>,
        Li-hao Kuo <lhjeff911@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, dan.carpenter@linaro.org,
        kernel-janitors@vger.kernel.org, error27@gmail.com
References: <20230801052321.1328225-1-harshit.m.mogalapalli@oracle.com>
 <CAPDyKFr9inG4dgAUYhrQOEND1Fu1CDajEPoO3W=dBRRXB=kceQ@mail.gmail.com>
Content-Language: en-US
From:   Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
In-Reply-To: <CAPDyKFr9inG4dgAUYhrQOEND1Fu1CDajEPoO3W=dBRRXB=kceQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0045.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::16) To PH8PR10MB6290.namprd10.prod.outlook.com
 (2603:10b6:510:1c1::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR10MB6290:EE_|BY5PR10MB4196:EE_
X-MS-Office365-Filtering-Correlation-Id: 8149a35a-5a5c-4721-9b32-08db9837d709
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8fJLJAKebiWQlYTcpYtp4DE8agZ+/0h7N6f9YQUcD68POIIipds2x0VMA/cmseWZ4dJED0JCN5Jiw6V7LZJ20ElDPUoNpInPKyWh8Qi+VC3fKHfZCBIwkbNfw74oOF95uG/TGvSlpsc3D+CmAMbAeeKRiCnJHXFK1t8NS0j2vhu7q3AiB06sJ5uNW+wERpCa6pc/4wPISC7DE8ly2aqpRhWwXEj39A4FSbYOJBoh1F4ubZvgMsoNk+6vqI8EM7XK5GSB9cUnfxBxMF2mdb8cgF4WgcPUjzHnYlgr2CepimSv4tKF/naugdrw+uVQEIzI8KEyFzAR5gpqMJLdLA3xWboEAGjcuJrbHIIoxkVK79LxIr5e+1eiacQy+pufwD/aIO6JRwu4hUsN9v94NnF5En349VJ16QIlB3MZh6WByYSEdt8UToetkjDvs/AL2ZGmfS3JnFgTUfHzriHXTd0juSYLeZOQz1XIQkAQYFHeeSXx7W1mREcthWspbEz13LAbYmQvPeG6/JfzNYU2wrWK0PI/qsyWdx3RUeKVlVGzx0prGxCDIi+F6gywo45eROFjOTqWHwHnG6xP/DkltZugvttB3OF+1CjRMgYIE7II6ghsW0b0mhB2KujWex/N+QNTzFCXODL9Fe8Pmdf/yK7Gbw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR10MB6290.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(346002)(39860400002)(136003)(396003)(366004)(1800799003)(186006)(451199021)(26005)(8936002)(2906002)(5660300002)(31686004)(83380400001)(41300700001)(8676002)(2616005)(6916009)(316002)(38100700002)(53546011)(478600001)(31696002)(6506007)(54906003)(6486002)(66556008)(66476007)(6666004)(86362001)(66946007)(6512007)(4326008)(966005)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U1MyMEE3UTJqdXZCMFBLcC9OMTlkb1hDVWU5KzhwZlRqTjNTRmhJRkhyTEgr?=
 =?utf-8?B?OHdSU3lFTmxNTDRyWndDb1FiUFkrcnYrVWdhRE9SYmhDU0NWNmxUUW1XK2t6?=
 =?utf-8?B?dUJJZmJwWDlCNHlyNHUzN2xlS1VzQWs1KzZoa2N6T0p1dDM2OGFHQUpPTWho?=
 =?utf-8?B?U29sVGJiWnVIenh1d0t2ZVdpYW81UHkyaVZCcDFnbkx0SDF6Y0JYL1pWV2Jm?=
 =?utf-8?B?VWI2QXhkSzJSNHAzS2FZRkNKTlR2dmRwVCtxTElJU0ZLSjZmeGwvQmk0K1hT?=
 =?utf-8?B?bkNWZ1RRbndOZkFSVk96ekU1cXFBcy8xZ2dvRlBidEV0M2tJL2x5RkdVb2o4?=
 =?utf-8?B?Tk9ibzhoR2VVRkltNGpoMEI4blZINFJjbTN3ZlEwVEtrbmxxNzdNeHJidlJz?=
 =?utf-8?B?cURpQzlVNVh1QzJmMzE1VXY1d3FQMnpjRFZMaFdiOVZodTFENGxVbjJrMk13?=
 =?utf-8?B?V3B6VVpVeGg0cW40bFBjQVpOSkNCcjRFalQxSkFPeCtqVFRkTHJJbVR1M3Q4?=
 =?utf-8?B?K042YVN3R1ZyUG5zdFJoV1k0RjdSMlR1SzVKKy9zUG5PZnBONWNsTCtKeStp?=
 =?utf-8?B?R2hvbDdDcGZ6Q2xTQ2dhYzBtL0llRnQvSjRPZGJLVHJWdVdQQjFuaHl3aks1?=
 =?utf-8?B?S0lNZWRUaEpZcjBTaWZUdVFOZk1qSHFRQzQ4OHY1MXl6NWd5YS9sU0RZSlpi?=
 =?utf-8?B?NzVySXFDMWFGT05EQzkwMDAyZUpsU1l5Y0xYalV5MG94TjJVRlIvZUlsQ2FN?=
 =?utf-8?B?UHVzbGJSTURYZHUyUDM2TFNYUDFuTUlKMzExSkFOMDdPNktNQncxQ1NHTzBM?=
 =?utf-8?B?MDlqNnc1REFTSkhlV0NoeC8wdm1iRDdGUWYzMmxhY0lkR2cwOExWYlRrWE9Z?=
 =?utf-8?B?MDdnRm5sK3ZmODN0TzkrTUxsempwV0lEYnhWYlZiM3NFZlV1Nys1czl6TGZo?=
 =?utf-8?B?Y2RHQUQ0djROdFNUU0lKSjlMV3EvWHJwVUlna1V4N3lLQ1dSRnZxYXllTHdn?=
 =?utf-8?B?bHVzV25QbVdwUmdJbUtlMTZaT2NyQ21FZHpDMFJveW9GUUhtaHBheTJmMUIx?=
 =?utf-8?B?ZUhqU0lPTDFYY3dkTW9oVFV5OVpIVXZzcDIxY2VZak5CNmxyc3JWNERpQkE3?=
 =?utf-8?B?dURreGxIbktBZDZNNzJLNlpoK29ZQnlCbmdvZmRKZ2dWeC8vVzExY0ZKMzBW?=
 =?utf-8?B?WXkzcGJUZ2s3ajF5UlJvLzlOa1EwMUFkWWtxUXZ5QjcxbVkrZkNSc2RYOUpH?=
 =?utf-8?B?NEc0c29uc1BoQ1E5NzdHTHdlWHgyTzk5UUdLZndFTWhyL2liVGxveGh4TUpR?=
 =?utf-8?B?RDNUbkxCMXVtV2hKRzcrYmJTK3J0Vk9ic2dQS0I5bytqZ1pOMTUyaTdFY0Nt?=
 =?utf-8?B?WTJRd1NzTURmNEV5WGVwZ2dYYlNtVWpEbzJhVk9UZHl1TC9rNmhrYkxzQkJP?=
 =?utf-8?B?ZGtMUEpzMWFsTS93MURKVFNjVkFXVnN0bW42U1lGRHh6aHl1bDhGam9KTjVU?=
 =?utf-8?B?cm5XdHc5MnZ0T0JrdUNKY01jSE0yMGhHaWs3NlR2dis2RlEvMlByMjRBdGh6?=
 =?utf-8?B?VmtiTGZ1Tm5ZeFhubEhTVUYvQ0FpajB0Q3Boa2FIQ3V0SE1KREZnaFhKOFo1?=
 =?utf-8?B?ZUVaVk9Ob3kzOXhSSmNUeUhkN2Uxa1NBV05qK0F0Q2dFQkdubGQzczZOSUdV?=
 =?utf-8?B?V0pKOEY1UG9pSUlJTEtoRU54QTZKR245bFlXcXc0VEFQdmtWM3Z4ZzJQaGh6?=
 =?utf-8?B?TEV4OWt0czJVWVVYSkxaYitwN0hRRDAzak54WnNJeUNiNEErTW9HTjBZZGRu?=
 =?utf-8?B?RC94bm5JUkx0Kzk3dlAxU2RjM2ZDajIzTjdiV3lCZUFDSFhnZ2oyNStyQnJx?=
 =?utf-8?B?RTNLUE1NeXJ0N3ZVTEw5dkdwQ2I4dldxVGlLNm5QQnc4d2FRd3dwVFZXK1pV?=
 =?utf-8?B?cTZOSmphUWROVk1zdGxXWEVLVkl1ZXNDbnJCczlieGhjdDRwR3hML1pqZ1VT?=
 =?utf-8?B?dkRzVE5ZZDZTcWN6Sm5iQUhnZnFlSXlNRXd3eG9PM0FMV2I4YXlwZWpDbUhO?=
 =?utf-8?B?YnRxS2ZESDhtVWc5aFpmLzFaQjJHK0lqWWFwNmNHT3piVjIvaURoczE1eXhH?=
 =?utf-8?B?SldSTzNXeGp6Q2RENElWWU40MVZ4ZG05bllPeHRVcmhVdWVvcVE0VEZ2RGFz?=
 =?utf-8?Q?/eudcgL0dS84rlD1dqouGVk=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: lINKPzJF8nfGeCRq7Ewb2+bFDAUCBDq5K6ghnX1hSC5Q4bwzn719jixj6ye5hJfG9/lXrVqR02f/wqy1HReqYnGiGZgniBavy0UtOr8JoI0rzWu8ZJpFlaQmTLolBV6EyFJkKTP/6OoAnxGV2CODgnaYgxDX+PN7DGhypW5c9gC76pNlt0v5S/YYnlEVgRtodhTYaFbuAoUMXKQr7ZtupMv3yfOEqEhs9DZMFEsfdv63SJN2cNqLcyyeyhDio1+Fo4679HFk2the8Hk/W9JFi5gMZD3hGFaOaYeQ3bammid3ec9zs40co1gEm2C40tBo7ks28sdDiKVr5Uvs5oyuHd3yPOPtDih7fF8vxKsq7k03l7ZA1oun2BrYska/tYKhxUKn6o3Z9wry8Pn8KGQD0r/QffnsrDkIR6gDSToTid2rSdqQfQYBEt9y8lf8lPYInt7LkhVOSUrk1O80A+jDqx1LyNeMpDolddLQzPGvmCv8K58bZ2QzOv5WNFPx36/wEc4Y3Ncb/Yw+t4zsCYRkKK84t9HUslBe4QEkTOt+KqZrfI3VpG0J1oYTawthmk8MmXl18Q1S/w1sllkg4K0LCAAzu6zyY83KeeEoksWeGp11LL1o11wDjvJ+4H4mz6WzhQuCfF8h4SuI1y9oaN9MQR3+/CZGnEC9CJlUmL1sABexwIBM9ce4Fj7ZjY+wxDUP17LBPgOEbWkrY0Yxf3Arzbydf2V225mDPhTd2UPZ6h60Pnazk9jnBu43Kz2hCXWf02ydjwW2j4BcbVJNIbOqXcMLo9SpAZmLMJkga6BsEr/Rxv9nPqSH0H63wD+IyYGPN2HHUHXDrNnY9cO6lUUriQ==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8149a35a-5a5c-4721-9b32-08db9837d709
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6290.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2023 17:49:40.4138
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XrbMY9+5vs0vGXEJOC9YUTRISDLs/y4O/XVe/RzZjQvGLxBU6AhotYXSkozZ4NUP/NqIYiFt5SFeqqsLk7qxOIG76fg54HVHC/GtdiH5vMoUKJvh9XH7V6fFZv0jh7HC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4196
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-08_15,2023-08-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 bulkscore=0
 malwarescore=0 adultscore=0 phishscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308080159
X-Proofpoint-GUID: 95kogkRTkUfIlPdgrM-_OMV__r7wuKbG
X-Proofpoint-ORIG-GUID: 95kogkRTkUfIlPdgrM-_OMV__r7wuKbG
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 08/08/23 2:30 pm, Ulf Hansson wrote:
> On Tue, 1 Aug 2023 at 07:23, Harshit Mogalapalli
> <harshit.m.mogalapalli@oracle.com> wrote:
>>
>> There are few issues in spmmc_drv_probe():
>>
>> 1. When mmc allocation fails, goto is a no-op.
>> 2. When mmc allocation succeeds, the error paths should use goto instead
>>     of direct return.
> 
> Rather than adding a bunch of new "gotos", how about converting into
> using devm_mmc_alloc_host()?
> 
Thanks for the suggestion. Yes it would reduce many "gotos".

Will send a V2 with the changes.

>> 3. platform_get_irq() doesn't return zero, so '<' is sufficient.
>>
(Also will split this into different patch as it's fixing a different 
thing than above.)

Thanks,
Harshit
>> Fix the above issues by adding goto instead of direct return, also
>> remove NULL check in 'probe_free_host' as we changed the goto to return
>> when mmc_alloc_host() fails.
>>
>> Fixes: 4e268fed8b18 ("mmc: Add mmc driver for Sunplus SP7021")
>> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
>> Closes: https://lore.kernel.org/all/a3829ed3-d827-4b9d-827e-9cc24a3ec3bc@moroto.mountain/
>> Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
> 
> Other than the above, this looks good to me!
> 
> Kind regards
> Uffe
