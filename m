Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B950809BA6
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 06:21:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233004AbjLHFVK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 00:21:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjLHFVH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 00:21:07 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF03310F7;
        Thu,  7 Dec 2023 21:21:12 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B85F0Lx007545;
        Fri, 8 Dec 2023 05:21:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=X0qjoUt/h7SR0/2/aOztxJtsjhdmjcOcAN3tFB1FMmE=;
 b=lsCAziNXdueBhCME4tZfJN+PGVGeDjTKV0xAtp87/vhGx3Z+ui4rj8z2K71VKCyexQCS
 0bsM32vJdJdadRcbAfYnlfphFu99tkQ759MNprVm3fzwXUwERj8wArmTqG8XijQnBbYL
 qg2YR5Ho+k7JAqMsuiIrL/J1JcwbwYy2E4pVrfmspbOQRfvfoVvG9wCC7u9nDBHeCUK8
 p81dQ5ola/rMy1+zpHSoXPMfJUzOyT6KE8ka6HOpvxip+8+zKntTjBlveLCaNMzXqUgi
 eaivot2xZAeduI5CtLv1F0ZtBreNpd4ErjFcVnEsgLZXI8zmb68y1WZWHussr4JBOnSi zg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3utdabw6qq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 08 Dec 2023 05:21:06 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3B84Pc7S012655;
        Fri, 8 Dec 2023 05:21:05 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2040.outbound.protection.outlook.com [104.47.51.40])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3utanbqb86-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 08 Dec 2023 05:21:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mv5v05LDA8Y70t0e0y5+eINRLBMdeFjXXP4b1RkKYDLHmGqIzeJNXidr2TWQGVUB7l/+Ih7Fbgut/yLbvFax2cAkfo7kQ9CApXDvxPD6YE7KIx1G8I7JNurjz4bWFCG+uQ/tnBby243zbAIFUsZbTb8aXVvMD1VP2tcA6efAe/zUNopuFY4Ynx0XLfH9iDZ9AzX5Uel4Sgga/vWIzxMI39mxSsgK2c2MZMTJfQQjN1SX+GkMA9YvanGxG1NLDREWCxHMbTS/+NJA9YvMvoaFk3AH/CJuEsZCG5N8fpYl1u73Iao9WSqmV5xHOf8lLmbKOnmn1CgPjW3cGtk5bnzlYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X0qjoUt/h7SR0/2/aOztxJtsjhdmjcOcAN3tFB1FMmE=;
 b=fBYtim6lVEUQstvBq2mMj/ukW14BZB8s4va1tBiHkAkYUigCVK1f9348TuHUXMExALZWW6Fk8Tw7ipQVqzc8ZRw1sbmj8PQ+cYLjBtO4kPw7Fk7OaGSGx9Nbrrli5Dl3rpDO4RtiBxJPDrV0i9fNJUGJnep3js0PFzjiRBP68HHciCOrC2cTGb2IgDiG16ykLS+jFszNcfPzPgpUM4V7OeD1c5ejjZ0J6e+aPFa7Y3sDQRchE5gwoNyaCbWaTEz/KTUROvDtdKexKVuPzibUl7j1heX9gdLte9aCNzALZWxow9O8rN4X+UW9bPM0KaIj9AwhhQfhZjSjNsYZ4buAow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X0qjoUt/h7SR0/2/aOztxJtsjhdmjcOcAN3tFB1FMmE=;
 b=YPpoMiHuBFTbbsEqbgRULaISQlqmP49Nb0VuAwNE2/YkOE44IZFbr3U8FLFHgxbgwN43YWkaj1dFtCEAfdZmDDwm4025i77WX/Is7l5WihtnYq7JpTgkh7Sob8nRiJsZkgTrTblRyTBind5UFWzCePKsmRSDvhLa3jd0mBDRsIY=
Received: from SN6PR10MB2975.namprd10.prod.outlook.com (2603:10b6:805:d2::10)
 by SJ0PR10MB6325.namprd10.prod.outlook.com (2603:10b6:a03:44a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.27; Fri, 8 Dec
 2023 05:20:58 +0000
Received: from SN6PR10MB2975.namprd10.prod.outlook.com
 ([fe80::de47:3c1f:a55b:58d0]) by SN6PR10MB2975.namprd10.prod.outlook.com
 ([fe80::de47:3c1f:a55b:58d0%7]) with mapi id 15.20.7068.028; Fri, 8 Dec 2023
 05:20:58 +0000
From:   Kris Van Hees <kris.van.hees@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-modules@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Cc:     Kris Van Hees <kris.van.hees@oracle.com>,
        Nick Alcock <nick.alcock@oracle.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Jiri Olsa <olsajiri@gmail.com>
Subject: [PATCH 5/6] kbuild: generate modules.builtin.ranges when linking the kernel
Date:   Fri,  8 Dec 2023 00:07:51 -0500
Message-ID: <20231208050752.2787575-6-kris.van.hees@oracle.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231208050752.2787575-1-kris.van.hees@oracle.com>
References: <20231208050752.2787575-1-kris.van.hees@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0036.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::11) To SN6PR10MB2975.namprd10.prod.outlook.com
 (2603:10b6:805:d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB2975:EE_|SJ0PR10MB6325:EE_
X-MS-Office365-Filtering-Correlation-Id: 939becaf-1a26-48f6-785f-08dbf7ad760b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dbvoZQ3VqiBuKe8RB/4FH+CwQ4vx5fQmizXZ2PjqJbpDE1m8TgKGdkMPSdwuv31qHch53+7NsttWEoDFPMEHg/pqGu5tQfYvzjikgVOGU8CEJJNIPsQcOMBzijMX9rz1CYXBwW73gslxisb4AntVIYt4/08JK7GP0Nvq1FQ3wa2gq60hELM3jcQmla0sKqRt7AMl31k/1RLeZA6umhxGIzI0nbEDs3wqX83pIy0uKmTrrZzxy1SOxurAFP39Ern+pUupW1Q1JKtB6DUU32fKU8bNUPqauHChOJhvZkqkD58XO6EyHDC+8dclNh3poJnZKPtcKUWKZGbWcpHj4bX6xUkJUlO20dbQ+WxICs2SG96uE8lOLaqbuBq8h9ruNWy5nJM4lzhTra8EqLbv+GzjuRHzxg73DuBBC3HPkgKztuYbVHKuicnDUeK//26SkZM4i4/rs0TnHe+xvUd1sUoDTa/nn/hNWFqfyPoVtnY7bcjO60Wx4xDJwjNk0sTslvGrOJg8Y9vO5HbqRD+BRezcEbgqqIPoLQKDGh23a4RVkprtnIIkCf2L4F8UocVe0oyM
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB2975.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(346002)(366004)(136003)(396003)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(4326008)(8676002)(8936002)(103116003)(2906002)(86362001)(5660300002)(36756003)(41300700001)(6512007)(6666004)(6506007)(1076003)(2616005)(26005)(38100700002)(54906003)(478600001)(66556008)(66476007)(66946007)(6486002)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ulbWeG+fwHXH0wnv9zUXLV//iasNdlI7qUo+AO5dxdFOuibne67Rzr1r6Rb1?=
 =?us-ascii?Q?40nhIRdU81O2MZZO1iZ6pY7IHkGnbCsleUrHMnzAcCoyfo6Q3+z2eGeXMZdI?=
 =?us-ascii?Q?sDJXhu0BCKxiLKIsqiIzyJHu3SD6qB84WujFr5NLfgsCUoxGTcue/dZaxq0u?=
 =?us-ascii?Q?W1MXhvVQkFBoJncsfbPyaPmTDiYw0HI73iLQ9XlUgituoqrVbc5+bHXZU35Z?=
 =?us-ascii?Q?TZ6NfFMAhQ6VATyX3iezRa+ActWepe3WWnrJSgZr7NVq3i1Ps/aASemC7ENx?=
 =?us-ascii?Q?Ea0Z1gWFP4tpND/G7CW6jPiEjL/0CdUByHPNsfIef4/RDlrJMUbYViB0S364?=
 =?us-ascii?Q?sJImPZ0gmlwUIT9Pz2UIkUkKVhPSiPgJkSC7aH4znqipVvWGvmzLu3+GqRsv?=
 =?us-ascii?Q?FojGcXxwkOCDvG+8ZtIxNByPprvvpTXIdaeS4kBOMBFGzjrbD13ddDi8h52q?=
 =?us-ascii?Q?zVllHXThulWwGN1RLVJKvStC+K91H8te3MrB4UwVXgs4VB7w36wuMbYNKhOf?=
 =?us-ascii?Q?o4Bn5eyjtNXGsVxZBmd5DYLh/l7fJbhZhBkgdemBAXELnHSGVS9xNa6myjc5?=
 =?us-ascii?Q?ysGfQaIBoxUHHqucFh7VgNW1xLnSsM88SRHaO6e2L5Plt2kfz0nGyL7WBRem?=
 =?us-ascii?Q?lH6ajnyVXQX+COxC+nOlRJaviaYnFgra3x4geTzhy6LFiuyDsATpZaFnkzBQ?=
 =?us-ascii?Q?515hY9HcWXXHWlMLqbvGnmdmO8WI8J+odUsP7ZMvKEKvYqhi4KN2AY/SO60N?=
 =?us-ascii?Q?75KG4OPYfxzjh8LfTQu9ETxAjxxuKeCEMrG4ioariravT8WISPofg2OaR5AS?=
 =?us-ascii?Q?BWdu3KuIc4l7eD/DyHnsGvK9jfp8oWjUTjTod64MdIKEzSOsEjuwmnQAHk+C?=
 =?us-ascii?Q?uMUvBnt27K7c2Yf/uQE7f3YEWcVsuzmkF9UIsrdjhwN0wcg3Y8VcpyCrvz+X?=
 =?us-ascii?Q?8CzRUZ5Fti8LYF6BF9nQaqQM+aPqP9tQCKsXXUAO5w/jscA2lE6dD6EsEB/h?=
 =?us-ascii?Q?TqVz/hoF0CMcB+FTVMTxRLNGUCFVqUzEQGe2zKz89Vfi8EjKZvkp0A/oG5BX?=
 =?us-ascii?Q?aV3f6Ru6klNB9qDTyTBsmxK9nGsZ4G7/IlbedKp0Ez6HcXk4SCU/XUXpK+Jr?=
 =?us-ascii?Q?kj5sj32mSA81miI+nZyedoey3CdoL5qjj87CwkBEWx1Rqxp1LUOwlhvSmYwB?=
 =?us-ascii?Q?RQMovKKMudQjXB0ComtT0nrYE81K39qtOmiHliZm6UBtwAMNOAgMge8EYk7b?=
 =?us-ascii?Q?dOqo9hGzAuxwTFtlQBaX9hPfLPY8DVieA5HNoRglAQFEMzvUxRG41DNKpT1p?=
 =?us-ascii?Q?/daft0PZ3c/XMUyTTJCcXtg9Rnp8jRYx1q2wOyhbGt9Hpl4uU+3ijm09AAOE?=
 =?us-ascii?Q?WyW9y/DYBaLcIrBoay8XnI1tQEdBQN6no92twKazulFQYeyUJ9KPxCp4RCBd?=
 =?us-ascii?Q?NYLpN0NktSStWjYjSgBHXWUzEVHk6UbqHqjXKHyn0H2tz6QA1Gg1a/eON7g1?=
 =?us-ascii?Q?7HqBH+mX1woaHiAKVMCRn6HwpjT9k1wuUbaXwC589icCAXHZm+kPHWW7GOv4?=
 =?us-ascii?Q?6fMLBX0UTzySVvlHN6pPScQfnN2gySVgFsFMjsry4uIVRPAXPrND+frTJjx2?=
 =?us-ascii?Q?PA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Q4RLlEDZ4Eu+xBtITccXnsAb74qE3sORh9yE8dWnYhm4rsXNVTYTfaKJ8KvBjWiWz+C8wtuDezxC43rukyb6QFdWxvrgo2s02gvwgRxYiZqJOekFFBwTRSAhCFdBeaBgRE199iCAP2bGNl4MD0/kI/HzOAegKYDcMjgN90yMY8crG6G9V334oxG4+xeC1bGYfLiqAtr2NwuIlakQ+wob8tPGzDdGoHwIzEbWHNGm8OY5u4BaTFOgX/Spc0Nd48uvlJDW0ZiBQv8P742+GtIyJ3UFDVqL5x+Au5IyXW3BNnYJ3CDypUtXbZVVF/GEEPzdo4XCl81LvEl0U9PHOroYgE2nyo1aqh3xpyUsEyHxuBptQcWC5KEfpHpMGjhoQLhQ0gOYLmjZknpNirOAQ0UPP89LY3bQiSAU40lOBJNCsx/mjrkcwU4mYDE0V5feXA65Ke13C8Ro6KDbpdsABoAdaM/9zvlbf5IWgPTb6PPsMKWC8yDZJhXttXQJ4hpreUFG5aAsxWcM2fZKh9YDkmbzz8vbT6EvQ1oeA63sC2R3O3YPhD0M/mL7u6yYRz5/PH6/yGp7wQs8L04jWc7Q0P39dVnriJdeddkEsZr2uhPaoMkNDyKaGJZKo3U4HtVkq2YDxBfXyypYNP+RCW1fX/Bjc+o3+afqjxEj4F7p6A1JG5/uRUCehmIu3MTUpFkEzjuYXY+49DvbkmHWcPYD9GHdUfcN4Wn1xNg58SWsoitUmJlksYQQBHENXgdanMF2stSwr2rpyRgKhb8FKuKr6W5hWUsz1Y0ZLoGzTgNcclWhYTrsZnbIELDn8NGUFfLPUTqruDU8MQXPvjX+C7pB2WDjRlbjSnAFF6zun+gL7KXRMto5XnwA/plE+5Vrtyek4Kpe
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 939becaf-1a26-48f6-785f-08dbf7ad760b
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB2975.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2023 05:20:58.5611
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aOTfOMNTHiBvsFqPgJ2c2dysS67i6pf5aKl/Az8lqIdTSOImrdZNHnk/QIaAt+x6HVcceNUmNeQ+gn0oS9ywhERgmRzGe4yJeWdm/RDlzxI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB6325
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-08_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 suspectscore=0
 mlxscore=0 bulkscore=0 mlxlogscore=999 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2312080040
X-Proofpoint-ORIG-GUID: W0nWDiDLCPAYUF9AAujW9lx26poEYlYv
X-Proofpoint-GUID: W0nWDiDLCPAYUF9AAujW9lx26poEYlYv
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Kris Van Hees <kris.van.hees@oracle.com>
Reviewed-by: Nick Alcock <nick.alcock@oracle.com>
---
 scripts/Makefile.vmlinux | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/scripts/Makefile.vmlinux b/scripts/Makefile.vmlinux
index c9f3e03124d7..c23d40b023ff 100644
--- a/scripts/Makefile.vmlinux
+++ b/scripts/Makefile.vmlinux
@@ -36,6 +36,23 @@ targets += vmlinux
 vmlinux: scripts/link-vmlinux.sh vmlinux.o $(KBUILD_LDS) FORCE
 	+$(call if_changed_dep,link_vmlinux)
 
+# module.builtin.ranges
+# ---------------------------------------------------------------------------
+ifdef CONFIG_BUILTIN_RANGES
+__default: modules.builtin.ranges
+
+quiet_cmd_modules_builtin_ranges = GEN     $@
+      cmd_modules_builtin_ranges = \
+	$(srctree)/scripts/generate_builtin_ranges.awk \
+	  $(filter-out FORCE,$+) > $@
+
+vmlinux.map: vmlinux
+
+targets += modules.builtin.ranges
+modules.builtin.ranges: modules.builtin.objs vmlinux.map vmlinux.o.map FORCE
+	$(call if_changed,modules_builtin_ranges)
+endif
+
 # Add FORCE to the prequisites of a target to force it to be always rebuilt.
 # ---------------------------------------------------------------------------
 
-- 
2.42.0

