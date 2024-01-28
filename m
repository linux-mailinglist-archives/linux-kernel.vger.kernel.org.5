Return-Path: <linux-kernel+bounces-41958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 786C283FA04
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 22:12:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7FA51F21EB4
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 21:12:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B85073C087;
	Sun, 28 Jan 2024 21:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=illinois.edu header.i=@illinois.edu header.b="KVgrJqh4"
Received: from mx0b-00007101.pphosted.com (mx0b-00007101.pphosted.com [148.163.139.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EE233C463;
	Sun, 28 Jan 2024 21:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.139.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706476331; cv=fail; b=BKtHNOzNIFI7fXTrPhH6cmwhI0ZRrCqZcPXtUEcz++C3xfkbq7nF7ufOZndaWPYLttq1nj9gPVgaw1ehRGlyrrhHzHkijmW9TNz0zeAZgHMux2jvmHqbJpcAAINpYhn+FihFjhG9nOTl1oSC3kCClGzQcRgJZ7XF8sLXiQ4UCNo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706476331; c=relaxed/simple;
	bh=wGPnDMWoHmu6IHP1X/BJYpa2W6zR9Zyo5NdHoE+c9qM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Pz8f7Cd/JndGvz1HwiJitn+vN5LMiW8zHw9lyKSBChy+6amZ4Y3LzwnMhg946wrSdwW/WL7j10toi59tbPjYhvqUXctE+ZKmCUGq1VGT29FcK6SjzAjATKrsfvQlnfzqosbyxzQTG5eXx6VImTPdKFOujxLgJMFvbWureT7IuxE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=illinois.edu; spf=pass smtp.mailfrom=illinois.edu; dkim=pass (2048-bit key) header.d=illinois.edu header.i=@illinois.edu header.b=KVgrJqh4; arc=fail smtp.client-ip=148.163.139.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=illinois.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=illinois.edu
Received: from pps.filterd (m0166258.ppops.net [127.0.0.1])
	by mx0b-00007101.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40SG2ui8030958;
	Sun, 28 Jan 2024 21:11:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=illinois.edu; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 mime-version; s=campusrelays;
 bh=wGPnDMWoHmu6IHP1X/BJYpa2W6zR9Zyo5NdHoE+c9qM=;
 b=KVgrJqh4oNbBpiDqRTWCjz2tw3B8V5jh/nderVHR4MY+i0f+2MequB0UpFF5F9dw8rnI
 9Vl2Zw4iY36DD5f9xkPwjyw+S2RnW1E1Cfn2TLlLXunoqk21MudLpZNC8lpT9/gkoNmr
 boickxGWOSmniEsZjh2kZwxtadgh55jA8Eno6yj1VURbI3dhzM0fkCJXC7EsvmDK9c+f
 gi9EuoQmzz4fysfV4FQCth6B+DtYQPB0w7eqAloSzjutZbcFiB8bc8jGiB7Z+Qfsh0N4
 zMewi5Ip5XKVGigew1kUUDDBvwSWcocsYRF0bfs/BcrAJkmS904xOwGl89UgXQqfyuVW 2A== 
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
	by mx0b-00007101.pphosted.com (PPS) with ESMTPS id 3vvr6sscd5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 28 Jan 2024 21:11:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YF/M4AOYj+6QUFKUhrRLWx3JA6Zpus5sL3M3hRNjBl+4hOJup6ObvrWg7avG1MHSPnt3HTHFN1+GD5MrzLM2JZH4pQP/1WIYEIKfk7WBo69KhCHBchCaiekbhGzJCKNHARoS83bUqGJFn7agydGoUIjYmgOwMSkLHtiI7dx4HGulqwxq89FDzrJ21duD/QzmxQRr4rqm3RvAjJy3UGPhbav39nozOtvemSzuAlaWhQr/KlnBpdLG/9/RSREOi6UP/528/4DfCIHOM8SDIH/M1J00ee0Pnfr1Y75Y9k00TyaV2r5kmg4qNC/JqF5BXerSr0xT7LXMskMpDWzGytdVpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wGPnDMWoHmu6IHP1X/BJYpa2W6zR9Zyo5NdHoE+c9qM=;
 b=bsYHaOyJMeLMXSORt31G+RInxrijzRjHVPlNEXufhJ8/jWAwUJYfKKetwojtISl1ej0guXQ3vJOU4XjrVC8wd08LnLP9+DQhc7AtPLV14JvH9XqyIYE6OK9sTyGPc4owy/wCC2hGOu1Z4j07opl2MTqN9CBRrorCLiM39SSrKAMmO8LuSWXe5AmFEI9IURxgO6rA3S2c/ZbaG+FWZMc8oDtscde7H2aUqrpURFQ5g56utxdo03bnhQJJ9Yy2n+lDjISYOUSN6gH5YDkGC7f8Az8Blyb9wFRmxN+CJW76aclfLE6iZ7bbTQm1Mms/DTb9cbWgcQiduxxpTHW1pear5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=illinois.edu; dmarc=pass action=none header.from=illinois.edu;
 dkim=pass header.d=illinois.edu; arc=none
Received: from IA1PR11MB7272.namprd11.prod.outlook.com (2603:10b6:208:428::8)
 by MW4PR11MB6984.namprd11.prod.outlook.com (2603:10b6:303:22e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.31; Sun, 28 Jan
 2024 21:10:55 +0000
Received: from IA1PR11MB7272.namprd11.prod.outlook.com
 ([fe80::3b5f:2696:825a:bd34]) by IA1PR11MB7272.namprd11.prod.outlook.com
 ([fe80::3b5f:2696:825a:bd34%5]) with mapi id 15.20.7228.029; Sun, 28 Jan 2024
 21:09:52 +0000
Message-ID: <8935a6b8-0853-43ca-84ce-35c87bcc643c@illinois.edu>
Date: Sun, 28 Jan 2024 15:09:50 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/2] x86/kprobes: Prohibit kprobing on INT and UD
Content-Language: en-US
To: Xin Li <xin@zytor.com>, "Masami Hiramatsu (Google)"
 <mhiramat@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc: linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240127044124.57594-1-jinghao7@illinois.edu>
 <20240127044124.57594-2-jinghao7@illinois.edu>
 <30966e59-d757-43f2-a89b-75bf41426611@zytor.com>
From: Jinghao Jia <jinghao7@illinois.edu>
Autocrypt: addr=jinghao7@illinois.edu; keydata=
 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
In-Reply-To: <30966e59-d757-43f2-a89b-75bf41426611@zytor.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------izVobTP9JTJxqmSnH0UHoxG0"
X-ClientProxiedBy: CH2PR02CA0011.namprd02.prod.outlook.com
 (2603:10b6:610:4e::21) To IA1PR11MB7272.namprd11.prod.outlook.com
 (2603:10b6:208:428::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7272:EE_|MW4PR11MB6984:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a60685e-f42f-4c22-6fd8-08dc2045781d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	T939Q4ssHiQLXNRaNJ+2qsWgonFMtucsi+DleT2lnihYQ+MmUwh0CeeTX/IVx2ObJ3aFTuyYb/25OE++t0N/2m0VWutkzb85uTt78On1Dq7L2QZ8A3sh2i8HKz8jHUhWBk8ywvrvME3flU9AS8AN3yE0Hwi/Q8bngVk/UUSD0faoLG7NmSgvdY8UVP9G9npipNqymrG53slnrHVN5tYu5VgG+hPXTqHpbTblD0iiSUt594+r0K9zW4x8JkpYu24U3yYXlln//7g6cw8fm1KT1uMdUze1b8bXjK96txY2bdzcA6g/Va0qKSjvq9eB5lY6AVB1/EZYLpCY0P7cn+DtaXgEUgmkn9yAcLIfVPLgBv0rkfSmvINOz2ZuAE0aPRoWIFalPz77zP0xlMEoRtbFrlFvVh/NoVTpy02dSvwt0cZ0mNiEFSF7wPAL82tL6B6jR2e5dijyFLt6WWkab45QDL07/zzGlirmy+GwPfrqjv3I7iy274XKxqf5qM9xxVmkgV7kzIn/XRjJe+UMByrAOREiiPd1cG9hNakb6gj1ObNnq3tOMfL9TYAYwjXQafWJyBcLEPoyLNLeTOV87LpYHd8Go98H9T/mW2RrjdIFEWUej47rz2gT5/8T/xaEqNXU391h+ZFhR0MZ7ZujdV05Yw==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7272.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(376002)(136003)(346002)(366004)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(31686004)(2906002)(7416002)(5660300002)(66946007)(316002)(33964004)(66556008)(66476007)(110136005)(53546011)(4326008)(75432002)(786003)(8676002)(8936002)(6506007)(38100700002)(478600001)(235185007)(41300700001)(86362001)(31696002)(36756003)(6512007)(83380400001)(21480400003)(2616005)(6486002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?YzRXa3h4eXBla01USWNrWmpQSERiUlZBWGtPbldJZnBRK2RrZlNaSXh4c3BW?=
 =?utf-8?B?VlZOUWtaVzFWemxnN1loWm9sZ3ExS0ZpTm5ZWnQ0clFuSngyZitIMlJDTi9R?=
 =?utf-8?B?UDVqNUZibHNnblExTE5rK1RWSUhQZXhkTDV4a2VsTGVYY2l0b01WZkpqZGxi?=
 =?utf-8?B?K3BUVS9RN2hQOUVwbFFLWVhXTlVkMnN5TW5ENXFyWnVMeXBsOEswdlJLUzhr?=
 =?utf-8?B?RStXdFk3SDdsTjJPYW12ZjByVGcxOXc1VDFkM0JPUWtZc0xtYlJseElPQjM2?=
 =?utf-8?B?VVFaQlk3ZmZTR3NnWVQvVDNzRUhsRVRJcjc2bW41K3dXai9xYWxkK1lidWR1?=
 =?utf-8?B?dVpoZWNvbVgrK2tnVWlPRVFMSWxjZTJLM24vVlowTGNSK1paL2gxT25GblI5?=
 =?utf-8?B?cjVPQldGWnhTaUg3NEtqU3IvU2laVlQrQmRyR29YMXBLVi8ybjVzYjVsUEdW?=
 =?utf-8?B?amYxSzQ0UnNtUjJ2dU1wdlR6ZDlGNUdISk1vQ1BVOW9nZmRIUG9hNDJZRVhq?=
 =?utf-8?B?Tk9PYnJJVHZTSFBZR3FmV0VvdmNVT0RSOXlBV3FhT05uc2hjVDY2RXAyTkw0?=
 =?utf-8?B?RHd6djlJNXp6L2FNa2ZaaW02Nmo2b1NSWGJEcTd1TzZES0dxTlh1RDNzNHFp?=
 =?utf-8?B?ckM5UUZZUWJ5ZmZJWEFKbWM0Tm1MTW5mZC9ScWtWWHV0UmFBcHlBb000aW1K?=
 =?utf-8?B?SGhocnNoNGF5R3hkVzh3QTM0K05tQjNFaE9JWW5QYVNHU0pEUTBNWHNnSjA0?=
 =?utf-8?B?OGVtR3cwS1VSUnd4M0lZSUVpczl4d0JxMGtvZE5ldHQ0anQwbjg5SHVZTkla?=
 =?utf-8?B?aUFUc3RwaFA0N094aDlmQ1M2ZGVQblJsZmZHOENRc0kxOUgyWndaUEhBNi9D?=
 =?utf-8?B?OVZDZEhINHJodnlETS9uUGQwendPeHQraEJ2SkgyNWVPajl0N28xQWM0elBB?=
 =?utf-8?B?Y05tTkI0VEh2WEs2ZlFFNmpSdVlMWUFpUWpPWmdXZVdWWERzTmErVW9WVEN5?=
 =?utf-8?B?N0EzTGczUUJCa0xxWTlCaHdkTEtWV3BhdS85d21VT2IwOVE2b25XYWVVYzE4?=
 =?utf-8?B?ZHFpMCtRQ29hQlF3Wk42YlMxUnFNdzAwZ1hFMitGVTlkWTVVQ0lqN0JWY0Rn?=
 =?utf-8?B?UXpFdGJyZ054dCswMXZTVDExRmkzeXFDVU5GT3dsVzh1SmdDWkluWmVsMmI5?=
 =?utf-8?B?bTc4ZDFoU2JMVEtnOGZsM28xV01jSHVWTnZkUS9PTlRsU3BJQ3NYQUhZeVpo?=
 =?utf-8?B?NTlxK1FySUhra0ZGcjhnRmVvQ1NlTzh5WXpwRWphYlVzZkVmb01sWWFKWEZp?=
 =?utf-8?B?YW0vaDhQMktDdkIzS1M3VCtmT1ZpTHFTWnpkdW1OQ3VuRUpwbm0vMUc1NjEw?=
 =?utf-8?B?WjdGeXdOMjI1c083bEU5WEMwbW5GTnVVOGo2cnpSRWc5dVlPenEwZmdsem5S?=
 =?utf-8?B?NWp2Vmx6aEVxMmFTVW42aG9najZTRndXZlRka0NqUVhvV045ZTFCTm9OR2J6?=
 =?utf-8?B?YU9pU2FCbU9MS2xMOGJuWUF4bDBaQ0sraEU5OG15c1MrM1ZuV1cxUlUyand4?=
 =?utf-8?B?cGxnRkVDalNESWdsQVNjcWZ0MFUyRjNZK2hrbTlvb3VOQmdFNDJXMTJzVjV4?=
 =?utf-8?B?SW9pSGpKcGhUYlAzVWRaUVdCUVdHYmpDLzBpQ1l3djZYUTN4K0NpR1VEVjVh?=
 =?utf-8?B?blNlODg4aXp4OXVGQXpuWDRUODVvTUF0eGlNTDNLZ1RRdEc2SGlab3hTdVda?=
 =?utf-8?B?NzBDMitpWE1ISEZpL3ZVQVYvdzNJcWhoaTdyZGRPTkp6bjFVckNZWnc2RGlo?=
 =?utf-8?B?VWhBSkZPOWo2dFpsMHRST2orZms2cHl4QzByTXZlL3V5QWU2VkJSU1lXUno5?=
 =?utf-8?B?WXkyNjlFYWdmUkwzS256ZTBiN0Y3VHN5Y2ZLQ2lJR1VoWlB2bkp0YjNIaXlm?=
 =?utf-8?B?YmhQTjFmZzB1Z1Yyc2plNlJwelh1NUJxYk95ZnoxaW5KcUUyVStWU2tjQjFp?=
 =?utf-8?B?TVFJbFBjMlg4cWVHd0lXYzBLSENMdHNnUjZXazFjZE8zc1VWcEluZmVPOFlX?=
 =?utf-8?B?UWQwMDFibGVOZkU2UXU1YWtLaXFJRFRraEx2OHVPZVRnVDFXSUs5d2tOeHFQ?=
 =?utf-8?B?bWxPa2J2WWxIZkFBYUc3QWd1WWdMWXkzc0xvZWVZWVpRN2k3THI0ZWhlcmxu?=
 =?utf-8?Q?7SBR+RSmmCeZ781CrWWnCNP0ruC7dEJhqUr9ysZx9iHM?=
X-OriginatorOrg: illinois.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a60685e-f42f-4c22-6fd8-08dc2045781d
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7272.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2024 21:09:52.2734
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 44467e6f-462c-4ea2-823f-7800de5434e3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ykc6gNd/OI8x5vpKAdQOWpV/TAuhlKATeGuT3s6QKp3PFmpLpaUjcf4ODpTgMcfjwwj50XYbOAmy/cIv59RwdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6984
X-Proofpoint-GUID: MSOkoNzGC_mFwNNR2fS57-HVklrkUFoa
X-Proofpoint-ORIG-GUID: MSOkoNzGC_mFwNNR2fS57-HVklrkUFoa
X-Spam-Details: rule=cautious_plus_nq_notspam policy=cautious_plus_nq score=0
 impostorscore=0 spamscore=0 malwarescore=0 priorityscore=1501
 clxscore=1011 mlxlogscore=999 phishscore=0 suspectscore=0
 lowpriorityscore=0 mlxscore=0 bulkscore=0 adultscore=0 classifier=spam
 adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401280160
X-Spam-Score: 0
X-Spam-OrigSender: jinghao7@illinois.edu
X-Spam-Bar: 

--------------izVobTP9JTJxqmSnH0UHoxG0
Content-Type: multipart/mixed; boundary="------------PqI2qAe9hIxVz4Ya4iSy6h7a";
 protected-headers="v1"
From: Jinghao Jia <jinghao7@illinois.edu>
To: Xin Li <xin@zytor.com>, "Masami Hiramatsu (Google)"
 <mhiramat@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>
Cc: linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <8935a6b8-0853-43ca-84ce-35c87bcc643c@illinois.edu>
Subject: Re: [RFC PATCH 1/2] x86/kprobes: Prohibit kprobing on INT and UD
References: <20240127044124.57594-1-jinghao7@illinois.edu>
 <20240127044124.57594-2-jinghao7@illinois.edu>
 <30966e59-d757-43f2-a89b-75bf41426611@zytor.com>
In-Reply-To: <30966e59-d757-43f2-a89b-75bf41426611@zytor.com>

--------------PqI2qAe9hIxVz4Ya4iSy6h7a
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64

DQoNCk9uIDEvMjcvMjQgMTM6NDcsIFhpbiBMaSB3cm90ZToNCj4gT24gMS8yNi8yMDI0IDg6
NDEgUE0sIEppbmdoYW8gSmlhIHdyb3RlOg0KPj4gQm90aCBJTlRzIChJTlQgbiwgSU5UMSwg
SU5UMywgSU5UTykgYW5kIFVEcyAoVUQwLCBVRDEsIFVEMikgc2VydmUNCj4+IHNwZWNpYWwg
cHVycG9zZXMgaW4gdGhlIGtlcm5lbCwgZS5nLiwgSU5UMyBpcyB1c2VkIGJ5IEtHREIgYW5k
IFVEMiBpcw0KPj4gaW52b2x2ZWQgaW4gTExWTS1LQ0ZJIGluc3RydW1lbnRhdGlvbi4gQXQg
dGhlIHNhbWUgdGltZSwgYXR0YWNoaW5nDQo+PiBrcHJvYmVzIG9uIHRoZXNlIGluc3RydWN0
aW9ucyAocGFydGljdWxhcmx5IFVEcykgd2lsbCBwb2xsdXRlIHRoZSBzdGFjaw0KPj4gdHJh
Y2UgZHVtcGVkIGluIHRoZSBrZXJuZWwgcmluZyBidWZmZXIsIHNpbmNlIHRoZSBleGNlcHRp
b24gaXMgdHJpZ2dlcmVkDQo+PiBpbiB0aGUgY29weSBidWZmZXIgcmF0aGVyIHRoYW4gdGhl
IG9yaWdpbmFsIGxvY2F0aW9uLg0KPj4NCj4+IENoZWNrIGZvciBJTlRzIGFuZCBVRHMgaW4g
Y2FuX3Byb2JlIGFuZCByZWplY3QgYW55IGtwcm9iZXMgdHJ5aW5nIHRvDQo+PiBhdHRhY2gg
dG8gdGhlc2UgaW5zdHJ1Y3Rpb25zLg0KPj4NCj4+IFN1Z2dlc3RlZC1ieTogTWFzYW1pIEhp
cmFtYXRzdSAoR29vZ2xlKSA8bWhpcmFtYXRAa2VybmVsLm9yZz4NCj4+IFNpZ25lZC1vZmYt
Ynk6IEppbmdoYW8gSmlhIDxqaW5naGFvN0BpbGxpbm9pcy5lZHU+DQo+PiAtLS0NCj4+IMKg
IGFyY2gveDg2L2tlcm5lbC9rcHJvYmVzL2NvcmUuYyB8IDMzICsrKysrKysrKysrKysrKysr
KysrKysrKysrLS0tLS0tLQ0KPj4gwqAgMSBmaWxlIGNoYW5nZWQsIDI2IGluc2VydGlvbnMo
KyksIDcgZGVsZXRpb25zKC0pDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2FyY2gveDg2L2tlcm5l
bC9rcHJvYmVzL2NvcmUuYyBiL2FyY2gveDg2L2tlcm5lbC9rcHJvYmVzL2NvcmUuYw0KPj4g
aW5kZXggZThiYWJlYmFkN2I4Li43OTJiMzhkMjIxMjYgMTAwNjQ0DQo+PiAtLS0gYS9hcmNo
L3g4Ni9rZXJuZWwva3Byb2Jlcy9jb3JlLmMNCj4+ICsrKyBiL2FyY2gveDg2L2tlcm5lbC9r
cHJvYmVzL2NvcmUuYw0KPj4gQEAgLTI1Miw2ICsyNTIsMjIgQEAgdW5zaWduZWQgbG9uZyBy
ZWNvdmVyX3Byb2JlZF9pbnN0cnVjdGlvbihrcHJvYmVfb3Bjb2RlX3QgKmJ1ZiwgdW5zaWdu
ZWQgbG9uZyBhZGQNCj4+IMKgwqDCoMKgwqAgcmV0dXJuIF9fcmVjb3Zlcl9wcm9iZWRfaW5z
bihidWYsIGFkZHIpOw0KPj4gwqAgfQ0KPj4gwqAgK3N0YXRpYyBpbmxpbmUgaW50IGlzX2V4
Y2VwdGlvbl9pbnNuKHN0cnVjdCBpbnNuICppbnNuKQ0KPiANCj4gcy9pbnQvYm9vbA0KPiAN
Cg0KT2ggeWVzLCB0aGUgcmV0dXJuIHR5cGUgc2hvdWxkIGJlIGJvb2wuIFRoYW5rcyBmb3Ig
cG9pbnRpbmcgb3V0IQ0KDQotLUppbmdoYW8NCg0KPj4gK3sNCj4+ICvCoMKgwqAgaWYgKGlu
c24tPm9wY29kZS5ieXRlc1swXSA9PSAweDBmKSB7DQo+PiArwqDCoMKgwqDCoMKgwqAgLyog
VUQwIC8gVUQxIC8gVUQyICovDQo+PiArwqDCoMKgwqDCoMKgwqAgcmV0dXJuIGluc24tPm9w
Y29kZS5ieXRlc1sxXSA9PSAweGZmIHx8DQo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCBpbnNuLT5vcGNvZGUuYnl0ZXNbMV0gPT0gMHhiOSB8fA0KPj4gK8KgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgaW5zbi0+b3Bjb2RlLmJ5dGVzWzFdID09IDB4MGI7DQo+PiAr
wqDCoMKgIH0gZWxzZSB7DQo+PiArwqDCoMKgwqDCoMKgwqAgLyogSU5UMyAvIElOVCBuIC8g
SU5UTyAvIElOVDEgKi8NCj4+ICvCoMKgwqDCoMKgwqDCoCByZXR1cm4gaW5zbi0+b3Bjb2Rl
LmJ5dGVzWzBdID09IDB4Y2MgfHwNCj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IGluc24tPm9wY29kZS5ieXRlc1swXSA9PSAweGNkIHx8DQo+PiArwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCBpbnNuLT5vcGNvZGUuYnl0ZXNbMF0gPT0gMHhjZSB8fA0KPj4gK8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaW5zbi0+b3Bjb2RlLmJ5dGVzWzBdID09IDB4
ZjE7DQo+PiArwqDCoMKgIH0NCj4+ICt9DQo+PiArDQo+PiDCoCAvKiBDaGVjayBpZiBwYWRk
ciBpcyBhdCBhbiBpbnN0cnVjdGlvbiBib3VuZGFyeSAqLw0KPj4gwqAgc3RhdGljIGludCBj
YW5fcHJvYmUodW5zaWduZWQgbG9uZyBwYWRkcikNCj4+IMKgIHsNCj4+IEBAIC0yOTQsNiAr
MzEwLDE2IEBAIHN0YXRpYyBpbnQgY2FuX3Byb2JlKHVuc2lnbmVkIGxvbmcgcGFkZHIpDQo+
PiDCoCAjZW5kaWYNCj4+IMKgwqDCoMKgwqDCoMKgwqDCoCBhZGRyICs9IGluc24ubGVuZ3Ro
Ow0KPj4gwqDCoMKgwqDCoCB9DQo+PiArwqDCoMKgIF9fYWRkciA9IHJlY292ZXJfcHJvYmVk
X2luc3RydWN0aW9uKGJ1ZiwgYWRkcik7DQo+PiArwqDCoMKgIGlmICghX19hZGRyKQ0KPj4g
K8KgwqDCoMKgwqDCoMKgIHJldHVybiAwOw0KPj4gKw0KPj4gK8KgwqDCoCBpZiAoaW5zbl9k
ZWNvZGVfa2VybmVsKCZpbnNuLCAodm9pZCAqKV9fYWRkcikgPCAwKQ0KPj4gK8KgwqDCoMKg
wqDCoMKgIHJldHVybiAwOw0KPj4gKw0KPj4gK8KgwqDCoCBpZiAoaXNfZXhjZXB0aW9uX2lu
c24oJmluc24pKQ0KPj4gK8KgwqDCoMKgwqDCoMKgIHJldHVybiAwOw0KPj4gKw0KPj4gwqDC
oMKgwqDCoCBpZiAoSVNfRU5BQkxFRChDT05GSUdfQ0ZJX0NMQU5HKSkgew0KPj4gwqDCoMKg
wqDCoMKgwqDCoMKgIC8qDQo+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoCAqIFRoZSBjb21waWxl
ciBnZW5lcmF0ZXMgdGhlIGZvbGxvd2luZyBpbnN0cnVjdGlvbiBzZXF1ZW5jZQ0KPj4gQEAg
LTMwOCwxMyArMzM0LDYgQEAgc3RhdGljIGludCBjYW5fcHJvYmUodW5zaWduZWQgbG9uZyBw
YWRkcikNCj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgICogQWxzbywgdGhlc2UgbW92bCBhbmQg
YWRkbCBhcmUgdXNlZCBmb3Igc2hvd2luZyBleHBlY3RlZA0KPj4gwqDCoMKgwqDCoMKgwqDC
oMKgwqAgKiB0eXBlLiBTbyB0aG9zZSBtdXN0IG5vdCBiZSB0b3VjaGVkLg0KPj4gwqDCoMKg
wqDCoMKgwqDCoMKgwqAgKi8NCj4+IC3CoMKgwqDCoMKgwqDCoCBfX2FkZHIgPSByZWNvdmVy
X3Byb2JlZF9pbnN0cnVjdGlvbihidWYsIGFkZHIpOw0KPj4gLcKgwqDCoMKgwqDCoMKgIGlm
ICghX19hZGRyKQ0KPj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIDA7DQo+PiAt
DQo+PiAtwqDCoMKgwqDCoMKgwqAgaWYgKGluc25fZGVjb2RlX2tlcm5lbCgmaW5zbiwgKHZv
aWQgKilfX2FkZHIpIDwgMCkNCj4+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybiAw
Ow0KPj4gLQ0KPj4gwqDCoMKgwqDCoMKgwqDCoMKgIGlmIChpbnNuLm9wY29kZS52YWx1ZSA9
PSAweEJBKQ0KPj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgb2Zmc2V0ID0gMTI7DQo+
PiDCoMKgwqDCoMKgwqDCoMKgwqAgZWxzZSBpZiAoaW5zbi5vcGNvZGUudmFsdWUgPT0gMHgz
KQ0KPiANCg==

--------------PqI2qAe9hIxVz4Ya4iSy6h7a--

--------------izVobTP9JTJxqmSnH0UHoxG0
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEE2/ZzTtJDFIshN/BBL9huahcPNUYFAmW2wp4FAwAAAAAACgkQL9huahcPNUYM
pw//VdIh1zfJRCMoe1TV+jqCYiJuk5Ovzzvei/NM2AIiAmmPS7cm/geIHaC5aXF87lCIQXwRMf9/
ymMCPSYIz/+4C0O2hKseLsZlk3RcYSEzcd3tGCuUZarCsYat6B8uAt5SVIBXHwn3qrJv24iba4ut
rwfUFNVeLUd6sQm8uveP7Wd6lzGU3GD7ot5sQnaS5y+Nvvy7u1oA56RpW0WN4FIuiUb3D4egAFj0
A8xFYY5OwCxpA3uy2YHQ/+Xl1dKml43hVHlbz6v9Nsr/bngMYI2OeWCNc7ohEEAcrvvUP0D7xZW3
fTsaUtYoXRB4HPG66P/SUtwzA1P3Tuo/il96NX9dflqrpdSLFyDYiQPoolYo9pZNb76TzWZMHwb4
FRNdUJMBhl9egjyLZ4287blEjtPIITrvpXqAac0t4hR8Qhs5FL5mXVPlLWWpXjdxC3Z3eUQePC8i
Z6GS0TO+x0RiYuzYoijbCxo5VYoz7czSzyMzUJQ2VzRlgNg0zYkVjZAXoV0y0F5NhtGspS/a5/AR
Cd0Tdtt9te5QplrOv3KnqJqA8gexoBLM6e60M1gZGby3P4u/IsZmHa5T/2vZodHIw8JdgrTD6hrw
E/5np8IGFxErqbW5vcteRuc1Z/1md87H5xg3I8Kw9VvHP6FFlblH/mmrduGbXTG6sRGu3LcSg8JB
wKQ=
=CV3H
-----END PGP SIGNATURE-----

--------------izVobTP9JTJxqmSnH0UHoxG0--

