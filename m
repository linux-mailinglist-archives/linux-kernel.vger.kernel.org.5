Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72FEB7662C0
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 06:06:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233269AbjG1EF6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 00:05:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230302AbjG1EFu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 00:05:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0EC730E4;
        Thu, 27 Jul 2023 21:05:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7C6E761FBA;
        Fri, 28 Jul 2023 04:05:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FCBEC433C7;
        Fri, 28 Jul 2023 04:05:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690517148;
        bh=dHltZhHdE5uw2HizC9WfEno1ZG1bS3l7xu/Dsxyv7yo=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=fHk6RSsz5su3QndTYlRQ3NVCGARzd5EvVe205Ss5zFFVXhO2RgvLP33DMyP3iaPlL
         SKc9VKDZH2QZKHNU83eGqYsqt7BxhPn9nLJINMN4GSASeVRs5ubJITjy2JHev7F26G
         kb5KFr1xhYT2Dapf1HwRbCu7KWNC6wY+ayrPSNFSGwKHQ3QJOI+Vuub3TT+040sNFD
         PUbRAG6aflEgfkJ/HkhJC47ihEQE5wpXm2hYhpDttJqUfTdqXuf3SqZ4LEudL+AywZ
         nqxCoStGZmdMOLgVfJ9x7JSvxhrgRFfUX7au4I4WLkmcyJIzSGNQ71IucHhER2BTsM
         jmWveabvGR+Wg==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Christian Marangi <ansuelsmth@gmail.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH] dt-bindings: arm: msm: kpss-acc: Revert "dt-bindings: arm: msm: kpss-acc: Make the optional reg truly optional"
Date:   Thu, 27 Jul 2023 21:08:53 -0700
Message-ID: <169051733322.1270972.2942168850088686471.b4-ty@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230724090109.19489-1-krzysztof.kozlowski@linaro.org>
References: <20230724090109.19489-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 24 Jul 2023 11:01:09 +0200, Krzysztof Kozlowski wrote:
> This reverts commit 981be238e1d28e156aa9da2a8722f86f02fd0453 because it
> was totally bogus and duplicated existing minItems:
> 
>   ruamel.yaml.constructor.DuplicateKeyError: while constructing a mapping
>   Documentation/devicetree/bindings/power/qcom,kpss-acc-v2.yaml: ignoring, error parsing file
> 
> 
> [...]

Applied, thanks!

[1/1] dt-bindings: arm: msm: kpss-acc: Revert "dt-bindings: arm: msm: kpss-acc: Make the optional reg truly optional"
      commit: 2f17bea81aff53155689de776e52328f82bf603c

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
