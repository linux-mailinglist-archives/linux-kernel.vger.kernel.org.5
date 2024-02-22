Return-Path: <linux-kernel+bounces-76063-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6EFC85F27C
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 09:09:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD3C61C2337B
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 08:09:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D8D117BCA;
	Thu, 22 Feb 2024 08:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="PcX1XUBg";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Z7gzs7vj"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 281A517C66;
	Thu, 22 Feb 2024 08:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708589348; cv=fail; b=uXzVu6Absj3U0ypMuiRGZ9DgoTPi8JTGwsCShqgXD2dRjotjgJW7wQoETelNfIf2xnLsol8WV+9idhpPR0b4ztTC1sk3KDgVGRO6rB4lGMZWTROkgEpmPbWzRf21wrhqMDms0FJVFwBETrT97ppjyBopoYz2u++oWDWEv33s3kc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708589348; c=relaxed/simple;
	bh=C2Mnll9HtFXU8rsYgHu7hKyauqHvpFSRzJ4C8MLEbhk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LhfKYIDD7GEYgWDui3QlfFeLI1c3M+0TBBSBaSLuO1AEmMHKH0ztLaa39D4EmoR/bBxuYMd2jYAKBDgDJw1mDr9Tgyu7ysA4Dp+kyBkwsJWluwFpe5qtWhwcZLo/PCGrLHSdk/EvNxKRIVqTa3sEua3wo0pAvI4RvJR2zhoH7Nw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=PcX1XUBg; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Z7gzs7vj; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41M3SvTO002433;
	Thu, 22 Feb 2024 08:08:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=OEfLDJqKUdBLyPuXnzDSNE84GhXglsYBackl+8CIOgE=;
 b=PcX1XUBgep/7ZBFBjm6Fo9zeINK5hU0BnlPQOcHDRZelKD4XhwsZbsYxAof/07mjhbIm
 fP+nQaDHdMI447MGGEamrLgcXuLemYHsB+hxb3PKqeeU3PqKz0XB8rxsJnhSHQbNpCjM
 Lve6cg7eFEc9D9exfoQlkQSgEQ65DNE0d0xthD19IB62Q/fpW80/NBqPFbSt8Bej2ZZx
 pQvw+vGnvZiDq/sggmPREREpTwKBKDNsIoJvVylo2pnHbLNujFt+r5BM6zhWT4mSgdX+
 kFdKVIfXLpBdRaXuMzwloHn/P7RBboYouoYVh86TveUkvyOJ65GbSxqcR6JQvR8IfvR5 3g== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wamdu3upc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 22 Feb 2024 08:08:58 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41M88CNe006632;
	Thu, 22 Feb 2024 08:08:44 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3wak8ag171-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 22 Feb 2024 08:08:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aB++tS3DOgbSoa8XXuX/1+gQ8UDv/Qh8zo5QlHB4f46s62/0zy6WcmIfWpeoCa+0RGfs0+RNSOTt4d0qyCedaZ0jgnBAQSTiZuiXv3CEE+FmOP7PMd4GcnycrTz/qOBPalkl4GGVnIoUIzgoGt0uIleRLVtwQKBpqQKQUEBbSD6TsweVBhKN7HBNiFafrzvRDAHaqwv7epAl9OyEC4G8ZcgpQdHN/cgnvvFTZgp0y07Fje7ZHIKLr6naesEo9GCo2soz/VssoKjbjxof/Z6LjDJcLjik14KVzz9+oi8kvQ9uJthPLN31vZP2giJ2ojNK6ONV9zFPA/ExzX56kxaZHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OEfLDJqKUdBLyPuXnzDSNE84GhXglsYBackl+8CIOgE=;
 b=PZi9trRVSFjbvm9LiggYB5mLJQO0ouFNqA5hQIDg4FU4Y0uHKfOZPJFbUWElkaMFXC1ZxhNMcfdxxoSnP3hK3riKjxEJNBHDPXrxrxUcFPsCJuNjac1gr3YG96lmxRXWWhd5Cd0RSScXDm7F3LdJbY9AO/HHnHGpbnQBb536K9LGU9QkUYLcN50OddXT+3fCJ8r3hYG00Lh2Q4lpu5QNA99SarAsvaQgZvmiDxy3+XSlvKqdZ9BOJI/VfbWrHLUFUSRQzBgr0XPev2B/DKn0Z78KQHQ3dLx2lihcyCo5C/BQimdv8XPv0611rXYiIwL3we9tXwFVIKOFikfqfJdGRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OEfLDJqKUdBLyPuXnzDSNE84GhXglsYBackl+8CIOgE=;
 b=Z7gzs7vjZtIszaSEtb+kzhkkWkeX2yOp92G2CfpUZyVR3HODiqAkvb1J/jwmfbLGiNuU+Pqa4pLCu9Mgen0Sh7j9uFieVrJNpPwNjoHeunIrO9THrvWoPmWAvCxJ8Zio202jZZ6nS1XQmizorn48MR+fT/l2ShGC6Oejp+21234=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by SA3PR10MB7072.namprd10.prod.outlook.com (2603:10b6:806:31d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.22; Thu, 22 Feb
 2024 08:08:38 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::56f9:2210:db18:61c4]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::56f9:2210:db18:61c4%4]) with mapi id 15.20.7316.018; Thu, 22 Feb 2024
 08:08:38 +0000
Message-ID: <9e6e933d-be9b-406b-85f4-7b8e3c2f8267@oracle.com>
Date: Thu, 22 Feb 2024 08:08:34 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: ethtool: avoid rebuilds on UTS_RELEASE change
To: Jakub Kicinski <kuba@kernel.org>, Jann Horn <jannh@google.com>
Cc: "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240220194244.2056384-1-jannh@google.com>
 <20240221112309.7d526047@kernel.org>
 <CAG48ez2tr8k0BqM_Lq4VAMRfrEdYhWudK1Fx6HwOEb0TBPDd-g@mail.gmail.com>
 <20240221113541.76161ac3@kernel.org>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20240221113541.76161ac3@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0664.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:316::8) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|SA3PR10MB7072:EE_
X-MS-Office365-Filtering-Correlation-Id: be404cf6-44b6-4440-c4bc-08dc337d7963
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	4pGgbIa/peNoy6MhlyuP72IcDLWOZbyQRpyZqPd2KizcD5Ad1uGeKl7DF/Njt0d+/W07UeMJPYi3OGkW+96hOlmlGSw4mmg2Fl1hV/iRQpjdpBU2GD1lLJospT1Kl0/6UfmZrosZvD7JG6O5h6GZ5/1yd65wHtBTGZprgj34EQinIO4Gr4/WkUStSM5Ls/9k4Ny73KFMulLpw0Fh6MILTLN9WbZDhlQnBFzddMiCt4l2SpYAZOkvf3Iq09PLK1Rhydsk1QRp7PnZxIsJHmQTmDon5eQEUoeFz4UK2unT8j+dspThzLD87KpPcyhN8sNs8+scwtqVVOh9faMdhwApghUxjvzA0kxp+96w7f8faAnS8aj2Bz7edSGGgE+ivlMy8LPGD2Mj/Hoky6yJ8+P2tNboQAixU41b3vaXKfRko2Lr5B3UfetNHhE6r+18OB75H5Z96LADgKLyGa77LebjzAnFSoZmtUxymdg2e0PscS227CzYUdoTYcQ+z+PakoKCuYYOqhlG3khb+Al2nIIEVQ==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?amNzM2tJaEVTNDYwUEIydVF2TlJUOVJwakdXc0NaU2diSEhld1dscGVsdDE1?=
 =?utf-8?B?SzlFUThpTGR6V2gzUmJPYW5HNG9kcjFFU1FNWnp3dGJLZWptcHFOY05zVkpr?=
 =?utf-8?B?OUFHbXgzdmZkWDRTRDNWd3dFNVJkaGFtNTJ2RXFkQVg3ak9jWGdzZndWYnBO?=
 =?utf-8?B?ejdEWlVKWnZUak1FcDZGU29zdHZ2bEI1bEVHNTk2SDdRcEdrOURqWjRKWUgv?=
 =?utf-8?B?emRzSXV3SW1pbEp4VitTODJLa08wc1JCQmNKQm9XV2RiNGhKdEY5cm93VSsx?=
 =?utf-8?B?VlhGNFhUU0Y2cFExODlpOWc5WiszVzZoUWxjemlmMUhEU25BVGNsZGhQUXhY?=
 =?utf-8?B?L3RQS1JHRTZ0SUZqWkRuQ2lsNzBOOW5MOFUzYzF1Ykx4d3AyMUU2YkJZdzlL?=
 =?utf-8?B?T25XV3hNcWhWdmFoRDh2NlpUUXkxUWNraGpuam5FMkZQOENSQ3FXQWplT0N2?=
 =?utf-8?B?Znk2dXFWc2RrdXFQWDhNRmpjQVBTM0h2dTFzWVZadUtRcXV2MkQwUDFwdU1u?=
 =?utf-8?B?SmNnaTBCeGM2bEh5WEdPaTdpMXFiU2VuRVdTNDR5T005eXZhUDZ4dy8vaEhV?=
 =?utf-8?B?Z2ZBallpcWZpMHpmSzhpRm9NTWhMR25KdW1rMWpwaXR1QzNhUVppcSswQlZw?=
 =?utf-8?B?ZXRkTW02eS9OSVpzZmpJa3FnYktxWjA5UXlCdFowWjZqZkFHYytuRnZzRmds?=
 =?utf-8?B?UDNHNXlVWW9LS1V1Z25XelBoakRoUUpIM1VMYUpjMW5ENDdDTDN1N1VMdlIv?=
 =?utf-8?B?c09wVmFsM0dqM2hMd252c0QvT3VXdGdLbE51RTVYRkkzbWcyWmtLNEtzRkJH?=
 =?utf-8?B?VzJNWWRCZW9TRStHYlV4WG5JQ1lPOVFpaE1JazdtaGRFbThOMjNYdEJad3lI?=
 =?utf-8?B?andqTG93aTNmZWYzbjJsaDRRTVZNSytaQXUxRUhlVkVwdTVJc3dtRExqa0d1?=
 =?utf-8?B?bVlid1ArQmhhdFhPbjVPNXJ0ZjRrQmR4QjRxck42QnZoRFJPa05mb3M5VUNB?=
 =?utf-8?B?Q1BiV05hWU80bVh6Sk1zaGxLVzRnRmZYRGdwUWx2Wk1CVmhMYmlNTExjQWp6?=
 =?utf-8?B?NUx0U1pLamJnQVdRMEdNa3FYTExIaHFDZ0E1YzJRelkzaktOem1oVHhLS2Fq?=
 =?utf-8?B?MnlEZDBjSXVyVnVSNm9rMmpDY2hSVWJPMTQ3bnI3ZUo3YnNJbmFvVUs2Wnk1?=
 =?utf-8?B?T1ZoQ2ZVdUNXQ2FDeG1UcGRsNnhsMWRuZmQ4R1FnQnZiaThoMHVrSlUralIr?=
 =?utf-8?B?cmRNcWI0bUpEL0d5VmVEVDJzOHZrTjNrdnFFenk3YkJSTzhlUkNyMENncnBa?=
 =?utf-8?B?QXhaZ3YvTTZ5Z2dHeHoyM0t2UlY4Ui9HVTRVeTNGaDlTR0hsdklTSHJEcjFu?=
 =?utf-8?B?Q25vekkvQ2lvdnUzOHp4aCt6TzM4K2ZrdUdWT2ZCQ0NScUx1ajlYUWhkY2xs?=
 =?utf-8?B?cWJpYm9WOG1OSnFwSWxrS0ExRmczQ0pta3d6ZmJCUm85R1JmSlVwM1hCSHdN?=
 =?utf-8?B?ZzlicUU2UGR1WHdKOW1VWXNCNnNZUkxOOWlmb2hCNE5jc3dxMTJXMDIzaFFn?=
 =?utf-8?B?UTlERGZ3OVdYMjVCdmdYVDIrSjVmYVN4T2JUcU9DTkNucHpCZno3SzNxZDhk?=
 =?utf-8?B?MDI2eEV5V1F5c3VPL0xURWUzeVR4RTRLRmY1VGxicS9aMnJZanpCNVp5SXMw?=
 =?utf-8?B?VWZCd2o0bnZFV1hDeHFiY3J2QWtLaWZlY3l3aTMwcWZrS2JSWTIvaGdxblJv?=
 =?utf-8?B?Y1F0VTNDTysyMFY5K0RzclJSME5RYjRrak9BcEtaUVJiVTFoNktLNE9XT1d1?=
 =?utf-8?B?QXdtVmVRSElETUYzdmFPVWxIYVhwZ3FyYXd3N0QxU0dwNFhNeFVEOXc0VWxi?=
 =?utf-8?B?b3ZNVEpVMW1xRTdJak4vVDd6S29sMS82NTJ6RlVweHB6UmxKTFZnZUxxVnR3?=
 =?utf-8?B?bGVPUzhnNnY3elE1eVovV0V5R2lSWDM5dVd5L0RybTZaRVNZUy82RkpGU3hw?=
 =?utf-8?B?azV3b3pvWXBKZ0VYQitnbmUzZTIxU3c3dWtJSkFWeU9YRzRtS1hzRVFYLzFO?=
 =?utf-8?B?VXRveVZtT1N1Q0E1SXVWcUpRenR4UzJUazBJb2pRbm9jdml5OUMwSTcvWkRX?=
 =?utf-8?B?bEtLNU1GeFJXRlZNRUVCdmRtM1NhTlVCdDhRN2hOS0RwSk9hM0JGaExyMWdh?=
 =?utf-8?B?MEE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	lhZgMT9sr7y+21fnt0kHERmZOB/GYlVC+ZK+DAURHYxZmnvmdBjemo4iDpHKefimuPMHeE8o7lPil07Xs2y2K7aevozz39rw7VtaG3vv3IGCOhhkr0xl/DJcbZueB3O0OS/xcNadgC0U1xQFC762jrs/BvdfwledcPi/fIN6SjqsUhR8iwKoOEDRWJ4ORZrWw5BeUcnDckZ91lB/65cddpLiFno+Dv4lrxcvMQN17oA8zRr+Sw9B9u0ZtInbkL3zj7o3aCQrNaSur2Ry5g0z+7iyFBYgbALHpJDLo1088PvzzyN3FwK6ppQw2IH9x/9k9TnrIsCPSPjlByr075k6eXdkk7JyxsswzJPwKQqagCEgSdo6v6H8zMa+TR+ykVHZRCj7Di+zTfoB4U1sHBgkGzSA8WTeFs23rJiT5uW1pU5CQUHHnvwUFCyE11oy/y6eVSaMdqNsQA0IUeqtQAOLYE6RlmmxjfPuOFVrw7zXJss9bXmNaW/roChjUszlABlDJTV6xa1FWoXtBd8eL6gGaWgXkyNxOg79aK4y9xjHaVaUb7q/bvnG73j5o9zwSBjt2EfTghrUpOWgl3Ztdb9HlZkYjyBNJhr/OfxGTud6rys=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be404cf6-44b6-4440-c4bc-08dc337d7963
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2024 08:08:38.2245
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hFL2tGxo3O1Nblk9ML11gvZqLuK7urTAAeixV1joayzsdC7O1Ho0JaOHTLIqiLVNX56b6iMUfz5rH7v/x1YD/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR10MB7072
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-22_06,2024-02-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 mlxscore=0 spamscore=0 mlxlogscore=999 phishscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402220064
X-Proofpoint-GUID: 3a9lTZzXUkRLZwoU72t05SHI5flDlQrN
X-Proofpoint-ORIG-GUID: 3a9lTZzXUkRLZwoU72t05SHI5flDlQrN

On 21/02/2024 19:35, Jakub Kicinski wrote:

Thanks for including me

> On Wed, 21 Feb 2024 20:25:00 +0100 Jann Horn wrote:
>>> Is this related to John's work from:
>>> https://urldefense.com/v3/__https://lore.kernel.org/all/20240131104851.2311358-1-john.g.garry@oracle.com/__;!!ACWV5N9M2RV99hQ!IghWg9_5HEQ-ng1XiYH9hes6vmgylmcQF5l2RITIrCSB20BzKzOhWWKHrgQZw_DkgKlZRNllglTanuY$
>>> ?
>>
>> Ah, I didn't see his patch, but that seems like he had the same idea
>> (but implemented it less sloppily). You can drop this one then...
> 
> No preference on my side, just wanted to make sure we don't have
> to decide within netdev which approach is better, not really our
> wheelhouse :)

I was not going to pursue the change to introduce uts_release, as we can 
instead use init_uts_ns.name.release or init_utsname()->release instead. 
I think that init_utsname()->release is a bit neater to use, as it 
slightly hides the init_uts_ns structure.

@Jann, please feel free to pursue upstreaming the change in this patch with:

Reviewed-by: John Garry <john.g.garry@oracle.com>

However, note that I do have many other changes pending on this subject, 
see:
https://github.com/johnpgarry/linux/commits/uts-version-string/

I just need to find a bit of time to update and post them. We also need 
to be wary of CONFIG_MODVERSIONS, as discussed in that thread.

Thanks,
John



