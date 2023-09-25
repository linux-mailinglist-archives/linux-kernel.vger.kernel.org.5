Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED3197AE29D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 01:52:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233569AbjIYXtp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 19:49:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233551AbjIYXtl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 19:49:41 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C34C5116
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 16:49:32 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38PNDqPG030138;
        Mon, 25 Sep 2023 23:49:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=TX7Kgu5vLRMl23g6p2+L9qirIhzBjTxtaL2mM0XH1ng=;
 b=MH3VXNXiykAcZ82q7iGD9SxPU3MKP/6Xu4v4uJuVhqjVWXu6IW3TzAaI8SWEGwfTGzgD
 yybf/3re2sXZcyLkQthnLIX2Y92/HCTvIC0gOlbh38ufd7BWcC11Ig7ADEK1ZUErt5iV
 6oUbXKUvGUpGnVjgGs8wcDKA4eWXGUJW0Es7B9qmkT59WxvbEZwUpS0jqiHqs9VwSnIr
 o0T/aej2ovz1HIYs3b/0Q0VABGF5aRkirtJT2xJoojezqeuhLZNJ0Z7Sp+k81q30zDhY
 QOMlLDI+r/yQDQ2reYzWZGoZF3SyOWZBD61+wBI+iFigqr2f0BHirBmjLJaFw2mPAlTM Hw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t9pt3n62x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Sep 2023 23:48:59 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38PN62tx030634;
        Mon, 25 Sep 2023 23:48:58 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2103.outbound.protection.outlook.com [104.47.55.103])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3t9pf53054-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Sep 2023 23:48:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BRk0MDvnYqEiNAdP95TfQdz2eLol+felrzcqd6ZnhTz8LdtyxSNRC4nwAQE1h4AU//r5kPuJYoP9bjOyZCH4I59Fg2aSo7PHPJ1jLodZlU5CQtNSXTSG9pvHcHutDaOxl55ucboD393i6Zn40jLNFtd0BbVl+XQewdJclW66vFn+nm4La+Zr8PCbE9yDoUnejWUA3f5TpMRSlfzarKFup2nZlWK2yNTor6cR1qbFtxgTwqS1FJr2My4bStxbbuExtuGkx370m5NC6cGgmWOkKQ0+If4ptRZQ6mfI9BwDVvpgfWi8KdNxoo/sN6hV7pz4GuC0RvLbRB3J9l9CW0qtSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TX7Kgu5vLRMl23g6p2+L9qirIhzBjTxtaL2mM0XH1ng=;
 b=lWLM03FjNcRhF1R+QY54PQwpxFqKgI8ol+krJ2bUwVNqo5iDlMi5wnP5Sj8opvjV0Y8jhQyAN7+WsoB0nXSDTjZ7BvvS/K20gXI4Iob4mtOBMgbRVpJunpTIdve3hWP6RStezfALM/DN6ytLPENKXy7m3o3mIHd1CKAFAhv1ft2nEKJ8ujAIvJwuDFS8EmEw4YY4B21gr2zExmoBYpYVJHMd6sUsLAOsl3i6O4hJMjAqT+N4KSwzI8+MWB2Loc3cEoj7cJlNjGCwFjJtzmhhFfdm023AOJXGXmICfCiKOm8C47eNzfK/DMlHI8tMtXzwMKkymjM+wjTY/8phL7HaDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TX7Kgu5vLRMl23g6p2+L9qirIhzBjTxtaL2mM0XH1ng=;
 b=e0AH5xuQkacN7aed44ooaajpz2KCqCbDwI/rq3XJhe2A4Ppw249bCxr6w4gcmbJ43PH/HTUel3ziFLJI73P7LZK3p/Dyh+W3hoLzM+sVjMrjcnHYlZVbN1uYwZqMZTBmEUhbKuWulmGxa4/+MNO1qzZ/531j4opRYV4oSO/oQF4=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by CY8PR10MB6730.namprd10.prod.outlook.com (2603:10b6:930:95::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.20; Mon, 25 Sep
 2023 23:48:56 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c621:12ca:ba40:9054]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c621:12ca:ba40:9054%5]) with mapi id 15.20.6813.027; Mon, 25 Sep 2023
 23:48:56 +0000
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
Subject: [PATCH v6 4/8] hugetlb: perform vmemmap restoration on a list of pages
Date:   Mon, 25 Sep 2023 16:48:32 -0700
Message-ID: <20230925234837.86786-5-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230925234837.86786-1-mike.kravetz@oracle.com>
References: <20230925234837.86786-1-mike.kravetz@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR02CA0027.namprd02.prod.outlook.com
 (2603:10b6:303:16d::32) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|CY8PR10MB6730:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b17b64f-d85b-46b4-391a-08dbbe21fb7b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mTi6UPTHZcB/Qqyrfhsd2bb0l0444Ge5YRAG34R8TlmnYaIks05WcGhP9d0aQBO7V5XIvjoyW7DaY86yc325hW0bLOuRDC9nvZh33tlMSEX0gN1CfvC7UpH4k1UwQMODXdd/pvHp9H4w0XGQD/HK29spJLFt976y64koMXM5ERsaB3xH96o8597fJhBifo0HDSGHX4tm29QeGrtCPJwelYdfEyQjjhs3hEBdqZCV1gL0pflBRHLJDcQ897XL/X/pWcRY9Gb0y4tiX9SgtsM+IWEDBZUVBn5RbuOhxB61NCc5LLD7UHqrmGlDpsMjC2Ei9bmzbJo4DdAeWYeqILyyqtlJyA48NfGKEQ/vRDziwawbT73NdrON0QlD9Cv9xSuFgTDRrtn2GqRJq5LMA4Zci/Qx6UBsFIK10FpE+XVNDQNlxgaXExyK+PAZERhYG5PjkGU7+sdfzm003GYo67RtCX2SwYrUvj3MLsuc/yk4s/6UsLjjoKy2DBk1TWpM9NaPHpXgYZ8wmuvdGJdnw9/Tc2iPFZqlOauqQB0opoKX4yvzf03LShLbWZXTSIB+XlHW
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(136003)(366004)(376002)(346002)(230922051799003)(186009)(1800799009)(451199024)(478600001)(6506007)(6666004)(6486002)(1076003)(2906002)(2616005)(5660300002)(6512007)(7416002)(54906003)(316002)(107886003)(66946007)(8936002)(66476007)(8676002)(4326008)(41300700001)(44832011)(66556008)(26005)(38100700002)(36756003)(86362001)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bVwfuVNE5uYL7exCj70AaN3/FjPtKy19bYgWL/xs+1cWmds1lYUncG52dsUu?=
 =?us-ascii?Q?3oDWenGW8vOWTSgML9vM0WO8QNLEhEQHrBETggfbzZBEnUa3SyryHUUw7xND?=
 =?us-ascii?Q?sTmDubz9VWG8YcEl2kHkyKYuQpjSxu7e94iT6/bXY2jYEhqP2iInh+YhNRbO?=
 =?us-ascii?Q?X/LmnsdJpoYiGFzRvIU6huVq/CC43gozmprf+qas92Rh7eW1SZagK/4cU2gv?=
 =?us-ascii?Q?Qj5//UCPv4t1b9huLlg+ujWelcvjXeK40uhNPe6jtQbOTy7nYixsZwIjmkQM?=
 =?us-ascii?Q?5jzQoo7SKjiIR3/HmPZIHq5m2WBMUROLgX1Ac/nIkB6Q+u2BH6IGJDH1n/Xt?=
 =?us-ascii?Q?cYS4yZoQmsmZ/6BQfOA5OTvm64z4+vT4int0bnISqXnYd6DzUUSG4ST1EmS4?=
 =?us-ascii?Q?gGlsGkXa2l9fiBwkl47jgqI6Vea0yqr1g4Vvs3tnhpyv7mfCcMWZXFUvLVbI?=
 =?us-ascii?Q?58lue48mvCNWw3Si1xZfyM2oVZPmPDxJ4+BTe56nOQzTtxZDcN+0AWp4aCe9?=
 =?us-ascii?Q?r3M5FyGZUApCfXGBqBAHlrtxsDQpjYGer/CkFdmp6fdJN6QzZQnmrC8JPwqZ?=
 =?us-ascii?Q?yPrmMFT6NnxuI+dqny/lOHh7Xg5yUk7mfaSX32TM5fwSqmS1uAHfMZDAlkdM?=
 =?us-ascii?Q?+EtrpDB30BNyMoe9kcekHfka8Y/3qynf+Aq82vPKQzSXgqvjearj3TV4E2Jm?=
 =?us-ascii?Q?Vu61FnWKurGMd1D4dcXgBxiduco/xIDqywFcPrmtVtHURDiItkpozLDwHrqH?=
 =?us-ascii?Q?cqYNBhFOe8d0bTEXPh8XXcyHbwGv11KGDXXpbviCYGMwW3IhhY2nOpcf78a2?=
 =?us-ascii?Q?WSXo6WwOgW6aHNqtaUr2xYdYYkIZGFQNLTW0CRXMuT0Pl4JJPpU4gfI6oRiG?=
 =?us-ascii?Q?9jLDs78ES9e+h+8adKa0rfasy1kvXTFeaYB0a0W1f3aG9qdlQ+0NwwO5Ica5?=
 =?us-ascii?Q?oh0TBW2S9dfRjoAHpnBiMR3+NKjU6FT/8raVxvl4am96Wgt0RnxKJOuJaMOQ?=
 =?us-ascii?Q?fnFeTO+x2vrXXsvgIEPr5dvN0pAqjXOGHLNujxqPvutlJLUOFvXdbxJCByV5?=
 =?us-ascii?Q?hw8hmmIt8EGoLQp2AmD949UAWnbg099uC1eWKe3nTJT6fom9/Vbn+ZLnmxgk?=
 =?us-ascii?Q?Wxor+5MOQ6CnOc3qT19RibWBNedAr3DRL7IsM4x96EL/Jmw97nMTg3wsBK7X?=
 =?us-ascii?Q?l5vTVEC9fdpoGQrm4pji/q+P/YNrbsKAIM4L2gmx8axWnIK1Kopzg+4zRv1H?=
 =?us-ascii?Q?klSxXeFWweGh93vZGi4tOA6uNhmpjM6XCQ+uTuBNh4ODoRbnngCIcxHU1LjR?=
 =?us-ascii?Q?krHPtX/clXYCcG0Age/W005o5BnRb+PXpdd0XdGPWQQacInB63lYt3MUtDiA?=
 =?us-ascii?Q?2Fl/6Uk9Go4tilBxuZ8yAv52jklAyy5IWqiAdfyrpngGRJKj7xXZlNmZoE8l?=
 =?us-ascii?Q?pE0wArUWm+ifRMPK3UcnjearqCXjjz8/shnGE/3H9bUG0g7fPBg/pTxNZ5zy?=
 =?us-ascii?Q?Phq7HZ+mSekZq1iJBhrutWDRN9V9jSej9mydntRU5q3ARZ1+weCBS3KkKX3a?=
 =?us-ascii?Q?VBCkUio4Mwa1xsm2gj9mlMrAt17nVVranHxw9xailYo8CxeKKFIiyvqB6zeu?=
 =?us-ascii?Q?Ig=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?oyHYJHu6VgRIUw8a4vI6GUb8Gm5SBz6PuFMFTOs9P400o6zVRKcvTq+l74MW?=
 =?us-ascii?Q?hCXlWl4zWZGG79VZij2D+TJ9Nait/eenrVcpOcnhz9q9FEwgvqJ49XycMY1V?=
 =?us-ascii?Q?/H2IKPvMv/AwZFobP2B9IxQAoB+R5HjE4APIQok5S8042g9zeMiyZSqH+VNM?=
 =?us-ascii?Q?dAUbM1EsPD9eFzJPLh79yoG1QCRja10HEA9ziN8SXawBuh/T9LKYC0rZqcxx?=
 =?us-ascii?Q?6WdS0LcYL0XJC0z4XYTjHqUpkaJX+YW6z7wejk0Krk6jM+E/ZOjmfzi01fFV?=
 =?us-ascii?Q?rlSyYFdyyJ2ZyiXSkagCBTS4m6AaY6OYcaULrVNeSU4DEnOED1FcGluHzudj?=
 =?us-ascii?Q?Hi8HIdgawV9o7nAs14nv/zlkijvUWF7C3P0MS/pPXKecnmSX+6qW7SlQuUAN?=
 =?us-ascii?Q?/ko7TegSOCuIqnGh3usUylKz9TFFgTixBrR/PWihdp9ILOKoM4eA+Xmx4247?=
 =?us-ascii?Q?17S0Eou5ZV4CTeCmTKi11dg8PZ8GF9gYincyE8Cgd0gkxO9JeMUx9Pwt6Mab?=
 =?us-ascii?Q?jpqivcfybjPb6TaxfVY96l5K5ssHxBAhYTOIF2qHbYOd4fwvobQt8zcj65oC?=
 =?us-ascii?Q?MsRBMIe7VfrjKpG6Ffkyu7HlyIBF/VBgXYwiuydfQdbn6fmWkU78nlfyqR94?=
 =?us-ascii?Q?uHD4l2tVPu6FA2M+D6BQfGY42MX3fANCxOslIBoTvkcH24mNHDJZ8vOpq2aG?=
 =?us-ascii?Q?XZuQydXMlg3GzMLz4184u89wZF/ygKuIEYbhpvXGgTJbqIbcHoiO6a+5PlzC?=
 =?us-ascii?Q?Pn2auHCWmtR8WoDPyL2i01sMUCkoRMTY+S1b1nDLr2GYelnq4KyoOOIZpxT5?=
 =?us-ascii?Q?VoAtMSsmArpZx+EleNMwfvvAURhQPFYp7OSoQTH2gHif2ccPnc8hBm2Cb5I3?=
 =?us-ascii?Q?Ob3mzGzKTJpvw0de9RPUDlVTotQ3JiApmbzimENC5Im85zkyMberGz5mmGTf?=
 =?us-ascii?Q?3GeMUifahu/AGHFdq3eStDEBh4Z0j1wClvWL2/xy52a2Bh6HD9kxdvymySje?=
 =?us-ascii?Q?t1CHTm6Qk/oc+eOdDsmmm4MqZSZSkgSU5dJVTi2tLx5UIIASWWXKq+xW8JOA?=
 =?us-ascii?Q?0VYXegGfyNTj8UANHjc7gBf0mNFVJdqskOOcZt9WCXPsh8XyOYPPYVSGqp9a?=
 =?us-ascii?Q?SlZXOQsdCLQZ?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b17b64f-d85b-46b4-391a-08dbbe21fb7b
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2023 23:48:56.6971
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O/Cl9FVQx8UCEzO3PFPsXUczOnN6V6S/qHZIMCpjxZesnDJXqs1Q4g3iJR/O6cv6M4reNesbpTe6OQS28jIJ4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6730
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-25_18,2023-09-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 phishscore=0
 mlxscore=0 malwarescore=0 mlxlogscore=999 bulkscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2309250185
X-Proofpoint-ORIG-GUID: MM-Hq3KOHZXnrrsAtRxcEwdahMlX7fe2
X-Proofpoint-GUID: MM-Hq3KOHZXnrrsAtRxcEwdahMlX7fe2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The routine update_and_free_pages_bulk already performs vmemmap
restoration on the list of hugetlb pages in a separate step.  In
preparation for more functionality to be added in this step, create a
new routine hugetlb_vmemmap_restore_folios() that will restore
vmemmap for a list of folios.

This new routine must provide sufficient feedback about errors and
actual restoration performed so that update_and_free_pages_bulk can
perform optimally.

Special care must be taken when encountering an error from
hugetlb_vmemmap_restore_folios.  We want to continue making as much
forward progress as possible.  A new routine bulk_vmemmap_restore_error
handles this specific situation.

Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 mm/hugetlb.c         | 99 +++++++++++++++++++++++++++++++-------------
 mm/hugetlb_vmemmap.c | 38 +++++++++++++++++
 mm/hugetlb_vmemmap.h | 10 +++++
 3 files changed, 119 insertions(+), 28 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index da0ebd370b5f..c484bb74201a 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1834,50 +1834,93 @@ static void update_and_free_hugetlb_folio(struct hstate *h, struct folio *folio,
 		schedule_work(&free_hpage_work);
 }
 
-static void update_and_free_pages_bulk(struct hstate *h, struct list_head *list)
+static void bulk_vmemmap_restore_error(struct hstate *h,
+					struct list_head *folio_list,
+					struct list_head *non_hvo_folios)
 {
 	struct folio *folio, *t_folio;
-	bool clear_dtor = false;
 
-	/*
-	 * First allocate required vmemmmap (if necessary) for all folios on
-	 * list.  If vmemmap can not be allocated, we can not free folio to
-	 * lower level allocator, so add back as hugetlb surplus page.
-	 * add_hugetlb_folio() removes the page from THIS list.
-	 * Use clear_dtor to note if vmemmap was successfully allocated for
-	 * ANY page on the list.
-	 */
-	list_for_each_entry_safe(folio, t_folio, list, lru) {
-		if (folio_test_hugetlb_vmemmap_optimized(folio)) {
+	if (!list_empty(non_hvo_folios)) {
+		/*
+		 * Free any restored hugetlb pages so that restore of the
+		 * entire list can be retried.
+		 * The idea is that in the common case of ENOMEM errors freeing
+		 * hugetlb pages with vmemmap we will free up memory so that we
+		 * can allocate vmemmap for more hugetlb pages.
+		 */
+		list_for_each_entry_safe(folio, t_folio, non_hvo_folios, lru) {
+			list_del(&folio->lru);
+			spin_lock_irq(&hugetlb_lock);
+			__clear_hugetlb_destructor(h, folio);
+			spin_unlock_irq(&hugetlb_lock);
+			update_and_free_hugetlb_folio(h, folio, false);
+			cond_resched();
+		}
+	} else {
+		/*
+		 * In the case where there are no folios which can be
+		 * immediately freed, we loop through the list trying to restore
+		 * vmemmap individually in the hope that someone elsewhere may
+		 * have done something to cause success (such as freeing some
+		 * memory).  If unable to restore a hugetlb page, the hugetlb
+		 * page is made a surplus page and removed from the list.
+		 * If are able to restore vmemmap and free one hugetlb page, we
+		 * quit processing the list to retry the bulk operation.
+		 */
+		list_for_each_entry_safe(folio, t_folio, folio_list, lru)
 			if (hugetlb_vmemmap_restore(h, &folio->page)) {
+				list_del(&folio->lru);
 				spin_lock_irq(&hugetlb_lock);
 				add_hugetlb_folio(h, folio, true);
 				spin_unlock_irq(&hugetlb_lock);
-			} else
-				clear_dtor = true;
-		}
+			} else {
+				list_del(&folio->lru);
+				spin_lock_irq(&hugetlb_lock);
+				__clear_hugetlb_destructor(h, folio);
+				spin_unlock_irq(&hugetlb_lock);
+				update_and_free_hugetlb_folio(h, folio, false);
+				cond_resched();
+				break;
+			}
 	}
+}
+
+static void update_and_free_pages_bulk(struct hstate *h,
+						struct list_head *folio_list)
+{
+	long ret;
+	struct folio *folio, *t_folio;
+	LIST_HEAD(non_hvo_folios);
 
 	/*
-	 * If vmemmmap allocation was performed on any folio above, take lock
-	 * to clear destructor of all folios on list.  This avoids the need to
-	 * lock/unlock for each individual folio.
-	 * The assumption is vmemmap allocation was performed on all or none
-	 * of the folios on the list.  This is true expect in VERY rare cases.
+	 * First allocate required vmemmmap (if necessary) for all folios.
+	 * Carefully handle errors and free up any available hugetlb pages
+	 * in an effort to make forward progress.
 	 */
-	if (clear_dtor) {
+retry:
+	ret = hugetlb_vmemmap_restore_folios(h, folio_list, &non_hvo_folios);
+	if (ret < 0) {
+		bulk_vmemmap_restore_error(h, folio_list, &non_hvo_folios);
+		goto retry;
+	}
+
+	/*
+	 * At this point, list should be empty, ret should be >= 0 and there
+	 * should only be pages on the non_hvo_folios list.
+	 * Do note that the non_hvo_folios list could be empty.
+	 * Without HVO enabled, ret will be 0 and there is no need to call
+	 * __clear_hugetlb_destructor as this was done previously.
+	 */
+	VM_WARN_ON(!list_empty(folio_list));
+	VM_WARN_ON(ret < 0);
+	if (!list_empty(&non_hvo_folios) && ret) {
 		spin_lock_irq(&hugetlb_lock);
-		list_for_each_entry(folio, list, lru)
+		list_for_each_entry(folio, &non_hvo_folios, lru)
 			__clear_hugetlb_destructor(h, folio);
 		spin_unlock_irq(&hugetlb_lock);
 	}
 
-	/*
-	 * Free folios back to low level allocators.  vmemmap and destructors
-	 * were taken care of above, so update_and_free_hugetlb_folio will
-	 * not need to take hugetlb lock.
-	 */
-	list_for_each_entry_safe(folio, t_folio, list, lru) {
+	list_for_each_entry_safe(folio, t_folio, &non_hvo_folios, lru) {
 		update_and_free_hugetlb_folio(h, folio, false);
 		cond_resched();
 	}
diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
index 4558b814ffab..77f44b81ff01 100644
--- a/mm/hugetlb_vmemmap.c
+++ b/mm/hugetlb_vmemmap.c
@@ -480,6 +480,44 @@ int hugetlb_vmemmap_restore(const struct hstate *h, struct page *head)
 	return ret;
 }
 
+/**
+ * hugetlb_vmemmap_restore_folios - restore vmemmap for every folio on the list.
+ * @h:			hstate.
+ * @folio_list:		list of folios.
+ * @non_hvo_folios:	Output list of folios for which vmemmap exists.
+ *
+ * Return: number of folios for which vmemmap was restored, or an error code
+ *		if an error was encountered restoring vmemmap for a folio.
+ *		Folios that have vmemmap are moved to the non_hvo_folios
+ *		list.  Processing of entries stops when the first error is
+ *		encountered. The folio that experienced the error and all
+ *		non-processed folios will remain on folio_list.
+ */
+long hugetlb_vmemmap_restore_folios(const struct hstate *h,
+					struct list_head *folio_list,
+					struct list_head *non_hvo_folios)
+{
+	struct folio *folio, *t_folio;
+	long restored = 0;
+	long ret = 0;
+
+	list_for_each_entry_safe(folio, t_folio, folio_list, lru) {
+		if (folio_test_hugetlb_vmemmap_optimized(folio)) {
+			ret = hugetlb_vmemmap_restore(h, &folio->page);
+			if (ret)
+				break;
+			restored++;
+		}
+
+		/* Add non-optimized folios to output list */
+		list_move(&folio->lru, non_hvo_folios);
+	}
+
+	if (!ret)
+		ret = restored;
+	return ret;
+}
+
 /* Return true iff a HugeTLB whose vmemmap should and can be optimized. */
 static bool vmemmap_should_optimize(const struct hstate *h, const struct page *head)
 {
diff --git a/mm/hugetlb_vmemmap.h b/mm/hugetlb_vmemmap.h
index c512e388dbb4..0b7710f90e38 100644
--- a/mm/hugetlb_vmemmap.h
+++ b/mm/hugetlb_vmemmap.h
@@ -19,6 +19,9 @@
 
 #ifdef CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP
 int hugetlb_vmemmap_restore(const struct hstate *h, struct page *head);
+long hugetlb_vmemmap_restore_folios(const struct hstate *h,
+					struct list_head *folio_list,
+					struct list_head *non_hvo_folios);
 void hugetlb_vmemmap_optimize(const struct hstate *h, struct page *head);
 void hugetlb_vmemmap_optimize_folios(struct hstate *h, struct list_head *folio_list);
 
@@ -45,6 +48,13 @@ static inline int hugetlb_vmemmap_restore(const struct hstate *h, struct page *h
 	return 0;
 }
 
+static long hugetlb_vmemmap_restore_folios(const struct hstate *h,
+					struct list_head *folio_list,
+					struct list_head *non_hvo_folios)
+{
+	return 0;
+}
+
 static inline void hugetlb_vmemmap_optimize(const struct hstate *h, struct page *head)
 {
 }
-- 
2.41.0

