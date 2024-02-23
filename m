Return-Path: <linux-kernel+bounces-78928-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 51172861AB6
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 18:54:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71D701C25E3C
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 17:54:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 123CA140391;
	Fri, 23 Feb 2024 17:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=elektrobit.com header.i=@elektrobit.com header.b="jy8ThV7G";
	dkim=pass (1024-bit key) header.d=elektrobit.com header.i=@elektrobit.com header.b="jy8ThV7G"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2104.outbound.protection.outlook.com [40.107.220.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE5E913DB9E;
	Fri, 23 Feb 2024 17:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.104
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708710847; cv=fail; b=D8o4oHWMG3nLSxt2Zu6Qjs69w5adIU+vSsKTAPRn+9fj0PNc3oNesvlGz/g8RYfaI4gQWvb3Q6d5OeSSpOlSh8EpKmCWApzne/eYqWVrBF9lliaCi6LGGBUhukBdNc2Hv4FM00gM+nvapZYCTCMZAKvE/UFI5fFIWuu1W2iynN8=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708710847; c=relaxed/simple;
	bh=aspBwXzsaeyDKo4Wewryzl2+16Nipl2Ami6r7yNTq+I=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LjWNsQBCgKT6cMfkLuviMw1JydxojXu9eVAEY0RpKAnuzKVCJiki7UlE1Da4YX1Wh3ovPHUwfbc4f45aArGSt/nwIHVtbS1Yc3Gn0lR8VpL07pA2EA6g8En/DeEbJWC7pPbsGwZHhD9iB0YKDXb5DwA4v3yIjxWoFq1HB8vK7to=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=elektrobit.com; spf=pass smtp.mailfrom=elektrobit.com; dkim=pass (1024-bit key) header.d=elektrobit.com header.i=@elektrobit.com header.b=jy8ThV7G; dkim=pass (1024-bit key) header.d=elektrobit.com header.i=@elektrobit.com header.b=jy8ThV7G; arc=fail smtp.client-ip=40.107.220.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=elektrobit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=elektrobit.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=PdCu02Y0x+wiwvaZrw9OHizFU2Uo2/EmF1wbr6ayPHL33y6qaYeFMZfVsivSx086bdXiaJEOd5UBGgD7MWf2sSkLjO2aOKahOsnEW+ULx5P3DIWNSAzNfWxE36o/MUWC1zjBcIfi+oKmIZsh3fSYi1zewnRVYsy2qoo1TXhK9MsS77inJaz2WDMLLGd7IXydjFRLASYosSNiCNwVeo1NMrB/FVac2GZ3q18nK8QSpZVUmPzYiD089D4MtLhoZQqQu3icO9oXf2hRpmq5iJPTW+Shhm9gT4qxafgnwIge5HDpNW+ag9G/8egzMY903C8jC84KFvWvomY7bwRXN75czQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aspBwXzsaeyDKo4Wewryzl2+16Nipl2Ami6r7yNTq+I=;
 b=OzHcSXyp0VDoaNIqe6ikzq8mWSsLVVdgnOtXIqBeiVx4TdDdte6D0l3mObaANPmHEMEoXXn7yXjsp9Q9LAKcmj0is1VNBCggjWa7ukD/GJecw/GTHdurrAhEKToSD0lgEONpr9pra891xS3iHJt8/z2W6JbFUOHvmjNMlWG0/GQ32CsrBajpybRToDLFfh4/qQ9Pvd8gmlgqxsxU96WxJI0E4bkT6bcEaiZFDxe53T00Y89aXGMShUNdr2qZmLi1kSPHvW40K5L1ANOKQtcAGtyuU3tGeGoOvpnbjgsLcBf9ghJY0Krxm0307gWNfMtl0TLBcZllV0EbUrhlIUVPmw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.79.107.243) smtp.rcpttodomain=gmail.com smtp.mailfrom=elektrobit.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none
 header.from=elektrobit.com; dkim=pass (signature was verified)
 header.d=elektrobit.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=elektrobit.com] dkim=[1,1,header.d=elektrobit.com]
 dmarc=[1,1,header.from=elektrobit.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=elektrobit.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aspBwXzsaeyDKo4Wewryzl2+16Nipl2Ami6r7yNTq+I=;
 b=jy8ThV7GvD4RTlf/fR2YJitMNrH/lZFLyew+A8LDJtoRaD9QSfTSbdfE1J7lxT9iisDhj9KVvXsOU+5VZgOZSu4oVmxaVYaVqwO3l5/adhbHE1f8c+1aIjcCwTh1KpJdtSsiGMAH4aYSjWpeYnjuXM+Fnb7SqL/nCDEvq/e9lXU=
Received: from BYAPR04CA0020.namprd04.prod.outlook.com (2603:10b6:a03:40::33)
 by LV3PR08MB9070.namprd08.prod.outlook.com (2603:10b6:408:212::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.24; Fri, 23 Feb
 2024 17:54:02 +0000
Received: from MW2NAM12FT003.eop-nam12.prod.protection.outlook.com
 (2603:10b6:a03:40:cafe::f1) by BYAPR04CA0020.outlook.office365.com
 (2603:10b6:a03:40::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.43 via Frontend
 Transport; Fri, 23 Feb 2024 17:54:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.79.107.243)
 smtp.mailfrom=elektrobit.com; dkim=pass (signature was verified)
 header.d=elektrobit.com;dmarc=pass action=none header.from=elektrobit.com;
Received-SPF: Pass (protection.outlook.com: domain of elektrobit.com
 designates 4.79.107.243 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.79.107.243; helo=usbth1es003.ebgroup.elektrobit.com; pr=C
Received: from usbth1es003.ebgroup.elektrobit.com (4.79.107.243) by
 MW2NAM12FT003.mail.protection.outlook.com (10.13.180.70) with Microsoft SMTP
 Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.7339.19 via
 Frontend Transport; Fri, 23 Feb 2024 17:54:01 +0000
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05lp2104.outbound.protection.outlook.com [104.47.17.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by usbth1es003.ebgroup.elektrobit.com (Postfix) with ESMTPS;
	Fri, 23 Feb 2024 09:54:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MgoNYC471suNuWp9Y6/SYaKNKQ2c42iX9fQ6lkRlM8qUq/BIzcAXp06P1zEGvOqTGjNG7PyR5VQnTO1IgYDs0raF95xTOdBbkwuLpiFuCUS7PfvAevZaeBJEAMxQZcD3yN2/Em8V4ovDGgw4SmxkHAbxkIcxjOZCXCz7bazjcHMcOqdiqcZcgoWYPdOiQDQRKK3typvsMOzcYsaC3xKFy0TebU4NAd/NE5dKZ8Z8u2QhXW7VZ6EI9chlV7mEzsZ4cCUvfgiOMvP6w+Et7d2mTN07ddqCTEk7qFWHwSNnuSig6uG7O8ZtFuq3slsSkilUq4BZOS7LJAPfaEYchhaFpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aspBwXzsaeyDKo4Wewryzl2+16Nipl2Ami6r7yNTq+I=;
 b=R1Y2yAXyvX7qoZJIWXBD1KprgtyTipcfJSywYRxyWwi0yMPWgwm97ieh4haq9zWfoFk1L+xEb8Pz/gwonVvQRpCVjTP6PCM5N6H1ibFrRklglb5+mDpbYh2UWHg3Audwx6NjVpb91TpSP9Wx6lpVpH8TB1485n4upzfM17fQkzVJNYjxZgkijTsXq94elvMsD4BVZjYZQ0GlFwcCocZW9uGaP8Zzv5TJ+t+HhfhNpd95bHsxxS9mmHbymqD9FSOMNq1IORoLXYZmjMBzrxL7EF56EQ4tWsi0fsScJs/+zaPusPrAqrxqOBy8FQ+cOwiNf242tlGEqnF60+D2uyXKrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=elektrobit.com; dmarc=pass action=none
 header.from=elektrobit.com; dkim=pass header.d=elektrobit.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=elektrobit.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aspBwXzsaeyDKo4Wewryzl2+16Nipl2Ami6r7yNTq+I=;
 b=jy8ThV7GvD4RTlf/fR2YJitMNrH/lZFLyew+A8LDJtoRaD9QSfTSbdfE1J7lxT9iisDhj9KVvXsOU+5VZgOZSu4oVmxaVYaVqwO3l5/adhbHE1f8c+1aIjcCwTh1KpJdtSsiGMAH4aYSjWpeYnjuXM+Fnb7SqL/nCDEvq/e9lXU=
Received: from PAXP195MB1231.EURP195.PROD.OUTLOOK.COM (2603:10a6:102:1a3::10)
 by AM8P195MB0819.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:1ee::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.24; Fri, 23 Feb
 2024 17:53:58 +0000
Received: from PAXP195MB1231.EURP195.PROD.OUTLOOK.COM
 ([fe80::dd67:dab1:27ba:981a]) by PAXP195MB1231.EURP195.PROD.OUTLOOK.COM
 ([fe80::dd67:dab1:27ba:981a%6]) with mapi id 15.20.7316.023; Fri, 23 Feb 2024
 17:53:57 +0000
From: =?utf-8?B?V2Vpw58sIFNpbW9uZQ==?= <Simone.Weiss@elektrobit.com>
To: "mpatocka@redhat.com" <mpatocka@redhat.com>
CC: "song@kernel.org" <song@kernel.org>, "Tomerius, Kai"
	<Kai.Tomerius@elektrobit.com>, "simone.p.weiss@posteo.net"
	<simone.p.weiss@posteo.net>, "agk@redhat.com" <agk@redhat.com>,
	"linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
	"dm-devel@lists.linux.dev" <dm-devel@lists.linux.dev>, "yukuai3@huawei.com"
	<yukuai3@huawei.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "lukas.bulwahn@gmail.com"
	<lukas.bulwahn@gmail.com>, "snitzer@kernel.org" <snitzer@kernel.org>
Subject: Re: [PATCH] [RFQ] dm-integrity: Add a lazy commit mode for journal
Thread-Topic: [PATCH] [RFQ] dm-integrity: Add a lazy commit mode for journal
Thread-Index: AQHaW43LYOGlNHnfu0CczaL+NCYlN7ETpNcAgASmmYA=
Date: Fri, 23 Feb 2024 17:53:57 +0000
Message-ID: <3e5a2087667333bb88135a6b6f9620201989605f.camel@elektrobit.com>
References: <20240209192542.449367-1-simone.weiss@elektrobit.com>
	 <8a485b9-6dbb-78c-9a84-ed3ba65d9cb3@redhat.com>
In-Reply-To: <8a485b9-6dbb-78c-9a84-ed3ba65d9cb3@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=elektrobit.com;
x-ms-traffictypediagnostic:
	PAXP195MB1231:EE_|AM8P195MB0819:EE_|MW2NAM12FT003:EE_|LV3PR08MB9070:EE_
X-MS-Office365-Filtering-Correlation-Id: d129042d-7b6e-4ab1-a9fb-08dc34986b14
X-SM-outgoing: yes
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original:
 n47bQoYwJOOtD/sPhnF+m6HVgjr0ihuUXh3QOYali63LePyxMai0OzI2/RCjZkdKF2/M46jwjmCSgQUIK6QBs0E12xLMVe1NdZxrMOPu0vA/58J3ERwoGnCf+ZfOzlCbCGpIhEzzA2bDhzlxuqMqlZvm77XKkG9+lhCU/hKV2gwRsZs547lpf2G2Fxk5q6EEusZSpUrfp9djwAUQpmZkwOdDPG2pROFkNS8eYzwf2cQ7U4stMvyRtzlCvmsMDr9DQ0PF9/BBnRw4YGNeWnYXAJa5JdZG1WgKLbhwmnhx0lsiFXveWBFRwHB0MYi1pgNxcY/m11cfKpxOwrhAm7uL3AmwL26cbPyI3q5LZGlJ9iOxmQS372csXEj+12i9mdQsOIEfkGjHORNSkeaXVxedT4U/Mkdq/wduQXh7V70sKVYyVOwvz0r1xfWz/5MqcI+sEbhCYoCNIybbGTFC1QZemxLSPeHBlcl8wxklLA7UowvvPyrt0lx3cWx3B+kg1LS7JmraHIWuFE+BJo6sY53ER2tx12MdoZZG4DZ2beO0ZuQZQawvIM43Wc1hsffyvf+c0BRJFdtE6lsx1d6k31Q7EDtC2f0r/jtQBKWUKBF0FriqTulw2zEpg8+ZNhG2iLVlBUkXNgDEsXCNNALmFvTjoQ==
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXP195MB1231.EURP195.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(230273577357003)(1590799021)(1580799018)(38070700009);DIR:OUT;SFP:1102;
Content-Type: text/plain; charset="utf-8"
Content-ID: <B835D2004966484E95DA5853AC2BC921@EURP195.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
 626rDmNNujHoowqNnzqWvjfJgfDWGuYgyJ7OXGR92R+qQ06vDlSXOEGzWqlIFyQCMByGcPfetxqTXK18qHGN6U9PlVTE6VSsmT4OJqplF6hWZwiw6rlYptKIGQE/ITnOb2U6QE5SjUHV4EQ2KSbzpOAYdCfaMjwbQZdcb9Bh7ZCycie5EedIeYNf0fjdVD4DCPi7fg825JJDkzpKKbwWMU8Ss/lU976Jl/NHiauG3InjhLW0rYkoQ++zgNk0xRahJl19y6GAZxH8sm8RWqY5Y91/iodwIDizVCVDQslBOvbMI8hw+NOXqQBCcoellnvp01ZHMr/fJUaMlb8NvQuWIAcUIV+k9xzZJP5U044cq0QFUVbG5xXaWYvM9O+SyN2XMknADvwxfm41n934c65U64q7cqZAs8Darb6p4pKweAMudsZAGhASfA19jvjyoHvosZMfMQuRxx4nh5Y0kK4G7G4sVc32iguTxpsSxLHSUF1vMvXK1PqINIXNEZ2wkhzLAyV1hLcqQMdwEn3q7XChgmlwk5hYvbh4Vjq5U5LV6wa6NcZPaqtG5cbu/3KROjrdwzUTkDsKrLagXZ61B839SZHxjZbqDEhu0z7ttpBmEVWixIfXR9jA87TFI4En+gMtfxo7j5IuW03jnYMqAsiRpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8P195MB0819
X-SM-smarthost: [elektrobit-com.mail.protection.outlook.com]
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 MW2NAM12FT003.eop-nam12.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	471bb51a-a0f4-423f-311c-08dc349868d3
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	f82TADqml3e9p3hRKTxTVsT6hf8vOxA0ua9CQ9byiVIgTeMNtX29ssQROGV9hXg/MZJBJU9HomQ3DLMbOjImJ7of2umVIR5UKEK98n0wsH0Fx61k+i0KazwhtlrHUmT0TBDOP/Tj9gQkc+MYjCt/O3APOudoP97jFVZfKAjh2HaWrHrOsffuHOvTL+vk8TlTcN7Lpj/faEBePe4W4wX7y3m+C++WpNHYrArPNCfBM0gqlmtUQ1d72wWWYzzAvW30cdtR4vvODFi5SkfnFMLbnVbCUKDbZe7R3l9XTDgjgyCUhLIyGZfUwvC/2iSmCEN+6fP5Pt0fFUe2zwttL1DAzugTDUFbIbzvtJJt2CoQ/PRFayyOUI17txxrgaXsf3JCServpi5K9JMpBcnjoxAmTIp3DkpiUme6Z5CR9cSI3Y46PeYSkMu/fzZ73sQ9j9ErTKjj77eUnxzkHsWyJGRC3ptCHCZYxeMRetdXFmAQSbFxbkoEn4PJlfEo5Kq2ahVpQ5MhM+YT1nm4/OdsS1yrlr90UIEZY6qjUdVUDb6K63YrxPIQj6uOAS78Fk+mZRiIxylKD4IG2wulDNmCawcl3a66Eo77pottSd/V4lCsqBtijTM0GH3g6HsXoKNsyOYmHNM3SBULCUF8lpIkcPjfKRQv7Fy5PhP+UWPA7HOelfCL0Nrn0gx2XJIMBKyGq77i
X-Forefront-Antispam-Report:
	CIP:4.79.107.243;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:usbth1es003.ebgroup.elektrobit.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(230273577357003)(1590799021)(36860700004)(40470700004)(46966006)(1580799018);DIR:OUT;SFP:1102;
X-OriginatorOrg: elektrobit.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2024 17:54:01.5332
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d129042d-7b6e-4ab1-a9fb-08dc34986b14
X-MS-Exchange-CrossTenant-Id: e764c36b-012e-4216-910d-8fd16283182d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e764c36b-012e-4216-910d-8fd16283182d;Ip=[4.79.107.243];Helo=[usbth1es003.ebgroup.elektrobit.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MW2NAM12FT003.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR08MB9070

T24gVHVlLCAyMDI0LTAyLTIwIGF0IDE5OjUyICswMTAwLCBNaWt1bGFzIFBhdG9ja2Egd3JvdGU6
DQo+IENBVVRJT046IFRoaXMgZW1haWwgb3JpZ2luYXRlZCBmcm9tIG91dHNpZGUgb2YgdGhlIEVs
ZWt0cm9iaXQgb3JnYW5pemF0aW9uLiBEbw0KPiBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRh
Y2htZW50cyB1bmxlc3MgeW91IHJlY29nbml6ZSB0aGUgc2VuZGVyIGFuZCBrbm93DQo+IHRoZSBj
b250ZW50IGlzIHNhZmUuDQo+IA0KPiANCj4gT24gRnJpLCA5IEZlYiAyMDI0LCBTaW1vbmUgV2Vp
w58gd3JvdGU6DQo+IA0KPiA+IEV4dGVuZCB0aGUgZG0taW50ZWdyaXR5IGRyaXZlciB0byBvbWl0
IHdyaXRpbmcgdW51c2VkIGpvdXJuYWwgZGF0YSBzZWN0b3JzLg0KPiA+IEluc3RlYWQgb2YgZmls
bGluZyB1cCB0aGUgd2hvbGUgam91cm5hbCBzZWN0aW9uLCBtYXJrIHRoZSBsYXN0IHVzZWQNCj4g
PiBzZWN0b3Igd2l0aCBhIHNwZWNpYWwgY29tbWl0IElELiBUaGUgY29tbWl0IElEIHN0aWxsIHVz
ZXMgdGhlIHNhbWUgYmFzZQ0KPiA+IHZhbHVlLA0KPiA+IGJ1dCBzZWN0aW9uIG51bWJlciBhbmQg
c2VjdG9yIG51bWJlciBhcmUgaW52ZXJ0ZWQuIEF0IHJlcGxheSB3aGVuIGNvbW1pdCBJRHMNCj4g
PiBhcmUgYW5hbHl6ZWQgdGhpcyBzcGVjaWFsIGNvbW1pdCBJRCBpcyBkZXRlY3RlZCBhcyBlbmQg
b2YgdmFsaWQgZGF0YSBmb3INCj4gPiB0aGlzDQo+ID4gc2VjdGlvbi4gVGhlIG1haW4gZ29hbCBp
cyB0byBwcm9sb25nIHRoZSBsaXZlIHRpbWVzIG9mIGUuZy4gZU1NQ3MgYnkNCj4gPiBhdm9pZGlu
Zw0KPiA+IHRvIHdyaXRlIHRoZSB3aG9sZSBqb3VybmFsIGRhdGEgc2VjdG9ycy4NCj4gPiANCj4g
PiBUaGUgY2hhbmdlIGlzIHJpZ2h0IG5vdyB0byBiZSBzZWVuIGFzIGV4cGVyaW1lbnRhbCBhbmQg
Z2V0cyBhcHBsaWVkIGlmDQo+ID4gQ09ORklHX0RNSU5UX0xBWllfQ09NTUlUIGlzIHNldCB0byB5
LiBOb3RlIHBsZWFzZSB0aGF0IHRoaXMgaXMgTk9UDQo+ID4gcGxhbm5lZCBmb3IgYSBmaW5hbCB2
ZXJzaW9uIG9mIHRoZSBjaGFuZ2VzLiBJIHdvdWxkIG1ha2UgaXQgY29uZmlndXJhYmxlDQo+ID4g
dmlhIGZsYWdzIHBhc3NlZCBlLmcuIHZpYSBkbXNldHVwIGFuZCBzdG9yZWQgaW4gdGhlIHN1cGVy
YmxvY2suDQo+ID4gDQo+ID4gQXJjaGl0ZWN0dXJhbCBMaW1pdGF0aW9uczoNCj4gPiAtIEEgZG0t
aW50ZWdyaXR5IHBhcnRpdGlvbiwgdGhhdCB3YXMgcHJldmlvdXNseSB1c2VkIHdpdGggbGF6eSBj
b21taXQsDQo+ID4gwqBjYW4ndCBiZSByZXBsYXllZCB3aXRoIGEgZG0taW50ZWdyaXR5IGRyaXZl
ciBub3QgdXNpbmcgbGF6eSBjb21taXQuDQo+ID4gLSBBIGRtLWludGVncml0eSBkcml2ZXIgdGhh
dCB1c2VzIGxhenkgY29tbWl0IGlzIGV4cGVjdGVkDQo+ID4gwqB0byBiZSBhYmxlIHRvIGNvcGUg
d2l0aCBhIHBhcnRpdGlvbiB0aGF0IHdhcyBjcmVhdGVkIGFuZCB1c2VkIHdpdGhvdXQNCj4gPiDC
oGxhenkgY29tbWl0Lg0KPiA+IC0gV2l0aCBkbS1pbnRlZ3JpdHkgbGF6eSBjb21taXQsIGEgcGFy
dGlhbGx5IHdyaXR0ZW4gam91cm5hbCAoZS5nLiBkdWUgdG8gYQ0KPiA+IMKgcG93ZXIgY3V0KSBj
YW4gY2F1c2UgYSB0YWcgbWlzbWF0Y2ggZHVyaW5nIHJlcGxheSBpZiB0aGUgam91cm5hbCBlbnRy
eQ0KPiA+IG1hcmtpbmcNCj4gPiDCoHRoZSBlbmQgb2YgdGhlIGpvdXJuYWwgc2VjdGlvbiBpcyBt
aXNzaW5nLiBEdWUgdG8gbGF6eSBjb21taXQsIG9sZGVyDQo+ID4gam91cm5hbA0KPiA+IMKgZW50
cmllcyBhcmUgbm90IGVyYXNlZCBhbmQgbWlnaHQgYmUgcHJvY2Vzc2VkIGlmIHRoZXkgaGF2ZSB0
aGUgc2FtZSBjb21taXQNCj4gPiBJRA0KPiA+IMKgYXMgYWRqYWNlbnQgbmV3ZXIgam91cm5hbCBl
bnRyaWVzLg0KPiANCj4gSGkNCj4gDQo+IEkgd2FzIHRoaW5raW5nIGFib3V0IGl0IGFuZCBJIHRo
aW5rIHRoYXQgdGhpcyBwcm9ibGVtIGlzIGEgc2hvd3N0b3BwZXIuDQo+IA0KPiBTdXBwb3NlIHRo
YXQgYSBqb3VybmFsIHNlY3Rpb24gY29udGFpbnMgdGhlc2UgY29tbWl0IElEczoNCj4gDQo+IMKg
wqDCoMKgwqDCoMKgIDLCoMKgwqDCoMKgwqAgMsKgwqDCoMKgwqDCoCAywqDCoMKgwqDCoMKgIDIo
RU9GKcKgIDPCoMKgwqDCoMKgwqAgM8KgwqDCoMKgwqDCoCAzwqDCoMKgwqDCoMKgIDMNCj4gDQo+
IFRoZSBJRHMgIjMiIGFyZSBsZWZ0IG92ZXIgZnJvbSBwcmV2aW91cyBpdGVyYXRpb25zLiBUaGUg
SURzICIyIiBjb250YWluDQo+IHRoZSBjdXJyZW50IGRhdGEuIEFuZCBub3csIHRoZSBqb3VybmFs
IHJvbGxzIG92ZXIgYW5kIHdlIGF0dGVtcHQgdG8gd3JpdGUNCj4gYWxsIDggcGFnZXMgd2l0aCB0
aGUgSUQgIjMiLiBIb3dldmVyLCBhIHBvd2VyIGZhaWx1cmUgaGFwcGVucyBhbmQgd2Ugb25seQ0K
PiB3cml0ZSA0IHBhZ2VzIHdpdGggdGhlIElEICIzIi4gU28sIHRoZSBqb3VybmFsIHdpbGwgbG9v
ayBsaWtlOg0KPiANCj4gwqDCoMKgwqDCoMKgwqAgMyhuZXcpwqAgMyhuZXcpwqAgMyhuZXcpwqAg
MyhuZXcpwqAgMyhvbGQpwqAgMyhvbGQpwqAgMyhvbGQpwqAgMyhvbGQpDQo+IA0KPiBBZnRlciBh
IHJlYm9vdCwgdGhlIGpvdXJuYWwtcmVwbGF5IGxvZ2ljIHdpbGwgZmFsc2VseSBiZWxpZXZlIHRo
YXQgdGhlDQo+IHdob2xlIGpvdXJuYWwgc2VjdGlvbiBpcyBjb25zaXN0ZW50IGFuZCBpdCB3aWxs
IGF0dGVtcHQgdG8gcmVwbGF5IGl0Lg0KPiANCj4gVGhpcyBjb3VsZCBiZSBmaXhlZCBieSBoYXZp
bmcgYWx3YXlzIGluY3JlYXNpbmcgY29tbWl0IElEcyAtIHRoZSBjb21taXQNCj4gSURzIGhhdmUg
OCBieXRlcywgc28gd2UgY2FuIGFzc3VtZSB0aGF0IHRoZXkgbmV2ZXIgcm9sbC1vdmVyIGFuZCBp
dCB3b3VsZA0KPiBwcmV2ZW50IHVzIGZyb20gbWl4aW5nIG9sZCBJRHMgaW50byB0aGUgY3VycmVu
dCB0cmFuc2FjdGlvbi4NCkhpDQoNClRoYW5rcyBmb3IgdGhlIHJldmlldyBvZiB0aGUgY29uY2Vw
dC4gSSB3YXMgb3V0IHRoaXMgd2VlayBhbmQgY291bGQgb25seSB0aGluaw0KYWJvdXQgaXQgbm93
LiBJIHVuZGVyc3Rvb2QgaXQgcmlnaHQsIHRoYXQgdGhlIHByb3Bvc2FsIGlzIHRvIGFkZCBhbiBl
eHRyYSB2YWx1ZQ0KdG8gdGhlIGNvbW1pdCBJRCwgdGhhdCBpcyBlLmcuIGluY3JlbWVudGVkIHdo
ZW4gaW50ZWdyaXR5X2NvbW1pdCBpcyBleGVjdXRlZD8NCg0KSWYgc28sIEkgdHJpZWQgdGhpcyBx
dWlja2x5IGFuZCBsb29rcyBnb29kIG9uIGZpcnN0IGdsYW5jZS4gV2lsbCBjaGVjayBhbmQgdGVz
dA0KZnVydGhlciBuZXh0Lg0KDQpTaW1vbmUNCj4gDQo+IE1pa3VsYXMNCj4gDQo+ID4gwqBJZiBk
bS1pbnRlZ3JpdHkgZGV0ZWN0cyBiYWQgc2VjdGlvbnMgd2hpbGUNCj4gPiDCoHJlcGxheWluZyB0
aGUgam91cm5hbCwga2VlcCB0cmFjayBhYm91dCB0aG9zZSBzZWN0aW9ucyBhbmQgdHJ5IHRvIGF0
IGxlYXN0DQo+ID4gwqByZXBsYXkgb2xkZXIsIGdvb2Qgc2VjdGlvbnMuDQo+ID4gwqBUaGlzIGlz
IGJhc2VkIG9uIHRoZSBhc3N1bXB0aW9uIHRoYXQgbW9zdCBsaWtlbHkgdGhlIG5ld2VzdA0KPiA+
IMKgc2VjdGlvbihzKSB3aWxsIGJlIGRhbWFnZWQsIHdoaWNoIG1pZ2h0IGhhdmUgYmVlbiBvbmx5
IHBhcnRpYWxseSB3cml0dGVuDQo+ID4gwqBkdWUgdG8gYSBzdWRkZW4gcmVzZXQuIFByZXZpb3Vz
bHksIHRoZSB3aG9sZSBqb3VybmFsIHdvdWxkIGJlIGNsZWFyZWQgaW4NCj4gPiDCoHN1Y2ggYSBj
YXNlLg0KPiA+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IFNpbW9uZSBXZWnDnyA8c2ltb25lLndlaXNz
QGVsZWt0cm9iaXQuY29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEthaSBUb21lcml1cyA8a2FpLnRv
bWVyaXVzQGVsZWt0cm9iaXQuY29tPg0KDQo=

