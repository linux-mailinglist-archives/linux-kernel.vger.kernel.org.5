Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D75497C852C
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 14:00:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231625AbjJML7S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 07:59:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231580AbjJML7N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 07:59:13 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF3A5CA;
        Fri, 13 Oct 2023 04:59:11 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-9b64b98656bso321418866b.0;
        Fri, 13 Oct 2023 04:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697198350; x=1697803150; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=thbVoOKvvFFfWREjhW0EaTYNaIfFHPUXv/GpkLEVSkM=;
        b=TTMxU0lcAo/FXowvRY2PNcaRM04eQ21t4KaXoOX/Jl7TVH2+Aod7Kk5fmPquNZ7b+e
         T0PINfOFo4qFnrO44Ml1tqjwhzoJMEeY2s3aS8s5HQMNpuIZbK0izzDGWDUcmtbOZblP
         El76AISotSocNUhEPJomnLKMjXyUEvTeyGvnW32nRnfoxxMD5M+k0ZOVJm0DVsJBxCZG
         EoHQNYoqtoXBODVxJ6CekIiJBGppX5BeYeAte8SOHjQExbNcXvUwA8nHWoszo/vUD9iB
         pzDdCEY4ylDdjvwg6udXRQ1OFlt+krQsNMI5LY94WEx1ibLTwgwAITfiHxqd+Xx6HA+T
         wHdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697198350; x=1697803150;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=thbVoOKvvFFfWREjhW0EaTYNaIfFHPUXv/GpkLEVSkM=;
        b=nIJfGuiHlipFMCe2h7UAiqzzNKwdiGV1w8BYPe7l36g6tgUmeDH4R9Q6IePCR3MM1h
         3TgXz7vn/z9Ru5GNp27cu6R661aMnAtcQMBkCSKcWAqMfKcNaEaJbiJYm8BBA1odggyO
         kuHYgO93tqY7bz8qo3Z1wo9qSwFxK293nS1VdRKcIC3NfAqRTtuEKR4n3zrvK7yWNiTC
         bFgnW04grnUEb67tR5fQMsMlD4Hi8P29LxxaFEaXESwfQrRYQIqq1TUjc/09yRj3nAiQ
         7Sb3Qu1qawd0rB8tAXD8WOd0fdqHa3iDk/zByVmetHA0iff1KCQeZ/P68VCKRiG/aGOg
         x8qQ==
X-Gm-Message-State: AOJu0YwRkJvjD1tw0DAbI4L1U733rOXIzDtJPqLHBMwyBRfUKwK8Ww8z
        7tRg2JgSyGSqNDglzTuwvHMLnVPddYg=
X-Google-Smtp-Source: AGHT+IFVTrO5QAjuQ+dzy+VrB5ivQQbjM4YWV1IRwl+W0iT1JCPlgwxSx8TsLHtgYfHzzMVhvqQZ8A==
X-Received: by 2002:a17:906:8a64:b0:9b3:120:f319 with SMTP id hy4-20020a1709068a6400b009b30120f319mr22632705ejc.51.1697198350045;
        Fri, 13 Oct 2023 04:59:10 -0700 (PDT)
Received: from localhost (p200300e41f3f4900f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f3f:4900:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id qq25-20020a17090720d900b00977cad140a8sm12349240ejb.218.2023.10.13.04.59.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Oct 2023 04:59:09 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH 0/5] PM: domains: Drop pm_genpd_opp_to_performance_state()
Date:   Fri, 13 Oct 2023 13:59:06 +0200
Message-ID: <169719833142.3828427.5236534342833939623.b4-ty@nvidia.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231012152108.101270-1-ulf.hansson@linaro.org>
References: <20231012152108.101270-1-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>


On Thu, 12 Oct 2023 17:21:08 +0200, Ulf Hansson wrote:
> Since commit 7c41cdcd3bbe ("OPP: Simplify the over-designed pstate <-> level
> dance"), there is no longer any users of the
> pm_genpd_opp_to_performance_state() API, while a few genpd providers are still
> assigning the redundant ->opp_to_performance_state() callback.
> 
> Let's clean this up so we can drop pm_genpd_opp_to_performance_state() and the
> callback too.
> 
> [...]

Applied, thanks!

[1/5] soc/tegra: pmc: Drop the ->opp_to_performance_state() callback
      commit: cda263907a6f88c75fb97cf7adecffaafb6237ec

Best regards,
-- 
Thierry Reding <treding@nvidia.com>
