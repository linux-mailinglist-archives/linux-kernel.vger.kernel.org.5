Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21A4C774143
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 19:17:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234295AbjHHRRf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 13:17:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234335AbjHHRRB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 13:17:01 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D85471F0D
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 09:06:56 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-58969d4f1b6so16245477b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 08 Aug 2023 09:06:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691510815; x=1692115615;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=EyDtqRMa+XeuHmfOHzoFQ2EBCRcPgUdz7VrLow00vho=;
        b=YFM9I4RT+07tXlEF/uDhTPtxhf7u6ZIa/DMEUQx7roPSkrnhbpRS5oDl7m9b0uCKda
         PVpStqqpcm4fnVP+t1Ei99YZTG242Vwtmvm7CkWJ3ZNuUxDkH5qftEyNtD92Vq3ZouS+
         78HUAYGnQPCsXmugHZAa8DNsmJTI70G4JKgEjQ4qtVfiHTnOODbcHMqrC7h9zY01iQbu
         jHtsKg5Dc3+WhJioeGfTh6vCj5Uvt41W0XHOPc4K0hRpPNKOSXz078IumK6B7BcCc9/M
         Oce52zl/S+tiXrA12qRvf2HMSjcxTlmrhkCnlTwSYG7QDMcu7Lbo5krF5qoozQNdkASQ
         Hz+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691510815; x=1692115615;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EyDtqRMa+XeuHmfOHzoFQ2EBCRcPgUdz7VrLow00vho=;
        b=HaBSz3yf6xVsiuThp2U8BpmiawxYiH9xpYYmzWrPLvms8muy7osPxFLuDiZuaphmfl
         xix2NKSxgOtvtCselkHLAkybG53g1U6z6cSeGuztlFisFYlFvlaJADWxsS6gh3YdrYxQ
         W5Zfe9Ax3B5GUxUzKUm0in9GGGJ7uKXUJPi5Rvio1tXJSI+uWF1BgriaMZJtW1QyBwY+
         dYEQ2wperFFnIiefjN5i4vfyQ2sCocYIVeei0+KE9NQiCfjckgLDpkg6TSUtgqXR2mNT
         iI216JMV/XzXn2I5sBx2cVCGDxEibhjg4mJ34vc7Pp9QIDmCb4GooNVcqBsNG659bxve
         E7QA==
X-Gm-Message-State: AOJu0Ywr9voGHon9sbwPwWKeWViGN6GI3vaxaOgFQat22G1iC+/00sX9
        AnGddqfrfnUiprcmjIA3Dq+S992c7vBv+iHE6ZS5IqAM4QjnyVSA
X-Google-Smtp-Source: AGHT+IEyc7HHsMlkF2r9nll2T0yEWZZ5v0pKzIcru7d42nj6cqrIRE36KBIE7qFz1IaWZ2c38uHVZnZYbGIn7T2NF0c=
X-Received: by 2002:a25:8d12:0:b0:d1d:514e:27c6 with SMTP id
 n18-20020a258d12000000b00d1d514e27c6mr10881786ybl.6.1691492001963; Tue, 08
 Aug 2023 03:53:21 -0700 (PDT)
MIME-Version: 1.0
References: <bf912d5f5e74b43903a84262565f564bfe0fed7e.1691047370.git.michal.simek@amd.com>
In-Reply-To: <bf912d5f5e74b43903a84262565f564bfe0fed7e.1691047370.git.michal.simek@amd.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 8 Aug 2023 12:52:46 +0200
Message-ID: <CAPDyKFoQk+ETga2za3=pLdN+btKsy6tx70o3wsZGZFQ0XWmEVg@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: mmc: arasan,sdci: Add power-domains and
 iommus properties
To:     Michal Simek <michal.simek@amd.com>
Cc:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com,
        Adrian Hunter <adrian.hunter@intel.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Aug 2023 at 09:23, Michal Simek <michal.simek@amd.com> wrote:
>
> ZynqMP SDHCI Arasan IP core has own power domain and also iommu ID that's
> why describe optional power-domains and iommus properties.
>
> Signed-off-by: Michal Simek <michal.simek@amd.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>
>  Documentation/devicetree/bindings/mmc/arasan,sdhci.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/mmc/arasan,sdhci.yaml b/Documentation/devicetree/bindings/mmc/arasan,sdhci.yaml
> index a6c19a6cc99e..3e99801f77d2 100644
> --- a/Documentation/devicetree/bindings/mmc/arasan,sdhci.yaml
> +++ b/Documentation/devicetree/bindings/mmc/arasan,sdhci.yaml
> @@ -160,6 +160,12 @@ properties:
>      description:
>        The MIO bank number in which the command and data lines are configured.
>
> +  iommus:
> +    maxItems: 1
> +
> +  power-domains:
> +    maxItems: 1
> +
>  dependencies:
>    '#clock-cells': [ clock-output-names ]
>
> --
> 2.36.1
>
