Return-Path: <linux-kernel+bounces-65867-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3361E855304
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 20:14:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFCB42818FC
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 19:14:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5720013A888;
	Wed, 14 Feb 2024 19:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="qe3igyIG";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="qe3igyIG"
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2076.outbound.protection.outlook.com [40.107.104.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C927E134CCA;
	Wed, 14 Feb 2024 19:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.76
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707938049; cv=fail; b=rnHcY/OIc+Fmc4swRue8eWqIFcHOQLKLNtDWvCTzlzMMCHZX3XJ+VXOT1hdAdHXq7nM7XHcji1vWDlhxeB2JmYQNWes+/j05P7yEFa8tLCeEfdIcqT6qo+JDsh/lP4xiBEyV8TDoS8ESEdJRDVm49gWRiR0S1qgUyiJbegGFVLI=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707938049; c=relaxed/simple;
	bh=PtBSmNalnSgK0fQj7nKSueL8f5Ax3K3cayRj9hRDAqU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RPPSfMB0isFRVr3rzR0rC1bkijomM8ij2dJ+tJQwJp8h72gW5AY2Rcr1mQYleYlsdT/tNQOsOuxmDuXfB2Drx8eX2C60hs+Tx0DNA1PuEivdZP64HUpxBXOLcQ5xOqiXGYOOSV1S9xbz8EtfsbdjVASji+NyAZ70TeW3Ah6MAxw=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b=qe3igyIG; dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b=qe3igyIG; arc=fail smtp.client-ip=40.107.104.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=c+oA9dgqNXVae8TzrwZhg1VBfePZGukuhCE2Mh38+Fq1k00WPTVP5RuItFt91rBIOWu2wcBZaZjO4ai4S2M+wAkdfyauS+8ITjquO6s9GWrTAEUz0GDLTGqJ254SuWHnteVhKbRyeDTV4B58gYAJ+AWk8WDm3cJ4v8mVCCFpoa55xDhsWcgmlIjogtROVy8N4xyPe1+ORnO3Ak4NSsyDTFtbU0MEoTI0ga2RAGAGJtiXbljtR6onHOmoCZa86M1kmjq1cWArWJyscM4dUsLqlhEv/o28XsILCsmkWHvwov9BLsTqLAMBidVzvJbYxwhoQhtILtc2TiW7sFwOIOWt3Q==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PtBSmNalnSgK0fQj7nKSueL8f5Ax3K3cayRj9hRDAqU=;
 b=Dctb3fkczwOhA7mzJT3JQgRw9IcDIWo67Tsr+x4tGfyQBD66CdfdY5kd9OXhqFCgz9HaNBKvd0+rUMfhMogm33+JqaqPAzANRs75QJid4F47xz/0aBR8vaCsSJo28+Bqi4KqMDb9OBjEldXQ6e465ttwbvrlmzPNjSoet6nz/gS/w2m6dneTg44lBvzmddjE1mAVAg/N9TfJruVYIE+zjSX6oBCWaqzej/CTuOk1XD7JNBmQDxtRe1K7wR2vyI6tbMA0jf0/sU+o/LUZNEQniXRGbtJplB9c0rylUmyHIHEQy6/9j7yWS+qSXPUQ/u3mKskivjh9GgKlHvigZCiMyg==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=armh.onmicrosoft.com; arc=pass (0
 oda=1 ltdi=1 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PtBSmNalnSgK0fQj7nKSueL8f5Ax3K3cayRj9hRDAqU=;
 b=qe3igyIGDRl2fqtBhcD5JtRjAx2D8Bq5NHZzpFpqYxiZNznFb52IuZ1XkeJjFyzfaQT33RCIDKnnAPhA7C7dzfphW6KO4Bzdz9cY8ccq8z0NXDYxPCArbdZRVD5iBfTCn0km/pgnvcBcYN0dVESR/do0RzzI6G6WISQ5kek7SgU=
Received: from AM6PR0202CA0067.eurprd02.prod.outlook.com
 (2603:10a6:20b:3a::44) by AM7PR08MB5429.eurprd08.prod.outlook.com
 (2603:10a6:20b:107::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.27; Wed, 14 Feb
 2024 19:14:00 +0000
Received: from AMS0EPF000001A4.eurprd05.prod.outlook.com
 (2603:10a6:20b:3a:cafe::d5) by AM6PR0202CA0067.outlook.office365.com
 (2603:10a6:20b:3a::44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.39 via Frontend
 Transport; Wed, 14 Feb 2024 19:14:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AMS0EPF000001A4.mail.protection.outlook.com (10.167.16.229) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7292.25 via Frontend Transport; Wed, 14 Feb 2024 19:13:59 +0000
Received: ("Tessian outbound e4025c20aa63:v228"); Wed, 14 Feb 2024 19:13:59 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: dac5077fe9b0eea0
X-CR-MTA-TID: 64aa7808
Received: from f3d9b8037eb3.2
	by 64aa7808-outbound-1.mta.getcheckrecipient.com id 8757E218-240F-40AE-89D1-F63398C01F58.1;
	Wed, 14 Feb 2024 19:13:53 +0000
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id f3d9b8037eb3.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Wed, 14 Feb 2024 19:13:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E3B4Dylf2E9Eghmdwh5PQN0h8FMBMMV5jHnEbkV6mERCZk6kgOOZNkyvKl6YIodBlKrTsf1dzPzWdm5SBkKJ5ASzbSzcvXKDTtxKc7mGJLQl2xRXal87v9tst4RPd9hk+16x1+CtsAie5J6QWAJLNUvH2efORUhVPywaXj2nWOfcVNXUap0/txYac54HXq+rKpLKqP4FZKeBUZ1iW84zDHGtL0tTD3eQsPAgrKiHEbY3IkTUtHeGOHwaWRPggEzOHYjl+dxSpHL5z8QQgfgXuGknlWU5t4izIXevRV7HUGKqgaaRbKCQxq70kBF8xOZwQ6te2hIUI9lVUyMPMRE1Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PtBSmNalnSgK0fQj7nKSueL8f5Ax3K3cayRj9hRDAqU=;
 b=K7j9ak6bh/UCllCYEGhqVt5q77TuaXda4YHgBh5npU0XwhphLLr7ivHvbDgb69am7YDCyMF+Dj/xPegC33sBLuRhNfzh3xViek9xAZGnczA0vJEDOPinnx0nP/p5IB28ly3AMevN+awjnf2/M7Ey3rLbeQptTQ6sjarb2oGWeH9RDMALh+EshwcjR2gmxX5FywlUSCneAh+YyA0PYl0zKeu1w8ZO3geDTbsdAdRuV1BKCbOjfqG81kb1SWCiSO1YaT2/P00Jvqh6Sgi8rP7y925QMYvzM0Rf3qyedCQkImxiQkfkBd0e+T+thBc7zRFe+l3Fx1LLgNmYgH/K5yJyfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PtBSmNalnSgK0fQj7nKSueL8f5Ax3K3cayRj9hRDAqU=;
 b=qe3igyIGDRl2fqtBhcD5JtRjAx2D8Bq5NHZzpFpqYxiZNznFb52IuZ1XkeJjFyzfaQT33RCIDKnnAPhA7C7dzfphW6KO4Bzdz9cY8ccq8z0NXDYxPCArbdZRVD5iBfTCn0km/pgnvcBcYN0dVESR/do0RzzI6G6WISQ5kek7SgU=
Received: from AS8PR08MB6646.eurprd08.prod.outlook.com (2603:10a6:20b:350::15)
 by VI0PR08MB10631.eurprd08.prod.outlook.com (2603:10a6:800:20f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.39; Wed, 14 Feb
 2024 19:13:50 +0000
Received: from AS8PR08MB6646.eurprd08.prod.outlook.com
 ([fe80::bf90:87a7:c796:ce84]) by AS8PR08MB6646.eurprd08.prod.outlook.com
 ([fe80::bf90:87a7:c796:ce84%4]) with mapi id 15.20.7292.026; Wed, 14 Feb 2024
 19:13:50 +0000
From: Ben Gainey <Ben.Gainey@arm.com>
To: "ak@linux.intel.com" <ak@linux.intel.com>
CC: "irogers@google.com" <irogers@google.com>,
	"alexander.shishkin@linux.intel.com" <alexander.shishkin@linux.intel.com>,
	"peterz@infradead.org" <peterz@infradead.org>, Mark Rutland
	<Mark.Rutland@arm.com>, "linux-perf-users@vger.kernel.org"
	<linux-perf-users@vger.kernel.org>, "mingo@redhat.com" <mingo@redhat.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "jolsa@kernel.org" <jolsa@kernel.org>,
	"acme@kernel.org" <acme@kernel.org>, "namhyung@kernel.org"
	<namhyung@kernel.org>, "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
	"will@kernel.org" <will@kernel.org>
Subject: Re: [RFC PATCH 0/2] A mechanism for efficient support for
 per-function metrics
Thread-Topic: [RFC PATCH 0/2] A mechanism for efficient support for
 per-function metrics
Thread-Index: AQHaTfAsajJVWBW/3kKvO/nD4CFIobEJvBnlgACb5gA=
Date: Wed, 14 Feb 2024 19:13:50 +0000
Message-ID: <7de25cbdc9df21e1723d209ca8bd377a55bb54e4.camel@arm.com>
References: <20240123113420.1928154-1-ben.gainey@arm.com>
	 <87r0hfwet0.fsf@linux.intel.com>
In-Reply-To: <87r0hfwet0.fsf@linux.intel.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
x-ms-traffictypediagnostic:
	AS8PR08MB6646:EE_|VI0PR08MB10631:EE_|AMS0EPF000001A4:EE_|AM7PR08MB5429:EE_
X-MS-Office365-Filtering-Correlation-Id: 5eb53fd4-11e6-4620-1d35-08dc2d91195a
x-checkrecipientrouted: true
nodisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original:
 c/W1T71dkqsta468c0tVk2ztobP7V31M2L1v0/EeA1Yfsz1zdxruWOWfkGavMZMteUqLzL7iFvyMzSTFHZTViz6oFiMNdRySdxL2PxIwbXm/WtsRsuFMfy/o6HWSnuLhOZ33OMKKdbnYA1pTtoqU7PlGUHaipnA5kP0P2tMQ0AZRHZX26JZc/i2cKPaQ13H5JTYF8uj6Ak24NRbbjLofXmcyf+9t3kN4fv3RNquAvlYG9Db5+1bbUXtTE629JO78gXrGiJIe4NYu6Edf+Ds6swwVUG4k85rNi5Cs5QoUGYw7IxU2J45dFAy7wAUhi26os+AQ3issecq0pDeKgMayYdB8X2X7R/JmDinB5yzyW7IpdNsjUhIBYi89Kzu9BEWsQwh7efhSDGX8/rZtR5MXgXB+MBrjRt5dleK/INdWLBFDFMEnZy2obn8feT8/JjRhW8ScspNJvl/ciQ+JPAd2xB0dzejfYJ4FeGuVm0sR4YA9F59v+KSWvyRiRHdtvTN7dMtEauE0yYRV4+G5p4oGYqfz9AHSad+QMupqO0QHTCME85vvLOEAO1eZ+bO+ezGS0MCuhSer1JL52bwba1Nn63CIqoP1vOc+c3R2i4AaP+5MLW6laXKF/XK8W65sGb/P
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR08MB6646.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(136003)(366004)(39860400002)(376002)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(6486002)(478600001)(6506007)(41300700001)(86362001)(71200400001)(66899024)(38070700009)(66946007)(2906002)(7416002)(5660300002)(76116006)(54906003)(66476007)(6916009)(316002)(8936002)(8676002)(64756008)(66446008)(66556008)(4326008)(6512007)(38100700002)(26005)(2616005)(36756003)(83380400001)(122000001);DIR:OUT;SFP:1101;
Content-Type: text/plain; charset="utf-8"
Content-ID: <76C44AC956DEE742ADD628271DB61694@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR08MB10631
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AMS0EPF000001A4.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	f1882263-c77e-4c14-2f88-08dc2d9113a3
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	4D3h92PUUGULLAgz+gkkDbt5POFfhV1Die0pORVE2L2v3KPclm1vMeRbsfFBiP8MBvpcxu3S6RL3FOQmpEpW7r6JFZiUxzesGO4YwU0gSlmoBXPfcgeVN66ylqK1X25X2kE6ggQ40ine3ZOjTz75QakOhhRK6X73OiLQJlqwKVhBdMj7wRMt5Axz9W/xQvLe+MoaYbkWusINn61/SvZo1ehaDJabD0u+2cO4z35pUfDR4MpPDnfTMBzcSH62eUgUeA3dGXIC+rDkSJAPOCQqn51ovEmfWuc2nTtHSku74Clp8CoiuyNyPsj5hfGZm77fKGNw4pXlkySjnE/XAxfjYRnlTHVQ73Z9RS8mHQ8G2JzrldAydNptiJB7E5WLQU2+MyPrj9SUZoH2cmA5XYf6YA2G0bq8BphVCFSLxkYyGj0ZY3ER6fts7UX6JsasI2zrFLYnFcto1doESHkVPAYV3wyfNwe5HioLhxXtG8hfpq95zphFkbnnGkkx24nUXuu+uGKBQDjmUEO2DVeP6RetHmi97/0+CI2N9RfVFNLdACSAMevQ88xiVSsE6aP7MrcoEUOoZTiFhJW8FMaqYoP5ytlqw8TgnzHqAIBuQgFLxKE=
X-Forefront-Antispam-Report:
	CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230031)(4636009)(376002)(396003)(136003)(39860400002)(346002)(230922051799003)(1800799012)(82310400011)(64100799003)(451199024)(186009)(40470700004)(36840700001)(46966006)(86362001)(83380400001)(356005)(81166007)(82740400003)(36756003)(66899024)(2906002)(5660300002)(70586007)(450100002)(70206006)(41300700001)(8936002)(6862004)(4326008)(8676002)(54906003)(316002)(6486002)(6506007)(478600001)(6512007)(336012)(26005)(2616005);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2024 19:13:59.7674
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5eb53fd4-11e6-4620-1d35-08dc2d91195a
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF000001A4.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5429

SGkgQW5kaQ0KDQpUaGFua3MgZm9yIGNvbW1lbnRpbmcuLi4NCg0KT24gV2VkLCAyMDI0LTAyLTE0
IGF0IDAxOjU1IC0wODAwLCBBbmRpIEtsZWVuIHdyb3RlOg0KPiBCZW4gR2FpbmV5IDxiZW4uZ2Fp
bmV5QGFybS5jb20+IHdyaXRlczoNCj4gDQo+ID4gSSd2ZSBiZWVuIHdvcmtpbmcgb24gYW4gYXBw
cm9hY2ggdG8gc3VwcG9ydGluZyBwZXItZnVuY3Rpb24gbWV0cmljcw0KPiA+IGZvcg0KPiA+IGFh
cmNoNjQgY29yZXMsIHdoaWNoIHJlcXVpcmVzIHNvbWUgY2hhbmdlcyB0byB0aGUgYXJtX3BtdXYz
IGRyaXZlciwNCj4gPiBhbmQNCj4gPiBJJ20gd29uZGVyaW5nIGlmIHRoaXMgYXBwcm9hY2ggd291
bGQgbWFrZSBzZW5zZSBhcyBhIGdlbmVyaWMNCj4gPiBmZWF0dXJlDQo+ID4gdGhhdCBjb3VsZCBi
ZSB1c2VkIHRvIGVuYWJsZSB0aGUgc2FtZSBvbiBvdGhlciBhcmNoaXRlY3R1cmVzPw0KPiA+IA0K
PiA+IFRoZSBiYXNpYyBpZGVhIGlzIGFzIGZvbGxvd3M6DQo+ID4gDQo+ID4gwqAqIFBlcmlvZGlj
YWxseSBzYW1wbGUgb25lIG9yIG1vcmUgY291bnRlcnMgYXMgbmVlZGVkIGZvciB0aGUNCj4gPiBj
aG9zZW4NCj4gPiDCoMKgIHNldCBvZiBtZXRyaWNzLg0KPiA+IMKgKiBSZWNvcmQgYSBzYW1wbGUg
Y291bnQgZm9yIGVhY2ggc3ltYm9sIHNvIGFzIHRvIGlkZW50aWZ5IGhvdA0KPiA+IMKgwqAgZnVu
Y3Rpb25zLg0KPiA+IMKgKiBBY2N1bXVsYXRlIGNvdW50ZXIgdG90YWxzIGZvciBlYWNoIG9mIHRo
ZSBjb3VudGVycyBpbiBlYWNoIG9mDQo+ID4gdGhlDQo+ID4gwqDCoCBtZXRyaWNzICpidXQqIG9u
bHkgZG8gdGhpcyB3aGVyZSB0aGUgcHJldmlvdXMgc2FtcGxlJ3Mgc3ltYm9sDQo+ID4gwqDCoCBt
YXRjaGVzIHRoZSBjdXJyZW50IHNhbXBsZSdzIHN5bWJvbC4NCj4gDQo+IEl0IHNvdW5kcyB2ZXJ5
IHNpbWlsYXIgdG8gd2hhdCBwZXJmIHNjcmlwdCAtRiArbWV0cmljIGFscmVhZHkgZG9lcw0KPiAo
b3IgZGlkIGlmIGl0IHdhc24ndCBicm9rZW4gY3VycmVudGx5KS4gSXQgd291bGQgYmUgYSBzdHJh
aWdodA0KPiBmb3J3YXJkDQo+IGV4dGVuc2lvbiBoZXJlIHRvIGFkZCB0aGlzICJzYW1lIGFzIHBy
ZXZpb3VzIiBjaGVjay4NCg0KDQpOaWNlLCBJIHdhc24ndCBhd2FyZSBvZiB0aGlzIGZlYXR1cmUu
IEknbGwgaGF2ZSBhIHBsYXkuLi4NCg0KDQo+IA0KPiBPZiBjb3Vyc2UgdGhlIGZlYXR1cmUgaXMg
c29tZXdoYXQgZHViaW91cyBpbiB0aGF0IGl0IHdpbGwgaGF2ZSBhIHZlcnkNCj4gc3Ryb25nIHN5
c3RlbWF0aWMgYmlhcyBhZ2FpbnN0IHNob3J0IGZ1bmN0aW9ucyBhbmQgZXZlbiBsb25nDQo+IGZ1
bmN0aW9ucw0KPiBpbiBzb21lIGFsdGVybmF0aW5nIGV4ZWN1dGlvbiBwYXR0ZXJucy4gSSBhc3N1
bWUgeW91IGRpZCBzb21lDQo+IGV4cGVyaW1lbnRzIHRvIGNoYXJhY3Rlcml6ZSB0aGlzLiBJdCB3
b3VsZCBiZSBpbXBvcnRhbnQNCj4gdG8gZW1waGFzaXplIHRoaXMgaW4gYW55IGRvY3VtZW50YXRp
b24uDQoNClRoZSB3YXkgSSBoYXZlIGJlZW4gdGhpbmtpbmcgYWJvdXQgdGhpcyBpcyB0aGF0IGZv
ciBlYWNoIHNhbXBsZSB5b3UNCmFsd2F5cyBtYWludGFpbiBhIHBlcmlvZGljIHNhbXBsZSBjb3Vu
dCBzbyB0aGF0IHRoZSByZWxhdGl2ZSByYW5raW5nIG9mDQpmdW5jdGlvbnMgaXMgbWFpbnRhaW5l
ZCwgYW5kIHRoYXQgdGhlICJzYW1lIGFzIHByZXZpb3VzIiBjaGVjayBpcyBhIHdheQ0KdG8gZW5o
YW5jZSB0aGUgYXR0cmlidXRhYmlsaXR5IG9mIHRoZSBQTVUgZGF0YSBmb3IgYW55IGdpdmVuIHNh
bXBsZS4gDQoNCkJ1dCBpdCBhYnNvbHV0ZWx5IGNvcnJlY3QgdG8gc2F5IHRoYXQgdGhpcyB3aWxs
IGJpYXMgdGhlIGF2YWlsYWJpbGl0eQ0Kb2YgUE1VIGRhdGEgaW4gdGhlIHdheSB5b3UgaGF2ZSBk
ZXNjcmliZS4gVGhlIGJpYXMgZGVwZW5kcyBvbiBzYW1wbGUNCndpbmRvdyBzaXplLCB3b3JrbG9h
ZCBjaGFyYWN0ZXJpc3RpY3MgYW5kIHNvIG9uLg0KDQpJdCBzaG91bGQgYmUgcG9zc2libGUgdG8g
cHJvdmlkZSBhIHBlciBtZXRyaWMgInZhbGlkIHNhbXBsZSIgY291bnQgdGhhdA0KY2FuIGJlIHVz
ZWQgdG8ganVkZ2UgdGhlICAicXVhbGl0eSIgb2YgdGhlIG1ldHJpY3MgZm9yIGVhY2ggc3ltYm9s
LA0Kd2hpY2ggbWF5IGFsbG93IHRoZSB1c2VyIHRvIG1ha2Ugc29tZSBhZGp1c3RtZW50cyB0byB0
aGUgcmVjb3JkaW5nDQpwYXJhbXRlcnMgKG1vZGlmeSBzYW1wbGUgcGVyaW9kLCBvciBzYW1wbGUg
d2luZG93IHNpemUgZm9yIGV4YW1wbGUpLg0KDQpJJ2xsIGhhdmUgYSB0aGluayBhYm91dCB0aGUg
YmVzdCB3YXkgdG8gY29udmV5IHRoaXMgaW4gZG9jcy4gSSBoYXZlIGENCmZldyBpZGVhcyBmb3Ig
d2F5cyB0byBmdXJ0aGVyIGltcG92ZSB0aGUgYXR0cmlidXRhYmlsaXR5IC8gaWRlbnRpZnkNCmNh
c2VzIHdoZXJlIHNob3J0IGZ1bmN0aW9ucyBhcmUgbWlzc2VkLCBidXQgdGhleSdkIG5vdCBhZmZl
Y3QgdGhlDQppbXBsZW1lbnRhdGlvbiBvZiBhbnl0aGluZyBpbiB0aGUga2VybmVsLCBqdXN0IHBl
cmhhcHMgdGhlIHRvb2wncyBwb3N0LQ0KcHJvY2Vzc2luZy4NCg0KDQo+IA0KPiA+IEZvciB0aGlz
IHRvIHdvcmsgZWZmaWNpZW50bHksIGl0IGlzIHVzZWZ1bCB0byBwcm92aWRlIGEgbWVhbnMgdG8N
Cj4gPiBkZWNvdXBsZSB0aGUgc2FtcGxlIHdpbmRvdyAodGltZSBvdmVyIHdoaWNoIGV2ZW50cyBh
cmUgY291bnRlZCkNCj4gPiBmcm9tDQo+ID4gdGhlIHNhbXBsZSBwZXJpb2QgKHRpbWUgYmV0d2Vl
biBpbnRlcmVzdGluZyBzYW1wbGVzKS4gVGhpcw0KPiA+IHBhdGNoZXNldA0KPiA+IG1vZGlmaWVz
IHRoZSBBcm0gUE1VIGRyaXZlciB0byBzdXBwb3J0IGFsdGVybmF0aW5nIGJldHdlZW4gdHdvDQo+
ID4gc2FtcGxlX3BlcmlvZCB2YWx1ZXMsIHByb3ZpZGluZyBhIHNpbXBsZSBhbmQgaW5leHBlbnNp
dmUgd2F5IGZvcg0KPiA+IHRvb2xzDQo+ID4gdG8gc2VwYXJhdGUgb3V0IHRoZSBzYW1wbGUgcGVy
aW9kIGFuZCB0aGUgc2FtcGxlIHdpbmRvdy4gSXQgaXMNCj4gPiBleHBlY3RlZA0KPiA+IHRvIGJl
IHVzZWQgd2l0aCB0aGUgY3ljbGUgY291bnRlciBldmVudCwgYWx0ZXJuYXRpbmcgYmV0d2VlbiBh
IGxvbmcNCj4gPiBhbmQNCj4gPiBzaG9ydCBwZXJpb2QgYW5kIHN1YnNlcXVlbnRseSBkaXNjYXJk
aW5nIHRoZSBjb3VudGVyIGRhdGEgZm9yDQo+ID4gc2FtcGxlcw0KPiA+IHdpdGggdGhlIGxvbmcg
cGVyaW9kLiBUaGUgY29tYmluZWQgbG9uZyBhbmQgc2hvcnQgcGVyaW9kIGdpdmVzIHRoZQ0KPiA+
IG92ZXJhbGwgc2FtcGxpbmcgcGVyaW9kLCBhbmQgdGhlIHNob3J0IHNhbXBsZSBwZXJpb2QgZ2l2
ZXMgdGhlDQo+ID4gc2FtcGxlDQo+ID4gd2luZG93LiBUaGUgc3ltYm9sIHRha2VuIGZyb20gdGhl
IHNhbXBsZSBhdCB0aGUgZW5kIG9mIHRoZSBsb25nDQo+ID4gcGVyaW9kDQo+ID4gY2FuIGJlIHVz
ZWQgYnkgdG9vbHMgdG8gZW5zdXJlIGNvcnJlY3QgYXR0cmlidXRpb24gYXMgZGVzY3JpYmVkDQo+
ID4gcHJldmlvdXNseS4gVGhlIGN5Y2xlIGNvdW50ZXIgaXMgcmVjb21tZW5kZWQgYXMgaXQgcHJv
dmlkZXMgZmFpcg0KPiA+IHRlbXBvcmFsIGRpc3RyaWJ1dGlvbiBvZiBzYW1wbGVzIGFzIHdvdWxk
IGJlIHJlcXVpcmVkIGZvciB0aGUNCj4gPiBwZXItc3ltYm9sIHNhbXBsZSBjb3VudCBtZW50aW9u
ZWQgcHJldmlvdXNseSwgYW5kIGJlY2F1c2UgdGhlIFBNVQ0KPiA+IGNhbg0KPiA+IGJlIHByb2dy
YW1tZWQgdG8gb3ZlcmZsb3cgYWZ0ZXIgYSBzdWZmaWNpZW50bHkgc2hvcnQgd2luZG93OyB0aGlz
DQo+ID4gbWF5DQo+ID4gbm90IGJlIHBvc3NpYmxlIHdpdGggc29mdHdhcmUgdGltZXIgKGZvciBl
eGFtcGxlKS4gVGhpcyBwYXRjaCBkb2VzDQo+ID4gbm90DQo+ID4gcmVzdHJpY3QgdG8gb25seSB0
aGUgY3ljbGUgY291bnRlciwgaXQgaXMgcG9zc2libGUgdGhlcmUgY291bGQgYmUNCj4gPiBvdGhl
cg0KPiA+IG5vdmVsIHVzZXMgYmFzZWQgb24gZGlmZmVyZW50IGV2ZW50cy4NCj4gDQo+IEkgZG9u
J3Qgc2VlIGFueXRoaW5nIEFSTSBzcGVjaWZpYyB3aXRoIHRoZSB0ZWNobmlxdWUsIHNvIGlmIGl0
J3MgZG9uZQ0KPiBpdCBzaG91bGQgYmUgZG9uZSBnZW5lcmljYWxseSBJTUhPDQoNCg0KR3JlYXQu
IFdoZW4gaSB3YXMgb3JpZ2luYWxseSB0aGlua2luZyBhYm91dCB0aGUgaW1wbGVtZW50YXRpb24g
b2YgdGhlDQpldmVudCBzdHJvYmluZyBmZWF0dXJlIEkgd2FzIHRoaW5raW5nOg0KDQogKiBBZGQg
YHN0cm9iZV9zYW1wbGVgIGZsYWcgYml0IHRvIG9wdCBpbnRvIHRoZSBmYXR1cmUNCiAgIC0gVGhp
cyB3aWxsIGJlIG11dHVhbGx5IGV4Y2x1c2l2ZSB3aXRoIGBmcmVxYC4NCiAqIEFkZCBgc3Ryb2Jl
X3BlcmlvZGAgZmllbGQgdG8gaG9sZCB0aGUgYWx0ZXJuYXRlIHNhbXBsZSBwZXJpb2QgKGZvcg0K
dGhlIHNhbXBsZSB3aW5kb3cuDQogKiBIYXZlIGFsbCBQTVUgZHJpdmVycyBjaGVjayBhbmQgcmVq
ZWN0IHRoZSBgc3Ryb2JlX3NhbXBsZWAgZmxhZyBieQ0KZGVmYXVsdDsgdGhlIHN3aXp6bGluZyBv
ZiB0aGUgcGVyaW9kIHdpbGwgYmUgZG9uZSBpbiB0aGUgUE1VIGRyaXZlciBpdHMNCnNlbGYgaWYg
aXQgbWFrZSBzZW5zZSB0byBzdXBwb3J0IHRoaXMgZmVhdHVyZSBmb3IgYSBnaXZlbiBQTVUuDQog
ICAtIERvIHlvdSB0aGluayB0aGlzIGlzIHNlbnNpYmxlLCBvciB3b3VsZCBiZSBiZXR0ZXIgaGFu
ZGxlZCBpbiBjb3JlPw0KDQpBbnkgb2J2aW91cyBpc3N1ZXMgd2l0aCB0aGlzIGFwcHJvYWNoPw0K
DQo+IA0KPiANCj4gPiBDdXJzb3J5IHRlc3Rpbmcgb24gYSBYZW9uKFIpIFctMjE0NSBzYW1wbGlu
ZyBldmVyeSAzMDAgY3ljbGVzDQo+ID4gKHdpdGhvdXQNCj4gPiB0aGUgcGF0Y2gpIHN1Z2dlc3Rz
IHRoaXMgYXBwcm9hY2ggd291bGQgd29yayBmb3Igc29tZSBjb3VudGVycy4NCj4gPiBDYWxjdWxh
dGluZyBicmFuY2ggbWlzcyByYXRlcyBmb3IgZXhhbXBsZSBhcHBlYXJzIHRvIGJlIGNvcnJlY3Qs
DQo+ID4gbGlrZXdpc2UgVU9QU19FWEVDVVRFRC5USFJFQUQgc2VlbXMgdG8gZ2l2ZSBzb21ldGhp
bmcgbGlrZSBhDQo+ID4gc2Vuc2libGUNCj4gPiBjeWNsZXMtcGVyLXVvcCB2YWx1ZS4gT24gdGhl
IG90aGVyIGhhbmQgdGhlIGZpeGVkIGZ1bmN0aW9uDQo+ID4gaW5zdHJ1Y3Rpb25zDQo+ID4gY291
bnRlciBkb2VzIG5vdCBhcHBlYXIgdG8gc2FtcGxlIGNvcnJlY3RseSAoaXQgc2VlbXMgdG8gcmVw
b3J0DQo+ID4gZWl0aGVyDQo+ID4gdmVyeSBzbWFsbCBvciB2ZXJ5IGxhcmdlIG51bWJlcnMpLiBO
byBpZGVhIHdoYXRzIGdvaW5nIG9uIHRoZXJlLCBzbw0KPiA+IGFueQ0KPiA+IGluc2lnaHQgd2Vs
Y29tZS4uLg0KPiANCj4gSWYgeW91IHVzZSBwcmVjaXNlIHNhbXBsZXMgd2l0aCAzcCB0aGVyZSBp
cyBhIHJlc3RyaWN0aW9uIG9uIHRoZQ0KPiBwZXJpb2RzDQo+IHRoYXQgaXMgZW5mb3JjZWQgYnkg
dGhlIGtlcm5lbC4gTm9uIHByZWNpc2Ugb3Igc2luZ2xlL2RvdWJsZSBwIHNob3VsZA0KPiBzdXBw
b3J0IGFyYml0cmFyeSwgZXhjZXB0IHRoYXQgYW55IHAgaXMgYWx3YXlzIHBlcmlvZCArIDEuDQoN
CklzIHRoZXJlIHNvbWUgZGVmYXVsdCB2YWx1ZSBmb3IgcHJlY2lzZT8gd2hlbiB0ZXN0aW5nIEkg
ZGlkbid0IHNldCBhbnkNCnNwZWNpZmljIHZhbHVlIGZvciBwIG1vZGlmaWVyLg0KDQoNCj4gDQo+
IE9uZSBkcmF3YmFjayBvZiB0aGUgdGVjaG5pcXVlIG9uIHg4NiBpcyB0aGF0IGl0IHdvbid0IGFs
bG93IG11bHRpDQo+IHJlY29yZA0KPiBwZWJzIChjb2xsZWN0aW5nIHNhbXBsZXMgd2l0aG91dCBp
bnRlcnJ1cHRzKSwgc28gdGhlIG92ZXJoZWFkIG1pZ2h0DQo+IGJlIGludHJpbnNpY2FsbHkgaGln
aGVyLg0KPiANCj4gLUFuZGkNCg0KDQpTdXJlLCBJIHRoaW5rIHRoaXMga2luZCBvZiBkZXRhaWwg
d2FzIHdoeSBJIHdhcyB0aGlua2luZyBpdCBzaG91bGQgYmUNCnRoZSBQTVUgZHJpdmVyIHJhdGhl
ciB0aGFuIGNvcmUgdGhhdCBoYW5kbGVzIHRoZSBzdHJvYmluZyBmZWF0dXJlLA0Kc2luY2UgdGhl
cmUgbWF5IGJlIG90aGVyIGNvbnNpZGVyYXRpb25zIC8gYmV0dGVyIHdheXMgdG8gY29sbGVjdCB0
aGUNCm1ldHJpY3Mgc2FtcGxlcy4NCg0KUmVnYXJkcw0KQmVuDQo=

