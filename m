Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA1F077A312
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 23:36:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230006AbjHLVge (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Aug 2023 17:36:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjHLVgd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Aug 2023 17:36:33 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 217571706;
        Sat, 12 Aug 2023 14:36:36 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-68730bafa6bso2866339b3a.1;
        Sat, 12 Aug 2023 14:36:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691876195; x=1692480995;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wa8XBwPigobobIYOZwDPIfHtzN+bm0HM3i60VeEtrcM=;
        b=prRKN05ah5mxmdwO8fMp8t30JTrbepUytiLrBxzGKQopjwdyUTITmDIJVQCvoVYXop
         HqYgo57kuM6ENZmTAjDseW3c4A0EjmbpLvfVD9u2zkX2jolxg0DG6MeA+GbDpjZDxNQC
         mw6Vsj88KeIjeBPfNtPYBJZxjdX4a/laq8RncGFDR31R8zy1dkKpafPOEMLX/nW2c/WD
         Clfh+/cy9NQNZncO5ZOjYUeIerP35iTIyB6hBYgYKMvH1LbXimGalKuPP+8922m2xGV3
         K1txPKxpHzW2HpYTaKrp45sx5jb0CvVv/bjSsBZYZU9F8jHFIk77M1FpAv9S/bjZziOQ
         4rmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691876195; x=1692480995;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wa8XBwPigobobIYOZwDPIfHtzN+bm0HM3i60VeEtrcM=;
        b=Vwppb5GhaPu1dODd8N1DgEAEhITbbqJ3BvnNjnm88Jqi/rfbehAilDL1CxqUUSqsLl
         M5bgFNISss/4zWqh5YOrDj5/Cgog5+Hxq/v8q2SDMUBpMfn3FrwDrcJas+nlUZlU3FT2
         dKDBms3yPFrxEtIgnSEsFfshNeL7jEk2o01Lnmnlw9HTkcuQtQ8zuFQKMzXQtARBFlPR
         2rPBU5I3MAsRX/UGXIQv/eNQMVZWrzTiAoYZm8k7uYQC9VEHOBSQRG93ibO00K7nD8ue
         2MJ5oh/ybgEkp7J/agJa8wkvc/pfsrf+4fuJ5U03PN190tEPOkInGoe7p4VW7Solp36d
         2T0Q==
X-Gm-Message-State: AOJu0Yzqz2nLqnGXeiectUNaUJt2tzF5Y+sV+8ZAdSxupzok8RWa68la
        eHEGrmVQCjgh4mWJiRKwc94=
X-Google-Smtp-Source: AGHT+IHCq0iH/Az3xVQnRlfpxOcT6U40u9MnDlJ21dCfozsvHss0Bk4PcsZiVOh/cgNgHba0716MwQ==
X-Received: by 2002:a05:6a20:8422:b0:13e:debc:3648 with SMTP id c34-20020a056a20842200b0013edebc3648mr10893039pzd.29.1691876195351;
        Sat, 12 Aug 2023 14:36:35 -0700 (PDT)
Received: from yoga ([2400:1f00:13:dd22:5ae5:bc57:c1e5:1a03])
        by smtp.gmail.com with ESMTPSA id w20-20020a637b14000000b0055fd10306a2sm5674478pgc.75.2023.08.12.14.36.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Aug 2023 14:36:34 -0700 (PDT)
Date:   Sun, 13 Aug 2023 03:06:27 +0530
From:   Anup Sharma <anupnewsmail@gmail.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        =?utf-8?B?wqA=?= Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Anup Sharma <anupnewsmail@gmail.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH] perf scripts python: Add support for input args in gecko
 script
Message-ID: <ZNf7W+EIrrCSHZN0@yoga>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Refines the argument handling mechanism in the "gecko-report"
script to enable better compatibility and improved user
experience. The script now differentiates between scenarios
where arguments are provided for record and report cases
where gecko.py arguments are passed.

Signed-off-by: Anup Sharma <anupnewsmail@gmail.com>

---
Hi Arnaldo,
Thanks for providing such a detail insights here:

https://lore.kernel.org/linux-perf-users/ZMJaDGhSnhIlK3Nd@kernel.org/

I've successfully confirmed that the command "perf script gecko -a sleep 1"
is functioning as expected. However, I encountered an issue when attempting
to provide arguments such as "--user-color" and "--save-only" to the
"gecko.py" script while using the "perf script gecko" or "perf script report
gecko" commands.

In order to understand the inner workings of how these commands are executed,
I delved into the "buildin-script.c" code. From my investigation, it seems
that the arguments are taken into account for the "record" functionality,
rather than for "report."

To address this  I added this changes.

I've also documented the usage of this command in our wiki:
https://perf.wiki.kernel.org/index.php/Tutorial#Firefox_Profiler

For most cases where users do not require specific "gecko.py" arguments, the
command "perf script gecko -a sleep 0.5" is sufficient. However, if users
intend to provide particular arguments to "gecko.py," they should employ the
command "perf script report gecko --save-only=cloud_cpu.json."

I believe there might be an intelligent solution to streamline this process.
Therefore, I would greatly appreciate your insights on this matter.
---
 tools/perf/scripts/python/bin/gecko-report | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)
 mode change 100644 => 100755 tools/perf/scripts/python/bin/gecko-report

diff --git a/tools/perf/scripts/python/bin/gecko-report b/tools/perf/scripts/python/bin/gecko-report
old mode 100644
new mode 100755
index 0c12cc08f3ab..1867ec8d9757
--- a/tools/perf/scripts/python/bin/gecko-report
+++ b/tools/perf/scripts/python/bin/gecko-report
@@ -1,3 +1,7 @@
 #!/bin/bash
 # description: create firefox gecko profile json format from perf.data
-perf script "$@" -s "$PERF_EXEC_PATH"/scripts/python/gecko.py
+if [ "$*" = "-i -" ]; then
+perf script -s "$PERF_EXEC_PATH"/scripts/python/gecko.py
+else
+perf script -s "$PERF_EXEC_PATH"/scripts/python/gecko.py -- "$@"
+fi
-- 
2.34.1

