Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31C7A752667
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 17:15:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233542AbjGMPPH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 11:15:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233486AbjGMPPF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 11:15:05 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C6E5106;
        Thu, 13 Jul 2023 08:15:03 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-9924ac01f98so123244966b.1;
        Thu, 13 Jul 2023 08:15:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689261301; x=1691853301;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ejWIQTJ8MrmjvLsNIW9S8vt55JHQjtyx46a8r32tq1g=;
        b=kwu1l+2NxOFNYyFrFJ50wUPA5KuDc9reRIUJeO6GfB4hdFhvchS3utDFJnFdb9Dm3N
         vlGKRDF1rgoIx9ZS9Fsc3DUV148QyeWpu/xdxUU5Xk9cGMMLcimPdlfeO1NHKIxKkBCW
         e/Z9K5Th34uLR+N0YOi1JenYNinzkGOpDt+AqrA2GzAYYPnDtjCqlkXY7u4ZBAT1qQTk
         qsMrPxfxVJJEjNUOcZFdftxBaHdHOBmv/MhmtLUJpX3r5++XKrbM/6BmFH5Hbgr19jRZ
         TwE68jDuDk0SS+I5/HU/pjSVF0AMNMbKDxXoTbReRDa+iZ8FX5c2SNp44O/GhWboC5MF
         gZHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689261301; x=1691853301;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ejWIQTJ8MrmjvLsNIW9S8vt55JHQjtyx46a8r32tq1g=;
        b=OU5K7mcTcz1s9r8boLXKNRSaZYQQTl31lAP9YxCdLDF159/cfE9mxuJ4z2KGryopbY
         9APbCu+LRwU13mxkOhDcx0n011Rn9s+y7XBG3ur5OgJ+C3Q76DoeHHvGAr4hcbMbqhdM
         jaxJ3sBdxH4pq3wAuGlHEDKnoD6L6OZtyCuNGA2ANlIx7Vv/ElChFB8CJ0h3dD6s9cfC
         M+pUHNbG/XUl8gAlAgVPn2OQgzlu3WpPP14o4orjBnc+4SdIuKB7uxsj7DywrWBJFwz8
         KK3xgnt3mf43DdQkpmVB5yx5H6b+svKeUlsUzEpfzneLBPGSKK9GT6mUwokhsCkMiOhq
         daAQ==
X-Gm-Message-State: ABy/qLYbP4/vUeArckR/4037s4vT0yX5SBwop7xvCQ7tkgE5LOt2Pdgx
        rb6Yjt6LHotB3xw3pv44Wgw=
X-Google-Smtp-Source: APBJJlEL0pC3JqIMQMikXRbZwitjsByBW5SfrCFuOY1Lr/Bl1Du4uLIo8HflRw+hJFgTQ5yz94uvjA==
X-Received: by 2002:a17:906:2308:b0:98d:e7e3:5ab7 with SMTP id l8-20020a170906230800b0098de7e35ab7mr1781567eja.11.1689261301300;
        Thu, 13 Jul 2023 08:15:01 -0700 (PDT)
Received: from localhost (p200300e41f4b7100f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f4b:7100:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id hb24-20020a170906b89800b00977c7566ccbsm4043692ejb.164.2023.07.13.08.15.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jul 2023 08:15:00 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     broonie@kernel.org, robh+dt@kernel.org, krzk+dt@kernel.org,
        thierry.reding@gmail.com, lgirdwood@gmail.com, perex@perex.cz,
        tiwai@suse.com, Sameer Pujar <spujar@nvidia.com>
Cc:     jonathanh@nvidia.com, mkumard@nvidia.com, sheetal@nvidia.com,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH v2 0/5] Few audio fixes on Tegra platforms
Date:   Thu, 13 Jul 2023 17:14:56 +0200
Message-ID: <168926127035.2339191.6180837272583412024.b4-ty@nvidia.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <1688015537-31682-1-git-send-email-spujar@nvidia.com>
References: <1688015537-31682-1-git-send-email-spujar@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>


On Thu, 29 Jun 2023 10:42:12 +0530, Sameer Pujar wrote:
> This series fixes some of the issues which were observed during an attempt to
> enhance automated test coverage on Jetson AGX Orin. Below is a short summary
> of the issues and fixes:
> 
>   * Sample rate coversion failures above 48kHz.
>   * AMX and ADX test cases failures due to incorrect byte mask.
>   * Atomic sleep in RT5640 codec which is present on Jetson AGX Orin.
>   * AHUB clock fixes on Tegra234 and previous chips.
>   * Minor cleanups in ASRC and AHUB driver.
> 
> [...]

Applied, thanks!

[4/5] arm64: tegra: Update AHUB clock parent and rate on Tegra234
      commit: e483fe34adab3197558b7284044c1b26f5ede20e
[5/5] arm64: tegra: Update AHUB clock parent and rate
      commit: dc6d5d85ed3a3fe566314f388bce4c71a26b1677

Best regards,
-- 
Thierry Reding <treding@nvidia.com>
