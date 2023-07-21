Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63C8175D0E7
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 19:51:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229896AbjGURvQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 13:51:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjGURvN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 13:51:13 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3BC73580;
        Fri, 21 Jul 2023 10:51:10 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-668711086f4so1505876b3a.1;
        Fri, 21 Jul 2023 10:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689961870; x=1690566670;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Xpz1j0ViON/79H2hi1Eb1uXwApxUrfNApf/6cdh9gVs=;
        b=c38Cqeoo94sWHycPlXorn1b2IPOWpnBg3h+QpBzO7AaekTWgGxN8lRdRl/Ab2XEU40
         meBodYoL2nOUb3kwj+dHewh4qq1Q9FLtLZE82HzzYD3TsexYtaxEhwKw/xBYH2qVMfxS
         uj5elBlVTSIfM2SdfB5rbuUUT7Fx/mMt7ZyyLpTsWByNFJBDlD2kDUadTRMn9WwCK0EE
         H0OaqUOz81Qp31ePNwAknTFxc47XI+iyXxRj0SSuERcr0O1d6S6D1E1Gy+HWdopylbJ8
         GHR5epNhagfo8IW2lQoxweE7qMHG1ahKcJvykwMrodSDIfrFQxAU83B+BA6ZqqEn9hC5
         Yngg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689961870; x=1690566670;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Xpz1j0ViON/79H2hi1Eb1uXwApxUrfNApf/6cdh9gVs=;
        b=SdGNvv7+hLxk1h2IEkNFbrBN4KyGt1jJoRjhEO7YX4frwQ/mPL3PvDSQ/fYk5HPMiK
         MBZYUWFdUuycjlkRwp5aXxuhQvQMzgcagUVT2U2lUMKtHM+a5bjFCI3JWIJiiVYOlM9i
         lKRfmGstuRNKesaCkLbUw7LymwefrOasuVT85E/UujVL3Yi3GkIlYSeAYvJiuqL+EvhN
         YMdadJw33KQVGER5taEoIlRZ09xI8yRRb2909G739Us/DNGu6FrHi17KVK5s4iX2+MOR
         twn9fL4EDKyixArh1mdW7HDPCj4ChE1Y5p34IQzMuqR4PB274Y6wtDVCMXBjvQsrjpDT
         wBZQ==
X-Gm-Message-State: ABy/qLYhoWV8zieggYhLMiHMuO5EfZktfWv7zl21LmBdo6P/52xxENhh
        GFrzWxFXI+2yrb+ZZkOtWPg=
X-Google-Smtp-Source: APBJJlFyRRRr9DW6Q6e9XUtTfgm9f8cMnHFp/DhAiEmIxrd4jlqg45OayAjc7h4RSnT2JNJyaXuGrw==
X-Received: by 2002:a05:6a20:394f:b0:10b:764b:a942 with SMTP id r15-20020a056a20394f00b0010b764ba942mr4627422pzg.11.1689961869947;
        Fri, 21 Jul 2023 10:51:09 -0700 (PDT)
Received: from yoga ([2400:1f00:13:cde2:d588:8109:e86b:839c])
        by smtp.gmail.com with ESMTPSA id y6-20020a63b506000000b005348af1b84csm3346092pge.74.2023.07.21.10.51.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 10:51:09 -0700 (PDT)
Date:   Fri, 21 Jul 2023 23:21:00 +0530
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
Subject: [PATCH v5 0/8] Add support for Firefox's gecko profile format
Message-ID: <cover.1689961706.git.anupnewsmail@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds support for Firefox's gecko profile format.
The format is documented here [1].

I have incorporated several changes based on feedback from the
previous version of the patch.

Changes in v5:
- Reorganized the patch series to ensure that each patch works independently.
- Renamed the file to perf-gecko.py.
- Added command exection support for the script. The script can now be
  executed as "perf script report perf-gecko > output.json."
- Simplified the usage information; previously it was "perf script
  perf-gecko.py > output.json," now it is "perf script report
  perf-gecko > output.json."
- Merged the test and command execution patches into this series,
  which were previously in a separate series.

Committer Testing:
- Tested with a perf.data file generated for single and multiple cpu
  cores enabled.
- Uploaded the stdout into profiler.firefox.com and verified the
  output.
- Verified the output with the output generated by the existing
  script as mentioned here [2].

Method:
- perf record -F 99 -a -g -- sleep 5
- perf script report perf-gecko > output.json
- upload output.json to profiler.firefox.com

[1] https://github.com/firefox-devtools/profiler/blob/main/docs-developer/gecko-profile-format.md
[2] https://perf.wiki.kernel.org/index.php/Tutorial#Firefox_Profiler

Anup Sharma (8):
  perf scripts python: Add initial script file with usage information
  perf scripts python: Extact necessary information from process event
  perf scripts python: Add classes and conversion functions
  perf scripts python: Add trace end processing and PRODUCT and
    CATEGORIES information
  perf scripts python: Implement add sample function and thread
    processing
  perf scripts python: Implement add sample function and thread
    processing
  perf scripts python: Add command execution for firefox gecko converter
    script
  perf test: Add support for testing firefox gecko converter script

 .../perf/scripts/python/bin/perf-gecko-record |   2 +
 .../perf/scripts/python/bin/perf-gecko-report |   3 +
 tools/perf/scripts/python/perf-gecko.py       | 339 ++++++++++++++++++
 tools/perf/tests/shell/test_perf_gecko.sh     | 188 ++++++++++
 4 files changed, 532 insertions(+)
 create mode 100644 tools/perf/scripts/python/bin/perf-gecko-record
 create mode 100644 tools/perf/scripts/python/bin/perf-gecko-report
 create mode 100644 tools/perf/scripts/python/perf-gecko.py
 create mode 100755 tools/perf/tests/shell/test_perf_gecko.sh

-- 
2.34.1

