Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D75057F6C81
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 07:58:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229453AbjKXG6r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 01:58:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231222AbjKXG6l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 01:58:41 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC6E7D41
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 22:58:46 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF380C433C7;
        Fri, 24 Nov 2023 06:58:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700809126;
        bh=U6byld8anRrkI6XoiBszDu/qVMqfQAx6ni8me6xAFng=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=BXLqPYz8orin3Xjy69BbAjdMvVGl0eHcTTWog1tOzuJSnBjOFiNwHNKSCtaKIZaHq
         ZhKZ/dikU7t6ItWru8SrwYzUYfcy+lOx1ztMZ81nTgzhcwbow/T8WKDlmSUqFrXH4k
         jIlv/zq8/j1Jj06A0Rh/drdABJ3147wmu97IpQoViI6ux3Lrt6P8l7IOm3+mK9MP1L
         8VC+1oQ1nO2stf+eqXL92YBGHgqGz+dtz4pYmoj7Ohug2QznaSOHN1U3UvHbumZMTy
         eD/vsmpjpjCRAa3clFAbZYtu+LCdZXMJxUgEsrvbCrm26UG4Nxtupg1hJuxb15MLxf
         y7XG9nufdkr6w==
From:   Vinod Koul <vkoul@kernel.org>
To:     alsa-devel@alsa-project.org, srinivas.kandagatla@linaro.org
Cc:     broonie@kernel.org, perex@perex.cz, tiwai@suse.de,
        yung-chuan.liao@linux.intel.com, linux-kernel@vger.kernel.org,
        pierre-louis.bossart@linux.intel.com,
        krzysztof.kozlowski@linaro.org
In-Reply-To: <20231123105332.102167-1-srinivas.kandagatla@linaro.org>
References: <20231123105332.102167-1-srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH] soundwire: qcom: set controller id to hw master id
Message-Id: <170080912346.720753.8349008868499476969.b4-ty@kernel.org>
Date:   Fri, 24 Nov 2023 12:28:43 +0530
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 23 Nov 2023 10:53:32 +0000, srinivas.kandagatla@linaro.org wrote:
> Qualcomm Soundwire Controllers IP version after 1.3 have a dedicated
> master id register which will provide a unique id value for each
> controller instance. Use this value instead of artificially generated
> value from idr. Versions 1.3 and below only have one instance of
> soundwire controller which does no have this register, so let them use
> value from idr.
> 
> [...]

Applied, thanks!

[1/1] soundwire: qcom: set controller id to hw master id
      commit: a7ae05ef356162c2a7ff108a7ff154d7d0dcd6aa

Best regards,
-- 
~Vinod


