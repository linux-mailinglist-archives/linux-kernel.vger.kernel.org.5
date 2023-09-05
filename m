Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95154792575
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 18:22:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245209AbjIEQUc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:20:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354415AbjIEL1l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 07:27:41 -0400
Received: from AUS01-SY4-obe.outbound.protection.outlook.com (mail-sy4aus01olkn2169.outbound.protection.outlook.com [40.92.62.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90F761AE;
        Tue,  5 Sep 2023 04:27:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XZYC+G8W/wHswo126k6QMY0UEGLIBuDaeYlBzNZVPGbOnSgKIHl/y4qdNejr94GX844DZh5w7BbPx/jnimM+V4daiFq7CeHshoXAFiY+ynfuo1ITYxqGIloBLM2LvNuFmZyNbb1PC7nJg0FP/lTYZG23UTsXN2pbgqjmDuXwQ0zSE47RVIkyOpvWELr+aElEJnq6yD4rgEgESoGMJz1utKd02QN52gSVwXnqg5/FszgnhAlxSjdy/FsGtmsluWSxyshSODz9iJq3fC2fMNF0AwdyIs57ePh9J3yig8XIdGCulHWkT+fIyVYT+Fh+PembpLkPVSM/2xPcjNKwQ2f11A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZV1jfBQJTdlaTb9AJaEU7wTiQTdWHPksKJfAk5caves=;
 b=bGFNWC+c6odKZZSNIFJ2jHlpWMjCqJsJIMwaRo/RoJn33IntIbAiEs47Bp+qt0j2GPTNW/omM4rQfwqehi4YJDY0Hh8mP2xhvLRMBHcDBS4eTIaffXSRLyKPzoEXHFZ1tDgKHNg3I0+/bjfdzI/KZOm+gfICAzJEwLtTfAQhRHMFV5G8Myp5EiZX0Owlrri44sJd+9SymgUSP1mnfHWZJKkYvtriZMmMHanOLsqhLkHKnv2kO4qGzmQAaqnqkQhZIskMXfybjArbWBfiw4lJqLNbKMN15JGHa4MQcjOAWKP4UOSqELXtipCDkm+IiPR/AO5MI01n4JK7fbaPeI+7Lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZV1jfBQJTdlaTb9AJaEU7wTiQTdWHPksKJfAk5caves=;
 b=twi0k74w5T/tXFwjS4mJyq8Tqr5gDtAgINpMpdiFPtCPR2UyMvIDrW72lz028A8iqnNCGCQi+GQb1Dpl6MVB3U8DGAqJJUAaIYPe2YlxY9tB6lPynLmQqu98yj4amSUTGwsfHtifFcnf+19nuriFEmBzL52okJ4px6g5nXcLaaGtV7NbRFjYDpknKdZnyGyTJKRIfLdCAe5ksVO0wfK3Ve8bBUdkCoN4UDNulwPQdhamQ9MVuQJdivN5aJYli0DX78Tim4kGJpbnwbLk+Ot7T2L+B/pFp+9Pz4ycf3vfLhLb9ji/uDTvBWpWQftPqikcGKWQ4iGembsUtfsOxqqXkg==
Received: from MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:14c::12)
 by SY6P282MB3213.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:164::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.33; Tue, 5 Sep
 2023 11:27:31 +0000
Received: from MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM
 ([fe80::beb:8e33:17b1:a347]) by MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM
 ([fe80::beb:8e33:17b1:a347%4]) with mapi id 15.20.6745.030; Tue, 5 Sep 2023
 11:27:31 +0000
From:   Jinjian Song <songjinjian@hotmail.com>
To:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, corbet@lwn.net, loic.poulain@linaro.org,
        ryazanov.s.a@gmail.com
Cc:     jiri@resnulli.us, johannes@sipsolutions.net,
        chandrashekar.devegowda@intel.com, linuxwwan@intel.com,
        chiranjeevi.rapolu@linux.intel.com, haijun.liu@mediatek.com,
        m.chetan.kumar@linux.intel.com, ricardo.martinez@linux.intel.com,
        netdev@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, nmarupaka@google.com,
        vsankar@lenovo.com, danielwinkler@google.com,
        Jinjian Song <jinjian.song@fibocom.com>
Subject: [net-next v3 3/5] net: wwan: t7xx: Creates region & snapshot for coredump log collection
Date:   Tue,  5 Sep 2023 19:26:35 +0800
Message-ID: <MEYP282MB2697959ECDE02DD1A88F3DFABBE8A@MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230905112637.18877-1-songjinjian@hotmail.com>
References: <20230905112637.18877-1-songjinjian@hotmail.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [CIjnzUYyH3SvvVoPRhKwBfRG1TY4ptps]
X-ClientProxiedBy: SGAP274CA0006.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::18)
 To MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:14c::12)
X-Microsoft-Original-Message-ID: <20230905112637.18877-4-songjinjian@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MEYP282MB2697:EE_|SY6P282MB3213:EE_
X-MS-Office365-Filtering-Correlation-Id: cbd59c7d-0956-4fd3-ff74-08dbae0317a6
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jCa9EpKyhFagXW97zP5Xnu7a8d8wQXEuPibYXNVXmGlQcjOCezmkjHXt7vheZPMhyQ19zIrpm35gvgEVdXgjPgCtcgXMd1yn0g762d81bYvyyqTnIJiXjhZUlzUs0FleVY14F3sb+nWy5UsfTenr/2UiZ67OtXp1sid5ETttnpQNO9kEGvlu+eX8ieeyKV3RqGdB82MSMCdn566oIhcZ/NKvB7jLuMcvLwzIeVeQby9r0KRypznxQgrghAPiI1M1sjwcJom4qiWp7oU5URlLFoXaFQoNRvFubKeXxcKIWbGKbc2UKhUdpHAwCDXvknVfNOQP50134vJzrODwLDsYjqwuPjtuBlkC7ftLwvy6M79TNM47eod7eUWmdBBftecGsyWZHU0qUk2SQJUiv5uXpJNI9modhiQdrgDRKwp1oCkhSELsQCO90a7/vfgCsM+LK3MeC1Yu2lIqCVk70JHCNSYjjiW7g8MbljyxKRK5BWWeiUXAM9EPXd2nD9QJFf7CS0l3iQlleOY0QVpIkDps5NKiCoLKoCDvAagu3wr6Z10uvZAX9MvZLcYZyLSLIgVd
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3tBbmanMy+E9vqNKe7YMh1SmLA8uAQ8MVedv4FmbnBAlqY3kPGcOB9+vSyeI?=
 =?us-ascii?Q?7K5EIHi0pHILhcNW1LjdCm6nizKVDgEZ5cLoCzoyonf6g/JoKr1KOiqlqYF8?=
 =?us-ascii?Q?TgFTgtf/5UwUmlN6DGfXMv8xVa3OedgM9aN5rvtf3mqNPE0GvMypYNjO30xo?=
 =?us-ascii?Q?GuK47JBVeD0QTGpgTDbarJiE+5QK4KWoQ8vGdH1h5rA8tQKEsifNfo9kcAzK?=
 =?us-ascii?Q?oDa4WbzUeXPp1ZnlXqi8vWTHYyu8ez4UDUOM17+YQ9+hqNMw1jriZkcw+mgn?=
 =?us-ascii?Q?yW/6dywT2MVDwedtX0jcVnSvdMG+z24KggPwLk6lYgztYRwl35vdYMIiLDCJ?=
 =?us-ascii?Q?HPs/uAb2y4S8/LrpVR9pQ7jsB+fxtsM3rKccPcNNqt1ZsuwHDopFT3xYIDAT?=
 =?us-ascii?Q?F4BpGXve7HN8WsN8VnUsCQtTgBVbTjdFa5bPmdsXG6PxjFwxe0o7i9jaTdhx?=
 =?us-ascii?Q?bg047+5TDYzntTbLPzgTov31k84Kx0XiriUUYP25/qiTOJeNAGapGEFfPE1m?=
 =?us-ascii?Q?jpb3GTIH9IKh4lA9Ce9NOrJzT2Tipj4G0PAYnbLiKweJy0Sn5ZG1Qr3FTVEA?=
 =?us-ascii?Q?KDr55NUU/VRQUAhVFH8aMX833Fa9bRuW8zaZptxWZBv+bvVI93aRtEV7R0uX?=
 =?us-ascii?Q?aBEgjqCWGS/1zPKllziMct2254CbdrC7xAyeGg1cuE5LuDEuhkLDSyhNoN1t?=
 =?us-ascii?Q?R41OjLAA2oYstrdQxVT8OwF19CgZdrhuOEMpoHDsJCWNx/HLorwtRNuR5zLy?=
 =?us-ascii?Q?+oBNp2E1smVlrBtCLjtjWFAMUQg/kudp98pzM/h1w4jHdZqwfU4L9bggvx55?=
 =?us-ascii?Q?+pcSUYurlxvZ50dWXGtkXJeoAA5K782ssYPqKHzACPWS/RzmDodx59yFnIzG?=
 =?us-ascii?Q?NKOzTZ+uTLxXskshlO3vs0pHNwIJ2kGS+MRAqmO4p4f3gn7UFSsD1LfcLTMJ?=
 =?us-ascii?Q?a4vCmPUTP+h/SxJ/bUJXOrnMMZBryuRaq/srdKz1C8ZsQ46nET3hf6iFL19g?=
 =?us-ascii?Q?do0Z6wjVuJAjI21kUfvtE6pan7VvsjRuYfOIrPZLMKb/mD/VYE2/QjMfnX0H?=
 =?us-ascii?Q?v5Pfzj9dxni1L9SgWtGuNXCAlhfVXela/Voqh30X/WuUPKHnyrmf47zL64Ug?=
 =?us-ascii?Q?8LnqYYhbbxmzDzqzurEHgqzIN9BJGquwk3Oyt4L5paqm5dTLu9/AY1H4lMrQ?=
 =?us-ascii?Q?xl3ryUpHqt/3uPtoVgnMh77wYpPfHPo7Zeh7PbwDyqxb/+1DS9r14d1Y/sk?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-746f3.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: cbd59c7d-0956-4fd3-ff74-08dbae0317a6
X-MS-Exchange-CrossTenant-AuthSource: MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2023 11:27:31.2399
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY6P282MB3213
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jinjian Song <jinjian.song@fibocom.com>

Adds support for t7xx wwan device coredump collection using devlink.

In case of coredump collection when wwan device encounters an exception
it reboots & stays in fastboot mode for coredump collection by host driver.
On detecting exception state driver collects the core dump, creates the
devlink region & reports an event to user space application for dump
collection. The user space application invokes devlink region read command
for dump collection.

Below are the devlink commands used for coredump collection.

devlink region new pci/$BDF/mr_dump
devlink region read pci/$BDF/mr_dump snapshot $ID address $ADD length $LEN
devlink region del pci/$BDF/mr_dump snapshot $ID

Base on the v5 patch version of follown series:
'net: wwan: t7xx: fw flashing & coredump support'
(https://patchwork.kernel.org/project/netdevbpf/patch/fc8bbb0b66a5ff3a489ea9857d79b374508090ef.1674307425.git.m.chetan.kumar@linux.intel.com/)

Signed-off-by: Jinjian Song <jinjian.song@fibocom.com>
---
v3:
 * no change
v2:
 * rename function name from devlink to flash_dump
---
 drivers/net/wwan/t7xx/t7xx_port_flash_dump.c | 256 ++++++++++++++++++-
 drivers/net/wwan/t7xx/t7xx_port_flash_dump.h |  39 +++
 drivers/net/wwan/t7xx/t7xx_state_monitor.c   |   2 +
 3 files changed, 296 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wwan/t7xx/t7xx_port_flash_dump.c b/drivers/net/wwan/t7xx/t7xx_port_flash_dump.c
index 1129ef793798..b8ef3b7d7430 100644
--- a/drivers/net/wwan/t7xx/t7xx_port_flash_dump.c
+++ b/drivers/net/wwan/t7xx/t7xx_port_flash_dump.c
@@ -9,6 +9,11 @@
 #include "t7xx_port_ap_msg.h"
 #include "t7xx_port_flash_dump.h"
 
+static struct t7xx_dump_region_info t7xx_dump_region_infos[] = {
+	[T7XX_MRDUMP_INDEX] = {"mr_dump", T7XX_MRDUMP_SIZE},
+	[T7XX_LKDUMP_INDEX] = {"lk_dump", T7XX_LKDUMP_SIZE},
+};
+
 static int t7xx_flash_dump_port_read(struct t7xx_port *port, char *buf, size_t count)
 {
 	struct sk_buff *skb;
@@ -130,6 +135,151 @@ static int t7xx_flash_dump_fb_raw_command(char *cmd, struct t7xx_port *port, cha
 	return ret;
 }
 
+static int t7xx_flash_dump_fb_cmd_send(struct t7xx_port *port, char *cmd)
+{
+	int len = strlen(cmd);
+	int ret;
+
+	ret = t7xx_flash_dump_port_write(port, cmd, len);
+	if (ret == len)
+		return 0;
+
+	return ret;
+}
+
+static int t7xx_flash_dump_fb_get_core(struct t7xx_port *port)
+{
+	u32 mrd_mb = T7XX_MRDUMP_SIZE / (1024 * 1024);
+	struct t7xx_flash_dump *flash_dump = port->t7xx_dev->flash_dump;
+	char mcmd[T7XX_FB_MCMD_SIZE + 1];
+	size_t offset_dlen = 0;
+	int clen, dlen, ret;
+
+	flash_dump->regions[T7XX_MRDUMP_INDEX].buf =
+		vmalloc(flash_dump->regions[T7XX_MRDUMP_INDEX].info->size);
+	if (!flash_dump->regions[T7XX_MRDUMP_INDEX].buf)
+		return -ENOMEM;
+
+	set_bit(T7XX_MRDUMP_STATUS, &flash_dump->status);
+	ret = t7xx_flash_dump_fb_raw_command(T7XX_FB_CMD_OEM_MRDUMP, port, NULL);
+	if (ret) {
+		dev_err(port->dev, "%s command failed\n", T7XX_FB_CMD_OEM_MRDUMP);
+		goto free_mem;
+	}
+
+	while (flash_dump->regions[T7XX_MRDUMP_INDEX].info->size > offset_dlen) {
+		clen = t7xx_flash_dump_port_read(port, mcmd, sizeof(mcmd) - 1);
+		if (clen <= 0)
+			goto free_mem;
+
+		mcmd[clen] = '\0';
+		if (!strcmp(mcmd, T7XX_FB_CMD_RTS)) {
+			memset(mcmd, 0, sizeof(mcmd));
+			ret = t7xx_flash_dump_fb_cmd_send(port, T7XX_FB_CMD_CTS);
+			if (ret < 0) {
+				dev_err(port->dev, "write for _CTS failed:%zu\n",
+					strlen(T7XX_FB_CMD_CTS));
+				goto free_mem;
+			}
+
+			dlen = t7xx_flash_dump_port_read(port,
+							 flash_dump->regions[T7XX_MRDUMP_INDEX].buf
+							 + offset_dlen, T7XX_FB_MDATA_SIZE);
+			if (dlen <= 0) {
+				dev_err(port->dev, "read data error(%d)\n", dlen);
+				ret = dlen;
+				goto free_mem;
+			}
+			offset_dlen += dlen;
+
+			ret = t7xx_flash_dump_fb_cmd_send(port, T7XX_FB_CMD_FIN);
+			if (ret < 0) {
+				dev_err(port->dev, "_FIN failed, (Read %05zu:%05zu)\n",
+					strlen(T7XX_FB_CMD_FIN), offset_dlen);
+				goto free_mem;
+			}
+			continue;
+		} else if (!strcmp(mcmd, T7XX_FB_RESP_MRDUMP_DONE)) {
+			dev_dbg(port->dev, "%s! size:%zd\n", T7XX_FB_RESP_MRDUMP_DONE, offset_dlen);
+			clear_bit(T7XX_MRDUMP_STATUS, &flash_dump->status);
+			return 0;
+		}
+		dev_err(port->dev, "getcore protocol error (read len %05d, response %s)\n",
+			clen, mcmd);
+		ret = -EPROTO;
+		goto free_mem;
+	}
+
+	dev_err(port->dev, "mrdump exceeds %uMB size. Discarded!\n", mrd_mb);
+
+free_mem:
+	vfree(flash_dump->regions[T7XX_MRDUMP_INDEX].buf);
+	clear_bit(T7XX_MRDUMP_STATUS, &flash_dump->status);
+	return ret;
+}
+
+static int t7xx_flash_dump_fb_dump_log(struct t7xx_port *port)
+{
+	struct t7xx_flash_dump *flash_dump = port->t7xx_dev->flash_dump;
+	struct t7xx_dump_region *lkdump_region;
+	char rsp[T7XX_FB_RESPONSE_SIZE];
+	int datasize = 0, ret;
+	size_t offset = 0;
+
+	if (flash_dump->status != T7XX_DEVLINK_IDLE) {
+		dev_err(&flash_dump->t7xx_dev->pdev->dev, "Modem is busy!\n");
+		return -EBUSY;
+	}
+
+	set_bit(T7XX_LKDUMP_STATUS, &flash_dump->status);
+	ret = t7xx_flash_dump_fb_raw_command(T7XX_FB_CMD_OEM_LKDUMP, port, rsp);
+	if (ret) {
+		dev_err(port->dev, "%s command returns failure\n", T7XX_FB_CMD_OEM_LKDUMP);
+		goto err_clear_bit;
+	}
+
+	ret = kstrtoint(rsp, 16, &datasize);
+	if (ret) {
+		dev_err(port->dev, "bad value\n");
+		goto err_clear_bit;
+	}
+
+	lkdump_region = &flash_dump->regions[T7XX_LKDUMP_INDEX];
+	if (datasize > lkdump_region->info->size) {
+		dev_err(port->dev, "lkdump size is more than %dKB. Discarded!\n",
+			T7XX_LKDUMP_SIZE / 1024);
+		ret = -EFBIG;
+		goto err_clear_bit;
+	}
+
+	lkdump_region->buf = vmalloc(lkdump_region->info->size);
+	if (!lkdump_region->buf) {
+		ret = -ENOMEM;
+		goto err_clear_bit;
+	}
+
+	while (datasize > 0) {
+		int dlen = t7xx_flash_dump_port_read(port, lkdump_region->buf + offset, datasize);
+
+		if (dlen <= 0) {
+			dev_err(port->dev, "lkdump read error ret = %d\n", dlen);
+			ret = dlen;
+			goto err_clear_bit;
+		}
+
+		datasize -= dlen;
+		offset += dlen;
+	}
+
+	dev_dbg(port->dev, "LKDUMP DONE! size:%zd\n", offset);
+	clear_bit(T7XX_LKDUMP_STATUS, &flash_dump->status);
+	return t7xx_flash_dump_fb_handle_response(port, NULL);
+
+err_clear_bit:
+	clear_bit(T7XX_LKDUMP_STATUS, &flash_dump->status);
+	return ret;
+}
+
 static int t7xx_flash_dump_fb_download_command(struct t7xx_port *port, size_t size)
 {
 	char download_command[T7XX_FB_COMMAND_SIZE];
@@ -355,6 +505,67 @@ static const struct devlink_ops devlink_flash_ops = {
 	.reload_up = t7xx_devlink_reload_up,
 };
 
+static int t7xx_flash_dump_region_snapshot(struct devlink *dl, const struct devlink_region_ops *ops,
+					   struct netlink_ext_ack *extack, u8 **data)
+{
+	struct t7xx_flash_dump *flash_dump = devlink_priv(dl);
+	struct t7xx_dump_region *region = ops->priv;
+	struct t7xx_port *port = flash_dump->port;
+	u8 *snapshot_mem;
+
+	if (flash_dump->status != T7XX_DEVLINK_IDLE)
+		return -EBUSY;
+
+	if (!strncmp(ops->name, "mr_dump", strlen("mr_dump"))) {
+		snapshot_mem = vmalloc(region->info->size);
+		memcpy(snapshot_mem, region->buf, region->info->size);
+		*data = snapshot_mem;
+	} else if (!strncmp(ops->name, "lk_dump", strlen("lk_dump"))) {
+		int ret;
+
+		ret = t7xx_flash_dump_fb_dump_log(port);
+		if (ret)
+			return ret;
+
+		*data = region->buf;
+	}
+
+	return 0;
+}
+
+static_assert(ARRAY_SIZE(t7xx_dump_region_infos) ==
+	      ARRAY_SIZE(((struct t7xx_flash_dump *)NULL)->regions));
+
+/* To create regions for dump files */
+static int t7xx_flash_dump_create_regions(struct t7xx_flash_dump *flash_dump)
+{
+	int ret, i;
+
+	for (i = 0; i < ARRAY_SIZE(t7xx_dump_region_infos); i++) {
+		flash_dump->regions[i].info = &t7xx_dump_region_infos[i];
+		flash_dump->regions[i].ops.name = flash_dump->regions[i].info->name;
+		flash_dump->regions[i].ops.snapshot = t7xx_flash_dump_region_snapshot;
+		flash_dump->regions[i].ops.destructor = vfree;
+		flash_dump->regions[i].dlreg = devlink_region_create(flash_dump->ctx,
+								     &flash_dump->regions[i].ops,
+								     T7XX_MAX_SNAPSHOTS,
+								     t7xx_dump_region_infos[i].size
+								     );
+		if (IS_ERR(flash_dump->regions[i].dlreg)) {
+			ret = PTR_ERR(flash_dump->regions[i].dlreg);
+			dev_err(flash_dump->port->dev, "create region failed, err %d\n", ret);
+			while (i >= 0)
+				devlink_region_destroy(flash_dump->regions[i--].dlreg);
+
+			return ret;
+		}
+
+		flash_dump->regions[i].ops.priv = &flash_dump->regions[i];
+	}
+
+	return 0;
+}
+
 int t7xx_devlink_register(struct t7xx_pci_dev *t7xx_dev)
 {
 	union devlink_param_value value;
@@ -379,6 +590,14 @@ int t7xx_devlink_register(struct t7xx_pci_dev *t7xx_dev)
 	return 0;
 }
 
+static void t7xx_flash_dump_work(struct work_struct *work)
+{
+	struct t7xx_flash_dump *flash_dump;
+
+	flash_dump = container_of(work, struct t7xx_flash_dump, ws);
+	t7xx_flash_dump_fb_get_core(flash_dump->port);
+}
+
 void t7xx_devlink_unregister(struct t7xx_pci_dev *t7xx_dev)
 {
 	struct devlink *dl_ctx = t7xx_dev->flash_dump->ctx;
@@ -399,29 +618,64 @@ void t7xx_devlink_unregister(struct t7xx_pci_dev *t7xx_dev)
 static int t7xx_port_flash_dump_init(struct t7xx_port *port)
 {
 	struct t7xx_flash_dump *flash_dump = port->t7xx_dev->flash_dump;
+	struct workqueue_struct *flash_dump_wq;
+	int rc;
+
+	flash_dump_wq = create_workqueue("t7xx_flash_dump");
+	if (!flash_dump_wq) {
+		dev_err(port->dev, "create_workqueue failed\n");
+		return -ENODATA;
+	}
 
+	INIT_WORK(&flash_dump->ws, t7xx_flash_dump_work);
 	port->rx_length_th = T7XX_MAX_QUEUE_LENGTH;
 
 	flash_dump->mode = T7XX_NORMAL_MODE;
 	flash_dump->status = T7XX_DEVLINK_IDLE;
+	flash_dump->wq = flash_dump_wq;
 	flash_dump->port = port;
 
+	rc = t7xx_flash_dump_create_regions(flash_dump);
+	if (rc) {
+		destroy_workqueue(flash_dump->wq);
+		dev_err(port->dev, "devlink region creation failed, rc %d\n", rc);
+		return -ENOMEM;
+	}
+
 	return 0;
 }
 
 static void t7xx_port_flash_dump_uninit(struct t7xx_port *port)
 {
 	struct t7xx_flash_dump *flash_dump = port->t7xx_dev->flash_dump;
+	int i;
+
+	vfree(flash_dump->regions[T7XX_MRDUMP_INDEX].buf);
 
 	flash_dump->mode = T7XX_NORMAL_MODE;
+	destroy_workqueue(flash_dump->wq);
+
+	for (i = 0; i < ARRAY_SIZE(t7xx_dump_region_infos); ++i)
+		devlink_region_destroy(flash_dump->regions[i].dlreg);
 
 	skb_queue_purge(&port->rx_skb_list);
 }
 
+static int t7xx_flash_dump_enable_chl(struct t7xx_port *port)
+{
+	struct t7xx_flash_dump *flash_dump = port->t7xx_dev->flash_dump;
+
+	t7xx_port_enable_chl(port);
+	if (flash_dump->mode == T7XX_FB_DUMP_MODE)
+		queue_work(flash_dump->wq, &flash_dump->ws);
+
+	return 0;
+}
+
 struct port_ops flash_dump_port_ops = {
 	.init = &t7xx_port_flash_dump_init,
 	.recv_skb = &t7xx_port_enqueue_skb,
 	.uninit = &t7xx_port_flash_dump_uninit,
-	.enable_chl = &t7xx_port_enable_chl,
+	.enable_chl = &t7xx_flash_dump_enable_chl,
 	.disable_chl = &t7xx_port_disable_chl,
 };
diff --git a/drivers/net/wwan/t7xx/t7xx_port_flash_dump.h b/drivers/net/wwan/t7xx/t7xx_port_flash_dump.h
index 7614c01dcb2c..90758baa7854 100644
--- a/drivers/net/wwan/t7xx/t7xx_port_flash_dump.h
+++ b/drivers/net/wwan/t7xx/t7xx_port_flash_dump.h
@@ -12,28 +12,67 @@
 #define T7XX_MAX_QUEUE_LENGTH 32
 #define T7XX_FB_COMMAND_SIZE  64
 #define T7XX_FB_RESPONSE_SIZE 512
+#define T7XX_FB_MCMD_SIZE     64
+#define T7XX_FB_MDATA_SIZE    1024
 #define T7XX_FB_RESP_COUNT    30
 
+#define T7XX_FB_EVENT_SIZE      50
+
+#define T7XX_MAX_SNAPSHOTS  1
+#define T7XX_MRDUMP_SIZE    (160 * 1024 * 1024)
+#define T7XX_LKDUMP_SIZE    (256 * 1024)
+#define T7XX_TOTAL_REGIONS  2
+
 #define T7XX_FLASH_STATUS   0
+#define T7XX_MRDUMP_STATUS  1
+#define T7XX_LKDUMP_STATUS  2
 #define T7XX_GET_INFO       3
 
 #define T7XX_DEVLINK_IDLE   0
 #define T7XX_NORMAL_MODE    0
 #define T7XX_FB_DL_MODE     1
+#define T7XX_FB_DUMP_MODE   2
 
+#define T7XX_FB_CMD_RTS          "_RTS"
+#define T7XX_FB_CMD_CTS          "_CTS"
+#define T7XX_FB_CMD_FIN          "_FIN"
+#define T7XX_FB_CMD_OEM_MRDUMP   "oem mrdump"
+#define T7XX_FB_CMD_OEM_LKDUMP   "oem dump_pllk_log"
 #define T7XX_FB_CMD_DOWNLOAD     "download"
 #define T7XX_FB_CMD_FLASH        "flash"
 #define T7XX_FB_CMD_REBOOT       "reboot"
+#define T7XX_FB_RESP_MRDUMP_DONE "MRDUMP08_DONE"
 #define T7XX_FB_RESP_OKAY        "OKAY"
 #define T7XX_FB_RESP_FAIL        "FAIL"
 #define T7XX_FB_RESP_DATA        "DATA"
 #define T7XX_FB_RESP_INFO        "INFO"
 #define T7XX_FB_CMD_GET_VER      "get_version"
 
+/* Internal region indexes */
+enum t7xx_regions {
+	T7XX_MRDUMP_INDEX,
+	T7XX_LKDUMP_INDEX,
+};
+
+struct t7xx_dump_region_info {
+	const char *name;
+	size_t size;
+};
+
+struct t7xx_dump_region {
+	struct t7xx_dump_region_info *info;
+	struct devlink_region_ops ops;
+	struct devlink_region *dlreg;
+	void *buf;
+};
+
 struct t7xx_flash_dump {
 	struct t7xx_pci_dev *t7xx_dev;
 	struct t7xx_port *port;
 	struct devlink *ctx;
+	struct t7xx_dump_region regions[T7XX_TOTAL_REGIONS];
+	struct workqueue_struct *wq;
+	struct work_struct ws;
 	unsigned long status;
 	u8 mode;
 };
diff --git a/drivers/net/wwan/t7xx/t7xx_state_monitor.c b/drivers/net/wwan/t7xx/t7xx_state_monitor.c
index 24f79e981fd9..86cdb0d572d4 100644
--- a/drivers/net/wwan/t7xx/t7xx_state_monitor.c
+++ b/drivers/net/wwan/t7xx/t7xx_state_monitor.c
@@ -244,6 +244,8 @@ static void t7xx_lk_stage_event_handling(struct t7xx_fsm_ctl *ctl, unsigned int
 
 		if (lk_event == LK_EVENT_CREATE_POST_DL_PORT)
 			md->t7xx_dev->flash_dump->mode = T7XX_FB_DL_MODE;
+		else
+			md->t7xx_dev->flash_dump->mode = T7XX_FB_DUMP_MODE;
 
 		port->port_conf->ops->enable_chl(port);
 		t7xx_cldma_start(md_ctrl);
-- 
2.34.1

