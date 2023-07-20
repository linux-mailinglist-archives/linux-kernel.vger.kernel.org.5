Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3944575B122
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 16:22:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232180AbjGTOWd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 10:22:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232179AbjGTOWb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 10:22:31 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF28126B0;
        Thu, 20 Jul 2023 07:22:29 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1b8a8154f9cso6326175ad.1;
        Thu, 20 Jul 2023 07:22:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689862949; x=1690467749;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=d167hB7YQNbzLtoS0eVOcQB2Qin/w0s6eMtHjyAbHA8=;
        b=A6Q4mKG32BbL8dGXE8ejFUx9+raXF1AozeHkH5n+AY0KrBi1mlCmF4JoHIstLKzcHS
         MPk++3FR1T030YLCO1nYUcGbhiQnaydRl0YA/oCiqUORDvaO+Kus+eN+uX6blWyu6doe
         d+Q6XLYkQhtox6TlzvgRLYNp3M1LULKVnCUykMKVrDtymWIWK4Y/+s6/TtEngGnGmQU4
         lob2854rW7I2IGKIBXPBoZ+e/l5Xgu6wG3B9e/ncAFQEW/BogCKVNRhA8maJwqAa1XsU
         zKTHBOj+/AdIsnxxAwO79Mg6W2Cl7FAa69ZNoqsx5tmydTBHXO1mqk+LaTYUyPK/SerP
         sKkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689862949; x=1690467749;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d167hB7YQNbzLtoS0eVOcQB2Qin/w0s6eMtHjyAbHA8=;
        b=bxpgVLVvfFVchYDWIRrg01Ih4S/lwIExTtM73NwNyS9XWqKuUKW5e88LgJbdHryDFb
         A9WH5uPDVx2IuLTnZ9xOP+oyFAjL6Nw2J99qXZFfAV7as5C5LX4qBr7kCdoKtPXjHjoQ
         HEbfXTyfS1mNvmnR6S9a5z3bYPujTQtCrEHx6m8LP43xN5xlL2buL4t72dVFcKrlvWXv
         mcEMeHjUIWLuks2kXBtQrUGbwysoc7xgpqLALOxn1wdxHOWTlxHBlUqkwUvikqAU57Lq
         TW8ixvhVm+KtI8iuFXL09z/pcirOnQk0jn0jul8Xch+oGVjQULqdifdAZjfl3zteFfLD
         0Lyg==
X-Gm-Message-State: ABy/qLZNzOT6Li6GmdBF96YNcMbfNV3PpKnvLQpNQjjZ8oHgGzOcpUoU
        LUHQVaUGW9e4tJ826RVg4PBCvTilXvgniyWT
X-Google-Smtp-Source: APBJJlGyLu0aktPhWO+9sEJ6iXiRekutPKEHv9P5ijwVTYMWHUOdZ1fWFg0Umk3Ic+U9gHcx/K8RZw==
X-Received: by 2002:a17:902:d505:b0:1b8:c63:4b79 with SMTP id b5-20020a170902d50500b001b80c634b79mr7417637plg.19.1689862949258;
        Thu, 20 Jul 2023 07:22:29 -0700 (PDT)
Received: from yoga ([2400:1f00:13:4928:ca70:2ef7:845e:1b9e])
        by smtp.gmail.com with ESMTPSA id a17-20020a170902ecd100b001ba066c589dsm1432552plh.137.2023.07.20.07.22.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jul 2023 07:22:28 -0700 (PDT)
Date:   Thu, 20 Jul 2023 19:52:21 +0530
From:   Anup Sharma <anupnewsmail@gmail.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Anup Sharma <anupnewsmail@gmail.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] Add support for firefox gecko converter test and commands
Message-ID: <cover.1689862609.git.anupnewsmail@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds support for firefox gecko converter test and commands.
The firefox gecko converter is a python script which converts the
perf.data file into firefox gecko profile format. The script is
available at tools/perf/scripts/python/firefox-gecko-converter.py

Anup Sharma (2):
  perf scripts python: Add command execution for converter
  perf test: Add support for testing firefox-gecko-converter script

 .../python/bin/firefox-gecko-converter-record |   2 +
 .../python/bin/firefox-gecko-converter-report |   3 +
 .../shell/test_firefox-gecko-converter.sh     | 190 ++++++++++++++++++
 3 files changed, 195 insertions(+)
 create mode 100755 tools/perf/scripts/python/bin/firefox-gecko-converter-record
 create mode 100755 tools/perf/scripts/python/bin/firefox-gecko-converter-report
 create mode 100755 tools/perf/tests/shell/test_firefox-gecko-converter.sh

-- 
2.34.1

