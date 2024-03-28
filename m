Return-Path: <linux-kernel+bounces-104832-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EC9587D44D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 20:04:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 559401C22158
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 19:04:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C9FE524D8;
	Fri, 15 Mar 2024 19:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RkNryIjH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9C654E1B5;
	Fri, 15 Mar 2024 19:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710529456; cv=none; b=QVH5pXrdf2XyoGwlhrzI5NkkNYA0wYJX0F+q83IoNv1g60F66d7XQUWlTB/gI/kaCgvO0VCP/QRrRoqlEfw7pOxXucxvxjYj+k4W4SA4x7OH52QpJUKN4JmZgF4vigwJhW21voevVMBvTJYMtW6weGkkZGy1qNO+Adr632wO1W4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710529456; c=relaxed/simple;
	bh=ePbUWUjISenfWIdHdyt0gRxFTA6OwUOdRzu6dxH07rs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O9XloHW9IqS/J9JWRSkVdkGehYVsQZEXAtbt2djeYb3jtEudvFjbK09Y4cgy3SmCyAu6iyu3v5Ky/LuASApet2Qnnb3ncIXf7i8BiXHxYNF0CNT5x8Qacl4FevCCbkmywx+5QDl7tZ3kru9W1lzaHcFCCrhU5Tl5LBUoDJeIEnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RkNryIjH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5413C43390;
	Fri, 15 Mar 2024 19:04:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710529456;
	bh=ePbUWUjISenfWIdHdyt0gRxFTA6OwUOdRzu6dxH07rs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RkNryIjHwx1YvQYqQSfhha4yF04rq4UTjxHVsMaA11/dTOpp/7pkBbcCFGXVZe0EO
	 o5pwMaBUkLRXLxI/DVWOuuwPuZXhsH7MpvUCUDU3zpCJ0uuX+9Acwnm7m8HByRVK8i
	 6HfUeDilwHmW8FJKjzFuddkpoZyYQkNO8yS42mQfVJazQkMyfovWrjnfknJ6sBBffC
	 FsMrADwG0uZp76aEhGw+t9dE2s1Dfb2In4NivZ+CHucWegy9K5DeK5rFZAFxIPkDCf
	 KmcDWN6+YKJQfKyGxgW35svSSjnrrXsrx1knHOvWUYUUZp+aBxoqDANi8BHG92+l+Y
	 4TXIHRUOciwiQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	gregkh@linuxfoundation.org
Subject: Re: Linux 5.10.213
Date: Fri, 15 Mar 2024 15:04:10 -0400
Message-ID: <20240315190412.1843035-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240315190412.1843035-1-sashal@kernel.org>
References: <20240315190412.1843035-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

diff --git a/Makefile b/Makefile
index d7ec0be4cd791..b6af62d53d7a6 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 5
 PATCHLEVEL = 10
-SUBLEVEL = 212
+SUBLEVEL = 213
 EXTRAVERSION =
 NAME = Dare mighty things
 
diff --git a/arch/um/Kconfig b/arch/um/Kconfig
index eb1c6880bde49..20264b47dcffc 100644
--- a/arch/um/Kconfig
+++ b/arch/um/Kconfig
@@ -92,6 +92,19 @@ config LD_SCRIPT_DYN
 	depends on !LD_SCRIPT_STATIC
 	select MODULE_REL_CRCS if MODVERSIONS
 
+config LD_SCRIPT_DYN_RPATH
+	bool "set rpath in the binary" if EXPERT
+	default y
+	depends on LD_SCRIPT_DYN
+	help
+	  Add /lib (and /lib64 for 64-bit) to the linux binary's rpath
+	  explicitly.
+
+	  You may need to turn this off if compiling for nix systems
+	  that have their libraries in random /nix directories and
+	  might otherwise unexpected use libraries from /lib or /lib64
+	  instead of the desired ones.
+
 config HOSTFS
 	tristate "Host filesystem"
 	help
diff --git a/arch/um/Makefile b/arch/um/Makefile
index 56e5320da7624..4211e23a2f68f 100644
--- a/arch/um/Makefile
+++ b/arch/um/Makefile
@@ -118,7 +118,8 @@ archprepare:
 	$(Q)$(MAKE) $(build)=$(HOST_DIR)/um include/generated/user_constants.h
 
 LINK-$(CONFIG_LD_SCRIPT_STATIC) += -static
-LINK-$(CONFIG_LD_SCRIPT_DYN) += -Wl,-rpath,/lib $(call cc-option, -no-pie)
+LINK-$(CONFIG_LD_SCRIPT_DYN) += $(call cc-option, -no-pie)
+LINK-$(CONFIG_LD_SCRIPT_DYN_RPATH) += -Wl,-rpath,/lib
 
 CFLAGS_NO_HARDENING := $(call cc-option, -fno-PIC,) $(call cc-option, -fno-pic,) \
 	-fno-stack-protector $(call cc-option, -fno-stack-protector-all)
diff --git a/arch/x86/Makefile.um b/arch/x86/Makefile.um
index 1db7913795f51..b3c1ae084180d 100644
--- a/arch/x86/Makefile.um
+++ b/arch/x86/Makefile.um
@@ -44,7 +44,7 @@ ELF_FORMAT := elf64-x86-64
 
 # Not on all 64-bit distros /lib is a symlink to /lib64. PLD is an example.
 
-LINK-$(CONFIG_LD_SCRIPT_DYN) += -Wl,-rpath,/lib64
+LINK-$(CONFIG_LD_SCRIPT_DYN_RPATH) += -Wl,-rpath,/lib64
 LINK-y += -m64
 
 endif
diff --git a/drivers/base/regmap/internal.h b/drivers/base/regmap/internal.h
index 0097696c31de2..2720d8d7bbfc9 100644
--- a/drivers/base/regmap/internal.h
+++ b/drivers/base/regmap/internal.h
@@ -104,6 +104,10 @@ struct regmap {
 	int (*reg_write)(void *context, unsigned int reg, unsigned int val);
 	int (*reg_update_bits)(void *context, unsigned int reg,
 			       unsigned int mask, unsigned int val);
+	/* Bulk read/write */
+	int (*read)(void *context, const void *reg_buf, size_t reg_size,
+		    void *val_buf, size_t val_size);
+	int (*write)(void *context, const void *data, size_t count);
 
 	bool defer_caching;
 
diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
index 7bc603145bd98..2dfd6aa600450 100644
--- a/drivers/base/regmap/regmap.c
+++ b/drivers/base/regmap/regmap.c
@@ -800,12 +800,15 @@ struct regmap *__regmap_init(struct device *dev,
 		map->reg_stride_order = ilog2(map->reg_stride);
 	else
 		map->reg_stride_order = -1;
-	map->use_single_read = config->use_single_read || !bus || !bus->read;
-	map->use_single_write = config->use_single_write || !bus || !bus->write;
-	map->can_multi_write = config->can_multi_write && bus && bus->write;
+	map->use_single_read = config->use_single_read || !(config->read || (bus && bus->read));
+	map->use_single_write = config->use_single_write || !(config->write || (bus && bus->write));
+	map->can_multi_write = config->can_multi_write && (config->write || (bus && bus->write));
 	if (bus) {
 		map->max_raw_read = bus->max_raw_read;
 		map->max_raw_write = bus->max_raw_write;
+	} else if (config->max_raw_read && config->max_raw_write) {
+		map->max_raw_read = config->max_raw_read;
+		map->max_raw_write = config->max_raw_write;
 	}
 	map->dev = dev;
 	map->bus = bus;
@@ -839,9 +842,19 @@ struct regmap *__regmap_init(struct device *dev,
 		map->read_flag_mask = bus->read_flag_mask;
 	}
 
-	if (!bus) {
+	if (config && config->read && config->write) {
+		map->reg_read  = _regmap_bus_read;
+
+		/* Bulk read/write */
+		map->read = config->read;
+		map->write = config->write;
+
+		reg_endian = REGMAP_ENDIAN_NATIVE;
+		val_endian = REGMAP_ENDIAN_NATIVE;
+	} else if (!bus) {
 		map->reg_read  = config->reg_read;
 		map->reg_write = config->reg_write;
+		map->reg_update_bits = config->reg_update_bits;
 
 		map->defer_caching = false;
 		goto skip_format_initialization;
@@ -855,10 +868,13 @@ struct regmap *__regmap_init(struct device *dev,
 	} else {
 		map->reg_read  = _regmap_bus_read;
 		map->reg_update_bits = bus->reg_update_bits;
-	}
+		/* Bulk read/write */
+		map->read = bus->read;
+		map->write = bus->write;
 
-	reg_endian = regmap_get_reg_endian(bus, config);
-	val_endian = regmap_get_val_endian(dev, bus, config);
+		reg_endian = regmap_get_reg_endian(bus, config);
+		val_endian = regmap_get_val_endian(dev, bus, config);
+	}
 
 	switch (config->reg_bits + map->reg_shift) {
 	case 2:
@@ -1627,8 +1643,6 @@ static int _regmap_raw_write_impl(struct regmap *map, unsigned int reg,
 	size_t len;
 	int i;
 
-	WARN_ON(!map->bus);
-
 	/* Check for unwritable or noinc registers in range
 	 * before we start
 	 */
@@ -1710,7 +1724,7 @@ static int _regmap_raw_write_impl(struct regmap *map, unsigned int reg,
 		val = work_val;
 	}
 
-	if (map->async && map->bus->async_write) {
+	if (map->async && map->bus && map->bus->async_write) {
 		struct regmap_async *async;
 
 		trace_regmap_async_write_start(map, reg, val_len);
@@ -1778,10 +1792,10 @@ static int _regmap_raw_write_impl(struct regmap *map, unsigned int reg,
 	 * write.
 	 */
 	if (val == work_val)
-		ret = map->bus->write(map->bus_context, map->work_buf,
-				      map->format.reg_bytes +
-				      map->format.pad_bytes +
-				      val_len);
+		ret = map->write(map->bus_context, map->work_buf,
+				 map->format.reg_bytes +
+				 map->format.pad_bytes +
+				 val_len);
 	else if (map->bus->gather_write)
 		ret = map->bus->gather_write(map->bus_context, map->work_buf,
 					     map->format.reg_bytes +
@@ -1800,7 +1814,7 @@ static int _regmap_raw_write_impl(struct regmap *map, unsigned int reg,
 		memcpy(buf, map->work_buf, map->format.reg_bytes);
 		memcpy(buf + map->format.reg_bytes + map->format.pad_bytes,
 		       val, val_len);
-		ret = map->bus->write(map->bus_context, buf, len);
+		ret = map->write(map->bus_context, buf, len);
 
 		kfree(buf);
 	} else if (ret != 0 && !map->cache_bypass && map->format.parse_val) {
@@ -1857,7 +1871,7 @@ static int _regmap_bus_formatted_write(void *context, unsigned int reg,
 	struct regmap_range_node *range;
 	struct regmap *map = context;
 
-	WARN_ON(!map->bus || !map->format.format_write);
+	WARN_ON(!map->format.format_write);
 
 	range = _regmap_range_lookup(map, reg);
 	if (range) {
@@ -1870,8 +1884,7 @@ static int _regmap_bus_formatted_write(void *context, unsigned int reg,
 
 	trace_regmap_hw_write_start(map, reg, 1);
 
-	ret = map->bus->write(map->bus_context, map->work_buf,
-			      map->format.buf_size);
+	ret = map->write(map->bus_context, map->work_buf, map->format.buf_size);
 
 	trace_regmap_hw_write_done(map, reg, 1);
 
@@ -1891,7 +1904,7 @@ static int _regmap_bus_raw_write(void *context, unsigned int reg,
 {
 	struct regmap *map = context;
 
-	WARN_ON(!map->bus || !map->format.format_val);
+	WARN_ON(!map->format.format_val);
 
 	map->format.format_val(map->work_buf + map->format.reg_bytes
 			       + map->format.pad_bytes, val, 0);
@@ -1905,7 +1918,7 @@ static int _regmap_bus_raw_write(void *context, unsigned int reg,
 
 static inline void *_regmap_map_get_context(struct regmap *map)
 {
-	return (map->bus) ? map : map->bus_context;
+	return (map->bus || (!map->bus && map->read)) ? map : map->bus_context;
 }
 
 int _regmap_write(struct regmap *map, unsigned int reg,
@@ -2312,7 +2325,7 @@ static int _regmap_raw_multi_reg_write(struct regmap *map,
 	u8 = buf;
 	*u8 |= map->write_flag_mask;
 
-	ret = map->bus->write(map->bus_context, buf, len);
+	ret = map->write(map->bus_context, buf, len);
 
 	kfree(buf);
 
@@ -2618,9 +2631,7 @@ static int _regmap_raw_read(struct regmap *map, unsigned int reg, void *val,
 	struct regmap_range_node *range;
 	int ret;
 
-	WARN_ON(!map->bus);
-
-	if (!map->bus || !map->bus->read)
+	if (!map->read)
 		return -EINVAL;
 
 	range = _regmap_range_lookup(map, reg);
@@ -2636,9 +2647,9 @@ static int _regmap_raw_read(struct regmap *map, unsigned int reg, void *val,
 				      map->read_flag_mask);
 	trace_regmap_hw_read_start(map, reg, val_len / map->format.val_bytes);
 
-	ret = map->bus->read(map->bus_context, map->work_buf,
-			     map->format.reg_bytes + map->format.pad_bytes,
-			     val, val_len);
+	ret = map->read(map->bus_context, map->work_buf,
+			map->format.reg_bytes + map->format.pad_bytes,
+			val, val_len);
 
 	trace_regmap_hw_read_done(map, reg, val_len / map->format.val_bytes);
 
@@ -2749,8 +2760,6 @@ int regmap_raw_read(struct regmap *map, unsigned int reg, void *val,
 	unsigned int v;
 	int ret, i;
 
-	if (!map->bus)
-		return -EINVAL;
 	if (val_len % map->format.val_bytes)
 		return -EINVAL;
 	if (!IS_ALIGNED(reg, map->reg_stride))
@@ -2765,7 +2774,7 @@ int regmap_raw_read(struct regmap *map, unsigned int reg, void *val,
 		size_t chunk_count, chunk_bytes;
 		size_t chunk_regs = val_count;
 
-		if (!map->bus->read) {
+		if (!map->read) {
 			ret = -ENOTSUPP;
 			goto out;
 		}
@@ -2825,7 +2834,7 @@ EXPORT_SYMBOL_GPL(regmap_raw_read);
  * @val: Pointer to data buffer
  * @val_len: Length of output buffer in bytes.
  *
- * The regmap API usually assumes that bulk bus read operations will read a
+ * The regmap API usually assumes that bulk read operations will read a
  * range of registers. Some devices have certain registers for which a read
  * operation read will read from an internal FIFO.
  *
@@ -2843,10 +2852,6 @@ int regmap_noinc_read(struct regmap *map, unsigned int reg,
 	size_t read_len;
 	int ret;
 
-	if (!map->bus)
-		return -EINVAL;
-	if (!map->bus->read)
-		return -ENOTSUPP;
 	if (val_len % map->format.val_bytes)
 		return -EINVAL;
 	if (!IS_ALIGNED(reg, map->reg_stride))
@@ -2960,7 +2965,7 @@ int regmap_bulk_read(struct regmap *map, unsigned int reg, void *val,
 	if (val_count == 0)
 		return -EINVAL;
 
-	if (map->bus && map->format.parse_inplace && (vol || map->cache_type == REGCACHE_NONE)) {
+	if (map->format.parse_inplace && (vol || map->cache_type == REGCACHE_NONE)) {
 		ret = regmap_raw_read(map, reg, val, val_bytes * val_count);
 		if (ret != 0)
 			return ret;
diff --git a/drivers/hv/channel.c b/drivers/hv/channel.c
index f064fa6ef181a..a59ab2f3d68e1 100644
--- a/drivers/hv/channel.c
+++ b/drivers/hv/channel.c
@@ -503,6 +503,70 @@ int vmbus_establish_gpadl(struct vmbus_channel *channel, void *kbuffer,
 }
 EXPORT_SYMBOL_GPL(vmbus_establish_gpadl);
 
+/**
+ * request_arr_init - Allocates memory for the requestor array. Each slot
+ * keeps track of the next available slot in the array. Initially, each
+ * slot points to the next one (as in a Linked List). The last slot
+ * does not point to anything, so its value is U64_MAX by default.
+ * @size The size of the array
+ */
+static u64 *request_arr_init(u32 size)
+{
+	int i;
+	u64 *req_arr;
+
+	req_arr = kcalloc(size, sizeof(u64), GFP_KERNEL);
+	if (!req_arr)
+		return NULL;
+
+	for (i = 0; i < size - 1; i++)
+		req_arr[i] = i + 1;
+
+	/* Last slot (no more available slots) */
+	req_arr[i] = U64_MAX;
+
+	return req_arr;
+}
+
+/*
+ * vmbus_alloc_requestor - Initializes @rqstor's fields.
+ * Index 0 is the first free slot
+ * @size: Size of the requestor array
+ */
+static int vmbus_alloc_requestor(struct vmbus_requestor *rqstor, u32 size)
+{
+	u64 *rqst_arr;
+	unsigned long *bitmap;
+
+	rqst_arr = request_arr_init(size);
+	if (!rqst_arr)
+		return -ENOMEM;
+
+	bitmap = bitmap_zalloc(size, GFP_KERNEL);
+	if (!bitmap) {
+		kfree(rqst_arr);
+		return -ENOMEM;
+	}
+
+	rqstor->req_arr = rqst_arr;
+	rqstor->req_bitmap = bitmap;
+	rqstor->size = size;
+	rqstor->next_request_id = 0;
+	spin_lock_init(&rqstor->req_lock);
+
+	return 0;
+}
+
+/*
+ * vmbus_free_requestor - Frees memory allocated for @rqstor
+ * @rqstor: Pointer to the requestor struct
+ */
+static void vmbus_free_requestor(struct vmbus_requestor *rqstor)
+{
+	kfree(rqstor->req_arr);
+	bitmap_free(rqstor->req_bitmap);
+}
+
 static int __vmbus_open(struct vmbus_channel *newchannel,
 		       void *userdata, u32 userdatalen,
 		       void (*onchannelcallback)(void *context), void *context)
@@ -523,6 +587,12 @@ static int __vmbus_open(struct vmbus_channel *newchannel,
 	if (newchannel->state != CHANNEL_OPEN_STATE)
 		return -EINVAL;
 
+	/* Create and init requestor */
+	if (newchannel->rqstor_size) {
+		if (vmbus_alloc_requestor(&newchannel->requestor, newchannel->rqstor_size))
+			return -ENOMEM;
+	}
+
 	newchannel->state = CHANNEL_OPENING_STATE;
 	newchannel->onchannel_callback = onchannelcallback;
 	newchannel->channel_callback_context = context;
@@ -626,6 +696,7 @@ static int __vmbus_open(struct vmbus_channel *newchannel,
 error_clean_ring:
 	hv_ringbuffer_cleanup(&newchannel->outbound);
 	hv_ringbuffer_cleanup(&newchannel->inbound);
+	vmbus_free_requestor(&newchannel->requestor);
 	newchannel->state = CHANNEL_OPEN_STATE;
 	return err;
 }
@@ -808,6 +879,9 @@ static int vmbus_close_internal(struct vmbus_channel *channel)
 		channel->ringbuffer_gpadlhandle = 0;
 	}
 
+	if (!ret)
+		vmbus_free_requestor(&channel->requestor);
+
 	return ret;
 }
 
@@ -888,7 +962,7 @@ int vmbus_sendpacket(struct vmbus_channel *channel, void *buffer,
 	/* in 8-bytes granularity */
 	desc.offset8 = sizeof(struct vmpacket_descriptor) >> 3;
 	desc.len8 = (u16)(packetlen_aligned >> 3);
-	desc.trans_id = requestid;
+	desc.trans_id = VMBUS_RQST_ERROR; /* will be updated in hv_ringbuffer_write() */
 
 	bufferlist[0].iov_base = &desc;
 	bufferlist[0].iov_len = sizeof(struct vmpacket_descriptor);
@@ -897,7 +971,7 @@ int vmbus_sendpacket(struct vmbus_channel *channel, void *buffer,
 	bufferlist[2].iov_base = &aligned_data;
 	bufferlist[2].iov_len = (packetlen_aligned - packetlen);
 
-	return hv_ringbuffer_write(channel, bufferlist, num_vecs);
+	return hv_ringbuffer_write(channel, bufferlist, num_vecs, requestid);
 }
 EXPORT_SYMBOL(vmbus_sendpacket);
 
@@ -939,7 +1013,7 @@ int vmbus_sendpacket_pagebuffer(struct vmbus_channel *channel,
 	desc.flags = VMBUS_DATA_PACKET_FLAG_COMPLETION_REQUESTED;
 	desc.dataoffset8 = descsize >> 3; /* in 8-bytes granularity */
 	desc.length8 = (u16)(packetlen_aligned >> 3);
-	desc.transactionid = requestid;
+	desc.transactionid = VMBUS_RQST_ERROR; /* will be updated in hv_ringbuffer_write() */
 	desc.reserved = 0;
 	desc.rangecount = pagecount;
 
@@ -956,7 +1030,7 @@ int vmbus_sendpacket_pagebuffer(struct vmbus_channel *channel,
 	bufferlist[2].iov_base = &aligned_data;
 	bufferlist[2].iov_len = (packetlen_aligned - packetlen);
 
-	return hv_ringbuffer_write(channel, bufferlist, 3);
+	return hv_ringbuffer_write(channel, bufferlist, 3, requestid);
 }
 EXPORT_SYMBOL_GPL(vmbus_sendpacket_pagebuffer);
 
@@ -983,7 +1057,7 @@ int vmbus_sendpacket_mpb_desc(struct vmbus_channel *channel,
 	desc->flags = VMBUS_DATA_PACKET_FLAG_COMPLETION_REQUESTED;
 	desc->dataoffset8 = desc_size >> 3; /* in 8-bytes granularity */
 	desc->length8 = (u16)(packetlen_aligned >> 3);
-	desc->transactionid = requestid;
+	desc->transactionid = VMBUS_RQST_ERROR; /* will be updated in hv_ringbuffer_write() */
 	desc->reserved = 0;
 	desc->rangecount = 1;
 
@@ -994,7 +1068,7 @@ int vmbus_sendpacket_mpb_desc(struct vmbus_channel *channel,
 	bufferlist[2].iov_base = &aligned_data;
 	bufferlist[2].iov_len = (packetlen_aligned - packetlen);
 
-	return hv_ringbuffer_write(channel, bufferlist, 3);
+	return hv_ringbuffer_write(channel, bufferlist, 3, requestid);
 }
 EXPORT_SYMBOL_GPL(vmbus_sendpacket_mpb_desc);
 
@@ -1042,3 +1116,91 @@ int vmbus_recvpacket_raw(struct vmbus_channel *channel, void *buffer,
 				  buffer_actual_len, requestid, true);
 }
 EXPORT_SYMBOL_GPL(vmbus_recvpacket_raw);
+
+/*
+ * vmbus_next_request_id - Returns a new request id. It is also
+ * the index at which the guest memory address is stored.
+ * Uses a spin lock to avoid race conditions.
+ * @rqstor: Pointer to the requestor struct
+ * @rqst_add: Guest memory address to be stored in the array
+ */
+u64 vmbus_next_request_id(struct vmbus_requestor *rqstor, u64 rqst_addr)
+{
+	unsigned long flags;
+	u64 current_id;
+	const struct vmbus_channel *channel =
+		container_of(rqstor, const struct vmbus_channel, requestor);
+
+	/* Check rqstor has been initialized */
+	if (!channel->rqstor_size)
+		return VMBUS_NO_RQSTOR;
+
+	spin_lock_irqsave(&rqstor->req_lock, flags);
+	current_id = rqstor->next_request_id;
+
+	/* Requestor array is full */
+	if (current_id >= rqstor->size) {
+		spin_unlock_irqrestore(&rqstor->req_lock, flags);
+		return VMBUS_RQST_ERROR;
+	}
+
+	rqstor->next_request_id = rqstor->req_arr[current_id];
+	rqstor->req_arr[current_id] = rqst_addr;
+
+	/* The already held spin lock provides atomicity */
+	bitmap_set(rqstor->req_bitmap, current_id, 1);
+
+	spin_unlock_irqrestore(&rqstor->req_lock, flags);
+
+	/*
+	 * Cannot return an ID of 0, which is reserved for an unsolicited
+	 * message from Hyper-V.
+	 */
+	return current_id + 1;
+}
+EXPORT_SYMBOL_GPL(vmbus_next_request_id);
+
+/*
+ * vmbus_request_addr - Returns the memory address stored at @trans_id
+ * in @rqstor. Uses a spin lock to avoid race conditions.
+ * @rqstor: Pointer to the requestor struct
+ * @trans_id: Request id sent back from Hyper-V. Becomes the requestor's
+ * next request id.
+ */
+u64 vmbus_request_addr(struct vmbus_requestor *rqstor, u64 trans_id)
+{
+	unsigned long flags;
+	u64 req_addr;
+	const struct vmbus_channel *channel =
+		container_of(rqstor, const struct vmbus_channel, requestor);
+
+	/* Check rqstor has been initialized */
+	if (!channel->rqstor_size)
+		return VMBUS_NO_RQSTOR;
+
+	/* Hyper-V can send an unsolicited message with ID of 0 */
+	if (!trans_id)
+		return trans_id;
+
+	spin_lock_irqsave(&rqstor->req_lock, flags);
+
+	/* Data corresponding to trans_id is stored at trans_id - 1 */
+	trans_id--;
+
+	/* Invalid trans_id */
+	if (trans_id >= rqstor->size || !test_bit(trans_id, rqstor->req_bitmap)) {
+		spin_unlock_irqrestore(&rqstor->req_lock, flags);
+		return VMBUS_RQST_ERROR;
+	}
+
+	req_addr = rqstor->req_arr[trans_id];
+	rqstor->req_arr[trans_id] = rqstor->next_request_id;
+	rqstor->next_request_id = trans_id;
+
+	/* The already held spin lock provides atomicity */
+	bitmap_clear(rqstor->req_bitmap, trans_id, 1);
+
+	spin_unlock_irqrestore(&rqstor->req_lock, flags);
+	return req_addr;
+}
+EXPORT_SYMBOL_GPL(vmbus_request_addr);
diff --git a/drivers/hv/hyperv_vmbus.h b/drivers/hv/hyperv_vmbus.h
index 7845fa5de79e9..601660bca5d47 100644
--- a/drivers/hv/hyperv_vmbus.h
+++ b/drivers/hv/hyperv_vmbus.h
@@ -180,7 +180,8 @@ int hv_ringbuffer_init(struct hv_ring_buffer_info *ring_info,
 void hv_ringbuffer_cleanup(struct hv_ring_buffer_info *ring_info);
 
 int hv_ringbuffer_write(struct vmbus_channel *channel,
-			const struct kvec *kv_list, u32 kv_count);
+			const struct kvec *kv_list, u32 kv_count,
+			u64 requestid);
 
 int hv_ringbuffer_read(struct vmbus_channel *channel,
 		       void *buffer, u32 buflen, u32 *buffer_actual_len,
diff --git a/drivers/hv/ring_buffer.c b/drivers/hv/ring_buffer.c
index 7ed6fad3fa8ff..a49cc69c56af0 100644
--- a/drivers/hv/ring_buffer.c
+++ b/drivers/hv/ring_buffer.c
@@ -261,7 +261,8 @@ EXPORT_SYMBOL_GPL(hv_ringbuffer_spinlock_busy);
 
 /* Write to the ring buffer. */
 int hv_ringbuffer_write(struct vmbus_channel *channel,
-			const struct kvec *kv_list, u32 kv_count)
+			const struct kvec *kv_list, u32 kv_count,
+			u64 requestid)
 {
 	int i;
 	u32 bytes_avail_towrite;
@@ -271,6 +272,8 @@ int hv_ringbuffer_write(struct vmbus_channel *channel,
 	u64 prev_indices;
 	unsigned long flags;
 	struct hv_ring_buffer_info *outring_info = &channel->outbound;
+	struct vmpacket_descriptor *desc = kv_list[0].iov_base;
+	u64 rqst_id = VMBUS_NO_RQSTOR;
 
 	if (channel->rescind)
 		return -ENODEV;
@@ -313,6 +316,22 @@ int hv_ringbuffer_write(struct vmbus_channel *channel,
 						     kv_list[i].iov_len);
 	}
 
+	/*
+	 * Allocate the request ID after the data has been copied into the
+	 * ring buffer.  Once this request ID is allocated, the completion
+	 * path could find the data and free it.
+	 */
+
+	if (desc->flags == VMBUS_DATA_PACKET_FLAG_COMPLETION_REQUESTED) {
+		rqst_id = vmbus_next_request_id(&channel->requestor, requestid);
+		if (rqst_id == VMBUS_RQST_ERROR) {
+			spin_unlock_irqrestore(&outring_info->ring_lock, flags);
+			return -EAGAIN;
+		}
+	}
+	desc = hv_get_ring_buffer(outring_info) + old_write;
+	desc->trans_id = (rqst_id == VMBUS_NO_RQSTOR) ? requestid : rqst_id;
+
 	/* Set previous packet start */
 	prev_indices = hv_get_ring_bufferindices(outring_info);
 
@@ -332,8 +351,13 @@ int hv_ringbuffer_write(struct vmbus_channel *channel,
 
 	hv_signal_on_write(old_write, channel);
 
-	if (channel->rescind)
+	if (channel->rescind) {
+		if (rqst_id != VMBUS_NO_RQSTOR) {
+			/* Reclaim request ID to avoid leak of IDs */
+			vmbus_request_addr(&channel->requestor, rqst_id);
+		}
 		return -ENODEV;
+	}
 
 	return 0;
 }
diff --git a/drivers/mmc/host/mmci_stm32_sdmmc.c b/drivers/mmc/host/mmci_stm32_sdmmc.c
index 4cceb9bab0361..e3201a621870a 100644
--- a/drivers/mmc/host/mmci_stm32_sdmmc.c
+++ b/drivers/mmc/host/mmci_stm32_sdmmc.c
@@ -43,6 +43,9 @@ struct sdmmc_lli_desc {
 struct sdmmc_idma {
 	dma_addr_t sg_dma;
 	void *sg_cpu;
+	dma_addr_t bounce_dma_addr;
+	void *bounce_buf;
+	bool use_bounce_buffer;
 };
 
 struct sdmmc_dlyb {
@@ -54,6 +57,8 @@ struct sdmmc_dlyb {
 static int sdmmc_idma_validate_data(struct mmci_host *host,
 				    struct mmc_data *data)
 {
+	struct sdmmc_idma *idma = host->dma_priv;
+	struct device *dev = mmc_dev(host->mmc);
 	struct scatterlist *sg;
 	int i;
 
@@ -61,41 +66,69 @@ static int sdmmc_idma_validate_data(struct mmci_host *host,
 	 * idma has constraints on idmabase & idmasize for each element
 	 * excepted the last element which has no constraint on idmasize
 	 */
+	idma->use_bounce_buffer = false;
 	for_each_sg(data->sg, sg, data->sg_len - 1, i) {
 		if (!IS_ALIGNED(sg->offset, sizeof(u32)) ||
 		    !IS_ALIGNED(sg->length, SDMMC_IDMA_BURST)) {
-			dev_err(mmc_dev(host->mmc),
+			dev_dbg(mmc_dev(host->mmc),
 				"unaligned scatterlist: ofst:%x length:%d\n",
 				data->sg->offset, data->sg->length);
-			return -EINVAL;
+			goto use_bounce_buffer;
 		}
 	}
 
 	if (!IS_ALIGNED(sg->offset, sizeof(u32))) {
-		dev_err(mmc_dev(host->mmc),
+		dev_dbg(mmc_dev(host->mmc),
 			"unaligned last scatterlist: ofst:%x length:%d\n",
 			data->sg->offset, data->sg->length);
-		return -EINVAL;
+		goto use_bounce_buffer;
 	}
 
+	return 0;
+
+use_bounce_buffer:
+	if (!idma->bounce_buf) {
+		idma->bounce_buf = dmam_alloc_coherent(dev,
+						       host->mmc->max_req_size,
+						       &idma->bounce_dma_addr,
+						       GFP_KERNEL);
+		if (!idma->bounce_buf) {
+			dev_err(dev, "Unable to map allocate DMA bounce buffer.\n");
+			return -ENOMEM;
+		}
+	}
+
+	idma->use_bounce_buffer = true;
+
 	return 0;
 }
 
 static int _sdmmc_idma_prep_data(struct mmci_host *host,
 				 struct mmc_data *data)
 {
-	int n_elem;
+	struct sdmmc_idma *idma = host->dma_priv;
 
-	n_elem = dma_map_sg(mmc_dev(host->mmc),
-			    data->sg,
-			    data->sg_len,
-			    mmc_get_dma_dir(data));
+	if (idma->use_bounce_buffer) {
+		if (data->flags & MMC_DATA_WRITE) {
+			unsigned int xfer_bytes = data->blksz * data->blocks;
 
-	if (!n_elem) {
-		dev_err(mmc_dev(host->mmc), "dma_map_sg failed\n");
-		return -EINVAL;
-	}
+			sg_copy_to_buffer(data->sg, data->sg_len,
+					  idma->bounce_buf, xfer_bytes);
+			dma_wmb();
+		}
+	} else {
+		int n_elem;
 
+		n_elem = dma_map_sg(mmc_dev(host->mmc),
+				    data->sg,
+				    data->sg_len,
+				    mmc_get_dma_dir(data));
+
+		if (!n_elem) {
+			dev_err(mmc_dev(host->mmc), "dma_map_sg failed\n");
+			return -EINVAL;
+		}
+	}
 	return 0;
 }
 
@@ -112,8 +145,19 @@ static int sdmmc_idma_prep_data(struct mmci_host *host,
 static void sdmmc_idma_unprep_data(struct mmci_host *host,
 				   struct mmc_data *data, int err)
 {
-	dma_unmap_sg(mmc_dev(host->mmc), data->sg, data->sg_len,
-		     mmc_get_dma_dir(data));
+	struct sdmmc_idma *idma = host->dma_priv;
+
+	if (idma->use_bounce_buffer) {
+		if (data->flags & MMC_DATA_READ) {
+			unsigned int xfer_bytes = data->blksz * data->blocks;
+
+			sg_copy_from_buffer(data->sg, data->sg_len,
+					    idma->bounce_buf, xfer_bytes);
+		}
+	} else {
+		dma_unmap_sg(mmc_dev(host->mmc), data->sg, data->sg_len,
+			     mmc_get_dma_dir(data));
+	}
 }
 
 static int sdmmc_idma_setup(struct mmci_host *host)
@@ -137,6 +181,8 @@ static int sdmmc_idma_setup(struct mmci_host *host)
 		host->mmc->max_segs = SDMMC_LLI_BUF_LEN /
 			sizeof(struct sdmmc_lli_desc);
 		host->mmc->max_seg_size = host->variant->stm32_idmabsize_mask;
+
+		host->mmc->max_req_size = SZ_1M;
 	} else {
 		host->mmc->max_segs = 1;
 		host->mmc->max_seg_size = host->mmc->max_req_size;
@@ -154,8 +200,18 @@ static int sdmmc_idma_start(struct mmci_host *host, unsigned int *datactrl)
 	struct scatterlist *sg;
 	int i;
 
-	if (!host->variant->dma_lli || data->sg_len == 1) {
-		writel_relaxed(sg_dma_address(data->sg),
+	host->dma_in_progress = true;
+
+	if (!host->variant->dma_lli || data->sg_len == 1 ||
+	    idma->use_bounce_buffer) {
+		u32 dma_addr;
+
+		if (idma->use_bounce_buffer)
+			dma_addr = idma->bounce_dma_addr;
+		else
+			dma_addr = sg_dma_address(data->sg);
+
+		writel_relaxed(dma_addr,
 			       host->base + MMCI_STM32_IDMABASE0R);
 		writel_relaxed(MMCI_STM32_IDMAEN,
 			       host->base + MMCI_STM32_IDMACTRLR);
@@ -184,9 +240,30 @@ static int sdmmc_idma_start(struct mmci_host *host, unsigned int *datactrl)
 	return 0;
 }
 
+static void sdmmc_idma_error(struct mmci_host *host)
+{
+	struct mmc_data *data = host->data;
+	struct sdmmc_idma *idma = host->dma_priv;
+
+	if (!dma_inprogress(host))
+		return;
+
+	writel_relaxed(0, host->base + MMCI_STM32_IDMACTRLR);
+	host->dma_in_progress = false;
+	data->host_cookie = 0;
+
+	if (!idma->use_bounce_buffer)
+		dma_unmap_sg(mmc_dev(host->mmc), data->sg, data->sg_len,
+			     mmc_get_dma_dir(data));
+}
+
 static void sdmmc_idma_finalize(struct mmci_host *host, struct mmc_data *data)
 {
+	if (!dma_inprogress(host))
+		return;
+
 	writel_relaxed(0, host->base + MMCI_STM32_IDMACTRLR);
+	host->dma_in_progress = false;
 
 	if (!data->host_cookie)
 		sdmmc_idma_unprep_data(host, data, 0);
@@ -512,6 +589,7 @@ static struct mmci_host_ops sdmmc_variant_ops = {
 	.dma_setup = sdmmc_idma_setup,
 	.dma_start = sdmmc_idma_start,
 	.dma_finalize = sdmmc_idma_finalize,
+	.dma_error = sdmmc_idma_error,
 	.set_clkreg = mmci_sdmmc_set_clkreg,
 	.set_pwrreg = mmci_sdmmc_set_pwrreg,
 	.busy_complete = sdmmc_busy_complete,
diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 135acd74497f3..58c87d79c1261 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -12944,9 +12944,9 @@ int i40e_queue_pair_disable(struct i40e_vsi *vsi, int queue_pair)
 		return err;
 
 	i40e_queue_pair_disable_irq(vsi, queue_pair);
+	i40e_queue_pair_toggle_napi(vsi, queue_pair, false /* off */);
 	err = i40e_queue_pair_toggle_rings(vsi, queue_pair, false /* off */);
 	i40e_clean_rx_ring(vsi->rx_rings[queue_pair]);
-	i40e_queue_pair_toggle_napi(vsi, queue_pair, false /* off */);
 	i40e_queue_pair_clean_rings(vsi, queue_pair);
 	i40e_queue_pair_reset_stats(vsi, queue_pair);
 
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 02f72fbec1042..035bc90c81246 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -6546,6 +6546,8 @@ ice_bridge_setlink(struct net_device *dev, struct nlmsghdr *nlh,
 	pf_sw = pf->first_sw;
 	/* find the attribute in the netlink message */
 	br_spec = nlmsg_find_attr(nlh, sizeof(struct ifinfomsg), IFLA_AF_SPEC);
+	if (!br_spec)
+		return -EINVAL;
 
 	nla_for_each_nested(attr, br_spec, rem) {
 		__u16 mode;
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index b16cb2365d960..b7672200dc624 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -2949,8 +2949,8 @@ static void ixgbe_check_lsc(struct ixgbe_adapter *adapter)
 static inline void ixgbe_irq_enable_queues(struct ixgbe_adapter *adapter,
 					   u64 qmask)
 {
-	u32 mask;
 	struct ixgbe_hw *hw = &adapter->hw;
+	u32 mask;
 
 	switch (hw->mac.type) {
 	case ixgbe_mac_82598EB:
@@ -10394,6 +10394,44 @@ static void ixgbe_reset_rxr_stats(struct ixgbe_ring *rx_ring)
 	memset(&rx_ring->rx_stats, 0, sizeof(rx_ring->rx_stats));
 }
 
+/**
+ * ixgbe_irq_disable_single - Disable single IRQ vector
+ * @adapter: adapter structure
+ * @ring: ring index
+ **/
+static void ixgbe_irq_disable_single(struct ixgbe_adapter *adapter, u32 ring)
+{
+	struct ixgbe_hw *hw = &adapter->hw;
+	u64 qmask = BIT_ULL(ring);
+	u32 mask;
+
+	switch (adapter->hw.mac.type) {
+	case ixgbe_mac_82598EB:
+		mask = qmask & IXGBE_EIMC_RTX_QUEUE;
+		IXGBE_WRITE_REG(&adapter->hw, IXGBE_EIMC, mask);
+		break;
+	case ixgbe_mac_82599EB:
+	case ixgbe_mac_X540:
+	case ixgbe_mac_X550:
+	case ixgbe_mac_X550EM_x:
+	case ixgbe_mac_x550em_a:
+		mask = (qmask & 0xFFFFFFFF);
+		if (mask)
+			IXGBE_WRITE_REG(hw, IXGBE_EIMS_EX(0), mask);
+		mask = (qmask >> 32);
+		if (mask)
+			IXGBE_WRITE_REG(hw, IXGBE_EIMS_EX(1), mask);
+		break;
+	default:
+		break;
+	}
+	IXGBE_WRITE_FLUSH(&adapter->hw);
+	if (adapter->flags & IXGBE_FLAG_MSIX_ENABLED)
+		synchronize_irq(adapter->msix_entries[ring].vector);
+	else
+		synchronize_irq(adapter->pdev->irq);
+}
+
 /**
  * ixgbe_txrx_ring_disable - Disable Rx/Tx/XDP Tx rings
  * @adapter: adapter structure
@@ -10410,6 +10448,11 @@ void ixgbe_txrx_ring_disable(struct ixgbe_adapter *adapter, int ring)
 	tx_ring = adapter->tx_ring[ring];
 	xdp_ring = adapter->xdp_ring[ring];
 
+	ixgbe_irq_disable_single(adapter, ring);
+
+	/* Rx/Tx/XDP Tx share the same napi context. */
+	napi_disable(&rx_ring->q_vector->napi);
+
 	ixgbe_disable_txr(adapter, tx_ring);
 	if (xdp_ring)
 		ixgbe_disable_txr(adapter, xdp_ring);
@@ -10418,9 +10461,6 @@ void ixgbe_txrx_ring_disable(struct ixgbe_adapter *adapter, int ring)
 	if (xdp_ring)
 		synchronize_rcu();
 
-	/* Rx/Tx/XDP Tx share the same napi context. */
-	napi_disable(&rx_ring->q_vector->napi);
-
 	ixgbe_clean_tx_ring(tx_ring);
 	if (xdp_ring)
 		ixgbe_clean_tx_ring(xdp_ring);
@@ -10448,9 +10488,6 @@ void ixgbe_txrx_ring_enable(struct ixgbe_adapter *adapter, int ring)
 	tx_ring = adapter->tx_ring[ring];
 	xdp_ring = adapter->xdp_ring[ring];
 
-	/* Rx/Tx/XDP Tx share the same napi context. */
-	napi_enable(&rx_ring->q_vector->napi);
-
 	ixgbe_configure_tx_ring(adapter, tx_ring);
 	if (xdp_ring)
 		ixgbe_configure_tx_ring(adapter, xdp_ring);
@@ -10459,6 +10496,11 @@ void ixgbe_txrx_ring_enable(struct ixgbe_adapter *adapter, int ring)
 	clear_bit(__IXGBE_TX_DISABLED, &tx_ring->state);
 	if (xdp_ring)
 		clear_bit(__IXGBE_TX_DISABLED, &xdp_ring->state);
+
+	/* Rx/Tx/XDP Tx share the same napi context. */
+	napi_enable(&rx_ring->q_vector->napi);
+	ixgbe_irq_enable_queues(adapter, BIT_ULL(ring));
+	IXGBE_WRITE_FLUSH(&adapter->hw);
 }
 
 /**
diff --git a/drivers/net/geneve.c b/drivers/net/geneve.c
index 081939cb420b0..2bb9820c66641 100644
--- a/drivers/net/geneve.c
+++ b/drivers/net/geneve.c
@@ -218,7 +218,7 @@ static void geneve_rx(struct geneve_dev *geneve, struct geneve_sock *gs,
 	struct genevehdr *gnvh = geneve_hdr(skb);
 	struct metadata_dst *tun_dst = NULL;
 	unsigned int len;
-	int err = 0;
+	int nh, err = 0;
 	void *oiph;
 
 	if (ip_tunnel_collect_metadata() || gs->collect_md) {
@@ -262,9 +262,23 @@ static void geneve_rx(struct geneve_dev *geneve, struct geneve_sock *gs,
 		goto drop;
 	}
 
-	oiph = skb_network_header(skb);
+	/* Save offset of outer header relative to skb->head,
+	 * because we are going to reset the network header to the inner header
+	 * and might change skb->head.
+	 */
+	nh = skb_network_header(skb) - skb->head;
+
 	skb_reset_network_header(skb);
 
+	if (!pskb_inet_may_pull(skb)) {
+		DEV_STATS_INC(geneve->dev, rx_length_errors);
+		DEV_STATS_INC(geneve->dev, rx_errors);
+		goto drop;
+	}
+
+	/* Get the outer header. */
+	oiph = skb->head + nh;
+
 	if (geneve_get_sk_family(gs) == AF_INET)
 		err = IP_ECN_decapsulate(oiph, skb);
 #if IS_ENABLED(CONFIG_IPV6)
diff --git a/drivers/net/hyperv/hyperv_net.h b/drivers/net/hyperv/hyperv_net.h
index 367878493e704..15652d7951f9e 100644
--- a/drivers/net/hyperv/hyperv_net.h
+++ b/drivers/net/hyperv/hyperv_net.h
@@ -847,6 +847,19 @@ struct nvsp_message {
 
 #define NETVSC_XDP_HDRM 256
 
+#define NETVSC_MIN_OUT_MSG_SIZE (sizeof(struct vmpacket_descriptor) + \
+				 sizeof(struct nvsp_message))
+#define NETVSC_MIN_IN_MSG_SIZE sizeof(struct vmpacket_descriptor)
+
+/* Estimated requestor size:
+ * out_ring_size/min_out_msg_size + in_ring_size/min_in_msg_size
+ */
+static inline u32 netvsc_rqstor_size(unsigned long ringbytes)
+{
+	return ringbytes / NETVSC_MIN_OUT_MSG_SIZE +
+		ringbytes / NETVSC_MIN_IN_MSG_SIZE;
+}
+
 #define NETVSC_XFER_HEADER_SIZE(rng_cnt) \
 		(offsetof(struct vmtransfer_page_packet_header, ranges) + \
 		(rng_cnt) * sizeof(struct vmtransfer_page_range))
diff --git a/drivers/net/hyperv/netvsc.c b/drivers/net/hyperv/netvsc.c
index 3eae31c0f97a6..03333a4136bf4 100644
--- a/drivers/net/hyperv/netvsc.c
+++ b/drivers/net/hyperv/netvsc.c
@@ -37,6 +37,10 @@ void netvsc_switch_datapath(struct net_device *ndev, bool vf)
 	struct netvsc_device *nv_dev = rtnl_dereference(net_device_ctx->nvdev);
 	struct nvsp_message *init_pkt = &nv_dev->channel_init_pkt;
 
+	/* Block sending traffic to VF if it's about to be gone */
+	if (!vf)
+		net_device_ctx->data_path_is_vf = vf;
+
 	memset(init_pkt, 0, sizeof(struct nvsp_message));
 	init_pkt->hdr.msg_type = NVSP_MSG4_TYPE_SWITCH_DATA_PATH;
 	if (vf)
@@ -51,7 +55,10 @@ void netvsc_switch_datapath(struct net_device *ndev, bool vf)
 	vmbus_sendpacket(dev->channel, init_pkt,
 			       sizeof(struct nvsp_message),
 			       (unsigned long)init_pkt,
-			       VM_PKT_DATA_INBAND, 0);
+			       VM_PKT_DATA_INBAND,
+			       VMBUS_DATA_PACKET_FLAG_COMPLETION_REQUESTED);
+	wait_for_completion(&nv_dev->channel_init_wait);
+	net_device_ctx->data_path_is_vf = vf;
 }
 
 /* Worker to setup sub channels on initial setup
@@ -163,7 +170,7 @@ static void netvsc_revoke_recv_buf(struct hv_device *device,
 		ret = vmbus_sendpacket(device->channel,
 				       revoke_packet,
 				       sizeof(struct nvsp_message),
-				       (unsigned long)revoke_packet,
+				       VMBUS_RQST_ID_NO_RESPONSE,
 				       VM_PKT_DATA_INBAND, 0);
 		/* If the failure is because the channel is rescinded;
 		 * ignore the failure since we cannot send on a rescinded
@@ -213,7 +220,7 @@ static void netvsc_revoke_send_buf(struct hv_device *device,
 		ret = vmbus_sendpacket(device->channel,
 				       revoke_packet,
 				       sizeof(struct nvsp_message),
-				       (unsigned long)revoke_packet,
+				       VMBUS_RQST_ID_NO_RESPONSE,
 				       VM_PKT_DATA_INBAND, 0);
 
 		/* If the failure is because the channel is rescinded;
@@ -557,7 +564,7 @@ static int negotiate_nvsp_ver(struct hv_device *device,
 
 	ret = vmbus_sendpacket(device->channel, init_packet,
 				sizeof(struct nvsp_message),
-				(unsigned long)init_packet,
+				VMBUS_RQST_ID_NO_RESPONSE,
 				VM_PKT_DATA_INBAND, 0);
 
 	return ret;
@@ -614,7 +621,7 @@ static int netvsc_connect_vsp(struct hv_device *device,
 	/* Send the init request */
 	ret = vmbus_sendpacket(device->channel, init_packet,
 				sizeof(struct nvsp_message),
-				(unsigned long)init_packet,
+				VMBUS_RQST_ID_NO_RESPONSE,
 				VM_PKT_DATA_INBAND, 0);
 	if (ret != 0)
 		goto cleanup;
@@ -698,10 +705,19 @@ static void netvsc_send_tx_complete(struct net_device *ndev,
 				    const struct vmpacket_descriptor *desc,
 				    int budget)
 {
-	struct sk_buff *skb = (struct sk_buff *)(unsigned long)desc->trans_id;
 	struct net_device_context *ndev_ctx = netdev_priv(ndev);
+	struct sk_buff *skb;
 	u16 q_idx = 0;
 	int queue_sends;
+	u64 cmd_rqst;
+
+	cmd_rqst = vmbus_request_addr(&channel->requestor, (u64)desc->trans_id);
+	if (cmd_rqst == VMBUS_RQST_ERROR) {
+		netdev_err(ndev, "Incorrect transaction id\n");
+		return;
+	}
+
+	skb = (struct sk_buff *)(unsigned long)cmd_rqst;
 
 	/* Notify the layer above us */
 	if (likely(skb)) {
@@ -748,8 +764,31 @@ static void netvsc_send_completion(struct net_device *ndev,
 				   const struct vmpacket_descriptor *desc,
 				   int budget)
 {
-	const struct nvsp_message *nvsp_packet = hv_pkt_data(desc);
+	const struct nvsp_message *nvsp_packet;
 	u32 msglen = hv_pkt_datalen(desc);
+	struct nvsp_message *pkt_rqst;
+	u64 cmd_rqst;
+
+	/* First check if this is a VMBUS completion without data payload */
+	if (!msglen) {
+		cmd_rqst = vmbus_request_addr(&incoming_channel->requestor,
+					      (u64)desc->trans_id);
+		if (cmd_rqst == VMBUS_RQST_ERROR) {
+			netdev_err(ndev, "Invalid transaction id\n");
+			return;
+		}
+
+		pkt_rqst = (struct nvsp_message *)(uintptr_t)cmd_rqst;
+		switch (pkt_rqst->hdr.msg_type) {
+		case NVSP_MSG4_TYPE_SWITCH_DATA_PATH:
+			complete(&net_device->channel_init_wait);
+			break;
+
+		default:
+			netdev_err(ndev, "Unexpected VMBUS completion!!\n");
+		}
+		return;
+	}
 
 	/* Ensure packet is big enough to read header fields */
 	if (msglen < sizeof(struct nvsp_message_header)) {
@@ -757,6 +796,7 @@ static void netvsc_send_completion(struct net_device *ndev,
 		return;
 	}
 
+	nvsp_packet = hv_pkt_data(desc);
 	switch (nvsp_packet->hdr.msg_type) {
 	case NVSP_MSG_TYPE_INIT_COMPLETE:
 		if (msglen < sizeof(struct nvsp_message_header) +
@@ -1530,6 +1570,7 @@ struct netvsc_device *netvsc_device_add(struct hv_device *device,
 		       netvsc_poll, NAPI_POLL_WEIGHT);
 
 	/* Open the channel */
+	device->channel->rqstor_size = netvsc_rqstor_size(netvsc_ring_bytes);
 	ret = vmbus_open(device->channel, netvsc_ring_bytes,
 			 netvsc_ring_bytes,  NULL, 0,
 			 netvsc_channel_cb, net_device->chan_table);
diff --git a/drivers/net/hyperv/netvsc_drv.c b/drivers/net/hyperv/netvsc_drv.c
index 790bf750281ad..0fc0f9cb3f34b 100644
--- a/drivers/net/hyperv/netvsc_drv.c
+++ b/drivers/net/hyperv/netvsc_drv.c
@@ -44,6 +44,10 @@
 #define LINKCHANGE_INT (2 * HZ)
 #define VF_TAKEOVER_INT (HZ / 10)
 
+/* Macros to define the context of vf registration */
+#define VF_REG_IN_PROBE		1
+#define VF_REG_IN_NOTIFIER	2
+
 static unsigned int ring_size __ro_after_init = 128;
 module_param(ring_size, uint, 0444);
 MODULE_PARM_DESC(ring_size, "Ring buffer size (# of pages)");
@@ -2194,7 +2198,7 @@ static rx_handler_result_t netvsc_vf_handle_frame(struct sk_buff **pskb)
 }
 
 static int netvsc_vf_join(struct net_device *vf_netdev,
-			  struct net_device *ndev)
+			  struct net_device *ndev, int context)
 {
 	struct net_device_context *ndev_ctx = netdev_priv(ndev);
 	int ret;
@@ -2217,7 +2221,11 @@ static int netvsc_vf_join(struct net_device *vf_netdev,
 		goto upper_link_failed;
 	}
 
-	schedule_delayed_work(&ndev_ctx->vf_takeover, VF_TAKEOVER_INT);
+	/* If this registration is called from probe context vf_takeover
+	 * is taken care of later in probe itself.
+	 */
+	if (context == VF_REG_IN_NOTIFIER)
+		schedule_delayed_work(&ndev_ctx->vf_takeover, VF_TAKEOVER_INT);
 
 	call_netdevice_notifiers(NETDEV_JOIN, vf_netdev);
 
@@ -2310,8 +2318,17 @@ static struct net_device *get_netvsc_byslot(const struct net_device *vf_netdev)
 		if (!ndev_ctx->vf_alloc)
 			continue;
 
-		if (ndev_ctx->vf_serial == serial)
-			return hv_get_drvdata(ndev_ctx->device_ctx);
+		if (ndev_ctx->vf_serial != serial)
+			continue;
+
+		ndev = hv_get_drvdata(ndev_ctx->device_ctx);
+		if (ndev->addr_len != vf_netdev->addr_len ||
+		    memcmp(ndev->perm_addr, vf_netdev->perm_addr,
+			   ndev->addr_len) != 0)
+			continue;
+
+		return ndev;
+
 	}
 
 	/* Fallback path to check synthetic vf with help of mac addr.
@@ -2346,7 +2363,7 @@ static int netvsc_prepare_bonding(struct net_device *vf_netdev)
 	return NOTIFY_DONE;
 }
 
-static int netvsc_register_vf(struct net_device *vf_netdev)
+static int netvsc_register_vf(struct net_device *vf_netdev, int context)
 {
 	struct net_device_context *net_device_ctx;
 	struct netvsc_device *netvsc_dev;
@@ -2386,7 +2403,7 @@ static int netvsc_register_vf(struct net_device *vf_netdev)
 
 	netdev_info(ndev, "VF registering: %s\n", vf_netdev->name);
 
-	if (netvsc_vf_join(vf_netdev, ndev) != 0)
+	if (netvsc_vf_join(vf_netdev, ndev, context) != 0)
 		return NOTIFY_DONE;
 
 	dev_hold(vf_netdev);
@@ -2411,12 +2428,15 @@ static int netvsc_register_vf(struct net_device *vf_netdev)
  * During hibernation, if a VF NIC driver (e.g. mlx5) preserves the network
  * interface, there is only the CHANGE event and no UP or DOWN event.
  */
-static int netvsc_vf_changed(struct net_device *vf_netdev)
+static int netvsc_vf_changed(struct net_device *vf_netdev, unsigned long event)
 {
 	struct net_device_context *net_device_ctx;
 	struct netvsc_device *netvsc_dev;
 	struct net_device *ndev;
-	bool vf_is_up = netif_running(vf_netdev);
+	bool vf_is_up = false;
+
+	if (event != NETDEV_GOING_DOWN)
+		vf_is_up = netif_running(vf_netdev);
 
 	ndev = get_netvsc_byref(vf_netdev);
 	if (!ndev)
@@ -2429,7 +2449,6 @@ static int netvsc_vf_changed(struct net_device *vf_netdev)
 
 	if (net_device_ctx->data_path_is_vf == vf_is_up)
 		return NOTIFY_OK;
-	net_device_ctx->data_path_is_vf = vf_is_up;
 
 	if (vf_is_up && !net_device_ctx->vf_alloc) {
 		netdev_info(ndev, "Waiting for the VF association from host\n");
@@ -2468,10 +2487,31 @@ static int netvsc_unregister_vf(struct net_device *vf_netdev)
 	return NOTIFY_OK;
 }
 
+static int check_dev_is_matching_vf(struct net_device *event_ndev)
+{
+	/* Skip NetVSC interfaces */
+	if (event_ndev->netdev_ops == &device_ops)
+		return -ENODEV;
+
+	/* Avoid non-Ethernet type devices */
+	if (event_ndev->type != ARPHRD_ETHER)
+		return -ENODEV;
+
+	/* Avoid Vlan dev with same MAC registering as VF */
+	if (is_vlan_dev(event_ndev))
+		return -ENODEV;
+
+	/* Avoid Bonding master dev with same MAC registering as VF */
+	if (netif_is_bond_master(event_ndev))
+		return -ENODEV;
+
+	return 0;
+}
+
 static int netvsc_probe(struct hv_device *dev,
 			const struct hv_vmbus_device_id *dev_id)
 {
-	struct net_device *net = NULL;
+	struct net_device *net = NULL, *vf_netdev;
 	struct net_device_context *net_device_ctx;
 	struct netvsc_device_info *device_info = NULL;
 	struct netvsc_device *nvdev;
@@ -2579,6 +2619,30 @@ static int netvsc_probe(struct hv_device *dev,
 	}
 
 	list_add(&net_device_ctx->list, &netvsc_dev_list);
+
+	/* When the hv_netvsc driver is unloaded and reloaded, the
+	 * NET_DEVICE_REGISTER for the vf device is replayed before probe
+	 * is complete. This is because register_netdevice_notifier() gets
+	 * registered before vmbus_driver_register() so that callback func
+	 * is set before probe and we don't miss events like NETDEV_POST_INIT
+	 * So, in this section we try to register the matching vf device that
+	 * is present as a netdevice, knowing that its register call is not
+	 * processed in the netvsc_netdev_notifier(as probing is progress and
+	 * get_netvsc_byslot fails).
+	 */
+	for_each_netdev(dev_net(net), vf_netdev) {
+		ret = check_dev_is_matching_vf(vf_netdev);
+		if (ret != 0)
+			continue;
+
+		if (net != get_netvsc_byslot(vf_netdev))
+			continue;
+
+		netvsc_prepare_bonding(vf_netdev);
+		netvsc_register_vf(vf_netdev, VF_REG_IN_PROBE);
+		__netvsc_vf_setup(net, vf_netdev);
+		break;
+	}
 	rtnl_unlock();
 
 	netvsc_devinfo_put(device_info);
@@ -2735,35 +2799,24 @@ static int netvsc_netdev_event(struct notifier_block *this,
 			       unsigned long event, void *ptr)
 {
 	struct net_device *event_dev = netdev_notifier_info_to_dev(ptr);
+	int ret = 0;
 
-	/* Skip our own events */
-	if (event_dev->netdev_ops == &device_ops)
-		return NOTIFY_DONE;
-
-	/* Avoid non-Ethernet type devices */
-	if (event_dev->type != ARPHRD_ETHER)
-		return NOTIFY_DONE;
-
-	/* Avoid Vlan dev with same MAC registering as VF */
-	if (is_vlan_dev(event_dev))
-		return NOTIFY_DONE;
-
-	/* Avoid Bonding master dev with same MAC registering as VF */
-	if ((event_dev->priv_flags & IFF_BONDING) &&
-	    (event_dev->flags & IFF_MASTER))
+	ret = check_dev_is_matching_vf(event_dev);
+	if (ret != 0)
 		return NOTIFY_DONE;
 
 	switch (event) {
 	case NETDEV_POST_INIT:
 		return netvsc_prepare_bonding(event_dev);
 	case NETDEV_REGISTER:
-		return netvsc_register_vf(event_dev);
+		return netvsc_register_vf(event_dev, VF_REG_IN_NOTIFIER);
 	case NETDEV_UNREGISTER:
 		return netvsc_unregister_vf(event_dev);
 	case NETDEV_UP:
 	case NETDEV_DOWN:
 	case NETDEV_CHANGE:
-		return netvsc_vf_changed(event_dev);
+	case NETDEV_GOING_DOWN:
+		return netvsc_vf_changed(event_dev, event);
 	default:
 		return NOTIFY_DONE;
 	}
diff --git a/drivers/net/hyperv/rndis_filter.c b/drivers/net/hyperv/rndis_filter.c
index 90bc0008fa2fd..13f62950eeb9f 100644
--- a/drivers/net/hyperv/rndis_filter.c
+++ b/drivers/net/hyperv/rndis_filter.c
@@ -1170,6 +1170,7 @@ static void netvsc_sc_open(struct vmbus_channel *new_sc)
 	/* Set the channel before opening.*/
 	nvchan->channel = new_sc;
 
+	new_sc->rqstor_size = netvsc_rqstor_size(netvsc_ring_bytes);
 	ret = vmbus_open(new_sc, netvsc_ring_bytes,
 			 netvsc_ring_bytes, NULL, 0,
 			 netvsc_channel_cb, nvchan);
diff --git a/drivers/net/usb/lan78xx.c b/drivers/net/usb/lan78xx.c
index c5a666bb86ee4..96d3d0bd248bc 100644
--- a/drivers/net/usb/lan78xx.c
+++ b/drivers/net/usb/lan78xx.c
@@ -90,6 +90,12 @@
 /* statistic update interval (mSec) */
 #define STAT_UPDATE_TIMER		(1 * 1000)
 
+/* time to wait for MAC or FCT to stop (jiffies) */
+#define HW_DISABLE_TIMEOUT		(HZ / 10)
+
+/* time to wait between polling MAC or FCT state (ms) */
+#define HW_DISABLE_DELAY_MS		1
+
 /* defines interrupts from interrupt EP */
 #define MAX_INT_EP			(32)
 #define INT_EP_INTEP			(31)
@@ -384,8 +390,9 @@ struct lan78xx_net {
 	struct urb		*urb_intr;
 	struct usb_anchor	deferred;
 
+	struct mutex		dev_mutex; /* serialise open/stop wrt suspend/resume */
 	struct mutex		phy_mutex; /* for phy access */
-	unsigned		pipe_in, pipe_out, pipe_intr;
+	unsigned int		pipe_in, pipe_out, pipe_intr;
 
 	u32			hard_mtu;	/* count any extra framing */
 	size_t			rx_urb_size;	/* size for rx urbs */
@@ -395,7 +402,7 @@ struct lan78xx_net {
 	wait_queue_head_t	*wait;
 	unsigned char		suspend_count;
 
-	unsigned		maxpacket;
+	unsigned int		maxpacket;
 	struct timer_list	delay;
 	struct timer_list	stat_monitor;
 
@@ -479,6 +486,26 @@ static int lan78xx_write_reg(struct lan78xx_net *dev, u32 index, u32 data)
 	return ret;
 }
 
+static int lan78xx_update_reg(struct lan78xx_net *dev, u32 reg, u32 mask,
+			      u32 data)
+{
+	int ret;
+	u32 buf;
+
+	ret = lan78xx_read_reg(dev, reg, &buf);
+	if (ret < 0)
+		return ret;
+
+	buf &= ~mask;
+	buf |= (mask & data);
+
+	ret = lan78xx_write_reg(dev, reg, buf);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
 static int lan78xx_read_stats(struct lan78xx_net *dev,
 			      struct lan78xx_statstage *data)
 {
@@ -504,7 +531,7 @@ static int lan78xx_read_stats(struct lan78xx_net *dev,
 	if (likely(ret >= 0)) {
 		src = (u32 *)stats;
 		dst = (u32 *)data;
-		for (i = 0; i < sizeof(*stats)/sizeof(u32); i++) {
+		for (i = 0; i < sizeof(*stats) / sizeof(u32); i++) {
 			le32_to_cpus(&src[i]);
 			dst[i] = src[i];
 		}
@@ -518,10 +545,11 @@ static int lan78xx_read_stats(struct lan78xx_net *dev,
 	return ret;
 }
 
-#define check_counter_rollover(struct1, dev_stats, member) {	\
-	if (struct1->member < dev_stats.saved.member)		\
-		dev_stats.rollover_count.member++;		\
-	}
+#define check_counter_rollover(struct1, dev_stats, member)		\
+	do {								\
+		if ((struct1)->member < (dev_stats).saved.member)	\
+			(dev_stats).rollover_count.member++;		\
+	} while (0)
 
 static void lan78xx_check_stat_rollover(struct lan78xx_net *dev,
 					struct lan78xx_statstage *stats)
@@ -847,9 +875,9 @@ static int lan78xx_read_raw_otp(struct lan78xx_net *dev, u32 offset,
 
 	for (i = 0; i < length; i++) {
 		lan78xx_write_reg(dev, OTP_ADDR1,
-					((offset + i) >> 8) & OTP_ADDR1_15_11);
+				  ((offset + i) >> 8) & OTP_ADDR1_15_11);
 		lan78xx_write_reg(dev, OTP_ADDR2,
-					((offset + i) & OTP_ADDR2_10_3));
+				  ((offset + i) & OTP_ADDR2_10_3));
 
 		lan78xx_write_reg(dev, OTP_FUNC_CMD, OTP_FUNC_CMD_READ_);
 		lan78xx_write_reg(dev, OTP_CMD_GO, OTP_CMD_GO_GO_);
@@ -903,9 +931,9 @@ static int lan78xx_write_raw_otp(struct lan78xx_net *dev, u32 offset,
 
 	for (i = 0; i < length; i++) {
 		lan78xx_write_reg(dev, OTP_ADDR1,
-					((offset + i) >> 8) & OTP_ADDR1_15_11);
+				  ((offset + i) >> 8) & OTP_ADDR1_15_11);
 		lan78xx_write_reg(dev, OTP_ADDR2,
-					((offset + i) & OTP_ADDR2_10_3));
+				  ((offset + i) & OTP_ADDR2_10_3));
 		lan78xx_write_reg(dev, OTP_PRGM_DATA, data[i]);
 		lan78xx_write_reg(dev, OTP_TST_CMD, OTP_TST_CMD_PRGVRFY_);
 		lan78xx_write_reg(dev, OTP_CMD_GO, OTP_CMD_GO_GO_);
@@ -962,7 +990,7 @@ static int lan78xx_dataport_wait_not_busy(struct lan78xx_net *dev)
 		usleep_range(40, 100);
 	}
 
-	netdev_warn(dev->net, "lan78xx_dataport_wait_not_busy timed out");
+	netdev_warn(dev->net, "%s timed out", __func__);
 
 	return -EIO;
 }
@@ -975,7 +1003,7 @@ static int lan78xx_dataport_write(struct lan78xx_net *dev, u32 ram_select,
 	int i, ret;
 
 	if (usb_autopm_get_interface(dev->intf) < 0)
-			return 0;
+		return 0;
 
 	mutex_lock(&pdata->dataport_mutex);
 
@@ -1048,9 +1076,9 @@ static void lan78xx_deferred_multicast_write(struct work_struct *param)
 	for (i = 1; i < NUM_OF_MAF; i++) {
 		lan78xx_write_reg(dev, MAF_HI(i), 0);
 		lan78xx_write_reg(dev, MAF_LO(i),
-					pdata->pfilter_table[i][1]);
+				  pdata->pfilter_table[i][1]);
 		lan78xx_write_reg(dev, MAF_HI(i),
-					pdata->pfilter_table[i][0]);
+				  pdata->pfilter_table[i][0]);
 	}
 
 	lan78xx_write_reg(dev, RFE_CTL, pdata->rfe_ctl);
@@ -1069,11 +1097,12 @@ static void lan78xx_set_multicast(struct net_device *netdev)
 			    RFE_CTL_DA_PERFECT_ | RFE_CTL_MCAST_HASH_);
 
 	for (i = 0; i < DP_SEL_VHF_HASH_LEN; i++)
-			pdata->mchash_table[i] = 0;
+		pdata->mchash_table[i] = 0;
+
 	/* pfilter_table[0] has own HW address */
 	for (i = 1; i < NUM_OF_MAF; i++) {
-			pdata->pfilter_table[i][0] =
-			pdata->pfilter_table[i][1] = 0;
+		pdata->pfilter_table[i][0] = 0;
+		pdata->pfilter_table[i][1] = 0;
 	}
 
 	pdata->rfe_ctl |= RFE_CTL_BCAST_EN_;
@@ -1163,7 +1192,7 @@ static int lan78xx_link_reset(struct lan78xx_net *dev)
 	/* clear LAN78xx interrupt status */
 	ret = lan78xx_write_reg(dev, INT_STS, INT_STS_PHY_INT_);
 	if (unlikely(ret < 0))
-		return -EIO;
+		return ret;
 
 	mutex_lock(&phydev->lock);
 	phy_read_status(phydev);
@@ -1176,11 +1205,11 @@ static int lan78xx_link_reset(struct lan78xx_net *dev)
 		/* reset MAC */
 		ret = lan78xx_read_reg(dev, MAC_CR, &buf);
 		if (unlikely(ret < 0))
-			return -EIO;
+			return ret;
 		buf |= MAC_CR_RST_;
 		ret = lan78xx_write_reg(dev, MAC_CR, buf);
 		if (unlikely(ret < 0))
-			return -EIO;
+			return ret;
 
 		del_timer(&dev->stat_monitor);
 	} else if (link && !dev->link_on) {
@@ -1192,18 +1221,30 @@ static int lan78xx_link_reset(struct lan78xx_net *dev)
 			if (ecmd.base.speed == 1000) {
 				/* disable U2 */
 				ret = lan78xx_read_reg(dev, USB_CFG1, &buf);
+				if (ret < 0)
+					return ret;
 				buf &= ~USB_CFG1_DEV_U2_INIT_EN_;
 				ret = lan78xx_write_reg(dev, USB_CFG1, buf);
+				if (ret < 0)
+					return ret;
 				/* enable U1 */
 				ret = lan78xx_read_reg(dev, USB_CFG1, &buf);
+				if (ret < 0)
+					return ret;
 				buf |= USB_CFG1_DEV_U1_INIT_EN_;
 				ret = lan78xx_write_reg(dev, USB_CFG1, buf);
+				if (ret < 0)
+					return ret;
 			} else {
 				/* enable U1 & U2 */
 				ret = lan78xx_read_reg(dev, USB_CFG1, &buf);
+				if (ret < 0)
+					return ret;
 				buf |= USB_CFG1_DEV_U2_INIT_EN_;
 				buf |= USB_CFG1_DEV_U1_INIT_EN_;
 				ret = lan78xx_write_reg(dev, USB_CFG1, buf);
+				if (ret < 0)
+					return ret;
 			}
 		}
 
@@ -1221,6 +1262,8 @@ static int lan78xx_link_reset(struct lan78xx_net *dev)
 
 		ret = lan78xx_update_flowcontrol(dev, ecmd.base.duplex, ladv,
 						 radv);
+		if (ret < 0)
+			return ret;
 
 		if (!timer_pending(&dev->stat_monitor)) {
 			dev->delta = 1;
@@ -1231,7 +1274,7 @@ static int lan78xx_link_reset(struct lan78xx_net *dev)
 		tasklet_schedule(&dev->bh);
 	}
 
-	return ret;
+	return 0;
 }
 
 /* some work can't be done in tasklets, so we use keventd
@@ -1267,9 +1310,10 @@ static void lan78xx_status(struct lan78xx_net *dev, struct urb *urb)
 			generic_handle_irq(dev->domain_data.phyirq);
 			local_irq_enable();
 		}
-	} else
+	} else {
 		netdev_warn(dev->net,
 			    "unexpected interrupt: 0x%08x\n", intdata);
+	}
 }
 
 static int lan78xx_ethtool_get_eeprom_len(struct net_device *netdev)
@@ -1358,7 +1402,7 @@ static void lan78xx_get_wol(struct net_device *netdev,
 	struct lan78xx_priv *pdata = (struct lan78xx_priv *)(dev->data[0]);
 
 	if (usb_autopm_get_interface(dev->intf) < 0)
-			return;
+		return;
 
 	ret = lan78xx_read_reg(dev, USB_CFG0, &buf);
 	if (unlikely(ret < 0)) {
@@ -1980,7 +2024,7 @@ static int lan8835_fixup(struct phy_device *phydev)
 
 	/* RGMII MAC TXC Delay Enable */
 	lan78xx_write_reg(dev, MAC_RGMII_ID,
-				MAC_RGMII_ID_TXC_DELAY_EN_);
+			  MAC_RGMII_ID_TXC_DELAY_EN_);
 
 	/* RGMII TX DLL Tune Adjust */
 	lan78xx_write_reg(dev, RGMII_TX_BYP_DLL, 0x3D00);
@@ -2244,11 +2288,16 @@ static int lan78xx_change_mtu(struct net_device *netdev, int new_mtu)
 	int ll_mtu = new_mtu + netdev->hard_header_len;
 	int old_hard_mtu = dev->hard_mtu;
 	int old_rx_urb_size = dev->rx_urb_size;
+	int ret;
 
 	/* no second zero-length packet read wanted after mtu-sized packets */
 	if ((ll_mtu % dev->maxpacket) == 0)
 		return -EDOM;
 
+	ret = usb_autopm_get_interface(dev->intf);
+	if (ret < 0)
+		return ret;
+
 	lan78xx_set_rx_max_frame_length(dev, new_mtu + VLAN_ETH_HLEN);
 
 	netdev->mtu = new_mtu;
@@ -2264,6 +2313,8 @@ static int lan78xx_change_mtu(struct net_device *netdev, int new_mtu)
 		}
 	}
 
+	usb_autopm_put_interface(dev->intf);
+
 	return 0;
 }
 
@@ -2420,26 +2471,186 @@ static void lan78xx_init_ltm(struct lan78xx_net *dev)
 	lan78xx_write_reg(dev, LTM_INACTIVE1, regs[5]);
 }
 
+static int lan78xx_start_hw(struct lan78xx_net *dev, u32 reg, u32 hw_enable)
+{
+	return lan78xx_update_reg(dev, reg, hw_enable, hw_enable);
+}
+
+static int lan78xx_stop_hw(struct lan78xx_net *dev, u32 reg, u32 hw_enabled,
+			   u32 hw_disabled)
+{
+	unsigned long timeout;
+	bool stopped = true;
+	int ret;
+	u32 buf;
+
+	/* Stop the h/w block (if not already stopped) */
+
+	ret = lan78xx_read_reg(dev, reg, &buf);
+	if (ret < 0)
+		return ret;
+
+	if (buf & hw_enabled) {
+		buf &= ~hw_enabled;
+
+		ret = lan78xx_write_reg(dev, reg, buf);
+		if (ret < 0)
+			return ret;
+
+		stopped = false;
+		timeout = jiffies + HW_DISABLE_TIMEOUT;
+		do  {
+			ret = lan78xx_read_reg(dev, reg, &buf);
+			if (ret < 0)
+				return ret;
+
+			if (buf & hw_disabled)
+				stopped = true;
+			else
+				msleep(HW_DISABLE_DELAY_MS);
+		} while (!stopped && !time_after(jiffies, timeout));
+	}
+
+	ret = stopped ? 0 : -ETIME;
+
+	return ret;
+}
+
+static int lan78xx_flush_fifo(struct lan78xx_net *dev, u32 reg, u32 fifo_flush)
+{
+	return lan78xx_update_reg(dev, reg, fifo_flush, fifo_flush);
+}
+
+static int lan78xx_start_tx_path(struct lan78xx_net *dev)
+{
+	int ret;
+
+	netif_dbg(dev, drv, dev->net, "start tx path");
+
+	/* Start the MAC transmitter */
+
+	ret = lan78xx_start_hw(dev, MAC_TX, MAC_TX_TXEN_);
+	if (ret < 0)
+		return ret;
+
+	/* Start the Tx FIFO */
+
+	ret = lan78xx_start_hw(dev, FCT_TX_CTL, FCT_TX_CTL_EN_);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+static int lan78xx_stop_tx_path(struct lan78xx_net *dev)
+{
+	int ret;
+
+	netif_dbg(dev, drv, dev->net, "stop tx path");
+
+	/* Stop the Tx FIFO */
+
+	ret = lan78xx_stop_hw(dev, FCT_TX_CTL, FCT_TX_CTL_EN_, FCT_TX_CTL_DIS_);
+	if (ret < 0)
+		return ret;
+
+	/* Stop the MAC transmitter */
+
+	ret = lan78xx_stop_hw(dev, MAC_TX, MAC_TX_TXEN_, MAC_TX_TXD_);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+/* The caller must ensure the Tx path is stopped before calling
+ * lan78xx_flush_tx_fifo().
+ */
+static int lan78xx_flush_tx_fifo(struct lan78xx_net *dev)
+{
+	return lan78xx_flush_fifo(dev, FCT_TX_CTL, FCT_TX_CTL_RST_);
+}
+
+static int lan78xx_start_rx_path(struct lan78xx_net *dev)
+{
+	int ret;
+
+	netif_dbg(dev, drv, dev->net, "start rx path");
+
+	/* Start the Rx FIFO */
+
+	ret = lan78xx_start_hw(dev, FCT_RX_CTL, FCT_RX_CTL_EN_);
+	if (ret < 0)
+		return ret;
+
+	/* Start the MAC receiver*/
+
+	ret = lan78xx_start_hw(dev, MAC_RX, MAC_RX_RXEN_);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+static int lan78xx_stop_rx_path(struct lan78xx_net *dev)
+{
+	int ret;
+
+	netif_dbg(dev, drv, dev->net, "stop rx path");
+
+	/* Stop the MAC receiver */
+
+	ret = lan78xx_stop_hw(dev, MAC_RX, MAC_RX_RXEN_, MAC_RX_RXD_);
+	if (ret < 0)
+		return ret;
+
+	/* Stop the Rx FIFO */
+
+	ret = lan78xx_stop_hw(dev, FCT_RX_CTL, FCT_RX_CTL_EN_, FCT_RX_CTL_DIS_);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+/* The caller must ensure the Rx path is stopped before calling
+ * lan78xx_flush_rx_fifo().
+ */
+static int lan78xx_flush_rx_fifo(struct lan78xx_net *dev)
+{
+	return lan78xx_flush_fifo(dev, FCT_RX_CTL, FCT_RX_CTL_RST_);
+}
+
 static int lan78xx_reset(struct lan78xx_net *dev)
 {
 	struct lan78xx_priv *pdata = (struct lan78xx_priv *)(dev->data[0]);
-	u32 buf;
-	int ret = 0;
 	unsigned long timeout;
+	int ret;
+	u32 buf;
 	u8 sig;
 
 	ret = lan78xx_read_reg(dev, HW_CFG, &buf);
+	if (ret < 0)
+		return ret;
+
 	buf |= HW_CFG_LRST_;
+
 	ret = lan78xx_write_reg(dev, HW_CFG, buf);
+	if (ret < 0)
+		return ret;
 
 	timeout = jiffies + HZ;
 	do {
 		mdelay(1);
 		ret = lan78xx_read_reg(dev, HW_CFG, &buf);
+		if (ret < 0)
+			return ret;
+
 		if (time_after(jiffies, timeout)) {
 			netdev_warn(dev->net,
 				    "timeout on completion of LiteReset");
-			return -EIO;
+			ret = -ETIMEDOUT;
+			return ret;
 		}
 	} while (buf & HW_CFG_LRST_);
 
@@ -2447,13 +2658,22 @@ static int lan78xx_reset(struct lan78xx_net *dev)
 
 	/* save DEVID for later usage */
 	ret = lan78xx_read_reg(dev, ID_REV, &buf);
+	if (ret < 0)
+		return ret;
+
 	dev->chipid = (buf & ID_REV_CHIP_ID_MASK_) >> 16;
 	dev->chiprev = buf & ID_REV_CHIP_REV_MASK_;
 
 	/* Respond to the IN token with a NAK */
 	ret = lan78xx_read_reg(dev, USB_CFG0, &buf);
+	if (ret < 0)
+		return ret;
+
 	buf |= USB_CFG_BIR_;
+
 	ret = lan78xx_write_reg(dev, USB_CFG0, buf);
+	if (ret < 0)
+		return ret;
 
 	/* Init LTM */
 	lan78xx_init_ltm(dev);
@@ -2476,53 +2696,105 @@ static int lan78xx_reset(struct lan78xx_net *dev)
 	}
 
 	ret = lan78xx_write_reg(dev, BURST_CAP, buf);
+	if (ret < 0)
+		return ret;
+
 	ret = lan78xx_write_reg(dev, BULK_IN_DLY, DEFAULT_BULK_IN_DELAY);
+	if (ret < 0)
+		return ret;
 
 	ret = lan78xx_read_reg(dev, HW_CFG, &buf);
+	if (ret < 0)
+		return ret;
+
 	buf |= HW_CFG_MEF_;
+
 	ret = lan78xx_write_reg(dev, HW_CFG, buf);
+	if (ret < 0)
+		return ret;
 
 	ret = lan78xx_read_reg(dev, USB_CFG0, &buf);
+	if (ret < 0)
+		return ret;
+
 	buf |= USB_CFG_BCE_;
+
 	ret = lan78xx_write_reg(dev, USB_CFG0, buf);
+	if (ret < 0)
+		return ret;
 
 	/* set FIFO sizes */
 	buf = (MAX_RX_FIFO_SIZE - 512) / 512;
+
 	ret = lan78xx_write_reg(dev, FCT_RX_FIFO_END, buf);
+	if (ret < 0)
+		return ret;
 
 	buf = (MAX_TX_FIFO_SIZE - 512) / 512;
+
 	ret = lan78xx_write_reg(dev, FCT_TX_FIFO_END, buf);
+	if (ret < 0)
+		return ret;
 
 	ret = lan78xx_write_reg(dev, INT_STS, INT_STS_CLEAR_ALL_);
+	if (ret < 0)
+		return ret;
+
 	ret = lan78xx_write_reg(dev, FLOW, 0);
+	if (ret < 0)
+		return ret;
+
 	ret = lan78xx_write_reg(dev, FCT_FLOW, 0);
+	if (ret < 0)
+		return ret;
 
 	/* Don't need rfe_ctl_lock during initialisation */
 	ret = lan78xx_read_reg(dev, RFE_CTL, &pdata->rfe_ctl);
+	if (ret < 0)
+		return ret;
+
 	pdata->rfe_ctl |= RFE_CTL_BCAST_EN_ | RFE_CTL_DA_PERFECT_;
+
 	ret = lan78xx_write_reg(dev, RFE_CTL, pdata->rfe_ctl);
+	if (ret < 0)
+		return ret;
 
 	/* Enable or disable checksum offload engines */
-	lan78xx_set_features(dev->net, dev->net->features);
+	ret = lan78xx_set_features(dev->net, dev->net->features);
+	if (ret < 0)
+		return ret;
 
 	lan78xx_set_multicast(dev->net);
 
 	/* reset PHY */
 	ret = lan78xx_read_reg(dev, PMT_CTL, &buf);
+	if (ret < 0)
+		return ret;
+
 	buf |= PMT_CTL_PHY_RST_;
+
 	ret = lan78xx_write_reg(dev, PMT_CTL, buf);
+	if (ret < 0)
+		return ret;
 
 	timeout = jiffies + HZ;
 	do {
 		mdelay(1);
 		ret = lan78xx_read_reg(dev, PMT_CTL, &buf);
+		if (ret < 0)
+			return ret;
+
 		if (time_after(jiffies, timeout)) {
 			netdev_warn(dev->net, "timeout waiting for PHY Reset");
-			return -EIO;
+			ret = -ETIMEDOUT;
+			return ret;
 		}
 	} while ((buf & PMT_CTL_PHY_RST_) || !(buf & PMT_CTL_READY_));
 
 	ret = lan78xx_read_reg(dev, MAC_CR, &buf);
+	if (ret < 0)
+		return ret;
+
 	/* LAN7801 only has RGMII mode */
 	if (dev->chipid == ID_REV_CHIP_ID_7801_)
 		buf &= ~MAC_CR_GMII_EN_;
@@ -2537,27 +2809,13 @@ static int lan78xx_reset(struct lan78xx_net *dev)
 		}
 	}
 	ret = lan78xx_write_reg(dev, MAC_CR, buf);
-
-	ret = lan78xx_read_reg(dev, MAC_TX, &buf);
-	buf |= MAC_TX_TXEN_;
-	ret = lan78xx_write_reg(dev, MAC_TX, buf);
-
-	ret = lan78xx_read_reg(dev, FCT_TX_CTL, &buf);
-	buf |= FCT_TX_CTL_EN_;
-	ret = lan78xx_write_reg(dev, FCT_TX_CTL, buf);
+	if (ret < 0)
+		return ret;
 
 	ret = lan78xx_set_rx_max_frame_length(dev,
 					      dev->net->mtu + VLAN_ETH_HLEN);
 
-	ret = lan78xx_read_reg(dev, MAC_RX, &buf);
-	buf |= MAC_RX_RXEN_;
-	ret = lan78xx_write_reg(dev, MAC_RX, buf);
-
-	ret = lan78xx_read_reg(dev, FCT_RX_CTL, &buf);
-	buf |= FCT_RX_CTL_EN_;
-	ret = lan78xx_write_reg(dev, FCT_RX_CTL, buf);
-
-	return 0;
+	return ret;
 }
 
 static void lan78xx_init_stats(struct lan78xx_net *dev)
@@ -2591,9 +2849,13 @@ static int lan78xx_open(struct net_device *net)
 	struct lan78xx_net *dev = netdev_priv(net);
 	int ret;
 
+	netif_dbg(dev, ifup, dev->net, "open device");
+
 	ret = usb_autopm_get_interface(dev->intf);
 	if (ret < 0)
-		goto out;
+		return ret;
+
+	mutex_lock(&dev->dev_mutex);
 
 	phy_start(net->phydev);
 
@@ -2609,6 +2871,20 @@ static int lan78xx_open(struct net_device *net)
 		}
 	}
 
+	ret = lan78xx_flush_rx_fifo(dev);
+	if (ret < 0)
+		goto done;
+	ret = lan78xx_flush_tx_fifo(dev);
+	if (ret < 0)
+		goto done;
+
+	ret = lan78xx_start_tx_path(dev);
+	if (ret < 0)
+		goto done;
+	ret = lan78xx_start_rx_path(dev);
+	if (ret < 0)
+		goto done;
+
 	lan78xx_init_stats(dev);
 
 	set_bit(EVENT_DEV_OPEN, &dev->flags);
@@ -2619,9 +2895,11 @@ static int lan78xx_open(struct net_device *net)
 
 	lan78xx_defer_kevent(dev, EVENT_LINK_RESET);
 done:
-	usb_autopm_put_interface(dev->intf);
+	mutex_unlock(&dev->dev_mutex);
+
+	if (ret < 0)
+		usb_autopm_put_interface(dev->intf);
 
-out:
 	return ret;
 }
 
@@ -2638,38 +2916,56 @@ static void lan78xx_terminate_urbs(struct lan78xx_net *dev)
 	temp = unlink_urbs(dev, &dev->txq) + unlink_urbs(dev, &dev->rxq);
 
 	/* maybe wait for deletions to finish. */
-	while (!skb_queue_empty(&dev->rxq) &&
-	       !skb_queue_empty(&dev->txq) &&
-	       !skb_queue_empty(&dev->done)) {
+	while (!skb_queue_empty(&dev->rxq) ||
+	       !skb_queue_empty(&dev->txq)) {
 		schedule_timeout(msecs_to_jiffies(UNLINK_TIMEOUT_MS));
 		set_current_state(TASK_UNINTERRUPTIBLE);
 		netif_dbg(dev, ifdown, dev->net,
-			  "waited for %d urb completions\n", temp);
+			  "waited for %d urb completions", temp);
 	}
 	set_current_state(TASK_RUNNING);
 	dev->wait = NULL;
 	remove_wait_queue(&unlink_wakeup, &wait);
+
+	while (!skb_queue_empty(&dev->done)) {
+		struct skb_data *entry;
+		struct sk_buff *skb;
+
+		skb = skb_dequeue(&dev->done);
+		entry = (struct skb_data *)(skb->cb);
+		usb_free_urb(entry->urb);
+		dev_kfree_skb(skb);
+	}
 }
 
 static int lan78xx_stop(struct net_device *net)
 {
 	struct lan78xx_net *dev = netdev_priv(net);
 
+	netif_dbg(dev, ifup, dev->net, "stop device");
+
+	mutex_lock(&dev->dev_mutex);
+
 	if (timer_pending(&dev->stat_monitor))
 		del_timer_sync(&dev->stat_monitor);
 
-	if (net->phydev)
-		phy_stop(net->phydev);
-
 	clear_bit(EVENT_DEV_OPEN, &dev->flags);
 	netif_stop_queue(net);
+	tasklet_kill(&dev->bh);
+
+	lan78xx_terminate_urbs(dev);
 
 	netif_info(dev, ifdown, dev->net,
 		   "stop stats: rx/tx %lu/%lu, errs %lu/%lu\n",
 		   net->stats.rx_packets, net->stats.tx_packets,
 		   net->stats.rx_errors, net->stats.tx_errors);
 
-	lan78xx_terminate_urbs(dev);
+	/* ignore errors that occur stopping the Tx and Rx data paths */
+	lan78xx_stop_tx_path(dev);
+	lan78xx_stop_rx_path(dev);
+
+	if (net->phydev)
+		phy_stop(net->phydev);
 
 	usb_kill_urb(dev->urb_intr);
 
@@ -2679,12 +2975,17 @@ static int lan78xx_stop(struct net_device *net)
 	 * can't flush_scheduled_work() until we drop rtnl (later),
 	 * else workers could deadlock; so make workers a NOP.
 	 */
-	dev->flags = 0;
+	clear_bit(EVENT_TX_HALT, &dev->flags);
+	clear_bit(EVENT_RX_HALT, &dev->flags);
+	clear_bit(EVENT_LINK_RESET, &dev->flags);
+	clear_bit(EVENT_STAT_UPDATE, &dev->flags);
+
 	cancel_delayed_work_sync(&dev->wq);
-	tasklet_kill(&dev->bh);
 
 	usb_autopm_put_interface(dev->intf);
 
+	mutex_unlock(&dev->dev_mutex);
+
 	return 0;
 }
 
@@ -2807,6 +3108,9 @@ lan78xx_start_xmit(struct sk_buff *skb, struct net_device *net)
 	struct lan78xx_net *dev = netdev_priv(net);
 	struct sk_buff *skb2 = NULL;
 
+	if (test_bit(EVENT_DEV_ASLEEP, &dev->flags))
+		schedule_delayed_work(&dev->wq, 0);
+
 	if (skb) {
 		skb_tx_timestamp(skb);
 		skb2 = lan78xx_tx_prep(dev, skb, GFP_ATOMIC);
@@ -3334,9 +3638,10 @@ static void lan78xx_tx_bh(struct lan78xx_net *dev)
 		if (skb)
 			dev_kfree_skb_any(skb);
 		usb_free_urb(urb);
-	} else
+	} else {
 		netif_dbg(dev, tx_queued, dev->net,
 			  "> tx, len %d, type 0x%x\n", length, skb->protocol);
+	}
 }
 
 static void lan78xx_rx_bh(struct lan78xx_net *dev)
@@ -3412,18 +3717,17 @@ static void lan78xx_delayedwork(struct work_struct *work)
 
 	dev = container_of(work, struct lan78xx_net, wq.work);
 
+	if (usb_autopm_get_interface(dev->intf) < 0)
+		return;
+
 	if (test_bit(EVENT_TX_HALT, &dev->flags)) {
 		unlink_urbs(dev, &dev->txq);
-		status = usb_autopm_get_interface(dev->intf);
-		if (status < 0)
-			goto fail_pipe;
+
 		status = usb_clear_halt(dev->udev, dev->pipe_out);
-		usb_autopm_put_interface(dev->intf);
 		if (status < 0 &&
 		    status != -EPIPE &&
 		    status != -ESHUTDOWN) {
 			if (netif_msg_tx_err(dev))
-fail_pipe:
 				netdev_err(dev->net,
 					   "can't clear tx halt, status %d\n",
 					   status);
@@ -3433,18 +3737,14 @@ static void lan78xx_delayedwork(struct work_struct *work)
 				netif_wake_queue(dev->net);
 		}
 	}
+
 	if (test_bit(EVENT_RX_HALT, &dev->flags)) {
 		unlink_urbs(dev, &dev->rxq);
-		status = usb_autopm_get_interface(dev->intf);
-		if (status < 0)
-				goto fail_halt;
 		status = usb_clear_halt(dev->udev, dev->pipe_in);
-		usb_autopm_put_interface(dev->intf);
 		if (status < 0 &&
 		    status != -EPIPE &&
 		    status != -ESHUTDOWN) {
 			if (netif_msg_rx_err(dev))
-fail_halt:
 				netdev_err(dev->net,
 					   "can't clear rx halt, status %d\n",
 					   status);
@@ -3458,16 +3758,9 @@ static void lan78xx_delayedwork(struct work_struct *work)
 		int ret = 0;
 
 		clear_bit(EVENT_LINK_RESET, &dev->flags);
-		status = usb_autopm_get_interface(dev->intf);
-		if (status < 0)
-			goto skip_reset;
 		if (lan78xx_link_reset(dev) < 0) {
-			usb_autopm_put_interface(dev->intf);
-skip_reset:
 			netdev_info(dev->net, "link reset failed (%d)\n",
 				    ret);
-		} else {
-			usb_autopm_put_interface(dev->intf);
 		}
 	}
 
@@ -3481,6 +3774,8 @@ static void lan78xx_delayedwork(struct work_struct *work)
 
 		dev->delta = min((dev->delta * 2), 50);
 	}
+
+	usb_autopm_put_interface(dev->intf);
 }
 
 static void intr_complete(struct urb *urb)
@@ -3610,8 +3905,8 @@ static int lan78xx_probe(struct usb_interface *intf,
 	struct net_device *netdev;
 	struct usb_device *udev;
 	int ret;
-	unsigned maxp;
-	unsigned period;
+	unsigned int maxp;
+	unsigned int period;
 	u8 *buf = NULL;
 
 	udev = interface_to_usbdev(intf);
@@ -3640,6 +3935,7 @@ static int lan78xx_probe(struct usb_interface *intf,
 	skb_queue_head_init(&dev->rxq_pause);
 	skb_queue_head_init(&dev->txq_pend);
 	mutex_init(&dev->phy_mutex);
+	mutex_init(&dev->dev_mutex);
 
 	tasklet_init(&dev->bh, lan78xx_bh, (unsigned long)dev);
 	INIT_DELAYED_WORK(&dev->wq, lan78xx_delayedwork);
@@ -3782,37 +4078,119 @@ static u16 lan78xx_wakeframe_crc16(const u8 *buf, int len)
 	return crc;
 }
 
-static int lan78xx_set_suspend(struct lan78xx_net *dev, u32 wol)
+static int lan78xx_set_auto_suspend(struct lan78xx_net *dev)
 {
 	u32 buf;
-	int mask_index;
-	u16 crc;
-	u32 temp_wucsr;
-	u32 temp_pmt_ctl;
+	int ret;
+
+	ret = lan78xx_stop_tx_path(dev);
+	if (ret < 0)
+		return ret;
+
+	ret = lan78xx_stop_rx_path(dev);
+	if (ret < 0)
+		return ret;
+
+	/* auto suspend (selective suspend) */
+
+	ret = lan78xx_write_reg(dev, WUCSR, 0);
+	if (ret < 0)
+		return ret;
+	ret = lan78xx_write_reg(dev, WUCSR2, 0);
+	if (ret < 0)
+		return ret;
+	ret = lan78xx_write_reg(dev, WK_SRC, 0xFFF1FF1FUL);
+	if (ret < 0)
+		return ret;
+
+	/* set goodframe wakeup */
+
+	ret = lan78xx_read_reg(dev, WUCSR, &buf);
+	if (ret < 0)
+		return ret;
+
+	buf |= WUCSR_RFE_WAKE_EN_;
+	buf |= WUCSR_STORE_WAKE_;
+
+	ret = lan78xx_write_reg(dev, WUCSR, buf);
+	if (ret < 0)
+		return ret;
+
+	ret = lan78xx_read_reg(dev, PMT_CTL, &buf);
+	if (ret < 0)
+		return ret;
+
+	buf &= ~PMT_CTL_RES_CLR_WKP_EN_;
+	buf |= PMT_CTL_RES_CLR_WKP_STS_;
+	buf |= PMT_CTL_PHY_WAKE_EN_;
+	buf |= PMT_CTL_WOL_EN_;
+	buf &= ~PMT_CTL_SUS_MODE_MASK_;
+	buf |= PMT_CTL_SUS_MODE_3_;
+
+	ret = lan78xx_write_reg(dev, PMT_CTL, buf);
+	if (ret < 0)
+		return ret;
+
+	ret = lan78xx_read_reg(dev, PMT_CTL, &buf);
+	if (ret < 0)
+		return ret;
+
+	buf |= PMT_CTL_WUPS_MASK_;
+
+	ret = lan78xx_write_reg(dev, PMT_CTL, buf);
+	if (ret < 0)
+		return ret;
+
+	ret = lan78xx_start_rx_path(dev);
+
+	return ret;
+}
+
+static int lan78xx_set_suspend(struct lan78xx_net *dev, u32 wol)
+{
 	const u8 ipv4_multicast[3] = { 0x01, 0x00, 0x5E };
 	const u8 ipv6_multicast[3] = { 0x33, 0x33 };
 	const u8 arp_type[2] = { 0x08, 0x06 };
+	u32 temp_pmt_ctl;
+	int mask_index;
+	u32 temp_wucsr;
+	u32 buf;
+	u16 crc;
+	int ret;
 
-	lan78xx_read_reg(dev, MAC_TX, &buf);
-	buf &= ~MAC_TX_TXEN_;
-	lan78xx_write_reg(dev, MAC_TX, buf);
-	lan78xx_read_reg(dev, MAC_RX, &buf);
-	buf &= ~MAC_RX_RXEN_;
-	lan78xx_write_reg(dev, MAC_RX, buf);
+	ret = lan78xx_stop_tx_path(dev);
+	if (ret < 0)
+		return ret;
+	ret = lan78xx_stop_rx_path(dev);
+	if (ret < 0)
+		return ret;
 
-	lan78xx_write_reg(dev, WUCSR, 0);
-	lan78xx_write_reg(dev, WUCSR2, 0);
-	lan78xx_write_reg(dev, WK_SRC, 0xFFF1FF1FUL);
+	ret = lan78xx_write_reg(dev, WUCSR, 0);
+	if (ret < 0)
+		return ret;
+	ret = lan78xx_write_reg(dev, WUCSR2, 0);
+	if (ret < 0)
+		return ret;
+	ret = lan78xx_write_reg(dev, WK_SRC, 0xFFF1FF1FUL);
+	if (ret < 0)
+		return ret;
 
 	temp_wucsr = 0;
 
 	temp_pmt_ctl = 0;
-	lan78xx_read_reg(dev, PMT_CTL, &temp_pmt_ctl);
+
+	ret = lan78xx_read_reg(dev, PMT_CTL, &temp_pmt_ctl);
+	if (ret < 0)
+		return ret;
+
 	temp_pmt_ctl &= ~PMT_CTL_RES_CLR_WKP_EN_;
 	temp_pmt_ctl |= PMT_CTL_RES_CLR_WKP_STS_;
 
-	for (mask_index = 0; mask_index < NUM_OF_WUF_CFG; mask_index++)
-		lan78xx_write_reg(dev, WUF_CFG(mask_index), 0);
+	for (mask_index = 0; mask_index < NUM_OF_WUF_CFG; mask_index++) {
+		ret = lan78xx_write_reg(dev, WUF_CFG(mask_index), 0);
+		if (ret < 0)
+			return ret;
+	}
 
 	mask_index = 0;
 	if (wol & WAKE_PHY) {
@@ -3841,30 +4219,52 @@ static int lan78xx_set_suspend(struct lan78xx_net *dev, u32 wol)
 
 		/* set WUF_CFG & WUF_MASK for IPv4 Multicast */
 		crc = lan78xx_wakeframe_crc16(ipv4_multicast, 3);
-		lan78xx_write_reg(dev, WUF_CFG(mask_index),
+		ret = lan78xx_write_reg(dev, WUF_CFG(mask_index),
 					WUF_CFGX_EN_ |
 					WUF_CFGX_TYPE_MCAST_ |
 					(0 << WUF_CFGX_OFFSET_SHIFT_) |
 					(crc & WUF_CFGX_CRC16_MASK_));
+		if (ret < 0)
+			return ret;
+
+		ret = lan78xx_write_reg(dev, WUF_MASK0(mask_index), 7);
+		if (ret < 0)
+			return ret;
+		ret = lan78xx_write_reg(dev, WUF_MASK1(mask_index), 0);
+		if (ret < 0)
+			return ret;
+		ret = lan78xx_write_reg(dev, WUF_MASK2(mask_index), 0);
+		if (ret < 0)
+			return ret;
+		ret = lan78xx_write_reg(dev, WUF_MASK3(mask_index), 0);
+		if (ret < 0)
+			return ret;
 
-		lan78xx_write_reg(dev, WUF_MASK0(mask_index), 7);
-		lan78xx_write_reg(dev, WUF_MASK1(mask_index), 0);
-		lan78xx_write_reg(dev, WUF_MASK2(mask_index), 0);
-		lan78xx_write_reg(dev, WUF_MASK3(mask_index), 0);
 		mask_index++;
 
 		/* for IPv6 Multicast */
 		crc = lan78xx_wakeframe_crc16(ipv6_multicast, 2);
-		lan78xx_write_reg(dev, WUF_CFG(mask_index),
+		ret = lan78xx_write_reg(dev, WUF_CFG(mask_index),
 					WUF_CFGX_EN_ |
 					WUF_CFGX_TYPE_MCAST_ |
 					(0 << WUF_CFGX_OFFSET_SHIFT_) |
 					(crc & WUF_CFGX_CRC16_MASK_));
+		if (ret < 0)
+			return ret;
+
+		ret = lan78xx_write_reg(dev, WUF_MASK0(mask_index), 3);
+		if (ret < 0)
+			return ret;
+		ret = lan78xx_write_reg(dev, WUF_MASK1(mask_index), 0);
+		if (ret < 0)
+			return ret;
+		ret = lan78xx_write_reg(dev, WUF_MASK2(mask_index), 0);
+		if (ret < 0)
+			return ret;
+		ret = lan78xx_write_reg(dev, WUF_MASK3(mask_index), 0);
+		if (ret < 0)
+			return ret;
 
-		lan78xx_write_reg(dev, WUF_MASK0(mask_index), 3);
-		lan78xx_write_reg(dev, WUF_MASK1(mask_index), 0);
-		lan78xx_write_reg(dev, WUF_MASK2(mask_index), 0);
-		lan78xx_write_reg(dev, WUF_MASK3(mask_index), 0);
 		mask_index++;
 
 		temp_pmt_ctl |= PMT_CTL_WOL_EN_;
@@ -3885,16 +4285,27 @@ static int lan78xx_set_suspend(struct lan78xx_net *dev, u32 wol)
 		 * for packettype (offset 12,13) = ARP (0x0806)
 		 */
 		crc = lan78xx_wakeframe_crc16(arp_type, 2);
-		lan78xx_write_reg(dev, WUF_CFG(mask_index),
+		ret = lan78xx_write_reg(dev, WUF_CFG(mask_index),
 					WUF_CFGX_EN_ |
 					WUF_CFGX_TYPE_ALL_ |
 					(0 << WUF_CFGX_OFFSET_SHIFT_) |
 					(crc & WUF_CFGX_CRC16_MASK_));
+		if (ret < 0)
+			return ret;
+
+		ret = lan78xx_write_reg(dev, WUF_MASK0(mask_index), 0x3000);
+		if (ret < 0)
+			return ret;
+		ret = lan78xx_write_reg(dev, WUF_MASK1(mask_index), 0);
+		if (ret < 0)
+			return ret;
+		ret = lan78xx_write_reg(dev, WUF_MASK2(mask_index), 0);
+		if (ret < 0)
+			return ret;
+		ret = lan78xx_write_reg(dev, WUF_MASK3(mask_index), 0);
+		if (ret < 0)
+			return ret;
 
-		lan78xx_write_reg(dev, WUF_MASK0(mask_index), 0x3000);
-		lan78xx_write_reg(dev, WUF_MASK1(mask_index), 0);
-		lan78xx_write_reg(dev, WUF_MASK2(mask_index), 0);
-		lan78xx_write_reg(dev, WUF_MASK3(mask_index), 0);
 		mask_index++;
 
 		temp_pmt_ctl |= PMT_CTL_WOL_EN_;
@@ -3902,7 +4313,9 @@ static int lan78xx_set_suspend(struct lan78xx_net *dev, u32 wol)
 		temp_pmt_ctl |= PMT_CTL_SUS_MODE_0_;
 	}
 
-	lan78xx_write_reg(dev, WUCSR, temp_wucsr);
+	ret = lan78xx_write_reg(dev, WUCSR, temp_wucsr);
+	if (ret < 0)
+		return ret;
 
 	/* when multiple WOL bits are set */
 	if (hweight_long((unsigned long)wol) > 1) {
@@ -3910,33 +4323,45 @@ static int lan78xx_set_suspend(struct lan78xx_net *dev, u32 wol)
 		temp_pmt_ctl &= ~PMT_CTL_SUS_MODE_MASK_;
 		temp_pmt_ctl |= PMT_CTL_SUS_MODE_0_;
 	}
-	lan78xx_write_reg(dev, PMT_CTL, temp_pmt_ctl);
+	ret = lan78xx_write_reg(dev, PMT_CTL, temp_pmt_ctl);
+	if (ret < 0)
+		return ret;
 
 	/* clear WUPS */
-	lan78xx_read_reg(dev, PMT_CTL, &buf);
+	ret = lan78xx_read_reg(dev, PMT_CTL, &buf);
+	if (ret < 0)
+		return ret;
+
 	buf |= PMT_CTL_WUPS_MASK_;
-	lan78xx_write_reg(dev, PMT_CTL, buf);
 
-	lan78xx_read_reg(dev, MAC_RX, &buf);
-	buf |= MAC_RX_RXEN_;
-	lan78xx_write_reg(dev, MAC_RX, buf);
+	ret = lan78xx_write_reg(dev, PMT_CTL, buf);
+	if (ret < 0)
+		return ret;
 
-	return 0;
+	ret = lan78xx_start_rx_path(dev);
+
+	return ret;
 }
 
 static int lan78xx_suspend(struct usb_interface *intf, pm_message_t message)
 {
 	struct lan78xx_net *dev = usb_get_intfdata(intf);
-	struct lan78xx_priv *pdata = (struct lan78xx_priv *)(dev->data[0]);
-	u32 buf;
+	bool dev_open;
 	int ret;
 
-	if (!dev->suspend_count++) {
+	mutex_lock(&dev->dev_mutex);
+
+	netif_dbg(dev, ifdown, dev->net,
+		  "suspending: pm event %#x", message.event);
+
+	dev_open = test_bit(EVENT_DEV_OPEN, &dev->flags);
+
+	if (dev_open) {
 		spin_lock_irq(&dev->txq.lock);
 		/* don't autosuspend while transmitting */
 		if ((skb_queue_len(&dev->txq) ||
 		     skb_queue_len(&dev->txq_pend)) &&
-			PMSG_IS_AUTO(message)) {
+		    PMSG_IS_AUTO(message)) {
 			spin_unlock_irq(&dev->txq.lock);
 			ret = -EBUSY;
 			goto out;
@@ -3945,129 +4370,207 @@ static int lan78xx_suspend(struct usb_interface *intf, pm_message_t message)
 			spin_unlock_irq(&dev->txq.lock);
 		}
 
-		/* stop TX & RX */
-		ret = lan78xx_read_reg(dev, MAC_TX, &buf);
-		buf &= ~MAC_TX_TXEN_;
-		ret = lan78xx_write_reg(dev, MAC_TX, buf);
-		ret = lan78xx_read_reg(dev, MAC_RX, &buf);
-		buf &= ~MAC_RX_RXEN_;
-		ret = lan78xx_write_reg(dev, MAC_RX, buf);
+		/* stop RX */
+		ret = lan78xx_stop_rx_path(dev);
+		if (ret < 0)
+			goto out;
+
+		ret = lan78xx_flush_rx_fifo(dev);
+		if (ret < 0)
+			goto out;
 
-		/* empty out the rx and queues */
+		/* stop Tx */
+		ret = lan78xx_stop_tx_path(dev);
+		if (ret < 0)
+			goto out;
+
+		/* empty out the Rx and Tx queues */
 		netif_device_detach(dev->net);
 		lan78xx_terminate_urbs(dev);
 		usb_kill_urb(dev->urb_intr);
 
 		/* reattach */
 		netif_device_attach(dev->net);
-	}
 
-	if (test_bit(EVENT_DEV_ASLEEP, &dev->flags)) {
 		del_timer(&dev->stat_monitor);
 
 		if (PMSG_IS_AUTO(message)) {
-			/* auto suspend (selective suspend) */
-			ret = lan78xx_read_reg(dev, MAC_TX, &buf);
-			buf &= ~MAC_TX_TXEN_;
-			ret = lan78xx_write_reg(dev, MAC_TX, buf);
-			ret = lan78xx_read_reg(dev, MAC_RX, &buf);
-			buf &= ~MAC_RX_RXEN_;
-			ret = lan78xx_write_reg(dev, MAC_RX, buf);
+			ret = lan78xx_set_auto_suspend(dev);
+			if (ret < 0)
+				goto out;
+		} else {
+			struct lan78xx_priv *pdata;
+
+			pdata = (struct lan78xx_priv *)(dev->data[0]);
+			netif_carrier_off(dev->net);
+			ret = lan78xx_set_suspend(dev, pdata->wol);
+			if (ret < 0)
+				goto out;
+		}
+	} else {
+		/* Interface is down; don't allow WOL and PHY
+		 * events to wake up the host
+		 */
+		u32 buf;
 
-			ret = lan78xx_write_reg(dev, WUCSR, 0);
-			ret = lan78xx_write_reg(dev, WUCSR2, 0);
-			ret = lan78xx_write_reg(dev, WK_SRC, 0xFFF1FF1FUL);
+		set_bit(EVENT_DEV_ASLEEP, &dev->flags);
 
-			/* set goodframe wakeup */
-			ret = lan78xx_read_reg(dev, WUCSR, &buf);
+		ret = lan78xx_write_reg(dev, WUCSR, 0);
+		if (ret < 0)
+			goto out;
+		ret = lan78xx_write_reg(dev, WUCSR2, 0);
+		if (ret < 0)
+			goto out;
 
-			buf |= WUCSR_RFE_WAKE_EN_;
-			buf |= WUCSR_STORE_WAKE_;
+		ret = lan78xx_read_reg(dev, PMT_CTL, &buf);
+		if (ret < 0)
+			goto out;
 
-			ret = lan78xx_write_reg(dev, WUCSR, buf);
+		buf &= ~PMT_CTL_RES_CLR_WKP_EN_;
+		buf |= PMT_CTL_RES_CLR_WKP_STS_;
+		buf &= ~PMT_CTL_SUS_MODE_MASK_;
+		buf |= PMT_CTL_SUS_MODE_3_;
 
-			ret = lan78xx_read_reg(dev, PMT_CTL, &buf);
+		ret = lan78xx_write_reg(dev, PMT_CTL, buf);
+		if (ret < 0)
+			goto out;
 
-			buf &= ~PMT_CTL_RES_CLR_WKP_EN_;
-			buf |= PMT_CTL_RES_CLR_WKP_STS_;
+		ret = lan78xx_read_reg(dev, PMT_CTL, &buf);
+		if (ret < 0)
+			goto out;
 
-			buf |= PMT_CTL_PHY_WAKE_EN_;
-			buf |= PMT_CTL_WOL_EN_;
-			buf &= ~PMT_CTL_SUS_MODE_MASK_;
-			buf |= PMT_CTL_SUS_MODE_3_;
+		buf |= PMT_CTL_WUPS_MASK_;
 
-			ret = lan78xx_write_reg(dev, PMT_CTL, buf);
+		ret = lan78xx_write_reg(dev, PMT_CTL, buf);
+		if (ret < 0)
+			goto out;
+	}
 
-			ret = lan78xx_read_reg(dev, PMT_CTL, &buf);
+	ret = 0;
+out:
+	mutex_unlock(&dev->dev_mutex);
 
-			buf |= PMT_CTL_WUPS_MASK_;
+	return ret;
+}
 
-			ret = lan78xx_write_reg(dev, PMT_CTL, buf);
+static bool lan78xx_submit_deferred_urbs(struct lan78xx_net *dev)
+{
+	bool pipe_halted = false;
+	struct urb *urb;
 
-			ret = lan78xx_read_reg(dev, MAC_RX, &buf);
-			buf |= MAC_RX_RXEN_;
-			ret = lan78xx_write_reg(dev, MAC_RX, buf);
+	while ((urb = usb_get_from_anchor(&dev->deferred))) {
+		struct sk_buff *skb = urb->context;
+		int ret;
+
+		if (!netif_device_present(dev->net) ||
+		    !netif_carrier_ok(dev->net) ||
+		    pipe_halted) {
+			usb_free_urb(urb);
+			dev_kfree_skb(skb);
+			continue;
+		}
+
+		ret = usb_submit_urb(urb, GFP_ATOMIC);
+
+		if (ret == 0) {
+			netif_trans_update(dev->net);
+			lan78xx_queue_skb(&dev->txq, skb, tx_start);
 		} else {
-			lan78xx_set_suspend(dev, pdata->wol);
+			usb_free_urb(urb);
+			dev_kfree_skb(skb);
+
+			if (ret == -EPIPE) {
+				netif_stop_queue(dev->net);
+				pipe_halted = true;
+			} else if (ret == -ENODEV) {
+				netif_device_detach(dev->net);
+			}
 		}
 	}
 
-	ret = 0;
-out:
-	return ret;
+	return pipe_halted;
 }
 
 static int lan78xx_resume(struct usb_interface *intf)
 {
 	struct lan78xx_net *dev = usb_get_intfdata(intf);
-	struct sk_buff *skb;
-	struct urb *res;
+	bool dev_open;
 	int ret;
-	u32 buf;
 
-	if (!timer_pending(&dev->stat_monitor)) {
-		dev->delta = 1;
-		mod_timer(&dev->stat_monitor,
-			  jiffies + STAT_UPDATE_TIMER);
-	}
+	mutex_lock(&dev->dev_mutex);
 
-	if (!--dev->suspend_count) {
-		/* resume interrupt URBs */
-		if (dev->urb_intr && test_bit(EVENT_DEV_OPEN, &dev->flags))
-				usb_submit_urb(dev->urb_intr, GFP_NOIO);
+	netif_dbg(dev, ifup, dev->net, "resuming device");
+
+	dev_open = test_bit(EVENT_DEV_OPEN, &dev->flags);
+
+	if (dev_open) {
+		bool pipe_halted = false;
+
+		ret = lan78xx_flush_tx_fifo(dev);
+		if (ret < 0)
+			goto out;
+
+		if (dev->urb_intr) {
+			int ret = usb_submit_urb(dev->urb_intr, GFP_KERNEL);
 
-		spin_lock_irq(&dev->txq.lock);
-		while ((res = usb_get_from_anchor(&dev->deferred))) {
-			skb = (struct sk_buff *)res->context;
-			ret = usb_submit_urb(res, GFP_ATOMIC);
 			if (ret < 0) {
-				dev_kfree_skb_any(skb);
-				usb_free_urb(res);
-				usb_autopm_put_interface_async(dev->intf);
-			} else {
-				netif_trans_update(dev->net);
-				lan78xx_queue_skb(&dev->txq, skb, tx_start);
+				if (ret == -ENODEV)
+					netif_device_detach(dev->net);
+
+			netdev_warn(dev->net, "Failed to submit intr URB");
 			}
 		}
 
+		spin_lock_irq(&dev->txq.lock);
+
+		if (netif_device_present(dev->net)) {
+			pipe_halted = lan78xx_submit_deferred_urbs(dev);
+
+			if (pipe_halted)
+				lan78xx_defer_kevent(dev, EVENT_TX_HALT);
+		}
+
 		clear_bit(EVENT_DEV_ASLEEP, &dev->flags);
+
 		spin_unlock_irq(&dev->txq.lock);
 
-		if (test_bit(EVENT_DEV_OPEN, &dev->flags)) {
-			if (!(skb_queue_len(&dev->txq) >= dev->tx_qlen))
-				netif_start_queue(dev->net);
-			tasklet_schedule(&dev->bh);
+		if (!pipe_halted &&
+		    netif_device_present(dev->net) &&
+		    (skb_queue_len(&dev->txq) < dev->tx_qlen))
+			netif_start_queue(dev->net);
+
+		ret = lan78xx_start_tx_path(dev);
+		if (ret < 0)
+			goto out;
+
+		tasklet_schedule(&dev->bh);
+
+		if (!timer_pending(&dev->stat_monitor)) {
+			dev->delta = 1;
+			mod_timer(&dev->stat_monitor,
+				  jiffies + STAT_UPDATE_TIMER);
 		}
+
+	} else {
+		clear_bit(EVENT_DEV_ASLEEP, &dev->flags);
 	}
 
 	ret = lan78xx_write_reg(dev, WUCSR2, 0);
+	if (ret < 0)
+		goto out;
 	ret = lan78xx_write_reg(dev, WUCSR, 0);
+	if (ret < 0)
+		goto out;
 	ret = lan78xx_write_reg(dev, WK_SRC, 0xFFF1FF1FUL);
+	if (ret < 0)
+		goto out;
 
 	ret = lan78xx_write_reg(dev, WUCSR2, WUCSR2_NS_RCD_ |
 					     WUCSR2_ARP_RCD_ |
 					     WUCSR2_IPV6_TCPSYN_RCD_ |
 					     WUCSR2_IPV4_TCPSYN_RCD_);
+	if (ret < 0)
+		goto out;
 
 	ret = lan78xx_write_reg(dev, WUCSR, WUCSR_EEE_TX_WAKE_ |
 					    WUCSR_EEE_RX_WAKE_ |
@@ -4076,23 +4579,32 @@ static int lan78xx_resume(struct usb_interface *intf)
 					    WUCSR_WUFR_ |
 					    WUCSR_MPR_ |
 					    WUCSR_BCST_FR_);
+	if (ret < 0)
+		goto out;
 
-	ret = lan78xx_read_reg(dev, MAC_TX, &buf);
-	buf |= MAC_TX_TXEN_;
-	ret = lan78xx_write_reg(dev, MAC_TX, buf);
+	ret = 0;
+out:
+	mutex_unlock(&dev->dev_mutex);
 
-	return 0;
+	return ret;
 }
 
 static int lan78xx_reset_resume(struct usb_interface *intf)
 {
 	struct lan78xx_net *dev = usb_get_intfdata(intf);
+	int ret;
 
-	lan78xx_reset(dev);
+	netif_dbg(dev, ifup, dev->net, "(reset) resuming device");
+
+	ret = lan78xx_reset(dev);
+	if (ret < 0)
+		return ret;
 
 	phy_start(dev->net->phydev);
 
-	return lan78xx_resume(intf);
+	ret = lan78xx_resume(intf);
+
+	return ret;
 }
 
 static const struct usb_device_id products[] = {
diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index 28f22e58639c6..bd30ae9751bf5 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -343,6 +343,7 @@ config SERIAL_MAX310X
 	depends on SPI_MASTER
 	select SERIAL_CORE
 	select REGMAP_SPI if SPI_MASTER
+	select REGMAP_I2C if I2C
 	help
 	  This selects support for an advanced UART from Maxim (Dallas).
 	  Supported ICs are MAX3107, MAX3108, MAX3109, MAX14830.
diff --git a/drivers/tty/serial/max310x.c b/drivers/tty/serial/max310x.c
index 14537878f9855..2f88eae8a55a1 100644
--- a/drivers/tty/serial/max310x.c
+++ b/drivers/tty/serial/max310x.c
@@ -14,9 +14,10 @@
 #include <linux/delay.h>
 #include <linux/device.h>
 #include <linux/gpio/driver.h>
+#include <linux/i2c.h>
 #include <linux/module.h>
-#include <linux/of.h>
-#include <linux/of_device.h>
+#include <linux/mod_devicetable.h>
+#include <linux/property.h>
 #include <linux/regmap.h>
 #include <linux/serial_core.h>
 #include <linux/serial.h>
@@ -72,7 +73,8 @@
 #define MAX310X_GLOBALCMD_REG		MAX310X_REG_1F /* Global Command (WO) */
 
 /* Extended registers */
-#define MAX310X_REVID_EXTREG		MAX310X_REG_05 /* Revision ID */
+#define MAX310X_SPI_REVID_EXTREG	MAX310X_REG_05 /* Revision ID */
+#define MAX310X_I2C_REVID_EXTREG	(0x25) /* Revision ID */
 
 /* IRQ register bits */
 #define MAX310X_IRQ_LSR_BIT		(1 << 0) /* LSR interrupt */
@@ -235,6 +237,10 @@
 #define MAX310x_REV_MASK		(0xf8)
 #define MAX310X_WRITE_BIT		0x80
 
+/* Port startup definitions */
+#define MAX310X_PORT_STARTUP_WAIT_RETRIES	20 /* Number of retries */
+#define MAX310X_PORT_STARTUP_WAIT_DELAY_MS	10 /* Delay between retries */
+
 /* Crystal-related definitions */
 #define MAX310X_XTAL_WAIT_RETRIES	20 /* Number of retries */
 #define MAX310X_XTAL_WAIT_DELAY_MS	10 /* Delay between retries */
@@ -249,7 +255,17 @@
 #define MAX14830_BRGCFG_CLKDIS_BIT	(1 << 6) /* Clock Disable */
 #define MAX14830_REV_ID			(0xb0)
 
+struct max310x_if_cfg {
+	int (*extended_reg_enable)(struct device *dev, bool enable);
+
+	unsigned int rev_id_reg;
+};
+
 struct max310x_devtype {
+	struct {
+		unsigned short min;
+		unsigned short max;
+	} slave_addr;
 	char	name[9];
 	int	nr;
 	u8	mode1;
@@ -262,16 +278,16 @@ struct max310x_one {
 	struct work_struct	tx_work;
 	struct work_struct	md_work;
 	struct work_struct	rs_work;
+	struct regmap		*regmap;
 
-	u8 wr_header;
-	u8 rd_header;
 	u8 rx_buf[MAX310X_FIFO_SIZE];
 };
 #define to_max310x_port(_port) \
 	container_of(_port, struct max310x_one, port)
 
 struct max310x_port {
-	struct max310x_devtype	*devtype;
+	const struct max310x_devtype *devtype;
+	const struct max310x_if_cfg *if_cfg;
 	struct regmap		*regmap;
 	struct clk		*clk;
 #ifdef CONFIG_GPIOLIB
@@ -293,26 +309,26 @@ static DECLARE_BITMAP(max310x_lines, MAX310X_UART_NRMAX);
 
 static u8 max310x_port_read(struct uart_port *port, u8 reg)
 {
-	struct max310x_port *s = dev_get_drvdata(port->dev);
+	struct max310x_one *one = to_max310x_port(port);
 	unsigned int val = 0;
 
-	regmap_read(s->regmap, port->iobase + reg, &val);
+	regmap_read(one->regmap, reg, &val);
 
 	return val;
 }
 
 static void max310x_port_write(struct uart_port *port, u8 reg, u8 val)
 {
-	struct max310x_port *s = dev_get_drvdata(port->dev);
+	struct max310x_one *one = to_max310x_port(port);
 
-	regmap_write(s->regmap, port->iobase + reg, val);
+	regmap_write(one->regmap, reg, val);
 }
 
 static void max310x_port_update(struct uart_port *port, u8 reg, u8 mask, u8 val)
 {
-	struct max310x_port *s = dev_get_drvdata(port->dev);
+	struct max310x_one *one = to_max310x_port(port);
 
-	regmap_update_bits(s->regmap, port->iobase + reg, mask, val);
+	regmap_update_bits(one->regmap, reg, mask, val);
 }
 
 static int max3107_detect(struct device *dev)
@@ -361,13 +377,12 @@ static int max3109_detect(struct device *dev)
 	unsigned int val = 0;
 	int ret;
 
-	ret = regmap_write(s->regmap, MAX310X_GLOBALCMD_REG,
-			   MAX310X_EXTREG_ENBL);
+	ret = s->if_cfg->extended_reg_enable(dev, true);
 	if (ret)
 		return ret;
 
-	regmap_read(s->regmap, MAX310X_REVID_EXTREG, &val);
-	regmap_write(s->regmap, MAX310X_GLOBALCMD_REG, MAX310X_EXTREG_DSBL);
+	regmap_read(s->regmap, s->if_cfg->rev_id_reg, &val);
+	s->if_cfg->extended_reg_enable(dev, false);
 	if (((val & MAX310x_REV_MASK) != MAX3109_REV_ID)) {
 		dev_err(dev,
 			"%s ID 0x%02x does not match\n", s->devtype->name, val);
@@ -392,13 +407,12 @@ static int max14830_detect(struct device *dev)
 	unsigned int val = 0;
 	int ret;
 
-	ret = regmap_write(s->regmap, MAX310X_GLOBALCMD_REG,
-			   MAX310X_EXTREG_ENBL);
+	ret = s->if_cfg->extended_reg_enable(dev, true);
 	if (ret)
 		return ret;
 	
-	regmap_read(s->regmap, MAX310X_REVID_EXTREG, &val);
-	regmap_write(s->regmap, MAX310X_GLOBALCMD_REG, MAX310X_EXTREG_DSBL);
+	regmap_read(s->regmap, s->if_cfg->rev_id_reg, &val);
+	s->if_cfg->extended_reg_enable(dev, false);
 	if (((val & MAX310x_REV_MASK) != MAX14830_REV_ID)) {
 		dev_err(dev,
 			"%s ID 0x%02x does not match\n", s->devtype->name, val);
@@ -423,6 +437,10 @@ static const struct max310x_devtype max3107_devtype = {
 	.mode1	= MAX310X_MODE1_AUTOSLEEP_BIT | MAX310X_MODE1_IRQSEL_BIT,
 	.detect	= max3107_detect,
 	.power	= max310x_power,
+	.slave_addr	= {
+		.min = 0x2c,
+		.max = 0x2f,
+	},
 };
 
 static const struct max310x_devtype max3108_devtype = {
@@ -431,6 +449,10 @@ static const struct max310x_devtype max3108_devtype = {
 	.mode1	= MAX310X_MODE1_AUTOSLEEP_BIT,
 	.detect	= max3108_detect,
 	.power	= max310x_power,
+	.slave_addr	= {
+		.min = 0x60,
+		.max = 0x6f,
+	},
 };
 
 static const struct max310x_devtype max3109_devtype = {
@@ -439,6 +461,10 @@ static const struct max310x_devtype max3109_devtype = {
 	.mode1	= MAX310X_MODE1_AUTOSLEEP_BIT,
 	.detect	= max3109_detect,
 	.power	= max310x_power,
+	.slave_addr	= {
+		.min = 0x60,
+		.max = 0x6f,
+	},
 };
 
 static const struct max310x_devtype max14830_devtype = {
@@ -447,11 +473,15 @@ static const struct max310x_devtype max14830_devtype = {
 	.mode1	= MAX310X_MODE1_IRQSEL_BIT,
 	.detect	= max14830_detect,
 	.power	= max14830_power,
+	.slave_addr	= {
+		.min = 0x60,
+		.max = 0x6f,
+	},
 };
 
 static bool max310x_reg_writeable(struct device *dev, unsigned int reg)
 {
-	switch (reg & 0x1f) {
+	switch (reg) {
 	case MAX310X_IRQSTS_REG:
 	case MAX310X_LSR_IRQSTS_REG:
 	case MAX310X_SPCHR_IRQSTS_REG:
@@ -468,7 +498,7 @@ static bool max310x_reg_writeable(struct device *dev, unsigned int reg)
 
 static bool max310x_reg_volatile(struct device *dev, unsigned int reg)
 {
-	switch (reg & 0x1f) {
+	switch (reg) {
 	case MAX310X_RHR_REG:
 	case MAX310X_IRQSTS_REG:
 	case MAX310X_LSR_IRQSTS_REG:
@@ -490,7 +520,7 @@ static bool max310x_reg_volatile(struct device *dev, unsigned int reg)
 
 static bool max310x_reg_precious(struct device *dev, unsigned int reg)
 {
-	switch (reg & 0x1f) {
+	switch (reg) {
 	case MAX310X_RHR_REG:
 	case MAX310X_IRQSTS_REG:
 	case MAX310X_SPCHR_IRQSTS_REG:
@@ -503,6 +533,11 @@ static bool max310x_reg_precious(struct device *dev, unsigned int reg)
 	return false;
 }
 
+static bool max310x_reg_noinc(struct device *dev, unsigned int reg)
+{
+	return reg == MAX310X_RHR_REG;
+}
+
 static int max310x_set_baud(struct uart_port *port, int baud)
 {
 	unsigned int mode = 0, div = 0, frac = 0, c = 0, F = 0;
@@ -556,7 +591,7 @@ static int max310x_update_best_err(unsigned long f, long *besterr)
 	return 1;
 }
 
-static int max310x_set_ref_clk(struct device *dev, struct max310x_port *s,
+static s32 max310x_set_ref_clk(struct device *dev, struct max310x_port *s,
 			       unsigned long freq, bool xtal)
 {
 	unsigned int div, clksrc, pllcfg = 0;
@@ -626,40 +661,25 @@ static int max310x_set_ref_clk(struct device *dev, struct max310x_port *s,
 		} while (!stable && (++try < MAX310X_XTAL_WAIT_RETRIES));
 
 		if (!stable)
-			dev_warn(dev, "clock is not stable yet\n");
+			return dev_err_probe(dev, -EAGAIN,
+					     "clock is not stable\n");
 	}
 
-	return (int)bestfreq;
+	return bestfreq;
 }
 
 static void max310x_batch_write(struct uart_port *port, u8 *txbuf, unsigned int len)
 {
 	struct max310x_one *one = to_max310x_port(port);
-	struct spi_transfer xfer[] = {
-		{
-			.tx_buf = &one->wr_header,
-			.len = sizeof(one->wr_header),
-		}, {
-			.tx_buf = txbuf,
-			.len = len,
-		}
-	};
-	spi_sync_transfer(to_spi_device(port->dev), xfer, ARRAY_SIZE(xfer));
+
+	regmap_noinc_write(one->regmap, MAX310X_THR_REG, txbuf, len);
 }
 
 static void max310x_batch_read(struct uart_port *port, u8 *rxbuf, unsigned int len)
 {
 	struct max310x_one *one = to_max310x_port(port);
-	struct spi_transfer xfer[] = {
-		{
-			.tx_buf = &one->rd_header,
-			.len = sizeof(one->rd_header),
-		}, {
-			.rx_buf = rxbuf,
-			.len = len,
-		}
-	};
-	spi_sync_transfer(to_spi_device(port->dev), xfer, ARRAY_SIZE(xfer));
+
+	regmap_noinc_read(one->regmap, MAX310X_RHR_REG, rxbuf, len);
 }
 
 static void max310x_handle_rx(struct uart_port *port, unsigned int rxlen)
@@ -1261,16 +1281,18 @@ static int max310x_gpio_set_config(struct gpio_chip *chip, unsigned int offset,
 }
 #endif
 
-static int max310x_probe(struct device *dev, struct max310x_devtype *devtype,
-			 struct regmap *regmap, int irq)
+static int max310x_probe(struct device *dev, const struct max310x_devtype *devtype,
+			 const struct max310x_if_cfg *if_cfg,
+			 struct regmap *regmaps[], int irq)
 {
-	int i, ret, fmin, fmax, freq, uartclk;
-	struct clk *clk_osc, *clk_xtal;
+	int i, ret, fmin, fmax, freq;
 	struct max310x_port *s;
-	bool xtal = false;
+	s32 uartclk = 0;
+	bool xtal;
 
-	if (IS_ERR(regmap))
-		return PTR_ERR(regmap);
+	for (i = 0; i < devtype->nr; i++)
+		if (IS_ERR(regmaps[i]))
+			return PTR_ERR(regmaps[i]);
 
 	/* Alloc port structure */
 	s = devm_kzalloc(dev, struct_size(s, p, devtype->nr), GFP_KERNEL);
@@ -1279,23 +1301,20 @@ static int max310x_probe(struct device *dev, struct max310x_devtype *devtype,
 		return -ENOMEM;
 	}
 
-	clk_osc = devm_clk_get(dev, "osc");
-	clk_xtal = devm_clk_get(dev, "xtal");
-	if (!IS_ERR(clk_osc)) {
-		s->clk = clk_osc;
-		fmin = 500000;
-		fmax = 35000000;
-	} else if (!IS_ERR(clk_xtal)) {
-		s->clk = clk_xtal;
-		fmin = 1000000;
-		fmax = 4000000;
-		xtal = true;
-	} else if (PTR_ERR(clk_osc) == -EPROBE_DEFER ||
-		   PTR_ERR(clk_xtal) == -EPROBE_DEFER) {
-		return -EPROBE_DEFER;
+	/* Always ask for fixed clock rate from a property. */
+	device_property_read_u32(dev, "clock-frequency", &uartclk);
+
+	s->clk = devm_clk_get_optional(dev, "osc");
+	if (IS_ERR(s->clk))
+		return PTR_ERR(s->clk);
+	if (s->clk) {
+		xtal = false;
 	} else {
-		dev_err(dev, "Cannot get clock\n");
-		return -EINVAL;
+		s->clk = devm_clk_get_optional(dev, "xtal");
+		if (IS_ERR(s->clk))
+			return PTR_ERR(s->clk);
+
+		xtal = true;
 	}
 
 	ret = clk_prepare_enable(s->clk);
@@ -1303,14 +1322,31 @@ static int max310x_probe(struct device *dev, struct max310x_devtype *devtype,
 		return ret;
 
 	freq = clk_get_rate(s->clk);
+	if (freq == 0)
+		freq = uartclk;
+	if (freq == 0) {
+		dev_err(dev, "Cannot get clock rate\n");
+		ret = -EINVAL;
+		goto out_clk;
+	}
+
+	if (xtal) {
+		fmin = 1000000;
+		fmax = 4000000;
+	} else {
+		fmin = 500000;
+		fmax = 35000000;
+	}
+
 	/* Check frequency limits */
 	if (freq < fmin || freq > fmax) {
 		ret = -ERANGE;
 		goto out_clk;
 	}
 
-	s->regmap = regmap;
+	s->regmap = regmaps[0];
 	s->devtype = devtype;
+	s->if_cfg = if_cfg;
 	dev_set_drvdata(dev, s);
 
 	/* Check device to ensure we are talking to what we expect */
@@ -1319,25 +1355,38 @@ static int max310x_probe(struct device *dev, struct max310x_devtype *devtype,
 		goto out_clk;
 
 	for (i = 0; i < devtype->nr; i++) {
-		unsigned int offs = i << 5;
+		bool started = false;
+		unsigned int try = 0, val = 0;
 
 		/* Reset port */
-		regmap_write(s->regmap, MAX310X_MODE2_REG + offs,
+		regmap_write(regmaps[i], MAX310X_MODE2_REG,
 			     MAX310X_MODE2_RST_BIT);
 		/* Clear port reset */
-		regmap_write(s->regmap, MAX310X_MODE2_REG + offs, 0);
+		regmap_write(regmaps[i], MAX310X_MODE2_REG, 0);
 
 		/* Wait for port startup */
 		do {
-			regmap_read(s->regmap,
-				    MAX310X_BRGDIVLSB_REG + offs, &ret);
-		} while (ret != 0x01);
+			msleep(MAX310X_PORT_STARTUP_WAIT_DELAY_MS);
+			regmap_read(regmaps[i], MAX310X_BRGDIVLSB_REG, &val);
 
-		regmap_write(s->regmap, MAX310X_MODE1_REG + offs,
-			     devtype->mode1);
+			if (val == 0x01)
+				started = true;
+		} while (!started && (++try < MAX310X_PORT_STARTUP_WAIT_RETRIES));
+
+		if (!started) {
+			ret = dev_err_probe(dev, -EAGAIN, "port reset failed\n");
+			goto out_uart;
+		}
+
+		regmap_write(regmaps[i], MAX310X_MODE1_REG, devtype->mode1);
 	}
 
 	uartclk = max310x_set_ref_clk(dev, s, freq, xtal);
+	if (uartclk < 0) {
+		ret = uartclk;
+		goto out_uart;
+	}
+
 	dev_dbg(dev, "Reference clock set to %i Hz\n", uartclk);
 
 	for (i = 0; i < devtype->nr; i++) {
@@ -1357,11 +1406,13 @@ static int max310x_probe(struct device *dev, struct max310x_devtype *devtype,
 		s->p[i].port.fifosize	= MAX310X_FIFO_SIZE;
 		s->p[i].port.flags	= UPF_FIXED_TYPE | UPF_LOW_LATENCY;
 		s->p[i].port.iotype	= UPIO_PORT;
-		s->p[i].port.iobase	= i * 0x20;
+		s->p[i].port.iobase	= i;
 		s->p[i].port.membase	= (void __iomem *)~0;
 		s->p[i].port.uartclk	= uartclk;
 		s->p[i].port.rs485_config = max310x_rs485_config;
 		s->p[i].port.ops	= &max310x_ops;
+		s->p[i].regmap		= regmaps[i];
+
 		/* Disable all interrupts */
 		max310x_port_write(&s->p[i].port, MAX310X_IRQEN_REG, 0);
 		/* Clear IRQ status register */
@@ -1372,10 +1423,6 @@ static int max310x_probe(struct device *dev, struct max310x_devtype *devtype,
 		INIT_WORK(&s->p[i].md_work, max310x_md_proc);
 		/* Initialize queue for changing RS485 mode */
 		INIT_WORK(&s->p[i].rs_work, max310x_rs_proc);
-		/* Initialize SPI-transfer buffers */
-		s->p[i].wr_header = (s->p[i].port.iobase + MAX310X_THR_REG) |
-				    MAX310X_WRITE_BIT;
-		s->p[i].rd_header = (s->p[i].port.iobase + MAX310X_RHR_REG);
 
 		/* Register port */
 		ret = uart_add_one_port(&max310x_uart, &s->p[i].port);
@@ -1462,16 +1509,35 @@ static struct regmap_config regcfg = {
 	.val_bits = 8,
 	.write_flag_mask = MAX310X_WRITE_BIT,
 	.cache_type = REGCACHE_RBTREE,
+	.max_register = MAX310X_REG_1F,
 	.writeable_reg = max310x_reg_writeable,
 	.volatile_reg = max310x_reg_volatile,
 	.precious_reg = max310x_reg_precious,
+	.writeable_noinc_reg = max310x_reg_noinc,
+	.readable_noinc_reg = max310x_reg_noinc,
+	.max_raw_read = MAX310X_FIFO_SIZE,
+	.max_raw_write = MAX310X_FIFO_SIZE,
 };
 
 #ifdef CONFIG_SPI_MASTER
+static int max310x_spi_extended_reg_enable(struct device *dev, bool enable)
+{
+	struct max310x_port *s = dev_get_drvdata(dev);
+
+	return regmap_write(s->regmap, MAX310X_GLOBALCMD_REG,
+			    enable ? MAX310X_EXTREG_ENBL : MAX310X_EXTREG_DSBL);
+}
+
+static const struct max310x_if_cfg __maybe_unused max310x_spi_if_cfg = {
+	.extended_reg_enable = max310x_spi_extended_reg_enable,
+	.rev_id_reg = MAX310X_SPI_REVID_EXTREG,
+};
+
 static int max310x_spi_probe(struct spi_device *spi)
 {
-	struct max310x_devtype *devtype;
-	struct regmap *regmap;
+	const struct max310x_devtype *devtype;
+	struct regmap *regmaps[4];
+	unsigned int i;
 	int ret;
 
 	/* Setup SPI bus */
@@ -1482,23 +1548,18 @@ static int max310x_spi_probe(struct spi_device *spi)
 	if (ret)
 		return ret;
 
-	if (spi->dev.of_node) {
-		const struct of_device_id *of_id =
-			of_match_device(max310x_dt_ids, &spi->dev);
-		if (!of_id)
-			return -ENODEV;
-
-		devtype = (struct max310x_devtype *)of_id->data;
-	} else {
-		const struct spi_device_id *id_entry = spi_get_device_id(spi);
+	devtype = device_get_match_data(&spi->dev);
+	if (!devtype)
+		devtype = (struct max310x_devtype *)spi_get_device_id(spi)->driver_data;
 
-		devtype = (struct max310x_devtype *)id_entry->driver_data;
+	for (i = 0; i < devtype->nr; i++) {
+		u8 port_mask = i * 0x20;
+		regcfg.read_flag_mask = port_mask;
+		regcfg.write_flag_mask = port_mask | MAX310X_WRITE_BIT;
+		regmaps[i] = devm_regmap_init_spi(spi, &regcfg);
 	}
 
-	regcfg.max_register = devtype->nr * 0x20 - 1;
-	regmap = devm_regmap_init_spi(spi, &regcfg);
-
-	return max310x_probe(&spi->dev, devtype, regmap, spi->irq);
+	return max310x_probe(&spi->dev, devtype, &max310x_spi_if_cfg, regmaps, spi->irq);
 }
 
 static int max310x_spi_remove(struct spi_device *spi)
@@ -1518,7 +1579,7 @@ MODULE_DEVICE_TABLE(spi, max310x_id_table);
 static struct spi_driver max310x_spi_driver = {
 	.driver = {
 		.name		= MAX310X_NAME,
-		.of_match_table	= of_match_ptr(max310x_dt_ids),
+		.of_match_table	= max310x_dt_ids,
 		.pm		= &max310x_pm_ops,
 	},
 	.probe		= max310x_spi_probe,
@@ -1527,6 +1588,101 @@ static struct spi_driver max310x_spi_driver = {
 };
 #endif
 
+#ifdef CONFIG_I2C
+static int max310x_i2c_extended_reg_enable(struct device *dev, bool enable)
+{
+	return 0;
+}
+
+static struct regmap_config regcfg_i2c = {
+	.reg_bits = 8,
+	.val_bits = 8,
+	.cache_type = REGCACHE_RBTREE,
+	.writeable_reg = max310x_reg_writeable,
+	.volatile_reg = max310x_reg_volatile,
+	.precious_reg = max310x_reg_precious,
+	.max_register = MAX310X_I2C_REVID_EXTREG,
+	.writeable_noinc_reg = max310x_reg_noinc,
+	.readable_noinc_reg = max310x_reg_noinc,
+	.max_raw_read = MAX310X_FIFO_SIZE,
+	.max_raw_write = MAX310X_FIFO_SIZE,
+};
+
+static const struct max310x_if_cfg max310x_i2c_if_cfg = {
+	.extended_reg_enable = max310x_i2c_extended_reg_enable,
+	.rev_id_reg = MAX310X_I2C_REVID_EXTREG,
+};
+
+static unsigned short max310x_i2c_slave_addr(unsigned short addr,
+					     unsigned int nr)
+{
+	/*
+	 * For MAX14830 and MAX3109, the slave address depends on what the
+	 * A0 and A1 pins are tied to.
+	 * See Table I2C Address Map of the datasheet.
+	 * Based on that table, the following formulas were determined.
+	 * UART1 - UART0 = 0x10
+	 * UART2 - UART1 = 0x20 + 0x10
+	 * UART3 - UART2 = 0x10
+	 */
+
+	addr -= nr * 0x10;
+
+	if (nr >= 2)
+		addr -= 0x20;
+
+	return addr;
+}
+
+static int max310x_i2c_probe(struct i2c_client *client)
+{
+	const struct max310x_devtype *devtype =
+			device_get_match_data(&client->dev);
+	struct i2c_client *port_client;
+	struct regmap *regmaps[4];
+	unsigned int i;
+	u8 port_addr;
+
+	if (client->addr < devtype->slave_addr.min ||
+		client->addr > devtype->slave_addr.max)
+		return dev_err_probe(&client->dev, -EINVAL,
+				     "Slave addr 0x%x outside of range [0x%x, 0x%x]\n",
+				     client->addr, devtype->slave_addr.min,
+				     devtype->slave_addr.max);
+
+	regmaps[0] = devm_regmap_init_i2c(client, &regcfg_i2c);
+
+	for (i = 1; i < devtype->nr; i++) {
+		port_addr = max310x_i2c_slave_addr(client->addr, i);
+		port_client = devm_i2c_new_dummy_device(&client->dev,
+							client->adapter,
+							port_addr);
+
+		regmaps[i] = devm_regmap_init_i2c(port_client, &regcfg_i2c);
+	}
+
+	return max310x_probe(&client->dev, devtype, &max310x_i2c_if_cfg,
+			     regmaps, client->irq);
+}
+
+static int max310x_i2c_remove(struct i2c_client *client)
+{
+	max310x_remove(&client->dev);
+
+	return 0;
+}
+
+static struct i2c_driver max310x_i2c_driver = {
+	.driver = {
+		.name		= MAX310X_NAME,
+		.of_match_table	= max310x_dt_ids,
+		.pm		= &max310x_pm_ops,
+	},
+	.probe_new	= max310x_i2c_probe,
+	.remove		= max310x_i2c_remove,
+};
+#endif
+
 static int __init max310x_uart_init(void)
 {
 	int ret;
@@ -1540,15 +1696,35 @@ static int __init max310x_uart_init(void)
 #ifdef CONFIG_SPI_MASTER
 	ret = spi_register_driver(&max310x_spi_driver);
 	if (ret)
-		uart_unregister_driver(&max310x_uart);
+		goto err_spi_register;
+#endif
+
+#ifdef CONFIG_I2C
+	ret = i2c_add_driver(&max310x_i2c_driver);
+	if (ret)
+		goto err_i2c_register;
+#endif
+
+	return 0;
+
+#ifdef CONFIG_I2C
+err_i2c_register:
+	spi_unregister_driver(&max310x_spi_driver);
 #endif
 
+err_spi_register:
+	uart_unregister_driver(&max310x_uart);
+
 	return ret;
 }
 module_init(max310x_uart_init);
 
 static void __exit max310x_uart_exit(void)
 {
+#ifdef CONFIG_I2C
+	i2c_del_driver(&max310x_i2c_driver);
+#endif
+
 #ifdef CONFIG_SPI_MASTER
 	spi_unregister_driver(&max310x_spi_driver);
 #endif
diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
index eb70f07e3623a..4fa387e447f08 100644
--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -2059,16 +2059,13 @@ int xhci_is_vendor_info_code(struct xhci_hcd *xhci, unsigned int trb_comp_code)
 	return 0;
 }
 
-static int finish_td(struct xhci_hcd *xhci, struct xhci_td *td,
-	struct xhci_transfer_event *event, struct xhci_virt_ep *ep)
+static int finish_td(struct xhci_hcd *xhci, struct xhci_virt_ep *ep,
+		     struct xhci_ring *ep_ring, struct xhci_td *td,
+		     u32 trb_comp_code)
 {
 	struct xhci_ep_ctx *ep_ctx;
-	struct xhci_ring *ep_ring;
-	u32 trb_comp_code;
 
-	ep_ring = xhci_dma_to_transfer_ring(ep, le64_to_cpu(event->buffer));
 	ep_ctx = xhci_get_ep_ctx(xhci, ep->vdev->out_ctx, ep->ep_index);
-	trb_comp_code = GET_COMP_CODE(le32_to_cpu(event->transfer_len));
 
 	if (trb_comp_code == COMP_STOPPED_LENGTH_INVALID ||
 			trb_comp_code == COMP_STOPPED ||
@@ -2099,8 +2096,9 @@ static int finish_td(struct xhci_hcd *xhci, struct xhci_td *td,
 					     EP_HARD_RESET);
 	} else {
 		/* Update ring dequeue pointer */
-		while (ep_ring->dequeue != td->last_trb)
-			inc_deq(xhci, ep_ring);
+		ep_ring->dequeue = td->last_trb;
+		ep_ring->deq_seg = td->last_trb_seg;
+		ep_ring->num_trbs_free += td->num_trbs - 1;
 		inc_deq(xhci, ep_ring);
 	}
 
@@ -2125,9 +2123,9 @@ static int sum_trb_lengths(struct xhci_hcd *xhci, struct xhci_ring *ring,
 /*
  * Process control tds, update urb status and actual_length.
  */
-static int process_ctrl_td(struct xhci_hcd *xhci, struct xhci_td *td,
-	union xhci_trb *ep_trb, struct xhci_transfer_event *event,
-	struct xhci_virt_ep *ep)
+static int process_ctrl_td(struct xhci_hcd *xhci, struct xhci_virt_ep *ep,
+		struct xhci_ring *ep_ring,  struct xhci_td *td,
+			   union xhci_trb *ep_trb, struct xhci_transfer_event *event)
 {
 	struct xhci_ep_ctx *ep_ctx;
 	u32 trb_comp_code;
@@ -2215,15 +2213,15 @@ static int process_ctrl_td(struct xhci_hcd *xhci, struct xhci_td *td,
 		td->urb->actual_length = requested;
 
 finish_td:
-	return finish_td(xhci, td, event, ep);
+	return finish_td(xhci, ep, ep_ring, td, trb_comp_code);
 }
 
 /*
  * Process isochronous tds, update urb packet status and actual_length.
  */
-static int process_isoc_td(struct xhci_hcd *xhci, struct xhci_td *td,
-	union xhci_trb *ep_trb, struct xhci_transfer_event *event,
-	struct xhci_virt_ep *ep)
+static int process_isoc_td(struct xhci_hcd *xhci, struct xhci_virt_ep *ep,
+		struct xhci_ring *ep_ring, struct xhci_td *td,
+		union xhci_trb *ep_trb, struct xhci_transfer_event *event)
 {
 	struct urb_priv *urb_priv;
 	int idx;
@@ -2246,6 +2244,9 @@ static int process_isoc_td(struct xhci_hcd *xhci, struct xhci_td *td,
 	/* handle completion code */
 	switch (trb_comp_code) {
 	case COMP_SUCCESS:
+		/* Don't overwrite status if TD had an error, see xHCI 4.9.1 */
+		if (td->error_mid_td)
+			break;
 		if (remaining) {
 			frame->status = short_framestatus;
 			if (xhci->quirks & XHCI_TRUST_TX_LENGTH)
@@ -2261,9 +2262,13 @@ static int process_isoc_td(struct xhci_hcd *xhci, struct xhci_td *td,
 	case COMP_BANDWIDTH_OVERRUN_ERROR:
 		frame->status = -ECOMM;
 		break;
-	case COMP_ISOCH_BUFFER_OVERRUN:
 	case COMP_BABBLE_DETECTED_ERROR:
+		sum_trbs_for_length = true;
+		fallthrough;
+	case COMP_ISOCH_BUFFER_OVERRUN:
 		frame->status = -EOVERFLOW;
+		if (ep_trb != td->last_trb)
+			td->error_mid_td = true;
 		break;
 	case COMP_INCOMPATIBLE_DEVICE_ERROR:
 	case COMP_STALL_ERROR:
@@ -2271,8 +2276,9 @@ static int process_isoc_td(struct xhci_hcd *xhci, struct xhci_td *td,
 		break;
 	case COMP_USB_TRANSACTION_ERROR:
 		frame->status = -EPROTO;
+		sum_trbs_for_length = true;
 		if (ep_trb != td->last_trb)
-			return 0;
+			td->error_mid_td = true;
 		break;
 	case COMP_STOPPED:
 		sum_trbs_for_length = true;
@@ -2292,6 +2298,9 @@ static int process_isoc_td(struct xhci_hcd *xhci, struct xhci_td *td,
 		break;
 	}
 
+	if (td->urb_length_set)
+		goto finish_td;
+
 	if (sum_trbs_for_length)
 		frame->actual_length = sum_trb_lengths(xhci, ep->ring, ep_trb) +
 			ep_trb_len - remaining;
@@ -2300,7 +2309,15 @@ static int process_isoc_td(struct xhci_hcd *xhci, struct xhci_td *td,
 
 	td->urb->actual_length += frame->actual_length;
 
-	return finish_td(xhci, td, event, ep);
+finish_td:
+	/* Don't give back TD yet if we encountered an error mid TD */
+	if (td->error_mid_td && ep_trb != td->last_trb) {
+		xhci_dbg(xhci, "Error mid isoc TD, wait for final completion event\n");
+		td->urb_length_set = true;
+		return 0;
+	}
+
+	return finish_td(xhci, ep, ep_ring, td, trb_comp_code);
 }
 
 static int skip_isoc_td(struct xhci_hcd *xhci, struct xhci_td *td,
@@ -2321,8 +2338,9 @@ static int skip_isoc_td(struct xhci_hcd *xhci, struct xhci_td *td,
 	frame->actual_length = 0;
 
 	/* Update ring dequeue pointer */
-	while (ep->ring->dequeue != td->last_trb)
-		inc_deq(xhci, ep->ring);
+	ep->ring->dequeue = td->last_trb;
+	ep->ring->deq_seg = td->last_trb_seg;
+	ep->ring->num_trbs_free += td->num_trbs - 1;
 	inc_deq(xhci, ep->ring);
 
 	return xhci_td_cleanup(xhci, td, ep->ring, status);
@@ -2331,17 +2349,15 @@ static int skip_isoc_td(struct xhci_hcd *xhci, struct xhci_td *td,
 /*
  * Process bulk and interrupt tds, update urb status and actual_length.
  */
-static int process_bulk_intr_td(struct xhci_hcd *xhci, struct xhci_td *td,
-	union xhci_trb *ep_trb, struct xhci_transfer_event *event,
-	struct xhci_virt_ep *ep)
+static int process_bulk_intr_td(struct xhci_hcd *xhci, struct xhci_virt_ep *ep,
+		struct xhci_ring *ep_ring, struct xhci_td *td,
+		union xhci_trb *ep_trb, struct xhci_transfer_event *event)
 {
 	struct xhci_slot_ctx *slot_ctx;
-	struct xhci_ring *ep_ring;
 	u32 trb_comp_code;
 	u32 remaining, requested, ep_trb_len;
 
 	slot_ctx = xhci_get_slot_ctx(xhci, ep->vdev->out_ctx);
-	ep_ring = xhci_dma_to_transfer_ring(ep, le64_to_cpu(event->buffer));
 	trb_comp_code = GET_COMP_CODE(le32_to_cpu(event->transfer_len));
 	remaining = EVENT_TRB_LEN(le32_to_cpu(event->transfer_len));
 	ep_trb_len = TRB_LEN(le32_to_cpu(ep_trb->generic.field[2]));
@@ -2401,7 +2417,8 @@ static int process_bulk_intr_td(struct xhci_hcd *xhci, struct xhci_td *td,
 			  remaining);
 		td->urb->actual_length = 0;
 	}
-	return finish_td(xhci, td, event, ep);
+
+	return finish_td(xhci, ep, ep_ring, td, trb_comp_code);
 }
 
 /*
@@ -2686,17 +2703,51 @@ static int handle_tx_event(struct xhci_hcd *xhci,
 		}
 
 		if (!ep_seg) {
-			if (!ep->skip ||
-			    !usb_endpoint_xfer_isoc(&td->urb->ep->desc)) {
-				/* Some host controllers give a spurious
-				 * successful event after a short transfer.
-				 * Ignore it.
-				 */
-				if ((xhci->quirks & XHCI_SPURIOUS_SUCCESS) &&
-						ep_ring->last_td_was_short) {
-					ep_ring->last_td_was_short = false;
-					goto cleanup;
+
+			if (ep->skip && usb_endpoint_xfer_isoc(&td->urb->ep->desc)) {
+				skip_isoc_td(xhci, td, ep, status);
+				goto cleanup;
+			}
+
+			/*
+			 * Some hosts give a spurious success event after a short
+			 * transfer. Ignore it.
+			 */
+			if ((xhci->quirks & XHCI_SPURIOUS_SUCCESS) &&
+			    ep_ring->last_td_was_short) {
+				ep_ring->last_td_was_short = false;
+				goto cleanup;
+			}
+
+			/*
+			 * xhci 4.10.2 states isoc endpoints should continue
+			 * processing the next TD if there was an error mid TD.
+			 * So host like NEC don't generate an event for the last
+			 * isoc TRB even if the IOC flag is set.
+			 * xhci 4.9.1 states that if there are errors in mult-TRB
+			 * TDs xHC should generate an error for that TRB, and if xHC
+			 * proceeds to the next TD it should genete an event for
+			 * any TRB with IOC flag on the way. Other host follow this.
+			 * So this event might be for the next TD.
+			 */
+			if (td->error_mid_td &&
+			    !list_is_last(&td->td_list, &ep_ring->td_list)) {
+				struct xhci_td *td_next = list_next_entry(td, td_list);
+
+				ep_seg = trb_in_td(xhci, td_next->start_seg, td_next->first_trb,
+						   td_next->last_trb, ep_trb_dma, false);
+				if (ep_seg) {
+					/* give back previous TD, start handling new */
+					xhci_dbg(xhci, "Missing TD completion event after mid TD error\n");
+					ep_ring->dequeue = td->last_trb;
+					ep_ring->deq_seg = td->last_trb_seg;
+					inc_deq(xhci, ep_ring);
+					xhci_td_cleanup(xhci, td, ep_ring, td->status);
+					td = td_next;
 				}
+			}
+
+			if (!ep_seg) {
 				/* HC is busted, give up! */
 				xhci_err(xhci,
 					"ERROR Transfer event TRB DMA ptr not "
@@ -2708,9 +2759,6 @@ static int handle_tx_event(struct xhci_hcd *xhci,
 					  ep_trb_dma, true);
 				return -ESHUTDOWN;
 			}
-
-			skip_isoc_td(xhci, td, ep, status);
-			goto cleanup;
 		}
 		if (trb_comp_code == COMP_SHORT_PACKET)
 			ep_ring->last_td_was_short = true;
@@ -2752,11 +2800,11 @@ static int handle_tx_event(struct xhci_hcd *xhci,
 
 		/* update the urb's actual_length and give back to the core */
 		if (usb_endpoint_xfer_control(&td->urb->ep->desc))
-			process_ctrl_td(xhci, td, ep_trb, event, ep);
+			process_ctrl_td(xhci, ep, ep_ring, td, ep_trb, event);
 		else if (usb_endpoint_xfer_isoc(&td->urb->ep->desc))
-			process_isoc_td(xhci, td, ep_trb, event, ep);
+			process_isoc_td(xhci, ep, ep_ring, td, ep_trb, event);
 		else
-			process_bulk_intr_td(xhci, td, ep_trb, event, ep);
+			process_bulk_intr_td(xhci, ep, ep_ring, td, ep_trb, event);
 cleanup:
 		handling_skipped_tds = ep->skip &&
 			trb_comp_code != COMP_MISSED_SERVICE_ERROR &&
@@ -3487,7 +3535,7 @@ int xhci_queue_bulk_tx(struct xhci_hcd *xhci, gfp_t mem_flags,
 			field |= TRB_IOC;
 			more_trbs_coming = false;
 			td->last_trb = ring->enqueue;
-
+			td->last_trb_seg = ring->enq_seg;
 			if (xhci_urb_suitable_for_idt(urb)) {
 				memcpy(&send_addr, urb->transfer_buffer,
 				       trb_buff_len);
@@ -3513,7 +3561,7 @@ int xhci_queue_bulk_tx(struct xhci_hcd *xhci, gfp_t mem_flags,
 				upper_32_bits(send_addr),
 				length_field,
 				field);
-
+		td->num_trbs++;
 		addr += trb_buff_len;
 		sent_len = trb_buff_len;
 
@@ -3537,8 +3585,10 @@ int xhci_queue_bulk_tx(struct xhci_hcd *xhci, gfp_t mem_flags,
 				       ep_index, urb->stream_id,
 				       1, urb, 1, mem_flags);
 		urb_priv->td[1].last_trb = ring->enqueue;
+		urb_priv->td[1].last_trb_seg = ring->enq_seg;
 		field = TRB_TYPE(TRB_NORMAL) | ring->cycle_state | TRB_IOC;
 		queue_trb(xhci, ring, 0, 0, 0, TRB_INTR_TARGET(0), field);
+		urb_priv->td[1].num_trbs++;
 	}
 
 	check_trb_math(urb, enqd_len);
@@ -3589,6 +3639,7 @@ int xhci_queue_ctrl_tx(struct xhci_hcd *xhci, gfp_t mem_flags,
 
 	urb_priv = urb->hcpriv;
 	td = &urb_priv->td[0];
+	td->num_trbs = num_trbs;
 
 	/*
 	 * Don't give the first TRB to the hardware (by toggling the cycle bit)
@@ -3661,6 +3712,7 @@ int xhci_queue_ctrl_tx(struct xhci_hcd *xhci, gfp_t mem_flags,
 
 	/* Save the DMA address of the last TRB in the TD */
 	td->last_trb = ep_ring->enqueue;
+	td->last_trb_seg = ep_ring->enq_seg;
 
 	/* Queue status TRB - see Table 7 and sections 4.11.2.2 and 6.4.1.2.3 */
 	/* If the device sent data, the status stage is an OUT transfer */
@@ -3905,7 +3957,7 @@ static int xhci_queue_isoc_tx(struct xhci_hcd *xhci, gfp_t mem_flags,
 			goto cleanup;
 		}
 		td = &urb_priv->td[i];
-
+		td->num_trbs = trbs_per_td;
 		/* use SIA as default, if frame id is used overwrite it */
 		sia_frame_id = TRB_SIA;
 		if (!(urb->transfer_flags & URB_ISO_ASAP) &&
@@ -3948,6 +4000,7 @@ static int xhci_queue_isoc_tx(struct xhci_hcd *xhci, gfp_t mem_flags,
 			} else {
 				more_trbs_coming = false;
 				td->last_trb = ep_ring->enqueue;
+				td->last_trb_seg = ep_ring->enq_seg;
 				field |= TRB_IOC;
 				if (trb_block_event_intr(xhci, num_tds, i))
 					field |= TRB_BEI;
diff --git a/drivers/usb/host/xhci.h b/drivers/usb/host/xhci.h
index bb3c362a194b2..5a8443f6ed703 100644
--- a/drivers/usb/host/xhci.h
+++ b/drivers/usb/host/xhci.h
@@ -1550,9 +1550,12 @@ struct xhci_td {
 	struct xhci_segment	*start_seg;
 	union xhci_trb		*first_trb;
 	union xhci_trb		*last_trb;
+	struct xhci_segment	*last_trb_seg;
 	struct xhci_segment	*bounce_seg;
 	/* actual_length of the URB has already been set */
 	bool			urb_length_set;
+	bool			error_mid_td;
+	unsigned int		num_trbs;
 };
 
 /* xHCI command default timeout value */
diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index 68aa8760cb465..9e12592727914 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -3107,8 +3107,9 @@ static int ext4_zeroout_es(struct inode *inode, struct ext4_extent *ex)
 	if (ee_len == 0)
 		return 0;
 
-	return ext4_es_insert_extent(inode, ee_block, ee_len, ee_pblock,
-				     EXTENT_STATUS_WRITTEN);
+	ext4_es_insert_extent(inode, ee_block, ee_len, ee_pblock,
+			      EXTENT_STATUS_WRITTEN);
+	return 0;
 }
 
 /* FIXME!! we need to try to merge to left or right after zero-out  */
diff --git a/fs/ext4/extents_status.c b/fs/ext4/extents_status.c
index cccbdfd49a86b..f37e62546745b 100644
--- a/fs/ext4/extents_status.c
+++ b/fs/ext4/extents_status.c
@@ -846,12 +846,10 @@ static int __es_insert_extent(struct inode *inode, struct extent_status *newes,
 /*
  * ext4_es_insert_extent() adds information to an inode's extent
  * status tree.
- *
- * Return 0 on success, error code on failure.
  */
-int ext4_es_insert_extent(struct inode *inode, ext4_lblk_t lblk,
-			  ext4_lblk_t len, ext4_fsblk_t pblk,
-			  unsigned int status)
+void ext4_es_insert_extent(struct inode *inode, ext4_lblk_t lblk,
+			   ext4_lblk_t len, ext4_fsblk_t pblk,
+			   unsigned int status)
 {
 	struct extent_status newes;
 	ext4_lblk_t end = lblk + len - 1;
@@ -863,13 +861,13 @@ int ext4_es_insert_extent(struct inode *inode, ext4_lblk_t lblk,
 	bool revise_pending = false;
 
 	if (EXT4_SB(inode->i_sb)->s_mount_state & EXT4_FC_REPLAY)
-		return 0;
+		return;
 
 	es_debug("add [%u/%u) %llu %x to extent status tree of inode %lu\n",
 		 lblk, len, pblk, status, inode->i_ino);
 
 	if (!len)
-		return 0;
+		return;
 
 	BUG_ON(end < lblk);
 
@@ -938,7 +936,7 @@ int ext4_es_insert_extent(struct inode *inode, ext4_lblk_t lblk,
 		goto retry;
 
 	ext4_es_print_tree(inode);
-	return 0;
+	return;
 }
 
 /*
diff --git a/fs/ext4/extents_status.h b/fs/ext4/extents_status.h
index 4ec30a7982605..481ec4381bee6 100644
--- a/fs/ext4/extents_status.h
+++ b/fs/ext4/extents_status.h
@@ -127,9 +127,9 @@ extern int __init ext4_init_es(void);
 extern void ext4_exit_es(void);
 extern void ext4_es_init_tree(struct ext4_es_tree *tree);
 
-extern int ext4_es_insert_extent(struct inode *inode, ext4_lblk_t lblk,
-				 ext4_lblk_t len, ext4_fsblk_t pblk,
-				 unsigned int status);
+extern void ext4_es_insert_extent(struct inode *inode, ext4_lblk_t lblk,
+				  ext4_lblk_t len, ext4_fsblk_t pblk,
+				  unsigned int status);
 extern void ext4_es_cache_extent(struct inode *inode, ext4_lblk_t lblk,
 				 ext4_lblk_t len, ext4_fsblk_t pblk,
 				 unsigned int status);
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 365c4d3a434ab..8b48ed351c4b9 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -589,10 +589,8 @@ int ext4_map_blocks(handle_t *handle, struct inode *inode,
 		    ext4_es_scan_range(inode, &ext4_es_is_delayed, map->m_lblk,
 				       map->m_lblk + map->m_len - 1))
 			status |= EXTENT_STATUS_DELAYED;
-		ret = ext4_es_insert_extent(inode, map->m_lblk,
-					    map->m_len, map->m_pblk, status);
-		if (ret < 0)
-			retval = ret;
+		ext4_es_insert_extent(inode, map->m_lblk, map->m_len,
+				      map->m_pblk, status);
 	}
 	up_read((&EXT4_I(inode)->i_data_sem));
 
@@ -701,12 +699,8 @@ int ext4_map_blocks(handle_t *handle, struct inode *inode,
 		    ext4_es_scan_range(inode, &ext4_es_is_delayed, map->m_lblk,
 				       map->m_lblk + map->m_len - 1))
 			status |= EXTENT_STATUS_DELAYED;
-		ret = ext4_es_insert_extent(inode, map->m_lblk, map->m_len,
-					    map->m_pblk, status);
-		if (ret < 0) {
-			retval = ret;
-			goto out_sem;
-		}
+		ext4_es_insert_extent(inode, map->m_lblk, map->m_len,
+				      map->m_pblk, status);
 	}
 
 out_sem:
@@ -1734,11 +1728,8 @@ static int ext4_da_map_blocks(struct inode *inode, sector_t iblock,
 
 	/* Lookup extent status tree firstly */
 	if (ext4_es_lookup_extent(inode, iblock, NULL, &es)) {
-		if (ext4_es_is_hole(&es)) {
-			retval = 0;
-			down_read(&EXT4_I(inode)->i_data_sem);
+		if (ext4_es_is_hole(&es))
 			goto add_delayed;
-		}
 
 		/*
 		 * Delayed extent could be allocated by fallocate.
@@ -1780,27 +1771,11 @@ static int ext4_da_map_blocks(struct inode *inode, sector_t iblock,
 		retval = ext4_ext_map_blocks(NULL, inode, map, 0);
 	else
 		retval = ext4_ind_map_blocks(NULL, inode, map, 0);
-
-add_delayed:
-	if (retval == 0) {
-		int ret;
-
-		/*
-		 * XXX: __block_prepare_write() unmaps passed block,
-		 * is it OK?
-		 */
-
-		ret = ext4_insert_delayed_block(inode, map->m_lblk);
-		if (ret != 0) {
-			retval = ret;
-			goto out_unlock;
-		}
-
-		map_bh(bh, inode->i_sb, invalid_block);
-		set_buffer_new(bh);
-		set_buffer_delay(bh);
-	} else if (retval > 0) {
-		int ret;
+	if (retval < 0) {
+		up_read(&EXT4_I(inode)->i_data_sem);
+		return retval;
+	}
+	if (retval > 0) {
 		unsigned int status;
 
 		if (unlikely(retval != map->m_len)) {
@@ -1813,15 +1788,23 @@ static int ext4_da_map_blocks(struct inode *inode, sector_t iblock,
 
 		status = map->m_flags & EXT4_MAP_UNWRITTEN ?
 				EXTENT_STATUS_UNWRITTEN : EXTENT_STATUS_WRITTEN;
-		ret = ext4_es_insert_extent(inode, map->m_lblk, map->m_len,
-					    map->m_pblk, status);
-		if (ret != 0)
-			retval = ret;
+		ext4_es_insert_extent(inode, map->m_lblk, map->m_len,
+				      map->m_pblk, status);
+		up_read(&EXT4_I(inode)->i_data_sem);
+		return retval;
 	}
+	up_read(&EXT4_I(inode)->i_data_sem);
 
-out_unlock:
-	up_read((&EXT4_I(inode)->i_data_sem));
+add_delayed:
+	down_write(&EXT4_I(inode)->i_data_sem);
+	retval = ext4_insert_delayed_block(inode, map->m_lblk);
+	up_write(&EXT4_I(inode)->i_data_sem);
+	if (retval)
+		return retval;
 
+	map_bh(bh, inode->i_sb, invalid_block);
+	set_buffer_new(bh);
+	set_buffer_delay(bh);
 	return retval;
 }
 
diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index a0edd4b8fa189..bf3cda4989623 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -135,6 +135,7 @@ static int hugetlbfs_file_mmap(struct file *file, struct vm_area_struct *vma)
 	loff_t len, vma_len;
 	int ret;
 	struct hstate *h = hstate_file(file);
+	vm_flags_t vm_flags;
 
 	/*
 	 * vma address alignment (but not the pgoff alignment) has
@@ -176,10 +177,20 @@ static int hugetlbfs_file_mmap(struct file *file, struct vm_area_struct *vma)
 	file_accessed(file);
 
 	ret = -ENOMEM;
-	if (hugetlb_reserve_pages(inode,
+
+	vm_flags = vma->vm_flags;
+	/*
+	 * for SHM_HUGETLB, the pages are reserved in the shmget() call so skip
+	 * reserving here. Note: only for SHM hugetlbfs file, the inode
+	 * flag S_PRIVATE is set.
+	 */
+	if (inode->i_flags & S_PRIVATE)
+		vm_flags |= VM_NORESERVE;
+
+	if (!hugetlb_reserve_pages(inode,
 				vma->vm_pgoff >> huge_page_order(h),
 				len >> huge_page_shift(h), vma,
-				vma->vm_flags))
+				vm_flags))
 		goto out;
 
 	ret = 0;
@@ -1500,7 +1511,7 @@ struct file *hugetlb_file_setup(const char *name, size_t size,
 	inode->i_size = size;
 	clear_nlink(inode);
 
-	if (hugetlb_reserve_pages(inode, 0,
+	if (!hugetlb_reserve_pages(inode, 0,
 			size >> huge_page_shift(hstate_inode(inode)), NULL,
 			acctflag))
 		file = ERR_PTR(-ENOMEM);
diff --git a/include/linux/filter.h b/include/linux/filter.h
index bc6ce4b202a80..cd56e53bd42e2 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -892,8 +892,7 @@ int sk_reuseport_attach_filter(struct sock_fprog *fprog, struct sock *sk);
 int sk_reuseport_attach_bpf(u32 ufd, struct sock *sk);
 void sk_reuseport_prog_free(struct bpf_prog *prog);
 int sk_detach_filter(struct sock *sk);
-int sk_get_filter(struct sock *sk, struct sock_filter __user *filter,
-		  unsigned int len);
+int sk_get_filter(struct sock *sk, sockptr_t optval, unsigned int len);
 
 bool sk_filter_charge(struct sock *sk, struct sk_filter *fp);
 void sk_filter_uncharge(struct sock *sk, struct sk_filter *fp);
diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 99b73fc4a8246..90c66b9458c31 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -140,7 +140,7 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm, pte_t *dst_pte,
 				unsigned long dst_addr,
 				unsigned long src_addr,
 				struct page **pagep);
-int hugetlb_reserve_pages(struct inode *inode, long from, long to,
+bool hugetlb_reserve_pages(struct inode *inode, long from, long to,
 						struct vm_area_struct *vma,
 						vm_flags_t vm_flags);
 long hugetlb_unreserve_pages(struct inode *inode, long start, long end,
diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
index eada4d8d65879..2aaf450c8d800 100644
--- a/include/linux/hyperv.h
+++ b/include/linux/hyperv.h
@@ -764,6 +764,23 @@ enum vmbus_device_type {
 	HV_UNKNOWN,
 };
 
+/*
+ * Provides request ids for VMBus. Encapsulates guest memory
+ * addresses and stores the next available slot in req_arr
+ * to generate new ids in constant time.
+ */
+struct vmbus_requestor {
+	u64 *req_arr;
+	unsigned long *req_bitmap; /* is a given slot available? */
+	u32 size;
+	u64 next_request_id;
+	spinlock_t req_lock; /* provides atomicity */
+};
+
+#define VMBUS_NO_RQSTOR U64_MAX
+#define VMBUS_RQST_ERROR (U64_MAX - 1)
+#define VMBUS_RQST_ID_NO_RESPONSE (U64_MAX - 2)
+
 struct vmbus_device {
 	u16  dev_type;
 	guid_t guid;
@@ -988,8 +1005,14 @@ struct vmbus_channel {
 	u32 fuzz_testing_interrupt_delay;
 	u32 fuzz_testing_message_delay;
 
+	/* request/transaction ids for VMBus */
+	struct vmbus_requestor requestor;
+	u32 rqstor_size;
 };
 
+u64 vmbus_next_request_id(struct vmbus_requestor *rqstor, u64 rqst_addr);
+u64 vmbus_request_addr(struct vmbus_requestor *rqstor, u64 trans_id);
+
 static inline bool is_hvsock_channel(const struct vmbus_channel *c)
 {
 	return !!(c->offermsg.offer.chn_flags &
diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index 92a76ce0c382d..07abcd384975b 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -293,9 +293,9 @@ LSM_HOOK(int, 0, socket_getsockopt, struct socket *sock, int level, int optname)
 LSM_HOOK(int, 0, socket_setsockopt, struct socket *sock, int level, int optname)
 LSM_HOOK(int, 0, socket_shutdown, struct socket *sock, int how)
 LSM_HOOK(int, 0, socket_sock_rcv_skb, struct sock *sk, struct sk_buff *skb)
-LSM_HOOK(int, 0, socket_getpeersec_stream, struct socket *sock,
-	 char __user *optval, int __user *optlen, unsigned len)
-LSM_HOOK(int, 0, socket_getpeersec_dgram, struct socket *sock,
+LSM_HOOK(int, -ENOPROTOOPT, socket_getpeersec_stream, struct socket *sock,
+	 sockptr_t optval, sockptr_t optlen, unsigned int len)
+LSM_HOOK(int, -ENOPROTOOPT, socket_getpeersec_dgram, struct socket *sock,
 	 struct sk_buff *skb, u32 *secid)
 LSM_HOOK(int, 0, sk_alloc_security, struct sock *sk, int family, gfp_t priority)
 LSM_HOOK(void, LSM_RET_VOID, sk_free_security, struct sock *sk)
diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 64cdf4d7bfb30..bbf9c8c7bd9c5 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -926,8 +926,8 @@
  *	SO_GETPEERSEC.  For tcp sockets this can be meaningful if the
  *	socket is associated with an ipsec SA.
  *	@sock is the local socket.
- *	@optval userspace memory where the security state is to be copied.
- *	@optlen userspace int where the module should copy the actual length
+ *	@optval memory where the security state is to be copied.
+ *	@optlen memory where the module should copy the actual length
  *	of the security state.
  *	@len as input is the maximum length to copy to userspace provided
  *	by the caller.
diff --git a/include/linux/regmap.h b/include/linux/regmap.h
index e7834d98207f7..83a7485de78fb 100644
--- a/include/linux/regmap.h
+++ b/include/linux/regmap.h
@@ -289,6 +289,17 @@ typedef void (*regmap_unlock)(void *);
  *		  read operation on a bus such as SPI, I2C, etc. Most of the
  *		  devices do not need this.
  * @reg_write:	  Same as above for writing.
+ * @reg_update_bits: Optional callback that if filled will be used to perform
+ *		     all the update_bits(rmw) operation. Should only be provided
+ *		     if the function require special handling with lock and reg
+ *		     handling and the operation cannot be represented as a simple
+ *		     update_bits operation on a bus such as SPI, I2C, etc.
+ * @read: Optional callback that if filled will be used to perform all the
+ *        bulk reads from the registers. Data is returned in the buffer used
+ *        to transmit data.
+ * @write: Same as above for writing.
+ * @max_raw_read: Max raw read size that can be used on the device.
+ * @max_raw_write: Max raw write size that can be used on the device.
  * @fast_io:	  Register IO is fast. Use a spinlock instead of a mutex
  *	     	  to perform locking. This field is ignored if custom lock/unlock
  *	     	  functions are used (see fields lock/unlock of struct regmap_config).
@@ -366,6 +377,14 @@ struct regmap_config {
 
 	int (*reg_read)(void *context, unsigned int reg, unsigned int *val);
 	int (*reg_write)(void *context, unsigned int reg, unsigned int val);
+	int (*reg_update_bits)(void *context, unsigned int reg,
+			       unsigned int mask, unsigned int val);
+	/* Bulk read/write */
+	int (*read)(void *context, const void *reg_buf, size_t reg_size,
+		    void *val_buf, size_t val_size);
+	int (*write)(void *context, const void *data, size_t count);
+	size_t max_raw_read;
+	size_t max_raw_write;
 
 	bool fast_io;
 
diff --git a/include/linux/security.h b/include/linux/security.h
index e388b1666bcfc..5b61aa19fac66 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -31,6 +31,7 @@
 #include <linux/err.h>
 #include <linux/string.h>
 #include <linux/mm.h>
+#include <linux/sockptr.h>
 
 struct linux_binprm;
 struct cred;
@@ -1366,8 +1367,8 @@ int security_socket_getsockopt(struct socket *sock, int level, int optname);
 int security_socket_setsockopt(struct socket *sock, int level, int optname);
 int security_socket_shutdown(struct socket *sock, int how);
 int security_sock_rcv_skb(struct sock *sk, struct sk_buff *skb);
-int security_socket_getpeersec_stream(struct socket *sock, char __user *optval,
-				      int __user *optlen, unsigned len);
+int security_socket_getpeersec_stream(struct socket *sock, sockptr_t optval,
+				      sockptr_t optlen, unsigned int len);
 int security_socket_getpeersec_dgram(struct socket *sock, struct sk_buff *skb, u32 *secid);
 int security_sk_alloc(struct sock *sk, int family, gfp_t priority);
 void security_sk_free(struct sock *sk);
@@ -1501,8 +1502,10 @@ static inline int security_sock_rcv_skb(struct sock *sk,
 	return 0;
 }
 
-static inline int security_socket_getpeersec_stream(struct socket *sock, char __user *optval,
-						    int __user *optlen, unsigned len)
+static inline int security_socket_getpeersec_stream(struct socket *sock,
+						    sockptr_t optval,
+						    sockptr_t optlen,
+						    unsigned int len)
 {
 	return -ENOPROTOOPT;
 }
diff --git a/include/linux/sockptr.h b/include/linux/sockptr.h
index ea193414298b7..38862819e77a1 100644
--- a/include/linux/sockptr.h
+++ b/include/linux/sockptr.h
@@ -64,6 +64,11 @@ static inline int copy_to_sockptr_offset(sockptr_t dst, size_t offset,
 	return 0;
 }
 
+static inline int copy_to_sockptr(sockptr_t dst, const void *src, size_t size)
+{
+	return copy_to_sockptr_offset(dst, 0, src, size);
+}
+
 static inline void *memdup_sockptr(sockptr_t src, size_t len)
 {
 	void *p = kmalloc_track_caller(len, GFP_USER | __GFP_NOWARN);
diff --git a/include/trace/events/qdisc.h b/include/trace/events/qdisc.h
index 330d32d84485b..a50df41634c58 100644
--- a/include/trace/events/qdisc.h
+++ b/include/trace/events/qdisc.h
@@ -53,14 +53,14 @@ TRACE_EVENT(qdisc_reset,
 	TP_ARGS(q),
 
 	TP_STRUCT__entry(
-		__string(	dev,		qdisc_dev(q)	)
-		__string(	kind,		q->ops->id	)
-		__field(	u32,		parent		)
-		__field(	u32,		handle		)
+		__string(	dev,		qdisc_dev(q)->name	)
+		__string(	kind,		q->ops->id		)
+		__field(	u32,		parent			)
+		__field(	u32,		handle			)
 	),
 
 	TP_fast_assign(
-		__assign_str(dev, qdisc_dev(q));
+		__assign_str(dev, qdisc_dev(q)->name);
 		__assign_str(kind, q->ops->id);
 		__entry->parent = q->parent;
 		__entry->handle = q->handle;
@@ -78,14 +78,14 @@ TRACE_EVENT(qdisc_destroy,
 	TP_ARGS(q),
 
 	TP_STRUCT__entry(
-		__string(	dev,		qdisc_dev(q)	)
-		__string(	kind,		q->ops->id	)
-		__field(	u32,		parent		)
-		__field(	u32,		handle		)
+		__string(	dev,		qdisc_dev(q)->name	)
+		__string(	kind,		q->ops->id		)
+		__field(	u32,		parent			)
+		__field(	u32,		handle			)
 	),
 
 	TP_fast_assign(
-		__assign_str(dev, qdisc_dev(q));
+		__assign_str(dev, qdisc_dev(q)->name);
 		__assign_str(kind, q->ops->id);
 		__entry->parent = q->parent;
 		__entry->handle = q->handle;
diff --git a/kernel/bpf/cpumap.c b/kernel/bpf/cpumap.c
index c61a23b564aa5..2dcc04b2f330e 100644
--- a/kernel/bpf/cpumap.c
+++ b/kernel/bpf/cpumap.c
@@ -229,7 +229,7 @@ static int cpu_map_bpf_prog_run_xdp(struct bpf_cpu_map_entry *rcpu,
 				    void **frames, int n,
 				    struct xdp_cpumap_stats *stats)
 {
-	struct xdp_rxq_info rxq;
+	struct xdp_rxq_info rxq = {};
 	struct xdp_buff xdp;
 	int i, nframes = 0;
 
diff --git a/kernel/sys.c b/kernel/sys.c
index bff14910b9262..efc213ae4c5ad 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -1736,74 +1736,87 @@ void getrusage(struct task_struct *p, int who, struct rusage *r)
 	struct task_struct *t;
 	unsigned long flags;
 	u64 tgutime, tgstime, utime, stime;
-	unsigned long maxrss = 0;
+	unsigned long maxrss;
+	struct mm_struct *mm;
+	struct signal_struct *sig = p->signal;
+	unsigned int seq = 0;
 
-	memset((char *)r, 0, sizeof (*r));
+retry:
+	memset(r, 0, sizeof(*r));
 	utime = stime = 0;
+	maxrss = 0;
 
 	if (who == RUSAGE_THREAD) {
 		task_cputime_adjusted(current, &utime, &stime);
 		accumulate_thread_rusage(p, r);
-		maxrss = p->signal->maxrss;
-		goto out;
+		maxrss = sig->maxrss;
+		goto out_thread;
 	}
 
-	if (!lock_task_sighand(p, &flags))
-		return;
+	flags = read_seqbegin_or_lock_irqsave(&sig->stats_lock, &seq);
 
 	switch (who) {
 	case RUSAGE_BOTH:
 	case RUSAGE_CHILDREN:
-		utime = p->signal->cutime;
-		stime = p->signal->cstime;
-		r->ru_nvcsw = p->signal->cnvcsw;
-		r->ru_nivcsw = p->signal->cnivcsw;
-		r->ru_minflt = p->signal->cmin_flt;
-		r->ru_majflt = p->signal->cmaj_flt;
-		r->ru_inblock = p->signal->cinblock;
-		r->ru_oublock = p->signal->coublock;
-		maxrss = p->signal->cmaxrss;
+		utime = sig->cutime;
+		stime = sig->cstime;
+		r->ru_nvcsw = sig->cnvcsw;
+		r->ru_nivcsw = sig->cnivcsw;
+		r->ru_minflt = sig->cmin_flt;
+		r->ru_majflt = sig->cmaj_flt;
+		r->ru_inblock = sig->cinblock;
+		r->ru_oublock = sig->coublock;
+		maxrss = sig->cmaxrss;
 
 		if (who == RUSAGE_CHILDREN)
 			break;
 		fallthrough;
 
 	case RUSAGE_SELF:
-		thread_group_cputime_adjusted(p, &tgutime, &tgstime);
-		utime += tgutime;
-		stime += tgstime;
-		r->ru_nvcsw += p->signal->nvcsw;
-		r->ru_nivcsw += p->signal->nivcsw;
-		r->ru_minflt += p->signal->min_flt;
-		r->ru_majflt += p->signal->maj_flt;
-		r->ru_inblock += p->signal->inblock;
-		r->ru_oublock += p->signal->oublock;
-		if (maxrss < p->signal->maxrss)
-			maxrss = p->signal->maxrss;
-		t = p;
-		do {
+		r->ru_nvcsw += sig->nvcsw;
+		r->ru_nivcsw += sig->nivcsw;
+		r->ru_minflt += sig->min_flt;
+		r->ru_majflt += sig->maj_flt;
+		r->ru_inblock += sig->inblock;
+		r->ru_oublock += sig->oublock;
+		if (maxrss < sig->maxrss)
+			maxrss = sig->maxrss;
+
+		rcu_read_lock();
+		__for_each_thread(sig, t)
 			accumulate_thread_rusage(t, r);
-		} while_each_thread(p, t);
+		rcu_read_unlock();
+
 		break;
 
 	default:
 		BUG();
 	}
-	unlock_task_sighand(p, &flags);
 
-out:
-	r->ru_utime = ns_to_kernel_old_timeval(utime);
-	r->ru_stime = ns_to_kernel_old_timeval(stime);
+	if (need_seqretry(&sig->stats_lock, seq)) {
+		seq = 1;
+		goto retry;
+	}
+	done_seqretry_irqrestore(&sig->stats_lock, seq, flags);
 
-	if (who != RUSAGE_CHILDREN) {
-		struct mm_struct *mm = get_task_mm(p);
+	if (who == RUSAGE_CHILDREN)
+		goto out_children;
 
-		if (mm) {
-			setmax_mm_hiwater_rss(&maxrss, mm);
-			mmput(mm);
-		}
+	thread_group_cputime_adjusted(p, &tgutime, &tgstime);
+	utime += tgutime;
+	stime += tgstime;
+
+out_thread:
+	mm = get_task_mm(p);
+	if (mm) {
+		setmax_mm_hiwater_rss(&maxrss, mm);
+		mmput(mm);
 	}
+
+out_children:
 	r->ru_maxrss = maxrss * (PAGE_SIZE / 1024); /* convert pages to KBs */
+	r->ru_utime = ns_to_kernel_old_timeval(utime);
+	r->ru_stime = ns_to_kernel_old_timeval(stime);
 }
 
 SYSCALL_DEFINE2(getrusage, int, who, struct rusage __user *, ru)
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 81949f6d29af5..02b7c8f9b0e87 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5108,12 +5108,13 @@ unsigned long hugetlb_change_protection(struct vm_area_struct *vma,
 	return pages << h->order;
 }
 
-int hugetlb_reserve_pages(struct inode *inode,
+/* Return true if reservation was successful, false otherwise.  */
+bool hugetlb_reserve_pages(struct inode *inode,
 					long from, long to,
 					struct vm_area_struct *vma,
 					vm_flags_t vm_flags)
 {
-	long ret, chg, add = -1;
+	long chg, add = -1;
 	struct hstate *h = hstate_inode(inode);
 	struct hugepage_subpool *spool = subpool_inode(inode);
 	struct resv_map *resv_map;
@@ -5123,7 +5124,7 @@ int hugetlb_reserve_pages(struct inode *inode,
 	/* This should never happen */
 	if (from > to) {
 		VM_WARN(1, "%s called with a negative range\n", __func__);
-		return -EINVAL;
+		return false;
 	}
 
 	/*
@@ -5132,7 +5133,7 @@ int hugetlb_reserve_pages(struct inode *inode,
 	 * without using reserves
 	 */
 	if (vm_flags & VM_NORESERVE)
-		return 0;
+		return true;
 
 	/*
 	 * Shared mappings base their reservation on the number of pages that
@@ -5154,7 +5155,7 @@ int hugetlb_reserve_pages(struct inode *inode,
 		/* Private mapping. */
 		resv_map = resv_map_alloc();
 		if (!resv_map)
-			return -ENOMEM;
+			return false;
 
 		chg = to - from;
 
@@ -5162,18 +5163,12 @@ int hugetlb_reserve_pages(struct inode *inode,
 		set_vma_resv_flags(vma, HPAGE_RESV_OWNER);
 	}
 
-	if (chg < 0) {
-		ret = chg;
+	if (chg < 0)
 		goto out_err;
-	}
-
-	ret = hugetlb_cgroup_charge_cgroup_rsvd(
-		hstate_index(h), chg * pages_per_huge_page(h), &h_cg);
 
-	if (ret < 0) {
-		ret = -ENOMEM;
+	if (hugetlb_cgroup_charge_cgroup_rsvd(hstate_index(h),
+				chg * pages_per_huge_page(h), &h_cg) < 0)
 		goto out_err;
-	}
 
 	if (vma && !(vma->vm_flags & VM_MAYSHARE) && h_cg) {
 		/* For private mappings, the hugetlb_cgroup uncharge info hangs
@@ -5188,19 +5183,15 @@ int hugetlb_reserve_pages(struct inode *inode,
 	 * reservations already in place (gbl_reserve).
 	 */
 	gbl_reserve = hugepage_subpool_get_pages(spool, chg);
-	if (gbl_reserve < 0) {
-		ret = -ENOSPC;
+	if (gbl_reserve < 0)
 		goto out_uncharge_cgroup;
-	}
 
 	/*
 	 * Check enough hugepages are available for the reservation.
 	 * Hand the pages back to the subpool if there are not
 	 */
-	ret = hugetlb_acct_memory(h, gbl_reserve);
-	if (ret < 0) {
+	if (hugetlb_acct_memory(h, gbl_reserve) < 0)
 		goto out_put_pages;
-	}
 
 	/*
 	 * Account for the reservations made. Shared mappings record regions
@@ -5218,7 +5209,6 @@ int hugetlb_reserve_pages(struct inode *inode,
 
 		if (unlikely(add < 0)) {
 			hugetlb_acct_memory(h, -gbl_reserve);
-			ret = add;
 			goto out_put_pages;
 		} else if (unlikely(chg > add)) {
 			/*
@@ -5251,7 +5241,8 @@ int hugetlb_reserve_pages(struct inode *inode,
 			hugetlb_cgroup_put_rsvd_cgroup(h_cg);
 		}
 	}
-	return 0;
+	return true;
+
 out_put_pages:
 	/* put back original number of pages, chg */
 	(void)hugepage_subpool_put_pages(spool, chg);
@@ -5267,7 +5258,7 @@ int hugetlb_reserve_pages(struct inode *inode,
 			region_abort(resv_map, from, to, regions_needed);
 	if (vma && is_vma_resv_set(vma, HPAGE_RESV_OWNER))
 		kref_put(&resv_map->refs, resv_map_release);
-	return ret;
+	return false;
 }
 
 long hugetlb_unreserve_pages(struct inode *inode, long start, long end,
diff --git a/net/core/filter.c b/net/core/filter.c
index 6cfc8fb0562a2..49e4d1535cc82 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -9903,8 +9903,7 @@ int sk_detach_filter(struct sock *sk)
 }
 EXPORT_SYMBOL_GPL(sk_detach_filter);
 
-int sk_get_filter(struct sock *sk, struct sock_filter __user *ubuf,
-		  unsigned int len)
+int sk_get_filter(struct sock *sk, sockptr_t optval, unsigned int len)
 {
 	struct sock_fprog_kern *fprog;
 	struct sk_filter *filter;
@@ -9935,7 +9934,7 @@ int sk_get_filter(struct sock *sk, struct sock_filter __user *ubuf,
 		goto out;
 
 	ret = -EFAULT;
-	if (copy_to_user(ubuf, fprog->filter, bpf_classic_proglen(fprog)))
+	if (copy_to_sockptr(optval, fprog->filter, bpf_classic_proglen(fprog)))
 		goto out;
 
 	/* Instead of bytes, the API requests to return the number
diff --git a/net/core/sock.c b/net/core/sock.c
index 769e969cd1dc5..016c0b9e01b70 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -644,8 +644,8 @@ static int sock_setbindtodevice(struct sock *sk, sockptr_t optval, int optlen)
 	return ret;
 }
 
-static int sock_getbindtodevice(struct sock *sk, char __user *optval,
-				int __user *optlen, int len)
+static int sock_getbindtodevice(struct sock *sk, sockptr_t optval,
+				sockptr_t optlen, int len)
 {
 	int ret = -ENOPROTOOPT;
 #ifdef CONFIG_NETDEVICES
@@ -668,12 +668,12 @@ static int sock_getbindtodevice(struct sock *sk, char __user *optval,
 	len = strlen(devname) + 1;
 
 	ret = -EFAULT;
-	if (copy_to_user(optval, devname, len))
+	if (copy_to_sockptr(optval, devname, len))
 		goto out;
 
 zero:
 	ret = -EFAULT;
-	if (put_user(len, optlen))
+	if (copy_to_sockptr(optlen, &len, sizeof(int)))
 		goto out;
 
 	ret = 0;
@@ -1281,22 +1281,25 @@ static void cred_to_ucred(struct pid *pid, const struct cred *cred,
 	}
 }
 
-static int groups_to_user(gid_t __user *dst, const struct group_info *src)
+static int groups_to_user(sockptr_t dst, const struct group_info *src)
 {
 	struct user_namespace *user_ns = current_user_ns();
 	int i;
 
-	for (i = 0; i < src->ngroups; i++)
-		if (put_user(from_kgid_munged(user_ns, src->gid[i]), dst + i))
+	for (i = 0; i < src->ngroups; i++) {
+		gid_t gid = from_kgid_munged(user_ns, src->gid[i]);
+
+		if (copy_to_sockptr_offset(dst, i * sizeof(gid), &gid, sizeof(gid)))
 			return -EFAULT;
+	}
 
 	return 0;
 }
 
-int sock_getsockopt(struct socket *sock, int level, int optname,
-		    char __user *optval, int __user *optlen)
+static int sk_getsockopt(struct sock *sk, int level, int optname,
+			 sockptr_t optval, sockptr_t optlen)
 {
-	struct sock *sk = sock->sk;
+	struct socket *sock = sk->sk_socket;
 
 	union {
 		int val;
@@ -1312,7 +1315,7 @@ int sock_getsockopt(struct socket *sock, int level, int optname,
 	int lv = sizeof(int);
 	int len;
 
-	if (get_user(len, optlen))
+	if (copy_from_sockptr(&len, optlen, sizeof(int)))
 		return -EFAULT;
 	if (len < 0)
 		return -EINVAL;
@@ -1445,7 +1448,7 @@ int sock_getsockopt(struct socket *sock, int level, int optname,
 		cred_to_ucred(sk->sk_peer_pid, sk->sk_peer_cred, &peercred);
 		spin_unlock(&sk->sk_peer_lock);
 
-		if (copy_to_user(optval, &peercred, len))
+		if (copy_to_sockptr(optval, &peercred, len))
 			return -EFAULT;
 		goto lenout;
 	}
@@ -1463,11 +1466,11 @@ int sock_getsockopt(struct socket *sock, int level, int optname,
 		if (len < n * sizeof(gid_t)) {
 			len = n * sizeof(gid_t);
 			put_cred(cred);
-			return put_user(len, optlen) ? -EFAULT : -ERANGE;
+			return copy_to_sockptr(optlen, &len, sizeof(int)) ? -EFAULT : -ERANGE;
 		}
 		len = n * sizeof(gid_t);
 
-		ret = groups_to_user((gid_t __user *)optval, cred->group_info);
+		ret = groups_to_user(optval, cred->group_info);
 		put_cred(cred);
 		if (ret)
 			return ret;
@@ -1483,7 +1486,7 @@ int sock_getsockopt(struct socket *sock, int level, int optname,
 			return -ENOTCONN;
 		if (lv < len)
 			return -EINVAL;
-		if (copy_to_user(optval, address, len))
+		if (copy_to_sockptr(optval, address, len))
 			return -EFAULT;
 		goto lenout;
 	}
@@ -1500,7 +1503,8 @@ int sock_getsockopt(struct socket *sock, int level, int optname,
 		break;
 
 	case SO_PEERSEC:
-		return security_socket_getpeersec_stream(sock, optval, optlen, len);
+		return security_socket_getpeersec_stream(sock,
+							 optval, optlen, len);
 
 	case SO_MARK:
 		v.val = sk->sk_mark;
@@ -1528,7 +1532,7 @@ int sock_getsockopt(struct socket *sock, int level, int optname,
 		return sock_getbindtodevice(sk, optval, optlen, len);
 
 	case SO_GET_FILTER:
-		len = sk_get_filter(sk, (struct sock_filter __user *)optval, len);
+		len = sk_get_filter(sk, optval, len);
 		if (len < 0)
 			return len;
 
@@ -1575,7 +1579,7 @@ int sock_getsockopt(struct socket *sock, int level, int optname,
 		sk_get_meminfo(sk, meminfo);
 
 		len = min_t(unsigned int, len, sizeof(meminfo));
-		if (copy_to_user(optval, &meminfo, len))
+		if (copy_to_sockptr(optval, &meminfo, len))
 			return -EFAULT;
 
 		goto lenout;
@@ -1625,14 +1629,22 @@ int sock_getsockopt(struct socket *sock, int level, int optname,
 
 	if (len > lv)
 		len = lv;
-	if (copy_to_user(optval, &v, len))
+	if (copy_to_sockptr(optval, &v, len))
 		return -EFAULT;
 lenout:
-	if (put_user(len, optlen))
+	if (copy_to_sockptr(optlen, &len, sizeof(int)))
 		return -EFAULT;
 	return 0;
 }
 
+int sock_getsockopt(struct socket *sock, int level, int optname,
+		    char __user *optval, int __user *optlen)
+{
+	return sk_getsockopt(sock->sk, level, optname,
+			     USER_SOCKPTR(optval),
+			     USER_SOCKPTR(optlen));
+}
+
 /*
  * Initialize an sk_lock.
  *
diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index b23e42efb3dff..2d53c362f309e 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -5235,19 +5235,7 @@ static int ip6_route_multipath_add(struct fib6_config *cfg,
 	err_nh = NULL;
 	list_for_each_entry(nh, &rt6_nh_list, next) {
 		err = __ip6_ins_rt(nh->fib6_info, info, extack);
-		fib6_info_release(nh->fib6_info);
-
-		if (!err) {
-			/* save reference to last route successfully inserted */
-			rt_last = nh->fib6_info;
-
-			/* save reference to first route for notification */
-			if (!rt_notif)
-				rt_notif = nh->fib6_info;
-		}
 
-		/* nh->fib6_info is used or freed at this point, reset to NULL*/
-		nh->fib6_info = NULL;
 		if (err) {
 			if (replace && nhn)
 				NL_SET_ERR_MSG_MOD(extack,
@@ -5255,6 +5243,12 @@ static int ip6_route_multipath_add(struct fib6_config *cfg,
 			err_nh = nh;
 			goto add_errout;
 		}
+		/* save reference to last route successfully inserted */
+		rt_last = nh->fib6_info;
+
+		/* save reference to first route for notification */
+		if (!rt_notif)
+			rt_notif = nh->fib6_info;
 
 		/* Because each route is added like a single route we remove
 		 * these flags after the first nexthop: if there is a collision,
@@ -5315,8 +5309,7 @@ static int ip6_route_multipath_add(struct fib6_config *cfg,
 
 cleanup:
 	list_for_each_entry_safe(nh, nh_safe, &rt6_nh_list, next) {
-		if (nh->fib6_info)
-			fib6_info_release(nh->fib6_info);
+		fib6_info_release(nh->fib6_info);
 		list_del(&nh->next);
 		kfree(nh);
 	}
diff --git a/net/netfilter/nf_conntrack_h323_asn1.c b/net/netfilter/nf_conntrack_h323_asn1.c
index e697a824b0018..540d97715bd23 100644
--- a/net/netfilter/nf_conntrack_h323_asn1.c
+++ b/net/netfilter/nf_conntrack_h323_asn1.c
@@ -533,6 +533,8 @@ static int decode_seq(struct bitstr *bs, const struct field_t *f,
 	/* Get fields bitmap */
 	if (nf_h323_error_boundary(bs, 0, f->sz))
 		return H323_ERROR_BOUND;
+	if (f->sz > 32)
+		return H323_ERROR_RANGE;
 	bmp = get_bitmap(bs, f->sz);
 	if (base)
 		*(unsigned int *)base = bmp;
@@ -589,6 +591,8 @@ static int decode_seq(struct bitstr *bs, const struct field_t *f,
 	bmp2_len = get_bits(bs, 7) + 1;
 	if (nf_h323_error_boundary(bs, 0, bmp2_len))
 		return H323_ERROR_BOUND;
+	if (bmp2_len > 32)
+		return H323_ERROR_RANGE;
 	bmp2 = get_bitmap(bs, bmp2_len);
 	bmp |= bmp2 >> f->sz;
 	if (base)
diff --git a/net/netfilter/nft_ct.c b/net/netfilter/nft_ct.c
index 2b15dbbca98b3..2a8dfa68f6e20 100644
--- a/net/netfilter/nft_ct.c
+++ b/net/netfilter/nft_ct.c
@@ -1188,14 +1188,13 @@ static int nft_ct_expect_obj_init(const struct nft_ctx *ctx,
 	switch (priv->l3num) {
 	case NFPROTO_IPV4:
 	case NFPROTO_IPV6:
-		if (priv->l3num != ctx->family)
-			return -EINVAL;
+		if (priv->l3num == ctx->family || ctx->family == NFPROTO_INET)
+			break;
 
-		fallthrough;
-	case NFPROTO_INET:
-		break;
+		return -EINVAL;
+	case NFPROTO_INET: /* tuple.src.l3num supports NFPROTO_IPV4/6 only */
 	default:
-		return -EOPNOTSUPP;
+		return -EAFNOSUPPORT;
 	}
 
 	priv->l4proto = nla_get_u8(tb[NFTA_CT_EXPECT_L4PROTO]);
diff --git a/net/netrom/af_netrom.c b/net/netrom/af_netrom.c
index 24747163122bb..37d0bf6cab456 100644
--- a/net/netrom/af_netrom.c
+++ b/net/netrom/af_netrom.c
@@ -453,16 +453,16 @@ static int nr_create(struct net *net, struct socket *sock, int protocol,
 	nr_init_timers(sk);
 
 	nr->t1     =
-		msecs_to_jiffies(sysctl_netrom_transport_timeout);
+		msecs_to_jiffies(READ_ONCE(sysctl_netrom_transport_timeout));
 	nr->t2     =
-		msecs_to_jiffies(sysctl_netrom_transport_acknowledge_delay);
+		msecs_to_jiffies(READ_ONCE(sysctl_netrom_transport_acknowledge_delay));
 	nr->n2     =
-		msecs_to_jiffies(sysctl_netrom_transport_maximum_tries);
+		msecs_to_jiffies(READ_ONCE(sysctl_netrom_transport_maximum_tries));
 	nr->t4     =
-		msecs_to_jiffies(sysctl_netrom_transport_busy_delay);
+		msecs_to_jiffies(READ_ONCE(sysctl_netrom_transport_busy_delay));
 	nr->idle   =
-		msecs_to_jiffies(sysctl_netrom_transport_no_activity_timeout);
-	nr->window = sysctl_netrom_transport_requested_window_size;
+		msecs_to_jiffies(READ_ONCE(sysctl_netrom_transport_no_activity_timeout));
+	nr->window = READ_ONCE(sysctl_netrom_transport_requested_window_size);
 
 	nr->bpqext = 1;
 	nr->state  = NR_STATE_0;
@@ -954,7 +954,7 @@ int nr_rx_frame(struct sk_buff *skb, struct net_device *dev)
 		 * G8PZT's Xrouter which is sending packets with command type 7
 		 * as an extension of the protocol.
 		 */
-		if (sysctl_netrom_reset_circuit &&
+		if (READ_ONCE(sysctl_netrom_reset_circuit) &&
 		    (frametype != NR_RESET || flags != 0))
 			nr_transmit_reset(skb, 1);
 
diff --git a/net/netrom/nr_dev.c b/net/netrom/nr_dev.c
index 29e418c8c6c30..4caee8754b794 100644
--- a/net/netrom/nr_dev.c
+++ b/net/netrom/nr_dev.c
@@ -81,7 +81,7 @@ static int nr_header(struct sk_buff *skb, struct net_device *dev,
 	buff[6] |= AX25_SSSID_SPARE;
 	buff    += AX25_ADDR_LEN;
 
-	*buff++ = sysctl_netrom_network_ttl_initialiser;
+	*buff++ = READ_ONCE(sysctl_netrom_network_ttl_initialiser);
 
 	*buff++ = NR_PROTO_IP;
 	*buff++ = NR_PROTO_IP;
diff --git a/net/netrom/nr_in.c b/net/netrom/nr_in.c
index 69e58906c32b1..034f79d11ae11 100644
--- a/net/netrom/nr_in.c
+++ b/net/netrom/nr_in.c
@@ -97,7 +97,7 @@ static int nr_state1_machine(struct sock *sk, struct sk_buff *skb,
 		break;
 
 	case NR_RESET:
-		if (sysctl_netrom_reset_circuit)
+		if (READ_ONCE(sysctl_netrom_reset_circuit))
 			nr_disconnect(sk, ECONNRESET);
 		break;
 
@@ -128,7 +128,7 @@ static int nr_state2_machine(struct sock *sk, struct sk_buff *skb,
 		break;
 
 	case NR_RESET:
-		if (sysctl_netrom_reset_circuit)
+		if (READ_ONCE(sysctl_netrom_reset_circuit))
 			nr_disconnect(sk, ECONNRESET);
 		break;
 
@@ -263,7 +263,7 @@ static int nr_state3_machine(struct sock *sk, struct sk_buff *skb, int frametype
 		break;
 
 	case NR_RESET:
-		if (sysctl_netrom_reset_circuit)
+		if (READ_ONCE(sysctl_netrom_reset_circuit))
 			nr_disconnect(sk, ECONNRESET);
 		break;
 
diff --git a/net/netrom/nr_out.c b/net/netrom/nr_out.c
index 44929657f5b71..5e531394a724b 100644
--- a/net/netrom/nr_out.c
+++ b/net/netrom/nr_out.c
@@ -204,7 +204,7 @@ void nr_transmit_buffer(struct sock *sk, struct sk_buff *skb)
 	dptr[6] |= AX25_SSSID_SPARE;
 	dptr += AX25_ADDR_LEN;
 
-	*dptr++ = sysctl_netrom_network_ttl_initialiser;
+	*dptr++ = READ_ONCE(sysctl_netrom_network_ttl_initialiser);
 
 	if (!nr_route_frame(skb, NULL)) {
 		kfree_skb(skb);
diff --git a/net/netrom/nr_route.c b/net/netrom/nr_route.c
index 78da5eab252a0..895702337c92e 100644
--- a/net/netrom/nr_route.c
+++ b/net/netrom/nr_route.c
@@ -153,7 +153,7 @@ static int __must_check nr_add_node(ax25_address *nr, const char *mnemonic,
 		nr_neigh->digipeat = NULL;
 		nr_neigh->ax25     = NULL;
 		nr_neigh->dev      = dev;
-		nr_neigh->quality  = sysctl_netrom_default_path_quality;
+		nr_neigh->quality  = READ_ONCE(sysctl_netrom_default_path_quality);
 		nr_neigh->locked   = 0;
 		nr_neigh->count    = 0;
 		nr_neigh->number   = nr_neigh_no++;
@@ -725,7 +725,7 @@ void nr_link_failed(ax25_cb *ax25, int reason)
 	nr_neigh->ax25 = NULL;
 	ax25_cb_put(ax25);
 
-	if (++nr_neigh->failed < sysctl_netrom_link_fails_count) {
+	if (++nr_neigh->failed < READ_ONCE(sysctl_netrom_link_fails_count)) {
 		nr_neigh_put(nr_neigh);
 		return;
 	}
@@ -763,7 +763,7 @@ int nr_route_frame(struct sk_buff *skb, ax25_cb *ax25)
 	if (ax25 != NULL) {
 		ret = nr_add_node(nr_src, "", &ax25->dest_addr, ax25->digipeat,
 				  ax25->ax25_dev->dev, 0,
-				  sysctl_netrom_obsolescence_count_initialiser);
+				  READ_ONCE(sysctl_netrom_obsolescence_count_initialiser));
 		if (ret)
 			return ret;
 	}
@@ -777,7 +777,7 @@ int nr_route_frame(struct sk_buff *skb, ax25_cb *ax25)
 		return ret;
 	}
 
-	if (!sysctl_netrom_routing_control && ax25 != NULL)
+	if (!READ_ONCE(sysctl_netrom_routing_control) && ax25 != NULL)
 		return 0;
 
 	/* Its Time-To-Live has expired */
diff --git a/net/netrom/nr_subr.c b/net/netrom/nr_subr.c
index e2d2af924cff4..c3bbd5880850b 100644
--- a/net/netrom/nr_subr.c
+++ b/net/netrom/nr_subr.c
@@ -182,7 +182,8 @@ void nr_write_internal(struct sock *sk, int frametype)
 		*dptr++ = nr->my_id;
 		*dptr++ = frametype;
 		*dptr++ = nr->window;
-		if (nr->bpqext) *dptr++ = sysctl_netrom_network_ttl_initialiser;
+		if (nr->bpqext)
+			*dptr++ = READ_ONCE(sysctl_netrom_network_ttl_initialiser);
 		break;
 
 	case NR_DISCREQ:
@@ -236,7 +237,7 @@ void __nr_transmit_reply(struct sk_buff *skb, int mine, unsigned char cmdflags)
 	dptr[6] |= AX25_SSSID_SPARE;
 	dptr += AX25_ADDR_LEN;
 
-	*dptr++ = sysctl_netrom_network_ttl_initialiser;
+	*dptr++ = READ_ONCE(sysctl_netrom_network_ttl_initialiser);
 
 	if (mine) {
 		*dptr++ = 0;
diff --git a/net/rds/rdma.c b/net/rds/rdma.c
index 6f1a50d50d06d..c29c7a59f2053 100644
--- a/net/rds/rdma.c
+++ b/net/rds/rdma.c
@@ -301,6 +301,9 @@ static int __rds_rdma_map(struct rds_sock *rs, struct rds_get_mr_args *args,
 			kfree(sg);
 		}
 		ret = PTR_ERR(trans_private);
+		/* Trigger connection so that its ready for the next retry */
+		if (ret == -ENODEV)
+			rds_conn_connect_if_down(cp->cp_conn);
 		goto out;
 	}
 
diff --git a/net/rds/send.c b/net/rds/send.c
index 985d0b7713acc..65eeb82cb5de5 100644
--- a/net/rds/send.c
+++ b/net/rds/send.c
@@ -1314,12 +1314,8 @@ int rds_sendmsg(struct socket *sock, struct msghdr *msg, size_t payload_len)
 
 	/* Parse any control messages the user may have included. */
 	ret = rds_cmsg_send(rs, rm, msg, &allocated_mr, &vct);
-	if (ret) {
-		/* Trigger connection so that its ready for the next retry */
-		if (ret ==  -EAGAIN)
-			rds_conn_connect_if_down(conn);
+	if (ret)
 		goto out;
-	}
 
 	if (rm->rdma.op_active && !conn->c_trans->xmit_rdma) {
 		printk_ratelimited(KERN_NOTICE "rdma_op %p conn xmit_rdma %p\n",
diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index 585edcc6814d2..052f1b920e43f 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -1070,11 +1070,10 @@ static struct aa_label *sk_peer_label(struct sock *sk)
  * Note: for tcp only valid if using ipsec or cipso on lan
  */
 static int apparmor_socket_getpeersec_stream(struct socket *sock,
-					     char __user *optval,
-					     int __user *optlen,
+					     sockptr_t optval, sockptr_t optlen,
 					     unsigned int len)
 {
-	char *name;
+	char *name = NULL;
 	int slen, error = 0;
 	struct aa_label *label;
 	struct aa_label *peer;
@@ -1091,23 +1090,21 @@ static int apparmor_socket_getpeersec_stream(struct socket *sock,
 	/* don't include terminating \0 in slen, it breaks some apps */
 	if (slen < 0) {
 		error = -ENOMEM;
-	} else {
-		if (slen > len) {
-			error = -ERANGE;
-		} else if (copy_to_user(optval, name, slen)) {
-			error = -EFAULT;
-			goto out;
-		}
-		if (put_user(slen, optlen))
-			error = -EFAULT;
-out:
-		kfree(name);
-
+		goto done;
+	}
+	if (slen > len) {
+		error = -ERANGE;
+		goto done_len;
 	}
 
+	if (copy_to_sockptr(optval, name, slen))
+		error = -EFAULT;
+done_len:
+	if (copy_to_sockptr(optlen, &slen, sizeof(slen)))
+		error = -EFAULT;
 done:
 	end_current_label_crit_section(label);
-
+	kfree(name);
 	return error;
 }
 
diff --git a/security/security.c b/security/security.c
index 269c3965393f4..0bbcb100ba8e9 100644
--- a/security/security.c
+++ b/security/security.c
@@ -2224,17 +2224,40 @@ int security_sock_rcv_skb(struct sock *sk, struct sk_buff *skb)
 }
 EXPORT_SYMBOL(security_sock_rcv_skb);
 
-int security_socket_getpeersec_stream(struct socket *sock, char __user *optval,
-				      int __user *optlen, unsigned len)
+int security_socket_getpeersec_stream(struct socket *sock, sockptr_t optval,
+				      sockptr_t optlen, unsigned int len)
 {
-	return call_int_hook(socket_getpeersec_stream, -ENOPROTOOPT, sock,
-				optval, optlen, len);
+	struct security_hook_list *hp;
+	int rc;
+
+	/*
+	 * Only one module will provide a security context.
+	 */
+	hlist_for_each_entry(hp, &security_hook_heads.socket_getpeersec_stream,
+			     list) {
+		rc = hp->hook.socket_getpeersec_stream(sock, optval, optlen,
+						       len);
+		if (rc != LSM_RET_DEFAULT(socket_getpeersec_stream))
+			return rc;
+	}
+	return LSM_RET_DEFAULT(socket_getpeersec_stream);
 }
 
 int security_socket_getpeersec_dgram(struct socket *sock, struct sk_buff *skb, u32 *secid)
 {
-	return call_int_hook(socket_getpeersec_dgram, -ENOPROTOOPT, sock,
-			     skb, secid);
+	struct security_hook_list *hp;
+	int rc;
+
+	/*
+	 * Only one module will provide a security context.
+	 */
+	hlist_for_each_entry(hp, &security_hook_heads.socket_getpeersec_dgram,
+			     list) {
+		rc = hp->hook.socket_getpeersec_dgram(sock, skb, secid);
+		if (rc != LSM_RET_DEFAULT(socket_getpeersec_dgram))
+			return rc;
+	}
+	return LSM_RET_DEFAULT(socket_getpeersec_dgram);
 }
 EXPORT_SYMBOL(security_socket_getpeersec_dgram);
 
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 50d3ddfe15fd1..46c00a68bb4bd 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -5110,11 +5110,12 @@ static int selinux_socket_sock_rcv_skb(struct sock *sk, struct sk_buff *skb)
 	return err;
 }
 
-static int selinux_socket_getpeersec_stream(struct socket *sock, char __user *optval,
-					    int __user *optlen, unsigned len)
+static int selinux_socket_getpeersec_stream(struct socket *sock,
+					    sockptr_t optval, sockptr_t optlen,
+					    unsigned int len)
 {
 	int err = 0;
-	char *scontext;
+	char *scontext = NULL;
 	u32 scontext_len;
 	struct sk_security_struct *sksec = sock->sk->sk_security;
 	u32 peer_sid = SECSID_NULL;
@@ -5130,17 +5131,15 @@ static int selinux_socket_getpeersec_stream(struct socket *sock, char __user *op
 				      &scontext_len);
 	if (err)
 		return err;
-
 	if (scontext_len > len) {
 		err = -ERANGE;
 		goto out_len;
 	}
 
-	if (copy_to_user(optval, scontext, scontext_len))
+	if (copy_to_sockptr(optval, scontext, scontext_len))
 		err = -EFAULT;
-
 out_len:
-	if (put_user(scontext_len, optlen))
+	if (copy_to_sockptr(optlen, &scontext_len, sizeof(scontext_len)))
 		err = -EFAULT;
 	kfree(scontext);
 	return err;
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index e1669759403a6..5388f143eecd8 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -4022,12 +4022,12 @@ static int smack_socket_sock_rcv_skb(struct sock *sk, struct sk_buff *skb)
  * returns zero on success, an error code otherwise
  */
 static int smack_socket_getpeersec_stream(struct socket *sock,
-					  char __user *optval,
-					  int __user *optlen, unsigned len)
+					  sockptr_t optval, sockptr_t optlen,
+					  unsigned int len)
 {
 	struct socket_smack *ssp;
 	char *rcp = "";
-	int slen = 1;
+	u32 slen = 1;
 	int rc = 0;
 
 	ssp = sock->sk->sk_security;
@@ -4035,15 +4035,16 @@ static int smack_socket_getpeersec_stream(struct socket *sock,
 		rcp = ssp->smk_packet->smk_known;
 		slen = strlen(rcp) + 1;
 	}
-
-	if (slen > len)
+	if (slen > len) {
 		rc = -ERANGE;
-	else if (copy_to_user(optval, rcp, slen) != 0)
-		rc = -EFAULT;
+		goto out_len;
+	}
 
-	if (put_user(slen, optlen) != 0)
+	if (copy_to_sockptr(optval, rcp, slen))
+		rc = -EFAULT;
+out_len:
+	if (copy_to_sockptr(optlen, &slen, sizeof(slen)))
 		rc = -EFAULT;
-
 	return rc;
 }
 
diff --git a/tools/testing/selftests/vm/charge_reserved_hugetlb.sh b/tools/testing/selftests/vm/charge_reserved_hugetlb.sh
index 7536ff2f890a1..d0107f8ae6213 100644
--- a/tools/testing/selftests/vm/charge_reserved_hugetlb.sh
+++ b/tools/testing/selftests/vm/charge_reserved_hugetlb.sh
@@ -1,4 +1,4 @@
-#!/bin/sh
+#!/bin/bash
 # SPDX-License-Identifier: GPL-2.0
 
 set -e
diff --git a/tools/testing/selftests/vm/map_hugetlb.c b/tools/testing/selftests/vm/map_hugetlb.c
index 312889edb84ab..c65c55b7a789f 100644
--- a/tools/testing/selftests/vm/map_hugetlb.c
+++ b/tools/testing/selftests/vm/map_hugetlb.c
@@ -15,6 +15,7 @@
 #include <unistd.h>
 #include <sys/mman.h>
 #include <fcntl.h>
+#include "vm_util.h"
 
 #define LENGTH (256UL*1024*1024)
 #define PROTECTION (PROT_READ | PROT_WRITE)
@@ -70,10 +71,16 @@ int main(int argc, char **argv)
 {
 	void *addr;
 	int ret;
+	size_t hugepage_size;
 	size_t length = LENGTH;
 	int flags = FLAGS;
 	int shift = 0;
 
+	hugepage_size = default_huge_page_size();
+	/* munmap with fail if the length is not page aligned */
+	if (hugepage_size > length)
+		length = hugepage_size;
+
 	if (argc > 1)
 		length = atol(argv[1]) << 20;
 	if (argc > 2) {
diff --git a/tools/testing/selftests/vm/write_hugetlb_memory.sh b/tools/testing/selftests/vm/write_hugetlb_memory.sh
index 70a02301f4c27..3d2d2eb9d6fff 100644
--- a/tools/testing/selftests/vm/write_hugetlb_memory.sh
+++ b/tools/testing/selftests/vm/write_hugetlb_memory.sh
@@ -1,4 +1,4 @@
-#!/bin/sh
+#!/bin/bash
 # SPDX-License-Identifier: GPL-2.0
 
 set -e

