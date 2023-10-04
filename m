Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F63E7B9695
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 23:38:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244073AbjJDVf7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 17:35:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244002AbjJDVf5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 17:35:57 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 499DBC9;
        Wed,  4 Oct 2023 14:35:53 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 394FJ05I014539;
        Wed, 4 Oct 2023 21:35:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=Q7bs9u0sHec+XbxAxhc0D5z1bWmRxduIG0Jt1dY35ac=;
 b=Wf90/mD2ijuLRAPE/a7QKnHkMOi5Kl+fX61qsbMkbnQGt22yYHtTgWccpYIxlEfqpbJ7
 naQOmUvF7vTdfplE15c6ho55sL41LoXRzGb6JmpbCQ6C/BAzEfUqVVbtNaP02eiUUDIZ
 SxDWlEJxlUNO4vdnwBxT/J6hA5JWMTK1j2XQQN64cmOicO4fEK6AaJ7DqTE0eAG6UXgg
 dEQdnJoymuTcKDB/lu4IWnFsOFrUuTKIwymRS9MbxH5RlGC3cqCsfrOzyFXWjaUVILfn
 doKMDel+vlvPVyErUfWVk0PQBCRXg4aYfziRhsRh6aCLht8cXXoewmSNmDwpXxmhE9Wv mA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tea9285ts-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 Oct 2023 21:35:15 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 394JruIM005954;
        Wed, 4 Oct 2023 21:35:15 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2171.outbound.protection.outlook.com [104.47.59.171])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3tea487htt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 Oct 2023 21:35:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jjMwfr2ac9M+bA2R5pLMTqpSU+dBO6vdiNPBl7JtM/l/3PXwqfMZhycRe+9cpHydrxlKiYr/CtpaZK9E8KtY+1eieF6n5sDqjTwCm2HkDQyyyki+G+BNLg+yWNfMVz6swTp41PnP5xWD3UrCtYz0jvxmqKRmO7wppGo81aFJ0ynd3V6o/XGFG8t3xEfTgFomfOjXis8nZm40pHPVsPszE2S5WZmtX18vyCUcMrtxnhiAj+zJA8aXTTFCwae9BTl7UyE77reCY360LxDfTrECoZczqel2XE8nFIRC1DXM5Wkln0j9iwmTF3qwJG5TAy5UVMDJANmJDk745JL2PJe9Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q7bs9u0sHec+XbxAxhc0D5z1bWmRxduIG0Jt1dY35ac=;
 b=We1E2h1n+B0EWFNA2VILp/4cCDdUrRjf9/OlF3G58L6XbHjHKoSa0Xk1m98y8vaGAt5MOGxzVeAClwSFHiHy/YwxODndek+JyDHHjjw8KINaG1CfpeR1E4PZ4sGqU5vnksfKqQoALfn2xOvFAGSmo2VNe6Bkl84MVeox/rjJ4uK1+Ta2RWnPwPEzmGbugmf5C+fferrRjmJV0LmglJQzPEbuhzxuSKpsL3Ej08TW5I2BRpjUWHBNcs6/f+v9viQDHQo5HiT9aygWN+wv0+s9o/IO2H34hL2VKeKk75KkyzVXqs+JeRYMmvB8erH7A5ZR/ocUODSmhV/AuiG537fFeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q7bs9u0sHec+XbxAxhc0D5z1bWmRxduIG0Jt1dY35ac=;
 b=mPnyVIqO9cC5sybWPfu7m7+tt0P2mIG7+Vpf/R/HnER3LT3Qq7R4RMxTzax5WJlPGdROILvhg0U1nQ0uBMAW8w9J1It5RUSoloAJz+MCMNHPn3cYT1HK8cJadaPKJxhNkGiDmC+umjaGHjvv8YjIi4Yzo2EYLg8o33HX1imk3TQ=
Received: from CH0PR10MB5276.namprd10.prod.outlook.com (2603:10b6:610:c4::23)
 by CO6PR10MB5570.namprd10.prod.outlook.com (2603:10b6:303:145::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.29; Wed, 4 Oct
 2023 21:35:12 +0000
Received: from CH0PR10MB5276.namprd10.prod.outlook.com
 ([fe80::5b90:1cb6:408:90e3]) by CH0PR10MB5276.namprd10.prod.outlook.com
 ([fe80::5b90:1cb6:408:90e3%4]) with mapi id 15.20.6838.033; Wed, 4 Oct 2023
 21:35:12 +0000
Message-ID: <2f749ade-7821-00fa-ba34-e2d25cbad441@oracle.com>
Date:   Wed, 4 Oct 2023 22:35:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 0/4] tracing: improve symbolic printing
Content-Language: en-GB
To:     Steven Rostedt <rostedt@goodmis.org>,
        Jakub Kicinski <kuba@kernel.org>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        netdev@vger.kernel.org, linux-wireless@vger.kernel.org
References: <20230921085129.261556-5-johannes@sipsolutions.net>
 <20231004092205.02c8eb0b@kernel.org>
 <20231004123524.27feeae7@gandalf.local.home>
 <20231004095431.1dd234e6@kernel.org>
 <20231004132955.0fb3893d@gandalf.local.home>
From:   Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <20231004132955.0fb3893d@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO3P265CA0022.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:387::13) To CH0PR10MB5276.namprd10.prod.outlook.com
 (2603:10b6:610:c4::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5276:EE_|CO6PR10MB5570:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c13e49d-ee23-455e-5123-08dbc521ca6d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0xRWUP+niDKRJ03ProOpA0fiQ/DWznsHOH/4B46wqPjPp9hRIfImU4eLl8llQvdBR6aibrSwCXCCyrMRbBKTOJIWfYRuZqNEj8TB5qxiwECzqqeB7Wj5ekRa/t+u/GbZxx4DpSCOFraSHPTEmNoljqnMhGMHYOXSvQS4CSV8bH66zscGzWsR1R2kbYK8GW02NY7FiRgYAMbf57SG7tBc2OP4TlkeAhlyoKY8bc/TT2t22HWd+P/0+86tM//rsgfYwOkOXH8AgvW1UkRU+HU6ZCVWBtAUpautuMhmAOAGeL3p0XpMLMRqzhb3WxHiGUV/YhB/FNpG59LQuOKf0mmcbxaupEMfkzcMNplmuJSRDCw0CF3vJUNA1ZWlNDcx/Ye+c7Ksywm07pkX6CXeSzW1Vui5N2bgxbyDr5SGPp08TY9EqthbHH9uxIYvLhG7miqOV8DPOT0HGuWyzCgWh5psCvzXsft0iVJoic/67L2W5bYdmWG2uaKJO64gubkXEedM9FmEa+xRvVJwAS+NqGxFo0EmCXmjKlASZG0Eo2MJ9oKasKmvKVQxn3/wMwzYTuY4eSacltAJ/qr8NZq2db1gR5mBL7hmxK1xDsy2YZXrB4J1OgCdpHVFX6yrGgKVTf8O
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5276.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(376002)(136003)(366004)(39860400002)(230922051799003)(186009)(1800799009)(451199024)(64100799003)(316002)(110136005)(44832011)(66476007)(5660300002)(66946007)(66556008)(6506007)(966005)(8936002)(4326008)(41300700001)(6486002)(6512007)(2906002)(31686004)(478600001)(8676002)(2616005)(53546011)(83380400001)(6666004)(38100700002)(31696002)(86362001)(66899024)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eUFTWjRuRGpjMjdabHdRRU5RV2VFWnlMM0M5YzByMUNvYmFXczhyQ2RHZkZG?=
 =?utf-8?B?NFdLb3ZtcTZFdnZDY2JVSnkzSEhuZEFuamlWZ0tWcHJMUDZBSHJzTDFteTht?=
 =?utf-8?B?RGhPZUF1cXpnVUwyMEhXcy9DNUYxQWZmQXdWV0w4dldIeU1wb2hIOTFINVlM?=
 =?utf-8?B?UWpDRkxTTDJncEpCLzk2NG5ZNXk0NVhLc3NVbGtESnJhSFhWVWVrYUZCUlhl?=
 =?utf-8?B?U1ZVQnlkRCtVOHltdTJjSTI5bnlRVkJab003dG0zaG1qeGE4dXpHbWNuSmxF?=
 =?utf-8?B?MmpnZmt1aTd3UTZIa2wwbzdvQVpyaDhTTVc4ajFSRTdkcEg0cytBN20xSTFV?=
 =?utf-8?B?SFRGUXRwSWt6QlBrRDlyRUFFaUVkQWhNTGhPSG8ySmluUnVHeDRKTDhtMEVT?=
 =?utf-8?B?K2EwL0pYWGZ1THhkQ2g1Rm0xZDNBNDhUSENFOGt3dmxPYUVKNWdWd0xNQ3JU?=
 =?utf-8?B?R2RGVnJvMFFNdEt3Z3JsakVibFNObXZYV1RrM04raVpQT0wvd2pRTmxUWXVv?=
 =?utf-8?B?NmNpMEpjNXh5SlBtaWQ5Ykp5RVl5eVBqNkR5bU1yT3lCOTRkckVRZHFyTmNB?=
 =?utf-8?B?ZVlEcHVBQ1JXcXBSTmRCWGxFaGhsU1RNek5yUnBkZ3BsTEQ1aWZVajQ0V3Bl?=
 =?utf-8?B?MDFnbnFiZFJYTHVqeW1GbXhtS0lFaUV0NWc0bFdGRWZYTHd5OVdCR2hYK244?=
 =?utf-8?B?STREZ3BOWWFIbTBLbjdWNHBlVGtNNHZqbEpGVnJvV3ZqUlF0V3Q0M1RGU0xM?=
 =?utf-8?B?cUUxMTJld2pqeU5GZlZqSWZJSFR5bzF4ekF1SlF6SG5CSi9qMmZtdlBUTTRP?=
 =?utf-8?B?NkZhcnRLbCs0ZUVEdkM3ckd2MWtXT0JRZCsxSkcxVkg0eWR3WWpKam5iVWhE?=
 =?utf-8?B?RS9zeUhRTG5MLzlUUUdoOFlLMERwWmY5YW1NOFRIbUJWM2ZKZlN0NGgvYXVG?=
 =?utf-8?B?TkpZK25jKzRsS2xPTDlid0V5QTVveEVJUXpvS05aenA3a0l6Q3duNjg3dW5U?=
 =?utf-8?B?ZDRzUDEyY3V2akkrOE41VFJqTHl4YWE3OXVMelFzYWw0R2hrUnhuSWhmM3hW?=
 =?utf-8?B?K215WGZSMkVYVkVLQTMyNDE1bmpLMXZhNVlZcUE1emNWYjNiSnhJbVV3L2JC?=
 =?utf-8?B?WWJ5Rk9jL1AzNEVFLzJVWG9NeWVoakxXQjlMQlFJaDU2eVVRSDZDeE9DdXlR?=
 =?utf-8?B?QUlSdmpvdHUwNGVmRnpIK2MvR2tXY0pBZko3aWtTYU1RMUNGbmViSExpTnMr?=
 =?utf-8?B?SW5mVXZOaXp2TTFSTFJYNWlQNEhhTzV5ck9Zb2JYb3ZsZWNYTTVqTlBwdEV4?=
 =?utf-8?B?THZ2bDlTOSt5dDZLQnlDQjZoS3pZb1EwUFVIU2pld3BJaklzOGhHWXU0Y3Zv?=
 =?utf-8?B?QjEzQXo2Vm84MWtOZTZObWNYZzNtaGFpc0hFdk9wb3BDbEhXRFRIUUVWWjJj?=
 =?utf-8?B?ZU04K3EzSGFVUmIzdkl5NncvK1JjRUFCNWU2RFZwVDRvWGFhUEw2elZPaVgv?=
 =?utf-8?B?cFFsOTNoWkRQcEhSWmsyaE1vWSttSlF6YXVTMm1NRHM4TVJxRmxuZ2w1VjJQ?=
 =?utf-8?B?TFM0aWFaSVp5TWF4YzNhQmNEZ2c5eER5MkVqT3ZXUVNuR1JiT0xiUkNhQUYy?=
 =?utf-8?B?NWRjazhoN3pvVlRtdHBkWjRWM3lzaXdGbHpNVzNFOG5VaFZNcmNDL3Rhdjc2?=
 =?utf-8?B?OEhLeGlHUnRNanNZRUV3NEk5bnhRNFhJbklxNVFNQzY0M3RlNVdvMEs4ekVB?=
 =?utf-8?B?V082TnRNUjNVdkJFd3AvUkNjeVNRckRhRkdhMmFyditFNG1GbWRTVldJYjlF?=
 =?utf-8?B?MC9rbWg1dExSTndxNkQyQ2V1Z01MbEFjSlpkUXBrLyszaDgxL1JYbzRiTHhl?=
 =?utf-8?B?d3dISjhIQnpvM2Vhd0RTZUVsbkw1eXo3bVFtZlBjMndKYzl4U2dyTlk4bVp5?=
 =?utf-8?B?RnEzRjNpeVJPeFRQalJrd0JHbjllRzREbnZpK04vZm9lb2NIdDBKdExZdzRm?=
 =?utf-8?B?azh0NHJZV1MxLzVUTEszcXNPeG5oMUFkazc3N3pDYTZzbnl5UUFyUFE0RGMr?=
 =?utf-8?B?RzRPMHBMQUwwZWpiNy9PQk9ZUzBhMzFVMUFnbnNuZ29sNVo1dXZCRGExNnh1?=
 =?utf-8?B?RERhUXFKelI2d2p6RFNpbUZCZGd1ZURvMVgzSk5UZkZiR3JrRkRRVW1wRFVR?=
 =?utf-8?Q?WQEOGGkord2qJIlP5WGvQLI=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: hc7JkF9jeTZzlPo0/x/XIdfu/+gEfJQxnvxTyZd8Tp+4bN3AzEgVOIX7et23Cin7X34NP+PyOyyNiYb0hNr7j2jirWHx1QR31TD612okHtfRh+vLsYVBGA2z8M1PqIDJLMr3In7ZyGsd/OvRPqu/HkRMqmPZ+ZJSxZ0SQU+ouaSay+iMjKL9MUcK8EvxC2XzfMDGFpYEDPnztpU78JszR4pGzsHmqDcYgYLqOA0WmIaYa8asmg47wuh2QORbMicT7S/RFNWRmEapg2r+NaCNiX5O04+LOM74C2aSp9sbgq2isyQQFWiUUD3X+FKjGykOL9U7Ig/bsgUL9YpziqqwQgbySn2ksTe77xlKaF2vCfiFFduXynxvZFPav3fnGeSCuVey5a2qXiPxuFs6lhEjrVQ+fgysc3SgERcbdq2Jvjkp2cfve0Gosfhhzpja0wDGSW1ppI/NCxmA8XawXl9UeJgh3rQO5X35Dzek334GXDq1R+2NPkuz3XCkPj6aKT4JFT/IABeMls44hHytUil37VplTMcnji8zjeQZvhO5GcJzK5L5p9dFYW+pM3G6CaTfHZy/+0k8L8GBKRWx7k1ktw3/yaC5k63WQw/pV7toIXKASNEuipbwO9RBqdmIo4KpfWlyJxp0e4g50sAuME6m5tDwqJoSX+jkV1lQpaS7R8aM8jyGIgYtrqKM96jBRHwJpjmRpOkgJYR7aYPyOs1+zbrfRN+oSA4A81MyzoT9GkO/MUxGrWhaFPh0pAn9sjZth1ETaqSwDsWbMJjjt4ddMakDDMb6nqQDcsnM5xam9ba05TEnFE5mFtNwVlZSEN3eTDn/G+ea58pYRV7ebGxoVMaH6jYclHyj+8tIJrL4DHjiynrsn8Vr1huaoXXvL6av
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c13e49d-ee23-455e-5123-08dbc521ca6d
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5276.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2023 21:35:12.6551
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X9BVSaBkdSO1FZ/jkjg5ZfWkKkLZXIenH4InfgHjY6m0T+RH995sKO9y1WRLYs9I5sKFHBzm8NlemEHt5hFlBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5570
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-04_12,2023-10-02_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 bulkscore=0
 adultscore=0 mlxlogscore=999 phishscore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310040159
X-Proofpoint-GUID: gStLrXP-tQUvgva5tA-0sRmGbkX-kRo7
X-Proofpoint-ORIG-GUID: gStLrXP-tQUvgva5tA-0sRmGbkX-kRo7
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/10/2023 18:29, Steven Rostedt wrote:
> On Wed, 4 Oct 2023 09:54:31 -0700
> Jakub Kicinski <kuba@kernel.org> wrote:
> 
>> On Wed, 4 Oct 2023 12:35:24 -0400 Steven Rostedt wrote:
>>>> Potentially naive question - the trace point holds enum skb_drop_reason.
>>>> The user space can get the names from BTF. Can we not teach user space
>>>> to generically look up names of enums in BTF?    
>>>
>>> That puts a hard requirement to include BTF in builds where it was not
>>> needed before. I really do not want to build with BTF just to get access to
>>> these symbols. And since this is used by the embedded world, and BTF is
>>> extremely bloated, the short answer is "No".  
>>
>> Dunno. BTF is there most of the time. It could make the life of
>> majority of the users far more pleasant.
> 
> BTF isn't there for a lot of developers working in embedded who use this
> code. Most my users that I deal with have minimal environments, so BTF is a
> showstopper.

One thing we've heard from some embedded folks [1] is that having
kernel BTF loadable as a separate module (rather than embedded in
vmlinux) would help, as there are size limits on vmlinux that they can
workaround by having modules on a different partition. We're hoping
to get that working soon. I was wondering if you see other issues around
BTF adoption for embedded systems that we could put on the to-do list?
Not necessarily for this particular use-case (since there are
complications with trace data as you describe), but just trying to make
sure we can remove barriers to BTF adoption where possible.

Thanks!

Alan

[1]
https://lore.kernel.org/bpf/CAHBbfcUkr6fTm2X9GNsFNqV75fTG=aBQXFx_8Ayk+4hk7heB-g@mail.gmail.com/

> 
>>
>> I hope we can at least agree that the current methods of generating 
>> the string arrays at C level are... aesthetically displeasing.
> 
> I don't know, I kinda like it ;-)
> 
> -- Steve
> 
