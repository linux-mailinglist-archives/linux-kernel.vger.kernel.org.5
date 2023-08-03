Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A580A76EFA8
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 18:35:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237142AbjHCQfY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 12:35:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234587AbjHCQfO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 12:35:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2FBBE77;
        Thu,  3 Aug 2023 09:35:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 836A661E32;
        Thu,  3 Aug 2023 16:35:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E095C433CC;
        Thu,  3 Aug 2023 16:35:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691080512;
        bh=eDIAanYdSbzWKeqIeelcPw2HbevmTucCnIfnv4pg290=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=Mx8SSs3s8ibGwW3T9PqkVQkLlsizNUgoYMhbcMsv6AjPhnY+QVaM9ioKsm4R9MnyX
         ouj8GkoLtA6x0LAaV80v+9Egh5iwxKNDDLUmIrRxu09Fo3ppda/6gAznkhVigBTsit
         sSTBb4JXy/OFoIIE/ubf2T/BQRrLLIFdzwUHMklNgDSn0YqTj4RinfQYF6r4+6cseA
         xGaaCjmM12hxwKqkjcT/h2EaykwObNK04CD3KeDfF5f342CU3/va+IeRev2NPy1ATs
         Umw8ZJBXCV+EASgV5/U865dujxjrtURSJl7lF5r2VdgmsNyYU95lM2fmK1R5Gq3Kw5
         YWuT9H/XsgUhw==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH] arm64: dts: qcom: msm8953-daisy: use new speaker maxim,interleave-mode
Date:   Thu,  3 Aug 2023 09:38:03 -0700
Message-ID: <169108064638.108343.2880061463839618717.b4-ty@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230730202051.71099-1-krzysztof.kozlowski@linaro.org>
References: <20230730202051.71099-1-krzysztof.kozlowski@linaro.org>
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


On Sun, 30 Jul 2023 22:20:51 +0200, Krzysztof Kozlowski wrote:
> MAX98927 speaker amplifier "interleave_mode" property was never
> documented.  Corrected bindings expect "maxim,interleave-mode" instead,
> which is already supported by Linux driver.  Change is not compatible
> with older Linux kernels.
> 
> 

Applied, thanks!

[1/1] arm64: dts: qcom: msm8953-daisy: use new speaker maxim,interleave-mode
      commit: b6866546c214aad707f69a7d96215e3d08c2eb84

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
