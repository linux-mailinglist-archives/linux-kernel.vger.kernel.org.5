Return-Path: <linux-kernel+bounces-127218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 03025894845
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 02:13:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6F465B21F5B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 00:13:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5558E556;
	Tue,  2 Apr 2024 00:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=garmin.com header.i=@garmin.com header.b="lSwN5YDN";
	dkim=pass (2048-bit key) header.d=garmin.com header.i=@garmin.com header.b="htZ0hujm"
Received: from mx0b-000eb902.pphosted.com (mx0b-000eb902.pphosted.com [205.220.177.212])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FF9510E4;
	Tue,  2 Apr 2024 00:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.212
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712016776; cv=fail; b=psbwAgbI5WZYKtA1OL0C+XxS7bBrEX6BOhr5N2/cbnfqxEQ6o2MpayZak2CZVJWtxI7VrDY8//bY3MF86bUuQ5fVGYJFagO/iy/XDKT7sv2nhP0hKv693SPYJbAKjwIADlNLtBlWj6UJ4bAV5ATyJNi96wY0HnEVZFQXlCceGy8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712016776; c=relaxed/simple;
	bh=0KY8WUPQ5/njZz42Rr5DucHs0Y/+IKCbQV8ShgaJ2NE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=aBMOqHsl3bNCnpOi0ZJfymLFwadHRporpwiUy43IL2te9fGrN56qAl/CQsbEZ723acFuRzGspCjrUu2WpBg6z7y0Tj2hxrjYMq5iOacqMyDW5Z4Lv6JRKY0b1+LCz8Aio/+Q/ymps9Z3ElhUMEAN890Nhgn5GkiDoJ71aXxq3Uk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=garmin.com; spf=pass smtp.mailfrom=garmin.com; dkim=pass (2048-bit key) header.d=garmin.com header.i=@garmin.com header.b=lSwN5YDN; dkim=pass (2048-bit key) header.d=garmin.com header.i=@garmin.com header.b=htZ0hujm; arc=fail smtp.client-ip=205.220.177.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=garmin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garmin.com
Received: from pps.filterd (m0220298.ppops.net [127.0.0.1])
	by mx0a-000eb902.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 431J09KU001847;
	Mon, 1 Apr 2024 19:12:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garmin.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=pps1; bh=2F6GRq8z7beR
	ghwKokkmfCAMQOkAUXVV66t4OmNExWs=; b=lSwN5YDNqVURUnqrIsGpL5cNAtGi
	5Sn7WU55tIEQuygLf5Tx+PI1f8k587v5KAtd9TbHPToMThbLBco9VqS/gn2AAiTa
	aaUMoXzb9ybwlN6KH1SaT/6tbnuMQTVNNoeI7MjyxW6KwMsGpJGJz4dQ72Ozi2P+
	ROg4h7TFC29t7dsDuDbbQF6SQYkjUHDxz6K8XCyF68l9/8kIeFgCur0ux22D3dD7
	sRbfeqvkPL3LQRKXU9hh5ngDfyXL2ahpvBbZnFsFKKQyungmUYNX7D2q2HIMpid+
	O6gawZAfj2PKbqXtWnHcXV6RKqMPx+T1jLD8T0k5dvUSsadDvYbzS47eGQ==
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2040.outbound.protection.outlook.com [104.47.56.40])
	by mx0a-000eb902.pphosted.com (PPS) with ESMTPS id 3x7st3jbtv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Apr 2024 19:12:14 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DdaRVLPaSPw0DxB0Q6Ccdl7GyhRbFKoX9okR8aqbd5B/OwG04dSietxqZ9huRDQjQh8RZE+A7GW6ZENwkgVMV6JFP4BMDOhR08K43BE0S6irxBuFNR7VTieg3IStWLcFCbBlf+kvvn/DB2n0fsAvEo7epsitXX2ochomDDFuA3mVEtU3mLMHOlxBJ3BblRZv8txldzCmweSPSmt+TfDvd1GmlgPz8YaRnjoW2fZ8y2clTsGubN7s6NGYs/kZ50ecZZ5Z0mjE9Zvi6mQF63pZPx16mQp99wX+NWpNUeoi/p9d0vvv8jFv1KjFNTWrWv5FaY4nTDKsP60xilPN1xmDrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2F6GRq8z7beRghwKokkmfCAMQOkAUXVV66t4OmNExWs=;
 b=AwnvUjlj1xNvdJhGeNR/UI9L1h9lWh5DwPPI5akucSXCQRTFrUwi+Upokd1A7AUeitLIJRZSGRpar7NeoUBrrmtutzgc5l2Uj1B4jr1qek3KUx3W/rKs6t4qeVd9mr/HX6vXiplS2zSR/S3/EoIu8iV1OJ5dopjqbGnaVVp+xeZt36qmxr6TnGGWaOKYabXXfgRg6ex2JH/LTI9R7P0wJNMeyU4oPSZkg3sFXoN5v5CWvQG7GssPI4iesoxSODFZHkzt3Gqkr2osCN8xL1/ppIwjo+Xbz8bZe6i1BbvWfXeA0O1eNkxKUugyuQSMwmuRKI73qZKGbt+Ep4AOAu4Epg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 204.77.163.244) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=garmin.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=garmin.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garmin.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2F6GRq8z7beRghwKokkmfCAMQOkAUXVV66t4OmNExWs=;
 b=htZ0hujmaqaLLDg5x5OP28sr+8BgMiQ1JldHzSRe1cYosIkmaw2gU/VHuh6fgyb6SxeqYwVKz5WReELz1lofIvYWrYMktIqWYCBAlqjdxiXuo3VmTgpr9WJiizn/+tlY2jGA5SCaI9HGBzOiogocqrwRQCHRQ5ohTRJFLTXhoHf/A6m0w0ByMLwygQgMG/MDJIOG1YvB0AGOpPLy5wkBjzuudNrbQ5oEzd1GsxWwfF11Cii84ZhflMbcM8VHLSjoF4h/Cp9IT+Fey7EX7wFtiw0muiA5NZoikd1h5ovHAWk8hYD8sx5JYCC+CUT98IEv8AaZc4fR5g1A8ZF2nmqKxQ==
Received: from BY3PR03CA0006.namprd03.prod.outlook.com (2603:10b6:a03:39a::11)
 by BY5PR04MB6978.namprd04.prod.outlook.com (2603:10b6:a03:220::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 2 Apr
 2024 00:12:12 +0000
Received: from SJ5PEPF000001CB.namprd05.prod.outlook.com
 (2603:10b6:a03:39a:cafe::87) by BY3PR03CA0006.outlook.office365.com
 (2603:10b6:a03:39a::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46 via Frontend
 Transport; Tue, 2 Apr 2024 00:12:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 204.77.163.244)
 smtp.mailfrom=garmin.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=garmin.com;
Received-SPF: Pass (protection.outlook.com: domain of garmin.com designates
 204.77.163.244 as permitted sender) receiver=protection.outlook.com;
 client-ip=204.77.163.244; helo=edgetransport.garmin.com; pr=C
Received: from edgetransport.garmin.com (204.77.163.244) by
 SJ5PEPF000001CB.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.22 via Frontend Transport; Tue, 2 Apr 2024 00:12:11 +0000
Received: from cv1wpa-exmb3.ad.garmin.com (10.5.144.73) by
 olawpa-edge5.garmin.com (10.60.4.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Mon, 1 Apr 2024 19:12:03 -0500
Received: from cv1wpa-exmb5.ad.garmin.com (10.5.144.75) by
 cv1wpa-exmb3.ad.garmin.com (10.5.144.73) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.37; Mon, 1 Apr 2024 19:12:11 -0500
Received: from kc3wpa-exmb3.ad.garmin.com (10.65.32.83) by
 cv1wpa-exmb5.ad.garmin.com (10.5.144.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.32; Mon, 1 Apr 2024 19:12:10 -0500
Received: from CAR-4RCMR33.ad.garmin.com (10.5.209.17) by mail.garmin.com
 (10.65.32.83) with Microsoft SMTP Server id 15.2.1258.32 via Frontend
 Transport; Mon, 1 Apr 2024 19:12:10 -0500
From: Joseph Huang <Joseph.Huang@garmin.com>
To: <netdev@vger.kernel.org>
CC: Joseph Huang <Joseph.Huang@garmin.com>, Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, "Roopa
 Prabhu" <roopa@nvidia.com>,
        Nikolay Aleksandrov <razor@blackwall.org>,
        =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>,
        <linux-kernel@vger.kernel.org>, <bridge@lists.linux.dev>
Subject: [PATCH RFC net-next 00/10] MC Flood disable and snooping
Date: Mon, 1 Apr 2024 20:10:59 -0400
Message-ID: <20240402001137.2980589-1-Joseph.Huang@garmin.com>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CB:EE_|BY5PR04MB6978:EE_
X-MS-Office365-Filtering-Correlation-Id: bdbcba8e-1416-4f5f-4ca1-08dc52a98b45
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	P1MfPhxRxEpAcu5phYF58jcN63bV/P0vqz50T6DTNugHfunTr6mnjV+WTIH2lPQJvmIyTg2OTEptGkVte+1rCUxjNX+NYGMCwrQFTYhianPrP3OH9USFTH8oiVdrzyEQFDpgzvRkSgPzL5oaBQvCE6m+TFpjmTfJRaugNbk96NnX1oaEBteOaOkQNr+25QKuPq0LQVrnoyrYNdvtulPge9oBrOnXAYOtx/11vsVX7enmjQwtsj72YcsY1B8M+tnpNk2+VOzLYDWYm/I7iinHkfQwsgFQRalIZCPZvgLjx7PHyixfPo9VlfqGFgIbvp5K18DmjSLNBelBY95i38TKziOU4m+Ix8sFPd60IJoFu44YR8j7p4tzf5BCaCkg12Lo+RwYVk2BbZcrzC3MyWHGHy2GXUHNWoX0eD1eg61TIY1b/zJiMXujwhCLKvecl29gJ6yU2XcA+XnKOCG9In1Kk5aUH5dHqllnsvk1rM8ZR4L9Xq1fwpJvEaYb9YLijGMOidGhXVUkCfWvstyTMnLDX+htaCJyKbk4fcgLQN1P0MbRK03Iwm6u5O9bCIZMd9RdRwDu4jnl+MBXmDA9Zra8ZlcRkQllcHxNpYrcBlBa7NuAcnCrpADaP/KpX7KnhkKH8Oj/YmDYmFw97dIjyf3jB4yMXTqwrK6qGBRPSTDiQTWqtVDXWldwRh34OlmoGpHZTBLd5OUAB2+0IiPRM/hpGQ==
X-Forefront-Antispam-Report: 
	CIP:204.77.163.244;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:edgetransport.garmin.com;PTR:extedge.garmin.com;CAT:NONE;SFS:(13230031)(36860700004)(82310400014)(376005)(7416005)(1800799015);DIR:OUT;SFP:1102;
X-OriginatorOrg: garmin.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2024 00:12:11.7886
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bdbcba8e-1416-4f5f-4ca1-08dc52a98b45
X-MS-Exchange-CrossTenant-Id: 38d0d425-ba52-4c0a-a03e-2a65c8e82e2d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38d0d425-ba52-4c0a-a03e-2a65c8e82e2d;Ip=[204.77.163.244];Helo=[edgetransport.garmin.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	SJ5PEPF000001CB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6978
X-Proofpoint-GUID: 9L95mypQc4ZMl3pyBenU3YkYEwRlhqUM
X-Proofpoint-ORIG-GUID: 9L95mypQc4ZMl3pyBenU3YkYEwRlhqUM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-01_16,2024-04-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 clxscore=1011 spamscore=0
 mlxscore=0 impostorscore=0 suspectscore=0 mlxlogscore=999
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403210001 definitions=main-2404010168

There is a use case where one would like to enable multicast snooping
on a bridge but disable multicast flooding on all bridge ports so that
registered multicast traffic will only reach the intended recipients and
unregistered multicast traffic will be dropped. However, with existing
bridge ports' mcast_flood flag implementation, it doesn't work as desired.

This patchset aims to make multicast snooping work even when multicast
flooding is disabled on the bridge ports, without changing the semantic of
the mcast_flood flag too much. Patches 1 to 4 attempt to address this issue.

Also, in a network where more than one multicast snooping capable bridges
are interconnected without multicast routers being present, multicast
snooping fails if:

  1. The source is not directly attached to the Querier
  2. The listener is beyond the mrouter port of the bridge where the
     source is directly attached
  3. A hardware offloading switch is involved

When all of the conditions are met, the listener will not receive any
multicast packets from the source. Patches 5 to 10 attempt to address this
issue. Specifically, patches 5 to 8 set up the infrastructure, patch 9
handles unregistered multicast packets forwarding, and patch 10 handles
registered multicast packets forwarding to the mrouter port.

The patches were developed against 5.15, and forward-ported to 6.8.
Tests were done on a Pi 4B + Marvell 6393X Eval board with a single
switch chip with no VLAN.

V1 -> V2:
- Moved the bulk of the change from the bridge to the mv88e6xxx driver.
- Added more patches (specifically 3 and 4) to workaround some more
  issues with multicast flooding being disabled.

v1 here:
https://patchwork.kernel.org/project/netdevbpf/cover/20210504182259.5042-1-Joseph.Huang@garmin.com/


Joseph Huang (10):
  net: bridge: Flood Queries even when mc flood is disabled
  net: bridge: Always multicast_flood Reports
  net: bridge: Always flood local subnet mc packets
  net: dsa: mv88e6xxx: Add all hosts mc addr to ATU
  net: dsa: Add support for PORT_MROUTER attribute
  net: dsa: mv88e6xxx: Track soft bridge objects
  net: dsa: mv88e6xxx: Track bridge mdb objects
  net: dsa: mv88e6xxx: Convert MAB to use bit flags
  net: dsa: mv88e6xxx: Enable mc flood for mrouter port
  net: dsa: mv88e6xxx: Offload mrouter port

 drivers/net/dsa/mv88e6xxx/Kconfig       |  12 +
 drivers/net/dsa/mv88e6xxx/chip.c        | 439 +++++++++++++++++++++++-
 drivers/net/dsa/mv88e6xxx/chip.h        |  16 +-
 drivers/net/dsa/mv88e6xxx/global1_atu.c |   3 +-
 include/net/dsa.h                       |   2 +
 net/bridge/br_device.c                  |   5 +-
 net/bridge/br_forward.c                 |   3 +-
 net/bridge/br_input.c                   |   5 +-
 net/bridge/br_multicast.c               |  21 +-
 net/bridge/br_private.h                 |   6 +
 net/dsa/port.c                          |  11 +
 net/dsa/port.h                          |   2 +
 net/dsa/user.c                          |   6 +
 13 files changed, 502 insertions(+), 29 deletions(-)

-- 
2.17.1


