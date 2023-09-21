Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FA697AA4F7
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 00:26:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232300AbjIUW0q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 18:26:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231726AbjIUW0E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 18:26:04 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AED4E17C29
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 10:07:44 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-31fe2c8db0dso1108317f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 10:07:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695316063; x=1695920863; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vhrSVaekmaaS857MYrgyAKM4+ElTs9bb8AF7UO+hWSw=;
        b=lQo79qE5/8P/SRcbaV7ryHnbh+TJTfuqE+67ye8CWhbMdDdB4/qURdNHu/DUyVVIdw
         AcuvqNvpxJblQnOUIFhLhl+QgDh8mGaaYVrR5VEKehbMLcxkrhbrMfNRTJbYLrghJDDd
         RA8946mV8o5koH8ekRlyF1UzpPnNrtAYAxD5Qdfygj8NkTALN4Hr2k0KfmR8kOg7oOT3
         9AcCvC4ytGSX7WBfGZpoo/hiqVMY6i8R6HUuyqqTmUJedbxrx2wYlXdPaPNDMJCmhRJj
         jOOqegth73ztGCLjvlwse6Oux46sDrftUd4qJtuobdspbrObzMeFU/xRn+tK6KCFVMMr
         6+KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695316063; x=1695920863;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vhrSVaekmaaS857MYrgyAKM4+ElTs9bb8AF7UO+hWSw=;
        b=maGWWCQHFsotvBhXedLW+JmbnNHpGpgRDHhcP3Gasg3OFqhGqVswSM1ACNf10MnB6S
         Dg0y/qOZjHk4BNapdMwTm/SADZW1/jXLrn9PmIJzBMFpAIUDDH9g0aCbavlZZyuLvV+S
         U3nhqlNm8p9xWwgFyj4FK+S93vw6Edhs4bnkieRpD7MQfhY0bUuM9H+mWfRBqArXx8og
         E8TiSxX7mgJsBVYmh7+sXsjmP5Fc5O+vKFaeGfObgfMu02rV6A3cqLHK3sJjVMHAL4te
         wpKMbe4kLwTZKIHJDdzmMm8KjyRHEY+mpN405xT6GIRixgZEjoVdwfAFKHqPcpy5WiqP
         kBKw==
X-Gm-Message-State: AOJu0YwigZOOOpNP2E1jW5gMrpIYEpNOwj+l0UU1Wxkfa/KldMkxLouo
        CsPQUV3ikYZxKWCoWfwB2ibGSU7kl022cYiQyruiC+ZeoxXqv6Ewi9roHg==
X-Google-Smtp-Source: AGHT+IH/oHbQjIKY1hc68OC0HLda5ssIJG+10LaW+f2EeRjP96QRrNJkfgWAiwt9yxSXP5uqPOv7A04wkNF+ihcnhUM=
X-Received: by 2002:aa7:c3c3:0:b0:532:deae:9c1f with SMTP id
 l3-20020aa7c3c3000000b00532deae9c1fmr4961974edr.18.1695306572624; Thu, 21 Sep
 2023 07:29:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230825112633.236607-1-ulf.hansson@linaro.org> <20230825112633.236607-5-ulf.hansson@linaro.org>
In-Reply-To: <20230825112633.236607-5-ulf.hansson@linaro.org>
From:   Viresh Kumar <viresh.kumar@linaro.org>
Date:   Thu, 21 Sep 2023 16:29:15 +0200
Message-ID: <CAKohpoma56EGs=gTTQGyQ5jw8f1bZvd2tJYZjYTTnkAf4A58tA@mail.gmail.com>
Subject: Re: [PATCH v3 04/13] firmware: arm_scmi: Align perf ops to use
 domain-id as in-parameter
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Nikunj Kela <nkela@quicinc.com>,
        Prasad Sodagudi <psodagud@quicinc.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
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

On Fri, 25 Aug 2023 at 13:27, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> Most scmi_perf_proto_ops are already using an "u32 domain" as an
> in-parameter to indicate what performance domain we shall operate upon.
> However, some of the ops are using a "struct device *dev", which means that
> an additional OF parsing is needed each time the perf ops gets called, to
> find the corresponding domain-id.
>
> To avoid the above, but also to make the code more consistent, let's
> replace the in-parameter "struct device *dev" with an "u32 domain". Note
> that, this requires us to make some corresponding changes to the scmi
> cpufreq driver, so let's do that too.
>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>
> Changes in v3:
>         - Re-based.
>
> ---
>  drivers/cpufreq/scmi-cpufreq.c   | 14 +++++++++-----

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
