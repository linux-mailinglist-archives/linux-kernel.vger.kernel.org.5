Return-Path: <linux-kernel+bounces-108068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68AD4880581
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 20:34:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C04F5283B72
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 19:34:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59D123A1D4;
	Tue, 19 Mar 2024 19:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kqAXek58";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="P377N6cj"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6015539FE0;
	Tue, 19 Mar 2024 19:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710876850; cv=fail; b=RXg4D/wrOLkhEuaCjJJyFeFNxDtpepodgc9nA4e0NkPZbtTxBX+BV1vgdnKBrw4CHpWFUHmB3XS2gcPbX0gT+JSMyr9VskfLin29YauN+Pp0n3lIAE19mcXvFO9A8hEvtSUhWjRp6adukm+i/sZAODRPCI3wBniiMNlJiiPqlPk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710876850; c=relaxed/simple;
	bh=B3i9LLqU327+UFtx6oECHvy2FtiliLgFR8VpziUAlgk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DZVNvlvoyiFGmmvnMlnfGxn95D2XaTvhp0DcQ9J5l+hNqgrjYIKMhgvJiU8r7FeUQwAHqZXyZcXkwh4r1CY3dUzTbfv9rjHmCr51Vbh50P8wKacwLrscC3kLOU5+1rv3BZw6zo0AfUG8ZE5D4anJuoSPM5iQqg0Tw0vFCbqUG8I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=kqAXek58; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=P377N6cj; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42JJE8go008968;
	Tue, 19 Mar 2024 19:34:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=9RVrRUTpHSFHNo7F4ObXo5zOI/dnUj/nEH96+fZbd6M=;
 b=kqAXek58R+zTOCYOsf4yFyETXTkKY4SXsE8WL64dHY7Es5low0rOxBntD0jd5WbxmTvx
 obIsh3mLotJ76B/ZRvuI9Vl47L5oM4H37l2LrssNwMMbIF9SitGpGLUuwFmdTLPuXTcE
 uCZE0K8qJfaHBzL/IIxBebcKGcB9aO7qISxnJs6FDNYWQRecg0iYZ54gJkjKxoQ2UY4f
 QAUx1OyCHLJy1jn/iYp4ZF9UCl33cqXUodwbwmP56jDHGf5+mud0cHA5Rpdpb+N2C04c
 pTU+UCyFrbKgBlO9Gn3E9U2Ovn1a8ACUAFBL01tHwbanUprf8Xw31poIqGko/UnqKSXj mA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ww1udeekf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 Mar 2024 19:34:01 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 42JIqaoh007503;
	Tue, 19 Mar 2024 19:34:01 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2041.outbound.protection.outlook.com [104.47.51.41])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ww1v6s2kg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 Mar 2024 19:34:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MtWtVEbLhnDxTFdaCs5Y72mW2kJX5FzFxF/u2bEtSEyZbua1is6AD1qnYmD3DP9pfJgxfOwzEHHgmetArvl8NSm7KViYDFJ6uzbPJQWwspk0+qJ571QVHp6iOvYtarZ/djIx1qlH5Y5mW3rfsTynpJ8fR+w1rxbWr3NQ0TQfZ96266q6zWtGbFpyLptjuwLyCWlKumXbh4V9CimZam4NPrjiOg3PAPTHxeWF33xI/kSposfaocFkcobyUafR4buCHuqJBrZrxyg0xysYuMTAH69bOciWAKL30I327iQptCoBdlxdMXw4VW8Dra/aaT5jVX/5f+pe7diu54bjgGL19g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9RVrRUTpHSFHNo7F4ObXo5zOI/dnUj/nEH96+fZbd6M=;
 b=HubOW/e/z0NyADCUhrhkecRvlB7YULwufThC9lh0E5rW0/Yp24uqrJUHQfI3XXaHZ9NrGFpu7qGJ/UdxAKJVBbF4ZAdwXhcS6YP6Yd/xa8xxKrA3iQfQaNJa9vCJ69ZC4ylLOOUYSjHRU0o0f3uCztlVoD11I6DV1agbrMfI1pwMMnc9mtXHlqQ1P9O/gbTalh/jiHGIk+ElGFffUHikLw2tY/11VNaOsejV2PXQrJnPHq++R3Fo/IPY2kL8Xmoy/wt0NIvtNAkqEIBHCt2F42gpLtZfMt4bswfBc8fo1xpDJVvLPBH+1Pfu4wAWJ6VJsZTbA5lSiqEgx3GNPiYhNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9RVrRUTpHSFHNo7F4ObXo5zOI/dnUj/nEH96+fZbd6M=;
 b=P377N6cj3yDDjxkiRtysWVRZhUOgDZNANcXk1nx4vYVNGCJs1GepdjdwEVq8ERVjP9C3jhfCe147m8qwMk/nSK9TAtQ3o0xYtGHedeLyRkRl7YJq64HSuu13XDETg32KW6fdExeLwS0JGY80khPGd7y+YbxIOP/A1qE4XKLEmsY=
Received: from CY8PR10MB7243.namprd10.prod.outlook.com (2603:10b6:930:7c::10)
 by PH7PR10MB6966.namprd10.prod.outlook.com (2603:10b6:510:277::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.28; Tue, 19 Mar
 2024 19:33:58 +0000
Received: from CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::2246:144f:3bb9:60d]) by CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::2246:144f:3bb9:60d%3]) with mapi id 15.20.7386.025; Tue, 19 Mar 2024
 19:33:58 +0000
Message-ID: <6bc61553-6c8e-4705-9cbb-8e73d3f8c801@oracle.com>
Date: Tue, 19 Mar 2024 14:33:56 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] iscsi_tcp: disallow binding the same connection twice
Content-Language: en-US
To: Khazhismel Kumykov <khazhy@chromium.org>, Lee Duncan <lduncan@suse.com>,
        Chris Leech <cleech@redhat.com>,
        "James E . J . Bottomley"
 <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Cc: open-iscsi@googlegroups.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Khazhismel Kumykov <khazhy@google.com>
References: <20240318194902.3290795-1-khazhy@google.com>
 <20240318194902.3290795-2-khazhy@google.com>
From: Mike Christie <michael.christie@oracle.com>
In-Reply-To: <20240318194902.3290795-2-khazhy@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR02CA0161.namprd02.prod.outlook.com
 (2603:10b6:5:332::28) To CY8PR10MB7243.namprd10.prod.outlook.com
 (2603:10b6:930:7c::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR10MB7243:EE_|PH7PR10MB6966:EE_
X-MS-Office365-Filtering-Correlation-Id: cc19fa6e-455d-4902-eadf-08dc484b85a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	JkGbwlI4TkAlS5vKX59yeCYlLDp/QAakIn2Gk1n6+FDFewIqk9OqFm4+RB1SDxQBZygp6NayWs0spAph2OtFljeTIDJ00HD4S2+Qe8bOTarVTczP4+OD4My4dKsDO7SADhlPesDSPGvk6un2aRHBnryirSi1yuRBbGd2TnsE4tobMAoey4fVKDKf8/kjrn6MxyxtiUfrrAnvTgOytZxGUiURLATtKI+K0RPAn6m9SKfD0ickS3dUe+tU2hu/aGR4ewM69t7ncbRdxscwCDDL88nBMBWyfN/t3/TqkaonK3SWCZumDkc6HdaWxH52JUQ1x/GhJmASCcqejMCtilxDAkdeATP2ZjxyExjpZywRVTn4HdUzphOMvNykz87M0qTm9aOR9tJY3DatFqKpmiwEaCd2T0Zq1HVVuwGFLBunNDq/k0zmyNA4bJsvsZBQ6pg8tSseWfZ4KDsnA5R1cq8DAaGBLoozs55BqfWRRAG7ACRiGbaY+1EMbWQEojn9Fcr+LV8a25aw2Qr7euwdRjUSfJrt3l3BV+Qa6sV7pevl26MVWunXewIqRbOHJ9iGATNA+CCbne/mugTvwIl/o9Zty6Tq1WNIg5JAutwscOD9dzjV1CICr6+sm/7+Q5RHF7RNX+aVSkeibfre/oSU5DoZg+ORq2jfnvRhZbXEwzmZL+4=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR10MB7243.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?dHV3MnJQbk5zOHd4NERpUFBtdTRnQ0NYTzJBQlYweTBrMjJGYnJzbWtWd0Nn?=
 =?utf-8?B?NGwzUmJLRDdsQ3NjQ0ZieWIrTEpaNkcvN2c0OFVjTmdCN1dwNlFicnl0Z3lZ?=
 =?utf-8?B?TWRGNFpGQ3RMdjQyT2JqMC9VcCtxYzdIeEYxV2xYa0pQWmhPRlZUTitDVDha?=
 =?utf-8?B?R0ZmckNDZ2NzMEI2SGhrU1BKRnVKRHA2RVBqcjc2SW56QnZhS0ZxMXhjNFUw?=
 =?utf-8?B?NVZXQzFvT1pNWGhmQ2NWOGd4VTVIaDB3UlVYSmowWDJXakU2MFdkQ2FkQUcz?=
 =?utf-8?B?SW1zQktZVzhyVDRKNkpzMlRPTGw5MU9pc2s0eXJDV2paaGJNODZ5eldFd0xL?=
 =?utf-8?B?cjFXL2ZTdHhCeWVld1V0aTEyUnVmTm5iRjNudGF4YTYrZTExM3oyc0plWHRa?=
 =?utf-8?B?U3gzZmRKTjhOWE5rVUJhLzU4VndaalVQWE9IYUtBeXdBcTRpMDFFNzBKaEU0?=
 =?utf-8?B?bFdyOVI0dXZZSlpiVm56YnFhYVlrUFlXYXdoS3RVSEc4VFFvSitaOG02OGhl?=
 =?utf-8?B?TnJGMFl3eVZZamhDYzNyQ0E3SHlRZXNYek5yc2xrek1YODgrbGFvL29wMTRr?=
 =?utf-8?B?TjVrLzZ6a2RwSW9ydHVUaWNFeGdvNGpwQklnUTB0enlFakNnYXZ5dExDMi9v?=
 =?utf-8?B?UnNBYzF1UC91eXNQNkxwaGJhbjlwU3Ztb3ZFRXh6RytHaWgwSGQ0UEhVKzRM?=
 =?utf-8?B?RmVnYUtVOTZUeVVHOVJ6OHRQdzVZbmczY3ZDUXFtSU5hY1RSbTkyLzE1WTJk?=
 =?utf-8?B?VEFMSm1meTBBcmZ3REZGUTM0a285L2JKSW03QlVYdWljNnJubUlPS3dEbTBi?=
 =?utf-8?B?R3piTWRkR2NybHM5TG1qMW1vVU1nSElLQ1lKZzExakhZZlpGZ2hWMVZoTWph?=
 =?utf-8?B?ZUN0QzVTY3V4OWpQeVZjOUFUNmJpWUc4OUFQSmwxTDFMSENsMlF4cmRNUnhq?=
 =?utf-8?B?ZDNHdW5udVB4bXdBVVhONUtCMXAxbWxHYVd6R212V3pFZTdPcXU3WmRQUStj?=
 =?utf-8?B?S1Y2ZUM4YTZ5Nmp4bVFjSHFqb2JTRjVQelQ4MkYvelZBMkpOekZmOGNJcTZV?=
 =?utf-8?B?YVpVWGtBdW80T0pWeGpkcmcrd29VQi9VL0JEYVdhbkJXZTg1Z2tZSVgzcVB3?=
 =?utf-8?B?VjdBTkhOTjZSR1k0MkpFZktJSGNwV2lMS2t2c3hBdVY2OEpzQklvbDUvbXpD?=
 =?utf-8?B?blJYNE1FNjJQbjU2Vk1JY0pNS1kvVmJWenR5VUNHTFpqb1kwRXpHdVpyaEpY?=
 =?utf-8?B?czRmNXptSkVOUEJpK1dBZldZVGJ2S1JOdUlyV1R3TjJyU2ZrWUxBOHkrSmlW?=
 =?utf-8?B?ZHFobWE5SkdSZ2RDRlFmRnlLUDQxTjEyeHdza29zbXB5dFJNZGx1TWc3eGc4?=
 =?utf-8?B?citkdTZpL2R4cUFpV3EvLzJpNG8zT21CV3VodHJFVVVYVzBYeGN5bFhMNzJl?=
 =?utf-8?B?b250WjR1aDFlcmdiV201b0FzSWlKeDJvdk43M3g1WEljWkVuUXAySFlCM05p?=
 =?utf-8?B?cFlnVHpLcmdFenQyblV4LzI0SDhVaEdzMnpLejlWS0ZpRHBwMkVxM25HRUY3?=
 =?utf-8?B?dW85eW00eHVMa2dFMEIwejBKbXVBeWRwV2RldDNKS2pOSWorNDV3SmE1b2to?=
 =?utf-8?B?d1BhL0VnbW9ZSTVNTnFxMnRCQzIwNjVzOGxBcU0zTHRTQ1lvZmZZclMycnFh?=
 =?utf-8?B?Um9lZGJNZ1UwS3M2bEJPbEJwZzYxdDVHVitnUXIrcjhyMnlYaE0vOFlSRVpK?=
 =?utf-8?B?ZVZLdDFXYVFkZE9rSXVtN1FjMXR1Z3JXZk0rM3R5TlBLMFNUSFIvQ0dTRFI0?=
 =?utf-8?B?aG82VWNUdVgrMFRTbWQ3ZnJHczJudUt4WDNWVytmOEtUZ1kvaUhFSXk1S21P?=
 =?utf-8?B?Sk92TkR2dmhHNjkxcnY5RElUMTJ5QlpjUUtFblZzL3ZwanVNbU05YTREZmhS?=
 =?utf-8?B?Q0pXNTc4MVhickRBRnErZ1JEVFlteHdvb3M0VHlGTUtrRXpJbXVYSDNEY3hh?=
 =?utf-8?B?UmZwSkFPckVadWtoZUErRVliNjV6bzZkYmZIYW9rR2RJVkYwNWhaL0VnZFB6?=
 =?utf-8?B?MFpzZHpIVWpmYmJ1cmFIYTlWYU94NDRvL0g3MkY1Z3NGSm1LOW1FU08zalZr?=
 =?utf-8?B?TDM4cUZtakdvL2dtZWkzL1J4QUNKcnBodmdac1hIanJSSGJMR2RIaURPQng2?=
 =?utf-8?B?R0E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	M5O6R6YPJk5UmQqcecLgheehCVBd9vSm8eQ1JzYdSAmTFL+XZg+GfysUQRo3X0q5j61G29VE2beU41sznaw+BYQauWOAsqCIKAZnopklMrdtpmGfgidvp/bwUi47XeHhQB+DQ4cOQaH+H+dnTMf4t1hP+8BrXAu3PRqP8B9PNCa1BVgdUcP21eAsmyCIuERRxld1jm3dUsXuP1tW0SD4o0JF6+UjcArxwCl2EZKtV5BxKMtom0GUfxTpMhZ55Qv/+CpAHu0Cklzg+EJnE874EAb3HaaBp/1duwYCeD0HT24Gr1URUinh41481MYTEsJGwryo/o2b0pMjKHbmBQ8VCUsPOT8i6eIWLsHA+2j1SrdIB/ohU5oJrVeeVbdWWq08Crk/IVpdXXKdtis1e/K5OaZ5F7e/FjbBF2rkj/M6zXsCm8Z49hsP2LB6WbYAYpFk+21JLxznOnSLD+KxmNINf4WpSngXZtFO9Mp/BplVdZLvsvKCjJdnvu3qjMALUH/7L6yRPQ02jnVvIkmXijsZIOivygdqlA/4LZ20vL9hzIiZU/YJZNdhW6/nxyuVe6cf6+AUGUzMuDgBUSWy5mjeM3Hw+06iAwk1xDGP9HAqTk0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc19fa6e-455d-4902-eadf-08dc484b85a2
X-MS-Exchange-CrossTenant-AuthSource: CY8PR10MB7243.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2024 19:33:58.2753
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ij4FGLA1mitHFUBy4jgmttMA8sHqcIZOMAuFSFZPpcsCSLAWuxWDek2RpS+tawAXfmufDoy6ATazIFt2zLROY1a8SVfy/6Z3uTgt1ER5AIE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6966
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-19_08,2024-03-18_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=940
 malwarescore=0 adultscore=0 suspectscore=0 mlxscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403140000 definitions=main-2403190150
X-Proofpoint-GUID: yF5cwRY2V0_agWY60KmK2bKz6FRFQnKu
X-Proofpoint-ORIG-GUID: yF5cwRY2V0_agWY60KmK2bKz6FRFQnKu

On 3/18/24 2:49 PM, Khazhismel Kumykov wrote:
> iscsi_sw_tcp_conn_bind does not check or cleanup previously bound
> sockets, nor should we allow binding the same connection twice.
> 

This looks like a problem for all the iscsi drivers.

I think you could:

1. Add a check for ISCSI_CONN_FLAG_BOUND in iscsi_conn_bind.
2. Have iscsi_sw_tcp_conn_stop do:

        /* stop xmit side */
-       iscsi_suspend_tx(conn);
+       iscsi_conn_unbind(cls_conn, true);

to clear the flag when we clean up the conn for relogin.

3. Fix up the other iscsi drivers so they call:

iscsi_conn_unbind(cls_conn, true);

in their failure paths so when they fail they clear ISCSI_CONN_FLAG_BOUND and
iscsi_conn_bind can be called on the retry.



> Signed-off-by: Khazhismel Kumykov <khazhy@google.com>
> ---
>  drivers/scsi/iscsi_tcp.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/scsi/iscsi_tcp.c b/drivers/scsi/iscsi_tcp.c
> index e8ed60b777c6..8cf5dc203a82 100644
> --- a/drivers/scsi/iscsi_tcp.c
> +++ b/drivers/scsi/iscsi_tcp.c
> @@ -716,6 +716,9 @@ iscsi_sw_tcp_conn_bind(struct iscsi_cls_session *cls_session,
>  	struct socket *sock;
>  	int err;
>  
> +	if (tcp_sw_conn->sock)
> +		return -EINVAL;
> +
>  	/* lookup for existing socket */
>  	sock = sockfd_lookup((int)transport_eph, &err);
>  	if (!sock) {


