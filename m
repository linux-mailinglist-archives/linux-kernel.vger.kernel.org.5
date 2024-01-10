Return-Path: <linux-kernel+bounces-21934-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C560C8296C8
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 11:00:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59EAC2896DA
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 10:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B4DC3FB26;
	Wed, 10 Jan 2024 10:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b="GpuBT+yZ";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b="syw5P1GD"
Received: from smtpout39.security-mail.net (smtpout39.security-mail.net [85.31.212.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 571103F8D6
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 10:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kalrayinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kalrayinc.com
Received: from localhost (fx303.security-mail.net [127.0.0.1])
	by fx303.security-mail.net (Postfix) with ESMTP id 4435330F3E6
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 10:58:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kalrayinc.com;
	s=sec-sig-email; t=1704880698;
	bh=JaSKp2aG6giJAY0X0ecFU6SrPUtjSggGRFIGTKn6ZFw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=GpuBT+yZe4qcoNK40AvDpISlCvNMm7PsgHeMxHw4vVC7DV4V9yzjThkHJvVoTrlcy
	 cNxJQEe25Im9xaWGf81a/exVZksLxeRHiOxSIuwkEYw9jxpojiqomD88NmGbo6Oc1k
	 88k75qxgoFi1W0Guqi69/fP4fsDSewmsF9KbReJM=
Received: from fx303 (fx303.security-mail.net [127.0.0.1]) by
 fx303.security-mail.net (Postfix) with ESMTP id F33D130EC28; Wed, 10 Jan
 2024 10:58:17 +0100 (CET)
Received: from FRA01-PR2-obe.outbound.protection.outlook.com
 (mail-pr2fra01on0100.outbound.protection.outlook.com [104.47.24.100]) by
 fx303.security-mail.net (Postfix) with ESMTPS id 4A11030EF84; Wed, 10 Jan
 2024 10:58:17 +0100 (CET)
Received: from MR1P264MB1890.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:13::5)
 by MRZP264MB1943.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.18; Wed, 10 Jan
 2024 09:58:15 +0000
Received: from MR1P264MB1890.FRAP264.PROD.OUTLOOK.COM
 ([fe80::1300:32a9:2172:a2a]) by MR1P264MB1890.FRAP264.PROD.OUTLOOK.COM
 ([fe80::1300:32a9:2172:a2a%7]) with mapi id 15.20.7181.015; Wed, 10 Jan 2024
 09:58:15 +0000
X-Virus-Scanned: E-securemail
Secumail-id: <26bb.659e6a39.490b4.0>
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BoT3eqB0AbyB2eZc3dRekP5EPyxC8Rur+g12ydJATtmSbUeiJlrikn0R834QzzeC815Qy3N8WV0bUHOwmgx0eCuXCObXx3onmp1XdbSgYTW/UJJQssDFDL6iNMCmk4o4aCOULRT6KJ+RRaQrxWjbbi12fHD8it9CdaIhCZ5zxJffr+1B24i1lu7BzTTySacVd5Hw7t1aglEtCyiPsgq+W4jtAJdJIL1W+OLG6V7nTSIDviAta2dtvUkCATKWEqMDmmdtSpavCT1mhb+CmfDaf6nJLCwgGBxQRh2rgH5Dax2Pb5UCB4trBJRy6+UuooKGr0xN9UkSu8fay6myed5Zvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microsoft.com; s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LrnCcpUA2xIUTMK2QQOZoliwACtwKUVIvf3A98o6tPI=;
 b=Q2MM9PLUURqKHk+aJH/ugJEe63r6ef2qlLPAIYUF/f3SDcxpXyawNGJlT2FXkJBqph8d9KHbAOEnpRGZb7LhYcj2qskI/8dsijd8SYytwQAyddNTIcdsfj/kMQa3p86JsTTVradVEBhwjhu/DLb/e8MfmdCZ2qNdNsnKkgep7Jt6SSxP7rtSBv2ALuhBs98fOrCth538JZC2wJvupzvQtf3mOqj7pl+y/sd/xbrX12pjcz8dLmtubsdsYhnA1Oeq9ryDWblrjZJ6cwMJvf98ETtrJtsTG1JV9xBrTzDmvJTkd6u9IiPhF0RNtxEM5NqJ4SxYYPpwWwgXc0B/bFLVXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kalrayinc.com; dmarc=pass action=none
 header.from=kalrayinc.com; dkim=pass header.d=kalrayinc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kalrayinc.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LrnCcpUA2xIUTMK2QQOZoliwACtwKUVIvf3A98o6tPI=;
 b=syw5P1GDvu6MqcrQiuVfj2pPEiiDNRdrYhFa6EcvhyKDA7Cv5sXbFaEvp9qWt74qIwt+9lXN9loaO16fITX8hZ8pGAncpMClJ0OzQGeWIs5f0eaisZV8mpZ/5dVt4i3jq8Z/JgWQO/GsVOQ126WqDBU0KGLLIT0lP2QVfsu4O4aqNAuzmGG7gx7aNuAwJV/yebYpE9xnL33+E5MLJTq/nDS4azM33HhnP8kiT0tnnYEkQnqcSGBMyORTl8uoMpiZs4YmDPhul6WTbq2yTzGwysTgIWsEFn47v7720z/snZXKK7UN7qjMgaoFZMjgTWw2K21yJ+IN5auHKxfClM8qhA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kalrayinc.com;
Message-ID: <8ffc6434-31e4-4331-a3e7-ac925362774b@kalrayinc.com>
Date: Wed, 10 Jan 2024 10:58:13 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 000/150] 6.1.72-rc1 review
Content-Language: en-us, fr
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, Jonathan Borne
 <jborne@kalrayinc.com>, Julian Vetter <jvetter@kalrayinc.com>
References: <20240108153511.214254205@linuxfoundation.org>
From: Yann Sionneau <ysionneau@kalrayinc.com>
In-Reply-To: <20240108153511.214254205@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PA7P264CA0533.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:3db::25) To MR1P264MB1890.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:13::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MR1P264MB1890:EE_|MRZP264MB1943:EE_
X-MS-Office365-Filtering-Correlation-Id: d920afdc-cc6c-4eef-bf9b-08dc11c2a9e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lOSG0uOkQuOWo5b8dW0Yanyf2szrot7jctyTDhLuhXnglBakBRRba3LHgs2kgO94BW+4EzVZgE1YE80cdhsHi12tkM0MKD/X4g7HT4+YU4AbOs73VhpiuXvvu5qtXUFfSkZ9cW7Fem6KoeibbUmZK7LXyfINxp1mZc85Ye8EsJohwtboqE1SsBJNSgIz4lVoUlBhlyhpRgSnQZW5RPN2e4VduHHG3kQFN3RyLf1QRZJnfaXVcM+je0tUWaZ1+6T+yugqqDw09e5EuuNIxyM52IZ6bWB1BTGTL+dFukp5QZxA5/JOnf8E3PohvUN2U/8rKmF5UUyUvauc3CyW0cm/O4sNQgZ8j2lac6ofv6RJgcie03pIfCz91hdGqeYW73rCIes6ohwTIpglm6Sj8TTvFx2By9zxaPYbJ8LBQdBn4X/Yi0wa4aoJtuHqUQ+mBUU8W/Z2LKIewhmBJwKCjZARlBd2XDnsbXxG1yb4C6J3kBEaTj6SUeT8+0seAwYHsGN5U7ykD8fp9LGd80XEY6zxqhgkCcBglpiqdbT68qVCWALCk/yXcwxgteL0kKmlpIO56lluF/wJYa3Xb6mXwERslsgzLhd1lyfO0N/CsA4EmPa7kHA+ycP9bnnWYYL3iTwn006I0770wFXpjng2GWE9xQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MR1P264MB1890.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(396003)(39850400004)(366004)(136003)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(5660300002)(7416002)(478600001)(966005)(6486002)(2616005)(53546011)(6506007)(6512007)(86362001)(31696002)(8936002)(8676002)(41300700001)(66946007)(316002)(36756003)(66556008)(66476007)(54906003)(107886003)(38100700002)(4326008)(31686004)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: og8Shd0iJGNHKCAmvkSq8xYJNK/tTQOvnF+UCN8Zf45SDb9T/DazqtiAbWxe+/W9D4Esq8NFizuAulg4Fp+zzFDiOCIE+QQGtEWeHvmtBH2JWczgcqjaSlV7QXM/80vZIfc05Lq9VBJcqniCZDJnyKOpxOIWTvn+z+pzQVyEk5TlDdJs3+42hbado+Cnu5S/Etm7LEKDVjR9AOU1NSdgkX2fDI1jyPW4LE/LcLqc8I4SlzDxYKgF1Sea6NRMCVg9/qweGLqTcmB5gkPGcjsF2sEL1w3M5LenamvcndYMlpiZ8bq8DrEa9j4JinFh3bgWgl/8XdeKJyQI5w7YFySk8hcZ32DIF80VF1AMe9MTsRBG9P2mqyknFiI8k6b9GJqOHJOj9cuWf1/+B8IuOJcu+HtWMOV7KciwAB/gbECqUXVCVAcDe78D7Ve2oZ2fcntnu+pNdgO9PZNQWzKnlkJ1RDW2+t+cDREW814YCaSnZObMFuyaGq4U3iRrwxrX6dM2VTQjYJfGYnnZqWarQSIi/Uu3uqQNd43Koc/wV34hxvbBA8eBzBKAJo9T4IPjTmH/rr6sbLzs289ULt7tpP5yCi+L7y+cw6/pbcf8/wX4B7PSRJR3RWnYSbhvO7iLQJkls/K2xCPIo3xwqwSQ6LyCHAY7biMuOp1oP9KpR76DrEkbAMD7fSQIEenxvFwiBxhUDIaO3poECgzuIMuE8LMumxkx+eOZMX+hW5IzUqWlv1hNl0mv0Bs4gbecPPruslXtNMxstpnjQYXyOhe1s3lFVfWKiAHTO+HrE7cR26ASnPTEvW6ipqat7T5n1a2S79ZJ4ePrshgHQTFp0FJ84zOAGqQntwXyz23150Fq2lID5K6s8WE+RW7xyEojvFyL1KM/WAmui0SejNCde3XBWwlWOKkMG2JXu6wU+Oeihpq9SWnJutXJK+DfgWXpi9cc1g/u
 RK+Z9T7nXuyzyWf4hxvdb2kITq11+TiJ0S0FwaGVMXi85kb7SbhtiTYRCMJd0RIp1Iy7V9VsBouSGuyw5rPEsWPywW3xsmqzbqUAW7J1nPvU4kxyOaozQB+DRDD+SamdTqb/uyOUugtlbOKJwHONMEcHPBkEY6ZQhRJVB5zQ8F6jpkT3Gw1RnCzd0+EQdT2SfP1gneAcd8LVal3Cp/m+8qWSW4jNspaqt1h0XRQ5KVNIdFQNdIu4wx3QWv1G4rSzMaTQrNSZXK5fNFqJAZmW/oGKUltfr6FH1B7e0WB/AR64fIK756y13NZDM5nnsoJLSegRZLzsKhvN6JlU2wySUVGknTmxMpJH8THwVOIbpAz9o6I0MIErdLKuYQcw6DwxZB79NMmnZkFhL5mo1JpGlDZShltEPoX4FCr7lrtC8gQqIF8vhuu4afqSi4P5WKZTgfH22jN7lZLXbWcKmFKHpSexMd55gL9ryBeFEMisMJTqpbLKpynYiVhluESI0YZjuvu+mELyZE+J9DO3MElE+ZFTmT0PwDdBVCken9uSh5TkknvPzzucjQoV4zbQq207wkU3Z1iuBn8DdOEt5KQnyes7iW/BIZVm+6PtMKjBnqNZIDQEGnPFooXfJEM91NyBP71x6w3jH0V0pCLVITfXi2XSGVCXJ9Dnu+GCbsk5VQfSGK7LjM6p7MfKpcJJS6LiOtJOc32b62N9Cp/PJZIxug==
X-OriginatorOrg: kalrayinc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d920afdc-cc6c-4eef-bf9b-08dc11c2a9e3
X-MS-Exchange-CrossTenant-AuthSource: MR1P264MB1890.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2024 09:58:15.2751
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8931925d-7620-4a64-b7fe-20afd86363d3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gZHCQ+rXACe99wDhUTPfienHLIvVf8jMpdioNJSpaAMODOBaIj4WBQtOs46/GdmjZ8xlc6b4Sfl+f1MJEjeWOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MRZP264MB1943
X-ALTERMIMEV2_out: done

Hi Greg,

On 08/01/2024 16:34, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.72 release.
> There are 150 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 10 Jan 2024 15:34:37 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.72-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> and the diffstat can be found below.
>
> thanks,

I tested 6.1.72-rc1 on Kalray kvx arch (not upstream yet), just to let you know everything works in our CI.

It ran on real hw (k200 and k200lp boards), on qemu as well as on our internal instruction set simulator (ISS).

Tests were run on several interfaces/drivers (usb, qsfp ethernet, eMMC, PCIe endpoint+RC, SPI, remoteproc, uart, iommu). LTP and uClibc-ng testsuites are also run without any regression.

Everything looks fine to us.

Tested-by: Yann Sionneau <ysionneau@kalrayinc.com>

Thanks a lot!

-- 

Yann





