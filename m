Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9A6B75ECB6
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 09:46:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230330AbjGXHq1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 03:46:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbjGXHqZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 03:46:25 -0400
Received: from codesynthesis.com (codesynthesis.com [188.40.148.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E3BB1A1;
        Mon, 24 Jul 2023 00:46:23 -0700 (PDT)
Received: from brak.codesynthesis.com (unknown [105.186.254.141])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by codesynthesis.com (Postfix) with ESMTPSA id E81D960C3E;
        Mon, 24 Jul 2023 07:46:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codesynthesis.com;
        s=mail1; t=1690184781;
        bh=4cU059ydZOLnzVOI8ThUTxWFlG61H8gBw++F2PtMlps=;
        h=From:To:Subject:Date:Message-Id:MIME-Version:From;
        b=mFzxorf3wT7KIkZN4yKEBeFYdN0VSCeMjFIQmLJvkRzGTnEfDrHU9AFGRgooGFVNV
         25iSlA707AOES4ft4uSitffkbIwToN1F8l+nks0xNKAyGLwluA7uRuCse1W9b2oF9S
         JVzmj3vhM7e3rJMRCQds51puqr2kKOv1VbDT377E6y4cm39TcnA5NJSxozlMvfAlE2
         MRdjM6XkHD04/iSVmwnJdZDYstwBglCKHVcWnZzcWCGZ4+HSBtzj0p6EAUkZLCwRFu
         DYFAEbQAAjhDboH97KU1GByllNxx6Q2TemcGnD7miirlujmVZhQKXeCZ2ZkagdvEJa
         r9cCFDGGID8SQ==
Received: by brak.codesynthesis.com (Postfix, from userid 1000)
        id 07A7E142D4E; Mon, 24 Jul 2023 09:46:46 +0200 (SAST)
From:   Boris Kolpackov <boris@codesynthesis.com>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Boris Kolpackov <boris@codesynthesis.com>
Subject: [PATCH 0/1] kconfig: port qconf to work with Qt6 in addition to Qt5
Date:   Mon, 24 Jul 2023 09:46:24 +0200
Message-Id: <20230724074625.458456-1-boris@codesynthesis.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch ports qconf to work with Qt6 in addition to latest Qt5. Tested
with Qt5 5.15 and Qt6 6.4. Note that earlier versions of Qt5 are no longer
guaranteed to work.

Signed-off-by: Boris Kolpackov <boris@codesynthesis.com>

Boris Kolpackov (1):
  kconfig: port qconf to work with Qt6 in addition to Qt5

 scripts/kconfig/qconf.cc | 40 ++++++++++++++++++++++++++--------------
 1 file changed, 26 insertions(+), 14 deletions(-)

--
2.40.1
