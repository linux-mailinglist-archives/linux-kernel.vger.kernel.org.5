Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5761778969
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 11:04:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233288AbjHKJEh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 05:04:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjHKJEf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 05:04:35 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41A20F5
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 02:04:35 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id 98e67ed59e1d1-26814e27a9eso1053997a91.0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 02:04:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691744675; x=1692349475;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WcREfgCdK8BYuBc5YfIqNosYW9TG/OPFM51bg8f31k0=;
        b=qZgfmbOMGxqWQoisjtrO4lN9gd1otQtd0Rr1WmXtuGF6qbwoRtS7st3rCz60lG1Bje
         EgWaexBBO6VZqqtHvJEWtr3aZ2nJkQUDB/BfqZRGNY5r1cZ5kxebZsIlZAjFe6YudbjV
         /TZu26y5EYb5aSUBoq2Q39WS56eR2IzATNmYqrGgPabV03LfIWGXvurvItwzFphwg9NC
         ln5GIx6csiGeTQITAk8A3opTnYYlmAV6pIG7Y+uipprMYp8H0Tf0GmmtfFOI5UtDCXSf
         K4sFY1WbUksVuoaBteEXYD0AeLW0lhQ8rjeClRUUy7mmK4zP1on7FFPomn3h/i1X6Hkb
         lYkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691744675; x=1692349475;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WcREfgCdK8BYuBc5YfIqNosYW9TG/OPFM51bg8f31k0=;
        b=DfUCeN68U8YMapkaIx9s7oHt82bAW1IzS+AwKUaMTe5C0JNfvxGhVSDRTdSBolHdV7
         r4PPpxaKbZCDquYBRmWPsVdwxVtzGq0ZfCJil3aQide1yffzYarhsZeQ+xX37SjSLjxr
         K58aEBuCgxMa+5V9N36nKUvCSjn2PCY8+gjXhQI9y4rWGYiBvMk2lNbjFGOoY5lU3vOj
         JR43IrJ75vwyvqSD7K4oo2ldK8sfImFeZtY9CHy2Zv7APFcI1HHeGMst4dRezzoF+jAI
         S/wuq2w7jUt6/EVjG1MhQaj9aN1FH7P2DpC5b8AsD4ftGdn+k80L530lGymLwOOBT9Pc
         0d6g==
X-Gm-Message-State: AOJu0YwYe4gMp63KPjBdlZaW8Bg70+YqZULINT4+PZ64vDg/+OrcW9Ee
        HbJTsh9w6BG3rdt89WLBEb5DZjgE/umKV1CS14SmIQ==
X-Google-Smtp-Source: AGHT+IEb/UE7KGbRYlBCmdEnrY74tj1J1P3C+LwP7vGCBwT6vFfyKIdcqYMk/ujfdsGYGSLj4YyvrgLNTvRbBHGAqx4=
X-Received: by 2002:a17:90b:3c4:b0:268:10a3:cea8 with SMTP id
 go4-20020a17090b03c400b0026810a3cea8mr670340pjb.9.1691744674596; Fri, 11 Aug
 2023 02:04:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230811034600.944386-1-anshuman.khandual@arm.com>
 <20230811034600.944386-3-anshuman.khandual@arm.com> <CAJ9a7VgNmY0_vPfRfz=+hSjbFqnsOAzBgHtZva9fkG04mRaeaQ@mail.gmail.com>
 <1c0e47a0-1e84-1e02-33dd-76d8eaaa41b0@arm.com>
In-Reply-To: <1c0e47a0-1e84-1e02-33dd-76d8eaaa41b0@arm.com>
From:   Mike Leach <mike.leach@linaro.org>
Date:   Fri, 11 Aug 2023 10:04:23 +0100
Message-ID: <CAJ9a7Vj5zsOcEQ7QE_T8qPvrciJYcZQqL0U8dp6QkSt-UGynWw@mail.gmail.com>
Subject: Re: [PATCH V3 2/3] coresight: etm: Make cycle count threshold user configurable
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, suzuki.poulose@arm.com,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        Leo Yan <leo.yan@linaro.org>, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org, coresight@lists.linaro.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Aug 2023 at 09:57, Anshuman Khandual
<anshuman.khandual@arm.com> wrote:
>
>
>
> On 8/11/23 14:22, Mike Leach wrote:
> > On Fri, 11 Aug 2023 at 04:46, Anshuman Khandual
> > <anshuman.khandual@arm.com> wrote:
> >>
> >> Cycle counting is enabled, when requested and supported but with a default
> >> threshold value ETM_CYC_THRESHOLD_DEFAULT i.e 0x100 getting into TRCCCCTLR,
> >> representing the minimum interval between cycle count trace packets.
> >>
> >> This makes cycle threshold user configurable, from the user space via perf
> >> event attributes. Although it falls back using ETM_CYC_THRESHOLD_DEFAULT,
> >> in case no explicit request. As expected it creates a sysfs file as well.
> >>
> >> /sys/bus/event_source/devices/cs_etm/format/cc_threshold
> >>
> >> New 'cc_threshold' uses 'event->attr.config3' as no more space is available
> >> in 'event->attr.config1' or 'event->attr.config2'.
> >>
> >> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
> >> Cc: Mike Leach <mike.leach@linaro.org>
> >> Cc: James Clark <james.clark@arm.com>
> >> Cc: Leo Yan <leo.yan@linaro.org>
> >> Cc: coresight@lists.linaro.org
> >> Cc: linux-arm-kernel@lists.infradead.org
> >> Cc: linux-doc@vger.kernel.org
> >> Cc: linux-kernel@vger.kernel.org
> >> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> >> ---
> >>  drivers/hwtracing/coresight/coresight-etm-perf.c   |  2 ++
> >>  drivers/hwtracing/coresight/coresight-etm4x-core.c | 12 ++++++++++--
> >>  2 files changed, 12 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
> >> index 5ca6278baff4..09f75dffae60 100644
> >> --- a/drivers/hwtracing/coresight/coresight-etm-perf.c
> >> +++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
> >> @@ -68,6 +68,7 @@ PMU_FORMAT_ATTR(preset,               "config:0-3");
> >>  PMU_FORMAT_ATTR(sinkid,                "config2:0-31");
> >>  /* config ID - set if a system configuration is selected */
> >>  PMU_FORMAT_ATTR(configid,      "config2:32-63");
> >> +PMU_FORMAT_ATTR(cc_threshold,  "config3:0-11");
> >>
> >>
> >>  /*
> >> @@ -101,6 +102,7 @@ static struct attribute *etm_config_formats_attr[] = {
> >>         &format_attr_preset.attr,
> >>         &format_attr_configid.attr,
> >>         &format_attr_branch_broadcast.attr,
> >> +       &format_attr_cc_threshold.attr,
> >>         NULL,
> >>  };
> >>
> >> diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> >> index 1f3d29a639ff..ad28ee044cba 100644
> >> --- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
> >> +++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> >> @@ -644,7 +644,7 @@ static int etm4_parse_event_config(struct coresight_device *csdev,
> >>         struct etmv4_config *config = &drvdata->config;
> >>         struct perf_event_attr *attr = &event->attr;
> >>         unsigned long cfg_hash;
> >> -       int preset;
> >> +       int preset, cc_threshold;
> >>
> >>         /* Clear configuration from previous run */
> >>         memset(config, 0, sizeof(struct etmv4_config));
> >> @@ -667,7 +667,15 @@ static int etm4_parse_event_config(struct coresight_device *csdev,
> >>         if (attr->config & BIT(ETM_OPT_CYCACC)) {
> >>                 config->cfg |= TRCCONFIGR_CCI;
> >>                 /* TRM: Must program this for cycacc to work */
> >> -               config->ccctlr = ETM_CYC_THRESHOLD_DEFAULT;
> >> +               cc_threshold = attr->config3 & ETM_CYC_THRESHOLD_MASK;
> >> +               if (cc_threshold) {
> >> +                       if (cc_threshold < drvdata->ccitmin)
> >> +                               config->ccctlr = drvdata->ccitmin;
> >> +                       else
> >> +                               config->ccctlr = cc_threshold;
> >> +               } else {
> >> +                       config->ccctlr = ETM_CYC_THRESHOLD_DEFAULT;
> >
> > Don't normally have {} round a single statement else clause - did
>
> I would believe single statement else clause could have { }, only
> when the preceding if clause consists of multiple statements just
> to be symmetrical ?
>
> > checkpatch.pl not object here?
>
> No, it does not object.
>

Fair enough - good to go then!

> >
> >
> > Otherwise
> >
> > Reviewed-by: Mike Leach <mike.leach@linaro.org>
> >
> >> +               }
> >>         }
> >>         if (attr->config & BIT(ETM_OPT_TS)) {
> >>                 /*
> >> --
> >> 2.25.1
> >>
> >
> >



-- 
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK
