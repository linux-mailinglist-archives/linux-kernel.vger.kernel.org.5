Return-Path: <linux-kernel+bounces-52025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 360858492FB
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 05:42:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8608282CA6
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 04:42:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BD15B65C;
	Mon,  5 Feb 2024 04:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=illinois.edu header.i=@illinois.edu header.b="EryxEfyG"
Received: from mx0a-00007101.pphosted.com (mx0a-00007101.pphosted.com [148.163.135.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98593AD27;
	Mon,  5 Feb 2024 04:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.135.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707108136; cv=fail; b=rx7v+Ol7Ly3/fr60wBcZMBlssWKvG4gVtVppsbuqWYmx6z8GQBGnSxkFSf4QeQAyFLsoi4/r4ofDYRsHBouuDeLZVkn5j6OM93ZsHT9aSAXcwLALJC0F35nlFO/oNJAuVILsPuS4Eot+xtb2m9pNYXaUlslcf19j1oGRTiFC/cM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707108136; c=relaxed/simple;
	bh=p+GGkCy7k2rMDqg4QlPyNJmKoinwhRBjqgwJUJoKT+Q=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=h5HI8M+KwlJZ9EDeb742N+3cIDZ+qKkdnsXqRPnl43lE1GRWw9Z3KsR+SbtHq7E8pA1xcJ1hT9l40Ek8SeeXoiyiMpyZrMeSvAQ7EMTV97f3DH/cyoETcGrNc2v8m/wuS0ORbBWniBId9/8S6pAuLmtgocA2A7LQxMXIF5YtHYI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=illinois.edu; spf=pass smtp.mailfrom=illinois.edu; dkim=pass (2048-bit key) header.d=illinois.edu header.i=@illinois.edu header.b=EryxEfyG; arc=fail smtp.client-ip=148.163.135.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=illinois.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=illinois.edu
Received: from pps.filterd (m0166257.ppops.net [127.0.0.1])
	by mx0a-00007101.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4153abBd022206;
	Mon, 5 Feb 2024 04:41:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=illinois.edu; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 mime-version; s=campusrelays;
 bh=PRnX+IL7z1uEAUuAFWy1XheYxtUSO9f1LDXiuVMDNFw=;
 b=EryxEfyGAJGKlgqk5lww6liebmj4U/W+9XeZhiXFfuOd5xh1anL12q/yMS55Ug7Yb3vp
 NNZWoP8xEG1mBamZ1WiW7/zv4MLFeUzE0kbhvM2JvcVKENg1Qdyil/PlByz6nsAEn3e9
 B+FmIKU0BC8C3dUwPkDHUdvnL7BMPRyAAeWTbl5oML0WXMk+CfjiMsxcWU/YS5f5pgYS
 vo8g/GXnnph/YpUyEqot2/GVwt3AfuOPSsq4QkpDVpGhGpEkDyRHgekhBQdWG8MpBB67
 SHXF7gBnJ8CZUc1ggQTTK8f+FAkD4yxBFK9PhkadtFoOVA1VNeZV9KXomNx/PuiYGP4I xg== 
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
	by mx0a-00007101.pphosted.com (PPS) with ESMTPS id 3w1e8n9ueg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 05 Feb 2024 04:40:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CXYBa8b7pizJVwopKW7s5gVyNOAms0jlri/gTBZEtUintIUQfsA+czJeQRK1EiJaUSLWrvMYCTGIoMV+YLKpx25TCfFS02UQ0Ps+3EW0ShDDxFNrGoZwDtgO0YB1ckBoK7eSXy/igzyS/W589RTvYG5yzTWjOzNUIKJDvgHhW0h8mw/UNixpUpuNVEkrc9VLmQZRDp2I3oOXoFOM8AJ62BguUVIujh0IhuDcUuUBz/fmU+yRDQUyWjSRdwIbL3nfV2ZDcyqfsZaZ3j+luxwJ3I9yR2488U6J5Ak/tLxqtuveTigoujvIa0h/Po+fjlNecCD4W7BW2YwWRGhEAlaJVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PRnX+IL7z1uEAUuAFWy1XheYxtUSO9f1LDXiuVMDNFw=;
 b=Afr+faOFJ/CPLMSWu/8n2Mtt/73QmMqP8ZAEFesVnl5iq9Vg5cCDTEJL5qdvCIrf9O4isP8GSWQJlYnigrXQ0pr+cZJvhN916mRqye3B7dFDVqf2mkFLZ440B44ooL/YoQAoNIqwSiqTCdbmmU1S9a0RUvzmwxeEGMcULRQH5+w4btQY148eyZnbRjOqLdYeqTIhaOYCclIMJ+8wzkdtsdE8AKlMgDItPeEGtDE98qRn9JIwSJ9rMlG9m8kWYqFy/GLvQJwb3oaA/uspHzJMrXiYcZ0qKTLHW075JpbrNkpgA5pH8o3yYy503Sd8znB5pamblNQxmlLLD1VamBI4Zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=illinois.edu; dmarc=pass action=none header.from=illinois.edu;
 dkim=pass header.d=illinois.edu; arc=none
Received: from DS0PR11MB7286.namprd11.prod.outlook.com (2603:10b6:8:13c::15)
 by DM8PR11MB5607.namprd11.prod.outlook.com (2603:10b6:8:28::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.34; Mon, 5 Feb
 2024 04:40:48 +0000
Received: from DS0PR11MB7286.namprd11.prod.outlook.com
 ([fe80::df27:adc7:bb62:4690]) by DS0PR11MB7286.namprd11.prod.outlook.com
 ([fe80::df27:adc7:bb62:4690%4]) with mapi id 15.20.7249.035; Mon, 5 Feb 2024
 04:39:33 +0000
Message-ID: <14799708-1f90-464f-9432-5b11755c3fca@illinois.edu>
Date: Sun, 4 Feb 2024 22:39:32 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] x86/kprobes: Boost more instructions from
 grp2/3/4/5
Content-Language: en-US
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>, Xin Li <xin@zytor.com>,
        linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240204031300.830475-1-jinghao7@illinois.edu>
 <20240204031300.830475-4-jinghao7@illinois.edu>
 <20240204210932.bd112a37dd3c276b046f6b16@kernel.org>
From: Jinghao Jia <jinghao7@illinois.edu>
Autocrypt: addr=jinghao7@illinois.edu; keydata=
 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
In-Reply-To: <20240204210932.bd112a37dd3c276b046f6b16@kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------ZZ2yMAKQPMMRAYDpK65oEstS"
X-ClientProxiedBy: CH0PR03CA0426.namprd03.prod.outlook.com
 (2603:10b6:610:10e::10) To DS0PR11MB7286.namprd11.prod.outlook.com
 (2603:10b6:8:13c::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7286:EE_|DM8PR11MB5607:EE_
X-MS-Office365-Filtering-Correlation-Id: b741f1b2-e4d2-43d0-d921-08dc26047335
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	RbRwP6d9UFhnkxsJ7fhHyO0rAf8IkcWGZuVxqSCrj1t1d7gTqek+TRI6ngHhf8P/Lqh3prQvyTAJ+s04DFZQNIjtdWNuNZi3y8KWHh+c2eGvPgTyhoTFzkHp5ruAr/QTjRMj4yhHycHfQuzok9EAi5t5chR/1sSurj2I25+k0PeAg4p3cqeSDQYOk/mxRZGQObGhPmp+7ZJAO3p68DA56yvrbFQ11FzBl0r8nB7aBOaEh2RBFq04BfHoSJi1HenY9d0qy8hTC9qZN0XRvN+wr4veEGCTeygBR8SQwRfKSnIKE6poIoZRrKlCvc0zNh2a8Baclm9gJPAS2jYDM8ZzTRG0b0L1InOPLO2DGFEvlhPwN4LzyCTnkz5cRm97V03SEGKv3dzrutL22ngjjyfteEAf2cMYGhasNqX0aH4KGN2FfOS5GqG9QlC+1JfH+UMrgPZOmM1GZDhht+PCRzrjCKxvNpVUyIzbNRpo2dLscGlV9OwuH9ErIV4uhlqbE/Ggzu2Rakdkohu1Fp2/a5yF9r2KGwmOoOsLYo8uAvlpyiPULUqbZqbt4ETUvQuaCbN5577kTHETdxTeDhepOrrSVQONTPHOqlEDWrjX97l7CuU6lOLRdQBsNbP3nqS6JXv87mK48stZ18vro0WFKqIzdw==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7286.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(39860400002)(396003)(366004)(136003)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(235185007)(5660300002)(53546011)(6506007)(33964004)(41300700001)(31686004)(7416002)(38100700002)(36756003)(4326008)(8676002)(8936002)(2906002)(21480400003)(786003)(316002)(83380400001)(6916009)(6512007)(54906003)(2616005)(66476007)(66556008)(66946007)(31696002)(478600001)(86362001)(75432002)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?TitHcGRuLzNvbVAwVW05Y1VwdnRDSVQ1UGd2VGlPRUY3WFlyMzVJWGVxMVda?=
 =?utf-8?B?bmRtaVROUUQySzh0V1NOd2liOTI0QUZRRithbGg3dGVtOUJHNllpSVVZM0xV?=
 =?utf-8?B?Mzl1L3hWWFpCZU9vV3dBRGIyWEVqcS94ZXlwMGNGUktXcHJNMkJwSnFZWk8z?=
 =?utf-8?B?c2VFYUxMdVA2WWNrMnlhOEd2R3A3SWRBM1VDZnRFWTRQaEJreTdoSEJCdGpO?=
 =?utf-8?B?ZklhazB2MTI5aFoyZmZDUFVES2JmRTc2dUhZSVNhcWtCMkJudHQyajkzOHBi?=
 =?utf-8?B?blJabUhseGFOL2JXZ0lWckdwTU9QVFAwL3BQdktwclJCb2xDUWVmTmNpZEtY?=
 =?utf-8?B?K1g3R2hGb2U2WlAwVHFPc0pxaFloZDNMemlvNE1ObmxjcWFHc2lpdTVwQ1lG?=
 =?utf-8?B?Yit4eUUzT0RPTGVhM0ZKZnAreWRlcGMwYmZPZVlzeU12SXovQ0dtMGFkNWJz?=
 =?utf-8?B?b0lTSjRMZnBETEFUZ1I2bjlLdUo1bm04OTd1K0llZ2tnQ3ptVEszNyt4bzQ4?=
 =?utf-8?B?UEhpVjM4T3FXNnZJMUtDTkpVSm9EVzVEV3JueDFSWFZPZmE3UmdCQTJpL3dv?=
 =?utf-8?B?RFpZZ24ySHRYZVI5VnlKSUIzMjNpWjJqakkwMS9tQUhaaEdLZWplYXdidzBs?=
 =?utf-8?B?dmJhOWtGZWp1MzJFT1E4M0VJSCtYKzhpYkY5bXk1RDZpZ1drOFhjOFd4L3VR?=
 =?utf-8?B?bHRMVElEVHl6VWtuUW91ZTNHM1JyMFV6OUNJQm5MZ2Z1S0tTMDZTaFNyVG5v?=
 =?utf-8?B?ZDkyQjJyM2hiMlAyR2taQU9KMU9HREw3SFdMZm1TVXJKMTM1bXFody9RWUQ3?=
 =?utf-8?B?amgyYU9zODZ0UGs0bUpUQlNsbGJzdzRBMmNYRzloQWdEaURFelo2TFBVNFNp?=
 =?utf-8?B?QTdwZmNGMjVhTTg4Vi83K1Nvc2dCQVprbkF1WkI2QzliaEYxUjFlRDN3WWZm?=
 =?utf-8?B?S2JPOXIwYld6QXNRdklPWUM4c0RMelRIaG96MnJtZlJRN2RoT2UxeVJFRkxU?=
 =?utf-8?B?c3RpWG5zU2xic2E1Ulk5Z1pFUDg0Qzk0eWpDWHFlN3lKTzRQOC8wZHhkLzRP?=
 =?utf-8?B?ZlBaeU5EZWMxanMvRlZVQmI2U0wxTm05SCtPTGcxTjlRQ0R6dytmdTE3VS9C?=
 =?utf-8?B?UEhwc3FQMnFiWThFRXc2MEkrNnVlWlZPbTkyN1puMndPSnVacUY0M0FzQk1k?=
 =?utf-8?B?RGdyYk03NVlpV2oxcnFEZVpjZTVQMTdXaEpNRG9FZXNVc1NRUm5TVzJ5Q2hE?=
 =?utf-8?B?aythSHI3akNVazVRbWNHN3prSEdQeDRnUU5EQVlpT0o5Z1VkWnVkekM2RmpJ?=
 =?utf-8?B?RHlYTVdRL05HeHd6RytrM3dQUjhtdkpWQ0VvMDhkbWpnQlJPRUZRQit3dFhn?=
 =?utf-8?B?dXcxc3YvdmE5R1FMK0UxVWRlVTZmMzlOdHp3SVJzUGo1V3pCeDVrY292S2Q4?=
 =?utf-8?B?cnAwSkFjczNHZEo2c040NnA5QkpFazJGak4wYmdpTExwaXhvWUxHOWJXVW8x?=
 =?utf-8?B?a1lvUm1EZGFrSHlSUDdlYnlCUmdpT2d4UVM4eE84Uk9wTkk5QXlVQ3B5MHVJ?=
 =?utf-8?B?bzJEa2NFYWdsd2l0Zy9LbXg2NWc5N1ZsM2x4TXE0MTdETU9LNm1mQy8vV0Nn?=
 =?utf-8?B?cTBSZjhDMzd5K1E5aDBrVG5ITHk0Rlo0MkkyR2lia282TTl6c1VSTVM2WEtL?=
 =?utf-8?B?MWJaOGpIcjlUUW5kWjFCcmpybG5LNnRuS0dBbVNxa3pZS1B0czI2V0JxWXFG?=
 =?utf-8?B?eC9KQXhTcHpmTGRaV3g1dkNpTnB4d2gxVlFYck5vQXJ2VzhOT3Vwc1RwNkxp?=
 =?utf-8?B?Q1BOUk9sRmJ2WndXa0tBWmhzUnlncGVaaXNTazhuVkgwcmswRWZuekc5NW5D?=
 =?utf-8?B?cGlQbWtURFlHcDMyNDU3MmwvSVJQREZrNVE1d1JEeTM3YUo3YmMzK1ZmNW1i?=
 =?utf-8?B?d3Fwbkw5QUJqMTY3UkRwV1o1REZndmZvZWtFSW9BdTBkV0ppR3hNV2lpdmNw?=
 =?utf-8?B?RFpJMXpXUmtoR0Z5bzRoVE52R0REcmNnM0Z3SmFqWHhZb3I5UWR6Nnd1ZTYr?=
 =?utf-8?B?T0ZMdlMvZnlsVlBCd3Zpbk9uWWFad3dKai95dGxvTWpRS09TWlRLNVJKMkJo?=
 =?utf-8?B?S0o5bmpSbVRxTi9SV043VXNKdTVKMVo5bHZEWjFmZmlFU0lyOEs5YkwrUjVk?=
 =?utf-8?Q?87DhvxwZE+Wf4z55PIqfxV41kAzQEa2FdYUQkhI5OZVz?=
X-OriginatorOrg: illinois.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: b741f1b2-e4d2-43d0-d921-08dc26047335
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7286.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2024 04:39:33.6747
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 44467e6f-462c-4ea2-823f-7800de5434e3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iRY8HWvepYqBCDjj2m1tjYFFk542u56N5x3QVXKuXjzlCzwgLDWwV6Ac1p9SbYHROZtj/V3Pcryi8Wn+JGaAoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR11MB5607
X-Proofpoint-GUID: zY3fW_Mg6vq75BlTU8G-mDOFIOUt0rRt
X-Proofpoint-ORIG-GUID: zY3fW_Mg6vq75BlTU8G-mDOFIOUt0rRt
X-Spam-Details: rule=cautious_plus_nq_notspam policy=cautious_plus_nq score=0
 lowpriorityscore=0 malwarescore=0 phishscore=0 bulkscore=0 spamscore=0
 impostorscore=0 mlxscore=0 suspectscore=0 mlxlogscore=999
 priorityscore=1501 adultscore=0 clxscore=1015 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402050034
X-Spam-Score: 0
X-Spam-OrigSender: jinghao7@illinois.edu
X-Spam-Bar: 

--------------ZZ2yMAKQPMMRAYDpK65oEstS
Content-Type: multipart/mixed; boundary="------------M0CLXM6euGmP4zr93iem0nhr";
 protected-headers="v1"
From: Jinghao Jia <jinghao7@illinois.edu>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
 Peter Zijlstra <peterz@infradead.org>, Xin Li <xin@zytor.com>,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <14799708-1f90-464f-9432-5b11755c3fca@illinois.edu>
Subject: Re: [PATCH v2 3/3] x86/kprobes: Boost more instructions from
 grp2/3/4/5
References: <20240204031300.830475-1-jinghao7@illinois.edu>
 <20240204031300.830475-4-jinghao7@illinois.edu>
 <20240204210932.bd112a37dd3c276b046f6b16@kernel.org>
In-Reply-To: <20240204210932.bd112a37dd3c276b046f6b16@kernel.org>

--------------M0CLXM6euGmP4zr93iem0nhr
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 2/4/24 06:09, Masami Hiramatsu (Google) wrote:
> On Sat,  3 Feb 2024 21:13:00 -0600
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
> This looks good to me. And can you check how many instructions in the
> vmlinux will be covered by this change typically?
>=20

I collected the stats from the LLVM CodeGen backend on kernel version 6.7=
=2E3
using Gentoo's dist-kernel config (with a mod2yesconfig to make modules
builtin) and here are the number of Grp 2/3/4/5 instructions that are new=
ly
covered by this patch:

Kernel total # of insns:    28552017    (from objdump)
Grp2 insns:                 286249      (from LLVM)
Grp3 insns:                 286556      (from LLVM)
Grp4 insns:                 5832        (from LLVM)
Grp5 insns:                 146314      (from LLVM)

Note that using LLVM means we miss the stats from inline assembly and
assembly source files.

--Jinghao

> Thank you,
>=20
>> Signed-off-by: Jinghao Jia <jinghao7@illinois.edu>
>> ---
>>  arch/x86/kernel/kprobes/core.c | 23 +++++++++++++++++------
>>  1 file changed, 17 insertions(+), 6 deletions(-)
>>
>> diff --git a/arch/x86/kernel/kprobes/core.c b/arch/x86/kernel/kprobes/=
core.c
>> index 7a08d6a486c8..530f6d4b34f4 100644
>> --- a/arch/x86/kernel/kprobes/core.c
>> +++ b/arch/x86/kernel/kprobes/core.c
>> @@ -169,22 +169,33 @@ bool can_boost(struct insn *insn, void *addr)
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
>>  		return false;
>> +	case 0xc0 ... 0xc1:	/* Grp2 */
>> +	case 0xd0 ... 0xd3:	/* Grp2 */
>> +		/*
>> +		 * AMD uses nnn =3D=3D 110 as SHL/SAL, but Intel makes it reserved.=

>> +		 */
>> +		return X86_MODRM_REG(insn->modrm.bytes[0]) !=3D 0b110;
>> +	case 0xf6 ... 0xf7:	/* Grp3 */
>> +		/* AMD uses nnn =3D=3D 001 as TEST, but Intel makes it reserved. */=

>> +		return X86_MODRM_REG(insn->modrm.bytes[0]) !=3D 0b001;
>> +	case 0xfe:		/* Grp4 */
>> +		/* Only INC and DEC are boostable */
>> +		return X86_MODRM_REG(insn->modrm.bytes[0]) =3D=3D 0b000 ||
>> +		       X86_MODRM_REG(insn->modrm.bytes[0]) =3D=3D 0b001;
>>  	case 0xff:		/* Grp5 */
>> -		/* Only indirect jmp is boostable */
>> -		return X86_MODRM_REG(insn->modrm.bytes[0]) =3D=3D 4;
>> +		/* Only INC, DEC, and indirect JMP are boostable */
>> +		return X86_MODRM_REG(insn->modrm.bytes[0]) =3D=3D 0b000 ||
>> +		       X86_MODRM_REG(insn->modrm.bytes[0]) =3D=3D 0b001 ||
>> +		       X86_MODRM_REG(insn->modrm.bytes[0]) =3D=3D 0b100;
>>  	default:
>>  		return true;
>>  	}
>> --=20
>> 2.43.0
>>
>=20
>=20

--------------M0CLXM6euGmP4zr93iem0nhr--

--------------ZZ2yMAKQPMMRAYDpK65oEstS
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEE2/ZzTtJDFIshN/BBL9huahcPNUYFAmXAZoQFAwAAAAAACgkQL9huahcPNUZR
DRAAtivU3wLiveyrE472EpivOJUPsFg3goSTPtxEzu1kyK7qPBVa144buNh8P+WQpBsxinnUUcxz
zBAQtAvenxIx+wQdjlmyF5oc6uuV4nEMybZg5WohFr40b7/uTjECGb8ONmsu0ZAxXzXssuo6VoQk
4Bhlv5sHA87ZfncUBA4ca3ZHKov+LjCCTRXj5QSbqntjZV7bLituJnoT2rkxmHpeHweotnkN36aE
gGaYcYkQMaXnEdafuqG/+RIKq18S/1E4vwbAMa6rIk8/lDkwf27JRfwPSYHYq404aegACgocbCqA
3TX+iLBIAoM/lCcilPKW7wC3WcG/1devDrHCpAhLROaFt1eS+l9a9/LQrs7kEUX/P/KyAwPyPa5A
Fxei83YQzqMZciJH/Spmw/4HXnzhwRcn9/fKH9WCWG1PnoxZpPC80wwAZEDW8BbQGFYOaWu9J7Qa
9zbUtPVpPWTOyL0yt95NRiY5BhaWRA3PKwcNA5c3A9B5dwAi1lS4caHx2KrjAJF7wjJtKIlCnArT
IOTCTLtzVzpgCLmtLKkbcRUyrR3xKoXccJ9lFgyUEVQQdivlm+7FST2rGvOLBePPLqyFjXkyD2T4
BgXYc7Wmq/4X2H/7Xa0j+Sa62dCe5agun6L0alw91yq0WmYWoTeq9Sq3pGVhF0d7WpZtFfYaV06f
gb0=
=rP4m
-----END PGP SIGNATURE-----

--------------ZZ2yMAKQPMMRAYDpK65oEstS--

