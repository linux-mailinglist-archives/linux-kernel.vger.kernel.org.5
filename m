Return-Path: <linux-kernel+bounces-64991-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FE2985464A
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 10:41:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 652851C273FF
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 09:41:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52F0113AD8;
	Wed, 14 Feb 2024 09:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="ULqNU7sF";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="ULqNU7sF"
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2057.outbound.protection.outlook.com [40.107.8.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDA8C14A8C;
	Wed, 14 Feb 2024 09:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.57
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707903689; cv=fail; b=Smc9NE7QV77W0cd7gVS/QAHhJDcyt6kn2ZS63g1hTzTEbc3yoWPgDrR1G9y8P2lg6Bf2N3t9qGb+VpYsSI0K/gs8qzPMPOE4YgjR2Uar8Ud4jmv0O7WnQxQR1QKsjFq/73WZlTGiuq7Eg1VAqQ4vcRp4JfoU0ImnFoWaurD0ezU=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707903689; c=relaxed/simple;
	bh=5IX/gTjgsXDBdWRAo9xYvvKtxMnsivABWOClAsUfP+M=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=k+Q0ZpJVJcklNwR7YWCe8PB+Tknqx4ufYRHM7pCv3k6ydP78nzDl9b0bttPksE9nPt41hrNdrCvq197LlhNYniuT+WILXKqrn/n+781DSYwiOb43ScRKBXXssBOrP/t19uspJqYT+YbWLhbJjqOEc8BX7Pe4Z+BkOeoExa2W1R0=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b=ULqNU7sF; dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b=ULqNU7sF; arc=fail smtp.client-ip=40.107.8.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=ihDW9jKB2+lhx2oxwd3hnS7rM93O1yzLGMxvmbkoUlWE7KKMZ1D4kKE1E3nzuEjUSq1IOFbzucTY6In1YSWPHPukOCg0gZr6fCJnFTh9G7fcQVelVqSiDTq3fSaSv0V6cDX89oPYUqljemH9ctCrjook4WZQOOuKqmj0kPxMnTUyjzVQDr8ueonEv2wshJ3e0eRpwUBKwIPGt+V4/QZKey0rl/wUhx/oBMqBHwzcIxZcICu6epJnDt8bJdiANfKvYKxzI499WBIeIYLmwdvlQabk8gPJLEHFYaqaMYeNeVr7DNjhfZyJMGtWnfcetcuN2ekTJnW3vb77F5OGqM/iKQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5IX/gTjgsXDBdWRAo9xYvvKtxMnsivABWOClAsUfP+M=;
 b=DRvZT5E6EKVCcDA+9eHXJ99N2c/WJrwnrKOt35ZGpvg+dU+G6KxMvK+md1SOoLzafCJaEmwPXv2hkpotZP0nhggfuNkUl6NgO+MpZMq7p8jmZ4lyLKHImYwM6KpTicXZ4/gj/WHoTHxKLbeTwbF8VlEHL4VFcGQ/E1GsL1j57GSa47ix67RG0jlw4Q5TGsXZh+G02f5LKWHh6Nc19qjRpv+UBm9YsXN/+VOIvSeX7VKgWK0NshQzmpVBUHjkZ4AXZyyGb1QHcReSB9lRUfhhmDjBYV/8T0cRca7zOjp38NPtUrc63wnJN5et/Ia+rsEwm64Axh4gMjbChk5/Mg88AA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=armh.onmicrosoft.com; arc=pass (0
 oda=1 ltdi=1 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5IX/gTjgsXDBdWRAo9xYvvKtxMnsivABWOClAsUfP+M=;
 b=ULqNU7sFr8YOqgPMS5ujMrn9ZGTd6TZKJnH8TQtZWGhRXjGzf4ScNZZlzXUItztcUTzKbpFIhJDOXeUkylDPSoimWZltmzJK2SGBIwQJ4AyiPlrVJ3gLxf/BAssL8QwJ/lXl7xpTs5c5+tYWicxMbAvJVee90YTVxftUNs8ylP4=
Received: from AM6PR10CA0030.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:209:89::43)
 by PAXPR08MB7336.eurprd08.prod.outlook.com (2603:10a6:102:223::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.39; Wed, 14 Feb
 2024 09:41:12 +0000
Received: from AM3PEPF00009B9D.eurprd04.prod.outlook.com
 (2603:10a6:209:89:cafe::2e) by AM6PR10CA0030.outlook.office365.com
 (2603:10a6:209:89::43) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.39 via Frontend
 Transport; Wed, 14 Feb 2024 09:41:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM3PEPF00009B9D.mail.protection.outlook.com (10.167.16.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7292.25 via Frontend Transport; Wed, 14 Feb 2024 09:41:12 +0000
Received: ("Tessian outbound 982a51ae93a5:v228"); Wed, 14 Feb 2024 09:41:11 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: a248ed724a358412
X-CR-MTA-TID: 64aa7808
Received: from 901f735d02d1.2
	by 64aa7808-outbound-1.mta.getcheckrecipient.com id D1709308-2F88-4C6F-A597-63A395567ECB.1;
	Wed, 14 Feb 2024 09:41:00 +0000
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 901f735d02d1.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Wed, 14 Feb 2024 09:41:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BBpuuJFNd03A+Zrm2JfJ40HMBFmLkv3G2AtqMGySX4RKUxAWkgHVbHUJEbL+zgoMY4PEpkBj96zn4jBaPB/ewkiY4Ekkwit0QPUXN3cGGei2Ai8vgJuH/5gefHJZzkMrbMRYuz0R/d5PvcAJuzbjgAZ+W5zvRuclTXgcvrojwQFdiB5IB4I6ey+wUAkRbLQmIBWQbnpPWKBc7pfOuJfT7yMwID2Mr+8Oj/jynmAajyxnbgAAZmbYGDVxYzu0dl84D0FYI3YdAC3xyiHRdpBEdMn7Intj0NSJ2c23nKZp/rmniHGxmMgo6aY7pWz0SF/emPD1RqQpC1/mnFodQkCnnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5IX/gTjgsXDBdWRAo9xYvvKtxMnsivABWOClAsUfP+M=;
 b=oH/deUIoPTtOzNX1O6dgcyVclqiE3nNsnuREbvNAUUokR53UtyrxBXi1bOANLej+nr/W2+i2buTcCspzIwpfqgb6OCvKKePiXJpLWjZdJ2YU4egaB3B9O/bnZcF8ZYeSeFaiGawmIzSFx37d95cVkr+j66Fnve7nsOGJoAqspacpxqhSZ8UfRC++TZ8RCCC+n+9Cy1z6JJ10DLIt2QMsiHErPeyVh57R8cTqDd/Y0+QU02I+Bcu4k1zVWRb77krxeYP0tpzTu6Mp/0qy1AXzimsYaCAa6nDAqKp5z/DreYli5CXbAD5Uu+8+tIbL49G0g0VFHcCU0XEli5BY1YW7ZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5IX/gTjgsXDBdWRAo9xYvvKtxMnsivABWOClAsUfP+M=;
 b=ULqNU7sFr8YOqgPMS5ujMrn9ZGTd6TZKJnH8TQtZWGhRXjGzf4ScNZZlzXUItztcUTzKbpFIhJDOXeUkylDPSoimWZltmzJK2SGBIwQJ4AyiPlrVJ3gLxf/BAssL8QwJ/lXl7xpTs5c5+tYWicxMbAvJVee90YTVxftUNs8ylP4=
Received: from AS8PR08MB6646.eurprd08.prod.outlook.com (2603:10a6:20b:350::15)
 by AS4PR08MB7808.eurprd08.prod.outlook.com (2603:10a6:20b:51b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.27; Wed, 14 Feb
 2024 09:40:57 +0000
Received: from AS8PR08MB6646.eurprd08.prod.outlook.com
 ([fe80::bf90:87a7:c796:ce84]) by AS8PR08MB6646.eurprd08.prod.outlook.com
 ([fe80::bf90:87a7:c796:ce84%4]) with mapi id 15.20.7292.026; Wed, 14 Feb 2024
 09:40:57 +0000
From: Ben Gainey <Ben.Gainey@arm.com>
To: "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-perf-users@vger.kernel.org"
	<linux-perf-users@vger.kernel.org>
CC: "alexander.shishkin@linux.intel.com" <alexander.shishkin@linux.intel.com>,
	"peterz@infradead.org" <peterz@infradead.org>, "acme@kernel.org"
	<acme@kernel.org>, "mingo@redhat.com" <mingo@redhat.com>, Mark Rutland
	<Mark.Rutland@arm.com>, "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
	"irogers@google.com" <irogers@google.com>, "jolsa@kernel.org"
	<jolsa@kernel.org>, "will@kernel.org" <will@kernel.org>,
	"namhyung@kernel.org" <namhyung@kernel.org>
Subject: Re: [RFC PATCH 0/2] perf: A mechanism for efficient support for
 per-function metrics
Thread-Topic: [RFC PATCH 0/2] perf: A mechanism for efficient support for
 per-function metrics
Thread-Index: AQHaXynp0myL0WMKRkC37nMNiIz6uw==
Date: Wed, 14 Feb 2024 09:40:57 +0000
Message-ID: <7b6c55a93f5064147b85795d471a8ae990817d3b.camel@arm.com>
References: <20240123113420.1928154-1-ben.gainey@arm.com>
In-Reply-To: <20240123113420.1928154-1-ben.gainey@arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.50.3 
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
x-ms-traffictypediagnostic:
	AS8PR08MB6646:EE_|AS4PR08MB7808:EE_|AM3PEPF00009B9D:EE_|PAXPR08MB7336:EE_
X-MS-Office365-Filtering-Correlation-Id: 08acc0b1-39f9-4372-3468-08dc2d4114bd
x-checkrecipientrouted: true
nodisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original:
 ME+ZbyBOVVy23Wp3Nn2S+wI2LberLUwLyhfvG5l/MVmMqBuqry4yi0KxjmfcqJLYni+eS0d3PKqTBazRhm45Z4JE5s0PunqCzb3eaYk++LTzbPKjIGQo3j5wy52ff45NR+TOZ+zsvuInY6xb9k0RRTevcL/zablWJocwG1EU9cjwyTawSIADV1FcS4iuNsPqTwpcZr7nYITLnQrd5FtfwSMbuqdHGpdg4zGy21Rm7/Oov5nYhg2dX+20uaLmReqf/5OmuCB0qzMe5Yp7wmSqHjDPg17KqzIdO7jhyVTz+0GzIEY/YaMLy0hbns5D+38cfTQAKrCCEHFHwet6dHys41bLCts9eUpUygyinBG/cQz7wnDvJXoguo0K5BZCfkEEj8hg+Xt07Yfc2N8/RM+TR4NMtOuHSb4l+Q70/R2rU82d4QUf00TMDHifVJAa6coWpgRX5DkFFZQ/AdRYelG+e++0nQOD0SFzyKvzVR7v5igeMK766tw+MTR+JIJpRlwRpEDKfDGpayWIau0drlFrJokd9O47wBauK56if4ezCvOo+iilcS8NrrI2h28sXMPJJDq7QkeR7ALG0v9kwJV0R4HW0SwgL32HkOCfvlNuBPQ=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR08MB6646.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(346002)(376002)(366004)(396003)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(66946007)(316002)(110136005)(54906003)(64756008)(66446008)(66476007)(66556008)(76116006)(66899024)(41300700001)(2906002)(5660300002)(7416002)(8676002)(8936002)(4326008)(86362001)(966005)(6486002)(478600001)(71200400001)(6512007)(38070700009)(2616005)(6506007)(36756003)(83380400001)(26005)(122000001)(38100700002);DIR:OUT;SFP:1101;
Content-Type: text/plain; charset="utf-8"
Content-ID: <86F3441BA0BF87488D0A13D75571ECDD@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR08MB7808
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM3PEPF00009B9D.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	ffb53619-15ae-4535-2de1-08dc2d410be3
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	4ybgQc4UPXt0xROjUpYDhmlv0XwGQ3v36Nto7uKyA6vZnNCJN3nJ/1LbpZSp2dHanmBytDF3ghIs7Bo3YesNpz3L9Ul+sJbHAuIKF9VimabtWcmEPBcWv3lZp3Kd7Q8BafAwHFviMWadJRxzWJnR1MqhW9XYPnzXi5IvceTskhmfA4glOMGR/cLbXUSwSjArB10VpmYKKRkXYBAcvR9dPd7zjjGVBOooqZFy8EJxN3nydDmbtl+lXTIqub1OEc3ShLFg4t5vFKneAUq6wY4hHwKLefGlE4X6OGgY06/cxx5G9SPUOIKCI2eOShTAlB1MdriV3kLzhSP8unisebtuo5mW/9NUQeLjbDisyXeZcF0Ubx9nkYqAbT7MJPO7W1emXNLpTUcuXzdpa54F1yBHIw772ptB+BNbONZkbLyEBNonsjIPxKuyO+CgACe7RyJKjt7wKV2+Xlt9P6o4afd7GpXiXT91Jvm+mpsVHmZDlpyzFE2mDjVrfcy+zmEvKEZOoacSMnI3jdHhLdXj9uWIiqsq8J3GMfnWIxaR3IGrJU0tVWpnKREbpAJGvhM4gX0ci6JYWZrIgl3fnIoJGo2mZQ==
X-Forefront-Antispam-Report:
	CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230031)(4636009)(136003)(346002)(39860400002)(396003)(376002)(230922051799003)(82310400011)(64100799003)(186009)(451199024)(1800799012)(46966006)(40470700004)(36840700001)(70206006)(70586007)(54906003)(316002)(110136005)(66899024)(41300700001)(8936002)(5660300002)(2906002)(8676002)(4326008)(450100002)(478600001)(6486002)(966005)(36756003)(6512007)(6506007)(2616005)(82740400003)(336012)(26005)(86362001)(83380400001)(81166007)(356005);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2024 09:41:12.3054
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 08acc0b1-39f9-4372-3468-08dc2d4114bd
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM3PEPF00009B9D.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR08MB7336

SGkgYWxsDQoNCkFwcHJlY2lhdGUgZXZlcnlvbmUgaXMgYnVzeSwgYnV0IGlmIHlvdSBoYXZlIHNv
bWUgdGltZSBJJ2QgYXBwcmVjaWF0ZQ0Kc29tZSBjb21tZW50cywgcGFydGljdWxhcmx5IGFyb3Vu
ZCB3aGV0aGVyIHRoaXMgbWFrZSBzZW5zZSB0byBhcHByb2FjaA0KYXMgYW4gQXJtLW9ubHkgUE1V
IGZlYXR1cmUgb3IgaGFzIHdpZGVyIGFwcGxpY2FiaWxpdHk/DQoNClRoYW5rcw0KQmVuDQoNCg0K
DQoNCk9uIFR1ZSwgMjAyNC0wMS0yMyBhdCAxMTozNCArMDAwMCwgQmVuIEdhaW5leSB3cm90ZToN
Cj4gSSd2ZSBiZWVuIHdvcmtpbmcgb24gYW4gYXBwcm9hY2ggdG8gc3VwcG9ydGluZyBwZXItZnVu
Y3Rpb24gbWV0cmljcw0KPiBmb3INCj4gYWFyY2g2NCBjb3Jlcywgd2hpY2ggcmVxdWlyZXMgc29t
ZSBjaGFuZ2VzIHRvIHRoZSBhcm1fcG11djMgZHJpdmVyLA0KPiBhbmQNCj4gSSdtIHdvbmRlcmlu
ZyBpZiB0aGlzIGFwcHJvYWNoIHdvdWxkIG1ha2Ugc2Vuc2UgYXMgYSBnZW5lcmljIGZlYXR1cmUN
Cj4gdGhhdCBjb3VsZCBiZSB1c2VkIHRvIGVuYWJsZSB0aGUgc2FtZSBvbiBvdGhlciBhcmNoaXRl
Y3R1cmVzPw0KPiANCj4gVGhlIGJhc2ljIGlkZWEgaXMgYXMgZm9sbG93czoNCj4gDQo+IMKgKiBQ
ZXJpb2RpY2FsbHkgc2FtcGxlIG9uZSBvciBtb3JlIGNvdW50ZXJzIGFzIG5lZWRlZCBmb3IgdGhl
IGNob3Nlbg0KPiDCoMKgIHNldCBvZiBtZXRyaWNzLg0KPiDCoCogUmVjb3JkIGEgc2FtcGxlIGNv
dW50IGZvciBlYWNoIHN5bWJvbCBzbyBhcyB0byBpZGVudGlmeSBob3QNCj4gwqDCoCBmdW5jdGlv
bnMuDQo+IMKgKiBBY2N1bXVsYXRlIGNvdW50ZXIgdG90YWxzIGZvciBlYWNoIG9mIHRoZSBjb3Vu
dGVycyBpbiBlYWNoIG9mIHRoZQ0KPiDCoMKgIG1ldHJpY3MgKmJ1dCogb25seSBkbyB0aGlzIHdo
ZXJlIHRoZSBwcmV2aW91cyBzYW1wbGUncyBzeW1ib2wNCj4gwqDCoCBtYXRjaGVzIHRoZSBjdXJy
ZW50IHNhbXBsZSdzIHN5bWJvbC4NCj4gDQo+IERpc2NhcmRpbmcgdGhlIGNvdW50ZXIgZGVsdGFz
IGZvciBhbnkgZ2l2ZW4gc2FtcGxlIGlzIGltcG9ydGFudCB0bw0KPiBlbnN1cmUgdGhhdCBjb3V0
ZXJzIGFyZSBjb3JyZWN0bHkgYXR0cmlidXRlZCB0byBhIHNpbmdsZSBmdW5jdGlvbiwNCj4gd2l0
aG91dCB0aGlzIHN0ZXAgdGhlIHJlc3VsdGluZyBtZXRyaWNzIHRyZW5kIHRvd2FyZHMgc29tZSBh
dmVyYWdlDQo+IHZhbHVlIGFjcm9zcyB0aGUgdG9wICduJyBmdW5jdGlvbnMuIEl0IGlzIGFja25v
d2xlZGdlZCB0aGF0IGl0IGlzDQo+IHBvc3NpYmxlIGZvciB0aGlzIGhldXJpc3RpYyB0byBmYWls
LCBmb3IgZXhhbXBsZSBpZiBzYW1wbGVzIHRvIGxhbmQNCj4gZWl0aGVyIHNpZGUgb2YgYSBuZXN0
ZWQgY2FsbCwgc28gYSBzdWZmaWNpZW50bHkgc21hbGwgc2FtcGxlIHdpbmRvdw0KPiBvdmVyIHdo
aWNoIHRoZSBjb3VudGVycyBhcmUgY29sbGVjdGVkIG11c3QgYmUgdXNlZCB0byByZWR1Y2UgdGhl
IHJpc2sNCj4gb2YgbWlzYXR0cmlidXRpb24uDQo+IA0KPiBTbyBmYXIsIHRoaXMgY2FuIGJlIGFj
aGVpdmVkIHdpdGhvdXQgYW55IGZ1cnRoZXIgbW9kaWZpY2F0aW9ucyB0bw0KPiBwZXJmDQo+IHRv
b2xzIG9yIHRoZSBrZXJuZWwuIEhvd2V2ZXIgYXMgbm90ZWQgaXQgcmVxdWlyZXMgdGhlIGNvdW50
ZXINCj4gY29sbGVjdGlvbiB3aW5kb3cgdG8gYmUgc3VmZmljaWVudGx5IHNtYWxsOyBpbiB0ZXN0
aW5nIG9uDQo+IE5lb3ZlcnNlLU4xLy1WMSwgYSB3aW5kb3cgb2YgYWJvdXQgMzAwIGN5Y2xlcyBn
aXZlcyBnb29kIHJlc3VsdHMuDQo+IFVzaW5nDQo+IHRoZSBjeWNsZSBjb3VudGVyIHdpdGggYSBz
YW1wbGVfcGVyaW9kIG9mIDMwMCBpcyBwb3NzaWJsZSwgYnV0IHN1Y2gNCj4gYW4NCj4gYXBwcm9h
Y2ggZ2VuZXJhdGVzIHNpZ25pZmljYW50IGFtb3VudHMgb2YgY2FwdHVyZSBkYXRhLCBhbmQNCj4g
aW50cm9kdWNlcw0KPiBhIGxvdCBvZiBvdmVyaGVhZCBhbmQgcHJvYmUgZWZmZWN0LiBXaGlsc3Qg
dGhlIGtlcm5lbCB3aWxsIHRocm90dGxlDQo+IHN1Y2ggYSBjb25maWd1cmF0aW9uLCB3aGljaCBo
ZWxwcyB0byBtaXRpZ2F0ZSBhIGxhcmdlIHBvcnRpb24gb2YgdGhlDQo+IGJhbmR3aWR0aCBhbmQg
Y2FwdHVyZSBvdmVyaGVhZCwgaXQgaXMgbm90IHNvbWV0aGluZyB0aGF0IGNhbiBiZQ0KPiBjb250
cm9sbGVkIGZvciBvbiBhIHBlciBldmVudCBiYXNpcywgb3IgZm9yIG5vbi1yb290IHVzZXJzLCBh
bmQNCj4gYmVjYXVzZQ0KPiB0aHJvdHRsaW5nIGlzIGNvbnRyb2xsZWQgYXMgYSBwZXJjZW50YWdl
IG9mIHRpbWUgaXRzIGFmZmVjdHMgdmFyeQ0KPiBmcm9tDQo+IG1hY2hpbmUgdG8gbWFjaGluZS4N
Cj4gDQo+IEZvciB0aGlzIHRvIHdvcmsgZWZmaWNpZW50bHksIGl0IGlzIHVzZWZ1bCB0byBwcm92
aWRlIGEgbWVhbnMgdG8NCj4gZGVjb3VwbGUgdGhlIHNhbXBsZSB3aW5kb3cgKHRpbWUgb3ZlciB3
aGljaCBldmVudHMgYXJlIGNvdW50ZWQpIGZyb20NCj4gdGhlIHNhbXBsZSBwZXJpb2QgKHRpbWUg
YmV0d2VlbiBpbnRlcmVzdGluZyBzYW1wbGVzKS4gVGhpcyBwYXRjaGVzZXQNCj4gbW9kaWZpZXMg
dGhlIEFybSBQTVUgZHJpdmVyIHRvIHN1cHBvcnQgYWx0ZXJuYXRpbmcgYmV0d2VlbiB0d28NCj4g
c2FtcGxlX3BlcmlvZCB2YWx1ZXMsIHByb3ZpZGluZyBhIHNpbXBsZSBhbmQgaW5leHBlbnNpdmUg
d2F5IGZvcg0KPiB0b29scw0KPiB0byBzZXBhcmF0ZSBvdXQgdGhlIHNhbXBsZSBwZXJpb2QgYW5k
IHRoZSBzYW1wbGUgd2luZG93LiBJdCBpcw0KPiBleHBlY3RlZA0KPiB0byBiZSB1c2VkIHdpdGgg
dGhlIGN5Y2xlIGNvdW50ZXIgZXZlbnQsIGFsdGVybmF0aW5nIGJldHdlZW4gYSBsb25nDQo+IGFu
ZA0KPiBzaG9ydCBwZXJpb2QgYW5kIHN1YnNlcXVlbnRseSBkaXNjYXJkaW5nIHRoZSBjb3VudGVy
IGRhdGEgZm9yIHNhbXBsZXMNCj4gd2l0aCB0aGUgbG9uZyBwZXJpb2QuIFRoZSBjb21iaW5lZCBs
b25nIGFuZCBzaG9ydCBwZXJpb2QgZ2l2ZXMgdGhlDQo+IG92ZXJhbGwgc2FtcGxpbmcgcGVyaW9k
LCBhbmQgdGhlIHNob3J0IHNhbXBsZSBwZXJpb2QgZ2l2ZXMgdGhlIHNhbXBsZQ0KPiB3aW5kb3cu
IFRoZSBzeW1ib2wgdGFrZW4gZnJvbSB0aGUgc2FtcGxlIGF0IHRoZSBlbmQgb2YgdGhlIGxvbmcN
Cj4gcGVyaW9kDQo+IGNhbiBiZSB1c2VkIGJ5IHRvb2xzIHRvIGVuc3VyZSBjb3JyZWN0IGF0dHJp
YnV0aW9uIGFzIGRlc2NyaWJlZA0KPiBwcmV2aW91c2x5LiBUaGUgY3ljbGUgY291bnRlciBpcyBy
ZWNvbW1lbmRlZCBhcyBpdCBwcm92aWRlcyBmYWlyDQo+IHRlbXBvcmFsIGRpc3RyaWJ1dGlvbiBv
ZiBzYW1wbGVzIGFzIHdvdWxkIGJlIHJlcXVpcmVkIGZvciB0aGUNCj4gcGVyLXN5bWJvbCBzYW1w
bGUgY291bnQgbWVudGlvbmVkIHByZXZpb3VzbHksIGFuZCBiZWNhdXNlIHRoZSBQTVUgY2FuDQo+
IGJlIHByb2dyYW1tZWQgdG8gb3ZlcmZsb3cgYWZ0ZXIgYSBzdWZmaWNpZW50bHkgc2hvcnQgd2lu
ZG93OyB0aGlzIG1heQ0KPiBub3QgYmUgcG9zc2libGUgd2l0aCBzb2Z0d2FyZSB0aW1lciAoZm9y
IGV4YW1wbGUpLiBUaGlzIHBhdGNoIGRvZXMNCj4gbm90DQo+IHJlc3RyaWN0IHRvIG9ubHkgdGhl
IGN5Y2xlIGNvdW50ZXIsIGl0IGlzIHBvc3NpYmxlIHRoZXJlIGNvdWxkIGJlDQo+IG90aGVyDQo+
IG5vdmVsIHVzZXMgYmFzZWQgb24gZGlmZmVyZW50IGV2ZW50cy4NCj4gDQo+IFRvIHRlc3QgdGhp
cyBJIGhhdmUgZGV2ZWxvcGVkIGEgc2ltcGxlIGBwZXJmIHNjcmlwdGAgYmFzZWQgcHl0aG9uDQo+
IHNjcmlwdC4gRm9yIGEgbGltaXRlZCBzZXQgb2YgQXJtIFBNVSBldmVudHMgaXQgd2lsbCBwb3N0
IHByb2Nlc3MgYQ0KPiBgcGVyZiByZWNvcmRgLWluZyBhbmQgZ2VuZXJhdGUgYSB0YWJsZSBvZiBt
ZXRyaWNzLiBBbG9uZyBzaWRlIHRoaXMgSQ0KPiBoYXZlIGRldmVsb3BlZCBhIGJlbmNobWFyayBh
cHBsaWNhdGlvbiB0aGF0IHJvdGF0ZXMgdGhyb3VnaCBhDQo+IHNlcXVlbmNlDQo+IG9mIGRpZmZl
cmVudCBjbGFzc2VzIG9mIGJlaGF2aW91ciB0aGF0IGNhbiBiZSBkZXRlY3RlZCBieSB0aGUgQXJt
IFBNVQ0KPiAoZWcuIG1pc3ByZWRpY3MsIGNhY2hlIG1pc3NlcywgZGlmZmVyZW50IGluc3RydWN0
aW9uIG1peGVzKS4gVGhlIHBhdGgNCj4gdGhyb3VnaCB0aGUgYmVuY2htYXJrIGNhbiBiZSByb3Rh
dGVkIGFmdGVyIGVhY2ggaXRlcmF0aW9uIHNvIGFzIHRvDQo+IGVuc3VyZSB0aGUgcmVzdWx0cyBk
b24ndCBsYW5kIG9uIHNvbWUgbHVja3kgaGFybW9uaWMgd2l0aCB0aGUgc2FtcGxlDQo+IHBlcmlv
ZC4gVGhlIHNjcmlwdCBjYW4gYmUgdXNlZCB3aXRoIGFuZCB3aXRob3V0IHRoZSBzdHJvYmluZyBw
YXRjaA0KPiBhbGxvd2luZyBjb21wYXJpc29uIG9mIHRoZSByZXN1bHRzLiBUZXN0aW5nIHdhcyBv
biBKdW5vIChBNTMrQTU3KSwgDQo+IE4xU0RQLCBHcmF2YXRvbiAyIGFuZCAzLiBJbiBhZGRpdGlv
biB0aGlzIGFwcHJvYWNoIGhhcyBiZWVuIGFwcGxpZWQNCj4gdG8NCj4gYSBmZXcgb2YgQXJtJ3Mg
dG9vbHMgcHJvamVjdHMgYW5kIGhhcyBjb3JyZWN0bHkgaWRlbnRpZmllZA0KPiBpbXByb3ZlbWVu
dHMNCj4gYW5kIHJlZ3Jlc3Npb25zLiANCj4gDQo+IEhlYWRsaW5lIHJlc3VsdHMgZnJvbSB0ZXN0
aW5nIGluZGljYXRlIHRoYXQgfjMwMCBjeWNsZXMgc2FtcGxlIHdpbmRvdw0KPiBnaXZlcyBnb29k
IHJlc3VsdHMgd2l0aCBvciB3aXRob3V0IHRoZSBzdHJvYmluZyBwYXRjaC4gV2hlbiB0aGUNCj4g
c3Ryb2JpbmcgcGF0Y2ggaXMgdXNlZCwgdGhlIHJlc3VsdGluZyBgcGVyZi5kYXRhYCBmaWxlcyBh
cmUgdHlwaWNhbGx5DQo+IDI1LTUweCBzbWFsbGVyIHRoYXQgd2l0aG91dCwgYW5kIHRha2UgfjI1
eCBsZXNzIHRpbWUgZm9yIHRoZSBweXRob24NCj4gc2NyaXB0IHRvIHBvc3QtcHJvY2Vzcy4gV2l0
aG91dCBzdHJvYmluZywgdGhlIHRlc3QgYXBwbGljYXRpb24ncw0KPiBydW50aW1lIHdhcyB4MjAg
c2xvd2VyIHdoZW4gc2FtcGxpbmcgZXZlcnkgMzAwIGN5Y2xlcyBhcyBjb21wYXJlZCB0bw0KPiBl
dmVyeSAxMDAwMDAwIGN5Y2xlcy4gV2l0aCBzdHJvYmluZyBlbmFibGVkIHN1Y2ggdGhhdCB0aGUg
bG9uZyBwZXJpb2QNCj4gd2FzIDk5OTcwMCBjeWNsZXMgYW5kIHRoZSBzaG9ydCBwZXJpb2Qgd2Fz
IDMwMCBjeWNsZXMsIHRoZSB0ZXN0DQo+IGFwcGxpY2F0aW9ucyBydW50aW1lIHdhcyBvbmx5IHgx
LjIgc2xvd2VyIHRoYW4gZXZlcnkgMTAwMDAwMCBjeWNsZXMuDQo+IE5vdGFibHksIHdpdGhvdXQg
dGhlIHBhdGNoLCBMMUQgY2FjaGUgbWlzcyByYXRlcyBhcmUgc2lnbmlmaWNhbnRseQ0KPiBoaWdo
ZXIgdGhhbiB3aXRoIHRoZSBwYXRjaCwgd2hpY2ggd2UgYXR0cmlidXRlIHRvIGluY3JlYXNlZCBp
bXBhY3Qgb24NCj4gdGhlIGNhY2hlIHRoYXQgdHJhcHBpbmcgaW50byB0aGUga2VybmVsIGV2ZXJ5
IDMwMCBjeWNsZXMgaGFzLiBUaGVzZQ0KPiByZXN1bHRzIGFyZSBnaXZlbiB3aXRoIGBwZXJmX2Nw
dV90aW1lX21heF9wZXJjZW50PTI1YC4gV2hlbiB0ZXN0ZWQNCj4gd2l0aCBgcGVyZl9jcHVfdGlt
ZV9tYXhfcGVyY2VudD0xMDBgIHRoZSBzaXplIGFuZCB0aW1lIGNvbXBhcmlzb25zDQo+IGFyZQ0K
PiBtb3JlIHNpZ25pZmljYW50LiBEaXNhYmxpbmcgdGhyb3R0bGluZyBkaWQgbm90IGxlYWQgdG8g
b2J2aW91cw0KPiBpbXByb3ZlbWVudHMgaW4gdGhlIGNvbGxlY3RlZCBtZXRyaWNzLCBzdWdnZXN0
aW5nIHRoYXQgdGhlIHNhbXBsaW5nDQo+IGFwcHJvYWNoIGlzIHN1ZmZpY2llbnQgdG8gY29sbGVj
dCByZXByZXNlbnRhdGl2ZSBtZXRyaWNzLg0KPiANCj4gQ3Vyc29yeSB0ZXN0aW5nIG9uIGEgWGVv
bihSKSBXLTIxNDUgc2FtcGxpbmcgZXZlcnkgMzAwIGN5Y2xlcw0KPiAod2l0aG91dA0KPiB0aGUg
cGF0Y2gpIHN1Z2dlc3RzIHRoaXMgYXBwcm9hY2ggd291bGQgd29yayBmb3Igc29tZSBjb3VudGVy
cy4NCj4gQ2FsY3VsYXRpbmcgYnJhbmNoIG1pc3MgcmF0ZXMgZm9yIGV4YW1wbGUgYXBwZWFycyB0
byBiZSBjb3JyZWN0LA0KPiBsaWtld2lzZSBVT1BTX0VYRUNVVEVELlRIUkVBRCBzZWVtcyB0byBn
aXZlIHNvbWV0aGluZyBsaWtlIGEgc2Vuc2libGUNCj4gY3ljbGVzLXBlci11b3AgdmFsdWUuIE9u
IHRoZSBvdGhlciBoYW5kIHRoZSBmaXhlZCBmdW5jdGlvbg0KPiBpbnN0cnVjdGlvbnMNCj4gY291
bnRlciBkb2VzIG5vdCBhcHBlYXIgdG8gc2FtcGxlIGNvcnJlY3RseSAoaXQgc2VlbXMgdG8gcmVw
b3J0DQo+IGVpdGhlcg0KPiB2ZXJ5IHNtYWxsIG9yIHZlcnkgbGFyZ2UgbnVtYmVycykuIE5vIGlk
ZWEgd2hhdHMgZ29pbmcgb24gdGhlcmUsIHNvDQo+IGFueQ0KPiBpbnNpZ2h0IHdlbGNvbWUuLi4N
Cj4gDQo+IFRoaXMgcGF0Y2ggbW9kaWZpZXMgdGhlIGFybV9wbXUgYW5kIGludHJvZHVjZXMgYW4g
YWRkaXRpb25hbCBmaWVsZCBpbg0KPiBjb25maWcyIHRvIGNvbmZpZ3VyZSB0aGUgYmVoYXZpb3Vy
LiBJZiB3ZSB0aGluayB0aGVyZSBpcyBicm9hZA0KPiBhcHBsaWNhYmlsaXR5LCB3b3VsZCBpdCBt
YWtlIHNlbnNlIHRvIG1vdmUgaW50byBwZXJmX2V2ZW50X2F0dHIgZmxhZ3MNCj4gb3IgZmllbGQs
IGFuZCBwb3NzaWJseSBwdWxsIHVwIGludG8gY29yZT8gSWYgd2UgZG9uJ3QgdGhpbmsgc28sIHRo
ZW4NCj4gc29tZSBmZWVkYmFjayBhcm91bmQgdGhlIGNvcmUgaGVhZGVyIGFuZCBhcm1fcG11IG1v
ZGlmaWNhdGlvbnMgd291bGQNCj4gYmUgYXBwcmVjaWF0ZWQuDQo+IA0KPiBBIGNvcHkgb2YgdGhl
IHBvc3QtcHJvY2Vzc2luZyBzY3JpcHQgaXMgYXZhaWxhYmxlIGF0IA0KPiBodHRwczovL2dpdGh1
Yi5jb20vQVJNLQ0KPiBzb2Z0d2FyZS9nYXRvci9ibG9iL3Byb3RvdHlwZXMvc3Ryb2JpbmcvcHJv
dG90eXBlcy9zdHJvYmluZy0NCj4gcGF0Y2hlcy90ZXN0LXNjcmlwdC9nZW5lcmF0ZS1mdW5jdGlv
bi1tZXRyaWNzLnB5DQo+IG5vdGUgdGhhdCB0aGUgc2NyaXB0IGl0cyBzZWxmIGhhcyBhIGRlcGVu
ZGVuY3kgb24NCj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgtcGVyZi11c2Vycy8yMDI0
MDEyMzEwMzEzNy4xODkwNzc5LTEtDQo+IGJlbi5nYWluZXlAYXJtLmNvbS8NCj4gDQo+IA0KPiBC
ZW4gR2FpbmV5ICgyKToNCj4gwqAgYXJtX3BtdTogQWxsb3cgdGhlIFBNVSB0byBhbHRlcm5hdGUg
YmV0d2VlbiB0d28gc2FtcGxlX3BlcmlvZA0KPiB2YWx1ZXMuDQo+IMKgIGFybV9wbXV2MzogQWRk
IGNvbmZpZyBiaXRzIGZvciBzYW1wbGUgcGVyaW9kIHN0cm9iaW5nDQo+IA0KPiDCoGRyaXZlcnMv
cGVyZi9hcm1fcG11LmPCoMKgwqDCoMKgwqAgfCA3NCArKysrKysrKysrKysrKysrKysrKysrKysr
KysrKy0tLS0tDQo+IC0tDQo+IMKgZHJpdmVycy9wZXJmL2FybV9wbXV2My5jwqDCoMKgwqAgfCAy
NSArKysrKysrKysrKysNCj4gwqBpbmNsdWRlL2xpbnV4L3BlcmYvYXJtX3BtdS5oIHzCoCAxICsN
Cj4gwqBpbmNsdWRlL2xpbnV4L3BlcmZfZXZlbnQuaMKgwqAgfCAxMCArKysrLQ0KPiDCoDQgZmls
ZXMgY2hhbmdlZCwgOTUgaW5zZXJ0aW9ucygrKSwgMTUgZGVsZXRpb25zKC0pDQo+IA0KDQo=

