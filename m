Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6674F752577
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 16:48:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231731AbjGMOsz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 10:48:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231126AbjGMOsq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 10:48:46 -0400
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2042.outbound.protection.outlook.com [40.107.241.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8428212D;
        Thu, 13 Jul 2023 07:48:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PMF8MxxhRt8De336PC8pJDAGHHJnUYpRps95Rwj+mqmUsY9ghUW2Nrpf0zM9/0FpfH+5Fk7hVKu7yieDLzwvMJewS1CH/lG8E1LeTwc+iAvDsb8L/6lCEqz73sGWvdmZg5OoPVv+nK6eYUMsZNlvZ3e05rijYQEWx1qb92XIJH69fiBNT4ykltRYf0xa26zXzr8+Y7HmX6/9F0Sg2f/ZZcu40t5usHRInlTdPifsftJxD3ID5+ML4EVNDFx87m1xYzJucJAJQFyEXHCXC4pLMTiQlgBFw0sYzywD6R0g7UPXbPv6cXfOSPNoHTjA32Puj66MC5PSBqokNK91m4SMIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qnYbnPt4L7xrw6HDXCldXKb9iMOag9e71uf/VjLpkV0=;
 b=IqnXtNtVk3NsFLyEHaJXxM98sCK26oBWmuGNP5uM6oziB1X8DLlY5hNkH7aSsq5ynfs1I3yZXS0A3uQXzIDYd7cqh8pIWEvAD2xuIBfJwyaDwBcu1TBxvPFiPZ+gxRpl3ANgf+einU7f8J6xk4lrLKvZFw7/LyV5/0G6MdzP6OBWS17BYRmlgnDGVC1vVdCbopaN1kJ6kay88/F8MFVM1f6BR4/Lga43YmMgYT4lkpFdUBQC/X5y0u6w77xjuYhCYiBtPt7v22pA8/CUMrNpIWWL+iYK2T5zAa8vC6jvGHYPUniNA7Q3jGTCz2avBuomXopjhUWM6kVFKya2/mZEUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.76) smtp.rcpttodomain=redhat.com smtp.mailfrom=siemens.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qnYbnPt4L7xrw6HDXCldXKb9iMOag9e71uf/VjLpkV0=;
 b=spiThwEFim2O078MvzJgOsL143X46g3JsfzqEGHslbuPNxr2E3Wqqvgdk65YnYJq6CyQWCc6c1ADv3/i2c19VuiWGSJ14oPY5HJHwIyYTUCsw7JQSYzwXIXe9WfdTV1eEOQa0KTUYijj4sQztHPyiFwcBGF/2Vyu1Ee/pfHjY2e+NObF0e5k+peTfnS3HAm9bRqWTtTyBuwEkSgZ9FK1tCa3ditVUWBOA8L8B50VDuoIoTA6am9PsBtBHIp6zXjapFcuNp0b4iie6faJtgPkQMyC/fhk/TmWvayN8h/5jyFVyjv1Aa7pd7OgTSrNowmbU0Dvk7gRoJ4TyDma5Whcng==
Received: from FR0P281CA0079.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:1e::19)
 by DB8PR10MB3831.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:16b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.20; Thu, 13 Jul
 2023 14:48:43 +0000
Received: from VE1EUR01FT029.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:d10:1e:cafe::46) by FR0P281CA0079.outlook.office365.com
 (2603:10a6:d10:1e::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.20 via Frontend
 Transport; Thu, 13 Jul 2023 14:48:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.76)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.76 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.76; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.76) by
 VE1EUR01FT029.mail.protection.outlook.com (10.152.2.224) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6588.22 via Frontend Transport; Thu, 13 Jul 2023 14:48:42 +0000
Received: from DEMCHDC8WAA.ad011.siemens.net (139.25.226.104) by
 DEMCHDC8VSA.ad011.siemens.net (194.138.21.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Thu, 13 Jul 2023 16:48:42 +0200
Received: from md1za8fc.ppmd.siemens.net (139.25.69.128) by
 DEMCHDC8WAA.ad011.siemens.net (139.25.226.104) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25; Thu, 13 Jul 2023 16:48:42 +0200
From:   Henning Schild <henning.schild@siemens.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        <platform-driver-x86@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Tobias Schaffner <tobias.schaffner@siemens.com>,
        Gerd Haeussler <gerd.haeussler.ext@siemens.com>,
        Henning Schild <henning.schild@siemens.com>
Subject: [PATCH v2 0/3] platform/x86: simatic-ipc: add another model and hwmon module loading
Date:   Thu, 13 Jul 2023 16:48:29 +0200
Message-ID: <20230713144832.26473-1-henning.schild@siemens.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [139.25.69.128]
X-ClientProxiedBy: DEMCHDC8WBA.ad011.siemens.net (139.25.226.105) To
 DEMCHDC8WAA.ad011.siemens.net (139.25.226.104)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1EUR01FT029:EE_|DB8PR10MB3831:EE_
X-MS-Office365-Filtering-Correlation-Id: 32355f76-c675-4f47-7a53-08db83b040de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IUU3RQHWSMRtXLTJbhhc7aKl7/sL9MGv08+jHsNArb6WdJvvyLyb42pKA8IuZf6FDo/++jWhZ9Cx43B59qSmrIW5hvibGxXMBOQHamUNviK3d4Q1g71Rt7nN6jLVeQyl3YLcKkTDzEivUV7rZ4A56BcFrV85UaknTBTV5DissSBzqdYhBqca8OBXC1ZNRDyqxNnkwg3b9j1rNTly1VpXvw/qywmbiFZ+s//JYIXHa83OD+ZjmUDR9vMEWqfobCNdYIhGlcGqBaQXzf/s6iQFv4YzD3Ehjg2OrDA0qXcsQQCvzZETqpDxavex4naSqb0DZBxtzXotzezg8aUKR/+q34yqD9v4ylKqb5ucPz6SZgcPsKrKutWttJo0oQ5yKvQfOAQ6ttnGH9NqTrC4gx9woYI5cVz20LFfGu9Hn6wJMetVmPVK0cXcx6ivg3gm/7fFflwXi8Ffod4JfOnmbnZv4drkzy7vgpsu1/sQvCgqzl1yODYRL3BJvWNbtD/F+hbeRVcWx6P85g6MxbH8uffZkRdrT8d5DMjPplxPeThnBYKWNDjXRJoUV6D76DxCSAuKKNuCSMsnV+pwJ29e2BvpA+SaaUEyWupyyLuFDsND7MfZofjTAGKCtYSqGBKkhtA5WhfJCz1b+nYGC0Xdx67eQWXkYyUTzynRlvf1LWISQsAh8x8sn6MZ9r6exnXD5U7yQcgzAmqjaDCSaBSgTVkTAk+azXxV0UN75HoY6PSntuPfLFNV6BstrIrAMEgjIhYLcvvhISsbrKwDarxaZuYgFQ==
X-Forefront-Antispam-Report: CIP:194.138.21.76;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(136003)(376002)(396003)(451199021)(46966006)(40470700004)(36840700001)(44832011)(70206006)(4326008)(70586007)(41300700001)(316002)(2906002)(4744005)(478600001)(8936002)(5660300002)(8676002)(110136005)(54906003)(36860700001)(6666004)(40460700003)(26005)(107886003)(40480700001)(36756003)(186003)(16526019)(83380400001)(336012)(47076005)(1076003)(82960400001)(356005)(82310400005)(82740400003)(2616005)(81166007)(956004)(86362001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2023 14:48:42.8393
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 32355f76-c675-4f47-7a53-08db83b040de
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.76];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR01FT029.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3831
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cahnged since v1:
 - switch to using a list of modules per device
 - add p3 and make the watchdog module load code use what p2 created

The first patch just adds a device that is pretty similar to another one
we already had here.

The second patch loads modules for hwmon support, should they be
available. That will save users the need to detect and manually load
those modules after a machine has been clearly identified by its Siemens
Simatic IPC station id.

And finally p3 changes another request_module call to use the mechanism
introduced in p2.

Henning Schild (3):
  platform/x86: simatic-ipc: add another model
  platform/x86: simatic-ipc: add auto-loading of hwmon modules
  platform/x86: simatic-ipc: use extra module loading for watchdog

 drivers/platform/x86/simatic-ipc.c            | 74 ++++++++++++++-----
 include/linux/platform_data/x86/simatic-ipc.h |  1 +
 2 files changed, 57 insertions(+), 18 deletions(-)

-- 
2.41.0

