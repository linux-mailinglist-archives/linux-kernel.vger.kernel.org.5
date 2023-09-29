Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B43BB7B3A5E
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 21:05:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233633AbjI2TFA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 15:05:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233365AbjI2TE6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 15:04:58 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7416199
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 12:04:55 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id A683732000E5;
        Fri, 29 Sep 2023 15:04:54 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Fri, 29 Sep 2023 15:04:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jcline.org; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1696014294; x=1696100694; bh=tl2+4CsKy4
        eJf2x1H0MEhr2ez9lBgVPpFI/7ocetrG0=; b=HMksuo6NSjlz9VKe+j/jrBS021
        w2C1jWc70y7WdOb/3yx9xx6hrh/GnqOjY+QzvTzndGVKt3xSsT1LAqKKYbTlb1YY
        S/x8OQqTeZEpqLxhMkBUR3sseOYiH6y3qzXM9171dNuAK2Mqp6XTzxG2Z5yLHpVw
        r14732TA4KbEFigbadTjHspvJlcTcGkuqPD/ofS80OQ+A/0HfMBvFLLNdNHAowul
        3vivu2ISAiPCWj1+EATy/zPZ7F42P5jHnmZlBnVFQBky7Pm3opzCG28xJLCfLrwi
        aU0EoCLTq8v/9ShiTsiYFTZnmbzNZ8vgkhyyZhwZBljaVHYmkI4GCaElmrSg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1696014294; x=1696100694; bh=tl2+4CsKy4eJf
        2x1H0MEhr2ez9lBgVPpFI/7ocetrG0=; b=VDygIHyyb5jMFO+nwnAHprxexGgr9
        Di6QuWfUL30TRRlVTdozC1A7v3EJjNF8BTuVEfFkjlQue1sxYRS3ZcYqU4p4l05+
        HYTOxL7rQ5/mbTIDRZA1tqVB2PDEakAru6jQTb5BS64IeZ4JxNWw4AUjKJcd4Iur
        ftrKAuL2rezceQIusqsuXy0z1DluJJ4pt2ez7V+LlJo9hFSqXoaOCvhka+oBGyNY
        nQA9ytMoasR9WUBvZD2DQRUMHY0Y8pfqOT9hpbxIsrgcc9c79dx4DfZ95wqz1hw0
        MQhazzSk5N5zN2zrv6Cf+QjSxaFg9+OfHs0Sh7li0FMPuEaxgUY1slxMA==
X-ME-Sender: <xms:1R8XZWSQ18J46CvW0SMuEhFGQd-R1FqGZNOC1rILWBCCt0BWxVt-dw>
    <xme:1R8XZbxuqL3zGwFyv8PyXkKQTGi1XknhT1VOjz5AbHtpyseDMB9Tych5Q05hKm4g_
    _moVQigwwY5_bmRne0>
X-ME-Received: <xmr:1R8XZT1m5ChYcVfe0rltVEoxYgjI9jb2p95AMbuQEe8rFTQB2TiJ7Szshj0n1xXz526ONLa-sgI4bLRcyYOfqxjkneUZSsKnWTiV>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrtddvgddufedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomheplfgvrhgvmhih
    ucevlhhinhgvuceojhgvrhgvmhihsehjtghlihhnvgdrohhrgheqnecuggftrfgrthhtvg
    hrnheptddufeeugeefheehvedufeduvddtgfdvtdfgudfftdelkeelfffhjeevhefhhfeg
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepjhgvrh
    gvmhihsehjtghlihhnvgdrohhrgh
X-ME-Proxy: <xmx:1R8XZSDCOQjCHz3Hedua8UdaS92B5v0viDy5YjO1bDD_Wg5FVV95Sg>
    <xmx:1R8XZfgrxFY6titHWCkDp3oD6WCLN0RPmNwiB4mffvILlxPAZShhaQ>
    <xmx:1R8XZeokjkp3wWILLSF9YFRFBQ8Q2byTjIObkC1e9cfeDAbg7X6Hww>
    <xmx:1h8XZfeQI_SfB69q-YhszQ-iZqXUNZZokR80vl7oUhy9PVbWeJHXMQ>
Feedback-ID: i7a7146c5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 29 Sep 2023 15:04:53 -0400 (EDT)
From:   Jeremy Cline <jeremy@jcline.org>
To:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Cc:     Tom Rix <trix@redhat.com>, llvm@lists.linux.dev,
        linux-kernel@vger.kernel.org, Jeremy Cline <jeremy@jcline.org>
Subject: [PATCH] gen_compile_commands: use raw string when replacing \#
Date:   Fri, 29 Sep 2023 15:04:46 -0400
Message-ID: <20230929190446.113168-1-jeremy@jcline.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I noticed this since I'm running Python 3.12-rc3, which emits
"SyntaxWarning: invalid escape sequence '\#'" when running this script.
According to the Python 3.12 release notes this will eventually become a
SyntaxError.

Based on the comment in the code, I believe the intention was to match
the literal string "\#". Marking it as a raw string will stop Python
from trying to treat it as an escape sequence and behave as intended.

Signed-off-by: Jeremy Cline <jeremy@jcline.org>
---
 scripts/clang-tools/gen_compile_commands.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/clang-tools/gen_compile_commands.py b/scripts/clang-tools/gen_compile_commands.py
index a84cc5737c2c..bc005cac1944 100755
--- a/scripts/clang-tools/gen_compile_commands.py
+++ b/scripts/clang-tools/gen_compile_commands.py
@@ -170,7 +170,7 @@ def process_line(root_directory, command_prefix, file_path):
     # escape the pound sign '#', either as '\#' or '$(pound)' (depending on the
     # kernel version). The compile_commands.json file is not interepreted
     # by Make, so this code replaces the escaped version with '#'.
-    prefix = command_prefix.replace('\#', '#').replace('$(pound)', '#')
+    prefix = command_prefix.replace(r'\#', '#').replace('$(pound)', '#')
 
     # Use os.path.abspath() to normalize the path resolving '.' and '..' .
     abs_path = os.path.abspath(os.path.join(root_directory, file_path))
-- 
2.41.0

