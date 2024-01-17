Return-Path: <linux-kernel+bounces-28648-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C4B77830150
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 09:33:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 781A61F25915
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 08:33:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CAA11170F;
	Wed, 17 Jan 2024 08:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="gAIjCzLD"
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25528D517;
	Wed, 17 Jan 2024 08:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705480431; cv=fail; b=mXgmL1RD2/0ARCG8NHQ/Ye4a/uOQxieNa58ek9iXbZ7GlChGfy1yGA7it9ej9ajALQYF1eYIE9ggjvxFQdGpCPGKzgMu9P/i0XC6lw8Pp79nBs7+7k1LMG1eKJMU98OCAHhFRml5xeZ6RtidYs15IPV6PZGYUXz4+TGF9LqwpdU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705480431; c=relaxed/simple;
	bh=qCQ8wGAAoUF93nn1locP3YXsYJG4Rg+Zfphl2eYRHH8=;
	h=Received:DKIM-Signature:Received:ARC-Message-Signature:
	 ARC-Authentication-Results:Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:Content-Transfer-Encoding:Content-Type:
	 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details; b=BosKovMaZkEXsWEUAmuyc8sMJTmrEZtvdJmpALgyRUtz6ZO4NYR7vtXcxt9xh6noCpVk/QXQ1g4jtTmCRfo6EiYD9qTjPJ4I2pzaS7XHEnI2miEtz8L8blE6YlKVEQxLTTzvvQTvbaVbLAiATaPBCI6NlqvYBdptkRXqiGJNaNo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=gAIjCzLD; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40H77LOB014355;
	Wed, 17 Jan 2024 08:33:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=from:to:cc:subject:date:message-id:content-transfer-encoding
	:content-type:mime-version; s=PPS06212021; bh=PX2txPy0WULlWrvDZU
	uXs6E55cydkl2Lunku/5nSEeg=; b=gAIjCzLDSaRh2Z76dEp7tMOx96PqRvLUe0
	UGx7KK1d928p1FmTbXpFNM3MVSSbM+pMuKycm+GUuwaYbZ2swdIwP2tn6Sv9hGL3
	mzkizDFrc54OeSZ/1Zk+x80Zb77v82evhw9IYiVMT2k4c8CdKwjiHST18TFqnkY9
	flx7SMo0N8JPFbZWQkbT4ev9Nt2D6LlDziQdhB1V8vF0HewNfoB2nFMvD2B6w6M5
	MWcauZPlh8HmQTVbiCwQq6vBKXT4IpR9oto8UDgJB/bqzEQikSXHbk38slC7Ilox
	2vjE6mmJQyEb33qpOWrN9rPRtyDFmaTZc73//SfDDV38+0WmugMQ==
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2168.outbound.protection.outlook.com [104.47.73.168])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3vkfqxcbsh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Jan 2024 08:33:32 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KasxlVDiyP9Ejky4I1DYiiX8kmFjQMK1A3T/cui/0Ooj866LNIlZyrGXnqSEzrM2r0dTsf16H9YEEE4yQFhctnHapAlbsj49pJXfYZVf9AQZ/WXEzaKJPXAY6tB4jxwbuWyEsqXjgVLPgpKr5x1y/9U4jRK07Ti21hSd/mLjEmGXuPOoTHXWa7sCt9OUyD7RwZ6b4muitNFr+1P8fPpsuKt2cCdnNLyn8H1j10PlyxZqlxqswBBurEfn2tPuW/X+189FdvuDvdlc6PSaU9aNFH+3Y4lVYc2IG4h30gFxurryjR83I1zER+8BdOGgMJAmqIuNNxwPcU9ULyMV4Lgc3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PX2txPy0WULlWrvDZUuXs6E55cydkl2Lunku/5nSEeg=;
 b=CCsUPANxlvPVNEPSrE6vTbLcZQYokWMxojv3eiBkc4UtAeZG+qHB40Jz3Mgw33J+mi+fSjzUec+PYyx6YAbRGrIWG6dvQf3RAoEl7IgfAGgah5tg4uOpa74sBHTeAvmO9Q1FKqmXB8pi9qkjZ6bD+rePhDgGQLVuumjWkDYS7ApZgIM/S0/L68Ikw83mgbCVyAJJg4ywVP/ASmNQR9UrOsxAzCedKSBUB+eAJ5dJdgytVKYqquHBne7HMBEM4sXprx4lfpQkDimJ5sK26+2eQ1ePdY3eWpQM5PYvBYnJZJZCxP+vslLfKZrkQo+zjo2EucZYN0DuJWXYGjVPTmDo9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from SA2PR11MB5193.namprd11.prod.outlook.com (2603:10b6:806:fa::5)
 by BY1PR11MB7984.namprd11.prod.outlook.com (2603:10b6:a03:531::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.23; Wed, 17 Jan
 2024 08:33:30 +0000
Received: from SA2PR11MB5193.namprd11.prod.outlook.com
 ([fe80::1f50:d5e1:869c:1709]) by SA2PR11MB5193.namprd11.prod.outlook.com
 ([fe80::1f50:d5e1:869c:1709%7]) with mapi id 15.20.7181.029; Wed, 17 Jan 2024
 08:33:30 +0000
From: Xulin Sun <xulin.sun@windriver.com>
To: robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        xulin.sun@windriver.com
Subject: [PATCH v2] ARM: dts: tps65217: add power regulator & backlight drivers support
Date: Wed, 17 Jan 2024 16:33:16 +0800
Message-Id: <20240117083316.3051295-1-xulin.sun@windriver.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGBP274CA0022.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::34)
 To SA2PR11MB5193.namprd11.prod.outlook.com (2603:10b6:806:fa::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PR11MB5193:EE_|BY1PR11MB7984:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c16042e-5974-4945-16c8-08dc1736fc01
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	pWzlo4uolla+Sa77kYJMNzkbscPC7YZT1Nm2+dgujAI+DFFYJpgp/dq6iwzmh5Ijs0G+xfEQ2Y3jAAncGenWHC9H2UMivuerPS5F2fc0/HX62888h3edEHcIz0vGdXPygPcDoQpuMZvwpyAlHSTU0q31c0oc3LcVNSQcS3xYilk5FGBz4PrBStuOgM4hoYhCTrDYEtliBYDBPq67wQYPBs4umKZOFvJ3i7TWyfTFaLuaN3uAIQOvlJxKFFav95b9I73Y1/jpLuKjzP1djHg3Ujmprc9qwKh7lGzS26LY47pqv99uVW0s1lwBc4fLqkeJKr1BHDNDAB8bdIt3QkmMv/GjQCHqp7hD0y5njhv3Pp3A6IV1XPbuhd1pGbPo6RbsZOA0lqqp65422qHhyTxztIF8s+Y9ZSPMh0LvvgEPgUjXz2bK9aq0TOpI02Gus92kI3vulJFwmHZ6xb70M7gFO3ZsRoH9U4VAIVIeAf6z8/Vf6wOdfZ/01arhMRMn+7c2G+47YBIhJxwcV9jHQzRVi57bZj/Pcal3Jv/d9s1CJChQwMlRhsS4sprVSUOeXTpo3+ikufzIoZnnzdeA7zNddzwK6n/+DpX0lxbfBFmzmEmTQNnWuXU9SivwRjsiiWHI
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB5193.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(136003)(39850400004)(366004)(376002)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(38350700005)(66556008)(6506007)(52116002)(44832011)(6512007)(6486002)(316002)(6666004)(66476007)(478600001)(66946007)(2616005)(26005)(107886003)(4326008)(8676002)(1076003)(8936002)(2906002)(5660300002)(41300700001)(36756003)(4744005)(86362001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?CRHidXBebFEcnuCW53U7ncyB4mHSzG/XUvKUgTFqUjmMkigUrPKd9oZ2731d?=
 =?us-ascii?Q?ZUs4LvpgPnfA6cGmp2LlM16IOALEOK+LYiB0g4+HyAyyS85/fbiDz625xrIb?=
 =?us-ascii?Q?ag5q2+wn8LAMd1cSIzZuyUSuPylnyobxN4Aq3SyyCkIi19/WXvRUiO28E3v/?=
 =?us-ascii?Q?OLZpNUZEZNhuGpAR41RzmVg9yEVer9WB/rTXGOl/0KC7s4ZslJZffgKE/oGE?=
 =?us-ascii?Q?QfMNOi5Fow++/qCvpwX85HjpRmWshAPeT5PeB837XAsE0+HA4lCfJ/qyqeTm?=
 =?us-ascii?Q?Ogna9Ws5AIBUe+XmQ7rYkwPYqWzFbsMIrIn38VM+OQyIaOnOQR1Ne3APmpzv?=
 =?us-ascii?Q?SSD6czYpGq9sCvPICPv1DF4KqCzxq6ycMv6Eu3uS8VK/btAmPEosrtft2Hiu?=
 =?us-ascii?Q?klWyptCX8vSCb1+Lupkc4axrzRFSMAtmcetSJ7E0dHH2GvXBBBrE27ZcE9KN?=
 =?us-ascii?Q?AkWHjKWRQgI9giswo+VpYs5f3sDbTFXzPmYhrS+hXOCsvOTBmot4qw5hligH?=
 =?us-ascii?Q?jq2loi97OsAEeR0Dj4x2ZtPsbEkjLKLY0ht1NNiqr8VwZG2D8Qj5r/5nYgEf?=
 =?us-ascii?Q?/Z2iqcvEre8TCytNIcENC+zc6lnDnWsM/EAKdChU1+ASdBCCB01xKT9J0wQo?=
 =?us-ascii?Q?j2NF3wfkvkvNmnLLv/Beq8O8tZM06RYYVxkSz0vKH6vx4iKCeU2zhYgACmcy?=
 =?us-ascii?Q?8dj682fSV3i1Sg5tWn4J8+wj+Tjthzstvq7cBjUkXdTIUyAHjXLaCiDo/E0e?=
 =?us-ascii?Q?0jyHYsqH0h086olq7ZF/+XBMUM8TcaGBfpCGZax8DMwkSxtJRjTufEmswAcx?=
 =?us-ascii?Q?5YrFiXUdnh3hGe/Fk8Y6k3kWR+MqVXw6OXpklV+Mnx60IAmgUMxuT7x+Wxoe?=
 =?us-ascii?Q?+/Dukb4rP/5ZniCV5SlPRrBzu0KqYLQT98lZH6TzTJ/71BnE2PxHSp1EipCb?=
 =?us-ascii?Q?Yo5ZHsZjZ8bGpsiAdGbJP4ZZRvkYfAmcjOPkG8eLg6MO95VoGwxpJffoKtmy?=
 =?us-ascii?Q?JS8mueeoNCDMLyxK3yoWiAo2I8g0qL7KgMOPNCkygmS6W5Mtjz5u/LkSRB7S?=
 =?us-ascii?Q?BURwpFuo3Ijv91jSG3YXlDg3G0vo5YFvkJeg0WFUxpzyLryVakAv5HMShzJO?=
 =?us-ascii?Q?wWTU6nrBPAFz1X0cpz13+xQxTKbapoqHXGzIkFHUHU7Axt1wO7hJHrv8KwPR?=
 =?us-ascii?Q?QEYyk4pKLS5MA/7q8lfcaUgBekpm41kIAv7J+fgxA0aVSz3fvMb+ehukiINh?=
 =?us-ascii?Q?q+EgMk5709/mSCdBVaXpKShdqg0yS/p9qcRP7tHkdS0DY1TwguWUorZmDEuP?=
 =?us-ascii?Q?BYMwm/smX11tViULUdtmr33zNFFrr/yhbk1p8pk5PDjgm3H3fpGIJPla46mO?=
 =?us-ascii?Q?EnnWSSOJNTuVWEAP0bofH9rHVPmSSWqJpZ6nNPZLcaFUwTO7gFWS3dAWTMke?=
 =?us-ascii?Q?pj7dcUPs308Gtc3+kUcg2QucNcfU0BtpYi8T4hXLP0XZrfY9pu9T6F31BzpF?=
 =?us-ascii?Q?QPoJvKYZzva9WbKkYyi/gRXtspHQOGzqm03i2gSjuyz5KqRAt7qByQ8hplHL?=
 =?us-ascii?Q?ptZkbd4Xkv+1mkCDDRvXRaSEATzFfTsMJD9sZT70xQex0VnIkoGUwZ7nPU8+?=
 =?us-ascii?Q?7w=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c16042e-5974-4945-16c8-08dc1736fc01
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB5193.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2024 08:33:30.6371
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4QlOL7D3Ykkd4oIjaH30WjL4tjuykH38BX72HkwB0w5rYnFQEavSg79MngyHBUEz42XS8SvW2aN77tf8TkyCHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR11MB7984
X-Proofpoint-GUID: 3rKHBFBgvRq2l2WihXVO4MKc74mOWZM7
X-Proofpoint-ORIG-GUID: 3rKHBFBgvRq2l2WihXVO4MKc74mOWZM7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-17_04,2024-01-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 spamscore=0 lowpriorityscore=0 phishscore=0 malwarescore=0
 mlxlogscore=314 clxscore=1015 bulkscore=0 mlxscore=0 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401170057

Support TPS65217 voltage regulator driver and TPS65217 Backlight driver.
This will avoid below booting failed information:
tps65217-pmic: Failed to locate of_node [id: -1]
tps65217-bl: Failed to locate of_node [id: -1]

Signed-off-by: Xulin Sun <xulin.sun@windriver.com>
---
 arch/arm/boot/dts/tps65217.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/tps65217.dtsi b/arch/arm/boot/dts/tps65217.dtsi
index 0d463de5650f..b1d4a7f4ec4f 100644
--- a/arch/arm/boot/dts/tps65217.dtsi
+++ b/arch/arm/boot/dts/tps65217.dtsi
@@ -13,6 +13,14 @@ &tps {
 	interrupt-controller;
 	#interrupt-cells = <1>;
 
+	pmic {
+		compatible = "ti,tps65217-pmic";
+	};
+
+	bl {
+		compatible = "ti,tps65217-bl";
+	};
+
 	charger {
 		compatible = "ti,tps65217-charger";
 		interrupts = <0>, <1>;
-- 
2.34.1


