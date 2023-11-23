Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2380D7F5917
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 08:21:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343905AbjKWHVP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 02:21:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbjKWHVN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 02:21:13 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14B36109
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 23:21:20 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6922C433C7;
        Thu, 23 Nov 2023 07:21:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700724079;
        bh=OP0/bY80RUPFBGCPYyA8H/XM+iSF8+mpGICoK9yfeTw=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=a2QxUt5hPAYdSv3pkgDlCmYd9J5S4ZvTSjKklcxb5FgAe7kl18KTTEF4Ph1gci4ln
         HpTNFH/hIzzIhKo9r+ZGXOK8+u4TV11OtiJ9uly8uIAlsc0/vUpjeUt5hWGYESEQEr
         AMbdENmDoT6CrFeJf1Wa/Kj6JiUPH6WisQ1d6ubpCAVcexlPZzarCoWDfHv+T/uGpJ
         Pzv7njLLnnQkl096K9LDtGD6dEAG+2BKUHGifkYM48tZ9w9byE++8r22bf3fdAhYT9
         etbuG78QaUrCmBzPP/VT+fgZbJl++nnG4FT8xwzwyYQheWscFCdhBJ4z7k069pIASO
         ZIIRlikA3suwQ==
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
In-Reply-To: <20231120190740.339350-1-krzysztof.kozlowski@linaro.org>
References: <20231120190740.339350-1-krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH 1/2] soundwire: qcom: drop unneeded
 qcom_swrm_stream_alloc_ports() cleanup
Message-Id: <170072407531.674978.2652900488518504446.b4-ty@kernel.org>
Date:   Thu, 23 Nov 2023 12:51:15 +0530
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 20 Nov 2023 20:07:39 +0100, Krzysztof Kozlowski wrote:
> The cleanup in "err" goto label clears bits from pconfig array which is
> a local variable.  This does not have any effect outside of this
> function, so drop this useless code.
> 
> 

Applied, thanks!

[1/2] soundwire: qcom: drop unneeded qcom_swrm_stream_alloc_ports() cleanup
      commit: 5c68b66d4d7eff8cdb6f508f8537faa30c5faa6d
[2/2] soundwire: qcom: move sconfig in qcom_swrm_stream_alloc_ports() out of critical section
      commit: 5bdc61ef45007908df9d8587111c7a5a552bdd46

Best regards,
-- 
~Vinod


