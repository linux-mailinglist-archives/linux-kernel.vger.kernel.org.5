Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB6A37ACD29
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 02:41:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231335AbjIYAlO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 20:41:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230435AbjIYAlJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 20:41:09 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46D12116
        for <linux-kernel@vger.kernel.org>; Sun, 24 Sep 2023 17:41:01 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38OMkBQF019937;
        Mon, 25 Sep 2023 00:40:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=x/ssleWl8yTL8a0XIJeSZc6h/9ChBMuzWbujLkXEhts=;
 b=MRJ0g+Os7KBcJZ1V4DLMCVgCyK3c+iLSfXcUJb0WoDxnPUfBrp5tfuqegCGV+MZnhlt5
 pIrxoofenKm3sRUkreRnPzAo4dKLLKupd7MHeg6f+oRWxwpRPjIcfjWtEDDXYy/VmiNs
 porfm/R3lqldW0OsEddnQcF0Mc23jjaXLlcVhRszvZqtsSZkbxpaZUO6i+zs1Hy7hzxP
 BPf9pZTozqGMhvehjMA4QYsq5bgyMlApbAkSN3L0aX5QKrY/468UcWHGAFYn/9Ls9M6M
 +ojwgwQWaxO8q4AnJGuHvRwdekBPCLD5yqEtxufwP/WBH31q4UcEIrLLigPLNHar/iby OQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t9qmuae0t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Sep 2023 00:40:18 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38ONQiWu030565;
        Mon, 25 Sep 2023 00:40:17 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3t9pf3kx04-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Sep 2023 00:40:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DfDKtJhoAS+wGqMp5FYEmGv4prdFKBHVDFhPYvwjGkHtNqNm61Ymrma9M0Tits10hVU5LHzylfV8MFBg/gTGOyFKU/fIKd9hHIlLINx2mFoiZ2BIMdi7xccoJCb6mTZF8T+La3oL/HtFyFDidNaJo9AOlqtvM28GYumPBUbZ2mRPRPA/l7JHaSmf1pdHX9o2rIhC/PO0pSMNi0tmq0KowV4/GZchEZDa1yZEOEJzw8GYolCk1E9qZj3BhUOmyrifG3+CERDvHh0yUCw/lkePKfYQXlMvkRzPXv/pkrG7d/UiPlvol0rPmNfrFLlx0322mJwgZjw3CkVFduMV9Ev0ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x/ssleWl8yTL8a0XIJeSZc6h/9ChBMuzWbujLkXEhts=;
 b=GVW1j81uM8LQ1K2Xxuu4e0gxzKoYf8LNKg0QYt2b4XKLTyGwev1ctzorWyCoGzDr5jyz31W/ItOUHNJio4D48jy17mxc8e6PNumJIW9lEyTNnGhOE2TGLj4VpCDWCF4CXBQJz9mt/9hGTxKAUNn5SZknAaL8xAhfvED90Af2rdq9Sr/n4wErEU1rrCZ6zm2oYnqf6ujmsTlQRX5yiDPEAbYBpTfZnydKyThxScFVQTnHN5X3+36oV1VQhSN0r3SgNaT4Uk0mZPm2BopLlLIu+0Shq6NnXevZHhZKqPzrhcsK+4P079TfEzWWol+i0bIdcGgASfpn9xPPzLyUR4npcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x/ssleWl8yTL8a0XIJeSZc6h/9ChBMuzWbujLkXEhts=;
 b=NPCRh8P1Igas5LfaCVPZhUv9TZBpv2ko6XavACGK5S0RTh+rtnoXcm8PZZuryMjQ04PUMQqsRsQTQAC8rzrLyuhbHVWxl4J1jgumSFkYGyBjOoLQ9h4x8XdLldRz6J6oP37xS11IpEPTnBU9dyvHT1DTYj2JogDY4bpLvx73D40=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by LV3PR10MB7819.namprd10.prod.outlook.com (2603:10b6:408:1b0::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Mon, 25 Sep
 2023 00:40:15 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c621:12ca:ba40:9054]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c621:12ca:ba40:9054%5]) with mapi id 15.20.6813.027; Mon, 25 Sep 2023
 00:40:15 +0000
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
        Barry Song <21cnbao@gmail.com>, Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        Xiongchun Duan <duanxiongchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: [PATCH v5 2/8] hugetlb: restructure pool allocations
Date:   Sun, 24 Sep 2023 17:39:46 -0700
Message-ID: <20230925003953.142620-3-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230925003953.142620-1-mike.kravetz@oracle.com>
References: <20230925003953.142620-1-mike.kravetz@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0087.namprd04.prod.outlook.com
 (2603:10b6:303:6b::32) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|LV3PR10MB7819:EE_
X-MS-Office365-Filtering-Correlation-Id: ee005a7d-433f-4834-ed26-08dbbd5ffbd2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qX2LXKlZTyvHh2hqSvyiC2U9B1MRgJpxmOrJ5rgeFEv0jZ7OTzcUqDGLPEuys8kJ0ILdU7h54qOHV7byJ5Ewc7AFdOkRDRh/vU5xe1rh1nB0RfKPY6oIuzU/xpabLvqYp6dlfo+07kGRKHjCAqgCC458sslyNVUCYzjI5ejj8HGmr69yD8w9cGUcPLaJmzB+JG0RjsSx6sRmcwrFo8PxkfZmtAYVfcz5AaEmjzFOKikhtBsd0m4mqMcENkBS2c+w4I4FmSpfwzSdtAGMwdj/MysQ2xSdRE2pqk1VtE4+HmgZsC2wFYi9/TjXtFkVXEnD+TRcRPshK3bJ3XYoBUsJeG+mteQMOKdpRqXmVY3Sdt52l2saY3gjzeBOaPIXnWzrF3cpewEHMl9fobPYRVvAn/tyVfbbovMX26VgHurmum+0TWg/dvJylGLcb/WwWuw+b7sS5nIK9myIE+fqC5UbXO94Yyu0djniO8LV4rQy6X3GXU+5c9+kPRCDi0gvL1oHic2B3dIjf43VT6ZDCdgFIQfnirJtOon9+j5d72lVGLhMClZau82UArarIh8FiTv3
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(39860400002)(136003)(346002)(376002)(230922051799003)(186009)(1800799009)(451199024)(2906002)(478600001)(6486002)(36756003)(6666004)(26005)(1076003)(107886003)(38100700002)(83380400001)(6506007)(6512007)(2616005)(86362001)(41300700001)(4326008)(8676002)(8936002)(316002)(44832011)(5660300002)(30864003)(66946007)(7416002)(66556008)(54906003)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3U/pcRCzSG9KTbHbXGh+Tx4+DFDEXlHQqAPeiFp5wZ0XxFIgNhixYHoZbPYg?=
 =?us-ascii?Q?/4ZQgtSb9W9xiOhh/o2mMTHcSo1NiFaXjyaJSivmYPKeeII0nvDEi0wEN8k2?=
 =?us-ascii?Q?CEA9yvh3bHLv0sM6SyuBQFXJg3fZDjPxZq0xXYL3PtOdkyoxCwmNlI6mICgy?=
 =?us-ascii?Q?2AQW7nWfgURMXe9sMkjgydtw1kyWmfQBjLn+lClO1XrRtPJVuLfhDBcxhkdV?=
 =?us-ascii?Q?OBlc4YZuX9jDdfEI1QvNCeQJA9B0ICSncIAkm9vBwkZMI6aVg2AcKUH1eUTP?=
 =?us-ascii?Q?G23WIBQe1buuHgJC6hkPPSIt3XdUR0ec5pASMPs7hLvBNSCLfFN8bioBChXf?=
 =?us-ascii?Q?et0hZ5Nk9Zq8gCH/P66AJlDq69oi4ivRmwK4H5HenQzy80ftHAlQHAL462UX?=
 =?us-ascii?Q?f1IyiFJTf29te58Wov6HQTfNcnj9xbiGcMT9EsTBSAXDs0hTmHXmN7GODyBA?=
 =?us-ascii?Q?IW/B6mzat1+H/1vOUoPA/3As5tBK9I/ZlsirMm2ljH3s2sFySwS7oexCs5Y2?=
 =?us-ascii?Q?XkLDviyFgxyIGrOJt2f+TL6W2jobIUXm/7xXmp96KD/cfayd7NRAKblA88HC?=
 =?us-ascii?Q?9tJDx3R1hg4o7AdPtZELFVixvXxWLWQ+ZjhGxOcOhxcS0cSChSq9uSn7QhhE?=
 =?us-ascii?Q?7Aux0Sz8eMGro+W+tGwvaoZ/AWY9ka3ScuZ9FZha788rPDD8nv9xibVP9DFN?=
 =?us-ascii?Q?290XIuMmCbXVeVMTqoVOQmh0KC06ZmiS0C0zBG/N6RGVU9lPtQhgm9GY12uU?=
 =?us-ascii?Q?YR/kcYeyPBGnemySMsRJFgeVrMkFrPfmFDl4+D4ot0GSkIWDl1ST0hEuBMwl?=
 =?us-ascii?Q?3OWdLKUw1AxDNhIdQHvw8JSS5I4xq2jFOhjvMpPLn8B/C9Tw6l0t4knivT7b?=
 =?us-ascii?Q?vIUEkTUrH0Ds0XPC0sg3KZotfw+fHHgkUOiuvizKAbq++yXQQFL+h5GFA1BW?=
 =?us-ascii?Q?KwpfRstIM4jpx0bpExr4Np/zlX+sns0qIqv04gkUqM0jqLwJnjoHLpXr8TMg?=
 =?us-ascii?Q?nxtWftIoPBH+tWhjNkdvqRKPH8Po1AsXZRxoS/rQ2Lx9zxMnCg0IlqMrYRmW?=
 =?us-ascii?Q?CkNreHIqG15v/2K5WLxTqwq/jcJnPoSUbqmYTZ1g/dFDPZ1hFMC73HImkgFi?=
 =?us-ascii?Q?4KRzN7bSRA34kUbWr99m+AwgBkr7l5jv8P+IpZFHaoyLXKig7CFSFBnwHV8I?=
 =?us-ascii?Q?WaPfI+23kfmaO8Ipb4cXT9KP3sKczAVmIinl7s3TzwiOPb1ytEIS66vhYK1i?=
 =?us-ascii?Q?8s/qWV18oUac7nyNskl/vKNQwkBQxH83Y8jPhiVb4oe73C0UiGxgz+s6epJh?=
 =?us-ascii?Q?61BUAr/Zja+lWZRmufXkwScOxERoHzvQJ1R+EPYcGalIci/R1fAJUBzRLr/8?=
 =?us-ascii?Q?notYTfjAp6amZ7o9TqZ1rcvoAxgIc63kMlhphA438iPgNiEVAUZZcO0XIt6b?=
 =?us-ascii?Q?J2fMe3v8P/4VcNEtEA8Abs1RLcGT1maaaxxAqUuX4puWWN2mBGs+5jZsdtX9?=
 =?us-ascii?Q?Z1NENkrM6yUPSyjUNz6w6HiWMYuBmRe4P4mCMCGzVbSwwAeEgD7kmn2tZl6O?=
 =?us-ascii?Q?vyfc4050cRoDag70fQiaQ4hLiHG8FwGF6DtTUVGI?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?E59jRxOWLkj8nxhIelt/YEE4f2SNYKv255OYEJ6xG7INaribjAscLYT9quiA?=
 =?us-ascii?Q?cFEVGyRU6a62uG8nG3YGpZUZ95Ryk9HW/OD4RDDYW7T6q/exWcrezyoOASF0?=
 =?us-ascii?Q?W+tVufuzmLo/DCDByV2Fqc2laX4gzkNYP7Z8MwGUVkK92wXWfCCzfb1wgbK7?=
 =?us-ascii?Q?/8BqfrwZIobyrHJ8JQYxTdviDSEVezRDyjhQxm+bFtJh2W/Y+A2RpnYXmBW6?=
 =?us-ascii?Q?7RJRUWymZERX+hZqIVr9if68Q9IU4LFNKi1nER1kqAYNRr1nbMEsDVF7IR6r?=
 =?us-ascii?Q?j/O5sMHy+UgIIywV6eSZfmwyd0stX3p9u/GYRytYy6Z8ziojgf7JgPblKVHK?=
 =?us-ascii?Q?ePXxkGGo30Jwahz6/9++zXla4K5wxv9EgT/FdPV3s/t+6o0pLcMlzkTeItss?=
 =?us-ascii?Q?7FDuC9+9ZTnBKDYLUGGVixz+LOW9DTSf2lE0GXpbQ+Iwl3WqvEzkp46naVmb?=
 =?us-ascii?Q?Y6+XHQmkzE1USW7ID6etso/h9r2ySEWk1pecmpArVIzvualILLe0yiDYFyzv?=
 =?us-ascii?Q?IjolQ52CK8nj4kXH9xG5i7flURwOVVagXW5UwswOSeApMI8kDk7vnDcKPSJ7?=
 =?us-ascii?Q?TKE5rqbnybPoh4e9VHKbotrHezl88XFhDIjpRlkugrcmzNfey4WIHGI+3yUz?=
 =?us-ascii?Q?o0Lc8ggMk3YECgOuuAu0l/h9hc6lNxT0LFYNn/lX12JffuyCZN6HwKecdOCe?=
 =?us-ascii?Q?eWFN3vVyYeru612KCe2dUQBbn2xPmLKaNuoVKyiUDwRvZd9OJwmFetqPtVPR?=
 =?us-ascii?Q?7lVYJaTeoAi+0/kQazMcH02KW1OBQyjlEANLvmB7vsOziNqXTMLIyR5kj9e2?=
 =?us-ascii?Q?TxoQtr6e2EyNa8pBm3oOUyEG/0ouKw49nqXD8Lh/jeJwxLDMmSgtBt3qNwXS?=
 =?us-ascii?Q?CWKXCHULpZBm7aIyOrQcodpm7Yl1JO1TNkvO7zTpM9HRMXl1oYSjeWqbFaCC?=
 =?us-ascii?Q?ERCiv/ybYLtwH4UwiEIgc464xItp/aZMQWYsdghKF0B8Spz2iocSV+slNYcM?=
 =?us-ascii?Q?JhYPWmhI7dc0f+Hn6MzNzJlhYV0vhxS8mpHwI+eN69sgm1p0t7saomCmotGD?=
 =?us-ascii?Q?wcIU7F+y9wRZp4IXfpDsKlq2WTlW90OeS+BTov6ptwCbgWn2RHJOMgO5tqVE?=
 =?us-ascii?Q?XOWINROMx+92?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee005a7d-433f-4834-ed26-08dbbd5ffbd2
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2023 00:40:14.9167
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mgZu+a33F1ieo4oNSddTax5LyoEqMGJ0TchvVu63zY86o5kY4LB1sDK6SivfQ+kucb77nqWGSQzkrokal+4/QA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB7819
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-24_21,2023-09-21_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 phishscore=0
 mlxscore=0 malwarescore=0 mlxlogscore=999 bulkscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2309250000
X-Proofpoint-GUID: 47kf-UyU0VW8jJYZpEUPyBeCy5cuSIAe
X-Proofpoint-ORIG-GUID: 47kf-UyU0VW8jJYZpEUPyBeCy5cuSIAe
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allocation of a hugetlb page for the hugetlb pool is done by the routine
alloc_pool_huge_page.  This routine will allocate contiguous pages from
a low level allocator, prep the pages for usage as a hugetlb page and
then add the resulting hugetlb page to the pool.

In the 'prep' stage, optional vmemmap optimization is done.  For
performance reasons we want to perform vmemmap optimization on multiple
hugetlb pages at once.  To do this, restructure the hugetlb pool
allocation code such that vmemmap optimization can be isolated and later
batched.

The code to allocate hugetlb pages from bootmem was also modified to
allow batching.

No functional changes, only code restructure.

Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 mm/hugetlb.c | 179 ++++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 140 insertions(+), 39 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 47159b9de633..64f50f3844fc 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1970,16 +1970,21 @@ static void __prep_account_new_huge_page(struct hstate *h, int nid)
 	h->nr_huge_pages_node[nid]++;
 }
 
-static void __prep_new_hugetlb_folio(struct hstate *h, struct folio *folio)
+static void init_new_hugetlb_folio(struct hstate *h, struct folio *folio)
 {
 	folio_set_hugetlb(folio);
-	hugetlb_vmemmap_optimize(h, &folio->page);
 	INIT_LIST_HEAD(&folio->lru);
 	hugetlb_set_folio_subpool(folio, NULL);
 	set_hugetlb_cgroup(folio, NULL);
 	set_hugetlb_cgroup_rsvd(folio, NULL);
 }
 
+static void __prep_new_hugetlb_folio(struct hstate *h, struct folio *folio)
+{
+	init_new_hugetlb_folio(h, folio);
+	hugetlb_vmemmap_optimize(h, &folio->page);
+}
+
 static void prep_new_hugetlb_folio(struct hstate *h, struct folio *folio, int nid)
 {
 	__prep_new_hugetlb_folio(h, folio);
@@ -2190,16 +2195,9 @@ static struct folio *alloc_buddy_hugetlb_folio(struct hstate *h,
 	return page_folio(page);
 }
 
-/*
- * Common helper to allocate a fresh hugetlb page. All specific allocators
- * should use this function to get new hugetlb pages
- *
- * Note that returned page is 'frozen':  ref count of head page and all tail
- * pages is zero.
- */
-static struct folio *alloc_fresh_hugetlb_folio(struct hstate *h,
-		gfp_t gfp_mask, int nid, nodemask_t *nmask,
-		nodemask_t *node_alloc_noretry)
+static struct folio *__alloc_fresh_hugetlb_folio(struct hstate *h,
+				gfp_t gfp_mask, int nid, nodemask_t *nmask,
+				nodemask_t *node_alloc_noretry)
 {
 	struct folio *folio;
 	bool retry = false;
@@ -2212,6 +2210,7 @@ static struct folio *alloc_fresh_hugetlb_folio(struct hstate *h,
 				nid, nmask, node_alloc_noretry);
 	if (!folio)
 		return NULL;
+
 	if (hstate_is_gigantic(h)) {
 		if (!prep_compound_gigantic_folio(folio, huge_page_order(h))) {
 			/*
@@ -2226,32 +2225,80 @@ static struct folio *alloc_fresh_hugetlb_folio(struct hstate *h,
 			return NULL;
 		}
 	}
-	prep_new_hugetlb_folio(h, folio, folio_nid(folio));
 
 	return folio;
 }
 
+static struct folio *only_alloc_fresh_hugetlb_folio(struct hstate *h,
+		gfp_t gfp_mask, int nid, nodemask_t *nmask,
+		nodemask_t *node_alloc_noretry)
+{
+	struct folio *folio;
+
+	folio = __alloc_fresh_hugetlb_folio(h, gfp_mask, nid, nmask,
+						node_alloc_noretry);
+	if (folio)
+		init_new_hugetlb_folio(h, folio);
+	return folio;
+}
+
 /*
- * Allocates a fresh page to the hugetlb allocator pool in the node interleaved
- * manner.
+ * Common helper to allocate a fresh hugetlb page. All specific allocators
+ * should use this function to get new hugetlb pages
+ *
+ * Note that returned page is 'frozen':  ref count of head page and all tail
+ * pages is zero.
  */
-static int alloc_pool_huge_page(struct hstate *h, nodemask_t *nodes_allowed,
-				nodemask_t *node_alloc_noretry)
+static struct folio *alloc_fresh_hugetlb_folio(struct hstate *h,
+		gfp_t gfp_mask, int nid, nodemask_t *nmask,
+		nodemask_t *node_alloc_noretry)
 {
 	struct folio *folio;
-	int nr_nodes, node;
+
+	folio = __alloc_fresh_hugetlb_folio(h, gfp_mask, nid, nmask,
+						node_alloc_noretry);
+	if (!folio)
+		return NULL;
+
+	prep_new_hugetlb_folio(h, folio, folio_nid(folio));
+	return folio;
+}
+
+static void prep_and_add_allocated_folios(struct hstate *h,
+					struct list_head *folio_list)
+{
+	struct folio *folio, *tmp_f;
+
+	/* Add all new pool pages to free lists in one lock cycle */
+	spin_lock_irq(&hugetlb_lock);
+	list_for_each_entry_safe(folio, tmp_f, folio_list, lru) {
+		__prep_account_new_huge_page(h, folio_nid(folio));
+		enqueue_hugetlb_folio(h, folio);
+	}
+	spin_unlock_irq(&hugetlb_lock);
+}
+
+/*
+ * Allocates a fresh hugetlb page in a node interleaved manner.  The page
+ * will later be added to the appropriate hugetlb pool.
+ */
+static struct folio *alloc_pool_huge_folio(struct hstate *h,
+					nodemask_t *nodes_allowed,
+					nodemask_t *node_alloc_noretry)
+{
 	gfp_t gfp_mask = htlb_alloc_mask(h) | __GFP_THISNODE;
+	int nr_nodes, node;
 
 	for_each_node_mask_to_alloc(h, nr_nodes, node, nodes_allowed) {
-		folio = alloc_fresh_hugetlb_folio(h, gfp_mask, node,
+		struct folio *folio;
+
+		folio = only_alloc_fresh_hugetlb_folio(h, gfp_mask, node,
 					nodes_allowed, node_alloc_noretry);
-		if (folio) {
-			free_huge_folio(folio); /* free it into the hugepage allocator */
-			return 1;
-		}
+		if (folio)
+			return folio;
 	}
 
-	return 0;
+	return NULL;
 }
 
 /*
@@ -3264,25 +3311,35 @@ static void __init hugetlb_folio_init_vmemmap(struct folio *folio,
  */
 static void __init gather_bootmem_prealloc(void)
 {
+	LIST_HEAD(folio_list);
 	struct huge_bootmem_page *m;
+	struct hstate *h, *prev_h = NULL;
 
 	list_for_each_entry(m, &huge_boot_pages, list) {
 		struct page *page = virt_to_page(m);
 		struct folio *folio = (void *)page;
-		struct hstate *h = m->hstate;
+
+		h = m->hstate;
+		/*
+		 * It is possible to have multiple huge page sizes (hstates)
+		 * in this list.  If so, process each size separately.
+		 */
+		if (h != prev_h && prev_h != NULL)
+			prep_and_add_allocated_folios(prev_h, &folio_list);
+		prev_h = h;
 
 		VM_BUG_ON(!hstate_is_gigantic(h));
 		WARN_ON(folio_ref_count(folio) != 1);
 
 		hugetlb_folio_init_vmemmap(folio, h,
 					   HUGETLB_VMEMMAP_RESERVE_PAGES);
-		prep_new_hugetlb_folio(h, folio, folio_nid(folio));
+		__prep_new_hugetlb_folio(h, folio);
 		/* If HVO fails, initialize all tail struct pages */
 		if (!HPageVmemmapOptimized(&folio->page))
 			hugetlb_folio_init_tail_vmemmap(folio,
 						HUGETLB_VMEMMAP_RESERVE_PAGES,
 						pages_per_huge_page(h));
-		free_huge_folio(folio); /* add to the hugepage allocator */
+		list_add(&folio->lru, &folio_list);
 
 		/*
 		 * We need to restore the 'stolen' pages to totalram_pages
@@ -3292,6 +3349,8 @@ static void __init gather_bootmem_prealloc(void)
 		adjust_managed_page_count(page, pages_per_huge_page(h));
 		cond_resched();
 	}
+
+	prep_and_add_allocated_folios(h, &folio_list);
 }
 
 static void __init hugetlb_hstate_alloc_pages_onenode(struct hstate *h, int nid)
@@ -3325,9 +3384,22 @@ static void __init hugetlb_hstate_alloc_pages_onenode(struct hstate *h, int nid)
 	h->max_huge_pages_node[nid] = i;
 }
 
+/*
+ * NOTE: this routine is called in different contexts for gigantic and
+ * non-gigantic pages.
+ * - For gigantic pages, this is called early in the boot process and
+ *   pages are allocated from memblock allocated or something similar.
+ *   Gigantic pages are actually added to pools later with the routine
+ *   gather_bootmem_prealloc.
+ * - For non-gigantic pages, this is called later in the boot process after
+ *   all of mm is up and functional.  Pages are allocated from buddy and
+ *   then added to hugetlb pools.
+ */
 static void __init hugetlb_hstate_alloc_pages(struct hstate *h)
 {
 	unsigned long i;
+	struct folio *folio;
+	LIST_HEAD(folio_list);
 	nodemask_t *node_alloc_noretry;
 	bool node_specific_alloc = false;
 
@@ -3369,14 +3441,25 @@ static void __init hugetlb_hstate_alloc_pages(struct hstate *h)
 
 	for (i = 0; i < h->max_huge_pages; ++i) {
 		if (hstate_is_gigantic(h)) {
+			/*
+			 * gigantic pages not added to list as they are not
+			 * added to pools now.
+			 */
 			if (!alloc_bootmem_huge_page(h, NUMA_NO_NODE))
 				break;
-		} else if (!alloc_pool_huge_page(h,
-					 &node_states[N_MEMORY],
-					 node_alloc_noretry))
-			break;
+		} else {
+			folio = alloc_pool_huge_folio(h, &node_states[N_MEMORY],
+							node_alloc_noretry);
+			if (!folio)
+				break;
+			list_add(&folio->lru, &folio_list);
+		}
 		cond_resched();
 	}
+
+	/* list will be empty if hstate_is_gigantic */
+	prep_and_add_allocated_folios(h, &folio_list);
+
 	if (i < h->max_huge_pages) {
 		char buf[32];
 
@@ -3510,7 +3593,9 @@ static int adjust_pool_surplus(struct hstate *h, nodemask_t *nodes_allowed,
 static int set_max_huge_pages(struct hstate *h, unsigned long count, int nid,
 			      nodemask_t *nodes_allowed)
 {
-	unsigned long min_count, ret;
+	unsigned long min_count;
+	unsigned long allocated;
+	struct folio *folio;
 	LIST_HEAD(page_list);
 	NODEMASK_ALLOC(nodemask_t, node_alloc_noretry, GFP_KERNEL);
 
@@ -3587,7 +3672,8 @@ static int set_max_huge_pages(struct hstate *h, unsigned long count, int nid,
 			break;
 	}
 
-	while (count > persistent_huge_pages(h)) {
+	allocated = 0;
+	while (count > (persistent_huge_pages(h) + allocated)) {
 		/*
 		 * If this allocation races such that we no longer need the
 		 * page, free_huge_folio will handle it by freeing the page
@@ -3598,15 +3684,32 @@ static int set_max_huge_pages(struct hstate *h, unsigned long count, int nid,
 		/* yield cpu to avoid soft lockup */
 		cond_resched();
 
-		ret = alloc_pool_huge_page(h, nodes_allowed,
+		folio = alloc_pool_huge_folio(h, nodes_allowed,
 						node_alloc_noretry);
-		spin_lock_irq(&hugetlb_lock);
-		if (!ret)
+		if (!folio) {
+			prep_and_add_allocated_folios(h, &page_list);
+			spin_lock_irq(&hugetlb_lock);
 			goto out;
+		}
+
+		list_add(&folio->lru, &page_list);
+		allocated++;
 
 		/* Bail for signals. Probably ctrl-c from user */
-		if (signal_pending(current))
+		if (signal_pending(current)) {
+			prep_and_add_allocated_folios(h, &page_list);
+			spin_lock_irq(&hugetlb_lock);
 			goto out;
+		}
+
+		spin_lock_irq(&hugetlb_lock);
+	}
+
+	/* Add allocated pages to the pool */
+	if (!list_empty(&page_list)) {
+		spin_unlock_irq(&hugetlb_lock);
+		prep_and_add_allocated_folios(h, &page_list);
+		spin_lock_irq(&hugetlb_lock);
 	}
 
 	/*
@@ -3632,8 +3735,6 @@ static int set_max_huge_pages(struct hstate *h, unsigned long count, int nid,
 	 * Collect pages to be removed on list without dropping lock
 	 */
 	while (min_count < persistent_huge_pages(h)) {
-		struct folio *folio;
-
 		folio = remove_pool_hugetlb_folio(h, nodes_allowed, 0);
 		if (!folio)
 			break;
-- 
2.41.0

