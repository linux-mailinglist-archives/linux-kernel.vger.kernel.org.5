Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC1327DF1E2
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 13:01:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346112AbjKBMBO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 08:01:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345997AbjKBMBM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 08:01:12 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1358136;
        Thu,  2 Nov 2023 05:01:05 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-6b77ab73c6fso705814b3a.1;
        Thu, 02 Nov 2023 05:01:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698926465; x=1699531265; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JHZljteCpRqvxfSpxJAG4QDEKl1NYk7c2QCt8liS/y4=;
        b=VMFpAW4WlFocY2Fx4Y03RU2QQhCZ2Ai3C+0yWVW2Dl/d9T3KFW00kwlmAugfVAq1EN
         6JSnuUJcUwWsOOrBEIXcpOwyf+w4jI7hL3OV5zV4l9rkLKxf4T+hl1M8sAvUEu6SRKDd
         FChxBeXLuB6yo8JB62E3hbufIvgA2RTe7OoxPN3TDPX32lGQFVndKQcZYAL3MDLTfYWi
         yGUq5tEMvfELcYNKi6FQEoLYl6qeqnh6LSZewiT9jjkZa38k4lJBCp2aHpC+Fr24nip5
         nsKnxWHyPCprE+Ij9JPXdN5oHRZoe45++5wrNCSklzLDm64WzxNGvrWj237mpjB6NepN
         XRBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698926465; x=1699531265;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JHZljteCpRqvxfSpxJAG4QDEKl1NYk7c2QCt8liS/y4=;
        b=F1a8xtBXCgSQHFMul9u2J77MsvUfl/6bYWmIiJ1picvvhjWKGu8Z2uZ4y6jOfU7a+u
         RyNvpY52oU/7xMypsDwN06r/5nwELwAr/v91cL8W2BznGXb/9VCFGg54Np6iA8+hXBzR
         fVI91e49lJOIjHfYFIj+NvltqIHlCrDdCISdSVoBx+dOXo2HpcUse304QBFOZLEDqgfg
         s0/Yep2exCpuoFXchnVqAc+6PRc3hr7346EJh70+S8diVaJtzJy+uAbF1ZGRU76JyKmx
         3XX6qVvsNElM+gjac6tYznuo7fJldgQwFDNuHLS7ThctBR9QLH1l+ODmjFruq/G18LG2
         D/Vw==
X-Gm-Message-State: AOJu0YyMEG1p4zSwLH+VU6cvhm27wN8sA8FACVRMptLqkUgoka2MWBwT
        7IUzaXqQTAOBb4wWc2MFbmM=
X-Google-Smtp-Source: AGHT+IHCMv5hDYepAeQhnfsUd0+Z/YZLiMVY77WPDzhBG64cDf9c88HDu6KK9YEa+SXKuUQ4vysi6A==
X-Received: by 2002:a05:6a00:1949:b0:68a:5cf8:dae4 with SMTP id s9-20020a056a00194900b0068a5cf8dae4mr12109403pfk.3.1698926464939;
        Thu, 02 Nov 2023 05:01:04 -0700 (PDT)
Received: from debian.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id p2-20020a62ab02000000b006be5e537b6csm2770451pff.63.2023.11.02.05.01.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Nov 2023 05:01:01 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 723C994783DA; Thu,  2 Nov 2023 19:00:57 +0700 (WIB)
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Documentation <linux-doc@ger.kernel.org>
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
Subject: [PATCH RFC 1/4] LICENSES: Add SIL Open Font License 1.1
Date:   Thu,  2 Nov 2023 19:00:43 +0700
Message-ID: <20231102120053.30630-2-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231102120053.30630-1-bagasdotme@gmail.com>
References: <20231102120053.30630-1-bagasdotme@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6146; i=bagasdotme@gmail.com; h=from:subject; bh=oJi90sHpZ+8fTIMAn6nhffIPoD5M4K3rwQZpFkTVXhU=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDKnOPVcnWGk1bm1vfVVQmztl8/0Ek5Zr/IueBRg1cnW8V N/2qfRmRykLgxgXg6yYIsukRL6m07uMRC60r3WEmcPKBDKEgYtTACZy+iIjw5FYjincab7/+k3t AhQDel5M3fmwsaTLV+zDvJYNKb8tGBn+1+tPVDF/8cSre0fMpTvCmfXmLau3dVxu0b9/aFZoh0E AOwA=
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
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

