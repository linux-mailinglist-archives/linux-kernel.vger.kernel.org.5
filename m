Return-Path: <linux-kernel+bounces-71344-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B47085A3C0
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 13:47:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FD911C20A54
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 12:47:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFD442E83C;
	Mon, 19 Feb 2024 12:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b="rhOFZ7Su"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8631021103
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 12:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708346866; cv=none; b=IpEyf7rWEix0lUIi+KhNwZE1rOXw78IR5OiVrVFfbZOXUqo8vfEpYQAt5bNeZ+jGMXqYWDFajXJr8Ra1eL2xs4JaXdIfC2sGTksgmpmholBEB2E//Eaoguqs1UmiETQU8DmAdUCpOrfLwLGVJaW8ZTgpig1phn5SwhM67/w/0+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708346866; c=relaxed/simple;
	bh=Iu1hCL+k4RywacCt7yHfC9UxHzlI5KmI/z6GqVzTwfU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=EqcO+qbsGQCiaWWRiruId0c9bFkLEkaMQLQy/11nuAyh3UJE61NFbo5KQ0WKYuBtpZsNbqS4yiydHQkpUgN/PLgFMKSkATbuCu8Xp2HGGBzmfdxXjWA7DXZL8ZL3ILUUqhJAbV4Xd121mUajlxnMLubIrZhb8Xz6wOw5VQ5cZsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b=rhOFZ7Su; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1db6e0996ceso30899925ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 04:47:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708346864; x=1708951664;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:dkim-signature:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gg3plRH7tWyzTAZ8Yu9B+GKyBHwf2UTvxQ8qRJa7aGU=;
        b=v0icHV+7Ybbo586GQB8WthhMMOoNf6CLXzdoN93GGeWIdkkDi95vSLYqR4+kND2S5M
         zYJhEKm/BHKRgF2VKnUaNiOptpoUuDpNbL8TLiEOApuSp3GG+b/qMJdU/+ckBbIUBdlx
         4lPfhfMhfHB58v4QiFv5Kcgqr5usGCNV1dI4jMaOdoma1Kyr93UhCCQbla0tyuYU8Jpc
         G4fwNPYxjGOVBeufWzWCuLyKl67DmEJLFu1265YprOi/NVU/PiruDDTupPiXouBKZfCW
         d2Q4sUwGsAiAZQ2h/TBOmSJh1VZDLCVqxzWui0QoupGi8bDWzkLOtd1EjG/CRoNEVe3C
         12pA==
X-Gm-Message-State: AOJu0Yzs/JoUHRSEsw+H7OyM+jGF6VXJmZW7E8kvtQf38TiR6wk+xTw7
	RCywA8rU4HLZdyeqG9s2UIM9eM5uk++EcQpLKml5GLaJsys/GEi/
X-Google-Smtp-Source: AGHT+IGa+hW9W8mTxrgHkHRYZIA6TnHooumab8PXDXh2eJd53Plj2q7fVyxx6ECL3+Id61wL63HM8Q==
X-Received: by 2002:a17:903:32c9:b0:1dc:147:18b4 with SMTP id i9-20020a17090332c900b001dc014718b4mr1415416plr.35.1708346863627;
        Mon, 19 Feb 2024 04:47:43 -0800 (PST)
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id w16-20020a1709029a9000b001db7ee44ff9sm4267296plp.263.2024.02.19.04.47.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Feb 2024 04:47:43 -0800 (PST)
From: "Ricardo B. Marliere" <ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2024; t=1708346862;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Gg3plRH7tWyzTAZ8Yu9B+GKyBHwf2UTvxQ8qRJa7aGU=;
	b=rhOFZ7SuDz3me12MyZ0YJo8WqLiQIxeHeLLsrKmiUgH+/GB0kmnDKgeW0r/sNlTdIo26cm
	fuUify7jUzdDVhcAzUt0AkEAo9sNmWeIeJb59hFNf3cu7AmegGBT9xmvHn/R0PKlR9lNCG
	QBwhwUWnNwH1zY0dokj9p7lQMus+wAdbsj8kLEOA0Is+CjdO2R77pQ4sgJdb7PBOxoe72W
	LVgfRUVeeN7xxwkSnESta2K9xnhlTJJdSnGbZybGpMMZgdH63zCNRVUNBMPog2jQwnRX4T
	n28ciFD8oT9K/8fHHHlX5bGXR+nnFL+y0PlPd9VftqkoYxsTIqILU6jStjiINQ==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
Date: Mon, 19 Feb 2024 09:48:27 -0300
Subject: [PATCH] intel_th: constify the struct device_type usage
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240219-device_cleanup-intel_th-v1-1-f4f62c2a298c@marliere.net>
X-B4-Tracking: v=1; b=H4sIABpO02UC/x2MXQqAIBAGrxL7nKAS9HOViBD3qxbCQiuC6O5Jj
 wMz81BCFCTqiociLkmyhQymLMgvLsxQwpnJaltpa1rFWfIY/QoXzl1JOLCOx6LYT85YzTU3oFz
 vEZPc/7kf3vcDXqavrmkAAAA=
To: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Ricardo B. Marliere" <ricardo@marliere.net>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2220; i=ricardo@marliere.net;
 h=from:subject:message-id; bh=Iu1hCL+k4RywacCt7yHfC9UxHzlI5KmI/z6GqVzTwfU=;
 b=owEBbQKS/ZANAwAKAckLinxjhlimAcsmYgBl004cxu1xtF+rf8sDCfU0/Txb6MJV914fFwH6K
 Ig9KII5GOSJAjMEAAEKAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZdNOHAAKCRDJC4p8Y4ZY
 prOdD/9IDJNVyu6OvuHykrwTS4h3yNlJhouPUPNIPNVGSBW9UIiyA2w6o2PFJSg1HLFtoBAsKom
 7KvEXfORBAxpvSl4b3zKoEE2Ua58/T72rQO6Qg3dY4uKISieWIccWwRgGR0e8C56OPglq+By07u
 kpeiEe23BA3ySZfUzowtmQlBZI7ULM54PnohcjMc1GHn6k7Nu19YZNbgU3fuBBXY2VWPXp3oIMW
 Q3qCtHN6umcyMEycjk6sr9sr0rRTCmLDQf08qod7J+dNaGtIY0GOxxdKz4PkjI36o3YUYbcjRWS
 8MAOXo66i1qE/vW5Dcepye4XTKSFLjGDVDbGFqCQb1T0oJYBnoWAZCmSvhK+5Zo+/jiqtNvKTDr
 2hsRllHgMhc2ziNsi6wPf6exRUXe+FnJcPH06LsDrY0OJeqaXmm878UMMIyDasRYHq58tKvHQP9
 FgcTZa30jCsmOejJspEitkUPFzTHa3/l+Cq+CbPrUkU0qs2LvQy8RLpjFc7KJlbBnNGeMwhuekr
 4kVg7n7yt16oDPAaGu1izyEmxBv/rGgH8aO2k8QooAqOZb13FjWqVNRpU/IaqHb8JVU2UC9HNDJ
 AoZNvVVC74hHgh7NxTf3LTtAJwhr6ZSzvhT/jzwNS0koiyvYJqQvIs9qQbYjt0CzlRQsTLlkKLq
 k0bP2OAj0222iOA==
X-Developer-Key: i=ricardo@marliere.net; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6

Since commit aed65af1cc2f ("drivers: make device_type const"), the driver
core can properly handle constant struct device_type. Move the
intel_th_source_device_type, intel_th_output_device_type,
intel_th_switch_device_type and intel_th_device_type variables to be
constant structures as well, placing it into read-only memory which can not
be modified at runtime.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
---
 drivers/hwtracing/intel_th/core.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/hwtracing/intel_th/core.c b/drivers/hwtracing/intel_th/core.c
index cc7f879bb175..3511f3618f2d 100644
--- a/drivers/hwtracing/intel_th/core.c
+++ b/drivers/hwtracing/intel_th/core.c
@@ -180,7 +180,7 @@ static void intel_th_device_release(struct device *dev)
 	intel_th_device_free(to_intel_th_device(dev));
 }
 
-static struct device_type intel_th_source_device_type = {
+static const struct device_type intel_th_source_device_type = {
 	.name		= "intel_th_source_device",
 	.release	= intel_th_device_release,
 };
@@ -333,19 +333,19 @@ static struct attribute *intel_th_output_attrs[] = {
 
 ATTRIBUTE_GROUPS(intel_th_output);
 
-static struct device_type intel_th_output_device_type = {
+static const struct device_type intel_th_output_device_type = {
 	.name		= "intel_th_output_device",
 	.groups		= intel_th_output_groups,
 	.release	= intel_th_device_release,
 	.devnode	= intel_th_output_devnode,
 };
 
-static struct device_type intel_th_switch_device_type = {
+static const struct device_type intel_th_switch_device_type = {
 	.name		= "intel_th_switch_device",
 	.release	= intel_th_device_release,
 };
 
-static struct device_type *intel_th_device_type[] = {
+static const struct device_type *intel_th_device_type[] = {
 	[INTEL_TH_SOURCE]	= &intel_th_source_device_type,
 	[INTEL_TH_OUTPUT]	= &intel_th_output_device_type,
 	[INTEL_TH_SWITCH]	= &intel_th_switch_device_type,

---
base-commit: b401b621758e46812da61fa58a67c3fd8d91de0d
change-id: 20240219-device_cleanup-intel_th-dcfa120d7d8e

Best regards,
-- 
Ricardo B. Marliere <ricardo@marliere.net>


