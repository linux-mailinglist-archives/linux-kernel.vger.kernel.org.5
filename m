Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 883E079BE0D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:16:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238835AbjIKUyY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 16:54:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237904AbjIKNU3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 09:20:29 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C90BCDD;
        Mon, 11 Sep 2023 06:20:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 852E1C433C7;
        Mon, 11 Sep 2023 13:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694438425;
        bh=gi5WDftDnANuY2jvvurSwZOUwv+r2i5vxgU8ztY6ZHA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aAJIo3i5lasHJSct1CH3i3CG7WjtxBCc7+eFPlr41IYwLHYZJk/FKUmhpBrCPtdqw
         Zv+aKiUmu3mXT//J3CUJu3vtVXRilmolqcbZe+LYsviTQX5NF9t9jl0OnpJ/q5OAFp
         qZbjQPjgrDvoo3ac2q28gbU0gSgWqlG7h5uBw6Cx4gDq/yNSjZL8ogtVW0NsGjjlOh
         uX1JFn109Y2BoHTFwaGYnrFXA6bJhDiqAFA3gqjW2BM9M0F6RCnqi4nqhm1F8OW+Qs
         w3npimuN1dpoi0E4ryuPnqbZ25j4La8hZawU/kUtlIKoyn8etLpVyqPnVpscalMS7Z
         hgbBMSPWE4O1A==
Received: (nullmailer pid 1144054 invoked by uid 1000);
        Mon, 11 Sep 2023 13:20:22 -0000
Date:   Mon, 11 Sep 2023 08:20:22 -0500
From:   Rob Herring <robh@kernel.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        devicetree@vger.kernel.org,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Prasad Sodagudi <psodagud@quicinc.com>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Nikunj Kela <nkela@quicinc.com>, Nishanth Menon <nm@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 08/13] dt-bindings: arm: cpus: Add a power-domain-name
 for a performance-domain
Message-ID: <169443841534.1143854.8978305160265987211.robh@kernel.org>
References: <20230825112633.236607-1-ulf.hansson@linaro.org>
 <20230825112633.236607-9-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230825112633.236607-9-ulf.hansson@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 25 Aug 2023 13:26:28 +0200, Ulf Hansson wrote:
> When an CPU's performance domain is managed through the SCMI firmware,
> let's enable us describe this as a consumer of a power-domain provider,
> which is the de-facto standard to use for performance domains. In this
> case, let's specify a corresponding power-domain-name, to point out the
> corresponding index for it.
> 
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
> Cc: Conor Dooley <conor+dt@kernel.org>
> Cc: devicetree@vger.kernel.org
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
> 
> Changes in v3:
> 	- New patch.
> 
> ---
>  Documentation/devicetree/bindings/arm/cpus.yaml | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

