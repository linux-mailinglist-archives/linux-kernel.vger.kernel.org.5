Return-Path: <linux-kernel+bounces-110591-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A9BF886107
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 20:33:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22A0D282AD0
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 19:33:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F53613442F;
	Thu, 21 Mar 2024 19:33:48 +0000 (UTC)
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54019134412;
	Thu, 21 Mar 2024 19:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711049628; cv=none; b=rAMKIDS6XygnD/+vQmeEBlA4NCBYzbOKen5g5rF8K3OTW2YcTtn07sHk9Js8AbA6zwmc+/6xvyWaGWwueJSvS8C5CPPJenF2yp8eHW1YMMEOfAnd+4eYxGyz32AOpwzoqrPl0hstNKH6IIiWjYNpD93t/Np3yHUmTVYD3xJmhyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711049628; c=relaxed/simple;
	bh=xWOwvbPZgST6WT++t4v3lHbMbLvITOiRaYTKtbxJdgw=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y8GzDDoenjgb0ZCY1xJy32n1jfTkSbSSxQHGlKTYn5VBBi9rkZymjlJDaioU/otAelHnxwpXuyvT/ShXiRkxFMLp1/TSK4GGNDgp0g/4Wq0HinJA2pAzWN5gYRoBya5h1I2REOT/6JTcaVhpbKqK3vIa2ULZX9ESqXmI5PdjZwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.96.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1rnOAE-0000Db-2U;
	Thu, 21 Mar 2024 19:33:22 +0000
Date: Thu, 21 Mar 2024 19:32:48 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>, Jens Axboe <axboe@kernel.dk>,
	Daniel Golle <daniel@makrotopia.org>,
	Dave Chinner <dchinner@redhat.com>, Jan Kara <jack@suse.cz>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
	Damien Le Moal <dlemoal@kernel.org>,
	Li Lingfeng <lilingfeng3@huawei.com>,
	Christian Brauner <brauner@kernel.org>,
	Christian Heusel <christian@heusel.eu>,
	Min Li <min15.li@samsung.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Avri Altman <avri.altman@wdc.com>, Hannes Reinecke <hare@suse.de>,
	Christian Loehle <CLoehle@hyperstone.com>,
	Bean Huo <beanhuo@micron.com>, Yeqi Fu <asuk4.q@gmail.com>,
	Victor Shih <victor.shih@genesyslogic.com.tw>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Dominique Martinet <dominique.martinet@atmark-techno.com>,
	"Ricardo B. Marliere" <ricardo@marliere.net>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org, linux-block@vger.kernel.org
Subject: [PATCH 1/8] dt-bindings: block: add basic bindings for block devices
Message-ID: <28dcc69ecf9d55e95991d8f2a8e19f71bbd32af0.1711048433.git.daniel@makrotopia.org>
References: <cover.1711048433.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1711048433.git.daniel@makrotopia.org>

Add bindings for block devices which are used to allow referencing
nvmem bits on them.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 .../bindings/block/block-device.yaml          | 22 ++++++++
 .../devicetree/bindings/block/partition.yaml  | 51 +++++++++++++++++++
 .../devicetree/bindings/block/partitions.yaml | 20 ++++++++
 3 files changed, 93 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/block/block-device.yaml
 create mode 100644 Documentation/devicetree/bindings/block/partition.yaml
 create mode 100644 Documentation/devicetree/bindings/block/partitions.yaml

diff --git a/Documentation/devicetree/bindings/block/block-device.yaml b/Documentation/devicetree/bindings/block/block-device.yaml
new file mode 100644
index 0000000000000..c83ea525650ba
--- /dev/null
+++ b/Documentation/devicetree/bindings/block/block-device.yaml
@@ -0,0 +1,22 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/block/block-device.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: block storage device
+
+description: |
+  This binding is generic and describes a block-oriented storage device.
+
+maintainers:
+  - Daniel Golle <daniel@makrotopia.org>
+
+properties:
+  partitions:
+    $ref: /schemas/block/partitions.yaml
+
+  nvmem-layout:
+    $ref: /schemas/nvmem/layouts/nvmem-layout.yaml#
+
+unevaluatedProperties: false
diff --git a/Documentation/devicetree/bindings/block/partition.yaml b/Documentation/devicetree/bindings/block/partition.yaml
new file mode 100644
index 0000000000000..86b61e30f9a41
--- /dev/null
+++ b/Documentation/devicetree/bindings/block/partition.yaml
@@ -0,0 +1,51 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/block/partition.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Partition on a block device
+
+description: |
+  This binding describes a partition on a block device.
+  Partitions may be matched by a combination of partition number, name,
+  and UUID.
+
+maintainers:
+  - Daniel Golle <daniel@makrotopia.org>
+
+properties:
+  $nodename:
+    pattern: '^block-partition-.+$'
+
+  partnum:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      Matches partition by number if present.
+
+  partname:
+    $ref: /schemas/types.yaml#/definitions/string
+    description:
+      Matches partition by PARTNAME if present.
+
+  partuuid:
+    $ref: /schemas/types.yaml#/definitions/string
+    description:
+      Matches partition by PARTUUID if present.
+
+  nvmem-layout:
+    $ref: /schemas/nvmem/layouts/nvmem-layout.yaml#
+    description:
+      This container may reference an NVMEM layout parser.
+
+anyOf:
+  - required:
+      - partnum
+
+  - required:
+      - partname
+
+  - required:
+      - partuuid
+
+unevaluatedProperties: false
diff --git a/Documentation/devicetree/bindings/block/partitions.yaml b/Documentation/devicetree/bindings/block/partitions.yaml
new file mode 100644
index 0000000000000..fd84c3ba8493b
--- /dev/null
+++ b/Documentation/devicetree/bindings/block/partitions.yaml
@@ -0,0 +1,20 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/block/partitions.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Partitions on block devices
+
+description: |
+  This binding is generic and describes the content of the partitions container
+  node.
+
+maintainers:
+  - Daniel Golle <daniel@makrotopia.org>
+
+patternProperties:
+  "^block-partition-.+$":
+    $ref: partition.yaml
+
+unevaluatedProperties: false
-- 
2.44.0

