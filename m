Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A33507DF27B
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 13:32:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376340AbjKBMcr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 08:32:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347477AbjKBMcn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 08:32:43 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC25D187;
        Thu,  2 Nov 2023 05:32:36 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1cc5916d578so7261985ad.2;
        Thu, 02 Nov 2023 05:32:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698928356; x=1699533156; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JHZljteCpRqvxfSpxJAG4QDEKl1NYk7c2QCt8liS/y4=;
        b=RuOusVW+8fvZ0jFzyJlIvXVHwBJCdmsEON/TevJD3VOmUWFKV+Jocx9DzKMF0sl/Jw
         ax07doVZze4Y3d993+CGV5nUVNhiKb02C3SYlRmCdAe8RYqlqf/frH5XlJBLrFBULayt
         zzoGbJQ7MM9WURwXjqjJnRtWc2aQXH+Ilw0HahXYJqjo+ijVQhrlE0vlb3I5qVsqk65R
         QshPmDVNyJW9Pf79Gq3fI4stjZkHiLzz2QmZn9/Ff0E0TbrBy7kWqGMbm3hEPooxuR0d
         7rweE4xxFqGGJStukfckebBBxWNxNBbgZeRExFwDkdE25qSF4FUji3jF70o0ofPatTTN
         Dvbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698928356; x=1699533156;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JHZljteCpRqvxfSpxJAG4QDEKl1NYk7c2QCt8liS/y4=;
        b=hNlY7ODMw2uT+M5X3jnl3SflHMLzVoy8dStXKuEsa2hLbyMEiMR99fnpfBGzl2s1jX
         ic9wNfocS8rOIqZsn4cFNle3jDGwTmQh0F4+o6QkUx/cEGK8R0QlCkO9PuMnqpqrfa/p
         jsc0tcqcCmYtLiGhDBhO/fXwilQbYlRxNoAJnS6433vgJp2xCJABSjJrS/hY4N0+cOSh
         Ro26FFu57VVmxcHqNyBvSPiIdV//sogAFrPpkgIF3Jy0U9xYB8rm2JRYE3j2z1lm7CDQ
         ioRgpSrFfvU/VGsv7N0c8kMLVmgUgiTY1UYtBKTSma9ItRWX2FStAT26FppUn2f8eaCy
         Gk+g==
X-Gm-Message-State: AOJu0YzEYrpOM6Y/ZZwSYsId+NYJc1ctU+LAQJT+B9/DkCFwo2LfIoSB
        QWUxUHCHdn/lqaZ7QeUn8ZNOtGulNQo=
X-Google-Smtp-Source: AGHT+IEaXRGmLq5dKyklqiVLUAOJIpLMew79Bwev59pNulFGjK9hiNBSg7f8AlVEdDfPe1AbQhq1xw==
X-Received: by 2002:a17:903:22c9:b0:1cc:665d:f822 with SMTP id y9-20020a17090322c900b001cc665df822mr9864685plg.32.1698928356040;
        Thu, 02 Nov 2023 05:32:36 -0700 (PDT)
Received: from debian.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id e19-20020a170902f1d300b001cc54202429sm3034827plc.288.2023.11.02.05.32.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Nov 2023 05:32:33 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 7F4F994783F6; Thu,  2 Nov 2023 19:32:27 +0700 (WIB)
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Documentation <linux-doc@vger.kernel.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Akira Yokosawa <akiyks@gmail.com>,
        Stanislav Fomichev <sdf@google.com>,
        David Vernet <void@manifault.com>,
        Miguel Ojeda <ojeda@kernel.org>, James Seo <james@equiv.tech>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Federico Vaga <federico.vaga@vaga.pv.it>,
        Carlos Bilbao <carlos.bilbao@amd.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        linux-spdx@vger.kernel.org, Richard Fontana <rfontana@redhat.com>
Subject: [PATCH RFC RESEND 1/4] LICENSES: Add SIL Open Font License 1.1
Date:   Thu,  2 Nov 2023 19:32:19 +0700
Message-ID: <20231102123225.32768-2-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231102123225.32768-1-bagasdotme@gmail.com>
References: <20231102123225.32768-1-bagasdotme@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6146; i=bagasdotme@gmail.com; h=from:subject; bh=oJi90sHpZ+8fTIMAn6nhffIPoD5M4K3rwQZpFkTVXhU=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDKnOUy9NsNJq3Nre+qqgNnfK5vsJJi3X+Bc9CzBq5Op4q b7tU+nNjlIWBjEuBlkxRZZJiXxNp3cZiVxoX+sIM4eVCWQIAxenAEykJZyRYfPHmfNvfbAvF9LZ 9s76NzPL7sj964Ifpe38PNG2pof30HxGhnNH3f3jRdjUWPVWsmU93nvvX/2G8F93zsnWR28L4s1 05gIA
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the license text along with appropriate tags for reference and
tooling. The text is taken from the text as distributed in Google
Fonts's zip files.

As the license itself may or may note be compatible with GPLv2,
let's take on the err side and require combining it with
GPL-compatible licenses when using the license.

Cc: linux-spdx@vger.kernel.org
Cc: Richard Fontana <rfontana@redhat.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 LICENSES/dual/OFL-1.1 | 107 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 107 insertions(+)
 create mode 100644 LICENSES/dual/OFL-1.1

diff --git a/LICENSES/dual/OFL-1.1 b/LICENSES/dual/OFL-1.1
new file mode 100644
index 00000000000000..00b8db08bd0e54
--- /dev/null
+++ b/LICENSES/dual/OFL-1.1
@@ -0,0 +1,107 @@
+Valid-License-Identifier: OFL-1.1
+SPDX-URL: https://spdx.org/licenses/OFL-1.1
+Usage-Guide:
+  Do NOT use this license for code, but it's acceptable for fonts (where the
+  license is specifically written for them). It's best to use it together
+  with a GPL2 compatible license using "OR", as OFL-1.1 texts processed by
+  the kernel's build system might combine it with content taken from more
+  restrictive licenses.
+  To use the SIL Open Font License 1.1, put the following SPDX tag/value pair
+  into a comment according to the placement guidelines in the licensing rules
+  documentation:
+    SPDX-License-Identifier: OFL-1.1
+License-Text:
+
+Copyright © <year> <owner>. with Reserved Font Name <reserved font name>.
+
+This Font Software is licensed under the SIL Open Font License, Version 1.1.
+This license is copied below, and is also available with a FAQ at:
+http://scripts.sil.org/OFL
+
+
+-----------------------------------------------------------
+SIL OPEN FONT LICENSE Version 1.1 - 26 February 2007
+-----------------------------------------------------------
+
+PREAMBLE
+The goals of the Open Font License (OFL) are to stimulate worldwide
+development of collaborative font projects, to support the font creation
+efforts of academic and linguistic communities, and to provide a free and
+open framework in which fonts may be shared and improved in partnership
+with others.
+
+The OFL allows the licensed fonts to be used, studied, modified and
+redistributed freely as long as they are not sold by themselves. The
+fonts, including any derivative works, can be bundled, embedded, 
+redistributed and/or sold with any software provided that any reserved
+names are not used by derivative works. The fonts and derivatives,
+however, cannot be released under any other type of license. The
+requirement for fonts to remain under this license does not apply
+to any document created using the fonts or their derivatives.
+
+DEFINITIONS
+"Font Software" refers to the set of files released by the Copyright
+Holder(s) under this license and clearly marked as such. This may
+include source files, build scripts and documentation.
+
+"Reserved Font Name" refers to any names specified as such after the
+copyright statement(s).
+
+"Original Version" refers to the collection of Font Software components as
+distributed by the Copyright Holder(s).
+
+"Modified Version" refers to any derivative made by adding to, deleting,
+or substituting -- in part or in whole -- any of the components of the
+Original Version, by changing formats or by porting the Font Software to a
+new environment.
+
+"Author" refers to any designer, engineer, programmer, technical
+writer or other person who contributed to the Font Software.
+
+PERMISSION & CONDITIONS
+Permission is hereby granted, free of charge, to any person obtaining
+a copy of the Font Software, to use, study, copy, merge, embed, modify,
+redistribute, and sell modified and unmodified copies of the Font
+Software, subject to the following conditions:
+
+1) Neither the Font Software nor any of its individual components,
+in Original or Modified Versions, may be sold by itself.
+
+2) Original or Modified Versions of the Font Software may be bundled,
+redistributed and/or sold with any software, provided that each copy
+contains the above copyright notice and this license. These can be
+included either as stand-alone text files, human-readable headers or
+in the appropriate machine-readable metadata fields within text or
+binary files as long as those fields can be easily viewed by the user.
+
+3) No Modified Version of the Font Software may use the Reserved Font
+Name(s) unless explicit written permission is granted by the corresponding
+Copyright Holder. This restriction only applies to the primary font name as
+presented to the users.
+
+4) The name(s) of the Copyright Holder(s) or the Author(s) of the Font
+Software shall not be used to promote, endorse or advertise any
+Modified Version, except to acknowledge the contribution(s) of the
+Copyright Holder(s) and the Author(s) or with their explicit written
+permission.
+
+5) The Font Software, modified or unmodified, in part or in whole,
+must be distributed entirely under this license, and must not be
+distributed under any other license. The requirement for fonts to
+remain under this license does not apply to any document created
+using the Font Software.
+
+TERMINATION
+This license becomes null and void if any of the above conditions are
+not met.
+
+DISCLAIMER
+THE FONT SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
+EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO ANY WARRANTIES OF
+MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT
+OF COPYRIGHT, PATENT, TRADEMARK, OR OTHER RIGHT. IN NO EVENT SHALL THE
+COPYRIGHT HOLDER BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
+INCLUDING ANY GENERAL, SPECIAL, INDIRECT, INCIDENTAL, OR CONSEQUENTIAL
+DAMAGES, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+FROM, OUT OF THE USE OR INABILITY TO USE THE FONT SOFTWARE OR FROM
+OTHER DEALINGS IN THE FONT SOFTWARE.
-- 
An old man doll... just what I always wanted! - Clara

