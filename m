Return-Path: <linux-kernel+bounces-10305-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C4DD81D260
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 06:08:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F3E31C227E0
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 05:08:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CB9DB663;
	Sat, 23 Dec 2023 05:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Q3OLSM8T"
X-Original-To: linux-kernel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85181BA32;
	Sat, 23 Dec 2023 05:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=keHgqFhOWpkH/zEjvcku1aRyCcDuntkNgDFAa7/rreE=; b=Q3OLSM8Tz+7dqXrI0CH7bRQnTK
	/xJHXyhWiqPglbzoRAaxVJJGMqfq1JIVcDxTAUN9LPCeCNe6pJn1nquAdYX9JYRt69lch6H3aMIJO
	6SYTPORN1GN4E37wJNz0/8gIDk2yBMqMq+L2eV4r58Q/kKiTky7PQ1aTT5uug/GoJmBsuyDaWe++n
	bvh6G6msXr2hzPsyOpzKGnY0Ev/2aJDRXyvnG7n1aiLWYN12KOy8K0FCeC4GGoJ97Z7X+8xPr2aut
	btrz3i/HVS9v5pYBMngygzcEDLhdLzuxCDQpSHaWmynpX1MZfN2ApxaYpSosZHBHs+foqRqe8m0sV
	OHf/LKKw==;
Received: from [50.53.46.231] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rGuE8-007Ory-08;
	Sat, 23 Dec 2023 05:07:10 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	linux-media@vger.kernel.org
Subject: [PATCH] media: media-entity.h: fix Excess kernel-doc description warnings
Date: Fri, 22 Dec 2023 21:07:07 -0800
Message-ID: <20231223050707.14091-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove the @major: and @minor: lines to prevent the kernel-doc warnings:

include/media/media-entity.h:376: warning: Excess struct member 'major' description in 'media_entity'
include/media/media-entity.h:376: warning: Excess struct member 'minor' description in 'media_entity'

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org
---
 include/media/media-entity.h |    4 ----
 1 file changed, 4 deletions(-)

diff -- a/include/media/media-entity.h b/include/media/media-entity.h
--- a/include/media/media-entity.h
+++ b/include/media/media-entity.h
@@ -337,10 +337,6 @@ enum media_entity_type {
  * @info.dev:	Contains device major and minor info.
  * @info.dev.major: device node major, if the device is a devnode.
  * @info.dev.minor: device node minor, if the device is a devnode.
- * @major:	Devnode major number (zero if not applicable). Kept just
- *		for backward compatibility.
- * @minor:	Devnode minor number (zero if not applicable). Kept just
- *		for backward compatibility.
  *
  * .. note::
  *

