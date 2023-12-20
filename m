Return-Path: <linux-kernel+bounces-6931-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C0148819F76
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 14:05:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4F791C22E17
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 13:05:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21A2B2D630;
	Wed, 20 Dec 2023 13:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b="ay2mvyrU";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b="oXkW1E/9"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtpout149.security-mail.net (smtpout149.security-mail.net [85.31.212.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32B9525550
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 13:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kalrayinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kalrayinc.com
Received: from localhost (fx409.security-mail.net [127.0.0.1])
	by fx409.security-mail.net (Postfix) with ESMTP id C9C6F349CD0
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 14:02:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kalrayinc.com;
	s=sec-sig-email; t=1703077331;
	bh=GVn4aTT6TA/KBBFeRLPsK7c09Pp6yipwE6c+ehrZgp4=;
	h=Date:To:Cc:References:Subject:From:In-Reply-To;
	b=ay2mvyrUC2ZxmWw3R/UyH6LtFhhfgRno/mSNCvHdTEwNoWxqlO3J1PP9GaWDtt1Pq
	 6gOXrQ+w5g6nRrcj9AUDl8uPQFJepUvDECtQRhDkaKDz7rSGjSul2ymA2OygUqEBZf
	 7Y/xqBkgaS5+WVsCAhvAFnYXABzV3nDav3LlOAuU=
Received: from fx409 (fx409.security-mail.net [127.0.0.1]) by
 fx409.security-mail.net (Postfix) with ESMTP id 9CC86349D4E; Wed, 20 Dec
 2023 14:02:11 +0100 (CET)
Received: from FRA01-MR2-obe.outbound.protection.outlook.com
 (mail-mr2fra01lp0100.outbound.protection.outlook.com [104.47.25.100]) by
 fx409.security-mail.net (Postfix) with ESMTPS id E25E1349C13; Wed, 20 Dec
 2023 14:02:10 +0100 (CET)
Received: from MR1P264MB1890.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:13::5)
 by MR1P264MB1988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:4::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.18; Wed, 20 Dec
 2023 13:02:09 +0000
Received: from MR1P264MB1890.FRAP264.PROD.OUTLOOK.COM
 ([fe80::1300:32a9:2172:a2a]) by MR1P264MB1890.FRAP264.PROD.OUTLOOK.COM
 ([fe80::1300:32a9:2172:a2a%7]) with mapi id 15.20.7113.016; Wed, 20 Dec 2023
 13:02:08 +0000
X-Virus-Scanned: E-securemail
Secumail-id: <10f11.6582e5d2.dffbb.0>
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DDl0qLDjLQqPy9FFiGAxuh4uI2+8YHO4yoKC9FERE0TFG4RD0or/ykv56xA4IGh+x/R47n4KqRVKhAEVzrnj/lfm9+O4JPsh6eHjitUsp0PVxvRji9laBPvDLfwrwxzwPnsncvdcTUNrpn5NvRqXfOLvgVot/cjJ/1HbUx+EQVrpYYM6UH+27zuEs2k43BSNw82YysF05Z1xt0O1CJcGwgJTYzX51s9FSBlpqR2VEO75kjAP3QNLc0ReAidzoJzx2UNTQfZiOqaqLffN5ZeqSsXIP3NRvCA2AoIUsyGAyABchn6VD/nUuPUKWVAwPHgAG0Hvtz9IIboE/fzYfNTMUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microsoft.com; s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OTTjDtL5jsOTLtsOQUOcD9VoRoM2/RE8T3W7wmse6so=;
 b=hVef4fa6kRV+6ZbTD5pdkcgjDAPTt4+UsD0pdRvtOZU3uUfZ2wbV7nz8+JFN6XdFywucl5++16G6CnKvgOMSnZeLYJX2Ew6WprbF9WGuzbiER4dXugfryMMWR5p+l/tHra4QuYX6V7jGdSTRHz/GxT6AHtoFWL8fXr02MAiYEFgoUx7UoVkTrN/d0DhS56EcZzujBKI/Vo5jaKMDnW9KatjeLdTMa8JYaE3oU+1NUY3bVbMz9lE01MZQYu34Xub1SZCWyfGM1gGUOnwdUJz7buLX51vjYOPEg+K/RexzF7G6BLsk9HgE6wNvkF/IuCCY3DHdcIF+P98GdOS2s06W7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kalrayinc.com; dmarc=pass action=none
 header.from=kalrayinc.com; dkim=pass header.d=kalrayinc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kalrayinc.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OTTjDtL5jsOTLtsOQUOcD9VoRoM2/RE8T3W7wmse6so=;
 b=oXkW1E/9nYEkspyg+XnP5MMtxEDgENFdwckTMSCVzazXrJGEj5SZsqhlVV19L1/Y0S09pqB8eYH7XTDxB5PQJCgT52dOVY7cP75vouH+Es+J3gfNhQiyufEVoNYKwMoguDl5RxkvLwaduzjOO8UdDugTYVyUrrp3ParjeqEuR3fL/HMdoGkd8JCdSSQj772k1wUL2LgOgt4JeU8gDjp7M4+B+rI9YD6XSeCIycGXPmwGYyqxgt8WCs92lGqLPWbXPopKX+ze+w9k2+ruDpiQVTwbbAYDxVGDgRz5VniZRieyfIrNCSDynA6T3gnlKV1oMQWIFb2W3BKQuXyqiXVLmg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kalrayinc.com;
Message-ID: <c40e9be6-6ab5-43e0-9d5e-2682fee94bd9@kalrayinc.com>
Date: Wed, 20 Dec 2023 14:02:07 +0100
User-Agent: Mozilla Thunderbird
To: gregkh@linuxfoundation.org
Cc: akpm@linux-foundation.org, allen.lkml@gmail.com, conor@kernel.org,
 f.fainelli@gmail.com, jonathanh@nvidia.com, linux-kernel@vger.kernel.org,
 linux@roeck-us.net, lkft-triage@lists.linaro.org, patches@kernelci.org,
 patches@lists.linux.dev, pavel@denx.de, rwarsow@gmx.de, shuah@kernel.org,
 srw@sladewatkins.net, stable@vger.kernel.org, sudipm.mukherjee@gmail.com,
 torvalds@linux-foundation.org
References: <20231218135055.005497074@linuxfoundation.org>
Subject: Re: [PATCH 6.1 000/106] 6.1.69-rc1 review
Content-Language: en-us
From: Yann Sionneau <ysionneau@kalrayinc.com>
In-Reply-To: <20231218135055.005497074@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PA7P264CA0281.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:373::18) To MR1P264MB1890.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:13::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MR1P264MB1890:EE_|MR1P264MB1988:EE_
X-MS-Office365-Filtering-Correlation-Id: d966867b-a343-419e-6150-08dc015bdfb1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vBe3bzzcI1GtPWM51kk2j0ux2EjVP5yt3BAylyEX7mSrPtb9q2DdZ7v9oj2pX9SIruixIKnvvtDQctLCxUWhcfgmgjXZbDxq4knb2jKZWiuHEh0ggD/YdGJh4G8u1t01mZRNB2u2FqPI2l9G/Hp0MnggfrPGCLTYbgQ4YT3bOiRQXDGkU3iSdmv3CXgLKE1xj/KeIcanAxykvBWHSw9YfLT2mEJqumdGTXvbyXBw4ukSEpYo1QIhJFFcpfBDNZ9E0WhO8y0pJn8AIiiT1h5StxeCwVybnTdijI9ljHNLPjRRfhAR6pmC7jiIE1iG/fbygKK3JV0n/b/808uWAnxmsfyc1KPEeKxqOZ6k3Eg+SWiEi/E4Lipyp/1f0dcRQoYdCOVJHVCNyyR+NO2NYpYiZtWWSc/BUdbYnTXHIdIchEvH8hO+x2m3lSzYziEd4kwynrtgZd5h58hzkPX7yR6yI9/viNrzG+3+LaT9+itRUUExhhmxNfEWRWMmwXsn6B02ypBLZoiwRGUbuKHc/mF1L/WWz3dsVIh3caK6YMbfnu8UDfZMVsLC5ckhrdO/LwjznXBa7VoMBe2UmYArp8A0NSdKS6CyT0e0XuiryvBo42pieRKaXKk+zZ7q2MhM8tnkmBxJpwDgsBmd48GN/qaEwQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MR1P264MB1890.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(136003)(39850400004)(346002)(376002)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(2616005)(316002)(38100700002)(6512007)(8936002)(4326008)(5660300002)(7416002)(8676002)(4744005)(66946007)(41300700001)(478600001)(6486002)(66556008)(6506007)(2906002)(66476007)(6916009)(31696002)(36756003)(86362001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: gpTiWl6YHE/LS76X51R30XPnFguteShT5UPjGdbgyZGisB54aHYc+nqfMOgAwbQKKaOpfNX5jGCcPv4RnyeDMLCGHew5LKPntt6sNpYOcetijU/aiMyH/f2wChbvMfCQfsmzHM2XaUn+JScd3NYIyEVBtIOe4n66GpkbgdF0XWCgsZh97txvnyr4o/L0CeyYKqctJ/QPN/rJCqx8/IpI5Wik61ndAkt7k6RxXwSJQ5VRUoDRtTnng2Ign99AUqJrhP7k36bb/+HaBuXtGYdBW0sZ0c/p3ddZLL1wGuRqqYLY0IMUF1jjZ5L2angkCYEoBoKoEP2p6G4G4EgdoEW3MJffg8WrIOLUivdqKp7U+s1au+SISydB89SD8h7t1GdA/WzHWygpjAYcPLXdmIU1RdhtVwCPicwiOfe02RSIlNM+ZUsORGQwpOy4GSm7OeDoIR9EWJhQ8i0MNftWuMHNWi1Z6a4XogNnST+fYRHlifaFvMrgTisNrJr2orfxr6JwH16HsH2gOwngvZCnS1euu2F+wdtScDx0pJXJRh715hqHuCgIY1OZ5VvV/ckZXnsHV9xifzH5ms/Gxm/1RZJgq5BOwqWtPmjr5yNbzOEhonq321dNnFfjMSt1U9KtLb/on2uNyyNuX7L2O9a2llJ+xF2psYMes9eQIfulq7WYXBiY+cYYrskl0fq9pE4Tak06+cmz3ivlUmeOodbwCA/74D9lXBkPdlmuN5N0wpK2pNFPyd749PnVQrrVtQi8HKZqKPiMhdCP8uRG3XTKna71UBp3Mki7QL7XCqyCWRKgRXXezoryWT7sMH3j1WXURkrmBTQoczi4jVwQK8DELub0OnM/XZe3sMaola5mWZZ+wKBUzJUJKDMztmO7F3IYcZ18TFeZaEgv/7ERFffuTrYdCEEd0cfl7JfAMazc9Rn6Dq5cfQ5cYBfZNNSWt1YhOXkb
 dtylOOk42B8Y8Bi6MVdrVJT6lSiOFH/JNpQI721ZoYaE4VHssHGjhxG5ykv3bYjzuwFaUtZ9lz4bhSx6CR180v2/jgiL/D/dmpDEFK7XtJZzQ1Rw+1ZJpx6F9lTPKXlhhkm3uhkxT9UrYYy5MtgutYBmrb+OhxuceY/zHQdoQ2y1WvqKQFEdM7gS5lMXXMXVurTvjQkIS8XqBqQtE7HhL6mhPlQUvFbhoK7y7e0649nP2n/1lrl4tKgGBqT3Bmiyx0jvX9MtlvJNLespUlGDM+Nj3ERw78mygDOK1paM4kK6o3w15wMqBEQS52UFpFt8PB9rqA3zcKjv1hjY3WnMLmcH0XCXCrNfb7qiTw7MZPq5Htqr/tXoZKWSkA05twBRWoNXjomO/gYlHJ4UOu3RTuTpiwRr0XAOZaqn4QaqH8r16478u/0mcAMD+XaU3WkEUWsCUZbghFwQ2QCl0jPgAV0z6PsAnwFg2cm0vTzjwYyoctATQLiE/rmJ25lPWRU5yMW+JMgMLq7DGbtoSsiCaEAYf4XtTkhjpRfoV6U+vlxJGV8W/xNT+Di71nq2ghbmAJQmFexoKVSqGzec2NhQjr04vmcuvcHsshH6JJXzdSk95S5fMx3y/W9h8/4mMaidx6VrrWOLxJRx1TSKRhEBGjwCGZAPCL0HUHqFuyykzCNIu6yl3gA4OcoP+wITKBf2
X-OriginatorOrg: kalrayinc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d966867b-a343-419e-6150-08dc015bdfb1
X-MS-Exchange-CrossTenant-AuthSource: MR1P264MB1890.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2023 13:02:08.8439
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8931925d-7620-4a64-b7fe-20afd86363d3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nNW+AzXPwu00RLxwjx4+HlAlL3rkeKZDlWDldvRyrR8eq6C7cFdIDD/+y9NS+7YY1ipmrYbL2H0mflyHuAH3sQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MR1P264MB1988
X-ALTERMIMEV2_out: done

Hello Greg,

I tested 6.1.69-rc1 on Kalray kvx arch (not upstream yet), just to let 
you know everything works in our CI: running on real hw + qemu, running 
tests using lots of interfaces (usb, qsfp ethernet, eMMC, PCIe 
endpoint+RC, SPI, remoteproc, uart). LTP and uClibc-ng testsuite are 
also run without any regression.

Everything looks fine to us.

Thanks!

-- 

Yann






