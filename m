Return-Path: <linux-kernel+bounces-23073-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 565EF82A74C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 06:43:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC7F7289A21
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 05:43:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B1812106;
	Thu, 11 Jan 2024 05:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="BZ6FIXfw"
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.7])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1205620E0
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 05:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Subject:Date:Message-Id; bh=CIiKcgzxPMZ8uXTepi
	Qzs/+KtYuuMjNy2tKnVKnI3W8=; b=BZ6FIXfwsgEwKlXe1AsxtOW4wJy99p9se0
	rXcfSZuqsKmG5GvUQnzByYhWPnC6YnglPjKxqJUZsFPRA7LWDy0EcVrRqrtGk9oa
	bpoHaGwKhr7xpIiCqxJrmLWyRbQlmNb8sTWOwgBFhWJmxsdQ0X3ZjqnjERpzeP9g
	lpGTr7UBo=
Received: from localhost.localdomain (unknown [182.148.14.173])
	by gzga-smtp-mta-g0-4 (Coremail) with SMTP id _____wDXH5HWf59lRw+gAA--.16881S2;
	Thu, 11 Jan 2024 13:42:47 +0800 (CST)
From: chenxuebing <chenxb_99091@126.com>
To: daniel@ffwll.ch,
	alexander.deucher@amd.com,
	airlied@gmail.com,
	Xinhui.Pan@amd.com,
	christian.koenig@amd.com
Cc: amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	chenxuebing <chenxb_99091@126.com>
Subject: [PATCH] drm/amdgpu: Clean up errors in discovery.h
Date: Thu, 11 Jan 2024 05:42:45 +0000
Message-Id: <20240111054245.8258-1-chenxb_99091@126.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID:_____wDXH5HWf59lRw+gAA--.16881S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxCw4fXFyDWryUWF17Cr4kZwb_yoW5ArWxpF
	s3JFnrKF45JFyIgr17Xrs3Zr43t397Ka48GFyq934Sgr4j9r18ta4rtF4YkFyYga48WwnF
	qw1ktw15Aan7u3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UUxhLUUUUU=
X-CM-SenderInfo: hfkh05lebzmiizr6ij2wof0z/1tbiGBdixWVLZWY47gAAsT
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Fix the following errors reported by checkpatch:

ERROR: open brace '{' following struct go on the same line
ERROR: "foo* bar" should be "foo *bar"

Signed-off-by: chenxuebing <chenxb_99091@126.com>
---
 drivers/gpu/drm/amd/include/discovery.h | 32 +++++++++----------------
 1 file changed, 11 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/amd/include/discovery.h b/drivers/gpu/drm/amd/include/discovery.h
index 7a9d473d0917..4a8b9eabcf03 100644
--- a/drivers/gpu/drm/amd/include/discovery.h
+++ b/drivers/gpu/drm/amd/include/discovery.h
@@ -32,8 +32,7 @@
 #define VCN_INFO_TABLE_ID               0x004E4356
 #define MALL_INFO_TABLE_ID              0x4C4C414D
 
-typedef enum
-{
+typedef enum {
 	IP_DISCOVERY = 0,
 	GC,
 	HARVEST_INFO,
@@ -45,16 +44,14 @@ typedef enum
 
 #pragma pack(1)
 
-typedef struct table_info
-{
+typedef struct table_info {
 	uint16_t offset;   /* Byte offset */
 	uint16_t checksum; /* Byte sum of the table */
 	uint16_t size;     /* Table size */
 	uint16_t padding;
 } table_info;
 
-typedef struct binary_header
-{
+typedef struct binary_header {
 	/* psp structure should go at the top of this structure */
 	uint32_t binary_signature; /* 0x7, 0x14, 0x21, 0x28 */
 	uint16_t version_major;
@@ -64,15 +61,13 @@ typedef struct binary_header
 	table_info table_list[TOTAL_TABLES];
 } binary_header;
 
-typedef struct die_info
-{
+typedef struct die_info {
 	uint16_t die_id;
 	uint16_t die_offset; /* Points to the corresponding die_header structure */
 } die_info;
 
 
-typedef struct ip_discovery_header
-{
+typedef struct ip_discovery_header {
 	uint32_t signature;    /* Table Signature */
 	uint16_t version;      /* Table Version */
 	uint16_t size;         /* Table Size */
@@ -89,8 +84,7 @@ typedef struct ip_discovery_header
 	};
 } ip_discovery_header;
 
-typedef struct ip
-{
+typedef struct ip {
 	uint16_t hw_id;           /* Hardware ID */
 	uint8_t number_instance;  /* instance of the IP */
 	uint8_t num_base_address; /* Number of Base Addresses */
@@ -107,8 +101,7 @@ typedef struct ip
 	uint32_t base_address[]; /* variable number of Addresses */
 } ip;
 
-typedef struct ip_v3
-{
+typedef struct ip_v3 {
 	uint16_t hw_id;                         /* Hardware ID */
 	uint8_t instance_number;                /* Instance number for the IP */
 	uint8_t num_base_address;               /* Number of base addresses*/
@@ -145,15 +138,13 @@ typedef struct ip_v4 {
 	} __packed;
 } ip_v4;
 
-typedef struct die_header
-{
+typedef struct die_header {
 	uint16_t die_id;
 	uint16_t num_ips;
 } die_header;
 
-typedef struct ip_structure
-{
-	ip_discovery_header* header;
+typedef struct ip_structure {
+	ip_discovery_header *header;
 	struct die
 	{
 		die_header *die_header;
@@ -357,8 +348,7 @@ struct vcn_info_header {
     uint32_t size_bytes; /* size of the entire header+data in bytes */
 };
 
-struct vcn_instance_info_v1_0
-{
+struct vcn_instance_info_v1_0 {
 	uint32_t instance_num; /* VCN IP instance number. 0 - VCN0; 1 - VCN1 etc*/
 	union _fuse_data {
 		struct {
-- 
2.17.1


