Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C96DD7AB82B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 19:51:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233582AbjIVRvT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 13:51:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233576AbjIVRvB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 13:51:01 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9397810CC
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 10:50:44 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-68fdd6011f2so2022210b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 10:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695405044; x=1696009844; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yIEluTePXKUgmZoz//4ptV8zeRXzjojVV5Zn13TdbAA=;
        b=B8ACxVnmTI70CkCoVxDOImntSKGYWkxDtztMJ2WECSD0rLzx9Jds7fYgy1zuD4+/Oa
         Qxg3wfnkJsQjDAszIq5zLtgnIByRNxCz108y25uGyofojIaLImyMsaz80znXdC75p5oD
         GFzsiJmJyYoRUmIFPHL7nx7uLkj5rmDh7j7vc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695405044; x=1696009844;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yIEluTePXKUgmZoz//4ptV8zeRXzjojVV5Zn13TdbAA=;
        b=r7/C6sAeyLRO8hKCZHZoftPnFtmtXAO00oU+9YmeR9O44Wj6Plu5PoePf73wDBk+J/
         1cBZjRcUyYE0PI+uOWflXAnGGcwfAAMNbVREBXwJFYSwOMWAGaBlY2uUXdcgEVbE1I8P
         dfvc/BTya92QIkd6hNiWklRQHKZswQ/IvUGf+x+jdzEDKDDrvWrDSA4PNy7CY3woqZ+6
         sFP0fCz+wcdilEMoFsV8PdvPVZQtcF9R2bkwU1w980D5aVqbMEwXqPUwRKENoKCU3QRs
         c48O1PMuwjjgHZkOT/Tm9fM5W8guoMBQwYkfuYLyOnEUArqfQyqETxv/MdjjZ2RKIuE1
         YcmA==
X-Gm-Message-State: AOJu0Yy08eK6Dtu5TLu5vKNJwgh/tF8lxFMmPKYZYvrhSMfYnk1Oyyr9
        k8m3P2yzjJfHsDyhNYxcJLnw5g==
X-Google-Smtp-Source: AGHT+IGlzZWrQahzIVY7sXtrvLZBK5+3kHZlDPRAqWBrggsxuzxxsLFOwwww26ZuTCH8VBPpWjNhmQ==
X-Received: by 2002:a05:6a20:8409:b0:159:b45e:1c7d with SMTP id c9-20020a056a20840900b00159b45e1c7dmr331120pzd.15.1695405044050;
        Fri, 22 Sep 2023 10:50:44 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id k17-20020aa78211000000b0068be4ce33easm3556666pfi.96.2023.09.22.10.50.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Sep 2023 10:50:43 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Jaroslav Kysela <perex@perex.cz>
Cc:     Kees Cook <keescook@chromium.org>, Takashi Iwai <tiwai@suse.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        alsa-devel@alsa-project.org, Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Jason Montleon <jmontleo@redhat.com>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        linux-hardening@vger.kernel.org
Subject: [PATCH] ALSA: hda: Annotate struct hda_conn_list with __counted_by
Date:   Fri, 22 Sep 2023 10:50:42 -0700
Message-Id: <20230922175042.work.547-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1166; i=keescook@chromium.org;
 h=from:subject:message-id; bh=2+WFGivuUVAKb1W+9E3ktp6XUMEEm32AWq2NC2ISBJg=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlDdPyOwKNuU3DBxwepcnIO9oHljCgGuE/kMNNW
 SIuGoQNj8SJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZQ3T8gAKCRCJcvTf3G3A
 Jo+WD/9F+wyEdMZRixRxq25YvGH8mw+aR+YpOV3Jnt0ScoGqx0BVe0PCT0yiRIlirDR/leDv/w8
 f7dQOHwxs6N9HFxhaKWBn/5fS39ICNQHC6rGWyVsrtVhQomA7J2VerZJ3EHX1Py8vAQ45YeksaK
 68AiMW/ZxVcB2VQVOV9JK2LLA8q1GDFaSzTX25NBCsilUpoA4Xg2zoxf99DJqx4M4DEcYMvA8dx
 P+iFCootNqc75w1qhByYrkec6Ypk9186+KIEpX23pJvVkkOnm+l4jFmeAc6fDGLx4GGyVGf7oBF
 bbuUPvR9ftPa8SdqnefuqXk6wUxPKdb94b6/PnBWLs8O87U+ug0Nkh5oYTMTOEp/cfyM7Aj3lT1
 HrZA5MhV2tsVVK2LMCLeFmqxZBfw/XJal0TYdzkGV7Y5HGrF3yDBqnAdJW4/uZeL9psk2L0ptaN
 L/SvDMIi0e7Jmwu580DQfxp4N23uZcYYDQNVFdCMuE+NSTggdbiilocOwMPL5ypkjb9X/boktW5
 tzYNjZsA3ZGXjSwzW61MmJOC52NSPC6Tk0bOHBbzVQfJGJUVVG8Q0uBN5PkgRtuVrc8oh4zUF5Z
 ILsCXDzpDzwULkvGXjOBJv5tUcenHcoyf4qbL5mC9nHz9RbDqdz0MnmL9tLf7L5LBNwVdJAyQpX
 sITrZ/3 7N36Rc8A==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prepare for the coming implementation by GCC and Clang of the __counted_by
attribute. Flexible array members annotated with __counted_by can have
their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
(for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
functions).

As found with Coccinelle[1], add __counted_by for struct hda_conn_list.

[1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci

Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.com>
Cc: Cezary Rojewski <cezary.rojewski@intel.com>
Cc: alsa-devel@alsa-project.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 sound/pci/hda/hda_codec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/pci/hda/hda_codec.c b/sound/pci/hda/hda_codec.c
index 33af707a65ab..01718b1fc9a7 100644
--- a/sound/pci/hda/hda_codec.c
+++ b/sound/pci/hda/hda_codec.c
@@ -88,7 +88,7 @@ struct hda_conn_list {
 	struct list_head list;
 	int len;
 	hda_nid_t nid;
-	hda_nid_t conns[];
+	hda_nid_t conns[] __counted_by(len);
 };
 
 /* look up the cached results */
-- 
2.34.1

