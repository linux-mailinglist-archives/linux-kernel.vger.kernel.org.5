Return-Path: <linux-kernel+bounces-36608-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D666183A3B7
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 09:07:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07D5D1C22298
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 08:07:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D61D171DC;
	Wed, 24 Jan 2024 08:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=elektrobit.com header.i=@elektrobit.com header.b="yaG6lf0P";
	dkim=pass (1024-bit key) header.d=elektrobit.com header.i=@elektrobit.com header.b="yaG6lf0P"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04335168BC
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 08:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.41
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706083659; cv=fail; b=YryxJIZk8NKoZPfTTxSWGjhvgStqS9iX0WzKec5cYnAVTwokTaC08nv/g7+/EEzFxlpsaDsNwF/wk3HIyA5K2eVj6F3LzXnth7kzODKPfBLfsGrLO1/61AUnivyPRZwWy/oev+YVItDskbRTbSXkZeWkmEglFlVZZbHUgdIc8Bs=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706083659; c=relaxed/simple;
	bh=l8fOL0x4zQGST1FMuoySrDhKHiw7oGQGe6tpy9wdkSU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Y24KtqFkKa2i2oxnnoBbGzVrW6ljLtpnbrsQa7jL8V+p/JIsCFRKEDeXliWhV2HC+xW4Ii22RBuzqv5Nv21SOqJwMIkEUwlmOVxasRUZoP2e651XTggIq1KhUSaz7DrbsXV3MwHCCZUsmG83SunYyKGBQV08KcZejVWcVAu59zk=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=elektrobit.com; spf=pass smtp.mailfrom=elektrobit.com; dkim=pass (1024-bit key) header.d=elektrobit.com header.i=@elektrobit.com header.b=yaG6lf0P; dkim=pass (1024-bit key) header.d=elektrobit.com header.i=@elektrobit.com header.b=yaG6lf0P; arc=fail smtp.client-ip=40.107.236.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=elektrobit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=elektrobit.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=bGFrYuv300Bxh5Qq0ypM1og8KTym1VrLkPSMcqfUQwnf/vEHjgiiwppPRlUNASHenOr4SiRk1eEkowKguCBuBt9+XswlJ/0CZPhWNDY5leySteQ1kMoyAHW4rrSohjOLlWb7sjOtGE+24X9D2lES3a+bs4wRD4EH1YOZejswzVDcUQ6BDjcxbIXc3Otu5o5kDjfShDQdv1hbZ12RsOKXPoOYeKMvOSaW2Kizayd+HKJQ9ubVi0FH85UnjbVhdzVBjaKAWeT1OzAuKlHuVkoxM5XpCNEiIuV24wjblnlQzk3WzpdX/sWHkLw5O+qHuQScPYiA2l9Xxdpm8tEtLzBaJA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l8fOL0x4zQGST1FMuoySrDhKHiw7oGQGe6tpy9wdkSU=;
 b=O4y9abz77WocD9/oSCi00KMVY/Mn8NOuTnGlopAaeNgAv0RWyY7pBKJM98bipofFC3bI+K4YaF08UzPSjd2dj1hhA26eExo8hiihJBISqKbmIDNzUAbAMJSq1KfxUxr7/z+RWjY76Baq/O4TYn6Gn5TgvVnF6Ki524sD5SOLnUMnSB5gzoX/EdUUTXpIi7sKz6EdySL9xpRdksaB578Bt3V7EKAAaOP3LvSvk6PATzBsDh/srHoeuMn5v1VrCe6zZ7v7UsictiaHzgTPUV2Us1fuTJ4POH4DrAoX80r78ENivsHebLTeg8CHlYII9/QfXQxoj5w2rMmsWk3xQfH0ww==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.79.107.243) smtp.rcpttodomain=linutronix.de smtp.mailfrom=elektrobit.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=elektrobit.com;
 dkim=pass (signature was verified) header.d=elektrobit.com; arc=pass (0 oda=1
 ltdi=1 spf=[1,1,smtp.mailfrom=elektrobit.com]
 dkim=[1,1,header.d=elektrobit.com] dmarc=[1,1,header.from=elektrobit.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=elektrobit.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l8fOL0x4zQGST1FMuoySrDhKHiw7oGQGe6tpy9wdkSU=;
 b=yaG6lf0PCCRgwI41B+kOwOJYVNA+6NZMh4QpaBJK9wr2QG/+X/+uHvZ/Nw/lxBcG4AubIwcOh4x7Sy5YpPxeFyQSVj39le4cpkX/VfFm5rBDJQZfnsDzlS8D9ekMDeZLsUIF8Uwv1TZj9IA4/Pxc/AiGT3YSQHShfcFaKyINB+A=
Received: from SN6PR01CA0013.prod.exchangelabs.com (2603:10b6:805:b6::26) by
 SN4PR0801MB7984.namprd08.prod.outlook.com (2603:10b6:806:21b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.21; Wed, 24 Jan
 2024 08:07:35 +0000
Received: from SN1PEPF0002636B.namprd02.prod.outlook.com
 (2603:10b6:805:b6:cafe::7f) by SN6PR01CA0013.outlook.office365.com
 (2603:10b6:805:b6::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22 via Frontend
 Transport; Wed, 24 Jan 2024 08:07:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.79.107.243)
 smtp.mailfrom=elektrobit.com; dkim=pass (signature was verified)
 header.d=elektrobit.com;dmarc=pass action=none header.from=elektrobit.com;
Received-SPF: Pass (protection.outlook.com: domain of elektrobit.com
 designates 4.79.107.243 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.79.107.243; helo=usbth1es003.ebgroup.elektrobit.com; pr=C
Received: from usbth1es003.ebgroup.elektrobit.com (4.79.107.243) by
 SN1PEPF0002636B.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7202.16 via Frontend Transport; Wed, 24 Jan 2024 08:07:35 +0000
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02lp2040.outbound.protection.outlook.com [104.47.11.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by usbth1es003.ebgroup.elektrobit.com (Postfix) with ESMTPS;
	Wed, 24 Jan 2024 00:07:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QnlHI1CkmMwwLspwgTQpl4ea8Rm4lRyxx7a9x822hljiGt/xoLch/6yPa6t3Hu5TxGJTB9Aac/yL2tUma014/EOsP0kPphnml20lcDt6ckUQGBaREjqUsUSpNPu+qXWyIVfs3I8UnV5trtdjbPPtJzHfYKtXRZgajcoZLwG5U0Ro0Jg6IrXINrC7X1iCu0U70ZyPfFq1H6kcMP/0CwnT0fJVblfaQ9zLZGP7uFOzyuL9jV8jsLyEmgXUJA834CaP+zXWjn+E1I0Dz/l+x3bDmAWhoOsPDbE7ZxiuM6tyANIsR7/dHp6vPEkUqslFI4vNsrDvMM1oPUs3uM39G0+3gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l8fOL0x4zQGST1FMuoySrDhKHiw7oGQGe6tpy9wdkSU=;
 b=aQkDdGahw9MnYgF2K4r0eV943T1WluwiA/kXLTZ43Bl88/3k71l+nBg8S6ykjCZvnTl1ne6oD8HkpMIe9S4XVkKhValGF4aL3vkUWK3FnNzuOt6C/bkkp/YARJtBo/cH1WQ7G8GxxCnu0I8l6XHEmWf1OvHwmLklNZ3CoT9ZnUO/XYaX/x7lMJ6pfYxip5CQY+FKxbZGEV/ciKsJ6j1qbZ81RX/iIZfxhV90YmKm2GHoY14aNhjhDQraowAvDj6FP8aWWIltR8yzfJpFSa3Rgp2q2RND3VDM9jY0V/f0HdYUJI48amc2xtgoZZCzW0kKRJpOvg5knNMN+HLR0VKAxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=elektrobit.com; dmarc=pass action=none
 header.from=elektrobit.com; dkim=pass header.d=elektrobit.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=elektrobit.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l8fOL0x4zQGST1FMuoySrDhKHiw7oGQGe6tpy9wdkSU=;
 b=yaG6lf0PCCRgwI41B+kOwOJYVNA+6NZMh4QpaBJK9wr2QG/+X/+uHvZ/Nw/lxBcG4AubIwcOh4x7Sy5YpPxeFyQSVj39le4cpkX/VfFm5rBDJQZfnsDzlS8D9ekMDeZLsUIF8Uwv1TZj9IA4/Pxc/AiGT3YSQHShfcFaKyINB+A=
Received: from PAXP195MB1231.EURP195.PROD.OUTLOOK.COM (2603:10a6:102:1a3::10)
 by VI1P195MB2382.EURP195.PROD.OUTLOOK.COM (2603:10a6:800:1c8::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.32; Wed, 24 Jan
 2024 08:07:31 +0000
Received: from PAXP195MB1231.EURP195.PROD.OUTLOOK.COM
 ([fe80::be9d:a803:2bb5:350b]) by PAXP195MB1231.EURP195.PROD.OUTLOOK.COM
 ([fe80::be9d:a803:2bb5:350b%4]) with mapi id 15.20.7202.035; Wed, 24 Jan 2024
 08:07:31 +0000
From: =?utf-8?B?V2Vpw58sIFNpbW9uZQ==?= <Simone.Weiss@elektrobit.com>
To: "tglx@linutronix.de" <tglx@linutronix.de>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Fix UBSAN warning for subtracting ktime_t
Thread-Topic: [PATCH] Fix UBSAN warning for subtracting ktime_t
Thread-Index: AQHaMnkoqPFYeE90f0+2FRcMN5dHybDWf8EAgBJUDQA=
Date: Wed, 24 Jan 2024 08:07:31 +0000
Message-ID: <42cf844f33c15eb54fa9c4e75f45681a0e3cf10e.camel@elektrobit.com>
References: <20231219124434.870613-1-simone.weiss@elektrobit.com>
	 <878r4uil6f.ffs@tglx>
In-Reply-To: <878r4uil6f.ffs@tglx>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=elektrobit.com;
x-ms-traffictypediagnostic:
	PAXP195MB1231:EE_|VI1P195MB2382:EE_|SN1PEPF0002636B:EE_|SN4PR0801MB7984:EE_
X-MS-Office365-Filtering-Correlation-Id: b1143ff5-ead5-4554-ecc1-08dc1cb38654
X-SM-outgoing: yes
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original:
 8bGk0pFpcpZdYV/S9SneO/XhjH9/Ue/RW1GutPQbzhaxkyM+jrkW6NEhV4W9zcwLDsjSdwUx8EgCUP+mwP5mZ/j/pSQ4FRUwsiJZXnRHEHGCfV1SgDr9+Hb9/1ZdXqN/91py8wID2WNO7UIDXZoJJEy7MiRMedBnQignuQgm04NWbGn/t5Y96P81v1wTiIf51TUpLNtAiToPVpR+f+YxZ3Cp6ubopsgilkGavYbyhAaZng7NATMXyMxVj0yFYlCAadMJnlMldkKPPiCN/2DdZWJ9rVSbNHhfMn6amp3kCvSiGZyFkqj311E4Fw2yTTEYoHfj3ow0eZ5O3C7qk2YVszTDPaxzEDYJz+CNyx2NWU+JL5fhXRYoddmbDVBp8X8SSP1OJQs3ZGRagZIDL2mwzeRF8lT9n4xzVclIk9cCBrNqRPcR9lDNbeESmswX0HqMpaXCzitbnzYIGG/BEq7X9EDTmE4ecw09M12GpZ2iC8uZ9DCebF6srsZaAah8mk9fuSOVQd92nMWhIdH3WnfSyyswNhyjN4vxEd6cc8/zFAbRJzQyeRpW6riJ3MvmokvvCIuyFmLx3cCggUyERxjcvHSwF0YXxfL8Vwg73IHoPt8QAxtMV9DBEPDk0LRTy/AYNCNF51mC48SOOQtcjMcz0Qt5MAJglkMgtSLaiEwxFzZmWQIzpFg620jdHChu6Qhm
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXP195MB1231.EURP195.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(396003)(136003)(346002)(39850400004)(230173577357003)(230922051799003)(230273577357003)(1590799021)(186009)(1800799012)(64100799003)(451199024)(1580799018)(122000001)(316002)(4326008)(2906002)(8936002)(5660300002)(86362001)(66476007)(66946007)(64756008)(91956017)(8676002)(6486002)(66446008)(66556008)(76116006)(2616005)(6916009)(38070700009)(85182001)(36756003)(38100700002)(6512007)(6506007)(478600001)(71200400001)(41300700001)(26005);DIR:OUT;SFP:1101;
Content-Type: text/plain; charset="utf-8"
Content-ID: <F715DBDD2498364EBA7FF134D5EE1285@EURP195.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
 oDt6vzetEmUPl8BbNirxfoJ7zbACjJgHmQX94C4iCdgrU9bgA/DRPnZdA/V6wk5B9Pao/ya4cNzAobP5A0OY6Aw2ypBz+xMi4mpVafN2W2WxyJoQyneQVGaQYbBF4DtUyD4dcvDq8L1qCrG1m1Mm4Yq9Oxt5vicuEMvtSxPAi+6P9I4wJK/6+Chke0Fobz5Qcp4y9LCfyjfiG8OyN5hD0NpfWyHtosKGbE53zGfpDUEFBBv8u156AKvO3iQeg9kATNBwfMDNyKtz+5ZRRG534KC2PJujgTPcqiNQJScN+JYbDeJV6ZAF2N+BDXNh+hoCYMiTFfxIcZz1uytfeh/FsZAhlxu7rV7nxQnNsrfz2TswwQBPY5PKJEkm74C//uet1kOPKmXqlxh/Zs7GahG9X9nL1secwOZR/7dEpe+cQbXcKl+4OZjNArzSPBv264OoXhHYK6XuBivzJqhTNchjfYKh36sNFu72ghm6jyxQCb2vpV67AL6l7vdmsW9InM/IhH8Q5jup+ePgHfkwPmpN65scYSY4+j6A1D61bBOzHND36fxKY+t2RN0sBjlRYeFsH0xdL54OfMp72DNANgMM2IklxP5SiBsTjH/vgN1/dLybto+R5ucMHvIFDiuLeTqNyUy8wkAuiXHxCSlm25cvLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1P195MB2382
X-SM-smarthost: [elektrobit-com.mail.protection.outlook.com]
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 SN1PEPF0002636B.namprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	457b2208-4bd4-4e27-8d68-08dc1cb3838e
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	lo+WLIgli0TTkxMND+95741ZEsrS7uLgds5cf8XlFlqIn9GCX8Uxu668hG72y58Kc3afIQLrLpp/dadCoQhkdiH4ZThxfryC/5DdpEc/gUKV3LMOsDqt25V/AhqYjtIpirkqjXRIf4yUF03truCbXXCV5ad25h+RZjyBv/Ugs2C17Zbj917GFnYxtjC4utNBn17RRNcTeeyYgftWD7CreiX6HJBREjapo0xH+bbjGjO1QfLMsxw2CaG+FoE5fSKTh5OHglWfpc0DZUPd4Dd2ikEd/Ig3TVv45v4udLQxz+TqD+/rnkjN7CPecDvszI5mTPHbFoTF3U/lzATH2WlHjzM6V4D++BdYExuqJmnbBalqsgywFbgVpTvS/1CZ8Q7k2OPX9ABtSgJqMuAncXI8OtwKw4DkAaObIU1B6zAS+Uw6gc9RU9aGH06eCzginYYUWjrVsz0ZkhEpPylIkdRMBl8H0L+4hjI4tIaMQ2GUJ7Kk7xn0j26dW/v4BJOrMeafiG1f/fiw7jWzFacrSojMNbkF9TDwcV5REf3WYTKDttDy+fq6KPlv8M4L160fIwtHWo2EGvxy6L5oEZB96b8AZN8OlN0XFYnoGvY+qicyIOcukTp1pCMszS4g1RNV7nMyZqwSNGJHWJzvN66VhLCOEbvv8qVJZX3d1wNL2CqspHRkQm3DhQ8LuYZ87CXc7yNQeJMJn63pxmSZKTKC4FelmNdv9uzQ4SepN4/gJa4c5NW4YMEGuYTG7b0b+RMVqyOiRahKK8G5wnvlb69J/WnrsHmryA1bAi0a35eLAprrB1CgVprPZ/UTdHLDEVXqDX8dJzl+mwbgO8VCcwspETg8Vg==
X-Forefront-Antispam-Report:
	CIP:4.79.107.243;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:usbth1es003.ebgroup.elektrobit.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(346002)(376002)(136003)(396003)(230173577357003)(230273577357003)(230922051799003)(1590799021)(64100799003)(82310400011)(186009)(1800799012)(451199024)(40470700004)(36840700001)(46966006)(70206006)(1580799018)(41300700001)(478600001)(6916009)(85182001)(70586007)(86362001)(316002)(26005)(2616005)(36756003)(47076005)(82740400003)(336012)(8936002)(8676002)(36860700001)(4326008)(5660300002)(81166007)(6486002)(356005)(2906002)(6506007)(6512007)(40460700003)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: elektrobit.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2024 08:07:35.4141
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b1143ff5-ead5-4554-ecc1-08dc1cb38654
X-MS-Exchange-CrossTenant-Id: e764c36b-012e-4216-910d-8fd16283182d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e764c36b-012e-4216-910d-8fd16283182d;Ip=[4.79.107.243];Helo=[usbth1es003.ebgroup.elektrobit.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002636B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0801MB7984

T24gRnJpLCAyMDI0LTAxLTEyIGF0IDE3OjE0ICswMTAwLCBUaG9tYXMgR2xlaXhuZXIgd3JvdGU6
DQo+IENBVVRJT046IFRoaXMgZW1haWwgb3JpZ2luYXRlZCBmcm9tIG91dHNpZGUgb2YgdGhlIEVs
ZWt0cm9iaXQgb3JnYW5pemF0aW9uLiBEbw0KPiBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRh
Y2htZW50cyB1bmxlc3MgeW91IHJlY29nbml6ZSB0aGUgc2VuZGVyIGFuZCBrbm93DQo+IHRoZSBj
b250ZW50IGlzIHNhZmUuDQo+IA0KPiANCj4gT24gVHVlLCBEZWMgMTkgMjAyMyBhdCAxMzo0NCwg
U2ltb25lIFdlaXNzIHdyb3RlOg0KPiA+IFVCU0FOOiBVbmRlZmluZWQgYmVoYXZpb3VyIGluIGtl
cm5lbC90aW1lL2hydGltZXIuYzo2MTI6MTANCj4gPiBzaWduZWQgaW50ZWdlciBvdmVyZmxvdzoN
Cj4gPiA5MjIzMzcyMDM2ODU0Nzc1ODA3IC0gLTUxMjI0NDk2IGNhbm5vdCBiZSByZXByZXNlbnRl
ZCBpbiB0eXBlDQo+ID4gJ2xvbmcgbG9uZyBpbnQnDQo+IA0KPiBTb21lIGV4cGxhbmF0aW9uIGFi
b3V0IHRoZSBjb250ZXh0IGFuZCB3aHkgdGhlIG9mZnNldCBpcyA8IDAgd291bGQgYmUNCj4gaGVs
cGZ1bC4NCj4gDQo+ID4gKy8qDQo+ID4gKyAqIFN1YiB0d28ga3RpbWUgdmFsdWVzIGFuZCBkbyBh
IHNhZmV0eSBjaGVjayBmb3Igb3ZlcmZsb3c6DQo+ID4gKyAqLw0KPiA+ICtrdGltZV90IGt0aW1l
X3N1Yl9zYWZlKGNvbnN0IGt0aW1lX3QgbGhzLCBjb25zdCBrdGltZV90IHJocykNCj4gPiArew0K
PiA+ICvCoMKgwqDCoCBrdGltZV90IHJlcyA9IGt0aW1lX3N1Yl91bnNhZmUobGhzLCByaHMpOw0K
PiA+ICsNCj4gPiArwqDCoMKgwqAgaWYgKGxocyA+IDAgJiYgcmhzIDwgMCAmJiByZXMgPCAwKQ0K
PiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmVzID0ga3RpbWVfc2V0KEtUSU1FX1NFQ19N
QVgsIDApOw0KPiA+ICvCoMKgwqDCoCBlbHNlIGlmIChsaHMgPCAwICYmIHJocyA+IDAgJiYgcmVz
ID4gMCkNCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJlcyA9IGt0aW1lX3NldCgtS1RJ
TUVfU0VDX01BWCwgMCk7DQo+IA0KPiBMb29raW5nIGF0IHRoZSB1c2UgY2FzZXMsIHRoZSBsaHMg
PCAwIGNhc2Ugd291bGQgYmUgYSBidWcgYmVjYXVzZSB0aGUNCj4gZXhwaXJ5IHZhbHVlcyBhcmUg
c3RyaWN0bHkgPj0gMC4NCj4gDQo+ID4gKw0KPiA+ICvCoMKgwqDCoCByZXR1cm4gcmVzOw0KPiA+
ICt9DQo+ID4gK0VYUE9SVF9TWU1CT0xfR1BMKGt0aW1lX3N1Yl9zYWZlKTsNCj4gDQo+IFRoYXQg
ZXhwb3J0IGlzIG5lZWRlZCBiZWNhdXNlPyBUaGUgb25seSB1c2FnZSBpcyBpbiB0aGlzIGZpbGUg
c28gdGhpcw0KPiBjYW4gYmUgc3RhdGljLCBubz8NCj4gDQo+IFRoYW5rcywNCj4gDQo+IMKgwqDC
oMKgwqDCoMKgIHRnbHgNCg0KSGksDQoNCmFmdGVyIG1vcmUgaW52ZXN0aWdhdGlvbiBpdCBzZWVt
cyB0byBtZSB0aGF0IHRoaXMgaXNzdWUgaXMgb25seSBwcmVzZW50IGluIG9sZGVyDQprZXJuZWxz
IGxpa2UgNC4xNC55IG9yIDQuMTkueS4gQSBzdGFjayB0cmFjZSBJIG9idGFpbmVkIGZyb20gZnV6
emluZyA0LjE0IGlzOg0KDQpIYXJkd2FyZSBuYW1lOiBsaW51eCxkdW1teS12aXJ0IChEVCkNCkNh
bGwgdHJhY2U6DQogZHVtcF9iYWNrdHJhY2UrMHgwLzB4MzMwDQogc2hvd19zdGFjaysweDIwLzB4
MzAgYXJjaC9hcm02NC9rZXJuZWwvdHJhcHMuYzoxNTYNCiBfX2R1bXBfc3RhY2sgbGliL2R1bXBf
c3RhY2suYzoxNyBbaW5saW5lXQ0KIGR1bXBfc3RhY2srMHgxMmMvMHgxODAgbGliL2R1bXBfc3Rh
Y2suYzo1OA0KIHVic2FuX2VwaWxvZ3VlKzB4MTgvMHg1MCBsaWIvdWJzYW4uYzoxNjYNCiBoYW5k
bGVfb3ZlcmZsb3crMHhmNC8weDExOCBsaWIvdWJzYW4uYzoxOTcNCiBfX3Vic2FuX2hhbmRsZV9z
dWJfb3ZlcmZsb3crMHgzNC8weDQ4IGxpYi91YnNhbi5jOjIxMQ0KIGhydGltZXJfcmVwcm9ncmFt
IGtlcm5lbC90aW1lL2hydGltZXIuYzo2MTIgW2lubGluZV0NCiBocnRpbWVyX3N0YXJ0X3Jhbmdl
X25zKzB4NzY4LzB4ODU4IGtlcm5lbC90aW1lL2hydGltZXIuYzo5OTMNCiBocnRpbWVyX3N0YXJ0
IGluY2x1ZGUvbGludXgvaHJ0aW1lci5oOjM3NyBbaW5saW5lXQ0KIHRpbWVyZmRfc2V0dXAgZnMv
dGltZXJmZC5jOjIwNSBbaW5saW5lXQ0KIGRvX3RpbWVyZmRfc2V0dGltZSBmcy90aW1lcmZkLmM6
NDk2IFtpbmxpbmVdDQogU1lTQ190aW1lcmZkX3NldHRpbWUgZnMvdGltZXJmZC5jOjU0NCBbaW5s
aW5lXQ0KIFN5U190aW1lcmZkX3NldHRpbWUrMHg0YzAvMHg3ZTAgZnMvdGltZXJmZC5jOjUzNQ0K
IGVsMF9zdmNfbmFrZWQrMHgzNC8weDM4DQpNeSBwcmVzZW50IGFzc3VtcHRpb24gaXMsIHRoYXQg
aXQgaXMgYWxyZWFkeSBmaXhlZCBpbiBuZXdlciBrZXJuZWwgdmVyc2lvbnMNCnZpYSB0aGlzIGNv
bW1pdDoNCjZjZDg4OWQ0M2M0MGIgKCJ0aW1lcmZkOiBNYWtlIHRpbWVyZmRfc2V0dGltZSgpIHRp
bWUgbmFtZXNwYWNlIGF3YXJlIikuDQoNCkkgd2lsbCBjaGVjayBmdXJ0aGVyLg0KDQpCZXN0LA0K
U2ltb25lDQoNCg==

