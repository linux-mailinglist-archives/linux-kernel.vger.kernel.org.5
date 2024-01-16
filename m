Return-Path: <linux-kernel+bounces-28282-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11F7582FC7E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 23:21:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 43D6BB23BB9
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 22:21:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BC1A2C6BC;
	Tue, 16 Jan 2024 21:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="MB4P3yjT";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="b6suSBFd"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E6682C6A4
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 21:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705439245; cv=fail; b=slDjh8E8SZg+zYVJbFLAwjpdk14upLygGV1o//YmQbXNDEs7WHfINkLSKmeRHd6Z2WfQISkEFH7f81miokp9c3bAEAH5k+JOuJg3Di+5aoN3gqgp0itNkH0ru4lreMqMoZrQaWiict4tRfKrKQTjHxgSzu/aaLRRMRqJuz1AvW8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705439245; c=relaxed/simple;
	bh=qyLi/dkEcfjGief+TiYypmEux1/2ncW9p+ocdW1A0hw=;
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
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID; b=D4p3IvjFKU1HbrK5FsM9E0YjcVcTV6YugR3YX9SghU9iGuGO6eoOJEOzaYq+XsL1LaIa+2zyoOoPz6GtJe/xm8k6+XkEUn00r6sBLN1dh8mgjrgkVuDN06NVCkCGsaL0U32Yn0OwaFyDRSTRnJqa1MuNzV1Abatp/WTcBArgAc4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=MB4P3yjT; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=b6suSBFd; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40GKEB9T027002;
	Tue, 16 Jan 2024 21:06:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=+Un/9xB5uZLjk3uN5OQF8nQBNwVstTKF9qD9EMVsJus=;
 b=MB4P3yjTjl0t2EWL82syP4lpQqEblWCKpxzq8LKqn3ndTIoCzAJLrFfpkspVV1Ey5r2s
 T5+16D0piT/IpEv/fi7X1s/GLVJ1Wx4mCgMAgA/dIuY+XiY55bPPbw3bwP9w3enrKhwG
 luFNxVz2A3DVcdtllt1pDaAKZcxPqS26UiFyZsirhHrIiuBfEMsPcs8eO3UIXCLMU37r
 jjC5jZJM7h2oV/2XHMTd0en24rEQx4CuT4WQFBpDYVsXpCNrxUTRchRRCGbjSx7+ms3D
 hWFpEUncYGkpOM5JpT1nOBF4mVw54cIrrZgZTR7sPLiNWSBimfpOOMH6ukDIqT8IhAx0 9Q== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vkqcdwrab-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 Jan 2024 21:06:53 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40GJfrWS020061;
	Tue, 16 Jan 2024 21:06:52 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3vkgy8u4d1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 Jan 2024 21:06:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RsL5Zr2eW5xKlh0sAKX6qATJA72PkHE8PB5RaBdgdKItzuQAklZphQWGdBMxYO6C0pII0ab15MZipOLAsow3HHP/JYc/wiWRMEXQ2FeYDVnhRpcZhY79kcCKDPpzBoiH0fgw7g2n2JqtA2jSm+PEm1+Sd+gNW6vXOxY0+YZqLu+yajqrwTbdO9kM+yzu6pSo9IPZ2seX2C+sJfQfouYQKx2zgw1BJmTO5/q2/3uhCUwTSd6FItQF6JLptQZNUVcFKsJn2xHrEzpdvUO/bEPIqlk0j0i6LT50zOp3H5RRYFF3TjVMl3h1GVmVC5zfaZiFzIAYGiqAv4cjQ22Rctfm/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+Un/9xB5uZLjk3uN5OQF8nQBNwVstTKF9qD9EMVsJus=;
 b=RPWtVFnoS2ta3TNROecRVZf1HdmllcF1DbQzfl5FYEUowAUH9e+aonkx4NY6nMsfsKUrKTda27r7Ap+CuhJLSakZGVDUf0x1juWIaX+r2dq1lAEnHIeX12FDROwgCw6JwaN+mdAvkmsb+9aUMMKxCl3EDymmGFtPfagmaaKK9FG8Gj4bEB1f+VZtY6CP5UGMMCO6WKnoU1Nfrtyy02a7ZzlFZX+5k0JYFbPbz0m1KdJC/8ZdetiJ0f5bcDZf/lY8wwKKq7SK6cgqZSsRDTIjTuEnC7GWhPJaA/pSdE4ZAo6RQVI8WoQ/9ETvPZUR8Wc41mA/pXFeISXUqLtTHZ8q/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+Un/9xB5uZLjk3uN5OQF8nQBNwVstTKF9qD9EMVsJus=;
 b=b6suSBFdKdW3Ph784jcCk+GjxPCs7oqJbKNdWqf3GcT/j5it8pTKxIqLSlDUTjOQ+KKhawkiRX2ZHeh20ByzGgrGrFxA8/84ZPVtccOsBy6Vq20/vYRtUnhiEZOc/ZR6TfohDscoLIliwWgehS/9dnG+xwhIJb4jtRe8x+aY6YA=
Received: from CO1PR10MB4418.namprd10.prod.outlook.com (2603:10b6:303:94::9)
 by IA1PR10MB7261.namprd10.prod.outlook.com (2603:10b6:208:3f6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.21; Tue, 16 Jan
 2024 21:06:48 +0000
Received: from CO1PR10MB4418.namprd10.prod.outlook.com
 ([fe80::bcc5:bbae:8d5e:9b56]) by CO1PR10MB4418.namprd10.prod.outlook.com
 ([fe80::bcc5:bbae:8d5e:9b56%4]) with mapi id 15.20.7181.018; Tue, 16 Jan 2024
 21:06:48 +0000
From: Eric Mackay <eric.mackay@oracle.com>
To: linux@armlinux.org.uk
Cc: Jonathan.Cameron@huawei.com, Matteo.Carlini@arm.com,
        Valentin.Schneider@arm.com, akpm@linux-foundation.org,
        anshuman.khandual@arm.com, catalin.marinas@arm.com, cl@linux.com,
        dave.kleikamp@oracle.com, eric.mackay@oracle.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, robin.murphy@arm.com,
        vanshikonda@os.amperecomputing.com, yang@os.amperecomputing.com
Subject: Re: [PATCH] ARM64: Dynamically allocate cpumasks and increase supported CPUs to 512
Date: Tue, 16 Jan 2024 13:06:44 -0800
Message-Id: <20240116210644.116421-1-eric.mackay@oracle.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <ZaZnYrv/QThRjW2Q@shell.armlinux.org.uk>
References: <ZaZnYrv/QThRjW2Q@shell.armlinux.org.uk>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR10CA0004.namprd10.prod.outlook.com
 (2603:10b6:208:120::17) To CO1PR10MB4418.namprd10.prod.outlook.com
 (2603:10b6:303:94::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4418:EE_|IA1PR10MB7261:EE_
X-MS-Office365-Filtering-Correlation-Id: f1e7d499-4d27-4258-08c5-08dc16d70d8d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	gJr7cLaeaoZ11gR5mHvNUgKxcNdfGvuuiwy633G9vK/1UxGpHuicUM6Vp01OSrsgcAo0ee6ZNC7C3/8llVJaK3lk2azxWH4ZKBhEaQGg1mDrBcjLLXkcoJ+vSND2xMo9riLincEYL3Tk4bCjy0hY6hOk4CEfCvHK3vOGbo+2TNnivV/E+iZgNrUWKmw/h/JopLg3UrcZL3VgXz0uWfct2Dxs14EEp2D8bpe6hcTo5Op/8MuUmTk+3xvagrs5A6u60wEph9cg2yVOpvXRezLLHGUTTItJH5yAe5tiHnt4iA/EENd5sfPXXjYHnU4jXjMkBXMHlGpfRMD4T8uqrHNGoSmppk/3nBKuuW0/0GWZ/o28o2pAHGQv4bU2kXhI7TRfXija0iruU044gyTHPt1E/OQK3n9q/6W2eSVoxtdz6qSvOrpGW5ERWyBTOtiiwtZ1mS/XJp+i7N+apYdpvRwI4KMX/tX99SlaxmD3UWvEUlEHyhgGSzEclM0v88rfmtmY8GYWBTAfkKJorOmTFIrS+QW1JQmIZFJahZ2xskXpvbQ=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4418.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(396003)(376002)(366004)(39860400002)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(83380400001)(66946007)(2616005)(26005)(38100700002)(8676002)(6666004)(4326008)(8936002)(1076003)(66556008)(44832011)(6506007)(41300700001)(966005)(5660300002)(6486002)(478600001)(7416002)(6512007)(316002)(66476007)(2906002)(6916009)(86362001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?SDz4XUKTCO4JWzCEBxu5dKrCgKstchGn/PNPHfDpoUavz3bTkrm+MiloPEJL?=
 =?us-ascii?Q?GYoC7zr/53+C+vRYoh1t5pGUNrxXpesBTOtc0vaZ+y+g/D3HKmx7QMzdQRhr?=
 =?us-ascii?Q?+GH463MS0/CFZuUbGteKhbg0ZgYYw4QFZ3q0099yvvNrk0SfhNdS1KsamiSV?=
 =?us-ascii?Q?/b7CSbBeYpEwHXEq0GH1HR+xHsGHCarhsYsniWM5Ap+T/mmr2rC7ZZ50abvD?=
 =?us-ascii?Q?GWmlhxkt5M/Ah7DI3sSWm+ZiLUXZMcdG49LVVqk/zrTJPuDSAbUzen1Pnwst?=
 =?us-ascii?Q?XICz+ZC2Pz2WSx5N2fBsd6v5LaNZiiU4KXXpZwjFzz24DMjkeWj4ec+kwLf8?=
 =?us-ascii?Q?zF6yrjF1XNXiGXdnAWTLc6jXB8QcoCqDwYph59Z54gctI6j3OSGzV7VGoJYb?=
 =?us-ascii?Q?vtMaGFJT3N59cuaQRIYOIhVhtX8mP8efpYN5NfBDZ1YUT2nj9Msm9fnbrrHP?=
 =?us-ascii?Q?iBkUYcx/GGy4q3fYxHQYKtvrcnyiOHSe4fuwwe/oscj+6Kp47U5vFkq+jTSU?=
 =?us-ascii?Q?Me3f3aS/dWGdU1JijE6jD6/bQKdgkwGIz4DzGiHDTiSsaSllBapWhzRw4++R?=
 =?us-ascii?Q?kzXGthuNYZFLOgdGLpdUZX1rW9q++wQvE2LzntHV5diDRXZjajWdRUOSWnOo?=
 =?us-ascii?Q?pXAJNrb6SAnCXumxg0B9Ip07IsqiOtiJbJdL1MsYPkme6b5eXZpfQS4J+IXJ?=
 =?us-ascii?Q?acG/9jM4/uYdyWksF6fLNpYYOBP+2ejsArtLGA+7vhAlGxsLjAbEd4EZZktT?=
 =?us-ascii?Q?9PwvGTjqp4l4MGJvWcN+6qxORReMaF2AkMYkHrRwnUyBkqsv6nTGzPNHOaPX?=
 =?us-ascii?Q?F/+8pShzi8ocX3m/uVlxohKcBlrjyr8zflcY8ImBJv0nHE7fd56pgrvNgJfn?=
 =?us-ascii?Q?RhgYgN4zDfhMcN5RKT/r529QFgcSoH9R+0OUoyq54VY0tuALnhJxs7El97WM?=
 =?us-ascii?Q?by+ZqrhktdwH4sM4l2K5rTeM0IpGlyBCjV25zX6Iq7fJIgcHXcE3EJ4dK6xX?=
 =?us-ascii?Q?FSQPITHilv+YxVf4FUCYQuhvT/a4W4b6eosBFlOjsJCFkoC0CJvCuCKXG6ce?=
 =?us-ascii?Q?2/iTxwbhCgev6PCIiBansHQjWOfUeF4kwaflfHYc7ZadPMWhIkDX51sInM8I?=
 =?us-ascii?Q?mnGHfWqOAxeM5+OHHsx/yAlVwu+JyriXImffv8wkmvdSdzZUZokDrCFev9+B?=
 =?us-ascii?Q?QT3Z4IoRLola8ZtD1Lj6yuzmkN/HFjGgLxHvZaTQgqZWSexhflA8+NRjylLW?=
 =?us-ascii?Q?Wste4NYwMAI1l6ABH9C+eHCbn1kZ+HzQFc0A+0SY7BTB9I4O5CGiKJpTF3KY?=
 =?us-ascii?Q?y8EYVpgUfW821DPrI0ZFi8uHF2z2F3UXNrqycWgQjJd02x1dvwVc70mFq5ct?=
 =?us-ascii?Q?XJQL4HXX7rVton3YUrCyrlEQUWfWsfUaa5hxSjXX1wuj5YCfIMvYNm2xa+uk?=
 =?us-ascii?Q?MF0cGTMfU981I2SAjzgojBS4CBHRD5amIuFOpcfpe6jVJJJBTo38G6n4IsBr?=
 =?us-ascii?Q?HBVzU8Ko3h/bw3TZW9HZjDoW2Vllj6XAWke3QFpgK/l2mR1Mh+6heB8p9P3v?=
 =?us-ascii?Q?xauu5kTy9aLhOMFe8t/YmdhIY9WrMqjxQEj33geyqcnDyHxI73GCVJ8f6WrN?=
 =?us-ascii?Q?DQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	Yth/4jNOPZupLMHZBtAGSMOk+RLORMCBd5s4vgeiXLPKsIzxUAMBIhrFFQhlCyVul01mTILjjbGx9mIJCnbEFxuv2ZHXhpa/WfFggKivUGtMSG1uAbAaAsHIzwd+qdGDph5CjETLEWjBGGxNGcUy5xyRNzVoOIVUTlAxQMuIydJwpvXzt1CtJRAsZiv2K5/UpFbd4FCV7v/5EI8L/a51tQ42oBu42Zs4ARn7q8NV9hC5+ZeE09fanACzhty4K7hPBlSQ/LUPwESua4lvJ0cLYr5npwMH8+Gbf9RUcbUsHGaOMc02lwmWRcgRPue2M4wUVBu3KHsH3GmF7upL9RXsurpqvy+3Icsg5ZIqKQrgMTvaW63krZdmICQ2fOJJ0f1M8fKEQHrJypIGBYYirYtjRKYd1DBJHkONS6cLjjC+ENJ3NPYIF59p9yWhkxbjJD6um+K6dRae6KuzQqs4EBe8fZi+3OHTn1PCbKqWh85rlvNmjNWmDCoDIn3sgj4RUttUjZyV+ouMMbYJsm/sUNHk6giudsSRoEAcpV1gTfp+48/T9lafL9r2ZptXj/SCLeZ2Kn2BHP5u9lp8hx1PN1Z66Ahr0GYdJ95w7bA5Gkgk5W0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1e7d499-4d27-4258-08c5-08dc16d70d8d
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4418.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2024 21:06:48.2261
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IgoBuHh6hmRL+KHR2NE66XcmuxhCRa+n0GYszZzeJgSA5rds6zJh8DzqKbKknaaS0SdZzgwWVZZ8AQvtsBEkiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7261
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-16_12,2024-01-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=0 bulkscore=0
 spamscore=0 mlxlogscore=999 phishscore=0 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401160166
X-Proofpoint-GUID: LmQcmxhdkejQsFwrhWB57M6Tf-Omq4Ex
X-Proofpoint-ORIG-GUID: LmQcmxhdkejQsFwrhWB57M6Tf-Omq4Ex

On Tue, Jan 16, 2024 11:24:18PM +0000, Russell King (Oracle) wrote:
> On Mon, Jan 15, 2024 at 03:59:11PM -0800, Eric Mackay wrote:
> > Whitespace issues aside, I have applied the patch on top of kernel 6.1.55 and tested on both a dual-socket Ampere Altra machine with < 256 CPUs, and a dual-socket AmpereOne machine with > 256 CPUs. Works as expected, with all CPUs visible and functional.
> > 
> > >   config NR_CPUS
> > >   	int "Maximum number of CPUs (2-4096)"
> > >   	range 2 4096
> > > - 	default "256"
> > > + 	default 512
> > 
> > Nit: the new default value should be in quotation marks, if we want to be pedantic
> 
> I can't find anything that requires the quotes - and as "range" doesn't
> for consistency it seems that default shouldn't either. There's nothing
> in the documentation that indicates quotes should be used, and looking
> at the code, it's just treated as a string. The only thing that quotes
> seem to do is to ensure that whitespace will be included.
> 
> -- 
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

Ack. I withdraw my nit.

