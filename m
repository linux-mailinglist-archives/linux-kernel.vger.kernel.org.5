Return-Path: <linux-kernel+bounces-1560-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94B16815019
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 20:19:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8FD91C20B5A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 19:19:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA48641860;
	Fri, 15 Dec 2023 19:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=PHYTEC.onmicrosoft.com header.i=@PHYTEC.onmicrosoft.com header.b="djUvn3JQ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2043.outbound.protection.outlook.com [40.107.96.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C87F23FE43;
	Fri, 15 Dec 2023 19:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytec.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytec.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NH3myU13Oyal3uWgHMebfgdQy85b+RThURH0g5GWvXZqxj6jM5IVxNaaaH4YlBeGu7ZqzqfJpvkC/jhZxR61RkESkFs6cKVe0zE2oqqWovm5IJcT6aQ/Oz814K6C3K8gRG5OajzCptshrCOc0ykI3LPa8QMmSTiQeg0tlx049L34qppszm5lD+jlhB04RL6oIyObWRbJ4TSHIxsNAEC68mmnYm0sgooENJB52CKxQFWgYh9WtpvC3DxsiXZoymrQP60r4Kqs6y4AXoWNr19Q38cW9dnDRmZ51eu5+nQB0YM0d1Q/tL1Jv3Fd6I38fqZGTNEUIcfqSIdRWZ5XXkRFTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R8oJDYAu3Y9ssFYHiYbz3AhUb0G5zHLK3Jww9DSA1fs=;
 b=TWLx9ioro4jp5TEpM2EfXkKNJ2DlSt1zJOJqx4bAoptnBZD02dmzUxMWu8aYwUzweymhVtbbwI8pvR5Q8wxUJ+dTPHQ1kJPy+tmyYzvbPumiF8RL4ucZNLC6XbN70DMJskURh1VqWPnB+DH/gBxjU1rdbO/UzWtEqO8PjE3qqb0jniX8C+WDVlb6W2RlQakxMr5Y2q1kvzsmLurHt9os/rTl/JfXF7C3PxlumwwkixnTGjt3fkunvZ7V8jFYy67Frci68Svc6oHcvuKL3CATPdnxclJFLu2j7temFVkeKd+fRYt/MpKt/JPo1Co/sJlWcxKOJO2lXsVcfUuJ/DMN5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.com; dmarc=pass action=none header.from=phytec.com;
 dkim=pass header.d=phytec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=PHYTEC.onmicrosoft.com; s=selector2-PHYTEC-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R8oJDYAu3Y9ssFYHiYbz3AhUb0G5zHLK3Jww9DSA1fs=;
 b=djUvn3JQICFxqfGOhdCrrV8GUjm9RoINiT/mT5vTKu8dD/oOCEN4OlhK9QpcS6iXUbE+Rcax9G0Z7b0KYXIvHJH6DwxCjOSK/4gd2huCEnLtIIlMdGUFuqRkUOemJt/RBDROTrLq7bU7HS3OIKMEnY55LLCJfNR0vBJMfOdQAFg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.com;
Received: from DM5PR2201MB1515.namprd22.prod.outlook.com (2603:10b6:4:36::18)
 by CYYPR22MB4299.namprd22.prod.outlook.com (2603:10b6:930:cb::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.31; Fri, 15 Dec
 2023 19:18:53 +0000
Received: from DM5PR2201MB1515.namprd22.prod.outlook.com
 ([fe80::89be:ff90:a5ab:1821]) by DM5PR2201MB1515.namprd22.prod.outlook.com
 ([fe80::89be:ff90:a5ab:1821%4]) with mapi id 15.20.7091.028; Fri, 15 Dec 2023
 19:18:53 +0000
From: Nathan Morrisson <nmorrisson@phytec.com>
To: nm@ti.com,
	vigneshr@ti.com,
	kristo@kernel.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	upstream@lists.phytec.de,
	w.egorov@phytec.de
Subject: [PATCH 1/2] arm64: dts: ti: k3-am62-phycore-som: Add fixed-partitions to NOR Flash
Date: Fri, 15 Dec 2023 11:18:37 -0800
Message-Id: <20231215191838.1925082-2-nmorrisson@phytec.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231215191838.1925082-1-nmorrisson@phytec.com>
References: <20231215191838.1925082-1-nmorrisson@phytec.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH2PR15CA0025.namprd15.prod.outlook.com
 (2603:10b6:610:51::35) To DM5PR2201MB1515.namprd22.prod.outlook.com
 (2603:10b6:4:36::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR2201MB1515:EE_|CYYPR22MB4299:EE_
X-MS-Office365-Filtering-Correlation-Id: 71b92152-2fd9-4cb7-7b64-08dbfda2acc4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	IzFNV29H0YUXYbRc9DtMKSbIivP8BAae6thV9sXMrMEZi0VyLTW432vXBtS14dQ6nmYw9a4w1xg/8zus4Hq60PTCKGhhPZOF581NO8pd7km+CDW80Y0U/qGbMnvTcm3AX5aXmxYj53A9wFWDfy4rqMbXpbN9aTsBZEMlp5D5urDONbw75njOY43rzSkOwnzyReOmkrjmaBktjmu+wtDUFQsiUaZ3sob9llrJ2bwhwGC0k5hm2ACtsagD+JICOeKj1Z6ccUnvepE0y0TJQppWeiqIfrG7JtGoDLMNkJ0BNSRV77zLNCjgPzXpttFHPJAIu23E0WZNRR57SrAMdaklQlM9phZ9v51mOYPyZ61+fg8u/cNgyXTcdEtH7punaQgKWt8CvU27E4LlxCEH55BtCIslsPhBNDw8Rs5MfVgPo9JRx19dY1IL8PABeWdPzzjYHgTltTC2vhuyJoJ61/2MJpc+4I5w1a3wSt8ttmdG3h9jxN3ozaxqbRu3xEgy/zonZW7rosgqsO+QYaouioaYdnpUZLMmfzMLsGW5QNNflf+1L4spiO6fLiD16jf+P3dxkW0xGnKKfkPd2lYc1BWlKq42dwJTV8KmzMYArLB4AdTCWVIW7cVtX0xCvdEiIkJS
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR2201MB1515.namprd22.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(366004)(346002)(136003)(39840400004)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(2906002)(4744005)(7416002)(38350700005)(36756003)(5660300002)(6666004)(6506007)(38100700002)(1076003)(52116002)(26005)(2616005)(6512007)(478600001)(66476007)(66556008)(66946007)(6486002)(41300700001)(86362001)(4326008)(8676002)(8936002)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KI5jHBkz87wKw6FqLuy9PeQgGR3bJBOrrZujVqF2NsXhGI/QZ9GkRf5di+Mk?=
 =?us-ascii?Q?9ZOOLk/xZTLufGiZd0SPrEhQZ0vtZ7JUaJ/INPKPRDBwmb6DK6SfriZKOrbp?=
 =?us-ascii?Q?IQjyv9Jqk2o8vXuXwizTsqWJv0+rQUeUzaJFsxoFbZy1NNBsYW1d5puCAzz5?=
 =?us-ascii?Q?sZTzW60wLJegRYwvctq3TpLWyiOmebaXBLOYYpKZN2lKMHkLBjXT8Hw+k8FS?=
 =?us-ascii?Q?s6kkPckA8S7V+LStC56gUJ0x6MabTYxwOd2/qisXwKkK9vvEMZRkYZbCwnqe?=
 =?us-ascii?Q?eWK8RNHLuQCKot5VLicwaKnC/uU7F61rT70vBAgPe9q6bcE/blc6F8tnrZRu?=
 =?us-ascii?Q?9APawBcV93vdRXua8ITAB1XJKcLsevYyyy2sWFfJ4GsjS5RRwjWOY6H0Ft/P?=
 =?us-ascii?Q?vex3PkAbhdLFZXcG9UpPcf0+ejwCp7Bh+U4Hc2IQ92S1m+z99D1UStTyyY3P?=
 =?us-ascii?Q?C7lTG1Bq2jTFsSVSJ4YkxboRL9jnUY284q7fjgsaOxNjwP1OIRlkpW1q9fnQ?=
 =?us-ascii?Q?TBBui71Cy8sOR1wF44tGhJngQskR5TjXdmdcs8cGu+3wpjMvGKHHEYhuzgBw?=
 =?us-ascii?Q?PbPQcobcBk/TIBP/PTNj27hx6NNuSJLVXfiFQYqL+fv+RI1Zy4FA3Q63lA93?=
 =?us-ascii?Q?UQHEo3NSioljqFUDIsLA1M95MMNRLHSVo23AD/kR8NJtKNftJyZ5rtJ3xxjK?=
 =?us-ascii?Q?2ZlWB1gdRE2U9x2sSwh00vAUD5wGjbEznGFMMRnECv1yY0QyCGg+c021lMal?=
 =?us-ascii?Q?mEX/5AX+3y6WsdugjiNdEHfZfYieBvthSC8Ec9bGo9WQL7io1c8WVQeu6Wn4?=
 =?us-ascii?Q?PB0tduhwOFAeVugZVPxW3G7cMn42ytZtDwtOcdQW+NHPZU+n6ztysxKf6qbL?=
 =?us-ascii?Q?cLCFgP61BSn7V4GUTY6T+TvOthvM0OvBj4St7WQQ3yW8UPsN+cXw33aMdkyk?=
 =?us-ascii?Q?CRyLBZlF+Gwj8OnUQO7S8Bmo8gozEWGOjL6dmpLXjNWxTgVbvPb1M/q7qRhW?=
 =?us-ascii?Q?elXX1M+UlYOa4+g5c02iBCwuhUzAdy2qzUYkORGgBkVNlXbxoHgxzs8aEsqu?=
 =?us-ascii?Q?xcdo7crSYBe18+Jr5umTWyd6su7+DqD/Y5rWOqLtYgCPNgMz1j/yPABVx3N9?=
 =?us-ascii?Q?XCj/uxuZkmGQZP1O4gcnk3bJZdGw4WvaSZseiPpsSh3dWm0lTUQ7s+ALMoXB?=
 =?us-ascii?Q?D7k+3DUkFy7j54BXYkq7+UJSLkagzhv/iyN8HRo69UrUVcMJw9A58ubwW89M?=
 =?us-ascii?Q?jatomL1wLCR/3xrfy77vGkcnpw+HW2etutwvboFN28ahcatBaGR/i/HI0p+k?=
 =?us-ascii?Q?W9zLIoEujDAtJJLFVW9leJ0j+SnXEkWmpZSq2qA0fLtVEkMoARdMEdgNIayk?=
 =?us-ascii?Q?uZp4V/6o3QPDVg9YMTuMfp9kjpPNEiQDbljFGNs3T2NlOdnFAQ4ioytd2AyW?=
 =?us-ascii?Q?krIzp6p8xa+mICQuhB6sJkdBAP5EASiJlW3MMQG/PFqAChRFbgBu0weBkk2r?=
 =?us-ascii?Q?ZIvbp58LSwsMCzeRVYEdS74v034I5kAv0YtCdfqr8VJqQP3ejipZ1vOstfw1?=
 =?us-ascii?Q?DjTmqbfCIqyXM2O5jM1buaRE5PT/j44AWJG6kKPX?=
X-OriginatorOrg: phytec.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71b92152-2fd9-4cb7-7b64-08dbfda2acc4
X-MS-Exchange-CrossTenant-AuthSource: DM5PR2201MB1515.namprd22.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2023 19:18:53.0670
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 67bcab1a-5db0-4ee8-86f4-1533d0b4b5c7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C5ja7xfp/a6e3edmHE83JKbGpyIaM4eJwvSrwYfJqLqE+ItZiIdHg/rK6xCjKVLkzuSgSRyq3FNHMzh1GVlzBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR22MB4299

Provide a fixed-partitions dummy node so bootladers can fixup
paritions.

Signed-off-by: Nathan Morrisson <nmorrisson@phytec.com>
---
 arch/arm64/boot/dts/ti/k3-am62-phycore-som.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am62-phycore-som.dtsi b/arch/arm64/boot/dts/ti/k3-am62-phycore-som.dtsi
index aa43e7407eee..681ac03cef40 100644
--- a/arch/arm64/boot/dts/ti/k3-am62-phycore-som.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62-phycore-som.dtsi
@@ -311,6 +311,12 @@ serial_flash: flash@0 {
 		cdns,tchsh-ns = <60>;
 		cdns,tslch-ns = <60>;
 		cdns,read-delay = <0>;
+
+		partitions {
+			compatible = "fixed-partitions";
+			#address-cells = <1>;
+			#size-cells = <1>;
+		};
 	};
 };
 
-- 
2.25.1


