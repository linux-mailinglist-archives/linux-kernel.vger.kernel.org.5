Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4497977828B
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 23:11:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbjHJVLX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 17:11:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbjHJVLW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 17:11:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB5BA2D44;
        Thu, 10 Aug 2023 14:11:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7B49364A79;
        Thu, 10 Aug 2023 21:11:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B171C433C8;
        Thu, 10 Aug 2023 21:11:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691701880;
        bh=NAb1X5poE1kxGcWg8Mx0g5QNjvBcpXzTJvawJVT2Klk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gQ/7HoRsvPY5jLn+DZ3gpxtSyoi03ZMFpDXYPtXbQCTkGPkqmRl50qKZeRpDeN6hx
         SfXw0x8xJcI2Ec+uaXD14q8fkim/WMJNh7ObJEX00Ez/7FLjfxMAgPFGwt19BYCrmu
         Be//LlQZ6aTifYcdYIn9ZDitT6a8ZQVHMqkLtayulynUsIZr1rGBu0McLwF0a/kxH8
         /vtzGGIVm+I3Tld4Vi5vR31h2AQfgsORniliis7EY5h+Kh/pg0ilt+oE+124jFq5eP
         8WWFTqUfwh/1eJFgWRL97zMyZ8AIlEZBQZFxhmneyfDK970tHqGc6814ByJo1snE6y
         Iic7J0Equrwqg==
Received: (nullmailer pid 1192664 invoked by uid 1000);
        Thu, 10 Aug 2023 21:11:18 -0000
Date:   Thu, 10 Aug 2023 15:11:18 -0600
From:   Rob Herring <robh@kernel.org>
To:     Luo Jie <quic_luoj@quicinc.com>
Cc:     linux-clk@vger.kernel.org, will@kernel.org, conor+dt@kernel.org,
        p.zabel@pengutronix.de, devicetree@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org,
        konrad.dybcio@linaro.org, linux-arm-msm@vger.kernel.org,
        robh+dt@kernel.org, mturquette@baylibre.com,
        quic_srichara@quicinc.com, sboyd@kernel.org,
        catalin.marinas@arm.com, agross@kernel.org, andersson@kernel.org
Subject: Re: [PATCH v3 2/3] dt-bindings: clock: add qca8386/qca8084 clock and
 reset definitions
Message-ID: <169170187710.1192576.13560521597205216697.robh@kernel.org>
References: <20230810115419.25539-1-quic_luoj@quicinc.com>
 <20230810115419.25539-3-quic_luoj@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230810115419.25539-3-quic_luoj@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 10 Aug 2023 19:54:18 +0800, Luo Jie wrote:
> QCA8386/QCA8084 includes the clock & reset controller that is
> accessed by MDIO bus. Two work modes are supported, qca8386 works
> as switch mode, qca8084 works as PHY mode.
> 
> Signed-off-by: Luo Jie <quic_luoj@quicinc.com>
> ---
>  .../bindings/clock/qcom,qca8k-nsscc.yaml      |  79 ++++++++++++++
>  include/dt-bindings/clock/qcom,qca8k-nsscc.h  | 101 ++++++++++++++++++
>  include/dt-bindings/reset/qcom,qca8k-nsscc.h  |  75 +++++++++++++
>  3 files changed, 255 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/qcom,qca8k-nsscc.yaml
>  create mode 100644 include/dt-bindings/clock/qcom,qca8k-nsscc.h
>  create mode 100644 include/dt-bindings/reset/qcom,qca8k-nsscc.h
> 

Reviewed-by: Rob Herring <robh@kernel.org>

