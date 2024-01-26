Return-Path: <linux-kernel+bounces-40621-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D238783E34D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 21:23:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 35F41B21135
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 20:23:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2BF222EFD;
	Fri, 26 Jan 2024 20:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="afVUdK9M"
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DF33225CD
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 20:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.18.73.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706300610; cv=none; b=Z4hG50JwN6s7U3p2BJyOyBH29oDYPUklkhCPeSnhlsxJh+l6oe9czwDX6qWYvkCPkV4gxk7jJy6Ow4xXC0LcMBaMEchD7HBjZNdeoX4QoP9Cd6U0PjqD5YPTd02cxgrZxd8U3gOCmlLOTO5OUDXfG/MRshmHBmnFtolqOfdiDys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706300610; c=relaxed/simple;
	bh=ZXBxdNVcmkcTYjXC/0G39DDqx4LYDazQ5Vm4ydRHxXg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TYHgoi/sr+ithxXy+BwGchFy8UNfu14IH+eVjFXlRLzmJYSjD/zf4uoJDNjZdD7anqPkX9v8rRLm8ySUMidDomaxLaInGeLSg6srElgTpSNHNIkH4fdFcnm7L0WATeaWJVlWR63jX50HfLFTbyhlT1S0Ssk90sYBjlDVK7pY+cM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=sberdevices.ru; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=afVUdK9M; arc=none smtp.client-ip=37.18.73.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sberdevices.ru
Received: from p-infra-ksmg-sc-msk01 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id E22D0100005;
	Fri, 26 Jan 2024 23:09:23 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru E22D0100005
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1706299763;
	bh=Fp/qhJPJ8j0f/d0J1CVPjhGQk511RNu42rI5IGIpC9w=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=afVUdK9MA9DndX1nkQgJxZhfijeQMLhvRIBOzGkkA2EJZVyhwkcK0TCuBRdCoWirD
	 qPFtJvYb1EJ6Z19/+gNO6D2zsC2xeDJleMkCUo0f2CZNGkp379oXoapmx/RBM/f8f1
	 aLlqLdjzOAUK7d6sSrcATw7AwGyGriTNmUq8C2qNx4/pNFj8QhV9PoSZyqmP7pEvfO
	 JjaLCd5BGQQUUsK1ZSQG1hpG4g6DBv9aYAzfUp1Yn5C4Tusnv2e+bEVcZ+EBqY/+Kt
	 xk63WcVzFlP+oEM+HiDPBnH9uEOMV5Zj/IyuP6IsSHF2mOI6JBynlmf3RAQcCAY3+r
	 t11Q90MNQHP6A==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Fri, 26 Jan 2024 23:09:16 +0300 (MSK)
Received: from CAB-WSD-0003115.sberdevices.ru (100.64.160.123) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 26 Jan 2024 23:09:08 +0300
From: Jan Dakinevich <jan.dakinevich@salutedevices.com>
To: Mark Brown <broonie@kernel.org>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <kernel@salutedevices.com>, Jan Dakinevich
	<jan.dakinevich@salutedevices.com>
Subject: [RFC] regmap: rework ->max_register handling
Date: Fri, 26 Jan 2024 23:08:36 +0300
Message-ID: <20240126200836.1829995-1-jan.dakinevich@salutedevices.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 182973 [Jan 26 2024]
X-KSMG-AntiSpam-Version: 6.1.0.3
X-KSMG-AntiSpam-Envelope-From: YVDakinevich@sberdevices.ru
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 7 0.3.7 6d6bf5bd8eea7373134f756a2fd73e9456bb7d1a, {Tracking_smtp_not_equal_from}, {Tracking_from_domain_doesnt_match_to}, smtp.sberdevices.ru:7.1.1,5.0.1;salutedevices.com:7.1.1;127.0.0.199:7.1.2;sberdevices.ru:7.1.1,5.0.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;100.64.160.123:7.1.2, FromAlignment: n, {Tracking_smtp_domain_mismatch}, {Tracking_smtp_domain_2level_mismatch}, {Tracking_white_helo}, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/01/26 14:25:00 #23442014
X-KSMG-AntiVirus-Status: Clean, skipped

---- >8 ----
Indeed, it is an ugly workaround, but we need to pass an extra
information to regmap. Another approach I'm thinking about is to
introduce special macro for ->max_register initialization:

    #define REGMAP_MAX_REGISTER_IS_0 UINT_MAX
    #define REGMAP_MAX_REGISTER(_max) ((_max) ?: REGMAP_MAX_REGISTER_IS_0)

and initialize regmap_config in the following way:

    struct regmap_config config = {
        ...
        .max_register = REGMAP_MAX_REGISTER(...),
    };

This will eliminate the need for an extra flag in the config. But this
approach has another disadvantage, it imposes an extra requirement,
that is not satisfied by existing code.
---- >8 ----

When regmap consists of single register, 'regmap' subsystem is unable to
understand whether ->max_register is set or not, because in both cases it
is equal to zero. It leads to that the logic based on value of
->max_register doesn't work. For example using of REGCACHE_FLAT fails.

This patch introduces an extra parameter to regmap config, indicating
that zero value in ->max_register is authentic.

Signed-off-by: Jan Dakinevich <jan.dakinevich@salutedevices.com>
---
 drivers/base/regmap/internal.h      |  1 +
 drivers/base/regmap/regcache-flat.c |  2 +-
 drivers/base/regmap/regcache.c      |  4 +++-
 drivers/base/regmap/regmap.c        | 10 ++++++----
 include/linux/regmap.h              |  5 +++++
 5 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/drivers/base/regmap/internal.h b/drivers/base/regmap/internal.h
index 583dd5d7d46b..bcdb25bec77c 100644
--- a/drivers/base/regmap/internal.h
+++ b/drivers/base/regmap/internal.h
@@ -93,6 +93,7 @@ struct regmap {
 #endif
 
 	unsigned int max_register;
+	bool max_register_is_set;
 	bool (*writeable_reg)(struct device *dev, unsigned int reg);
 	bool (*readable_reg)(struct device *dev, unsigned int reg);
 	bool (*volatile_reg)(struct device *dev, unsigned int reg);
diff --git a/drivers/base/regmap/regcache-flat.c b/drivers/base/regmap/regcache-flat.c
index b7e4b2464102..9b17c77dec9d 100644
--- a/drivers/base/regmap/regcache-flat.c
+++ b/drivers/base/regmap/regcache-flat.c
@@ -23,7 +23,7 @@ static int regcache_flat_init(struct regmap *map)
 	int i;
 	unsigned int *cache;
 
-	if (!map || map->reg_stride_order < 0 || !map->max_register)
+	if (!map || map->reg_stride_order < 0 || !map->max_register_is_set)
 		return -EINVAL;
 
 	map->cache = kcalloc(regcache_flat_get_index(map, map->max_register)
diff --git a/drivers/base/regmap/regcache.c b/drivers/base/regmap/regcache.c
index ac63a73ccdaa..2e41cb12b8e2 100644
--- a/drivers/base/regmap/regcache.c
+++ b/drivers/base/regmap/regcache.c
@@ -187,8 +187,10 @@ int regcache_init(struct regmap *map, const struct regmap_config *config)
 			return 0;
 	}
 
-	if (!map->max_register && map->num_reg_defaults_raw)
+	if (!map->max_register_is_set && map->num_reg_defaults_raw) {
 		map->max_register = (map->num_reg_defaults_raw  - 1) * map->reg_stride;
+		map->max_register_is_set = true;
+	}
 
 	if (map->cache_ops->init) {
 		dev_dbg(map->dev, "Initializing %s cache\n",
diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
index 6db77d8e45f9..5cb425f6f02d 100644
--- a/drivers/base/regmap/regmap.c
+++ b/drivers/base/regmap/regmap.c
@@ -89,7 +89,7 @@ EXPORT_SYMBOL_GPL(regmap_check_range_table);
 
 bool regmap_writeable(struct regmap *map, unsigned int reg)
 {
-	if (map->max_register && reg > map->max_register)
+	if (map->max_register_is_set && reg > map->max_register)
 		return false;
 
 	if (map->writeable_reg)
@@ -112,7 +112,7 @@ bool regmap_cached(struct regmap *map, unsigned int reg)
 	if (!map->cache_ops)
 		return false;
 
-	if (map->max_register && reg > map->max_register)
+	if (map->max_register_is_set && reg > map->max_register)
 		return false;
 
 	map->lock(map->lock_arg);
@@ -129,7 +129,7 @@ bool regmap_readable(struct regmap *map, unsigned int reg)
 	if (!map->reg_read)
 		return false;
 
-	if (map->max_register && reg > map->max_register)
+	if (map->max_register_is_set && reg > map->max_register)
 		return false;
 
 	if (map->format.format_write)
@@ -787,6 +787,7 @@ struct regmap *__regmap_init(struct device *dev,
 	map->bus = bus;
 	map->bus_context = bus_context;
 	map->max_register = config->max_register;
+	map->max_register_is_set = map->max_register ?: config->max_register_is_0;
 	map->wr_table = config->wr_table;
 	map->rd_table = config->rd_table;
 	map->volatile_table = config->volatile_table;
@@ -1412,6 +1413,7 @@ int regmap_reinit_cache(struct regmap *map, const struct regmap_config *config)
 	regmap_debugfs_exit(map);
 
 	map->max_register = config->max_register;
+	map->max_register_is_set = map->max_register ?: config->max_register_is_0;
 	map->writeable_reg = config->writeable_reg;
 	map->readable_reg = config->readable_reg;
 	map->volatile_reg = config->volatile_reg;
@@ -3383,7 +3385,7 @@ EXPORT_SYMBOL_GPL(regmap_get_val_bytes);
  */
 int regmap_get_max_register(struct regmap *map)
 {
-	return map->max_register ? map->max_register : -EINVAL;
+	return map->max_register_is_set ? map->max_register : -EINVAL;
 }
 EXPORT_SYMBOL_GPL(regmap_get_max_register);
 
diff --git a/include/linux/regmap.h b/include/linux/regmap.h
index c9182a47736e..b743241cfb7c 100644
--- a/include/linux/regmap.h
+++ b/include/linux/regmap.h
@@ -332,6 +332,10 @@ typedef void (*regmap_unlock)(void *);
  * @io_port:	  Support IO port accessors. Makes sense only when MMIO vs. IO port
  *		  access can be distinguished.
  * @max_register: Optional, specifies the maximum valid register address.
+ * @max_register_is_0: Optional, specifies that zero value in @max_register
+ *                     should be taken into account. This is a workaround to
+ *                     apply handling of @max_register for regmap that contains
+ *                     only one register.
  * @wr_table:     Optional, points to a struct regmap_access_table specifying
  *                valid ranges for write access.
  * @rd_table:     As above, for read access.
@@ -422,6 +426,7 @@ struct regmap_config {
 	bool io_port;
 
 	unsigned int max_register;
+	bool max_register_is_0;
 	const struct regmap_access_table *wr_table;
 	const struct regmap_access_table *rd_table;
 	const struct regmap_access_table *volatile_table;
-- 
2.34.1


