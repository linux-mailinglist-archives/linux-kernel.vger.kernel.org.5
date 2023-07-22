Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 508A875DA2A
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 07:15:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231597AbjGVFPU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jul 2023 01:15:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231467AbjGVFOf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jul 2023 01:14:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 166164200;
        Fri, 21 Jul 2023 22:14:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A30A460B00;
        Sat, 22 Jul 2023 05:14:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D2B5C433C7;
        Sat, 22 Jul 2023 05:14:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690002867;
        bh=XyYvAWHS41m400D1pKGMJwyE5YkKJQQO/Hxf7hJJ2eQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RT+LKfZ4iW5eNZ9vTxkDzhevAGTP3d5o9spsVDFwRgvmrlR2awaYLlCMZjbf87faT
         JCXXvtC6oeQTc+LCx06I5Tp7z2bSCjJptVCrAIA3svf/PjP/CdAMmOvnOnnTEhdzko
         uRzWHTTGaAx1MIf8Uc6gweaRqmiXKVzDBFXNvFDBGIG2oxw+FbDWlEDBUCXdNhKbWg
         GPAd+LWO9uDw1E+ynSgpYKv/SMj96TVmn9psSQuC4MftBFW2hecv/c0m4XagXw7Sgq
         ak12bY9XufpxvzJL/bsXI9j5VohzShZj19Irynt2KxlnBUQg8U0AeNqV7CbD36iIxZ
         ChL94bf8SU4VA==
From:   Bjorn Andersson <andersson@kernel.org>
To:     agross@kernel.org, konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        Rohit Agarwal <quic_rohiagar@quicinc.com>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] Use generic RPMHPD bindings for some of the Qualcomm SoCs
Date:   Fri, 21 Jul 2023 22:17:24 -0700
Message-ID: <169000304194.3611206.10792498261042328809.b4-ty@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <1689840545-5094-1-git-send-email-quic_rohiagar@quicinc.com>
References: <1689840545-5094-1-git-send-email-quic_rohiagar@quicinc.com>
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


On Thu, 20 Jul 2023 13:39:01 +0530, Rohit Agarwal wrote:
> This series updates the devicetree file of SM8[2345]50 to use the new
> generic RPMHPD bindings introduced in a previous series [1] and depends on it.
> 
> [1] https://lore.kernel.org/all/1689744162-9421-1-git-send-email-quic_rohiagar@quicinc.com/
> 
> Thanks,
> Rohit.
> 
> [...]

Applied, thanks!

[1/4] arm64: dts: qcom: sm8250: Update the RPMHPD bindings entry
      commit: 34e2fd6a686ba4a6893d16dee1602a69d73bc66d
[2/4] arm64: dts: qcom: sm8350: Update the RPMHPD bindings entry
      commit: fc4cbfbb7fb2ce5ad6c2afa3e529e8f04021d5fc
[3/4] arm64: dts: qcom: sm8450: Update the RPMHPD bindings entry
      commit: 8ed9de79680f1d0165e0bf6cc97a91fb08b67115
[4/4] arm64: dts: qcom: sm8550: Update the RPMHPD bindings entry
      commit: 1d14bcffb49c9d0d1268804bc9e7817120a9575f

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
