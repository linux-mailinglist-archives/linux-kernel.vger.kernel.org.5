Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08BA47D0600
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 03:06:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346805AbjJTBDE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 21:03:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233033AbjJTBDB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 21:03:01 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D29F1115
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 18:02:59 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39JKxJNB013649;
        Fri, 20 Oct 2023 01:02:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=szr1Tt5qdC03gksTf+IgNe546s8XVJoZsQBhVGjFNz0=;
 b=fE3aiLIrXkus+A/U/ai/eOaZvwTyMWlcnBQImEC5Za1T2EhCkipzxgmJ2ka+AkmawmeR
 Wuv3R64Zds8BCAtnTLJ9bevqkhdhFLTQ4U40vSsBjz9Q0UA8MjdcVM5kLb4cSJzSj8kt
 G8i84qm0cfFwhaDvfCw3PFIxtTuMISbrrfqnwBw7SRanapjrpcURNHaNZXIVEO4vdCo5
 +qmk+3v2lvui4HpnkPfPYDq4JbiNEVPNJfv7yzN0MUtFLcnyCT2Axt8RPVK0a94xzvVs
 yedVEPfM6Tnw/ybBkgO3D5aewhieionFGZZ95DOEBshGigT8/hiThEM1aSTjrDYfviED ow== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tubwd88ph-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 Oct 2023 01:02:43 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39JNUXp1038505;
        Fri, 20 Oct 2023 01:02:42 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3tubw46m1c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 Oct 2023 01:02:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k+MEiiRDWOMq4kQCj0t1mdtBc88gvdz7uxCTUxXrINQKo/xZeANDM9x4UGTirvEmAt2U66vD5aLySPni9fwRH1A/oLEyy75kT7fMI2GvYwWDV4OalcnQfyASdMN6+TP2Hon9fGrk+FgffMMZxCOoucgHJeI9dPVBndb0DdvQpu+0NQQFZSQFJ9waisj471cTYDraG0rBl5DZ6yLfCOptTv8TYIlBgqz+zh3HpsfO7BbcXoUciJ3H4HxfnO5dIItd4B3vpQq5CCQtWoPTUYrFKlSpTFc80Arwe7ghzfFHCp/JmUcMu7Ut5JakwzkPy2G98u3JtCi3/YQDwzVECBQzcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=szr1Tt5qdC03gksTf+IgNe546s8XVJoZsQBhVGjFNz0=;
 b=Nb+ikFAYmUgEUaw3U1du9AtRP1UXfyaDZqSPdVbPjSwBIAcIR4cXP/kC6ugIX2GlJHWP+rI+nCrtKXkGHeuiwSM936CDCYGIJ3hreQUTQaWZhtW9k4IYp7CBKGu8Ul5wUCvJUlEijdaTzRg0ll/NL1qMF+VwZVib0gXG6KgDkTOkcoCRPkJDEF+psq0KgKr874AlkHWtKvxvsT+FWGWFkB0eH2XmCawpkmUvAMAHSnlGyxtQrVLDMViOmEsOBWGOdd6PQuqwyeuj/SOGtQY7BSsCTvwayQdZpLN6MUXlGfVQjbb23yQIfuUqS3QDH6/TPmviWtL+vokeR+6PZYfgzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=szr1Tt5qdC03gksTf+IgNe546s8XVJoZsQBhVGjFNz0=;
 b=qzVgufd8xi+OiXfflB15YOWjn64Mhl5vRUlhmGoItnX6MTeU03tiiZy1CL/NegNObOdsV0U+XkZlsTenIfqzL+18/wqrwM6MTTabZHRybSK0IBB+KomdMe0LNsD85EGk+IDGti/YsZn7MDr4jbPDO2q1VKt2nkLpwcOB+aaIq3c=
Received: from MW4PR10MB6535.namprd10.prod.outlook.com (2603:10b6:303:225::12)
 by BN0PR10MB4934.namprd10.prod.outlook.com (2603:10b6:408:120::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Fri, 20 Oct
 2023 01:02:39 +0000
Received: from MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::5393:c70f:cefa:91c1]) by MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::5393:c70f:cefa:91c1%3]) with mapi id 15.20.6886.034; Fri, 20 Oct 2023
 01:02:39 +0000
Message-ID: <dbdfa01f-1aa6-4bf8-8981-cd7905f579eb@oracle.com>
Date:   Thu, 19 Oct 2023 18:02:35 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v2 PATCH] vdpa_sim: implement .reset_map support
Content-Language: en-US
To:     Stefano Garzarella <sgarzare@redhat.com>
Cc:     jasowang@redhat.com, mst@redhat.com, eperezma@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
References: <1697605893-30313-1-git-send-email-si-wei.liu@oracle.com>
 <becui44lhdptriz4ds7r2b22kazofwo7i44rydacjssnwb7mrq@f6sa74zjhlfp>
 <171a1147-2099-46da-81f1-fc953e9410e2@oracle.com>
 <tqjrjw64l7pqphaagskys4zmkknkv46w7fxojic75b5dwbtq7m@dgq3xgryqz6f>
From:   Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <tqjrjw64l7pqphaagskys4zmkknkv46w7fxojic75b5dwbtq7m@dgq3xgryqz6f>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL0PR1501CA0006.namprd15.prod.outlook.com
 (2603:10b6:207:17::19) To MW4PR10MB6535.namprd10.prod.outlook.com
 (2603:10b6:303:225::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR10MB6535:EE_|BN0PR10MB4934:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a30a274-73bd-4a2d-1c65-08dbd1084151
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: e21d5mdTnoul+Hi8PAM+G45EJjfpUIdZCkUTomwfHZiBc2FgFhn7htIhX/soCpBIIu9aPoUf+h2KwTBRGk3PY8Ee41Bpl8zAi9EUCXDalWFMwLYMoLg0GjzL291VnYpMbbOwcg8zxJNjSC/czgjziZhBHhgD1/LZ2qBQFd1mxsDUZrKb9fis+ItxuyiELDXiBbi44GoVtdxLrBBkXKL8lywin+hjQlRRoqVEuu+2XXEm6FpscL/ziAY6F9PsKKceFtkBr3HlfgHUufDW5XkcRgdCr152QnvZpyf96dQlg8/rZczKMKpIAIrTTJy13KUU+XkY+VEW5Gdfy+W3ic6Gv1b1c3wm7PlAhuCBTwnt2Bzn0Hvb9odNHldOw6nGY1j9x2tFoBPVqr+cAo0FeO/kb9W9eV8l+LvbhIgom7Z6b9crlpl3zMD6ZvEAD0ajXZtpPewL/TdezyliLNyv3a9ySJIU3z8VXTaoq84B4HCmbfCOQgiu0JFpxDx2KyvR7sek0Z6eYv6der1M4DyWlw/n86kBTFpG0cJEuSHS8Zz42FwCXTFR0C9XAHQlCUku42Wh64Db/iBodgDtZKdhqLnzhAD9IO+V87MwmyUKXPVZXE32esD/PO4cNu1NDgz1Cgrlm2r/0MF0ODvUO0OJSLDETxfTsQOHTHm5U1RCZvGi6W34Uq+mjwClDU3yFN0JFBeP2+CAtYgwJQoCv+tTVkD13w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR10MB6535.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(396003)(346002)(376002)(39860400002)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(66899024)(66946007)(66556008)(316002)(6916009)(6666004)(6486002)(478600001)(8676002)(66476007)(8936002)(966005)(36756003)(41300700001)(5660300002)(31696002)(4326008)(38100700002)(6506007)(2906002)(36916002)(86362001)(2616005)(53546011)(6512007)(83380400001)(26005)(31686004)(142923001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UCthekZFNDBISnMzSHZpeU9aV2RCeE50Umlib3ZFbnE1NFlyekFsS0txYm5k?=
 =?utf-8?B?dFVvZXlDVzcyWFQybjM4VWE1Z3FyL2JUNlFPQTFSMjk5ZnR1U1V4WkgrOS9q?=
 =?utf-8?B?NWFrUXBIVkRxb2piVUFiMWlXQzNxalB6YUFqT1ZFU0E1ak1NNi9LM1RTZFBS?=
 =?utf-8?B?NTB6WHpKdVlWUThWRWplL2R3Y2dQSkwvREhHTVJhVXhvcnc2ZXlrY0FwaEQ5?=
 =?utf-8?B?bTBzWlhrM2FrUlBXTzJEbDNlc21zeHNtaTNwSzY5Z2tVR1hRdks5K3J2aVpq?=
 =?utf-8?B?YzluOWtuSGQvK1Z3R3UvcGlVUUEvWHVESHl1MVN5Mll2cHVaQ2hRZU0vbURw?=
 =?utf-8?B?RGVmd1l0RXd5OG85aWMvbDZQcG9hVWhxWmpibXpVTEgvYlpTdmRSektDV2Nl?=
 =?utf-8?B?WWVGRStVUjFxMWxqUXRwQytNTmdwTFBabDBlbHJCbVpnMWRMZzNrb1loS3Rl?=
 =?utf-8?B?TFphdWNQc3hlaHliTm9UVjQ2aVZXWWs5dUFzNXZoam45NFZZL2dQM1VPcG00?=
 =?utf-8?B?TlNJbmYzRWN1U0ZUYmVUQ0tVOUFYeEwwa0U2cnBSdHpYV2NrT1hlcDdUeDBW?=
 =?utf-8?B?a2lKU0c4cWhBdk13ODlaQ01MOEpmelhhd21OWVBVaVFuY0l0UERDWjB0bG5n?=
 =?utf-8?B?MCs2TStpZVRFVk5zbnc1V3htc1o3ckk2TEE2eklIUlBTNWtzRzRYNXF0N2FX?=
 =?utf-8?B?VzFDSDJMUnJqT2tkY3pheTVkdEdzVFN6V3dVSzU5dnJNYVptek4vaXRGVFRV?=
 =?utf-8?B?SEpIb1lCeS9YQThVa3YrcXY1YTBCSmNyS3YxVFdCZTRrRXZ0Y0t2c1Zqbk9T?=
 =?utf-8?B?NmxEd2pXRDE2Z3MxQjhVK1lCOVV0MzFUSWljQWNlY3pZZzhCb0RuV3c0a29a?=
 =?utf-8?B?Slg2N2JEYWViYlhvZmwrUVlmRytuRWpORXNnbklNRy9zbXQ5OEhIWFVvcnZX?=
 =?utf-8?B?UVpSN2NhSjl1RytqbW4wQXRBQTFOckRBMkxSTy8vYzJxSldPbFVra0JFVzVs?=
 =?utf-8?B?a0t3Yjk0d3dOdzd5R0U1UXpKQ0hQVFJZOGdpZ2VCYzRsRk1vYVlwUU9SUW5W?=
 =?utf-8?B?MDN6c3gyU21oUUNYN3k4OTlJVUJ1K2FZNGRXSDhTSW5FblZQUHRHY1cvOVhG?=
 =?utf-8?B?N1lWZVVDT0JPZXM4Zy9qdGdPZ0d2Q2UzcjJmdFRJMkY0UDFwUCtrU3k1U0pL?=
 =?utf-8?B?Y1dGdVpUWUtEcjRrUy9uVitNcjVRQlVqVEhHcmx1Q05CY3JCM25lOGUyUks5?=
 =?utf-8?B?Y0pnMnlsVmVaSFY2elg3bEZObVRHazNqNWlyWHp5L0VVQ3FjcmpVRGpGREY4?=
 =?utf-8?B?VElXL00rL0JCZWRoTlR2aitaV2ZyekRRbWhZeEVzVXMwQXY5RUFMdy94WThQ?=
 =?utf-8?B?TmNQRVBLbEZlNkIxL1BFSWM2SGd2enlTNGdrZU94b0pZQ0pBYmM2eTRIc1FE?=
 =?utf-8?B?MWV0eC8xNjlxK09tb2JJUFFXSUhVQnk4cTlRMDA4c0JSZFpuRWkzV0lxQWRM?=
 =?utf-8?B?ekJFSTBWSGZXdWRDRFJJN0JMaTZjNndBMUN3b2VRaHZSNTcvVTVtZ0JQUy81?=
 =?utf-8?B?YjE3SjRodGNGRXE1VUs4U0RtSWRlUGZFY2dwQ0w3YlJGT3ZRUTlXaGVuZDR3?=
 =?utf-8?B?bUxkZ2IxN3p6WFUwVXJzQzJiamkzYmVXMUFXOFZNRDZmMW9PaE8xSi9qUGQ4?=
 =?utf-8?B?eEoyNHBQWllPZGZWN21nNGMzVmpCaE5Zamg4WGNiOXVOQXFRME1PWWdzZ0l6?=
 =?utf-8?B?eDNWRFlqaEMwZDdMcEloOVUrNExOVTcwdVFmSjFnRm9UR0NpcGUzNlF2MjY1?=
 =?utf-8?B?bjhadTZ5dmxWSmFnSDdEbGwvb3J6SU9hTTR6eURkRjVBTVlFWjkzVHY0Mi9D?=
 =?utf-8?B?V1VqWGdSSWdRRSszMHpLdEJRZi9rMzdiVzlhbEFJckYyU0lvYXQ5c1BSNnBr?=
 =?utf-8?B?RUxlOWIrYllHRG0xaWZWWDVBZGI0ekFlZWZEMWdNVkc4M1dMR09uTlNhd2Mx?=
 =?utf-8?B?bmJOWE04bzdKd1ZuL1RreGJqMTdqdmdkcE4xaWJveENra1RQOXE5d0ROcmtB?=
 =?utf-8?B?bEdnZkt6TVFXMXBjQVlmUmJ3MzVYVTlBRDRaT3lZVDZXd0RMNERlei9Sc0Vx?=
 =?utf-8?Q?/mBEEiI3A1i+f5hG2LpRC3MqG?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: MpRFu4FAbL6WucvZYn5JGZGbhfB1R8hJekQ6Q80mvts0XJGRtv6Gz2tF4tQghCcJdyvb01NZ43B4V1V42Zr7nOduK8FFn0KSIl0p6IXkTeMGeDV7hRzHX/K8io+fbzoFBzgMR0qwaSFixKKxvV6KSMJM5kIGNukn+cu8dnHp5xOSv5kNRDkd/aZttfuVvFXKOZyhlfX8dofY+SL+UhKF7kluink/M3og6DyIpEv5c15tnDq4yoGwcZ4nowmz6WwwMMze8b3hAocdIwxhhw5aZHl3p+++ZuUxuNHqcVfbVgdFjNWRU5ASJmMfn/oyMGbR7P/WacfBeWHZdzZ/YgK7lRNgYFFbFYWKMtp24bSJGApFZgWgF/VIFLASAaUICDu2RByuqFW0JvlWsLPyuCYdsMn6e9xmjd7JGXomgN+dbIlYjDFSOyN6dUvKKlS2p9QsUVtC2nOdQX6AN8TWeBJMp/jTKSDvVVtB0Xh7QmLFEfevOnmsqxVUJGOhyEWkIvfM33mZ8mFWcr6EcpHqCPbwR+a43mulrkHSx84IkZxypMMFGEUa7NxPBTjrP5sZGRjGwwVfzuA1k338zUSCjt5SqEsL0fP6DEZzyMM5XQpBI+8nnb0ZkEjjW5UJEjymTjFD30LcsFEZoc1uLhac6w7YvJqXjRLm8ozN/RUuSSX653BYUQatTk1S0W1KkccgD7HvxOrGiNaoyaICq3Xcs8wRnn4+K+QplAoQWATWWxz6k9Nrz0wwHUb1Zua927KgRJNZPptgCcUcahf2S4a9W4lPlCJh5zKNDuq0811orY17CyBfZXP9WsLXOeVIIUlCXjviwfq4gu8lWUGUGIh9U+00Ck2BhkgRrOPPmC2a5cVz/hg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a30a274-73bd-4a2d-1c65-08dbd1084151
X-MS-Exchange-CrossTenant-AuthSource: MW4PR10MB6535.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2023 01:02:39.0798
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: skcki5zlirEfMnrOwyCUp4xE8IG8kNscBVp2Yj4v9GRVg1CewRWcSBGVahFxea0JkDsrc7k+AjUyShYFgAXNPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4934
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-19_23,2023-10-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 mlxlogscore=999 phishscore=0 spamscore=0 mlxscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310170001 definitions=main-2310200006
X-Proofpoint-ORIG-GUID: iI_SymNdSmRhjMX-a6vLAOZZrKLyh-rU
X-Proofpoint-GUID: iI_SymNdSmRhjMX-a6vLAOZZrKLyh-rU
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/19/2023 2:29 AM, Stefano Garzarella wrote:
> On Wed, Oct 18, 2023 at 04:47:48PM -0700, Si-Wei Liu wrote:
>>
>>
>> On 10/18/2023 1:05 AM, Stefano Garzarella wrote:
>>> On Tue, Oct 17, 2023 at 10:11:33PM -0700, Si-Wei Liu wrote:
>>>> RFC only. Not tested on vdpa-sim-blk with user virtual address.
>>>> Works fine with vdpa-sim-net which uses physical address to map.
>>>>
>>>> This patch is based on top of [1].
>>>>
>>>> [1] 
>>>> https://lore.kernel.org/virtualization/1696928580-7520-1-git-send-email-si-wei.liu@oracle.com/
>>>>
>>>> Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
>>>>
>>>> ---
>>>> RFC v2:
>>>>  - initialize iotlb to passthrough mode in device add
>>>
>>> I tested this version and I didn't see any issue ;-)
>> Great, thank you so much for your help on testing my patch, Stefano!
>
> You're welcome :-)
>
>> Just for my own interest/curiosity, currently there's no vhost-vdpa 
>> backend client implemented for vdpa-sim-blk
>
> Yep, we developed libblkio [1]. libblkio exposes common API to access 
> block devices in userspace. It supports several drivers.
> The one useful for this use case is `virtio-blk-vhost-vdpa`. Here [2] 
> some examples on how to use the libblkio test suite with the 
> vdpa-sim-blk.
>
> Since QEMU 7.2, it supports libblkio drivers, so you can use the 
> following options to attach a vdpa-blk device to a VM:
>
>   -blockdev 
> node-name=drive_src1,driver=virtio-blk-vhost-vdpa,path=/dev/vhost-vdpa-0,cache.direct=on 
> \
>   -device virtio-blk-pci,id=src1,bootindex=2,drive=drive_src1 \
>
> For now only what we called slow-path [3][4] is supported, since the 
> VQs are not directly exposed to the guest, but QEMU allocates other 
> VQs (similar to shadow VQs for net) to support live-migration and QEMU 
> storage features. Fast-path is on the agenda, but on pause for now.
>
>> or any vdpa block device in userspace as yet, correct? 
>
> Do you mean with VDUSE?
> In this case, yes, qemu-storage-daemon supports it, and can implement 
> a virtio-blk in user space, exposing a disk image thorough VDUSE.
>
> There is an example in libblkio as well [5] on how to start it.
>
>> So there was no test specific to vhost-vdpa that needs to be 
>> exercised, right?
>>
>
> I hope I answered above :-)
Definitely! This is exactly what I needed, it's really useful! Much 
appreciated for the detailed information!

I hadn't been aware of the latest status on libblkio drivers and qemu 
support since I last checked it (it was at some point right after KVM 
2022, sorry my knowledge too outdated). I followed your links below and 
checked a few things, looks my change shouldn't affect anything. Good to 
see all the desired pieces landed to QEMU and libblkio already as 
planned, great job done!

Cheers,
-Siwei

> This reminded me that I need to write a blog post with all this 
> information, I hope to do that soon!
>
> Stefano
>
> [1] https://gitlab.com/libblkio/libblkio
> [2] 
> https://gitlab.com/libblkio/libblkio/-/blob/main/tests/meson.build?ref_type=heads#L42
> [3] 
> https://kvmforum2022.sched.com/event/15jK5/qemu-storage-daemon-and-libblkio-exploring-new-shores-for-the-qemu-block-layer-kevin-wolf-stefano-garzarella-red-hat
> [4] 
> https://kvmforum2021.sched.com/event/ke3a/vdpa-blk-unified-hardware-and-software-offload-for-virtio-blk-stefano-garzarella-red-hat
> [5] 
> https://gitlab.com/libblkio/libblkio/-/blob/main/tests/meson.build?ref_type=heads#L58
>

