Return-Path: <linux-kernel+bounces-41965-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F265A83FA1A
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 22:26:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59E02283448
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 21:26:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E73B3C08A;
	Sun, 28 Jan 2024 21:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=illinois.edu header.i=@illinois.edu header.b="Dbh1FZ7G"
Received: from mx0b-00007101.pphosted.com (mx0b-00007101.pphosted.com [148.163.139.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74FAA3C466;
	Sun, 28 Jan 2024 21:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.139.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706477191; cv=fail; b=G+lo7VNJvbAyLuIhzLVXSciEjwH1qU8YZUeJHZTohqtYXjQ2Nt/qWye7wRN0vz1iL4cS2cKusd8LBb991pgiFjQyUAd0YwWAKG3msyJVheznov9SfuDAnDXm0hiZGJQefgpwiiHaDR9+z6OzPx4xEOMH71dG8TyRxGgeBxKvyL4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706477191; c=relaxed/simple;
	bh=MDdB2EcDp+10ExJj5FMV7AogkEvkiHEY6n8qvBllkRA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bt4+vsdmBuTflQfEUe45qmUjBShR46dGuSMGhWDlQqLRI8F7nQCa48tmjXOPxmyuRhQeuvaZxAABDVIde3i4oDlRXejolMxjTE3xej2UUHx3zZuZxVaLr1RUvoYMH7U5WD0JO9/NL/3R5PQZ8G6zUgnE+I90kPa05Jd0m/Aicdo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=illinois.edu; spf=pass smtp.mailfrom=illinois.edu; dkim=pass (2048-bit key) header.d=illinois.edu header.i=@illinois.edu header.b=Dbh1FZ7G; arc=fail smtp.client-ip=148.163.139.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=illinois.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=illinois.edu
Received: from pps.filterd (m0166259.ppops.net [127.0.0.1])
	by mx0b-00007101.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40SJZOhS031900;
	Sun, 28 Jan 2024 21:26:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=illinois.edu; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 mime-version; s=campusrelays;
 bh=qEi1q4EqQazYs48VL728Kd3dfSY51u8IxXuYx0VxE3Y=;
 b=Dbh1FZ7GBfWRm8+w3qc5F6w2AxsVC0MuJY1dCr4c+jXcLfXMHQGvbaW8lXEq3uiyh3Be
 zh4N2wWMwi3QCHGku79bnGpyOL2Tvl6gPxoM38hE45Z19saq5teGTKAfVPd5TxOsJmGT
 C/IJN8cJ8IlFy5cfmyAs5u8J0i0kVVutRbtqlf9bzQfJZ6nz0VDLpvvZQbW6BFP0B92z
 S4azrDnTy8p172TZCpANJy6/8FQ51BQl3AjEyS8rZFXaWaBJYHT9zwoeM7H3rDtF8iwE
 CkWQWxDOl8SXA40A3v+uuwpNZ8pwzcAgmuXbAGoY3n3bsy2iqVQ0pszhz9ivZCI7WRix gQ== 
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
	by mx0b-00007101.pphosted.com (PPS) with ESMTPS id 3vvrnu0vgt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 28 Jan 2024 21:26:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O7I8YWvIyHKuvk5dDXUclxPOvLCF0Azu4Z6C8vUzA3cfaTboLAKLesHZWbCDFLlBmVq4riu401bo735xGF4/heS1Y/6gZJ9E2beS9CjJn4jYaCqy881sBmYjVECJ3UIHHr5CQ+5DNUWgouNMJW9Rkw7enRMUsfty9127mtueexQ1Yzl8OcxlsSb8qeikYWQOl7B7oDjCNMfEuwjhNoEqQY6ywMDThttUi0aMpycP0xud8V9JCmenUokvZ9th7zArhaqujlCPtlHBhoceD45aHEmDjekLGTuaDZRyZcX1JyWtYLdU08UhwhsIB5vxqR7uj4afawxqDQrPI82X9Jhu/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qEi1q4EqQazYs48VL728Kd3dfSY51u8IxXuYx0VxE3Y=;
 b=hDym3XW07nwELJo4I+BD7ydE/jNtuPs0MAqGmPUBm9JUtMMdrig5fURAXoo63GZkuB9vatDpax+AXFCP8oV9PzhU1qS6zQ1pkkc3zewEt+nZoKfM+pMZ/Om8vqbUQxhSILcfehIpLPXYHhwuEeCnJI+iSulhXNQvNooLuVMNhIyjiPXURiIXbVqXKqTluKGS0M1l15GjI3oAWajEybblPWti7O+ibUANmB0eQBxngfTH1uDI+tknKV0+D5VIknH2R5AoYpTGEDtIsXZWbqg7WvGMetwkN1o8VQLZxpIC0cv8ZKJh4qfD8f0iOYu5RjivPZornX/4chVMTWW1GlXkqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=illinois.edu; dmarc=pass action=none header.from=illinois.edu;
 dkim=pass header.d=illinois.edu; arc=none
Received: from IA1PR11MB7272.namprd11.prod.outlook.com (2603:10b6:208:428::8)
 by PH8PR11MB7992.namprd11.prod.outlook.com (2603:10b6:510:25b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.31; Sun, 28 Jan
 2024 21:26:01 +0000
Received: from IA1PR11MB7272.namprd11.prod.outlook.com
 ([fe80::3b5f:2696:825a:bd34]) by IA1PR11MB7272.namprd11.prod.outlook.com
 ([fe80::3b5f:2696:825a:bd34%5]) with mapi id 15.20.7228.029; Sun, 28 Jan 2024
 21:26:01 +0000
Message-ID: <8c29d66d-b17d-4185-988c-de078566d0da@illinois.edu>
Date: Sun, 28 Jan 2024 15:25:59 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/2] x86/kprobes: Prohibit kprobing on INT and UD
Content-Language: en-US
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240127044124.57594-1-jinghao7@illinois.edu>
 <20240127044124.57594-2-jinghao7@illinois.edu>
 <20240128101912.5ad6717347bd66089ecea03a@kernel.org>
From: Jinghao Jia <jinghao7@illinois.edu>
Autocrypt: addr=jinghao7@illinois.edu; keydata=
 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
In-Reply-To: <20240128101912.5ad6717347bd66089ecea03a@kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------VBPF9Wx84JQ0QpTl970cFOqB"
X-ClientProxiedBy: CH2PR07CA0002.namprd07.prod.outlook.com
 (2603:10b6:610:20::15) To IA1PR11MB7272.namprd11.prod.outlook.com
 (2603:10b6:208:428::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7272:EE_|PH8PR11MB7992:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f28132c-6a2b-48a8-0e60-08dc2047b9af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	0iPbq7YF7Fp7vcNXGtOlha79+JLL1cVcg4L4LZVFMOMqKW7XNqh95Jxt/gpBJjDCG2eiytzwUEMj239uGAe7ZbAVHLnk7ketwQA9XwKPtXaYYrOMwfKGevrac3N2rMBKvyMlrPwKMYHmDa/s0pQmML1vZPyL3+VE8hdvmetBzVFR+lAaWEreRxSPrm/veLngdsVGFGa39Tr2hz4gbAAa7sM0zyNU7m6FaPmMbb38QJtz+WbPi5qnWNN9by3No0j8D6X3QxBruIvDQqnrXhnh+mvr/hWe42zz/RY5KVFrvDduGd3dt85mY74hCM9ZxQxG4JdH/CxLMAIC/mkXCRSyh7QM65zkWKVopRA2a4cQ9T8m/E/pND6dlJUK+aitR5dhtemvJrXN/Zr0nEKJ7/T3Klbp432oMLjVKWumnVSu6f0UgpZZbTiXf9pNsbMOfBOXDM9TIy/82zEMgY+J/ZQXP+1HICKYhSuV9/AVpbsHauZyWsJyzlU9NvLoAK56mESKnMmRu3NGKJeNT80rCq0tZB1FAv2RZdZndyWlFZYFBnXDKaTy19BpBzoL2+RdT4vfjsXkeEEk3f9GretF2hmQpGE47iWA7AtrTWVGhd8YOlpyeV6yMyW4SEd5/GDXrHYTWgKhXNIH/WuKs+nlXzloMg==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7272.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(366004)(346002)(39860400002)(396003)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(31686004)(66899024)(83380400001)(6512007)(33964004)(6506007)(21480400003)(53546011)(36756003)(86362001)(31696002)(75432002)(5660300002)(7416002)(235185007)(8676002)(41300700001)(8936002)(4326008)(2616005)(38100700002)(66946007)(66556008)(66476007)(6916009)(54906003)(6486002)(2906002)(478600001)(786003)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?REpMZTVzdmhvRWhsc0V4NEFKd0J3d0JJejhhV2Y3aGtLck9vM3kzSHhsRHRx?=
 =?utf-8?B?WXdydkM4c0JyYjkreW51Wk9GYXFsVjZiMmxOOE5lbjRKdFZ1cFdzSitacCth?=
 =?utf-8?B?Vmg0amU0Uk8xM3IveFZjWEkxU2pPRVBPc2laeTFZWXpRTjFqL1VZRmNlZWw4?=
 =?utf-8?B?clRFYnBoblBhSHI0YVJVZGpzUm9mYlVMcUE5a0RsdjVlMm52aWdmZTBOSUp3?=
 =?utf-8?B?RCt1VnhVdmxWNFZoa05Vd2h4VFJIODZJc1lRMmgyQ0NyOHE4ODNuSWx2SmlX?=
 =?utf-8?B?dGgydlV0cWU3eTJodHVqT3lNd3hlL3JtY2JlWHBMUEROcm5yNkpETStCNko4?=
 =?utf-8?B?QmxtRUVlOTJIWmRCeGVkeDhoS0Q2VXZGZW1vbmNqRjdIVnJTVkNMeTMvYzhC?=
 =?utf-8?B?d1pRRUdwWElvVFdralVrbDEyejNLS0FnM1NoYXRZeE05VG9vK2phTFk3RnpV?=
 =?utf-8?B?WXgweXh4YmEwa3FFYTQvQjQwTW9jQXF0cXpndjdhY2RxaExEZUtzNzkxc2Y4?=
 =?utf-8?B?dnhoRVJaeVlSS3AxMG9HcW1DOWlBNnJsaTUweHpPdEhqSUZXdzNlNWR4djVL?=
 =?utf-8?B?cUhkOVVFTjlQTFV2S3cyZFM2eEFKejJtVVVnTkFVNDBEZTdiTWlBZlFZdEVQ?=
 =?utf-8?B?VFNFV2NFSWxQd3d3RkliU0UxZTA2b29nZU5FcnFQbTl1cTh2UHExWmU3SU5M?=
 =?utf-8?B?RnVQa0ttTFU3M1pEcHRKZHpEVm9VeVNIQmx3Z2o5TnJSRG1PUWhNSEZMbHM1?=
 =?utf-8?B?ZWxRcXh0Z2pQVUlJYlBSWjRzbWg0dnhOdmZNbjYydHVYQndZK3Z6cUdRRG1y?=
 =?utf-8?B?dm1vSUpicVJDQjVWdVl5OU9oc0N4bnduWlJXbHFSVU9ic1c4QkhnQVRiRmxR?=
 =?utf-8?B?YXlsR0VoQ3F1WkowMTJLYjlZZDFFY3R2M1NKSVZrMTBBMm9qblZYVk03YlZx?=
 =?utf-8?B?cTBDd1VIS3BQVzZlY3JtOUhhTlFSTkhPODA3WDVnUTFqYjU1RVNHWHpVZ2VY?=
 =?utf-8?B?Qytyc2pVcE1ReHY5QUxTdndpZU5LelpyRUwwUzdsYVJmZVdSL2NXTytXWjh0?=
 =?utf-8?B?VzgrcS9IVytUVWhDYVp0cTJRb1I5ZkxtQ0hzeGR2My8wK1dBRExWaGN6WVNO?=
 =?utf-8?B?elpIVWY2dUVUQlBiNGJMb3RkdFR3dFA1aEJuRWtLWmJKODFuemd6dXh1YjRv?=
 =?utf-8?B?b3oyU1ZKQXJoQnZJbzVJSVZ6N0FJM1Iwb1BUa3R1M3ZIcDBIRHhuS1pZRDBi?=
 =?utf-8?B?b2hYbkRWd04zN2ljWkplTEx0R0hDMUJqUmpRTkpqcFpIV2MzRy9wbEVxaTZM?=
 =?utf-8?B?dm5OaW55aUxjZDVzcms4SnRCVnBGbXZXcVhRYWlsVkRQbFlKS0Q1L3JzSzMz?=
 =?utf-8?B?Y2FRVFNvbzh4VndnTEt2d0s5bGVJL1g2VE05UDMwRm1BYUl6bitqajJ4SjhD?=
 =?utf-8?B?RWtiZWJ2amprdDJCWTYrZ3puVE9PTURtUEw1QW5YeUZvZGVxeEZSQjRhanJ1?=
 =?utf-8?B?RE1hb2ZsVFRhNUlSaWVia24wbTkwWWpNdlhSTVVyeTh0NDd3WEZRODJoZk51?=
 =?utf-8?B?eXQ0dklGYkFrc2U5MVl6WmcyQk9xenludkk5OXFyRmpveUwzdHRLc3dUUjFR?=
 =?utf-8?B?VHQ3S2RHcmJHSUZOQ3RFUGtvYnduQnhLcmRQMnh5TGljeEdzRFFHZ3dqV2s1?=
 =?utf-8?B?RDJXR2hGaFg2VWRGQm1tb1V3WWlJMitYT2FMOXo1ZnVtZk92T1A2Z0tFTWFI?=
 =?utf-8?B?VVJObWlTZVZUQldwTTRwZUZDckdUR21OSHBtTCtLVGtOZTJqU0E2MWZxQjRT?=
 =?utf-8?B?Q3lyQkRaK0hWbEkwcnZ4UUxFMWs4eXByUGYwZ1NDcDgzdGJabWRPcVdiSW4r?=
 =?utf-8?B?d0IyOWtTSmpKRzFGaUVUaWhnUzlhZTNFOW9JOENPUkt5d1dHSjZJOGlibVUv?=
 =?utf-8?B?UjM4YUhUTGVoOWd2WEsrN2poWVBuL01yTU9rQ3RuektmZVZJUndZalF6eDdR?=
 =?utf-8?B?MEVwaVRxd01YOEpLbldPckUvMElORDVkVW82Z3VQR1E4d01FNlZRR2pRaUdi?=
 =?utf-8?B?bVBoQTZtWjdYL0dhMW5FMHBuYzFVWWFMaDJ3MVdjeU14dkdtZTh5RUlaWW0r?=
 =?utf-8?B?ZFl6WjhZVGFJRmw1QjByRzNLeFBCNlJDeExaS0lUbjhFSzhjK3Evb09xcjRl?=
 =?utf-8?Q?n1Ix0SH3Ro+wIlFNT5RpTZjRHA5gfOGd95HBMPSIfGDJ?=
X-OriginatorOrg: illinois.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f28132c-6a2b-48a8-0e60-08dc2047b9af
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7272.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2024 21:26:01.0866
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 44467e6f-462c-4ea2-823f-7800de5434e3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CCyyMnJ46PiLDINL+k0J6hOzaPk8eYCViQTvo9KCR3ntwfZzkn/NipZdW20sOMNrREsz/CneeCU2tV+94UJqTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB7992
X-Proofpoint-ORIG-GUID: Do_UOlnmRfc2me_o7Or8VIR7fqrn1xFd
X-Proofpoint-GUID: Do_UOlnmRfc2me_o7Or8VIR7fqrn1xFd
X-Spam-Details: rule=cautious_plus_nq_notspam policy=cautious_plus_nq score=0 clxscore=1015
 bulkscore=0 priorityscore=1501 spamscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 malwarescore=0 lowpriorityscore=0 adultscore=0
 suspectscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2311290000 definitions=main-2401280162
X-Spam-Score: 0
X-Spam-OrigSender: jinghao7@illinois.edu
X-Spam-Bar: 

--------------VBPF9Wx84JQ0QpTl970cFOqB
Content-Type: multipart/mixed; boundary="------------EWNTiMAG0EiD9ghrNOmNd94i";
 protected-headers="v1"
From: Jinghao Jia <jinghao7@illinois.edu>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
 Peter Zijlstra <peterz@infradead.org>, linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Message-ID: <8c29d66d-b17d-4185-988c-de078566d0da@illinois.edu>
Subject: Re: [RFC PATCH 1/2] x86/kprobes: Prohibit kprobing on INT and UD
References: <20240127044124.57594-1-jinghao7@illinois.edu>
 <20240127044124.57594-2-jinghao7@illinois.edu>
 <20240128101912.5ad6717347bd66089ecea03a@kernel.org>
In-Reply-To: <20240128101912.5ad6717347bd66089ecea03a@kernel.org>

--------------EWNTiMAG0EiD9ghrNOmNd94i
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 1/27/24 19:19, Masami Hiramatsu (Google) wrote:
> On Fri, 26 Jan 2024 22:41:23 -0600
> Jinghao Jia <jinghao7@illinois.edu> wrote:
>=20
>> Both INTs (INT n, INT1, INT3, INTO) and UDs (UD0, UD1, UD2) serve
>> special purposes in the kernel, e.g., INT3 is used by KGDB and UD2 is
>> involved in LLVM-KCFI instrumentation. At the same time, attaching
>> kprobes on these instructions (particularly UDs) will pollute the stac=
k
>> trace dumped in the kernel ring buffer, since the exception is trigger=
ed
>> in the copy buffer rather than the original location.
>>
>> Check for INTs and UDs in can_probe and reject any kprobes trying to
>> attach to these instructions.
>>
>=20
> Thanks for implement this check!
>=20

You are very welcome :)

>=20
>> Suggested-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
>> Signed-off-by: Jinghao Jia <jinghao7@illinois.edu>
>> ---
>>  arch/x86/kernel/kprobes/core.c | 33 ++++++++++++++++++++++++++-------=

>>  1 file changed, 26 insertions(+), 7 deletions(-)
>>
>> diff --git a/arch/x86/kernel/kprobes/core.c b/arch/x86/kernel/kprobes/=
core.c
>> index e8babebad7b8..792b38d22126 100644
>> --- a/arch/x86/kernel/kprobes/core.c
>> +++ b/arch/x86/kernel/kprobes/core.c
>> @@ -252,6 +252,22 @@ unsigned long recover_probed_instruction(kprobe_o=
pcode_t *buf, unsigned long add
>>  	return __recover_probed_insn(buf, addr);
>>  }
>> =20
>> +static inline int is_exception_insn(struct insn *insn)
>> +{
>> +	if (insn->opcode.bytes[0] =3D=3D 0x0f) {
>> +		/* UD0 / UD1 / UD2 */
>> +		return insn->opcode.bytes[1] =3D=3D 0xff ||
>> +		       insn->opcode.bytes[1] =3D=3D 0xb9 ||
>> +		       insn->opcode.bytes[1] =3D=3D 0x0b;
>> +	} else {
>=20
> If "else" block just return, you don't need this "else".
>=20
> bool func()
> {
> 	if (cond)
> 		return ...
>=20
> 	return ...
> }
>=20
> Is preferrable because this puts "return val" always at the end of non-=
void
> function.
>=20

I will fix this in the v2.

>> +		/* INT3 / INT n / INTO / INT1 */
>> +		return insn->opcode.bytes[0] =3D=3D 0xcc ||
>> +		       insn->opcode.bytes[0] =3D=3D 0xcd ||
>> +		       insn->opcode.bytes[0] =3D=3D 0xce ||
>> +		       insn->opcode.bytes[0] =3D=3D 0xf1;
>> +	}
>> +}
>> +
>>  /* Check if paddr is at an instruction boundary */
>>  static int can_probe(unsigned long paddr)
>>  {
>> @@ -294,6 +310,16 @@ static int can_probe(unsigned long paddr)
>>  #endif
>>  		addr +=3D insn.length;
>>  	}
>> +	__addr =3D recover_probed_instruction(buf, addr);
>> +	if (!__addr)
>> +		return 0;
>> +
>> +	if (insn_decode_kernel(&insn, (void *)__addr) < 0)
>> +		return 0;
>> +
>> +	if (is_exception_insn(&insn))
>> +		return 0;
>> +
>=20
> Please don't put this outside of decoding loop. You should put these in=

> the loop which decodes the instruction from the beginning of the functi=
on.
> Since the x86 instrcution is variable length, can_probe() needs to chec=
k
> whether that the address is instruction boundary and decodable.
>=20
> Thank you,

If my understanding is correct then this is trying to decode the kprobe
target instruction, given that it is after the main decoding loop.  Here =
I
hoisted the decoding logic out of the if(IS_ENABLED(CONFIG_CFI_CLANG))
block so that we do not need to decode the same instruction twice.  I lef=
t
the main decoding loop unchanged so it is still decoding the function fro=
m
the start and should handle instruction boundaries. Are there any caveats=

that I missed?

--Jinghao

>=20
>>  	if (IS_ENABLED(CONFIG_CFI_CLANG)) {
>>  		/*
>>  		 * The compiler generates the following instruction sequence
>> @@ -308,13 +334,6 @@ static int can_probe(unsigned long paddr)
>>  		 * Also, these movl and addl are used for showing expected
>>  		 * type. So those must not be touched.
>>  		 */
>> -		__addr =3D recover_probed_instruction(buf, addr);
>> -		if (!__addr)
>> -			return 0;
>> -
>> -		if (insn_decode_kernel(&insn, (void *)__addr) < 0)
>> -			return 0;
>> -
>>  		if (insn.opcode.value =3D=3D 0xBA)
>>  			offset =3D 12;
>>  		else if (insn.opcode.value =3D=3D 0x3)
>> --=20
>> 2.43.0
>>
>=20
>=20

--------------EWNTiMAG0EiD9ghrNOmNd94i--

--------------VBPF9Wx84JQ0QpTl970cFOqB
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEE2/ZzTtJDFIshN/BBL9huahcPNUYFAmW2xmcFAwAAAAAACgkQL9huahcPNUYT
gg//ebb8+xpW43FCUQpu9Y0ov4EXDQ0RlpvU+w+sSSbmmtLEtKW0xw82Rigg/0VvMkA1h9NFLViW
G3OEVZMDODf6jDzyIMeDqe8nz5TAVI4/ersvJPmijz77jN3knlvZLoNamNCaXFtu4PXRK0qbZipd
Q7mIjiOrB6ShYQxU6aEcZpRqFnOgv/s2X3MomRZVBiOo4hu4pJAJwwjWGnVSUrPwcVCrn49HbcDg
L39/bSGhw7NXxECdig+8wAGLHEg6sIWLkTDB4Ab4WRE4bjDR/VF98MM8JBLibUVBxfvtGdowY5WH
82NLPYlnBXM3fCzOw7uqowph43pjBIboMc/4pfwf96ECC2v8T+qJvIOP/MWNzbh1ZNN/Jq9k+kfD
XGqjz52zT9MSKMAK72OS7L7kfIJSVblHiEJlLJPATqfEyn3BGDI8BTSLiffJ+DsQ2LKNkEerxMFO
2C6K7ZUY/d/ovEQI2RncMwKCYrGbOfCgJ18nE6tKxDoXrusG36L++56QIl6EGlM7qR6nM+z6dJhd
n29F/IwKyFBy/eXOTd85K1lTemmRmHbA1wiWyerhWBWKqQw5yq5WEfh6p/FHlT3ND8veNpRGj+ZE
pTS68GChpGhmDLJ/NQOD3dpvSHzYOXkAOZH/LDU2iz1MZ2c1akr4RYbUKHZOWdnOc0ftjc1zyqe8
Wu8=
=Hn/Q
-----END PGP SIGNATURE-----

--------------VBPF9Wx84JQ0QpTl970cFOqB--

