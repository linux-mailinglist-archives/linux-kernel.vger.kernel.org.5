Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AD7B7A2A62
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Sep 2023 00:17:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238147AbjIOWRs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 18:17:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237954AbjIOWRN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 18:17:13 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E15AC83
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 15:17:07 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38FLviaD025851;
        Fri, 15 Sep 2023 22:16:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=fR0foe/sV5Sumv5EvmNzyoFAm34AhjLE3kM7pxcILow=;
 b=cVlxG1ziPRjon1lSiAP7Gx8+qeBaUba/zMsYSP7cnMvh3ZghrI0ThFgEDtn3LNoODhh1
 3oBxSCiDq71i2Ufua6jP/c1IjrJWXgxFWLAV2LTXMPyIxXcdEvQCjtakluxEGugEmU32
 rwQq7+Xpt951BEgucBtIeBL8UnPXGA2MUJdXN2JZSgjvAq3p8RiyqNXnHHADjSb/u0Xw
 +hzVLERmorw36n2OJfVhHUU0doEBBc6RawYrfU0TKfKwQixlGEegvx5XmTmVkBBJZyt9
 PeWdySeJVEtEC3Wf4X2rVdS1pP60GtXjOchu7IMgzSbOpatEdRApvZ2mIz27FUg/CV1v jQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t2y7n0k4y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Sep 2023 22:16:27 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38FLb0xI008807;
        Fri, 15 Sep 2023 22:16:27 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2174.outbound.protection.outlook.com [104.47.59.174])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3t0f5awd55-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Sep 2023 22:16:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nMWIzJuAObHBG52dU6yhF0tD5WRm4WNISyH04Tt116RG0MWW52Futa/X2OSAJpjejjH23xZSManhbgFlm32yac/Mk+/wDu4rQlcbRJCwoVBmxbtDZUOO/aM91J0YvzcG8jm8ncIQPYoKbW35rixP6kvxxt3LCM5Fwq1TWC+PrWEDoZ61XVN5r+UzPE88OlJY2DMnAtg96cw19hyqZL4pEOsy1ZX/IUzs7OH4ME7j2NW9q2LPWT+Pk0NDDF7erT/VshsTbZAY+H/qggO2ntDrw7Ad6e3phwiWwOXsldiabCj+6wyWP5MXBfSM4bsNYVlWERPT2jZ9xvvowWdRRnBwaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fR0foe/sV5Sumv5EvmNzyoFAm34AhjLE3kM7pxcILow=;
 b=npA5NsGIMmG1a+7X0arzQ70apfAQCOlVoYEh8KsI/B1/bdVY/2PvDT2Qf2KN4a12aw0XBZhvvgSdazS8I9IRJC7DvOS9zh2i4Q8/o0j0MP+Q3OgavWiXDBs247PrmcrA7FVWNE0RAhLXwcu+3/dxNUov5O8c3k/AYlGnoNEtu/r89dTRMM9aQhBIIYUx75FsZG8k0jQflJdpEuJaWlx3RGqQ2jovT8BhZTYNSVVTGgxVyLcQi4rBokHSLF0+losnr8fuIydvXgh1Dnbtkn0M8GuJlL1PLicVMOU3KdDXfHoNmQ/WKZRicAXrxZ+ExBE2ofz0E9EyoMZXizASW/muTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fR0foe/sV5Sumv5EvmNzyoFAm34AhjLE3kM7pxcILow=;
 b=Rvq6XiU6wjNWckoP9ZvRctqY9JXUAJ5ksgqfl3X/H0fQDGzGvQ5qtaZSx+vcTrBUTvaZVVk5l9G4oLaAP2XBUsb1enpp7oEXZhiBwbEjxptljtpVJiLw09MQdLsEX1BQjSpyW4SZAH6iEC1HGpXo5zaBSgy0EkzFtUXpPyfgH+U=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by MW4PR10MB5861.namprd10.prod.outlook.com (2603:10b6:303:180::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.34; Fri, 15 Sep
 2023 22:16:25 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c621:12ca:ba40:9054]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c621:12ca:ba40:9054%5]) with mapi id 15.20.6792.021; Fri, 15 Sep 2023
 22:16:24 +0000
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Muchun Song <songmuchun@bytedance.com>,
        Joao Martins <joao.m.martins@oracle.com>,
        Oscar Salvador <osalvador@suse.de>,
        David Hildenbrand <david@redhat.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        David Rientjes <rientjes@google.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        Xiongchun Duan <duanxiongchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: [PATCH v3 12/12] hugetlb: batch TLB flushes when restoring vmemmap
Date:   Fri, 15 Sep 2023 15:15:45 -0700
Message-ID: <20230915221548.552084-13-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230915221548.552084-1-mike.kravetz@oracle.com>
References: <20230915221548.552084-1-mike.kravetz@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0201.namprd04.prod.outlook.com
 (2603:10b6:303:86::26) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|MW4PR10MB5861:EE_
X-MS-Office365-Filtering-Correlation-Id: e8ca82fd-ba7c-4bd1-62c8-08dbb6396638
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FnYUU+jr7yYOLNKTYoVsW5nqTom7s3SrhSiJoExhqGgoC/rdPlqItVgBfBmM1U4gogovk7gQLLVVNHoy9OKdqH9RYtXWaJ9ncNVoc9EOyM6FpL+S1DYm9tDyAojHbi4TEbreEia7BDJd35fxKYiUDqt0HvsM7aVNAJPbCTiBHy0WgQo5i3DHt/5q7dwcnIqmiNP1EhS7Jilf5X7LbKE02/E4/EIcXwqVIQprvmI1tX96BXcx0mwWINxZS58inx5jjv/kNGCSB8G5RnTmdCs7BjZR06sU2OADkz0gMD/1nXnyaBkx+EC/XXII18K5FRI152fWm8rw1vidLgFPPiiiiFRCLTCHhIR0YaUmXHoFC6mMgCaDDLYhdJRoGQLku4vpfQ6bd24ey+6LIj4gkHyz8DYc4usiglDCgLppGLqgoTMox4sW1Tycl08X+/8uXSGbY7ZCRlfvyy+Z7vt3DF3Y5/LHhP2WWWBXQr+jHA2cx4kXNoOaad0rcY8uX/FXoBqTNN5BIFF3bzV6SGlUoBijC8FI93otxx/3WlvXAeYZqJr+ULe+EoNJYW7apT/rzxfn
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(39860400002)(366004)(376002)(136003)(451199024)(186009)(1800799009)(44832011)(86362001)(36756003)(83380400001)(2906002)(38100700002)(478600001)(1076003)(2616005)(26005)(107886003)(4326008)(6512007)(41300700001)(5660300002)(6506007)(6486002)(8676002)(6666004)(66556008)(316002)(66946007)(8936002)(7416002)(66476007)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0uJwDlDZxbAHEdtFmkAyMsyQdOMk8QWEWHvgpWCHt0RBK59yIJW+FPIOrCOT?=
 =?us-ascii?Q?GfbQMkmlAz6G8zX7thrqx4d9LrbqLZpYHaClHeGRmfkMR8HwkOkXkODrr+vB?=
 =?us-ascii?Q?izD6H3Eew+4gf7AxoHo4gjkPD4Fi8wmUgTV0tUx/fQQOZmtT4RKZhlPkC4OZ?=
 =?us-ascii?Q?BV4zVekkFVvbRX+fi7T7MFf56lAfksRMmW1az5yPctW6PoTvu7pcr/e396IR?=
 =?us-ascii?Q?bIsRn/mQRkSo/GOjuJ34VtqYhez3icf2PAnW/5IYWT8BN/ABNnqAahC+oNtS?=
 =?us-ascii?Q?TauQmHSFAAC8ofImVhageKRVBwOGYaXFvAp+mczVA9My24lkxBuIWjOLKf85?=
 =?us-ascii?Q?yLfqpaXMdpBnAoBFYwYq2QaIV173QqUDkJBS/xX48pWkDzw3277DkVj2pEbh?=
 =?us-ascii?Q?hLUSfkfTYxk3M501iBLB0LZ431XsBbh3yYCFlsR3kNbrL7qQobii0WAHyDZB?=
 =?us-ascii?Q?C1W6AnIzo4DAV3ypTd/w7IuqHKT7RXbR+xPmYSEAlzloSnIl20AdF4l+C2Y3?=
 =?us-ascii?Q?qcJonaylm6HVZxhb+yi051pbvDYpmasLzil3GGXIQIUkmA73RkXvxjjgLgU3?=
 =?us-ascii?Q?ZbyGqyyQDkDEs6lLKmlvmST+YSKZO4U3tjhP5pUeBMMGLZBpY9epVm8RdYFK?=
 =?us-ascii?Q?EDPAfgQAJotd78CDVEwq9iEI7v48Tousi1jRgt4YdOS9I9XLv/TKbS7PhBl0?=
 =?us-ascii?Q?3hNv3dEFECtfeJanueRlilZzek7/HyHhqUStX28SSOYseeS9tKjQAhi36acS?=
 =?us-ascii?Q?ogCstzNezsWO4xFLHfUQj040Et0nZE3jYT0k8YX5TjrRmovitp1cfe8dj7zH?=
 =?us-ascii?Q?VlKgECEQlUX2GDJK+IA6a4OmxqRzxB7PLkz3DV0zYyVKZVhkhv3/nJ/heEEf?=
 =?us-ascii?Q?RXlhHTdMZPgXKHSwEhemKRsncnn7DaHFWnnGRl6xKAazHhffuQAG3mV95qOr?=
 =?us-ascii?Q?ytJEKY7cjCoqPc2cWShKHr05rbUQv7KAFXYYiBlGbVGFgsyqLwU8vE3wFGWY?=
 =?us-ascii?Q?74Q5ubwenz4NZpLhCUL2FL+MLrK7XuYbPBiVnrnGiTqIJGCL4Sf7pTEkJeP8?=
 =?us-ascii?Q?64wkjW1WrBB+7ewbaufVJ9Kj0r9KP14yGnRLwrgrpuZ0pJlA4FJ1dMXvBkqv?=
 =?us-ascii?Q?FDx6I3epWAer3ltYL6RxHfQtE3WA6vsR714y0McvLWd7g8OR7lZLZEheEG/y?=
 =?us-ascii?Q?tOBpOSKo7oFfydyk+YXK8vVyYTP1Ki/43O8+wIo618pjjxtE+bGtShtDMUDq?=
 =?us-ascii?Q?jPviGt3vhWZTsBUGNlTTanGfnrJX4JsyJWUKU+p6xtUVOQz8GvaPA8A2zOR1?=
 =?us-ascii?Q?dMGlOLZ+U2uTlkqIGUKxDCYLf9nGMHn2X3uHoYn0TluVCGGEJvkN0dDuYR76?=
 =?us-ascii?Q?xP/sbSp8acSwmwmL0bpGTmblk/wB+RrV2IGLuvf1SfVbPRX7TGuBmGjxyTnW?=
 =?us-ascii?Q?WSc2Ff9FaleZwCyCZm7L2WJVb7subBsIkzMPZWnsYbJJKVWwUIrt3mHJ0xRp?=
 =?us-ascii?Q?h3vJO8h4/l/nusGXzmh1QG6D8LPJnbeaG+5JRZxMGJDGN2pHVOURkYS/H99/?=
 =?us-ascii?Q?HGEiW6wL7OiD+qUiDeMYcWnntwo4JJ4ghA6cuVZ2kSiUQ51/VcSlEbMHeK8D?=
 =?us-ascii?Q?tA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?noXzunz+VW1vfjvQamsOS6IEmED47Z7TSxbIp4gbo+QT6Nj7XcImYythUBKP?=
 =?us-ascii?Q?j2t8KtZkjzvXhR5uq8tNWENn/VjkWPWhdLHSVcK8EQLj65Hun3q+ZOBkrb9p?=
 =?us-ascii?Q?LFqzgw8SRZnei5ufFaZF9iPUjm7b3/+M+3qeFMiTejFIwxKQEDLLhWAUS+mw?=
 =?us-ascii?Q?njiIUx9HALwF/occtqh09A2b1SnWebAGNOfZ97F/oKNLBGAnTsPq3VstTEgR?=
 =?us-ascii?Q?vR6OKC+owg7/yE1sWz19jQLguGFC9VbaRVnGQRW5zFVqD7/aWiw1Olr/fXKS?=
 =?us-ascii?Q?LCm2tXhQE0vORYJ5RQilp4e8UqOdg6jR4/UEeFVmxeYusy22hP1lVl+Z8uAP?=
 =?us-ascii?Q?SnqSC4+jHGZU2nkg8SnsRU93XsYFMwDO47TYyINskhHV5dx76YegUAaVzANp?=
 =?us-ascii?Q?3RGMEIZkbZZKe3kArv8fQJOiVjKeLvhC+Prq9bAQafdvFjsgJVgrSl6DNsBf?=
 =?us-ascii?Q?VRGZhNOTkSByCZzTQ0lV0f9k4bMboYwdunE4lBuNEfqeNVV4BA/aQWJcDyuq?=
 =?us-ascii?Q?DJ08taSsC6ZChcTPASOa+/5uTsmy64ijCoovAmX4EYBgrEsKRbYu4fc+vmKl?=
 =?us-ascii?Q?W61Xhotzv2owus0HqVUghUp5e+8lco8U+F/sA1LbvFTszLwkz2oD4fHBXS8e?=
 =?us-ascii?Q?EGLN/gWafYDqQ0r1L/L4qYiJSD1FAlvHAwmosxNjI5n/E5Qf9cF/aYXPRYUB?=
 =?us-ascii?Q?50GWLmbD+aKWF3DT/qds3DpPCIeL7NCQAyIumq6is0xss7p4LEPxFoq+awhX?=
 =?us-ascii?Q?U4AXv3gpiE0/AWRSudkmCZInjKgMaccm6FW0tbiGmh24gbWsHzH9yIry3e7k?=
 =?us-ascii?Q?jI97KpY1XhXein6Nu2cFC/YzTJTrGhwRYZpCni4cka1Wwti/jvnpUwTlM0p2?=
 =?us-ascii?Q?scVkxY8oHo2AW6HCaksrbIj/mSz2ow5pXT63bmCMPf3mHXvO+dkcbt93pIq4?=
 =?us-ascii?Q?kFHyDOVaBNK+b99iD9YKjJPmCsQp7MDuvmnq+yf7w909yhX9MUtna4aq/fuu?=
 =?us-ascii?Q?cHudebMM11HzSvJ2GNj+RqCxWd9lGbGE2Sdp0EChsJWKWtmP4IF3/G1AfL2p?=
 =?us-ascii?Q?ujxfSzFQZBRuTVqqYlu/7XkeC3Dk8YRrHIuM7myMATN3I1wr2T1RiR2ohsyk?=
 =?us-ascii?Q?U36cKEUc/Eh8?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8ca82fd-ba7c-4bd1-62c8-08dbb6396638
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2023 22:16:24.8774
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4xh6rb46FVTquit+qOmfQh4Nx7cmfoIC8fMJuy28A8LajsLFEnXguRwk4dLstxJ1KqY1mgDNZl2HCGSCWSB5Mg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5861
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-15_19,2023-09-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 mlxlogscore=999 phishscore=0 malwarescore=0 mlxscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309150200
X-Proofpoint-ORIG-GUID: _7KwDLtVsLlD14n7b_LTNmnQAai-P1V_
X-Proofpoint-GUID: _7KwDLtVsLlD14n7b_LTNmnQAai-P1V_
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the internal hugetlb restore vmemmap code path such that TLB
flushing can be batched.  Use the existing mechanism of passing the
VMEMMAP_REMAP_NO_TLB_FLUSH flag to indicate flushing should not be
performed for individual pages.  The routine hugetlb_vmemmap_restore_folios
is the only user of this new mechanism, and it will perform a global
flush after all vmemmap is restored.

Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 mm/hugetlb_vmemmap.c | 39 ++++++++++++++++++++++++---------------
 1 file changed, 24 insertions(+), 15 deletions(-)

diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
index 921f2fa7cf1b..0e9074a09afd 100644
--- a/mm/hugetlb_vmemmap.c
+++ b/mm/hugetlb_vmemmap.c
@@ -460,18 +460,19 @@ static int alloc_vmemmap_page_list(unsigned long start, unsigned long end,
  * @end:	end address of the vmemmap virtual address range that we want to
  *		remap.
  * @reuse:	reuse address.
+ * @flags:	modify behavior for bulk operations
  *
  * Return: %0 on success, negative error code otherwise.
  */
 static int vmemmap_remap_alloc(unsigned long start, unsigned long end,
-			       unsigned long reuse)
+			       unsigned long reuse, unsigned long flags)
 {
 	LIST_HEAD(vmemmap_pages);
 	struct vmemmap_remap_walk walk = {
 		.remap_pte	= vmemmap_restore_pte,
 		.reuse_addr	= reuse,
 		.vmemmap_pages	= &vmemmap_pages,
-		.flags		= 0,
+		.flags		= flags,
 	};
 
 	/* See the comment in the vmemmap_remap_free(). */
@@ -493,17 +494,7 @@ EXPORT_SYMBOL(hugetlb_optimize_vmemmap_key);
 static bool vmemmap_optimize_enabled = IS_ENABLED(CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP_DEFAULT_ON);
 core_param(hugetlb_free_vmemmap, vmemmap_optimize_enabled, bool, 0);
 
-/**
- * hugetlb_vmemmap_restore - restore previously optimized (by
- *			     hugetlb_vmemmap_optimize()) vmemmap pages which
- *			     will be reallocated and remapped.
- * @h:		struct hstate.
- * @head:	the head page whose vmemmap pages will be restored.
- *
- * Return: %0 if @head's vmemmap pages have been reallocated and remapped,
- * negative error code otherwise.
- */
-int hugetlb_vmemmap_restore(const struct hstate *h, struct page *head)
+static int __hugetlb_vmemmap_restore(const struct hstate *h, struct page *head, unsigned long flags)
 {
 	int ret;
 	unsigned long vmemmap_start = (unsigned long)head, vmemmap_end;
@@ -524,7 +515,7 @@ int hugetlb_vmemmap_restore(const struct hstate *h, struct page *head)
 	 * When a HugeTLB page is freed to the buddy allocator, previously
 	 * discarded vmemmap pages must be allocated and remapping.
 	 */
-	ret = vmemmap_remap_alloc(vmemmap_start, vmemmap_end, vmemmap_reuse);
+	ret = vmemmap_remap_alloc(vmemmap_start, vmemmap_end, vmemmap_reuse, flags);
 	if (!ret) {
 		ClearHPageVmemmapOptimized(head);
 		static_branch_dec(&hugetlb_optimize_vmemmap_key);
@@ -533,6 +524,21 @@ int hugetlb_vmemmap_restore(const struct hstate *h, struct page *head)
 	return ret;
 }
 
+/**
+ * hugetlb_vmemmap_restore - restore previously optimized (by
+ *				hugetlb_vmemmap_optimize()) vmemmap pages which
+ *				will be reallocated and remapped.
+ * @h:		struct hstate.
+ * @head:	the head page whose vmemmap pages will be restored.
+ *
+ * Return: %0 if @head's vmemmap pages have been reallocated and remapped,
+ * negative error code otherwise.
+ */
+int hugetlb_vmemmap_restore(const struct hstate *h, struct page *head)
+{
+	return __hugetlb_vmemmap_restore(h, head, 0);
+}
+
 /**
  * hugetlb_vmemmap_restore_folios - restore vmemmap for every folio on the list.
  * @h:		struct hstate.
@@ -557,7 +563,8 @@ int hugetlb_vmemmap_restore_folios(const struct hstate *h,
 	num_restored = 0;
 	list_for_each_entry(folio, folio_list, lru) {
 		if (folio_test_hugetlb_vmemmap_optimized(folio)) {
-			t_ret = hugetlb_vmemmap_restore(h, &folio->page);
+			t_ret = __hugetlb_vmemmap_restore(h, &folio->page,
+						VMEMMAP_REMAP_NO_TLB_FLUSH);
 			if (t_ret)
 				ret = t_ret;
 			else
@@ -565,6 +572,8 @@ int hugetlb_vmemmap_restore_folios(const struct hstate *h,
 		}
 	}
 
+	flush_tlb_all();
+
 	if (*restored)
 		*restored = num_restored;
 	return ret;
-- 
2.41.0

