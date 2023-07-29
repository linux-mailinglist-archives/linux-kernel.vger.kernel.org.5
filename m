Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DBF0767C44
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 07:02:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235049AbjG2FCU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jul 2023 01:02:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbjG2FCS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jul 2023 01:02:18 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 259E0198A
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 22:02:17 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id 41be03b00d2f7-55b5a37acb6so378656a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 22:02:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690606936; x=1691211736;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cjkBbkh/GjL93eEJmsCFWZWoMeD8zNhgHOIAKw8BpdA=;
        b=hFsfK1DYrPbFnSChjGA2BapKXb32Ttb0Iw+FGCAFOWSfC9uZbQ26QKqOVZsuJJdOJU
         YEEQ0Dy5J9V+OLGSGSPiLko6jaT1Yw44OPpwL/U6/Njagvev61rOvweUUo6qcNmqkbGm
         st8iWGANRMFtap+wcJNaW/SaC85aQuIBBSYwztZAq/qs5H1Nl45mwfP6rdhABmshjNrv
         yp1qyZI3dvclyWqV5P9gZ+W7qN/z8f+c76k2fo4y1HM+aEuEksRXDplblC+9vXOo2fnH
         cw96anaHwc5AEWmit4Kia8V68Ip7hERK2o9zRt6Q076IF+5PxjvItL4Ch69pnbMod8jo
         7PqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690606936; x=1691211736;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cjkBbkh/GjL93eEJmsCFWZWoMeD8zNhgHOIAKw8BpdA=;
        b=InApsfXx3TEHdivV+Kd+SupvEG8jW4qNfty8Y4DPJqIPXjOqtWqRZxaI1qM74COhE4
         aZlY+cp3FjwhFKUatzvAUX7qJtTknBfRXb1HXMQ55BfjlCuGNqPHypNcGEq6jb0qtb4S
         4GBIBAcB11gqGJNo0xUGWGh9yL/ssdEJUWAID8/MoN8yq1YPyJOzgPiz/qfb3umH+m/X
         YoXTG65s44FauQvYd4/OH/FTOIcTlmhHHvqjma4A+tQV55Izqm7QzqB6fJUtM8t1NtVj
         Tq3GIdUyW3Tjx8TMDLG4dCewVBJwC2WqI29j7eOYdLJ9U1ReqCdyrYPKaGt3E5wfzLci
         lWlQ==
X-Gm-Message-State: ABy/qLYXYI9drFqCv/dFrw4SEfMQEzkEbbExPaVHjmHEwYFuqkuwnE6z
        OabpiVCTXmF68Rh2MpUYbNI=
X-Google-Smtp-Source: APBJJlHFI5bqAf6ZPXP0Or/E+JkURtJBabWrf+YAFWrHmpbGpjZn6lodQcL9UTwrHT2WjArygDp6SQ==
X-Received: by 2002:a17:902:da84:b0:1bb:ac37:384b with SMTP id j4-20020a170902da8400b001bbac37384bmr1627144plx.6.1690606936434;
        Fri, 28 Jul 2023 22:02:16 -0700 (PDT)
Received: from mail.google.com (203-109-233-218.dsl.dyn.ihug.co.nz. [203.109.233.218])
        by smtp.gmail.com with ESMTPSA id t16-20020a17090aba9000b0026307fa0442sm4819654pjr.49.2023.07.28.22.02.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jul 2023 22:02:15 -0700 (PDT)
Date:   Sat, 29 Jul 2023 17:02:09 +1200
From:   Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
To:     masahiroy@kernel.org, bgray@linux.ibm.com, ajd@linux.ibm.com,
        n.schier@avm.de
Cc:     paulo.miguel.almeida.rodenas@gmail.com,
        linux-kernel@vger.kernel.org, keescook@chromium.org
Subject: [PATCH] [next] initramfs: Parse KBUILD_BUILD_TIMESTAMP as UTC date
Message-ID: <ZMSdUS37BD5b/dn7@mail.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When KBUILD_BUILD_TIMESTAMP is specified, the date command will parse
it to Unix Epoch time in UTC. However, the date command is
timezone-aware so it will convert from the local timezone to UTC first
which hits some of the sanity checks added on commit 5efb685bb3af1
("initramfs: Check negative timestamp to prevent broken cpio archive")

This creates an edge case for the UTC+<N> part of the world. For instance

 - In New Zealand (UTC+12:00):
	$ date -d"1970-01-01" +%s
	-43200

	$ make KBUILD_BUILD_TIMESTAMP=1970-01-01
	make[1]: Entering directory '<snip>/linux/'
	  GEN     Makefile
	  DESCEND objtool
	  INSTALL libsubcmd_headers
	  CALL    ../scripts/checksyscalls.sh
	  GEN     usr/initramfs_data.cpio
	ERROR: Timestamp out of range for cpio format
	make[4]: *** [../usr/Makefile:76: usr/initramfs_data.cpio] Error 1

 - In Seattle, WA (UTC-07:00):
	$ date -d"1970-01-01" +%s
	32400

	$ make KBUILD_BUILD_TIMESTAMP=1970-01-01
	<builds fine>

Parse KBUILD_BUILD_TIMESTAMP date string as UTC so no localtime
conversion is done which fixes the edge case aforementioned.

Signed-off-by: Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
---
 usr/gen_initramfs.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/usr/gen_initramfs.sh b/usr/gen_initramfs.sh
index 14b5782f961a..a90316d9a080 100755
--- a/usr/gen_initramfs.sh
+++ b/usr/gen_initramfs.sh
@@ -221,7 +221,7 @@ while [ $# -gt 0 ]; do
 			shift
 			;;
 		"-d")	# date for file mtimes
-			timestamp="$(date -d"$1" +%s || :)"
+			timestamp="$(date -d"$1" -u +%s || :)"
 			if test -n "$timestamp"; then
 				timestamp="-t $timestamp"
 			fi
-- 
2.40.1

