Return-Path: <linux-kernel+bounces-96500-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01DB6875D1C
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 05:23:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA266282948
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 04:23:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A24602C861;
	Fri,  8 Mar 2024 04:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kG6azDrU";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="TPnFfUNh"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C55732C1A6
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 04:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709871802; cv=fail; b=N9hH2mx8dyiJLZv0o/nRe5IMFhE7ilRnk4rHZJZCEEjdi+Xo7Iw+60+UkcJRzEOmi3BGhaNADN3oWyXlTGyTiBU3v8lLrrhO8XUBHg8+Ic8oGIE9v5AwGQQMhFHIDpV3SRNAeZW+9z/9gzMk2jxGVkM+Vd6OXLOkn8pL6qTY+gU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709871802; c=relaxed/simple;
	bh=wD4s+XFOoQVbP/fWkBTVvtFiGEK6TsJuNY2OtAjXJ9E=;
	h=References:From:To:Cc:Subject:In-reply-to:Date:Message-ID:
	 Content-Type:MIME-Version; b=JJ+L6uFEd/PVKrxJqY8xnm97eOudDFRqNKORYU0Q9q9S71UNkZYz0qZupmdVWOrfMtG8qXTCGsbQ6FQXrzyJSNenPcDKP+zXZUfUuWXrkFuQxje9yoHA7nZhqrM17Vw6Lyly4mD6HmF7sZnQT9MsIXBDu+6/hfM39CgL3lEsNU4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=kG6azDrU; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=TPnFfUNh; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4281j5aT009687;
	Fri, 8 Mar 2024 04:22:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=references : from :
 to : cc : subject : in-reply-to : date : message-id : content-type :
 mime-version; s=corp-2023-11-20;
 bh=YeCv0Ha58Vfct+xarWv1DEjLy9KMq4SrveW0oFW18/0=;
 b=kG6azDrUQNdKONLXvJIN77MDcf+SdCQPPBvOmFea88ROOQIvsZ+M55pZYzUM81Yht5Ug
 j7+GRkt8RBU2oR0I9MsGdfNfzT76+zexIIpXiPNkBlsqhaPaX6zTKAp/MhhoTWPT2svg
 hgycBJbx/VSnkAUkc/OTwS7/loWsc1HSXOCQJf35wa3Xe1wxiztqkq0LseJLJbfuZNz0
 Lm31RjxzJbLS3+0GqMU+NkJMdb9MPIG2Uh7YVTtBdEERcnTEpq4xHaYA2V2khQI1eog4
 bsS1Wbys7csjcqHquLZtZS6BHD5dCFb5IeZtDbMs/9O9784kj0SH195qN90eBn7gFoxC 9A== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wkv5dp36c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 08 Mar 2024 04:22:07 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 4281PT18013856;
	Fri, 8 Mar 2024 04:22:06 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2168.outbound.protection.outlook.com [104.47.73.168])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3wktjby8m1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 08 Mar 2024 04:22:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DM3ZaznrD+ms+cW73QZiPyl0LrqvrI3Ha2fodn0xOJE4R70Z1uDQp1r7Oj1o34XvgaWWvjywX8/Z2loLVGS028Kceoh5rLjP9HdNWpq79pBVXIfZnvzTZNr2SdG+zj1FVAcsSKjhC/6idYlt/OR7jQJPM+QCJ3On6ueJXzORZkNEBRTkaJMYMY7ix36Qd/L7ixSaxnJUi2k8BfLAFedLrXqwSl84t6rnhRFqBMpQrXCFbBQKZHh7o/IkYrBFRVp2rg3I92FTcRovP42xrrOApktkoOSK5wqDCeGhBWvOrFv27Bfm8lFG/mzL1ymobrfpvhwAH7dZdPoEu5kt8Tjavg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YeCv0Ha58Vfct+xarWv1DEjLy9KMq4SrveW0oFW18/0=;
 b=iEXg2hUhETbI7GK9Ex7D7IppbRzKFn6L5O3kVtjMjsrTkUXIskRMIrznDXr5V4IPTmSp1dl7r3pe018/B4S8icOS9emzjtAkJDguECM7TB65zOLgQQFPnJFHp6ZWY2DdnhoK2toLi8Cj1Z3cFLCoJ04E6gFWRHVRdOQw0q3yWBqU+MKgGiHO/whPZExYOc1hp5J6vxWuHxdkbviSxrPCWijKLGeY3LzZjnjKX9SqvtRJYuLxNR1EtFennPWFEyNO+OZNx2GOsqjnn8YxbLsW6CxLfLJwhZGGD/MmCB/QtSHdrz2mn6+RsDkb/3GMbR4mER75Zg6BuRvPsQr+yq3AWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YeCv0Ha58Vfct+xarWv1DEjLy9KMq4SrveW0oFW18/0=;
 b=TPnFfUNhwmCP8zon+KuV9f/xJqvoT5Q8jr4mRHQsaZSzOZEUa5CjpJbW4WSSgELbW7B1p7dnOT7yt2GujRmaa+DFWG381L0FDpwFCbK4nQMm//Z7djrZBYEeKNOkAZOyhCvFHVHfzXpWhs1wWiFfzelnmRrmI7VVm/3dJYCdcCA=
Received: from SJ0PR10MB5421.namprd10.prod.outlook.com (2603:10b6:a03:304::10)
 by SA1PR10MB6416.namprd10.prod.outlook.com (2603:10b6:806:25b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.28; Fri, 8 Mar
 2024 04:22:01 +0000
Received: from SJ0PR10MB5421.namprd10.prod.outlook.com
 ([fe80::2c09:4a0b:dbd3:b6cf]) by SJ0PR10MB5421.namprd10.prod.outlook.com
 ([fe80::2c09:4a0b:dbd3:b6cf%7]) with mapi id 15.20.7339.035; Fri, 8 Mar 2024
 04:22:01 +0000
References: <20240213055554.1802415-1-ankur.a.arora@oracle.com>
 <20240213055554.1802415-27-ankur.a.arora@oracle.com>
 <65e3cd87.050a0220.bc052.7a29@mx.google.com> <87frx514jz.fsf@oracle.com>
 <12a20651-5429-43df-88d7-9d01ff6212c6@joelfernandes.org>
 <63380f0a-329c-43df-8e6c-4818de5eb371@paulmck-laptop>
 <d956c2e9-492d-4559-b9f9-400f37f523bf@joelfernandes.org>
 <6054a8e0-eb95-45a3-9901-fe2a31b6fe4e@paulmck-laptop>
User-agent: mu4e 1.4.10; emacs 27.2
From: Ankur Arora <ankur.a.arora@oracle.com>
To: paulmck@kernel.org
Cc: Joel Fernandes <joel@joelfernandes.org>,
        Ankur Arora
 <ankur.a.arora@oracle.com>, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, peterz@infradead.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        luto@kernel.org, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, willy@infradead.org, mgorman@suse.de,
        jpoimboe@kernel.org, mark.rutland@arm.com, jgross@suse.com,
        andrew.cooper3@citrix.com, bristot@kernel.org,
        mathieu.desnoyers@efficios.com, geert@linux-m68k.org,
        glaubitz@physik.fu-berlin.de, anton.ivanov@cambridgegreys.com,
        mattst88@gmail.com, krypton@ulrich-teichert.org, rostedt@goodmis.org,
        David.Laight@aculab.com, richard@nod.at, mjguzik@gmail.com,
        jon.grimm@amd.com, bharata@amd.com, raghavendra.kt@amd.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com
Subject: Re: [PATCH 26/30] sched: handle preempt=voluntary under PREEMPT_AUTO
In-reply-to: <6054a8e0-eb95-45a3-9901-fe2a31b6fe4e@paulmck-laptop>
Date: Thu, 07 Mar 2024 20:22:30 -0800
Message-ID: <87plw5pd2x.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0002.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::7) To SJ0PR10MB5421.namprd10.prod.outlook.com
 (2603:10b6:a03:304::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5421:EE_|SA1PR10MB6416:EE_
X-MS-Office365-Filtering-Correlation-Id: ae364c0b-ca5d-4b37-8ee4-08dc3f274d13
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	3ZiLPGXyB2FSERTBa5tqTx5ovlSAx/5bxwaaH/WCdF4nXB9fW15CwQEIw9t72kdxP/HzjFqQ4n0JAUYleeke/ar4/j/PA1pil1eXQb/t1TakAsuhnGiWO4o0hHUUrx/J16eoajIR+JlI1DEtsqhRXFtZ3huGhJQlqIK3dNqjAddsMdijyP/7Ml478ofzu/OjDo2HH2lTeroJqCov4TvsfkQ52W5S2pG5eWKRYmEudUrwrI7lBgCPOBQ9zy8HSG1SrYQ0KmIAtQ1aCT4Ti8TJE8jgEd21xAy2ivhnmxBM18V7xzGkrlLnfLeHjwUo0wRyB9SlEVSa3R5jEZTlG+0cCmlRSn+OQtHF68YK9pjO64rcwwNAVpXtPZcIsoNyE/8Mv6MORnmqkvGtqTOfHXpfTV2meVTRAYzS3fsVZOYIjkZRuFsHwdNF2mu87FdpYcdIiecMnEM4g7er9Z9UPCIOf010sKqACY/lAGH9ifK2sypOphtvl5reVRcMbhePEuFDD48jnHNx6OanMaQG/WfSQ3O8aIDZvIgkPxD6TPnALw15DAT0w1z5NnL0kRNMPYTXNBdmS+UtXvHj0Pzkwojw9X8sOQUHvEyIXcs5Mak/EtGIp0uIWnnSE6IrYfa/SKdGtjr0xgMrTtUo8zCBbx4WKiC19kMth4wO8mqZpDeFjkU=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5421.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?LBBIhcgzdxcquX28T65DP9YH2fhoD7ziuW2wqtNYzVfu+wHfOP3I9CNg8oeu?=
 =?us-ascii?Q?MIzxcR+GH8N7box7eGuXchOL3U5AotXR5+NCnBoFk4UQLJ+fyMXh9n4T+pQ+?=
 =?us-ascii?Q?wrLVAP/pkMaZLd94SIXwdMEpv43NHnaeGRyO1S9mJKNudYSCHTPf1Nl6U6Lp?=
 =?us-ascii?Q?r5+DTNplKhUBix3Uh1mIG0rIWU7zwoyScoTK7dkY7CmBgNr0eVbDIwddRNAP?=
 =?us-ascii?Q?UlEcPMSM+4ScR96y004SpBpv2YafwDCf4Nj1wNMnq8FogwGsrzQ3SB/qfUbm?=
 =?us-ascii?Q?qiTLLdPtA2rL8d1I9koqSSNAAF/BhmSfFZaplxImCN7eCNGlDWsvbBQuaj/1?=
 =?us-ascii?Q?cLDiT9XlhpB9WXvBlFFUUZ7yWfQZdFPcn8zjtllI2S9cPcJi4xVFfWcxU382?=
 =?us-ascii?Q?I0ZKukMl7B0wn1J79c5tXwTDec/ZsKxZx+uCN7rvfBijLf7F31xqBHFo/BQ0?=
 =?us-ascii?Q?0KIE0M0JwXBi/0LjdTojWEgAyMr41qCPod9uQagQJBxfcC1R+UqWYrwiEPFb?=
 =?us-ascii?Q?4R4/2twRTVqdMLwRVJ876xhgZ2WScN+5Lk7aTw60+onqqmC/EE3kFxgVHXS7?=
 =?us-ascii?Q?yY45QUEZLDUVwO/QEkzidpUL+ZgR5mFRFpLeHHe37nYTr0TkzUeLjSJn+Ogz?=
 =?us-ascii?Q?QihN2l9n444knSN6dhB3ffWbW01ip665UV2dJPk2rM48BWbnZGxYB1adrh9v?=
 =?us-ascii?Q?KYjeR/89y+tfSLltzpaInnjjq5T8mV6EAxWePTz0iV4xhYhQDLEXhyfuSifl?=
 =?us-ascii?Q?DB+84rlq116L0SxJ/sMHTeUXwqEbFIeUNC7WvmsDr/Y9Aklbo+nsPyw0vI1U?=
 =?us-ascii?Q?oezLtUMRD28ZqihrZHR2Awzsd7JxpOrxAay5sZHxO3IgAEdkqG+KnThBC81J?=
 =?us-ascii?Q?GVh0fzZURD7efCt4fczamkm12g6ojl/atykiksnxunqbnD5+YLzxXP4h+3Ww?=
 =?us-ascii?Q?EUwrJ63WUNGo0QJ+eyCoMt73WD1ApLdJroEtTVJ54QIJEubAy1F9cq1LqG7w?=
 =?us-ascii?Q?3Yk+XdaLWjkIT3zLSJcykFUI729HgxljQ6o/9dToxrkE7yKZFRGY0e5yYpVQ?=
 =?us-ascii?Q?3RPei0/diE7uCvtK4x4NI52doA13eilaFYAbpzqIr3eEcl9NKftzie0qLEzq?=
 =?us-ascii?Q?NeNG2OKKnWX0M95VOE3amAcb7T5XefoRILpHPJ2Z38MAio64ouAl/xrD6YXs?=
 =?us-ascii?Q?iCMnWBKMxDrWh3eAgm2p5HWat/3FmiupK2GTCim74wEOSZpKxhjmmLpZ+k0U?=
 =?us-ascii?Q?axFhqOdv6jLvquUn0Wy+ENJ/3iwl5SbYE8QxBQ9YzKmpKPmbYESzK0nIoEjo?=
 =?us-ascii?Q?xvh3Aws8I/fXUVN1makzhw6JqLHigp8gxjUZRIyZf5a3TREpw3cSMstzUOc3?=
 =?us-ascii?Q?SUEoSZGi2o34nlAVkBoCwc4Y3sS1Sjm1jtXz7uF626I4Px/zdh6gz0arSUuG?=
 =?us-ascii?Q?5DeMst94jZlFKifLmBdjslIpq8tOlHUB3kHWhAbxYdAhUZon+pv3KXSR/e5w?=
 =?us-ascii?Q?C/QLgLjxo/wA2+iigAd5dUsoZ0PBNJ8BZgLSVMWO814BFWDAL39NKvycbJZ4?=
 =?us-ascii?Q?rEXvBv8sHmXPOl51347zb1ANO4GBGbqGC990QeNA?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	L5pUSUrWUhldTJmM6mvvMJffJwWda0qzNpBJf9T1LoiVMTjUhS+bnpEQk0DcCQzotORIwP0dVnbVTijVWu+3Jl/5iamEW8SQHoAjM7FhMegWOn0wJwWQ7Wq9AsHa1ADaG/7qckWNX8U4Nqv6dKf6WtiwcDguh6GnXo+vRdDs/OcdKNvUsQljvff6zSija3OmaEBzbb7iFukAWObGT4IPA67St/h9zXxuhdrW4D+Gk4JhxAeZyGSaNRAYy4bys4NMoc12JqIYZGkyi703JyeouYK7Ul+jccgDb7P7lCm5vhtxdE4so4uhDH0XKrMcNlecW5I10bCdpxAJDiQ4gn6cmhkCqY0EprBHKh/Zic2qF9NR+QsbigqutVkYf/9THepIHNta+5uL1JZEBciWnPBwzLmXy1wNhFx5o5ng9Jfm63rUY487Et2VCrB5vYyzus4TP3zIlz0MspgZi4f1tSjcf7hh+eycJShYJSnDj4IJVPpa/JHBVioQVpdE3ICKY65svl/rrJE4pBWJ4imtYrN4UAOqL6K1Wy1yvHUxGJ5wSoovcZslG4rJ0sMgh95/l9g4k1YoW1NytRabzlJEnLwNiVqovc+IoI1w3zyWl57gvCc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae364c0b-ca5d-4b37-8ee4-08dc3f274d13
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5421.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2024 04:22:01.1173
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B8jFaWITCu6SEY4bkWqZIMlei5KDm36jM2GGyqeJkzpWNasJ5bfOFoh8G6HJuMwB1Z4PHEBwAr7XGIHRMk6Byav8zCHZAhN/UOIxrFPTjdQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6416
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-08_02,2024-03-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0 mlxscore=0
 spamscore=0 phishscore=0 suspectscore=0 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2403080031
X-Proofpoint-GUID: a5Tr--H8FfEynV2x7rYgHfqHVq1cITP2
X-Proofpoint-ORIG-GUID: a5Tr--H8FfEynV2x7rYgHfqHVq1cITP2


Paul E. McKenney <paulmck@kernel.org> writes:

> On Thu, Mar 07, 2024 at 07:15:35PM -0500, Joel Fernandes wrote:
>>
>>
>> On 3/7/2024 2:01 PM, Paul E. McKenney wrote:
>> > On Wed, Mar 06, 2024 at 03:42:10PM -0500, Joel Fernandes wrote:
>> >> Hi Ankur,
>> >>
>> >> On 3/5/2024 3:11 AM, Ankur Arora wrote:
>> >>>
>> >>> Joel Fernandes <joel@joelfernandes.org> writes:
>> >>>
>> >> [..]
>> >>>> IMO, just kill 'voluntary' if PREEMPT_AUTO is enabled. There is no
>> >>>> 'voluntary' business because
>> >>>> 1. The behavior vs =none is to allow higher scheduling class to preempt, it
>> >>>> is not about the old voluntary.
>> >>>
>> >>> What do you think about folding the higher scheduling class preemption logic
>> >>> into preempt=none? As Juri pointed out, prioritization of at least the leftmost
>> >>> deadline task needs to be done for correctness.
>> >>>
>> >>> (That'll get rid of the current preempt=voluntary model, at least until
>> >>> there's a separate use for it.)
>> >>
>> >> Yes I am all in support for that. Its less confusing for the user as well, and
>> >> scheduling higher priority class at the next tick for preempt=none sounds good
>> >> to me. That is still an improvement for folks using SCHED_DEADLINE for whatever
>> >> reason, with a vanilla CONFIG_PREEMPT_NONE=y kernel. :-P. If we want a new mode
>> >> that is more aggressive, it could be added in the future.
>> >
>> > This would be something that happens only after removing cond_resched()
>> > might_sleep() functionality from might_sleep(), correct?
>>
>> Firstly, Maybe I misunderstood Ankur completely. Re-reading his comments above,
>> he seems to be suggesting preempting instantly for higher scheduling CLASSES
>> even for preempt=none mode, without having to wait till the next
>> scheduling-clock interrupt. Not sure if that makes sense to me, I was asking not
>> to treat "higher class" any differently than "higher priority" for preempt=none.
>>
>> And if SCHED_DEADLINE has a problem with that, then it already happens so with
>> CONFIG_PREEMPT_NONE=y kernels, so no need special treatment for higher class any
>> more than the treatment given to higher priority within same class. Ankur/Juri?
>>
>> Re: cond_resched(), I did not follow you Paul, why does removing the proposed
>> preempt=voluntary mode (i.e. dropping this patch) have to happen only after
>> cond_resched()/might_sleep() modifications?
>
> Because right now, one large difference between CONFIG_PREEMPT_NONE
> an CONFIG_PREEMPT_VOLUNTARY is that for the latter might_sleep() is a
> preemption point, but not for the former.

True. But, there is no difference between either of those with
PREEMPT_AUTO=y (at least right now).

For (PREEMPT_AUTO=y, PREEMPT_VOLUNTARY=y, DEBUG_ATOMIC_SLEEP=y),
might_sleep() is:

# define might_resched() do { } while (0)
# define might_sleep() \
        do { __might_sleep(__FILE__, __LINE__); might_resched(); } while (0)

And, cond_resched() for (PREEMPT_AUTO=y, PREEMPT_VOLUNTARY=y,
DEBUG_ATOMIC_SLEEP=y):

static inline int _cond_resched(void)
{
        klp_sched_try_switch();
        return 0;
}
#define cond_resched() ({                       \
        __might_resched(__FILE__, __LINE__, 0); \
        _cond_resched();                        \
})

And, no change for (PREEMPT_AUTO=y, PREEMPT_NONE=y, DEBUG_ATOMIC_SLEEP=y).

Thanks
Ankur

> But if might_sleep() becomes debug-only, then there will no longer be
> this difference.

