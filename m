Return-Path: <linux-kernel+bounces-28281-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CAD3B82FC7D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 23:21:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72B3C28E86F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 22:21:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D42E22C68C;
	Tue, 16 Jan 2024 21:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="efrK9QDE";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="SJK0HcDl"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0E981EB4F
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 21:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705439241; cv=fail; b=dQt2kUd/m9QjtY3uUe1MG+AbP+LZuBP6HyVMxJ1OpW2CChGoJOucJuIrUHx7hBMpLqL9QDfh3sivgQY0Ij1dS23sLHJV5KMMly220xkSC8BRR24EpfchHKcl1pHTaS0NK/vKcGF9NN7qcWfW8qrD4dMNQ6BJhmH7o7CR9P+hPsw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705439241; c=relaxed/simple;
	bh=rW6TOkQBQftfXgDhlOFtoHhwrgYlPcfdXlUP+eh7X+Q=;
	h=Received:DKIM-Signature:Received:Received:Received:
	 ARC-Message-Signature:ARC-Authentication-Results:DKIM-Signature:
	 Received:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 In-Reply-To:References:Content-Transfer-Encoding:Content-Type:
	 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:
	 X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID; b=M2CgRKi6CsdLZ/t0q9V37Efv3kSzNerkk4/MELarjOh7RVs++TupM3JAEsk/8fJ6Rnfo+BUpf66r7XUgrgwe/CgxE2lQ44M/LFeOOlZ/HIFxwn676euc09E2Pjsy7YFzPuiJo48U4YYsosyzkmY0IE769HxNIHsQAwUJ33YUwN0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=efrK9QDE; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=SJK0HcDl; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40GKEDpX013149;
	Tue, 16 Jan 2024 21:06:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=4vix4UxBd4K1uEuzqcw/x3mnhdtU94uxYPyD0hV3kBg=;
 b=efrK9QDEqiiSA50zF0/UlRQ5hRi8SoBrRYtjz7TB8fqO6Wp+JFhPafJyMWmkHKmx/0Mj
 uNFZWXUmKcYQgouAb9CBzYFMDePwE6JLDfafCS86/If9H4aKTvm6z3Ennk5fayErXR/U
 JL3DtpsGbJD2VQt+/aZiEGmM0dAJA7R34sZedXOZfuB9ErDxowK7VPZAoGAbZoSoORrP
 ViaE6ogh0No3gesBPXuggFITjgWct61SgX7g72ZzvjL1sgiMgYSzEFziKJNfxqRhemFA
 6k2V4jL6IsXzJbJ6vw2gxO9RbQ4MdKYNS35c/rdYjeK23PVlNph9z/T3CJoiNemW8tJu Sw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vknu9nsw5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 Jan 2024 21:06:41 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40GJRCgC035732;
	Tue, 16 Jan 2024 21:06:40 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3vkgy8unj2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 Jan 2024 21:06:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AFTT8M4+I9M8cZfu/3lDy+VtezhVUFg/VV5Lmw9JhYdXJgPVOhwVuO8PY6PjV8T0XyMlYOmiRhDqNZZ2sIY4SqQ34iSkmGOgglrgI+Fv3K0A+2vQOOSwnn/hHq3u+8vDGorDNpcLn9ko2TORKD1UPpWBazr8Cz+DBSZUbdqiqhktBc4rubzjv+7mGaRjhQMl8ZGWlW2H10qILh0EmAXCREFsdR0+qQVDMC76tfgAzY6Jc+ZfHLyJG7LsYxOGuAY2UTpU82bkqKBtXGkC9sl4FPnjUvn+imPbnELj4bgUzNlJt50qxTh1e6jfOjjTWSXzBsMFEjZfhkRpUd4ZhElqmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4vix4UxBd4K1uEuzqcw/x3mnhdtU94uxYPyD0hV3kBg=;
 b=kF44Nto5AsLAO5mGeIPhwzMqOCK1rdj15Dp7DAlzLUhPPxXZxpwAvrGDaCVmVLNMycv4/ecm6WUAV1mfL4drKkAcxVHvVC1YdIHywlchOqMpCJL8kKc7039gyKhHms/lYC8bo33gqFI3DjY2qi9ezNsSMo/6VmdxW/xz3HimY+HxPO0Y5XEJWIpMB2u4KKsPl3aPIJdfr/aW1pzGurUtLtgrg0kLFD5JUPk2moif5NZpc8wpqJLT65Ln252wGcEKYvLs3VuIyFNa7vDM6o0T15SNRBREOLPF/DFVyVR7CNlKlgkbjdsu+Hxgc0fS5d7wwKJh/7/yf1NqoWAyg1th+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4vix4UxBd4K1uEuzqcw/x3mnhdtU94uxYPyD0hV3kBg=;
 b=SJK0HcDlFifgwM3tdLQCCEx7gYtvgF8I+ih+gBVgdX1gKx/hWJkeiqXHfonUzvIcGovUJhHqRpg2qZmET5ExlnYjfofokOXzo2rRgvorZK6vvWZ3jT8UYjBFCSnjkWyJ9HJIgaeFIGiME6MhEIQf3ffziXFk59stzTflZj5g1Xk=
Received: from CO1PR10MB4418.namprd10.prod.outlook.com (2603:10b6:303:94::9)
 by IA1PR10MB7261.namprd10.prod.outlook.com (2603:10b6:208:3f6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.21; Tue, 16 Jan
 2024 21:06:37 +0000
Received: from CO1PR10MB4418.namprd10.prod.outlook.com
 ([fe80::bcc5:bbae:8d5e:9b56]) by CO1PR10MB4418.namprd10.prod.outlook.com
 ([fe80::bcc5:bbae:8d5e:9b56%4]) with mapi id 15.20.7181.018; Tue, 16 Jan 2024
 21:06:37 +0000
From: Eric Mackay <eric.mackay@oracle.com>
To: mark.rutland@arm.com
Cc: Jonathan.Cameron@huawei.com, Matteo.Carlini@arm.com,
        Valentin.Schneider@arm.com, akpm@linux-foundation.org,
        anshuman.khandual@arm.com, catalin.marinas@arm.com, cl@linux.com,
        dave.kleikamp@oracle.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux@armlinux.org.uk, robin.murphy@arm.com,
        vanshikonda@os.amperecomputing.com, yang@os.amperecomputing.com
Subject: Re: [PATCH] ARM64: Dynamically allocate cpumasks and increase supported CPUs to 512
Date: Tue, 16 Jan 2024 13:06:33 -0800
Message-Id: <20240116210633.116278-1-eric.mackay@oracle.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <ZaZ_xK5QHVPSD7N6@FVFF77S0Q05N>
References: <ZaZ_xK5QHVPSD7N6@FVFF77S0Q05N>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0314.namprd13.prod.outlook.com
 (2603:10b6:208:2c1::19) To CO1PR10MB4418.namprd10.prod.outlook.com
 (2603:10b6:303:94::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4418:EE_|IA1PR10MB7261:EE_
X-MS-Office365-Filtering-Correlation-Id: 6eae8154-4292-452c-2873-08dc16d706e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	fHRtluxAZVEO4DEyMhWgcZwEIRVR2ccm+orFiv/aunkzMDfqj42JXD5YLu+w9wDiv0IltpntWl8vxzcPARB14tC/XKiwgPJ1K6so84Vy7SvyoUGTWOg+8q/IbxmxoVTSnbyikiK3f48B1g4916q/9RibZHtyQRZYKRPhDjFz/mNURqMKOCG8ND2g/RD5chRpL65rSuk+y3CUdbW4t0cZ04f4R+1fN6ZUfGwUqOUk1KVbWmJhNxpREMFrWIOIybrSivOEkOFi9Q7PEnAvSuaJIjh5G5FjLFzLlBiFt0defWrMgOlS7IrfPEFjYErEC19+SeoL2iEc34FnwiyKh5gVvCrt6TDmGyS/IuhN/GeT//dzK1UCXtIO5YsDfJuIdsjFsVvuENfiYVTdpYC+hTAVuB2tTIEO1SwjfviinrB3cQObx2ImLed3K1Zk7c2G9c6I8USxnOntjEyzwQqi7dyYQ/DolWLenmo5vNv7yrxjXd/cVklDvVxNPpyIsAqzBnuDDz3m5k/aoiFyyrb1xzZtGSKosYknihU+fvEBbOIY/apZX/0mWP2RKAmGi1ReNtJ6
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4418.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(396003)(376002)(366004)(39860400002)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(66946007)(2616005)(26005)(38100700002)(8676002)(6666004)(4326008)(8936002)(1076003)(66556008)(44832011)(6506007)(41300700001)(5660300002)(6486002)(478600001)(7416002)(6512007)(316002)(66476007)(2906002)(6916009)(86362001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?0oHC4iWlOQ8VnTD0Tb0gS4Jf8DXYmRutUsjREAikFjFAk5CDXdQYDLab7Q/4?=
 =?us-ascii?Q?hulstMSGDtIkZVZDgKNSaYyTN3/1iOOUGAQnwBG3AgTzXz9uhp6zoE21Aihk?=
 =?us-ascii?Q?dxl7R+ZA4nl251l5XuMygvIaM8sut6ti7TWwLXHF5Rh0zSOcw72gcbNvuoCZ?=
 =?us-ascii?Q?AdtjB6ZLYJVUOUYlwVET208lVrAR8yW9DW1pU/hSv7BHYLmkhzXQcxKN3xHS?=
 =?us-ascii?Q?JCwwD+G7QrvdVhjI+GYk8zVa8cJbReZPTPs+TKNHF0K7H3iy9xXlCQOoEDoL?=
 =?us-ascii?Q?8o2GzxYquU02UWKEGtgsV+XdQgF3z58TZdY5GNE/G6QEzJAkk0WYCEX4DGsU?=
 =?us-ascii?Q?+MqvHFzwnWZoiqTcaLdlfjOQHW7tLSM9/XFXzcN+6JQbkd5h7Lnis5hOMDON?=
 =?us-ascii?Q?yzFyF/9nmbd75X9zzW5rfHN7rPd0eqyxgqdjEMA9n03OQYVnvkMVLxUWMJpC?=
 =?us-ascii?Q?Dwjd3OazTrzpsZqog6ZJsnnFcqB54aQFMvauuSJPs3b1zQBXg/ze8D8xwOz1?=
 =?us-ascii?Q?wFqnSsvPJBNarc2ar5p/l+1JcgwH4DY74R0LW849oMkz1lFdSFrrQDAqrIF6?=
 =?us-ascii?Q?tPNt/Wr8gvuh/AEbER4BUUHsgGLcrNCUWJCrkN/YX3hwH9fzL+q1RCdOVjk4?=
 =?us-ascii?Q?TOeoIBz9OFSUfTckUXMEshfCEHl1JVjKxgT6fWyfEYWjWTClxn3kCfP9D9At?=
 =?us-ascii?Q?RV2i3o/3e4IuaxBWbx7gj5b1X0hdGJAyuhduAgHdAF6Vio5XgCVQOAUGOuf2?=
 =?us-ascii?Q?/17FA/mKBgyQKeT6irUaH7cbWSipZJMfDnf43utLSO4qTWiyX5UhF2u+uzAu?=
 =?us-ascii?Q?YOFL8YPqI8A+JMvax4kXLnzqiJ7d+i8mig1Ot7MCVj9UCgWvzc4qzBALG8OU?=
 =?us-ascii?Q?B+/bwcn5ERZ60lJmXS1FusRggrS1x9HYn/Qrkq1Xi/amJhvLPcSjJouEt/LK?=
 =?us-ascii?Q?hjDEjj5Vnfm/4ZjtQGfCazTDP4n6Qz9sSjOQ0n4yrEWn0nd5gxcgtIOjVLjS?=
 =?us-ascii?Q?FEcrGwR5txNZA4Nvmwhmy3NdGPXjxwxZDOM2NDsO7k8JsqomZFZQ7mWjR9cV?=
 =?us-ascii?Q?T9PJTOC+wqELxGPQSGnXxKDlSVcveLzvc9XDUbwLTD7SsaTAxag8qsxmAwW6?=
 =?us-ascii?Q?xAkfwn4br313tdHu3fEbCJax4j4sN3UNUjX/40pNKvxjcYRR59UXl4ueRihb?=
 =?us-ascii?Q?NaiuonjS41ciUf7/taPpAaojXtDSRqX0lYzR99ee/xwsuev83tGzcWMRvaHJ?=
 =?us-ascii?Q?39+I+TMulwK/STHZGEaOSUYDLVBf6dhZL2xpIBMYNx8QPS0hAMo0nEtMUsPr?=
 =?us-ascii?Q?bD4j4cVyZyaE2kRtbTU8f+SdRCOm3/DpX34aMpaX6WCpDXyutdwhpJ5ECDWx?=
 =?us-ascii?Q?PAZgSYvSjesR7fe7DfFhj2PoSYkSRqmrEH3Q0+KYALT/ZGgGNytMOFFayqGJ?=
 =?us-ascii?Q?BJQ3qHu7JMdAaOgaWIfY0IWNCZ64wF1LgkffMK1rmuTHQVI4dH6aTPy3gb/T?=
 =?us-ascii?Q?MYaTerBlNePp6G1Pj9XskzYiX5smi2AWN5vgysodxE0RI6wiDryTc5bdUuC+?=
 =?us-ascii?Q?vHip/zf0gc44ig2WuIoK9nGQmIyOCmex6E0JSdbDdVPT21HIpPy43L1QSdFL?=
 =?us-ascii?Q?Ow=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	KXEiNCdNdJ0quKPpYW/bgPhG8rFzNBxpaPJJ1/vDRe7RjyTqItmo690sHbFHJM+5xAwR5pIc0Xno+gV06xa/wMzSq6f+N0sNu/hT6rkJC5/RKsKMsAMwul7bYEfjrAeqLN41RkovuvElYFXBbozj2fgF9Q4EOv/vGn8yiGLGdjLywGvBqAeo4uNlax4jZ0PL7PuFdSWbNFWNE1iNLEsiS4afOVcRs6xmd2VHDGyjLE7XyG9amtw6cZoP0OoRfT5yaGCo2QLmfnD6h9MZbfMc66umrbDTiwTyC471SyTli/BRHJy0hq4eiRAzE0kj0Q1NY9gW7Yl7+w0KJADYewywxOSbZT3SyiB0+YGVMwuMJV78++nqmuTFetkgsJC8YmEeBB9w6P484rU1WY50GZLC2OybndNc7qy1xI1lHEFR+hLjaO1ch/Kt/H40+c9sw3otcf2CiHNquqriBGezf3ERpr7mTDwZzpF+YcGcvYkpDjoJplu5NM1W1yvw7wLkbIAn7epnoddmLGGH2EjAlNsytfkkamWWcqHslhLbXFCBmBdkxFGpOKoqK/EVwWoOUdRZ28VOOWSpSe5gE1wBZGiCWRhRxw0YcbD7N7kbwWHwAI4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6eae8154-4292-452c-2873-08dc16d706e7
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4418.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2024 21:06:37.2020
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fvBB3NeFok/zjAGiDiUxfQWRfb1BrFLUUKxjnigVNBIptpgd+U+2jSHcctcLFrcX8jGqE0IrcI7rpP8Zt4I5yw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7261
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-16_12,2024-01-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 phishscore=0
 mlxlogscore=999 suspectscore=0 bulkscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401160166
X-Proofpoint-ORIG-GUID: B5iHWVGiMJzcz8orXyfLMWoFsmopzjYz
X-Proofpoint-GUID: B5iHWVGiMJzcz8orXyfLMWoFsmopzjYz

On Tue, Jan 16, 2024 1:08:20PM +0000, Mark Rutland wrote:
> On Mon, Jan 15, 2024 at 03:39:00PM +0000, Russell King (Oracle) wrote:
> > On Thu, Dec 14, 2023 at 04:05:56PM -0800, Christoph Lameter (Ampere) wrote:
> > > +# Determines the placement of cpumasks.
> > > +#
> > > +# With CPUMASK_OFFSTACK the cpumasks are dynamically allocated.
> > > +# Useful for machines with lots of core because it avoids increasing
> > > +# the size of many of the data structures in the kernel.
> > > +#
> > > +# If this is off then the cpumasks have a static sizes and are
> > > +# embedded within data structures.
> > > +#
> > > +config CPUMASK_OFFSTACK
> > > +	def_bool y
> > > +	depends on NR_CPUS > 256
> > 
> > Should that be ">= 256" ?
> 
> I don't think that ">= 256" makes sense. Note that since the cpumasks are
> arrays of unsigned long, they're chunked into groups of 64 bits:
> 
>     2 to  64 cpus:  1 x unsigned long =>  8 bytes
>    65 to 128 cpus:  2 x unsigned long => 16 bytes
>   129 to 192 cpus:  3 x unsigned long => 24 bytes
>   193 to 256 cpus:  4 x unsigned long => 32 bytes
>   257 to 320 cpus:  5 x unsigned long => 40 bytes
> 
> ... and so if a mask for 256 CPUs is too big to go in the stack, so is any mask
> for 193+ CPUs, and so ">= 256" should be clamped down to ">= 193" or "> 192".
> The boundary should be just after a multiple of 64.
> 
> How did we choose 256 specifically? I note that x86-64 allows 512 CPUs before
> requiring CPUMASK_OFFSTACK, and I see that powerpc selects CPUMASK_OFFSTACK
> when NR_CPUS >= 8192.
> 
> Mark.

The suggestion for >= 256 may have been a zero-index/one-index mixup.

It seems > 256 was chosen as the cutoff simply because it preserves existing behavior.
The patch description seems to imply there was pushback from distro maintainers on just increasing
the default NR_CPUS.

The existing default value of 256 is probably already a strain for smaller ARM systems, to which
x86-64 isn't a reasonable comparison. I'm not sure what the reaction to increasing from 64 to 256
in 2019 was like, but picking a pivot point for CPUMASK_OFFSTACK beyond 256 may skew the balance
even less in favor of smaller ARM systems.

