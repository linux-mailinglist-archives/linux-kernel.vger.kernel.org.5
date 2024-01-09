Return-Path: <linux-kernel+bounces-20990-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A4F7828832
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 15:34:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 316F91C24322
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 14:34:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 953DB39FFA;
	Tue,  9 Jan 2024 14:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=prevas.dk header.i=@prevas.dk header.b="lTf166/B"
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2124.outbound.protection.outlook.com [40.107.13.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29B5E39FCE;
	Tue,  9 Jan 2024 14:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bi+F0BULrd/eF3C6Ixk+YcJAKFl1RgNiGsPweuArKtFBVupRpCtuumajQxiYp8TuVn5ABsj1H55QOAuNaR3lTV+Mo7JCHJRqL/hl8I196wmiZsPZWzxqoWXm2Dt0BDMNUv468odxcxwklRRWh5y/FjQpNZG5Evs4IPrhzaNcW3oMs3RU4jH7PjBky+pmqrKyVCnph0gFNB9hONcfSDRCsE9SZ52ufKh5nrvW9+yNLaBLxJXPrOWTKpw7FydJX3cgBiL4lRpAJM3eGeaH9FtnQaxHQCAFbc09kkMrxcRYYK3NlCr1wMVRqYXFom+CoIMzsEbeSO5KQ2V4c0gEtbGmRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rig4AzIEKgnI0FRtZ2X5kntJ5euWcmJ6VFGVwr/Nbl8=;
 b=gvcXlMFYuyxJXUIBQOfBohDc9EIujk4a5VSVrqap/7aEUWy96vr9xwuGt9hgnng5BYg1DgyrUzwL+VfPfP3Znfijyi4JXURvrxizhFF0G5YCgCiCWctDvmMF5gwQHTRJOq5/denIvapAg9AIbCuwIQMf5k2yEpQGpc+E/5B1efoMmnJGjjZ5FnCZjeN2Fp4LVrjJ1xl3gIjNYusXDeP8NjS7nqTSwc7/IBADnI7A0A3UDqxmADnkMlJidRttmGe3mjWwylLY5Ta/cxeaoGpRZwqbtouO0cpHMnx2E//rK+wXkvtcgGE4HiE0mFM3wM5e7J33IanRowzZaXaP2gStfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rig4AzIEKgnI0FRtZ2X5kntJ5euWcmJ6VFGVwr/Nbl8=;
 b=lTf166/BEXrzyHJElv/C8WMUz94l1e/dCC3utf95Pyhp+n4d6QsIZhiJ2lEkJEqjo0926XuEY5I+TacuVXlGEphB9pfsaM4+CF5UmvaqshAidsADvbQ+wz0407sGHJts5cyJku9qGaac+LIwb0B5b4vaFYNYCL/8jJxKFf4iduU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45a::14)
 by VE1PR10MB3901.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:164::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Tue, 9 Jan
 2024 14:33:58 +0000
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f059:23ad:b039:15de]) by DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f059:23ad:b039:15de%7]) with mapi id 15.20.7159.020; Tue, 9 Jan 2024
 14:33:58 +0000
Message-ID: <5cdd1385-e2cf-4280-a31a-27e15a927b10@prevas.dk>
Date: Tue, 9 Jan 2024 15:33:55 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 2/2] arm64: boot: Support Flat Image Tree
Content-Language: en-US, da
To: Masahiro Yamada <masahiroy@kernel.org>, Chen-Yu Tsai <wenst@chromium.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Simon Glass <sjg@chromium.org>, linux-arm-kernel@lists.infradead.org,
 Ahmad Fatoum <a.fatoum@pengutronix.de>,
 U-Boot Mailing List <u-boot@lists.denx.de>,
 Nicolas Schier <nicolas@fjasle.eu>, Tom Rini <trini@konsulko.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Jonathan Corbet <corbet@lwn.net>,
 Nathan Chancellor <nathan@kernel.org>, Nick Terrell <terrelln@fb.com>,
 Will Deacon <will@kernel.org>, linux-doc@vger.kernel.org,
 linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
 workflows@vger.kernel.org
References: <20231202035511.487946-1-sjg@chromium.org>
 <20231202035511.487946-3-sjg@chromium.org>
 <20231203153401.GV8402@pendragon.ideasonboard.com>
 <20231207142723.GA3187877@google.com>
 <20231207143814.GD15521@pendragon.ideasonboard.com>
 <CAGXv+5Go_0pEVAOLQmRCc_a9-YUtZEmBfXtMuBupX_nb9iqwbw@mail.gmail.com>
 <20231209152946.GC13421@pendragon.ideasonboard.com>
 <CAMuHMdVMZs6mnwWBgFwktO=8o=QzROv60cfZe085MhD6HxQjpQ@mail.gmail.com>
 <CAGXv+5Est3FL-XcEL-vB-6zVNas0mqb2cNYa==Yb7W2SQU9xVQ@mail.gmail.com>
 <CAK7LNATyD-PeNbaLTjJmU9=koqqE+V6QvFe09c2VrXopWvjpcw@mail.gmail.com>
 <CAK7LNAR7Fm-1yaZmyH78vG5yNbbW2Avjj5F63u+aST6JQoMd5A@mail.gmail.com>
From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
In-Reply-To: <CAK7LNAR7Fm-1yaZmyH78vG5yNbbW2Avjj5F63u+aST6JQoMd5A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MM0P280CA0037.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:b::27) To DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:45a::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB7100:EE_|VE1PR10MB3901:EE_
X-MS-Office365-Filtering-Correlation-Id: a0977f1e-bf57-422e-1f40-08dc1120042b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	sRwFhiok8SrOYPAJVtIEmAVq7jh4L67eIpUbV4yYh24fj9pQkpAyLwWRW4DlHP3o4bLk11avRS3Q4s4Z7jEoSGLif8zZ/wM+o0QANDbiSYxTqUtMVkVUU17ubr2OJHZpYN/XdeVsui230ujfRVprHGfaNJqY4Omn54BKGZE5q0HSMF6gvgGIEADACKUZwq1TmHT1IxWiAy+z2bORoOYZu38zCt5Px3bs4zq0caNjFLo1mzCoL/srnVq2a6a9xT6PiNqxjpBv2nJ/Cb7gAvK1MmZc1zT6+1YQglGK6QrvIMjsG030C25vMJ7FzIFh5iUzoDUuK2vOxd3c6qfWWOM1MEXwthg4h+VuPqbxEYf+J1X4zSMpUuSgR4y/mWoG1IhDPVnSYN3geKGOmiD6FxDeadFPp7dwV29k3kUJ9sBHl/BexBXPusehzmvJ8H4tDVljt67a36Y/Y+dIoTRcE4CY61eO+d+Bbl/TWoKNDqPw43d42f9D6yOcHg9JQxO2B6KHZJHKHF6zX/mPg02LnCLLe/497KCqFJ98FTsqNoNsK3PepD20lbUcDT9SG++rsBe/z4y5GHTWqTYV8/jd/7iIpWfnp9pAI+HcLEb0DrBOP9owYIyGef5AaREiJ5dD8uhic23qjRpm27K+Z1FLS5D1Qg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(376002)(39840400004)(136003)(346002)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(31686004)(83380400001)(66946007)(41300700001)(36756003)(86362001)(31696002)(38100700002)(26005)(2616005)(6506007)(53546011)(6512007)(6486002)(2906002)(54906003)(66556008)(66476007)(478600001)(316002)(110136005)(6666004)(44832011)(8976002)(8676002)(8936002)(4326008)(7416002)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VytqUkp2UWRZV0ltVkhUSVJBaFRhOXNIODZFNENDU3MxS3ZNSzcvMXBhVUFM?=
 =?utf-8?B?K1czVGdqbkFETEtCSk95bDlvb1cwQTdxcFA5NDhlaEpLVUZZNFhubGpvZWov?=
 =?utf-8?B?cWY1bG9xMzYxQkl1MS92Rytmb3VYajhIeDg5NzN6OXBHS0xMeS9PZXUydExu?=
 =?utf-8?B?QjJpdWJHT0M0TEhYeHFYTXhDV24venhGUlFTWTN0QVkwRE8rWFdaOUF1RXlV?=
 =?utf-8?B?OHVKbDN1OGJHUU83RTY3aE5xVVh2MDRPMW43MXJ0VHBrQXAyNU9lNWhoVFJv?=
 =?utf-8?B?Y1JBam9qYm5NUW95U1p3SWIzOHY0SU9CVzhYMnBsMlVKWjhjQVJBS0xwVlBp?=
 =?utf-8?B?U0ZKeEhXZEVFSjQrWmg4S25nM1JETlVFUHFHU0JOZjJyMUZaT3pBK1pxbXFj?=
 =?utf-8?B?RzNTS2N2MFk3VUVpeldJamJkZzZrM1NxY20wUFI2K0ZZd2FtSXdFdHgydnpH?=
 =?utf-8?B?ajIvY1k3dHlVL0t0Y2ZGc2NOeGIwRk5DSG55c1JJY0xVUmNGUlRVWnlZeGt2?=
 =?utf-8?B?RFhPcTRKU1QzRUZzKy9UcS8wRE9LT0QyZDJIbXZlN29TeFJjSWlUa1lpYnYw?=
 =?utf-8?B?cWE0ancwM2FiUmIvY1dzNit3U3ZZNGV2WTlvaTN3Q2VnUjlUTFdwWVpHU1BV?=
 =?utf-8?B?clVnTGpESzBpRFlBZVBPMkJtMjJzVyt5dHBnZTh0R1AySTBuZ1A5WDNzUW9s?=
 =?utf-8?B?RXNaZTNjWENocEovc21BWTR1alpydFAvcGREaDQ4bVk1aG12eTVMU3FjL1F6?=
 =?utf-8?B?bGlkdGNxT251QVZXMFY3bEdxS1U4b1d1cVp1MEhMSHV5SWVqNnV5aHhuNEg1?=
 =?utf-8?B?UENjaDVGLzIyQ2hHN0JIc2VsTHNRMUpSejQ5ME1vSmRuL2JxUXJCdlhERzZx?=
 =?utf-8?B?bk1KcFRQLy95WVEvVGhIQ3p6blFRbVV3QjQ3c0lpSWxWRUU1dlhvUWpLN2xu?=
 =?utf-8?B?c1pyaFp2RG84OGl1ZmR1SWRTMnN2T1VockJaNlJ4blFqcXQ1U0NCQlFIOUg3?=
 =?utf-8?B?aXFxN0U0SjZ0dFpSNkRaK0ZsVSs4a2xpNy9VUzBQa1ZoeFNFbCt0U2gycnoy?=
 =?utf-8?B?WkxjNW5VOU5EYVZZY2FIZkJQblpQaThYTU53NSthWnR2NVcxV0NDT29XeEhI?=
 =?utf-8?B?MlhYaUw4c2FnWXVBY0t5ZTBQUXJqZXVjRWRFNGV5MHN2Q0tuY3BkMnZYeVZG?=
 =?utf-8?B?TkZUVEMxQWdrelIyQzZOeExxQ05PelFRMFdPQ1h3Z1RDUlArTmZVZ01Zc2NS?=
 =?utf-8?B?anZHN3J5bWxLVUZJRi9QdnVKR2pyeGVJZStXb09QRG5JcHRaSjR3ZXJzZkU1?=
 =?utf-8?B?RnNhS3N1SmZqREV5djdUSTQxQmk1ekl1ZGpKOXEweXNjRzM0TkNRMUdScXVt?=
 =?utf-8?B?UDUyeXY1cFBWeStQZWQ2eksxWHE0M1dsdlg1dGJBWEJESnRGUUZoWkFVbS9V?=
 =?utf-8?B?UWN4K0pIVFhZS05KZ1B4amNRZ0d5ckJRN3I0aUJtL1NEMnJtdktXaEVrOHpB?=
 =?utf-8?B?c2pmVm9Td0tTS2pRQ3ZyQ0ZyeVgycUxEU2JoRDE4dDdiZ09uT0N3bTdMNzJF?=
 =?utf-8?B?clkzaEMwSVhkMmNCWHowQjZFVzBvY0VrZDdaQXR1UVVHYndXTEw3dVFMM0hq?=
 =?utf-8?B?L3dTVVUvSDhVbEd1UUxNVkpHanhhVy9PV3o1UVlZNWdtNEs1RTQxTjdZZDcz?=
 =?utf-8?B?ejVjMzJJZXE3ZG5Jb1ZkZkxNc1VHTFgrZVgzRWtkMkxhNXN1eE0rOXF2VzRv?=
 =?utf-8?B?bE1henExT3YxbVdGaGt1UHVZMy9CaytGZmpObWxCUmxEdWNvUTJNb3FWTXlS?=
 =?utf-8?B?U1JCbWJFR3FJNVZzN0l2aExGdlZQR2hYbVBYdlA4MWh1Umw4Q21mZjR6R0xt?=
 =?utf-8?B?Vkpxby9ROUYvVzBUbFdIWUFBMG1JTm5hdW5McWV6a2lESUZ0OGxVc1ZuR1lu?=
 =?utf-8?B?WkIzUmRnb0FiWk5KUFU3VXBzWlE3VVYvNWhJWEg3anJvcnc2cnhrYUpLZ2g4?=
 =?utf-8?B?dDMxbDVuWW5PTEVWNzQwdGtWcjVnQkpaZzh0MjE3dzU0a0RWZWEwclZraDVR?=
 =?utf-8?B?eGpPa21hMUlkZSsxb0dmVWN2QVltSi8xNG9yWlBpUklXZk1naGtBTmFZcVJV?=
 =?utf-8?B?bzZSWWhobURTaWRJeTF5ZHkybnV3S3kxbUY0V3ZkQjNKSVdsSlBoU043UGpz?=
 =?utf-8?B?NXc9PQ==?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: a0977f1e-bf57-422e-1f40-08dc1120042b
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2024 14:33:58.7841
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TAnCxOSV/2sBlF5VzTkCZukbNauO/eIB5WsdTFKoQlpZq2FjjvziEKoYxaecGWnQBJhgyc7+CU+dWru2yH1T+Ls4IDFPwca/KCQKZKZmS/U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR10MB3901

On 14/12/2023 08.33, Masahiro Yamada wrote:
> On Thu, Dec 14, 2023 at 3:12 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
>>

> One more question to confirm if I can use this
> for my practical use-cases.
> 
> Is U-Boot able to handle FIT (includes kernel + DTs)
> and a separate initrd?
> 
>   # bootm  <fit-address>:<conf-name>  <ramdisk-address>
> 
> 
> Presumably, it would be difficult to inject initramdisk
> into image.fit later, so I am hoping bootm would work like that,
> but I did not delve into U-Boot code.

I recently had occasion to use this, and it actually already works
out-of-the-box, but perhaps it could be better documented. Though you
need not only the ramdisk address but also the size, as in
<addr>:<size>, and of course CONFIG_SUPPORT_RAW_INITRD.

My use case is bootstrapping: I have one FIT image (consisting of
kernel, dtbs and an initramfs) which is the one that will be written to
the target. But for bootstrapping, I (obviously) need to boot with a
different initramfs that contains the bootstrap logic. Since this
project uses fastboot, what I do is: upload the alternative initramfs,
move it out of the way ('cause fastboot only supports one single target
buffer), upload the FIT image, and "bootm $fitaddr $initrdaddr:$initrdsize".

> If it works, is it possible to verify the integrity of initrd?

No, I don't think so. In my case the FIT image is signed, and the kernel
and chosen dtb does get verified, but not the contents of the initrd.
I'm not sure how that should happen - in any case, in the fastboot case,
the host can run arbitrary shell commands so not much U-Boot can do.

Rasmus


