Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A02207F5918
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 08:21:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344862AbjKWHVS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 02:21:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344843AbjKWHVQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 02:21:16 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D72D9109
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 23:21:22 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 561C7C433C9;
        Thu, 23 Nov 2023 07:21:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700724082;
        bh=CsnrSxt8LqWz3IlU5RxL7FNAeARoDHTOQPwscn2bFpU=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=EN5QnXGXMDpptcghyw9o8SG+qqcVf9CJSLaF+/zuGzWvy2Q8pJP7X2cFJm+m68l1K
         Dav99GsszboT1/jgiSD5AHfFbyTo636ngZSDVVPLJFobKHVuLFhc5S+yWxtcWRaGxh
         puSffdbv4LTlcE6rXhgZ/Bi9/liIxUEMaUIOy7VW1yXWjFgbwY0OTZXjuXH9p84ONP
         JRCtLH7tCSKExOiLna09iAeB0pnLBligL1YUHIXWPkm4ufNdwXIo/jhWCXWedkMry5
         OoYA4WH+/fVz+mkGDR8pcBxkWFVVMZPu5EAcsMjrJUIaAIYqEj4ctub9uGMZoUjcv5
         BaO3F6CTiFNRw==
From:   Vinod Koul <vkoul@kernel.org>
To:     Bard Liao <yung-chuan.liao@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20231120174720.239610-1-krzysztof.kozlowski@linaro.org>
References: <20231120174720.239610-1-krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH] soundwire: stream: constify sdw_port_config when
 adding devices
Message-Id: <170072407994.674978.4727113730635083960.b4-ty@kernel.org>
Date:   Thu, 23 Nov 2023 12:51:19 +0530
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


On Mon, 20 Nov 2023 18:47:20 +0100, Krzysztof Kozlowski wrote:
> sdw_stream_add_master() and sdw_stream_add_slave() do not modify
> contents of passed sdw_port_config, so it can be made const for code
> safety and as documentation of expected usage.
> 
> 

Applied, thanks!

[1/1] soundwire: stream: constify sdw_port_config when adding devices
      commit: 21f4c443731fdb064c0dd31a743aafd0b075156c

Best regards,
-- 
~Vinod


