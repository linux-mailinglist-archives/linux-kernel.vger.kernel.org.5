Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDF787DB3FA
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 08:20:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231754AbjJ3HUG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 03:20:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231862AbjJ3HTp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 03:19:45 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2067.outbound.protection.outlook.com [40.107.96.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F18B4F3;
        Mon, 30 Oct 2023 00:19:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ikO+Lm0mNPpUHIHQj4ghjWZOptx0QIGkuGQYwY2cdPhtEUg9LxN1A8s8swg9aYRkr53Evjj+LP3otHJTvO4FBG+GInyWVpHSQiD7FSOukkdziSPvK612okrAOsIrRjlvIgZWEkDr0vxk07RX5rQ9wkzq4bS7SKf9HPQCF5ZdPHgJ+QvMnhmFZEFu5LK6i23D1dzKyVrr6Uj7huUBBKWpG8hEAxPGcQEnFbOwbs/f3aPVOXH70W1VR8PfirA45UnA2DVhB3ijpx9gZmnWh9RKCVa7O0GZ1R0INHml7PAyyX5+umCsiD3abmjtlu32gzAxvqAlPlvriZL1BtU2a4vT4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XDnvryzIVrj1jQgIGC/qeQfSUeZsi4vLUmJnBW2qjls=;
 b=lf2m+/ro4rt00/p8mzDUuRv7ywQOU1ecuvorln53bnrXCzSJQZ01FWnFHYDzncX+a9/rQCTyGiAv8HQ74bQ1MnLZ7/HAX8njyzT8dTm8pkI52GPuuk2Xdy6Pxxnmn+pMOCbfcvh3w92k5reTJBFdU85IrNvJPq1t2wJWToYNxyNvon5VmV0N5dTuBA4NJS6iPYSkfXzd9YjWoRz57Ad5GU2k3dEmCACP+somT69huuDdDdGE3eFpJ9UD24NSOT9MPlN2NXKMwGbFA9G3WeQBcTneLsGN625sSCwOVdrjhnmL7ovsSnG4vkHbo686ixX7Xzt4hV6hcmxwhNk8sn9Qbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XDnvryzIVrj1jQgIGC/qeQfSUeZsi4vLUmJnBW2qjls=;
 b=dVz/xlIuma0sOlAJ6RECCk2vf4GF9Gzy0zaZDy8JvaKq6NFBEL4l5P/8HTuiP8G7IOFJPpUR8oP4FjbpPvnV6QWdaTRF1lLk9M1wzmgnJotEdY5BRwXLF6rxpXb9wEguWSfv8Ej08MmXLDrqGUSLrGVNQfwnjvuUGQf8Z2tGRWc=
Received: from CY5PR13CA0059.namprd13.prod.outlook.com (2603:10b6:930:11::20)
 by DM6PR12MB4957.namprd12.prod.outlook.com (2603:10b6:5:20d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.26; Mon, 30 Oct
 2023 07:19:35 +0000
Received: from CY4PEPF0000E9D6.namprd05.prod.outlook.com
 (2603:10b6:930:11:cafe::4) by CY5PR13CA0059.outlook.office365.com
 (2603:10b6:930:11::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.14 via Frontend
 Transport; Mon, 30 Oct 2023 07:19:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D6.mail.protection.outlook.com (10.167.241.80) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6933.15 via Frontend Transport; Mon, 30 Oct 2023 07:19:34 +0000
Received: from compile-server.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Mon, 30 Oct
 2023 02:19:25 -0500
From:   Ma Jun <Jun.Ma2@amd.com>
To:     <amd-gfx@lists.freedesktop.org>, <lenb@kernel.org>,
        <johannes@sipsolutions.net>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <alexander.deucher@amd.com>, <Lijo.Lazar@amd.com>,
        <mario.limonciello@amd.com>, <netdev@vger.kernel.org>,
        <linux-wireless@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <platform-driver-x86@vger.kernel.org>
CC:     <majun@amd.com>, Evan Quan <quanliangl@hotmail.com>,
        Ma Jun <Jun.Ma2@amd.com>
Subject: [Patch v13 3/9] cfg80211: expose nl80211_chan_width_to_mhz for wide sharing
Date:   Mon, 30 Oct 2023 15:18:26 +0800
Message-ID: <20231030071832.2217118-4-Jun.Ma2@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231030071832.2217118-1-Jun.Ma2@amd.com>
References: <20231030071832.2217118-1-Jun.Ma2@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D6:EE_|DM6PR12MB4957:EE_
X-MS-Office365-Filtering-Correlation-Id: f3b2ae97-1ad7-4cb6-bce4-08dbd9189181
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sNbcHgdBYezqmW+SXQnRWXx+JOvKOIALC/fvk9KXGsgpOysPP3qfZQYWhHok8L9pMlF14FumZCrifArfA2KY85iP28ZjSJkodISpIqbZZnD2lDUjddXyaw5v5QFdFHWAa5PugxNmed0UeSjS36zg/LoMNZq3FRdi/UAaofSTtd6mN2n42Yg5+ANeglURAi5OSZ8maC89OgrnAOBP1c1vNlaqhTuMziVpz9vUvSS2yPTutTzjkzzoB4l2dH1fAtLgO1QFkkNYHpp2cRPAwKl6lk9uP3mbt3CMBAK8Ll3X1ph8x3mL256qdKP3v121JlTCyvYfwrNqZ/ovY9RxLrZrWQ+MvhC4MUywRz6GnNwRMy1TCbFd32IiuOiI/PyW7y3jFpn21/srmYQJFe6WNB5keTZitJSc6ZZnjeYtmUyqxDmxPuljBqTfY6nybN5j8Nf5O42dH5cgo17ZnstabWdC1WD8RSelI0CRLNhXtAiMYENaeZ9sSgMJpV0ZRcgMLBO00CRBq301FM83sSVN5/IZLqUuMftnbm2AWPb5HA7CXj255AM5xHNvC3O/RjLE3n6il5nhhddSYA2XM7GFrv2eW6UEweeSVXLlBgw9HUGXQhlBu1l0BwXs+uYM8MudQ6Pplsmw3ALR1M37BnSpezcIaQBTvgKY9kS1TVitQtj6diMh96ZIQ1FVMkySFBWJtmkR98ZArSDFL+u+PUynha3Cr1UhUrrCfp4XvgK/ixLSYGkCV930P2fhCmPzd4tr0fsui8gsvr5pL1nNBpkDX5O3fpuS9iIB4ek6+vasJnXDGb4=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(39860400002)(376002)(396003)(136003)(230922051799003)(186009)(1800799009)(82310400011)(64100799003)(451199024)(40470700004)(36840700001)(7696005)(478600001)(45080400002)(83380400001)(16526019)(26005)(2616005)(1076003)(336012)(426003)(2906002)(5660300002)(41300700001)(54906003)(316002)(7416002)(70206006)(110136005)(32650700002)(8936002)(4326008)(8676002)(70586007)(921008)(36860700001)(86362001)(36756003)(356005)(81166007)(82740400003)(40460700003)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2023 07:19:34.5604
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f3b2ae97-1ad7-4cb6-bce4-08dbd9189181
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4957
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Evan Quan <quanliangl@hotmail.com>

The newly added WBRF feature needs this interface for channel
width calculation.

Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
Signed-off-by: Evan Quan <quanliangl@hotmail.com>

--
v8->v9:
  - correct typo(Mhz -> MHz) (Johnson)
v13:
 - Fix the format issue (IIpo Jarvinen)
---
 include/net/cfg80211.h | 9 +++++++++
 net/wireless/chan.c    | 3 ++-
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 7192346e4a22..95955fa251c9 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -923,6 +923,15 @@ const struct cfg80211_chan_def *
 cfg80211_chandef_compatible(const struct cfg80211_chan_def *chandef1,
 			    const struct cfg80211_chan_def *chandef2);
 
+/**
+ * nl80211_chan_width_to_mhz - get the channel width in MHz
+ * @chan_width: the channel width from &enum nl80211_chan_width
+ *
+ * Return: channel width in MHz if the chan_width from &enum nl80211_chan_width
+ * is valid. -1 otherwise.
+ */
+int nl80211_chan_width_to_mhz(enum nl80211_chan_width chan_width);
+
 /**
  * cfg80211_chandef_valid - check if a channel definition is valid
  * @chandef: the channel definition to check
diff --git a/net/wireless/chan.c b/net/wireless/chan.c
index 0b7e81db383d..227db04eac42 100644
--- a/net/wireless/chan.c
+++ b/net/wireless/chan.c
@@ -141,7 +141,7 @@ static bool cfg80211_edmg_chandef_valid(const struct cfg80211_chan_def *chandef)
 	return true;
 }
 
-static int nl80211_chan_width_to_mhz(enum nl80211_chan_width chan_width)
+int nl80211_chan_width_to_mhz(enum nl80211_chan_width chan_width)
 {
 	int mhz;
 
@@ -190,6 +190,7 @@ static int nl80211_chan_width_to_mhz(enum nl80211_chan_width chan_width)
 	}
 	return mhz;
 }
+EXPORT_SYMBOL(nl80211_chan_width_to_mhz);
 
 static int cfg80211_chandef_get_width(const struct cfg80211_chan_def *c)
 {
-- 
2.34.1

