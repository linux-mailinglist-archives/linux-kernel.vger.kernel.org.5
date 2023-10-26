Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 937F77D7A7E
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 03:53:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233132AbjJZBwH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 21:52:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229954AbjJZBwG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 21:52:06 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8997ABD;
        Wed, 25 Oct 2023 18:52:04 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16ECBC433C7;
        Thu, 26 Oct 2023 01:52:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698285124;
        bh=uc68CtG1/PmB2c3+G1qYkLU0G3yZyhKP0af8C+0vViw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lxmqelvna5njSYvzoA0nLw61ngRwVaDSkKEMmQ31gysV354IuujhdYvsfxgjZQRtf
         rQlsRWasYHtpjz1feinFQgQQGMzFv59do8v+sZGdHUjZJDQlyDQDLD4zdxmSAwYy0a
         gmHmJaN7WuqWWVSLu4BIsRWvG6Grvp+2URDHBTsrcPbbcJnYRuWe3TnBPnrSfdDkfw
         VEFT7ueeYf6/o5ln6/chIw8khcNno85bjI+0oTCoTfdcnA3/Gv6CEToqIOYdjo8XD8
         fVRimjDudHv3U5/qZyjupXEi72XJh4aSjE7k9CmN3HvAbOY3O8/X9oykpCeet0SK8Z
         NNcn8qoXT4WnQ==
Date:   Wed, 25 Oct 2023 18:56:21 -0700
From:   Bjorn Andersson <andersson@kernel.org>
To:     Sibi Sankar <quic_sibis@quicinc.com>
Cc:     konrad.dybcio@linaro.org, linus.walleij@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        agross@kernel.org, conor+dt@kernel.org, quic_rjendra@quicinc.com,
        abel.vesa@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, quic_tsoni@quicinc.com,
        neil.armstrong@linaro.org
Subject: Re: [PATCH 0/2] pinctrl: qcom: Introduce Pinctrl/GPIO for SC8380XP
Message-ID: <faddmpsixivh3rfbsyvwpkt3mjaempkfdzqws2xjxlyhs5m5pm@7ss2k77rlryk>
References: <20231025135058.11268-1-quic_sibis@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231025135058.11268-1-quic_sibis@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 25, 2023 at 07:20:56PM +0530, Sibi Sankar wrote:
> This series adds pinctrl/gpio support for the Qualcomm SC8380XP platform, aka Snapdragon X Elite.
> 
> Release Link: https://www.qualcomm.com/news/releases/2023/10/qualcomm-unleashes-snapdragon-x-elite--the-ai-super-charged-plat
> 

Reviewed-by: Bjorn Andersson <andersson@kernel.org>

Regards,
Bjorn

> Rajendra Nayak (2):
>   dt-bindings: pinctrl: qcom: Add SC8380XP pinctrl
>   pinctrl: qcom: Add SC8380XP pinctrl driver
> 
>  .../bindings/pinctrl/qcom,sc8380xp-tlmm.yaml  |  143 ++
>  drivers/pinctrl/qcom/Kconfig.msm              |   10 +
>  drivers/pinctrl/qcom/Makefile                 |    1 +
>  drivers/pinctrl/qcom/pinctrl-sc8380xp.c       | 1876 +++++++++++++++++
>  4 files changed, 2030 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pinctrl/qcom,sc8380xp-tlmm.yaml
>  create mode 100644 drivers/pinctrl/qcom/pinctrl-sc8380xp.c
> 
> -- 
> 2.17.1
> 
