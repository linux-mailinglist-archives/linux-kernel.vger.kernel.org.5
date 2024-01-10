Return-Path: <linux-kernel+bounces-22868-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA14182A463
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 23:58:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D4A9289085
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 22:58:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D4744F895;
	Wed, 10 Jan 2024 22:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=prevas.dk header.i=@prevas.dk header.b="V8SM1w97"
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2119.outbound.protection.outlook.com [40.107.8.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CFF34EB41
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 22:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QICvKZw2F8TmENdytGDSsfdGmFQXdgL02pE/tUczwod2VDBW86ogB5bzAQ8vsr2TTor442R8ZaEJXs4zpxctUOIIIpu0UyOHhMcZ/3YKnYmxOjYaN19aX6lp0Mya8xiiSigY3X601cMs8RWy2dF9TuDsmsJb+F1IhllcGr7gk2kOloBEK8z/lkqb3P1S03mkly+5Aoeu0u2Yvd0YPKvJSL8oLirAD2lxKkQ+iOkV8Ie4UlHj5jiGaBi8BRdBuiWhd4zjIs3w8Ihh31LHS89P6jm5JfjgOgHN/qFqmAgZPPsBELwMV37NrbSySJN+EtiiSJIEabWlaYqLPoDV8euoIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6H8+vu9NSM2kjGHC2iYhz6sKdakOY/+ugugwjKK/pdo=;
 b=XwCJGLidelFN0lvmtbLd/ipJx7AtanWZd92LcsD+dp/c4c1ni1dNFNGvkcDm6QBk+I3Q1RnM+PpEtXc8aOs0VxsNllepbD2S0K9ZJcxjCKxYT5qVF/vj2I+1BRSsKQ/Iy5G+K5cpcz4rvIg2j8duq/V9rG+1kgCtUFIABPIxl7hzeUsAcmI/R8Lj/tdgb6RRaaGYaja08J1vsNYs/VMknd68Xpm/Aa0pN2Wn9V2MNGQr1DHxgTLnk4ZiuuKaViSGtpNfhSdmg0gR2kzZ/BXsO5O5v1j7t65Fz9cJb9IC0zSy+VEvudBzH8ZCmqlAskO7G1HROBeTK60n08F5Hc9nqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6H8+vu9NSM2kjGHC2iYhz6sKdakOY/+ugugwjKK/pdo=;
 b=V8SM1w97GY/krELDVB2K90gQRYLCVbH0Rtrkz5oT43ZgTZPdHIIiAJhAvp/bQKkgIcLdfkwHMByO20R21n0+9ayOXmMWVuDmeV/Tv7+cctSRc2EXQiVqW6pxnDRYySBanhbqpE359dL1HsThuEEEEH0GD15wQQZCt1TkjM8ehoI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45a::14)
 by VI1PR10MB7877.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:1bc::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Wed, 10 Jan
 2024 22:58:10 +0000
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f059:23ad:b039:15de]) by DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f059:23ad:b039:15de%7]) with mapi id 15.20.7159.020; Wed, 10 Jan 2024
 22:58:10 +0000
Message-ID: <d9fbe970-e087-486c-8a2c-0cbb32cb7082@prevas.dk>
Date: Wed, 10 Jan 2024 23:58:07 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] workqueue.c: Increase workqueue name length
Content-Language: en-US, da
To: Rafael Aquini <aquini@redhat.com>
Cc: Audra Mitchell <audra@redhat.com>, linux-kernel@vger.kernel.org,
 tj@kernel.org, jiangshanlai@gmail.com, hirokazu.yamauchi.hk@hitachi.com,
 ddouwsma@redhat.com, loberman@redhat.com, raquini@redhat.com
References: <20231215193954.1785069-1-audra@redhat.com>
 <20240110202959.249296-1-audra@redhat.com>
 <2f0efed5-f9f3-4a5c-9fd4-a4837cada298@prevas.dk>
 <ZZ8RtfKCmOQqj5KC@optiplex-fbsd>
 <f5ded466-cbe1-4a46-b042-1c65839c9e02@prevas.dk>
 <ZZ8a1RvwpDZvwfg9@optiplex-fbsd> <ZZ8d-7TUJ5F9GvRV@optiplex-fbsd>
From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
In-Reply-To: <ZZ8d-7TUJ5F9GvRV@optiplex-fbsd>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MM0P280CA0026.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:a::25) To DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:45a::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB7100:EE_|VI1PR10MB7877:EE_
X-MS-Office365-Filtering-Correlation-Id: 72ec3851-1b41-49de-62b3-08dc122f9e01
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Zm6IGPtOb4uBisuX4ixp7KPONsgvio5SucxJ95XnHpJOohXzULgK0QaT3oD4FJyQ2LduTzPDjg3wJ8BqsBxWMbiCLowqSOFsfFHimGGnkpyxNNqea7rXE2Kn0+vzFTAk2uCeYTBz2FUzOMrOGQVFRiP+4j+v462hd+Dr6Z0qOjHBDaR+UVBY5P4wrSPpabRlDeZLjOR2wI8oCJjPuHNAxGOuUcyRQtlJ351B/M1d1bhF7FCnPqAtPAe5QiyDd9fI2Eut9sxhACOepfhJYZgDVcoTIiKyMi8WJASk/uysaD5cScl0GSgQ15olK/UuGBe93t/YNRFIPdV9nhVWC+Qsk3M9uqNX+N7WOyrYus66LWp3JtWA6O+mZwf7CbmZuJlsbnoZiObiIpfuXDKfHv9zeL2LOGFg/ubW+D4NEKXngnwdKGnz2jFiOA/5AXMAs39i0PYGy5yw7ObNoBWD4MWfiivQtK/lJ7pP7KGEE45mdVPJw14+SeO+plNju4CHYS9qbHDI7Xs/39uSnOT6l/qEIcrduUL4U4Dmund0awyCeYAnbyno+g9u0KtZI2Iaj3JUioou+Ce5LATQr3jtOadJWGk7qugRtGICK+kCB/sp1D8W+6UlyZyrqQrs6d1RTg5Nu4rzRyYNAJz2wXBhKCj8XA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(136003)(39840400004)(396003)(346002)(376002)(366004)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(83380400001)(26005)(6512007)(6506007)(966005)(2616005)(38100700002)(2906002)(8936002)(8976002)(8676002)(44832011)(4326008)(66476007)(6916009)(6486002)(6666004)(66556008)(5660300002)(478600001)(41300700001)(36756003)(316002)(31696002)(66946007)(86362001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a1UwZVd4WDN6OGtjaEVCK25OUFpXWmRtQXpaRStPQzBsWWZ4TGxlRTBOc1l1?=
 =?utf-8?B?T0k5Y0g0bnZTMFk2Ujh5eW9sVWZSazEzTTBIbmVuS3JlVWc5eFN5Qi9US29L?=
 =?utf-8?B?OWROd3JWWkVSRTUvYTExZGJBc3ZPdExmeGJzK2VuRDNjNGNISTVhQkx5ZXNn?=
 =?utf-8?B?U2FoVElBaTYrWVdFSFVORGRjYldFWmZWRGh4cERXVm1qbTRXNk5SSkR1YWt1?=
 =?utf-8?B?ZU9qa2hvZ3FtTnBqNzI0UnZPWTZIb2VLQjJ4eTIvZ3VQQnQxNE8zZW1XbXJW?=
 =?utf-8?B?TzdrMkdpUU5meWxBTzR2bm02TUJtVWpPaVEzeU9IdC9hSGJxalpKNTl2QUpn?=
 =?utf-8?B?M0wwWFgxNXRpaVZXNmlLSTRXZThtU3I1ZkRVSWpiRm1yTjhIeXB6RHcrbmw3?=
 =?utf-8?B?K1c1WFJ1ZVl2Ry9pQjFkaHM0NFFiR0tIeXk0a1M5S2d0RGV4bDlPczNtbit5?=
 =?utf-8?B?S3pJaE9iekQ3NDZsRkx1SFowT3NuWVJ2TVBnSFV5U0oyT1VxeEJKdkpNQzRD?=
 =?utf-8?B?QzlMQUM0VER4UmZtVnlkZGZlQXM4Vjg2dXdnczJ4Y1BSQmViaTBQeEowMXVl?=
 =?utf-8?B?UG04Y1ZuUXhkQ0IwV3lla2d4TVVpd1lvcXYvUzJXTXBYZlB2L2dobktvNm1v?=
 =?utf-8?B?Si9ZU01BY3ZWdTZtN0VialoyWC81dmJpdmRxTEtpcXU2Z1lQRE1iUCtiZ2tk?=
 =?utf-8?B?UzcwL1dGSUxaRVE3SXdITGU1ZmZUczhxdEJ1NHpLaFFFNWp0RlFqRk5WcmZv?=
 =?utf-8?B?dGtXcC9Zby9LTFFNRENHOVYzbnEybmpmQkdWUEJYYnNIWTJiRHMycXJQeEJw?=
 =?utf-8?B?SkpiRmRLVW1NZ2Zsb01WdDAyVmNHUlBiNXB0K3hnZnlUMmJpUGppeStZVkZ2?=
 =?utf-8?B?Sm0yVENQdE5yRHpPeDhoUCt2RHJjdzQ2WjkvWEtIbVBwamlMem85eVVvZkln?=
 =?utf-8?B?N2JHN1RhRXdlUFFCYVFHMTlSSHR5dy9wNFFMbUNoNVNmTkJ4enI0REFUM21p?=
 =?utf-8?B?S25lS2FOMGN3d1o2a2p5ZXhGN2V2SlJZMWZOU3VPd0VUSnFJU3JiTmFURWRS?=
 =?utf-8?B?TW9LalFuSHFrMTBHWHFBcVN4N0MvSlM3bWxRZ1lyVEs3bldTaE9sWndKZHB0?=
 =?utf-8?B?K3NzK1l0d3Ewdm5paXEyWkhhbmFwYjYzbkVLRzZVOGVQV2pudG5rMHFEbFcy?=
 =?utf-8?B?aVAvSGIwUUd3dUtrVyt3MGkzYUFKL1doSmNhVmdLMFFwL0hVV0lmNXBYQWFo?=
 =?utf-8?B?KzNDcjlpNFJWOHk2Wm5UVTJyV0pNSUVwU20zK0NQV0JiaGVBTnoxNzQ1T09n?=
 =?utf-8?B?T1JDTm4yYnlUdmV4bTJnMFUxdERMRlpqWStXM2Z6NWd3MDN4N3FqV2hMekN4?=
 =?utf-8?B?VEVDNW8ybitPRlhnZFllYnRFWmN3TmlyNGJQK3ZCaVREY2pMdFZhUzBJZStD?=
 =?utf-8?B?UW9oeWw1OVlLeGhLK0VVaTNtcXZzaklIUHA0aFNuN0puUWZNd2UrOXhpSEJu?=
 =?utf-8?B?TW1ZWlhpVFFTL2JRWmhRa05WZkRoaG9ORWlsdmFIYW5IakZwNGF5V1JXQWlE?=
 =?utf-8?B?aE5hUThlMW1XQ0FkMlpucnJyN1JZYXhKbnFWWEVrNWpYL1B0SXdkSkxvUnVD?=
 =?utf-8?B?T0RBYmhXZ1hxYnVNSWtBVnlUdzNkWVZzNjNaN1ZZSzVOV0VhZnVTTzZpekVI?=
 =?utf-8?B?YmV6TGlnQVowVHdmcHRkMnF1aFhHR2RwdjkzTmMwTDZjTmowSkhURlhhTTJN?=
 =?utf-8?B?a0w1Mjd1RWJ4VWZTUDFKNFY3V3hGckZHTjZmZzJKRWhQQmxDemlGMGVCT0Js?=
 =?utf-8?B?aDdNYklwanozTWpLV21NdWg1MFdQNkoxVDFNbUord015L1NNQ2RGZnhoeWNE?=
 =?utf-8?B?REtxdk92SVgzZ2oxc1lNTzI4eERNSUxmdDgxcm1oMGVjeWtkTXZiUndUMEJx?=
 =?utf-8?B?WnhCdVc1czZONm9MNkFEcVM3c1J1L0JvUEt5U210bktSa1NQVGQxM3hOREFQ?=
 =?utf-8?B?R2hkbnhPSkNMMlVLb3NZM1JRRktycFI3L0l1QVNuVkpNSHc1USs4OEI2NG5z?=
 =?utf-8?B?akltTmdQKy8xN0NWUXdVc0RPSU1UMElBQytBY2ZvSDlCcVVWVUd3eUtQWE9O?=
 =?utf-8?B?enprVEFZQ3QzUFh0RjJiSGExd3pqM0h3L2xzVjdzVWplTXIxQ3FqQVQzSm1i?=
 =?utf-8?B?NUE9PQ==?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 72ec3851-1b41-49de-62b3-08dc122f9e01
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2024 22:58:10.4513
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ieLYa3BxFPQN2/J4wKnXxVkuqPLFKqb1X6fnT4HjmGrquaqt3oaha0TSbFTvyoYDIq2Om6bhtRKw6zeLpyEtQA7gQobID3FAyr8UDrFd3Ho=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB7877

On 10/01/2024 23.45, Rafael Aquini wrote:
> On Wed, Jan 10, 2024 at 05:31:49PM -0500, Rafael Aquini wrote:

>> this snippet from PRINTF(3) man page
>>
>> RETURN VALUE
>>        Upon successful return, these functions return the number of characters 
>>        printed (excluding the null byte used to end output to strings).
>>
> 
> Perhaps the man page should be amended to indicate vsnprintf returns the
> number of characters that would have been printed if the buffer size 
> were unlimited.
> 
> We based the assumption of kernel's vsnprintf behavior out of the 
> documented POSIX behavior as stated on the man page.

That's not at all the "documented POSIX behaviour". There's also no
reason to take that from badly (re)worded man pages when the horse's
mouth is right here:
https://pubs.opengroup.org/onlinepubs/9699919799/functions/snprintf.html
(and for vsnprintf,
https://pubs.opengroup.org/onlinepubs/9699919799/functions/vfprintf.html
, but that explicitly says it's the same as snprintf except for how the
varargs are passed).

Rasmus


