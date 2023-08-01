Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6380B76B6CD
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 16:07:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232180AbjHAOHh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 10:07:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234492AbjHAOHQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 10:07:16 -0400
Received: from codesynthesis.com (codesynthesis.com [188.40.148.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D48C02737;
        Tue,  1 Aug 2023 07:06:53 -0700 (PDT)
Received: from brak.codesynthesis.com (unknown [105.186.254.141])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by codesynthesis.com (Postfix) with ESMTPSA id A3B2260C40;
        Tue,  1 Aug 2023 14:06:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codesynthesis.com;
        s=mail1; t=1690898811;
        bh=xVggXhNc2Ajzm0Bx4WEAG+Q+rNDr2mVgRoC0ifaCs3Q=;
        h=From:To:Subject:Date:Message-Id:MIME-Version:From;
        b=VpM5oZhfBevNTsP9Z287jSlUnVjOwM9iGNK57odLd0kA51rFYP3jDCb+5fZ+XEeD/
         833sqLqFZAGZA1oKVmrhoK/ovBLyq6q9q4/zymPmEPtEBApNIhzD8v3UPojQ6AOUvz
         UsIw0VvnWL5Vjy06h0/X0vd6N0zjh9Min331ocC9WIxO4q1Bn9xdMie3+Aab0R2AxN
         aWRSzozZhJqUNJODHxlkDwSPVpFskMdgKSbtYe5Qcftn/JZyI4VtpwvD9cp7nVPw3H
         8f0Pa4ersG5YyISDodq9Ez9HpsXnEeNY6xs1clyaAjp/pfmhNlQhYzYtj5ATKd1LNq
         tAT8Hdr2zwxtA==
Received: by brak.codesynthesis.com (Postfix, from userid 1000)
        id C5EED1457E0; Tue,  1 Aug 2023 16:07:19 +0200 (SAST)
From:   Boris Kolpackov <boris@codesynthesis.com>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Boris Kolpackov <boris@codesynthesis.com>
Subject: [PATCH v2 0/1] kconfig: port qconf to work with Qt6 in addition to Qt5
Date:   Tue,  1 Aug 2023 16:06:56 +0200
Message-Id: <20230801140657.1324086-1-boris@codesynthesis.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
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

Signed-off-by: Boris Kolpackov <boris@codesynthesis.com>

Boris Kolpackov (1):
  kconfig: port qconf to work with Qt6 in addition to Qt5

 scripts/kconfig/qconf-cfg.sh | 23 ++++++++++++++-------
 scripts/kconfig/qconf.cc     | 40 +++++++++++++++++++++++-------------
 2 files changed, 42 insertions(+), 21 deletions(-)

--
2.40.1
