Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37D217E9098
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Nov 2023 14:31:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231927AbjKLN2p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Nov 2023 08:28:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231803AbjKLN22 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Nov 2023 08:28:28 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08D3246AE;
        Sun, 12 Nov 2023 05:27:42 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3128C433CC;
        Sun, 12 Nov 2023 13:27:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699795661;
        bh=y0TfggzpWPb/Wa1ssWhr5QrBaCm4qGZr1+mG4H75+iI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rp+uNag7p/eUBqJrjcwFyacEd8gE47bjey8O33VwbQV3r9ztB2kF+rBI+0Q6IeA42
         JI4HmPsS/iVd+02helf2/623Z2fbM91jG1O1wq/Hb3J3aDCuD0HIj42gkigmgw+Nuo
         85nHhAkUJJOYnjlEGBarUs7s/vgEQsqH7G1ePqUX6pKk1sRh7xGB6stBwaF1rBdi7F
         YC4Yn7y4Iw6Gc6hNooP3rqe+xUgBtpJyI9wirMJqclrv2vre+WSqsJS/TACaHdUx+O
         bHQpv6VgXVLoGynSs65woUwSPQ2qlnsKdKw5HEa06CAhCaBkMaAvRfUkXsKMOTKPgx
         nkwRO8q8QpmWA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Arnd Bergmann <arnd@arndb.de>, Sasha Levin <sashal@kernel.org>,
        linux-media@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 03/11] media: ipu-bridge: increase sensor_name size
Date:   Sun, 12 Nov 2023 08:27:26 -0500
Message-ID: <20231112132736.175494-3-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231112132736.175494-1-sashal@kernel.org>
References: <20231112132736.175494-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.1
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hans Verkuil <hverkuil-cisco@xs4all.nl>

[ Upstream commit 83d0d4cc1423194b580356966107379490edd02e ]

Fixes this compiler warning:

In file included from include/linux/property.h:14,
                 from include/linux/acpi.h:16,
                 from drivers/media/pci/intel/ipu-bridge.c:4:
In function 'ipu_bridge_init_swnode_names',
    inlined from 'ipu_bridge_create_connection_swnodes' at drivers/media/pci/intel/ipu-bridge.c:445:2,
    inlined from 'ipu_bridge_connect_sensor' at drivers/media/pci/intel/ipu-bridge.c:656:3:
include/linux/fwnode.h:81:49: warning: '%u' directive output may be truncated writing between 1 and 3 bytes into a region of size 2 [-Wformat-truncation=]
   81 | #define SWNODE_GRAPH_PORT_NAME_FMT              "port@%u"
      |                                                 ^~~~~~~~~
drivers/media/pci/intel/ipu-bridge.c:384:18: note: in expansion of macro 'SWNODE_GRAPH_PORT_NAME_FMT'
  384 |                  SWNODE_GRAPH_PORT_NAME_FMT, sensor->link);
      |                  ^~~~~~~~~~~~~~~~~~~~~~~~~~
include/linux/fwnode.h: In function 'ipu_bridge_connect_sensor':
include/linux/fwnode.h:81:55: note: format string is defined here
   81 | #define SWNODE_GRAPH_PORT_NAME_FMT              "port@%u"
      |                                                       ^~
In function 'ipu_bridge_init_swnode_names',
    inlined from 'ipu_bridge_create_connection_swnodes' at drivers/media/pci/intel/ipu-bridge.c:445:2,
    inlined from 'ipu_bridge_connect_sensor' at drivers/media/pci/intel/ipu-bridge.c:656:3:
include/linux/fwnode.h:81:49: note: directive argument in the range [0, 255]
   81 | #define SWNODE_GRAPH_PORT_NAME_FMT              "port@%u"
      |                                                 ^~~~~~~~~
drivers/media/pci/intel/ipu-bridge.c:384:18: note: in expansion of macro 'SWNODE_GRAPH_PORT_NAME_FMT'
  384 |                  SWNODE_GRAPH_PORT_NAME_FMT, sensor->link);
      |                  ^~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/media/pci/intel/ipu-bridge.c:382:9: note: 'snprintf' output between 7 and 9 bytes into a destination of size 7
  382 |         snprintf(sensor->node_names.remote_port,
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  383 |                  sizeof(sensor->node_names.remote_port),
      |                  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  384 |                  SWNODE_GRAPH_PORT_NAME_FMT, sensor->link);
      |                  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Acked-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/media/ipu-bridge.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/media/ipu-bridge.h b/include/media/ipu-bridge.h
index bdc654a455216..783bda6d5cc3f 100644
--- a/include/media/ipu-bridge.h
+++ b/include/media/ipu-bridge.h
@@ -108,7 +108,7 @@ struct ipu_node_names {
 	char ivsc_sensor_port[7];
 	char ivsc_ipu_port[7];
 	char endpoint[11];
-	char remote_port[7];
+	char remote_port[9];
 	char vcm[16];
 };
 
-- 
2.42.0

