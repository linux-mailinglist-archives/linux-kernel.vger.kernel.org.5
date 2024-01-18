Return-Path: <linux-kernel+bounces-29717-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 325C0831254
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 06:22:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C71ECB2321C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 05:22:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38C6F8F4F;
	Thu, 18 Jan 2024 05:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="iJvo62KA"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2064.outbound.protection.outlook.com [40.107.117.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FB7753A8;
	Thu, 18 Jan 2024 05:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705555351; cv=fail; b=KLhcLkWvtKKLh+yelhW2B0nuBTD00aJlict0pq6dIZyjnubwHUUajT5+rLgMfw8YBbAUWHXQf8aIUPGZthg7teL/TIIXtPyeoXiMFjrVc1OZp3tL9IMpaVhQ9CRYOKOrpb3BiNaUGBaQVjvuEAw0+jUGQMq6VojfHo7M85m0JC0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705555351; c=relaxed/simple;
	bh=iBeygL9hk7iSNyr50yFQ98ozkkcOtBhgdMMORRfhoYc=;
	h=ARC-Message-Signature:ARC-Authentication-Results:DKIM-Signature:
	 Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-EOPAttributedMessage:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:Content-Type:
	 X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped; b=f8xwSQrOujYGrk+N62BjR4Bl4E8c1OUFuw7XV4tgka7v2nrrZ6z0WUC9BlPOWBVKY4rf5jppBly1G/fKpNqWlx3UJrLPxb8J9Gm1dyLV8iS3bbEMbsw1AmRC4AcQePFsZMjH7crej4lRrNw9AikBVUum8PyQqVLG4EHnFIUkxWs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=iJvo62KA; arc=fail smtp.client-ip=40.107.117.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hizz01/m0guGbMq5g+OJSftneRPZ7lyqGh5A/OjXys84L9/hC0UQr+RQn0P0tFVeTuSbvrFA8QBnKARUZJLp1KqVOmRfd/FCI+T+YcvSrFSORU/jDX5gCF5EqOz+UpeYa9qOUC+HLbvEjQF3niA7EVyVMLvirlW+/XPlceOa71hUrtpIYE5TPrlQo1KkfjazGnfW4tzdotg8gbLXpfghj6QUNTf/7DTvGAo87qnhH8GUHYTKp+kqU6reTDG0vUQGOC9ClEG3xBgqvSY3gfrwnw9HApFE3TSop68X8GFsi05szna0WbCDTPL3/53QebDqkKcMZJ2tV84Uf35Vm61sFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MS5PSOJsuj2MzX08hFUsBUhDuZi4V4KWE+DnawiBK08=;
 b=a+okxdtc4X3Um/RH4LKAnpeEo37g4iHw2tvK5P/YRyYwZ7yq9/2WPwCBpTciS5BIk5bAcbK4hcyyZr1ANeK8Rss2jRVy5Y7aW7JLwM95E5rd6vTwUbXmBAAb5d0/aI+7yKEZcWm6NLFf17sHzo3liHNqWnnJhhpMZJSInqVZUdAG1QE6qjyGGzs1xoI+PS0EczYGSV3y8fOhsj/Fwgmd/+DAu+b8S/+VTg47BVW0A0DUgtDjj9nD6LjOpNBDDvwl4Nb14cB3XVKvzF1n+HSGAOP7xxHpASRGnKGgyhy5G/oTyWR5f10J9m5lmZyANtq2fagjOyymOUqyrbqBaJjNdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MS5PSOJsuj2MzX08hFUsBUhDuZi4V4KWE+DnawiBK08=;
 b=iJvo62KAA+HBSyRN8XMdLcVyMSY4xpPqtg+dK41g8cwN30l9MAdR6QWrUOxVkUe6JjZcpub4lSBf8AUONqYiGPsXCBk58syUyHVT1TBzWFF9m+sc9IQzSHCdcMzRFRXhZASqkcuXl9NPFWrhp3w3a5QrVemb1m7mlKaBIv1MtXd46HiZlU5NyBlPTAaEwSZ1sFzKMRvmDKt4D1Gtc2hxjU6QYxOFc3LPro+lL6TxaJYXFQ2mbZRpakb1oiMhIaYgxWEkwj1bYp5NZuFiopjHFPVqLLKgT3T2LXQAfPyduLjS5eDFiasUigU/ZW11foedq7jGITU3XDqodHoHTpQP2g==
Received: from SI2PR01CA0015.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::15) by TYZPR04MB4174.apcprd04.prod.outlook.com
 (2603:1096:400:2d::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24; Thu, 18 Jan
 2024 05:22:24 +0000
Received: from HK3PEPF0000021B.apcprd03.prod.outlook.com
 (2603:1096:4:191:cafe::4f) by SI2PR01CA0015.outlook.office365.com
 (2603:1096:4:191::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24 via Frontend
 Transport; Thu, 18 Jan 2024 05:22:24 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 HK3PEPF0000021B.mail.protection.outlook.com (10.167.8.37) with Microsoft SMTP
 Server id 15.20.7181.14 via Frontend Transport; Thu, 18 Jan 2024 05:22:23
 +0000
From: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
To: patrick@stwcx.xyz
Cc: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>,
	Samuel Mendoza-Jonas <sam@mendozajonas.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1] NCSI: Add propety : no-channel-monitor and start-redo-probe
Date: Thu, 18 Jan 2024 13:22:20 +0800
Message-Id: <20240118052220.1906721-1-Delphine_CC_Chiu@wiwynn.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HK3PEPF0000021B:EE_|TYZPR04MB4174:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 1439d3e7-e7e4-41d8-fe43-08dc17e573d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	e18XHtmTjqmu9zBm7wCB9B3MGuYQAijqH0/8X9eweyze371p6Yf2Qzp73qMRxngIVfDCSev77DeXUQ2fPfAhLpcjiQ3N8vP+xCy+N0GJBbQDVm85Xm2uViLl6RC8f5IcPVGUdHEiHWXUfyXXEG42SHWj9sGc/RQZWIwY6gVmSPGb6raa1EIB/hCsda7Vl2bRzCvnGDx9RS8IvJI9GG4uZS2kscE+CHY6bUXq3JW/+4TTFbbgt0gMisMtCBHegwqOKjtnGHQ1khDnOk02tT6MEVqSSU+SR2XqCC8v+uuOwwUHOXh2eB37M1+mr/JE6GFNxLQ1x7QWmXaspm08lUUxxYjhbOoyKap6DjbcePQb9G9bxp/vNSEtaLND6D4vHQ+j+mYHjzgwy1oIUHI3hMzTa5swplxrgp/9akvvi7CS5zgn1Zi9W8OzmxlRzuE+1ju+MXksONOHp6SW4hiZx9dl9JiSxlYL8oUfvDdcLSfrYr1/X9WZQ/jm7VhK1gM/iXalm2euVJd/9ymrbh8yFOIqEoRIbHOulStAw5g4uMdaPilrd5CEnkEm2EQzcuMceWCqWyAYJg4zXn/6fA3iAKZPL9iL6WyCNIh7omxryv3VRZl73g2tEa/uIC9Ze8uAUwAUiJxytb8C24mhkegkTvfA/RE2N/BOGKblj5/9s5prhI6pyBaN6hIpJLHWINgwR8P23iZXpWN1ZS2g0eHzufcwlg==
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230031)(6069001)(4636009)(39850400004)(136003)(376002)(396003)(346002)(230922051799003)(1800799012)(451199024)(82310400011)(186009)(64100799003)(46966006)(36840700001)(2906002)(9316004)(4326008)(5660300002)(41300700001)(81166007)(86362001)(356005)(82740400003)(478600001)(6486002)(36756003)(83380400001)(6512007)(6506007)(26005)(336012)(956004)(1076003)(2616005)(47076005)(36860700001)(6916009)(316002)(8676002)(8936002)(70586007)(70206006)(54906003)(36736006)(40480700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2024 05:22:23.6246
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1439d3e7-e7e4-41d8-fe43-08dc17e573d5
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	HK3PEPF0000021B.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR04MB4174

Add property start-redo-probe to redo probe, because Mellanox cx7 nic card
cannot't get mac address after nic card hot-plug.
Setup start-redo-probe property so that nic card can get MAC address again.
Also setup no-channel-monitor property so that the log won't keep
popping up when nic card host-plug.

Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
 net/ncsi/internal.h    |  6 ++++++
 net/ncsi/ncsi-manage.c | 25 +++++++++++++++++++++++--
 2 files changed, 29 insertions(+), 2 deletions(-)

diff --git a/net/ncsi/internal.h b/net/ncsi/internal.h
index 03757e76bb6b..a605271e04b4 100644
--- a/net/ncsi/internal.h
+++ b/net/ncsi/internal.h
@@ -199,6 +199,11 @@ struct ncsi_channel_stats {
 	u32 pt_rx_os_err;	/* Rx oversize errors         */
 };
 
+enum {
+	NCSI_CTRL_FLAG_NO_CHANNEL_MONITOR	= 0x0001,
+	NCSI_CTRL_FLAG_START_REDO_PROBE		= 0x0002,
+};
+
 struct ncsi_dev_priv;
 struct ncsi_package;
 
@@ -340,6 +345,7 @@ struct ncsi_dev_priv {
 	bool                multi_package;   /* Enable multiple packages   */
 	bool                mlx_multi_host;  /* Enable multi host Mellanox */
 	u32                 package_whitelist; /* Packages to configure    */
+	unsigned int        ctrl_flags;      /* NCSI control flags */
 };
 
 struct ncsi_cmd_arg {
diff --git a/net/ncsi/ncsi-manage.c b/net/ncsi/ncsi-manage.c
index d9da942ad53d..21a4b4db3cdc 100644
--- a/net/ncsi/ncsi-manage.c
+++ b/net/ncsi/ncsi-manage.c
@@ -1211,7 +1211,8 @@ static void ncsi_configure_channel(struct ncsi_dev_priv *ndp)
 		ndp->hot_channel = hot_nc;
 		spin_unlock_irqrestore(&ndp->lock, flags);
 
-		ncsi_start_channel_monitor(nc);
+		if (!(ndp->ctrl_flags & NCSI_CTRL_FLAG_NO_CHANNEL_MONITOR))
+			ncsi_start_channel_monitor(nc);
 		ncsi_process_next_channel(ndp);
 		break;
 	default:
@@ -1779,6 +1780,7 @@ struct ncsi_dev *ncsi_register_dev(struct net_device *dev,
 	INIT_LIST_HEAD(&ndp->vlan_vids);
 	INIT_WORK(&ndp->work, ncsi_dev_work);
 	ndp->package_whitelist = UINT_MAX;
+	ndp->ctrl_flags = 0;
 
 	/* Initialize private NCSI device */
 	spin_lock_init(&ndp->lock);
@@ -1804,8 +1806,14 @@ struct ncsi_dev *ncsi_register_dev(struct net_device *dev,
 	if (pdev) {
 		np = pdev->dev.of_node;
 		if (np && (of_property_read_bool(np, "mellanox,multi-host") ||
-			   of_property_read_bool(np, "mlx,multi-host")))
+			of_property_read_bool(np, "mlx,multi-host")))
 			ndp->mlx_multi_host = true;
+
+		if (np && of_get_property(np, "ncsi-ctrl,no-channel-monitor", NULL))
+			ndp->ctrl_flags |= NCSI_CTRL_FLAG_NO_CHANNEL_MONITOR;
+
+		if (np && of_get_property(np, "ncsi-ctrl,start-redo-probe", NULL))
+			ndp->ctrl_flags |= NCSI_CTRL_FLAG_START_REDO_PROBE;
 	}
 
 	return nd;
@@ -1815,11 +1823,24 @@ EXPORT_SYMBOL_GPL(ncsi_register_dev);
 int ncsi_start_dev(struct ncsi_dev *nd)
 {
 	struct ncsi_dev_priv *ndp = TO_NCSI_DEV_PRIV(nd);
+	struct ncsi_package *np, *tmp;
+	unsigned long flags;
 
 	if (nd->state != ncsi_dev_state_registered &&
 	    nd->state != ncsi_dev_state_functional)
 		return -ENOTTY;
 
+	if (ndp->ctrl_flags & NCSI_CTRL_FLAG_START_REDO_PROBE) {
+		nd->state = ncsi_dev_state_probe;
+		spin_lock_irqsave(&ndp->lock, flags);
+		ndp->flags &= ~NCSI_DEV_PROBED;
+		ndp->gma_flag = 0;
+		spin_unlock_irqrestore(&ndp->lock, flags);
+
+		list_for_each_entry_safe(np, tmp, &ndp->packages, node)
+			ncsi_remove_package(np);
+	}
+
 	if (!(ndp->flags & NCSI_DEV_PROBED)) {
 		ndp->package_probe_id = 0;
 		nd->state = ncsi_dev_state_probe;
-- 
2.25.1


