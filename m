Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E01ED754CB8
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jul 2023 00:10:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230184AbjGOWKd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jul 2023 18:10:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229981AbjGOWKT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jul 2023 18:10:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFBDD2723;
        Sat, 15 Jul 2023 15:10:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 640A460C50;
        Sat, 15 Jul 2023 22:10:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3F7BC433CD;
        Sat, 15 Jul 2023 22:10:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689459016;
        bh=fzXa2Uoxmo5Pv7nm/8+pm9wLcvtWAWr1jggWVxuBw00=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=b1pagmP32wtVHiXPU+YIl4NOlKlY2I60P+Ef+Zh1ztvzV/A59jXBMnjXPdyN9qJO8
         8pLuv8Rz3y2Wk70v/Pmmi7Bg+rDyItime+rIBWZmX8JnZGFo4Ztp6N5GTXRioj3Lqt
         mT67SL4SVs2nAHLib464zKmgZoZarxnoLV3UXysQ+BtL50PIkC1TlLyK1cuumGi3DD
         KDo4ZPXaCbFkLS2FHHjc9SEmiXhkVlQczKl+M8AcO+pawmKT5lH/lEsgYaP/HYrDZA
         6TKLNSA/uusSaT8EpaueLvgzEZM2rHLtLOaEHWhm2LU4do0z7pfxGyEN2cNdPIWomp
         3sgtTkQk7oJRQ==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Andy Gross <agross@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Dylan Van Assche <me@dylanvanassche.be>
Cc:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org
Subject: Re: (subset) [PATCH v3 0/3] remoteproc: qcom: pas: Support SDM845 SLPI
Date:   Sat, 15 Jul 2023 15:13:32 -0700
Message-ID: <168945921474.1805013.11097249554000566257.b4-ty@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230330164633.117335-1-me@dylanvanassche.be>
References: <20230330164633.117335-1-me@dylanvanassche.be>
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


On Thu, 30 Mar 2023 18:46:30 +0200, Dylan Van Assche wrote:
> * About *
> 
> The Qualcomm SDM845 SoC has a separate SLPI (Sensor Low Power Island)
> DSP for sensors connected to the SoC which is responsible for exposing
> sensors to userspace, power saving, and other features.
> While sensors are connected to GPIOs of the SoC, they cannot be used
> because the hypervisor blocks direct access to the sensors, thus the
> DSP must be used to access any sensor on this SoC. The SLPI DSP uses a
> GLink edge (dsps) to communicate with the host and has a FastRPC interface
> to load files from the host filesystem such as sensor configuration files.
> The FastRPC interface does not use regular FastRPC Compute Banks
> but instead uses an allocated CMA region through which communication happens.
> 
> [...]

Applied, thanks!

[1/3] dt-bindings: remoteproc: qcom: adsp: add qcom,sdm845-slpi-pas compatible
      commit: 242a626870eb453934b75749f8dbab997556b555
[2/3] remoteproc: qcom: pas: refactor SLPI remoteproc init
      commit: 637e98bfe20b2c6866cd79b8d487430af09dc8ac

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
