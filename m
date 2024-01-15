Return-Path: <linux-kernel+bounces-26035-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D21E982DA32
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 14:37:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 47DC0B20B28
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 13:37:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 951CB1755A;
	Mon, 15 Jan 2024 13:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=opensynergy.com header.i=@opensynergy.com header.b="RjOaspHD"
Received: from repost01.tmes.trendmicro.eu (repost01.tmes.trendmicro.eu [18.185.115.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5F27171B6
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 13:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensynergy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensynergy.com
Received: from 104.47.7.169_.trendmicro.com (unknown [172.21.190.17])
	by repost01.tmes.trendmicro.eu (Postfix) with SMTP id 03BB910000C39;
	Mon, 15 Jan 2024 13:37:26 +0000 (UTC)
X-TM-MAIL-RECEIVED-TIME: 1705325842.087000
X-TM-MAIL-UUID: 0439458f-0ece-496a-b474-05847176b0c4
Received: from DEU01-BE0-obe.outbound.protection.outlook.com (unknown [104.47.7.169])
	by repre01.tmes.trendmicro.eu (Trend Micro Email Security) with ESMTPS id 1566F10005E05;
	Mon, 15 Jan 2024 13:37:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ECUWrAQE7lBSP67+4WcB3DHkefEDbWl4F49K2yhRXeUwLBluX1IeJbUcU5nuky3cpihgOfmIs56G2kvm1A+KXwBMGOJfJNSZ/GfKn/L3GPU1rHPmtGNC8Sd6wQCGNVJTXcqmXG+pngkRKDWbDcqi4fKqfkznLQlYpgtiVykFrzySxomCYTW9ZzTBsF6YcmVYtNV4QRkN/kF9m7ECHIqQ7Q8kppARC04qfstYYIu7p/Cg0wuWdnU2+gVdeo5ym1bjbENqoEI+9hGSJ9U79sDOgIOaaaM6N8+e+zp6jja6teAiwl9KzeMYizzkDxB+IJpA9jYJg7gW2mRKGZzhcTLsGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hu9gvAIXe6GfC4rIGKOTjKSv+jP9v93quAMVJjG2VMA=;
 b=JCrQDbLou+78lryIrEmH+2MmhlSt+meYd8Hr4zovGb6nUY1RTftN19HhjRbsK3OMha/AIR9WBTbefle/XdZkqOH0h9JyCKW5Ak50boO6flkoSQPBElMdujU/GCFRZJJeQA7g8mhEoHioZ9mVW1ojGXIfZe0bCdBX7foDqqdWw0lk9+Opguj7dZ3NAEBRlRYwafqumwBlABY3SR+bDfi1O47hz9561T+Wqgrj96j8AI9Q9PTvLEDSyZQtp6GoiLiXTBxPKV5ZrA8Imr2VvuzQq6ZTVZpQyibWaZWzSqIVbboY3SAA5DFJdusv569IxtUFu1r+MmlQP5eo/+kD+SrIaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 217.66.60.4) smtp.rcpttodomain=alsa-project.org
 smtp.mailfrom=opensynergy.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=opensynergy.com; dkim=none (message not signed);
 arc=none (0)
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 217.66.60.4)
 smtp.mailfrom=opensynergy.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=opensynergy.com;
Received-SPF: Pass (protection.outlook.com: domain of opensynergy.com
 designates 217.66.60.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.66.60.4; helo=SR-MAIL-03.open-synergy.com; pr=C
From: Aiswarya Cyriac <aiswarya.cyriac@opensynergy.com>
To: mst@redhat.com,
	jasowang@redhat.com,
	perex@perex.cz,
	tiwai@suse.com,
	linux-kernel@vger.kernel.org,
	alsa-devel@alsa-project.org,
	virtualization@lists.linux-foundation.org,
	virtio-dev@lists.oasis-open.org
Cc: Anton Yakovlev <anton.yakovlev@opensynergy.com>,
	Aiswarya Cyriac <aiswarya.cyriac@opensynergy.com>
Subject: [v2 PATCH 1/1] ALSA: virtio: add support for audio controls
Date: Mon, 15 Jan 2024 14:36:54 +0100
Message-Id: <20240115133654.576068-2-aiswarya.cyriac@opensynergy.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240115133654.576068-1-aiswarya.cyriac@opensynergy.com>
References: <20240115133654.576068-1-aiswarya.cyriac@opensynergy.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6EUR05FT051:EE_|FR4P281MB3449:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: b144ab33-3957-4e16-2564-08dc15cf1868
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	R3HvK6JLR8TlguF7+rt/IVxeHE4GW5uXwTTDinMixzXgSI4ZOtRGuu0l6PboQp39geeZ05YJXz0FMKnX4FFSFP9Q4QdhekmjcM1uonwsH6WblDDUt4FW4I+BK1PCaVrwuai0UH3EB5xidkiyhIFLpu3ryEWiUtV/8Jb6RntkUPMiH4bhVSRyVYNgVrYT2NG7EulUjswQS/j29vRvnZ+e5mIJKXS9GgizYZ9EX5zxZxdmob+3n42Ww2owi6A3nmA1ko4Ap69If4FjyTzLQhHU5FG3YBpGY0g38mnRA/wShhDPbJSWmWFAnLRMkHOyGRVZCnDSg2Klu/ln/gT16C7892VnNpkDTEN+Vx7i156CWzRsi3mhmHsYpH5Pw6REyigp4heJAHWZ7NKEdmU9wn/j4tuUpGvuDblQB8kEp9bE83XpBv8QmlaBC/lhqifvEGBd3N5JdAWV497bgQQRqBlfhmP2MwVmfX+5hAkxZZsn34p6w0f8w6FOd0msWjsIhdjT+p+ECrIZWpNhuriU6fhhZIJ0NuvG9dewt4hfuPpZINc2e6zm9sSZBL8x/06RZSRzN5hFt63VaVRoOvX/D05prLKdjwVLXPiyO9u+gCfo6eqmlr5Chx54E6O7eJCfAGG+4dcqVqwxbkpeTckzUToQAC157HTMgp+QiMxU2JVt53feBs1FfwCtPkJ3/rx3m+zssJXF0mqoIAA6kSKWtgbJPPIUSSQGMLDScfZ8kDm3BIGaSu5UCM2XxBzPQ3xiBtj5RwhjduQuH/Ta1JG4fTcmIxtC3aTLy5ZcdzLpre7mu8U=
X-Forefront-Antispam-Report:
	CIP:217.66.60.4;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SR-MAIL-03.open-synergy.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(346002)(376002)(39840400004)(136003)(396003)(230922051799003)(451199024)(186009)(1800799012)(82310400011)(64100799003)(36840700001)(46966006)(2906002)(5660300002)(41300700001)(30864003)(107886003)(2616005)(36756003)(86362001)(1076003)(26005)(81166007)(36860700001)(336012)(83380400001)(47076005)(8936002)(478600001)(8676002)(4326008)(2013699003)(44832011)(70206006)(70586007)(966005)(316002)(54906003)(42186006)(40480700001)(21314003)(36900700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensynergy.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2024 13:37:19.0878
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b144ab33-3957-4e16-2564-08dc15cf1868
X-MS-Exchange-CrossTenant-Id: 800fae25-9b1b-4edc-993d-c939c4e84a64
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=800fae25-9b1b-4edc-993d-c939c4e84a64;Ip=[217.66.60.4];Helo=[SR-MAIL-03.open-synergy.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM6EUR05FT051.eop-eur05.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR4P281MB3449
X-TM-AS-ERS: 104.47.7.169-0.0.0.0
X-TMASE-Version: StarCloud-1.3-9.1.1015-28120.006
X-TMASE-Result: 10--27.885200-4.000000
X-TMASE-MatchedRID: az/Z5iu9uIw1ES5mXStnyoi/ka5VrHsKa0/GZfVOHDoj+9t//CeCEdqK
	Kei3fK/BELXgrbbFqNtlTstE4C1RYlVb7WSBJ2slCqJ0RbJ3bb3PaW4rD8GWjM6tJc684va3jUb
	HKinL4HA2bvTw4kGmhROxOZUm/FwcqMfOugFNRj0v/mdfeJBuVwf8yw0JGfKVyEYRIXZC1hKyCR
	+docAU/Ob1Nz8aB8UnQ8e9/KT1nPrROMN2W+zDHtTSGjubFor4oByh1U4IEaMu0hhTbF/LOPVyd
	O3N+rx/+X2Dz6UW7QouzpkxP8+5uBFRqOzVJzTgb9B0a4XF/0+TElYuFMnAunpSUvnSiBqHMMdr
	OY0C3Fefh+C5OxCORJZNDSOZsuZ1oDUf7boOKhZ+niUysM07RAeATH6uEs3ikVj8lcfFncZnDyA
	FsBwKF4IwZJtWEdPrBPsCWqKv2JAU3c9OcKbtaFY9XYa1m8xAGfP6Q7XnYodheY1N9xOffhHjVK
	3+pNKI38xnKIoqSpGv897CQ8vLRdITMXT2gZgPujYpdCy9VlJmwFrO7rfbIsLqQqWDHfa12WrhF
	gFRukkP0WkLMOGBJeM14YVLH8wgwGs+EcopPjBCPQBD3xA/3aODSWu0oxbK6gfKtA7YhlrtmyEv
	xwC5ZF4L45p2p0pV3+6k97GsyDiUTGVAhB5EbQ==
X-TMASE-XGENCLOUD: 66a99d20-2623-4049-853e-e7d95e0311c2-0-0-200-0
X-TM-Deliver-Signature: 10063A1D1629FDEE0D52F0C29EEFFCDB
X-TM-Addin-Auth: JQg27yprowPuW61f2Ju0Me3qbGhY737j4JL4VY0OJ+DPLkLnU03RVAKqTLH
	W5aoqPfT8Xwcq/xVdQmBf2pVFNE1dRiA3FT5e8ME4Q4TyPUg9YD47O5nLf6GXc1bhq3vEjp7IZl
	FP+aj94GjhlbS//B/a+92guRCiqu6fueiGGs3WTM1eTvV3MnM3liyiqUGlrVwfufFMUfz1dAnM/
	ZHYMOE2HlFcPKWih5GG/M7YVOdMWqNKsxrYVRE/GGIXVN3AQs36HVwLUXWMCpsZIJb6VT3tY/Me
	KehpOxJfMZmt9n3UdQ6kRf04NZ6HkUQN8S/l.XNMAHSEdTZuYiznvsFPaCkcyGPX5cS5Ak23z8v
	7IEY0xJpgv87kkg90Tig7BS9Glc7VVDj69ZhIyGd97FLpwBzHAnoZYt+nu3Rb4+t13WJosF3UEf
	AM4oWQQh/NJ4U2kwrGDvGkcSg/Gfl3+dJ+tBG6zT2Reft8n3Ha4HEgVVm/+/ahm4kTUUX8rMsuY
	+qrwrNy2Bn7x5efUxkGooOcQPaKd9A/ZplzYV34Gk53uI0+dmf+sPsj8WHtfb0fe3RrZTpHT78V
	qEZyjpCibp6G4P6wnNxbV/+6nm5SqHOlWrvB8tboXS40Nb4Oq7rFxJ4BTxxRlMCFRT373GMeHUu
	nBEQ==
X-TM-Addin-ProductCode: EMS
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=opensynergy.com;
	s=TM-DKIM-20210503141657; t=1705325845;
	bh=Ka5B1+87inF7tJVAKd6W/3cDzPElSl1q/1CqDmaGmwc=; l=24544;
	h=From:To:Date;
	b=RjOaspHDB7Qf8WsvbFHW8xZs6S2t9HVFlJvdO9r6IoboZ6vBkf8HQF1pL7ERFFO6K
	 EqPE9qdhduZpAAYeBX/tl/jok4d93UPAJ8ESn7MmUNbTwV37f2U36AShIxeWhuTJF7
	 F60amSU+n51f12HtALcTA8tqomeLOhY3Xf+JWsfLIPrgxPcIiLw5FYoFS3HXFUf2P5
	 cAW3CBmciP7bSHAuImE9KZ+Zg4Q6+AliS5A1Xi7QqUN1UYeLXg9gfvxFSKk860s616
	 A7EtI1yy4sL5ehtAmz6O3hbA0NXCjcmyC+m7CPfT6is8FzXj4RLSRORtI1ReALJ4ey
	 x6w4wM1Vf8FWA==

From: Anton Yakovlev <anton.yakovlev@opensynergy.com>

Implementation of support for audio controls in accordance with the
extension of the virtio sound device specification [1] planned for
virtio-v1.3-cs01.

The device can announce the VIRTIO_SND_F_CTLS feature. If the feature is
negotiated, then an additional field appears in the configuration space:

  struct virtio_snd_config {
    ...
    /* number of available control elements */
    __le32 controls;
  };

The driver can send the following requests to manage audio controls:

  enum {
    ...
    /* control element request types */
    VIRTIO_SND_R_CTL_INFO = 0x0300,
    VIRTIO_SND_R_CTL_ENUM_ITEMS,
    VIRTIO_SND_R_CTL_READ,
    VIRTIO_SND_R_CTL_WRITE,
    VIRTIO_SND_R_CTL_TLV_READ,
    VIRTIO_SND_R_CTL_TLV_WRITE,
    VIRTIO_SND_R_CTL_TLV_COMMAND,
    ...
  };

And the device can send the following audio control event notification:

  enum {
    ...
    /* control element event types */
    VIRTIO_SND_EVT_CTL_NOTIFY = 0x1200,
    ...
  };

See additional details in [1].

[1] https://lists.oasis-open.org/archives/virtio-comment/202104/msg00013.html

Signed-off-by: Anton Yakovlev <anton.yakovlev@opensynergy.com>
Signed-off-by: Aiswarya Cyriac <aiswarya.cyriac@opensynergy.com>
---
 include/uapi/linux/virtio_snd.h | 154 +++++++++++
 sound/virtio/Makefile           |   1 +
 sound/virtio/virtio_card.c      |  21 ++
 sound/virtio/virtio_card.h      |  22 ++
 sound/virtio/virtio_kctl.c      | 466 ++++++++++++++++++++++++++++++++
 5 files changed, 664 insertions(+)
 create mode 100644 sound/virtio/virtio_kctl.c

diff --git a/include/uapi/linux/virtio_snd.h b/include/uapi/linux/virtio_snd.h
index dfe49547a7b0..5f4100c2cf04 100644
--- a/include/uapi/linux/virtio_snd.h
+++ b/include/uapi/linux/virtio_snd.h
@@ -7,6 +7,14 @@
 
 #include <linux/virtio_types.h>
 
+/*******************************************************************************
+ * FEATURE BITS
+ */
+enum {
+	/* device supports control elements */
+	VIRTIO_SND_F_CTLS = 0
+};
+
 /*******************************************************************************
  * CONFIGURATION SPACE
  */
@@ -17,6 +25,8 @@ struct virtio_snd_config {
 	__le32 streams;
 	/* # of available channel maps */
 	__le32 chmaps;
+	/* # of available control elements */
+	__le32 controls;
 };
 
 enum {
@@ -55,6 +65,15 @@ enum {
 	/* channel map control request types */
 	VIRTIO_SND_R_CHMAP_INFO = 0x0200,
 
+	/* control element request types */
+	VIRTIO_SND_R_CTL_INFO = 0x0300,
+	VIRTIO_SND_R_CTL_ENUM_ITEMS,
+	VIRTIO_SND_R_CTL_READ,
+	VIRTIO_SND_R_CTL_WRITE,
+	VIRTIO_SND_R_CTL_TLV_READ,
+	VIRTIO_SND_R_CTL_TLV_WRITE,
+	VIRTIO_SND_R_CTL_TLV_COMMAND,
+
 	/* jack event types */
 	VIRTIO_SND_EVT_JACK_CONNECTED = 0x1000,
 	VIRTIO_SND_EVT_JACK_DISCONNECTED,
@@ -63,6 +82,9 @@ enum {
 	VIRTIO_SND_EVT_PCM_PERIOD_ELAPSED = 0x1100,
 	VIRTIO_SND_EVT_PCM_XRUN,
 
+	/* control element event types */
+	VIRTIO_SND_EVT_CTL_NOTIFY = 0x1200,
+
 	/* common status codes */
 	VIRTIO_SND_S_OK = 0x8000,
 	VIRTIO_SND_S_BAD_MSG,
@@ -331,4 +353,136 @@ struct virtio_snd_chmap_info {
 	__u8 positions[VIRTIO_SND_CHMAP_MAX_SIZE];
 };
 
+/*******************************************************************************
+ * CONTROL ELEMENTS MESSAGES
+ */
+struct virtio_snd_ctl_hdr {
+	/* VIRTIO_SND_R_CTL_XXX */
+	struct virtio_snd_hdr hdr;
+	/* 0 ... virtio_snd_config::controls - 1 */
+	__le32 control_id;
+};
+
+/* supported roles for control elements */
+enum {
+	VIRTIO_SND_CTL_ROLE_UNDEFINED = 0,
+	VIRTIO_SND_CTL_ROLE_VOLUME,
+	VIRTIO_SND_CTL_ROLE_MUTE,
+	VIRTIO_SND_CTL_ROLE_GAIN
+};
+
+/* supported value types for control elements */
+enum {
+	VIRTIO_SND_CTL_TYPE_BOOLEAN = 0,
+	VIRTIO_SND_CTL_TYPE_INTEGER,
+	VIRTIO_SND_CTL_TYPE_INTEGER64,
+	VIRTIO_SND_CTL_TYPE_ENUMERATED,
+	VIRTIO_SND_CTL_TYPE_BYTES,
+	VIRTIO_SND_CTL_TYPE_IEC958
+};
+
+/* supported access rights for control elements */
+enum {
+	VIRTIO_SND_CTL_ACCESS_READ = 0,
+	VIRTIO_SND_CTL_ACCESS_WRITE,
+	VIRTIO_SND_CTL_ACCESS_VOLATILE,
+	VIRTIO_SND_CTL_ACCESS_INACTIVE,
+	VIRTIO_SND_CTL_ACCESS_TLV_READ,
+	VIRTIO_SND_CTL_ACCESS_TLV_WRITE,
+	VIRTIO_SND_CTL_ACCESS_TLV_COMMAND
+};
+
+struct virtio_snd_ctl_info {
+	/* common header */
+	struct virtio_snd_info hdr;
+	/* element role (VIRTIO_SND_CTL_ROLE_XXX) */
+	__le32 role;
+	/* element value type (VIRTIO_SND_CTL_TYPE_XXX) */
+	__le32 type;
+	/* element access right bit map (1 << VIRTIO_SND_CTL_ACCESS_XXX) */
+	__le32 access;
+	/* # of members in the element value */
+	__le32 count;
+	/* index for an element with a non-unique name */
+	__le32 index;
+	/* name identifier string for the element */
+	__u8 name[44];
+	/* additional information about the element's value */
+	union {
+		/* VIRTIO_SND_CTL_TYPE_INTEGER */
+		struct {
+			/* minimum supported value */
+			__le32 min;
+			/* maximum supported value */
+			__le32 max;
+			/* fixed step size for value (0 = variable size) */
+			__le32 step;
+		} integer;
+		/* VIRTIO_SND_CTL_TYPE_INTEGER64 */
+		struct {
+			/* minimum supported value */
+			__le64 min;
+			/* maximum supported value */
+			__le64 max;
+			/* fixed step size for value (0 = variable size) */
+			__le64 step;
+		} integer64;
+		/* VIRTIO_SND_CTL_TYPE_ENUMERATED */
+		struct {
+			/* # of options supported for value */
+			__le32 items;
+		} enumerated;
+	} value;
+};
+
+struct virtio_snd_ctl_enum_item {
+	/* option name */
+	__u8 item[64];
+};
+
+struct virtio_snd_ctl_iec958 {
+	/* AES/IEC958 channel status bits */
+	__u8 status[24];
+	/* AES/IEC958 subcode bits */
+	__u8 subcode[147];
+	/* nothing */
+	__u8 pad;
+	/* AES/IEC958 subframe bits */
+	__u8 dig_subframe[4];
+};
+
+struct virtio_snd_ctl_value {
+	union {
+		/* VIRTIO_SND_CTL_TYPE_BOOLEAN|INTEGER value */
+		__le32 integer[128];
+		/* VIRTIO_SND_CTL_TYPE_INTEGER64 value */
+		__le64 integer64[64];
+		/* VIRTIO_SND_CTL_TYPE_ENUMERATED value (option indexes) */
+		__le32 enumerated[128];
+		/* VIRTIO_SND_CTL_TYPE_BYTES value */
+		__u8 bytes[512];
+		/* VIRTIO_SND_CTL_TYPE_IEC958 value */
+		struct virtio_snd_ctl_iec958 iec958;
+	} value;
+};
+
+/* supported event reason types */
+enum {
+	/* element's value has changed */
+	VIRTIO_SND_CTL_EVT_MASK_VALUE = 0,
+	/* element's information has changed */
+	VIRTIO_SND_CTL_EVT_MASK_INFO,
+	/* element's metadata has changed */
+	VIRTIO_SND_CTL_EVT_MASK_TLV
+};
+
+struct virtio_snd_ctl_event {
+	/* VIRTIO_SND_EVT_CTL_NOTIFY */
+	struct virtio_snd_hdr hdr;
+	/* 0 ... virtio_snd_config::controls - 1 */
+	__le16 control_id;
+	/* event reason bit map (1 << VIRTIO_SND_CTL_EVT_MASK_XXX) */
+	__le16 mask;
+};
+
 #endif /* VIRTIO_SND_IF_H */
diff --git a/sound/virtio/Makefile b/sound/virtio/Makefile
index 2742bddb8874..a839f8c8b5e6 100644
--- a/sound/virtio/Makefile
+++ b/sound/virtio/Makefile
@@ -7,6 +7,7 @@ virtio_snd-objs := \
 	virtio_chmap.o \
 	virtio_ctl_msg.o \
 	virtio_jack.o \
+	virtio_kctl.o \
 	virtio_pcm.o \
 	virtio_pcm_msg.o \
 	virtio_pcm_ops.o
diff --git a/sound/virtio/virtio_card.c b/sound/virtio/virtio_card.c
index e2847c040f75..61df3476cf70 100644
--- a/sound/virtio/virtio_card.c
+++ b/sound/virtio/virtio_card.c
@@ -64,6 +64,9 @@ static void virtsnd_event_dispatch(struct virtio_snd *snd,
 	case VIRTIO_SND_EVT_PCM_XRUN:
 		virtsnd_pcm_event(snd, event);
 		break;
+	case VIRTIO_SND_EVT_CTL_NOTIFY:
+		virtsnd_kctl_event(snd, event);
+		break;
 	}
 }
 
@@ -235,6 +238,12 @@ static int virtsnd_build_devs(struct virtio_snd *snd)
 	if (rc)
 		return rc;
 
+	if (virtio_has_feature(vdev, VIRTIO_SND_F_CTLS)) {
+		rc = virtsnd_kctl_parse_cfg(snd);
+		if (rc)
+			return rc;
+	}
+
 	if (snd->njacks) {
 		rc = virtsnd_jack_build_devs(snd);
 		if (rc)
@@ -253,6 +262,12 @@ static int virtsnd_build_devs(struct virtio_snd *snd)
 			return rc;
 	}
 
+	if (snd->nkctls) {
+		rc = virtsnd_kctl_build_devs(snd);
+		if (rc)
+			return rc;
+	}
+
 	return snd_card_register(snd->card);
 }
 
@@ -419,10 +434,16 @@ static const struct virtio_device_id id_table[] = {
 	{ 0 },
 };
 
+static unsigned int features[] = {
+	VIRTIO_SND_F_CTLS
+};
+
 static struct virtio_driver virtsnd_driver = {
 	.driver.name = KBUILD_MODNAME,
 	.driver.owner = THIS_MODULE,
 	.id_table = id_table,
+	.feature_table = features,
+	.feature_table_size = ARRAY_SIZE(features),
 	.validate = virtsnd_validate,
 	.probe = virtsnd_probe,
 	.remove = virtsnd_remove,
diff --git a/sound/virtio/virtio_card.h b/sound/virtio/virtio_card.h
index 86ef3941895e..3ceee4e416fc 100644
--- a/sound/virtio/virtio_card.h
+++ b/sound/virtio/virtio_card.h
@@ -31,6 +31,16 @@ struct virtio_snd_queue {
 	struct virtqueue *vqueue;
 };
 
+/**
+ * struct virtio_kctl - VirtIO control element.
+ * @kctl: ALSA control element.
+ * @items: Items for the ENUMERATED element type.
+ */
+struct virtio_kctl {
+	struct snd_kcontrol *kctl;
+	struct virtio_snd_ctl_enum_item *items;
+};
+
 /**
  * struct virtio_snd - VirtIO sound card device.
  * @vdev: Underlying virtio device.
@@ -45,6 +55,9 @@ struct virtio_snd_queue {
  * @nsubstreams: Number of PCM substreams.
  * @chmaps: VirtIO channel maps.
  * @nchmaps: Number of channel maps.
+ * @kctl_infos: VirtIO control element information.
+ * @kctls: VirtIO control elements.
+ * @nkctls: Number of control elements.
  */
 struct virtio_snd {
 	struct virtio_device *vdev;
@@ -59,6 +72,9 @@ struct virtio_snd {
 	u32 nsubstreams;
 	struct virtio_snd_chmap_info *chmaps;
 	u32 nchmaps;
+	struct virtio_snd_ctl_info *kctl_infos;
+	struct virtio_kctl *kctls;
+	u32 nkctls;
 };
 
 /* Message completion timeout in milliseconds (module parameter). */
@@ -108,4 +124,10 @@ int virtsnd_chmap_parse_cfg(struct virtio_snd *snd);
 
 int virtsnd_chmap_build_devs(struct virtio_snd *snd);
 
+int virtsnd_kctl_parse_cfg(struct virtio_snd *snd);
+
+int virtsnd_kctl_build_devs(struct virtio_snd *snd);
+
+void virtsnd_kctl_event(struct virtio_snd *snd, struct virtio_snd_event *event);
+
 #endif /* VIRTIO_SND_CARD_H */
diff --git a/sound/virtio/virtio_kctl.c b/sound/virtio/virtio_kctl.c
new file mode 100644
index 000000000000..0c6ac74aca1e
--- /dev/null
+++ b/sound/virtio/virtio_kctl.c
@@ -0,0 +1,466 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * virtio-snd: Virtio sound device
+ * Copyright (C) 2022 OpenSynergy GmbH
+ */
+#include <sound/control.h>
+#include <linux/virtio_config.h>
+
+#include "virtio_card.h"
+
+/* Map for converting VirtIO types to ALSA types. */
+static const snd_ctl_elem_type_t g_v2a_type_map[] = {
+	[VIRTIO_SND_CTL_TYPE_BOOLEAN] = SNDRV_CTL_ELEM_TYPE_BOOLEAN,
+	[VIRTIO_SND_CTL_TYPE_INTEGER] = SNDRV_CTL_ELEM_TYPE_INTEGER,
+	[VIRTIO_SND_CTL_TYPE_INTEGER64] = SNDRV_CTL_ELEM_TYPE_INTEGER64,
+	[VIRTIO_SND_CTL_TYPE_ENUMERATED] = SNDRV_CTL_ELEM_TYPE_ENUMERATED,
+	[VIRTIO_SND_CTL_TYPE_BYTES] = SNDRV_CTL_ELEM_TYPE_BYTES,
+	[VIRTIO_SND_CTL_TYPE_IEC958] = SNDRV_CTL_ELEM_TYPE_IEC958
+};
+
+/* Map for converting VirtIO access rights to ALSA access rights. */
+static const unsigned int g_v2a_access_map[] = {
+	[VIRTIO_SND_CTL_ACCESS_READ] = SNDRV_CTL_ELEM_ACCESS_READ,
+	[VIRTIO_SND_CTL_ACCESS_WRITE] = SNDRV_CTL_ELEM_ACCESS_WRITE,
+	[VIRTIO_SND_CTL_ACCESS_VOLATILE] = SNDRV_CTL_ELEM_ACCESS_VOLATILE,
+	[VIRTIO_SND_CTL_ACCESS_INACTIVE] = SNDRV_CTL_ELEM_ACCESS_INACTIVE,
+	[VIRTIO_SND_CTL_ACCESS_TLV_READ] = SNDRV_CTL_ELEM_ACCESS_TLV_READ,
+	[VIRTIO_SND_CTL_ACCESS_TLV_WRITE] = SNDRV_CTL_ELEM_ACCESS_TLV_WRITE,
+	[VIRTIO_SND_CTL_ACCESS_TLV_COMMAND] = SNDRV_CTL_ELEM_ACCESS_TLV_COMMAND
+};
+
+/* Map for converting VirtIO event masks to ALSA event masks. */
+static const unsigned int g_v2a_mask_map[] = {
+	[VIRTIO_SND_CTL_EVT_MASK_VALUE] = SNDRV_CTL_EVENT_MASK_VALUE,
+	[VIRTIO_SND_CTL_EVT_MASK_INFO] = SNDRV_CTL_EVENT_MASK_INFO,
+	[VIRTIO_SND_CTL_EVT_MASK_TLV] = SNDRV_CTL_EVENT_MASK_TLV
+};
+
+/**
+ * virtsnd_kctl_info() - Returns information about the control.
+ * @kcontrol: ALSA control element.
+ * @uinfo: Element information.
+ *
+ * Context: Process context.
+ * Return: 0 on success, -errno on failure.
+ */
+static int virtsnd_kctl_info(struct snd_kcontrol *kcontrol,
+			     struct snd_ctl_elem_info *uinfo)
+{
+	struct virtio_snd *snd = kcontrol->private_data;
+	struct virtio_kctl *kctl = &snd->kctls[kcontrol->private_value];
+	struct virtio_snd_ctl_info *kinfo =
+		&snd->kctl_infos[kcontrol->private_value];
+	unsigned int i;
+
+	uinfo->type = g_v2a_type_map[le32_to_cpu(kinfo->type)];
+	uinfo->count = le32_to_cpu(kinfo->count);
+
+	switch (uinfo->type) {
+	case SNDRV_CTL_ELEM_TYPE_INTEGER:
+		uinfo->value.integer.min =
+			le32_to_cpu(kinfo->value.integer.min);
+		uinfo->value.integer.max =
+			le32_to_cpu(kinfo->value.integer.max);
+		uinfo->value.integer.step =
+			le32_to_cpu(kinfo->value.integer.step);
+
+		break;
+	case SNDRV_CTL_ELEM_TYPE_INTEGER64:
+		uinfo->value.integer64.min =
+			le64_to_cpu(kinfo->value.integer64.min);
+		uinfo->value.integer64.max =
+			le64_to_cpu(kinfo->value.integer64.max);
+		uinfo->value.integer64.step =
+			le64_to_cpu(kinfo->value.integer64.step);
+
+		break;
+	case SNDRV_CTL_ELEM_TYPE_ENUMERATED:
+		uinfo->value.enumerated.items =
+			le32_to_cpu(kinfo->value.enumerated.items);
+		i = uinfo->value.enumerated.item;
+		if (i >= uinfo->value.enumerated.items)
+			return -EINVAL;
+
+		strscpy(uinfo->value.enumerated.name, kctl->items[i].item,
+			sizeof(uinfo->value.enumerated.name));
+
+		break;
+	}
+
+	return 0;
+}
+
+/**
+ * virtsnd_kctl_get() - Read the value from the control.
+ * @kcontrol: ALSA control element.
+ * @uvalue: Element value.
+ *
+ * Context: Process context.
+ * Return: 0 on success, -errno on failure.
+ */
+static int virtsnd_kctl_get(struct snd_kcontrol *kcontrol,
+			    struct snd_ctl_elem_value *uvalue)
+{
+	struct virtio_snd *snd = kcontrol->private_data;
+	struct virtio_snd_ctl_info *kinfo =
+		&snd->kctl_infos[kcontrol->private_value];
+	unsigned int type = le32_to_cpu(kinfo->type);
+	unsigned int count = le32_to_cpu(kinfo->count);
+	struct virtio_snd_msg *msg;
+	struct virtio_snd_ctl_hdr *hdr;
+	struct virtio_snd_ctl_value *kvalue;
+	size_t request_size = sizeof(*hdr);
+	size_t response_size = sizeof(struct virtio_snd_hdr) + sizeof(*kvalue);
+	unsigned int i;
+	int rc;
+
+	msg = virtsnd_ctl_msg_alloc(request_size, response_size, GFP_KERNEL);
+	if (!msg)
+		return -ENOMEM;
+
+	virtsnd_ctl_msg_ref(msg);
+
+	hdr = virtsnd_ctl_msg_request(msg);
+	hdr->hdr.code = cpu_to_le32(VIRTIO_SND_R_CTL_READ);
+	hdr->control_id = cpu_to_le32(kcontrol->private_value);
+
+	rc = virtsnd_ctl_msg_send_sync(snd, msg);
+	if (rc)
+		goto on_failure;
+
+	kvalue = (void *)((u8 *)virtsnd_ctl_msg_response(msg) +
+			  sizeof(struct virtio_snd_hdr));
+
+	switch (type) {
+	case VIRTIO_SND_CTL_TYPE_BOOLEAN:
+	case VIRTIO_SND_CTL_TYPE_INTEGER:
+		for (i = 0; i < count; ++i)
+			uvalue->value.integer.value[i] =
+				le32_to_cpu(kvalue->value.integer[i]);
+		break;
+	case VIRTIO_SND_CTL_TYPE_INTEGER64:
+		for (i = 0; i < count; ++i)
+			uvalue->value.integer64.value[i] =
+				le64_to_cpu(kvalue->value.integer64[i]);
+		break;
+	case VIRTIO_SND_CTL_TYPE_ENUMERATED:
+		for (i = 0; i < count; ++i)
+			uvalue->value.enumerated.item[i] =
+				le32_to_cpu(kvalue->value.enumerated[i]);
+		break;
+	case VIRTIO_SND_CTL_TYPE_BYTES:
+		memcpy(uvalue->value.bytes.data, kvalue->value.bytes, count);
+		break;
+	case VIRTIO_SND_CTL_TYPE_IEC958:
+		memcpy(&uvalue->value.iec958, &kvalue->value.iec958,
+		       sizeof(uvalue->value.iec958));
+		break;
+	}
+
+on_failure:
+	virtsnd_ctl_msg_unref(msg);
+
+	return rc;
+}
+
+/**
+ * virtsnd_kctl_put() - Write the value to the control.
+ * @kcontrol: ALSA control element.
+ * @uvalue: Element value.
+ *
+ * Context: Process context.
+ * Return: 0 on success, -errno on failure.
+ */
+static int virtsnd_kctl_put(struct snd_kcontrol *kcontrol,
+			    struct snd_ctl_elem_value *uvalue)
+{
+	struct virtio_snd *snd = kcontrol->private_data;
+	struct virtio_snd_ctl_info *kinfo =
+		&snd->kctl_infos[kcontrol->private_value];
+	unsigned int type = le32_to_cpu(kinfo->type);
+	unsigned int count = le32_to_cpu(kinfo->count);
+	struct virtio_snd_msg *msg;
+	struct virtio_snd_ctl_hdr *hdr;
+	struct virtio_snd_ctl_value *kvalue;
+	size_t request_size = sizeof(*hdr) + sizeof(*kvalue);
+	size_t response_size = sizeof(struct virtio_snd_hdr);
+	unsigned int i;
+
+	msg = virtsnd_ctl_msg_alloc(request_size, response_size, GFP_KERNEL);
+	if (!msg)
+		return -ENOMEM;
+
+	hdr = virtsnd_ctl_msg_request(msg);
+	hdr->hdr.code = cpu_to_le32(VIRTIO_SND_R_CTL_WRITE);
+	hdr->control_id = cpu_to_le32(kcontrol->private_value);
+
+	kvalue = (void *)((u8 *)hdr + sizeof(*hdr));
+
+	switch (type) {
+	case VIRTIO_SND_CTL_TYPE_BOOLEAN:
+	case VIRTIO_SND_CTL_TYPE_INTEGER:
+		for (i = 0; i < count; ++i)
+			kvalue->value.integer[i] =
+				cpu_to_le32(uvalue->value.integer.value[i]);
+		break;
+	case VIRTIO_SND_CTL_TYPE_INTEGER64:
+		for (i = 0; i < count; ++i)
+			kvalue->value.integer64[i] =
+				cpu_to_le64(uvalue->value.integer64.value[i]);
+		break;
+	case VIRTIO_SND_CTL_TYPE_ENUMERATED:
+		for (i = 0; i < count; ++i)
+			kvalue->value.enumerated[i] =
+				cpu_to_le32(uvalue->value.enumerated.item[i]);
+		break;
+	case VIRTIO_SND_CTL_TYPE_BYTES:
+		memcpy(kvalue->value.bytes, uvalue->value.bytes.data, count);
+		break;
+	case VIRTIO_SND_CTL_TYPE_IEC958:
+		memcpy(&kvalue->value.iec958, &uvalue->value.iec958,
+		       sizeof(kvalue->value.iec958));
+		break;
+	}
+
+	return virtsnd_ctl_msg_send_sync(snd, msg);
+}
+
+/**
+ * virtsnd_kctl_tlv_op() - Perform an operation on the control's metadata.
+ * @kcontrol: ALSA control element.
+ * @op_flag: Operation code (SNDRV_CTL_TLV_OP_XXX).
+ * @size: Size of the TLV data in bytes.
+ * @utlv: TLV data.
+ *
+ * Context: Process context.
+ * Return: 0 on success, -errno on failure.
+ */
+static int virtsnd_kctl_tlv_op(struct snd_kcontrol *kcontrol, int op_flag,
+			       unsigned int size, unsigned int __user *utlv)
+{
+	struct virtio_snd *snd = kcontrol->private_data;
+	struct virtio_snd_msg *msg;
+	struct virtio_snd_ctl_hdr *hdr;
+	unsigned int *tlv;
+	struct scatterlist sg;
+	int rc;
+
+	msg = virtsnd_ctl_msg_alloc(sizeof(*hdr), sizeof(struct virtio_snd_hdr),
+				    GFP_KERNEL);
+	if (!msg)
+		return -ENOMEM;
+
+	tlv = kzalloc(size, GFP_KERNEL);
+	if (!tlv) {
+		virtsnd_ctl_msg_unref(msg);
+		return -ENOMEM;
+	}
+
+	sg_init_one(&sg, tlv, size);
+
+	hdr = virtsnd_ctl_msg_request(msg);
+	hdr->control_id = cpu_to_le32(kcontrol->private_value);
+
+	switch (op_flag) {
+	case SNDRV_CTL_TLV_OP_READ:
+		hdr->hdr.code = cpu_to_le32(VIRTIO_SND_R_CTL_TLV_READ);
+
+		rc = virtsnd_ctl_msg_send(snd, msg, NULL, &sg, false);
+		if (!rc) {
+			if (copy_to_user(utlv, tlv, size))
+				rc = -EFAULT;
+		}
+
+		break;
+	case SNDRV_CTL_TLV_OP_WRITE:
+	case SNDRV_CTL_TLV_OP_CMD:
+		if (op_flag == SNDRV_CTL_TLV_OP_WRITE)
+			hdr->hdr.code = cpu_to_le32(VIRTIO_SND_R_CTL_TLV_WRITE);
+		else
+			hdr->hdr.code =
+				cpu_to_le32(VIRTIO_SND_R_CTL_TLV_COMMAND);
+
+		if (copy_from_user(tlv, utlv, size))
+			rc = -EFAULT;
+		else
+			rc = virtsnd_ctl_msg_send(snd, msg, &sg, NULL, false);
+
+		break;
+	}
+
+	kfree(tlv);
+
+	return rc;
+}
+
+/**
+ * virtsnd_kctl_get_enum_items() - Query items for the ENUMERATED element type.
+ * @snd: VirtIO sound device.
+ * @cid: Control element ID.
+ *
+ * This function is called during initial device initialization.
+ *
+ * Context: Any context that permits to sleep.
+ * Return: 0 on success, -errno on failure.
+ */
+static int virtsnd_kctl_get_enum_items(struct virtio_snd *snd, unsigned int cid)
+{
+	struct virtio_device *vdev = snd->vdev;
+	struct virtio_snd_ctl_info *kinfo = &snd->kctl_infos[cid];
+	struct virtio_kctl *kctl = &snd->kctls[cid];
+	struct virtio_snd_msg *msg;
+	struct virtio_snd_ctl_hdr *hdr;
+	unsigned int n = le32_to_cpu(kinfo->value.enumerated.items);
+	struct scatterlist sg;
+
+	msg = virtsnd_ctl_msg_alloc(sizeof(*hdr),
+				    sizeof(struct virtio_snd_hdr), GFP_KERNEL);
+	if (!msg)
+		return -ENOMEM;
+
+	kctl->items = devm_kcalloc(&vdev->dev, n, sizeof(*kctl->items),
+				   GFP_KERNEL);
+	if (!kctl->items) {
+		virtsnd_ctl_msg_unref(msg);
+		return -ENOMEM;
+	}
+
+	sg_init_one(&sg, kctl->items, n * sizeof(*kctl->items));
+
+	hdr = virtsnd_ctl_msg_request(msg);
+	hdr->hdr.code = cpu_to_le32(VIRTIO_SND_R_CTL_ENUM_ITEMS);
+	hdr->control_id = cpu_to_le32(cid);
+
+	return virtsnd_ctl_msg_send(snd, msg, NULL, &sg, false);
+}
+
+/**
+ * virtsnd_kctl_parse_cfg() - Parse the control element configuration.
+ * @snd: VirtIO sound device.
+ *
+ * This function is called during initial device initialization.
+ *
+ * Context: Any context that permits to sleep.
+ * Return: 0 on success, -errno on failure.
+ */
+int virtsnd_kctl_parse_cfg(struct virtio_snd *snd)
+{
+	struct virtio_device *vdev = snd->vdev;
+	u32 i;
+	int rc;
+
+	virtio_cread_le(vdev, struct virtio_snd_config, controls,
+			&snd->nkctls);
+	if (!snd->nkctls)
+		return 0;
+
+	snd->kctl_infos = devm_kcalloc(&vdev->dev, snd->nkctls,
+				       sizeof(*snd->kctl_infos), GFP_KERNEL);
+	if (!snd->kctl_infos)
+		return -ENOMEM;
+
+	snd->kctls = devm_kcalloc(&vdev->dev, snd->nkctls, sizeof(*snd->kctls),
+				  GFP_KERNEL);
+	if (!snd->kctls)
+		return -ENOMEM;
+
+	rc = virtsnd_ctl_query_info(snd, VIRTIO_SND_R_CTL_INFO, 0, snd->nkctls,
+				    sizeof(*snd->kctl_infos), snd->kctl_infos);
+	if (rc)
+		return rc;
+
+	for (i = 0; i < snd->nkctls; ++i) {
+		struct virtio_snd_ctl_info *kinfo = &snd->kctl_infos[i];
+		unsigned int type = le32_to_cpu(kinfo->type);
+
+		if (type == VIRTIO_SND_CTL_TYPE_ENUMERATED) {
+			rc = virtsnd_kctl_get_enum_items(snd, i);
+			if (rc)
+				return rc;
+		}
+	}
+
+	return 0;
+}
+
+/**
+ * virtsnd_kctl_build_devs() - Build ALSA control elements.
+ * @snd: VirtIO sound device.
+ *
+ * Context: Any context that permits to sleep.
+ * Return: 0 on success, -errno on failure.
+ */
+int virtsnd_kctl_build_devs(struct virtio_snd *snd)
+{
+	unsigned int cid;
+
+	for (cid = 0; cid < snd->nkctls; ++cid) {
+		struct virtio_snd_ctl_info *kinfo = &snd->kctl_infos[cid];
+		struct virtio_kctl *kctl = &snd->kctls[cid];
+		struct snd_kcontrol_new kctl_new;
+		unsigned int i;
+		int rc;
+
+		memset(&kctl_new, 0, sizeof(kctl_new));
+
+		kctl_new.iface = SNDRV_CTL_ELEM_IFACE_MIXER;
+		kctl_new.name = kinfo->name;
+		kctl_new.index = le32_to_cpu(kinfo->index);
+
+		for (i = 0; i < ARRAY_SIZE(g_v2a_access_map); ++i)
+			if (le32_to_cpu(kinfo->access) & (1 << i))
+				kctl_new.access |= g_v2a_access_map[i];
+
+		if (kctl_new.access & (SNDRV_CTL_ELEM_ACCESS_TLV_READ |
+				       SNDRV_CTL_ELEM_ACCESS_TLV_WRITE |
+				       SNDRV_CTL_ELEM_ACCESS_TLV_COMMAND)) {
+			kctl_new.access |= SNDRV_CTL_ELEM_ACCESS_TLV_CALLBACK;
+			kctl_new.tlv.c = virtsnd_kctl_tlv_op;
+		}
+
+		kctl_new.info = virtsnd_kctl_info;
+		kctl_new.get = virtsnd_kctl_get;
+		kctl_new.put = virtsnd_kctl_put;
+		kctl_new.private_value = cid;
+
+		kctl->kctl = snd_ctl_new1(&kctl_new, snd);
+		if (!kctl->kctl)
+			return -ENOMEM;
+
+		rc = snd_ctl_add(snd->card, kctl->kctl);
+		if (rc)
+			return rc;
+	}
+
+	return 0;
+}
+
+/**
+ * virtsnd_kctl_event() - Handle the control element event notification.
+ * @snd: VirtIO sound device.
+ * @event: VirtIO sound event.
+ *
+ * Context: Interrupt context.
+ */
+void virtsnd_kctl_event(struct virtio_snd *snd, struct virtio_snd_event *event)
+{
+	struct virtio_snd_ctl_event *kevent =
+		(struct virtio_snd_ctl_event *)event;
+	struct virtio_kctl *kctl;
+	unsigned int cid = le16_to_cpu(kevent->control_id);
+	unsigned int mask = 0;
+	unsigned int i;
+
+	if (cid >= snd->nkctls)
+		return;
+
+	for (i = 0; i < ARRAY_SIZE(g_v2a_mask_map); ++i)
+		if (le16_to_cpu(kevent->mask) & (1 << i))
+			mask |= g_v2a_mask_map[i];
+
+
+	kctl = &snd->kctls[cid];
+
+	snd_ctl_notify(snd->card, mask, &kctl->kctl->id);
+}
-- 
2.25.1


