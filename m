Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30F4579BF36
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:18:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347388AbjIKVYm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 17:24:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237909AbjIKNUr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 09:20:47 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D330DEB;
        Mon, 11 Sep 2023 06:20:42 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C4B6C433C7;
        Mon, 11 Sep 2023 13:20:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694438442;
        bh=seMOI04xQEN5HPAT6ZDe8j6wf/v6pSJLVXaemNCMKpw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=c6CgCk98+gX+mNjA5/yzdOmfddIZBXvZOxW6AV+Ks9Si+CT9d6gCysPmZ2eBUSsJr
         u6b77NmbTEHSjr8vKXluhcRO+JFWyoh4AiJQwTDnAfu0GEGpmKtJUlEie0QGhtYhl8
         xlErWIkB2Wgi9YA4DeVfN4IbBS4NWiLeFBMWi/mvIlpksa8rj0NzhEq4Nxt3sHc2I1
         4e+PhL+de+4voulGPW+vae+PDwQM+8qtU+yCK9BylqsrSw1JkxdbC9ZLPvOi0XiFSc
         +pHzRca5IqO4ZiFhC/HWs9OV71AZxwax2LY413J9VN51BEnHPhy+sgQhLVe89y4zCz
         91sjieKQNjJ1A==
Received: (nullmailer pid 1144444 invoked by uid 1000);
        Mon, 11 Sep 2023 13:20:40 -0000
Date:   Mon, 11 Sep 2023 08:20:40 -0500
From:   Rob Herring <robh@kernel.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Prasad Sodagudi <psodagud@quicinc.com>,
        Nikunj Kela <nkela@quicinc.com>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Viresh Kumar <vireshk@kernel.org>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        linux-kernel@vger.kernel.org, Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH v3 09/13] dt-bindings: firmware: arm,scmi: Extend
 bindings for protocol@13
Message-ID: <169443843853.1144377.15550246606474574952.robh@kernel.org>
References: <20230825112633.236607-1-ulf.hansson@linaro.org>
 <20230825112633.236607-10-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230825112633.236607-10-ulf.hansson@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 25 Aug 2023 13:26:29 +0200, Ulf Hansson wrote:
> The protocol@13 node is describing the performance scaling option for the
> ARM SCMI interface, as a clock provider. This is unnecessary limiting, as
> performance scaling is in many cases not limited to switching a clock's
> frequency.
> 
> Therefore, let's extend the binding so the interface can be modelled as a
> generic performance domain too. The common way to describe this, is to use
> the power-domain DT bindings, so let's use that.
> 
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
> Cc: Conor Dooley <conor+dt@kernel.org>
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
> 
> Changes in v3:
> 	- None.
> 
> ---
>  .../devicetree/bindings/firmware/arm,scmi.yaml        | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

