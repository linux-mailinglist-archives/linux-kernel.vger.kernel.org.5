Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4CA37588B2
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 00:46:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231297AbjGRWqK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 18:46:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230187AbjGRWqI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 18:46:08 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74CC61993;
        Tue, 18 Jul 2023 15:46:02 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-6687096c6ddso4076832b3a.0;
        Tue, 18 Jul 2023 15:46:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689720362; x=1692312362;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=T4TYcJ6kJj+x5DAbAdG+E1DjL2MWhgVK1ZpBFIUC5tI=;
        b=ohqtktsheOrMKmDN7OBQLc5J6SKol3OUWxfJHUXGakAil+CmPTqVhgEmdMvR3U0AGH
         fH4fwz04EgluDWbsbzOadF+PGVIKbCKIA9RQhOwi+AfH7WzBHmhK+xXdZqNrF1KGe0SP
         SsLQoXjtqPJJ1BDSY56oGwKNeKemUnHNh6pSwz6Hu289e72oGzfUaagAjIiPQw9jpQfs
         ZfhqDcDT/oTYFmqAXaM0Nt/q4mcLmZQ+mLBHE9xbmFqIZpJqSoSzg/OQfKFHqg9KLIBt
         7H3QVJSNrKpS/3748U5Y3kvBQheCir1Ds2af7LgHn+CWGKUxG4R8O8cuXyX+N3KJA6DX
         +4iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689720362; x=1692312362;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T4TYcJ6kJj+x5DAbAdG+E1DjL2MWhgVK1ZpBFIUC5tI=;
        b=RodiAktyLbs2syWTyngAbW9pnvpBNnImxWS3E9z0sGIy5usveegJ9WaUZP9u3V86mt
         tHgRPogF0uNLHmH9V82S/sKHgvhwn0af+ixrSip5F8ZBxTAq8McJrKfi9IwPoV/WtN8e
         oVZ9jburC7HusCSQpNf8QnoQXm5HT53P63V1GUBmZhtj9IuZM0+Mnkdfrkpz0/Hvk7uG
         +7SCnITPI9EqSbzknXPMQGNKj4xNMo+GKYCO4KcTZUMAIUxDZYCZZEJGYwQjhs7FQ03H
         dTXNr0Q44ZEHDRaRXVBNzO2ohiGOdTzCUBgiGnXbrvWAWYT3H7WiTZFL+KOWXPjbj4Mt
         LuOw==
X-Gm-Message-State: ABy/qLaDQVKBgkpZWa+QnO+zGbwdvjBEXLx3oxlcvcb7z6E9YMvoLF95
        sfQdls6EHijRd7K5BJUpQ0A=
X-Google-Smtp-Source: APBJJlE/SnQlaOlY+szvLzuh0xcUq+lACkfnx21q935fKd3a8aArCKYjDIb3jHPNm6byNbXkzZxkDA==
X-Received: by 2002:a05:6a00:1827:b0:681:50fd:2b85 with SMTP id y39-20020a056a00182700b0068150fd2b85mr17058349pfa.27.1689720361691;
        Tue, 18 Jul 2023 15:46:01 -0700 (PDT)
Received: from yoga ([2400:1f00:13:be68:c61a:77e0:3624:e4f6])
        by smtp.gmail.com with ESMTPSA id x48-20020a056a000bf000b00682b2044149sm2008018pfu.4.2023.07.18.15.45.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jul 2023 15:46:00 -0700 (PDT)
Date:   Wed, 19 Jul 2023 04:15:52 +0530
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
Subject: [PATCH v4 0/6] Add support for Firefox's gecko profile format
Message-ID: <cover.1689718662.git.anupnewsmail@gmail.com>
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

This patch series adds support for Firefox's gecko profile format.
The format is documented here [1].

I have incorporated several changes based on feedback from the
previous version of the patch.

Changes in v3:
- Implemented object-oriented programming (OOP) approach for Thread and Sample
  to improve code organization and maintainability.
- Enhanced user experience by introducing argparse for changing color settings
  of user and kernel symbols during execution.
- Ensured proper module encapsulation by adding imports wherever necessary.
- Improved code readability by adding descriptive comments and type annotations.

These changes focus on adopting OOP principles, enhancing user interaction with argparse,
and making the code more readable with comments and type information.

TODO:
- use cpu_mode to determine the category instead of finding it from symbol name.
- Write a test.
- add direct execution command for this script under script/python/bin directory.

Committer Testing:
- Tested with a perf.data file generated for single and multiple cpu
  cores enabled.
- Uploaded the stdout into profiler.firefox.com and verified the
  output.
- Verified the output with the output generated by the existing
  script as mentioned here [2].
Method:
- perf record -F 99 -a -g -- sleep 5
- perf script firefox-gecko-converter.py > output.json
- upload output.json to profiler.firefox.com

[1] https://github.com/firefox-devtools/profiler/blob/main/docs-developer/gecko-profile-format.md
[2] https://perf.wiki.kernel.org/index.php/Tutorial#Firefox_Profiler

Anup Sharma (6):
  perf scripts python: Add initial script file with usage information
  perf scripts python: Extact necessary information from process event
  perf scripts python: Add classes and conversion functions
  perf scripts python: Add trace end processing and PRODUCT and
    CATEGORIES information
  perf scripts python: implement internal get or create frame, stack and
    string function
  perf scripts python: Implement add sample function and thread
    processing

 .../scripts/python/firefox-gecko-converter.py | 339 ++++++++++++++++++
 1 file changed, 339 insertions(+)
 create mode 100644 tools/perf/scripts/python/firefox-gecko-converter.py

-- 
2.34.1

