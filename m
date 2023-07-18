Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26C4E757111
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 02:50:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229982AbjGRAub (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 20:50:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbjGRAu3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 20:50:29 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CACB310E4
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 17:50:28 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36HKOM3C026874;
        Tue, 18 Jul 2023 00:49:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-03-30;
 bh=DRnyZR/Wk+eUAUvLkL8qpZKsrsHh81szOQqei1HDGUM=;
 b=BY680ZCAxUUvZfdoDe+haG7beFU7gfgQUOkeBALSVRKY6OghEUl9V7pvLx24f2yS9pGt
 Uk4nlhsVUlBekaVPNQacIrSrkHg9/3nCznAKBxr+3BeEH3wNMscgPv5cBW/l5iAy/QS/
 /18hP3xkc3Wxlvx8wl3PHC+qIzS33ZfLfkuSoeHxOALiPmBtl6ZAhCRqr80nsKxRhoDa
 BcXz2CY8QuJWom7HJWWiJRHdq1mVth3h0tlU15l4EZt4pbmTcC7Uyu5WhxVN3oyJ52wb
 HJsWLtqSDlLpMu/nqz0yT44RTS6RcLQHjOXvE4UTXByMxoa9uLD60PuRCZNzMK6Wrjbf jg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3run783w7k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Jul 2023 00:49:51 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36HNle8P000794;
        Tue, 18 Jul 2023 00:49:51 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ruhw4dbfd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Jul 2023 00:49:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A0VjlleffXVnmXTD/dM8bu4ba9UCsH1SRr3yRfF5IG6ZPYKUvaBT6Ky4Is4mElEE6LA+qjRNMf/HVn+rBVjUc5EcRURNwF1G9apXEl23c0FAiIIrbZjQlHoYs9KVcojmxc5FA+WkSUgbvxRYdJcvUgEbszL4WCnN8k6mJ43qOqei7itVSYet7zUeljr53JxrVmoLNelNnhAtrKKwM10/4knZuaUfQ+UEEM584XidZ8dGc5GKYrcyVqgkm5A1bBRjTZ59xqJUMjNTzaRNVMUTEkQf+QNbrgmMV9jt84fxC0lihrO6SUHj12Tvc5pLHZzbw4wKzlZqYtsUXUul+eCApA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DRnyZR/Wk+eUAUvLkL8qpZKsrsHh81szOQqei1HDGUM=;
 b=jP+P45rEHT33A3hzL9lVB6K6pxPiDEvmKV++kZT6UxYiiGCo9UcerYtgcrUWqNlSMLlh/eMYU3LEwpoTeJG4XSPP8h50pQlN1ypl+nMEtAxbH9x0+Slo0khhRJwcD49MeZdlIN2dwtI78ozQEVCFYVva+wVuOVEile2TPyiLt0QjmBdpLK/ny8f+mCd+ZJ6kSzWo8jrhrkBsYK4A5LVR8L0OVzSmnIItqqq8R5kCaAHnnHsWr45sAZSltKL93RMYkGy3BMqDXmLCwLXmZHayFo2cbMz/19TAQW0Ma18qT6sVlKmNAlw9V3SA2p8Bj7JH+Xbs73JuhNoFKt8z2rDgnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DRnyZR/Wk+eUAUvLkL8qpZKsrsHh81szOQqei1HDGUM=;
 b=reMSQwYzk1S+ThgEQ51GUIFxckGG6BXfU4HcUQkkEZECaBvgrkOwx8XfJ+aQ++H8rhBB71uEQsQ1M8PhQSthIfovMo6ZsP+VUEe1bQu8hPL9sjZWHw7IyTpBLSGdimk/un/rRVjRrfPClmFvbhoGDYtnttUG+LiZTP4XUGSixw0=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by IA1PR10MB6193.namprd10.prod.outlook.com (2603:10b6:208:3a7::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Tue, 18 Jul
 2023 00:49:47 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::4a17:13b0:2876:97f2]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::4a17:13b0:2876:97f2%7]) with mapi id 15.20.6588.017; Tue, 18 Jul 2023
 00:49:47 +0000
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Jiaqi Yan <jiaqiyan@google.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        Muchun Song <songmuchun@bytedance.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        James Houghton <jthoughton@google.com>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: [PATCH v2 0/2] Fix hugetlb free path race with memory errors
Date:   Mon, 17 Jul 2023 17:49:40 -0700
Message-ID: <20230718004942.113174-1-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.41.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0158.namprd04.prod.outlook.com
 (2603:10b6:303:85::13) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|IA1PR10MB6193:EE_
X-MS-Office365-Filtering-Correlation-Id: d1c233eb-87bb-4cfe-4beb-08db8728e2b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: I/GxIFE7G+UYR+1X09RXlh0/G0ai3rjNSrL8mCCAPJY6mhDHUgQuhFkbiw7GiHPK+lgcO2iWayd7jug9x1e+uZDyG7gbTM5VEsmf0L5lIaKgWd6+bkBMErC+KnHO/CQwPtV/p5yBEzAczr75L44P6wr9NMrr6BoKM/yib3tcXSxayK7h2Wezx7ZT9GBQz0R3KhrLA5V0AtPZeLLnGCcl4EqxjkuNtvk6frwpOZRexAP+M+6tPF72ABEEhne/FO8L01dUbhRDu6olxje7O2o0B2ejuuwHWiZYKjr+pPTUrs5V9qm1VBLd4m5t8FIcVYsU6ahz78GWNDyiXQUAuWaUxsbh9Gd0RbjK6ET8ZG2PShAgxr+JDtx9OAvLjlrtwKWDEf3dV1u2/+SQAvD6yXMn8VTnDNYe7GV5GLnON3GTTqrVi6ULXz540Ciw6PqtrpGZAW9SxPDwPexvMTkOD/9hhGQ8rtxRTaxrRcsRiJYJ3R1ZKh/lAdqYsYRs2UDihtlKt0VsdRnjYyGEuCf1XOQlNKwLMvo7JVxEwFhIZvpZy+Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(396003)(136003)(366004)(39860400002)(346002)(451199021)(54906003)(6486002)(38100700002)(6666004)(41300700001)(8676002)(8936002)(5660300002)(66946007)(66556008)(66476007)(316002)(478600001)(4326008)(186003)(83380400001)(6512007)(966005)(2616005)(26005)(6506007)(1076003)(107886003)(86362001)(36756003)(44832011)(2906002)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bXjyviCVygO6f7J+hb3dCN8YDEB1e0JhooRFXwkF7nvb5Xn5P7kkucqiF6KM?=
 =?us-ascii?Q?HhqjLXAkNWngW8+7wSPSY0h2ijGxNKpRYEpTUeYW++Aex9/HJin3sp1s/O1j?=
 =?us-ascii?Q?s+d4bLCGWNwzrUeyfgSBUh8BZrjNV2aTFBogull8ihthxYQxcsETdAuF2H0r?=
 =?us-ascii?Q?DH/SjPaAt6qIC2mKzNA9g0PQHC+oqUggpgtseGy5Ks2HSt8T3c9rH20IxQMN?=
 =?us-ascii?Q?eHZ9QQs6Gv0zaOe8Uazbsm/tl5/MabaNaLru7KlAejYEwI3wsPcGmGoxKd5f?=
 =?us-ascii?Q?OG9juOEx3kd/IBOAZkObHznk2AzMJWH1XL7eXPgkUpyPGlITVYdaO2bL/cum?=
 =?us-ascii?Q?gIUWrYQsKa09cPQxR8zF5apasqkTS3kinS4Lr/yqtIm+oMRufRZtoMuaY5kD?=
 =?us-ascii?Q?HiKcE32uVWwqDOV7G7O0Lo8pc2iWLg1WfIvldUU8FmG3xx8LY/tcDZEBKP/r?=
 =?us-ascii?Q?cDln9Aq2zTUgETJ6o4f/thcmdUswtwfxjDpda1/NE2JaIlLDF3J9RCkP4Ktu?=
 =?us-ascii?Q?sEOPhXNo5FVoXqxbX3v89yJd1oKqZhE2G33xBtPZwwuNQQGqwmLck0V6JZlX?=
 =?us-ascii?Q?PeMomkzVtHOR6/AJvoIy9KKO2P4tvHwQ3ue/mVpdOFq57e8NISZ8KbezjRpW?=
 =?us-ascii?Q?8lyEPEMhtIQ4VKZVQQ/pBnDArHh443dLvOSgNtF3vFz4qkqgiR+N4/kf6X4f?=
 =?us-ascii?Q?CoZJnjwV7KBlnMsNtUzd877LVKh4sre7BfXAerLEKYgEKdhxGXd0mWtstmwX?=
 =?us-ascii?Q?WxONbaLgQpwdG5tpeSXCn4Ti/h5dSf0aZAfTB9E04MCUejVnKnVU6uCqU0nl?=
 =?us-ascii?Q?tr9GmJ9z0rJpHgxAS14e34LGPNt111CkYQyttpHgC30shfIFBgbCWvqT5CFI?=
 =?us-ascii?Q?+HvzYeykUoDkAEC0Jqx//8PpMJMIHZjA/6ISdkWurKd18zI9f5CP44losmKH?=
 =?us-ascii?Q?quMTbY8uw4iYjCHjhUEL9X18D9cQxtkv7/Mxk4Ekpn/B26Fdtr0wNmttUJ1m?=
 =?us-ascii?Q?PzcwwS+jX6Tqwmu+mRG8EFbxn132Q01wgi60MzviLteS4nuq+vOtwxLnLB5K?=
 =?us-ascii?Q?6sKTDJBjFRdtOgwIQRWXOmrxhWaGqOmXFrwEfdnsu/gzCh21UeEvsj0M9s/W?=
 =?us-ascii?Q?stM/Sz2Ipsa0uHQk0l28zC6Dgy1AFD4bF8RyeG1CCgpA9vnWYRd+sslxf1uA?=
 =?us-ascii?Q?kElotRPXWpnECj1zatbe7D5KEzKlhU1ygPkLGeUWgj5n3wXQiGCqIwjZ8eSl?=
 =?us-ascii?Q?VV7XU//PYubFzYWGj4YstGwUP/NuONq6e2NDI9WdnDPVst34P8Wi2ODk6pf8?=
 =?us-ascii?Q?clwx1/wuCAQdS+HY3fIBcDENCO4GSFM5Y7lVzCB75Yd/vG/qWmyUQItNaJIK?=
 =?us-ascii?Q?i6TZnR6wi0VbW8HrbpoxD+STiGUa2B9jZuwl5Ook/C59y1Gwgy+Jpa9xRCiE?=
 =?us-ascii?Q?8h8FQQmVUaOTnAGZ69w7y1KMLWSWbXS9oZGEgL/T9Ko3EtafO1KxkFIi+X5q?=
 =?us-ascii?Q?xiO6IEv5SEIrYIv6RGLq/cOwVh5V6tBro+2hkE4+MKaCzMPYdIB6zs2XuhQn?=
 =?us-ascii?Q?+gBFlSDjmAyEBWNjHQGui0+Vrl3SG6/GZON1aWDZ?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?MgEO5b+awdwTeABYWVSGojlmzbQLoghW0BwpJlCMylFTNdAiSwuJIy5oOTH7?=
 =?us-ascii?Q?XnotWuJUUY9GDnvvkrQZ6KYgN36hINw2yKiAnCa+0HGD5RUtX7+DDjoccWLq?=
 =?us-ascii?Q?gsskEC+U113GA6Z2i/zDOhzBoK1Y9w69p1h/dLIR1dGRTRGoTryQ0TjonRus?=
 =?us-ascii?Q?Vphp1dgYQruvGmeaEDEZxjaceywSJeUEgx9sRqHZrbbWeEhZShkX3DvX5jGf?=
 =?us-ascii?Q?y66h6B3beAznqD/SJGRM1zJmw/KipQjZg5p+qBUs5Hq1JNk2cRTj67xfZ+pf?=
 =?us-ascii?Q?4Pb3/pLHJjse1/zWUdb9oC1RHXul5ecd32dfdmX0WyFAYy+QEsJDJ5/+KLXO?=
 =?us-ascii?Q?X4HkBBNGpdVo8hTGK9s951ZCAuFtbgtlVw9yJTCAnEUnXcFOlqQ96+eVN0/J?=
 =?us-ascii?Q?FFvCnzPEvXsk/vBBNcMzZCRRaU0XEJdyvpGdSlFCK8oPf1Sk3Ks0wL/Xfx7N?=
 =?us-ascii?Q?Hs/koBsTR04mw7rPX2eWjJm9aPrYfGA3kZ1QheW5H4o4dn6bthXczjs2FXO4?=
 =?us-ascii?Q?Zmpdpd620qULBgYlRuRidkBBlRzuvqQKV8Fdr36221dWxmsZ5D2FgB1XdoyX?=
 =?us-ascii?Q?ArRI4akwieJFJh8a7u/99/ffKkK/xfnwM1C/JxGUNiSoQ4ZBl03ZokK46ZlO?=
 =?us-ascii?Q?5VHTLSszqx1BCd9J4XbtYx3nAQH5Z+f8k+VZG1hX0mBg/OLe63K/S0v0Ox6m?=
 =?us-ascii?Q?5MFGyHlP/U2frzNJHxYuHSwUgnFRW7BlaVvBqF1PchraBwebobTGc5ulrFC0?=
 =?us-ascii?Q?EVc1GHKI32uxJEhEPnOLIqyJh5tspIONSXJHXC4SGhebMRhrqhC66c/uhPlp?=
 =?us-ascii?Q?WJg2UlZ5m5d1ppOt5CQE0gZrTBPSyav5siLSABvxF+UuM62A0vmPPf2JAuPn?=
 =?us-ascii?Q?YCb+T40JjxRLenb+5ZstNE3QnWVOGHQnHU5ouUFNTlNWzde9FDU1p96n+duS?=
 =?us-ascii?Q?jG+T70t4llbGHhzGac1ihPvkvMRwTZvDcRdpne+pN565TIuo37RdPOfZuZ5I?=
 =?us-ascii?Q?lTny?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1c233eb-87bb-4cfe-4beb-08db8728e2b1
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2023 00:49:47.7188
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c/w6y8wEUJBwRVVee9fsQ5XwDt1c2KA7dy8WcFwXfLqx4y8DNvVoeYNOWunQgDtp5c1JG1ooJurKfM3ZkAHdmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6193
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-17_15,2023-07-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=479
 suspectscore=0 phishscore=0 bulkscore=0 mlxscore=0 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307180006
X-Proofpoint-ORIG-GUID: y1i0gw7E14igE3QXPP2f5WRYCx7ONucY
X-Proofpoint-GUID: y1i0gw7E14igE3QXPP2f5WRYCx7ONucY
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the discussion of Jiaqi Yan's series "Improve hugetlbfs read on
HWPOISON hugepages" the race window was discovered.
https://lore.kernel.org/linux-mm/20230616233447.GB7371@monkey/

Freeing a hugetlb page back to low level memory allocators is performed
in two steps.
1) Under hugetlb lock, remove page from hugetlb lists and clear destructor
2) Outside lock, allocate vmemmap if necessary and call low level free
Between these two steps, the hugetlb page will appear as a normal
compound page.  However, vmemmap for tail pages could be missing.
If a memory error occurs at this time, we could try to update page
flags non-existant page structs.

A much more detailed description is in the first patch.

The first patch addresses the race window.  However, it adds a
hugetlb_lock lock/unlock cycle to every vmemmap optimized hugetlb
page free operation.  This is sub-optimal but is hardly noticeable
on a mostly idle system (the normal case).

The second path optimizes the update_and_free_pages_bulk routine
to only take the lock once in bulk operations.

-> v2
  - Used the more definitive method of checking folio_test_hugetlb to
    determine if destructor must be cleared.
  - Added comment to clearly describe why and when we clear the
    destructor in __update_and_free_hugetlb_folio.
  - Clear destructor in hugetlb demote path.
  - Do not send second patch to stable releases.

Mike Kravetz (2):
  hugetlb: Do not clear hugetlb dtor until allocating vmemmap
  hugetlb: optimize update_and_free_pages_bulk to avoid lock cycles

 mm/hugetlb.c | 128 ++++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 100 insertions(+), 28 deletions(-)

-- 
2.41.0

