Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1794E7CEE1B
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 04:32:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232601AbjJSCch (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 22:32:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232479AbjJSCcV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 22:32:21 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C15A132
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 19:32:16 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39IIn3im027703;
        Thu, 19 Oct 2023 02:31:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=Tsc70UZvKWYWI+spZQiVZ3u2z8ZAo9dlRTusEOzzs6g=;
 b=rQpgErTtmdABXRMhNGQQlgg2mX9haPcDZ0EFYfKahihSaYXFLxHX/NS35+lzk81MfcOs
 FRMxamzwB3sxd69ZvQ2XDeUpNwznTrFIDMuXYOW73F7Dwnw9Zdar51isKl3rBLG0pYav
 kbijrBFpSCsA/ab9G6wxYDhTk2tdX8Jyk8Kn+Ru0SftYqzKDf8zG00BUWxIiHT8wc8Yg
 ZX+hpETt/BN8jLpfsx59m+85S1CIZBXiew6jvMM5f24JH7gvwk33r8UPzxmZT41JU4+0
 CJp62bS/3Ev9BdA32QT9KnYPzg7mbs5BZvRQS6jjhHZ0hD/thn2MHxidZWcXRFf4GQEa Qw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tqk1bs38n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Oct 2023 02:31:39 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39J2GJ34021964;
        Thu, 19 Oct 2023 02:31:38 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3trg539w5m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Oct 2023 02:31:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nxjOzwliXpJ3e6gfqvgLcy9YtSOFEt/tQATGpXR/vBEcoX1jJJUK5GU92e0HpViDd/OmBx1ontByJKoMkgYs0Q5aXZ31e4weCHJjh3lr7Gu0rf9ci2zPyDhilMF54s/TO46S7sI60tY09eUJn+U5Fwk/m3W1X+JueCsN8mgTdQEnyKnta0goIp8//fzyHlmZq/n7vvlkq6pDxS74mx2ZsHsVq2V6/Fpr4fuYZfNpBkqcG3IBPsQUGKUSkW9NKrBKwEgBb3WJtWRbvY1pcfsHHPD2A3rlYK2jhz3ydMUIlnCGn0lBB1gqczxpEk1K6lTsERkVeB9rY8y3dv2F8v2t5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tsc70UZvKWYWI+spZQiVZ3u2z8ZAo9dlRTusEOzzs6g=;
 b=NmvNZE0JZjMeBJKSoQI/L2/HdaP1Z/xg9u/p7FjOcrCRRwDiASjT2gKFcBpeL8xYVhjAQjpi+pXeFnIRnAKNwymkOXAxXp83ZGChWdMJ/he6JG921Ys7g2/zRm8PjhAPVHLIVKerGlxyX4/yZPCC0LGiQxYEQ1gw/nOo195BeHvvkw/V4SHHJiqWqEcYWb6BXrhMywCwlcyYhcJmoKc0iw2oTo5MgqUK5ESVtpLlKbPGVWBrquwJK9col5tlI4ipo+f2k/ZNDL00w2HkqD5naMZHBTrS2dkCnQqXucc4V7Aq3g5s+RHj7uorXOBlW0KbIRJM7Nlv8iTbhIyYpz4z8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tsc70UZvKWYWI+spZQiVZ3u2z8ZAo9dlRTusEOzzs6g=;
 b=deC0BAFXrqeOQZfQnHetFtYnVMGxKglo5r5RWLakj69BHUhg8rKeL2Fock4ArMy9G1PtkXUf2CrGCta34vqTld8q+Q01bLy7tabLOfhVjf3LlIliqlDY5nXVKVJJ4H06VH/QyMnfO4tQhn84re3yCOEFXeTnRf0zwAqGY/n8/Ik=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by CY8PR10MB7123.namprd10.prod.outlook.com (2603:10b6:930:74::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36; Thu, 19 Oct
 2023 02:31:36 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::59f7:ec45:eb41:d8c2]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::59f7:ec45:eb41:d8c2%6]) with mapi id 15.20.6863.032; Thu, 19 Oct 2023
 02:31:36 +0000
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Muchun Song <songmuchun@bytedance.com>,
        Joao Martins <joao.m.martins@oracle.com>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Oscar Salvador <osalvador@suse.de>,
        David Hildenbrand <david@redhat.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        David Rientjes <rientjes@google.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        Barry Song <21cnbao@gmail.com>, Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        Xiongchun Duan <duanxiongchun@bytedance.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Usama Arif <usama.arif@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: [PATCH v8 7/8] hugetlb: batch TLB flushes when freeing vmemmap
Date:   Wed, 18 Oct 2023 19:31:09 -0700
Message-ID: <20231019023113.345257-8-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231019023113.345257-1-mike.kravetz@oracle.com>
References: <20231019023113.345257-1-mike.kravetz@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0242.namprd04.prod.outlook.com
 (2603:10b6:303:88::7) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|CY8PR10MB7123:EE_
X-MS-Office365-Filtering-Correlation-Id: 09962dbe-d9c1-4a59-c18b-08dbd04b8457
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xgms/ZLaft5gG7asQJn6ysNtVgual/rNiT4vGufADxJVbTJPtKs7JLZLKG3ZbvnT2KrDKaeOmP8jdXGlN3wlkYhRABTxT3LgF4P8Fb1XAczMWW8junqSqvdMWbjOG4SOw/GaM44PGRzoCVs36mCXDugS5prvCASfrvi3XZOwgB+gDUVJ9stjQLutc59jB/INmcCUGWNaQFwscpKiCAWwrDnA38CRj2IeaIeo576IBA2kWN8B3iuQ5crQ6BLQiQAEEWqllPidKHlEX92jXvs7lrTwYLvfEeDPaVUvpI9NzuaSC0qav5iDoHO7oeB7Z3Az9H9kYaeduizv1u1tMqGHUq6jsIwZ9QLWQH1YX99BgXH1/U/QNoICtf7gNLWbuLOvOMqi2S3eIWCHa6VfhLcsbqqVXDwNNUYOAPJ2TaIrm1wD+tHnchbGB+I4tG75E+EQnXSVQ0S2VV8ZlOwObwH3gX+qQShdR8QFIAwnXfTIFKHYOVUMLYDgAAHi+x8k5zl94rW0+f76KzmCPB5o0Rc59eEalSnxtpAk94oPpN6Fg7FlhDfsIK2akvYtglPEeeoZ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(136003)(346002)(396003)(366004)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(478600001)(54906003)(316002)(66946007)(66476007)(6486002)(66556008)(6666004)(1076003)(86362001)(2616005)(26005)(6506007)(36756003)(107886003)(6512007)(8936002)(2906002)(4326008)(8676002)(7416002)(44832011)(41300700001)(83380400001)(5660300002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dhCmC2lRuBxv4R9mgKc22HTaMfDhfefEOMP9tQtZ8VrXt0KE7BmzA+lzeYbV?=
 =?us-ascii?Q?Cm01BHb3UCRlHaj0ZNhnhXC6n3C+lTV0owMtn91sdu/MhD93AnGk7E0Pgi3a?=
 =?us-ascii?Q?UpfemfquB2qOsv5AblF1sX0c0Xivc/2kaHSLpP3lNQ5R/dXE2bIJEKr3NaWQ?=
 =?us-ascii?Q?DBZY4jHVcmNUL0Q/6yQ+HgEc0zruMFFpzBCW/Xui6hrF5CUZKuArzEcSSpyD?=
 =?us-ascii?Q?etb8j/Gz0qiDesp1w0O9IXftHje0usjEEspQWNyOZ2jQ1jwZTVjd9NjvBA+H?=
 =?us-ascii?Q?yFQY+CVRKUObCQw8SnZQcP4vByg1h7suZo8zc6YMSo9PJi+s1eFpDV8qVUe2?=
 =?us-ascii?Q?1QtXkPkVvwPbzmv4UjVn4Khm8ztcBZ3pu0E/D57R0rpKQgIfuCdUyrjM1tQa?=
 =?us-ascii?Q?PyezbF2sOsckHLq11js37mIi0wNEHdV5aNZYJrEIs/7mj7AGewjlR3gGbBAI?=
 =?us-ascii?Q?WBCEa8c8E6Ymmha0mrv1JyuVoh/mfvYf2aqNuV5+JnRltHArB0UQgWLKfT1W?=
 =?us-ascii?Q?yj9kTt37MPZ1/bFyaIFj3Rq+RejAitQ3vDg++vUDijUyRUvEc1G+O51wT9bF?=
 =?us-ascii?Q?ZEzufGFhZWoqC6D2bvjnZBR534MTvU6PGHmRvUyMSnTyOBomxCTjvIzom3cC?=
 =?us-ascii?Q?w49tiBxZKBK0Hk8Ijq6O/cN3yNJOdJ0HuYU7zcQe0dO1GSt7+JPk9HZcI4Kq?=
 =?us-ascii?Q?77NfsCS0Sqxc08NhBkNmlqbvEdd5uDXJqbT6GjiRDk85L6+bgns9Zbhw0Msy?=
 =?us-ascii?Q?trIOIK+s5D+xehn4oE0qaYGTv+pzYJ4jW9zjs6OrYIWGDEw9gUU5VSCymCqq?=
 =?us-ascii?Q?kJ+AAty+fDw/PudyPqwb8lt3kCtIibTk88Htuc5bgprNCFOrot92w5s8yLNs?=
 =?us-ascii?Q?V0tVk30tkjRuEv4XtmOdkcry+idV7pwT9AdPVhEHKRjV+LRaQ1+QG23DY4eV?=
 =?us-ascii?Q?NblOSlnE9FWdhfCrslQ+H2UYQLSpLKaEdqNNewjuRjK0hyKaqDkeoRT/DKxe?=
 =?us-ascii?Q?w/mo+NJtJIYkWUSjxuyQ9VnI4JE2atovQucm/M3d1/JXzzC8fB12pngpPhme?=
 =?us-ascii?Q?YsK4QwCzD4Eto9j1s8X1tvfsALS8q2Z2Rf4Y9nHRGHkt9VIFPLjAbNxPQmBe?=
 =?us-ascii?Q?BOP3G17xHcvI+yiDO7iUUGeFer7Wn52HOsVW1pAl0VUdmry4Sh149p7maCe4?=
 =?us-ascii?Q?uIgONYftZuxwZ62XxtClsU3qxbGfw0dXcUc5rknIkExrq9irTe0sbM2tWVRd?=
 =?us-ascii?Q?RRbEicM1EzCeFQTJt5lsy5lg9GuwvrkUGCin8mgSFEzR4AstKIX1s2GcX4Kc?=
 =?us-ascii?Q?MLt3mR916rpsqvrpS8Cmx0xT0zr7JlxGGIuzVl32T/t0UvD5N0aH64GOseoL?=
 =?us-ascii?Q?6IhghGwvX+22De9EGm7Uflj1pXWD7FP41fCTkTtYRKf4PdKXtQkFaaw/9hzs?=
 =?us-ascii?Q?rEo2yL9vH2nTQjWTtWZzDYMTRrhQWXpHZxnwnpyzV9G2VR8VyDxBuBCnbU7V?=
 =?us-ascii?Q?bOMHv7ov7Tx2hpscNLgPx2Vi+j2e1Ov0n4GUtv+s1bbaZ8MpgizAzCPgHttU?=
 =?us-ascii?Q?yGiAzpvE2YqnPK0Sr65y4StB/4u27OxhP0ZIYdF7BopaeGBXVOh6lKGf5TqN?=
 =?us-ascii?Q?GA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?Ky/o0VFpNmrgFzkWT1wWdEh7/rervw8CWAUUCq1dFz1SFtyjcV6pEjHJPJxI?=
 =?us-ascii?Q?TU+ilipuMq11tZ5S0+L3bEeSzDnLxiBevABZruoPVMPR40RLL/4LOjmDebLS?=
 =?us-ascii?Q?6dQalSkkdzHH5LfrQDGKoKp3jVOJr08ZcRRSTR8C6lkeJ4ibszmHb7EMenOl?=
 =?us-ascii?Q?218iVJhAoqJHc3+tWZ0rn/0ZW1EVLG92/JRo/fc1AyOKQIrUlUV9+tmOwJ8M?=
 =?us-ascii?Q?nlueUeC20rNDox3czY5kZIqk0n4IfMRkuk/vLdW8z7mm+kV2rm78HkzpDsj/?=
 =?us-ascii?Q?kAWhbSXaY+m/4i07vY/aKSfxwXtLmTwU5ULR9qmn/dvEeUAeCiCs6BGRjD3j?=
 =?us-ascii?Q?n1L8T7/rzDttd6mpSG0PN1+HzobRbsrqWtrFDV6SwqU3oLQMTi153/5Yw9dq?=
 =?us-ascii?Q?hYshnew//eeiz5gE+A+iBf41ZScY2KPvniYwuqD64x2SU7mSy2hz3S0x60Cy?=
 =?us-ascii?Q?MliOZna5cLOa+65VF6448gmXMQJ8LuRsrqzPfMG+B4EMyEM/8NIDaOLXjf11?=
 =?us-ascii?Q?GoLrTRLEL65EnOqSOIO6Gcnlt75O6kOlZre0Q6g1ANlcWQLhKpTxLa7IR7ja?=
 =?us-ascii?Q?NQBy3hghpmeF3OWg5dWXSglInfwDpzKnPt0EAIlN+sefjmvACZs6fWVm/I2p?=
 =?us-ascii?Q?fkMiu1oLyhWNI3NMLIj3YRU5hUTpJpsXowehe1kj+2w6jH87NkvhKddUTDBh?=
 =?us-ascii?Q?TDShPNP63iODr8zO6hwdGiudMS/sVn1jslefdzgtRHMCo65TBIyXiQXVK8Ip?=
 =?us-ascii?Q?9H/z+n5Hf3OU6TbIAm+kRRFfie1/VKdc7B6sRKlPhiausvLkMgusLPBtmFph?=
 =?us-ascii?Q?fYoUqEoRc6DfHZTQdr1m0CvWSDvODsXjpbYabVj1FHOQgTL0EFdRxmUF+hTc?=
 =?us-ascii?Q?mWuWo4GBNNHzSqZcNbUKA2Rr9lCvCp32FtODOlqPtchtjLjoIdYS2DWfmm6b?=
 =?us-ascii?Q?95RtUnQAarNiKBxh4oe4QJF6+mQZ4Mt+xwJJ+3z2Jyhs/qMxv0Ab9GiawalX?=
 =?us-ascii?Q?G4YuLjaC37TVKaZG0tvYHb5/VxTcJ22uAABT1kzZnvgn1/kNTJ4Fk5auEP6R?=
 =?us-ascii?Q?tPS0GmS3fHM6gb0TuP6VDo1ON2SzM/0YLfg7+vg8OGdv2MPSE0And/QYhlmk?=
 =?us-ascii?Q?dRzcMkx6NtEI6drUNWZBylgF37v0ULweK+pNJzKfPtD5APaLt8pLwa8cMxv3?=
 =?us-ascii?Q?NcftMif0Xw/1zY9q?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09962dbe-d9c1-4a59-c18b-08dbd04b8457
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2023 02:31:36.5959
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q5llty7HKPseEisi7ARisAks16gh5InH6MJJ1W/rkZp/lZDRa0+C5l5oxnmcRuqbZ2dDp2Kp/eERlUxnX9ZPXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB7123
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-19_02,2023-10-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0 spamscore=0
 mlxscore=0 phishscore=0 bulkscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310190019
X-Proofpoint-GUID: _s8S4gi8IZCSJ0Jbh6r4D6-DbxfrMNyR
X-Proofpoint-ORIG-GUID: _s8S4gi8IZCSJ0Jbh6r4D6-DbxfrMNyR
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joao Martins <joao.m.martins@oracle.com>

Now that a list of pages is deduplicated at once, the TLB
flush can be batched for all vmemmap pages that got remapped.

Expand the flags field value to pass whether to skip the TLB flush
on remap of the PTE.

The TLB flush is global as we don't have guarantees from caller
that the set of folios is contiguous, or to add complexity in
composing a list of kVAs to flush.

Modified by Mike Kravetz to perform TLB flush on single folio if an
error is encountered.

Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
Reviewed-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/hugetlb_vmemmap.c | 49 ++++++++++++++++++++++++++++++++++----------
 1 file changed, 38 insertions(+), 11 deletions(-)

diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
index 10739e4285d5..9df350372046 100644
--- a/mm/hugetlb_vmemmap.c
+++ b/mm/hugetlb_vmemmap.c
@@ -40,6 +40,8 @@ struct vmemmap_remap_walk {
 
 /* Skip the TLB flush when we split the PMD */
 #define VMEMMAP_SPLIT_NO_TLB_FLUSH	BIT(0)
+/* Skip the TLB flush when we remap the PTE */
+#define VMEMMAP_REMAP_NO_TLB_FLUSH	BIT(1)
 	unsigned long		flags;
 };
 
@@ -214,7 +216,7 @@ static int vmemmap_remap_range(unsigned long start, unsigned long end,
 			return ret;
 	} while (pgd++, addr = next, addr != end);
 
-	if (walk->remap_pte)
+	if (walk->remap_pte && !(walk->flags & VMEMMAP_REMAP_NO_TLB_FLUSH))
 		flush_tlb_kernel_range(start, end);
 
 	return 0;
@@ -355,19 +357,21 @@ static int vmemmap_remap_split(unsigned long start, unsigned long end,
  * @reuse:	reuse address.
  * @vmemmap_pages: list to deposit vmemmap pages to be freed.  It is callers
  *		responsibility to free pages.
+ * @flags:	modifications to vmemmap_remap_walk flags
  *
  * Return: %0 on success, negative error code otherwise.
  */
 static int vmemmap_remap_free(unsigned long start, unsigned long end,
 			      unsigned long reuse,
-			      struct list_head *vmemmap_pages)
+			      struct list_head *vmemmap_pages,
+			      unsigned long flags)
 {
 	int ret;
 	struct vmemmap_remap_walk walk = {
 		.remap_pte	= vmemmap_remap_pte,
 		.reuse_addr	= reuse,
 		.vmemmap_pages	= vmemmap_pages,
-		.flags		= 0,
+		.flags		= flags,
 	};
 	int nid = page_to_nid((struct page *)reuse);
 	gfp_t gfp_mask = GFP_KERNEL | __GFP_NORETRY | __GFP_NOWARN;
@@ -629,7 +633,8 @@ static bool vmemmap_should_optimize(const struct hstate *h, const struct page *h
 
 static int __hugetlb_vmemmap_optimize(const struct hstate *h,
 					struct page *head,
-					struct list_head *vmemmap_pages)
+					struct list_head *vmemmap_pages,
+					unsigned long flags)
 {
 	int ret = 0;
 	unsigned long vmemmap_start = (unsigned long)head, vmemmap_end;
@@ -640,6 +645,18 @@ static int __hugetlb_vmemmap_optimize(const struct hstate *h,
 		return ret;
 
 	static_branch_inc(&hugetlb_optimize_vmemmap_key);
+	/*
+	 * Very Subtle
+	 * If VMEMMAP_REMAP_NO_TLB_FLUSH is set, TLB flushing is not performed
+	 * immediately after remapping.  As a result, subsequent accesses
+	 * and modifications to struct pages associated with the hugetlb
+	 * page could be to the OLD struct pages.  Set the vmemmap optimized
+	 * flag here so that it is copied to the new head page.  This keeps
+	 * the old and new struct pages in sync.
+	 * If there is an error during optimization, we will immediately FLUSH
+	 * the TLB and clear the flag below.
+	 */
+	SetHPageVmemmapOptimized(head);
 
 	vmemmap_end	= vmemmap_start + hugetlb_vmemmap_size(h);
 	vmemmap_reuse	= vmemmap_start;
@@ -651,11 +668,12 @@ static int __hugetlb_vmemmap_optimize(const struct hstate *h,
 	 * mapping the range to vmemmap_pages list so that they can be freed by
 	 * the caller.
 	 */
-	ret = vmemmap_remap_free(vmemmap_start, vmemmap_end, vmemmap_reuse, vmemmap_pages);
-	if (ret)
+	ret = vmemmap_remap_free(vmemmap_start, vmemmap_end, vmemmap_reuse,
+							vmemmap_pages, flags);
+	if (ret) {
 		static_branch_dec(&hugetlb_optimize_vmemmap_key);
-	else
-		SetHPageVmemmapOptimized(head);
+		ClearHPageVmemmapOptimized(head);
+	}
 
 	return ret;
 }
@@ -674,7 +692,7 @@ void hugetlb_vmemmap_optimize(const struct hstate *h, struct page *head)
 {
 	LIST_HEAD(vmemmap_pages);
 
-	__hugetlb_vmemmap_optimize(h, head, &vmemmap_pages);
+	__hugetlb_vmemmap_optimize(h, head, &vmemmap_pages, 0);
 	free_vmemmap_page_list(&vmemmap_pages);
 }
 
@@ -719,19 +737,28 @@ void hugetlb_vmemmap_optimize_folios(struct hstate *h, struct list_head *folio_l
 
 	list_for_each_entry(folio, folio_list, lru) {
 		int ret = __hugetlb_vmemmap_optimize(h, &folio->page,
-								&vmemmap_pages);
+						&vmemmap_pages,
+						VMEMMAP_REMAP_NO_TLB_FLUSH);
 
 		/*
 		 * Pages to be freed may have been accumulated.  If we
 		 * encounter an ENOMEM,  free what we have and try again.
+		 * This can occur in the case that both spliting fails
+		 * halfway and head page allocation also failed. In this
+		 * case __hugetlb_vmemmap_optimize() would free memory
+		 * allowing more vmemmap remaps to occur.
 		 */
 		if (ret == -ENOMEM && !list_empty(&vmemmap_pages)) {
+			flush_tlb_all();
 			free_vmemmap_page_list(&vmemmap_pages);
 			INIT_LIST_HEAD(&vmemmap_pages);
-			__hugetlb_vmemmap_optimize(h, &folio->page, &vmemmap_pages);
+			__hugetlb_vmemmap_optimize(h, &folio->page,
+						&vmemmap_pages,
+						VMEMMAP_REMAP_NO_TLB_FLUSH);
 		}
 	}
 
+	flush_tlb_all();
 	free_vmemmap_page_list(&vmemmap_pages);
 }
 
-- 
2.41.0

