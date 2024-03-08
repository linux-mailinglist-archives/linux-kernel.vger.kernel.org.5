Return-Path: <linux-kernel+bounces-96948-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0501587637E
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 12:44:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 753621F248DD
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 11:44:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11B035646E;
	Fri,  8 Mar 2024 11:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HwzDXsSV";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="MUe3k1E5"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C52356442;
	Fri,  8 Mar 2024 11:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709898253; cv=fail; b=TwagGVs3kRl3aLhRFvjf7s9u7LNHEbDueYpbJEwTyLBlRh6g8BhWN5XOXpf3+kSNfrEfiqrwFvo8RnAeDPOlNtpO3cNC0Zcqjm+RcUF96sivB8NaYHAYipBb0b76syKGXV50pigB5FDO8qYJblV9qEW9gUSwen+3GncdTSPzEI8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709898253; c=relaxed/simple;
	bh=k2IniBncwkh/zAHHj8uYjWbvH1Io/Jj+uHpn14W7rLY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rz5bJX3djiDYeRqrzpPWmMQDUgM4SMkG0GQW+Nt4+FtXw4ezX3qYWDd3ZhrwDhnGHcAX5Qju/eV1T8sV4UjBlcpB7F6GE8nIqLi9rx8bNtjNP8shWESfSzyuIrsHcUY59ygs8VlIUVsqm4z18d6e+TaTJ984ZIpf8GzWlVCfe0I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=HwzDXsSV; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=MUe3k1E5; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 428Ahwlt024721;
	Fri, 8 Mar 2024 11:43:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=NlSMzESof/4+0bqVXi0n5S5js/K846KaNkufe3n3Pls=;
 b=HwzDXsSVmABfrar5PUGsaBbLeu7dQeGlXT6hw9J4E9m4hNFdvSDYHy/Ra3XjmZchlmrn
 UN4PKbcIUoGlr3OWm4QxepNYsUZ+kgjXSlw/o1c2rIgJwAaVnJl2qFMpn/+lgBsaTwnO
 n1Vd+kqcMcKBGmHz8T19qPNuR0e6Uxk6ElZ5UxBySCQ1eu4CsHx7eMEDGmiUwFr7ZJEp
 SUXpufYuoqcFwB6poNthrpeBXsybPPYyuP1yGpRxjrIVgzH67yKPQnTP9u7B1VEcpmcF
 1KK7W3OshyVeIubaujtmnN6MD+4InFTfhMIukPH8LDMsBKYAWdll7UU7nTyrankAe4KF cg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wkv5dpvua-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 08 Mar 2024 11:43:47 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 428ASUSQ016003;
	Fri, 8 Mar 2024 11:43:46 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3wktjcpmq7-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 08 Mar 2024 11:43:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xo83KHw0oZnTDwGdCd3sqSAXTZSGAvntlQsy509RmLkf77yyCVoSFzJri8HiAxZPD9vzZOGJuJnF5rPVx/KzUvchHarn/ZOeAuwgN9lvuftXA/K3TtYp7IXnGkb4d/UIdi18twvRcBg7yHYSzytmk9xD4feThRciQvnqqLf0+iIObH9PpF5+HOWa79c5MPwl/iOXAmH3CjG+D7H22xwCLKzHAaZ1X/5HIgpeXDLa8/RZDi5Z14KIfI7g4l3G9AtwIINWzCHumyf3dD4iLr6E1+exBtZQeO3Gk5PbmU0iT8IzDi6ECCO4TrpNHIPOEc0QrsFWmc3peH5VgYZjjMzgig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NlSMzESof/4+0bqVXi0n5S5js/K846KaNkufe3n3Pls=;
 b=FkkamklOztZgFy8NwgtUMiBVChK+1VYQGNngpXiy6EmqxWhfHDAiuB+6Qz2ZL190xiekLvUfw+byybgEFsmQoQ/LGFnQYlR2WRAWOvDLCAZJf0LLboKIyXmhtw4id31LlUOizvVp1bA+32xFyZSImsyr9E5sO+2nq3k+jxPZYBK1VEL5fMJutoyJ0N0zeA3Xyl8auWvCnJtRCSDv2zGv98QJwFoRAUNIzQ7hABpjUvrrGo4eTSbMBvzl0a+TVixXdtAME7Gs2tbxpjhWgygxmxmGZ0h0d++by8HCQAdzmytNsQFkYPoZFKLFcBznyuMMxOciFDv3NxMZiysT1bUsZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NlSMzESof/4+0bqVXi0n5S5js/K846KaNkufe3n3Pls=;
 b=MUe3k1E5mAvoW1my9KMpcgsqISHr8o0XAlM+wPNvyRYmaZtrUx77KCT8twSoBp+JFMfGuYU8I9rifG2ES/zQrYPkWOGwOHt/rnVHR8QxKtiXDjuZ3UDbNsTw6Tez09Vvh3ctPQQLT/NAcYXTyFg+TGIZ/WBsa9H69oG4CCXabE4=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by CO1PR10MB4595.namprd10.prod.outlook.com (2603:10b6:303:98::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.27; Fri, 8 Mar
 2024 11:43:44 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ae68:7d51:133f:324]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ae68:7d51:133f:324%4]) with mapi id 15.20.7362.019; Fri, 8 Mar 2024
 11:43:44 +0000
From: John Garry <john.g.garry@oracle.com>
To: jejb@linux.ibm.com, martin.petersen@oracle.com, chenxiang66@hisilicon.com,
        jinpu.wang@cloud.ionos.com, artur.paszkiewicz@intel.com,
        yanaijie@huawei.com, dlemoal@kernel.org, ipylypiv@google.com,
        cassel@kernel.org
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH v2 1/6] scsi: libsas: Add LIBSAS_SHT_BASE
Date: Fri,  8 Mar 2024 11:43:34 +0000
Message-Id: <20240308114339.1340549-2-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240308114339.1340549-1-john.g.garry@oracle.com>
References: <20240308114339.1340549-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0051.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::26) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|CO1PR10MB4595:EE_
X-MS-Office365-Filtering-Correlation-Id: 25ab4eb4-4750-45cf-c457-08dc3f650276
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	NeOx3O1enj/3Yi66mDPsgrh8pXBWG4rgi7C2Gs33jlxbMsRBavYpaCczn5wIoSOgeBc8cP/iHMM0GNERNpDV14VWtKYPy7KfmxBJg3fVo9voMQ7gf90N5W9pywOJbunP/ubzSssJ6djGDMXjRQd35T1iWccZtNaaZjjhkyrVx0HK3Vfvd0gUyod8bktuC2l2bTn8PmCkASUWZILhl7QdwYKKtkhO4uuPBF4srfrGPccA1XTH8FseUaBpX3Iyq5fA3qra79oarhmd1WQEDyd+j0v3ZY1yoa6E6OxSgbwTA9p0yGOzh6gwubQ/ISXLx7/TTi+WsLHI34MxUh4rguS0dD/UyYK+cSYsJrLbZDIcs9OxTJnEZS2j4el+VIEaZs8FlnSbvwYfG8KnqvcGFVIm7CDHBffiKdDbuxFFn7viRR+2f/klmEY1aWNfiajZImkIE/HvXtc0EVBNZk1jfBVTwLUOycrLaDIGVgSMj2QCBiI/Wu5+XAtah/kheTAEypziR0EMOC3Y6130d99YU+a6+kfSwTaZAVW6MKFUcW1Q+J+7148nSFCMH6kagIDicv5TY+X9/KdwmAn1Zm68M5SBF1HyXMpJ9qp/JGSXgFrqXEzKY+yFtsp4JAOMwQJb+Imjt9a7MPctwj5JQKfPKf4lNpwkeGo/g+oykCsNs2jpYys=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(7416005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?JnYPHNylINBh995w6P43uPGWh+OZgGhj8q/XlU6D8QM8OcBtUHuv8zr4t+Cb?=
 =?us-ascii?Q?8/Ri0NA6hTU+gR71rxjul+mcRRehnvLOF3/ejX3EEhGGCCjI611pEAg0GCBa?=
 =?us-ascii?Q?IGVOQ386QkY1kJbXdYtJW5w0GiK43dx6uWJx6P4wDPZu/p3An6QYrtx/hpET?=
 =?us-ascii?Q?IhlRpJzJi376qL8rHf9dVFOG7ffYXLsHzjJ0awnmg3bv5kReEy9zPrgy0x6s?=
 =?us-ascii?Q?Sx5kjElhOzzrz0iNtYy/1JiV1yjvVGBOcxG7/M8oe/W8SRrN2wSZR16RXXLv?=
 =?us-ascii?Q?G5f97Px2eo4fgJ8mkVkE4zhQyvh6T6wr+aEpvhB61j3RrOWIwLwQQlmrO+yf?=
 =?us-ascii?Q?TWJ0ca2NoG5enzupR+6QdoR02OiVeQCnKVn6xHlr28uKo0XMLwYrVJiw10TQ?=
 =?us-ascii?Q?m8wLtTlUEpB+sLRmLB3IH9zIBMFpR5ruLfAEfp5EVG5WmxhlM6J0NgLycrK4?=
 =?us-ascii?Q?qGtltMCXLjGxHzwONe329QR69UTj8UIAHzddy3ambC3wpgHaP5wE1X9sLc8g?=
 =?us-ascii?Q?JK9XpGFbTZn5wfirFfQ9E+m6gAsVEGK/GZEtyZ5cEPu+3v33+iLcoPKgNZGe?=
 =?us-ascii?Q?utqV9CrxOzcPl0iBBGQ8CVQmwOklTOmffWMdypk6Qn8JEPIbiYM9IEczo6ZS?=
 =?us-ascii?Q?UKJ4nvf5BHBRDXTl8Jf6h/ZlA2x89JEnxxRDRxaz231EJI+adiPo6eZU5WPy?=
 =?us-ascii?Q?ko+02fRrsZouFiC/B2VnAqJoadxQiqwsp2tyK4MZQaP8Vwokz3oujLaiQwFu?=
 =?us-ascii?Q?WyWuF8jCUWWndkmb7FhVxEDEEhlbsLtqSF/KXOIu9CNUfxIt+rWbAmTkY/DJ?=
 =?us-ascii?Q?NMrJ7Jm+ZX6ZVVtRaC7wyx+WNM+JzVfZ84tkP3Nkp44f4laMuCIrtAINmuKv?=
 =?us-ascii?Q?koyAsUgnVKciWGjcUEwmsuijTAgINpj3bZyB9Zw1eEqAxKaXRFq5XPWaRH70?=
 =?us-ascii?Q?LPsdvPttGdGjqp099CxhP+gVRaA4GL3i7yd2BgF0ncm+75tzxbx4voHiEHvI?=
 =?us-ascii?Q?gUGlF67GsgyuUfkWP5tU7HUQXiLvPmTAQX6NN/l62HvwcLQLHpJoGqIxV4gJ?=
 =?us-ascii?Q?R0OakiBIPPDrNhd0+uw93ZUGRA6R7PtRBDQ7/+h4hD658iKpTpANJyjxVywv?=
 =?us-ascii?Q?kV/olfaoq8YuKoa0wFoeiBh/EK9qJbQbhCh/v7rLO1yETfTcE1llJ6MJ2gjZ?=
 =?us-ascii?Q?EKbsqqtgZkT2OwEtl1QhlZJ7q+Stt6A7WoRWGpLc3vi9u2ge+fekaHkkpxsC?=
 =?us-ascii?Q?+haQXR3F3Ev0zuD+Krqu5ZAd2ioL3+UM0UU4kmQlY8PFJTr1vcxv28Ok2j+c?=
 =?us-ascii?Q?qJY2XXcm4hkZ931JCymppk4Lo3keHXLB9Lr29lSbqnI3wj8d/8rqcS77GGVq?=
 =?us-ascii?Q?qILgbQj+9ihlCTC51SILywIGYqWKX6LKSYbERojvMciyj1MCUt66+wJLU5m4?=
 =?us-ascii?Q?1oAgGd9NJVJZjcOymToYC70cTlh6Qj7DP0vmr8uqSewzvu2EhNpglwu8ihsb?=
 =?us-ascii?Q?G/9zx2CuqEy4bz5egBcJXriQJar64t/CME9MfzJgPxlb3/6o+WQHebORkbvy?=
 =?us-ascii?Q?vFf3ldTORcBNy3bFjiVLUGy3Ts1RELY5ctyGTKwvigVYiw+H1YRTpLD1hk4p?=
 =?us-ascii?Q?9A=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	4/RhQsp6X3aN8dWWbC92Fppg0RFcMrDU2V0cm77Q73Bmm+gJidC+vVjDWPMTEqU/fAi8JbVyQpoCyqZcP5C7/gwyt0gjUCQH7Nr40uyhZz+mGYhMhUHxPFCjHEt8AHqGRxx0TG4PoWjj9KNDyRPeuoARpsfd/Wndj4avoP+1qbh7ASVpuKXmV2Dtn18n3OnH/7bR6S1336/NoJabEQFqQe9shMJXA0/7ihRW3gO2f2Edw/dQE1M/Zbtql1XJQSu1Ba7K9g0emnxiKPuU41EcsqdZI5AZNJHK9ITHeiDaOApBM2tPAe3HeNmqDVkadt0KEWV8vYf/QcsEyw4R1MPYva0Tyy3qfb4X7lRnKsK74gZ33unNbfzmQvntYufTchUvi0N/yS2VPzBQ0Byxm9sy3YUduu+F8n9IKgV94gEPKlY1Yd/G+BTDfAGIulWAOli3nv98nwd43rTdTCrwn9oRvzaDhhas0XfaNPz+plZM4WVQpZUQtlWRH3/CTfCmVRqULm1AlfGBSawDnHT1yQOcU6SRsnxDZkWVGW8h4Es3md/W6nVu+5kym3KOUJ9gfc2Pd25uCPEwOfg8dpEWJacAdC7DkrDAhfwT1RCeUfBLVXA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25ab4eb4-4750-45cf-c457-08dc3f650276
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2024 11:43:44.6434
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kxmiU5b3eFNJ72IGzbSltLqNtmd69reIr3pE2ZqtuTM89GWGiPJ95AE+OTZGOqaDeHQ9RHl4UlOOCjm7y5Xhhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4595
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-08_08,2024-03-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0
 mlxlogscore=999 suspectscore=0 spamscore=0 malwarescore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403080093
X-Proofpoint-GUID: MjassFqcj1HxYinMVLEemuJtuR9M-BwV
X-Proofpoint-ORIG-GUID: MjassFqcj1HxYinMVLEemuJtuR9M-BwV

There is much duplication in the scsi_host_template structure for the
drivers which use libsas.

Similar to how a standard template is used in libata with __ATA_BASE_SHT,
create a standard template in LIBSAS_SHT_BASE.

Don't set a default for max_sectors at SCSI_DEFAULT_MAX_SECTORS, as
scsi_host_alloc() will default to this value automatically.

Even though some drivers don't set proc_name, it won't make much difference
to set as DRV_NAME.

Also add LIBSAS_SHT_BASE_NO_SLAVE_INIT for the hisi_sas drivers which have
custom .slave_alloc and .slave_configure methods.

Reviewed-by: Jason Yan <yanaijie@huawei.com>
Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 include/scsi/libsas.h | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/include/scsi/libsas.h b/include/scsi/libsas.h
index f5257103fdb6..de842602f47e 100644
--- a/include/scsi/libsas.h
+++ b/include/scsi/libsas.h
@@ -726,4 +726,33 @@ void sas_notify_port_event(struct asd_sas_phy *phy, enum port_event event,
 void sas_notify_phy_event(struct asd_sas_phy *phy, enum phy_event event,
 			   gfp_t gfp_flags);
 
+#define __LIBSAS_SHT_BASE						\
+	.module				= THIS_MODULE,			\
+	.name				= DRV_NAME,			\
+	.proc_name			= DRV_NAME,			\
+	.queuecommand			= sas_queuecommand,		\
+	.dma_need_drain			= ata_scsi_dma_need_drain,	\
+	.target_alloc			= sas_target_alloc,		\
+	.change_queue_depth		= sas_change_queue_depth,	\
+	.bios_param			= sas_bios_param,		\
+	.this_id			= -1,				\
+	.eh_device_reset_handler	= sas_eh_device_reset_handler, 	\
+	.eh_target_reset_handler	= sas_eh_target_reset_handler,	\
+	.target_destroy			= sas_target_destroy,		\
+	.ioctl				= sas_ioctl,			\
+
+#ifdef CONFIG_COMPAT
+#define _LIBSAS_SHT_BASE		__LIBSAS_SHT_BASE		\
+	.compat_ioctl			= sas_ioctl,
+#else
+#define _LIBSAS_SHT_BASE		__LIBSAS_SHT_BASE
+#endif
+
+#define LIBSAS_SHT_BASE			_LIBSAS_SHT_BASE		\
+	.slave_configure		= sas_slave_configure,		\
+	.slave_alloc			= sas_slave_alloc,		\
+
+#define LIBSAS_SHT_BASE_NO_SLAVE_INIT	_LIBSAS_SHT_BASE
+
+
 #endif /* _SASLIB_H_ */
-- 
2.31.1


