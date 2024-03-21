Return-Path: <linux-kernel+bounces-110601-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 93E9A886124
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 20:36:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C14491C21D66
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 19:36:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB9DC136997;
	Thu, 21 Mar 2024 19:34:36 +0000 (UTC)
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1BBC13442F;
	Thu, 21 Mar 2024 19:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711049676; cv=none; b=RwoT3qAEvNIb3QwNFag/1V7ldnD3ExeiyNfhZf90OWF7dBsA8jVwoNGuoO7jLcjmIX7TJ90Z3Nv8lEwX+qHaBoY36hJ3sdDBZisn2qaZSe4KXjSS3wo1k89spNfBALAyYao0P94eERbVUI6DcqKxqn6qPt0ByB/d9mBKg3v+c6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711049676; c=relaxed/simple;
	bh=VQOLGE5b1WT05ny2MJKIquB+OOdiTR6lMQ9qYMzFM0I=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ksk7hU5+OvOHWxYpvmhJB050C/rZ0cQ7uXIclYqJuOcKv20rSHSF9NL8VlZYJBqs0WguzDpzMgGSW7TgQgPlYEF2xlqJ9vPqhbVysqeq1LDZyn2+16+7nF4Lo47YpufwxvGZlCC3XHZM3OC+uIa1nNDmtW8T8RV0oumFwjCsLvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.96.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1rnOB5-0000GQ-0D;
	Thu, 21 Mar 2024 19:34:15 +0000
Date: Thu, 21 Mar 2024 19:34:11 +0000
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
Subject: [PATCH 5/8] dt-bindings: mmc: mmc-card: add block device nodes
Message-ID: <8d837b883de9f9d745819c5304cfb8aed9a6085c.1711048433.git.daniel@makrotopia.org>
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

Add nodes representing the block devices exposed by an MMC device
including an example involving nvmem-cells.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 .../devicetree/bindings/mmc/mmc-card.yaml     | 45 +++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/mmc-card.yaml b/Documentation/devicetree/bindings/mmc/mmc-card.yaml
index fd347126449ac..95ccbda871d24 100644
--- a/Documentation/devicetree/bindings/mmc/mmc-card.yaml
+++ b/Documentation/devicetree/bindings/mmc/mmc-card.yaml
@@ -26,6 +26,18 @@ properties:
       Use this to indicate that the mmc-card has a broken hpi
       implementation, and that hpi should not be used.
 
+  block:
+    $ref: /schemas/block/block-device.yaml#
+    description:
+      Represents the block storage provided by an SD card or the
+      main hardware partition of an eMMC.
+
+patternProperties:
+  '^boot[0-9]+':
+    $ref: /schemas/block/block-device.yaml#
+    description:
+      Represents a boot hardware partition on an eMMC.
+
 required:
   - compatible
   - reg
@@ -42,6 +54,39 @@ examples:
             compatible = "mmc-card";
             reg = <0>;
             broken-hpi;
+
+            block {
+                partitions {
+                    cal_data: block-partition-rf {
+                        partnum = <3>;
+                        partname = "rf";
+
+                        nvmem-layout {
+                            compatible = "fixed-layout";
+                            #address-cells = <1>;
+                            #size-cells = <1>;
+
+                            eeprom@0 {
+                                reg = <0x0 0x1000>;
+                            };
+                        };
+                    };
+                };
+            };
+
+            boot1 {
+                nvmem-layout {
+                    compatible = "fixed-layout";
+                    #address-cells = <1>;
+                    #size-cells = <1>;
+
+                    macaddr: macaddr@a {
+                        compatible = "mac-base";
+                        reg = <0xa 0x6>;
+                        #nvmem-cell-cells = <1>;
+                    };
+                };
+            };
         };
     };
 
-- 
2.44.0

