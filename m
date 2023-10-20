Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 356257D07AD
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 07:40:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235620AbjJTFks convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 20 Oct 2023 01:40:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235599AbjJTFko (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 01:40:44 -0400
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B02D71A4;
        Thu, 19 Oct 2023 22:40:42 -0700 (PDT)
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-27d11401516so379485a91.2;
        Thu, 19 Oct 2023 22:40:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697780442; x=1698385242;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qjfQX/pwpr+oppLKOPOhk/9biL82OZa0ePqZEoQXKSc=;
        b=JLpjpLJLKbqv+S78f4qfxkljWAwfjHvKxz00f/rg1yKHXBMyvG/chYPu5gZKSXxQ8e
         KWtqiuADzVYLhH0g0TeyCpY7t6n9Xd/iy0z49k26OnT03LcYiWjWsAHMAhRhrh+zQZNp
         kftMfhjnKlnNUhcnmKvL3EsEw+4Ap14bnp9APCMZkYVM/lyHuZD6XFAd8qrzWOmQGTX2
         ppJbOYTcgVUnxa4/oUKyljKYK29lnadjc6SuX3qRG8Bj7WHxSKp4Fbtee8O7bIUAHDDH
         lLdo8g5b6OKk10JPhO2Ce5SmYUln/TZVwVlNtEYXUTM0AeonOichXCbpXE3rT6sCsDnj
         CpTw==
X-Gm-Message-State: AOJu0YwnPRxCYqXJvn/N3klghEhdbCzihzWI2kyLgIZXHvtU50pQ4Mta
        mnnZo81rzhm7nZKho3p4wqrk1JHh8GLJVxvrzC8=
X-Google-Smtp-Source: AGHT+IHE0A9qTEGPi+9UD7nWvOGVy1HeYSmEiDejI/VMRIG458U0FW71nwPO1YaJMg7AuMzAwkqRVxSf2qsG45zjKY0=
X-Received: by 2002:a17:90a:1c3:b0:27d:546d:f4a5 with SMTP id
 3-20020a17090a01c300b0027d546df4a5mr822414pjd.43.1697780442052; Thu, 19 Oct
 2023 22:40:42 -0700 (PDT)
MIME-Version: 1.0
References: <202310110451.rvdUZJEY-lkp@intel.com> <20231010234247.71604-1-namhyung@kernel.org>
 <CAP-5=fVpgYJMTgRjQc6zoMYjNkm7T0TSBPXLgz_VWuzwRo_ktg@mail.gmail.com>
In-Reply-To: <CAP-5=fVpgYJMTgRjQc6zoMYjNkm7T0TSBPXLgz_VWuzwRo_ktg@mail.gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Thu, 19 Oct 2023 22:40:30 -0700
Message-ID: <CAM9d7ci1NMVsF7T5RsveJ3wXAimMWW4dfkf3hM6tvVc1e1AxAA@mail.gmail.com>
Subject: Re: [PATCH] perf tools: Do not ignore the default vmlinux.h
To:     Ian Rogers <irogers@google.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org,
        kernel test robot <lkp@intel.com>,
        oe-kbuild-all@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 10, 2023 at 6:36 PM Ian Rogers <irogers@google.com> wrote:
>
> On Tue, Oct 10, 2023 at 4:42 PM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > The recent change made it possible to generate vmlinux.h from BTF and
> > to ignore the file.  But we also have a minimal vmlinux.h that will be
> > used by default.  It should not be ignored by GIT.
> >
> > Fixes: b7a2d774c9c5 ("perf build: Add ability to build with a generated vmlinux.h")
> > Reported-by: kernel test robot <lkp@intel.com>
> > Closes: https://lore.kernel.org/oe-kbuild-all/202310110451.rvdUZJEY-lkp@intel.com/
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
>
> Reviewed-by: Ian Rogers <irogers@google.com>

Applied to perf-tools-next, thanks!
