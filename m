Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0977481070C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 01:54:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378074AbjLMAyT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 19:54:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378068AbjLMAyR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 19:54:17 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F24A5AA;
        Tue, 12 Dec 2023 16:54:22 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-6ceb93fb381so4638031b3a.0;
        Tue, 12 Dec 2023 16:54:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702428862; x=1703033662; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nhDMSgCyoOSy52dPqiJZy8beciN9kQ6tNGi36qhCcB0=;
        b=lFLha33NTOiZhpnK2ukb7Y63hjoOulqHUSNkKuxZu7Msgr06zjmy/5K3elQJOC0q0c
         HLAsQS4wvG89GvySxTGb9gXXgs7rQlBuoLvYSjmc+5rJpq3KJcH2fX/+10DAhcoHqYM/
         Dsam+TKiQa/Q2kHx36Z97fLi7DmcWdYlxLsTYi7C9hbiAcLy3fTv5XKgOUkwiKiubMqU
         DQS/EhMPFXnOgySOPoH62mfL9ZU5k1d/vrsXkd7qvJZ00r5k9Ar9DEFmw2HExKKqTgvG
         ehqFPfLSNwVU6gRiIX1NbtJsEoh6sNE5rJgu2trr/JtogRCH/S0i/aW+ayDl9BKKOrF/
         lzMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702428862; x=1703033662;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nhDMSgCyoOSy52dPqiJZy8beciN9kQ6tNGi36qhCcB0=;
        b=WuC7j+W6W0ud6eXU6wjx3iTB56BGzhCrCCqjiabLFTdPIWjM1IaobQ1+yiWFp4G5bt
         7Ecq6gB55MYDkLqOM1HIYHqnvtnXLKk0iJJDJihCsh5ZBJvTYAnFvUD6E+xqRq4aVIvj
         wVr1XFqOEiVaTZ7HuIscvukZYnOPrJPj2xRMKRA1tlHSqSNGQk+9AhYGvTHpPkQSb6g9
         Pyy4eQE32CaALnfIJssvWQ/XqGhH3XWYAIlS0m0W6z2rMeYOogfSXenxz2LnaQH23Zn6
         aeckHvMjHKVmzhHcjmx2snAB3fUfYyb2KUA38jkKbZGRXhOI16bTJOYKQY65GoFtP07n
         IuDw==
X-Gm-Message-State: AOJu0Yy50mRElkPgHD1XJScjWuE+vTEewilfxu41vWep8jmOxsH8z1BX
        MOgS6vCWYvn5lF8DEvFFSVwVh86MSYnTYJ2Zd5Y=
X-Google-Smtp-Source: AGHT+IGLHTHBhe/sOquSIJESUXnDbnR24qEnQUrcvlYkZhp9z6hka8ieT+4so2qxEbo4uD8mUdNteYCrybjcOFDTcy8=
X-Received: by 2002:a05:6a00:22c6:b0:6ce:521e:23dc with SMTP id
 f6-20020a056a0022c600b006ce521e23dcmr9228663pfj.9.1702428862232; Tue, 12 Dec
 2023 16:54:22 -0800 (PST)
MIME-Version: 1.0
References: <20231212070547.612536-1-namhyung@kernel.org> <CAP-5=fV5sA1ga5UfvHW_=Ep25b-TzsLJ8Atqk3KePKOx-fk9TQ@mail.gmail.com>
In-Reply-To: <CAP-5=fV5sA1ga5UfvHW_=Ep25b-TzsLJ8Atqk3KePKOx-fk9TQ@mail.gmail.com>
From:   Pablo Galindo Salgado <pablogsal@gmail.com>
Date:   Wed, 13 Dec 2023 00:54:10 +0000
Message-ID: <CAFjbc8Gt1GpLWjDf1jdhnb6fhVx246Tik+_TFXarGEqiZUY5BQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] perf tools: Random fixes for DWARF unwind
To:     Ian Rogers <irogers@google.com>
Cc:     Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org,
        Milian Wolff <milian.wolff@kdab.com>,
        Fangrui Song <maskray@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> It'd be great if we could do similar for CPython.

We (the CPython team) plan to release the perf jitdump support for
Python 3.13 (around next October) so you will need to build from
source or wait until is officially released for that test.

Pablo
