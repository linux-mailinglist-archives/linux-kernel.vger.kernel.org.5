Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0A1779B739
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:06:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232529AbjIKUuZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 16:50:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240263AbjIKOkH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 10:40:07 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51923F2;
        Mon, 11 Sep 2023 07:40:03 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 454B4C433CA;
        Mon, 11 Sep 2023 14:40:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694443202;
        bh=DKDQNU6tGRi8sqGEa4X/qoKAhcLxWCiDCTvQUiCtuOQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=s01dUBoxSuA/IqEzYivkzVp7cU0o6cNSnMdU+HHL08ujd8Ub3zhnPjUQi9s2Q1RSl
         iWqjPL9DNYVWmFOjLtA9Jqt7v5gloFFRvpiWwX+LKhdvutwcEv3/STbUyIfyPwuM7u
         /s0pUFGzJwzncPpvu42C1OpYaw/rDWFufFKTrBvWYlj1hBoCzgiogiY1T5Fwt+59vi
         SBuqiKTytPjDA2StFG2a0Cb8rIIQR2A+fuD8Jo6QD6IjALkWHcoTTl4MyFDaT2Kdbc
         8kzsXeYbSFxFjH2oAStVfYcntjpyxw+y2jgXTZuDTd8oQ49qUwJgip+2DtGaz4uexe
         3tsf+vgjhKSQQ==
Received: (nullmailer pid 1226648 invoked by uid 1000);
        Mon, 11 Sep 2023 14:40:00 -0000
Date:   Mon, 11 Sep 2023 09:40:00 -0500
From:   Rob Herring <robh@kernel.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Kevin Hilman <khilman@kernel.org>, devicetree@vger.kernel.org,
        Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>, linux-pm@vger.kernel.org,
        Conor Dooley <conor+dt@kernel.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Cristian Marussi <cristian.marussi@arm.com>,
        Nikunj Kela <nkela@quicinc.com>,
        Prasad Sodagudi <psodagud@quicinc.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [PATCH v3 10/13] dt-bindings: power: Clarify performance
 capabilities of power-domains
Message-ID: <169444319926.1226593.2342724672076403322.robh@kernel.org>
References: <20230825112633.236607-1-ulf.hansson@linaro.org>
 <20230825112633.236607-11-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230825112633.236607-11-ulf.hansson@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 25 Aug 2023 13:26:30 +0200, Ulf Hansson wrote:
> The power-domains bindings has in many years been used to describe so
> called performance-domains too. Rather than using a separate binding it has
> been convenient to re-use the power-domain bindings, as in some cases it's
> in fact a combination of the both that would be the best description.
> 
> Therefore, let's make it more clear that the power-domains bindings can be
> used to describe a performance-domain too.
> 
> Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
> Cc: Kevin Hilman <khilman@kernel.org>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
> Cc: Conor Dooley <conor+dt@kernel.org>
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
> 
> Changes in v3:
> 	- New patch.
> 
> ---
>  .../devicetree/bindings/power/power-domain.yaml | 17 +++++++++--------
>  1 file changed, 9 insertions(+), 8 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

