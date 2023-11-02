Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40EFA7DF27A
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 13:32:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376314AbjKBMcp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 08:32:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347434AbjKBMck (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 08:32:40 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66E9C18A;
        Thu,  2 Nov 2023 05:32:34 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1cc4f777ab9so7315875ad.0;
        Thu, 02 Nov 2023 05:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698928354; x=1699533154; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QKAx5ThT2Vf8fFtCyU7a6NLM9WmpGysPMUECF9rGRn0=;
        b=WntAZcXAK5qVBCRhjlSWptYY6gqOR0DQs0GEVrnEFl29RVmZaDX1gIqBTYdcisTihu
         A0uuzDFkpvcSPX18tx6arp9bBOu0d9nLFnI0S1SueJknQyVv1MJxznQWZV+kw3PzwoT7
         chsY3uxv+//dE3xAlZli2abSEqxQmwMSBjGLbJQKfdnr5Z2e36ZhvyCfaT3NN4HMACKK
         Ogn2CW6QC3/E27faIXDkDa7GPjtoRc0fGvuiV+T//71hm0+Ch5oEGuvqGIN26Ke2Mva1
         GVdZUUecjGIo3ICRv7f19QKPstHxhv8KQdPOFA+YKueY15Rq+QNdQ3WJFNrp0b8IpiHB
         1dvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698928354; x=1699533154;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QKAx5ThT2Vf8fFtCyU7a6NLM9WmpGysPMUECF9rGRn0=;
        b=ZGdIdwAtz40ObRRjdLnHf8k2WRrW7oRced7LGbaUXJ+7jBULiNyjZWN2Wwm/sFBPoa
         lfxMEI7VOzioJ+EvHTUZPCCRIzHoD5XRaX6EcgXTI+FtjDf0WssqxjK1BM1avi64jNgG
         lb4wVQsH52cApG+nGMDVmeFEHXzGLNDr6n7EEj3JsiyezVhDFkGUF+TpcKZL5ech2Stj
         YKSlIzZsoTVUctsbhojugx7Dp+8AmUIon69qgsLDqrG2lCq1DR89xpz+8gIZBOOiUSWU
         GB9MJKIEQpaqttE18HBVcaPAWze+xT0yFuTrXENcIx10R6NGilyZZP1aWp9C6bPKIzM2
         N01A==
X-Gm-Message-State: AOJu0Ywi6TuE3WJs+McZawyeBAE+ZqWiaba2lb0GgCJjST0PKIA01qPZ
        B58wijTbKIaHtSUlt4zajhw=
X-Google-Smtp-Source: AGHT+IHJEFWfyJBXdCnPufQWTpRROogPrOje95/7SJj7s8Yme/cUC11Aj3losLSvzq2HqaAQvb6w9g==
X-Received: by 2002:a17:903:187:b0:1cc:50ea:d5c5 with SMTP id z7-20020a170903018700b001cc50ead5c5mr11550530plg.24.1698928353721;
        Thu, 02 Nov 2023 05:32:33 -0700 (PDT)
Received: from debian.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id s8-20020a170902ea0800b001ca21c8abf7sm3010728plg.188.2023.11.02.05.32.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Nov 2023 05:32:33 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 5898594783DE; Thu,  2 Nov 2023 19:32:27 +0700 (WIB)
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
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH RFC RESEND 0/4] Documentation: Web fonts for kernel documentation
Date:   Thu,  2 Nov 2023 19:32:18 +0700
Message-ID: <20231102123225.32768-1-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5260; i=bagasdotme@gmail.com; h=from:subject; bh=kbTowhNlSDIuR7XaqayK6AaiczYS/czXO1LI+m9LuXM=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDKnOU88d8f28xPVRSnGrD1u1FW+2wSSGTSe9ikLXiNWL7 n355KJfRykLgxgXg6yYIsukRL6m07uMRC60r3WEmcPKBDKEgYtTACZywoHhFzPT3Nub1z+uXvo6 OJVDWK31f8OC7QWdqR+mTekWmiAtuZjhf15M6fXPZ9zawziTTE/eXLapuvEHfwH/09Dz4fdau10 PMgAA
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

[resend from previous RFC [4] with correct linux-doc address]

Intro
=====

The Linux kernel documentation is primarily composed of text (both
prose and code snippets) and a few images. Hence, making the text
easy to read by proper typography choices is crucial.

The problem
===========

Currently, the kernel docs uses system-default serif fonts, as in
Documentation/conf.py:

```
...
if  html_theme == 'alabaster':
    html_theme_options = {
        'description': get_cline_version(),
        'page_width': '65em',
        'sidebar_width': '15em',
        'fixed_sidebar': 'true',
        'font_size': 'inherit',
        'font_family': 'serif',
    }
...
```

The problem is depending on the serif font selected by system, the docs
text (especially long passages) can be hard and uncomfortable to read.
For developers reading the docs on multiple devices, the apparence may
look inconsistent.

The solution
============

Uniform the font choices by leveraging web fonts. Most of people reading
the kernel docs should already have modern browser that supports this
feature (e.g. Chrome/Chromium and Firefox). The fonts are downloaded
automatically when loading the page, but only if the reader don't
already have ones installed locally. Subsequent docs page loading will
use the browser cache to retrieve the fonts. If for some reasons the
fonts fail to load, the browser will fall back to fallback fonts
commonly seen on other sites.

For the font choices, we settle down on IBM Plex Sans (sans-serif), IBM
Plex Mono (monospace), and Newsreader (serif). All these fonts are
licensed under OFL 1.1 and can be distributed alongside the kernel docs.
We have also considered to use Söhne [1] instead, but because it is paid
font, it is concluded that such font is non-free [2] (and by
implication, distributions must patch the kernel to not use it).

The fonts selected are downloaded from Google Fonts directory [3]. As
the font files are in .ttf format, these are compressed first into
.woff2 format (just like other sites that use web fonts do) using
`woff2_compress` program from `woff2` Debian package. These converted
files are then referenced in Documentation/sphinx-static/fonts.css via
`@font-face` directive and the appropriate `font-family` rule selects
that font.

Note that only necessary styles (regular, bold, italic, and bold-italic)
are included and used. For Newsreader, use the classic 14 pt static font
instead of variable variant for compatibility with older browsers.

Scope
=====

Only the main documentation and translations in languages using Latin
script (Italian and Spanish) are covered.

[1]: https://klim.co.nz/retail-fonts/soehne/
[2]: https://lists.debian.org/debian-legal/2023/06/msg00005.html
[3]: https://fonts.google.com
[4]: https://lore.kernel.org/all/20231102120053.30630-1-bagasdotme@gmail.com/

Bagas Sanjaya (4):
  LICENSES: Add SIL Open Font License 1.1
  Docmentation: Use IBM Plex Sans for page body
  Documentation: Use Newsreader font for document headings
  Documentation: Use IBM Plex Mono as monospace font

 Documentation/conf.py                         |   4 +
 .../sphinx-static/IBMPlexMono-Bold.woff2      | Bin 0 -> 39984 bytes
 .../IBMPlexMono-BoldItalic.woff2              | Bin 0 -> 43816 bytes
 .../sphinx-static/IBMPlexMono-Italic.woff2    | Bin 0 -> 43236 bytes
 .../sphinx-static/IBMPlexMono-Regular.woff2   | Bin 0 -> 38740 bytes
 .../sphinx-static/IBMPlexSans-Bold.woff2      | Bin 0 -> 55412 bytes
 .../IBMPlexSans-BoldItalic.woff2              | Bin 0 -> 59112 bytes
 .../sphinx-static/IBMPlexSans-Italic.woff2    | Bin 0 -> 59468 bytes
 .../sphinx-static/IBMPlexSans-Regular.woff2   | Bin 0 -> 55380 bytes
 .../sphinx-static/Newsreader_14pt-Bold.woff2  | Bin 0 -> 44512 bytes
 .../Newsreader_14pt-BoldItalic.woff2          | Bin 0 -> 48152 bytes
 .../Newsreader_14pt-Italic.woff2              | Bin 0 -> 44864 bytes
 .../Newsreader_14pt-Regular.woff2             | Bin 0 -> 41212 bytes
 Documentation/sphinx-static/fonts.css         | 157 ++++++++++++++++++
 LICENSES/dual/OFL-1.1                         | 107 ++++++++++++
 15 files changed, 268 insertions(+)
 create mode 100644 Documentation/sphinx-static/IBMPlexMono-Bold.woff2
 create mode 100644 Documentation/sphinx-static/IBMPlexMono-BoldItalic.woff2
 create mode 100644 Documentation/sphinx-static/IBMPlexMono-Italic.woff2
 create mode 100644 Documentation/sphinx-static/IBMPlexMono-Regular.woff2
 create mode 100644 Documentation/sphinx-static/IBMPlexSans-Bold.woff2
 create mode 100644 Documentation/sphinx-static/IBMPlexSans-BoldItalic.woff2
 create mode 100644 Documentation/sphinx-static/IBMPlexSans-Italic.woff2
 create mode 100644 Documentation/sphinx-static/IBMPlexSans-Regular.woff2
 create mode 100644 Documentation/sphinx-static/Newsreader_14pt-Bold.woff2
 create mode 100644 Documentation/sphinx-static/Newsreader_14pt-BoldItalic.woff2
 create mode 100644 Documentation/sphinx-static/Newsreader_14pt-Italic.woff2
 create mode 100644 Documentation/sphinx-static/Newsreader_14pt-Regular.woff2
 create mode 100644 Documentation/sphinx-static/fonts.css
 create mode 100644 LICENSES/dual/OFL-1.1


base-commit: babe393974de0351c0e6cca50f5f84edaf8d7fa1
-- 
An old man doll... just what I always wanted! - Clara

