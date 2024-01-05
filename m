Return-Path: <linux-kernel+bounces-17708-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 736F782516B
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 11:05:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BF198B226E8
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 10:05:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57DE624B41;
	Fri,  5 Jan 2024 10:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b="EMhUR/+o";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b="sjGjGNxh"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtpout149.security-mail.net (smtpout149.security-mail.net [85.31.212.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E8E924B32
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jan 2024 10:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kalrayinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kalrayinc.com
Received: from localhost (fx409.security-mail.net [127.0.0.1])
	by fx409.security-mail.net (Postfix) with ESMTP id 522E6349A0D
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jan 2024 11:02:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kalrayinc.com;
	s=sec-sig-email; t=1704448939;
	bh=BJ8KVjqRt54co/bzF59qRcIfgWd91Ua942lk0P7qv0g=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=EMhUR/+oFpIlG4731t0Hgus2YGtMK/4majss9Zil6BPfuuMjmxTBzbaI1x7QF75NC
	 sKFaq6fo593+tvAQ+GH7d6CvacOdZPR+noO2rxVnBeoWEeCxQMgzKihu0Tdho9WSK5
	 cwkQ8qn6gYQ6rXWmv7eC6wyJDK9dSPBSj4j6nlUg=
Received: from fx409 (fx409.security-mail.net [127.0.0.1]) by
 fx409.security-mail.net (Postfix) with ESMTP id 69862349A7A; Fri,  5 Jan
 2024 11:02:18 +0100 (CET)
Received: from FRA01-MR2-obe.outbound.protection.outlook.com
 (mail-mr2fra01on0100.outbound.protection.outlook.com [104.47.25.100]) by
 fx409.security-mail.net (Postfix) with ESMTPS id A2D4F349A6B; Fri,  5 Jan
 2024 11:02:17 +0100 (CET)
Received: from MR1P264MB1890.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:13::5)
 by MRZP264MB3033.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:1a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.16; Fri, 5 Jan
 2024 10:02:16 +0000
Received: from MR1P264MB1890.FRAP264.PROD.OUTLOOK.COM
 ([fe80::1300:32a9:2172:a2a]) by MR1P264MB1890.FRAP264.PROD.OUTLOOK.COM
 ([fe80::1300:32a9:2172:a2a%7]) with mapi id 15.20.7159.015; Fri, 5 Jan 2024
 10:02:16 +0000
X-Virus-Scanned: E-securemail
Secumail-id: <8308.6597d3a9.a0b1c.0>
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QohdhtZiNPr93/VLd/KUNXNSXS/xjI9wtQfBWGThkVnCKcLWLqFyWR5JgvA6kRuDc0UdkZ8VY+qamlHiXK0NW/U4qYkf3tNPYR5d0PIVDRyhq+Kkk7CcX18ShgXrPxewKLqGpBoSqu88v0jzrpdkF1PIjhzh3NzNuZcm68UvQDaVa94cB4J4y6pflEq/a/ZQMNFc1d87tw3sXymSG8ez+gy4vxOtrdTSurtJwBCGpRU+0hI5ATd+JzQZ2z24hHKqkw9TsUTVHZJ4Y9e/4rOem+8ONJDfb7qO/+6c6Y2G7gHkUc50FtXgY6qJ0SZ+MfA5FXWu7aGp6HCSxsguPd/XFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microsoft.com; s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2zQpcrQwtF7iXsz9BAtKBkRelvM5FPJPOlXZgwkgesg=;
 b=SZppDjLCxlTkWF+f2RDBYBSiWg9LHTgg5hn67nIKGLrqrpHHZ6d5bn5N2ubT9VYR7juB28J/bFjDi5uBjGok9SOh3vws3/lf9jVvbn40DNgcjkCvx9d4oIEBX625DVUPclPUmMGQkv5aXKHiPtu/+DoEc5xUk/7QY0W3SBkux7ChdKN4HUZTXVvmC/6rcXDVoIABa0GXkO9mYh8uaN5VceCn+n9OrjAgsiSbicd9nNr6LFUN39N9AP3EUIxNgf5ZaMZl6hPfnE5lLDt9iKrjLeVSiSo9ZJz+T+h8HwPaGuvqFRzu5JtTDggl8t2a3wPXtYyRe/sdGLbhJbOS+ZHHVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kalrayinc.com; dmarc=pass action=none
 header.from=kalrayinc.com; dkim=pass header.d=kalrayinc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kalrayinc.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2zQpcrQwtF7iXsz9BAtKBkRelvM5FPJPOlXZgwkgesg=;
 b=sjGjGNxhesQvEUU3W+7lNYTPZlWZJn2JQiz+CTdwNT/EJzjI1N7OARQ+Qt721X4ohfBT3iY0kYx2ioetmeL6L+ScKoHQ72z9ttOTHbqAP1kY6K0UsGXdVtNJ+35Lkn3PjzL3zdKfqzmHOLO5vJqBkwyEwf8TfjxFxzIiykTURgs5uHTDg00T34JN1TVsBeBjXvdfMoVFihYhzpUJfHzaTDwjVpHsQn620gT/vJLY4gMejmun7w6ZHVto4qs3mBJDMy9K5Rx/YqVQxt5yDL5ofXOxisptum3/gh/lje30+UdY1Vr8oEqD1XHTCffPCq4+KrazFWosatWtOaU8L2OQVQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kalrayinc.com;
Message-ID: <9132e76e-d4e6-496d-8195-0150d044b547@kalrayinc.com>
Date: Fri, 5 Jan 2024 11:02:14 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 000/100] 6.1.71-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com
References: <20240103164856.169912722@linuxfoundation.org>
Content-Language: en-us
From: Yann Sionneau <ysionneau@kalrayinc.com>
In-Reply-To: <20240103164856.169912722@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PR3P251CA0005.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:102:b5::12) To MR1P264MB1890.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:13::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MR1P264MB1890:EE_|MRZP264MB3033:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ed674f4-c38f-438d-632e-08dc0dd56592
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tc2heBpGJPy5kX2tFEQj0/OH0P9D/k8ithwSAAmkCbcKqQO4qt7URKdMsuhE+kRKTHEANjtYohcV6CTqTG2YK4Di0t5WrUJ+whtxQuP0PjdBbtMjJ2FL7B3iIwOy1YO1fNRqq6uyYNEkWYQqjOYAlHSIM/fBjrhA1D/bblmwLhuYGQlZDCoO3ii9gqzJm+eG/kba42VHip1NpaEVi9bxd/eTy895KgwDBYHCfQmRCOin4tG4TLzR+q8eSUQGVQPuRGk6nqPi3pBNCQOq9a1wkEvWumnPaHpU+x2/wiwXpsj0Azaupmactqz3qtExS/JcgqEWbjAqTuh/gnlbvajdDFg7arXk3Ebnb3P3zrarJ++ELXnb+Vmi1FDsyqxiICmFO1wKn6zNopuPC9u3UKDV+Qk53SiUMiZbehKiWIJC62PSZ92i+fdWzJNQGdfHsXrndfsECBk7oJMFzEJsuI0mIMxNExZQ8MTljSbIDxhoOIqzdbPwLNX9md6hcCuWtA4L0j+BsJZ7zSkE+5mCuPfVWdY5KEvoTrW8n7d34aWRvxMvc53T7Oo6njwEaOihWHstoC2UVOFX0do31ZYq9YRwrcl47PkWhiOsezNSTYhaFClzgMn/NhK49TrayHf0NGzw0MFeljxgsL87MPeDuRWpPg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MR1P264MB1890.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(39850400004)(376002)(346002)(136003)(366004)(396003)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(38100700002)(6486002)(66946007)(66556008)(66476007)(316002)(4326008)(8676002)(8936002)(5660300002)(7416002)(2616005)(31696002)(86362001)(31686004)(36756003)(2906002)(41300700001)(478600001)(6506007)(53546011)(966005)(6512007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: c2m9+4ASrODjLChRSsM8Ff+Jke637Kl3pEuRlbDIecr608jb0TQTcFA6EQtlEOgUuGF4aSDJwIpmWVXCCgWcyZY8Tr3XSv7Y3UDRYbCT9P7bp7YTQmL2odhyT/n++tCNj+qkffpePv7BID2Luen6oJEsY5F5nl/7C83+Z272AqEoTdVzNPRLhVM0UF4yBWSM1Eb9U7RcY8i+OQGtBUIurj1AMFvyJ0WjdOCOxC4INE20Fqs9wN7JtIq0mdRGyUobEl2PCmfTgWmJOkwvfJ3aKfadidhnpcQICH0nojQ9w+3/pDfh2khTyJtT90yhhYqCtEtHOvvk9OTIW4VmqDN3oh2b04L26VIHbSFH6MfV5W62v8rb1mP6GwvyEQp6KdZUoIjeQlJEtQOmNkoqd9PoY4YRFqG5uLKDeSHpH+M7gS0UL3umfQDyLOyDOMlnGpq6FXGTuDHcKOns0WZe5Czq9laX62g1wWshQg4LZafn/e9HHdkSjc3a4idj4jizRKZaqhW4PoMLrCUa0K//Hc67lgXO5FbpM+ErRHAkErdmGIOxG9I3FcaG+YD6AJ9mrmlpP44KUJGZ97VfP9yxlENOF/OhEr28P1j4wXBzceF2o0JOZqjxkET5C2Nqx6mdnxuIMQT/+mkSnt9gLIeadLR9Vf+++Gh2EArmgPVa0O7Kf+fvHbPoHnD3pR4jyG3Y8MS8+XqrqSoB8fPixVBNLkzYawd9+XRGPTB4XFsBlxSLm4mvoZqqD+LTJCSSHK94MQIlGLTgmBtWcJGGMyqDNGo/5dMYl03NcUmwZFZHyB5DdyRcFLIooqN/f0sdEzUBl4Hxfeo047SK7hunSos1PSM6dbfgAOHOunqEODQJBbhzVwkdcieVWguWDsuK67mSUGdl07w/1fEWWTq4a7kuufG1HF6EcDVFZSIIXrNfuS/tOwQ7rMAu6/cwlosi3IaftN4h
 5cVBz3/L3nbtpxd10pIFam8uoeTj0XNrS/x+2x3QBi1FRrRWlNr6spY/6cBR0lPqDIz+qRiittZry5dfoP//etkO3eUcBtggqx/ma7joVsA1m9Yj2dZQTA4VeWUss9ic4XTLYLmFeO/nn2Apht0z3KYFJqUZ+McfnRfMHWVWATHAb9u6YfQJbeyuCgi/KhAOG6OrhWd2G20WPXqu16Gt2aZ5t6Q7TTurK/A2gb13KSGBwK4wFcLm4bZ82PRLSs1b1q+O4PqJfi2v5QtbfcMOZMzUvLX3x7VSA5nw+qpV8g9We6tu0zYiiLsL/49wIgYz7Kv8lrVf/yZHotDj9gBpoHyArdp2qAe6KG2nQ4I53Hd9Mx/pZAgawZqARjsJYQWyfa43Gfd88v4JJRk93HSi1roHzYw/bkcS8GNR1qD9NMtyoONVvq8Nw+a7psq5EbZNFtGoeEJsBbl6/91jVb7Px6V3iQx2q/fSOdySZNB2Es5RB7kuNJo7sRG9BAag4k/u98kcdnFf3fVNYuFSz+Z4ELzpby+N4oAHPrNewYiEUkxnand451DLJr8XFkxTxHxFLlm0+2TK1HKjVFz6xRxvk62pUocvHbYGtRk1gLlpV4LtMBtJ1Nx+gcV+Xt++Dpwlt3ijiiyzu1lXgCrJv+uJC0me+Nf2abR65UX+7pW1O/3jlpKf+Vz61TnWM72iB1MxMH/NheerO/CO+DWeEk5s1w==
X-OriginatorOrg: kalrayinc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ed674f4-c38f-438d-632e-08dc0dd56592
X-MS-Exchange-CrossTenant-AuthSource: MR1P264MB1890.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2024 10:02:16.7413
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8931925d-7620-4a64-b7fe-20afd86363d3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gR8mDlqOVP035CL2RceG7ndoRKKB0InzCSTggvkFggBMDL3265mSyKHWZn0VKQES2s3BpV66NNE9pHjc6rw+3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MRZP264MB3033
X-ALTERMIMEV2_out: done

Hi Greg,

On 03/01/2024 17:53, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.71 release.
> There are 100 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 05 Jan 2024 16:47:49 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.71-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> and the diffstat can be found below.
>
> thanks,

I tested 6.1.71-rc1 on Kalray kvx arch (not upstream yet), just to let 
you know everything works in our CI.

It ran on real hw (k200 and k200lp boards), on qemu as well as on our 
internal instruction set simulator (ISS).

Tests were run on several interfaces/drivers (usb, qsfp ethernet, eMMC, 
PCIe endpoint+RC, SPI, remoteproc, uart, iommu). LTP and uClibc-ng 
testsuites are also run without any regression.

Everything looks fine to us.

Tested-by Yann Sionneau <ysionneau@kalrayinc.com>

Thanks a lot!

-- 

Yann






