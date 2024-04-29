Return-Path: <linux-kernel+bounces-162829-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B4FB8B6122
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 20:31:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52781281853
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 18:31:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ED8212A157;
	Mon, 29 Apr 2024 18:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="UynGsybh";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="C0ftU0XN"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94733127E1E;
	Mon, 29 Apr 2024 18:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714415505; cv=fail; b=leqhRx4gXhNnb9LCm3mVjyTtlN2GZW5fNUdTaBDLuMnBnqMlHZnEQ+Pnl5wFsanQsynLBh87i3U+qFDi1q7Enq8bFFljSofogjgEZ+evwmgF2k3f5wFv7XshrmU/fxI5eWxi2OxGcgOaKyp8Yrm0LL4MtsIVDBFUW/HrAAPvTzI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714415505; c=relaxed/simple;
	bh=dIAZ+uYJc36jgHHsJzP2sSrBm2iyJAcRIbK/36H02DY=;
	h=To:Cc:Subject:From:In-Reply-To:Message-ID:References:Date:
	 Content-Type:MIME-Version; b=nvKSs0mC36oXf2u5cr5sImEb79ZDpJQIioyhyVZYw56DJ3xbxNxiXLOoJp8P1ufQ9yQBESOtozTDAN2h+NJokFKt8MM8rFIvZASES6XjnRKCuXLzT6bqcPRJpOH8cFb9wmW4w7DiW7ENNiEM0wCZOrFpFfDum0cGIIbudle1TAU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=UynGsybh; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=C0ftU0XN; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43TI1Ttf013220;
	Mon, 29 Apr 2024 18:31:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : in-reply-to : message-id : references : date : content-type :
 mime-version; s=corp-2023-11-20;
 bh=frEVwy+xvrejb4aT2yvJVIbnYGl1EzB2QUYifVe2MVE=;
 b=UynGsybh4Hy7T9bpzUdd+plP3pMueOIvtFJnwRvW0dXDfl2hKSROCnjxYn0G4ypXfp2M
 NuiIrT74gL9WxVK777dQiRp1gpWKVI+hwehrb6xtcyzrpSJjl5xC3YOn0kJRYjTML9A+
 +SFyuxdmEvtnjR/dIWibbVr7Ki4aA58H+ri8ueu2Nsdds1Kwm/eI4YAoj4ZcUA0dsll7
 mteV+qpeE1Oi1gmIsDTjiaR94CybK3Yr8Aeb7UagxaCRDTywlrYo+s/41n520Z6gOIKk
 M/eIpDIbNZ4ur87zN/jNBqlbIlWkZw1fDmg4XRZbho80zutiDccprPsuFGVGng6FyJFM +g== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xrs8ck9a8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 29 Apr 2024 18:31:26 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43TIUSBq033276;
	Mon, 29 Apr 2024 18:31:25 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3xrqt6gx2p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 29 Apr 2024 18:31:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MKRpSIkPDAhTpbTVeJVf5T5WSvF+Yu9Xq+7OdGqaHz/1i22nOxSrAP8+e9n7QBcEm5H/oLWUmyz4wT9py9QFr8gQaxML8mjILQkG7sBaOWMn4ctzeU+lyZFxqAut51DUlbMuPyslE/Rt0E7qFLJxJzLpo85gEhlryREnrwVVZxEIOurXsfZTiUnUNg9eNlCce2hCg0yMs93rt1A57AVrKHn9PRVEBep2ynCYsVnxnkkNAqigCMz7Dq1nCNTCehLXOdzOuKIAlkmPJcHwF3Yvm4v2pUT/oAyTAbP2VNVr/fRNbLte+Crj/UgrwUuQCFGMDRBpyhkzdQHjvOeM70FSCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=frEVwy+xvrejb4aT2yvJVIbnYGl1EzB2QUYifVe2MVE=;
 b=gFsSSUAVu9EyKMaSpPbFrlPt2OEQqGydMwTTzkgCL7tM94hP/pLRinSBKPMjqW3rjyytAY3od87Tb4n8t6kUB8BlVf4EseDrPKVB1RX9gIlcNvC7iYRDcRLrtHX5gvVNmK2hwT7YohJ/4GexHEfWOPKL/lOH02MlwwQPrFONuRuArx8MhZ7biotbsvd9Hq1syyFKn/z5xsNCMXpoDO+uOLE4TX/xmKUH6VOY9ZqCCaXhjj/ewIUvNnnaR/FaQtgmiZBV2Y8uzZpv8LrmXrXmDaVar88Gb8b6xoqxT6lMCjZtkSq+8cvaABFWPBDo7rPMP1Iy+4sUWWIJg0Uhn4be8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=frEVwy+xvrejb4aT2yvJVIbnYGl1EzB2QUYifVe2MVE=;
 b=C0ftU0XN0e2Bf6DPX25GV6XWxHypiFoYjaCKOJKhd9WJuaJekCL6BLLSIakgnneEj6psQ79xK0tvXYhEAYK34K56QijMBFKr63Rygimcd8UFk2NYKXi70I/qc1REDmLaFAc3fj7VI+wyckDWfNkkb0yCsxgH2GIvHhYxRIlOf2c=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by DM4PR10MB6887.namprd10.prod.outlook.com (2603:10b6:8:101::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Mon, 29 Apr
 2024 18:31:23 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::5c74:6a24:843e:e8f7]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::5c74:6a24:843e:e8f7%4]) with mapi id 15.20.7519.031; Mon, 29 Apr 2024
 18:31:21 +0000
To: Kees Cook <keescook@chromium.org>
Cc: Erick Archer <erick.archer@outlook.com>,
        "James E.J. Bottomley"
 <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Justin Stitt
 <justinstitt@google.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH v3] scsi: csiostor: Use kcalloc() instead of kzalloc()
From: "Martin K. Petersen" <martin.petersen@oracle.com>
In-Reply-To: <202404291019.5AC903A@keescook> (Kees Cook's message of "Mon, 29
	Apr 2024 10:20:15 -0700")
Organization: Oracle Corporation
Message-ID: <yq17cgg58sp.fsf@ca-mkp.ca.oracle.com>
References: <AS8PR02MB7237BA2BBAA646DFDB21C63B8B392@AS8PR02MB7237.eurprd02.prod.outlook.com>
	<202404291019.5AC903A@keescook>
Date: Mon, 29 Apr 2024 14:31:19 -0400
Content-Type: text/plain
X-ClientProxiedBy: SJ2PR07CA0008.namprd07.prod.outlook.com
 (2603:10b6:a03:505::8) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|DM4PR10MB6887:EE_
X-MS-Office365-Filtering-Correlation-Id: 71c2bf7c-5a0c-49a8-61c0-08dc687a918a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?8x0bQcN/isjxJwXeGbYlW8S62n2x2hdbAv91SXP47LyYFKeyzk0DQGP0Fbuv?=
 =?us-ascii?Q?pAoMnzC1oL8/4S2BfTyuE9hNDvOSyKSdC5bRpeAliWkIBJjCOrqHn8DSpjRl?=
 =?us-ascii?Q?h6gEnxinCfIqICAUm5AsQjbAdOF7EXpDXLrS9VibhYTsI4NcbBumY1riL/Gh?=
 =?us-ascii?Q?DWAV+7OOSO/apujx6A2XbsmBeTPDl2g0b5Z36Tguf7kuDfmlFLxRzBBw/Rac?=
 =?us-ascii?Q?mGgSdJw0T87ZTxiuw6RUNbCHoiY8dmm0BBHWc8PRKEHdV8m5yS6hPfaiNsTw?=
 =?us-ascii?Q?+oru3ptL8ngTSJ38YtvdYV0CqCfe29FLqTVZd+B5bFiSe0GHImJUWoscLj6W?=
 =?us-ascii?Q?ElooMBC8TGuCJaAKbiOlVkOKE26ZSq12D0jzHhL10uXXiT8lhzqjVQtJNiM9?=
 =?us-ascii?Q?uZlIzorNZrgHwvFAhAFp6ZSEqrw6Ma9ulCCn1C+k3oQJkVRbIE9YNqjxQWqG?=
 =?us-ascii?Q?OJnBchkeZ71FkkKrzSX8XZGuPCA+OGcq2NXYAxEa5qPHwYU5mq5Y8vZMouPB?=
 =?us-ascii?Q?JojEHnwzwNsESMXhHEzNCjMswKaD3HZ5R7aza5wBW+oyyRNOplgYY3K+HnoJ?=
 =?us-ascii?Q?ukPQqLAwvyonSNrNGEDd/Iz7NKep87E/+OWpjp3R9grDg2po+ec4M2EM60G+?=
 =?us-ascii?Q?8n/MCIhqXHwBzKi80dKOVC4OHX9VUwn/goP3Bl6lH4XOA6IHKuhPHPFe007X?=
 =?us-ascii?Q?2Ef86FqFMBBCnrdeoilCrm9lbtiOdewpcYLpqKChyU211VzUdIIJu1MMbiL4?=
 =?us-ascii?Q?MCh626fiUvSyl5iOxvFUd8qEpU5Sm9fh8xE1Q6Ci7fwYYwtRl5olXZ8zpsCc?=
 =?us-ascii?Q?8CXYf1FPq6RNvwlSHJb7MIwRaZJGYgtL8agjfs1u8LHqmI7PLnxYHeSSaDHS?=
 =?us-ascii?Q?bYr/KvvXzbaLlm/ntz9qcoEag2lxRp4BXx0RXF0VPT+WKl9yQFM5krNVWCab?=
 =?us-ascii?Q?dYJdkDIHvioWDgKSM6OfVs3gn+2yCH3nnHj8dTVHC72A16d+pthDa9pW4BEX?=
 =?us-ascii?Q?CjT+gk4xFry4TwE/SKC1UcufDDmsoU6M6inSE2GAECAXLO5uQQd50EVETIXz?=
 =?us-ascii?Q?KarV1aSjTYtiOgIyRrv01KW1l1jrVcwWA1/v9+lXYBYEIy83AKToO7izlVT/?=
 =?us-ascii?Q?06nOEb1wsiG59C5z3gGelJ5Mr/TZjTss1Iz3b3Dfw58dFT7FmRcIkOwJnUYU?=
 =?us-ascii?Q?nxIVZ2SFgQeSKGJO8N4uHAgy73WEaxXw+lWinIkYo3VMHS+vMeGTfNmWEjdz?=
 =?us-ascii?Q?nYeFXJSWVc8XU+IV9XbcaqZg5no1z9lGgYDVenqD6w=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?Ay7bIVTwUwa612GJFK1pp4JS3CZUlwQLhQQcROhlnk5SGL/B3yjJhzQHcCfh?=
 =?us-ascii?Q?bsA9WtGjqUcy66La4YwyhxjZkr528VGgVGM8wNnesLvuD427TwlRn7wlqzEJ?=
 =?us-ascii?Q?X9gWVArbD17g4nt94MOoaU9MnaSPNvBBOi4u/WP/AYZ04ZJ6VrmYJ8J/syJn?=
 =?us-ascii?Q?jnpj0fCwu0Zjar3cWaAdagVKNsf9hZNVw3j6kaBF4taH+PNfwl0eZkxyK5Rs?=
 =?us-ascii?Q?xAHuD24VsT0yW7W0B8gHKKm6+zbKe73zNDB0uQjtBrNxyHJcd8qSJF5/BRqK?=
 =?us-ascii?Q?taI6MqTiYjIrtavBjZe/58pLs1zgkg+7IIdIA2nbQgE4MhKxGXnd5ZuPXmvC?=
 =?us-ascii?Q?07NrSAJgxupPtN90oU2HImBB3yw6HoO55TUshbxmH3jDbRZnWGGB65EZb15M?=
 =?us-ascii?Q?ZVG/mVmcnrkByANWkb6xYevLoCtVit5sRDsVkVA97rbasUDj8XtWRMkkUfL/?=
 =?us-ascii?Q?LOwFHqNYSD4PBXgNL02JUuZ09l40Bakhfllb/D3T2MXMlh5cBs+OLh0pXNhr?=
 =?us-ascii?Q?xVTAXaNmkuBEFiuxlx621l2SyveT3CbMGrS6uwafYnRNiNqiPv3Rq2E8YOWN?=
 =?us-ascii?Q?ehWUgdFwPYW96yWHDTaqQ4qFaH5NSLzQmk2OT606NAQdUYIlFico8TNdm3kR?=
 =?us-ascii?Q?DCYN16N6fib+5n3TZPc1j1/5VPVxbo1kXJnqvtyDEo72PKL8xwW83nX2V09F?=
 =?us-ascii?Q?QLXSFW+GNqwAcnhGbqf/Csgc9riXYx3ZA0HQLG0wwQ69Oq7xTfCFSt3YNBMs?=
 =?us-ascii?Q?760iOTGZ61Lm56EqZz50KH789c8qk9cxGFPB2UGRNMgdU7rq1dxLxADHzrqU?=
 =?us-ascii?Q?qt6vXGsWKUSFUzWthnKri2dbSOKO7UM1HbQdKi/JS2l0AkTB0Mv3eva4bLpS?=
 =?us-ascii?Q?oXJDOVMR4vmsqf8pmy9u+vX5e5x8W+ybstBtnexBgYNtPH20nQAbqXwg0u0d?=
 =?us-ascii?Q?e4PBQpNpOD5Ao7MaDwQ8RKYsgY9DTBaLpWlclbL94w9kT2bInFdxW2vfz36R?=
 =?us-ascii?Q?NMmk3D2iZcfZjtZtop7Z0wJBOkc2alfrxQ4aImZnZl0Pnvc4nbbTLzqEHkga?=
 =?us-ascii?Q?jMGjwT1YiIQJW2A7Ew5/Hmfg4vL+G5kLJ2mfiT03/ph1x71hqe+VxmLzeXw3?=
 =?us-ascii?Q?u8BTYkWkX+8/TC30oZtSz0nOswAxvWf4mVqP0NIS2zlJXBA5q05DgfPASc0N?=
 =?us-ascii?Q?xHMUiiNYhjs4MaJy/yXjDH/iOV37v9DBLFXLdtofG5pS4dKWwDjuo6Vcqm+S?=
 =?us-ascii?Q?K0u7XSVUdTD3rjM1sbBre8ArG5K26A0UhfRElRwOeUo8FLTduJVYdBD3Zuv4?=
 =?us-ascii?Q?rVjDCJth2mMhGo4ZEnXZRdZd5S/vRpw3ySvGWD/hpy+KDBRgRwYrOnc5hUcc?=
 =?us-ascii?Q?AC93CWtGNWn1nWGVSSw7logr+0Z5W7lhFeeVb5TgkLGkMGe6rmgDHKespTgH?=
 =?us-ascii?Q?6nHsdyAddOqz0JJv10u0hoCF+i5XTqg97MrFJoCGHHdQYO384udh4GaBrRx2?=
 =?us-ascii?Q?vvNyRaWL8sinvZVQerSRqLlIXyapn8/x7kS8tHtra8/iolk5mWjeD+lCkniS?=
 =?us-ascii?Q?IoixAcULzRFOMYNBdfHakjJ/Z2w3WYhGFB5wvXlruCYww/Wx40ta+PSnluKb?=
 =?us-ascii?Q?sg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	pdfJDmhErYPbz49RQwa6Us2VON+0vAs8OScRccPrsosUjVYJF5tSX+xd8rmqI+4CNdLCfv0nzR1L2qm9z7doL+lG16sHHid9wumozx5kR+TMl9xA1sAEvJvocjhGh+YsaFE3N6SKV3c5i+K3IHqijDuodmLEs81+LDHH0qdPJfGo5v6yUlKPqRuBH8A5yj2l7uNCVZcEg3apCW4c473M/J+ZTTC8Y8vf179XQc1a9Y8xmaXVrOUYrwLfbSg1hLJwbESm3gnI5UfsKyTK/xnKfNPUirqNbGxaLiR0qQE4NtSMEenVteFmpzJevkcYPyTfLI7nTjo4Aly3jQDpL6GQjcLeQTc8K5bopZSuCP4yX9euzLXjrL9yav6g/PXZxnP3oSfM66OFPBUwojTqtefwziiKTkmwQoseFjvar+8T0IwaJurH6AOZ+1yDN/YSArfx7hf2j/irjTvECLeYbkEKRXFdQIX8cJoh8bKAbI7+rOBOKiiqFN+eqd9zk/ZKkt2KycE93yhuodEwZIos2loOY+PkrVgefzVt1R4sVgrT+TiD9mBvarLEotvXK+il261Gv1vIUveA6EyiInWlFIFqVP4QT0rJrb6/Qz7LlrZRJDM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71c2bf7c-5a0c-49a8-61c0-08dc687a918a
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2024 18:31:21.7762
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F654BG1i1AfzDL4H4QpesMkoIZlwCZj2OEgbhyXLyFSTqypYCbTzuzCtLDOJI64Qe8V0euwIBME5QYHph0kN2WpOyAtWYZD9rWmRG5IRDNM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6887
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-29_16,2024-04-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 bulkscore=0
 suspectscore=0 malwarescore=0 spamscore=0 adultscore=0 mlxlogscore=632
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2404290120
X-Proofpoint-GUID: KPDElFbpYCpsg7Bgm4dTRpGzEWPyMiN0
X-Proofpoint-ORIG-GUID: KPDElFbpYCpsg7Bgm4dTRpGzEWPyMiN0


Kees,

>> This patch seems to be lost. Gustavo reviewed it on January 15, 2024
>> but the patch has not been applied since.
>
> This looks correct to me. I can pick this up if no one else snags it?

I guess my original reply didn't make it out, I don't see it in the
archives.

My objections were:

 1. The original code is more readable to me than the proposed
    replacement.

 2. The original code has worked since introduced in 2012. Nobody has
    touched it since, presumably it's fine.

 3. I don't have the hardware and thus no way of validating the proposed
    changes.

So what is the benefit of me accepting this patch? We have had several
regressions in these conversions. Had one just last week, almost
identical in nature to the one at hand.

I am all for fixing code which is undergoing active use and development.
But I really don't see the benefit of updating a legacy driver which
hasn't seen updates in ages. Why risk introducing a regression?

-- 
Martin K. Petersen	Oracle Linux Engineering

