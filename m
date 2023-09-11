Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DDD379AF32
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 01:46:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242641AbjIKU6J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 16:58:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244506AbjIKUi7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 16:38:59 -0400
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65688127;
        Mon, 11 Sep 2023 13:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
        ; s=x; h=Subject:Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Cc:To
        :From:subject:date:message-id:reply-to;
        bh=TLJ2bc/snhPLEcNROaiK2c5oF2wkJhqsS7gx9Br7BU8=; b=B6T9RrhySsq6SSgeW/VSamHn2J
        FA+hjYw88EPbe3YEATYM2wTvQC4oSswvqDHjsb24NYeWybhPGAIMNcH4LEPLC62WNiVHl+47FLTa7
        9BbjvaXJHnGNwWyz9JnM8eLQRQRAmaUAhz6+JBQsVkpk9fN7qcmiMNZFKwua1xR0wyZ8=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:60746 helo=pettiford.lan)
        by mail.hugovil.com with esmtpa (Exim 4.92)
        (envelope-from <hugo@hugovil.com>)
        id 1qfngG-0005zL-RE; Mon, 11 Sep 2023 16:38:49 -0400
From:   Hugo Villeneuve <hugo@hugovil.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     hugo@hugovil.com, Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        stable@vger.kernel.org, workflows@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 11 Sep 2023 16:36:30 -0400
Message-Id: <20230911203628.20068-1-hugo@hugovil.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 70.80.174.168
X-SA-Exim-Mail-From: hugo@hugovil.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH v2] Documentation: stable: clarify patch series prerequisites
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

Add some clarifications for patches that have dependencies within the
patch series.

Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
---
Changes since v1: rebase on latest torvalds/master

 Documentation/process/stable-kernel-rules.rst | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/Documentation/process/stable-kernel-rules.rst b/Documentation/process/stable-kernel-rules.rst
index 41f1e07abfdf..1704f1c686d0 100644
--- a/Documentation/process/stable-kernel-rules.rst
+++ b/Documentation/process/stable-kernel-rules.rst
@@ -101,6 +101,19 @@ comment:
      git cherry-pick fd21073
      git cherry-pick <this commit>
 
+   Note that for a patch series, you do not have to list as prerequisites the
+   patches present in the series itself. For example, if you have the following
+   patch series:
+
+   .. code-block:: none
+
+     patch1
+     patch2
+
+   where patch2 depends on patch1, you do not have to list patch1 as
+   prerequisite of patch2 if you have already marked patch1 for stable
+   inclusion.
+
  * For patches that may have kernel version prerequisites specify them using
    the following format in the sign-off area:
 

base-commit: 0bb80ecc33a8fb5a682236443c1e740d5c917d1d
-- 
2.30.2

