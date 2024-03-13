Return-Path: <linux-kernel+bounces-102410-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89A3F87B1AC
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 20:23:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A5C7289ADC
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 19:23:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EFDF52F87;
	Wed, 13 Mar 2024 19:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Eyms4R4t";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="K+/HDnQE"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BB7351C3B;
	Wed, 13 Mar 2024 19:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710357364; cv=fail; b=JwhGGNM7FR7+GJ4QGonUBWjGRls7cSxsA/sAjGi5AwDx4f2uKwmuZRzoz9S8+06r9gjTWsRJrG6KWfWDtfCq/RNLwMrtW40szaFK+68VlFFjZyGonBXUCUlq+VF+Q2msLsC/9pyoySNg5+wVUL9jt+/N9CMvQst7cZ3Z97Esc0E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710357364; c=relaxed/simple;
	bh=Q0K/x6iP8txZo888jjtJrFj7r5g+AOhlyuzxef5TYdc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mWBq57mR4tNVQ59Y+Z+ts082LhLPMfRNsc2fDvGC5ur6uuLxsPfAD8nO/IZliMcj87gTi1z6LUvyvuVW/QnIcDuEuK6phxxM5yYN0/pyW/jeEFu6QMxIuxJnaJWnnLbNtzSYtxJgtSyWoSS/zPRuhFJDLELQ/hzaqSy1+ewAqQU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Eyms4R4t; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=K+/HDnQE; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42DHx29g015067;
	Wed, 13 Mar 2024 19:14:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=WAmIwzIei+KCquJucwSZJkbLRUPRmBv+6Ao6ubLWAt4=;
 b=Eyms4R4tqd+Mkoa2knysujohUlJ/mZ+5oH3oJn7jfiofI1nG02AH5vecVAbhpvlFo7jY
 WG6tH4wfFl6es44OVUtGmNe6adYCTA6OCu4fl3n/cwdDaQpQfPXAh8Igvb0anTTndos5
 Jg5FyhdDFu9whK6vqhmjoDhxbrYtFeaaqjgczw1ZGNi1f37uoX9Ek0TOk/7M5dz/xKb7
 GYVuY/R+hBegJj+ixk7QF1NLlVVu+3HSf7PXvw0vXwgPheus/2jUpWTxTozGERzMVL7y
 HoHS58s2+cFJFnZ8miJxJXSHnAbg5fLYUMa1139lLUioSYNYhy77GoY4ThAbbiHvYLKu +g== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wrftdhxcq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Mar 2024 19:14:27 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 42DIVdMb009138;
	Wed, 13 Mar 2024 19:14:26 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3wre7fhe29-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Mar 2024 19:14:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fJwKrd2iqX1k5rhCMOCgjT5zjRlWwh+P5ACC6YeT3mNAVNZ/4D4VO+FR4ckeOurw9znTLGgQijYUa2KYZNNPKeMJca6l6Vr8mje7ooN9x8hcPCR3QQ7uoY7VrlwSmR7Vp4JHm40lKeBTpCsVFmMWRWT/QGO5vHk/ogMIY3JqMqtjI1PNb6/d9gl8kznYmqUnzvmAA1Kh6QVrk7EoaVo0i6HTztKGhJJJ0jEPZYDC+D0YSZQQWjDzCbtoaGKfWoiHTc8yeHMC1t4U6a9rKN1HoK3z5kXOvwp+5vYkauv4I4Ss2uRY2z0hB5arfaN6rAtX1IOUH6Tu/Jd351TWchgYjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WAmIwzIei+KCquJucwSZJkbLRUPRmBv+6Ao6ubLWAt4=;
 b=a0FTf8mZkUztbb44ZngLv00GNFLC/ApX4fiVb5m+Z7ETo4MzJ8kNEDDvGhYbEbsuCTC+toftw8Jg3j7R5grdslcB2FNJMdGmRXEpV2R7h6KMdYBq5nFNoTisohjyW5CgBV4kn3AIJkI+5AdLt7wKHH+DZ9EoGzzx6HpNGUfwNDrvlvCrj73GlNRtIpVMwDAhaooXDfoTJRVv3FGe1dZ3wUsjEIrE2NtcRBh+mA6mM7U42jncD9Gz7YUnXkruo1hWMb9uokgCXym/vID/KpjDHFxC4L2IGjH43EEhqqC/ysoRFfdyroS8WuV4QKPfmIsBp4e4HwzinjqoAHCqjwed4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WAmIwzIei+KCquJucwSZJkbLRUPRmBv+6Ao6ubLWAt4=;
 b=K+/HDnQEwKNQNL3BXaRutYcwDno/to49QsYI2/+pozmnI3h8cvHz11nuXUSkTjE8+riAnVsnyV8w5WAfvqfggflK0aOSg25TFdHiKI9mXAHGpCS7iVdzT303X+8gucBPBeOCupeSAESWL//IFeZl1nUGqQWVG0/iJerzkS/3cXE=
Received: from CO1PR10MB4705.namprd10.prod.outlook.com (2603:10b6:303:96::11)
 by CO1PR10MB4627.namprd10.prod.outlook.com (2603:10b6:303:9d::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.18; Wed, 13 Mar
 2024 19:14:23 +0000
Received: from CO1PR10MB4705.namprd10.prod.outlook.com
 ([fe80::88ef:4ee:6255:5391]) by CO1PR10MB4705.namprd10.prod.outlook.com
 ([fe80::88ef:4ee:6255:5391%5]) with mapi id 15.20.7386.017; Wed, 13 Mar 2024
 19:14:23 +0000
Message-ID: <d190daec-a7e8-4a88-9b96-e3610e9fc3b2@oracle.com>
Date: Wed, 13 Mar 2024 15:14:18 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/15] admin-guide/hw-vuln: Correct prctl() argument
 description
Content-Language: en-US
To: "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>
Cc: Suleiman Souhlal <suleiman@google.com>,
        Youssef Esmat <youssefesmat@google.com>,
        Steven Rostedt
 <rostedt@goodmis.org>,
        David Vernet <void@manifault.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        joseph.salisbury@canonical.com,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ben Segall
 <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Luca Abeni <luca.abeni@santannapisa.it>,
        Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>,
        Vineeth Pillai <vineeth@bitbyteword.org>,
        Shuah Khan <skhan@linuxfoundation.org>, Phil Auld <pauld@redhat.com>,
        linux-doc@vger.kernel.org
References: <20240313012451.1693807-1-joel@joelfernandes.org>
 <20240313012451.1693807-10-joel@joelfernandes.org>
From: Chris Hyser <chris.hyser@oracle.com>
In-Reply-To: <20240313012451.1693807-10-joel@joelfernandes.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0364.namprd13.prod.outlook.com
 (2603:10b6:208:2c0::9) To CO1PR10MB4705.namprd10.prod.outlook.com
 (2603:10b6:303:96::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4705:EE_|CO1PR10MB4627:EE_
X-MS-Office365-Filtering-Correlation-Id: d1dec080-a06c-4556-83ef-08dc4391cb1b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	BhsJAYdhdeHTtQiwrv7wW6bLy+0bDzHyJgnOL7yZ1l/J7bYznRy2wtHXi/z/BObgALV059ADYRluSqDjCzFuawXsOOEW+H2EzewuMHPd6TEpvSERfR1dUnyAIq/JFjP6ElQr78ZNUDGPNSF/hXOfr6pPUI0Q3D7HK/7peO0fKXV+TY801zhVz8yap0VWhjC+tOX3DVFu+cvwxX7ThcohFsi04Nyu0lk8ig7D/B3dORvbfElpx5zcOzubjTPkFaF210xYAMRO45WJPaXP0pj+e+myBSrBJZ6OZn6cYWLigzq7XNvtmx+pHI2afi5Ze5J00gaTy5CfjMDRi1H8t4CMuKMTOQAtFxBvkUMWVj2KSdsire1bN5X0FhKKYR2s17Qv4cV22IYrBr+jQ+XP7Va+xelhz6G2AeyeSraP+p4lX051d61C5i+WG7S6vB7mtqKILIQ3k+oazP0QP4gt4SFZIeLInbePgRHloWoJQvjkrQc+R3k6SMlfZ/yMr/R3+PEHPNz4ucULLk3FxTDiTpXZAhw9ItlupQ+o48kqda6b2Rb3z1g6vpc0XbRKQ9xEhe2eRGSB8q022OiGL/RGAhE50ZUHb2AeEZjzb7MAORLTJpL6V3NIkQOy/HvHNxLtL9r/aY5HT1wWDGkKCelRkhbadjkaFEmn48rM9QVhp/b3BuQ=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4705.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(7416005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?SWNGMUpNUjI1cnVnZzFlVktHQnB6Mm5HSTJuT1VLNFB4UGc5VXcweVNYRlJs?=
 =?utf-8?B?Vm5MZkw1V0tiTk1XSEpkaXppUllGNDI1eEp2dWwxR3Z0Z1BSMVp6akxzTUxQ?=
 =?utf-8?B?d25vR0hYcVJBMm9xODB5VGpmRUM0WG1qWnowRDFoODJWSlZ1ZGpNcWJydzNs?=
 =?utf-8?B?eTBPWVRTcVlIeUpYT3FwRy8xdGhDcjJ5S2cyWHF1U0RDWTJYSDkrbGw3d1FM?=
 =?utf-8?B?Z2tacFAwdnpoTEdZU0twWXEwa1pwa2UrakltbnNHcWZZSGFmakh2L1dSVDZS?=
 =?utf-8?B?clZuc20vdzFFZE11VjFzaGVMSEh2ekhKWko2ZGI3cmxTQTR5R1FDUjQ2dGh2?=
 =?utf-8?B?MVJSUzVMUmRKVEFxMi8rNmQyY3FnemdJL29vSXBOcWE4VFpaYWtORVhEaDl2?=
 =?utf-8?B?SlhTOVdNempXY3IrYjl0bjFDdmNabWNKdXpLMXM2S25GUVQ5VUozNmtpS3U0?=
 =?utf-8?B?NDQ0WjBNaUkyOTIzcEdkS1ZBeS9vbUhqOUJOTHA0UTBROTF0VDErU3hvWWh4?=
 =?utf-8?B?cnk0SHVYSDZrUk5JcCtSVSt2ektHWFVZZjlBZlRaVVUrMkpRZ01lVitzSktH?=
 =?utf-8?B?QnpEMnlCdXNZbXhJSWRuWnRHRmZxMW5ZZ29RM2NyNXhaQ2xjbWRENTNDcjdx?=
 =?utf-8?B?KzRoY3JlS3NzNktIWXN6Mmx2VFNvTjdTS3kyY3djVUF5Ym5BdUpUbFVuTUVQ?=
 =?utf-8?B?NkNrSTNyYlJHTVFsTHA3UHNLYlJ2dUdpTTh2Z0svNWYxSS9odkdhTGYwa1Y3?=
 =?utf-8?B?dW53cjRQSkVMenlVWG1ycWNGVFdjbFp3VEJnSGxTL0xCdnl3ckV1ZXlzNWdM?=
 =?utf-8?B?ZlorNmFualU0RVpQRjM1bWdHSGFxZlpPUnZPckViRU9PUzhNbDEzUVpUbzZV?=
 =?utf-8?B?UFVkTW1WbmE2cWFUbm9uc3B0MnVyQXpJeUFlNHd0elQ4S2RxU0dVWS9Td05r?=
 =?utf-8?B?eklaK2Jkd1dBUnhRRVlrZG1Wdlljc20rRDc2VHJ4VW0xREJOa1lYd3dwQ2U0?=
 =?utf-8?B?ek5OQTZNRUNWWjBQTGJhQkxIMk9NSU5YbWF1MTE4Sk92bzlObnFvZ1N4cU5v?=
 =?utf-8?B?Z0ZuU2dQdGdwNHhBUGUzaDB3ZStwdXkzTGY3NFlqTnpieUJLanA2YjNsaExM?=
 =?utf-8?B?M2YwWERRMlZoRmtaS1p2ZXliT0duU0MxTlJ2K0oxelhUZ1FDaXY0dVM1UE9N?=
 =?utf-8?B?VEdzRGZGYUhjUzEwNnFLT1NNUFB4UUtaTnplNlRJc2syalFsY0ZOci91aUd0?=
 =?utf-8?B?RzlDbFl5aloxcGgxclc1TVZxbXB1YklXUGNlQ1luQXR1NklWbjdWR1NUZ1Bp?=
 =?utf-8?B?VitaZVdYYkgwMldtZGU1SXNSOVF3dWdJeXpkQVVOT2liMDRLY2E3L1hjTEZ1?=
 =?utf-8?B?aS8wckZpRXdhMVEzTU5ZUzhyZWd4dENpNFJwRFZ3amZMV1BzU3Yza1VUeFFp?=
 =?utf-8?B?UGhpa0h3U09vVHVUbXp5Z2JFNjFVRkJmLzFtVkhwTFp4YUl1ZU5yd3VqNlBl?=
 =?utf-8?B?MGdXMnJjS01Pb1ozNXpiTDBaN3ZFc0F0c0RkQ2ljY1NjS2p4WE5mQ2ZocW5S?=
 =?utf-8?B?c1FkcHk2bzR6WUYyeHdaRmNabndmeEhESEczT3RlWGN0UERzRGNrSTVsNnVR?=
 =?utf-8?B?OFYzbDQvK3JzUXJwaWQ5ZHlkV0dmNmFVZmtuc1ZrbE1idmZTejNBSzdaYy8x?=
 =?utf-8?B?NDR3Wi9WSzI0dHFoN1hHNGVyOWJqM3kwNTc5Q2ZlcnVPRW13TGVxbUNTU1R6?=
 =?utf-8?B?UHpwQjVIMnFrVUVnQ1ZBaUZBbVNKZklhdGNOUDV5OW9DTDdzVnFuRUl5RVVC?=
 =?utf-8?B?VysvSXg1WVRaOG8wUWljWFJlZHcwaU9WQ1JOcU50MG12VUZGN1dwbEdNNk5n?=
 =?utf-8?B?MUdRRldwbXc1V0tLK09iZVdTN1BtZEk5a0VQTkF5d1pzOThPREcxbkFHRmFq?=
 =?utf-8?B?NWRwMDNLN2VVbmI4cndDOHhOUlpPTWFXUThCSmJSSG52SWxhcjIwZFc2TGpv?=
 =?utf-8?B?cFpKbkJTQm44SjhBeERMZGxsazQrZTZpdlYwbTkzK3ZTR3VhcEhMck1lRHpZ?=
 =?utf-8?B?aklLRHpqWENZbS9ycnVSbCsxVkYyNTI2RzZTOWhuM3ZjZFdDcmlCU3A2UTFx?=
 =?utf-8?B?Zmp0OHR3bnFUNzlwQlZnMFVJdHpnNzdzMW1MUGNHQWZJaGh5Vk9iV0pwNVpI?=
 =?utf-8?B?RUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	SvdANdO7dfzhaw2QjNYvHwvjnnH7I0EA/Br60WOY1OmCwc3kDiXiIEaO5nY1kLUN3ceG7ULWkskZliWVD8HTd7dLx92t0cKeB7XAyAw4TOoDccfqLDQBU+rNUg7OKp/LdjtXf9MSKFa/vYEtKksRDGmfsJbT20C2MfZNO+bgwQ1NNR8Q54whSeXeZJySCDnad1Az+x8h1RCtYxKvnnopmdilEzcsFpOaBo6nSQaeAELbFdH4w28Q6n3DQqPLjYQNE1/1H0UXln8a0QstkvbO4mWF4KQ+0PsYSroIAStIDqo9PowyMXX9Y+pSA2+m/FOufUyJfLzh8qmqduxptWqHG83DjOrE/ED9cfv0b09mdzlRCVf3hfodWx/Vgfw+wTqre+CMlpH2DtZEvH7kS87xgLqJIPvI3/mL8/mtoXx62TOmLj0BjSBbuKb2oRIXN2VnM+WcTxgm5JDSOK71YGJ1WplSmNoX10ga+fLcHirZJI3Zla7d4SYtfCSvFQ+VK9QqC6Nz5YgQ5ZZM+umNBQ7BozrgxOtW0T6x5SQF/M/B0FdufQo6yr1oBoSnOt/BN4wBVd/FGG7hsEKfqjak4TM3CA4K2J8jBBOxq3YZ66XIyng=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1dec080-a06c-4556-83ef-08dc4391cb1b
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4705.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2024 19:14:23.7752
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kZTJaL1O9/eLAK5MA99yPZ+ZO8XSimeSNV7jDH4sPhZv8Y0WV+fLEY8DooHaT63/f5J2xLFNJBgP5Z2R8CRIGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4627
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-13_09,2024-03-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0
 mlxlogscore=999 bulkscore=0 phishscore=0 malwarescore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403130148
X-Proofpoint-ORIG-GUID: uIjY2-L9xD9YMFEuN2jeYUvIwc-iMTg6
X-Proofpoint-GUID: uIjY2-L9xD9YMFEuN2jeYUvIwc-iMTg6


On 3/12/24 21:24, Joel Fernandes (Google) wrote:
> Correct the description for arg4 which appears to be outdated.

Technically, the constants referenced in the documentation are still 
defined in prctl.h, and there are BUILD_BUG_ON() checks to ensure they 
match their PIDTYPE_ equivalents. I would presume these should be left 
in as it is technically a defined interface and user code could break.


> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> ---
>   Documentation/admin-guide/hw-vuln/core-scheduling.rst | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/admin-guide/hw-vuln/core-scheduling.rst b/Documentation/admin-guide/hw-vuln/core-scheduling.rst
> index cf1eeefdfc32..338d639a8127 100644
> --- a/Documentation/admin-guide/hw-vuln/core-scheduling.rst
> +++ b/Documentation/admin-guide/hw-vuln/core-scheduling.rst
> @@ -62,8 +62,8 @@ arg3:
>   
>   arg4:
>       ``pid_type`` for which the operation applies. It is one of
> -    ``PR_SCHED_CORE_SCOPE_``-prefixed macro constants.  For example, if arg4
> -    is ``PR_SCHED_CORE_SCOPE_THREAD_GROUP``, then the operation of this command
> +    ``PIDTIME_``-prefixed macro constants.  For example, if arg4
Presumably you mean PIDTYPE_ here? Otherwise looks good and in 
retrospect this is probably what should have been done in the first place.
> +    is ``PIDTYPE_TGID``, then the operation of this command
>       will be performed for all tasks in the task group of ``pid``.
>   
>   arg5:


Reviewed-by: Chris Hyser <chris.hyser@oracle.com>


