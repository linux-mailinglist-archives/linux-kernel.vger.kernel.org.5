Return-Path: <linux-kernel+bounces-41971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 95AF983FA27
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 22:31:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B9231F2201B
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 21:31:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 947573C46D;
	Sun, 28 Jan 2024 21:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=illinois.edu header.i=@illinois.edu header.b="DXLvMv1G"
Received: from mx0b-00007101.pphosted.com (mx0b-00007101.pphosted.com [148.163.139.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 364B63C46B;
	Sun, 28 Jan 2024 21:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.139.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706477475; cv=fail; b=eUmVmvQLINvD+hLWFqbtKaqLMepcZYM3xAMVRZZIw6KXqgMA9lG7qTamNmATME63Rjp47ToHHZLiLtDWePWVsWeWin57s4yfyXU1Smgr6mv6tOuiJTjb+XNKBh4LyizZ1sM5uP9vqt5niYIqvR5PexZVv3tbfWjCwt5Ke6I5Tcw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706477475; c=relaxed/simple;
	bh=XnE57sQWwUZWyfEang9NPwrzJI22pwubYPkYqfT0kvI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=guZSBKLuZpTXM+ow3QZQ2b4SbuzRbF/acv8hc4NDSOy4JuS8yWL23eUF55EbMTJSaHKATz37GRU+Haxhtnrxdmu85HkuL6OQiwxyMVaeJCDcqHHJcbGOrF1uMleYk4oxMFk6+ZUwUljRI9NLEDpZ+fTIr2RYdoWzHyH/tGjc/eg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=illinois.edu; spf=pass smtp.mailfrom=illinois.edu; dkim=pass (2048-bit key) header.d=illinois.edu header.i=@illinois.edu header.b=DXLvMv1G; arc=fail smtp.client-ip=148.163.139.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=illinois.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=illinois.edu
Received: from pps.filterd (m0272703.ppops.net [127.0.0.1])
	by mx0b-00007101.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40SK8IAo008229;
	Sun, 28 Jan 2024 21:30:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=illinois.edu; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 mime-version; s=campusrelays;
 bh=Zjgmg45n4vN+chtzGyQx7da5sNQe3VGZGZ0ZMZm+I2w=;
 b=DXLvMv1GvpaE3sqU1E+fwUuMjtyFfKTMYD9YRsxKdYw5CUj3i84vZaqi15rkqcQQ65pW
 pCVIxVLqEny0+YrcBnB1HQfI7tVbcoh08UN/r1gdO7Vmhq5MFHfkpdaEiQQCIQz6KcAu
 kDV16J/0H9noD8rp4kaO0rYxpbwG5Wgs4jgADW3HoMDt0oBuhGF7IF/RF5sDi1rX7rCa
 Mb5g4WfRt2ZAXWQ2jtF5WIEsXCFYyCgDixzHpf5ySKBs62ZmGXtMnsbZ2FAs8qaEYPLD
 z1JPW8PApUU3j+7LiGd01y1XTMqBHqBDe/7CfN0OSUP4GI5CzZKiw6RT3nDpToDseMwH RQ== 
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
	by mx0b-00007101.pphosted.com (PPS) with ESMTPS id 3vvqyc8ywe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 28 Jan 2024 21:30:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EXxyk9ATuqeymwfpv/4t6tD0b7LyVlxS3U+xfcCGD1Oo/hRKJg66aSrI0u42RTrlXszqjKwyPx/XtKcw4D6Ta9WHYT6SG/eiwddz3kvjwkfL7x3YGp2RlCzJyf3sQzQ6wKOPSfWydQzi0wPBOKe8hOUi+VYsoMJT4m2QHFz0oyoB88jLAogBrbMZAu7CdOOAIO90JONfE/qiqbuhTedQcJ6bqh1tL/4eJHoePDKOpEx8jfyeowvy45puG75Vbw5oRBdAHJwXqitbRbY2+raLf4UYxmlPqlIIz1v8dSuREyhkKzVaJbPtbj+RI7+CGGh3zRwIh0EOJBaIVvFyuJVa0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zjgmg45n4vN+chtzGyQx7da5sNQe3VGZGZ0ZMZm+I2w=;
 b=YWG+hI0bkKmey2vQo0L5CLDLjtwYRpMWO5iviAIYNJfzWnn5q8Ddve03DDx6ETEDiy7+qILDiFkN6z4cei+qjSFaxnB6VWRrcLK4+qqxNdSZnIj8F7kl2zePJX0A39DtxcjF5NouvcW4sKXijb4ygt8BWwN+qrG43VVqbUgrzkngwQkTQgwE5FHFVtQClYOz9nQsexj/dZUIMY6xT2Td5901iFcKS1If/gfUh65aO53dKP5tp82GHRw0Zplsqp3y55tk9CCI0FJJ7xsVZPcBbBAGJy+VKqH4whSga3ercoIAU35+ateTEfBWKewdC+jmzLM+kio7fJuXtQ9rWZ6SNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=illinois.edu; dmarc=pass action=none header.from=illinois.edu;
 dkim=pass header.d=illinois.edu; arc=none
Received: from IA1PR11MB7272.namprd11.prod.outlook.com (2603:10b6:208:428::8)
 by BL1PR11MB5956.namprd11.prod.outlook.com (2603:10b6:208:387::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.32; Sun, 28 Jan
 2024 21:30:52 +0000
Received: from IA1PR11MB7272.namprd11.prod.outlook.com
 ([fe80::3b5f:2696:825a:bd34]) by IA1PR11MB7272.namprd11.prod.outlook.com
 ([fe80::3b5f:2696:825a:bd34%5]) with mapi id 15.20.7228.029; Sun, 28 Jan 2024
 21:30:52 +0000
Message-ID: <9aace649-8a84-46ba-9092-0b74523147f0@illinois.edu>
Date: Sun, 28 Jan 2024 15:30:50 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 2/2] x86/kprobes: boost more instructions from
 grp2/3/4/5
Content-Language: en-US
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240127044124.57594-1-jinghao7@illinois.edu>
 <20240127044124.57594-3-jinghao7@illinois.edu>
 <20240128112218.5501726d17ac2fde2502da44@kernel.org>
From: Jinghao Jia <jinghao7@illinois.edu>
Autocrypt: addr=jinghao7@illinois.edu; keydata=
 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
In-Reply-To: <20240128112218.5501726d17ac2fde2502da44@kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------tEsy2aZBJmvTdboE8xGpibrg"
X-ClientProxiedBy: CH0PR13CA0037.namprd13.prod.outlook.com
 (2603:10b6:610:b2::12) To IA1PR11MB7272.namprd11.prod.outlook.com
 (2603:10b6:208:428::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7272:EE_|BL1PR11MB5956:EE_
X-MS-Office365-Filtering-Correlation-Id: d90a88e2-e0d2-457e-fd8d-08dc20486764
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	zblShZR7Pjtnaa2BHPTLDLrK7zkxLv3SmV2gR2ZlUdsClepfXmPJDRrASRvBdM+u8Xoz1SeGjO6zV6Y9+CBZF3+XeKdRz/Y7793qGyy8dwcJKBbCHkKGU0qmdFpo+andVNFUivR+R8QIvAdvJyra1cgC3B3abl9ONd+0EBKzZknJV7uBEN+u9ihlfDMxR8zhKbkfLBFelSAojOrk339dbpqMizbBl5HPZVnd9nOV/OEk9hJtpNf1tGY1sEHn0Ok4bA9QcsjSfl7+8Z7SxWyEFDhXzwKIEfVtVcsUeTLcCajG4gzZiJdxphs3jPFJDdqtd1EldG2XubFQzujmKSYcZxuvZY4GW1nODtJvLRO8/039EWWduMU9kElSGNcQWTDthE7rxS+aVIFikPfXfOqMFPoBXbeVdRKV+r0XjQgYYLhXfSvxsN0bN5kfezIlne6fXDu6+wNmatpYUPuX1H5ifbOyabl3hHQ/4Di3yJOHprOK0xPdOwmke4U7EZHJGTBL3kLt7XYl+0OzuVZ9qDmlirQgtU0UJrL40SL79UiEg5qNLGXscPD8VHRnBr9+0zOmMb9KoU1qF6A5OfhW3AIeOCpE9tNP6cUPdMWhn4mLHGm3maSgSmFMcHE/hdMKKtgQpMwugASs44Gn2KB+BmpCYQ==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7272.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(366004)(39860400002)(376002)(136003)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(31686004)(83380400001)(6512007)(33964004)(6506007)(21480400003)(53546011)(36756003)(86362001)(31696002)(75432002)(7416002)(235185007)(5660300002)(41300700001)(4326008)(8676002)(8936002)(2616005)(38100700002)(66946007)(66556008)(66476007)(6916009)(54906003)(6486002)(2906002)(786003)(316002)(478600001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?WkVHaTNDeFVaa0w0Mm92MUEwdlVvSXByVUJUTU9JMTV3ZU9UYXlBeG4vSlEv?=
 =?utf-8?B?cGdESCtVK2VpQXJTdk5nZy9oODV2V21pYSt6N2ZWYWI4RzFYRW5QWERiWjFL?=
 =?utf-8?B?SlZjQnM4SXFXczBDUTkvOXRBdXlHd2treWlNTnFXZmpKNGxwTk1vR2wxUlRV?=
 =?utf-8?B?UXZNbjJrUDJicjAyc2JYUVlwT3RVcVYxSEJGaWNiUGN5MDV2eVVsd3ZRT3Z5?=
 =?utf-8?B?SGRTeCsxNTFxM1FDTEU2a2dEazFTS05tdVo5QVM3emJmUlkvVlNhaEdMKzdr?=
 =?utf-8?B?aHFqK0Z1R0VsOXhkNXZMbkFaY21rN3Z5ZUdlZG42RzJZbFE0RmJZeXI3OHdm?=
 =?utf-8?B?Y2VRblMyc2xHMTVWWE5mZ05QbnA1MjRSbXJMR3ViVTRXYVFYbzRBc2xLbThS?=
 =?utf-8?B?YlRNWVc3aXJQaHZENXZWeUhRWmxvbWU3T1JBeTkxT3BZVlRLaUZybUlwNStS?=
 =?utf-8?B?VnREaUxTZG5rZnZBWnAyeTBXSW5ZTS9xWVVLUTZYNHdLR3VGdytFZVl6Kzlo?=
 =?utf-8?B?ZURZdW5td0xKZld2T3ltNjcwd2VQc0VaTXBERldSZFBlQ1BiRHF5TEZWUU4y?=
 =?utf-8?B?dHdvWVAxVXRvd0FpN1EzUXVYSzdxV00zMi9reHdaMEJFdTd2R1cvK2p4SGRv?=
 =?utf-8?B?MitEQ2dQWlo5QW8rZVNnWmdTdXpRTkF1amppQmsyMm5nTStIM08ybXlhcTJF?=
 =?utf-8?B?aTRnN1AvUjlMNkNGV0VkZ3JPUy83eW81QTZTUXJDUFg1dmFqQU1rNzRYWXhZ?=
 =?utf-8?B?cXAxSE9YeVlwTzVTSjFEZCtJcHl5Zm94Tm1pcGtkNWp6S3Zybm12MjRzV3NX?=
 =?utf-8?B?NHByKzNycnRiK1VRVndqZ3lUTHlpbFRRLytJYjNqNmpmckVNWE1YVjZhcnRi?=
 =?utf-8?B?bHc4R1U4ZVA3N2tPUDdYd1ozVFFoTVp0ZXl4aTlzOTE5UkZ2bXR4MUdZMnB6?=
 =?utf-8?B?RDBBaEE2SGJ2RnAxKzRMcVZwRjBBVGhlSXZURVdLNTRRcEdyYjQ5WERLcUdm?=
 =?utf-8?B?aGxUZ3llb1J3UDVxOHppcjVVMFVCZmRSOXRzTXQxYTlEblJwNkhvOE1QZFlE?=
 =?utf-8?B?OGJSK08yWUxMN0twS0NCRkxKZVg0QXFINFdxZHNJT1p6bEJOQ0xmWGJydURB?=
 =?utf-8?B?OXM5bWlUemw3M3FBTG40ZGNjOGZDTWxlNmU4THBDQTlXVWQ1Z1MvTWY5QkVr?=
 =?utf-8?B?cm4vOTh5YkxqbWcwd3ZybjBvdk50VHVQc0h0K2ZXMEpkcXFKK1Fobmg3eDVj?=
 =?utf-8?B?MGdjM1N4ejJwYnUwMlF2eWI0NDZWSFhUaTRFVXk4Si9ZUUNJV0lvdjdMQzRX?=
 =?utf-8?B?WS95NFJIZXhuM0M2NGtxT1VQVnFQaWhtY0cvT0xyWFJPNXRvTVpMa3dyMVhj?=
 =?utf-8?B?VGw4RjR3Q0xRR0JVV0thODd4LzBIZXErc2JraFVvWVkvZ1BTSldLRWdEZDRP?=
 =?utf-8?B?TDZXcXBKY2xXRDROUndUSnNXZEdBYzhQd3lzV3ZPN2pyTjhCUmNTNXVOcUJm?=
 =?utf-8?B?Q0E0cVp5NDBwTDhzZFFKQTBtU3FLNENrZk1Oc2dkaHRZR1FseWJ4eHAxenZj?=
 =?utf-8?B?L3NIcFExMDVRY2NTbGxhcTVEcjVUenhsQnUzOFBLSkJ1VWp3R1N2V1lBNjRR?=
 =?utf-8?B?bkJhbC9BRjZhdFdRWjVDckV1QlVtZTRaaXJMTldPeUtHbFBYeGNCV3lJR0Ev?=
 =?utf-8?B?WHJoTDlsMGQrM2pONWVYZ0lTUjVMR2w0eGhrNG1rSEJQRk5hMWp5Wkc4VnV3?=
 =?utf-8?B?MG9PQndmQVNBaTRSbVF3MWRqUmJETXlmczA1QUNEeUp6VHd2NWlMNzMvQVJ4?=
 =?utf-8?B?dCtxU003ZUZPUzkxbUg3MVVaamNRZGpPSUlMTGxnTm5TdXJtWUxNa3ZDM0dj?=
 =?utf-8?B?NXRCY1R5TkRWQkhPUTVqaUx6cm1odzJJRDFJcXFvaXJDRWZwRTk5QXkwME5V?=
 =?utf-8?B?ZHpqeVRJMlk3aDZDZnBBR1VHclhmQVplbXZNQXhzR2ZGRlVueFZVOUptMkdo?=
 =?utf-8?B?djRjYlllZTRPVmtNQ1Fnakc2VHRpRkppZFp1ODB5U1FvRGNEYkh0eTJOcnlG?=
 =?utf-8?B?SE1uTXU0WllGSEdOeWNTUzVXd2hPTkFwdCtWRm9BV1pJdVRpN0dGaVc4cVoy?=
 =?utf-8?B?aGZVNXI4NWFxRjNIbHc4M3V0MmhXVnJyL0Nxd1JXZ1R2TlFyd2FIK2NCZWhk?=
 =?utf-8?Q?R9I5CS8ecZjhz1kiMywkuQ4EppBMGabZvd9+jUjSSjBu?=
X-OriginatorOrg: illinois.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: d90a88e2-e0d2-457e-fd8d-08dc20486764
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7272.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2024 21:30:52.5356
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 44467e6f-462c-4ea2-823f-7800de5434e3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z1Oiqhd6nd9N4WdxUH7MB6CjFDkglol0QPxZ7anq6bEn7wFJWKZtCMylSrUE9NVVMxsr2L25p3G1ilMLYeV4Ig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5956
X-Proofpoint-GUID: XpEcnGfyTU750660mpQ9JX14iyHiU1j2
X-Proofpoint-ORIG-GUID: XpEcnGfyTU750660mpQ9JX14iyHiU1j2
X-Spam-Details: rule=cautious_plus_nq_notspam policy=cautious_plus_nq score=0
 malwarescore=0 clxscore=1015 mlxlogscore=999 spamscore=0 bulkscore=0
 mlxscore=0 phishscore=0 suspectscore=0 adultscore=0 lowpriorityscore=0
 impostorscore=0 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2311290000 definitions=main-2401280162
X-Spam-Score: 0
X-Spam-OrigSender: jinghao7@illinois.edu
X-Spam-Bar: 

--------------tEsy2aZBJmvTdboE8xGpibrg
Content-Type: multipart/mixed; boundary="------------Zpi1PiNMEODEAj5fSV5QNyUB";
 protected-headers="v1"
From: Jinghao Jia <jinghao7@illinois.edu>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
 Peter Zijlstra <peterz@infradead.org>, linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Message-ID: <9aace649-8a84-46ba-9092-0b74523147f0@illinois.edu>
Subject: Re: [RFC PATCH 2/2] x86/kprobes: boost more instructions from
 grp2/3/4/5
References: <20240127044124.57594-1-jinghao7@illinois.edu>
 <20240127044124.57594-3-jinghao7@illinois.edu>
 <20240128112218.5501726d17ac2fde2502da44@kernel.org>
In-Reply-To: <20240128112218.5501726d17ac2fde2502da44@kernel.org>

--------------Zpi1PiNMEODEAj5fSV5QNyUB
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 1/27/24 20:22, Masami Hiramatsu (Google) wrote:
> On Fri, 26 Jan 2024 22:41:24 -0600
> Jinghao Jia <jinghao7@illinois.edu> wrote:
>=20
>> With the instruction decoder, we are now able to decode and recognize
>> instructions with opcode extensions. There are more instructions in
>> these groups that can be boosted:
>>
>> Group 2: ROL, ROR, RCL, RCR, SHL/SAL, SHR, SAR
>> Group 3: TEST, NOT, NEG, MUL, IMUL, DIV, IDIV
>> Group 4: INC, DEC (byte operation)
>> Group 5: INC, DEC (word/doubleword/quadword operation)
>>
>> These instructions are not boosted previously because there are reserv=
ed
>> opcodes within the groups, e.g., group 2 with ModR/M.nnn =3D=3D 110 is=

>> unmapped. As a result, kprobes attached to them requires two int3 trap=
s
>> as being non-boostable also prevents jump-optimization.
>>
>> Some simple tests on QEMU show that after boosting and jump-optimizati=
on
>> a single kprobe on these instructions with an empty pre-handler runs 1=
0x
>> faster (~1000 cycles vs. ~100 cycles).
>>
>> Since these instructions are mostly ALU operations and do not touch
>> special registers like RIP, let's boost them so that we get the
>> performance benefit.
>>
>=20
> As far as we check the ModR/M byte, I think we can safely run these
> instructions on trampoline buffer without adjusting results (this
> means it can be "boosted").
> I just have a minor comment, but basically this looks good to me.
>=20
> Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
>=20
>> Signed-off-by: Jinghao Jia <jinghao7@illinois.edu>
>> ---
>>  arch/x86/kernel/kprobes/core.c | 21 +++++++++++++++------
>>  1 file changed, 15 insertions(+), 6 deletions(-)
>>
>> diff --git a/arch/x86/kernel/kprobes/core.c b/arch/x86/kernel/kprobes/=
core.c
>> index 792b38d22126..f847bd9cc91b 100644
>> --- a/arch/x86/kernel/kprobes/core.c
>> +++ b/arch/x86/kernel/kprobes/core.c
>> @@ -169,22 +169,31 @@ int can_boost(struct insn *insn, void *addr)
>>  	case 0x62:		/* bound */
>>  	case 0x70 ... 0x7f:	/* Conditional jumps */
>>  	case 0x9a:		/* Call far */
>> -	case 0xc0 ... 0xc1:	/* Grp2 */
>>  	case 0xcc ... 0xce:	/* software exceptions */
>> -	case 0xd0 ... 0xd3:	/* Grp2 */
>>  	case 0xd6:		/* (UD) */
>>  	case 0xd8 ... 0xdf:	/* ESC */
>>  	case 0xe0 ... 0xe3:	/* LOOP*, JCXZ */
>>  	case 0xe8 ... 0xe9:	/* near Call, JMP */
>>  	case 0xeb:		/* Short JMP */
>>  	case 0xf0 ... 0xf4:	/* LOCK/REP, HLT */
>> -	case 0xf6 ... 0xf7:	/* Grp3 */
>> -	case 0xfe:		/* Grp4 */
>>  		/* ... are not boostable */
>>  		return 0;
>> +	case 0xc0 ... 0xc1:	/* Grp2 */
>> +	case 0xd0 ... 0xd3:	/* Grp2 */
>> +		/* ModR/M nnn =3D=3D 110 is reserved */
>> +		return X86_MODRM_REG(insn->modrm.bytes[0]) !=3D 6;
>> +	case 0xf6 ... 0xf7:	/* Grp3 */
>> +		/* ModR/M nnn =3D=3D 001 is reserved */
>=20
> 		/* AMD uses nnn =3D=3D 001 as TEST, but Intel makes it reserved. */
>=20

I will incorporate this into the v2. Since nnn =3D=3D 001 is still consid=
ered
reserved by Intel, we still need to prevent it from being boosted, don't
we?

--Jinghao

>> +		return X86_MODRM_REG(insn->modrm.bytes[0]) !=3D 1;
>> +	case 0xfe:		/* Grp4 */
>> +		/* Only inc and dec are boostable */
>> +		return X86_MODRM_REG(insn->modrm.bytes[0]) =3D=3D 0 ||
>> +		       X86_MODRM_REG(insn->modrm.bytes[0]) =3D=3D 1;
>>  	case 0xff:		/* Grp5 */
>> -		/* Only indirect jmp is boostable */
>> -		return X86_MODRM_REG(insn->modrm.bytes[0]) =3D=3D 4;
>> +		/* Only inc, dec, and indirect jmp are boostable */
>> +		return X86_MODRM_REG(insn->modrm.bytes[0]) =3D=3D 0 ||
>> +		       X86_MODRM_REG(insn->modrm.bytes[0]) =3D=3D 1 ||
>> +		       X86_MODRM_REG(insn->modrm.bytes[0]) =3D=3D 4;
>>  	default:
>>  		return 1;
>>  	}
>> --=20
>> 2.43.0
>>
>=20
> Thamnk you,
>=20

--------------Zpi1PiNMEODEAj5fSV5QNyUB--

--------------tEsy2aZBJmvTdboE8xGpibrg
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEE2/ZzTtJDFIshN/BBL9huahcPNUYFAmW2x4sFAwAAAAAACgkQL9huahcPNUZI
Zw/+L/DxoalncGQZhM1aXVeddLmMWM6J9cirwle+rhPkAigd4joYswereLpjzRX8xAzwramez36H
UNgbsQBQUhHwQDCcZBhWR1JadzoQr51nkf/WhaO+rf/0moeWsoxGy6B7Sx2Y56iBDP4frhNry1xi
+SVuwfWtBkwAc9PxIkuUwl4evBKD6dILINRI/O6GWIHBXJfiTzEgTNhFgsJAL3arLJIHq7g9ahMB
D22armO1Re2RgCbU6zunl3pdf501Y6wKUCN58lp2p2roMKtRFYXW6ZJoyhVs9jTzqjm5LKgQGe/z
LeU/mCrkYcTKBIR2Rvp3yDWhBf4oNR6RfE9l393z3QqpJH1DHsGuq8A4tMrViKco/2ZCiu5c3yNE
srvDbOGp1vAC+br9VW6AqS44Ye5/VmzdqIzRiRH4kD73QALFPGs1MzCfOYlNR88z5W6+N1oSeazh
SvjEgdTGuw7pXc0CxbT6j6JqwI5QP/Zbhy/w8HwJ1o9c5uRcE+knaMMAZkOOaXnSW9uKPyyhblTe
6xsl9PfBjsC/SYfcKUzk4s9JsviKCye4XnooOrm5RbsSvtiI+APr9XoJ1pLCjmNzglv02Yr2Ntqj
7JPLZPiThwWyPGNSWB8FSs/qIrW9UkuaumsqpUjiUQKfFcUHgELZrYVijUJr03N59W3y3lEG9FFQ
GOw=
=cNIY
-----END PGP SIGNATURE-----

--------------tEsy2aZBJmvTdboE8xGpibrg--

