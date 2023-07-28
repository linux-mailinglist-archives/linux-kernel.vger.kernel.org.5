Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9772B7662BD
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 06:05:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231910AbjG1EFx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 00:05:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230265AbjG1EFt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 00:05:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08F2B30E3;
        Thu, 27 Jul 2023 21:05:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8FF3B61FC4;
        Fri, 28 Jul 2023 04:05:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C735C433CB;
        Fri, 28 Jul 2023 04:05:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690517148;
        bh=iYgqArYEpT+RpfI4qzyUqzciApfHd3Drk78CFViQqow=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZsIIbplR5xJoE0I6i4ZmoKThk8JoIgjZqll6IPh2BVRnIZJxIyE79erxsuUyQP5nR
         7qoc3OSlyatltHZkIS2Xm+i/jnbHqisu9f8j52n8oSp9OLmMnyjsWjTevcXIuR4IyU
         0OAphCVsGs01PfXmM+V0JcOOXgVQEkQWdgri7lBRtQyY2il67q91mwjA2VKoXOQvWy
         g6cBaE4MwY5eEWslteCwLlPycuFLUre2UBi6MYPHP1gi7mDjLOU48Ew3u6TMrXjZ/1
         zNNaS2gnq5j4JzB7Bd4p2u+ALXvvAkzAGLajDjOMcaVD6DkadoFx3ePi/YKqPV6gWD
         /8LB/9yF2h+IA==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clk: qcom: dispcc-sc8280xp: Use ret registers on GDSCs
Date:   Thu, 27 Jul 2023 21:08:52 -0700
Message-ID: <169051733315.1270972.16633043255357894662.b4-ty@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725-topic-8280_dispcc_gdsc-v1-1-236590060531@linaro.org>
References: <20230725-topic-8280_dispcc_gdsc-v1-1-236590060531@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 25 Jul 2023 10:51:56 +0200, Konrad Dybcio wrote:
> The DISP_CC GDSCs have not been instructed to use the ret registers.
> Fix that.
> 
> 

Applied, thanks!

[1/1] clk: qcom: dispcc-sc8280xp: Use ret registers on GDSCs
      commit: 20e1d75bc043c5ec1fd8f5169fde17db89eb11c3

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
