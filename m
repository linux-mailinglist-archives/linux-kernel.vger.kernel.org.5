Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 212F477068F
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 19:01:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbjHDRBU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 13:01:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231558AbjHDRBQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 13:01:16 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DB8D4EFB
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 10:00:55 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 374EiDn7002929;
        Fri, 4 Aug 2023 17:00:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=m65lrO2qFmAh9M4Ry8wuMUS7xfZox23yZiJJhAn8EW0=;
 b=siBp/O0fpVZ2ngoPKQvky8N6TfJNdNd0d0bNRxBMTMpcqha367GYghbNyg62RooCDG+k
 y1WN2uYBCm1gqmRZ1R/MGpSD0Ddei0tGySv9EjM98KJOsB/LaZ59O7b6AbUT60KYc6Vq
 eu2TsbclXyh+RclgYSPckfG2WBpyZbpPfQ0MDKwqtq9/orJX1CP3fpRVqwQ+9zf84NGc
 w/TX4D139fFYTxUX5RzeTvmRPBm1JQ5G9Bgjku7eumHcBKHjz0eeCt37WX0GPMv9ncEz
 UfgQxqNGcXJ6eJTTpc5LBQqPXZh16Dm9+zt1PVbQndJqWH/FiKnSfn5DR8DpeeMR6tHe OQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s4spcc9w7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 04 Aug 2023 17:00:36 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 374FOjaY011606;
        Fri, 4 Aug 2023 17:00:36 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2107.outbound.protection.outlook.com [104.47.70.107])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3s8m2s3hxt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 04 Aug 2023 17:00:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gOxgs4DzR+mhVvgUcO4Z+11Xh6M4rSo7H2+u+aEvxnqRqNvbHxAiwnLEB1/euAXvRG0T1dSB0KePgSoxRGh6Kry88ZmNu95cM7zFbxfsprEIvG7H0NP1IoEhM4nwqVch3mvCu8Okexi5KaaKeMHjMrP/NjZT8ZHg7X/H7llP9O6D5RQxEYK+aPlkucQdioDWPqqC2TEtz+uIIct8qbciRABo/dstwj6W6gQWoYQuixF/hqLJK71mV6Mw2Qiozk1ySs5Sej63YFrLZXl3npIy0SJnuHC50XyZn2y36pIVNfldYSPToEVmx/tTGqNANIXK9fbPvLmGSmFtO4cEI+JzCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m65lrO2qFmAh9M4Ry8wuMUS7xfZox23yZiJJhAn8EW0=;
 b=YsSuwzH9Qo4oIUwOHj5DguCzJdZXe8K/PfoIeQGa2XivRpaTWqbfHtfI4IFIGvATtBlHdQLVq2sEN2dyG+Am4HjY5D9g9dr1fJBRegcM5sIJ/fzXp0ef61FumuWPAu8lL8ZBYwlKnr9FwqU5OzIfpYMGAF0cxiuMIDNr8eUlfnmddXgSNXzdhLpzbmRV+ABqBxsisO23X89DvC3A8jhntpN2pf/8rE3kX1Nr8TTLDpbiTPl5Qb5PJWUsZrV2tXfXPCOl9oak4oppw2okh8Fe3iLIv40pvZq58pq2Mw/4mmHzyH0T/q/tf+ytJdSBUqmReAQBzupDBGSUHktJ2OvFfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m65lrO2qFmAh9M4Ry8wuMUS7xfZox23yZiJJhAn8EW0=;
 b=z6ILSysOieTbcmXsux5cQ+XPQyTNy8ux7XmrL5p+gIXz40gItzlezt0zNk7mjLigx1nWUyem08tCxb7GfP9VIeQ05cCL4I59bzbWgKQjJLo2sXcdSF150j9IBJQ+qXGcDQQeOPrFFidn/hR4e/tnlnkLt9dfeindWM1B0VYF7EM=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CH0PR10MB4939.namprd10.prod.outlook.com (2603:10b6:610:c0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.21; Fri, 4 Aug
 2023 17:00:32 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::26d3:6f41:6415:8c35]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::26d3:6f41:6415:8c35%3]) with mapi id 15.20.6631.046; Fri, 4 Aug 2023
 17:00:32 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH 6/6] maple_tree: Replace data before marking dead in split and spanning store
Date:   Fri,  4 Aug 2023 12:59:51 -0400
Message-Id: <20230804165951.2661157-7-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230804165951.2661157-1-Liam.Howlett@oracle.com>
References: <20230804165951.2661157-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0166.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:ac::27) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|CH0PR10MB4939:EE_
X-MS-Office365-Filtering-Correlation-Id: ff35facf-918c-4829-5544-08db950c5081
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: A/xJAayClsC2SomTNEBlCZ6rh/mmvUD8BsxpAqzrQhJ1ajxd7um82zAQuLr99R03k8xIlEnrylyG3piJZ916BF2EYYqRl0EADqHH0LPBmwpC67ilp1tOhA/OJug+9+BjY/xYGxnBzw9HadbglAHkerx3HoWLSA24eudeHkfzJzwnpnRql6wIftAgO2jK9bzIP/HMUxu0wDjoWBTzZIu3KJfw6FfDJCC55Args7ClHR7PkaxW2mnLZH8tPt1WIs1WKLQxO0e7Vvgdxlk8vLodebMn+RnxcnEvlrZ8aXpTU6lpicbXObbEmRYCUb+j5Ofx9NiHpT/iC5hcWxFBLVHOZ5m/o6F+CVR+7vSc1kvcFG1fEtLpCiIvwEOp7kxczzL6uO/6CBxHRv4zkuBxEY9M2oCAbDez/HVmJSCeY7jG0udwXjAN63/yUNWufMR/Q41S08ky344ULTexKflffNGIskqqgIfXXDm8fnp21wfdyWAptWFZE0Oh75pcoz3JODdnY58akyDN83qwBmQiWM8hH2XBfOrxcBoKXdq7f00E3M584SPWVeEEdYJ/MVJIgd4F
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(396003)(39860400002)(346002)(376002)(136003)(186006)(451199021)(1800799003)(6666004)(6486002)(6512007)(86362001)(6506007)(26005)(1076003)(107886003)(36756003)(2616005)(83380400001)(38100700002)(5660300002)(41300700001)(8936002)(8676002)(4326008)(6916009)(66476007)(2906002)(66556008)(66946007)(316002)(30864003)(478600001)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?drUee/OZjF9XdWStFvLeBlAphd/ZnNA5NcJrrcPSSDsMsRNAkjtZgcoIpJQN?=
 =?us-ascii?Q?V0CwNHWm37PrzZLYqrlNnZ4sWuhdmhPg3RAx4hhaE4p/oSgRkix60e4xSrCm?=
 =?us-ascii?Q?FibbsSuJQc/xcOIq95dL9c+OcwqL5cXUU8zEAxTmErNZpwefIUucpKMdKcKA?=
 =?us-ascii?Q?5HDpNZuVfrPVuhEiEL3skuwhlMV02R5nN5z/+u71KlhClrxub89uNn1XTMrh?=
 =?us-ascii?Q?CHUeEfOpquCcjeJ/Bbj9zyP7kUhHmpCSxO3zBxIDVQ0+BlPixpljvrDIvxLw?=
 =?us-ascii?Q?M2eA+1TdPM5KimTclPtUmeiSBAvLgQhjaABC4ipGIR5n+1lk3tSFKE/bOrp6?=
 =?us-ascii?Q?m5DWz7x/Gj8WaFCOAmFgTJa/2okK7Lu/YQGSBrLA+Ffraiir4E3nKkh9wY6/?=
 =?us-ascii?Q?wW/2quUG5E2OUrtAybPsSmetazXDmu9xYwsaPBObWhkArSfuumKlZrLfNmh1?=
 =?us-ascii?Q?Q8sy59vYeD+2usEUp5ubv674ooMmj8/QMOg+52iQA3yA6iT0waFf3d5OYKmp?=
 =?us-ascii?Q?YCJUIv1unL6NE9Lb3CweOmLZuwTj0ZRSSmUVVFfbGTOtjQUeq4+V817ACGBs?=
 =?us-ascii?Q?3vyG1gaQNUmbHBw0LB6RX/3Z+4w7LniMLxfKytj4SCoZ5QKGKowrZW0wTPtA?=
 =?us-ascii?Q?sm5bj6axAEQbbrtS5OuagHusmiszIPjXQQ/oGzpTcfAjc0OzSSNOIKfhqN1g?=
 =?us-ascii?Q?ICPWW4JeOgQzJ2Rl57pyfTL/CbOaghaZOCXPAQbe21DRUlR5ckoxnxyFCQUZ?=
 =?us-ascii?Q?jWYrd/0aotbmimewiQAD4H2Us8X6g9PRCwXUaucYGfGvkmroSKSCcNh+yb1c?=
 =?us-ascii?Q?GpNQw6FFCBZoH5m8ot8hkYxrSR5BPpmur7zA1ztCgUTa4hELE5cMu7jhO3+P?=
 =?us-ascii?Q?1/nyw9aArSZXoei4CALd9ghEYBDrnGim56PCZlAcC59NL3cxffYJT6arTgK3?=
 =?us-ascii?Q?w9Iz+9OgGPaXiMBzN6obXp0wbm/GtEA9q72F5YF8IzLzQjsAKe78PxKwTmNI?=
 =?us-ascii?Q?lxqAItg4u/tJ264rNSCvhuyf7kVWvcmZVvVTYCUvOdAZHFu/d2ijjjzhZ1ie?=
 =?us-ascii?Q?3QxDnIiE3IE4ffH+hqMgCW8G8PQzZuv7h15qzHTITGB3MA0JERXLsT5u3p41?=
 =?us-ascii?Q?7WDWO42S9O0zRGLaooTv8uLfLru6O1YTpwzVfXR5pUQ4st4Cn0yIP5QG4MMe?=
 =?us-ascii?Q?jPYK4D1mzMKz15ml/8dZ1xxNUfJjw1dDPbs7OiXJCMBb62WKS4gYmUDhGXjI?=
 =?us-ascii?Q?S/DanANuiEGsBaGQRb9yTbfcpWUrKsgPuBj+3UlrMBdPkALlFg3yxPw5j5fj?=
 =?us-ascii?Q?vHTMswh7/dbGiFkulIFpDhs7+ISne8646+tfU5H088B0K8sjqGXgdqkLlt37?=
 =?us-ascii?Q?KgMdfyph1odSLW+Ve7kVmpqXcAkyPfzp7H2zmmuDonP+BqEHS2o52Nr4j65V?=
 =?us-ascii?Q?ocBk8LnpeAwY5bRhO1iDUjrha5RqbTmqPV7qAjpL5sJwy/ybMKSoBZIKBiXq?=
 =?us-ascii?Q?Ep7tfP5AVWsPmus91pKLccXLNdwWUAGVgq50odYifNE65edUBEA0PQUKdPBY?=
 =?us-ascii?Q?rGZQ/AG+q2KQ8lw4P27OKu7VkchOQtm5orf7q2Mq2/eSrxRLRMtULAbYcmKM?=
 =?us-ascii?Q?dA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?g/CkzaosCmgi1TUiWOUnHxjf1Q08RQuMzM8Rs0C7AlpxiMmzh2q1v4y7Yvgl?=
 =?us-ascii?Q?8jgTAD60sadnvxRlQesFEaIlRNCEK5RAguwxaZo5KFH0y2uhJht4hTXQyXdT?=
 =?us-ascii?Q?akQWblaBSMq0KXBwntHS9k+cWTeQFTqbMuq4Txh8eKNgTR72+ZY9K0CW2HYz?=
 =?us-ascii?Q?44FUfkyPnoZ4u27RU+3p5xhSQ79/+DcMOyVuwqnu3n2lfKQoJjY1GE7scBrT?=
 =?us-ascii?Q?I0sUrqDpU/8DL2A4dAQydy0Yr79zDWsdGsRIBHSjH69PFTOD1B5nKkq0y9WJ?=
 =?us-ascii?Q?61Etxr9QnQGtSb9SFbR1rQUytW07+OgeU0ZTKYMO7E6MS/cD/wsXO0xuCAk2?=
 =?us-ascii?Q?jXQ+nazOssYlWSosfhdcyYSD573rX5MdfRaUjH2Mt4gNgz/ynYwE4BhgdwYT?=
 =?us-ascii?Q?XMihwZnDG4v98vF1hSCSNdx7QOxlk/RROF27yH67WRvENLb+6OVcFNqArDup?=
 =?us-ascii?Q?PHmFeJjTa5Vj9tRNiaDFm8lBxuwUIXbsZ1nrHNnysSOZTyh/d/wlmxGE5zhU?=
 =?us-ascii?Q?WmrKbSwjvXH+3SENSkEqAp2NFAilxE4Kr4DUhh3XIrdoIdRksvT0ZwDpoaFU?=
 =?us-ascii?Q?nIOAKC4YEjjSp6nSrkmUbWVaMlqLtNfvBBgoAEN5gxqzHJPiYBV/250XHXct?=
 =?us-ascii?Q?XjKqbxiwYrBgwWJAiOEOEA6sIcHY4UTdwlD5DZUNJcC1jT3ohLxNyBZ94syN?=
 =?us-ascii?Q?y7gHMalpdyNiNKwAy10OGzWGZ9cXtyPL1kNawcT8bujAIJOtUaMAtsW3TexL?=
 =?us-ascii?Q?oWS3iRmANKQkK5ceF/xYXxIKYaauy+8UmvivMqKz6rQ5BqXy5QUg3lHRW7GG?=
 =?us-ascii?Q?v0xoydKnhtG/n7TwE2kBWvzirxB0F1uTtVKaQa46xgTB1FSOHChlaMnrCPjo?=
 =?us-ascii?Q?wB2qxyS2FeOHi30oVjO00jgybs3ciVIdSl89UsqlsIOMoQA2Ge/4RNfmxHtf?=
 =?us-ascii?Q?VJCBsElcUcWJmhal0XAS5GO536xLHwaeWzFHnb5KkH0=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff35facf-918c-4829-5544-08db950c5081
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2023 17:00:32.8119
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HmoyJepjIlIaW4bXerUYLblY1dN9U4QGscerk4AGClSNE/hXudPAH7yRRXd1yMGekDXyL619z4QiPDSU6Dubzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4939
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-04_16,2023-08-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 phishscore=0
 mlxscore=0 spamscore=0 adultscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308040151
X-Proofpoint-ORIG-GUID: MKoSml2S4K5IJulrLV5KuaJWlkqmBszm
X-Proofpoint-GUID: MKoSml2S4K5IJulrLV5KuaJWlkqmBszm
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reorder the operations for split and spanning stores so that new data is
placed in the tree prior to marking the old data as dead.  This will
limit re-walks on dead data to just once instead of a retry loop.

The order of operations is as follows: Create the new data, put the new
data in place, mark the top node of the old data as dead.

Then repair parent links in the reused nodes through all levels of the
tree, following the new nodes downwards.  Finally walk the top dead node
looking for nodes that are no longer used, or subtrees that should be
destroyed (marked dead throughout then freed), follow the partially used
nodes downwards to discover other dead nodes and subtrees.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 lib/maple_tree.c | 493 ++++++++++++++++-------------------------------
 1 file changed, 168 insertions(+), 325 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 8e94f5495a97..ffb9d15bd815 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -982,27 +982,9 @@ static inline void mat_add(struct ma_topiary *mat,
 	mat->tail = dead_enode;
 }
 
-static void mte_destroy_walk(struct maple_enode *, struct maple_tree *);
-static inline void mas_free(struct ma_state *mas, struct maple_enode *used);
-
-/*
- * mas_mat_free() - Free all nodes in a dead list.
- * @mas - the maple state
- * @mat - the ma_topiary linked list of dead nodes to free.
- *
- * Free walk a dead list.
- */
-static void mas_mat_free(struct ma_state *mas, struct ma_topiary *mat)
-{
-	struct maple_enode *next;
-
-	while (mat->head) {
-		next = mte_to_mat(mat->head)->next;
-		mas_free(mas, mat->head);
-		mat->head = next;
-	}
-}
-
+static void mt_free_walk(struct rcu_head *head);
+static void mt_destroy_walk(struct maple_enode *enode, struct maple_tree *mt,
+			    bool free);
 /*
  * mas_mat_destroy() - Free all nodes and subtrees in a dead list.
  * @mas - the maple state
@@ -1013,10 +995,15 @@ static void mas_mat_free(struct ma_state *mas, struct ma_topiary *mat)
 static void mas_mat_destroy(struct ma_state *mas, struct ma_topiary *mat)
 {
 	struct maple_enode *next;
+	struct maple_node *node;
+	bool in_rcu = mt_in_rcu(mas->tree);
 
 	while (mat->head) {
 		next = mte_to_mat(mat->head)->next;
-		mte_destroy_walk(mat->head, mat->mtree);
+		node = mte_to_node(mat->head);
+		mt_destroy_walk(mat->head, mas->tree, !in_rcu);
+		if (in_rcu)
+			call_rcu(&node->rcu, mt_free_walk);
 		mat->head = next;
 	}
 }
@@ -1759,11 +1746,11 @@ static inline void mas_replace_node(struct ma_state *mas,
 }
 
 /*
- * mas_new_child() - Find the new child of a node.
- * @mas: the maple state
+ * mas_find_child() - Find a child who has the parent @mas->node.
+ * @mas: the maple state with the parent.
  * @child: the maple state to store the child.
  */
-static inline bool mas_new_child(struct ma_state *mas, struct ma_state *child)
+static inline bool mas_find_child(struct ma_state *mas, struct ma_state *child)
 	__must_hold(mas->tree->ma_lock)
 {
 	enum maple_type mt;
@@ -2065,56 +2052,6 @@ static inline void mab_mas_cp(struct maple_big_node *b_node,
 	}
 }
 
-/*
- * mas_descend_adopt() - Descend through a sub-tree and adopt children.
- * @mas: the maple state with the maple encoded node of the sub-tree.
- *
- * Descend through a sub-tree and adopt children who do not have the correct
- * parents set.  Follow the parents which have the correct parents as they are
- * the new entries which need to be followed to find other incorrectly set
- * parents.
- */
-static inline void mas_descend_adopt(struct ma_state *mas)
-{
-	struct ma_state list[3], next[3];
-	int i, n;
-
-	/*
-	 * At each level there may be up to 3 correct parent pointers which indicates
-	 * the new nodes which need to be walked to find any new nodes at a lower level.
-	 */
-
-	for (i = 0; i < 3; i++) {
-		list[i] = *mas;
-		list[i].offset = 0;
-		next[i].offset = 0;
-	}
-	next[0] = *mas;
-
-	while (!mte_is_leaf(list[0].node)) {
-		n = 0;
-		for (i = 0; i < 3; i++) {
-			if (mas_is_none(&list[i]))
-				continue;
-
-			if (i && list[i-1].node == list[i].node)
-				continue;
-
-			while ((n < 3) && (mas_new_child(&list[i], &next[n])))
-				n++;
-
-			mas_adopt_children(&list[i], list[i].node);
-		}
-
-		while (n < 3)
-			next[n++].node = MAS_NONE;
-
-		/* descend by setting the list to the children */
-		for (i = 0; i < 3; i++)
-			list[i] = next[i];
-	}
-}
-
 /*
  * mas_bulk_rebalance() - Rebalance the end of a tree after a bulk insert.
  * @mas: The maple state
@@ -2304,98 +2241,6 @@ static inline void mas_wr_node_walk(struct ma_wr_state *wr_mas)
 	wr_mas->offset_end = mas->offset = offset;
 }
 
-/*
- * mas_topiary_range() - Add a range of slots to the topiary.
- * @mas: The maple state
- * @destroy: The topiary to add the slots (usually destroy)
- * @start: The starting slot inclusively
- * @end: The end slot inclusively
- */
-static inline void mas_topiary_range(struct ma_state *mas,
-	struct ma_topiary *destroy, unsigned char start, unsigned char end)
-{
-	void __rcu **slots;
-	unsigned char offset;
-
-	MAS_BUG_ON(mas, mte_is_leaf(mas->node));
-
-	slots = ma_slots(mas_mn(mas), mte_node_type(mas->node));
-	for (offset = start; offset <= end; offset++) {
-		struct maple_enode *enode = mas_slot_locked(mas, slots, offset);
-
-		if (mte_dead_node(enode))
-			continue;
-
-		mat_add(destroy, enode);
-	}
-}
-
-/*
- * mast_topiary() - Add the portions of the tree to the removal list; either to
- * be freed or discarded (destroy walk).
- * @mast: The maple_subtree_state.
- */
-static inline void mast_topiary(struct maple_subtree_state *mast)
-{
-	MA_WR_STATE(wr_mas, mast->orig_l, NULL);
-	unsigned char r_start, r_end;
-	unsigned char l_start, l_end;
-	void __rcu **l_slots, **r_slots;
-
-	wr_mas.type = mte_node_type(mast->orig_l->node);
-	mast->orig_l->index = mast->orig_l->last;
-	mas_wr_node_walk(&wr_mas);
-	l_start = mast->orig_l->offset + 1;
-	l_end = mas_data_end(mast->orig_l);
-	r_start = 0;
-	r_end = mast->orig_r->offset;
-
-	if (r_end)
-		r_end--;
-
-	l_slots = ma_slots(mas_mn(mast->orig_l),
-			   mte_node_type(mast->orig_l->node));
-
-	r_slots = ma_slots(mas_mn(mast->orig_r),
-			   mte_node_type(mast->orig_r->node));
-
-	if ((l_start < l_end) &&
-	    mte_dead_node(mas_slot_locked(mast->orig_l, l_slots, l_start))) {
-		l_start++;
-	}
-
-	if (mte_dead_node(mas_slot_locked(mast->orig_r, r_slots, r_end))) {
-		if (r_end)
-			r_end--;
-	}
-
-	if ((l_start > r_end) && (mast->orig_l->node == mast->orig_r->node))
-		return;
-
-	/* At the node where left and right sides meet, add the parts between */
-	if (mast->orig_l->node == mast->orig_r->node) {
-		return mas_topiary_range(mast->orig_l, mast->destroy,
-					     l_start, r_end);
-	}
-
-	/* mast->orig_r is different and consumed. */
-	if (mte_is_leaf(mast->orig_r->node))
-		return;
-
-	if (mte_dead_node(mas_slot_locked(mast->orig_l, l_slots, l_end)))
-		l_end--;
-
-
-	if (l_start <= l_end)
-		mas_topiary_range(mast->orig_l, mast->destroy, l_start, l_end);
-
-	if (mte_dead_node(mas_slot_locked(mast->orig_r, r_slots, r_start)))
-		r_start++;
-
-	if (r_start <= r_end)
-		mas_topiary_range(mast->orig_r, mast->destroy, 0, r_end);
-}
-
 /*
  * mast_rebalance_next() - Rebalance against the next node
  * @mast: The maple subtree state
@@ -2431,7 +2276,7 @@ static inline void mast_rebalance_prev(struct maple_subtree_state *mast)
 /*
  * mast_spanning_rebalance() - Rebalance nodes with nearest neighbour favouring
  * the node to the right.  Checking the nodes to the right then the left at each
- * level upwards until root is reached.  Free and destroy as needed.
+ * level upwards until root is reached.
  * Data is copied into the @mast->bn.
  * @mast: The maple_subtree_state.
  */
@@ -2440,8 +2285,6 @@ bool mast_spanning_rebalance(struct maple_subtree_state *mast)
 {
 	struct ma_state r_tmp = *mast->orig_r;
 	struct ma_state l_tmp = *mast->orig_l;
-	struct maple_enode *ancestor = NULL;
-	unsigned char start, end;
 	unsigned char depth = 0;
 
 	r_tmp = *mast->orig_r;
@@ -2450,87 +2293,25 @@ bool mast_spanning_rebalance(struct maple_subtree_state *mast)
 		mas_ascend(mast->orig_r);
 		mas_ascend(mast->orig_l);
 		depth++;
-		if (!ancestor &&
-		    (mast->orig_r->node == mast->orig_l->node)) {
-			ancestor = mast->orig_r->node;
-			end = mast->orig_r->offset - 1;
-			start = mast->orig_l->offset + 1;
-		}
-
 		if (mast->orig_r->offset < mas_data_end(mast->orig_r)) {
-			if (!ancestor) {
-				ancestor = mast->orig_r->node;
-				start = 0;
-			}
-
 			mast->orig_r->offset++;
 			do {
 				mas_descend(mast->orig_r);
 				mast->orig_r->offset = 0;
-				depth--;
-			} while (depth);
+			} while (--depth);
 
 			mast_rebalance_next(mast);
-			do {
-				unsigned char l_off = 0;
-				struct maple_enode *child = r_tmp.node;
-
-				mas_ascend(&r_tmp);
-				if (ancestor == r_tmp.node)
-					l_off = start;
-
-				if (r_tmp.offset)
-					r_tmp.offset--;
-
-				if (l_off < r_tmp.offset)
-					mas_topiary_range(&r_tmp, mast->destroy,
-							  l_off, r_tmp.offset);
-
-				if (l_tmp.node != child)
-					mat_add(mast->free, child);
-
-			} while (r_tmp.node != ancestor);
-
 			*mast->orig_l = l_tmp;
 			return true;
-
 		} else if (mast->orig_l->offset != 0) {
-			if (!ancestor) {
-				ancestor = mast->orig_l->node;
-				end = mas_data_end(mast->orig_l);
-			}
-
 			mast->orig_l->offset--;
 			do {
 				mas_descend(mast->orig_l);
 				mast->orig_l->offset =
 					mas_data_end(mast->orig_l);
-				depth--;
-			} while (depth);
+			} while (--depth);
 
 			mast_rebalance_prev(mast);
-			do {
-				unsigned char r_off;
-				struct maple_enode *child = l_tmp.node;
-
-				mas_ascend(&l_tmp);
-				if (ancestor == l_tmp.node)
-					r_off = end;
-				else
-					r_off = mas_data_end(&l_tmp);
-
-				if (l_tmp.offset < r_off)
-					l_tmp.offset++;
-
-				if (l_tmp.offset < r_off)
-					mas_topiary_range(&l_tmp, mast->destroy,
-							  l_tmp.offset, r_off);
-
-				if (r_tmp.node != child)
-					mat_add(mast->free, child);
-
-			} while (l_tmp.node != ancestor);
-
 			*mast->orig_r = r_tmp;
 			return true;
 		}
@@ -2542,36 +2323,24 @@ bool mast_spanning_rebalance(struct maple_subtree_state *mast)
 }
 
 /*
- * mast_ascend_free() - Add current original maple state nodes to the free list
- * and ascend.
+ * mast_ascend() - Ascend the original left and right maple states.
  * @mast: the maple subtree state.
  *
- * Ascend the original left and right sides and add the previous nodes to the
- * free list.  Set the slots to point to the correct location in the new nodes.
+ * Ascend the original left and right sides.  Set the offsets to point to the
+ * data already in the new tree (@mast->l and @mast->r).
  */
-static inline void
-mast_ascend_free(struct maple_subtree_state *mast)
+static inline void mast_ascend(struct maple_subtree_state *mast)
 {
 	MA_WR_STATE(wr_mas, mast->orig_r,  NULL);
-	struct maple_enode *left = mast->orig_l->node;
-	struct maple_enode *right = mast->orig_r->node;
-
 	mas_ascend(mast->orig_l);
 	mas_ascend(mast->orig_r);
-	mat_add(mast->free, left);
-
-	if (left != right)
-		mat_add(mast->free, right);
 
 	mast->orig_r->offset = 0;
 	mast->orig_r->index = mast->r->max;
 	/* last should be larger than or equal to index */
 	if (mast->orig_r->last < mast->orig_r->index)
 		mast->orig_r->last = mast->orig_r->index;
-	/*
-	 * The node may not contain the value so set slot to ensure all
-	 * of the nodes contents are freed or destroyed.
-	 */
+
 	wr_mas.type = mte_node_type(mast->orig_r->node);
 	mas_wr_node_walk(&wr_mas);
 	/* Set up the left side of things */
@@ -2750,66 +2519,152 @@ static inline void mast_set_split_parents(struct maple_subtree_state *mast,
 }
 
 /*
- * mas_wmb_replace() - Write memory barrier and replace
- * @mas: The maple state
- * @free: the maple topiary list of nodes to free
- * @destroy: The maple topiary list of nodes to destroy (walk and free)
+ * mas_topiary_node() - Dispose of a singe node
+ * @mas: The maple state for pushing nodes
+ * @enode: The encoded maple node
+ * @in_rcu: If the tree is in rcu mode
  *
- * Updates gap as necessary.
+ * The node will either be RCU freed or pushed back on the maple state.
  */
-static inline void mas_wmb_replace(struct ma_state *mas,
-				   struct ma_topiary *free,
-				   struct ma_topiary *destroy)
+static inline void mas_topiary_node(struct ma_state *mas,
+		struct maple_enode *enode, bool in_rcu)
 {
-	struct maple_enode *old_enode;
+	struct maple_node *tmp;
 
-	if (mte_is_root(mas->node)) {
-		old_enode = mas_root_locked(mas);
-	} else {
-		unsigned char offset = mte_parent_slot(mas->node);
-		void __rcu **slots = ma_slots(mte_parent(mas->node),
-					      mas_parent_type(mas, mas->node));
+	if (enode == MAS_NONE)
+		return;
 
-		old_enode = mas_slot_locked(mas, slots, offset);
-	}
+	tmp = mte_to_node(enode);
+	mte_set_node_dead(enode);
+	if (in_rcu)
+		ma_free_rcu(tmp);
+	else
+		mas_push_node(mas, tmp);
+}
 
-	/* Insert the new data in the tree */
+/*
+ * mas_topiary_replace() - Replace the data with new data, then repair the
+ * parent links within the new tree.  Iterate over the dead sub-tree and collect
+ * the dead subtrees and topiary the nodes that are no longer of use.
+ *
+ * The new tree will have up to three children with the correct parent.  Keep
+ * track of the new entries as they need to be followed to find the next level
+ * of new entries.
+ *
+ * The old tree will have up to three children with the old parent.  Keep track
+ * of the old entries as they may have more nodes below replaced.  Nodes within
+ * [index, last] are dead subtrees, others need to be freed and followed.
+ *
+ * @mas: The maple state pointing at the new data
+ * @old_enode: The maple encoded node being replaced
+ *
+ */
+static inline void mas_topiary_replace(struct ma_state *mas,
+		struct maple_enode *old_enode)
+{
+	struct ma_state tmp[3], tmp_next[3];
+	MA_TOPIARY(subtrees, mas->tree);
+	bool in_rcu;
+	int i, n;
+
+	/* Place data in tree & then mark node as old */
 	mas_put_in_tree(mas, old_enode);
 
-	if (!mte_is_leaf(mas->node))
-		mas_descend_adopt(mas);
+	/* Update the parent pointers in the tree */
+	tmp[0] = *mas;
+	tmp[0].offset = 0;
+	tmp[1].node = MAS_NONE;
+	tmp[2].node = MAS_NONE;
+	while (!mte_is_leaf(tmp[0].node)) {
+		n = 0;
+		for (i = 0; i < 3; i++) {
+			if (mas_is_none(&tmp[i]))
+				continue;
+
+			while (n < 3) {
+				if (!mas_find_child(&tmp[i], &tmp_next[n]))
+					break;
+				n++;
+			}
+
+			mas_adopt_children(&tmp[i], tmp[i].node);
+		}
 
-	mas_mat_free(mas, free);
+		if (MAS_WARN_ON(mas, n == 0))
+			break;
 
-	if (destroy)
-		mas_mat_destroy(mas, destroy);
+		while (n < 3)
+			tmp_next[n++].node = MAS_NONE;
 
-	if (mte_is_leaf(mas->node))
-		return;
+		for (i = 0; i < 3; i++)
+			tmp[i] = tmp_next[i];
+	}
 
-	mas_update_gap(mas);
+	/* Collect the old nodes that need to be discarded */
+	if (mte_is_leaf(old_enode))
+		return mas_free(mas, old_enode);
+
+	tmp[0] = *mas;
+	tmp[0].offset = 0;
+	tmp[0].node = old_enode;
+	tmp[1].node = MAS_NONE;
+	tmp[2].node = MAS_NONE;
+	in_rcu = mt_in_rcu(mas->tree);
+	do {
+		n = 0;
+		for (i = 0; i < 3; i++) {
+			if (mas_is_none(&tmp[i]))
+				continue;
+
+			while (n < 3) {
+				if (!mas_find_child(&tmp[i], &tmp_next[n]))
+					break;
+
+				if ((tmp_next[n].min >= tmp_next->index) &&
+				    (tmp_next[n].max <= tmp_next->last)) {
+					mat_add(&subtrees, tmp_next[n].node);
+					tmp_next[n].node = MAS_NONE;
+				} else {
+					n++;
+				}
+			}
+		}
+
+		if (MAS_WARN_ON(mas, n == 0))
+			break;
+
+		while (n < 3)
+			tmp_next[n++].node = MAS_NONE;
+
+		for (i = 0; i < 3; i++) {
+			mas_topiary_node(mas, tmp[i].node, in_rcu);
+			tmp[i] = tmp_next[i];
+		}
+	} while (!mte_is_leaf(tmp[0].node));
+
+	for (i = 0; i < 3; i++)
+		mas_topiary_node(mas, tmp[i].node, in_rcu);
+
+	mas_mat_destroy(mas, &subtrees);
 }
 
 /*
- * mast_new_root() - Set a new tree root during subtree creation
- * @mast: The maple subtree state
+ * mas_wmb_replace() - Write memory barrier and replace
  * @mas: The maple state
+ * @old: The old maple encoded node that is being replaced.
+ *
+ * Updates gap as necessary.
  */
-static inline void mast_new_root(struct maple_subtree_state *mast,
-				 struct ma_state *mas)
+static inline void mas_wmb_replace(struct ma_state *mas,
+		struct maple_enode *old_enode)
 {
-	mas_mn(mast->l)->parent = ma_parent_ptr(mas_tree_parent(mas));
-	if (!mte_dead_node(mast->orig_l->node) &&
-	    !mte_is_root(mast->orig_l->node)) {
-		do {
-			mast_ascend_free(mast);
-			mast_topiary(mast);
-		} while (!mte_is_root(mast->orig_l->node));
-	}
-	if ((mast->orig_l->node != mas->node) &&
-		   (mast->l->depth > mas_mt_height(mas))) {
-		mat_add(mast->free, mas->node);
-	}
+	/* Insert the new data in the tree */
+	mas_topiary_replace(mas, old_enode);
+
+	if (mte_is_leaf(mas->node))
+		return;
+
+	mas_update_gap(mas);
 }
 
 /*
@@ -2995,12 +2850,11 @@ static int mas_spanning_rebalance(struct ma_state *mas,
 	unsigned char split, mid_split;
 	unsigned char slot = 0;
 	struct maple_enode *left = NULL, *middle = NULL, *right = NULL;
+	struct maple_enode *old_enode;
 
 	MA_STATE(l_mas, mas->tree, mas->index, mas->index);
 	MA_STATE(r_mas, mas->tree, mas->index, mas->last);
 	MA_STATE(m_mas, mas->tree, mas->index, mas->index);
-	MA_TOPIARY(free, mas->tree);
-	MA_TOPIARY(destroy, mas->tree);
 
 	/*
 	 * The tree needs to be rebalanced and leaves need to be kept at the same level.
@@ -3009,8 +2863,6 @@ static int mas_spanning_rebalance(struct ma_state *mas,
 	mast->l = &l_mas;
 	mast->m = &m_mas;
 	mast->r = &r_mas;
-	mast->free = &free;
-	mast->destroy = &destroy;
 	l_mas.node = r_mas.node = m_mas.node = MAS_NONE;
 
 	/* Check if this is not root and has sufficient data.  */
@@ -3018,7 +2870,7 @@ static int mas_spanning_rebalance(struct ma_state *mas,
 	    unlikely(mast->bn->b_end <= mt_min_slots[mast->bn->type]))
 		mast_spanning_rebalance(mast);
 
-	mast->orig_l->depth = 0;
+	l_mas.depth = 0;
 
 	/*
 	 * Each level of the tree is examined and balanced, pushing data to the left or
@@ -3029,7 +2881,7 @@ static int mas_spanning_rebalance(struct ma_state *mas,
 	 * original tree and the partially new tree.  To remedy the parent pointers in
 	 * the old tree, the new data is swapped into the active tree and a walk down
 	 * the tree is performed and the parent pointers are updated.
-	 * See mas_descend_adopt() for more information..
+	 * See mas_topiary_replace() for more information.
 	 */
 	while (count--) {
 		mast->bn->b_end--;
@@ -3046,13 +2898,13 @@ static int mas_spanning_rebalance(struct ma_state *mas,
 		 */
 		memset(mast->bn, 0, sizeof(struct maple_big_node));
 		mast->bn->type = mte_node_type(left);
-		mast->orig_l->depth++;
+		l_mas.depth++;
 
 		/* Root already stored in l->node. */
 		if (mas_is_root_limits(mast->l))
 			goto new_root;
 
-		mast_ascend_free(mast);
+		mast_ascend(mast);
 		mast_combine_cp_left(mast);
 		l_mas.offset = mast->bn->b_end;
 		mab_set_b_end(mast->bn, &l_mas, left);
@@ -3061,7 +2913,6 @@ static int mas_spanning_rebalance(struct ma_state *mas,
 
 		/* Copy anything necessary out of the right node. */
 		mast_combine_cp_right(mast);
-		mast_topiary(mast);
 		mast->orig_l->last = mast->orig_l->max;
 
 		if (mast_sufficient(mast))
@@ -3083,7 +2934,7 @@ static int mas_spanning_rebalance(struct ma_state *mas,
 
 	l_mas.node = mt_mk_node(ma_mnode_ptr(mas_pop_node(mas)),
 				mte_node_type(mast->orig_l->node));
-	mast->orig_l->depth++;
+	l_mas.depth++;
 	mab_mas_cp(mast->bn, 0, mt_slots[mast->bn->type] - 1, &l_mas, true);
 	mas_set_parent(mas, left, l_mas.node, slot);
 	if (middle)
@@ -3094,23 +2945,20 @@ static int mas_spanning_rebalance(struct ma_state *mas,
 
 	if (mas_is_root_limits(mast->l)) {
 new_root:
-		mast_new_root(mast, mas);
+		mas_mn(mast->l)->parent = ma_parent_ptr(mas_tree_parent(mas));
+		while (!mte_is_root(mast->orig_l->node))
+			mast_ascend(mast);
 	} else {
 		mas_mn(&l_mas)->parent = mas_mn(mast->orig_l)->parent;
 	}
 
-	if (!mte_dead_node(mast->orig_l->node))
-		mat_add(&free, mast->orig_l->node);
-
-	mas->depth = mast->orig_l->depth;
-	*mast->orig_l = l_mas;
-	mte_set_node_dead(mas->node);
-
-	/* Set up mas for insertion. */
-	mast->orig_l->depth = mas->depth;
-	mast->orig_l->alloc = mas->alloc;
-	*mas = *mast->orig_l;
-	mas_wmb_replace(mas, &free, &destroy);
+	old_enode = mast->orig_l->node;
+	mas->depth = l_mas.depth;
+	mas->node = l_mas.node;
+	mas->min = l_mas.min;
+	mas->max = l_mas.max;
+	mas->offset = l_mas.offset;
+	mas_wmb_replace(mas, old_enode);
 	mtree_range_walk(mas);
 	return mast->bn->b_end;
 }
@@ -3341,7 +3189,6 @@ static inline void mast_fill_bnode(struct maple_subtree_state *mast,
 					 unsigned char skip)
 {
 	bool cp = true;
-	struct maple_enode *old = mas->node;
 	unsigned char split;
 
 	memset(mast->bn->gap, 0, sizeof(unsigned long) * ARRAY_SIZE(mast->bn->gap));
@@ -3353,7 +3200,6 @@ static inline void mast_fill_bnode(struct maple_subtree_state *mast,
 		cp = false;
 	} else {
 		mas_ascend(mas);
-		mat_add(mast->free, old);
 		mas->offset = mte_parent_slot(mas->node);
 	}
 
@@ -3457,13 +3303,11 @@ static inline bool mas_push_data(struct ma_state *mas, int height,
 	split = mt_slots[mast->bn->type] - 2;
 	if (left) {
 		/*  Switch mas to prev node  */
-		mat_add(mast->free, mas->node);
 		*mas = tmp_mas;
 		/* Start using mast->l for the left side. */
 		tmp_mas.node = mast->l->node;
 		*mast->l = tmp_mas;
 	} else {
-		mat_add(mast->free, tmp_mas.node);
 		tmp_mas.node = mast->r->node;
 		*mast->r = tmp_mas;
 		split = slot_total - split;
@@ -3490,6 +3334,7 @@ static int mas_split(struct ma_state *mas, struct maple_big_node *b_node)
 	struct maple_subtree_state mast;
 	int height = 0;
 	unsigned char mid_split, split = 0;
+	struct maple_enode *old;
 
 	/*
 	 * Splitting is handled differently from any other B-tree; the Maple
@@ -3512,7 +3357,6 @@ static int mas_split(struct ma_state *mas, struct maple_big_node *b_node)
 	MA_STATE(r_mas, mas->tree, mas->index, mas->last);
 	MA_STATE(prev_l_mas, mas->tree, mas->index, mas->last);
 	MA_STATE(prev_r_mas, mas->tree, mas->index, mas->last);
-	MA_TOPIARY(mat, mas->tree);
 
 	trace_ma_op(__func__, mas);
 	mas->depth = mas_mt_height(mas);
@@ -3525,7 +3369,6 @@ static int mas_split(struct ma_state *mas, struct maple_big_node *b_node)
 	mast.r = &r_mas;
 	mast.orig_l = &prev_l_mas;
 	mast.orig_r = &prev_r_mas;
-	mast.free = &mat;
 	mast.bn = b_node;
 
 	while (height++ <= mas->depth) {
@@ -3565,9 +3408,9 @@ static int mas_split(struct ma_state *mas, struct maple_big_node *b_node)
 	}
 
 	/* Set the original node as dead */
-	mat_add(mast.free, mas->node);
+	old = mas->node;
 	mas->node = l_mas.node;
-	mas_wmb_replace(mas, mast.free, NULL);
+	mas_wmb_replace(mas, old);
 	mtree_range_walk(mas);
 	return 1;
 }
@@ -3903,6 +3746,7 @@ static inline void *mtree_lookup_walk(struct ma_state *mas)
 	return NULL;
 }
 
+static void mte_destroy_walk(struct maple_enode *, struct maple_tree *);
 /*
  * mas_new_root() - Create a new root node that only contains the entry passed
  * in.
@@ -3969,7 +3813,6 @@ static inline int mas_wr_spanning_store(struct ma_wr_state *wr_mas)
 	/* Left and Right side of spanning store */
 	MA_STATE(l_mas, NULL, 0, 0);
 	MA_STATE(r_mas, NULL, 0, 0);
-
 	MA_WR_STATE(r_wr_mas, &r_mas, wr_mas->entry);
 	MA_WR_STATE(l_wr_mas, &l_mas, wr_mas->entry);
 
-- 
2.39.2

