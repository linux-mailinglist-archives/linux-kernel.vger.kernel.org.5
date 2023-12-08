Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E74E809BAA
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 06:21:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233060AbjLHFVm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 00:21:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232077AbjLHFVi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 00:21:38 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96EF710F1;
        Thu,  7 Dec 2023 21:21:44 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B82Sm53019457;
        Fri, 8 Dec 2023 05:21:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=NoFuyu/t9Pec//WyeQ5g/V4mc5VpN86s9d9kKvgGrf8=;
 b=YcjPqF6HVshSbOyOV1PQgHXItFzdfnuZ5BHI7gkDW/q6fur731Xw14KxRGUStguvSTlO
 NXWrZo6WXXwBUpZXHS3UwmAUSIaZlNcOi+QwM0lcfO5KWJY10FVHfGjRlP7wNOf19jTD
 IJPGKIjhhMKsGaw+S+x21jLjH/h+IUISZYkMGLEYr2R5CTSjqkn+haEwtPm73NYcoaVi
 NKZsoNRiIoGlsxyNq4fsWklaEPlN2xXoj34PED353DGnJFje0II7bP8hiaIjHrNq8dZJ
 1e2nKnNJnBNR/KuuCgPWSTU4sjKVa90P9n36Awvj7yPYYiWK3vkmAnx2BueEtjtP7xp9 pQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3utdmbnddv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 08 Dec 2023 05:21:39 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3B84b0xZ037433;
        Fri, 8 Dec 2023 05:21:38 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3utan8epup-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 08 Dec 2023 05:21:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BOC+dvVJ8T5chBkWiE2wCVMSQR7laQU8j9Gb/fzbB5JA11PSJ3Fz3J9vJBHgE4iNzWUxe4g3fHOuhGYMZjvTSwWJuDYb0Z4ZrvPDZSistZWaQB1gi+K1CaSv3QgjQZ2DIWTc0BuVGnLOmlLFrf+Eiq8+NFyxDX+HF3HPkMcxMsL8I1Guh1JDBEYzQN8smBBM6fxgIzOEA2F9tIirnl2/bcgIJ6Iz67N08uTffm89nx3c7jv7sJgVhTwU0tHyvPWLW56VIjNQzgyqJGAFbJxocoppXnZ7FOtE0EUHW6SMUCD/gc7sBhjAtLUIJ8UV+5n99eBxbYWn9TAdhzj76rXHGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NoFuyu/t9Pec//WyeQ5g/V4mc5VpN86s9d9kKvgGrf8=;
 b=dkNa2NACJYq+OmdXqmlZ89Lit1h7Ylf1/BvmPIlewKESwfqEz1LoLg10UvzGbXoLi0t2j0hdgdu34+zNLAlv11L/2BGCGw9mT6sC22iN24WGd5nuviNzcsWn2jTBEt5qighoDU0KxMtFnyUzuJxkksoI2HlA+wpol5deZtK1gvCSaNPEAWNcpe/to7dKHkiHY51LNKTs57H8//SK3uKoM85Gwy0U1+s1HL+ANZStTxQGb0oqvrgFMy6KhUTcKnlgR5kIHrwVVIHjqu9QzY624/01Q55F4n0Hxygc9yHdZXIKl9ALu4Vl+I3+Jf0jWR1/iW63BU+ktxw8nPJxhggjKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NoFuyu/t9Pec//WyeQ5g/V4mc5VpN86s9d9kKvgGrf8=;
 b=tm1oBfaKo8qUWv5UVssdVH0iTZow1naLp8PdFr8xVNcO5ezaZjcxDaCIEqbuBVGXIzDJP8Ddfi86ahXaxhniw4j3i6YZOO7wLA3TsQ+FLOGREgf/TlbwpjSqwfJIF61lGDmPFpSUr2BZ2FwpBY9x2EPAw1AW0406X49d2Bz44yY=
Received: from SN6PR10MB2975.namprd10.prod.outlook.com (2603:10b6:805:d2::10)
 by SJ0PR10MB6325.namprd10.prod.outlook.com (2603:10b6:a03:44a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.27; Fri, 8 Dec
 2023 05:21:35 +0000
Received: from SN6PR10MB2975.namprd10.prod.outlook.com
 ([fe80::de47:3c1f:a55b:58d0]) by SN6PR10MB2975.namprd10.prod.outlook.com
 ([fe80::de47:3c1f:a55b:58d0%7]) with mapi id 15.20.7068.028; Fri, 8 Dec 2023
 05:21:35 +0000
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
Subject: [PATCH 6/6] module: add install target for modules.builtin.ranges
Date:   Fri,  8 Dec 2023 00:07:52 -0500
Message-ID: <20231208050752.2787575-7-kris.van.hees@oracle.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231208050752.2787575-1-kris.van.hees@oracle.com>
References: <20231208050752.2787575-1-kris.van.hees@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0165.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::20) To SN6PR10MB2975.namprd10.prod.outlook.com
 (2603:10b6:805:d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB2975:EE_|SJ0PR10MB6325:EE_
X-MS-Office365-Filtering-Correlation-Id: e545ea73-48c6-4c1c-7695-08dbf7ad8c14
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xdiz/i4YM8uO5AMcp30Xlcn6q5BY8xGdwtXIRJg7toUiPVvaRahavzEr+gfljPUTEKHZ+RfJfcMyNprEHiPIqDp4+UNx5s0yjk02X6iWJOVQbC7XQtYPt+vKN5ZEhn1cpOYkMv1IIcPVHDsSmPzTeWyghaOwQ5Jtrig9u9zaE3HLjZ7Q9lUADIug4SkosTqHLj1jbP9eH6drlqaqNM1v6xl+Ov1cNFvPM1tRMic34iz6unf10JoakP0cZZzMCrqeI/2tQECyJzpZ874tfDpzI+ic7ha7s242Jz9ZBUiG1ZEpNvzVxQwv9Ho1um6DslLq6aDY6IpztKC2tfg0QuI3RlCJhDjQm67q3pwCeTV8HItkNoJwE5mMIwGa7gGyf9cSjVMUqs4zB/78+GV5NHB95BvBP8gZlGe1jnB2y0ij8H1Yc7fEgg7/ibH3uYFED4/ai5APHDRluUHd0vlyEeAKJsSAKyff9q5Mt7yqlZvaLlK764jYhnDgCnsYGhQSoNob0E+KgxSUIXguhIxeq2dw4TMY30FvT/lmTQB2aBezgEERHMAd/PghuGQtAx1RnX6o
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB2975.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(346002)(366004)(136003)(396003)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(4744005)(4326008)(8676002)(8936002)(103116003)(2906002)(86362001)(5660300002)(36756003)(41300700001)(83380400001)(6512007)(6666004)(6506007)(1076003)(2616005)(26005)(38100700002)(54906003)(478600001)(66556008)(66476007)(66946007)(6486002)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?au/9Kunh1itviq4mdtbhpXDd/n8W4P2LhDU80hWKZ8tMSBNTFlAf3NIZE1i1?=
 =?us-ascii?Q?c5ioLtaK59ER07bD2h30PVQNl/9gPiHy4ioWO+7hTFN6j9xqji/J7XDmuvCU?=
 =?us-ascii?Q?XXIYvN5KldJ37T97CqyI2FTkp4BLn1qA4R+lBqF8MM0bLBnB/IPs0gYl48y7?=
 =?us-ascii?Q?p96u5eC/3hKtk4R49iWQUOhRzhU43pF8RmTRfIMdci5+zhCB86n5mRU4tQk+?=
 =?us-ascii?Q?xq0eyliKxQx0ae8Z282Vj1L7ixXokU3mX1p5ptG3s2EIHXrRcKZOB+SFxI6F?=
 =?us-ascii?Q?5ruQgiFOe4f3GlP0xH3NN4GH2tiyTSgNSfRnAOxVa7eAF6c0KE2YVpf7DQvL?=
 =?us-ascii?Q?JmV47c+DaR2Sgfxf+7cTpnNxPU4LlaFJI3pwje+ps69iCon0YuYTd87pigDA?=
 =?us-ascii?Q?4CL/i1bxg2blHdP3/3bcF7oOHLgaUw6z0lW+cWCA16LaEIg+OWvZ1K1Pdt7e?=
 =?us-ascii?Q?4EnVooHYbFqpeYTFi96OUkGefRf5WyXVmr0ie9JnY32mvo4Ldh5W7q/E0tHQ?=
 =?us-ascii?Q?Uj2VrypriL3ocgg8goxRJZb0iEjtqvLAeDrOEAPDbMAQLyT6YAtdZHKDLWXb?=
 =?us-ascii?Q?2vdH/innP5av2xy3E3yqw0MeZZZqZ0IXV65q52MP6sDXyLDqwA1t7jQYydKX?=
 =?us-ascii?Q?T0jZmd5S+himBoBfAhuCL7Lwx18i9Mf/uZci0bLH6vDjgAPys9eNturjYppI?=
 =?us-ascii?Q?QYp8Mgh8sfJOZ2/R0quKQQ1S9ZhsbcfYjx1/1Y00afsD9VGcjtY07onkiZCP?=
 =?us-ascii?Q?/t4xvYOonWcJvVJAWxtM7emhzw6uN9H0ZKfe/tNDz522t8Zf4Su/5t2ndFup?=
 =?us-ascii?Q?7od0e9ReWVnfpjokm0o7NKyleir68MkFKD3FxdE3s8o5aTlWPR0BKRAhDjO4?=
 =?us-ascii?Q?MqoVXxH5Ay0E6hH5X2MgxWSDOZbKFFC4D6Ng4Z4+S5JSUykqIiQzBj7yPneq?=
 =?us-ascii?Q?bn5v6w+B6BEqwmiUxqH5xWWyvQv+wzBMZ1iFN3LtLwZ36OcfPE43zajlK4mH?=
 =?us-ascii?Q?36zs7mhWP1d1iXmg/xqfNmzB8ZaMZBP4oqunaGPtfh3WQ8kgB2cKO7LSG7uU?=
 =?us-ascii?Q?8di6XHXqvCTvjJLSlcsjaNcXNsGwPQbMp6Edajn57Qb55cLCu6iv5Pc6xXgY?=
 =?us-ascii?Q?u48sI5hlrZhAz7Neaep86RuZZSxXnu8IlktnTxmDO2okFvI9ag3MWpKsGU79?=
 =?us-ascii?Q?3ejJ4VnbhD83ZZfX2NqiRluFrZyPwPa6dOXt/VWpI2sxIDntIY11mNxMl/Oi?=
 =?us-ascii?Q?PWMuE5f4hgyZ3W8mpDD2tfdeEQz3qGjFki2TcxyqNhc0LfaB0tUm46cUyjCd?=
 =?us-ascii?Q?P0SqnddYp9m+fS/oYd1T9ruMS6UPeKcwGKnUqA46kRqgZ5pZZOaSmnPXLgaD?=
 =?us-ascii?Q?LPF6/Wo+0f+utXoJEP6J2rdpknIIsdRGn3oIK1uGEun9k1UTrhBnwwEkUmfQ?=
 =?us-ascii?Q?P2+WbY9liIHxWV4UDYLOliUicuKwT4k1zsU9JcqTF6GormLFdUT09xISg/Di?=
 =?us-ascii?Q?NQW002YnLKZgxKu8GZYgdjbkECA9ABi8klUEzT/jQfHWDWuvBKOUOCYsk0Ec?=
 =?us-ascii?Q?fERAGmvDLHFUqDjpv9iL81jAKtWRTcAdT1KrlgF5A/PiculuGD+bSXMLk4S5?=
 =?us-ascii?Q?ig=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: GiL3q+Xmtwd8YSocyeftn4cyw0ZcSOZW0zH+iR5fVYTk75y35cv9Vc1RReKdqkb3hb8mQh1tHGI7P/xWn4Eva0pCMiXORacokRc15K5GZWFDz/sR3JdWLm/N7eXxS12dJvHLgVNIB2+nRxuZ/XH2CPIxHGJAZ09brvqIfdIWrCWZHLiqVEbqQB6ArGCm1JSG5w+PNNc8phhC51kYndoGZDLZBLnenaiVIUyUCLJkzo+ga+v3w87eJ3l8ZfEIt0diK3tirO5st/KkjAWXzYbhssoR/aP8frvg2CErvruXNhJYD1drhfErXIJDfafaPnu9zkXzdMDFIpWFofiLmBpVzFHjGgnOczJcRZTOXxt8/cztpO2j1oERCaXDajyc0ZPMQA7RncSkmRn59GU9ceXt6s2PhPrlC47V9BNiBwD1tua+8GErGDr+fvhxLEFrP8XtwmRnyYvkEoeUmbMhFXu55Ry/BQMXqipJh96O8B+BwdoZFq4LDbhtSWO3qqt30loIc8x0VNxpbLIVudNTUE3dFwcw0T50tpT42AKEyBF1q5sEjITRliUdEIlnZ8UUt+ypjvJNog/RNEb4ZmHXES3CfrsjSwCluS/KxwgaMLkSf6XihtpUnEgleCZSYeRE2A9wXh4+AROts9W3fRrS8VE3dVtfTb4V74uI+7Pu8meRByEoYcCshySCjybBVzTy+Y2Q2htuqDCQ04F92qlDA6FSLck0vzELDIe8SH6Fen0FqUM39T5QdwCKMfmyjdFApRmrhQfHTdTAmKZBEj4k+Nr8HXwbRd/eumtmWOGg+LUK12fGPnhYrSeLGET35vPG0F6X+cOO6U10gb5SrFW4kPMdm86mJptcxNi7fQnQWelcKwxRLij60aU5sxlTRz8CJiFT
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e545ea73-48c6-4c1c-7695-08dbf7ad8c14
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB2975.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2023 05:21:35.5641
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yo9THaOVaDXaSv1sFLb3KaLsWJ0yKUxMekVYZxe/Eh+Iv8JTBoBuW3qenCHkpE1RivB9FQ0mkuoF/QFdSlhQDh/p1KrH/qQyWE6XeH3ddz4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB6325
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-08_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 malwarescore=0
 suspectscore=0 mlxscore=0 adultscore=0 bulkscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2312080040
X-Proofpoint-ORIG-GUID: CHbh5dGH6rJs2PdgbKRxX0PZQpt2WAId
X-Proofpoint-GUID: CHbh5dGH6rJs2PdgbKRxX0PZQpt2WAId
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When CONFIG_BUILTIN_RANGES is enable, the modules.builtin.ranges file
should be installed in the module install location.

Signed-off-by: Kris Van Hees <kris.van.hees@oracle.com>
Reviewed-by: Nick Alcock <nick.alcock@oracle.com>
---
 scripts/Makefile.modinst | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/scripts/Makefile.modinst b/scripts/Makefile.modinst
index b45586aa1de4..f30f5ea04566 100644
--- a/scripts/Makefile.modinst
+++ b/scripts/Makefile.modinst
@@ -36,6 +36,11 @@ install-y += $(addprefix $(MODLIB)/, modules.builtin modules.builtin.modinfo mod
 $(addprefix $(MODLIB)/, modules.builtin modules.builtin.modinfo modules.builtin.objs): $(MODLIB)/%: % FORCE
 	$(call cmd,install)
 
+install-$(CONFIG_BUILTIN_RANGES) += $(MODLIB)/modules.builtin.ranges
+
+$(MODLIB)/modules.builtin.ranges: modules.builtin.ranges FORCE
+	$(call cmd,install)
+
 endif
 
 modules := $(call read-file, $(MODORDER))
-- 
2.42.0

