Return-Path: <linux-kernel+bounces-54993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A0ED84B5FD
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 14:09:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E0331C2116D
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 13:09:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 290F3130AD4;
	Tue,  6 Feb 2024 13:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="aeYiAdO1";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="aeYiAdO1"
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2053.outbound.protection.outlook.com [40.107.15.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 790EB130AC9
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 13:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.15.53
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707224975; cv=fail; b=E3X3q4ij/1ShXEFPoaONc67NRvVT8+Gc/kiZr8iHTCyAjAZCnZmlw3YrNxc40xOr1feBWngxogH2xoPPGF1MKGRUKC4SjBXMZp3e8gWF4ZeAUGbtHSLgvExMf10EcP7lBey9kOJWZDix9tNQPN2LTNR4Lay2+2EjBTnfX8tvCWQ=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707224975; c=relaxed/simple;
	bh=Z23la128vsvnyfe1YRqIF1v7pFtGqNunegW3uhIcbKs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=I6P3suC0VTXOE4E+yt3wtV+f6Nm1PBOXLPv543Isn/BW+zWJxxvKzUbutOGIxZkVDqlTAJa5TigYbmIhy9ccEqED1ib/YMqJSKlvJ1FKK0sGt96vVdubnEhqqwm6BiRaMoAvmZsE/nKD4ayuVfMwJggynQ3TSauF8AAGAor9yss=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b=aeYiAdO1; dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b=aeYiAdO1; arc=fail smtp.client-ip=40.107.15.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=KojsQJO5AUYcT2KXGbvF2Uj61NKsTaeWLZ4dm89ueZyK/4orR9ikW1xVzsSZ4toQb9r1uiRZIdURaljq+rMiO1MhL+Hy9AgK7Dtwmp6hJsaXZC4xfpZKytBqHKIJgiY7tb59aDR3JMWgjznFGZMzLkgjyyGMckn8XdjwcaN/CxPbCKPGiSC0B+z1dwJ+zj09y+AnVQMzF+LiJtOBjsxYWIQE4zVMdAN8r+B3pP5qCcIzeyeOrji48ekgrB8xoWbei2bVFd6fEJSuc/BTy4c2EAeddGthOYe5YZM7o6sP75gGenbq7vKNYvjrR1NqBHfS8J1v13MsM4wQQAkOY5ipeQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Iw1hNmK0xuZ/wmrpugMw5nuhquiIiShkyO+U2/3urS0=;
 b=n9ZNPJv9NT3xS6q8FxnkCSc60roYpNbTjF4ddl0r45b6cRVaEVh+Dki3+z3Yx8oQtLe0jHQWc9aJmmsRrMaJfPP4ZiMdPwoIhPIzjQmF/uDUYHqdIxgiM0PSkltUjwYqIcF19jdV4Pe592NFFJgswnBzwefgNEoquGABbxb6JvRwi+Fr1KpvspVCVdnc7OEQ+LYrINgV93lUpygO4+IgBYXx9fKS6S6WxktuWSlAqK6lXJVTdsOsFQiPAxafP3pD8X/sHFY79yzah2+kpsGyvQgC5d+/v1CIb2gGf7SVHI5KPnjzeZFsyEz0MmCxpgQB5+kLG1JyKl0I7Ha+bVSZ5Q==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=armh.onmicrosoft.com; arc=pass (0
 oda=1 ltdi=1 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Iw1hNmK0xuZ/wmrpugMw5nuhquiIiShkyO+U2/3urS0=;
 b=aeYiAdO1ao8ixEjTy4flFFMsGYNDT1q5GlJKU/JoXAd1QHkicf4es1tZIkyoNrJHt+/qHMX7/jmTjcpzA6yyT0HnMwXTvywNxuSkQr+EjRK67+Ep3OnJg0KLO4JZzJJpKPY+5O9Yd7hCm295r1UDp89UYoCgLLwlVb/yG6MXZiQ=
Received: from DUZPR01CA0240.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b5::8) by DB9PR08MB9851.eurprd08.prod.outlook.com
 (2603:10a6:10:460::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36; Tue, 6 Feb
 2024 13:09:25 +0000
Received: from DB1PEPF000509E9.eurprd03.prod.outlook.com
 (2603:10a6:10:4b5:cafe::d2) by DUZPR01CA0240.outlook.office365.com
 (2603:10a6:10:4b5::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36 via Frontend
 Transport; Tue, 6 Feb 2024 13:09:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB1PEPF000509E9.mail.protection.outlook.com (10.167.242.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7249.19 via Frontend Transport; Tue, 6 Feb 2024 13:09:25 +0000
Received: ("Tessian outbound 94d82ba85b1d:v228"); Tue, 06 Feb 2024 13:09:24 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 1cef959518ac8089
X-CR-MTA-TID: 64aa7808
Received: from 9c7e89d9f63b.2
	by 64aa7808-outbound-1.mta.getcheckrecipient.com id 0FEE65ED-BFD2-44F1-BF77-6B69A9771709.1;
	Tue, 06 Feb 2024 13:09:14 +0000
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 9c7e89d9f63b.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Tue, 06 Feb 2024 13:09:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lRo4CP4t7yPm4sTq4DmFQSA+UD9EgiHYJ8j56xW5VeVMStVRuWYpl73z4Pvt1SZLCp2xti31hsP4yBpVWUcq3SgDXY3hbSm0fWPGmP4K1YuFOdarN2WWo4e6eOaPWgsZP/8KZTpYY85rqZWi2K6GdmL69f8HDzi0b4yRTgBHBSqwr4XBJgX8EdHiR8KS14Hgkspvl5ux4cHttZjFAkK4kxYlnID5RwZFV8oXQNHwMWqBSgjd0VeZ4MIr7eI/rD1CSnmeQynpHvT2EJYggKbHAWrSnMH4c8YclVendDdrA+RKVGgr6TjPqC3gsVl9q37czNT3MW7mTOy4Db3w6QqwaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Iw1hNmK0xuZ/wmrpugMw5nuhquiIiShkyO+U2/3urS0=;
 b=OZlhy1FwcDiOv+j1eDDiRCRSBaVu4xsjPsw6uRwfmDqLBqPCFQcsEY/Q3QMg99+TTXGsmDWToEzFuZotSE57Uj2Y+AnmMoWMR/O2nICv2nvdCN6PGFdrXgGSr5cPnVFmn+LDNOqLYeAR6zgo2/j4lE+42fzhXBBuKL7ybR0SRYhN3WKwmvdVW+eSRGMDtfieA/TIKUqAlbHjKKM5egcKzrl6zVH7XlHKhtVkaCZZHQWl2g5LQPlsNvKMfW29XpGv7Mfg8doyMEbh1ESr3RNsdXlh0YnrmnrxBnCdB1g9UVRmgJzT9NQt8W/lf4xUIUi2Mjc25VOSA0EPwOBtnMw3ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Iw1hNmK0xuZ/wmrpugMw5nuhquiIiShkyO+U2/3urS0=;
 b=aeYiAdO1ao8ixEjTy4flFFMsGYNDT1q5GlJKU/JoXAd1QHkicf4es1tZIkyoNrJHt+/qHMX7/jmTjcpzA6yyT0HnMwXTvywNxuSkQr+EjRK67+Ep3OnJg0KLO4JZzJJpKPY+5O9Yd7hCm295r1UDp89UYoCgLLwlVb/yG6MXZiQ=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from VI1PR08MB3919.eurprd08.prod.outlook.com (2603:10a6:803:c4::31)
 by AS2PR08MB10034.eurprd08.prod.outlook.com (2603:10a6:20b:64b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36; Tue, 6 Feb
 2024 13:09:09 +0000
Received: from VI1PR08MB3919.eurprd08.prod.outlook.com
 ([fe80::935e:b3a1:b0fd:99ac]) by VI1PR08MB3919.eurprd08.prod.outlook.com
 ([fe80::935e:b3a1:b0fd:99ac%4]) with mapi id 15.20.7249.032; Tue, 6 Feb 2024
 13:09:09 +0000
Message-ID: <d0ab28dd-95e0-446c-9e21-a45680114e5b@arm.com>
Date: Tue, 6 Feb 2024 13:09:06 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] sched/eevdf: Use tunable knob sysctl_sched_base_slice
 as explicit time quanta
Content-Language: en-US
To: Ze Gao <zegao2021@gmail.com>, Peter Zijlstra <peterz@infradead.org>
Cc: Ben Segall <bsegall@google.com>,
 Daniel Bristot de Oliveira <bristot@redhat.com>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>, Ingo Molnar <mingo@redhat.com>,
 Juri Lelli <juri.lelli@redhat.com>, Mel Gorman <mgorman@suse.de>,
 Steven Rostedt <rostedt@goodmis.org>,
 Valentin Schneider <vschneid@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>, linux-kernel@vger.kernel.org,
 Ze Gao <zegao@tencent.com>
References: <20240111115745.62813-2-zegao@tencent.com>
From: Luis Machado <luis.machado@arm.com>
In-Reply-To: <20240111115745.62813-2-zegao@tencent.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: LO4P265CA0215.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:33a::15) To VI1PR08MB3919.eurprd08.prod.outlook.com
 (2603:10a6:803:c4::31)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	VI1PR08MB3919:EE_|AS2PR08MB10034:EE_|DB1PEPF000509E9:EE_|DB9PR08MB9851:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a59d5ab-6d2b-4cdc-9b76-08dc2714d7b0
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original:
 4WSxmtqdMkv53Of6B+o0A+JR3G0OknfpgUuIMOdssnIWfeh0Jp0E18/tdBsBoVNmuxeSwT9p675+wk/PrB3+9oAtG7mm+XaWtzF0gzt20rw/hmQqSlq+lf0gnW9yUTBAqhcflfC+ojkSHsIcsGcUSZPkPg0unVQs2fBAjwT8aYecybAXCWDd0FnJMlPgmUul9BS+e7LI/dZ2mR/iXkgqd/pcER4crKlZKQxbRYH9xfzA6Vwu1yG9lcbKXBi7pwhM0y1aAMe0oV/mPPGnGWoO/oJnPw2R7OOQ322Lg7XFp3/rCPuOMaaWoY0Lz97a0pSVhTsI2Epr2Hhvf0q5F5hjb0bAzYfNS2dsN2CfJtIfuUAl+D7Ybd4qxp8bkv31+unCugFGRBJrf7WOg6q3a9cnbDvFg8SZVb3g+ikYBa7BFD2/8XbLCywukJ+/UO9o2TxNOKmEzNf0+h0zRttrN7dwzTYFOyrG7rdH53s73IHyS0YZnCbX06gsirg+hgrLPozu9GKXc0WL8c4Om+buzai00A8VsNklvKYAmniUVtnFGISjTnfXGCVAcpbCiiyIFc9gmi9yTnxdAY1RH1O9aG7tg3Y0hO1/cAgVz4Zflq4G4UqyFpvExDjvNb7bLwPUE8SANlpOC5IwdtIlKCzkaLt/pg==
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR08MB3919.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(346002)(376002)(366004)(39860400002)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(41300700001)(2616005)(26005)(31696002)(86362001)(6512007)(7416002)(6486002)(5660300002)(478600001)(2906002)(110136005)(54906003)(66556008)(66946007)(44832011)(66476007)(8936002)(4326008)(8676002)(36756003)(6666004)(6506007)(53546011)(38100700002)(31686004)(316002)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB10034
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB1PEPF000509E9.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	6a4cd279-da92-4727-a2cf-08dc2714ce3c
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	QOaQpX5ZrRPVvXXnjcKRhYD5Wgu5MKKmbdIslKCKRx7JT2XUc6Hi9yau9qPgAIhqfzPQ3VYHl2LP5BiPLGflmVVL6vYXvkdFb0wKUket84nI7aJmxFsNgYphSygJIe4fIwXeejFTZbigY2BcYg/i+48ZsgcAq/78OvrDZyrA/CyA9yl21i6prjD4PQh2LaosOrEbm2Bx33PlmhumbiTO66vlXy7aILLwbUhYf7h38CpRRgf8vEynji0bQTqTBhhegDRJb+xkWDobMKl2k7ywgvDPAfH6yYhhfE/PTZJywBuIe9vz0241VUh8kM4EcgsZtlEcyAe6d6H3vOeU5NQJehqSKUj07x/454/xq5DeIVnsabcj0BhOQNbl6/2hZcHq4S3UfCY8EnTbth2uODCZZ5H88vKN4rapME77blGGDfi/U1TIvbcfKdfTIpvZzKwuLOryHBArs5ZOmSXdP8AAQ4YZVgh9q28HrqQnfnjGUcmCGPV58ef2Xdf6MSq4qdaPFJQ8/HNEmdrjfOvZ9woPdfTOvhLnaCQ93eofpIy70xXcjpC8KG97xkb7SHDccp+Ey42gzck76HCkdeGulDUcJO7G/q2QdwmsOREDSJO4Xv/MAeXuT4QewEekourTFsUo222b/ty4NMKfYHntzctNbh0DyzdWcNCbjIE8sU6CFLt/IqiiuTWeIoucjiHkEHe806f59zsuFbnUE2VhsMql0lFkgAss8aTBcitOMyrTXpwnKUgpkudu/g7bok99FvuzdL6rYAkN5czpzEyU+d5DGg==
X-Forefront-Antispam-Report:
	CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(346002)(136003)(396003)(376002)(230922051799003)(186009)(82310400011)(64100799003)(451199024)(1800799012)(36840700001)(46966006)(40470700004)(40480700001)(31686004)(356005)(40460700003)(47076005)(36860700001)(81166007)(82740400003)(44832011)(83380400001)(26005)(2616005)(6486002)(336012)(107886003)(86362001)(31696002)(6506007)(6666004)(478600001)(6512007)(53546011)(36756003)(70586007)(70206006)(316002)(41300700001)(54906003)(110136005)(8676002)(4326008)(2906002)(8936002)(5660300002)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2024 13:09:25.1272
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a59d5ab-6d2b-4cdc-9b76-08dc2714d7b0
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509E9.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB9851

Hi,

On 1/11/24 11:57, Ze Gao wrote:
> AFAIS, We've overlooked what role of the concept of time quanta plays
> in EEVDF. According to Theorem 1 in [1], we have
>
>       -r_max < log_k(t) < max(r_max, q)
>
> cleary we don't want either r_max (the maximum user request) or q (time
> quanta) to be too much big.
>
> To trade for throughput, in [2] it chooses to do tick preemtion at
> per request boundary (i.e., once a cetain request is fulfilled), which
> means we literally have no concept of time quanta defined anymore.
> Obviously this is no problem if we make
>
>       q =3D r_i =3D sysctl_sched_base_slice
>
> just as exactly what we have for now, which actually creates a implict
> quanta for us and works well.
>
> However, with custom slice being possible, the lag bound is subject
> only to the distribution of users requested slices given the fact no
> time quantum is available now and we would pay the cost of losing
> many scheduling opportunities to maintain fairness and responsiveness
> due to [2]. What's worse, we may suffer unexpected unfairness and
> lantecy.
>
> For example, take two cpu bound processes with the same weight and bind
> them to the same cpu, and let process A request for 100ms whereas B
> request for 0.1ms each time (with HZ=3D1000, sysctl_sched_base_slice=3D3m=
s,
> nr_cpu=3D42).  And we can clearly see that playing with custom slice can
> actually incur unfair cpu bandwidth allocation (10706 whose request
> length is 0.1ms gets more cpu time as well as better latency compared to
> 10705. Note you might see the other way around in different machines but
> the allocation inaccuracy retains, and even top can show you the
> noticeble difference in terms of cpu util by per second reporting), which
> is obviously not what we want because that would mess up the nice system
> and fairness would not hold.
>
>                       stress-ng-cpu:10705     stress-ng-cpu:10706
> ---------------------------------------------------------------------
> Slices(ms)            100                     0.1
> Runtime(ms)           4934.206                5025.048
> Switches              58                      67
> Average delay(ms)     87.074                  73.863
> Maximum delay(ms)     101.998                 101.010
>
> In contrast, using sysctl_sched_base_slice as the size of a 'quantum'
> in this patch gives us a better control of the allocation accuracy and
> the avg latency:
>
>                       stress-ng-cpu:10584     stress-ng-cpu:10583
> ---------------------------------------------------------------------
> Slices(ms)            100                     0.1
> Runtime(ms)           4980.309                4981.356
> Switches              1253                    1254
> Average delay(ms)     3.990                   3.990
> Maximum delay(ms)     5.001                   4.014
>
> Furthmore, with sysctl_sched_base_slice =3D 10ms, we might benefit from
> less switches at the cost of worse delay:
>
>                       stress-ng-cpu:11208     stress-ng-cpu:11207
> ---------------------------------------------------------------------
> Slices(ms)            100                     0.1
> Runtime(ms)           4983.722                4977.035
> Switches              456                     456
> Average delay(ms)     10.963                  10.939
> Maximum delay(ms)     19.002                  21.001

Thanks for the write-up, those are interesting results.

While the fairness is restablished (important, no doubt), I'm wondering if =
the much larger number of switches is of any concern.

I'm planning on giving this patch a try as well.
IMPORTANT NOTICE: The contents of this email and any attachments are confid=
ential and may also be privileged. If you are not the intended recipient, p=
lease notify the sender immediately and do not disclose the contents to any=
 other person, use it for any purpose, or store or copy the information in =
any medium. Thank you.

