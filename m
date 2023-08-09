Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A63FE77650B
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 18:30:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230264AbjHIQaP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 12:30:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjHIQaO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 12:30:14 -0400
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27BF110F3;
        Wed,  9 Aug 2023 09:30:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
        ; s=x; h=Subject:Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Cc:To
        :From:subject:date:message-id:reply-to;
        bh=8EndxSmp6Qjc7xVkBhqjKI56UjhvwBrDojnvq5YdZ8g=; b=OomtjgrQg2ER400pMoM+eD70hF
        Zc7KqgU/GHRE9bCuQ80pzkUudQTOJ3g8x1rWJsKWebFSghMNhhJbQxOch+RYVi2kYiq314fn5IAHr
        lkbtzoEmWisQ5i+T2jNwccCpEPC0yoPCXFYdpKp1+Dmr6QYecVwyuAPQrYFL9C7zpZ2I=;
Received: from modemcable061.19-161-184.mc.videotron.ca ([184.161.19.61]:60908 helo=localhost.localdomain)
        by mail.hugovil.com with esmtpa (Exim 4.92)
        (envelope-from <hugo@hugovil.com>)
        id 1qTm4V-0004S3-Bd; Wed, 09 Aug 2023 12:30:07 -0400
From:   Hugo Villeneuve <hugo@hugovil.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     hugo@hugovil.com, andy.shevchenko@gmail.com,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        stable@vger.kernel.org, workflows@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed,  9 Aug 2023 12:29:42 -0400
Message-Id: <20230809162941.7769-1-hugo@hugovil.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 184.161.19.61
X-SA-Exim-Mail-From: hugo@hugovil.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
Subject: [PATCH] Documentation: stable: clarify patch series prerequisites
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
This patch was made after some discussions I had with Greg and Andy when
submitting a series of patches for stable inclusion:

Link: https://lkml.org/lkml/2023/8/4/21

 Documentation/process/stable-kernel-rules.rst | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/process/stable-kernel-rules.rst b/Documentation/process/stable-kernel-rules.rst
index 51df1197d5ab..1c38ee009ed4 100644
--- a/Documentation/process/stable-kernel-rules.rst
+++ b/Documentation/process/stable-kernel-rules.rst
@@ -124,6 +124,18 @@ The tag sequence has the meaning of:
      git cherry-pick fd21073
      git cherry-pick <this commit>
 
+Note that for a patch series, you do not have to list as prerequisites the
+patches present in the series itself. For example, if you have the following
+patch series:
+
+.. code-block:: none
+
+     patch1
+     patch2
+
+where patch2 depends on patch1, you do not have to list patch1 as prerequisite
+of patch2 if you have already marked patch1 for stable inclusion.
+
 Also, some patches may have kernel version prerequisites.  This can be
 specified in the following format in the sign-off area:
 

base-commit: 13b9372068660fe4f7023f43081067376582ef3c
-- 
2.30.2

