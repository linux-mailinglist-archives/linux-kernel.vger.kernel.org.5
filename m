Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 801677593B3
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 13:04:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229801AbjGSLEk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 07:04:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjGSLEj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 07:04:39 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24707186;
        Wed, 19 Jul 2023 04:04:38 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id ca18e2360f4ac-783698a37beso387942539f.0;
        Wed, 19 Jul 2023 04:04:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689764677; x=1692356677;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sf4ZRV10sV6tx4jAS43WUBL09WMMeV0xvAxTcrZcosU=;
        b=syS5KsxIe77zYDrCENDBQkrf7gsj3kAytcNlamTWsCmzB/0Jh8evMBT6NjC3nVN9iQ
         Wo4tXlj4vXy8P2mt9hlIFXcLuHAn6txEdXGbkqeG3db8MY1/raF5Wu3jBj30B0heQ1hM
         gzPZjOziD3R5nPRIToOO6eqLMhZKZJaydN3MoRa0E00Yb666/T0A+FVZr9k1Y8uOoV+h
         sugQOqGxtgsI/qT5Rsh6THy8EucTFCgqX6Sou7AaZWfFmgImeZTsQIE6LwUkr1TWEV/v
         NIPJRzzXBIpnSwfphiJ33nEKZoDxd7IRf5o7yYLw9KimPwrRMzkceIFvsP/sEcKl4csY
         T08w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689764677; x=1692356677;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sf4ZRV10sV6tx4jAS43WUBL09WMMeV0xvAxTcrZcosU=;
        b=aYmRweqD4P56KdR5FZdeEM887iNK6pJTPbwi3zW8uxSUoh/5E4FgDEpn4DVDIihAHc
         Lx4xoK/2rt1tBNuI//aeECohZW/W1RnQb20l6Nxk9yeh0g9IK2LTPpFnk+Zmfxuxv7XY
         RN53ic7MyMJmzFVZlY4SmeSS2x/ibJsNpqSZB22E1Y+Vfi0+vrDCyllk8JB7ICnieeww
         RTPpFW3seBazSjhS+jSh+B+WgfyENWmAxnEedHzPbGhrAtJt7ZI/mh4xy5bEZtpymxKz
         r6zf+kIZOuZBnPk2j5AuhHmSU8InKwp6+DQTuP7xdqSc27rL4geP9gEer9xwydjXvW8z
         PB+g==
X-Gm-Message-State: ABy/qLYjb9vZjj3eFp+ASc3sX7m+Qa2jbEAoUZYTs1O7kHvQyhtaXpTo
        07VUJMMTyWKBrJ5IcPp8SKE=
X-Google-Smtp-Source: APBJJlGaE1cI4QMalhDeKG+GT6zh5I35yQo6jroBAILxmWinh1inRLDQtp8kaGEZA7UT3BAER1aIYg==
X-Received: by 2002:a6b:fe17:0:b0:787:1f16:53ce with SMTP id x23-20020a6bfe17000000b007871f1653cemr5434904ioh.18.1689764677154;
        Wed, 19 Jul 2023 04:04:37 -0700 (PDT)
Received: from yoga ([2400:1f00:13:be68:7e35:c5e7:4202:bd70])
        by smtp.gmail.com with ESMTPSA id c1-20020a170902d48100b001b896d0eb3dsm3680730plg.8.2023.07.19.04.04.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jul 2023 04:04:36 -0700 (PDT)
From:   Anup Sharma <anupnewsmail@gmail.com>
X-Google-Original-From: Anup Sharma <AnupSharma>
Date:   Wed, 19 Jul 2023 16:34:28 +0530
To:     Anup Sharma <anupnewsmail@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/6] Add support for Firefox's gecko profile format
Message-ID: <ZLfDPPYK1PXc9xOe@yoga>
References: <cover.1689718662.git.anupnewsmail@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1689718662.git.anupnewsmail@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 19, 2023 at 04:15:52AM +0530, Anup Sharma wrote:
> This patch series adds support for Firefox's gecko profile format.
> The format is documented here [1].
> 
> I have incorporated several changes based on feedback from the
> previous version of the patch.
> 
> Changes in v3:
a small typo here. It should be v4 instead of v3 (changes in v4).
> - Implemented object-oriented programming (OOP) approach for Thread and Sample
>   to improve code organization and maintainability.
> - Enhanced user experience by introducing argparse for changing color settings
>   of user and kernel symbols during execution.
> - Ensured proper module encapsulation by adding imports wherever necessary.
> - Improved code readability by adding descriptive comments and type annotations.
> 
> These changes focus on adopting OOP principles, enhancing user interaction with argparse,
> and making the code more readable with comments and type information.
> 
> TODO:
> - use cpu_mode to determine the category instead of finding it from symbol name.
> - Write a test.
> - add direct execution command for this script under script/python/bin directory.
> 
> Committer Testing:
> - Tested with a perf.data file generated for single and multiple cpu
>   cores enabled.
> - Uploaded the stdout into profiler.firefox.com and verified the
>   output.
> - Verified the output with the output generated by the existing
>   script as mentioned here [2].
> Method:
> - perf record -F 99 -a -g -- sleep 5
> - perf script firefox-gecko-converter.py > output.json
> - upload output.json to profiler.firefox.com
> 
> [1] https://github.com/firefox-devtools/profiler/blob/main/docs-developer/gecko-profile-format.md
> [2] https://perf.wiki.kernel.org/index.php/Tutorial#Firefox_Profiler
> 
> Anup Sharma (6):
>   perf scripts python: Add initial script file with usage information
>   perf scripts python: Extact necessary information from process event
>   perf scripts python: Add classes and conversion functions
>   perf scripts python: Add trace end processing and PRODUCT and
>     CATEGORIES information
>   perf scripts python: implement internal get or create frame, stack and
>     string function
>   perf scripts python: Implement add sample function and thread
>     processing
> 
>  .../scripts/python/firefox-gecko-converter.py | 339 ++++++++++++++++++
>  1 file changed, 339 insertions(+)
>  create mode 100644 tools/perf/scripts/python/firefox-gecko-converter.py
> 
> -- 
> 2.34.1
> 
