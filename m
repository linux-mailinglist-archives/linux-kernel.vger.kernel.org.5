Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B97A3775DE6
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 13:42:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234265AbjHILmX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 07:42:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234257AbjHILmW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 07:42:22 -0400
Received: from codesynthesis.com (codesynthesis.com [188.40.148.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED5BA1FD7;
        Wed,  9 Aug 2023 04:42:20 -0700 (PDT)
Received: from brak.codesynthesis.com (unknown [105.186.254.141])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by codesynthesis.com (Postfix) with ESMTPSA id F300D60A1A;
        Wed,  9 Aug 2023 11:42:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codesynthesis.com;
        s=mail1; t=1691581339;
        bh=mNlyqB5yts1AOpAZia1Vu/YeLCc1TDFTbjdAqP8a2Kk=;
        h=From:To:Subject:Date:Message-Id:MIME-Version:From;
        b=Xb//GZcHGqYeS0Loid3wM0yE+43W70N6amIP/rDBFCdGlU7paZszTbaV6sY87rJ6f
         iUQ9P3F+LXRYqa5J/zjhaROdx/BiyuUirwk1TnA2nE48scxEwlsDtN6nwwu/SJjxnd
         YwWOZydA3k84gljcQMcLWltnVeCA9NJlKrJrr0nCsma2ED8KD0FnsKJGF4m7hK0bJe
         b0UPZJh08//cg70gjQ9eOHR7b257GD0l/BrYKEkdmTfTS50FkqlEAsNusDi6mhsrzH
         92XPeI/Gk/xBK8hp8hX4gA3W/A2DhxQLHTg9s21KqrZA412NCVy5+3J4uHdrfHuj/j
         jzroqN2pH9zwQ==
Received: by brak.codesynthesis.com (Postfix, from userid 1000)
        id 58A2B145D38; Wed,  9 Aug 2023 13:42:50 +0200 (SAST)
From:   Boris Kolpackov <boris@codesynthesis.com>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Boris Kolpackov <boris@codesynthesis.com>
Subject: [PATCH v3 0/1] kconfig: port qconf to work with Qt6 in addition to Qt5
Date:   Wed,  9 Aug 2023 13:42:30 +0200
Message-Id: <20230809114231.2533523-1-boris@codesynthesis.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch ports qconf to work with Qt6 in addition to latest Qt5. Tested
with Qt5 5.15 and Qt6 6.4. Note that earlier versions of Qt5 are no longer
guaranteed to work.

Compared to the v1 patch version, v2 also changes qconf-cfg.sh to first look
for Qt6 and fallback to Qt5.

Compared to the v2 patch version, v3 forces C++17 in qconf-cfg.sh for Qt6.

Signed-off-by: Boris Kolpackov <boris@codesynthesis.com>

Boris Kolpackov (1):
  kconfig: port qconf to work with Qt6 in addition to Qt5

 scripts/kconfig/qconf-cfg.sh | 25 +++++++++++++++-------
 scripts/kconfig/qconf.cc     | 40 +++++++++++++++++++++++-------------
 2 files changed, 44 insertions(+), 21 deletions(-)

--
2.40.1
