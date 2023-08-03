Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9F6676EFAF
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 18:35:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237313AbjHCQfh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 12:35:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236679AbjHCQfV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 12:35:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FAE6E77;
        Thu,  3 Aug 2023 09:35:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2CF9E61E3A;
        Thu,  3 Aug 2023 16:35:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FB5EC43140;
        Thu,  3 Aug 2023 16:35:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691080516;
        bh=G3FOLIfaHoy9tzg1QvyqoSq0xb1ylVr9cA8Be/6Aa04=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gygehvme91Sf5H7MIi14MCcsctKtR+cWv0OE+Uz0LQ1P8P7nVl9dux0olAILFYH/B
         M6fZxkw+FndYDyBKM9PBkoBWFD27ysd0/692IOdLKBzp17hWsz4UkI5Q4toMTj6iEn
         +oUqp5b5wJ2f6FylU+Dkek75zNGO3831o7Zyg55qOCZE+oTK/gtoAuWZdPj3KQsBc+
         N/e7SAlvO0Bfc8jDtX3Je7VkpuF5YdHwIeu24U+jegsVl4mPF+4gM9D6/ZjmCOH/ie
         Rwso5e7W3KJzkaERGmkvNdhdbXJ9dxHcxeoiqpJ7i8ALOsy4ehtUMTxgCPzUK+OTFb
         RuVPnYs6QgF/g==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Taniya Das <tdas@codeaurora.org>,
        Venkata Narendra Kumar Gutta <vnkgutta@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Patrick Whewell <patrick.whewell@sightlineapplications.com>
Cc:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        William Gray <william.gray@linaro.org>
Subject: Re: [RESEND PATCH v2] clk: qcom: gcc-sm8250: Fix gcc_sdcc2_apps_clk_src
Date:   Thu,  3 Aug 2023 09:38:06 -0700
Message-ID: <169108064631.108343.8315312770270911785.b4-ty@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230802210359.408-1-patrick.whewell@sightlineapplications.com>
References: <20230802210359.408-1-patrick.whewell@sightlineapplications.com>
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


On Wed, 02 Aug 2023 14:04:00 -0700, Patrick Whewell wrote:
> GPLL9 is not on by default, which causes a "gcc_sdcc2_apps_clk_src: rcg
> didn't update its configuration" error when booting. Set .flags =
> CLK_OPS_PARENT_ENABLE to fix the error.
> 
> 

Applied, thanks!

[1/1] clk: qcom: gcc-sm8250: Fix gcc_sdcc2_apps_clk_src
      commit: 783cb693828ce487cf0bc6ad16cbcf2caae6f8d9

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
