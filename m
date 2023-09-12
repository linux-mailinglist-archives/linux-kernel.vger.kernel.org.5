Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 576CF79CC58
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 11:50:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232898AbjILJuC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 05:50:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232917AbjILJt7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 05:49:59 -0400
Received: from AUS01-SY4-obe.outbound.protection.outlook.com (mail-sy4aus01olkn2155.outbound.protection.outlook.com [40.92.62.155])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC24BE6C;
        Tue, 12 Sep 2023 02:49:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VDcs6u6lSIaVML//v+8iCk5/lzfJd5FNbIay3uwWRHjt+MS5YTbgJdKlgmr+cDlLINbzMPjNuMKOxlzlADG3MO8c8e/iy0w2o7IlWXWhHG2SMCxBWB0vH8h0qGbRD7tlMdhFpJGboUKL1burGSOUAVWm8TcsLzer5gM3BFZsVWC3mn8s8IE8I+02qiJyGNFCVCuqHD4EZK7O8nPFOg0Yy9sHaUKwVU+VtHwnvtjrXLJ9flWBRpu0pP6z8Y9l15yb07VDrMKzLpc/+nx9wkhikVL3C6DT41Z9XtDD3WmooN+E+pAmu0b5cADazqlA9PkG/SsJZ0NbIDwFkNvc/f7obQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x1ON2lIXDXmijZaqWzsXZFy1gNW7vJ4qARHbNm90A0U=;
 b=Ep8XkdXrS0tFvsRX/hPMBwGe1zSFa3mpclREQsjtTLMgsZPSQo+DtAqB7Ns14z0d+//x3P+urFMD0qGSNBF+Thv5XlmBQ+8gUN+S0VLZ9RDt4yBaLyJ52e35zADVq+q49Net9T5JJwY0a4AloLyLoV6T3JR4aGAbmAcNXpl7k85UBKYpsB/lOy9LWg+ATrpQYcR+w7T6nT8WbR66dgECvv6Nw+ik4HroWZZ0E4T19i+wZafyxeoEKe4YBPXbukyIqi0NzL0pmFy+CKorVC1VsH0Dk39rlMfu86SCYYcq/B/WV3vIBoWoHPTTRsn1bnhg2dJIbmAJjeJkxjWR94wIjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x1ON2lIXDXmijZaqWzsXZFy1gNW7vJ4qARHbNm90A0U=;
 b=eWUqNr9bzw/Rg87hB3y72SzIKTxs9XOhc6B220Xc4qszvhZ40tIWTHY8uW1dt+jxMVf6hjWz6Pqm78IiQQDmC7dQOnhiNHCTxTgiG6Hv5FAwB9SjkTeTjsKc6GifTqCGwg0prTAkcdS4JowPJxAjcQSjs+5tUEdkESWsoy8Q00MhtVf7Whr1XImxOeUWH1JrFJlEjYwMsNGzWYLts8Km0WLaVZLw3EFptJdTwY3rfIpaXoj5KDlDdi6UaqMu0Cnur3iUAacdGyOt6BQQReYwrrrWo8Ap0w7+iYJDNKDCjZZ8Z1hfaFZcASftuVJqPRegGtl4SauxAQ+3YEb3py1Jxg==
Received: from ME3P282MB2703.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:16b::5)
 by SY4P282MB2981.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:15c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.35; Tue, 12 Sep
 2023 09:49:43 +0000
Received: from ME3P282MB2703.AUSP282.PROD.OUTLOOK.COM
 ([fe80::68b4:6263:97f:9a45]) by ME3P282MB2703.AUSP282.PROD.OUTLOOK.COM
 ([fe80::68b4:6263:97f:9a45%3]) with mapi id 15.20.6768.036; Tue, 12 Sep 2023
 09:49:43 +0000
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
Subject: [net-next v4 3/5] net: wwan: t7xx: Creates region & snapshot for coredump log collection
Date:   Tue, 12 Sep 2023 17:48:43 +0800
Message-ID: <ME3P282MB2703D49F0B73BE8D50918582BBF1A@ME3P282MB2703.AUSP282.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230912094845.11233-1-songjinjian@hotmail.com>
References: <20230912094845.11233-1-songjinjian@hotmail.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [yEC8JhMDWlnSUI3jy8vqNQhlIeTwNTdI]
X-ClientProxiedBy: SI2PR01CA0048.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::17) To ME3P282MB2703.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:220:16b::5)
X-Microsoft-Original-Message-ID: <20230912094845.11233-4-songjinjian@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ME3P282MB2703:EE_|SY4P282MB2981:EE_
X-MS-Office365-Filtering-Correlation-Id: 30945674-e3ef-45ba-3089-08dbb3759724
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9mgSHWf1YMWwvudydukzo5+o4v3MeNimdRCG1yKRJ9UAkraedRp6q9vb4D6doXFC6uuzeVQJzDEjpF36ZH8vvABT0KcVC4m7tUXo/3VbewawZMwgRzeVU5oEJsLv24yRUssR/5aPiXrdaaKhL3Ts1I/GIEDMKHtHaxHNk+QjzHNoW3SL2Rc6KzYR0cKsZ5eDG+m8dcO8n8kzdj7JS4sMQY9rbb36OGvGwgKgLPc4sZjqOa1u9Rpkmm/GQJ6BZy84l2AomiFVf+i39LoPstwtd+QfEaOmhIFaJjJKfcPqmmbkKA2jRBP37ORuFGcMLrzFgDiYz6tjDgbsknc+nMxakfgUMD0Zz15oW99nQiA7MAaXHQTvySJjN9VxuEbqDr0vyOxSH/dZM6jN1UgMZM6Jy4HMHxe1nE1uUxe9S5XlVfHVcrO17ZcvXfdL2qyWWZghsXsEcRBviBknlennaK5KvqzXHHcL1lzYiijzCO0omFM+7o602MadrHNFT3mkNw9riUr4K9yE63J93QCoZeWlNDND09gTxyd0YYc7NnOpAZiCJ8+L1os8GWSx3E9AMoWm1QFImO+Ja0Od7mKG+ePCiajYlwYSF1qH2Jv5qzNABbo=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2REIklQRakn2uxyqHnG1XVzvMHNK1ZCVYZ6ugAFY+5gln4532l1TpJTzQ+V6?=
 =?us-ascii?Q?zUk267ZHQGQgJ+BWdb+oxjhcDUKRWTljwqHuPY0n6Swk+cQgvLdwE24KRqsC?=
 =?us-ascii?Q?kGI7ZLx89mRZ6XvS7lIlNwxcmfcKyxerKbV8z9erzh5trP6oJMoGwRN4n08b?=
 =?us-ascii?Q?q4OG0mlS1I1Qp8WWAZ8p2LqANYEnuFiRyfKuE1aSR+5InoxVC1kLhPWMxVMR?=
 =?us-ascii?Q?mW3PRBYcNeHpLNIW755d+G7dWYRkAySBiIMDqL/1XUr+LvNpuRRhNrdIE4Bc?=
 =?us-ascii?Q?5A+6IIWK74aszs3IXB9H25VxSFL0RTh/toOt6X4mRhXOra/SVM8zSyRQtIll?=
 =?us-ascii?Q?x8O0uctuHpXGqDiH0lV+TvemiM5qo1o7bmxBI6QPexGUzT2BixFVicZi+Dd1?=
 =?us-ascii?Q?Et9N8vRFDRhDIVyEl2uIhsv0Xj+gfUtLYBsBFUKkmO6g/T75mM862GP25c/M?=
 =?us-ascii?Q?2ECG08BthYQRHrq1ABOmGr8OYBpihw2d9crav+WeRmGko0YeOvNKA5ZBrI5x?=
 =?us-ascii?Q?YbmOOAgpF99m4mfxZP59cGqD1MYneVFRbu+GG5Mo9jn3NrUW94TzpfPL6XsX?=
 =?us-ascii?Q?3XHjiZJZHoxDNbFBNNQ5Eufm40tU2LZ0n74QbFG8Vxyn6cDXafpxPF3wRHm5?=
 =?us-ascii?Q?4yba65gO9Zna5OhhI0yFFh7BTyqK92wpZLCQbdB8WX0CQHkDtiYQ88VGTGCo?=
 =?us-ascii?Q?DnVc5cANv7DsuF196R5uxswHbybVYzOEZhwV3FBvQAq7puJcLUV/Oemfb/rV?=
 =?us-ascii?Q?hr0HQ4SMBvSBjGa5XnahcOM6HHhWTToTjmI0gokR7lAwiYJNIGztE1nZKFOE?=
 =?us-ascii?Q?j24OLvp9HDb/r/nAiLZwVXZhhUd8HiKZVKgNMovKNGx7/oXRcVyU4qdyEYs/?=
 =?us-ascii?Q?g+YWBHJzAp42jis3AR+a9Nx7CB619gy7IBO9C5rZ2rIoZa7zUYrB7gt5gI8J?=
 =?us-ascii?Q?bSzD1i6gJW1SZzOdirc45/p5Wa6hg0IKlL5SOmMexESiPb/721PqcyMvnfZS?=
 =?us-ascii?Q?DLkICSf7/0A6UE66EtWOto0cdAWcLu+UOWfaPYcAwga9PVotXDx8y41lGFcr?=
 =?us-ascii?Q?MQGF98jHRLOUP6kFpeNS7N5QRJ8Bok27e+Iie6OgaHLWjGxM37PONejK5WAW?=
 =?us-ascii?Q?wzNhiQR1pcFiyWj+/7jp5IIMQhojhoNeqpDzai9brQEmwBPz8dkxTwSzv8xr?=
 =?us-ascii?Q?zTZNqGJXxwlpEvijJ9YdheALAQwbJoX8dh5hEEl+/IRCNG7LrE3eqTdYBm4?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-746f3.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 30945674-e3ef-45ba-3089-08dbb3759724
X-MS-Exchange-CrossTenant-AuthSource: ME3P282MB2703.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2023 09:49:43.3935
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY4P282MB2981
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
v4:
 * no change
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

