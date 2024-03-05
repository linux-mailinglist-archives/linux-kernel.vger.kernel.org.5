Return-Path: <linux-kernel+bounces-92854-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 70A838726F9
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 19:53:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F141E1F22735
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 18:53:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECBE4286A2;
	Tue,  5 Mar 2024 18:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="RVeIg5n8";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="RVeIg5n8"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2072.outbound.protection.outlook.com [40.107.22.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5A1B241E0;
	Tue,  5 Mar 2024 18:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.72
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709664792; cv=fail; b=WKxS4E6TJp66GGZa3NspmsOvY9oRkysQHk8T8qNvWVf9waMt1kD+o/PimnrVRB+fNKuF1UMD1fimKmiD4DAFZjrOGVsL8sD11x+v8Wm+BuClV2KcNPUypBWPmcowg3uQZJHonlR3ujienEB7F65oYUNKOwA9aJiQaWkuwxJ48AI=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709664792; c=relaxed/simple;
	bh=+HwUjBm+EfHZL5cejEnKyhtQUO21HE/7F8RTSKoJ3Xg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HPhTqO2EVyPHiuF/gxlP/G0EWa36nbCX0yCqTPcknR1ZZzLV5qvjbx/+V0ubeca6/zFY/u8gFgHybaQ2YLZRWyFGPeH0RdLjPUl99wTiR1rSEh2/Jf0mGI4qvBaEmWFfDo3RHuiOmQqWMUISS++V1ekQZN3u+HzEnFSEoOHmXG8=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b=RVeIg5n8; dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b=RVeIg5n8; arc=fail smtp.client-ip=40.107.22.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=lqPbCXnYqciv6cWI5AOHhV2hQfWBjoyVLD+aD8wPtoUWjfGPYYmnn9hVWFHNm2pasuvZn3kVDEw56iMJoNqqy7Z/7Dfa9aRlPog1dRPnqmpzYSYtBlyoejfErOhmSbFl2f+dYYEigXAbGAFhT++dz1k1z99ubK7hzMiCgkuUN9XgaWNG945UnoJFs842NtB+3UC2ff0C7D/eugmwaUK8N+/t9xGuYEnb1/j3pslaxhcUzeKpS/HcTTCajhRCLM6gZtUC+Vk3vbZZtShpGEBfg19nDbsfe4Y6ZqQXc8rigtMcrDM5s3uXDaas1Eaah/QPJyVVj7GKCDHHCYIrnAEYVA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X8dWCFqb2nh6J1gtJOMw9Qw7oT3RtD8A/utWlghCdOo=;
 b=O/wIEh9bUrd+JucSHnev/jA/z7OrHRevHn9NfBfH54ZO6nIeCx/IdMvgC4mH1FHpYJwNGK70DsosrSP8E44jPfanw6WsigUpW3S8Uq5s8DXipHjkwQzRgB1NM0/jrqFt9b9C0ZpAzeAk8m8/q4NbXqvh/CTmyj+lpU74ho468KinPsYXIMdU73sVDPAeeoRxv/UOpR/49Gyvqso1Gf+619Zxe2XHF77e4Ma+WBcpiC+xVcaTXDxElOCFJkcuOxUqYb/A3x3NkqYSqh5rBbi7wnjydu33CQ8/X/o1LUupsv0iqhwX5pR10hj1UoFrVxLfd63L9b1Pdu3kQHk4OfPNlw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=armh.onmicrosoft.com; arc=pass (0
 oda=1 ltdi=1 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X8dWCFqb2nh6J1gtJOMw9Qw7oT3RtD8A/utWlghCdOo=;
 b=RVeIg5n8K5dgJT5dJMFpp+nK1AqxB5LN9V++9MdfejPcd0bRS8pWszsC0GEFg+zPubJWWnj1r9J811NPEM4nVIyEu3/uc1U5CALXUxhAS1fh71yl2xG/0qy/P7XyUl5o+Zm84IsjYI7QMMnV5NlL9gXZXtbiV1VkYfT3Jl3ka8M=
Received: from DUZPR01CA0026.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:46b::20) by AM8PR08MB5859.eurprd08.prod.outlook.com
 (2603:10a6:20b:1c6::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.39; Tue, 5 Mar
 2024 18:53:05 +0000
Received: from DB5PEPF00014B8F.eurprd02.prod.outlook.com
 (2603:10a6:10:46b:cafe::4f) by DUZPR01CA0026.outlook.office365.com
 (2603:10a6:10:46b::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.39 via Frontend
 Transport; Tue, 5 Mar 2024 18:53:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5PEPF00014B8F.mail.protection.outlook.com (10.167.8.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7362.11 via Frontend Transport; Tue, 5 Mar 2024 18:53:05 +0000
Received: ("Tessian outbound ca5b6496b02a:v276"); Tue, 05 Mar 2024 18:53:04 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: a9ee1455c0a9a3cd
X-CR-MTA-TID: 64aa7808
Received: from 330e4fe5f4ce.2
	by 64aa7808-outbound-1.mta.getcheckrecipient.com id 7DD82386-A1E6-45D8-9CDC-C42184BC8643.1;
	Tue, 05 Mar 2024 18:52:58 +0000
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 330e4fe5f4ce.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Tue, 05 Mar 2024 18:52:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CkqqCOjTtfXe61AHSp/6s3LjyQB8+ma6JhSpACJHXDo0oxWYDQlSS+Q+RgR+UBQyoQhLE8J/vmLpkqmU1/hEaiThA0oU+m2ThvZWnxZXGasvaqXQ2D3T7/f2LEVkYny2qPQApAEQWwWvhZm47Hn9w42P3p22AU5G8kVQRWaCPCxuKzz2pyN4Cuo9CvdGUDj4xckqSAtwrLxv7Tr+IG9dQ209yG7jQ4q46iyawosjEzn+6eQ5PGnSS2e8MqwOgYZQgrXZ3/TSYMDbtIJk1siuQCxZE2sq6jzwxdHB3wSJDUkXmFRb5hEIDJGo1R6xCoDl8Kn4dle4r6j1KP3bAYEZnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X8dWCFqb2nh6J1gtJOMw9Qw7oT3RtD8A/utWlghCdOo=;
 b=n7vNBMdfNiUCHen0aa7D+xCjJZKU/jA2eCb3TpUmjv5z0G6Zr6KzMTwFIugn+gFpoweJf/NZ69kyQ9h379CSeagyfyaS9KSR8RpdNGb21GNWTICsBJGIdUZXORdRHA04j8J7OxP3lFOifS2+rYQ2JwmPJV1r/nk1RIu+v8Cgg1l9zrFR9rCwLjWyG3vp36YM6E9um8YYMTMqgIJNZcp2zuu/3Vun5CVxK/CRF4v3vsz9iZPsiVeWY55z2FmVCa2zwGOu61WL31iIKLbJsCh2Bdbfzacd79XcotnCyGBv2xGApnat0f6oXKaKgNELqujsQuzP0conZHM+13DCZqwJHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X8dWCFqb2nh6J1gtJOMw9Qw7oT3RtD8A/utWlghCdOo=;
 b=RVeIg5n8K5dgJT5dJMFpp+nK1AqxB5LN9V++9MdfejPcd0bRS8pWszsC0GEFg+zPubJWWnj1r9J811NPEM4nVIyEu3/uc1U5CALXUxhAS1fh71yl2xG/0qy/P7XyUl5o+Zm84IsjYI7QMMnV5NlL9gXZXtbiV1VkYfT3Jl3ka8M=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM0PR08MB4289.eurprd08.prod.outlook.com (2603:10a6:208:148::12)
 by VI1PR08MB5519.eurprd08.prod.outlook.com (2603:10a6:803:133::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.39; Tue, 5 Mar
 2024 18:52:55 +0000
Received: from AM0PR08MB4289.eurprd08.prod.outlook.com
 ([fe80::4a5d:48:bf49:a524]) by AM0PR08MB4289.eurprd08.prod.outlook.com
 ([fe80::4a5d:48:bf49:a524%6]) with mapi id 15.20.7339.035; Tue, 5 Mar 2024
 18:52:55 +0000
Message-ID: <4a6bf7f4-afa2-4c7f-b923-d67d48f41954@arm.com>
Date: Tue, 5 Mar 2024 18:52:54 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64/mm: Add memory barrier for mm_cid
To: Will Deacon <will@kernel.org>
Cc: catalin.marinas@arm.com, mark.rutland@arm.com, peterz@infradead.org,
 mathieu.desnoyers@efficios.com, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, nd@arm.com, stable@vger.kernel.org,
 Aaron Lu <aaron.lu@intel.com>
References: <20240305145335.2696125-1-yeoreum.yun@arm.com>
 <20240305171324.GA22616@willie-the-truck>
Content-Language: en-US
From: "levi.yun" <yeoreum.yun@arm.com>
In-Reply-To: <20240305171324.GA22616@willie-the-truck>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO2P265CA0406.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:f::34) To AM0PR08MB4289.eurprd08.prod.outlook.com
 (2603:10a6:208:148::12)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	AM0PR08MB4289:EE_|VI1PR08MB5519:EE_|DB5PEPF00014B8F:EE_|AM8PR08MB5859:EE_
X-MS-Office365-Filtering-Correlation-Id: 64dc4c91-fae0-4ce6-f47a-08dc3d457db9
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original:
 yH3QNpbuE3BG8HVYccAVQpltaoNrXuDapupIjUzROrSt9JuM2gI1YkXcQOSQ1qw+LsdhBkpI5mKm0XDRwqBf5QXiDHoJoGRuCdKHWT4ZpyFATTCCy3DX7blHh3RzENlqxduz/s7foAzuF8/zrdhGoo4BY97XjanDAPgRvCfbzZc0kaMHVBMrBtDmiM5JuzoQBg6lr5ncnFWgtZlbi8C/XrR8/lqlz6KxnlvwgeN9Jl74QjhQwx09fH/5yiRt1+vk30g3/+vyL49L2CeBvRKXZkjOUYA7j06xKo8P3/yyh9kBYjg+VuIZHIYmpolah3FVi+q7/PbEbj31LP7pvVguQQy6rAn+x0vJZjYRmhgM12YeXf8TuZGD5JwJD22f/GexbZo7E2lOlnZhdykyhnjAriQrZ/8TZ2rZHJUvdkDEf4WzpFFfYB366vaPHAiHZf5ofpP33D81WvDMeX9xJ6KiKLotvA53Ss4rUa65sOTnPVcqg5aTZct51iWbaDFR+PLfut4jUhTYlzL2yudJg4VJ5ThfrhHZVXQuNn3+m4m7eJzXa6IbyVRGBdxttgWZR1tposiZ672T3YqJJQEuSye0ujwereoVmhMJDGaL3m3YIZrAnkEa0ltWRqI+cDU7kgH773G5r9PW2LC7JGRKA+SAciFVtawnX3FcU6aTpiyS5DM=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR08MB4289.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB5519
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB5PEPF00014B8F.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	7a38f005-03ef-4204-b5dc-08dc3d457809
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	s0UY0FPqlAP3CH02JYkztvx5z+G2z+oEtt7BgZrNboWt7fXNizDfDN+7Z7AQuZqjFa7XnGPt7LH0IjOzZ01UYVNN9VhrA0qVWMlzkXhQMQ+H9bSWTADMuWiHQFBpDHHnM8q+Zgtzrg2MI09ahR1NPDylNr0eB6YtZDx5jPw9BoXY/Z9OfXwygagnBs64e5UNwqAFD6sGIOHN4jM9+vJmaJezAE//wZbLKqeG5Yoh4NvhfjATnOZLLEeStuGuvM5RXwU3xo2OLNgfpY1r9CDYomwM0RtaT1TxqM9Ij0TrBxaZZO2GeSQhBLQeTY20LWSLIJDAbCPKNNpBDpWUDehA0ZUmiZkUHObYyus2vxrRNR37QxbLzsPQaaxaLWRGCrZ/UO0v5Nef5iK0YWpzlQySf2kHpNklMZeRVM+ZW0PxKT6as/J2czfU6bqoJVMbNibz7zf96O0pojtA8FUcIoW3LWdB+N2j32PZHgBYJ9v8TtLeT6V8QOSmoGDKpK9FiXEyGUuQtFX5QlksxP1uSTeJwHzZ+W3ghr3UT3SYompBURNYcKAbE/MyJUXOkC0V9GzCh9C/pqMvqAoDkIwtiZCR9Mr/Ey+tFceLerc1CUEcxc7+8vdv7FD2yZCCAH/TaAi+DlzUnKNi17Awe3jbE2p4sZejN9V3t4bLPmEzcHgte+rwK3yhz7YkDMil2FA7qHI8zsetuA/ujvGvUf4eCqcfI84YMwgE7ZFT+HRUM6HGs88c6dnpeactCrREDXoAwD2W
X-Forefront-Antispam-Report:
	CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230031)(376005)(36860700004)(82310400014);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2024 18:53:05.0988
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 64dc4c91-fae0-4ce6-f47a-08dc3d457db9
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB5PEPF00014B8F.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR08MB5859

Hi will.

> We already have a stronger barrier than smp_mb() (dsb ish) in __switch_to().
> Is that not sufficient?

IIUC, It's not sufficient with smp_mb() in __switch_to().

Because, it can be broken in sched_mm_cid_remote_clear()

CPU0  in __schedule()                       CPU1 in 
sched_mm_cid_remote_clear()
rq->curr = new_task;
<no barrier>
mm_get_cid remote_clear
    - check valid cid and use it.            Invalidate CID.
<barrier>
rq->curr (not observed).
                                                           unset the cid 
(<<BUG).


If change of rq->curr couldn't be observed in sched_mm_cid_remote_clear(),
It could unset actively used cid.
Note that __switch_to()'s smp_mb() is called AFTER switch_mm_cid().
That means before __switch_to(), there's possibility that
sched_mm_cid_remote_clear() couldn't observe new active task,
after it sets lazy_put on active cid used by new active task.

