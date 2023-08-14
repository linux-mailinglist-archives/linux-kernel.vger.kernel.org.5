Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2313B77B013
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 05:26:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232845AbjHNDZ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Aug 2023 23:25:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232745AbjHNDZC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Aug 2023 23:25:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10329110;
        Sun, 13 Aug 2023 20:25:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9B48A62908;
        Mon, 14 Aug 2023 03:25:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 198B8C433CC;
        Mon, 14 Aug 2023 03:25:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691983501;
        bh=M0jnguORfubM9FJgougQLvnCV0zy+B3Ub7qS6gEdW6E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uO/+5QJCmwsIDjluzI0/rUssc5BfRqYzaSeRv/0m9HU/U8k13KNzzyT2rJ4em320K
         7n04oWiv00YOaB49O4O4nPa2EDbmKGdfZDsNRKxEd+TpDpEOw/JsM+YnViLeS4H5Xq
         cMyffCOmbjb7pIkH2xc1NJXlNB/RUEdh0E+ZjJom73axr8eaTGZ13iPp04PJg4ql1c
         oLiIkGA9QfGMlEGviy3CQOXMivJ4aOIXBZw60hyjiBsA/l11oYWq30H5BfC+A5PGnb
         MbkNknDyblTEJxPBzB2TH3Ua7BhNoA5qcbEm0mFJ0IqYkfolwIzom1uM2fYX6EN5Ae
         lFfbhQDCRYySw==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Andy Gross <agross@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-crypto@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH 0/3] Introduce PRNG on SM8450
Date:   Sun, 13 Aug 2023 20:27:31 -0700
Message-ID: <169198364302.2443702.962620427855698520.b4-ty@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230811-topic-8450_prng-v1-0-01becceeb1ee@linaro.org>
References: <20230811-topic-8450_prng-v1-0-01becceeb1ee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 11 Aug 2023 22:50:55 +0200, Konrad Dybcio wrote:
> SM8450's PRNG seems to be the same good ol' IP, except without a core
> clock.
> 
> For a lack of a better idea on how to test it, /proc/crypto reports that
> the selftest has gone through..
> 
> 
> [...]

Applied, thanks!

[3/3] arm64: dts: qcom: sm8450: Add PRNG
      commit: 76a6dd7bfcbb91217e4429d73c14ee67b441137d

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
