Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 023327A33D9
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Sep 2023 07:30:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233700AbjIQFaI convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 17 Sep 2023 01:30:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233820AbjIQF34 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Sep 2023 01:29:56 -0400
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6172D19F;
        Sat, 16 Sep 2023 22:29:51 -0700 (PDT)
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-792979d4cb5so128746839f.2;
        Sat, 16 Sep 2023 22:29:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694928590; x=1695533390;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tpNTlQ+I7CtsqqIB+axgS1MdKohh402zrq7Eb4xNf68=;
        b=KCdYb4MZgD/M5H0BVAwq3MF6oDmQxCKzYRa98VIk9O3jE6WaYRNLra3KoAR7ViiFRY
         a9B0qwZw5AMKf/jfmhxDfL/QFpEXOitwKLPycPx6xAfTi6zNC1pW/wQmqTUbrBfZFcwh
         FiuwQ4MgNwWNU2QcKxOgSaaBPAGBJTYrj+hhJk3LIfPGuYnQQyZLAuklj5U7cnOOTuBx
         G4dbRXj8zQhSJO4Wcj9R91ic4csYmiq5qIk1fEk3Dw4yfuq3zFMwKrpAN1mlwvaz+WZ2
         xSpNapPRQIeP8geSaTjDMNb71/+oAXPVPhB+mz8qsd3NpcqEsMgCYdBnoL1BJt8XW7ke
         xytg==
X-Gm-Message-State: AOJu0Yzo04U9aqMBZ5nwTn75XE8aKaFj2NlW02uB28vr4zYzp6hF/toE
        kEuwwLW/QTJnknY79tR0SfpJJUvZiWpdzaoW54g=
X-Google-Smtp-Source: AGHT+IF3QvKmNNGR1cNWajdo3lRVBvm9Np+46EOSZsCsh2b0DFOqYFTb8nEPA60Nu9s/6e6lGfa/fieJjVqNSX7n5AU=
X-Received: by 2002:a6b:ef09:0:b0:787:1472:3181 with SMTP id
 k9-20020a6bef09000000b0078714723181mr6861355ioh.3.1694928590567; Sat, 16 Sep
 2023 22:29:50 -0700 (PDT)
MIME-Version: 1.0
References: <20230915090910.30182-1-colin.i.king@gmail.com> <CAP-5=fVwyt+VriYacj3nmGZbfqVZciRwozr2sJQSPpHhoyxAaA@mail.gmail.com>
In-Reply-To: <CAP-5=fVwyt+VriYacj3nmGZbfqVZciRwozr2sJQSPpHhoyxAaA@mail.gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Sat, 16 Sep 2023 22:29:38 -0700
Message-ID: <CAM9d7cikYxmbnRS0djejEB-zh04hKt6dbHnoof3S35Mn9-c2RQ@mail.gmail.com>
Subject: Re: [PATCH][next] perf kwork: Fix spelling mistake "COMMMAND" -> "COMMAND"
To:     Ian Rogers <irogers@google.com>
Cc:     Colin Ian King <colin.i.king@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 15, 2023 at 9:44 AM Ian Rogers <irogers@google.com> wrote:
>
> On Fri, Sep 15, 2023 at 2:09 AM Colin Ian King <colin.i.king@gmail.com> wrote:
> >
> > There is a spelling mistake in a literal string. Fix it.
> >
> > Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
>
> Reviewed-by: Ian Rogers <irogers@google.com>

Applied to perf-tools-next, thanks!

Namhyung
