Return-Path: <linux-kernel+bounces-83278-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF9A8869135
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 14:02:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E3421C20D5B
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 13:02:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 471EB13AA35;
	Tue, 27 Feb 2024 13:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Q8FYSMQW";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="eXjY60LZ"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D256E13329D
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 13:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709038968; cv=fail; b=f0BL4q4Bqcaq/d2O5h5WZySHzujljFBB5AG//Ofap+9Hcq2ExU5fQvKAtVpwQ9o2tbB9j0O7+y6eB2w620iV5cQ+PPscuuLItJGSVEhvDa9J/mFks/IGFaSME48KwlO0lVk5vQ9dvPkgV9jD4uYRJpybOlClJ7rf0kN1pbQAFZs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709038968; c=relaxed/simple;
	bh=2abQOnsUbhXuoRBF25YpIGVXohMCvvnr5Ej18lPWxfI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hL/xAcl3G8fBD5+yqXSSpDb6lCS6N69iz68nikzovbn1BpyZhAMheCRSzmCAHqgu00G+nDbuQLOCB6ouNQ4zeEzxL4DqOhY3L9rYdcol5ddwWJkyW93NFNtLTpUffDubb7motUMIlMKjJNmyofw2ATJBnLo5To2wQYK6AIpRNjY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Q8FYSMQW; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=eXjY60LZ; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41R9JJ3i023082;
	Tue, 27 Feb 2024 13:02:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=dpr/jMSo8dsMWigLJmzv9TcDdFXyws6a9qiG5WoAQEU=;
 b=Q8FYSMQWFUhVEAuXU66Xwr5i8br8Jqexo0+whICAtUZ0ATv4ClzynoM8wRjyJgBgG6ak
 B5js9yB92wrC8SC2xzFxSYGNrGF2ObrmgbkB7xEeSUNpn2AodL912wQl2ZHFT8bcLU8+
 frf3MLXLrYMfbh9Swukd5eE5xthELg8uCS0MKYU8R5Izs1+UDiE77RMTthdrPTsTZB4M
 REG326Y574EHyRPk0i6lEdZbo0mXJM9dtVvuhxQ1oWffo+u52UZwyvYl/A6SHixs86xk
 s8ryodzaaTHmRFL8xjnnbdsV27H7jrVLVYmBzEVlNfMixUfqpN3hiM9LEHElw47ZIPQV 8g== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wf8gdf9v1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 27 Feb 2024 13:02:33 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41RBV1fm025545;
	Tue, 27 Feb 2024 13:02:32 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3wf6wdn05b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 27 Feb 2024 13:02:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a0kjWFoBoEuX3D7dYubDC2rqZrJh8Zzinze7JRKLSDaH+O3yJGsGj3KozwVG+v2eokkOjYLWj+XIaAHIhd1c5GU/2L7nK8niF8m4fg3TgriqILi+1770uk5yng9BN4XwBQW187qsA9aCIgI7lSY3MR4/iwRpz2JdYXFb3GpQ0GNTgcStic9ck469LurpJiJj9jcssTZ0A1jRoR+bESZYrX02wyJQN3P+m1aXp5q+55CxtT0aM3xootEOHAaiPFQj1AE2A1d16to7JLVhDBmVLsNSqqC3ae5Bn7Gbi7TQj854nau1WdeGvo1vEXlPMY/k2w9/K4PmWY7jwqKkCWUdSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dpr/jMSo8dsMWigLJmzv9TcDdFXyws6a9qiG5WoAQEU=;
 b=R4yl9HFKA3XksmJMfA8y9IYWJGMdPLqrjuoLcR7W5mmORkUECSOoE+fXqHBxCHQocswFJv5qbPdYDp36eqFggnTNPgnlU3Rxw72zxNyGy/6WL7h6aR2y8F/As5eJUGtxYnw3JN1D7yaB0UvNe+dtop/1xKU1WsCOtyuDHtp/1RgEYtvjzOPq1js1mhMI36t0q9S5IYqdTXn/lSyCN8uds2YaaNPT6NOrFylBs19bbktV2TcHfsgRIa4w42F5+nQQV6a+pxIT5RXNkM5YCNtSMfALCUUrOS6N1nzBgw9qpSl38EHU6kXLFPG6n7dNsLFD7gCk0i0iX7JZ3ukglT2gZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dpr/jMSo8dsMWigLJmzv9TcDdFXyws6a9qiG5WoAQEU=;
 b=eXjY60LZbOi94FKeaDxUsExJpcFsGkJvSn5NpBO8nRrqGjYArTfIc2z3jeC7WOcVhRc8sBDWEHmfaa7ACTyA+TYqGaf0ffH9daA75XqyQ327Dzah7VN8ImOpTxlIhLCRLnol+lk8mK+ndkJ91NikJN52hRyrA1FFaObyyOJO6Yk=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by SA2PR10MB4763.namprd10.prod.outlook.com (2603:10b6:806:117::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.36; Tue, 27 Feb
 2024 13:02:30 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::97a0:a2a2:315e:7aff]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::97a0:a2a2:315e:7aff%3]) with mapi id 15.20.7316.035; Tue, 27 Feb 2024
 13:02:30 +0000
Message-ID: <e88b76c5-1b13-4ad7-a97d-c34722cfde19@oracle.com>
Date: Tue, 27 Feb 2024 13:02:26 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] firmware_loader: Use init_utsname()->release
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: russ.weight@linux.dev, gregkh@linuxfoundation.org, rafael@kernel.org,
        linux-kernel@vger.kernel.org, masahiroy@kernel.org
References: <20240222145819.96646-1-john.g.garry@oracle.com>
 <Zddt-U-6SdxkxqmD@bombadil.infradead.org>
 <51483aaf-d64a-4eee-b256-ab126483ad6c@oracle.com>
 <Zdy9gKO5Q6K4IE8J@bombadil.infradead.org>
 <ZdzGF9bxLn3Slbgi@bombadil.infradead.org>
 <cb0c185c-54f8-4b43-856f-685cc5ed3fc4@oracle.com>
 <Zd3cz7yYezir-P7e@bombadil.infradead.org>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <Zd3cz7yYezir-P7e@bombadil.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM4PR07CA0022.eurprd07.prod.outlook.com
 (2603:10a6:205:1::35) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|SA2PR10MB4763:EE_
X-MS-Office365-Filtering-Correlation-Id: 309ce7c5-9fbe-4d93-2f5d-08dc37945ac2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	APbVWNvuStV7lmxABSM/Q3YH976O9hVl+rWzXwU61igTIU1lLWraKXaB3r+cK0K2S1Gm3wW5UcEx9Y9Aat5hx3Zo1sAN9PYYmCTMUQLCQ9kS+i2G7xtV2dOos0clgnnDGApazIR+Au+ah+J9EshcI1H346+t8QDr0M9QpyJkrn/ZCYgm0B8b7qFZYLvcUfp56d5pVUDR7YUpf2uFgdA9+F+VL6x2q2UrH+zoZV/6ExTbTwoF5gV8agtHo3JS9Hbx1DjTqBzWTlA7DfqLGUBrTFnnajz6bmBcs1WKlPIUYHTq8UTvH7vabrTcrXipJQDsMgrVkOUmfo9F+3XOeroT4XE2RmELoKuG7Q5POY2RgvMvKeICP6WzSFOPatYlA/rbKHBYHmJRlmrG/ZHQp/hjshlGkBG+Yzr+Zp9yLMqk/fKE5VUzqhjlQl9j0w1usCtK8mQVp2cpmria0iXoJdLokHgeusnAyYuGPNwd7enGAmLE8ujNaZFfnuUR3XsSi+HW2ygLUk1gTazYh1tGsj6agztKrscgs1BpaJekl+3Bu4tMCnZ+geyzYEKC2IhYViVplKTNzjQLOuouKvo2B14kEcQuy3ypR/GzXmQfKpJUy2TaNujOYpFteyrFIFLiCOxxD9WWaDqU1cZVVp8gZKd3Tw==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?R1lrTjV3MUJNWmtqZWpsSmdhVnU0VENvNnN5R1p0YnJuNGowRkFmZ2NLMWc0?=
 =?utf-8?B?dnQ4Z2ZPL1czSk1YVHZPcHBGTGE3YnRscGN3RnlvWDc0U1FMZVlRM21TYkR2?=
 =?utf-8?B?bDB3ZjBpMVFCZW1ySGxmTGlHaklVcERtTUtCN3E3K1pMVzkya1ZzdXhBRyto?=
 =?utf-8?B?Rno1OENtczJZT25kTG41TVNkZ0pTYnMrOEF2Tm9XbFBWcFhzSXVld1BrZlNH?=
 =?utf-8?B?QkpTQXJZM3RqMzFuUHdmYU1hK3hBRDU5aVJKTVI4dVVoSE5IanZZTnlyZ2Vl?=
 =?utf-8?B?WmhVcWhLR1VYRXdDWnpjZFByR0hCZzVqaU5ET2Jzb2xaL3kyQmRrNkF0SVI5?=
 =?utf-8?B?ZVd4WFJjbys4Um40Nk84c3I0cXB6MUJBaXBuU1dmUmV2bGg3NlFXNThvVzl3?=
 =?utf-8?B?QytZZjZNNVN0c3h3WGVWNk9la0hEblNNbzl1SGRKK3VOT1RuR3JuWVJSc2Z0?=
 =?utf-8?B?NmE3dVY5TmhQQWZKSGgwR1BKQWZ4YjMrV0x6NGhrc0RGM20vU01sK1dmMlo1?=
 =?utf-8?B?Q0hvYzRIaUhtcUpPZGJEd05nTW5SczVYZEx2N3FqYzFZU0JMNEpUT0ROa2tN?=
 =?utf-8?B?Y01IRjJ0ZWRJbEVnR1RXY2dnLzJVY01JeWtLRHBndUdUWS9SVG0xNkNFY0lW?=
 =?utf-8?B?dGpUSXpROE0wck1YWCtpSkpURDNXTFdia1Fvc0RIdDVRNGJsL2tDVldveWY1?=
 =?utf-8?B?UG1ZVXRSdE5RMzV0RktXekJPWnZoV1hUdEFqU2VodEVwMEFDalhZbGsydmRQ?=
 =?utf-8?B?dkdtWGhOQXp1Szd1OUZCYlA3QTJaQ0tLN0tXUUZ5VG5ITUdlR3U1VFNZcWZ0?=
 =?utf-8?B?akJNZWV5cWN6UGRKeEplUnh2NjlsamRVWU82NVovcCtRUzE1UVozUmk2MHFD?=
 =?utf-8?B?dXg3Sm5pdnBCZmgzdFpzZUMrVkwxL2piUDVjdlBkemVyYnovWVRDcHRZVnhh?=
 =?utf-8?B?M3FGTVNXRW1XY1lvUjk4MmlPKzJPRzZlbnAzdisxS2lmdnV4elN5RHBoaWpE?=
 =?utf-8?B?WEZCMStVY0JLZ3MwdDc3U21mZFVXcloxY0gvWXhHdXlDTFNVWG1JOGpKM0lP?=
 =?utf-8?B?Vm1PUysxSWVUZFJKZkZJbFNBOWgzVVhBU084YmtJWUFYRU05S0h6UWNvZEtk?=
 =?utf-8?B?SlBSZm5iU1BGNFBKczJzUWRmNy9nb3dEMng2N0ZyeUdoTmJlTmNRY0pIMG01?=
 =?utf-8?B?aXgzRzhZUzBINGczZkV6RFNVeExRZlJMd3JVUWFuSUJjemJ1UDJBRXJ3b0tq?=
 =?utf-8?B?M0ExbDhaNVpiSCs2cHkwMlNzYlZVZElsYk5BK1NQR0d5Z0V3VmVuTXlDRkk0?=
 =?utf-8?B?dEFMbGxhdkhDWktxWlE5dklCUUt0SWV1QmwzamVsd2tTWm83NXBRMnAvQUcy?=
 =?utf-8?B?OWREVFcxNTRjbVMwTW1HR2lTT1NHWVFGUHVHQ1JjS2xCZXZsTk9UeVF3bEd6?=
 =?utf-8?B?WGJGOXdocXZWdVRHR2k0N0M4TEFMdEVaVWdYTzh0Y2t5RTZXLzRHODJvNkFE?=
 =?utf-8?B?TlhQeVMyemV5MjNGdnBUaXVSdlNEbjBack9xSWVXUC94WXppOTB5UWhUaVU5?=
 =?utf-8?B?V0JIZzFDbm9DSURtN2xJaVM3VVpoRUdUMDhkM1hITDVJcDQyUTJSVjdzdGto?=
 =?utf-8?B?b3NodHZLcDlTZ3lJNHduRGpMUmY3SGM4b2l1WFJTQW8ybEJCbTUrVWRML2Fu?=
 =?utf-8?B?LzR4RGhiTnBham5iOUJCdllNblpOU0NIQ0NTejllZnpteXliRThkeG1xdnZ1?=
 =?utf-8?B?eFBGSFNkaGFnSU4wUHRQYTk2TnE0UmoxczVzR0dBemYySDlaQzBZM2pBQVBC?=
 =?utf-8?B?OG9RbWdpK2V1NmlnNXRtVFBYUTNhOSt6UkljUzg1Q0oxcmhVMWFtbkpqL1J4?=
 =?utf-8?B?Q05TSUw3QXNhd1Z6RUNuSDNGWGtsL2pXcmh6MVpCWGhxbnAxcXlPcDNFM01x?=
 =?utf-8?B?RS9rUzZ2UWIzZGMrbFp1Y3JZNVE1ZWJaN0RUZDFHeDFXa2pGMDZYd1BPVjB6?=
 =?utf-8?B?RUMxQUJLNC82VlMyRVplTXhEdk5wdjVnd2RmZ0xDR3VKT2QrWktKeTBERHl1?=
 =?utf-8?B?VHI3RWhaTVNaSStjSXFLWUdZY1ZkS1pXejE3ZnFoalRDQkdmZWFkcEgxSWpv?=
 =?utf-8?Q?W6ud9+zglLPB91OUlbbq5vs/l?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	JX+rOIzgYpmRdU4ujidsRdTMpeA3VyLgxw9nMoc+H/CE94c/ALH2yvCfLw2LDcDOaOngCgyUtuIBtI8C5IE31ryawJXQaxiBYJXnrbeFwcqu8uPnZuR+CgW2jZQdF9nIoYkmbXQQG1rhG2kKrmU+Uv2RXWY1rAiWtQzXsrSeI6+5Fia2TIjOBppaWS4nylbphwPUn8k/RpPEY2/vksFv4MqWIXA+AT+6TLK6terRxNSSn5O2NHEF+VmUnBOezMOBvh+fhOWFVNA/fIixr3JJFrtqxSusYzPozj8wxRXmr80PzEA3UXOArlw9mOtvOjG8fKP0YlWnADUgZVuIdSjBKd/dagS2ra1dkvu+Nk1WO0zNllVX0P8JhvtTmQJNoIhK31iXpGYKXLUvw8uVpwNoNpHkTneoz0AqWDMqJ3uupVGc8OmxJe4u1lgTc5d249S03zQndb7LqK4RjKcKTparz8FL+RyeTV5PZgKlRgamIgEHLZI0sUwmRraMNxYDQty42d02S6RChzc88dsTdDmCSPAHg0QLO2eoQhg/S1TJTktQ1V2T327Hh9d+7FbmvvFl0kEM17tgbV6AiekUBhnNtShGXaFA8mP+WAy9bCrfk2k=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 309ce7c5-9fbe-4d93-2f5d-08dc37945ac2
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2024 13:02:29.9177
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UnwpfXf95Y6XdWs2wEWPkwgrjA6irDwX1a9XaDHPkVMHlIlv2ApWg2bEE2wCQ3CJCf6dRIgNOyEKBCj9xqhgzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4763
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-26_11,2024-02-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0
 adultscore=0 mlxlogscore=999 malwarescore=0 spamscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402270101
X-Proofpoint-ORIG-GUID: pN5lhhNR2Hl-KPwkuqjRAtt_uFC-cFFk
X-Proofpoint-GUID: pN5lhhNR2Hl-KPwkuqjRAtt_uFC-cFFk

On 27/02/2024 12:59, Luis Chamberlain wrote:
> On Mon, Feb 26, 2024 at 05:13:44PM +0000, John Garry wrote:
>> On 26/02/2024 17:10, Luis Chamberlain wrote:
>>>>> I am running this now, but it does not seem stable on a v6.8-rc5 baseline. I
>>>>> am seeing hangs. Are there any known issues?
>>>> I tested next-20240108 and so no issues.
>>>>
>>>> Lemme upgrade.
>>>>
>>>> Note you also need /lib/udev/rules.d/50-firmware.rules removed if
>>>> you have it.
>> I have this:
>> ubuntu@jgarry-ubuntu-bm5-instance-20230215-1843:~/mnt/linux2$ more
>> /lib/udev/rules.d/50-firmware.rules
>> # stub for immediately telling the kernel that userspace firmware loading
>> # failed; necessary to avoid long timeouts with
>> CONFIG_FW_LOADER_USER_HELPER=y
>> SUBSYSTEM=="firmware", ACTION=="add", ATTR{loading}="-1"
>>
>> So I can remove it.
> You can keep it on a distro use case, but for testing it is important to
> remove it.

ok

> 
>>> I don't see any hung tasks on next-20240226. Perhaps its with your
>>> config that it is triggered.
>> OK, I'll check again when I get a chance, but I am not so keen on checking
>> linux-next in general.
> What kernel are you seeing this issue on?

I was testing v6.8-rc5 last week

Thanks,
John

