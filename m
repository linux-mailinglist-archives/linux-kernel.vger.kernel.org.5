Return-Path: <linux-kernel+bounces-104829-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 36D6287D43E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 20:02:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2725286894
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 19:02:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DE2B50A7E;
	Fri, 15 Mar 2024 19:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VIYPrNcJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65ECA4EB22;
	Fri, 15 Mar 2024 19:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710529315; cv=none; b=WFrntDKfvWo8mmoumzsgcyH/lsmF3HE+yZXvLxIzqkI0+9+3FZrdMsZi851uIc316zCgh9W9dr7Znc+ZquOLGLN/4QPdcmw1qoqSE7DbQfJsLrfLPpQ1ndpOXxGG9Y8MdVRAc1aYluxYgMxMalHtf+XAOQ14aDf2fISvkSWemp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710529315; c=relaxed/simple;
	bh=33yoI9jsk8Bor7MIZXLAGd9CIvKup+V7GmEZhGJrEzE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GJaRjNImtvKly4hCigJzVInehsHzf6bmlyhUS1WV83gQgQLZi9gdmhci1/4VTW6XEeN5JxTQeKLsJyG35atmVEgyEkINK/xiokaVtPnfoo6/8lY94O0odK4TKDbLJpEYU8lThUNIeFb/EQjXKWiqkYfpPJcfadsGXyjJY+0d6EA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VIYPrNcJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0134C433F1;
	Fri, 15 Mar 2024 19:01:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710529314;
	bh=33yoI9jsk8Bor7MIZXLAGd9CIvKup+V7GmEZhGJrEzE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VIYPrNcJCvpZOAdfyfLZE0xBVvqTKjMF0l5qJzb4zQ8NGz+PbgLE2zkV+F/+Hb1Cl
	 FnQvQ+gPB+sTuEdwCzj3UUvRrrRpqGGT/lXb+iqSTaGymj6UfPi6WeHJZ/r75a8FJy
	 A/npXKZTyRPpJSksGbbvwQcp3enXFII1hrPCBVqabBpfHoS7qijT2LB7sAacMEb6IK
	 FMUOtBEL6/m7Q1YPVnAZiwL+f8Q0bCZzyd8WzfqBXqWFLNprbxaS+6ZI6iN4wF8P14
	 GH1y65pSDdCL31E/5wC3RCogFr+R4DNHTBMAQiMoM5knT4bbtIIa5cc/s7OWFinHv4
	 iZ2tq9g0AIsAA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	gregkh@linuxfoundation.org
Subject: Re: Linux 5.15.152
Date: Fri, 15 Mar 2024 15:01:49 -0400
Message-ID: <20240315190151.1842554-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240315190151.1842554-1-sashal@kernel.org>
References: <20240315190151.1842554-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

diff --git a/Makefile b/Makefile
index bb73dba0e5052..918a73d3976f9 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 5
 PATCHLEVEL = 15
-SUBLEVEL = 151
+SUBLEVEL = 152
 EXTRAVERSION =
 NAME = Trick or Treat
 
diff --git a/drivers/base/regmap/internal.h b/drivers/base/regmap/internal.h
index b1905916f7af8..93e028445dade 100644
--- a/drivers/base/regmap/internal.h
+++ b/drivers/base/regmap/internal.h
@@ -108,6 +108,10 @@ struct regmap {
 	int (*reg_write)(void *context, unsigned int reg, unsigned int val);
 	int (*reg_update_bits)(void *context, unsigned int reg,
 			       unsigned int mask, unsigned int val);
+	/* Bulk read/write */
+	int (*read)(void *context, const void *reg_buf, size_t reg_size,
+		    void *val_buf, size_t val_size);
+	int (*write)(void *context, const void *data, size_t count);
 
 	bool defer_caching;
 
diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
index 7621b54975b57..6adb345866610 100644
--- a/drivers/base/regmap/regmap.c
+++ b/drivers/base/regmap/regmap.c
@@ -835,12 +835,15 @@ struct regmap *__regmap_init(struct device *dev,
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
@@ -874,9 +877,19 @@ struct regmap *__regmap_init(struct device *dev,
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
@@ -890,10 +903,13 @@ struct regmap *__regmap_init(struct device *dev,
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
@@ -1667,8 +1683,6 @@ static int _regmap_raw_write_impl(struct regmap *map, unsigned int reg,
 	size_t len;
 	int i;
 
-	WARN_ON(!map->bus);
-
 	/* Check for unwritable or noinc registers in range
 	 * before we start
 	 */
@@ -1750,7 +1764,7 @@ static int _regmap_raw_write_impl(struct regmap *map, unsigned int reg,
 		val = work_val;
 	}
 
-	if (map->async && map->bus->async_write) {
+	if (map->async && map->bus && map->bus->async_write) {
 		struct regmap_async *async;
 
 		trace_regmap_async_write_start(map, reg, val_len);
@@ -1818,10 +1832,10 @@ static int _regmap_raw_write_impl(struct regmap *map, unsigned int reg,
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
@@ -1840,7 +1854,7 @@ static int _regmap_raw_write_impl(struct regmap *map, unsigned int reg,
 		memcpy(buf, map->work_buf, map->format.reg_bytes);
 		memcpy(buf + map->format.reg_bytes + map->format.pad_bytes,
 		       val, val_len);
-		ret = map->bus->write(map->bus_context, buf, len);
+		ret = map->write(map->bus_context, buf, len);
 
 		kfree(buf);
 	} else if (ret != 0 && !map->cache_bypass && map->format.parse_val) {
@@ -1897,7 +1911,7 @@ static int _regmap_bus_formatted_write(void *context, unsigned int reg,
 	struct regmap_range_node *range;
 	struct regmap *map = context;
 
-	WARN_ON(!map->bus || !map->format.format_write);
+	WARN_ON(!map->format.format_write);
 
 	range = _regmap_range_lookup(map, reg);
 	if (range) {
@@ -1910,8 +1924,7 @@ static int _regmap_bus_formatted_write(void *context, unsigned int reg,
 
 	trace_regmap_hw_write_start(map, reg, 1);
 
-	ret = map->bus->write(map->bus_context, map->work_buf,
-			      map->format.buf_size);
+	ret = map->write(map->bus_context, map->work_buf, map->format.buf_size);
 
 	trace_regmap_hw_write_done(map, reg, 1);
 
@@ -1931,7 +1944,7 @@ static int _regmap_bus_raw_write(void *context, unsigned int reg,
 {
 	struct regmap *map = context;
 
-	WARN_ON(!map->bus || !map->format.format_val);
+	WARN_ON(!map->format.format_val);
 
 	map->format.format_val(map->work_buf + map->format.reg_bytes
 			       + map->format.pad_bytes, val, 0);
@@ -1945,7 +1958,7 @@ static int _regmap_bus_raw_write(void *context, unsigned int reg,
 
 static inline void *_regmap_map_get_context(struct regmap *map)
 {
-	return (map->bus) ? map : map->bus_context;
+	return (map->bus || (!map->bus && map->read)) ? map : map->bus_context;
 }
 
 int _regmap_write(struct regmap *map, unsigned int reg,
@@ -2355,7 +2368,7 @@ static int _regmap_raw_multi_reg_write(struct regmap *map,
 	u8 = buf;
 	*u8 |= map->write_flag_mask;
 
-	ret = map->bus->write(map->bus_context, buf, len);
+	ret = map->write(map->bus_context, buf, len);
 
 	kfree(buf);
 
@@ -2661,9 +2674,7 @@ static int _regmap_raw_read(struct regmap *map, unsigned int reg, void *val,
 	struct regmap_range_node *range;
 	int ret;
 
-	WARN_ON(!map->bus);
-
-	if (!map->bus || !map->bus->read)
+	if (!map->read)
 		return -EINVAL;
 
 	range = _regmap_range_lookup(map, reg);
@@ -2679,9 +2690,9 @@ static int _regmap_raw_read(struct regmap *map, unsigned int reg, void *val,
 				      map->read_flag_mask);
 	trace_regmap_hw_read_start(map, reg, val_len / map->format.val_bytes);
 
-	ret = map->bus->read(map->bus_context, map->work_buf,
-			     map->format.reg_bytes + map->format.pad_bytes,
-			     val, val_len);
+	ret = map->read(map->bus_context, map->work_buf,
+			map->format.reg_bytes + map->format.pad_bytes,
+			val, val_len);
 
 	trace_regmap_hw_read_done(map, reg, val_len / map->format.val_bytes);
 
@@ -2792,8 +2803,6 @@ int regmap_raw_read(struct regmap *map, unsigned int reg, void *val,
 	unsigned int v;
 	int ret, i;
 
-	if (!map->bus)
-		return -EINVAL;
 	if (val_len % map->format.val_bytes)
 		return -EINVAL;
 	if (!IS_ALIGNED(reg, map->reg_stride))
@@ -2808,7 +2817,7 @@ int regmap_raw_read(struct regmap *map, unsigned int reg, void *val,
 		size_t chunk_count, chunk_bytes;
 		size_t chunk_regs = val_count;
 
-		if (!map->bus->read) {
+		if (!map->read) {
 			ret = -ENOTSUPP;
 			goto out;
 		}
@@ -2868,7 +2877,7 @@ EXPORT_SYMBOL_GPL(regmap_raw_read);
  * @val: Pointer to data buffer
  * @val_len: Length of output buffer in bytes.
  *
- * The regmap API usually assumes that bulk bus read operations will read a
+ * The regmap API usually assumes that bulk read operations will read a
  * range of registers. Some devices have certain registers for which a read
  * operation read will read from an internal FIFO.
  *
@@ -2886,10 +2895,6 @@ int regmap_noinc_read(struct regmap *map, unsigned int reg,
 	size_t read_len;
 	int ret;
 
-	if (!map->bus)
-		return -EINVAL;
-	if (!map->bus->read)
-		return -ENOTSUPP;
 	if (val_len % map->format.val_bytes)
 		return -EINVAL;
 	if (!IS_ALIGNED(reg, map->reg_stride))
@@ -3003,7 +3008,7 @@ int regmap_bulk_read(struct regmap *map, unsigned int reg, void *val,
 	if (val_count == 0)
 		return -EINVAL;
 
-	if (map->bus && map->format.parse_inplace && (vol || map->cache_type == REGCACHE_NONE)) {
+	if (map->format.parse_inplace && (vol || map->cache_type == REGCACHE_NONE)) {
 		ret = regmap_raw_read(map, reg, val, val_bytes * val_count);
 		if (ret != 0)
 			return ret;
diff --git a/drivers/gpu/drm/amd/amdgpu/cik_ih.c b/drivers/gpu/drm/amd/amdgpu/cik_ih.c
index df385ffc97683..6578ca1b90afa 100644
--- a/drivers/gpu/drm/amd/amdgpu/cik_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/cik_ih.c
@@ -204,6 +204,12 @@ static u32 cik_ih_get_wptr(struct amdgpu_device *adev,
 		tmp = RREG32(mmIH_RB_CNTL);
 		tmp |= IH_RB_CNTL__WPTR_OVERFLOW_CLEAR_MASK;
 		WREG32(mmIH_RB_CNTL, tmp);
+
+		/* Unset the CLEAR_OVERFLOW bit immediately so new overflows
+		 * can be detected.
+		 */
+		tmp &= ~IH_RB_CNTL__WPTR_OVERFLOW_CLEAR_MASK;
+		WREG32(mmIH_RB_CNTL, tmp);
 	}
 	return (wptr & ih->ptr_mask);
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/cz_ih.c b/drivers/gpu/drm/amd/amdgpu/cz_ih.c
index b8c47e0cf37ad..c19681492efa7 100644
--- a/drivers/gpu/drm/amd/amdgpu/cz_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/cz_ih.c
@@ -216,6 +216,11 @@ static u32 cz_ih_get_wptr(struct amdgpu_device *adev,
 	tmp = REG_SET_FIELD(tmp, IH_RB_CNTL, WPTR_OVERFLOW_CLEAR, 1);
 	WREG32(mmIH_RB_CNTL, tmp);
 
+	/* Unset the CLEAR_OVERFLOW bit immediately so new overflows
+	 * can be detected.
+	 */
+	tmp = REG_SET_FIELD(tmp, IH_RB_CNTL, WPTR_OVERFLOW_CLEAR, 0);
+	WREG32(mmIH_RB_CNTL, tmp);
 
 out:
 	return (wptr & ih->ptr_mask);
diff --git a/drivers/gpu/drm/amd/amdgpu/iceland_ih.c b/drivers/gpu/drm/amd/amdgpu/iceland_ih.c
index ddfe4eaeea05e..77aacc242d439 100644
--- a/drivers/gpu/drm/amd/amdgpu/iceland_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/iceland_ih.c
@@ -215,6 +215,11 @@ static u32 iceland_ih_get_wptr(struct amdgpu_device *adev,
 	tmp = REG_SET_FIELD(tmp, IH_RB_CNTL, WPTR_OVERFLOW_CLEAR, 1);
 	WREG32(mmIH_RB_CNTL, tmp);
 
+	/* Unset the CLEAR_OVERFLOW bit immediately so new overflows
+	 * can be detected.
+	 */
+	tmp = REG_SET_FIELD(tmp, IH_RB_CNTL, WPTR_OVERFLOW_CLEAR, 0);
+	WREG32(mmIH_RB_CNTL, tmp);
 
 out:
 	return (wptr & ih->ptr_mask);
diff --git a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
index 5300116228013..6aa1884147c4c 100644
--- a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
@@ -447,6 +447,12 @@ static u32 navi10_ih_get_wptr(struct amdgpu_device *adev,
 	tmp = RREG32_NO_KIQ(ih_regs->ih_rb_cntl);
 	tmp = REG_SET_FIELD(tmp, IH_RB_CNTL, WPTR_OVERFLOW_CLEAR, 1);
 	WREG32_NO_KIQ(ih_regs->ih_rb_cntl, tmp);
+
+	/* Unset the CLEAR_OVERFLOW bit immediately so new overflows
+	 * can be detected.
+	 */
+	tmp = REG_SET_FIELD(tmp, IH_RB_CNTL, WPTR_OVERFLOW_CLEAR, 0);
+	WREG32_NO_KIQ(ih_regs->ih_rb_cntl, tmp);
 out:
 	return (wptr & ih->ptr_mask);
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/si_ih.c b/drivers/gpu/drm/amd/amdgpu/si_ih.c
index 9a24f17a57502..cada9f300a7f5 100644
--- a/drivers/gpu/drm/amd/amdgpu/si_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/si_ih.c
@@ -119,6 +119,12 @@ static u32 si_ih_get_wptr(struct amdgpu_device *adev,
 		tmp = RREG32(IH_RB_CNTL);
 		tmp |= IH_RB_CNTL__WPTR_OVERFLOW_CLEAR_MASK;
 		WREG32(IH_RB_CNTL, tmp);
+
+		/* Unset the CLEAR_OVERFLOW bit immediately so new overflows
+		 * can be detected.
+		 */
+		tmp &= ~IH_RB_CNTL__WPTR_OVERFLOW_CLEAR_MASK;
+		WREG32(IH_RB_CNTL, tmp);
 	}
 	return (wptr & ih->ptr_mask);
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/tonga_ih.c b/drivers/gpu/drm/amd/amdgpu/tonga_ih.c
index b08905d1c00f0..07a5d95be07f5 100644
--- a/drivers/gpu/drm/amd/amdgpu/tonga_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/tonga_ih.c
@@ -219,6 +219,12 @@ static u32 tonga_ih_get_wptr(struct amdgpu_device *adev,
 	tmp = REG_SET_FIELD(tmp, IH_RB_CNTL, WPTR_OVERFLOW_CLEAR, 1);
 	WREG32(mmIH_RB_CNTL, tmp);
 
+	/* Unset the CLEAR_OVERFLOW bit immediately so new overflows
+	 * can be detected.
+	 */
+	tmp = REG_SET_FIELD(tmp, IH_RB_CNTL, WPTR_OVERFLOW_CLEAR, 0);
+	WREG32(mmIH_RB_CNTL, tmp);
+
 out:
 	return (wptr & ih->ptr_mask);
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/vega10_ih.c b/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
index 73728fa859970..e0524197f1b3d 100644
--- a/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
@@ -371,6 +371,12 @@ static u32 vega10_ih_get_wptr(struct amdgpu_device *adev,
 	tmp = REG_SET_FIELD(tmp, IH_RB_CNTL, WPTR_OVERFLOW_CLEAR, 1);
 	WREG32_NO_KIQ(ih_regs->ih_rb_cntl, tmp);
 
+	/* Unset the CLEAR_OVERFLOW bit immediately so new overflows
+	 * can be detected.
+	 */
+	tmp = REG_SET_FIELD(tmp, IH_RB_CNTL, WPTR_OVERFLOW_CLEAR, 0);
+	WREG32_NO_KIQ(ih_regs->ih_rb_cntl, tmp);
+
 out:
 	return (wptr & ih->ptr_mask);
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/vega20_ih.c b/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
index ac34af4cb178c..87edd1908e8b9 100644
--- a/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
@@ -422,6 +422,12 @@ static u32 vega20_ih_get_wptr(struct amdgpu_device *adev,
 	tmp = REG_SET_FIELD(tmp, IH_RB_CNTL, WPTR_OVERFLOW_CLEAR, 1);
 	WREG32_NO_KIQ(ih_regs->ih_rb_cntl, tmp);
 
+	/* Unset the CLEAR_OVERFLOW bit immediately so new overflows
+	 * can be detected.
+	 */
+	tmp = REG_SET_FIELD(tmp, IH_RB_CNTL, WPTR_OVERFLOW_CLEAR, 0);
+	WREG32_NO_KIQ(ih_regs->ih_rb_cntl, tmp);
+
 out:
 	return (wptr & ih->ptr_mask);
 }
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/dc_fpu.c b/drivers/gpu/drm/amd/display/amdgpu_dm/dc_fpu.c
index b1bf80da3a55f..ab0c6d1910382 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/dc_fpu.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/dc_fpu.c
@@ -52,7 +52,7 @@ static DEFINE_PER_CPU(int, fpu_recursion_depth);
  * This function tells if the code is already under FPU protection or not. A
  * function that works as an API for a set of FPU operations can use this
  * function for checking if the caller invoked it after DC_FP_START(). For
- * example, take a look at dcn2x.c file.
+ * example, take a look at dcn20_fpu.c file.
  */
 inline void dc_assert_fp_enabled(void)
 {
diff --git a/drivers/gpu/drm/amd/display/dc/Makefile b/drivers/gpu/drm/amd/display/dc/Makefile
index 943fcb164876c..d82574f379119 100644
--- a/drivers/gpu/drm/amd/display/dc/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/Makefile
@@ -23,12 +23,12 @@
 # Makefile for Display Core (dc) component.
 #
 
-DC_LIBS = basics bios calcs clk_mgr dce gpio irq virtual
+DC_LIBS = basics bios clk_mgr dce dml gpio irq virtual
 
 ifdef CONFIG_DRM_AMD_DC_DCN
 DC_LIBS += dcn20
 DC_LIBS += dsc
-DC_LIBS += dcn10 dml
+DC_LIBS += dcn10
 DC_LIBS += dcn21
 DC_LIBS += dcn30
 DC_LIBS += dcn301
diff --git a/drivers/gpu/drm/amd/display/dc/calcs/Makefile b/drivers/gpu/drm/amd/display/dc/calcs/Makefile
deleted file mode 100644
index f3c00f479e1cb..0000000000000
--- a/drivers/gpu/drm/amd/display/dc/calcs/Makefile
+++ /dev/null
@@ -1,68 +0,0 @@
-#
-# Copyright 2017 Advanced Micro Devices, Inc.
-# Copyright 2019 Raptor Engineering, LLC
-#
-# Permission is hereby granted, free of charge, to any person obtaining a
-# copy of this software and associated documentation files (the "Software"),
-# to deal in the Software without restriction, including without limitation
-# the rights to use, copy, modify, merge, publish, distribute, sublicense,
-# and/or sell copies of the Software, and to permit persons to whom the
-# Software is furnished to do so, subject to the following conditions:
-#
-# The above copyright notice and this permission notice shall be included in
-# all copies or substantial portions of the Software.
-#
-# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
-# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
-# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
-# THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
-# OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
-# ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
-# OTHER DEALINGS IN THE SOFTWARE.
-#
-#
-# Makefile for the 'calcs' sub-component of DAL.
-# It calculates Bandwidth and Watermarks values for HW programming
-#
-
-ifdef CONFIG_X86
-calcs_ccflags := -mhard-float -msse
-endif
-
-ifdef CONFIG_PPC64
-calcs_ccflags := -mhard-float -maltivec
-endif
-
-ifdef CONFIG_CC_IS_GCC
-ifeq ($(call cc-ifversion, -lt, 0701, y), y)
-IS_OLD_GCC = 1
-endif
-endif
-
-ifdef CONFIG_X86
-ifdef IS_OLD_GCC
-# Stack alignment mismatch, proceed with caution.
-# GCC < 7.1 cannot compile code using `double` and -mpreferred-stack-boundary=3
-# (8B stack alignment).
-calcs_ccflags += -mpreferred-stack-boundary=4
-else
-calcs_ccflags += -msse2
-endif
-endif
-
-CFLAGS_$(AMDDALPATH)/dc/calcs/dcn_calcs.o := $(calcs_ccflags)
-CFLAGS_$(AMDDALPATH)/dc/calcs/dcn_calc_auto.o := $(calcs_ccflags)
-CFLAGS_$(AMDDALPATH)/dc/calcs/dcn_calc_math.o := $(calcs_ccflags) -Wno-tautological-compare
-CFLAGS_REMOVE_$(AMDDALPATH)/dc/calcs/dcn_calcs.o := $(calcs_rcflags)
-CFLAGS_REMOVE_$(AMDDALPATH)/dc/calcs/dcn_calc_auto.o := $(calcs_rcflags)
-CFLAGS_REMOVE_$(AMDDALPATH)/dc/calcs/dcn_calc_math.o := $(calcs_rcflags)
-
-BW_CALCS = dce_calcs.o bw_fixed.o custom_float.o
-
-ifdef CONFIG_DRM_AMD_DC_DCN
-BW_CALCS += dcn_calcs.o dcn_calc_math.o dcn_calc_auto.o
-endif
-
-AMD_DAL_BW_CALCS = $(addprefix $(AMDDALPATH)/dc/calcs/,$(BW_CALCS))
-
-AMD_DISPLAY_FILES += $(AMD_DAL_BW_CALCS)
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dpcd.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dpcd.c
index 72970e49800a6..3978cd5ea08a7 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dpcd.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dpcd.c
@@ -199,7 +199,7 @@ enum dc_status core_link_read_dpcd(
 	uint32_t extended_size;
 	/* size of the remaining partitioned address space */
 	uint32_t size_left_to_read;
-	enum dc_status status;
+	enum dc_status status = DC_ERROR_UNEXPECTED;
 	/* size of the next partition to be read from */
 	uint32_t partition_size;
 	uint32_t data_index = 0;
@@ -228,7 +228,7 @@ enum dc_status core_link_write_dpcd(
 {
 	uint32_t partition_size;
 	uint32_t data_index = 0;
-	enum dc_status status;
+	enum dc_status status = DC_ERROR_UNEXPECTED;
 
 	while (size) {
 		partition_size = dpcd_get_next_partition_size(address, size);
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
index ede11eb120d4f..04b370e7e732e 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
@@ -35,7 +35,7 @@
 #include "include/irq_service_interface.h"
 #include "dcn20/dcn20_resource.h"
 
-#include "dml/dcn2x/dcn2x.h"
+#include "dml/dcn20/dcn20_fpu.h"
 
 #include "dcn10/dcn10_hubp.h"
 #include "dcn10/dcn10_ipp.h"
diff --git a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
index 5b8274b8c3845..7c5c1414b7a1c 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
@@ -35,7 +35,7 @@
 #include "include/irq_service_interface.h"
 #include "dcn20/dcn20_resource.h"
 
-#include "dml/dcn2x/dcn2x.h"
+#include "dml/dcn20/dcn20_fpu.h"
 
 #include "clk_mgr.h"
 #include "dcn10/dcn10_hubp.h"
diff --git a/drivers/gpu/drm/amd/display/dc/dml/Makefile b/drivers/gpu/drm/amd/display/dc/dml/Makefile
index 9009b92490f34..96e70832c7423 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dml/Makefile
@@ -58,20 +58,21 @@ CFLAGS_$(AMDDALPATH)/dc/dml/display_mode_lib.o := $(dml_ccflags)
 
 ifdef CONFIG_DRM_AMD_DC_DCN
 CFLAGS_$(AMDDALPATH)/dc/dml/display_mode_vba.o := $(dml_ccflags)
-CFLAGS_$(AMDDALPATH)/dc/dml/dcn2x/dcn2x.o := $(dml_ccflags)
-CFLAGS_$(AMDDALPATH)/dc/dml/dcn20/display_mode_vba_20.o := $(dml_ccflags)
-CFLAGS_$(AMDDALPATH)/dc/dml/dcn20/display_mode_vba_20.o := $(dml_ccflags)
+CFLAGS_$(AMDDALPATH)/dc/dml/dcn20/dcn20_fpu.o := $(dml_ccflags)
+CFLAGS_$(AMDDALPATH)/dc/dml/dcn20/display_mode_vba_20.o := $(dml_ccflags) $(frame_warn_flag)
 CFLAGS_$(AMDDALPATH)/dc/dml/dcn20/display_rq_dlg_calc_20.o := $(dml_ccflags)
-CFLAGS_$(AMDDALPATH)/dc/dml/dcn20/display_mode_vba_20v2.o := $(dml_ccflags)
+CFLAGS_$(AMDDALPATH)/dc/dml/dcn20/display_mode_vba_20v2.o := $(dml_ccflags) $(frame_warn_flag)
 CFLAGS_$(AMDDALPATH)/dc/dml/dcn20/display_rq_dlg_calc_20v2.o := $(dml_ccflags)
-CFLAGS_$(AMDDALPATH)/dc/dml/dcn21/display_mode_vba_21.o := $(dml_ccflags)
+CFLAGS_$(AMDDALPATH)/dc/dml/dcn21/display_mode_vba_21.o := $(dml_ccflags) $(frame_warn_flag)
 CFLAGS_$(AMDDALPATH)/dc/dml/dcn21/display_rq_dlg_calc_21.o := $(dml_ccflags)
 CFLAGS_$(AMDDALPATH)/dc/dml/dcn30/display_mode_vba_30.o := $(dml_ccflags) $(frame_warn_flag)
 CFLAGS_$(AMDDALPATH)/dc/dml/dcn30/display_rq_dlg_calc_30.o := $(dml_ccflags)
 CFLAGS_$(AMDDALPATH)/dc/dml/dcn31/display_mode_vba_31.o := $(dml_ccflags) $(frame_warn_flag)
 CFLAGS_$(AMDDALPATH)/dc/dml/dcn31/display_rq_dlg_calc_31.o := $(dml_ccflags)
 CFLAGS_$(AMDDALPATH)/dc/dml/dsc/rc_calc_fpu.o := $(dml_ccflags)
-CFLAGS_$(AMDDALPATH)/dc/dml/display_mode_lib.o := $(dml_ccflags)
+CFLAGS_$(AMDDALPATH)/dc/dml/calcs/dcn_calcs.o := $(dml_ccflags)
+CFLAGS_$(AMDDALPATH)/dc/dml/calcs/dcn_calc_auto.o := $(dml_ccflags)
+CFLAGS_$(AMDDALPATH)/dc/dml/calcs/dcn_calc_math.o := $(dml_ccflags) -Wno-tautological-compare
 CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/display_mode_vba.o := $(dml_rcflags)
 CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn2x/dcn2x.o := $(dml_rcflags)
 CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn20/display_mode_vba_20.o := $(dml_rcflags)
@@ -91,17 +92,22 @@ CFLAGS_$(AMDDALPATH)/dc/dml/dml1_display_rq_dlg_calc.o := $(dml_ccflags)
 CFLAGS_$(AMDDALPATH)/dc/dml/display_rq_dlg_helpers.o := $(dml_ccflags)
 CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dml1_display_rq_dlg_calc.o := $(dml_rcflags)
 CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/display_rq_dlg_helpers.o := $(dml_rcflags)
+CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/calcs/dcn_calcs.o := $(dml_rcflags)
+CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/calcs/dcn_calc_auto.o := $(dml_rcflags)
+CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/calcs/dcn_calc_math.o := $(dml_rcflags)
 
-DML = display_mode_lib.o display_rq_dlg_helpers.o dml1_display_rq_dlg_calc.o \
+DML = calcs/dce_calcs.o calcs/custom_float.o calcs/bw_fixed.o
 
 ifdef CONFIG_DRM_AMD_DC_DCN
+DML += display_mode_lib.o display_rq_dlg_helpers.o dml1_display_rq_dlg_calc.o
+DML += dcn20/dcn20_fpu.o
 DML += display_mode_vba.o dcn20/display_rq_dlg_calc_20.o dcn20/display_mode_vba_20.o
-DML += dcn2x/dcn2x.o
 DML += dcn20/display_rq_dlg_calc_20v2.o dcn20/display_mode_vba_20v2.o
 DML += dcn21/display_rq_dlg_calc_21.o dcn21/display_mode_vba_21.o
 DML += dcn30/display_mode_vba_30.o dcn30/display_rq_dlg_calc_30.o
 DML += dcn31/display_mode_vba_31.o dcn31/display_rq_dlg_calc_31.o
 DML += dsc/rc_calc_fpu.o
+DML += calcs/dcn_calcs.o calcs/dcn_calc_math.o calcs/dcn_calc_auto.o
 endif
 
 AMD_DAL_DML = $(addprefix $(AMDDALPATH)/dc/dml/,$(DML))
diff --git a/drivers/gpu/drm/amd/display/dc/calcs/bw_fixed.c b/drivers/gpu/drm/amd/display/dc/dml/calcs/bw_fixed.c
similarity index 100%
rename from drivers/gpu/drm/amd/display/dc/calcs/bw_fixed.c
rename to drivers/gpu/drm/amd/display/dc/dml/calcs/bw_fixed.c
diff --git a/drivers/gpu/drm/amd/display/dc/calcs/calcs_logger.h b/drivers/gpu/drm/amd/display/dc/dml/calcs/calcs_logger.h
similarity index 100%
rename from drivers/gpu/drm/amd/display/dc/calcs/calcs_logger.h
rename to drivers/gpu/drm/amd/display/dc/dml/calcs/calcs_logger.h
diff --git a/drivers/gpu/drm/amd/display/dc/calcs/custom_float.c b/drivers/gpu/drm/amd/display/dc/dml/calcs/custom_float.c
similarity index 100%
rename from drivers/gpu/drm/amd/display/dc/calcs/custom_float.c
rename to drivers/gpu/drm/amd/display/dc/dml/calcs/custom_float.c
diff --git a/drivers/gpu/drm/amd/display/dc/calcs/dce_calcs.c b/drivers/gpu/drm/amd/display/dc/dml/calcs/dce_calcs.c
similarity index 100%
rename from drivers/gpu/drm/amd/display/dc/calcs/dce_calcs.c
rename to drivers/gpu/drm/amd/display/dc/dml/calcs/dce_calcs.c
diff --git a/drivers/gpu/drm/amd/display/dc/calcs/dcn_calc_auto.c b/drivers/gpu/drm/amd/display/dc/dml/calcs/dcn_calc_auto.c
similarity index 100%
rename from drivers/gpu/drm/amd/display/dc/calcs/dcn_calc_auto.c
rename to drivers/gpu/drm/amd/display/dc/dml/calcs/dcn_calc_auto.c
diff --git a/drivers/gpu/drm/amd/display/dc/calcs/dcn_calc_auto.h b/drivers/gpu/drm/amd/display/dc/dml/calcs/dcn_calc_auto.h
similarity index 100%
rename from drivers/gpu/drm/amd/display/dc/calcs/dcn_calc_auto.h
rename to drivers/gpu/drm/amd/display/dc/dml/calcs/dcn_calc_auto.h
diff --git a/drivers/gpu/drm/amd/display/dc/calcs/dcn_calc_math.c b/drivers/gpu/drm/amd/display/dc/dml/calcs/dcn_calc_math.c
similarity index 100%
rename from drivers/gpu/drm/amd/display/dc/calcs/dcn_calc_math.c
rename to drivers/gpu/drm/amd/display/dc/dml/calcs/dcn_calc_math.c
diff --git a/drivers/gpu/drm/amd/display/dc/calcs/dcn_calcs.c b/drivers/gpu/drm/amd/display/dc/dml/calcs/dcn_calcs.c
similarity index 100%
rename from drivers/gpu/drm/amd/display/dc/calcs/dcn_calcs.c
rename to drivers/gpu/drm/amd/display/dc/dml/calcs/dcn_calcs.c
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn2x/dcn2x.c b/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c
similarity index 99%
rename from drivers/gpu/drm/amd/display/dc/dml/dcn2x/dcn2x.c
rename to drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c
index c58522436291a..d590dc9173637 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn2x/dcn2x.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c
@@ -26,7 +26,7 @@
 
 #include "resource.h"
 
-#include "dcn2x.h"
+#include "dcn20_fpu.h"
 
 /**
  * DOC: DCN2x FPU manipulation Overview
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn2x/dcn2x.h b/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.h
similarity index 94%
rename from drivers/gpu/drm/amd/display/dc/dml/dcn2x/dcn2x.h
rename to drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.h
index 331547ba07132..36f26126d574b 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn2x/dcn2x.h
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.h
@@ -24,11 +24,11 @@
  *
  */
 
-#ifndef __DCN2X_H__
-#define __DCN2X_H__
+#ifndef __DCN20_FPU_H__
+#define __DCN20_FPU_H__
 
 void dcn20_populate_dml_writeback_from_context(struct dc *dc,
 					       struct resource_context *res_ctx,
 					       display_e2e_pipe_params_st *pipes);
 
-#endif /* __DCN2X_H__ */
+#endif /* __DCN20_FPU_H__ */
diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
index a68496b3f9296..197ea6e263878 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
@@ -188,29 +188,6 @@ u32 amdgpu_dpm_get_vrefresh(struct amdgpu_device *adev)
 	return vrefresh;
 }
 
-bool amdgpu_is_internal_thermal_sensor(enum amdgpu_int_thermal_type sensor)
-{
-	switch (sensor) {
-	case THERMAL_TYPE_RV6XX:
-	case THERMAL_TYPE_RV770:
-	case THERMAL_TYPE_EVERGREEN:
-	case THERMAL_TYPE_SUMO:
-	case THERMAL_TYPE_NI:
-	case THERMAL_TYPE_SI:
-	case THERMAL_TYPE_CI:
-	case THERMAL_TYPE_KV:
-		return true;
-	case THERMAL_TYPE_ADT7473_WITH_INTERNAL:
-	case THERMAL_TYPE_EMC2103_WITH_INTERNAL:
-		return false; /* need special handling */
-	case THERMAL_TYPE_NONE:
-	case THERMAL_TYPE_EXTERNAL:
-	case THERMAL_TYPE_EXTERNAL_GPIO:
-	default:
-		return false;
-	}
-}
-
 union power_info {
 	struct _ATOM_POWERPLAY_INFO info;
 	struct _ATOM_POWERPLAY_INFO_V2 info_2;
diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
index 16e3f72d31b9f..a3f6caaec88c7 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
@@ -501,8 +501,6 @@ void amdgpu_dpm_get_active_displays(struct amdgpu_device *adev);
 int amdgpu_dpm_read_sensor(struct amdgpu_device *adev, enum amd_pp_sensors sensor,
 			   void *data, uint32_t *size);
 
-bool amdgpu_is_internal_thermal_sensor(enum amdgpu_int_thermal_type sensor);
-
 int amdgpu_get_platform_caps(struct amdgpu_device *adev);
 
 int amdgpu_parse_extended_power_table(struct amdgpu_device *adev);
diff --git a/drivers/gpu/drm/amd/pm/powerplay/kv_dpm.c b/drivers/gpu/drm/amd/pm/powerplay/kv_dpm.c
index 309c9f0b8f83a..b56854c03ead6 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/kv_dpm.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/kv_dpm.c
@@ -1256,6 +1256,29 @@ static void kv_dpm_enable_bapm(void *handle, bool enable)
 	}
 }
 
+static bool kv_is_internal_thermal_sensor(enum amdgpu_int_thermal_type sensor)
+{
+	switch (sensor) {
+	case THERMAL_TYPE_RV6XX:
+	case THERMAL_TYPE_RV770:
+	case THERMAL_TYPE_EVERGREEN:
+	case THERMAL_TYPE_SUMO:
+	case THERMAL_TYPE_NI:
+	case THERMAL_TYPE_SI:
+	case THERMAL_TYPE_CI:
+	case THERMAL_TYPE_KV:
+		return true;
+	case THERMAL_TYPE_ADT7473_WITH_INTERNAL:
+	case THERMAL_TYPE_EMC2103_WITH_INTERNAL:
+		return false; /* need special handling */
+	case THERMAL_TYPE_NONE:
+	case THERMAL_TYPE_EXTERNAL:
+	case THERMAL_TYPE_EXTERNAL_GPIO:
+	default:
+		return false;
+	}
+}
+
 static int kv_dpm_enable(struct amdgpu_device *adev)
 {
 	struct kv_power_info *pi = kv_get_pi(adev);
@@ -1352,7 +1375,7 @@ static int kv_dpm_enable(struct amdgpu_device *adev)
 	}
 
 	if (adev->irq.installed &&
-	    amdgpu_is_internal_thermal_sensor(adev->pm.int_thermal_type)) {
+	    kv_is_internal_thermal_sensor(adev->pm.int_thermal_type)) {
 		ret = kv_set_thermal_temperature_range(adev, KV_TEMP_RANGE_MIN, KV_TEMP_RANGE_MAX);
 		if (ret) {
 			DRM_ERROR("kv_set_thermal_temperature_range failed\n");
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
index 3d2b92a952a65..7b522d55f3684 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -13558,9 +13558,9 @@ int i40e_queue_pair_disable(struct i40e_vsi *vsi, int queue_pair)
 		return err;
 
 	i40e_queue_pair_disable_irq(vsi, queue_pair);
+	i40e_queue_pair_toggle_napi(vsi, queue_pair, false /* off */);
 	err = i40e_queue_pair_toggle_rings(vsi, queue_pair, false /* off */);
 	i40e_clean_rx_ring(vsi->rx_rings[queue_pair]);
-	i40e_queue_pair_toggle_napi(vsi, queue_pair, false /* off */);
 	i40e_queue_pair_clean_rings(vsi, queue_pair);
 	i40e_queue_pair_reset_stats(vsi, queue_pair);
 
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index d4c29e2562a1c..3cc344d5228b6 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -6987,6 +6987,8 @@ ice_bridge_setlink(struct net_device *dev, struct nlmsghdr *nlh,
 	pf_sw = pf->first_sw;
 	/* find the attribute in the netlink message */
 	br_spec = nlmsg_find_attr(nlh, sizeof(struct ifinfomsg), IFLA_AF_SPEC);
+	if (!br_spec)
+		return -EINVAL;
 
 	nla_for_each_nested(attr, br_spec, rem) {
 		__u16 mode;
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index cb9e9d70b338c..d7eabc526f782 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -2941,8 +2941,8 @@ static void ixgbe_check_lsc(struct ixgbe_adapter *adapter)
 static inline void ixgbe_irq_enable_queues(struct ixgbe_adapter *adapter,
 					   u64 qmask)
 {
-	u32 mask;
 	struct ixgbe_hw *hw = &adapter->hw;
+	u32 mask;
 
 	switch (hw->mac.type) {
 	case ixgbe_mac_82598EB:
@@ -10380,6 +10380,44 @@ static void ixgbe_reset_rxr_stats(struct ixgbe_ring *rx_ring)
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
@@ -10396,6 +10434,11 @@ void ixgbe_txrx_ring_disable(struct ixgbe_adapter *adapter, int ring)
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
@@ -10404,9 +10447,6 @@ void ixgbe_txrx_ring_disable(struct ixgbe_adapter *adapter, int ring)
 	if (xdp_ring)
 		synchronize_rcu();
 
-	/* Rx/Tx/XDP Tx share the same napi context. */
-	napi_disable(&rx_ring->q_vector->napi);
-
 	ixgbe_clean_tx_ring(tx_ring);
 	if (xdp_ring)
 		ixgbe_clean_tx_ring(xdp_ring);
@@ -10434,9 +10474,6 @@ void ixgbe_txrx_ring_enable(struct ixgbe_adapter *adapter, int ring)
 	tx_ring = adapter->tx_ring[ring];
 	xdp_ring = adapter->xdp_ring[ring];
 
-	/* Rx/Tx/XDP Tx share the same napi context. */
-	napi_enable(&rx_ring->q_vector->napi);
-
 	ixgbe_configure_tx_ring(adapter, tx_ring);
 	if (xdp_ring)
 		ixgbe_configure_tx_ring(adapter, xdp_ring);
@@ -10445,6 +10482,11 @@ void ixgbe_txrx_ring_enable(struct ixgbe_adapter *adapter, int ring)
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
diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_mactable.c b/drivers/net/ethernet/microchip/sparx5/sparx5_mactable.c
index 9a8e4f201eb1f..6ba93fa984f26 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_mactable.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_mactable.c
@@ -344,10 +344,10 @@ int sparx5_del_mact_entry(struct sparx5 *sparx5,
 				 list) {
 		if ((vid == 0 || mact_entry->vid == vid) &&
 		    ether_addr_equal(addr, mact_entry->mac)) {
+			sparx5_mact_forget(sparx5, addr, mact_entry->vid);
+
 			list_del(&mact_entry->list);
 			devm_kfree(sparx5->dev, mact_entry);
-
-			sparx5_mact_forget(sparx5, addr, mact_entry->vid);
 		}
 	}
 	mutex_unlock(&sparx5->mact_lock);
diff --git a/drivers/net/ethernet/netronome/nfp/flower/conntrack.c b/drivers/net/ethernet/netronome/nfp/flower/conntrack.c
index fc17e9b11d19d..03a2dbcfbe566 100644
--- a/drivers/net/ethernet/netronome/nfp/flower/conntrack.c
+++ b/drivers/net/ethernet/netronome/nfp/flower/conntrack.c
@@ -1004,7 +1004,7 @@ static int nfp_ct_do_tc_merge(struct nfp_fl_ct_zone_entry *zt,
 	/* Checks that the chain_index of the filter matches the
 	 * chain_index of the GOTO action.
 	 */
-	if (post_ct_entry->chain_index != pre_ct_entry->chain_index)
+	if (post_ct_entry->chain_index != pre_ct_entry->goto_chain_index)
 		return -EINVAL;
 
 	err = nfp_ct_merge_check(post_ct_entry, pre_ct_entry);
@@ -1450,7 +1450,8 @@ int nfp_fl_ct_handle_pre_ct(struct nfp_flower_priv *priv,
 	if (IS_ERR(ct_entry))
 		return PTR_ERR(ct_entry);
 	ct_entry->type = CT_TYPE_PRE_CT;
-	ct_entry->chain_index = ct_goto->chain_index;
+	ct_entry->chain_index = flow->common.chain_index;
+	ct_entry->goto_chain_index = ct_goto->chain_index;
 	list_add(&ct_entry->list_node, &zt->pre_ct_list);
 	zt->pre_ct_count++;
 
@@ -1470,9 +1471,30 @@ int nfp_fl_ct_handle_post_ct(struct nfp_flower_priv *priv,
 {
 	struct flow_rule *rule = flow_cls_offload_flow_rule(flow);
 	struct nfp_fl_ct_flow_entry *ct_entry;
+	struct flow_action_entry *ct_goto;
 	struct nfp_fl_ct_zone_entry *zt;
+	struct flow_action_entry *act;
 	bool wildcarded = false;
 	struct flow_match_ct ct;
+	int i;
+
+	flow_action_for_each(i, act, &rule->action) {
+		switch (act->id) {
+		case FLOW_ACTION_REDIRECT:
+		case FLOW_ACTION_REDIRECT_INGRESS:
+		case FLOW_ACTION_MIRRED:
+		case FLOW_ACTION_MIRRED_INGRESS:
+			if (act->dev->rtnl_link_ops &&
+			    !strcmp(act->dev->rtnl_link_ops->kind, "openvswitch")) {
+				NL_SET_ERR_MSG_MOD(extack,
+						   "unsupported offload: out port is openvswitch internal port");
+				return -EOPNOTSUPP;
+			}
+			break;
+		default:
+			break;
+		}
+	}
 
 	flow_rule_match_ct(rule, &ct);
 	if (!ct.mask->ct_zone) {
@@ -1497,6 +1519,8 @@ int nfp_fl_ct_handle_post_ct(struct nfp_flower_priv *priv,
 
 	ct_entry->type = CT_TYPE_POST_CT;
 	ct_entry->chain_index = flow->common.chain_index;
+	ct_goto = get_flow_act(flow->rule, FLOW_ACTION_GOTO);
+	ct_entry->goto_chain_index = ct_goto ? ct_goto->chain_index : 0;
 	list_add(&ct_entry->list_node, &zt->post_ct_list);
 	zt->post_ct_count++;
 
diff --git a/drivers/net/ethernet/netronome/nfp/flower/conntrack.h b/drivers/net/ethernet/netronome/nfp/flower/conntrack.h
index beb6cceff9d8e..47607cd8a716d 100644
--- a/drivers/net/ethernet/netronome/nfp/flower/conntrack.h
+++ b/drivers/net/ethernet/netronome/nfp/flower/conntrack.h
@@ -108,6 +108,7 @@ enum nfp_nfp_layer_name {
  * @cookie:	Flow cookie, same as original TC flow, used as key
  * @list_node:	Used by the list
  * @chain_index:	Chain index of the original flow
+ * @goto_chain_index:	goto chain index of the flow
  * @netdev:	netdev structure.
  * @type:	Type of pre-entry from enum ct_entry_type
  * @zt:		Reference to the zone table this belongs to
@@ -120,6 +121,7 @@ struct nfp_fl_ct_flow_entry {
 	unsigned long cookie;
 	struct list_head list_node;
 	u32 chain_index;
+	u32 goto_chain_index;
 	enum ct_entry_type type;
 	struct net_device *netdev;
 	struct nfp_fl_ct_zone_entry *zt;
diff --git a/drivers/net/geneve.c b/drivers/net/geneve.c
index 605332f36d9df..9569b5cc595ec 100644
--- a/drivers/net/geneve.c
+++ b/drivers/net/geneve.c
@@ -219,7 +219,7 @@ static void geneve_rx(struct geneve_dev *geneve, struct geneve_sock *gs,
 	struct genevehdr *gnvh = geneve_hdr(skb);
 	struct metadata_dst *tun_dst = NULL;
 	unsigned int len;
-	int err = 0;
+	int nh, err = 0;
 	void *oiph;
 
 	if (ip_tunnel_collect_metadata() || gs->collect_md) {
@@ -263,9 +263,23 @@ static void geneve_rx(struct geneve_dev *geneve, struct geneve_sock *gs,
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
diff --git a/drivers/net/hyperv/netvsc_drv.c b/drivers/net/hyperv/netvsc_drv.c
index 25b65450cbb99..804c11cbccff6 100644
--- a/drivers/net/hyperv/netvsc_drv.c
+++ b/drivers/net/hyperv/netvsc_drv.c
@@ -42,6 +42,10 @@
 #define LINKCHANGE_INT (2 * HZ)
 #define VF_TAKEOVER_INT (HZ / 10)
 
+/* Macros to define the context of vf registration */
+#define VF_REG_IN_PROBE		1
+#define VF_REG_IN_NOTIFIER	2
+
 static unsigned int ring_size __ro_after_init = 128;
 module_param(ring_size, uint, 0444);
 MODULE_PARM_DESC(ring_size, "Ring buffer size (# of 4K pages)");
@@ -2204,7 +2208,7 @@ static rx_handler_result_t netvsc_vf_handle_frame(struct sk_buff **pskb)
 }
 
 static int netvsc_vf_join(struct net_device *vf_netdev,
-			  struct net_device *ndev)
+			  struct net_device *ndev, int context)
 {
 	struct net_device_context *ndev_ctx = netdev_priv(ndev);
 	int ret;
@@ -2227,7 +2231,11 @@ static int netvsc_vf_join(struct net_device *vf_netdev,
 		goto upper_link_failed;
 	}
 
-	schedule_delayed_work(&ndev_ctx->vf_takeover, VF_TAKEOVER_INT);
+	/* If this registration is called from probe context vf_takeover
+	 * is taken care of later in probe itself.
+	 */
+	if (context == VF_REG_IN_NOTIFIER)
+		schedule_delayed_work(&ndev_ctx->vf_takeover, VF_TAKEOVER_INT);
 
 	call_netdevice_notifiers(NETDEV_JOIN, vf_netdev);
 
@@ -2365,7 +2373,7 @@ static int netvsc_prepare_bonding(struct net_device *vf_netdev)
 	return NOTIFY_DONE;
 }
 
-static int netvsc_register_vf(struct net_device *vf_netdev)
+static int netvsc_register_vf(struct net_device *vf_netdev, int context)
 {
 	struct net_device_context *net_device_ctx;
 	struct netvsc_device *netvsc_dev;
@@ -2405,7 +2413,7 @@ static int netvsc_register_vf(struct net_device *vf_netdev)
 
 	netdev_info(ndev, "VF registering: %s\n", vf_netdev->name);
 
-	if (netvsc_vf_join(vf_netdev, ndev) != 0)
+	if (netvsc_vf_join(vf_netdev, ndev, context) != 0)
 		return NOTIFY_DONE;
 
 	dev_hold(vf_netdev);
@@ -2503,10 +2511,31 @@ static int netvsc_unregister_vf(struct net_device *vf_netdev)
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
@@ -2614,6 +2643,30 @@ static int netvsc_probe(struct hv_device *dev,
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
@@ -2770,29 +2823,17 @@ static int netvsc_netdev_event(struct notifier_block *this,
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
diff --git a/drivers/net/usb/lan78xx.c b/drivers/net/usb/lan78xx.c
index c8b42892655a1..77cb30259dca7 100644
--- a/drivers/net/usb/lan78xx.c
+++ b/drivers/net/usb/lan78xx.c
@@ -2960,7 +2960,8 @@ static int lan78xx_open(struct net_device *net)
 done:
 	mutex_unlock(&dev->dev_mutex);
 
-	usb_autopm_put_interface(dev->intf);
+	if (ret < 0)
+		usb_autopm_put_interface(dev->intf);
 
 	return ret;
 }
diff --git a/drivers/tty/serial/max310x.c b/drivers/tty/serial/max310x.c
index 5dd73d1da1ecc..c122e7e90fc89 100644
--- a/drivers/tty/serial/max310x.c
+++ b/drivers/tty/serial/max310x.c
@@ -72,7 +72,7 @@
 #define MAX310X_GLOBALCMD_REG		MAX310X_REG_1F /* Global Command (WO) */
 
 /* Extended registers */
-#define MAX310X_REVID_EXTREG		MAX310X_REG_05 /* Revision ID */
+#define MAX310X_SPI_REVID_EXTREG	MAX310X_REG_05 /* Revision ID */
 
 /* IRQ register bits */
 #define MAX310X_IRQ_LSR_BIT		(1 << 0) /* LSR interrupt */
@@ -235,6 +235,10 @@
 #define MAX310x_REV_MASK		(0xf8)
 #define MAX310X_WRITE_BIT		0x80
 
+/* Port startup definitions */
+#define MAX310X_PORT_STARTUP_WAIT_RETRIES	20 /* Number of retries */
+#define MAX310X_PORT_STARTUP_WAIT_DELAY_MS	10 /* Delay between retries */
+
 /* Crystal-related definitions */
 #define MAX310X_XTAL_WAIT_RETRIES	20 /* Number of retries */
 #define MAX310X_XTAL_WAIT_DELAY_MS	10 /* Delay between retries */
@@ -249,6 +253,12 @@
 #define MAX14830_BRGCFG_CLKDIS_BIT	(1 << 6) /* Clock Disable */
 #define MAX14830_REV_ID			(0xb0)
 
+struct max310x_if_cfg {
+	int (*extended_reg_enable)(struct device *dev, bool enable);
+
+	unsigned int rev_id_reg;
+};
+
 struct max310x_devtype {
 	char	name[9];
 	int	nr;
@@ -262,9 +272,8 @@ struct max310x_one {
 	struct work_struct	tx_work;
 	struct work_struct	md_work;
 	struct work_struct	rs_work;
+	struct regmap		*regmap;
 
-	u8 wr_header;
-	u8 rd_header;
 	u8 rx_buf[MAX310X_FIFO_SIZE];
 };
 #define to_max310x_port(_port) \
@@ -272,6 +281,7 @@ struct max310x_one {
 
 struct max310x_port {
 	const struct max310x_devtype *devtype;
+	const struct max310x_if_cfg *if_cfg;
 	struct regmap		*regmap;
 	struct clk		*clk;
 #ifdef CONFIG_GPIOLIB
@@ -293,26 +303,26 @@ static DECLARE_BITMAP(max310x_lines, MAX310X_UART_NRMAX);
 
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
@@ -361,13 +371,12 @@ static int max3109_detect(struct device *dev)
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
@@ -392,13 +401,12 @@ static int max14830_detect(struct device *dev)
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
@@ -451,7 +459,7 @@ static const struct max310x_devtype max14830_devtype = {
 
 static bool max310x_reg_writeable(struct device *dev, unsigned int reg)
 {
-	switch (reg & 0x1f) {
+	switch (reg) {
 	case MAX310X_IRQSTS_REG:
 	case MAX310X_LSR_IRQSTS_REG:
 	case MAX310X_SPCHR_IRQSTS_REG:
@@ -468,7 +476,7 @@ static bool max310x_reg_writeable(struct device *dev, unsigned int reg)
 
 static bool max310x_reg_volatile(struct device *dev, unsigned int reg)
 {
-	switch (reg & 0x1f) {
+	switch (reg) {
 	case MAX310X_RHR_REG:
 	case MAX310X_IRQSTS_REG:
 	case MAX310X_LSR_IRQSTS_REG:
@@ -490,7 +498,7 @@ static bool max310x_reg_volatile(struct device *dev, unsigned int reg)
 
 static bool max310x_reg_precious(struct device *dev, unsigned int reg)
 {
-	switch (reg & 0x1f) {
+	switch (reg) {
 	case MAX310X_RHR_REG:
 	case MAX310X_IRQSTS_REG:
 	case MAX310X_SPCHR_IRQSTS_REG:
@@ -503,6 +511,11 @@ static bool max310x_reg_precious(struct device *dev, unsigned int reg)
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
@@ -636,31 +649,15 @@ static s32 max310x_set_ref_clk(struct device *dev, struct max310x_port *s,
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
@@ -1263,15 +1260,17 @@ static int max310x_gpio_set_config(struct gpio_chip *chip, unsigned int offset,
 #endif
 
 static int max310x_probe(struct device *dev, const struct max310x_devtype *devtype,
-			 struct regmap *regmap, int irq)
+			 const struct max310x_if_cfg *if_cfg,
+			 struct regmap *regmaps[], int irq)
 {
 	int i, ret, fmin, fmax, freq;
 	struct max310x_port *s;
 	s32 uartclk = 0;
 	bool xtal;
 
-	if (IS_ERR(regmap))
-		return PTR_ERR(regmap);
+	for (i = 0; i < devtype->nr; i++)
+		if (IS_ERR(regmaps[i]))
+			return PTR_ERR(regmaps[i]);
 
 	/* Alloc port structure */
 	s = devm_kzalloc(dev, struct_size(s, p, devtype->nr), GFP_KERNEL);
@@ -1318,8 +1317,9 @@ static int max310x_probe(struct device *dev, const struct max310x_devtype *devty
 		goto out_clk;
 	}
 
-	s->regmap = regmap;
+	s->regmap = regmaps[0];
 	s->devtype = devtype;
+	s->if_cfg = if_cfg;
 	dev_set_drvdata(dev, s);
 
 	/* Check device to ensure we are talking to what we expect */
@@ -1328,22 +1328,30 @@ static int max310x_probe(struct device *dev, const struct max310x_devtype *devty
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
+
+			if (val == 0x01)
+				started = true;
+		} while (!started && (++try < MAX310X_PORT_STARTUP_WAIT_RETRIES));
+
+		if (!started) {
+			ret = dev_err_probe(dev, -EAGAIN, "port reset failed\n");
+			goto out_uart;
+		}
 
-		regmap_write(s->regmap, MAX310X_MODE1_REG + offs,
-			     devtype->mode1);
+		regmap_write(regmaps[i], MAX310X_MODE1_REG, devtype->mode1);
 	}
 
 	uartclk = max310x_set_ref_clk(dev, s, freq, xtal);
@@ -1371,11 +1379,13 @@ static int max310x_probe(struct device *dev, const struct max310x_devtype *devty
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
@@ -1386,10 +1396,6 @@ static int max310x_probe(struct device *dev, const struct max310x_devtype *devty
 		INIT_WORK(&s->p[i].md_work, max310x_md_proc);
 		/* Initialize queue for changing RS485 mode */
 		INIT_WORK(&s->p[i].rs_work, max310x_rs_proc);
-		/* Initialize SPI-transfer buffers */
-		s->p[i].wr_header = (s->p[i].port.iobase + MAX310X_THR_REG) |
-				    MAX310X_WRITE_BIT;
-		s->p[i].rd_header = (s->p[i].port.iobase + MAX310X_RHR_REG);
 
 		/* Register port */
 		ret = uart_add_one_port(&max310x_uart, &s->p[i].port);
@@ -1476,16 +1482,35 @@ static struct regmap_config regcfg = {
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
 	const struct max310x_devtype *devtype;
-	struct regmap *regmap;
+	struct regmap *regmaps[4];
+	unsigned int i;
 	int ret;
 
 	/* Setup SPI bus */
@@ -1500,10 +1525,14 @@ static int max310x_spi_probe(struct spi_device *spi)
 	if (!devtype)
 		devtype = (struct max310x_devtype *)spi_get_device_id(spi)->driver_data;
 
-	regcfg.max_register = devtype->nr * 0x20 - 1;
-	regmap = devm_regmap_init_spi(spi, &regcfg);
+	for (i = 0; i < devtype->nr; i++) {
+		u8 port_mask = i * 0x20;
+		regcfg.read_flag_mask = port_mask;
+		regcfg.write_flag_mask = port_mask | MAX310X_WRITE_BIT;
+		regmaps[i] = devm_regmap_init_spi(spi, &regcfg);
+	}
 
-	return max310x_probe(&spi->dev, devtype, regmap, spi->irq);
+	return max310x_probe(&spi->dev, devtype, &max310x_spi_if_cfg, regmaps, spi->irq);
 }
 
 static int max310x_spi_remove(struct spi_device *spi)
diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
index aa12da0796d2d..31d355613933f 100644
--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -2428,6 +2428,9 @@ static int process_isoc_td(struct xhci_hcd *xhci, struct xhci_virt_ep *ep,
 	/* handle completion code */
 	switch (trb_comp_code) {
 	case COMP_SUCCESS:
+		/* Don't overwrite status if TD had an error, see xHCI 4.9.1 */
+		if (td->error_mid_td)
+			break;
 		if (remaining) {
 			frame->status = short_framestatus;
 			if (xhci->quirks & XHCI_TRUST_TX_LENGTH)
@@ -2443,9 +2446,13 @@ static int process_isoc_td(struct xhci_hcd *xhci, struct xhci_virt_ep *ep,
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
@@ -2453,8 +2460,9 @@ static int process_isoc_td(struct xhci_hcd *xhci, struct xhci_virt_ep *ep,
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
@@ -2474,6 +2482,9 @@ static int process_isoc_td(struct xhci_hcd *xhci, struct xhci_virt_ep *ep,
 		break;
 	}
 
+	if (td->urb_length_set)
+		goto finish_td;
+
 	if (sum_trbs_for_length)
 		frame->actual_length = sum_trb_lengths(xhci, ep->ring, ep_trb) +
 			ep_trb_len - remaining;
@@ -2482,6 +2493,14 @@ static int process_isoc_td(struct xhci_hcd *xhci, struct xhci_virt_ep *ep,
 
 	td->urb->actual_length += frame->actual_length;
 
+finish_td:
+	/* Don't give back TD yet if we encountered an error mid TD */
+	if (td->error_mid_td && ep_trb != td->last_trb) {
+		xhci_dbg(xhci, "Error mid isoc TD, wait for final completion event\n");
+		td->urb_length_set = true;
+		return 0;
+	}
+
 	return finish_td(xhci, ep, ep_ring, td, trb_comp_code);
 }
 
@@ -2866,17 +2885,51 @@ static int handle_tx_event(struct xhci_hcd *xhci,
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
@@ -2888,9 +2941,6 @@ static int handle_tx_event(struct xhci_hcd *xhci,
 					  ep_trb_dma, true);
 				return -ESHUTDOWN;
 			}
-
-			skip_isoc_td(xhci, td, ep, status);
-			goto cleanup;
 		}
 		if (trb_comp_code == COMP_SHORT_PACKET)
 			ep_ring->last_td_was_short = true;
diff --git a/drivers/usb/host/xhci.h b/drivers/usb/host/xhci.h
index 8ae33db1e4bcc..0e46b9e45c20c 100644
--- a/drivers/usb/host/xhci.h
+++ b/drivers/usb/host/xhci.h
@@ -1572,6 +1572,7 @@ struct xhci_td {
 	struct xhci_segment	*bounce_seg;
 	/* actual_length of the URB has already been set */
 	bool			urb_length_set;
+	bool			error_mid_td;
 	unsigned int		num_trbs;
 };
 
diff --git a/fs/erofs/data.c b/fs/erofs/data.c
index 16a41d0db55a3..a859bf0f31df2 100644
--- a/fs/erofs/data.c
+++ b/fs/erofs/data.c
@@ -340,4 +340,5 @@ const struct file_operations erofs_file_fops = {
 	.read_iter	= erofs_file_read_iter,
 	.mmap		= erofs_file_mmap,
 	.splice_read	= generic_file_splice_read,
+	.get_unmapped_area = thp_get_unmapped_area,
 };
diff --git a/fs/proc/array.c b/fs/proc/array.c
index 49be8c8ef555e..c925287a4dc4b 100644
--- a/fs/proc/array.c
+++ b/fs/proc/array.c
@@ -495,7 +495,7 @@ static int do_task_stat(struct seq_file *m, struct pid_namespace *ns,
 
 	sigemptyset(&sigign);
 	sigemptyset(&sigcatch);
-	cutime = cstime = utime = stime = 0;
+	cutime = cstime = 0;
 	cgtime = gtime = 0;
 
 	if (lock_task_sighand(task, &flags)) {
@@ -529,7 +529,6 @@ static int do_task_stat(struct seq_file *m, struct pid_namespace *ns,
 
 			min_flt += sig->min_flt;
 			maj_flt += sig->maj_flt;
-			thread_group_cputime_adjusted(task, &utime, &stime);
 			gtime += sig->gtime;
 		}
 
@@ -541,11 +540,14 @@ static int do_task_stat(struct seq_file *m, struct pid_namespace *ns,
 	}
 
 	if (permitted && (!whole || num_threads < 2))
-		wchan = get_wchan(task);
-	if (!whole) {
+		wchan = !task_is_running(task);
+
+	if (whole) {
+		thread_group_cputime_adjusted(task, &utime, &stime);
+	} else {
+		task_cputime_adjusted(task, &utime, &stime);
 		min_flt = task->min_flt;
 		maj_flt = task->maj_flt;
-		task_cputime_adjusted(task, &utime, &stime);
 		gtime = task_gtime(task);
 	}
 
@@ -606,10 +608,7 @@ static int do_task_stat(struct seq_file *m, struct pid_namespace *ns,
 	 *
 	 * This works with older implementations of procps as well.
 	 */
-	if (wchan)
-		seq_puts(m, " 1");
-	else
-		seq_puts(m, " 0");
+	seq_put_decimal_ull(m, " ", wchan);
 
 	seq_put_decimal_ull(m, " ", 0);
 	seq_put_decimal_ull(m, " ", 0);
diff --git a/include/linux/regmap.h b/include/linux/regmap.h
index e3c9a25a853a8..f74e543fadc07 100644
--- a/include/linux/regmap.h
+++ b/include/linux/regmap.h
@@ -290,6 +290,17 @@ typedef void (*regmap_unlock)(void *);
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
@@ -372,6 +383,14 @@ struct regmap_config {
 
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
 
diff --git a/include/trace/events/qdisc.h b/include/trace/events/qdisc.h
index 59c945b66f9c7..5180da19d837f 100644
--- a/include/trace/events/qdisc.h
+++ b/include/trace/events/qdisc.h
@@ -81,14 +81,14 @@ TRACE_EVENT(qdisc_reset,
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
@@ -106,14 +106,14 @@ TRACE_EVENT(qdisc_destroy,
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
index 8d1c4b3ee7604..f7de5b313cc5b 100644
--- a/kernel/bpf/cpumap.c
+++ b/kernel/bpf/cpumap.c
@@ -221,7 +221,7 @@ static int cpu_map_bpf_prog_run_xdp(struct bpf_cpu_map_entry *rcpu,
 				    void **frames, int n,
 				    struct xdp_cpumap_stats *stats)
 {
-	struct xdp_rxq_info rxq;
+	struct xdp_rxq_info rxq = {};
 	struct xdp_buff xdp;
 	int i, nframes = 0;
 
diff --git a/kernel/sys.c b/kernel/sys.c
index 2efab44746356..2cfb829864c63 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -1763,74 +1763,87 @@ void getrusage(struct task_struct *p, int who, struct rusage *r)
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
diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index 75eab4032f017..3a95466e10a95 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -5346,19 +5346,7 @@ static int ip6_route_multipath_add(struct fib6_config *cfg,
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
@@ -5366,6 +5354,12 @@ static int ip6_route_multipath_add(struct fib6_config *cfg,
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
@@ -5426,8 +5420,7 @@ static int ip6_route_multipath_add(struct fib6_config *cfg,
 
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
index 7c667629c5149..69214993b5a2c 100644
--- a/net/netfilter/nft_ct.c
+++ b/net/netfilter/nft_ct.c
@@ -1192,14 +1192,13 @@ static int nft_ct_expect_obj_init(const struct nft_ctx *ctx,
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
index 2f084b6f69d7e..97944db6b5ac6 100644
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
 
@@ -262,7 +262,7 @@ static int nr_state3_machine(struct sock *sk, struct sk_buff *skb, int frametype
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
index ddd5cbd455e39..983c5ad9724f1 100644
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
@@ -728,7 +728,7 @@ void nr_link_failed(ax25_cb *ax25, int reason)
 	nr_neigh->ax25 = NULL;
 	ax25_cb_put(ax25);
 
-	if (++nr_neigh->failed < sysctl_netrom_link_fails_count) {
+	if (++nr_neigh->failed < READ_ONCE(sysctl_netrom_link_fails_count)) {
 		nr_neigh_put(nr_neigh);
 		return;
 	}
@@ -766,7 +766,7 @@ int nr_route_frame(struct sk_buff *skb, ax25_cb *ax25)
 	if (ax25 != NULL) {
 		ret = nr_add_node(nr_src, "", &ax25->dest_addr, ax25->digipeat,
 				  ax25->ax25_dev->dev, 0,
-				  sysctl_netrom_obsolescence_count_initialiser);
+				  READ_ONCE(sysctl_netrom_obsolescence_count_initialiser));
 		if (ret)
 			return ret;
 	}
@@ -780,7 +780,7 @@ int nr_route_frame(struct sk_buff *skb, ax25_cb *ax25)
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
index 53444397de669..d6462d1471c14 100644
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
diff --git a/sound/usb/card.c b/sound/usb/card.c
index 550c6a72fb5bc..bebd42413fadb 100644
--- a/sound/usb/card.c
+++ b/sound/usb/card.c
@@ -643,6 +643,7 @@ static int snd_usb_audio_create(struct usb_interface *intf,
 	INIT_LIST_HEAD(&chip->pcm_list);
 	INIT_LIST_HEAD(&chip->ep_list);
 	INIT_LIST_HEAD(&chip->iface_ref_list);
+	INIT_LIST_HEAD(&chip->clock_ref_list);
 	INIT_LIST_HEAD(&chip->midi_list);
 	INIT_LIST_HEAD(&chip->mixer_list);
 
diff --git a/sound/usb/card.h b/sound/usb/card.h
index 87f042d06ce08..6ec95b2edf863 100644
--- a/sound/usb/card.h
+++ b/sound/usb/card.h
@@ -44,6 +44,7 @@ struct audioformat {
 
 struct snd_usb_substream;
 struct snd_usb_iface_ref;
+struct snd_usb_clock_ref;
 struct snd_usb_endpoint;
 struct snd_usb_power_domain;
 
@@ -62,6 +63,7 @@ struct snd_urb_ctx {
 struct snd_usb_endpoint {
 	struct snd_usb_audio *chip;
 	struct snd_usb_iface_ref *iface_ref;
+	struct snd_usb_clock_ref *clock_ref;
 
 	int opened;		/* open refcount; protect with chip->mutex */
 	atomic_t running;	/* running status */
@@ -127,7 +129,9 @@ struct snd_usb_endpoint {
 					   in a stream */
 	bool implicit_fb_sync;		/* syncs with implicit feedback */
 	bool lowlatency_playback;	/* low-latency playback mode */
-	bool need_setup;		/* (re-)need for configure? */
+	bool need_setup;		/* (re-)need for hw_params? */
+	bool need_prepare;		/* (re-)need for prepare? */
+	bool fixed_rate;		/* skip rate setup */
 
 	/* for hw constraints */
 	const struct audioformat *cur_audiofmt;
@@ -138,7 +142,6 @@ struct snd_usb_endpoint {
 	unsigned int cur_period_frames;
 	unsigned int cur_period_bytes;
 	unsigned int cur_buffer_periods;
-	unsigned char cur_clock;
 
 	spinlock_t lock;
 	struct list_head list;
diff --git a/sound/usb/endpoint.c b/sound/usb/endpoint.c
index 6c7d842d04965..8188113ca83f2 100644
--- a/sound/usb/endpoint.c
+++ b/sound/usb/endpoint.c
@@ -35,6 +35,16 @@ struct snd_usb_iface_ref {
 	struct list_head list;
 };
 
+/* clock refcounting */
+struct snd_usb_clock_ref {
+	unsigned char clock;
+	atomic_t locked;
+	int opened;
+	int rate;
+	bool need_setup;
+	struct list_head list;
+};
+
 /*
  * snd_usb_endpoint is a model that abstracts everything related to an
  * USB endpoint and its streaming.
@@ -598,6 +608,25 @@ iface_ref_find(struct snd_usb_audio *chip, int iface)
 	return ip;
 }
 
+/* Similarly, a refcount object for clock */
+static struct snd_usb_clock_ref *
+clock_ref_find(struct snd_usb_audio *chip, int clock)
+{
+	struct snd_usb_clock_ref *ref;
+
+	list_for_each_entry(ref, &chip->clock_ref_list, list)
+		if (ref->clock == clock)
+			return ref;
+
+	ref = kzalloc(sizeof(*ref), GFP_KERNEL);
+	if (!ref)
+		return NULL;
+	ref->clock = clock;
+	atomic_set(&ref->locked, 0);
+	list_add_tail(&ref->list, &chip->clock_ref_list);
+	return ref;
+}
+
 /*
  * Get the existing endpoint object corresponding EP
  * Returns NULL if not present.
@@ -738,13 +767,15 @@ bool snd_usb_endpoint_compatible(struct snd_usb_audio *chip,
  * The endpoint needs to be closed via snd_usb_endpoint_close() later.
  *
  * Note that this function doesn't configure the endpoint.  The substream
- * needs to set it up later via snd_usb_endpoint_configure().
+ * needs to set it up later via snd_usb_endpoint_set_params() and
+ * snd_usb_endpoint_prepare().
  */
 struct snd_usb_endpoint *
 snd_usb_endpoint_open(struct snd_usb_audio *chip,
 		      const struct audioformat *fp,
 		      const struct snd_pcm_hw_params *params,
-		      bool is_sync_ep)
+		      bool is_sync_ep,
+		      bool fixed_rate)
 {
 	struct snd_usb_endpoint *ep;
 	int ep_num = is_sync_ep ? fp->sync_ep : fp->endpoint;
@@ -775,6 +806,15 @@ snd_usb_endpoint_open(struct snd_usb_audio *chip,
 			goto unlock;
 		}
 
+		if (fp->protocol != UAC_VERSION_1) {
+			ep->clock_ref = clock_ref_find(chip, fp->clock);
+			if (!ep->clock_ref) {
+				ep = NULL;
+				goto unlock;
+			}
+			ep->clock_ref->opened++;
+		}
+
 		ep->cur_audiofmt = fp;
 		ep->cur_channels = fp->channels;
 		ep->cur_rate = params_rate(params);
@@ -784,13 +824,14 @@ snd_usb_endpoint_open(struct snd_usb_audio *chip,
 		ep->cur_period_frames = params_period_size(params);
 		ep->cur_period_bytes = ep->cur_period_frames * ep->cur_frame_bytes;
 		ep->cur_buffer_periods = params_periods(params);
-		ep->cur_clock = fp->clock;
 
 		if (ep->type == SND_USB_ENDPOINT_TYPE_SYNC)
 			endpoint_set_syncinterval(chip, ep);
 
 		ep->implicit_fb_sync = fp->implicit_fb;
 		ep->need_setup = true;
+		ep->need_prepare = true;
+		ep->fixed_rate = fixed_rate;
 
 		usb_audio_dbg(chip, "  channels=%d, rate=%d, format=%s, period_bytes=%d, periods=%d, implicit_fb=%d\n",
 			      ep->cur_channels, ep->cur_rate,
@@ -898,12 +939,16 @@ void snd_usb_endpoint_close(struct snd_usb_audio *chip,
 		endpoint_set_interface(chip, ep, false);
 
 	if (!--ep->opened) {
+		if (ep->clock_ref) {
+			if (!--ep->clock_ref->opened)
+				ep->clock_ref->rate = 0;
+		}
 		ep->iface = 0;
 		ep->altsetting = 0;
 		ep->cur_audiofmt = NULL;
 		ep->cur_rate = 0;
-		ep->cur_clock = 0;
 		ep->iface_ref = NULL;
+		ep->clock_ref = NULL;
 		usb_audio_dbg(chip, "EP 0x%x closed\n", ep->ep_num);
 	}
 	mutex_unlock(&chip->mutex);
@@ -912,9 +957,11 @@ void snd_usb_endpoint_close(struct snd_usb_audio *chip,
 /* Prepare for suspening EP, called from the main suspend handler */
 void snd_usb_endpoint_suspend(struct snd_usb_endpoint *ep)
 {
-	ep->need_setup = true;
+	ep->need_prepare = true;
 	if (ep->iface_ref)
 		ep->iface_ref->need_setup = true;
+	if (ep->clock_ref)
+		ep->clock_ref->rate = 0;
 }
 
 /*
@@ -1258,23 +1305,51 @@ static int sync_ep_set_params(struct snd_usb_endpoint *ep)
 	return -ENOMEM;
 }
 
+/* update the rate of the referred clock; return the actual rate */
+static int update_clock_ref_rate(struct snd_usb_audio *chip,
+				 struct snd_usb_endpoint *ep)
+{
+	struct snd_usb_clock_ref *clock = ep->clock_ref;
+	int rate = ep->cur_rate;
+
+	if (!clock || clock->rate == rate)
+		return rate;
+	if (clock->rate) {
+		if (atomic_read(&clock->locked))
+			return clock->rate;
+		if (clock->rate != rate) {
+			usb_audio_err(chip, "Mismatched sample rate %d vs %d for EP 0x%x\n",
+				      clock->rate, rate, ep->ep_num);
+			return clock->rate;
+		}
+	}
+	clock->rate = rate;
+	clock->need_setup = true;
+	return rate;
+}
+
 /*
  * snd_usb_endpoint_set_params: configure an snd_usb_endpoint
  *
+ * It's called either from hw_params callback.
  * Determine the number of URBs to be used on this endpoint.
  * An endpoint must be configured before it can be started.
  * An endpoint that is already running can not be reconfigured.
  */
-static int snd_usb_endpoint_set_params(struct snd_usb_audio *chip,
-				       struct snd_usb_endpoint *ep)
+int snd_usb_endpoint_set_params(struct snd_usb_audio *chip,
+				struct snd_usb_endpoint *ep)
 {
 	const struct audioformat *fmt = ep->cur_audiofmt;
-	int err;
+	int err = 0;
+
+	mutex_lock(&chip->mutex);
+	if (!ep->need_setup)
+		goto unlock;
 
 	/* release old buffers, if any */
 	err = release_urbs(ep, false);
 	if (err < 0)
-		return err;
+		goto unlock;
 
 	ep->datainterval = fmt->datainterval;
 	ep->maxpacksize = fmt->maxpacksize;
@@ -1312,28 +1387,62 @@ static int snd_usb_endpoint_set_params(struct snd_usb_audio *chip,
 	usb_audio_dbg(chip, "Set up %d URBS, ret=%d\n", ep->nurbs, err);
 
 	if (err < 0)
-		return err;
+		goto unlock;
 
 	/* some unit conversions in runtime */
 	ep->maxframesize = ep->maxpacksize / ep->cur_frame_bytes;
 	ep->curframesize = ep->curpacksize / ep->cur_frame_bytes;
 
+	err = update_clock_ref_rate(chip, ep);
+	if (err >= 0) {
+		ep->need_setup = false;
+		err = 0;
+	}
+
+ unlock:
+	mutex_unlock(&chip->mutex);
+	return err;
+}
+
+static int init_sample_rate(struct snd_usb_audio *chip,
+			    struct snd_usb_endpoint *ep)
+{
+	struct snd_usb_clock_ref *clock = ep->clock_ref;
+	int rate, err;
+
+	rate = update_clock_ref_rate(chip, ep);
+	if (rate < 0)
+		return rate;
+	if (clock && !clock->need_setup)
+		return 0;
+
+	if (!ep->fixed_rate) {
+		err = snd_usb_init_sample_rate(chip, ep->cur_audiofmt, rate);
+		if (err < 0) {
+			if (clock)
+				clock->rate = 0; /* reset rate */
+			return err;
+		}
+	}
+
+	if (clock)
+		clock->need_setup = false;
 	return 0;
 }
 
 /*
- * snd_usb_endpoint_configure: Configure the endpoint
+ * snd_usb_endpoint_prepare: Prepare the endpoint
  *
  * This function sets up the EP to be fully usable state.
- * It's called either from hw_params or prepare callback.
+ * It's called either from prepare callback.
  * The function checks need_setup flag, and performs nothing unless needed,
  * so it's safe to call this multiple times.
  *
  * This returns zero if unchanged, 1 if the configuration has changed,
  * or a negative error code.
  */
-int snd_usb_endpoint_configure(struct snd_usb_audio *chip,
-			       struct snd_usb_endpoint *ep)
+int snd_usb_endpoint_prepare(struct snd_usb_audio *chip,
+			     struct snd_usb_endpoint *ep)
 {
 	bool iface_first;
 	int err = 0;
@@ -1341,7 +1450,7 @@ int snd_usb_endpoint_configure(struct snd_usb_audio *chip,
 	mutex_lock(&chip->mutex);
 	if (WARN_ON(!ep->iface_ref))
 		goto unlock;
-	if (!ep->need_setup)
+	if (!ep->need_prepare)
 		goto unlock;
 
 	/* If the interface has been already set up, just set EP parameters */
@@ -1350,14 +1459,10 @@ int snd_usb_endpoint_configure(struct snd_usb_audio *chip,
 		 * to update at each EP configuration
 		 */
 		if (ep->cur_audiofmt->protocol == UAC_VERSION_1) {
-			err = snd_usb_init_sample_rate(chip, ep->cur_audiofmt,
-						       ep->cur_rate);
+			err = init_sample_rate(chip, ep);
 			if (err < 0)
 				goto unlock;
 		}
-		err = snd_usb_endpoint_set_params(chip, ep);
-		if (err < 0)
-			goto unlock;
 		goto done;
 	}
 
@@ -1381,11 +1486,7 @@ int snd_usb_endpoint_configure(struct snd_usb_audio *chip,
 	if (err < 0)
 		goto unlock;
 
-	err = snd_usb_init_sample_rate(chip, ep->cur_audiofmt, ep->cur_rate);
-	if (err < 0)
-		goto unlock;
-
-	err = snd_usb_endpoint_set_params(chip, ep);
+	err = init_sample_rate(chip, ep);
 	if (err < 0)
 		goto unlock;
 
@@ -1403,7 +1504,7 @@ int snd_usb_endpoint_configure(struct snd_usb_audio *chip,
 	ep->iface_ref->need_setup = false;
 
  done:
-	ep->need_setup = false;
+	ep->need_prepare = false;
 	err = 1;
 
 unlock:
@@ -1414,15 +1515,15 @@ int snd_usb_endpoint_configure(struct snd_usb_audio *chip,
 /* get the current rate set to the given clock by any endpoint */
 int snd_usb_endpoint_get_clock_rate(struct snd_usb_audio *chip, int clock)
 {
-	struct snd_usb_endpoint *ep;
+	struct snd_usb_clock_ref *ref;
 	int rate = 0;
 
 	if (!clock)
 		return 0;
 	mutex_lock(&chip->mutex);
-	list_for_each_entry(ep, &chip->ep_list, list) {
-		if (ep->cur_clock == clock && ep->cur_rate) {
-			rate = ep->cur_rate;
+	list_for_each_entry(ref, &chip->clock_ref_list, list) {
+		if (ref->clock == clock) {
+			rate = ref->rate;
 			break;
 		}
 	}
@@ -1463,6 +1564,9 @@ int snd_usb_endpoint_start(struct snd_usb_endpoint *ep)
 	if (atomic_inc_return(&ep->running) != 1)
 		return 0;
 
+	if (ep->clock_ref)
+		atomic_inc(&ep->clock_ref->locked);
+
 	ep->active_mask = 0;
 	ep->unlink_mask = 0;
 	ep->phase = 0;
@@ -1572,6 +1676,15 @@ void snd_usb_endpoint_stop(struct snd_usb_endpoint *ep, bool keep_pending)
 		if (ep->sync_source)
 			WRITE_ONCE(ep->sync_source->sync_sink, NULL);
 		stop_urbs(ep, false, keep_pending);
+		if (ep->clock_ref)
+			atomic_dec(&ep->clock_ref->locked);
+
+		if (ep->chip->quirk_flags & QUIRK_FLAG_FORCE_IFACE_RESET &&
+		    usb_pipeout(ep->pipe)) {
+			ep->need_prepare = true;
+			if (ep->iface_ref)
+				ep->iface_ref->need_setup = true;
+		}
 	}
 }
 
@@ -1598,12 +1711,16 @@ void snd_usb_endpoint_free_all(struct snd_usb_audio *chip)
 {
 	struct snd_usb_endpoint *ep, *en;
 	struct snd_usb_iface_ref *ip, *in;
+	struct snd_usb_clock_ref *cp, *cn;
 
 	list_for_each_entry_safe(ep, en, &chip->ep_list, list)
 		kfree(ep);
 
 	list_for_each_entry_safe(ip, in, &chip->iface_ref_list, list)
 		kfree(ip);
+
+	list_for_each_entry_safe(cp, cn, &chip->clock_ref_list, list)
+		kfree(cp);
 }
 
 /*
diff --git a/sound/usb/endpoint.h b/sound/usb/endpoint.h
index daa7ba063d858..c09f68ce08b18 100644
--- a/sound/usb/endpoint.h
+++ b/sound/usb/endpoint.h
@@ -14,11 +14,14 @@ struct snd_usb_endpoint *
 snd_usb_endpoint_open(struct snd_usb_audio *chip,
 		      const struct audioformat *fp,
 		      const struct snd_pcm_hw_params *params,
-		      bool is_sync_ep);
+		      bool is_sync_ep,
+		      bool fixed_rate);
 void snd_usb_endpoint_close(struct snd_usb_audio *chip,
 			    struct snd_usb_endpoint *ep);
-int snd_usb_endpoint_configure(struct snd_usb_audio *chip,
-			       struct snd_usb_endpoint *ep);
+int snd_usb_endpoint_set_params(struct snd_usb_audio *chip,
+				struct snd_usb_endpoint *ep);
+int snd_usb_endpoint_prepare(struct snd_usb_audio *chip,
+			     struct snd_usb_endpoint *ep);
 int snd_usb_endpoint_get_clock_rate(struct snd_usb_audio *chip, int clock);
 
 bool snd_usb_endpoint_compatible(struct snd_usb_audio *chip,
diff --git a/sound/usb/implicit.c b/sound/usb/implicit.c
index f3e8484b3d9cb..4727043fd7458 100644
--- a/sound/usb/implicit.c
+++ b/sound/usb/implicit.c
@@ -15,6 +15,7 @@
 #include "usbaudio.h"
 #include "card.h"
 #include "helper.h"
+#include "pcm.h"
 #include "implicit.h"
 
 enum {
@@ -455,7 +456,8 @@ const struct audioformat *
 snd_usb_find_implicit_fb_sync_format(struct snd_usb_audio *chip,
 				     const struct audioformat *target,
 				     const struct snd_pcm_hw_params *params,
-				     int stream)
+				     int stream,
+				     bool *fixed_rate)
 {
 	struct snd_usb_substream *subs;
 	const struct audioformat *fp, *sync_fmt = NULL;
@@ -469,7 +471,7 @@ snd_usb_find_implicit_fb_sync_format(struct snd_usb_audio *chip,
 	subs = find_matching_substream(chip, stream, target->sync_ep,
 				       target->fmt_type);
 	if (!subs)
-		return sync_fmt;
+		goto end;
 
 	high_score = 0;
 	list_for_each_entry(fp, &subs->fmt_list, list) {
@@ -483,6 +485,9 @@ snd_usb_find_implicit_fb_sync_format(struct snd_usb_audio *chip,
 		}
 	}
 
+ end:
+	if (fixed_rate)
+		*fixed_rate = snd_usb_pcm_has_fixed_rate(subs);
 	return sync_fmt;
 }
 
diff --git a/sound/usb/implicit.h b/sound/usb/implicit.h
index ccb415a0ea860..7f1577b6c4d38 100644
--- a/sound/usb/implicit.h
+++ b/sound/usb/implicit.h
@@ -9,6 +9,6 @@ const struct audioformat *
 snd_usb_find_implicit_fb_sync_format(struct snd_usb_audio *chip,
 				     const struct audioformat *target,
 				     const struct snd_pcm_hw_params *params,
-				     int stream);
+				     int stream, bool *fixed_rate);
 
 #endif /* __USBAUDIO_IMPLICIT_H */
diff --git a/sound/usb/mixer.c b/sound/usb/mixer.c
index 567514832b0df..d818eee53c90a 100644
--- a/sound/usb/mixer.c
+++ b/sound/usb/mixer.c
@@ -1205,6 +1205,13 @@ static void volume_control_quirks(struct usb_mixer_elem_info *cval,
 			cval->res = 16;
 		}
 		break;
+	case USB_ID(0x1bcf, 0x2283): /* NexiGo N930AF FHD Webcam */
+		if (!strcmp(kctl->id.name, "Mic Capture Volume")) {
+			usb_audio_info(chip,
+				"set resolution quirk: cval->res = 16\n");
+			cval->res = 16;
+		}
+		break;
 	}
 }
 
diff --git a/sound/usb/pcm.c b/sound/usb/pcm.c
index de0964dbf7a91..580e2649641e4 100644
--- a/sound/usb/pcm.c
+++ b/sound/usb/pcm.c
@@ -157,6 +157,33 @@ find_substream_format(struct snd_usb_substream *subs,
 			   true, subs);
 }
 
+bool snd_usb_pcm_has_fixed_rate(struct snd_usb_substream *subs)
+{
+	const struct audioformat *fp;
+	struct snd_usb_audio *chip = subs->stream->chip;
+	int rate = -1;
+
+	if (!subs)
+		return false;
+	if (!(chip->quirk_flags & QUIRK_FLAG_FIXED_RATE))
+		return false;
+	list_for_each_entry(fp, &subs->fmt_list, list) {
+		if (fp->rates & SNDRV_PCM_RATE_CONTINUOUS)
+			return false;
+		if (fp->nr_rates < 1)
+			continue;
+		if (fp->nr_rates > 1)
+			return false;
+		if (rate < 0) {
+			rate = fp->rate_table[0];
+			continue;
+		}
+		if (rate != fp->rate_table[0])
+			return false;
+	}
+	return true;
+}
+
 static int init_pitch_v1(struct snd_usb_audio *chip, int ep)
 {
 	struct usb_device *dev = chip->dev;
@@ -433,35 +460,6 @@ static void close_endpoints(struct snd_usb_audio *chip,
 	}
 }
 
-static int configure_endpoints(struct snd_usb_audio *chip,
-			       struct snd_usb_substream *subs)
-{
-	int err;
-
-	if (subs->data_endpoint->need_setup) {
-		/* stop any running stream beforehand */
-		if (stop_endpoints(subs, false))
-			sync_pending_stops(subs);
-		if (subs->sync_endpoint) {
-			err = snd_usb_endpoint_configure(chip, subs->sync_endpoint);
-			if (err < 0)
-				return err;
-		}
-		err = snd_usb_endpoint_configure(chip, subs->data_endpoint);
-		if (err < 0)
-			return err;
-		snd_usb_set_format_quirk(subs, subs->cur_audiofmt);
-	} else {
-		if (subs->sync_endpoint) {
-			err = snd_usb_endpoint_configure(chip, subs->sync_endpoint);
-			if (err < 0)
-				return err;
-		}
-	}
-
-	return 0;
-}
-
 /*
  * hw_params callback
  *
@@ -479,12 +477,14 @@ static int snd_usb_hw_params(struct snd_pcm_substream *substream,
 	struct snd_usb_audio *chip = subs->stream->chip;
 	const struct audioformat *fmt;
 	const struct audioformat *sync_fmt;
+	bool fixed_rate, sync_fixed_rate;
 	int ret;
 
 	ret = snd_media_start_pipeline(subs);
 	if (ret)
 		return ret;
 
+	fixed_rate = snd_usb_pcm_has_fixed_rate(subs);
 	fmt = find_substream_format(subs, hw_params);
 	if (!fmt) {
 		usb_audio_dbg(chip,
@@ -498,7 +498,8 @@ static int snd_usb_hw_params(struct snd_pcm_substream *substream,
 	if (fmt->implicit_fb) {
 		sync_fmt = snd_usb_find_implicit_fb_sync_format(chip, fmt,
 								hw_params,
-								!substream->stream);
+								!substream->stream,
+								&sync_fixed_rate);
 		if (!sync_fmt) {
 			usb_audio_dbg(chip,
 				      "cannot find sync format: ep=0x%x, iface=%d:%d, format=%s, rate=%d, channels=%d\n",
@@ -511,6 +512,7 @@ static int snd_usb_hw_params(struct snd_pcm_substream *substream,
 		}
 	} else {
 		sync_fmt = fmt;
+		sync_fixed_rate = fixed_rate;
 	}
 
 	ret = snd_usb_lock_shutdown(chip);
@@ -530,7 +532,7 @@ static int snd_usb_hw_params(struct snd_pcm_substream *substream,
 		close_endpoints(chip, subs);
 	}
 
-	subs->data_endpoint = snd_usb_endpoint_open(chip, fmt, hw_params, false);
+	subs->data_endpoint = snd_usb_endpoint_open(chip, fmt, hw_params, false, fixed_rate);
 	if (!subs->data_endpoint) {
 		ret = -EINVAL;
 		goto unlock;
@@ -539,7 +541,8 @@ static int snd_usb_hw_params(struct snd_pcm_substream *substream,
 	if (fmt->sync_ep) {
 		subs->sync_endpoint = snd_usb_endpoint_open(chip, sync_fmt,
 							    hw_params,
-							    fmt == sync_fmt);
+							    fmt == sync_fmt,
+							    sync_fixed_rate);
 		if (!subs->sync_endpoint) {
 			ret = -EINVAL;
 			goto unlock;
@@ -553,7 +556,16 @@ static int snd_usb_hw_params(struct snd_pcm_substream *substream,
 	subs->cur_audiofmt = fmt;
 	mutex_unlock(&chip->mutex);
 
-	ret = configure_endpoints(chip, subs);
+	if (!subs->data_endpoint->need_setup)
+		goto unlock;
+
+	if (subs->sync_endpoint) {
+		ret = snd_usb_endpoint_set_params(chip, subs->sync_endpoint);
+		if (ret < 0)
+			goto unlock;
+	}
+
+	ret = snd_usb_endpoint_set_params(chip, subs->data_endpoint);
 
  unlock:
 	if (ret < 0)
@@ -636,9 +648,18 @@ static int snd_usb_pcm_prepare(struct snd_pcm_substream *substream)
 		goto unlock;
 	}
 
-	ret = configure_endpoints(chip, subs);
+	if (subs->sync_endpoint) {
+		ret = snd_usb_endpoint_prepare(chip, subs->sync_endpoint);
+		if (ret < 0)
+			goto unlock;
+	}
+
+	ret = snd_usb_endpoint_prepare(chip, subs->data_endpoint);
 	if (ret < 0)
 		goto unlock;
+	else if (ret > 0)
+		snd_usb_set_format_quirk(subs, subs->cur_audiofmt);
+	ret = 0;
 
 	/* reset the pointer */
 	subs->buffer_bytes = frames_to_bytes(runtime, runtime->buffer_size);
diff --git a/sound/usb/pcm.h b/sound/usb/pcm.h
index 493a4e34d78dc..388fe2ba346d6 100644
--- a/sound/usb/pcm.h
+++ b/sound/usb/pcm.h
@@ -6,6 +6,8 @@ void snd_usb_set_pcm_ops(struct snd_pcm *pcm, int stream);
 int snd_usb_pcm_suspend(struct snd_usb_stream *as);
 int snd_usb_pcm_resume(struct snd_usb_stream *as);
 
+bool snd_usb_pcm_has_fixed_rate(struct snd_usb_substream *as);
+
 int snd_usb_init_pitch(struct snd_usb_audio *chip,
 		       const struct audioformat *fmt);
 void snd_usb_preallocate_buffer(struct snd_usb_substream *subs);
diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
index 03b6a07a2ea05..1226ce5d5a304 100644
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -1765,6 +1765,8 @@ static const struct usb_audio_quirk_flags_table quirk_flags_table[] = {
 		   QUIRK_FLAG_GET_SAMPLE_RATE),
 	DEVICE_FLG(0x04e8, 0xa051, /* Samsung USBC Headset (AKG) */
 		   QUIRK_FLAG_SKIP_CLOCK_SELECTOR | QUIRK_FLAG_CTL_MSG_DELAY_5M),
+	DEVICE_FLG(0x0525, 0xa4ad, /* Hamedal C20 usb camero */
+		   QUIRK_FLAG_IFACE_SKIP_CLOSE),
 	DEVICE_FLG(0x054c, 0x0b8c, /* Sony WALKMAN NW-A45 DAC */
 		   QUIRK_FLAG_SET_IFACE_FIRST),
 	DEVICE_FLG(0x0556, 0x0014, /* Phoenix Audio TMX320VC */
@@ -1786,6 +1788,8 @@ static const struct usb_audio_quirk_flags_table quirk_flags_table[] = {
 	DEVICE_FLG(0x0644, 0x804a, /* TEAC UD-301 */
 		   QUIRK_FLAG_ITF_USB_DSD_DAC | QUIRK_FLAG_CTL_MSG_DELAY |
 		   QUIRK_FLAG_IFACE_DELAY),
+	DEVICE_FLG(0x0644, 0x805f, /* TEAC Model 12 */
+		   QUIRK_FLAG_FORCE_IFACE_RESET),
 	DEVICE_FLG(0x06f8, 0xb000, /* Hercules DJ Console (Windows Edition) */
 		   QUIRK_FLAG_IGNORE_CTL_ERROR),
 	DEVICE_FLG(0x06f8, 0xd002, /* Hercules DJ Console (Macintosh Edition) */
@@ -1806,8 +1810,14 @@ static const struct usb_audio_quirk_flags_table quirk_flags_table[] = {
 		   QUIRK_FLAG_CTL_MSG_DELAY_1M),
 	DEVICE_FLG(0x0b0e, 0x0349, /* Jabra 550a */
 		   QUIRK_FLAG_CTL_MSG_DELAY_1M),
+	DEVICE_FLG(0x0ecb, 0x205c, /* JBL Quantum610 Wireless */
+		   QUIRK_FLAG_FIXED_RATE),
+	DEVICE_FLG(0x0ecb, 0x2069, /* JBL Quantum810 Wireless */
+		   QUIRK_FLAG_FIXED_RATE),
 	DEVICE_FLG(0x0fd9, 0x0008, /* Hauppauge HVR-950Q */
 		   QUIRK_FLAG_SHARE_MEDIA_DEVICE | QUIRK_FLAG_ALIGN_TRANSFER),
+	DEVICE_FLG(0x1224, 0x2a25, /* Jieli Technology USB PHY 2.0 */
+		   QUIRK_FLAG_GET_SAMPLE_RATE),
 	DEVICE_FLG(0x1395, 0x740a, /* Sennheiser DECT */
 		   QUIRK_FLAG_GET_SAMPLE_RATE),
 	DEVICE_FLG(0x1397, 0x0507, /* Behringer UMC202HD */
@@ -1838,6 +1848,10 @@ static const struct usb_audio_quirk_flags_table quirk_flags_table[] = {
 		   QUIRK_FLAG_ITF_USB_DSD_DAC | QUIRK_FLAG_CTL_MSG_DELAY),
 	DEVICE_FLG(0x1901, 0x0191, /* GE B850V3 CP2114 audio interface */
 		   QUIRK_FLAG_GET_SAMPLE_RATE),
+	DEVICE_FLG(0x19f7, 0x0035, /* RODE NT-USB+ */
+		   QUIRK_FLAG_GET_SAMPLE_RATE),
+	DEVICE_FLG(0x1bcf, 0x2283, /* NexiGo N930AF FHD Webcam */
+		   QUIRK_FLAG_GET_SAMPLE_RATE),
 	DEVICE_FLG(0x2040, 0x7200, /* Hauppauge HVR-950Q */
 		   QUIRK_FLAG_SHARE_MEDIA_DEVICE | QUIRK_FLAG_ALIGN_TRANSFER),
 	DEVICE_FLG(0x2040, 0x7201, /* Hauppauge HVR-950Q-MXL */
@@ -1876,6 +1890,12 @@ static const struct usb_audio_quirk_flags_table quirk_flags_table[] = {
 		   QUIRK_FLAG_IGNORE_CTL_ERROR),
 	DEVICE_FLG(0x2912, 0x30c8, /* Audioengine D1 */
 		   QUIRK_FLAG_GET_SAMPLE_RATE),
+	DEVICE_FLG(0x2b53, 0x0023, /* Fiero SC-01 (firmware v1.0.0 @ 48 kHz) */
+		   QUIRK_FLAG_GENERIC_IMPLICIT_FB),
+	DEVICE_FLG(0x2b53, 0x0024, /* Fiero SC-01 (firmware v1.0.0 @ 96 kHz) */
+		   QUIRK_FLAG_GENERIC_IMPLICIT_FB),
+	DEVICE_FLG(0x2b53, 0x0031, /* Fiero SC-01 (firmware v1.1.0) */
+		   QUIRK_FLAG_GENERIC_IMPLICIT_FB),
 	DEVICE_FLG(0x30be, 0x0101, /* Schiit Hel */
 		   QUIRK_FLAG_IGNORE_CTL_ERROR),
 	DEVICE_FLG(0x413c, 0xa506, /* Dell AE515 sound bar */
@@ -1884,16 +1904,6 @@ static const struct usb_audio_quirk_flags_table quirk_flags_table[] = {
 		   QUIRK_FLAG_ALIGN_TRANSFER),
 	DEVICE_FLG(0x534d, 0x2109, /* MacroSilicon MS2109 */
 		   QUIRK_FLAG_ALIGN_TRANSFER),
-	DEVICE_FLG(0x1224, 0x2a25, /* Jieli Technology USB PHY 2.0 */
-		   QUIRK_FLAG_GET_SAMPLE_RATE),
-	DEVICE_FLG(0x2b53, 0x0023, /* Fiero SC-01 (firmware v1.0.0 @ 48 kHz) */
-		   QUIRK_FLAG_GENERIC_IMPLICIT_FB),
-	DEVICE_FLG(0x2b53, 0x0024, /* Fiero SC-01 (firmware v1.0.0 @ 96 kHz) */
-		   QUIRK_FLAG_GENERIC_IMPLICIT_FB),
-	DEVICE_FLG(0x2b53, 0x0031, /* Fiero SC-01 (firmware v1.1.0) */
-		   QUIRK_FLAG_GENERIC_IMPLICIT_FB),
-	DEVICE_FLG(0x0525, 0xa4ad, /* Hamedal C20 usb camero */
-		   QUIRK_FLAG_IFACE_SKIP_CLOSE),
 
 	/* Vendor matches */
 	VENDOR_FLG(0x045e, /* MS Lifecam */
diff --git a/sound/usb/usbaudio.h b/sound/usb/usbaudio.h
index ec06f441e890f..f5a8dca66457f 100644
--- a/sound/usb/usbaudio.h
+++ b/sound/usb/usbaudio.h
@@ -46,6 +46,7 @@ struct snd_usb_audio {
 	struct list_head pcm_list;	/* list of pcm streams */
 	struct list_head ep_list;	/* list of audio-related endpoints */
 	struct list_head iface_ref_list; /* list of interface refcounts */
+	struct list_head clock_ref_list; /* list of clock refcounts */
 	int pcm_devs;
 
 	struct list_head midi_list;	/* list of midi interfaces */
@@ -171,6 +172,12 @@ extern bool snd_usb_skip_validation;
  *  Don't apply implicit feedback sync mode
  * QUIRK_FLAG_IFACE_SKIP_CLOSE
  *  Don't closed interface during setting sample rate
+ * QUIRK_FLAG_FORCE_IFACE_RESET
+ *  Force an interface reset whenever stopping & restarting a stream
+ *  (e.g. after xrun)
+ * QUIRK_FLAG_FIXED_RATE
+ *  Do not set PCM rate (frequency) when only one rate is available
+ *  for the given endpoint.
  */
 
 #define QUIRK_FLAG_GET_SAMPLE_RATE	(1U << 0)
@@ -193,5 +200,7 @@ extern bool snd_usb_skip_validation;
 #define QUIRK_FLAG_GENERIC_IMPLICIT_FB	(1U << 17)
 #define QUIRK_FLAG_SKIP_IMPLICIT_FB	(1U << 18)
 #define QUIRK_FLAG_IFACE_SKIP_CLOSE	(1U << 19)
+#define QUIRK_FLAG_FORCE_IFACE_RESET	(1U << 20)
+#define QUIRK_FLAG_FIXED_RATE		(1U << 21)
 
 #endif /* __USBAUDIO_H */
diff --git a/tools/testing/selftests/net/mptcp/simult_flows.sh b/tools/testing/selftests/net/mptcp/simult_flows.sh
index 752cef1688040..99deb3abb169f 100755
--- a/tools/testing/selftests/net/mptcp/simult_flows.sh
+++ b/tools/testing/selftests/net/mptcp/simult_flows.sh
@@ -289,10 +289,10 @@ done
 
 setup
 run_test 10 10 0 0 "balanced bwidth"
-run_test 10 10 1 50 "balanced bwidth with unbalanced delay"
+run_test 10 10 1 25 "balanced bwidth with unbalanced delay"
 
 # we still need some additional infrastructure to pass the following test-cases
-run_test 30 10 0 0 "unbalanced bwidth"
-run_test 30 10 1 50 "unbalanced bwidth with unbalanced delay"
-run_test 30 10 50 1 "unbalanced bwidth with opposed, unbalanced delay"
+run_test 10 3 0 0 "unbalanced bwidth"
+run_test 10 3 1 25 "unbalanced bwidth with unbalanced delay"
+run_test 10 3 25 1 "unbalanced bwidth with opposed, unbalanced delay"
 exit $ret
diff --git a/tools/testing/selftests/vm/charge_reserved_hugetlb.sh b/tools/testing/selftests/vm/charge_reserved_hugetlb.sh
index 0899019a7fcb4..e14bdd4455f2d 100644
--- a/tools/testing/selftests/vm/charge_reserved_hugetlb.sh
+++ b/tools/testing/selftests/vm/charge_reserved_hugetlb.sh
@@ -1,4 +1,4 @@
-#!/bin/sh
+#!/bin/bash
 # SPDX-License-Identifier: GPL-2.0
 
 # Kselftest framework requirement - SKIP code is 4.
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

