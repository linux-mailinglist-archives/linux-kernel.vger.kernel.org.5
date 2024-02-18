Return-Path: <linux-kernel+bounces-70127-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5049C8593BE
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 01:55:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 757F11C20B03
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 00:55:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 936D4EA4;
	Sun, 18 Feb 2024 00:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="KOjouo4j"
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91A6B36E;
	Sun, 18 Feb 2024 00:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708217746; cv=fail; b=nOBD/cazV2t87MPBt5GEcBr/RdrQSHFxU4qe8jV6yd3Oljoa9jkLBiNnk6WFJLM7X4ByFsd/AQSyUqNTl/CquTF7RsP5MCda7MRUCgho5gmH/6rPBUfl6BfxnoqFR4afKFtYeoM1vdR+bAuj/5r2kKORFyRC8C1OwWvo/AvxOUI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708217746; c=relaxed/simple;
	bh=pkvc5mzYY7wawohRVdYav8IDiiNSnGlz4S6aTFttw7o=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=MmWit1rzmz5mxJlSF04vDCQbnjT4g/G3cwvDB1NPkFBI/fZPJ8rOQaEXkpuU1miHOUg9hZrI1mJRLptUea8r1x7/xTQGUUjvwpqG5V97Ittek2s6PP2V1HQP5BDRqbQKR1MJp7qpUO4qNRDiSfROkWrkPpqSH+q83lDrnX0SMUk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=KOjouo4j; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41I0paRK025231;
	Sun, 18 Feb 2024 00:55:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	PPS06212021; bh=zV7vtzzEQ0UCnIyDU5xvHJNFQf2RAZIn8kViUxLdCNM=; b=
	KOjouo4jeCLunMzGmWtW5BpxTQXVENEFdjwsZ+Dmw2rF25CFzZ4r4vEHPqItzUXV
	FSvQnL7Qh0qddpj02utgtXwLH5hMCc+dSvTad39Vf0boGj8KRycRfwQK0yvTPdju
	rv7Pnz1BfFtqIyGgmuw9INl8POxfJ4objEmsha7lIhGUPe+XWM+hSrZgTD4On7qT
	c9wz/4yQSuYkRJZlHyWeOwA8IdTJUhq4yzQj24X0uyL9v5U3b80MnKWc+sKuU7V0
	QEFnbyR1C/unyZyKpKvZaMCOQq27T7obwErid9djXw6jp0QvwSkkqSsuGoypriYE
	CjDBHfxNJ5WBMblipuGjKg==
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3waj0y0ppn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 18 Feb 2024 00:55:38 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c76AVdaQ9ZDl51jDyoesrwbo/KRcR1Kk/DRL6XqOIlRMZOSftYEfs8XGto8ZR8gC1uuRKDmx95HbEdtvMQ9j5cth2/oSE7mBu2Y8twOjjtcqlhLzaUScSQSffGQ5s8T/u7++4SFDdAdteZl+r8wIfGtGpiJU0KZ1SKCEK+tpzSKOmtPL8+saK1RVVHK5YceyskziQfAxi6AMNryLVVDrjEVcK8oUViA1Tza4Sglazk5AmrqF7tGYrRYOz4/wxKV40lOBYpLkgXdbhlRkB7GQrqjnbANS7IIZSJ5MNiybYm/TQJu5+hjEZk3PXE0mYsKgPGnbaHWY/wrhhNqwD0bUEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zV7vtzzEQ0UCnIyDU5xvHJNFQf2RAZIn8kViUxLdCNM=;
 b=VNL39IWHPF9o8HWQy+sZvGGu2NAxdZ5xi6PRzZNxPTPN+4fAwvInodteC+01hntqM2rAo6pfMVpgEH4eSL73McxThQ4kapimxFZVUcrimKSyPtIAmpfDpkRSW/HNcZ6TF2Qf7/2+6L15mQjotpZbgso2fHR38jHXOtZv657RDUtxrxvZJam/LmPk54bwYV/0/1JdstPcbUsYGhAiDUre2H9lMGOPhGvtcnO6K404wKC10nh2rt73Xx/Z8IEj3mvVZXcOe6M6Uiu/xkdl6lrXpT10iAESlLCDCUtfs5wKsVSYhUwA/kUxQUqSwLlbCVUK4VERlOHVQfCRHqO9YSu+eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from MW5PR11MB5764.namprd11.prod.outlook.com (2603:10b6:303:197::8)
 by DM4PR11MB5376.namprd11.prod.outlook.com (2603:10b6:5:397::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.31; Sun, 18 Feb
 2024 00:55:14 +0000
Received: from MW5PR11MB5764.namprd11.prod.outlook.com
 ([fe80::9c74:bf8d:9e30:b9be]) by MW5PR11MB5764.namprd11.prod.outlook.com
 ([fe80::9c74:bf8d:9e30:b9be%4]) with mapi id 15.20.7292.033; Sun, 18 Feb 2024
 00:55:13 +0000
Message-ID: <b50a72ea-1b14-4bd8-831b-468d2aa988fa@windriver.com>
Date: Sun, 18 Feb 2024 08:55:05 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [linux-next][PATCH 1/1] gpio: Delete excess allocated label
 memory
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: linus.walleij@linaro.org, andriy.shevchenko@linux.intel.com,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240217135255.1128716-1-xiaolei.wang@windriver.com>
 <CAMRc=MdGhfHSWPB0FCHbK+uA0MAZNFstupgm7-Zkw9dbuTmyVQ@mail.gmail.com>
 <CAMRc=Mfb1Vg1qnwE7c95PBroDFySZ6c0b0HgUhyrHFFpCz0Diw@mail.gmail.com>
Content-Language: en-US
From: xiaolei wang <xiaolei.wang@windriver.com>
In-Reply-To: <CAMRc=Mfb1Vg1qnwE7c95PBroDFySZ6c0b0HgUhyrHFFpCz0Diw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TYCP286CA0019.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:263::13) To SJ0PR11MB5769.namprd11.prod.outlook.com
 (2603:10b6:a03:420::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW5PR11MB5764:EE_|DM4PR11MB5376:EE_
X-MS-Office365-Filtering-Correlation-Id: 992000a9-06e3-4754-6203-08dc301c4391
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	R4pdUB6lZIqOhY5aNOsrQCKsX/NX6E19Clkq91LvLZcJsL9PUw8AgYtUp9OCSiPJuqVsDqJ4NrLFTjYIGnps0lOj/9qsqkiUTV15GvUhzDxE9JEkx3pxTIPLmMoyR4egQIhPOflBrn8oca8rIFqawvooSMjGpsRMeBNuLtYR9jVNs6RyA46FGg7NV//MGIRYTcyLbFTuSsA2CdWtRDgI8DGXI5FXSfrQUBhBl3EMLyTiGLPnxybrRC6pLz5Y+NEbKF5A0kXOrVZT/W1rq6VfiHCnWysK4J8HaDMdx4ugAxo02H1zvBcMiwAkdc0jwNi+HjQgzGO1UW6QVEd2PMV+kNZBhPm7tr5xUkw0TOw4Ee6oNFmwqRH2lxGHx4irzOp4z9aiTWJB+5fR4l3V1EzuovKy4xIPi08DRaqPszmQhiiXs2OS7CpDcbFy/RE1j8t9GVp8dlfnqUNvdRx4LqdKbrzGmZ6GwA4tZzVL492/I6YlOFFSk5hB+TQfoRlAkTV3/M8ZDE+wyFk4lS/E0EM476QCOprpI2jtbGs9h2lRnamvGPFS2I9kaVOAJSIZndKD
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5764.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(396003)(39840400004)(366004)(346002)(230273577357003)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(4326008)(8936002)(66476007)(8676002)(6916009)(2906002)(66556008)(5660300002)(66946007)(2616005)(26005)(41300700001)(36756003)(83380400001)(316002)(478600001)(6666004)(6512007)(6486002)(53546011)(31696002)(86362001)(38100700002)(31686004)(6506007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?QWxOclRKZG1xendhRnRqd2dGRUZBWFZzVGs1TU05aDJPbnFRZERpdG0zWm81?=
 =?utf-8?B?YUFmNnByOVFnLzlYNzExaTBFdmgyQ3h3NmFkNi9XRkxoMkh1SVBaUmY2ZVJS?=
 =?utf-8?B?bDRiRXFBR01qN25HdmRlSmpCQnpLWm5Obm42RlBDaUdhTlNjcXpveVVnTVg4?=
 =?utf-8?B?K0NBWE1SbjQwRVVHSmVEbWZlVFh6cjc5RGZnTTRRNmN1KzF5N2JoSXp0ZVVs?=
 =?utf-8?B?MlB0TFJSMU1tY0R1b1Nxa0cyUGJVc0lwS0lvOHNtUlJRbFhmcVc1MTFLUkNq?=
 =?utf-8?B?aGlENnJKYzNQcGtBZHl5NCtvY0lDcTNaM2tTclhpdFpUdXZSTjFRQmRhVzlr?=
 =?utf-8?B?NzdOU3g3K1pMbVRKQnRkYUwwQktDVXJuUktFTDM5eCtoYnJHc1FNQzFLWUN4?=
 =?utf-8?B?ei9ya2lHZDQ2ZXpwNTRpSzMzai9CeE44UGh1Tkt2Q095ZkhjYnQ4NkM2MWc1?=
 =?utf-8?B?UXMxeGhJNkRaMVBpcWRXRkxaRnp3SXcvYlZaY0NpR2dOUkh2WVNWZUlISjZP?=
 =?utf-8?B?SVFzMGVoV3Z0UmtQUDlydTRGWjJBQ1VzbEVVYlpWZEpkczNMWVlvc0VSbTVW?=
 =?utf-8?B?WTlKc3FTL1VCMk5QYVBtSkdNWm5KVDFML0xpcS9MZHltc2lUTVpXVkxtOEJI?=
 =?utf-8?B?Rm5Tc3dkM3Yvd0YwaVJrVWFRKzZ0NXl2S1g5TVhFdWJlZTc1NzFEZzQyNXE0?=
 =?utf-8?B?ZVBkc09JWGdneWZKditHcWY0SXlxalFSNjAwTUN0bHB5K2NQOVhGVkFUSlhr?=
 =?utf-8?B?d3gxVnIzdERyQTVVaStTYkNHYlp5ZlNpZlFidkNWTS8xMHF6cE9hZGxReGx3?=
 =?utf-8?B?OE1hcmxaSUN4Rk0wamwwY3VKT3YrZ3dnL0ZiemNyWGhyTVdWbitsNHdtQ2VG?=
 =?utf-8?B?ZmN1M2Zpc0Q4ejczRzM3Q2VOVlg1RlMrUlNYc2pheTFRc2o0d1VkYjVsNHZU?=
 =?utf-8?B?NExNTzUwR0tXdEZ4d09PS0dvbjBpUHRXYkpmcDNyeG5ZZDVmUFQwZmNzdTNl?=
 =?utf-8?B?NUdQQnhjdFdzZ3JRdDc4K2Jzb0ZibUtaQklVRDkyYStPUU5QZDVQc3FFWFg5?=
 =?utf-8?B?WjM5d2xRVkZxOE5oajllb0VCVExtV0kzVmZHMzN0WE1wb1hJczBpMG9IRjZB?=
 =?utf-8?B?QzFZUUgyOE9EUjFhR1VSN0VGUjVCUXVMYVBwN1dKYXk0TVdpN2t4WEtvMXZY?=
 =?utf-8?B?QTZZTCtOZDV4T1Y4WGZFb0hRS09kMXIvYXg5WWMvYzZaak1MZ3lSOVBTOUZS?=
 =?utf-8?B?Mm9JU3g0a2ttb3c4b2xRdDJnUitoNGhsNnBPS0o2eFd3TlJnbVhJN3hVdVlT?=
 =?utf-8?B?a2dLcmdaeTZzbEZYdkFWUklWTmpGV1JkTjJqZExrSzRnSzJXOUNJZDlVMU1i?=
 =?utf-8?B?YVdWM3g0bGFGUFFVSVI5VGVaZTBTQ3hMQnNiQVQyTUlKUERUTmhXQ0prV21S?=
 =?utf-8?B?VVZZbWNBZitWWkpZS1Y2WUw5eXRlT0kybGRuaTZZdVFpdlRNcGs4Y0FxK1k1?=
 =?utf-8?B?ZTlOMlBwSUhPOXUxalRjaUsvL3Y3Z3I0OStUSXl0U1k4NnEyVlZLMUVPeUxw?=
 =?utf-8?B?ZHcwOVdrS3ZucXg1WlJ6SU5tanI1R3pWOGY5YnBBV0FYZXFiMm8rWjd4eDdw?=
 =?utf-8?B?VWI4V3M3MTBXT0haa3BiUnBJL3F5S2FvVmFFMG5nMm01Q3FKM245dEdxN2ZF?=
 =?utf-8?B?c3cwejQrU2Vhc2FpaGVHRmVGcGFBMWpjYTF5RG5GMWN4TXAwWGdkZFlWdFlG?=
 =?utf-8?B?S2ovTFZveHVONWFLTzVKNzlYMDI2T0ZNRk90aXZ3RFdic05pRXdTSFErbmcw?=
 =?utf-8?B?YUNJVVg0Q2JkdjFaWEluWE10Nk9STUJRT1RmbHFSd2J3Yll3WVVNdEZPcnhM?=
 =?utf-8?B?UUZYN2lvcGFheFJSOEt4cXBGQm1uY1Qvcmkyais3eHlBUW5YV21mb09VOHRX?=
 =?utf-8?B?WEFjNWZWVDlRVkJrYnB4bzFCMGk3b2ZlblgvUHI0U2NzWXJJM0NITi9jTDBp?=
 =?utf-8?B?QzFoNklsUkNYb0lic1RqaEQ5cHVrY1hqQ0kycE10U3pRbGVnOEYrZzYvWUtl?=
 =?utf-8?B?WDQ0eWdaVktuZ1lzZ1NGTGtZV2NFeWlvVXpVTnlzQWcrdW5oemQxcUt1a2FU?=
 =?utf-8?B?WVRqeXg4SThmaVI0Rk1ET2tBYnBvR3d5aENiUHlZQitsYU4rUUtleC9xUW9M?=
 =?utf-8?B?TlE9PQ==?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 992000a9-06e3-4754-6203-08dc301c4391
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5769.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2024 00:55:13.8069
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FEOF6HUfQZOeodafGQZ26Gg6KvFnEOduvToczJw1ehyssiS6JPYjTDok+V3sa6XrdKygXI1uWcJcaQKXWllelYiyIjgQurP40OJnYA8iCsI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5376
X-Proofpoint-GUID: VWyJbucM17zqrN2C00pQwRi9Wqq93KTn
X-Proofpoint-ORIG-GUID: VWyJbucM17zqrN2C00pQwRi9Wqq93KTn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-17_22,2024-02-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 malwarescore=0 phishscore=0 mlxlogscore=999 adultscore=0
 priorityscore=1501 suspectscore=0 impostorscore=0 spamscore=0 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402180004


On 2/18/24 02:52, Bartosz Golaszewski wrote:
> CAUTION: This email comes from a non Wind River email account!
> Do not click links or open attachments unless you recognize the sender and know the content is safe.
>
> On Sat, 17 Feb 2024 19:35:43 +0100, Bartosz Golaszewski <brgl@bgdev.pl> said:
>> On Sat, Feb 17, 2024 at 2:53 PM Xiaolei Wang <xiaolei.wang@windriver.com> wrote:
>>> The changes in commit 1f2bcb8c8ccd ("gpio: protect the
>>> descriptor label with SRCU"), desc_set_label has already
>>> allocated memory space for the label, so there is no need
>>> to allocate it again. otherwise memory leaks will be
>>> introduced.
>>>
>> No, we *want* to copy it if it's not in .rodata for the same reason we
>> introduced SRCU. This may be a valid report but the fix is wrong.
>>
>>> unreferenced object 0xffff0000c3e4d0c0 (size 32):
>>>    comm "kworker/u16:4", pid 60, jiffies 4294894555
>>>    hex dump (first 32 bytes):
>>>      72 65 67 75 6c 61 74 6f 72 2d 63 61 6e 32 2d 73  regulator-can2-s
>>>      74 62 79 00 00 00 ff ff ff ff ff ff eb db ff ff  tby.............
>>>    backtrace (crc 2c3a0350):
>>>      [<00000000e93c5cf4>] kmemleak_alloc+0x34/0x40
>>>      [<0000000097a2657f>] __kmalloc_node_track_caller+0x2c4/0x524
>>>      [<000000000dd1c057>] kstrdup+0x4c/0x98
>>>      [<00000000b513a96a>] kstrdup_const+0x34/0x40
>>>      [<000000008a7f0feb>] gpiod_request_commit+0xdc/0x358
>>>      [<00000000fc71ad64>] gpiod_request+0xd8/0x204
>>>      [<00000000fa24b091>] gpiod_find_and_request+0x170/0x780
>>>      [<0000000086ecf92d>] gpiod_get_index+0x70/0xe0
>>>      [<000000004aef97f9>] gpiod_get_optional+0x18/0x30
>>>      [<00000000312f1b25>] reg_fixed_voltage_probe+0x58c/0xad8
>>>      [<00000000e6f47635>] platform_probe+0xc4/0x198
>>>      [<00000000cf78fbdb>] really_probe+0x204/0x5a8
>>>      [<00000000e28d05ec>] __driver_probe_device+0x158/0x2c4
>>>      [<00000000e4fe452b>] driver_probe_device+0x60/0x18c
>>>      [<00000000479fcf5d>] __device_attach_driver+0x168/0x208
>>>      [<000000007d389f38>] bus_for_each_drv+0x104/0x190
>>>
>> Can you post the full kmemleak report for this, please?
>>
>> Bart
>>
> Ah, I think I see the problem. Can you test the following diff:
>
> diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
> index 02be0ba1a402..0fdd4ad242bd 100644
> --- a/drivers/gpio/gpiolib.c
> +++ b/drivers/gpio/gpiolib.c
> @@ -695,10 +695,15 @@ EXPORT_SYMBOL_GPL(gpiochip_line_is_valid);
>   static void gpiodev_release(struct device *dev)
>   {
>          struct gpio_device *gdev = to_gpio_device(dev);
> +       struct gpio_desc *desc;
>          unsigned int i;
>
> -       for (i = 0; i < gdev->ngpio; i++)
> -               cleanup_srcu_struct(&gdev->descs[i].srcu);
> +       for (i = 0; i < gdev->ngpio; i++) {
> +               desc = &gdev->descs[i];
> +
> +               kfree_const(desc->label);
> +               cleanup_srcu_struct(&desc->srcu);
> +       }
>
>          ida_free(&gpio_ida, gdev->id);
>          kfree_const(gdev->label);
>
> and let me know if it fixes the issue?
I tried the following modifications, which did not fix the problem,

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 02be0ba1a402..5940ef88399c 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -695,10 +695,14 @@ EXPORT_SYMBOL_GPL(gpiochip_line_is_valid);
   static void gpiodev_release(struct device *dev)
   {
          struct gpio_device *gdev = to_gpio_device(dev);
+ struct gpio_desc *desc;
          unsigned int i;

- for (i = 0; i < gdev->ngpio; i++)
- cleanup_srcu_struct(&gdev->descs[i].srcu);
+ for (i = 0; i < gdev->ngpio; i++) {
+ desc = &gdev->descs[i];
+ kfree_const(desc->label);
+ cleanup_srcu_struct(&desc->srcu);
+ }

          ida_free(&gpio_ida, gdev->id);

          kfree_const(gdev->label);


unreferenced object 0xffff0000c0e83740 (size 32):
   comm "kworker/u16:0", pid 10, jiffies 4294894561
   hex dump (first 32 bytes):
     72 65 67 75 6c 61 74 6f 72 2d 75 73 64 68 63 32 regulator-usdhc2
     00 37 e8 c0 00 00 ff ff 00 00 00 00 00 00 00 00 .7..............
   backtrace (crc 222fadd4):
     [<00000000cd106dac>] kmemleak_alloc+0x34/0x40
     [<00000000e084cf5f>] __kmalloc_node_track_caller+0x2c4/0x524
     [<00000000746173b0>] kstrdup+0x4c/0x98
     [<00000000f79b3bf4>] kstrdup_const+0x34/0x40
     [<00000000f47eb728>] gpiod_request_commit+0xdc/0x358
     [<000000003a6899af>] gpiod_request+0xd8/0x204
     [<00000000c93118be>] gpiod_find_and_request+0x170/0x780
     [<00000000660eebdd>] gpiod_get_index+0x70/0xe0
     [<00000000eb599be3>] gpiod_get_optional+0x18/0x30
     [<00000000e8b3cfcb>] reg_fixed_voltage_probe+0x58c/0xad8
     [<000000009737579a>] platform_probe+0xc4/0x198
     [<00000000405158e3>] really_probe+0x204/0x5a8
     [<00000000772dd378>] __driver_probe_device+0x158/0x2c4
     [<00000000ddc25aba>] driver_probe_device+0x60/0x18c
     [<00000000cc4413ff>] __device_attach_driver+0x168/0x208
     [<00000000e04f3755>] bus_for_each_drv+0x104/0x190

I'm a little confused. In the gpiod_request_commit() function, if label 
is true, we allocate space kstrdup_const() for it, but desc_set_label() 
will still be called. If label is true, space will be allocated to it 
again, desc-> label will be pointed to the place where new is allocated,

thanks

xiaolei

>
> Bart
>
>>> Fixes: 1f2bcb8c8ccd ("gpio: protect the descriptor label with SRCU")
>>> Signed-off-by: Xiaolei Wang <xiaolei.wang@windriver.com>
>>> ---
>>>   drivers/gpio/gpiolib.c | 6 ------
>>>   1 file changed, 6 deletions(-)
>>>
>>> diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
>>> index 02be0ba1a402..32191547dece 100644
>>> --- a/drivers/gpio/gpiolib.c
>>> +++ b/drivers/gpio/gpiolib.c
>>> @@ -2250,12 +2250,6 @@ static int gpiod_request_commit(struct gpio_desc *desc, const char *label)
>>>          if (test_and_set_bit(FLAG_REQUESTED, &desc->flags))
>>>                  return -EBUSY;
>>>
>>> -       if (label) {
>>> -               label = kstrdup_const(label, GFP_KERNEL);
>>> -               if (!label)
>>> -                       return -ENOMEM;
>>> -       }
>>> -
>>>          /* NOTE:  gpio_request() can be called in early boot,
>>>           * before IRQs are enabled, for non-sleeping (SOC) GPIOs.
>>>           */
>>> --
>>> 2.25.1
>>>

