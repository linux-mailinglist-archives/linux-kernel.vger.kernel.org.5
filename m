Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D33C7A97A1
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 19:26:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229862AbjIUR0V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 13:26:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbjIUR0D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 13:26:03 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74DEA4F387
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 10:25:17 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-307d20548adso1082102f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 10:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695317115; x=1695921915; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DpJ/97G25b6TPjTn6QzU+EXfaLRmUn9TD44GKiLbxUc=;
        b=XEkjCMU3aqZK8Juq/KEZbqWpqTZUK4nPDVl6zK9EYVnBBf/8LQkH52rFQQTOjUX0no
         KhX2ruLvQ9yRA4GACbmmZNCKAGHLUqiPA80bFbjI0T0MF9geukksqtVxOI+CE9+Ask2k
         r7AwnKSThwwslEpFKo+c6mLlDyEQL7iAxZjP+H4kYFk9M+DhwBEZqq6Z6aDnVthN7V0p
         a2t5lkzKhNqX81827FI1BC87LpJjJKQ6dPeMri2yopZ7rbl02ifAwV/r0hyPZP2jwFzC
         Ss+LOBlVh2IYBy8CecHLZAUyCw2K4V1LsW27f/D9MHeRJfrTPypErZd5V0cRcKKw0aQ/
         sM+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695317115; x=1695921915;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DpJ/97G25b6TPjTn6QzU+EXfaLRmUn9TD44GKiLbxUc=;
        b=lOAy/HJd8Cd34MXDksdPGCQD9No7E8ltxGivL+49C+PvVpClREWV6OXpra8yyF55Uw
         IMQwbC+yAhoZevfKSGccPz4XfB7Bc1LQKPEC1j73pMDx5kEmJg+pICCCRVfkXuRMnrkD
         Dmte84JJvZz8egCktf/zvdzMxj+JtmpDyEIO3nH6By2MUvYUymda9vVAiHgpvLa+MLzj
         FmKCAqAxKcs+J4tDMcvbjBDhFmMsnmY9uGOH03nh/o/H0f3X3mIF7yzNp5AMpdVnj6DE
         S//81Z3Pzx/DHGNa111SVWaW1HkeEaS/6zWpac5j6Klob4zzcfBk4RWDBY9BAlnqAPKm
         oNAg==
X-Gm-Message-State: AOJu0Ywslw2TigMRChyxJ3CgJSnTU09wwbVS4WpbN4uSncsdFNyZ3BJr
        6L94Mlg5qPAP6/JAjm/3fW836mwJe3vPTTM7G8Oe4bSjk60Zrf8G7TxHDA==
X-Google-Smtp-Source: AGHT+IFTxMHPC95KiOI2z0xWTy4CeTB0NUWNRpnxeR4sjTTRwKDyfOkzMakcC+k0ZCF0c3b4q1acDPb+GMi6CilNLCU=
X-Received: by 2002:a05:6512:110e:b0:503:7dd:7ebc with SMTP id
 l14-20020a056512110e00b0050307dd7ebcmr6385076lfg.18.1695306665262; Thu, 21
 Sep 2023 07:31:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230825112633.236607-1-ulf.hansson@linaro.org> <20230825112633.236607-12-ulf.hansson@linaro.org>
In-Reply-To: <20230825112633.236607-12-ulf.hansson@linaro.org>
From:   Viresh Kumar <viresh.kumar@linaro.org>
Date:   Thu, 21 Sep 2023 16:30:48 +0200
Message-ID: <CAKohponrQRm5xP4Ahei7ZnSmfdsLk+6tFD+7mXZ_c23pEP+x9w@mail.gmail.com>
Subject: Re: [PATCH v3 11/13] cpufreq: scmi: Add support to parse domain-id
 using #power-domain-cells
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
> The performance domain-id can be described in DT using the power-domains
> property or the clock property. The latter is already supported, so let's
> add support for the power-domains too.
>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>
> Changes in v3:
>         - Move to get the power-domain index from power-domain-names.
>
> ---
>  drivers/cpufreq/scmi-cpufreq.c | 25 +++++++++++++++++++------
>  1 file changed, 19 insertions(+), 6 deletions(-)


Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
