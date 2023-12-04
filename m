Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A31B8802F46
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 10:51:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343712AbjLDJvM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 04:51:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbjLDJvI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 04:51:08 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10olkn2014.outbound.protection.outlook.com [40.92.42.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57DDBD7;
        Mon,  4 Dec 2023 01:51:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GT6xtPxn6EaprrOwYfxS5rN23x9k6h5UgSOacRlYA65umn6A5Gfe3O1nfjE1778Vf7NTvVsCfh79VaEXj1UKm+hmmYRnryf5v+f1yxnsLH3I68TufS9ilx7q2IMJgSHmaAQIhG3h1xFjUtoos4CbWT/A41adVNR8Gxxh3tJqZOGpeeIbofdbInPYhIJtDfOY/3zw2lZ9UVMplu6lYqlZOQOrKFaNkixpqL4btU+sNB2jQpqH5ox3NaeyKecHa8IPm8rK6pWbWwYiO7IGhpgeDbqH8c/EuC0FNoNM2JA99YBpGck2rsFajb0Yq6nlfLlzAFQScqW4X5eqXWTXHIpvaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p4R2wutvcBHmuFu3qJlMQQpJPtZM/vGXv+N6H7rd5dk=;
 b=nYTUefz+kVYJhsEYNq7yJW0S7inTUbR0Qxmgmo3KnrPSxRWYY5wpIz6bw5G8CGTV/YawXcoQQ1gvUg7CJVrpdVT1nDuJ++cyNPVxNq5b6ZgSbEpJvHjbYCcyFFWNTkm+KX6ZisNSxUbeYIiE9JJYPFyfL3MHnFM8767PqEIZDuFEP88BeT4pOkfnxXWtdMomuQpuBUAixIH7HrLRX2Hh5PykvCkVg4KJ+TTZxlX/BM1DXE/uoCRrDOMrnw/QZsKdgwYIEtB6ROUdkH+WoNknxxnLP+dB4xQPM/0/811L/4S3Jj2bJyEgBGg4POVhlRI85fyXWXtIVeVFsgJ+4Hdr0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p4R2wutvcBHmuFu3qJlMQQpJPtZM/vGXv+N6H7rd5dk=;
 b=kCdJDaAQ9fxqMEHcTqCGhbRD0ZptwCS+OR3dl/qgqRaFMoMJxY65NWf8ekvTSVOrL+3a0QTUbhPIjDv7Lnmc8Ox8KqpNspHZkqAg99BYHP2ha5vxYyXf/Sjj80Y/vFDJ8AdvsdBSCosRIFByrZCIJVVoziPifp3sNFvGN0cOMVVWPl2mZz5hRv4Q9jdWGf/SddlCrtevh9zaLLx/jHzTnf5d7s9dqqlv4xRoqk4R8lP3bM8jwQgNCnzuqmnGSXiR6O4urI2fyfSsTEdwM1AkG6LTr/9aCdq4mwSX8L49K7sQBCviPV3rCaOQ7r+2a+pt+Qb4IJBB3a/mMb8a/GfN4Q==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by PH0PR20MB3718.namprd20.prod.outlook.com (2603:10b6:510::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7046.33; Mon, 4 Dec 2023 09:51:11 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::55b:c350:980:ad8]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::55b:c350:980:ad8%6]) with mapi id 15.20.7046.024; Mon, 4 Dec 2023
 09:51:11 +0000
From:   Inochi Amaoto <inochiama@outlook.com>
To:     Chao Wei <chao.wei@sophgo.com>,
        Chen Wang <unicorn_wang@outlook.com>,
        Conor Dooley <conor@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Inochi Amaoto <inochiama@outlook.com>,
        Xiaoguang Xing <xiaoguang.xing@sophgo.com>,
        Guo Ren <guoren@kernel.org>
Cc:     Anup Patel <anup@brainfault.org>,
        Samuel Holland <samuel.holland@sifive.com>,
        Jisheng Zhang <jszhang@kernel.org>,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 2/2] riscv: dts: sophgo: separate sg2042 mtime and mtimecmp to fit aclint format
Date:   Mon,  4 Dec 2023 17:51:09 +0800
Message-ID: <IA1PR20MB4953669C097D9C9E24B549FFBB86A@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <IA1PR20MB4953C912FC58C0D248976564BB86A@IA1PR20MB4953.namprd20.prod.outlook.com>
References: <IA1PR20MB4953C912FC58C0D248976564BB86A@IA1PR20MB4953.namprd20.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [EKyltk2x9H2h/jBKwgrDbowmbaNmSWD7RH+bHnMWv+Q=]
X-ClientProxiedBy: SJ0PR13CA0128.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::13) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID: <20231204095110.667480-2-inochiama@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|PH0PR20MB3718:EE_
X-MS-Office365-Filtering-Correlation-Id: aa057d35-b83f-4830-5a2c-08dbf4ae8bd7
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: J31L7LyqILWJUrQeeqELJen1d1uiADtJs6a3t3p728oopttgOXEu8A6eAIbQPjfM0+wRTiS7BGWT8nhtAVba3wW304oSrfgJt/5Xj6BT/3Pl1wTEB+/p9gM9zQxHlTkNclBSgnLysOzMI0kKsZLe4ou4Njci2LNrivrE49/pIzbg80e8fR7mlMq84EXk8rInEb/lstnDproFLGdIN/miuoIwqUnWNcnrRefsz1EUm4ulGOyshwcaVQJqdbj1Jp3hijl6O66VXSL6yfrXifTv/oi5qJDqE9LLXFFSA3m8jOC52+CcSlpt1WmTPd6MVX8GvdOPe51EMbebNk9axFiJNoljq8CqzSX7f9uZMgkz+0sc5kJjdLPnyDzg3sVZUpc8ZGv01OVXKo9gC7EuiBaeByEg1AO1ES9qHao8892FdezgsfYPdAIoXGxr+fE9dBD0NSShIiyFPLHzi0YSOMW/uERWli1urotYokGQc8IAXohamkM+ZQqT+WJ1OjBQcnbaF0V7GiN2Ck6kM4dWfUecIxzc8plEaJtYAv2FWMP9DTmoUZHspYIOv5/ZWvTxXYOaMng63M8+uG5IFS/9ZLWAQHuiUBA5NUJAHTgvitZ22IdvNx4a6viQW2gIPeRkEFL3
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?A4OdN/iQ0teVjjwfLz7IL3iNjJpbGE/07GCgMFidPNFDLOz9Mge3oMBFd/YK?=
 =?us-ascii?Q?48voJHmSa/QoTmfqBzB40zZL1KMD51DGAEfaBOXOLRq/Ytwg1tCP12X4qfzc?=
 =?us-ascii?Q?gEjnPkG6gDM54vmho3JkjZn0J2HHSvr9kMl1lX5qo+hZntz/pLB7RuIQW9rL?=
 =?us-ascii?Q?sgv1QFPj0SZ4LwND7fyih3TrtfF72eLPY00s53EyIGm6o+IF7SpiwkfzkF67?=
 =?us-ascii?Q?fwYHSxH09sivOqI9QJeTjWt8AFssgQ0FIJo3gOSmCnzw6UL84OKOX1lI3Pop?=
 =?us-ascii?Q?J9ICm7mhD0YFId2K83IkIC8eWYfAUv8xoVfv3xKhHg8fjXDtURektojIdPop?=
 =?us-ascii?Q?yeqySa9g3W3cRAwGh/zlUUUVcjVl634GKtWHgxXkcbtMf8IT9/q5cjhWbOhi?=
 =?us-ascii?Q?uXFnB6WSYKTo81SMyUvOFRy5lB1KhXge/4IFZCZThezzxe13hjZ43Z33HXDS?=
 =?us-ascii?Q?VXADw317h+6NShpoolXL3oe1DbaxcWjmOL/A91Va9cfRyfxhH7OOZKdHn/zC?=
 =?us-ascii?Q?bbEPav/uhVy6Q6ePqsYPmfmQuC1Q4eeGd3hGXjMLDa2B9JPoD40EjlE3WGKN?=
 =?us-ascii?Q?XagpWTKPKgBdcDaIS9n1mBcMGRmQ9yyesHqsVJhrRnqHcdrRRvPPDi2mseQs?=
 =?us-ascii?Q?yYgwolkF8t3S/ldZDzeteHzSNcXVB045uhpfnnxsRsoUaZumWowuG5RBh+C6?=
 =?us-ascii?Q?AfEahIeckzuJDR8AETA3g8YBOs4TTXb8YkUGtvfQk+CdzglcxZkJ6hFRMc4P?=
 =?us-ascii?Q?6aUtBOEk4R8V/N3mfKQ2RU3SFo4O+1hnTgM49+DEP4N9CjGiZwBgJ+D0cMBm?=
 =?us-ascii?Q?I4u4QxERtwH7ZE53KOxS8cusSFxw/a5UDJwZ9iy5ksjLTLFueJ6cRf8wLwkz?=
 =?us-ascii?Q?Uc53Y+HEW0eYEirv7Q1KLIp36MvjRXh8e5bdM2lJlcW5elNc60UcPyadprKc?=
 =?us-ascii?Q?Eo3yhSqmgil7HGnA4C3CdI/f9tQK0NX0MEjq++NtlsifRy0fyTSXzEnQImPI?=
 =?us-ascii?Q?lfWTYNciVU+AmH9Ks9GBM4sGpKoqDrB3oUeEd+RazHBJd6XzUINzgUDxn7+V?=
 =?us-ascii?Q?66yzTyLAIFzROsNBAwyl7EMii84Qi0ZaBVnMjekqAyXpcH7FWRdT7pnCDee1?=
 =?us-ascii?Q?u7iDvbGrIJgk+PJEUIU9z+aVC3xsHDED4kwNvCISIzMwaPLIottGeRA2hXqZ?=
 =?us-ascii?Q?ktR451ix6vvA1P6JgZ5pNZJxt7wjd6PdHi17fN7S7haa9EZRKXfkfn1d2U0?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa057d35-b83f-4830-5a2c-08dbf4ae8bd7
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2023 09:51:11.4731
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR20MB3718
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change the timer layout in the dtb to fit the format that needed by
the SBI.

Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
Fixes: 967a94a92aaa ("riscv: dts: add initial Sophgo SG2042 SoC device tree")
Reviewed-by: Chen Wang <unicorn_wang@outlook.com>
---
 arch/riscv/boot/dts/sophgo/sg2042.dtsi | 80 +++++++++++++++-----------
 1 file changed, 48 insertions(+), 32 deletions(-)

diff --git a/arch/riscv/boot/dts/sophgo/sg2042.dtsi b/arch/riscv/boot/dts/sophgo/sg2042.dtsi
index 93256540d078..ead1cc35d88b 100644
--- a/arch/riscv/boot/dts/sophgo/sg2042.dtsi
+++ b/arch/riscv/boot/dts/sophgo/sg2042.dtsi
@@ -93,144 +93,160 @@ clint_mswi: interrupt-controller@7094000000 {
 					      <&cpu63_intc 3>;
 		};

-		clint_mtimer0: timer@70ac000000 {
+		clint_mtimer0: timer@70ac004000 {
 			compatible = "sophgo,sg2042-aclint-mtimer", "thead,c900-aclint-mtimer";
-			reg = <0x00000070 0xac000000 0x00000000 0x00007ff8>;
+			reg = <0x00000070 0xac004000 0x00000000 0x0000c000>;
+			reg-names = "mtimecmp";
 			interrupts-extended = <&cpu0_intc 7>,
 					      <&cpu1_intc 7>,
 					      <&cpu2_intc 7>,
 					      <&cpu3_intc 7>;
 		};

-		clint_mtimer1: timer@70ac010000 {
+		clint_mtimer1: timer@70ac014000 {
 			compatible = "sophgo,sg2042-aclint-mtimer", "thead,c900-aclint-mtimer";
-			reg = <0x00000070 0xac010000 0x00000000 0x00007ff8>;
+			reg = <0x00000070 0xac014000 0x00000000 0x0000c000>;
+			reg-names = "mtimecmp";
 			interrupts-extended = <&cpu4_intc 7>,
 					      <&cpu5_intc 7>,
 					      <&cpu6_intc 7>,
 					      <&cpu7_intc 7>;
 		};

-		clint_mtimer2: timer@70ac020000 {
+		clint_mtimer2: timer@70ac024000 {
 			compatible = "sophgo,sg2042-aclint-mtimer", "thead,c900-aclint-mtimer";
-			reg = <0x00000070 0xac020000 0x00000000 0x00007ff8>;
+			reg = <0x00000070 0xac024000 0x00000000 0x0000c000>;
+			reg-names = "mtimecmp";
 			interrupts-extended = <&cpu8_intc 7>,
 					      <&cpu9_intc 7>,
 					      <&cpu10_intc 7>,
 					      <&cpu11_intc 7>;
 		};

-		clint_mtimer3: timer@70ac030000 {
+		clint_mtimer3: timer@70ac034000 {
 			compatible = "sophgo,sg2042-aclint-mtimer", "thead,c900-aclint-mtimer";
-			reg = <0x00000070 0xac030000 0x00000000 0x00007ff8>;
+			reg = <0x00000070 0xac034000 0x00000000 0x0000c000>;
+			reg-names = "mtimecmp";
 			interrupts-extended = <&cpu12_intc 7>,
 					      <&cpu13_intc 7>,
 					      <&cpu14_intc 7>,
 					      <&cpu15_intc 7>;
 		};

-		clint_mtimer4: timer@70ac040000 {
+		clint_mtimer4: timer@70ac044000 {
 			compatible = "sophgo,sg2042-aclint-mtimer", "thead,c900-aclint-mtimer";
-			reg = <0x00000070 0xac040000 0x00000000 0x00007ff8>;
+			reg = <0x00000070 0xac044000 0x00000000 0x0000c000>;
+			reg-names = "mtimecmp";
 			interrupts-extended = <&cpu16_intc 7>,
 					      <&cpu17_intc 7>,
 					      <&cpu18_intc 7>,
 					      <&cpu19_intc 7>;
 		};

-		clint_mtimer5: timer@70ac050000 {
+		clint_mtimer5: timer@70ac054000 {
 			compatible = "sophgo,sg2042-aclint-mtimer", "thead,c900-aclint-mtimer";
-			reg = <0x00000070 0xac050000 0x00000000 0x00007ff8>;
+			reg = <0x00000070 0xac054000 0x00000000 0x0000c000>;
+			reg-names = "mtimecmp";
 			interrupts-extended = <&cpu20_intc 7>,
 					      <&cpu21_intc 7>,
 					      <&cpu22_intc 7>,
 					      <&cpu23_intc 7>;
 		};

-		clint_mtimer6: timer@70ac060000 {
+		clint_mtimer6: timer@70ac064000 {
 			compatible = "sophgo,sg2042-aclint-mtimer", "thead,c900-aclint-mtimer";
-			reg = <0x00000070 0xac060000 0x00000000 0x00007ff8>;
+			reg = <0x00000070 0xac064000 0x00000000 0x0000c000>;
+			reg-names = "mtimecmp";
 			interrupts-extended = <&cpu24_intc 7>,
 					      <&cpu25_intc 7>,
 					      <&cpu26_intc 7>,
 					      <&cpu27_intc 7>;
 		};

-		clint_mtimer7: timer@70ac070000 {
+		clint_mtimer7: timer@70ac074000 {
 			compatible = "sophgo,sg2042-aclint-mtimer", "thead,c900-aclint-mtimer";
-			reg = <0x00000070 0xac070000 0x00000000 0x00007ff8>;
+			reg = <0x00000070 0xac074000 0x00000000 0x0000c000>;
+			reg-names = "mtimecmp";
 			interrupts-extended = <&cpu28_intc 7>,
 					      <&cpu29_intc 7>,
 					      <&cpu30_intc 7>,
 					      <&cpu31_intc 7>;
 		};

-		clint_mtimer8: timer@70ac080000 {
+		clint_mtimer8: timer@70ac084000 {
 			compatible = "sophgo,sg2042-aclint-mtimer", "thead,c900-aclint-mtimer";
-			reg = <0x00000070 0xac080000 0x00000000 0x00007ff8>;
+			reg = <0x00000070 0xac084000 0x00000000 0x0000c000>;
+			reg-names = "mtimecmp";
 			interrupts-extended = <&cpu32_intc 7>,
 					      <&cpu33_intc 7>,
 					      <&cpu34_intc 7>,
 					      <&cpu35_intc 7>;
 		};

-		clint_mtimer9: timer@70ac090000 {
+		clint_mtimer9: timer@70ac094000 {
 			compatible = "sophgo,sg2042-aclint-mtimer", "thead,c900-aclint-mtimer";
-			reg = <0x00000070 0xac090000 0x00000000 0x00007ff8>;
+			reg = <0x00000070 0xac094000 0x00000000 0x0000c000>;
+			reg-names = "mtimecmp";
 			interrupts-extended = <&cpu36_intc 7>,
 					      <&cpu37_intc 7>,
 					      <&cpu38_intc 7>,
 					      <&cpu39_intc 7>;
 		};

-		clint_mtimer10: timer@70ac0a0000 {
+		clint_mtimer10: timer@70ac0a4000 {
 			compatible = "sophgo,sg2042-aclint-mtimer", "thead,c900-aclint-mtimer";
-			reg = <0x00000070 0xac0a0000 0x00000000 0x00007ff8>;
+			reg = <0x00000070 0xac0a4000 0x00000000 0x0000c000>;
+			reg-names = "mtimecmp";
 			interrupts-extended = <&cpu40_intc 7>,
 					      <&cpu41_intc 7>,
 					      <&cpu42_intc 7>,
 					      <&cpu43_intc 7>;
 		};

-		clint_mtimer11: timer@70ac0b0000 {
+		clint_mtimer11: timer@70ac0b4000 {
 			compatible = "sophgo,sg2042-aclint-mtimer", "thead,c900-aclint-mtimer";
-			reg = <0x00000070 0xac0b0000 0x00000000 0x00007ff8>;
+			reg = <0x00000070 0xac0b4000 0x00000000 0x0000c000>;
+			reg-names = "mtimecmp";
 			interrupts-extended = <&cpu44_intc 7>,
 					      <&cpu45_intc 7>,
 					      <&cpu46_intc 7>,
 					      <&cpu47_intc 7>;
 		};

-		clint_mtimer12: timer@70ac0c0000 {
+		clint_mtimer12: timer@70ac0c4000 {
 			compatible = "sophgo,sg2042-aclint-mtimer", "thead,c900-aclint-mtimer";
-			reg = <0x00000070 0xac0c0000 0x00000000 0x00007ff8>;
+			reg = <0x00000070 0xac0c4000 0x00000000 0x0000c000>;
+			reg-names = "mtimecmp";
 			interrupts-extended = <&cpu48_intc 7>,
 					      <&cpu49_intc 7>,
 					      <&cpu50_intc 7>,
 					      <&cpu51_intc 7>;
 		};

-		clint_mtimer13: timer@70ac0d0000 {
+		clint_mtimer13: timer@70ac0d4000 {
 			compatible = "sophgo,sg2042-aclint-mtimer", "thead,c900-aclint-mtimer";
-			reg = <0x00000070 0xac0d0000 0x00000000 0x00007ff8>;
+			reg = <0x00000070 0xac0d4000 0x00000000 0x0000c000>;
+			reg-names = "mtimecmp";
 			interrupts-extended = <&cpu52_intc 7>,
 					      <&cpu53_intc 7>,
 					      <&cpu54_intc 7>,
 					      <&cpu55_intc 7>;
 		};

-		clint_mtimer14: timer@70ac0e0000 {
+		clint_mtimer14: timer@70ac0e4000 {
 			compatible = "sophgo,sg2042-aclint-mtimer", "thead,c900-aclint-mtimer";
-			reg = <0x00000070 0xac0e0000 0x00000000 0x00007ff8>;
+			reg = <0x00000070 0xac0e4000 0x00000000 0x0000c000>;
+			reg-names = "mtimecmp";
 			interrupts-extended = <&cpu56_intc 7>,
 					      <&cpu57_intc 7>,
 					      <&cpu58_intc 7>,
 					      <&cpu59_intc 7>;
 		};

-		clint_mtimer15: timer@70ac0f0000 {
+		clint_mtimer15: timer@70ac0f4000 {
 			compatible = "sophgo,sg2042-aclint-mtimer", "thead,c900-aclint-mtimer";
-			reg = <0x00000070 0xac0f0000 0x00000000 0x00007ff8>;
+			reg = <0x00000070 0xac0f4000 0x00000000 0x0000c000>;
+			reg-names = "mtimecmp";
 			interrupts-extended = <&cpu60_intc 7>,
 					      <&cpu61_intc 7>,
 					      <&cpu62_intc 7>,
--
2.43.0

