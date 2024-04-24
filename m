Return-Path: <linux-kernel+bounces-156281-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A414E8B00BC
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 06:58:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EEC69B21B57
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 04:58:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CFCA154BF3;
	Wed, 24 Apr 2024 04:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="KBAeczAP"
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED8A6328DB;
	Wed, 24 Apr 2024 04:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.156.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713934667; cv=fail; b=jDKlQw/auwnlaYfxRTGd9a4nqtBvBQP+/lw96nZepnZKWrxGF/yD+rDqgOcCLTaWiS+PQPHANRJ5acZjwQu8dvBaI3wqwdqJqkoRf0V1pcxhLm9i2n51zxCNqOHy+dwllLy72uOpVRxBkCfcDl8ds16nJeC6uC8d0j8bSS1+r18=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713934667; c=relaxed/simple;
	bh=JVrKW4bNdLQneX2vQUkBOzxfHOQ9y33I48I+zQfq2i4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=aNyOXJT2E++KG0mNoYQu3x60OgYjJcgqJaps3hVyPkLuglpyqXY+lh+AhFyyJ9IyPsi3iAo+3RboNluOtBogu1XzQw7jrVbEBklehOlZZm/zSz+k0FReZ1cFkq7RXn4IhfJz04ip9s36eGcI0GetUsYq6CPuovIx5TdIxecymkU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=KBAeczAP; arc=fail smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43O0qaXl022561;
	Tue, 23 Apr 2024 21:57:30 -0700
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2169.outbound.protection.outlook.com [104.47.73.169])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3xmd7gmh31-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Apr 2024 21:57:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ngzukK3OHozIxrYSZ66pZAa6TSNM0njXMC+M19c9qG5cOdXnHKO/1t8Sz7N0ZO2daZZ8X4azcerRXlF3yO3FiciP0kw3VppTTb70zVU8WIzfpGSe601uHE4Z30rvVl+IdJ1b+ZgElmqImEYiZJp/SoQ0g5VEyWIhfEynS92oeS3g9CKgvUNhfMx2qqThItHsWhS3sNWIDZH4dlYuPb4cLa5J7RoDEvreLw+5Pmx2pWNiKS0E7qH+e85YJLX9yKpAX9GgEf+KG1hVmpo9N6KxVWGD9xBPf2KBOpjegBDkNrq6LhtGuvJOkLWTEgHQq/i7JMvm5+PkJUnzhSg4EBrXYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JVrKW4bNdLQneX2vQUkBOzxfHOQ9y33I48I+zQfq2i4=;
 b=OoqTuKfkTwNrf3aHsN0T9fe9hmoS2CjR1aGTx+EiZ7IQYPiLZP4o69cFpNMnUMOfM4OLIpg+ElmoZP/WKs8pfcE9NVF/QKVhB0TvkPVeRqvw8XM1He55GKkO63MB8k4NfSuc4L2iDgcFH1gxCsqEHPQRHvxm2QlNI5kYUoVOY49PfFTbltg9BfMOIhgAyUVGWL+ldrgTQ9GCCz3AXRn3eA7xkEXGBVHRZpfJvbwLAOjxbX05/DJnP9H1Bzzyzyc1GmY/s5G2i8pX3oThn3+hqgnuw/XcPs9rLVak2oyLffFtfUBL8bb9g2VVyGDrmBnZ+YmhMLMhxln7m+LJrz9xlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JVrKW4bNdLQneX2vQUkBOzxfHOQ9y33I48I+zQfq2i4=;
 b=KBAeczAP60bFC4ixJkjyXyJTs53vbKftrfN8EoCP+h/wN0fVCyq3XeOUNU7yAX5gz56xde9qDJI9h2l3ZDh15cPPOO63zuXTwcz/SXQkV8eTwRWyIHzVOPjUU7dHfBuc7LOef2X/J2aeEBhN7UdA4MV30FZmYMzzn4BWMtL6Nnk=
Received: from PH0PR18MB4474.namprd18.prod.outlook.com (2603:10b6:510:ea::22)
 by CH3PR18MB5548.namprd18.prod.outlook.com (2603:10b6:610:1a8::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Wed, 24 Apr
 2024 04:57:26 +0000
Received: from PH0PR18MB4474.namprd18.prod.outlook.com
 ([fe80::eeed:4f:2561:f916]) by PH0PR18MB4474.namprd18.prod.outlook.com
 ([fe80::eeed:4f:2561:f916%5]) with mapi id 15.20.7452.049; Wed, 24 Apr 2024
 04:57:25 +0000
From: Hariprasad Kelam <hkelam@marvell.com>
To: Kalesh Anakkur Purayil <kalesh-anakkur.purayil@broadcom.com>,
        Su Hui
	<suhui@nfschina.com>
CC: Sunil Kovvuri Goutham <sgoutham@marvell.com>,
        Linu Cherian
	<lcherian@marvell.com>,
        Geethasowjanya Akula <gakula@marvell.com>,
        Jerin
 Jacob <jerinj@marvell.com>,
        Subbaraya Sundeep Bhatta <sbhatta@marvell.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com"
	<edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "nathan@kernel.org"
	<nathan@kernel.org>,
        "ndesaulniers@google.com" <ndesaulniers@google.com>,
        "morbo@google.com" <morbo@google.com>,
        "justinstitt@google.com"
	<justinstitt@google.com>,
        Suman Ghosh <sumang@marvell.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "llvm@lists.linux.dev" <llvm@lists.linux.dev>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Subject: ] Re: [PATCH net] octeontx2-af: fix the double free in
 rvu_npc_freemem()
Thread-Topic: ] Re: [PATCH net] octeontx2-af: fix the double free in
 rvu_npc_freemem()
Thread-Index: AQHalgPm/eDubODqs0aQDZSekpMRQA==
Date: Wed, 24 Apr 2024 04:57:25 +0000
Message-ID: 
 <PH0PR18MB4474BFBF06C699039D669D2ADE102@PH0PR18MB4474.namprd18.prod.outlook.com>
References: <20240424022724.144587-1-suhui@nfschina.com>
 <CAH-L+nMUhn0n=RmDTi0_5iXAsP=tkr-AbwnYoCnQ+_Q9apW98w@mail.gmail.com>
In-Reply-To: 
 <CAH-L+nMUhn0n=RmDTi0_5iXAsP=tkr-AbwnYoCnQ+_Q9apW98w@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR18MB4474:EE_|CH3PR18MB5548:EE_
x-ms-office365-filtering-correlation-id: 2a1afc4e-67e7-462e-2e46-08dc641b08d2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 =?utf-8?B?MXVaL0ZhakNKdVdWb0Raa2FlelhYMFgxNFdiazNINjJ2aWN3dTJHaGFJSHVR?=
 =?utf-8?B?cC95N3BxUVJ6S2dXZDV1SklZbHRMa0xTZE5mK3FvTExuR21hOHFQOEpRdytN?=
 =?utf-8?B?cndycXQzK3NTc3RabmY3NjRUL09hQk9yUmdldmJ0M0tvUlNRd2xha0Rhb1Uw?=
 =?utf-8?B?eGRBOThOTmRHdEJTUEtkMUp1VjZ2SGFMR1BITWN5cFhBSmR4emdoRlY5MVE5?=
 =?utf-8?B?UnVVZmhWQlFVdVJqMDUwa2xqWEVja2JUUU1FYVRYK1hxcDA2dGZ3MjBOejBK?=
 =?utf-8?B?MTZpZ2VoeW1YVFZNUEtrRTVzb0RSZGJXZjBuaTAzMVFwbUtLcVIwUks5SUh5?=
 =?utf-8?B?bFB2WXJkMFV3N01IKzZQb1owWEZacVMzME0vMEh3MmYwZVdRcWhtRklxMTBl?=
 =?utf-8?B?N1FDNnBjL3l6cURub0U0d1dyZGVUdjF2bC9jUWlreUNjaXVXekpvKzFubmhI?=
 =?utf-8?B?ai9BSmJ4ZURkdW1wUm4vRlViWUZiam43ZllHYVJBakwyZHVlbmppMlJid2xL?=
 =?utf-8?B?M0FoVkVTd01FSkdsTHNibFJER2VkK3JzN2NxeFlVd1ltaDZ5N3F4U1NnN2Zn?=
 =?utf-8?B?YUxaTUhZMHlSZEJIdU9HWnE3MmloUllacHA1ZWJPSUhSVEdwVFc2T0Q5MkI1?=
 =?utf-8?B?dGRiQUlHWU9IbEI5SmNDOWZITTVsOGEwOGFvYVk3cDVvQ1dzNjhpeHJrajdk?=
 =?utf-8?B?V3JUcEFxSWNxa3hObloxbFpjQ3RoZTg2b3RhQk1aa2s0MlBEeWo5eENFTkJO?=
 =?utf-8?B?ZnhnbjRzRkhPbTlIMzlwd091SEg5amdEdC9VOXNQMzNCbmR0Yi9rK0lpSzNr?=
 =?utf-8?B?R1hleWlQUDJvZVdvNmNyaThWdDZ0L3lJakhSSDlxdHhma2VmQmw4bmpHb0d3?=
 =?utf-8?B?OGhMbzF3MGpVWTFqSnFUeFJIaXJCS3BGcjQ3TTVxamppMmJaVEhNc3lIdlpG?=
 =?utf-8?B?VEx6NjFGTEpFNkNWTkZIcW1zZ3czZkwwSjM1MkJIb0JndGdZK1lndE91bzFr?=
 =?utf-8?B?NEJsS1hONE1Odk1NREJUVU5ubG1qVWhwUTY4bzBiT01QNzlsRXZTSk9Ta2Ra?=
 =?utf-8?B?VnRpd1d1eVNYQ3ZOZ1V5MDB1aGlNajlqVmc4SXo3QlBHbnJLQUtNcjVvMDhD?=
 =?utf-8?B?ZGNWT1hOeEZyZ1ErbE5MYnh3blJYSWozdUFnYlhZbld6TC9hWVYvc0dQcTV4?=
 =?utf-8?B?YjZKdVFJWVJwVXRoT09PTThFekgxMmY5cEZxcFprajJGazNTYzVib2Nvd1Jx?=
 =?utf-8?B?djNMRVRrZ2tvL21RcU5YZjZnMldzNENiQVN0ZHdkR0pSelZlQ1hkcDcvTzFT?=
 =?utf-8?B?clRoM0svUlEyY1VsL25UYnkxUzJ2ZUlDZUJ1TUsrRHJGWWQzcTk1ODJ3d2dj?=
 =?utf-8?B?RUtZWFRKckpsM2VJUlM3Y3lnaHdzYW0zdzRVeUJnaHpKSG0yS2xOK0UrMUZE?=
 =?utf-8?B?Qjl4c3RHRW50V3RCdjdLb0NHN05jcW9jRVhnU2lqZlNkSFhTZjhQWTcwR2Z4?=
 =?utf-8?B?UCtDdTh0MUhMMVE4MVgxWlpTVUc2T2hRYVIxVzdJRGxpaUVQektZY0hiSXRv?=
 =?utf-8?B?MDZWbGZsbjJUZjlGVjN3cUpqcmp6TndERUZPR1JzaGRuYVhESGlMUEQxSytD?=
 =?utf-8?B?ZDNJaUZDK0F2TXhucDNSK2pxYWlVQnlCbDBmbHFKK3RJdldHaTRjdk90ZGhq?=
 =?utf-8?B?OVBlYUhldk5KRml6K25Yd1BMQmFKSlJ2OG1Ub3VQcWtsTEJYaFJvaE5KZWZH?=
 =?utf-8?B?K0tjNlVzaEJpU3p6dGlwOE9PSnlMQ2sxdFZ4VVpFOURKN1JQWDVGWS9PdWJK?=
 =?utf-8?B?cXpBVHc4Ylk1YjdGUDFOZz09?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR18MB4474.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(7416005)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?MDE1cnlaL2RodjBFa3lHVXhGZjZnR080ZzJCQXJad0ZwZ2dTRDB5Si9IOWJI?=
 =?utf-8?B?ZWxYbHNMcnJoNzBmS3VPbXRsU3JFTEs0enZNcW5nUFVQMUYvcmZSMHFrSVRq?=
 =?utf-8?B?UnptbFV4bExkNHRkV0F0QTVzdTY1d0czczQ1U1hYNGZaaXZBeVlWNmxXWnor?=
 =?utf-8?B?YzNaZjN6UGtFV2pITHQxQ0lRbDR0a1k4eTJZdWZ5eXFuKzdvK0EyU05vK0xY?=
 =?utf-8?B?ZEk1TGdGMCt4RG1JQ2V3eGFpSENzRGlXejJnamIrcE5NcDFxSHo5b2J1cmlD?=
 =?utf-8?B?bWRmNENoNzd1QkU4c0lsNjBBWDIvSVdYam9Kek5jRlFLMkZzTHRqRkJSZzJm?=
 =?utf-8?B?TXk1aDFQRUwrOU01YjQ1NVNZS3U1L0lNVEpLc0V6cjUrVllFRlRza285VDRT?=
 =?utf-8?B?NU9HUmp3L3drWkJ6dFd4UzgwQk1seUhiaHVuemY5YWJRQjRjaHMxdjIyYjAx?=
 =?utf-8?B?N1BLTUdaYUF4NE1ORUxhdmlRaFJWWHBSTzlSTlRDbDE2SkE3M3NYcXBRbjly?=
 =?utf-8?B?SkpTUDZTRjJzKzcyRWkvT3hVcVNrb3QxY09Gek05cUlza0VjRnlTK1dVQi84?=
 =?utf-8?B?SXRBVDl3UWEyK2NsVXQ0WFdnRm95TTVscDduTnE5Q3o4QzBucWk3c1FYZTVP?=
 =?utf-8?B?WGVjaHQ3NnZjZTBkSERXMW5vRkdETHovamFabnNUYm1TNnRMcTA2WXhwLzZT?=
 =?utf-8?B?Y1ppb1NxS3JjdFhJV0xPRDlHQmxJeUhubzQrUmJWN1pvaGlrMEZ0T2IrSUJz?=
 =?utf-8?B?Ynh3UWQ1YVBvTUoxNzVsRkxKQ2NkK051dUV3cFYrM2tSQm5hL21MM3czbC81?=
 =?utf-8?B?YWxkR0luZmVCTjNXYkNXbldQVU5aWTFJRGNiQXkzZ1lnVFpFWGhleTVsUzln?=
 =?utf-8?B?VlE5VHB0dERXbStJcHI2S3M1Z25DSGpRV2FLODFvbDgxckIxbzk1eTlEaVNZ?=
 =?utf-8?B?V2hHUHFjdjlxQ0FGL0NJYlhRbEZ6UEtERHFDNUpWenI0YktOMUVKdnpzYnJ6?=
 =?utf-8?B?YTZZQ3ZKdzYzU2J1NC9IQjVkQXV0dHRrYk5FOXdaUXd2aStKNElKZnlYUXpu?=
 =?utf-8?B?WE15Q0VUcW1aV1F2YWpzTjZaOFJncCtIakF3end4YkpPNW91NnJXYndMRGJh?=
 =?utf-8?B?SEZHcmIvdTBFS0xtZFpjS0J2ZW1KYkMraW45Y2YvS3ZxSWdYTkFyYWVScGRv?=
 =?utf-8?B?d0FrU3BZQ05rMjYrdkpZTXZhY09sbmd1NVlETzZmaGRaZWdrZ2x3VGlMbkRU?=
 =?utf-8?B?Tk1ZcTNydHRCeWozQzlzL1hUSWlCd2JydDgzYWE2MERZOGh0RFFKbTlDRER0?=
 =?utf-8?B?YVd5UkRxVFR1TzY4a05ZNnM1cjhHUE5yTVJyWXdlU3MrS0JVdnJ6UjR5LzIy?=
 =?utf-8?B?akZlRDRzME13SVFtTGFsQkR2QUhWUmNHZTZMRWFsem9sWDlEVDVhVmNyR2xM?=
 =?utf-8?B?dloxeGFJeDhXT0xCY0FCNUhreWxmOURUQ210N01HSkdPdlVzS0x3Uk9ocTky?=
 =?utf-8?B?WVUxMXdQUXU4dGlWQTBUUEVNbjhXYWFqcC91UEF6cVp1UWJmTXZFbXRkRzJz?=
 =?utf-8?B?dVUxeXlSVGFkaXFpQ1NnWE5aVUd6K0JuU3Z1MDJRZUliT1FSYWJISHBLcVV2?=
 =?utf-8?B?Vi95S24wa00xK2pkcnNZZ0RYMzdrTnBwYmRQTjIvT3djTUxRYklHVWFNMHJN?=
 =?utf-8?B?dUtHQmFaK0ROV3RpRDVEVVZuUFVPYlovQjlmYlYzRzc2bWRJd3NRRkQzM3Nl?=
 =?utf-8?B?WTdCb21rUHVpc2JyR1YzUWRCT2VjSWlWa3JWTVhOUWp6cFdRRy9GaERNd2Nt?=
 =?utf-8?B?M2h2R1MrbitDMlM4cHhwam1zOC9SV2ZmQmI2SzFmUjlVZFVmV0Z1M0hyUFhk?=
 =?utf-8?B?SFVKLzdUVjhhMG9aVXFwTDBQRzc1ZWQ2by83VE5vZ2xLSTdlM1o1dVdCSHpw?=
 =?utf-8?B?eGdNZ3JpMTk0UVpUNU9wZUJRbC9CZENRZU9ySEFYUUxiM2FZYnIwMTlXL0hy?=
 =?utf-8?B?WXAxNCtHREVVSnlOZnUxRStwbnRQQTU2R20yZ3FjaExpSnZRS2dvTUhNWmY2?=
 =?utf-8?B?VXBYR2dFSlJNK2NXRC9NMG9oMFdjY1QyT05aRGZQNUkzUTZUUzBtZmpUQWc1?=
 =?utf-8?Q?AGNw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR18MB4474.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a1afc4e-67e7-462e-2e46-08dc641b08d2
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2024 04:57:25.4048
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LCqVrnUOrpPaQ2tEUIfFvY9lUKCTbexY9lhj1tF7a2OUK+YHRIybdoJ9+TiN8/3Es2UGA79bbNzSDig40Blm2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR18MB5548
X-Proofpoint-ORIG-GUID: NBJfAzw-Sf9AyOnsGvwljoTBMPe7cvm_
X-Proofpoint-GUID: NBJfAzw-Sf9AyOnsGvwljoTBMPe7cvm_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-24_02,2024-04-23_02,2023-05-22_02

DQoNCj4gT24gV2VkLCBBcHIgMjQsIDIwMjQgYXQgNzo1OOKAr0FNIFN1IEh1aSA8c3VodWlAbmZz
Y2hpbmEuY29tPiB3cm90ZToNCj4gPg0KPiA+IENsYW5nIHN0YXRpYyBjaGVja2VyKHNjYW4tYnVp
bGQpIHdhcm5pbmfvvJoNCj4gPiBkcml2ZXJzL25ldC9ldGhlcm5ldC9tYXJ2ZWxsL29jdGVvbnR4
Mi9hZi9ydnVfbnBjLmM6bGluZSAyMTg0LCBjb2x1bW4gMg0KPiA+IEF0dGVtcHQgdG8gZnJlZSBy
ZWxlYXNlZCBtZW1vcnkuDQo+ID4NCj4gPiBucGNfbWNhbV9yc3Jjc19kZWluaXQoKSBoYXMgcmVs
ZWFzZWQgJ21jYW0tPmNvdW50ZXJzLmJtYXAnLiBEZWxldGVkDQo+IHRoaXMNCj4gPiByZWR1bmRh
bnQga2ZyZWUoKSB0byBmaXggdGhpcyBkb3VibGUgZnJlZSBwcm9ibGVtLg0KPiA+DQo+ID4gRml4
ZXM6IGRkNzg0Mjg3ODYzMyAoIm9jdGVvbnR4Mi1hZjogQWRkIG5ldyBkZXZsaW5rIHBhcmFtIHRv
IGNvbmZpZ3VyZQ0KPiBtYXhpbXVtIHVzYWJsZSBOSVggYmxvY2sgTEZzIikNCj4gPiBTaWduZWQt
b2ZmLWJ5OiBTdSBIdWkgPHN1aHVpQG5mc2NoaW5hLmNvbT4NCg0KUmV2aWV3ZWQtYnk6IEhhcmlw
cmFzYWQgS2VsYW0gPGhrZWxhbUBtYXJ2ZWxsLmNvbT4NCj4gDQo+IExHVE0NCj4gUmV2aWV3ZWQt
Ynk6IEthbGVzaCBBUCA8a2FsZXNoLWFuYWtrdXIucHVyYXlpbEBicm9hZGNvbS5jb20+DQo+ID4g
LS0tDQo+ID4gIGRyaXZlcnMvbmV0L2V0aGVybmV0L21hcnZlbGwvb2N0ZW9udHgyL2FmL3J2dV9u
cGMuYyB8IDEgLQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMSBkZWxldGlvbigtKQ0KPiA+DQo+ID4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L21hcnZlbGwvb2N0ZW9udHgyL2FmL3J2
dV9ucGMuYw0KPiBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L21hcnZlbGwvb2N0ZW9udHgyL2FmL3J2
dV9ucGMuYw0KPiA+IGluZGV4IGJlNzA5ZjgzZjMzMS4uZThiNzNiOWQ3NWUzIDEwMDY0NA0KPiA+
IC0tLSBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L21hcnZlbGwvb2N0ZW9udHgyL2FmL3J2dV9ucGMu
Yw0KPiA+ICsrKyBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L21hcnZlbGwvb2N0ZW9udHgyL2FmL3J2
dV9ucGMuYw0KPiA+IEBAIC0yMTgxLDcgKzIxODEsNiBAQCB2b2lkIHJ2dV9ucGNfZnJlZW1lbShz
dHJ1Y3QgcnZ1ICpydnUpDQo+ID4NCj4gPiAgICAgICAgIGtmcmVlKHBraW5kLT5yc3JjLmJtYXAp
Ow0KPiA+ICAgICAgICAgbnBjX21jYW1fcnNyY3NfZGVpbml0KHJ2dSk7DQo+ID4gLSAgICAgICBr
ZnJlZShtY2FtLT5jb3VudGVycy5ibWFwKTsNCj4gPiAgICAgICAgIGlmIChydnUtPmtwdV9wcmZs
X2FkZHIpDQo+ID4gICAgICAgICAgICAgICAgIGlvdW5tYXAocnZ1LT5rcHVfcHJmbF9hZGRyKTsN
Cj4gPiAgICAgICAgIGVsc2UNCj4gPiAtLQ0KPiA+IDIuMzAuMg0KPiA+DQo+ID4NCj4gDQo+IA0K
PiAtLQ0KPiBSZWdhcmRzLA0KPiBLYWxlc2ggQSBQDQo=

