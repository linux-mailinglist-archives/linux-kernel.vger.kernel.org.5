Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D209077DA6C
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 08:23:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242105AbjHPGXL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 02:23:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242148AbjHPGW6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 02:22:58 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14B9126BA;
        Tue, 15 Aug 2023 23:22:49 -0700 (PDT)
Received: from leknes.fjasle.eu ([46.142.99.55]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1McZfZ-1pu4Lu1i3h-00cwFg; Wed, 16 Aug 2023 08:22:27 +0200
Received: from fjasle.eu (localhost [IPv6:::1])
        by leknes.fjasle.eu (Postfix) with ESMTP id DD8153F75F;
        Wed, 16 Aug 2023 08:22:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fjasle.eu; s=mail;
        t=1692166944; bh=0X0b4/DNHjk0hc/ShiDY9InFUbbXZZ3LbjU8MO8jZ5A=;
        h=From:To:Cc:Subject:Date:From;
        b=QOPTqsSROZj4VGRL5WnpejEyrzXdUV7IwZILPADlgqv24nVvdMgRyqWxwacpMUEL4
         DoTBGbPnxA2es/w4sXCo3Cn+wacswVnOjp3Uv9Vofb9nAFUqRrPko+BcEXP2MdroCw
         4BykCy9FsT5PdzoxuldSURVcVa/35jHoFQnBpbVI=
From:   Nicolas Schier <nicolas@fjasle.eu>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        linux-kernel@vger.kernel.org, Nicolas Schier <n.schier@avm.de>
Subject: [PATCH] MAINTAINERS: Add usr/ (initramfs generation) to KBUILD
Date:   Wed, 16 Aug 2023 08:22:19 +0200
Message-Id: <20230816062219.1086685-1-nicolas@fjasle.eu>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:5efYKn7F2za0bzOch2sK3zAAJMCZclTVtXWsbnQ1krjrYI1HvjA
 ItpwXZOHlEH7CZKWOeyHJVNXxBVRuGjaFobL2njp/+kaTNB9f2eSvLPAjiq5uRfBJdTGf1B
 QKqY8+S7hZMJEAv8QLxl1DDjt6j9jAc42EW5o3hFEO1mm8UCex1Q1b11scmJZdEASrjV8AF
 2X0ttwuG1ZEIeMPE4GxyA==
UI-OutboundReport: notjunk:1;M01:P0:l5/JpwWrnlE=;97cEQn4stRO/L91iAFV+/X+orNW
 D3vUIRxtDaDi5yV959b6EbJ6DgCY1SjUzdk3g3Jcl8MGGJlD6gHARipyobENz+0P7t3Czi/KO
 DeigjkcMx6ocVOCOmSVAOzw7ZdN5q/eDuiTa6fCFkugSmLx/3VgODm1ypL6h2A5SZ+cUI2QAo
 N3j1k4mb3sQ/MQXcSYaNzv5MyoYToxmucZ5MuE8hjaIUMetB7aDPpCAgQpG9/fWyxiwjQAVE+
 Prp5EMuMYST9xtzaY3HjcFgCuhAl0g9so6qc/XKxFYKoTBrXFb/FcIQ2x73MjTtg9t7BkiLP4
 tn8onQ7tTZBbxCUONXa91jCYHLrZFtXz9G3LJ2/L6ctcFAbIeQfdLt2IslMG+LQ20nCAETFpi
 zo9ilHDvZRu+C3sTBPRRYoAhiC55V4J4lgAbjEL/rzpZlNZT3F7DIXC+DK6HEWPsCPw4A1kyZ
 O0rS9gg71vGHlctXWQjo+8roiFX8sgLjXrlt4j/wFqp6CWK6aJ7xgvbqwjw3hl7HyhcwdVGXW
 okVCEyqdVxUL2Ka1DpQU6pf+G/yO7Sych3hztnURM4Lw1UwxocAUiZXcNW1LUJKyIraMuhWi2
 hrgQZKQh4TgW9851PAvMlLUf6h+JbYn4Fj8XFzNZeeMaOsSdbJiQ3WrO9zqBLxmHhC4tYaPzX
 REHMjNJy/NHqKu0vYx+iPhwSC/SAbjiCcX3WE23tAb4yJOJlG5XinDrVixPqdmUGTkzlOZLd+
 QaRus/u/lVBp2G2GNwtPtN/DCttyy23bQl8E1PuRrdApOArBCUZV0oAXyRgPbC0RgVh3FFVvO
 GglQsC3u8Du9vF+0Gl8ZMB5iaA8u2x4n1iNIK50psRjeq615kbaAw9HBopJXk+cjv15sCCGPC
 2ZvjP26QHOSI4Hw==
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        T_SPF_TEMPERROR,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nicolas Schier <n.schier@avm.de>

Add scripts for generating initramfs to KBUILD, to prevent idling of
patches for usr/.

Signed-off-by: Nicolas Schier <n.schier@avm.de>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index d516295978a4..eff293e8d3bf 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11296,6 +11296,7 @@ F:	scripts/dummy-tools/
 F:	scripts/mk*
 F:	scripts/mod/
 F:	scripts/package/
+F:	usr/
 
 KERNEL HARDENING (not covered by other areas)
 M:	Kees Cook <keescook@chromium.org>
-- 
2.39.2

