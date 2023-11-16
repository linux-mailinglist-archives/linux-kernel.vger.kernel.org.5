Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7FB47EDBB1
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 07:58:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230239AbjKPG6X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 01:58:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbjKPG6V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 01:58:21 -0500
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDB87196
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 22:58:15 -0800 (PST)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-5a7fb84f6ceso4842797b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 22:58:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700117895; x=1700722695; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MlUMs5yfeQyYc6Y/Az4rq8fO2Clnbz+XnVMEINfcjBg=;
        b=ZjqKNQyA7ZGNBR3j9PgeXKjjIp9NWNkFanm1n5QS8qQvLfiQhTEjaf4eecVWToiR/e
         56mGrilKtR8gn4upU0ozDSwGqgyji07jFUrzM4RUk1Ntk2KN1jmvYiE5V8e4B/w1z4Sg
         jTAoO8C+F44z2oBFF5ForQkRy/mSacdMkz1XMqgwGLIvhLhOjMOTsbZF35amGlIsL9uf
         w806z+ZCx/3YKKmW3QDcJyBqF77lkl3gvJ436meBQTVexGfZE6D6cw/ErU1KkqiCiFR3
         j47HQgczBT82sUfkDUBYW1rEM/qs0SjJe0VPIqoFqzgIerQ+4yms+OlufpxjGFAzgru1
         EhMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700117895; x=1700722695;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MlUMs5yfeQyYc6Y/Az4rq8fO2Clnbz+XnVMEINfcjBg=;
        b=sY2HBJAe82N0cbV8WMhpsHLItH6A3CeYcbPEs3HGgaj+MiINgpCW5WSzAPkMy+EXFA
         xnz6PfzM4ATOSDqKs18d2746ziR78RJCssnO/tDmY4Mzv/GzMxP0Ea1CNr4MqF9DwRjl
         aUUA5SF1AMFp6gHsYQJ2GfXBxf6tqtt4O5/nHrdFBBcEi6rWryFgJU+DAqO5TTjXZYZX
         TcQ1O5eUpug3yaNTZXDwh4HR2mXvqSrVAfYhaGrv1OtXTafAuhY8SKpQUbun/VLHx49o
         ykdqoMxmpaGU44+/5kXqIGM1IkhjF8MHdJ0pcu2sfwsRDQBvfbO6p5U+KOz/cvjd+Mp5
         qxgA==
X-Gm-Message-State: AOJu0Yw8/G7YV3o7g4u2CQQVdE26G6380EstqWS8qAkgKy646nnGpy+E
        CGydkEEmfoqhkUe7bHDmRDj9RrtDxbi7YVh2FN1wVQ==
X-Google-Smtp-Source: AGHT+IHve10MyqU2Jd1eMdvWSqrn1JhntSzmwKDJMgvOkWsqcxLkFxnFE4uOgoNAIt4GNReGlfE8m8apQkiSaQ9ingg=
X-Received: by 2002:a0d:ea85:0:b0:5a7:e4d9:f091 with SMTP id
 t127-20020a0dea85000000b005a7e4d9f091mr13004592ywe.25.1700117894941; Wed, 15
 Nov 2023 22:58:14 -0800 (PST)
MIME-Version: 1.0
References: <20231116032530.753192-1-quic_jprakash@quicinc.com>
 <CAA8EJprJuiFq5UXc9weNr1hy2vW_10TaQweN_ZW5XW=3LKrgtA@mail.gmail.com> <5a476b51-5916-74f8-0395-60d94f210aa0@quicinc.com>
In-Reply-To: <5a476b51-5916-74f8-0395-60d94f210aa0@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Thu, 16 Nov 2023 08:58:03 +0200
Message-ID: <CAA8EJpq+2cu4pyWRGm_DVQe7_6NJAssT=HWD6UieyXkAgncwMA@mail.gmail.com>
Subject: Re: [PATCH V2 0/3] iio: adc: Add support for QCOM SPMI PMIC5 Gen3 ADC
To:     Jishnu Prakash <quic_jprakash@quicinc.com>
Cc:     jic23@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        daniel.lezcano@linaro.org, linus.walleij@linaro.org,
        linux-arm-msm@vger.kernel.org, andriy.shevchenko@linux.intel.com,
        quic_subbaram@quicinc.com, quic_collinsd@quicinc.com,
        quic_amelende@quicinc.com, quic_kamalw@quicinc.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        marijn.suijten@somainline.org, lars@metafoo.de, luca@z3ntu.xyz,
        linux-iio@vger.kernel.org, lee@kernel.org, rafael@kernel.org,
        rui.zhang@intel.com, lukasz.luba@arm.com,
        cros-qcom-dts-watchers@chromium.org, sboyd@kernel.org,
        linux-pm@vger.kernel.org, linux-arm-msm-owner@vger.kernel.org,
        kernel@quicinc.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Nov 2023 at 08:30, Jishnu Prakash <quic_jprakash@quicinc.com> wrote:
>
> Hi Dmitry,
>
> On 11/16/2023 10:52 AM, Dmitry Baryshkov wrote:
> > On Thu, 16 Nov 2023 at 05:26, Jishnu Prakash <quic_jprakash@quicinc.com> wrote:
> >> PMIC5 Gen3 has a similar ADC architecture to that on PMIC5 Gen2,
> >> with all SW communication to ADC going through PMK8550 which
> >> communicates with other PMICs through PBS. The major difference is
> >> that the register interface used here is that of an SDAM present on
> >> PMK8550, rather than a dedicated ADC peripheral. There may be more than one
> >> SDAM used for ADC5 Gen3. Each ADC SDAM has eight channels, each of which may
> >> be used for either immediate reads (same functionality as previous PMIC5 and
> >> PMIC5 Gen2 ADC peripherals) or recurring measurements (same as PMIC5 and PMIC5
> >> Gen2 ADC_TM functionality). In this case, we have VADC and ADC_TM functionality
> >> combined into the same driver.
> >>
> >> Patches 1 adds bindings for ADC5 Gen3 peripheral.
> >>
> >> Patches 2 adds driver support for ADC5 Gen3.
> > For some reason I don't see this patch in my inbox. Maybe it will
> > arrive later. Immediate response: please add
> > devm_thermal_add_hwmon_sysfs().
>
>
> Yes, I'll check and add this in the next patch series, I'll wait for
> some more comments on the existing patches for now.
>
> I ran into some error after sending the first two mails (cover letter
> and patch 1), so I sent patches 2 and 3 separately after it, I think you
> may have received them separately.
>
>
> >
> >> Patch 3 is a cleanup, to move the QCOM ADC dt-bindings files from
> >> dt-bindings/iio to dt-bindings/iio/adc folder, as they are
> >> specifically for ADC devices. It also fixes all compilation errors
> >> with this change in driver and devicetree files and similar errors
> >> in documentation for dtbinding check.
> > NAK. The kernel is expected to build and work after each commit.
> > Otherwise git-bisecting the kernel becomes impossible.
> > So, please rework your series in a way that there are no compilation
> > errors after any of the patches. The easiest way would be to rearrange
> > your patches in 3-1-2 order.
>
>
> I think you may have misunderstood the meaning here, I had verified
> compilation works each time after applying each of the three patches in
> this series. It's not that this last patch fixes compilation errors
> caused by the first two, this is a completely separate patch which
> affects existing QCOM ADC code (driver and devicetree) including ADC5 Gen3.
>
>
> This patch does two things mainly:
>
> Move the ADC binding files from dt-bindings/iio folder to
> dt-bindings/iio/adc folder (this would naturally cause some errors in
> driver and devicetree code due to path update)
>
> Fix all compilation and dtbinding errors generated by the move
>
>
> I added this change at the end of the series as I was not completely
> sure if it could get picked, just wanted to make it easier to drop if
> that is the final decision.

Ah, so patch 1 adds new files to <dt-bindings/iio/adc>, while
retaining old files in the old directory. I'd say, this is
counterintuitive.
Please reorder patches into 3-1-2 order. dt-binding changes anyway
should come first.

>
>
> Thanks,
>
> Jishnu
>
>
> >
> >
> >> Changes since v1:
> >> - Dropped patches 1-5 for changing 'ADC7' peripheral name to 'ADC5 Gen2'.
> >> - Addressed reviewer comments for binding and driver patches for ADC5 Gen3.
> >> - Combined patches 8-11 into a single patch as requested by reviewers to make
> >>    the change clearer and made all fixes required in same patch.
> >>
> >>   .../iio/{ => adc}/qcom,spmi-adc7-pm8350b.h    |    2 +-
> >>   .../iio/{ => adc}/qcom,spmi-adc7-pmk8350.h    |    2 +-
> >>   .../iio/{ => adc}/qcom,spmi-adc7-pmr735a.h    |    2 +-
> >>   .../iio/{ => adc}/qcom,spmi-adc7-pmr735b.h    |    0
> >>   .../iio/{ => adc}/qcom,spmi-vadc.h            |   81 ++
> >>   46 files changed, 1725 insertions(+), 61 deletions(-)
> >>   create mode 100644 drivers/iio/adc/qcom-spmi-adc5-gen3.c
> >>   create mode 100644 include/dt-bindings/iio/adc/qcom,spmi-adc5-gen3-pm8550.h
> >>   create mode 100644 include/dt-bindings/iio/adc/qcom,spmi-adc5-gen3-pm8550b.h
> >>   create mode 100644 include/dt-bindings/iio/adc/qcom,spmi-adc5-gen3-pm8550vx.h
> >>   create mode 100644 include/dt-bindings/iio/adc/qcom,spmi-adc5-gen3-pmk8550.h
> >>   rename include/dt-bindings/iio/{ => adc}/qcom,spmi-adc7-pm8350.h (98%)
> >>   rename include/dt-bindings/iio/{ => adc}/qcom,spmi-adc7-pm8350b.h (99%)
> >>   rename include/dt-bindings/iio/{ => adc}/qcom,spmi-adc7-pmk8350.h (97%)
> >>   rename include/dt-bindings/iio/{ => adc}/qcom,spmi-adc7-pmr735a.h (95%)
> >>   rename include/dt-bindings/iio/{ => adc}/qcom,spmi-adc7-pmr735b.h (100%)
> >>   rename include/dt-bindings/iio/{ => adc}/qcom,spmi-vadc.h (77%)
> >>
> >> --
> >> 2.25.1
> >>
> >
> > --
> > With best wishes
> > Dmitry



-- 
With best wishes
Dmitry
