Return-Path: <linux-kernel+bounces-105483-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EED887DF08
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 18:24:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A7601C20A38
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 17:24:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E31D1CF80;
	Sun, 17 Mar 2024 17:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=illinois.edu header.i=@illinois.edu header.b="cMhxm+c+"
Received: from mx0b-00007101.pphosted.com (mx0b-00007101.pphosted.com [148.163.139.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 047451CD04;
	Sun, 17 Mar 2024 17:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.139.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710696284; cv=fail; b=ZRztWN3+rdP1Wcy48JhKjkU0ATNL9oJjP9FDE0EIN6jM6b5EXbybWLELdQWsVEgicRMsXwsOGoJCgwviVzubMrdxcdRW4RC2MUn6Ww0dpx23NbCpeTYeGo4ZbkCmP9Tta+xDnAxSSVrKcI+trGM768NAN1ajTwjC5GnVtFDF0U8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710696284; c=relaxed/simple;
	bh=LxptST+lWtmxapSDw4SaB9DjeShl/u7FTr2ld5BRu0g=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lN3Ohg1BAOaW8CJIkNzvUjSAiTi7iw5mJIdrlyB1umRhTB0WExVORwjSWaO8rFrdPxSfJJRgv8ZXPaTvI4ABgBoom5N8bJHZIOgXb64TaHyC0Rr8OPSt18T/YYNL5IwzFkWs0bC9qOZqMJESJ83kwRZxAEGELOr6ghi7tL6HnmY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=illinois.edu; spf=pass smtp.mailfrom=illinois.edu; dkim=pass (2048-bit key) header.d=illinois.edu header.i=@illinois.edu header.b=cMhxm+c+; arc=fail smtp.client-ip=148.163.139.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=illinois.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=illinois.edu
Received: from pps.filterd (m0272703.ppops.net [127.0.0.1])
	by mx0b-00007101.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42H6iIUh015230;
	Sun, 17 Mar 2024 15:55:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=illinois.edu; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 mime-version; s=campusrelays;
 bh=N+qNy9qP5Eu/6koH5IbNcHiawHGudkea2ip9tdFSNmI=;
 b=cMhxm+c+qvzu28kTKPpMd9UCG7TTF7CV2PhFvwYkAx943Cli3kwsmyB3p2xby/asFYGn
 /AcM92PbNeNZE08tRK6JrbyaXKPs2fNEOlZ9VQQ/Y4gf6zYtcPH84UE58xO5xYdnETiD
 ImbJhgPb5sQ/AZaDNuYKCebmauqLtnHDhGmECGvbmtwpKFKWHDTr94dggX12QlU7N2CK
 aT3FI/xcPwwrmMSeN4aFzJVVRUdN9Tt5RQa3kOLcSfcpfnsyZeM7DXuhyxvYe+vX5iAk
 riJhy/Kv0GD6HsYih2jyjq0hPM890VqPuj1S7HXtSYlXc7eBNPCI59yUOqBOujUN9kUA 3A== 
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
	by mx0b-00007101.pphosted.com (PPS) with ESMTPS id 3ww1jf0mr8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 17 Mar 2024 15:55:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OnYCah3XKG0IMdIDnLgcLFn73ruWNWvGHcQwi09VKCVe2qzOmUA7sPrK6yytzrspZk71i6zONIDLPhI8cxOIsslvnKBagvazkSSZAjNLwQeyxW/BBe5EVnT+J61B6xqldTekNSN1JYU1c8iWOGhoxF8DeGGte4JWFzwP/big1ZxkK8z6pUiK3ekKZkVo5ci48CTMXdXoi3cO5cOLQ0t+UnmBXI8dUBjJWq7udbbOa2aXlMa1Tl/Csgvcb92f7POvmWoqQHna7KzJTRtjWU6xlzPQnLsjWVloGnPbvWgikYxz7LR8KNsgnN73DMlv3aKUT2FqpBDNFvVtSROAu9Qpcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N+qNy9qP5Eu/6koH5IbNcHiawHGudkea2ip9tdFSNmI=;
 b=g99os4yROUrPgIuXMyPzA73jU25BsgWpkomvibBW4lYUdEefAQ1P86cUjGG4mLzaZOFIFREwKDaqGy/lcNw/uWdpLSmKpvlVEmId7rQjb0756yedyDBB00/dnWMUeK9MiWkt3ozSDTxFMjYvtzjlojsfWY5QTldmU5qDx415VElGlHkrQpLyd3rGxMAQsglwYCBa9SCKn5+xsmDS4DpDhgKZm4kt8NF74IwdMRiP/nFiIHYFOX81CmJpddHeGazNcPxLZK4sPY7YqbbLZV650O+NznC8su/T/bJCxH6GD84cq93o1aZ/E3R76FzgT1yfvawQGHiaWW45qrLtAm5HKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=illinois.edu; dmarc=pass action=none header.from=illinois.edu;
 dkim=pass header.d=illinois.edu; arc=none
Received: from DS0PR11MB7286.namprd11.prod.outlook.com (2603:10b6:8:13c::15)
 by SJ2PR11MB7672.namprd11.prod.outlook.com (2603:10b6:a03:4cd::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.10; Sun, 17 Mar
 2024 15:55:12 +0000
Received: from DS0PR11MB7286.namprd11.prod.outlook.com
 ([fe80::157d:9e6e:b778:36f4]) by DS0PR11MB7286.namprd11.prod.outlook.com
 ([fe80::157d:9e6e:b778:36f4%5]) with mapi id 15.20.7409.009; Sun, 17 Mar 2024
 15:54:01 +0000
Message-ID: <12453ce8-0b78-4c1c-9aca-de4cc366e3e1@illinois.edu>
Date: Sun, 17 Mar 2024 10:53:59 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] kprobes/x86: Use copy_from_kernel_nofault() to read
 from unsafe address
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Qiang Zhang <zzqq0103.hey@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H . Peter Anvin"
 <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org
References: <20240315000753.a448251fce0291e041f76c13@kernel.org>
 <171042945004.154897.2221804961882915806.stgit@devnote2>
 <fb6919c5-8acf-4ee3-8fd2-1d483b274867@illinois.edu>
 <20240316224630.01bd6b91938720f5083e0d07@kernel.org>
Content-Language: en-US
From: Jinghao Jia <jinghao7@illinois.edu>
Autocrypt: addr=jinghao7@illinois.edu; keydata=
 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
In-Reply-To: <20240316224630.01bd6b91938720f5083e0d07@kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------0AVV8I0K2oitCsN8f0MLbkI9"
X-ClientProxiedBy: CH0PR03CA0192.namprd03.prod.outlook.com
 (2603:10b6:610:e4::17) To DS0PR11MB7286.namprd11.prod.outlook.com
 (2603:10b6:8:13c::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7286:EE_|SJ2PR11MB7672:EE_
X-MS-Office365-Filtering-Correlation-Id: e1e27214-7baf-4934-a4d5-08dc469a7703
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	gEkXOPy3ijcUb/+dnG3cua3wvWDVDjxEVcFgsmdUKD+VymjZVrkF94AHRMmioLCeXLRGDflwO1EBxnaBOKanLs57/FcZRTmOZPzY4aREYhLen2n4GkPH3XR4zaceHGpIcQMKBto8PyrfaMIBjBz6l78ABbfxfURdWLfY9lX0RZfBpjqCXVHvlxs1DfdY3e1U7qtD8AB9GbGqy/MwLhFyf9XIRT/+WAeyxZQdKY+pNyEN1JtyWXpvN9sc7esmjECZaN3wqZ1UQct3O4SjcbGzHOistFMmYGc4Rem0OfB9pUH9S2e8mqJ1Qz/0ZPA71K+WRpC1N7Jcy/hGRgEXIwv5LVSlDZ6djYPKsYLKmVS84PRcxbiJOst06oA9yrcMtL90awrVTiauXtVFhKeoBHTBP+ejZ3VruEX9t6fckhrExJke+jXFOcURjgX016S00IJDSOipyDuvSY0VYvlim5dFD1yqEmIQXGmFTvEPxADSTamvw9SRiw+RCmubTFNI+/45v42W9DtQ8ru179y17tUW5teuSWkxuHKbQO1bbUfm5e8QP5G7/dPSizlZd1wl2bwlLYCwvUR7xyBzLVviFRCRbMSFmVM0XrvBLVkVvFCOeFU=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7286.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(7416005)(376005)(1800799015);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?TnB3NlFUOWxHR3pRRk04bk5iVDFsS0U3RXNMRCtRenNaSllPVkZyaVRLaEkz?=
 =?utf-8?B?bHV2WHNZS1ExZ2M3VHB1bnIzaTZmTmhjY3FZblkyNStzQ2tuWU1tdFdhSS9H?=
 =?utf-8?B?VCtDWW1xTXlvUi96cnR1d25kangzWDRNNlhKb1ROeHJJa0hiVkZjTDFPeEdJ?=
 =?utf-8?B?ZWRtY25IS25HT1hDWjJWZVVXSGVldXBuUXdFbjBwWWlTdjUzamhVb3ErYWti?=
 =?utf-8?B?eEsva3Y1RUNkd2tPb0FzUWNhYzkxL0lET281WUdoUzRXQU9XMWgzNXhCRjQz?=
 =?utf-8?B?blVlQjhqUW5tQk1FL2d4VDhUOEdVR3lxWk9JaUNVZDhYK3h5eW54bUxIUXc3?=
 =?utf-8?B?c1l6RUxoRUVCRW8zRG9CdmJidTh4V0MzbW1rZUJlLzBSV21WQ2MrSzQ1am9K?=
 =?utf-8?B?WTBCTDlPekZEVEl5RHBSY1NDcGhSa2d5OVB2N3FlcmNXOG8rK21kVk9oYzNE?=
 =?utf-8?B?UXo0bHZTcDlQcndsaTM1SFdzb0JoWG5xTkkyOHhyRDJjbzVZWVBwODBmb29r?=
 =?utf-8?B?S3FIOEVHeGZ3VE1XeXRlbWhPWktIYUUxclRVeHo0VWZVZ2dmcWFsMXEwazBa?=
 =?utf-8?B?THZYYTJzcGd2TXIxd2ltcys0VjQ1TnNZV2J1bVdOcHg3azNJMHp1Q292QXVL?=
 =?utf-8?B?L0gyU2NSaUVjcG1iU2tJWkRJMDUrTm1CT3JhcmNNR0VSRkY3OHlONVg4LzFY?=
 =?utf-8?B?dTZTWmlaRWI0dmhoQWtDaVYyRzM2QkhNTWs4MUlJbVBOaHNPbWJXZUlweUt1?=
 =?utf-8?B?NkIxdGhFTUNxTUMrSDBlUEd0MUdQRCtxWVd4Zis3cm1Sb0d4d0x2T0NxMFJC?=
 =?utf-8?B?SnBEWFlsaVJ2aE1veCt4R3AxaEJhR2F1RDR3ODBOL3NkcTBtOXN1TDNXODBv?=
 =?utf-8?B?WmJZdHhGajl0TTFpMzFYRGY5bEFkL0lqdFU5VUpsUE5tdWU4ZWFpNW5xbldy?=
 =?utf-8?B?YTJ5VUgyRkFyKytMcFE0UVdqY2Jrc2JRRlBDeVp0S2JFdzV6aVFQdk1ndDlp?=
 =?utf-8?B?aklXWDZ1ZVAzWWU3Tmo5WlpnN09FZWFHRUlJdmZuYkVSUE9Xb0hrT0ZzMUZK?=
 =?utf-8?B?a2hXQXZmV2xEZEFtSXdpNDl2YTF0Y1p2dWtQR3NsRzhPM0RkU2xaUld0ZHlm?=
 =?utf-8?B?YlNNTW1wVFpVZUxCbmZSSFdzaTlmcWczTFdwNVVzdnNYTm51dUpQTmpnemt4?=
 =?utf-8?B?L2Y1OXlXWGtHQU5UaHY5b3YzOFdBNFEvcEpBeFRBcjVqVUV6WWRCd3JuVU5F?=
 =?utf-8?B?NDF6RGxYTkllL2IyaCt1bDRENWp6V3ZLL1BEbXJkYkMzWWM0Y21OR3pUQm9P?=
 =?utf-8?B?Tmw1cTB5bmJaWDdTMzNSbmluQ1o0ajNFZTRzRmswZGVFWHN1cW9YUjlrZGJa?=
 =?utf-8?B?ay9oNWlKTWRUVXhWS3NBY0ptNEx6T0V0ZStDUUdoZHNLL3gzTVJVbFkvMmJP?=
 =?utf-8?B?SG1xL2NSRk9VQ2Rmays1clNsbmsrcGJjZjdOZ0tQMi91cHNBVlVFYWV0N2c5?=
 =?utf-8?B?SS90WG5jU0VVaWJRM1BudjRqUTNVUXJZZnlwOHY5VXRGMVNiUE16cXZZZkxU?=
 =?utf-8?B?WEdOSFRiaEpmUC9jRGdwdjFBR1Y4MHFxSnIzcGR2emlSeCszT3I2QlVvZmtw?=
 =?utf-8?B?RE14UEpFZko0RUFlTks1TGMvNnZmZWJ0bitMOC9saEtaWTdaNHRLdnYwMGp2?=
 =?utf-8?B?N1I0Rmd3WXcyRzd1NGROTW8ybWRUK1FRU3Z5NjVPZ0Q2ZFphNTRCZmE0WlVu?=
 =?utf-8?B?UkRjOXM3NDJLMG9rUGx1TnBBM0pzV1Z1VWVLZjBuQlkrWDVZbXh4Q2M0MUZI?=
 =?utf-8?B?OXo1MHlaSnA0N1BWRjVUN2ZpSnBreDNQdTlZeTRucngySkhKdFVsLzJSS1lJ?=
 =?utf-8?B?cWExZzE1aWV3M05HaDdkc2hzRXJXRmZxRG1TNnB1UE5tQUZNTlBSY0pUV3ZW?=
 =?utf-8?B?MGJwVDlpTGNPR1hCU0lzNTJ6a3dTRTJXdkpzYnVqcUxXYmJUY0NuQmpmdElS?=
 =?utf-8?B?d1dNT1dLYjRyWmx3d2VVek1LaC9vcVpqbytXMmZOc3AvTzl1TjhsZDlQRTcw?=
 =?utf-8?B?cTBYWFNNekJYNHZiYXFCaTU4cUY2RG9SUE93UVkxSmRWcVltYWkyK2ZEUFVo?=
 =?utf-8?B?bkR5MisyTnNaZWtoUnFKbHpJUTlwMjR1TC92a2tabnQ3WkNLZnlKOEhDdGZr?=
 =?utf-8?Q?QxYMqRvlKxvPKhYFRDWxIZpdQmydzMlI/iJy1vpJsWCo?=
X-OriginatorOrg: illinois.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: e1e27214-7baf-4934-a4d5-08dc469a7703
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7286.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2024 15:54:01.6812
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 44467e6f-462c-4ea2-823f-7800de5434e3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xtEZ8OCtInMrRG31C8iGh6WrbaY0ufW3G2MUWM8yVdAr30zUQUqU2NfYlLDQYUi/8RKGuOYtr+TjaxL+l6GKRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7672
X-Proofpoint-ORIG-GUID: WdBJBtG7FV49pObaBo-Gcf5mkJ3FNvxC
X-Proofpoint-GUID: WdBJBtG7FV49pObaBo-Gcf5mkJ3FNvxC
X-Spam-Details: rule=cautious_plus_nq_notspam policy=cautious_plus_nq score=0 phishscore=0
 bulkscore=0 spamscore=0 adultscore=0 mlxscore=0 malwarescore=0
 mlxlogscore=999 impostorscore=0 priorityscore=1501 clxscore=1015
 suspectscore=0 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2403140000 definitions=main-2403170124
X-Spam-Score: 0
X-Spam-OrigSender: jinghao7@illinois.edu
X-Spam-Bar: 

--------------0AVV8I0K2oitCsN8f0MLbkI9
Content-Type: multipart/mixed; boundary="------------un0QyYflrBZMKRZTnFZ8EihV";
 protected-headers="v1"
From: Jinghao Jia <jinghao7@illinois.edu>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 Qiang Zhang <zzqq0103.hey@gmail.com>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, "H . Peter Anvin"
 <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>, x86@kernel.org
Message-ID: <12453ce8-0b78-4c1c-9aca-de4cc366e3e1@illinois.edu>
Subject: Re: [PATCH v2] kprobes/x86: Use copy_from_kernel_nofault() to read
 from unsafe address
References: <20240315000753.a448251fce0291e041f76c13@kernel.org>
 <171042945004.154897.2221804961882915806.stgit@devnote2>
 <fb6919c5-8acf-4ee3-8fd2-1d483b274867@illinois.edu>
 <20240316224630.01bd6b91938720f5083e0d07@kernel.org>
In-Reply-To: <20240316224630.01bd6b91938720f5083e0d07@kernel.org>

--------------un0QyYflrBZMKRZTnFZ8EihV
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 3/16/24 08:46, Masami Hiramatsu (Google) wrote:
> On Thu, 14 Mar 2024 18:56:35 -0500
> Jinghao Jia <jinghao7@illinois.edu> wrote:
>=20
>> On 3/14/24 10:17, Masami Hiramatsu (Google) wrote:
>>> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
>>>
>>> Read from an unsafe address with copy_from_kernel_nofault() in
>>> arch_adjust_kprobe_addr() because this function is used before checki=
ng
>>> the address is in text or not. Syzcaller bot found a bug and reported=

>>> the case if user specifies inaccessible data area,
>>> arch_adjust_kprobe_addr() will cause a kernel panic.
>>
>> IMHO there is a check on the address in kallsyms_lookup_size_offset to=
 see
>> if it is a kernel text address before arch_adjust_kprobe_addr is invok=
ed.
>=20
> Yeah, kallsyms does not ensure the page (especially data) exists.
>=20
>>
>> The call chain is:
>>
>> register_kprobe()
>>   _kprobe_addr()
>>     kallsyms_lookup_size_offset() <- check on addr is here
>>     arch_adjust_kprobe_addr()
>>
>> I wonder why this check was not able to capture the problem in this bu=
g
>> report (I cannot reproduce it locally).
>=20
> I could reproduce it locally, it tried to access 'Y' data.
> (I attached my .config) And I ensured that this fixed the problem.
>=20
> The reproduce test actually tried to access initdata area
>=20
> ffffffff82fb5450 d __alt_reloc_selftest_addr
> ffffffff82fb5460 d int3_exception_nb.1
> ffffffff82fb5478 d tsc_early_khz
> ffffffff82fb547c d io_delay_override
> ffffffff82fb5480 d fxregs.0
> ffffffff82fb5680 d y                    <--- access this
> ffffffff82fb5688 d x
> ffffffff82fb56a0 d xsave_cpuid_features
> ffffffff82fb56c8 d l1d_flush_mitigation
>=20
> `y` is too generic, so check `io_delay_override` which is on the
> same page.
>=20
> $ git grep io_delay_override
> arch/x86/kernel/io_delay.c:static int __initdata io_delay_override;
>=20
> As you can see, it is marked as `__initdata`, and the initdata has been=

> freed before starting /init.
>=20
> ----
> [    2.679161] Freeing unused kernel image (initmem) memory: 2888K
> [    2.688731] Write protecting the kernel read-only data: 24576k
> [    2.691802] Freeing unused kernel image (rodata/data gap) memory: 14=
36K
> [    2.746994] x86/mm: Checked W+X mappings: passed, no W+X pages found=
=2E
> [    2.748022] x86/mm: Checking user space page tables
> [    2.789520] x86/mm: Checked W+X mappings: passed, no W+X pages found=
=2E
> [    2.790527] Run /init as init process
> ----
>=20
> So this has been caused because accessing freed initdata.

Thanks a lot for the explanation! I have confirmed the bug and tested the=

patch with CONFIG_DEBUG_PAGEALLOC_ENABLE_DEFAULT=3Dy (which explicitly ma=
rks
the init pages as not-present after boot).

Tested-by: Jinghao Jia <jinghao7@illinois.edu>

--Jinghao

>=20
> Thank you,
>=20
>>
>> Thanks,
>> --Jinghao
>>
>>>
>>> Reported-by: Qiang Zhang <zzqq0103.hey@gmail.com>
>>> Closes: https://urldefense.com/v3/__https://lore.kernel.org/all/CAKHo=
SAs2rof6vQVBw_Lg_j3QNku0CANZR2qmy4eT7R5Lo8MFbg@mail.gmail.com/__;!!DZ3fjg=
!_C9Dn6-GBlkyS2z34bDUBsEXkTkgWp45MNrd4Rl5I5slz2A3SrurXOxKupsxLMqxC2BMiySC=
TfB2-5fPhkLP1g$=20
>>> Fixes: cc66bb914578 ("x86/ibt,kprobes: Cure sym+0 equals fentry woes"=
)
>>> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
>>> ---
>>>  Changes in v2:
>>>   - Fix to return NULL if failed to access the address.
>>> ---
>>>  arch/x86/kernel/kprobes/core.c |   11 ++++++++++-
>>>  1 file changed, 10 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/arch/x86/kernel/kprobes/core.c b/arch/x86/kernel/kprobes=
/core.c
>>> index a0ce46c0a2d8..95e4ebe5d514 100644
>>> --- a/arch/x86/kernel/kprobes/core.c
>>> +++ b/arch/x86/kernel/kprobes/core.c
>>> @@ -335,7 +335,16 @@ static int can_probe(unsigned long paddr)
>>>  kprobe_opcode_t *arch_adjust_kprobe_addr(unsigned long addr, unsigne=
d long offset,
>>>  					 bool *on_func_entry)
>>>  {
>>> -	if (is_endbr(*(u32 *)addr)) {
>>> +	u32 insn;
>>> +
>>> +	/*
>>> +	 * Since addr is not guaranteed to be safely accessed yet, use
>>> +	 * copy_from_kernel_nofault() to get the instruction.
>>> +	 */
>>> +	if (copy_from_kernel_nofault(&insn, (void *)addr, sizeof(u32)))
>>> +		return NULL;
>>> +
>>> +	if (is_endbr(insn)) {
>>>  		*on_func_entry =3D !offset || offset =3D=3D 4;
>>>  		if (*on_func_entry)
>>>  			offset =3D 4;
>>>
>=20
>=20

--------------un0QyYflrBZMKRZTnFZ8EihV--

--------------0AVV8I0K2oitCsN8f0MLbkI9
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEE2/ZzTtJDFIshN/BBL9huahcPNUYFAmX3EhgFAwAAAAAACgkQL9huahcPNUZG
LhAAnIwH2dcu5iYju1ArWH9DT76NEc/zG2LBVXzmLhxlGnfmC3u/QsL9Ul2HE3afICMM0DpjkgGy
wIwFJ1gk0GLHwWtipIltcrHnbyyKRFTEup4FPqUXnI7jZhz3/xsbwvvb7/dgazVgKjqXd8Ysn6e6
jK2OFXlOWUqbHmVBk8htLy0S6yP96GFj20nD/pL7wQztR9RnQ+q2hrReE8o4ugkCkkw12bqMIMyi
mjl6420UYzQ6tSk4iY9eK55mu/mygOtILcs/0h7b9yPyxB32cbukETCVjPPOYEQNcbP4hP/3/l9i
12Oa327gMRNyTa1P7XsPlUk1A2/nv/dBL2i5jktfWTpwJHRJWM+nxktmzrfMoZeO401A4mdU1X1h
E0xgZklgYtjTjG/5h9GptkL6eVMgpCVYTIbx82fC0Dp+Z2AOLdR9XjCWdujGUCdJP9amQIzE2lh9
iw10K4yIWvlxpCUZf9kKuB/VMVYNtsOW0yhLUPCxd4+58dwWh9OG/wVC0sPF8IyrXkU5PpJTyZLp
xQZOnNAvlIZBwOPEsGqPXhOzohx40+Au8Q53Sc2JusmQT4q+JOyfO+zJjqyJVLG8KUbtlYV8d1+D
lTzIbwYHlW/Oj7CDqdeG4gGlJkcXCIZm5/i5ZEYZpGjo75pB9GeX8JK5ynLzfKqzefJaOEHps66f
Lrc=
=zLH+
-----END PGP SIGNATURE-----

--------------0AVV8I0K2oitCsN8f0MLbkI9--

