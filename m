Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11F16785D4D
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 18:30:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237595AbjHWQak (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 12:30:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237603AbjHWQah (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 12:30:37 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBA2710DE
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 09:30:31 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-58d41109351so87247b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 09:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692808231; x=1693413031;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4WIeojozpIxmSsF2RUkSADK15h44qyPJk1IVXM4MnWY=;
        b=Pu5Erh9xwx/lQn4Yx0iCKh67FrGE57frhfQDch/1OFADRsQOGh5Tb2CyOl2JR7cl6I
         DHnbwWAtv+5rE3tyPfD64HFtCJt0uAsdDzpsNqDf97AQNSrpL3Ea06uvIoiSV+71t8ZN
         gRwio5PvFC5Is9BiwKqEWbuXnqSS6wmi1C1ZHs9quxWKdLlhGq75dVk9RqRBUeocUMxT
         iOe27RGnMxWOSJJImCnYeXGRVPHcWA00X1BMXcQ0j9KsDFhhkJI1v5/43zvbgwVLODbS
         9LK0fhv8lMh0KKXtWt61f9G/LVF9cjAVqaWOtjAgSb/VdQDEiuvcGLdyckOPugpnS5Y6
         8nGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692808231; x=1693413031;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4WIeojozpIxmSsF2RUkSADK15h44qyPJk1IVXM4MnWY=;
        b=HuNgOj9soBOUwMl7ChwHinPPDXlFYDOCq9s1y8LKN8Z01tniOW0Ji6RzjdlGIqbrwd
         +61DiwlJllRFSB/uwef64/3pi5boLze0uLsSzAcak2h94C5/igvCoMhBjVNTfq6FCKnr
         MVO7WX/PduwLXvs3xNZj1nxEpwdNAXAJqacubldiwh2P5xa0kCbmANdb3A8INd0kdloR
         Rt/uS85ZkySyCx1zt1k4a4VeiC53TntZcRi0mKrYXopqR71G6vFcSvLGZW3w58ySeiHA
         BBkikDmgHH3xfElHaIQFNPJJPUlUia37gCirQB7UNB9Dwkj5MXYRVQGd+nKX3kZp/7bN
         r1QA==
X-Gm-Message-State: AOJu0YyXC1m4naOJMnrMy/ayIvmL0brNtCV+ApB31D3w2hTAKzNYZGtd
        21tScU4Ny9bSQq0CkpXB5005T+gSshS/qy0ofsyXUw==
X-Google-Smtp-Source: AGHT+IEFMaChi60GbWv1LIlg+iMC6f7cYJT9GtZocEwDYoF2oFcl6/SrVGhJNWWR0qft+CZ3NygJYygRyr91mW2mtWA=
X-Received: by 2002:a81:4f49:0:b0:56c:f0c7:7d72 with SMTP id
 d70-20020a814f49000000b0056cf0c77d72mr10962983ywb.4.1692808231002; Wed, 23
 Aug 2023 09:30:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230823114528.3677667-1-abel.vesa@linaro.org>
In-Reply-To: <20230823114528.3677667-1-abel.vesa@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 23 Aug 2023 18:29:55 +0200
Message-ID: <CAPDyKFqjN9aJsvbcmp=iUSvMAqnkpFZ50aueDrs-xtsGt1BwwA@mail.gmail.com>
Subject: Re: [PATCH v3 0/5] PM: domains: Add control for switching back and
 forth to HW control
To:     Abel Vesa <abel.vesa@linaro.org>, Stephen Boyd <sboyd@kernel.org>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Kevin Hilman <khilman@kernel.org>, Pavel Machek <pavel@ucw.cz>,
        Len Brown <len.brown@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mike Turquette <mturquette@baylibre.com>,
        Taniya Das <tdas@qti.qualcomm.com>, linux-pm@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Aug 2023 at 13:45, Abel Vesa <abel.vesa@linaro.org> wrote:
>
> The v2 can be found here:
> https://lore.kernel.org/lkml/20230816145741.1472721-1-abel.vesa@linaro.org/
>
> Changes since v2:
>  * 5th patch has been squashed in the 4th one
>
> Further details about other changes are found in each patch.
>
> Abel Vesa (1):
>   PM: domains: Add the domain HW-managed mode to the summary
>
> Jagadeesh Kona (3):
>   clk: qcom: gdsc: Add set and get hwmode callbacks to switch GDSC mode
>   clk: qcom: Use HW_CTRL_TRIGGER flag to switch video GDSC to HW mode
>   venus: pm_helpers: Use dev_pm_genpd_set_hwmode to switch GDSC mode
>
> Ulf Hansson (1):
>   PM: domains: Allow devices attached to genpd to be managed by HW
>
>  drivers/base/power/domain.c                   | 84 ++++++++++++++++++-
>  drivers/clk/qcom/gdsc.c                       | 32 +++++++
>  drivers/clk/qcom/gdsc.h                       |  1 +
>  drivers/clk/qcom/videocc-sc7180.c             |  2 +-
>  drivers/clk/qcom/videocc-sc7280.c             |  2 +-
>  drivers/clk/qcom/videocc-sdm845.c             |  4 +-
>  drivers/clk/qcom/videocc-sm8250.c             |  4 +-
>  drivers/clk/qcom/videocc-sm8550.c             |  4 +-
>  drivers/media/platform/qcom/venus/core.c      |  4 +
>  drivers/media/platform/qcom/venus/core.h      |  1 +
>  .../media/platform/qcom/venus/pm_helpers.c    | 47 +++++------
>  include/linux/pm_domain.h                     | 17 ++++
>  12 files changed, 165 insertions(+), 37 deletions(-)
>

I guess this series is best funneled via the clk tree? Stephen, I am
fine with patch 1 and patch2, but I guess you may need an ack for the
others too.

Kind regards
Uffe
