Return-Path: <linux-kernel+bounces-65597-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 89309854F44
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 17:58:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42158283EE9
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 16:58:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FB6C605DF;
	Wed, 14 Feb 2024 16:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="DpxtBb+E";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="DpxtBb+E"
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2048.outbound.protection.outlook.com [40.107.105.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60DA6604BC;
	Wed, 14 Feb 2024 16:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.48
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707929900; cv=fail; b=rdjig3wZkaMXi1HscMROaXZitYvcQ27ieW7Ddb+QOOCfaDNkjYv5Nx1EdTWvfpSCSVaLVhHIJzyBir104erVep5B4Fq7hTGtn1NvSTRyzKNB5fOt5sV/Bh/Vm8V04V45jRC4jJJDm+9VeeGP7Dz4B2HS1pnSx7h5lO6jz2vGXGs=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707929900; c=relaxed/simple;
	bh=EYio4zPl+9EMLWpRGG8xN/sPn6bJBYFN8ZiMmHL0DQ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uk7v61cCwC1ax4WTVNQT8sKS43ChDWXtKW08ru8P0A+J5Jc2Y5XKQQeHiSnpYoH9ZFT3Ln6GadkHIWTyFWFFvcFpsRSKmN9FgIqou7CqMC657O8GT+n20CxoqbU+qvtCkB6i+jsanM6PasOO0cj10kAn2UoyGq+qkkxWOSJlclw=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b=DpxtBb+E; dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b=DpxtBb+E; arc=fail smtp.client-ip=40.107.105.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=EU9SXfOk43MzjepQT5j1XSDhX7dJ8r6F5XteOVmn2LkexNZL5KR3BxzxKo8n/PqWCDszL1M67XBk0p7jxM9qBLbFQ6V/9xU5pmIcINH7gaYwlBrH+0IrhMMAYpVHamf8QMjW3kuNuSdix/wsxW16AWjf91tKJdm2zOtlZGU11lsQzF4O4XGcVuuK09GVbJCOCLr73CrPiSyShLaKlkCbNiwFM2PoZmxK+lLbj8LVNbbp/MbmH61I658b0LigzNogr8lfiAF2fc+5KTUYGIzL+C/WfUxBj0F5GRl0VhjDd9WDk2dnRTELewo4+20OCiJeYAcfTUsZOahFWqtO4SSM3A==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TlT8qBa3eyDHPDB8wRdMAvti5i+ryETTRcSj43ILdaY=;
 b=O2BttGJmsn9EK+E82GEjC4OoNOlIoq8tZi0jxJlGSJfnRX3ReyHdO/kBY2D8KvJ0r/meiRUNVmjTbq3h4EHbbuO/Wfxo8h2Dp9PaCqLzRdMUYa4J+YC7oBerecN+HqMqIEf5jwiftLjKYC68zTrXNyvDCf37Yp6T7TVLcdAKusAgVB/Qhwqo7QVC8i4L9pJP2qmN8VosLIv8a5zPyryjYejELF3jMyU7s27lkDUv8dChJ/p221xIsqrqLby0rrBC4pQvVlbdvmhtRgs+q83ogWYfMS60P50d2ZqvFhpHBWjJJLCbDs1WYbgMOSZ01AnuMHbVcWqquteKeitx1r3maA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=armh.onmicrosoft.com; arc=pass (0
 oda=1 ltdi=1 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TlT8qBa3eyDHPDB8wRdMAvti5i+ryETTRcSj43ILdaY=;
 b=DpxtBb+E/a+6XeVUyc4h4QcXuvbO45JgQB/29a2FIvIZhux3LkQH03hPevc9UA2lnQjpIJHCZ6YzCQgE3RwLZexnwoNWHt8hFnClxjY5LVXvixet/VyH0j/kTQGcxyu7oVaRN/OZb4LCQNvhgJ5JSxdeqIk5uKRVareA5NBWdh4=
Received: from DU2PR04CA0335.eurprd04.prod.outlook.com (2603:10a6:10:2b4::11)
 by GV1PR08MB10598.eurprd08.prod.outlook.com (2603:10a6:150:165::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.26; Wed, 14 Feb
 2024 16:58:06 +0000
Received: from DB5PEPF00014B9D.eurprd02.prod.outlook.com
 (2603:10a6:10:2b4:cafe::6c) by DU2PR04CA0335.outlook.office365.com
 (2603:10a6:10:2b4::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.39 via Frontend
 Transport; Wed, 14 Feb 2024 16:58:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5PEPF00014B9D.mail.protection.outlook.com (10.167.8.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7292.25 via Frontend Transport; Wed, 14 Feb 2024 16:58:06 +0000
Received: ("Tessian outbound 982a51ae93a5:v228"); Wed, 14 Feb 2024 16:58:06 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 050fa6b98e681624
X-CR-MTA-TID: 64aa7808
Received: from 4508d37cf19a.2
	by 64aa7808-outbound-1.mta.getcheckrecipient.com id C8B156EC-5E49-4856-BAFC-C498180C4A80.1;
	Wed, 14 Feb 2024 16:56:45 +0000
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 4508d37cf19a.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Wed, 14 Feb 2024 16:56:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PIMmbMR6io0VX6F3vqBVE6Cjm/2pS4ZBS11Nn8fJxts5shlzSvS1bCtnqtRynxLqJshrP5+EkJF70jO8KARuDb8jFDdK3aPDoq82G0ZcbXxyQcsND6wcl5TCM3jeqty1slQklMYNyHYl5eLt7h1ig8nkCtzCWQ5DELqYbU6Lmv8RszO3lO4IwAVRq7mmnmNRP3hoeochlvx1uJgq0H95fs+JLruBe/2WIAS9/stzIs/ovosGe7jB0L+++edkDVrvphaenuYdlTTIDa/b38e6Cn8kYIIn+WeQZmgVgdZLUbrFi0qL8lRgsqLsX1pIEUwZFHHFC/EDc3lxA7jIIpFG9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TlT8qBa3eyDHPDB8wRdMAvti5i+ryETTRcSj43ILdaY=;
 b=HZyZRj8mEzBvD3OFVKg2VjDNUI+Zaw5eN14y3PBUMVnQ59ER5lhUi3qlSg5IXIIyZr3oG8GhCs2+xwAKXcqmMfIGkVvzGo+rFChHkNxjs5+YNWZ0l24zuOfwGpnhTQSRU6YV2BHsAohpcExZoB9+7xXyWeZP5dw+2C9PHNigOjmu1KP/Ki/8/RZxR/n/FLpHe4Kn8zwil3QzB8sf1mIElB/VlH43OJ3j7t40emf/WtwCYwzkWcNFKQ3VbGIKnw/LgncwmRpqHcONwe9us12SsDWBjMZ3hZhNTyq5u8nigsIRFXIrXYW10TpJ/P9QhYRG0N1EZCx6MOe44v6ZEIfh0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TlT8qBa3eyDHPDB8wRdMAvti5i+ryETTRcSj43ILdaY=;
 b=DpxtBb+E/a+6XeVUyc4h4QcXuvbO45JgQB/29a2FIvIZhux3LkQH03hPevc9UA2lnQjpIJHCZ6YzCQgE3RwLZexnwoNWHt8hFnClxjY5LVXvixet/VyH0j/kTQGcxyu7oVaRN/OZb4LCQNvhgJ5JSxdeqIk5uKRVareA5NBWdh4=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from PA4PR08MB6093.eurprd08.prod.outlook.com (2603:10a6:102:e8::7)
 by DB9PR08MB8626.eurprd08.prod.outlook.com (2603:10a6:10:3d2::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.38; Wed, 14 Feb
 2024 16:56:44 +0000
Received: from PA4PR08MB6093.eurprd08.prod.outlook.com
 ([fe80::89b9:e2af:de7b:d8b9]) by PA4PR08MB6093.eurprd08.prod.outlook.com
 ([fe80::89b9:e2af:de7b:d8b9%2]) with mapi id 15.20.7270.036; Wed, 14 Feb 2024
 16:56:44 +0000
From: Balint Dobszay <balint.dobszay@arm.com>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: op-tee@lists.trustedfirmware.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 jens.wiklander@linaro.org, sumit.garg@linaro.org, corbet@lwn.net,
 sudeep.holla@arm.com, gyorgy.szing@arm.com
Subject: Re: [PATCH 3/3] Documentation: tee: Add TS-TEE driver
Date: Wed, 14 Feb 2024 17:56:41 +0100
X-Mailer: MailMate (1.14r5937)
Message-ID: <40BCD479-90FC-4B32-AA97-A7B39CA8A3FC@arm.com>
In-Reply-To: <bbb40718-9bfa-4431-a3b0-c09d068fd6cc@infradead.org>
References: <20240213145239.379875-1-balint.dobszay@arm.com>
 <20240213145239.379875-4-balint.dobszay@arm.com>
 <bbb40718-9bfa-4431-a3b0-c09d068fd6cc@infradead.org>
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0318.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:eb::18) To PA4PR08MB6093.eurprd08.prod.outlook.com
 (2603:10a6:102:e8::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	PA4PR08MB6093:EE_|DB9PR08MB8626:EE_|DB5PEPF00014B9D:EE_|GV1PR08MB10598:EE_
X-MS-Office365-Filtering-Correlation-Id: c30a2162-5619-4ce5-1ea5-08dc2d7e1d63
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original:
 TYWtitNlEbaFOtR/Fk2LCIQNdTfH5O/iU5yvUaQp8oA7C2SU2NCVgp2ZhsGj5pWmpKHkIeDfdpthkZ+1jGC8MSCreEHpEsnLq8qS0nF2/gct5ma2tZIpUv7FM0F0K/QND2WxogMtmWXm4RCUeQ5l/wxM6bZ7ppBliAdMFf8DntjoBeIUAT7KUg25dpHEoWOCgnN2VB28aSV7tCimaGHIodU5V2h4Mto8hh1kunnu+o5C4XPk63gaXvXg1Kzg7VdvLm1CCKzrDk91WRZoUZ66Yt2jRgwgQ0rTuFAkPgPxIwXwwSoRk3BfShqCfqqTMRYJFeLt0Wi79PXkMSBNn03ojTqH3lSOL5PfjfmJm1pJpGyYc24bsD65VKtycpc8jN3RteRDIoU2hh7kdcDQgA+9ei1RMBpNCF/qketIbiXyPiKpao3Osr0oHxt24Kds9suUXYSr9uH7a6yN+LZnZqjtNsfRAer+/j/ed9SWualb6alhNxmnTREgF7HZjb0kt8Du2NH8m0QZk4pRnl0zJTA7xEox/FeBv1OtCsWjzDU8tsXgHT+o395/bCubNuKWgTrQ
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR08MB6093.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(376002)(346002)(396003)(366004)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(2906002)(44832011)(478600001)(53546011)(6916009)(66476007)(6486002)(6512007)(4326008)(26005)(66556008)(6506007)(8936002)(5660300002)(66946007)(8676002)(33656002)(36756003)(2616005)(83380400001)(41300700001)(6666004)(316002)(38100700002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB8626
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB5PEPF00014B9D.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	ae395060-0e67-440e-278e-08dc2d7dec95
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	58uVhAiHnHV4Xe9/vEPnT8FZ+yz4On7WnHEbIVMeS75hWCF2SVkwugMtMpr5QqxTPdEDEaFz8gRn5ehoeNYa3wkLgHdVWGULmGRNqxrlZRyQhRz6hAI1txL7Pj2YnRWUcbnGQG8vk+lgvEQ5XchA9R7sN3oX/CvUcBPJRe1vXzOD0EJC7ERejlqvfKZrrN1gS5aP/TCQuW6B3Bl6SITJC5LJVZKHrZrD0rnosy/789gMv/f9g6tBAWzZUOo+p2pHeGvpQ5DlhWf5R4LU+IvhWIgak6lS+ChlOCVgNHzt8BtC2FGt8DMMPwTCrCE1rs1cpzpTVLIXmyB9k+In5qtuIntOnbU2yTc8fQ0EAh4XPKefqaqBWdgVIfa+diqAKAdPUq3M6P20cUX0yZ3IhkKHIV2GPUC/wCE3H6HjdFAbCT1XRrXHdvAuPA+pOo2rqUXS3IKJs39Zu7exumMdnJ0Y6lDbeSUkQoH9oDIBo3KxYlobcVz08lLDyvwICa79fqoaBLvLch2Rxghv8WLnwEEZBD51VQQy8IwYSbinymgNFgO3nQUYnJd3jCnpmerCrJ7jChmOfjg04qGymYsZDEpjvtnfaCBQuPgWtGJHveKyRYI=
X-Forefront-Antispam-Report:
	CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230031)(4636009)(346002)(136003)(39860400002)(396003)(376002)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(82310400011)(40470700004)(46966006)(36840700001)(316002)(70206006)(70586007)(41300700001)(2906002)(5660300002)(8676002)(6512007)(450100002)(4326008)(86362001)(33656002)(6862004)(8936002)(44832011)(478600001)(6486002)(6666004)(53546011)(6506007)(26005)(2616005)(36756003)(82740400003)(83380400001)(336012)(81166007)(356005);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2024 16:58:06.1932
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c30a2162-5619-4ce5-1ea5-08dc2d7e1d63
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB5PEPF00014B9D.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB10598

Hi Randy,

On 13 Feb 2024, at 22:44, Randy Dunlap wrote:

> Hi--
>
> On 2/13/24 06:52, Balint Dobszay wrote:
>> Add documentation for the Trusted Services TEE driver.
>>
>> Signed-off-by: Balint Dobszay <balint.dobszay@arm.com>
>> ---
>>  Documentation/tee/index.rst  |  1 +
>>  Documentation/tee/ts-tee.rst | 70 ++++++++++++++++++++++++++++++++++++
>>  2 files changed, 71 insertions(+)
>>  create mode 100644 Documentation/tee/ts-tee.rst
>>
>
>> diff --git a/Documentation/tee/ts-tee.rst b/Documentation/tee/ts-tee.rst
>> new file mode 100644
>> index 000000000000..e121ebbbfab7
>> --- /dev/null
>> +++ b/Documentation/tee/ts-tee.rst
>> @@ -0,0 +1,70 @@
>> +.. SPDX-License-Identifier: GPL-2.0
>> +
>> +=================================
>> +TS-TEE (Trusted Services project)
>> +=================================
>> +
>> +This driver provides access to secure services implemented by Trusted Services.
>> +
>> +Trusted Services [1] is a TrustedFirmware.org project that provides a framework
>> +for developing and deploying device Root of Trust services in FF-A [2] S-EL0
>> +Secure Partitions. The project hosts the reference implementation of the Arm
>> +Platform Security Architecture [3] for Arm A-profile devices.
>> +
>> +The FF-A Secure Partitions (SP) are accessible through the FF-A driver [4] which
>> +provides the low level communication for this driver. On top of that the Trusted
>> +Services RPC protocol is used [5]. To use the driver from user space a reference
>> +implementation is provided at [6], which is part of the Trusted Services client
>> +library called libts [7].
>> +
>
> Fix run-on sentences:
>
>> +All Trusted Services (TS) SPs have the same FF-A UUID, it identifies the TS RPC
>
>                                                     UUID. It
> or
>                                                     UUIT; it
>
>> +protocol. A TS SP can host one or more services (e.g. PSA Crypto, PSA ITS, etc).
>> +A service is identified by its service UUID, the same type of service cannot be
>
>                                           UUID;
>
>> +present twice in the same SP. During SP boot each service in the SP is assigned
>> +an "interface ID", this is just a short ID to simplify message addressing.
>
>       "interface ID." This
>
>> +
>> +The generic TEE design is to share memory at once with the TEE implementation,
>> +which can then be reused to communicate with multiple TAs. However, in case of
>
> "TA" is not defined.
>
>> +FF-A, memory sharing works on an endpoint level, i.e. memory is shared with a
>> +specific SP. User space has to be able to separately share memory with each SP
>> +based on its endpoint ID, therefore a separate TEE device is registered for each
>
>                          ID; therefore
>
>> +discovered TS SP. Opening the SP corresponds to opening the TEE device and
>> +creating a TEE context. A TS SP hosts one or more services, opening a service
>
>                                                      services. Opening

Thanks for the comments, I'll address them in the next version.

Regards,
Balint

