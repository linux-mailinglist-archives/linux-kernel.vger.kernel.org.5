Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E8A97D24CC
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Oct 2023 19:06:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232447AbjJVRGn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Oct 2023 13:06:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232578AbjJVRGf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Oct 2023 13:06:35 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 863BCD63;
        Sun, 22 Oct 2023 10:06:28 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DBABC433C9;
        Sun, 22 Oct 2023 17:06:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697994388;
        bh=hKI1zzwBL75rgCF5kVM4ODL5hDvv/GmFFgzS1g4lATI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=d/jr2zEZFapXEUeHrMZOfqTMdiWYVWdzESaIC4c6z+PBZgj/SIIBYofDuzXwSmfya
         aAqcO+ftepC6hG5fXKgra8RiS7+ePPvVuzvHqbxqFzv87RZQ/h6LB9O0EuyyGnzqZe
         NQpRqhASjAMJxQr5E4i2upCwumbwXfhWdoDvHZCRE+7FZMdnYhumprkpXWGXkrdfRO
         Ln/tQ/w2As4/n5Dfxzn2UG1KcD58lqDHS0kVzcU0PuaEnutMVvucGZYNcimDk8oKzs
         BPxJlAAYfp3BLS+iKrlG6CatIi3Mkr7M6Np0L9uVz43Xa/KBSopJuicVLAN6V77kL7
         72Cr2xs/9Az1g==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>
Subject: [PATCH 08/10] modpost: use ALL_INIT_SECTIONS for the section check from DATA_SECTIONS
Date:   Mon, 23 Oct 2023 02:06:11 +0900
Message-Id: <20231022170613.2072838-8-masahiroy@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231022170613.2072838-1-masahiroy@kernel.org>
References: <20231022170613.2072838-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ALL_INIT_SECTIONS is defined as follows:

  #define ALL_INIT_SECTIONS INIT_SECTIONS, ALL_XXXINIT_SECTIONS

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/mod/modpost.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index 8f4bddbbc52b..c726383c1909 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -863,7 +863,7 @@ static const struct sectioncheck sectioncheck[] = {
 },
 {
 	.fromsec = { DATA_SECTIONS, NULL },
-	.bad_tosec = { ALL_XXXINIT_SECTIONS, INIT_SECTIONS, NULL },
+	.bad_tosec = { ALL_INIT_SECTIONS, NULL },
 	.mismatch = DATA_TO_ANY_INIT,
 },
 {
-- 
2.40.1

