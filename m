Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 223B47C4AF8
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 08:50:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345613AbjJKGul (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 02:50:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345289AbjJKGuj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 02:50:39 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B49D90
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 23:50:38 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-537f07dfe8eso5879a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 23:50:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697007037; x=1697611837; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fSdUFdNj96ap5yOzCUQatTJqtRpLC8WshQaaBaUNCbs=;
        b=oT+THZDf+QDadK0nvojwt9eOmAKznH8i7VGKGiu9W+fhYiI1zeWXZkMlWhrVTfnCaR
         3FNm2wLQj3j2BK/18R5KXq8zaX40b/lC/cZNy+Msa7I0zaubRQfuUZvWHxxgvJhT0Sz+
         ZKY5eoNJDKzRClYYxCq3oGW0KklCha1lsp2w9Vomzxhmrg1FL7tj9f/swLTDB7YNRGCw
         ViOBPdfBlHRtITaTgoVx+mnQu8M3EyDYbQp8RdXDjRuiK5lmXefO/xz6hjpn93qSfftU
         Xs4K89QQE9yEIwIpDdqUMsBKEtrAWl9U9exCIE9yIPGd9eUtGh8qYA0rLj+QDljPK1O4
         6M1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697007037; x=1697611837;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fSdUFdNj96ap5yOzCUQatTJqtRpLC8WshQaaBaUNCbs=;
        b=XD6fs57K1w0YDhtDOrea2git4D66k+NDpHUGeoR0Rb4aotEV4SfICY5Trb6NPxuBPV
         t9mV6d/hn4/g5sYUyytjcHoeKWnTWMYQS2F1VGjoG0zvxMIR9pdeofO2QTvkB1lYfcI1
         mKdWNzCgPr74IEHuZmBc4C6KILCVGW8vv3n98Wqiagb+iCyWE7/aevks4WAfPuYqNvil
         wrWh6ZBO7SEn2/0rPQXZ0B8P7usDcdQ2lvZlDRjZelA8CyhkEwKddE8diS9JXlK2dA77
         kOxWBu/bIYa/7udcWTFXIH7NYq5++rrsf38LZi2unic5qnx99JLN2CgBP0MC2KsgiXFz
         fqRA==
X-Gm-Message-State: AOJu0YzN9EAXVKK65bUvmuaBtylcXbtLculVjUNm9Y3MhqGvLIRo9rXI
        BZtdjpHSKpLHpGWhgbMW7EaLpYi1UlKu6oSkfRQVrQ==
X-Google-Smtp-Source: AGHT+IHtpBCgMDNuwyCLbV/TmJmT1aF1BKCDMSYjGgolBuC8aR9OOrLb8aK6Oo+7rWTSvZYKPL2nKc4+xp9VwQSoI9I=
X-Received: by 2002:a50:9356:0:b0:538:1d3b:172f with SMTP id
 n22-20020a509356000000b005381d3b172fmr57065eda.3.1697007036622; Tue, 10 Oct
 2023 23:50:36 -0700 (PDT)
MIME-Version: 1.0
References: <20231002221909.2958708-1-irogers@google.com> <CAP-5=fX-VOeCkOJY5xeW67x0+A0tGAHM4VYBBz46L-g2eRCR+w@mail.gmail.com>
 <93afcf44-5f8b-49c1-abc5-5304cba5f991@intel.com> <CAP-5=fXzcR6QKKhFG5PS1pFYi5JsO4AOUoH_-Bv0O+11YzEkkw@mail.gmail.com>
 <CAM9d7cjQZvZm+Vyrx9PTUYMFN5RjE+i-Kq1kbffyVp2hGKF6sg@mail.gmail.com>
 <CAP-5=fUo-vuLofC4jgHC9z=BTe80OEiY_PoQWqQtyVdvHcf+KQ@mail.gmail.com> <CAM9d7cjdb5WE-xdSdKD=p_EtsS7OSVEWL+GL3RVwczu-+1JvFQ@mail.gmail.com>
In-Reply-To: <CAM9d7cjdb5WE-xdSdKD=p_EtsS7OSVEWL+GL3RVwczu-+1JvFQ@mail.gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 10 Oct 2023 23:50:25 -0700
Message-ID: <CAP-5=fVe9v=KOxJE5TfmivBQCD=7SRFpnqkob7e05U76d_bSPQ@mail.gmail.com>
Subject: Re: [PATCH v1] perf intel-pt: pkt-decoder: Fix alignment issues
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Jiri Olsa <jolsa@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
        Liam Howlett <liam.howlett@oracle.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 10, 2023 at 10:56=E2=80=AFPM Namhyung Kim <namhyung@kernel.org>=
 wrote:
>
> On Mon, Oct 9, 2023 at 8:31=E2=80=AFAM Ian Rogers <irogers@google.com> wr=
ote:
> >
> > On Sun, Oct 8, 2023 at 10:29=E2=80=AFPM Namhyung Kim <namhyung@kernel.o=
rg> wrote:
> > >
> > > On Thu, Oct 5, 2023 at 2:24=E2=80=AFPM Ian Rogers <irogers@google.com=
> wrote:
> > > >
> > > > On Thu, Oct 5, 2023 at 12:06=E2=80=AFPM Adrian Hunter <adrian.hunte=
r@intel.com> wrote:
> > > > >
> > > > > On 5/10/23 18:48, Ian Rogers wrote:
> > > > > > On Mon, Oct 2, 2023 at 3:19=E2=80=AFPM Ian Rogers <irogers@goog=
le.com> wrote:
> > > > > >>
> > > > > >> The byte aligned buffer is cast to large types and dereference=
d
> > > > > >> causing misaligned pointer warnings from undefined behavior sa=
nitizer.
> > > > > >> Fix the alignment issues with memcpy which may require the
> > > > > >> introduction of temporaries.
> > > > > >>
> > > > > >> Signed-off-by: Ian Rogers <irogers@google.com>
> > > > > >> ---
> > > > > >
> > > > > > This is a relatively small change that fixes building with
> > > > > > -fsanitize=3Dalignment -fsanitize-undefined-trap-on-error. Adri=
an, as
> > > > > > this is Intel-PT could you take a look?
> > > > >
> > > > > Thanks! This has been down my list of things to do for ages,
> > > > > but using get_unaligned_le16() etc seems nicer.  I sent a patch
> > > > > set for that.
> > > >
> > > > Thanks Adrian! Your patch set looks good and I think after Arnaldo'=
s
> > > > comment is addressed we should go with it.
> > >
> > > I think it can be done as a later step as long as the interface is th=
e
> > > same.  Can I add your Ack's to the Adrian's patchset?
> >
> > I think addressing Arnaldo's comment:
> > https://lore.kernel.org/lkml/ZR8QnasisGEsaaDR@kernel.org/
> > will need some changes to the patch series, and so I was waiting to
> > see the outcome of that.
>
> It seems it's done without further changes.  Can I get your Ack's now?

With the unaligned.h patch on its own, I think patch 1 of 5 needs
dropping. For the rest I'm happy to acked-by.

Thanks,
Ian

> Thanks,
> Namhyung
