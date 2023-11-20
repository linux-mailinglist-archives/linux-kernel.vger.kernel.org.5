Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 595F07F1F31
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 22:31:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232116AbjKTVbf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 16:31:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbjKTVbe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 16:31:34 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A30B099;
        Mon, 20 Nov 2023 13:31:30 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id 98e67ed59e1d1-27ff7fe7fbcso3808378a91.1;
        Mon, 20 Nov 2023 13:31:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700515890; x=1701120690; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FctPSCj7tPevGlMSxSjEDJsdguhwQ45p/dX89rjXqg0=;
        b=iEFGX72rNsTsiFJxQVlbFyDezownQPzvJdrkL37X9YUOE0AMBvRoUG/zuQppmjAjoc
         CfpHglAfZVdDTXjo6H3mn4r67GQf2N5uOGJqG4zXY1QqkiqDomU8dx1wE3NwpMAu7FyB
         fUSfGzVV3Nu+lSCxxEGu5dd7e+Um8vnx8I9+9Z62qaSNKSxGqV+e8zylbdYNQMjEx3nd
         u59JEfrEXSVgUOvsC5lnpRdU6ITjgwZJk0/S2pwS0bs2bqiuL/qsZvlTPUnLAULnTsa5
         RPi/Uitcc1u1Z5xdJyMVFV6S9BGxzaPBsUAigb4Xg4apK9UgXuLqYCYvoSc8dj5QAHlO
         zlyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700515890; x=1701120690;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FctPSCj7tPevGlMSxSjEDJsdguhwQ45p/dX89rjXqg0=;
        b=X2Q7lA0f07xCFqxbCNCigaALAnGUB218xz04Rw3o1+y2glYf6UK97rdMrWShD1BEQc
         m31DSVO3ECcmSdH32FfhGwC5TSEETJ9Jfc+KjggettlBd4tsI7vOwAENLbYYIhKZM/iF
         FtVDs2xYp/OclB3SLN9sdH1HNHuC1EZpZq2Twj2FPNx0cqg2F8EKJOvXcxC1cK4xR48j
         DKEJeCTszjYnAGMaOGzKEqngNDFRoCzmg4nSx+05eLuqrkIZr/cFTWrRjXEnkTSkxCsk
         pqWKKEJpvsLE5POpBTMXVLA/3hAN1RBO408K8mmWSZ0xTq5a9S+wqH6yllVyqHtXsQAx
         zmfw==
X-Gm-Message-State: AOJu0Yy6biaX4VmbOdf0BSoJBbaltf9LzBOTSk7A9AEzmjxXVQcLOzKj
        8dH20N5GclmqBx+94QxWJya5eOKT6E0ylJDR2/U=
X-Google-Smtp-Source: AGHT+IFLPipHGoDrsUtzfKJWJKbruw7OLvOy/n33f2E9xeIwg0s9OZsP2ZNEj7FYbdOZ7ZsOwoP28ZXjjGjcte1L2+0=
X-Received: by 2002:a17:90b:3a82:b0:27d:12e1:7e20 with SMTP id
 om2-20020a17090b3a8200b0027d12e17e20mr8939742pjb.12.1700515889879; Mon, 20
 Nov 2023 13:31:29 -0800 (PST)
MIME-Version: 1.0
References: <20231113112507.917107-1-james.clark@arm.com> <20231113112507.917107-4-james.clark@arm.com>
In-Reply-To: <20231113112507.917107-4-james.clark@arm.com>
From:   Namhyung Kim <namhyung@gmail.com>
Date:   Mon, 20 Nov 2023 13:31:18 -0800
Message-ID: <CAM9d7ciDq-te1DQPrMrZQC9er0pSMY24nvC-atxdRu1C6uD08A@mail.gmail.com>
Subject: Re: [PATCH v5 3/3] Documentation: arm64: Document the PMU event
 counting threshold feature
To:     James Clark <james.clark@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, suzuki.poulose@arm.com,
        will@kernel.org, mark.rutland@arm.com,
        Catalin Marinas <catalin.marinas@arm.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 13, 2023 at 3:26=E2=80=AFAM James Clark <james.clark@arm.com> w=
rote:
>
> Add documentation for the new Perf event open parameters and
> the threshold_max capability file.
>
> Signed-off-by: James Clark <james.clark@arm.com>
> ---
>  Documentation/arch/arm64/perf.rst | 56 +++++++++++++++++++++++++++++++
>  1 file changed, 56 insertions(+)
>
> diff --git a/Documentation/arch/arm64/perf.rst b/Documentation/arch/arm64=
/perf.rst
> index 1f87b57c2332..36b8111a710d 100644
> --- a/Documentation/arch/arm64/perf.rst
> +++ b/Documentation/arch/arm64/perf.rst
> @@ -164,3 +164,59 @@ and should be used to mask the upper bits as needed.
>     https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tr=
ee/tools/perf/arch/arm64/tests/user-events.c
>  .. _tools/lib/perf/tests/test-evsel.c:
>     https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tr=
ee/tools/lib/perf/tests/test-evsel.c
> +
> +Event Counting Threshold
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Overview
> +--------
> +
> +FEAT_PMUv3_TH (Armv8.8) permits a PMU counter to increment only on
> +events whose count meets a specified threshold condition. For example if
> +threshold_compare is set to 2 ('Greater than or equal'), and the
> +threshold is set to 2, then the PMU counter will now only increment by
> +when an event would have previously incremented the PMU counter by 2 or
> +more on a single processor cycle.
> +
> +To increment by 1 after passing the threshold condition instead of the
> +number of events on that cycle, add the 'threshold_count' option to the
> +commandline.
> +
> +How-to
> +------
> +
> +The threshold, threshold_compare and threshold_count values can be
> +provided per event:
> +
> +.. code-block:: sh
> +
> +  perf stat -e stall_slot/threshold=3D2,threshold_compare=3D2/ \
> +            -e dtlb_walk/threshold=3D10,threshold_compare=3D3,threshold_=
count/

Can you please explain this a bit more?

I guess the first event counts stall_slot PMU if the event if it's
greater than or equal to 2.  And as threshold_count is not set,
it'd count the stall_slot as is.  E.g. it counts 3 when it sees 3.

OTOH, dtlb_walk will count 1 if it sees an event less than 10.
Is my understanding correct?

> +
> +And the following comparison values are supported:
> +
> +.. code-block::
> +
> +  0: Not-equal
> +  1: Equals
> +  2: Greater-than-or-equal
> +  3: Less-than

So the above values are for threashold_compare, right?
It'd be nice if it's more explicit.

Similarly, it'd be helpful to have a description for the
threshold and threshold_count fields.

Thanks,
Namhyung

> +
> +The maximum supported threshold value can be read from the caps of each
> +PMU, for example:
> +
> +.. code-block:: sh
> +
> +  cat /sys/bus/event_source/devices/armv8_pmuv3/caps/threshold_max
> +
> +  0x000000ff
> +
> +If a value higher than this is given, then it will be silently clamped
> +to the maximum. The highest possible maximum is 4095, as the config
> +field for threshold is limited to 12 bits, and the Perf tool will refuse
> +to parse higher values.
> +
> +If the PMU doesn't support FEAT_PMUv3_TH, then threshold_max will read
> +0, and both threshold and threshold_compare will be silently ignored.
> +threshold_max will also read as 0 on aarch32 guests, even if the host
> +is running on hardware with the feature.
> --
> 2.34.1
>
>
