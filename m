Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7859680F51A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 19:00:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377062AbjLLSA1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 13:00:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230181AbjLLSAX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 13:00:23 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BE56B7
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 10:00:29 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-50beed2a46eso177e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 10:00:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702404028; x=1703008828; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CLc2uwTCsXHrkyfMISisr6i9Izcj9rKOSvz6R6z0jK8=;
        b=1+GrW/PL+8KSPt7tJTWJJmQEFkBa54Y+7z0E/Ov2Z6uyi9irIKdjO61mnQFQyH7dEP
         j15p3cm9MEzj0zOzeio1JV/RcBAtnf2rxUf/ncdqTHS+w12yDoIMi7gOdAXfxt8jHatM
         n+hgOuJACS5NmFzT8CGZcSdog7KzoTbgT5EpSC1N9fzcRo+wbsXKMLulm+1oPgWzNpzh
         NJYRYh7Wx6OjrysBqZeU6me9B7IJqFktgEK909UEyOc/CrQbbpCRxO8gRWq/xmhiHA5f
         MCp9DbFaVEuWoIjsVRhWIU0s5IC91TBzy9SlaFG4/qDaDoyWBEcvReJhbeswnI0aAuOZ
         ldQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702404028; x=1703008828;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CLc2uwTCsXHrkyfMISisr6i9Izcj9rKOSvz6R6z0jK8=;
        b=K4tqC9qaLph+6ooHAhPuQlafrile6N/sB78rvRtgU1YRpxRPlLQiJ2eBH3DjRbd5A3
         Kf+9HIeH4pOQ54JSq9VTRUkrHitlBhT4wVVRo+0s3M3DHkTVzovwK6cgHXosfptFPcBx
         Va86V84zL4ZkuM7htxiUXnJsuI0H4iJcuCarpxKwOcn04nG/96nNmu+SbnmiavCdwQ1Q
         z9Qaj9u5S9ZNijGACafstTNHErVJICT8lDFVMs3JfJcxI5VS8G0znUimnQ0QQ+QrCWR1
         3E0+oCba0VGV5WxpRDlzbBBKHZc4SoWcWZyZEhPF9QbuUl1Ze/Gk2a6s9v5iz9G2gfOx
         ow2A==
X-Gm-Message-State: AOJu0YzbmB8yFX1GJnBjebacyVGFCEZn+sBX00m/cESQobDqu/tphAeW
        E25dAdeibBktu7Y0Bh4m+PmNQTsboLFa6K1YuTqLAw==
X-Google-Smtp-Source: AGHT+IEO6SMKP18mW79wlSCfRL85uc/ZxGxAtrMNO3aesJ0MKMM65U17ubTZNlIPBFHjTe8ED02eAlkrmkn47QZmOkU=
X-Received: by 2002:a19:e058:0:b0:50b:fc76:42c with SMTP id
 g24-20020a19e058000000b0050bfc76042cmr240096lfj.2.1702404027469; Tue, 12 Dec
 2023 10:00:27 -0800 (PST)
MIME-Version: 1.0
References: <20231208210855.407580-1-kan.liang@linux.intel.com>
 <ZXd7ZuxbNNsjAyqm@kernel.org> <07677ab2-c29b-499b-b473-f7535fb27a8c@linux.intel.com>
 <CAM9d7ci-VVhubefMqkSQgK-B2e2z4QU1=TLJtC49wbWW=VNc8g@mail.gmail.com>
In-Reply-To: <CAM9d7ci-VVhubefMqkSQgK-B2e2z4QU1=TLJtC49wbWW=VNc8g@mail.gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 12 Dec 2023 10:00:16 -0800
Message-ID: <CAP-5=fVd-0aSovYVsOmTo2dfKb5_PHz1KV7ePipi35_JbfJ6qQ@mail.gmail.com>
Subject: Re: [PATCH] perf top: Use evsel's cpus to replace user_requested_cpus
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     "Liang, Kan" <kan.liang@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        mark.rutland@arm.com, maz@kernel.org, marcan@marcan.st,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 12, 2023 at 9:23=E2=80=AFAM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> On Tue, Dec 12, 2023 at 7:56=E2=80=AFAM Liang, Kan <kan.liang@linux.intel=
.com> wrote:
> >
> >
> >
> > On 2023-12-11 4:13 p.m., Arnaldo Carvalho de Melo wrote:
> > > Em Fri, Dec 08, 2023 at 01:08:55PM -0800, kan.liang@linux.intel.com e=
screveu:
> > >> From: Kan Liang <kan.liang@linux.intel.com>
> > >>
> > >> perf top errors out on a hybrid machine
> > >>  $perf top
> > >>
> > >>  Error:
> > >>  The cycles:P event is not supported.
> > >>
> > >> The user_requested_cpus may contain CPUs that are invalid for a hybr=
id
> > >> PMU. It causes perf_event_open to fail.
> > >
> > > ?
> > >
> > > All perf top expects is that the "cycles", the most basic one, be
> > > collected, on all CPUs in the system.
> > >
> >
> > Yes, but for hybrid there is no single "cycles" event which can cover
> > all CPUs.
>
> Does that mean the kernel would reject the legacy "cycles" event
> on hybrid CPUs?

I believe not. When the extended type isn't set on legacy cycles we
often have the CPU and from that can determine the PMU. The issue is
with the -1 any CPU perf_event_open option. As I was told, the PMU the
event is opened on in this case is the first one registered in the
kernel, on Intel hybrid this could be cpu_core or cpu_atom.. but IIRC
it'll probably be cpu_core. On ARM =C2=AF\_(=E3=83=84)_/=C2=AF. In any case=
 you only
have an event that will be enabled on a fraction of the CPU cores the
thread you are monitoring could be scheduled on. This is why 2 or more
events are needed (depending on how many core types you have).

Thanks,
Ian

> Thanks,
> Namhyung
