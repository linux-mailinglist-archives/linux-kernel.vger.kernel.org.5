Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 091D77B603F
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 07:10:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239133AbjJCFKJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 01:10:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239122AbjJCFKF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 01:10:05 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99EA8E3
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 22:10:00 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-50348c54439so2109e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Oct 2023 22:10:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696309799; x=1696914599; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nuCQrq07t28e/w8SE3k84A5e3jrsGC5/Njzxci1gOnM=;
        b=vImCd6G1Y+pKOMGE2CajqhHxMzgQHmJugXVu3fvu0SAGfc+M0NFkn7DcVlJpSjYuFU
         vM2EZkN7CNWLF/LIH1az4Gsz5u8F28APE6mfkCwKPpzRff3NWeWlwsxR2ZDh5lejsDCj
         Pl0bPQyJV7X46dAeb5TOfPiLy3tKrT/IvtY95XZaX9+j/eJvRK/5tBemBHms5a6h2TT8
         TZkQkGoRooRxg6L2CU7Fycy4iBUCW8GQ/6Kdn7/jmm8hmzCohTz8PTUkZzgeLec2Yzbc
         Pe6VaRp3rZyPluUirJXpj6EaU3+F8U9WTK6pPzzT72lcrQpzMpaIpnADeD4G72675Syx
         DT6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696309799; x=1696914599;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nuCQrq07t28e/w8SE3k84A5e3jrsGC5/Njzxci1gOnM=;
        b=Qg4Vj4jPpBqOshl3J3rtO0C1fKgStPBd9b++DaauM75ZR72tBPGG64k3Ma4lV0RqLM
         elHsU1bRwG1OXYwMUQXoilyFMkjuxPnjvqKe6Nic481UKPdi+iuDTAPiXh614gyf5aP+
         nu5NDilTck9yE+NbLPETy2GnGe8x9L+52hfoF8BFr5zGIA+wKjX00Pye6y8kIJgFdDvf
         E3Ah0GBMcL9Ye68hodku7fthR6ZC6GfrSdaSBSgaXVlDmaotX8lPoRNmQ7bTQ3HIEjFP
         NeZx9/JqKYL0mSWPgW7yNiJIZcatGdpTthvZlCvLry4cVgloHcssTihYdcUVkh5XwBlD
         2rAQ==
X-Gm-Message-State: AOJu0Yyjsyzu6Ls0TJbsTfvK20WbNPaFXbAh/+Ine5YiwAVhX3PIjXwP
        3tLDe8cGFWAUrJ9Ys9Z77o32ElrFEq7P5OLeKXDt/A==
X-Google-Smtp-Source: AGHT+IFyKRAs1nSnT7gvq2u//Gg7pZ51XcU9iClk/bEw0hlTaiaSYD7AI5ZrfWX42ndTU40I/DwZlI/gmpWW64Pxa7A=
X-Received: by 2002:ac2:4ade:0:b0:505:7c88:9e45 with SMTP id
 m30-20020ac24ade000000b005057c889e45mr57996lfp.0.1696309798688; Mon, 02 Oct
 2023 22:09:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230930060206.2353141-1-irogers@google.com> <CAM9d7chAvXoU90uCNAqr6DxH1-pUYqd82_BAdoZjjs1Uscm8Vw@mail.gmail.com>
In-Reply-To: <CAM9d7chAvXoU90uCNAqr6DxH1-pUYqd82_BAdoZjjs1Uscm8Vw@mail.gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 2 Oct 2023 22:09:47 -0700
Message-ID: <CAP-5=fWDzjtkf7cSZVgSYUzFohH0tp81A7muke_+bH7rgnGJxw@mail.gmail.com>
Subject: Re: [PATCH v1] perf test: Avoid system wide when not privileged
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 2, 2023 at 9:47=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> w=
rote:
>
> Hi Ian,
>
> On Fri, Sep 29, 2023 at 11:02=E2=80=AFPM Ian Rogers <irogers@google.com> =
wrote:
> >
> > Switch the test program to sleep that makes more sense for system wide
> > events. Only enable system wide when root or not paranoid. This avoids
> > failures under some testing conditions like ARM cloud.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
>
> While I'm ok with the change, I wonder why it doesn't have the same
> code structure as in the stat_all_metrics.sh which checks the actual resu=
lt.
>
> Acked-by: Namhyung Kim <namhyung@kernel.org>

The metric group isn't printed when we print the metrics within it.
This could be changed.

Thanks,
Ian

> Thanks,
> Namhyung
>
> > ---
> >  tools/perf/tests/shell/stat_all_metricgroups.sh | 16 ++++++++++++++--
> >  1 file changed, 14 insertions(+), 2 deletions(-)
> >
> > diff --git a/tools/perf/tests/shell/stat_all_metricgroups.sh b/tools/pe=
rf/tests/shell/stat_all_metricgroups.sh
> > index cb35e488809a..f3e305649e2c 100755
> > --- a/tools/perf/tests/shell/stat_all_metricgroups.sh
> > +++ b/tools/perf/tests/shell/stat_all_metricgroups.sh
> > @@ -4,9 +4,21 @@
> >
> >  set -e
> >
> > -for m in $(perf list --raw-dump metricgroups); do
> > +function ParanoidAndNotRoot()
> > +{
> > +  [ "$(id -u)" !=3D 0 ] && [ "$(cat /proc/sys/kernel/perf_event_parano=
id)" -gt $1 ]
> > +}
> > +
> > +system_wide_flag=3D"-a"
> > +if ParanoidAndNotRoot 0
> > +then
> > +  system_wide_flag=3D""
> > +fi
> > +
> > +for m in $(perf list --raw-dump metricgroups)
> > +do
> >    echo "Testing $m"
> > -  perf stat -M "$m" -a true
> > +  perf stat -M "$m" $system_wide_flag sleep 0.01
> >  done
> >
> >  exit 0
> > --
> > 2.42.0.582.g8ccd20d70d-goog
> >
