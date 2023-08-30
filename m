Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D299878E026
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 22:16:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344249AbjH3T0z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 15:26:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343648AbjH3QcV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 12:32:21 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC788107
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 09:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=mAQxkF5a0yjShIqw/cpgy8IMetyqgXXhHwgJ+4Sy81U=; b=LMgWMX3mlFxxWgvWbCMtp1+CAP
        Yu/Ex35EU5XMfyyXxutQlpsBdUrPJdKrA1x3bLcuBhAOFAN0LaHjHiy9vteSeyr6z/QhusmGBrLbW
        tPwfX3yrfoA0576ToAQ6ZBmKpr8b51cDbXFuFL2t8h7wXxcKe8q7QPCIxOp+30drQL1/JlnlGTRVq
        CUXqk1knt0TM4yo4dx8T/N4Cy6bEo1tOPeTAd/vrWoPoNPbvF0pgkHLl8Xp/IdxIAIVg8yS7rqFXA
        U2cW0aDmIjnY9BW76wQVDsD7DAa/1BbFg9slcFSog04eNJVGxwkeawNmkidAJY8BEtz0vUPQTPg0v
        5v72nOrQ==;
Received: from [2601:1c2:980:9ec0::2764] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qbO75-00DrCE-2Q;
        Wed, 30 Aug 2023 16:32:15 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     patches@lists.linux.dev, Randy Dunlap <rdunlap@infradead.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Christian Brauner <brauner@kernel.org>
Subject: [PATCH] userns: eliminate many kernel-doc warnings
Date:   Wed, 30 Aug 2023 09:32:15 -0700
Message-ID: <20230830163215.13193-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop the kernel-doc "/**" notation from 8 structs or functions to
prevent 22 kernel-doc warnings  (samples below).

user_namespace.c:239: warning: Function parameter or member 'map_up' not described in 'idmap_key'
user_namespace.c:246: warning: Function parameter or member 'k' not described in 'cmp_map_id'
user_namespace.c:277: warning: Function parameter or member 'extents' not described in 'map_id_range_down_max'
user_namespace.c:295: warning: Function parameter or member 'extents' not described in 'map_id_range_down_base'
user_namespace.c:344: warning: Function parameter or member 'extents' not described in 'map_id_up_base'
user_namespace.c:364: warning: Function parameter or member 'extents' not described in 'map_id_up_max'
user_namespace.c:776: warning: Function parameter or member 'map' not described in 'insert_extent'
user_namespace.c:844: warning: Function parameter or member 'map' not described in 'sort_idmaps'

Fixes: 6397fac4915a ("userns: bump idmap limits to 340")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Eric Biederman <ebiederm@xmission.com>
Cc: Christian Brauner <brauner@kernel.org>
---
 kernel/user_namespace.c |   16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff -- a/kernel/user_namespace.c b/kernel/user_namespace.c
--- a/kernel/user_namespace.c
+++ b/kernel/user_namespace.c
@@ -228,7 +228,7 @@ void __put_user_ns(struct user_namespace
 }
 EXPORT_SYMBOL(__put_user_ns);
 
-/**
+/*
  * struct idmap_key - holds the information necessary to find an idmapping in a
  * sorted idmap array. It is passed to cmp_map_id() as first argument.
  */
@@ -238,7 +238,7 @@ struct idmap_key {
 	u32 count; /* == 0 unless used with map_id_range_down() */
 };
 
-/**
+/*
  * cmp_map_id - Function to be passed to bsearch() to find the requested
  * idmapping. Expects struct idmap_key to be passed via @k.
  */
@@ -268,7 +268,7 @@ static int cmp_map_id(const void *k, con
 	return 1;
 }
 
-/**
+/*
  * map_id_range_down_max - Find idmap via binary search in ordered idmap array.
  * Can only be called if number of mappings exceeds UID_GID_MAP_MAX_BASE_EXTENTS.
  */
@@ -285,7 +285,7 @@ map_id_range_down_max(unsigned extents,
 		       sizeof(struct uid_gid_extent), cmp_map_id);
 }
 
-/**
+/*
  * map_id_range_down_base - Find idmap via binary search in static extent array.
  * Can only be called if number of mappings is equal or less than
  * UID_GID_MAP_MAX_BASE_EXTENTS.
@@ -334,7 +334,7 @@ static u32 map_id_down(struct uid_gid_ma
 	return map_id_range_down(map, id, 1);
 }
 
-/**
+/*
  * map_id_up_base - Find idmap via binary search in static extent array.
  * Can only be called if number of mappings is equal or less than
  * UID_GID_MAP_MAX_BASE_EXTENTS.
@@ -355,7 +355,7 @@ map_id_up_base(unsigned extents, struct
 	return NULL;
 }
 
-/**
+/*
  * map_id_up_max - Find idmap via binary search in ordered idmap array.
  * Can only be called if number of mappings exceeds UID_GID_MAP_MAX_BASE_EXTENTS.
  */
@@ -767,7 +767,7 @@ static bool mappings_overlap(struct uid_
 	return false;
 }
 
-/**
+/*
  * insert_extent - Safely insert a new idmap extent into struct uid_gid_map.
  * Takes care to allocate a 4K block of memory if the number of mappings exceeds
  * UID_GID_MAP_MAX_BASE_EXTENTS.
@@ -836,7 +836,7 @@ static int cmp_extents_reverse(const voi
 	return 0;
 }
 
-/**
+/*
  * sort_idmaps - Sorts an array of idmap entries.
  * Can only be called if number of mappings exceeds UID_GID_MAP_MAX_BASE_EXTENTS.
  */
