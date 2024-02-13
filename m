Return-Path: <linux-kernel+bounces-62976-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C14E85287C
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 07:02:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 858131F220EE
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 06:02:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C52EB2BB0C;
	Tue, 13 Feb 2024 05:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="KAzrDiPL";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="BMcJod57"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 028B8286B3
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 05:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707803841; cv=fail; b=P4C/81GbDGTj2zP+5HpZrzWjJnlTQP2ijgjNpWxnw/LcccZ6sx1MAyIqvfvBFQAmE9jtWhAjveOPEBE48lRL1hiGlgq/k6vVw+fkm90/zqp07JQvO0TzSmAFY+nOhfK99sk3rOE+CshTwFzJ97p/HBjVYqGB1oSlgZe8c2rXqfs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707803841; c=relaxed/simple;
	bh=a7f2TJ02TLEo6PvKYzByepJ/+WZwJxpPpbEWeVWUJto=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EwiAyOR+mc6bMaaZ9UvKfK2e03l0Kx1xlRZIZ1Gw8AKRsBltyvThItjKM/JOblSo1iBDzUMecaSwLyMn5ghnlt+COrLc2hPLAgahJMVUp3hOFDlBl/ewJDySTTa2lOsUQwjMHvz/fbvfFAAsIFlU6c3qxQmh6P014S+Z7Fz64ww=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=KAzrDiPL; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=BMcJod57; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41D5U7DI004760;
	Tue, 13 Feb 2024 05:56:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=pP0wdiV3fIR9BWpzqWZ/WT1vd1nOf9518eTuA0ndXxQ=;
 b=KAzrDiPLH1ZruqvlqVqix+k3Ka9Gvn43KFsl+hHOc2vKdNKqVs5LU7x23JfGwvw305JU
 m57HD8NEw62dNOd9fyu4qTkhT07UHUGHpRj5592q5398uKHSExVf1mr9XxaH/NSoNq9P
 FlXBDtV4+wZ6EtEedAfo+eFeIaSfqzId9FazPQlyuU3K+c6h2jBzwBpAlDz/eDQo3HDc
 GBFYn3Tk9HVDYd851ZKXdFKPHfa2bcBgaApjTgYbi4Bys9Y/o1gBlNnOMghbmTENf65h
 hcvY5O+dJs3eYJn3z/u6k0GMEbTRdTQ8R97zqUQk4WRwGcGcea0aUq36YADLZfVmA3/G Dg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w82atr1rj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Feb 2024 05:56:25 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41D3YlWH015085;
	Tue, 13 Feb 2024 05:56:24 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3w5yk6k8jp-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Feb 2024 05:56:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C5nIbkRQNyU3ftg74LzZRIFFikCvIlguuA313o/nTP2tRc+kM3PSok0GHvIaeQfBkQR+vGmuGJOOMccemr/az7Th2++KMomAwoQ6P0kKLX8gODcy8VRfAagYfLvhnWzobKGjXERE2D+znea8DcL2QxWi2CUUQVWgd1bnMUqenmpssU8rq6vgL5dSSIKg+ZTtNLD083pdIqbGS14Y3lgIBPcul6ZxFw+vViHQxWImO0CtAuEbkzLw5LtGsTF3BJtacAdcFYH8p0eNgrdxFGlj9th0mT1uafdNnaqPyyJzktSf4bBK+f69cxXIJAA+YWAfSh4Apsvni0e/NK4wvbxg2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pP0wdiV3fIR9BWpzqWZ/WT1vd1nOf9518eTuA0ndXxQ=;
 b=RxaPa7c/ni9k718RuqzcGaN46sViMNI4SRTPJZB+aC0ze1q4szU5SMO8i1oXP6sKy0kY6GWFjMhZXg019KY6Mp4vWtJRUzaPj1Csf+Wmq9qeXMfJ+8cb75RGfcKMEoVblh0qkP62WlcjM2US8D3IgHuD3jiQDpjhur9emS5gF3MlZhPTbXxwmLRAkmDMpdP+6N6DiJR0Fn+AkFJTS8oxyoA94dRomjLP1hUQv7cnoOGcgQX1l4WGhZ/+mtM4Y6JC1nJ4Yy+67pAWQlQpTta5wFCpJzT+IFwZuY8EY/tfUKFmp0Q6IBbnAQGC3S6WKoJwAMZcIz/nMN0QzZleeWvpRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pP0wdiV3fIR9BWpzqWZ/WT1vd1nOf9518eTuA0ndXxQ=;
 b=BMcJod57cdDu6dX0fYiMVFxXB3kceWjMqOtZLTCCTO0bjQcjTjscCS7lvp/4296AdVeV2jNGr6IuEkLeZbY+NGH0scjj/0YPCSrPWZ6jfhfae9wNsWL5nzpJWIpTgpqqEMKZ0b71CJJse+/h4V7N77V44Fd1OgUO0EDyY4Y20L8=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by CY8PR10MB6906.namprd10.prod.outlook.com (2603:10b6:930:85::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.39; Tue, 13 Feb
 2024 05:56:22 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::91b3:fd53:a6ee:8685]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::91b3:fd53:a6ee:8685%4]) with mapi id 15.20.7270.036; Tue, 13 Feb 2024
 05:56:21 +0000
From: Ankur Arora <ankur.a.arora@oracle.com>
To: linux-kernel@vger.kernel.org
Cc: tglx@linutronix.de, peterz@infradead.org, torvalds@linux-foundation.org,
        paulmck@kernel.org, akpm@linux-foundation.org, luto@kernel.org,
        bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
        mingo@redhat.com, juri.lelli@redhat.com, vincent.guittot@linaro.org,
        willy@infradead.org, mgorman@suse.de, jpoimboe@kernel.org,
        mark.rutland@arm.com, jgross@suse.com, andrew.cooper3@citrix.com,
        bristot@kernel.org, mathieu.desnoyers@efficios.com,
        geert@linux-m68k.org, glaubitz@physik.fu-berlin.de,
        anton.ivanov@cambridgegreys.com, mattst88@gmail.com,
        krypton@ulrich-teichert.org, rostedt@goodmis.org,
        David.Laight@ACULAB.COM, richard@nod.at, mjguzik@gmail.com,
        jon.grimm@amd.com, bharata@amd.com, raghavendra.kt@amd.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        Ankur Arora <ankur.a.arora@oracle.com>
Subject: [PATCH 16/30] rcu: force context-switch for PREEMPT_RCU=n, PREEMPT_COUNT=y
Date: Mon, 12 Feb 2024 21:55:40 -0800
Message-Id: <20240213055554.1802415-17-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240213055554.1802415-1-ankur.a.arora@oracle.com>
References: <20240213055554.1802415-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0231.namprd03.prod.outlook.com
 (2603:10b6:303:b9::26) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|CY8PR10MB6906:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ef417ca-7dab-499b-404f-08dc2c588132
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	V1ZJC/eCjNaZnnp64tXdvAf1ckz7Z6aCRfxm2pE8YmzRxXEPV33CumUgKRS9ihRjV7soYbScOp3PMT8WMs2MSDKvLLZUc3Qb3FPzEJyIwQjBjzr7Q0Ajavq/rYzuWvpEtY8hTw4HQ4DlDWjAVAH386U5Di4u6+ibC6pws/qwKrYU818i0wn9yXAKXJhGeXP24XOFBQCa1KTLayk8K6I4n6+Z9cXctEKPlC3IFBxXLpge/UrjlmZ+eis0CzkolrsvNrvkD14susGSKWbbRA5Z5WwQRECOqKIXaxSpPD40AXE4l/53/Zi1TGCZAKTeyfCRikv+oXPa39Jtis0sqGbYmywf5GHAqp1Ha0Do0wTT3hbbhc4XjbJDMk35uSBUuJVrsE+FeIns0R17j7Gf8M3w+6H90cWMG5sip14V9cI6AhH+epNMOhkdBUlNIqoV5G8Yh1b01oagX07y1wgnYGM5ZtAgKXWHPWz8ORazM7cblnjq/BppturFS9ukQYUs3X6X4HYAVSUBvQPbW/lBqXEmz8ugacZnC/OJZZ2F0l+1Mq7UJ2npw1Jeac9C8eyS7IBy
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(366004)(346002)(136003)(396003)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(2906002)(5660300002)(66476007)(66556008)(66946007)(8936002)(8676002)(7416002)(7406005)(6916009)(4326008)(86362001)(41300700001)(1076003)(26005)(107886003)(2616005)(36756003)(83380400001)(6666004)(316002)(6506007)(6486002)(6512007)(103116003)(478600001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?o32WEnGmqiNCucWx2jXVFtl2292qdfDEM73CT4EHxea9Iu8ksn+DUPFSMU+5?=
 =?us-ascii?Q?kpn1zQycYfGf3ld++J3H/0TdDjlATB5czS8pK3Yb+lf1kJgqOITzHnusq9BH?=
 =?us-ascii?Q?a2Mq3oX9chEW8TPB4joB3A9lkP1eitMqN7YonYyQO0rmvnAdLhnWijqsEACm?=
 =?us-ascii?Q?M1mt0Sq2CBxdMo7b8A25Lm5qTgFOsplXUk+OxX2TQ70n3rBpCJcozN8JQaVA?=
 =?us-ascii?Q?xV0H0utU6s96CjtX3drvkkwSEING/GYI6Ve9D9jFrjVtwvOFtPYtOJCvQeaS?=
 =?us-ascii?Q?NSRxMPcPX1NIq+9LbVUE80ALkMO+GQkHJQBmoh0oxCVVElyCUtZMGXV8U11A?=
 =?us-ascii?Q?6OTHOp15mkxeQZjT6DCWp92laGYY+HiWaR+UdE8dbGK1wmTktOgsM+Wgejiz?=
 =?us-ascii?Q?zcT6XPKLwAjn2fcB7FqaQiw3Uzij98HLvQ+yFiVwrIEi1NKD9w+MXMwnwtgx?=
 =?us-ascii?Q?g6ymzcnLnXx+wS9me+GOjHUaoRJ7tl1q9E8RY2wXtrjaZgaJiHD7jOvYnt4e?=
 =?us-ascii?Q?Eg+b0Jw3NZSqhUgxLceyR2YQFsDADilnj87VqGcv/4u60bDPIjjcvQdA0UDM?=
 =?us-ascii?Q?DQUxs2X2cW2BQb+J+BGnrb6IVDepiPvsWxICsTtAxTNFq8S17DHzF9gAmay+?=
 =?us-ascii?Q?YldyWrKvBHvcpj3H1qcfaiVjlBcqv+YTbJ8+3ec+VN+6T+lMC/CcCNOHACuH?=
 =?us-ascii?Q?TppCwBWIBPhF8HNTejn2wD07yvCCH2qBzneMkYcDa+WKMfdkjKdrnN3A/dHj?=
 =?us-ascii?Q?YSmDg1n8lQj34W2RsZsb10itE+4c0/aedoGWCxFUKbop6oJAy3YOd9jLbSTb?=
 =?us-ascii?Q?kDVcom7wzyVpeJltSrb8D10diBmJzdSaABLYfiXrLKwbD3huVYu0PjYiQ6JN?=
 =?us-ascii?Q?3AqESwLb9UbzAKa0wdf0YTXhQsvD0U/X4+PM449r1zw+9CEW7dkHJCJeDLZA?=
 =?us-ascii?Q?uUZe/NZ3MizPR7vkowcx4O+TiLr2FVRJ6aLRjHy82l2KZeTj9J1tcZyzuy4+?=
 =?us-ascii?Q?8CngzsHa/vSn5HY6k2KKAv9zP0hBs+pCDY1M+bZHrxSiwbBynVv3P9SzkJdO?=
 =?us-ascii?Q?8a3RcFTlDeJQcwIcaI7T//tH+zDkKQiZqg4xr6LGNlnFA253P7SZAmceWPQM?=
 =?us-ascii?Q?sKy7iky+K4rIniRyebGuNvQE5gaB3BMPkWZBh5sMLhwUqW8JjMM5pSFGemGE?=
 =?us-ascii?Q?0xNBMwjcRTAJht9JQx0uX2za60YwMfBon4n8T2vaoIFKyekXHcQw8opaZbUt?=
 =?us-ascii?Q?enxeTmLQUVuTtQX9OMXO+cVN5CAXtGhK3B2OcF5Iw4kzlwtzIn0yvYp+ruB2?=
 =?us-ascii?Q?7s2h8bpcCTa+d8Xh0owV0kXybrfmGWaU08wvGgTHbmS2Z3+ad9xEFw2qSJvI?=
 =?us-ascii?Q?40PscFHnZT/7pMp5pCJGKZfctvd0Z7l3PJ4TX1BgNckjeXHdmxSt8EKLz+aK?=
 =?us-ascii?Q?f0sgKA9lBGEjoW3qrRCuoMj/w7yVQEMGgerDX8zcf8bwaD7reeQNjTIcNEkE?=
 =?us-ascii?Q?NbXB6enbQyeTK3EwiqXymFSCeWg0skB0pPljspKov7rYB0kKM4dndvSkeElb?=
 =?us-ascii?Q?7mw5hUmxZxh8PVv6D5yXm6Y3mDS0N/l67hEH1sXPGG6aG0nrWiTxMMhGjNCb?=
 =?us-ascii?Q?ZQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	CXbT5kgumPGx+0kZIUFd0cn4TA6/9PqgBkzLGhumucgzMKapmTAZIPofIW4WrAenFPB65ORA/vd/k3f1CjCFmdGJogTZiE4NsfxehjU9YX1KAKjS8adRDzHAzlCqru3+hRn1EauFq+zn16eEoMOh/onV89BcDD8ctXp0+INrQZUk6HzB44MYqqaw+qtvAC439P/2znjlbDpdmd3l3xj7L92NluVNbLZod5ERKFsGagc6R/hRRd8SbiLsCNw7glK2I1haaTVnvx4BneuhsCKUBp7kF/vSarG1HNGODSUAzSiDlz/Vc0ypCoBaYX9FTG3x2NtHKiyw0CrGGmd6gLI26vBpnrJzAisppiJ8T8uJKAhXfV3iIienJR/j1gZXLsyGvOeogKtCXv14ezYR6tDrvgaIBLHm5iuMmUZ92CaPu1q+0zxVI9ihP1U8hElC8jCDTbMtIq3F69LzfKZ7wa9p995BjzdiwQJ1r73PYXKBQAFrTWgFFaQCKjsChoKozs8IHigMWLCUWOSMWJHh5bP0FGe3G1KBtUi6elAob5rTejh6QIiZOjxoqps+7OtfTXTdM7ZR/0ksp9pBawrdwnGogMdasVnZHiAW39scCORl4tc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ef417ca-7dab-499b-404f-08dc2c588132
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2024 05:56:21.7522
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /AanC6tZ1iM/77zGaUMrVMvaQJ1gFNNEaGTQ7l2ilqajE4LKLYNvsq8kGqk847V6AKCUxrWMRNl7cWV/MiKpq3I4WuOaOeBETXiQvoIAMXk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6906
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-13_02,2024-02-12_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0
 mlxlogscore=869 bulkscore=0 phishscore=0 mlxscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402130043
X-Proofpoint-GUID: OOuDlOiIhYaTyzydUUHdPAsdvzDIVCcl
X-Proofpoint-ORIG-GUID: OOuDlOiIhYaTyzydUUHdPAsdvzDIVCcl

With (PREEMPT_RCU=n, PREEMPT_COUNT=y), rcu_flavor_sched_clock_irq()
registers urgently needed quiescent states when preempt_count() is
available and no task or softirq is in a non-preemptible section.

This, however, does nothing for long running loops where preemption
is only temporarily enabled, since the tick is unlikely to neatly fall
in the preemptible() section.

Handle that by forcing a context-switch when we require a quiescent
state urgently but are holding a preempt_count().

Cc: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 kernel/rcu/tree.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index d6ac2b703a6d..5f61e7e0f16c 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2248,8 +2248,17 @@ void rcu_sched_clock_irq(int user)
 	raw_cpu_inc(rcu_data.ticks_this_gp);
 	/* The load-acquire pairs with the store-release setting to true. */
 	if (smp_load_acquire(this_cpu_ptr(&rcu_data.rcu_urgent_qs))) {
-		/* Idle and userspace execution already are quiescent states. */
-		if (!rcu_is_cpu_rrupt_from_idle() && !user) {
+		/*
+		 * Idle and userspace execution already are quiescent states.
+		 * If, however, we came here from a nested interrupt in the
+		 * kernel, or if we have PREEMPT_RCU=n but are holding a
+		 * preempt_count() (say, with CONFIG_PREEMPT_AUTO=y), then
+		 * force a context switch.
+		 */
+		if ((!rcu_is_cpu_rrupt_from_idle() && !user) ||
+		     ((!IS_ENABLED(CONFIG_PREEMPT_RCU) &&
+		       IS_ENABLED(CONFIG_PREEMPT_COUNT)) &&
+		     (preempt_count() & (PREEMPT_MASK | SOFTIRQ_MASK)))) {
 			set_tsk_need_resched(current, NR_now);
 			set_preempt_need_resched();
 		}
-- 
2.31.1


