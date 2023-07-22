Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD59775DA28
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 07:15:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231418AbjGVFPK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jul 2023 01:15:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231464AbjGVFOb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jul 2023 01:14:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 093B53C2A;
        Fri, 21 Jul 2023 22:14:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C825460AFD;
        Sat, 22 Jul 2023 05:14:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87DFCC433C9;
        Sat, 22 Jul 2023 05:14:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690002866;
        bh=UuE1s+lRwHdWB5JC7kATLqxbXlmee916ziCC0eSek10=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mR2S15JOKyYzVBxRShX3NNmRG8NOnAhHveN5HXf/Yg+Zbo6nDdBv8S4V7fySA9h3t
         00DtsVUWr1aHLOAg/diQCqy5rh6U+/MnhX6SAqVwkCz0bxh0Uy57+K77rF5EMCKwyu
         HCla2cAo3PoyCungZ9zKcqUUGeWeTt8KKtBN0lSUl652uYlxRFDAGI2VlY6JRGpOtZ
         mmgYq4O7F4VZSottaPHpiwDFO0VUItPdtTg3c0GSDVGkKUK6r3GyxlXVZIyLCVz75J
         Sy4ILI/lWAfL/zhYo8PHJUT3BmHYSWIttvO+Q7Kd5nBOLjFihOaWIrlxvkOSkpUnAq
         iLcmOr1USDY0Q==
From:   Bjorn Andersson <andersson@kernel.org>
To:     agross@kernel.org, konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        Rohit Agarwal <quic_rohiagar@quicinc.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: (subset) [PATCH 0/2] Introduce new generic bindings for RPMHPD
Date:   Fri, 21 Jul 2023 22:17:23 -0700
Message-ID: <169000304193.3611206.15540856664685705788.b4-ty@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <1689744162-9421-1-git-send-email-quic_rohiagar@quicinc.com>
References: <1689744162-9421-1-git-send-email-quic_rohiagar@quicinc.com>
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


On Wed, 19 Jul 2023 10:52:40 +0530, Rohit Agarwal wrote:
> This series introduces a new generic bindings for Qualcomm SoCs
> to be used instead of creating new SoC specific bindings each time.
> The order of the bindings is kept according to the order in Qualcomm
> SoC like SM8[2345]50 so that it can be reused in these SoC without
> breaking the ABI.
> This was suggested as per the discussions in [1].
> I will create a followup series of DT updates according to the new bindings.
> 
> [...]

Applied, thanks!

[2/2] soc: qcom: rpmhpd: Use the newly created generic RPMHPD bindings
      commit: de3acb7af908ef4fa9fda19cdfce1cc30cb48388

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
