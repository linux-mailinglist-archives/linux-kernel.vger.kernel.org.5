Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C0CE7A9D32
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 21:29:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230465AbjIUT3c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 15:29:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230070AbjIUT3K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 15:29:10 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65F83A9EA;
        Thu, 21 Sep 2023 10:07:28 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4ACB6C32780;
        Thu, 21 Sep 2023 09:38:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695289085;
        bh=94iskBoc6V/PnxsBaXf75S6qQ4CxvGzdNsAZ1gka2mg=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=PINsPSLHMNW0Ir2cAkCHqaAQHo2ZkKI28ArKcJ42NTjFW8szAXnJE3hoJFYG61AUj
         3xSpLYDx43ZvVcIj1MWn3tJzUgJfwSA7TFYG1qWIdUgd4m5LTuGUIOJq8RsqsJxDLK
         sbYPAbfsdrZ9CQ8xRCaa5+Qe8Hmr5eNM83M17mAdBF+ERS2Z7kbTMKYx/LpCCj5q8w
         4l+SuoWZGo6GtlIZYz5gTkDIPZjclLuS1BX/FLvE3okRFHwdaS41YbP7jr9SyY73RY
         RAA22XSshN5HVtn5WmBy3iN5Vrc3ZVJMjyRd4U/luHgQQ5xTtF+CJzAW68Cp95AqWX
         hTS84DsY5VdcA==
From:   Vinod Koul <vkoul@kernel.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230728112848.67092-1-krzysztof.kozlowski@linaro.org>
References: <20230728112848.67092-1-krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH 1/2] soundwire: qcom: use newer link status tregister
 on v2.0.0
Message-Id: <169528908296.97319.1848948668643094291.b4-ty@kernel.org>
Date:   Thu, 21 Sep 2023 11:38:02 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 28 Jul 2023 13:28:47 +0200, Krzysztof Kozlowski wrote:
> Soundwire v2.0.0 comes with a new register LINK_STATUS for the
> FRAME_GEN_ENABLED field (bit indicating that an active frame is
> running).  The old register COMP_STATUS is still there and still works,
> although the new one is preferred in downstream sources.  Probably
> because it allows to choose Soundwire instance per CPU.  Most of the
> code allowing to use new register for Soundwire v2.0.0 was already there
> as part of commit 312355a6a9f6 ("soundwire: qcom: add support for v2.0.0
> controller"), so switch to it in swrm_wait_for_frame_gen_enabled()
> function.  This should not have functional impact, because the old
> register still behaves correctly.
> 
> [...]

Applied, thanks!

[1/2] soundwire: qcom: use newer link status tregister on v2.0.0
      commit: 5d78c7d684192e42241593a936ee60003d8ac064
[2/2] soundwire: qcom: handle command ignored interrupt
      commit: 16d568c8f646933710c980783d87d3f59a89b563

Best regards,
-- 
~Vinod


