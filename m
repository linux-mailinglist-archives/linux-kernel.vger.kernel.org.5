Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 059BB782770
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 12:56:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229862AbjHUK4e convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 21 Aug 2023 06:56:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbjHUK4d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 06:56:33 -0400
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B2C6D9;
        Mon, 21 Aug 2023 03:56:32 -0700 (PDT)
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-570b3ebb3faso98112eaf.0;
        Mon, 21 Aug 2023 03:56:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692615392; x=1693220192;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CN5lMKccOwwzdoBewRQ8cXjpNAWqbcdLedtKOodtvi0=;
        b=KTX/6fzLhCtV4qrnyfRd5QHca55BpzcAydfZwZokrrKDj06GEGGJhQX7j5cxJKy+Q+
         p0uMJi+scyuYqzSY00D4SG9Kqs34oeX5zAguQk98rj+TVbcS6yhzVt7TsTooJPyH+PIe
         YccD0PDaHgU7tC6Zn/xokg8JX/WN3jjEqRxO+QMOED0q3hYS/4vDh1wLHB9/6ly8NhCI
         LoFLbHZSIyNiPyEQSuXDeP/MUE+d4FAmwAQ4fiKhfGiVx+5VKzvC8GosdOcOzVTsNqCv
         0g6Ybq3l0KxtpM+YR/gLSoPKsvoYCP84qaZjt+uwYygFqn1AzUus79aDB/709pR1TZJC
         65fA==
X-Gm-Message-State: AOJu0YzktfTgi+/jCEXBA3YjJKPH1kGQk+jUMmsEUTjcC2WUHbKzt9jQ
        5SddTP7POFX3ExStrVzLsurVqPqmQUGUqTpFkAq0iM21
X-Google-Smtp-Source: AGHT+IFgo0/izNdE/i8dxOf47JBFgnuUZHiXA1fNXsADt9QyH5FsOxEa5TyRPDUJlGIsXHVtRn4MVYDxxj8rA9e6zkA=
X-Received: by 2002:a4a:e741:0:b0:56e:94ed:c098 with SMTP id
 n1-20020a4ae741000000b0056e94edc098mr5793638oov.0.1692615391688; Mon, 21 Aug
 2023 03:56:31 -0700 (PDT)
MIME-Version: 1.0
References: <acaa61be-aa68-22bc-4838-e345de13d2b0@kernel.org>
In-Reply-To: <acaa61be-aa68-22bc-4838-e345de13d2b0@kernel.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 21 Aug 2023 12:56:16 +0200
Message-ID: <CAJZ5v0iTEUsUWZurJKEyB9kj6qOWmHQsd43B5VgFhqyHhUF0cg@mail.gmail.com>
Subject: Re: [GIT PULL] devfreq next for 6.6
To:     Chanwoo Choi <chanwoo@kernel.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "open list:DEVICE FREQUENCY (DEVFREQ)" <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 20, 2023 at 11:53 PM Chanwoo Choi <chanwoo@kernel.org> wrote:
>
> Dear Rafael,
>
> This is devfreq-next pull request for v6.6. I add detailed description of
> this pull request on the following tag. Please pull devfreq with
> following updates.
>
> Best Regards,
> Chanwoo Choi
>
> The following changes since commit fdf0eaf11452d72945af31804e2a1048ee1b574c:
>
>   Linux 6.5-rc2 (2023-07-16 15:10:37 -0700)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/linux.git tags/devfreq-next-for-6.6
>
> for you to fetch changes up to 5693d077595de721f9ddbf9d37f40e5409707dfe:
>
>   PM / devfreq: Fix leak in devfreq_dev_release() (2023-08-10 22:48:16 +0900)
>
> ----------------------------------------------------------------
> Update devfreq next for v6.6
>
> Detailed description for this pull request:
> - Include correct DT header including explicitly for imx-bus/imx8m-ddrc/
>   mtk-cci/tegra30 tegra drivers.
>
> - Reword the kernel-doc comment for devfreq_monitor_start() API using to specify
> the default timer as deferrable timer because devfreq core supports both delayed
> timer and deferrable timer according to devfreq device profile.
>
> - Add missing srcu_cleanup_notifier_head() when releasing devfreq device.
> : srcu_init_notifier_head() allocates resources that need to be released
> with a srcu_cleanup_notifier_head() call.
> ----------------------------------------------------------------
> Boris Brezillon (1):
>       PM / devfreq: Fix leak in devfreq_dev_release()
>
> Manivannan Sadhasivam (1):
>       PM / devfreq: Reword the kernel-doc comment for devfreq_monitor_start() API
>
> Rob Herring (1):
>       PM / devfreq: Explicitly include correct DT includes
>
>  drivers/devfreq/devfreq.c         | 10 ++++++----
>  drivers/devfreq/imx-bus.c         |  2 +-
>  drivers/devfreq/imx8m-ddrc.c      |  2 +-
>  drivers/devfreq/mtk-cci-devfreq.c |  1 -
>  drivers/devfreq/tegra30-devfreq.c |  2 +-
>  5 files changed, 9 insertions(+), 8 deletions(-)

Pulled and added to the linux-next branch in linux-pm.git.

Thanks!
