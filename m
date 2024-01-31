Return-Path: <linux-kernel+bounces-46262-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BFC8B843D48
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 11:53:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 91A3EB2ECE5
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 10:51:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E96EE76047;
	Wed, 31 Jan 2024 10:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="U8d2Op63";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Fh10FD20"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7353478679;
	Wed, 31 Jan 2024 10:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706698192; cv=fail; b=trUXSZDF14JehNBvb1CRNznLWg92rLKwQlqdDvxHuJGiv9O8xBUc5mX/MGjEHj0kQ17vM3XsF2nVHRCv76Tk+cBwFnFlUBxfGbDmQiULRU1PWVWsIwSQYczWOLDKYQ08/Y2XyvyiTBJEIObvdIwB4yb/xrHxC5TI4h1hhp7cXaw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706698192; c=relaxed/simple;
	bh=mzegE1Hm1luMZWqJaViUopOGFiXrPo4bP5VJj3ngZgM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tA6lZICrg1AFj1hnm5lMXh2uEzhQUrW8NHIiZPknW5zNPKTaEBsSz0NIzi9nqYD1fETLuAnBEXyXkgM0CtpdO2N4Z65zim2yHMnVceAYi5DTHRBrMmBPzehUfHDqAcgRtr6MufWgIRW8XINkZ1/61ATaYOn+pnzM/eVcO2Han7c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=U8d2Op63; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Fh10FD20; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40V9iBV6027717;
	Wed, 31 Jan 2024 10:49:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=BLGK+/yelwV7pr4yA0vANDfEwh+KPgt/lK/Xih1/Si0=;
 b=U8d2Op63gd+pIS5ipL5JpJXa/qjvMzOKwHadFPvgJZ8/tEdTvpVh1e2ruqywIaQR4Izy
 i4k3j88wSfey7gu91GrHg8oUzPwXBZ3je9HKW/vCw8wDA8jWuM7h9Zn7LPdBtva4OY2J
 taVDO8JGXLbk4S1D8l3m9+wBImXCz+0OMkAEDb2qnsCL06S40T/cqiWZVLB8tNUyLsep
 IUOZcx/bWzDzzEH9Y1rFwjxpAl9tNeNKUEJM2EnVjkN+Eg5g2oIkqfs4tsOcdyk7YZOe
 DsUl82UUdNfJfXkW9WxqOPonzKuUQyhWcrVpXwU3TDDEQ5DmQWenjmIcjZ3bAmiNh+bh XQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vvtcv1jks-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 31 Jan 2024 10:49:30 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40VAC0lV014630;
	Wed, 31 Jan 2024 10:49:12 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2040.outbound.protection.outlook.com [104.47.51.40])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3vvr9evy5c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 31 Jan 2024 10:49:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S8i0GzpeBFYsiIxDbJwX0grsfblSEfapE3+Wk7IfQVip1M0BrFyND6wDqs2C8ma7GbFbHytQPe3kDvHemWP8iUbXy+17TIc1rvwiA9RhFvTMVUaVUjS1akVP3+kmRnAz09aHlTeIftFDv+F6ErbFBmJI85Tee+nh4PdjCSoHNCd7TtEr/39YKR6RjD0JxgNbYiQwWaCO0shbIvg9ee0i7Xkx2wGj3iQUE1Q6jcY7PROeT7Ee6dfNXjFPfKsKvv3K/pueoZT2xO8lsXj9WvibRyWgHOZFAUrMR+REMyrcYgp5j6lG8cPWrlj07RknCNA7x/8oHm81Z9Aw2pj/R7VgQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BLGK+/yelwV7pr4yA0vANDfEwh+KPgt/lK/Xih1/Si0=;
 b=K0YXK/qpOIXd7sTm28mqG6cvWmBb0cALh5RO0b3TktYpzqei5SuMrjiU+pwJDunX3BkmpEn+LdEz3JBqev3Dh/SdET3OR/RdSXOJRtfvXXBahvdF8OWi0f5ImhHlcKL4/iAlYlGcBp9iA7Xuq7aC6Q/BhepTlXMbjQU3lXU1/u5POdaGzBvMI5GKKFlzPF9qcwKd6SnAVsbnHsGRDAS5y0l60lc06aaP+fq/9Sk+2zLsxAugd4xcWH2hyxnC5XYTWrzlqAekbXkgNJZDlKwE21+Qy2uxZFoW/akCZf/bm5atsx01MViL61x+Zi2HhLOaRKGBkYNnvSKA/UrysxNhOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BLGK+/yelwV7pr4yA0vANDfEwh+KPgt/lK/Xih1/Si0=;
 b=Fh10FD20gOKE9WxnIH5Z0e2OUQlKHw2wc8Zmgl6RyJzH47cfDGn7gJKcuSS1KHJ/beHZShMBWPrhJSp9pixiXEVUOUQJmCj2AB4ZwsGdCsJvM5ho6ZIzabd9rNLC99oJOG27kHKeeYg7KN2u/fDU9Fh8Ftbfk6rDXGj76ui5JPM=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DS7PR10MB7323.namprd10.prod.outlook.com (2603:10b6:8:ec::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7249.22; Wed, 31 Jan 2024 10:49:10 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::f11:7303:66e7:286c]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::f11:7303:66e7:286c%5]) with mapi id 15.20.7249.024; Wed, 31 Jan 2024
 10:49:10 +0000
From: John Garry <john.g.garry@oracle.com>
To: mcgrof@kernel.org, russ.weight@linux.dev, gregkh@linuxfoundation.org,
        rafael@kernel.org, rostedt@goodmis.org, mhiramat@kernel.org,
        mathieu.desnoyers@efficios.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        keescook@chromium.org, masahiroy@kernel.org, nathan@kernel.org,
        nicolas@fjasle.eu
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        netdev@vger.kernel.org, linux-kbuild@vger.kernel.org,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH RFC 1/4] init: Add uts_release
Date: Wed, 31 Jan 2024 10:48:48 +0000
Message-Id: <20240131104851.2311358-2-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240131104851.2311358-1-john.g.garry@oracle.com>
References: <20240131104851.2311358-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0214.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:33a::9) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DS7PR10MB7323:EE_
X-MS-Office365-Filtering-Correlation-Id: 1597dfe2-76e5-46d9-b553-08dc224a41c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	V9hsGFRFC5ExnGKtqB0eec4gxkuaaR7SJkcYqFtsDsrQWGtlpTsJI7k+azN5EyseSDH7VmzFhpVZdLHbLCoOuyFR3h9TpGDZKfTM/ZIiua/qeK7hrYYofOn7+iSqt/m2S+w00Wsa0b0wOoxapv7n0r8L7x6sLIzmecXlcAK4EyEXOv7XAzwGpS4cel5jwgFGxAsk8/HFDHirCrd93zs/RkitcMA/vlgYK4i7zkZBGlw1hiWtEODX6I+U7+8lP9PTqRFx/jh0nC6VbjtongZKDzajDlXy78eDRmVOhaO+QO9y+s7a9nIALryMc/U3k9hnTehdIaiUSPwD71UWAhw8EaySY5tjFIRl9+LahvfpOCuNUi0b2gvaLAZf8iL3h7dkQfAZMqDns3il6gRqVHRff2/b+kywvOVdg04I2uuMlsrpHGNfBRia0KKaCg0MM72ib5s+qzQFUOv4Qrk7GO+27cCmAdZYWjm3+JAwcubOVWl+ZT6XCMgbUWiJ8UvqGuxL59Fiw/x082MCJrBwqYeyemw+MBfhc4UiS24wpA612QkX4oIud5H4/2Nplr/sL1HrAY65BWARvSLXY6qdtNNRy9uEXVkzPuOFUFuCy4hcJJ4=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(396003)(346002)(39860400002)(366004)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(921011)(26005)(2616005)(1076003)(107886003)(6486002)(41300700001)(478600001)(6506007)(6666004)(8676002)(6512007)(36756003)(8936002)(4326008)(316002)(66556008)(66476007)(66946007)(2906002)(7416002)(5660300002)(38100700002)(103116003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?9NJa4PLwK0ePZ+slLAB0OSi4LEC1D9Yt3j8vINpvtSLrKX59DJVOwZrJXBeE?=
 =?us-ascii?Q?pZX718E3c7P4wfErqb1+dSsIhxAqw1vsee3518wJFJAI4q1WnVwwfd19DCl2?=
 =?us-ascii?Q?AGe6iI9Hy6Dyo/UCqV4R6EwpqYMNklmDtEthkkkCWAHhu+3JbT5jrDnUfCiL?=
 =?us-ascii?Q?eA94ibrd7JuUNL1dEYhz7SXxk0CVsQU4stG2E1b8261BeIr0P/BLza3PZ4Y6?=
 =?us-ascii?Q?ffriTMqQ8XtrXNqD/rMA/u79PDuu1CZ7Xk79eOHcxvhGkTQd7o9A0nbjvJBO?=
 =?us-ascii?Q?0J9fhhWI+iaIlcpepRHfQ9mMT4Jq/NwYG24ikuhCxuP6pkac0XtGpQ4iR+6R?=
 =?us-ascii?Q?T3bl1BNQooH1Yum/T3aaCGq73LfyhVavTTRE8A5K0Xq1lScTiTFdHO9w/sM7?=
 =?us-ascii?Q?eOwx/wKb9xSLXzCdO/GGgWwPwotTwOug1qwmIAP3ytOWWSu74Slzm5icjCFk?=
 =?us-ascii?Q?jlfX4fE8OnpX2c5UFKv1eNSHkvyljJKaCjteeFsx19RRrmnwoFtgcwrEaNER?=
 =?us-ascii?Q?3xwila3xHu4WLOls0a4K9Qi0FG8PXzavtSpRyxypPbJ1gdSxFhD1/kcAUDnF?=
 =?us-ascii?Q?CnMutfOhV6EtHt0sgUBicv9dxX6zbSpI1Qjk13BuMfn2IJY3MMqjOKk3U6gq?=
 =?us-ascii?Q?pBW2+u7nzwaGAAWOSc8a+y1u8Wsyr1ozXt06SjzkovE0TqRpCZd2nJsJ2iP1?=
 =?us-ascii?Q?AsmTHIlgXHA07ap5peTmSLmmikdAd5a6adqS8SNoGkH1Fe3sekMefAxZuXrn?=
 =?us-ascii?Q?mXX1jvxyys+FyfXtsUtj7w0ViuvIZZsUEVaiP8m9w+epDCnQt6LSxVLtsWuf?=
 =?us-ascii?Q?kFtZ6qPSTovPDTrP6NcntJVQMmULaHt2OOjtTzlFxJxF07n8HeWGZ8NBU4FT?=
 =?us-ascii?Q?JAdaeK3EpAyzvqPfBknxlaEI9T9XktWI09Z2JWlrPQ2JM3dYvS4hc3d8oFnT?=
 =?us-ascii?Q?2JtkjQA4aw5O7T/UkaJwG7ViG/PTY1lE+xHz+5Ft/F3X/TUsP7rkl/j+AqWG?=
 =?us-ascii?Q?YQKNfFdsOJA9K82Y4q+k/oV+7nAcwTYktX6HtiizOYRm216Zh5Se4gP5/iXu?=
 =?us-ascii?Q?f7bTlpJjYzHOUfWa4oWW670fY45KKyHFD/Qmu/4oXiT0WoQ0XXsjWlLRQ/zv?=
 =?us-ascii?Q?9WAh0lbbcFjye7UC902uGQ/9XL706WIbcG3d7TSjGqiH0NzdnjFdNDy3RG/Q?=
 =?us-ascii?Q?vGnpdHZIw9szzkVMg4KYMw42BvwRclG24FYnaZLkyA0D32h0s21FMvPyTE7r?=
 =?us-ascii?Q?tu90e5chO+WngYDbq7M7DjDvHbxvBS8rhZVpeb0SFWDL1YF/U1Y55M+WwHud?=
 =?us-ascii?Q?7aNqXHXeFSngYcUWRlzHWp7E7nJ5dvgNIPiUd64t3MiN70fwnY4TOYF/s0Cs?=
 =?us-ascii?Q?LIX6j3hsxK7cD73P1Ca7duhSmUvOPPBg7iePcc5dac5mFTuWJIed7tdzbmYr?=
 =?us-ascii?Q?Hxp4htCjcmXVGRKHYktFIKQN5hCfiU/W6K9qIwu2hdwtVV+0Hffg03Py1jjt?=
 =?us-ascii?Q?GDUjRABiR4emsQGQXihioRFaEqtUts2iVlNrGEAzm4B+oaz81VC/DeI0A2HQ?=
 =?us-ascii?Q?m9z064xnVgwdxA/jUPZFLpBfAxMoyKTmgDyd6AOgCRP2JszGF1ZjR5A/kjVD?=
 =?us-ascii?Q?rA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	KKXRWCDO3IZdlCZYoB6chMiGWg0pyXriP6McRNTt0KWiSH4/aqu3faR7/sl1qhdUh3H+hPvwERwXqsDsI+R0EuVQ4EvoQFaZny4vqJBWIKHBO4utBU/BP0HZgWldq43YUPWPokbC/8zz21J3+Sz8zwZz1iJEZcgC+zN7YNFT8jUducHbjc7WnPru157aYsTgpL7eb+JpRtnZlk+fcH4fUJ3gctkEYfz9SQWUgifhbamN4XbHooc0unXSrHg6LJi82876jGpjrL5yGTgKB1Nt4YJByyMkmjOr4yXQ0T0fJPv8nAxhXJYwAPN3KAaj9IcJUrljke9LiKamL3qvNhjSeaf65WjCAr2YbAfxfXzC47Cr+ntHoksLHN7E/eg8Kh4HWWLrqNRCXG9wer57ssHevK3PfJ2XrGw5K43lxO1rGZ69ayNzeEJsfzcVoVbqgynzQdBHY5jz+6jPJ3GGHqf6nM6NHvlxyuiId9MKltTsmx/vP4+FSzC8yvu3Rshw5QYp3irfGSRUFGIXIclibzHcP+cNqpOZN3Cf2a1L5xZtv8+gxUP4Kk42MgoXRfNhF0P3I89JsT/DIcxJOE33g1Qv7iiNdOLHj1x+Hba+KvHqZUM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1597dfe2-76e5-46d9-b553-08dc224a41c2
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2024 10:49:10.7831
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F2eabCRR83Lfc555u0gcaA8wvk5XVlOVKziABmdznMc4e5XATfkEyeCaq8xPqCYWc/WkRhToWm+lY601Ie1YdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7323
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-31_05,2024-01-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 bulkscore=0 malwarescore=0 suspectscore=0 phishscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401310082
X-Proofpoint-ORIG-GUID: SuQwf3zk0a532sbJweIx1GEmDkQNVzzE
X-Proofpoint-GUID: SuQwf3zk0a532sbJweIx1GEmDkQNVzzE

Add a char [] for UTS_RELEASE so that we don't need to rebuild code which
references UTS_RELEASE.

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 include/linux/utsname.h | 1 +
 init/version.c          | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/include/linux/utsname.h b/include/linux/utsname.h
index bf7613ba412b..15b0b1c9a9ee 100644
--- a/include/linux/utsname.h
+++ b/include/linux/utsname.h
@@ -88,5 +88,6 @@ static inline struct new_utsname *init_utsname(void)
 }
 
 extern struct rw_semaphore uts_sem;
+extern const char uts_release[];
 
 #endif /* _LINUX_UTSNAME_H */
diff --git a/init/version.c b/init/version.c
index 94c96f6fbfe6..87fecdd4fbfb 100644
--- a/init/version.c
+++ b/init/version.c
@@ -16,6 +16,7 @@
 #include <linux/uts.h>
 #include <linux/utsname.h>
 #include <linux/proc_ns.h>
+#include <generated/utsrelease.h>
 
 static int __init early_hostname(char *arg)
 {
@@ -48,6 +49,8 @@ BUILD_LTO_INFO;
 
 struct uts_namespace init_uts_ns __weak;
 const char linux_banner[] __weak;
+const char uts_release[] = UTS_RELEASE;
+EXPORT_SYMBOL_GPL(uts_release);
 
 #include "version-timestamp.c"
 
-- 
2.35.3


