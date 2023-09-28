Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DFA27B262F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 21:59:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231489AbjI1T7u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 15:59:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229864AbjI1T7r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 15:59:47 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F087180
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 12:59:45 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38SJufLD002088;
        Thu, 28 Sep 2023 19:59:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=+QA5tnXxYaoGicQZHO2xqT2sfASsPSM1+l15uFZLU1o=;
 b=To85fnWewIAXUomlHz5sXNaX4KP04Jgs4Pw99UAlxxzxFw2ufzBQ69xVW6HoCESNJvBo
 bSvtuKfnFcUFRysT3GrLjemYgw2x6ju+fi1jx/DDN4FtSyImCfPo3Hb18RFsh7hsaPQr
 94PV1p+Qqd0m0+ofDRLuXIoRxHCUJEb5OqqLNziL6iceliXFM0WDAtXi/q4OUv0KsBhm
 o/2ft2zcObFw+OKPrx3kw9B4ppskvWaCBAvRiK5Zl04KSY/7lTjVIFXdYIwwnuI6iIdZ
 NoNVjBHOEyCClSsOH9ojSv7gVYAH3Z+DioysrBtrjo+N8FBi6UsuAjCAryeDK/xWnDJ/ dg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t9pt3wf9m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Sep 2023 19:59:33 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38SIhrEv014442;
        Thu, 28 Sep 2023 19:59:32 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2049.outbound.protection.outlook.com [104.47.56.49])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3t9pfams7v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Sep 2023 19:59:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MK+EFN9xpLqLYBsLR+Mcv2+fljK9gGI0icfTvM20zdaDkGIV4PCft391DIhztaDuiPrSaFaWYU9VnB1dBKe+vChQbYqmVcRMbQxpmaxjPR1VsWo0GyiVD3AGarP0VE5f6x3/Pt5mvThBbSo7TgUU09kctTVVViSsToNA6vzGsKSW3Y8k++p9oG/kAIk/PyOjZ6uR7w/2gSUVCraeS7O9IQksdeF0dgOgsB3iLZptVbiutBMokQsz+chcoddCmlrhkghsFXkg94pEIElW+cj0Auwu1+53qYZNdCKKL7WlXsDtI68i58/eterBlqyL78MTUJpNvK/TsqoKrA5kLTx/hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+QA5tnXxYaoGicQZHO2xqT2sfASsPSM1+l15uFZLU1o=;
 b=C3gBwHuxjRrtLRv7WcuV1G0h8XKL2rl07j1L7QDwpuhkfOC9Qs50peS8cpUFTnaLqweDXX/B+E0L34qglHb153/MI6gCuOanYqRkq5ugFBAl9csCEBOp6wcJmKXZlrhxWbXJBECGQeiFi9bPkjAM2BU9Xv4lTcKlXrhtkoFqkFbaVs6CS/6/xsWBwIRFjswsmX21D5DZnWcy2UOBRCTaI9Q6IQjsa3YdmhGBbh8oQ6xCP/RHWWer/zTJeaKx7YkRZELehFhgSy7gI8S0sXWJ5KpOuOthY5XKFVEDomZkyoCW0V7K4k+A6xnvIsUeoBsjyEfZOQStJkqj5npvx/9DYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+QA5tnXxYaoGicQZHO2xqT2sfASsPSM1+l15uFZLU1o=;
 b=K/et65Cu1AQsvxgiuNrqrzBR69ye1dmA1shp1QIVGUq1oF1YIXBDgAfHEs1wedQLszjyatlcRwgj30xQ4w4kwIKjszmT7r5LmMYSE4H5K0dQ07WhNUlaJmdj0khCpb2cqsJAdeXtITckE+vfGx1hgIMQg78zSmZUaBWN9fVRQOM=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by BN0PR10MB4968.namprd10.prod.outlook.com (2603:10b6:408:12c::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.22; Thu, 28 Sep
 2023 19:59:30 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8979:3e3f:c3e0:8dfa]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8979:3e3f:c3e0:8dfa%4]) with mapi id 15.20.6813.027; Thu, 28 Sep 2023
 19:59:30 +0000
Date:   Thu, 28 Sep 2023 15:59:26 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
Cc:     maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: BUG: maple_tree: KCSAN: data-race in mas_topiary_replace /
 mtree_range_walk
Message-ID: <20230928195926.ucp7it3c3c75erzk@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>,
        maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <9c1549f9-78c2-441b-8617-3ea3c080a5a4@alu.unizg.hr>
 <20230922135155.tqrelea66hcj5cog@revolver>
 <5d908c60-88fb-49c0-a150-bfb468eaa513@alu.unizg.hr>
Content-Type: multipart/mixed; boundary="uybnb7adp4e2cyyt"
Content-Disposition: inline
In-Reply-To: <5d908c60-88fb-49c0-a150-bfb468eaa513@alu.unizg.hr>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT3PR01CA0029.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:86::35) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|BN0PR10MB4968:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f66c29d-0634-4a6f-b9bb-08dbc05d6d15
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CCRp2z6uZtX26JKpodLChcQ2ML176LNM/RGz6UxlOCk2bObFyTpbiayMeEr4n5sQjzLNUEuhCjre8WyJWer0uKcuqYTVcYjzKDA3dP3si8ySibDPIU/Va9a877ezWc4JskLq9LgcG+Cu/0CScZaS/VaORHs+fWd55NZJYivGxuODeIwkLcxa+DTsqsNKIZICp9pqoy7IsZAPKrgkcmxRodiWGKEy3DW3G893fSZzCVzCnEm9xnHJEUq7Yw5cRObMEzec1TTH9pTeWtglD2ya8oix7wpJu8f5cx1FPStxZuD9XlNz4N9sFlxgYuU3vPxfQrfDqoT5t0Q63d2J13HKMh2y8uroGs+cj3hhm42mBbjY75Qb09K+kHYAhcgOhkHyf+eZqcOFF/zuNotP1aEEq8EYLUaGfg9TCI5f88nB18c6d3LgeMAiKrm+Hk4YUMZM4nHPNR9Drznz58aeBtamY2+Bqrh0QZPvP1qJvD1YRoSi5QH+7YW4U098pgwAZUz9yuj5YKFliEj8AD3xFrLXlQpGxQzVsBIfs1XCNcEnmn1rBcEZ5rymw46mWWFKjZ+p+8WMHvMh3U+OC2Vnc4L6jSUhx+fZmKwVMubswthivMRmifijsOmbM+vbFw9pNDIk
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(346002)(39860400002)(366004)(136003)(396003)(376002)(230922051799003)(186009)(451199024)(64100799003)(1800799009)(66476007)(41300700001)(8936002)(8676002)(235185007)(26005)(2906002)(45080400002)(5660300002)(316002)(66946007)(66556008)(4326008)(6916009)(478600001)(6486002)(6666004)(6506007)(33964004)(44144004)(53546011)(9686003)(6512007)(1076003)(83380400001)(86362001)(38100700002)(33716001)(2700100001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NGVCWGVuTGVRenQrL09lMThzaUtEdkxwWHkvcVl5OWlqNnRKSUltRVVRWE44?=
 =?utf-8?B?NzR2dVVLUmhxUFkxb3ZIcDl5MGlUZUJlUW5uWEtGVURxbUpyUEh4WXZEQSt2?=
 =?utf-8?B?RThuVjZuZWlYL1NmSWNFZVA5eng5NmJ3TzlLTUJIakIvcXZWcWEyZ2NZbExM?=
 =?utf-8?B?a05FbmhUVnhVb1l4eFpKSGdJcitWYTlxaVlFazc3SHFKdXVRTkFpTWxKcVMz?=
 =?utf-8?B?U0J4cHUvRTBjOVVxdHdSa2VjcEtjb2RGem1lU1dlcDl0dThlaldZYzRUK2N4?=
 =?utf-8?B?T0Q2dTdsNzFxd2h2b0dxR1BWL1h4RVlWcDZRTUl2K0QweGdKdXNCazJWNFJK?=
 =?utf-8?B?aHBpMVpYV0VwSExMbTdEVlZxb2E1dWlLWk96RXZ5cENHcnUxVlpMZndtMjR5?=
 =?utf-8?B?SXBxODBhSUIzcTRmY0srTm8zVW85REJPWnhsTFRBMTl1eThFbzRYZVljMlQ1?=
 =?utf-8?B?VjF1QmhVM1NIWmFnZDFMVTd0SVJEV20vNC9UNGVxUFNkSUxuYzhIQmc5SzZv?=
 =?utf-8?B?WDhEUVBEUmFjVzZsL0VzbGoyUUp5dkhKNWorSXo1UVBtakFicmgxbE5WUk8y?=
 =?utf-8?B?THpkcDVRaWdHNTZkZnVMV3ZlbTZpZEg5SUNZc1NJRGp6Ti84WkVmNW0xQ1FH?=
 =?utf-8?B?T2g0TlA4dGNIdFdVV2M5SXNsR2YvT3dqdXcwQmZTK1pvaEl6WFMwaWpIRXBB?=
 =?utf-8?B?TndVazV2SnZGLzFQZ3Z2SzVPOVowYXNaT251RldubE1LcWxyZ01YbHRHK0FP?=
 =?utf-8?B?WWd6emlBbTdzWmJtTlROTDk2ak1VZTkwTXJObEVGK1hMV1ZsSFUwejA0R3BO?=
 =?utf-8?B?UEx5WVQ2aGYyQXdKQVEySldJWFlkVUNLVzFiNmNXeXBhQ0tTRXdYSXo1VDJ3?=
 =?utf-8?B?YlRuUzBGRC9laHQzZGtVaTNmSkhLdFh1bi9HeWxrcGVUZTFQcC9XZFovcEZO?=
 =?utf-8?B?YWdsSTBtU1k5Y2d2Sk1PU3VwUlE4bktkY00xMkRQVWtqcHNLVjJxdVdsR3lP?=
 =?utf-8?B?NlVHeVk2eENDQmJzNHI3dXZvWjNVVzVzUVV1SHdCdVNkUXBxb1Z0VlU4eFZY?=
 =?utf-8?B?Q0NjUVlTN1lOTXpNeTFZSmVMeGNmcDBPUUFKLzR1VmlsSGJlblZoYVIvdnFw?=
 =?utf-8?B?aS9EYk1pUW1sbXE1VllGWFVtbGFVVmI3dFFiREF3TVlOMU5HdmFCaGZoMGpx?=
 =?utf-8?B?QUNxZWdRdnBtcEpmT3ZzM0Zia1JOY3hXSFRibkhiU0NYZFc5RmFWYzhyTzZP?=
 =?utf-8?B?UGZIWUUzSnlKa3JURzF2ZWtWZEpoR3hkK2VtRVp3Q2Qxd0l1bmhjVmpmc1lm?=
 =?utf-8?B?amE0czRHbWtpOVN5MFRicENHRFJQVDdtOHllNjc1Y1JPY1JPR2Rvd2FZdjYy?=
 =?utf-8?B?bFZlTXFvOGZGUklGOEFWbFBUbm0zZjBYVFUyekdWK1djVUw5QkR5eUJqSkor?=
 =?utf-8?B?SUs4VTFITjREa1JmOExnZTRLVkN5bmNFSzJzWVkvUUxNNzVzQm5hYytvc05T?=
 =?utf-8?B?VHZnTzJ0N0hTMm11MzRsQmU4UkwwT3dTWjdDQm1qeVhqL0lDbzR1dmZYQWZJ?=
 =?utf-8?B?VzUxL0R2NmZqTjlsYnB6ek5Ocy8zOFljWUZmQW1ZbE5DaWVMakdNd1g0Rmx0?=
 =?utf-8?B?NHRsTmZnTHRKTnc5Nnk1dXg2M2RseE5iSXFGTnVzSHcxOUducnhVN2IxUnpn?=
 =?utf-8?B?aGlnZjl1aDdraWMzL2FWTHJ1a25MemwwZFFqWE9aVHJFOHZRdk9HeUR6OVM4?=
 =?utf-8?B?T0R1cytaZDI4Z1RPVnEvODNxaEdEa0dIVjVwYVh2L1pFMDVQd2xaWjhHYWV1?=
 =?utf-8?B?NHJIdEJibzc5eDNmRnF0Vm5aNWpEM2JxYkM5RnhBdkM2Ulpwbm15TDBMeTV2?=
 =?utf-8?B?YWladXNBZllOOFBVenJOYUFmYS9YeUZrYXpYVk5UUDVjL2R5MDAzNHJjSmh3?=
 =?utf-8?B?UVVZRGRWbENid3lrZno5ZVJsRVZmVWNac1Z6UVlQbFpydDR5YzJnNmZDZXhD?=
 =?utf-8?B?Ym54UmdnNVhYRzhZSjBkd2ZUT2sxRkVpa0ZzNmlDRUdzRCtpc3cxR1huZm55?=
 =?utf-8?B?WmhtM1FhZDROakhicHpKWVU0T1dNMHRWRFpFN01hcVdXTWVKalV3eDlpTkdF?=
 =?utf-8?Q?WEjFjhdkvG/EjyWLFsBXq/Md1?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: EWG+I7ulLYBUS5b8YYTSLIuWJai7t8cN10Tv2rf3GPWqA46mS+i2XN/E8bp3myATyouW6/x+xG/QYGYtlpSm4GNBJsn9o2UZ2GqGgptvaLuj9MeeaLP88vCSjxhS4BRLZJ08+/VRzq8MAlAtHU9SwRIW4VW+7c+ji9nyYUuP/ENphEU2g4l+azDaPgCxkWu3Z5VzlOGw8os7R64NAIzmbYJ44r+YUjKmn89FN+b1lepQy+cg1Awdd/0sfKtB5FJK0lCNccodmVKLprlnzY64Gc+XXiD1lj4lC9g5N7wDXyrV+v+1bFLhHl5475nhP0XdTYmdHR/NYbLNBVVF1XIsnun3sB8iAEhfJRFYqMjyXnYVCvjrW2DJ94/28VnU2ntlCwLAbbE6UQgGW+M9ysKeM7cT5gi9uBYZWJ6yKDdGQifAt30qQtQu0i+ekEBUcNVBBezTwHHEuc1r/Jpj4R6yXcLEksu04D4XrGgVtXOrpXw4TG8ANpSH+Wyc31QPW5bFphgRsesmDquesc+HUB85FyIrL5sZm0enBKwRVo56dkBYYbxkBYV4MtgyAqX0axylhc2TdDY0TgGc4s+Xs6+FqGeM3QtJswVwtIz+lVVhh53dselkKVbooPqhDiVC7G+wt7N4/bRmbRcDyLbth1I2PYW6vEfZaZw6x32jk6tN3v527lBH9le/Iq7oMHKs8UkA+sHOBuHC3jA1jVq+4mCnsUIKAky7BvXb542EPYF4qfleo1mJVr32dNYhTXfIG7F3oxLD4rUlL1CLdmT4gtGukQlrRGTDeoMGd7JZ2ZeFPcbejUuR78WgunVRKgUtprUrUp4n0hYoWJICv6ibAccqLQr29pLRCyd37pI9CZ0TJnqNt6mXVlaC7bTABL5eXkKO
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f66c29d-0634-4a6f-b9bb-08dbc05d6d15
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2023 19:59:30.0602
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zIFvWXC8RrizFHYGa5qMcutS5d0V7wBIDG7AW0YinwFVbZWfnOsEHVshTfDkY/GGWO61bkh3/vlOhdXJEJ/GoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4968
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-28_19,2023-09-28_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 mlxscore=0
 mlxlogscore=835 suspectscore=0 phishscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2309280170
X-Proofpoint-ORIG-GUID: 9YDR9VvrE5SDHLNO75n3XZ8y8Khe9mfZ
X-Proofpoint-GUID: 9YDR9VvrE5SDHLNO75n3XZ8y8Khe9mfZ
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--uybnb7adp4e2cyyt
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

* Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr> [230923 03:27]:
> On 9/22/23 15:51, Liam R. Howlett wrote:

...

> > > [ 6413.367326] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > [ 6413.367349] BUG: KCSAN: data-race in mas_topiary_replace / mtree_r=
ange_walk
> > >=20
> > > [ 6413.367375] write to 0xffff8883a0c5db00 of 8 bytes by task 5475 on=
 cpu 24:
> > > [ 6413.367386] mas_topiary_replace (/home/marvin/linux/kernel/torvald=
s2/lib/maple_tree.c:491 /home/marvin/linux/kernel/torvalds2/lib/maple_tree.=
c:1701 /home/marvin/linux/kernel/torvalds2/lib/maple_tree.c:2590)
> > > [ 6413.367399] mas_spanning_rebalance.isra.0 (/home/marvin/linux/kern=
el/torvalds2/lib/maple_tree.c:2664 /home/marvin/linux/kernel/torvalds2/lib/=
maple_tree.c:2961)
> > > [ 6413.367413] mas_wr_spanning_store.isra.0 (/home/marvin/linux/kerne=
l/torvalds2/lib/maple_tree.c:3894)
> > > [ 6413.367428] mas_wr_store_entry.isra.0 (/home/marvin/linux/kernel/t=
orvalds2/lib/maple_tree.c:4242)
> > > [ 6413.367442] mas_store_prealloc (/home/marvin/linux/kernel/torvalds=
2/lib/maple_tree.c:256 /home/marvin/linux/kernel/torvalds2/lib/maple_tree.c=
:5408)
> > > [ 6413.367455] vma_merge (/home/marvin/linux/kernel/torvalds2/mm/inte=
rnal.h:1127 /home/marvin/linux/kernel/torvalds2/mm/mmap.c:1005)
> > > [ 6413.367466] mprotect_fixup (/home/marvin/linux/kernel/torvalds2/mm=
/mprotect.c:632)
> > > [ 6413.367480] do_mprotect_pkey (/home/marvin/linux/kernel/torvalds2/=
mm/mprotect.c:819)
> > > [ 6413.367494] __x64_sys_mprotect (/home/marvin/linux/kernel/torvalds=
2/mm/mprotect.c:837)
> > > [ 6413.367503] do_syscall_64 (/home/marvin/linux/kernel/torvalds2/arc=
h/x86/entry/common.c:50 /home/marvin/linux/kernel/torvalds2/arch/x86/entry/=
common.c:80)
> > > [ 6413.367517] entry_SYSCALL_64_after_hwframe (/home/marvin/linux/ker=
nel/torvalds2/arch/x86/entry/entry_64.S:120)
> > >=20
> > > [ 6413.367534] read to 0xffff8883a0c5db00 of 8 bytes by task 5558 on =
cpu 11:
> > > [ 6413.367545] mtree_range_walk (/home/marvin/linux/kernel/torvalds2/=
lib/maple_tree.c:539 /home/marvin/linux/kernel/torvalds2/lib/maple_tree.c:2=
789)
> > > [ 6413.367556] mas_walk (/home/marvin/linux/kernel/torvalds2/lib/mapl=
e_tree.c:251 /home/marvin/linux/kernel/torvalds2/lib/maple_tree.c:4844)
> > > [ 6413.367567] lock_vma_under_rcu (/home/marvin/linux/kernel/torvalds=
2/mm/memory.c:5436)
> > > [ 6413.367579] do_user_addr_fault (/home/marvin/linux/kernel/torvalds=
2/arch/x86/mm/fault.c:1357)
> > > [ 6413.367593] exc_page_fault (/home/marvin/linux/kernel/torvalds2/./=
arch/x86/include/asm/paravirt.h:695 /home/marvin/linux/kernel/torvalds2/arc=
h/x86/mm/fault.c:1513 /home/marvin/linux/kernel/torvalds2/arch/x86/mm/fault=
.c:1561)
> > > [ 6413.367602] asm_exc_page_fault (/home/marvin/linux/kernel/torvalds=
2/./arch/x86/include/asm/idtentry.h:570)
> > >=20
> > > [ 6413.367617] value changed: 0xffff888341d43116 -> 0xffff888340f9211=
6
> > >=20
> > > [ 6413.367632] Reported by Kernel Concurrency Sanitizer on:
> > > [ 6413.367640] CPU: 11 PID: 5558 Comm: ThreadPoolForeg Tainted: G    =
         L     6.6.0-rc2-kcsan-00143-gb5cbe7c00aa0 #41
> > > [ 6413.367653] Hardware name: ASRock X670E PG Lightning/X670E PG Ligh=
tning, BIOS 1.21 04/26/2023
> > > [ 6413.367660] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > >=20
> > > For your convenience, took the trouble of finding those suspicious li=
nes of code:
> > >=20
> > > The write side:
> > >=20
> > > lib/maple_tree.c:491
> > > --------------------
> > >    456 /*
> > >    457  * mas_set_parent() - Set the parent node and encode the slot
> > >    458  * @enode: The encoded maple node.
> > >    459  * @parent: The encoded maple node that is the parent of @enod=
e.
> > >    460  * @slot: The slot that @enode resides in @parent.
> > >    461  *
> > >    462  * Slot number is encoded in the enode->parent bit 3-6 or 2-6,=
 depending on the
> > >    463  * parent type.
> > >    464  */
> > >    465 static inline
> > >    466 void mas_set_parent(struct ma_state *mas, struct maple_enode *=
enode,
> > >    467                     const struct maple_enode *parent, unsigned=
 char slot)
> > >    468 {
> > >    469         unsigned long val =3D (unsigned long)parent;
> > >    470         unsigned long shift;
> > >    471         unsigned long type;
> > >    472         enum maple_type p_type =3D mte_node_type(parent);
> > >    473
> > >    474         MAS_BUG_ON(mas, p_type =3D=3D maple_dense);
> > >    475         MAS_BUG_ON(mas, p_type =3D=3D maple_leaf_64);
> > >    476
> > >    477         switch (p_type) {
> > >    478         case maple_range_64:
> > >    479         case maple_arange_64:
> > >    480                 shift =3D MAPLE_PARENT_SLOT_SHIFT;
> > >    481                 type =3D MAPLE_PARENT_RANGE64;
> > >    482                 break;
> > >    483         default:
> > >    484         case maple_dense:
> > >    485         case maple_leaf_64:
> > >    486                 shift =3D type =3D 0;
> > >    487                 break;
> > >    488         }
> > >    489
> > >    490         val &=3D ~MAPLE_NODE_MASK; /* Clear all node metadata =
in parent */
> > > =E2=86=92 491         val |=3D (slot << shift) | type;
> > >    492         mte_to_node(enode)->parent =3D ma_parent_ptr(val);
> > >    493 }

This should probably be 492, not 491.  I know what is racing here and it
shouldn't cause issue.

...
> > > The read side:
> > >=20
> > >     527 /*
> > >     528  * ma_dead_node() - check if the @enode is dead.
> > >     529  * @enode: The encoded maple node
> > >     530  *
> > >     531  * Return: true if dead, false otherwise.
> > >     532  */
> > >     533 static inline bool ma_dead_node(const struct maple_node *node=
)
> > >     534 {
> > >     535         struct maple_node *parent;
> > >     536
> > >     537         /* Do not reorder reads from the node prior to the pa=
rent check */
> > >     538         smp_rmb();
> > > =E2=86=92  539         parent =3D (void *)((unsigned long) node->pare=
nt & ~MAPLE_NODE_MASK);
> > >     540         return (parent =3D=3D node);
> > >     541 }

This is the correct line.

...
> > >=20
> > > as above, but the smb_rmb() protection is here, so the KCSAN warning =
should be double-checked for
> > > validity.
> > >=20
> > > But I do not really understand maple trees to their depth, I am only =
reporting the symptomatic
> > > outlook of the reported data-race.
> >=20
> > This is the most complex part of the maple tree, and unique to the
> > ability to store a range over multiple existing entries.  I recently
> > rewrote this particular section to avoid a potential live-lock issue.
>=20
> I see.
>=20
> > I am confident that the parent pointer will not be set to the node
> > pointer as checked by ma_dead_node().  But in an abundance of caution
> > and to resolve this potential false-positive, I am looking at this in
> > more detail.
> >=20
> > This race is to see if the walk down the tree into unchanged data will
> > be seen before it is placed in the new subtree with its data also
> > unchanged.  Since we know the parent can never be the node, I feel this
> > is safe - but I'm not willing to live with the complaints from kasan.
>=20
> I cannot analyse a couple of thousand lines at such a short notice.

Don't worry, I will :)

>=20
> It looks suspicious because val in line 491 in a local variable and thus
> isn't available elsewhere.

It is used in the node->parent, as described above.  It is a race, but
it doesn't matter who wins.

>=20
> Maybe the compiler (gcc (Ubuntu 11.4.0-1ubuntu1~22.04) 11.4.0) did someth=
ing
> to the code?

Probably off-by-one line.

>=20
> > > This is all-in-all a very interested subject, and I wish there was a =
way to just slurp all those
> > > interesting kernel intrinsics into the brain, but it just ain't that =
easy. Forgive me for being
> > > open ...
> >=20
> > I appreciate that and your detailed analysis with code pointers of wher=
e
> > this happens.  Is this easy to recreate?  If so, how?  Can you attach
> > your kernel config?
>=20
> Got that attached first, so I do not forget. :-/
>=20
> Recreate? Actually it happened quite a number of times on my configuratio=
n (480+?).

I'm having issues recreating it because I hit a lot of races before this
one in my test setup.  I will keep working on reproducing this race, but
in the mean time can you test the attached patch with your setup?

...

Thanks,
Liam

--uybnb7adp4e2cyyt
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="race_fix.patch"

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index ee1ff0c59fd7..8f68582451c4 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -1699,6 +1699,7 @@ static inline void mas_adopt_children(struct ma_state *mas,
 	do {
 		child = mas_slot_locked(mas, slots, offset);
 		mas_set_parent(mas, child, parent, offset);
+		smp_wmb(); /* Needed for RCU */
 	} while (offset--);
 }
 

--uybnb7adp4e2cyyt--
