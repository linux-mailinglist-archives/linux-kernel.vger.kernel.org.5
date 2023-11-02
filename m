Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 950617DF1E3
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 13:01:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346140AbjKBMBR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 08:01:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346094AbjKBMBN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 08:01:13 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDFED13D
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 05:01:06 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id 98e67ed59e1d1-2809414efa9so844662a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Nov 2023 05:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698926466; x=1699531266; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cqny+M5uvbM/yvI/93voSmb/bNv7n/Z1HShErZfMR/U=;
        b=R68p3Ki/Lmw5VVF1CYdjAzUiBFF1q8JfdNuS2ZINDS7RTx2D/BsY+UuM7eVewTYw9u
         kOVcR9vqkSYy0iD/NxP71LS+agb57fnOBaBwfjNfh9kROhVgOS38xyLwnnVNtm8qQO3c
         +KijIMbwC4mXHaKgYugKyU/Q3nZsvz0Re0YwppFzxpHdNMKN1ffSuNcr3zdaU6snT2ni
         ngM8CS8BEfSeLjBwIaznAN4SsC1KMTL8GODeZ+R1mC6b0TEzY5RjoTF73WLxh1N8sewd
         afvKcB3km2N2wBIykcbZ4y+xedpuJO4Y3LsiF4rnZSPZ/nW3QHoLzqO3K0u7L7nxnvBs
         XM3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698926466; x=1699531266;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cqny+M5uvbM/yvI/93voSmb/bNv7n/Z1HShErZfMR/U=;
        b=qHk2ZJMm7tQXOmcwmzzJ2IwwSnCDPh86Suj9ccR3TVyRNNYb5XJP++Xy/3rwGdgy2X
         l3P7SreUjuloHoc9XAq/Qw77MTWQPXZmI4wGf5WqvQB2xmDqJU0m0Rf+Qosgw9JdKMS+
         h94Wrk5KBU0PUmJiJMzljkfeIMyoHh58Q0aXkfAWvsNtdPRDSKW5wYILcLrga3ewUur1
         OP8AmYQw5f16GvZ8vPyPJILY+JEZBYgmttv2UVSajP794RvPO38odiCTqeo+8umOYY8W
         vnjSn31U8QblVjbia6GCbroTvVXIVCPRgH3bMac2NvCnCKmtnAK5DSewuEZ1UWkbifnc
         LrEw==
X-Gm-Message-State: AOJu0YzOQuMy7n0YCXePK6k6ZDx/FVKIKoDrlju1Grgqk0t8K+zoeNqI
        GPV6IvTiEwZ1dLLBeYZ5KmmVInDt5I0=
X-Google-Smtp-Source: AGHT+IEYWbMWfhsAH7oVf+R9P73xfw9AlFWWUru904+MQepd8tbnrZMJvNO+7xS6HhxFZHmploPr9w==
X-Received: by 2002:a17:90a:b116:b0:280:21bd:2749 with SMTP id z22-20020a17090ab11600b0028021bd2749mr12504677pjq.0.1698926465768;
        Thu, 02 Nov 2023 05:01:05 -0700 (PDT)
Received: from debian.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id hg12-20020a17090b300c00b00280469602bcsm2380738pjb.2.2023.11.02.05.01.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Nov 2023 05:01:01 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 4AC8994783D8; Thu,  2 Nov 2023 19:00:57 +0700 (WIB)
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
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH RFC 0/4] Documentation: Web fonts for kernel documentation
Date:   Thu,  2 Nov 2023 19:00:42 +0700
Message-ID: <20231102120053.30630-1-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5217; i=bagasdotme@gmail.com; h=from:subject; bh=CfZUrYRJktYUl+Jf7DLm/CZWf7jeVSZuIXPsydEje6Q=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDKnOPVcnLFDMOLU19+KDbephD0SjbR8GRtbvn2qh7pPc6 SgcfTS8o5SFQYyLQVZMkWVSIl/T6V1GIhfa1zrCzGFlAhnCwMUpABOxOM/I0H86UoOPkWfOJzXz GzlPF/H+aqi4W7RlS/3ruAnvrf5Y9zH8U3GeWvxyp0hfzM6Pq02OvOZLjgzp+jzl5IsYrYqGvc1 lDAA=
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

