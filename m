Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F85475A080
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 23:22:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230367AbjGSVWJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 17:22:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbjGSVWH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 17:22:07 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A7FE1FC1;
        Wed, 19 Jul 2023 14:22:03 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id 46e09a7af769-6b9ede6195cso78087a34.3;
        Wed, 19 Jul 2023 14:22:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689801722; x=1692393722;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=OFl/Yl2t3jZxg8bk98EE4w1kgxMDfOoVWrddWbZKwzc=;
        b=LvdU0252mMyEGXPltgxFd7ClTEyB1xQHReV/hB/Yx+VQe3ioTeRI5HjMazr8ycJwdz
         39sLqNpiMiZ5Xt9QlgqxwzzkVtVkwmogyUQ7crc9b3v9sf36o1PCJUZpwHFUrrlHIWNB
         2GuQDURNHitWcq/fnxqdiwcS9Y2FDWddIukt1xqW7httaaAJeNSfv9fsR9C+Z6/CN/wj
         7z+TN0bGVsCfQ64WdLOoPywc/gIW9OQqKtrKRE5rLCicelvaIILAJfmf36wmD0VbCSLl
         Yo0HxE2bFseT66eAylZ5fLh6ICKtxM/TsivsUHfiJ9f7fBqP8S6mHLIFO3liNTUOolBy
         eyQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689801722; x=1692393722;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OFl/Yl2t3jZxg8bk98EE4w1kgxMDfOoVWrddWbZKwzc=;
        b=aI24zhuUU8pByOj5nHABIQhkF6CB46Jsb+QbKmekFmixhYkn58NyR+T8OMXG+mulab
         AP3cbCQD7Q/BtrMw8YZ+Js8sU7x2jKrUp/Cr6z1KBuYrCdG1gaS+lAdDw0AZ6gcwPJr4
         3C6qWcr4J1mLFntCOcHFYsTgiHDNYGiYFIxHE8uRtBQIdybnAI7ZGD7bABXbtrJYCOKS
         mErW2bzLqiTfJQ9hIBPUmpeWRCerQ58di2Az2C8YdurEv73wFARbyNIBZV8q0ov90IoL
         MqF1ZqwteY3orWYNBb872X9JPBbE0RlrufxIBngsBYNI89oi+NrhaAKZm4QePzq4/5CS
         ZJWw==
X-Gm-Message-State: ABy/qLY1xHtiLy1Mk7U0tRdQc/iIfNqqrevkVwMa7fAVyQ3TUvWKUReG
        EJyWScQMXM/YA591y477Yvs=
X-Google-Smtp-Source: APBJJlFuxJxUINU7EE8ZuowGQbMZQE2qK3cBwhrFaPr8H40D/bilat0UFoVwMkL80wxa2jpIeL3L+A==
X-Received: by 2002:a05:6358:4198:b0:132:d32d:d929 with SMTP id w24-20020a056358419800b00132d32dd929mr21265191rwc.20.1689801722132;
        Wed, 19 Jul 2023 14:22:02 -0700 (PDT)
Received: from yoga ([2400:1f00:13:be68:d721:f1d5:796e:8708])
        by smtp.gmail.com with ESMTPSA id a11-20020a637f0b000000b005633941a547sm3695601pgd.27.2023.07.19.14.21.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jul 2023 14:22:01 -0700 (PDT)
From:   Anup Sharma <anupnewsmail@gmail.com>
X-Google-Original-From: Anup Sharma <AnupSharma>
Date:   Thu, 20 Jul 2023 02:51:53 +0530
To:     Ian Rogers <irogers@google.com>
Cc:     Anup Sharma <anupnewsmail@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/6] Add support for Firefox's gecko profile format
Message-ID: <ZLhT8e7VIUnnhHVV@yoga>
References: <cover.1689718662.git.anupnewsmail@gmail.com>
 <ZLfDPPYK1PXc9xOe@yoga>
 <CAP-5=fUzUoLEpjcrZTzX93TPFbRMUhZGF+BVLB9OiusmKJFYvA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fUzUoLEpjcrZTzX93TPFbRMUhZGF+BVLB9OiusmKJFYvA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 19, 2023 at 08:22:24AM -0700, Ian Rogers wrote:
> On Wed, Jul 19, 2023 at 4:04 AM Anup Sharma <anupnewsmail@gmail.com> wrote:
> >
> > On Wed, Jul 19, 2023 at 04:15:52AM +0530, Anup Sharma wrote:
> > > This patch series adds support for Firefox's gecko profile format.
> > > The format is documented here [1].
> > >
> > > I have incorporated several changes based on feedback from the
> > > previous version of the patch.
> > >
> > > Changes in v3:
> > a small typo here. It should be v4 instead of v3 (changes in v4).
> > > - Implemented object-oriented programming (OOP) approach for Thread and Sample
> > >   to improve code organization and maintainability.
> > > - Enhanced user experience by introducing argparse for changing color settings
> > >   of user and kernel symbols during execution.
> > > - Ensured proper module encapsulation by adding imports wherever necessary.
> > > - Improved code readability by adding descriptive comments and type annotations.
> > >
> > > These changes focus on adopting OOP principles, enhancing user interaction with argparse,
> > > and making the code more readable with comments and type information.
> > >
> > > TODO:
> > > - use cpu_mode to determine the category instead of finding it from symbol name.
> > > - Write a test.
> > > - add direct execution command for this script under script/python/bin directory.
> > >
> 
> Thanks Anup, is there a minimal TODO so that some code can be merged?

Yaah, only the first TODO is left, will discuss during office hours.

> I didn't have any comments for this series so:
> Acked-by: Ian Rogers <irogers@google.com>

Thanks for the review.

> I think even the test can be follow up as the code isn't on the critical path.

By the way, I've finished writing the test and will send it very soon.

> Thanks,
> Ian
> 
> > > Committer Testing:
> > > - Tested with a perf.data file generated for single and multiple cpu
> > >   cores enabled.
> > > - Uploaded the stdout into profiler.firefox.com and verified the
> > >   output.
> > > - Verified the output with the output generated by the existing
> > >   script as mentioned here [2].
> > > Method:
> > > - perf record -F 99 -a -g -- sleep 5
> > > - perf script firefox-gecko-converter.py > output.json
> > > - upload output.json to profiler.firefox.com
> > >
> > > [1] https://github.com/firefox-devtools/profiler/blob/main/docs-developer/gecko-profile-format.md
> > > [2] https://perf.wiki.kernel.org/index.php/Tutorial#Firefox_Profiler
> > >
> > > Anup Sharma (6):
> > >   perf scripts python: Add initial script file with usage information
> > >   perf scripts python: Extact necessary information from process event
> > >   perf scripts python: Add classes and conversion functions
> > >   perf scripts python: Add trace end processing and PRODUCT and
> > >     CATEGORIES information
> > >   perf scripts python: implement internal get or create frame, stack and
> > >     string function
> > >   perf scripts python: Implement add sample function and thread
> > >     processing
> > >
> > >  .../scripts/python/firefox-gecko-converter.py | 339 ++++++++++++++++++
> > >  1 file changed, 339 insertions(+)
> > >  create mode 100644 tools/perf/scripts/python/firefox-gecko-converter.py
> > >
> > > --
> > > 2.34.1
> > >
