Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A58D76EFAE
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 18:35:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237307AbjHCQfc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 12:35:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236262AbjHCQfS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 12:35:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B7043AAC;
        Thu,  3 Aug 2023 09:35:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EF2C161E48;
        Thu,  3 Aug 2023 16:35:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A256C433C9;
        Thu,  3 Aug 2023 16:35:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691080515;
        bh=9GF8dPmqpJDorXIVtKf+9BG4DCxzhozeJx7oB74izKc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LHY2AgOLT1XO79agb5Nxaz/L5Sn4ZNaQhD5qLSgQj2FU7WbYKMfWL/RKMQ/WKS+dk
         8G4+JChxklJLmZElnB6mLdQuljxmvPbcA3B0Nue67DkJJtqdMet2PB/3Xs3ZZSUzGF
         rx0ev1HzU6gL4mtuqE9LWKy11N5dO/QExBcLcKhnhm5sER3luYuAKiYXybkBiG/Ayw
         iayFz3ZNDmpIycdaWiojgrNrKsOEQlKoS5xpMzLTvQ8NZknacVUF7aYCcThCNqv5+A
         rxl/yDE2HP9pIEvArQdrjCx8iNBwk6SVu6f+7YfAKfQvRA7QlEIc2Goy2dHQjRPcgP
         B7CPlL4QBGiGQ==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Andy Gross <agross@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        cros-qcom-dts-watchers@chromium.org,
        Marijn Suijten <marijn.suijten@somainline.org>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Martin Botka <martin.botka@somainline.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: (subset) [PATCH v5 0/2] dts: qcom: Use labels with generic node names for ADC channels
Date:   Thu,  3 Aug 2023 09:38:05 -0700
Message-ID: <169108064641.108343.2633623346382690322.b4-ty@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230730-generic-adc-channels-v5-0-e6c69bda8034@somainline.org>
References: <20230730-generic-adc-channels-v5-0-e6c69bda8034@somainline.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 30 Jul 2023 22:31:24 +0200, Marijn Suijten wrote:
> As discussed in [1] it is more convenient to use a generic `channel`
> node name for ADC channels while storing a friendly - board-specific
> instead of PMIC-specific - name in the label, if/when desired to
> overwrite the channel description already contained (but previously
> unused) in the driver [2].
> 
> The same `channel` node name pattern has also been set in
> iio/adc/adc.yaml, but this generic binding is not inherited as base for
> qcom,spmi-vadc bindings due to not having any other generic elements in
> common, besides the node name rule and reg property.
> 
> [...]

Applied, thanks!

[1/2] ARM: dts: qcom: Use labels with generic node names for ADC channels
      commit: 04601b9b1b67888b7e2987e31ab40637f7c999c0

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
