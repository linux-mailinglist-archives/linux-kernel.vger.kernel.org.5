Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AF217A8B48
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 20:11:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229697AbjITSLg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 14:11:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbjITSLc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 14:11:32 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7747EDC;
        Wed, 20 Sep 2023 11:11:26 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25F7EC433C9;
        Wed, 20 Sep 2023 18:11:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695233486;
        bh=be+zabTmXv7/l62mTC5GSeWFLNg/+okcaQ3h+uUJUak=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AyeqsFYv6R8k3NLlcKeUEYtc2FOgiAQ8pMnEC6CmtXRV4cFGQQJLLPq33iKrKn7MX
         lYgQghffm/VK6RxzMsVWao4LkTvY7h8HJXE3wajd0T65UXwGm73qSwJJGU7pvCPPt6
         LAEt/1iC9fBvxqNCOee+87uxZxYuXyknO4voj8X9Fuxr9erL1oVcLJ/cD5pef6pJd6
         ZDW6cuec2cwdFfGJZekxff3kXUKGdgaTOFIw9KEzRT4my0TCKFbpxchndnMPnrADQ7
         gF5Y7WhFZjG7E9u/tfSercr5NZcKbCnCiaANgUukonkaVQU+V0KA16oAi983XNre8r
         vCKW9WCyujEmw==
From:   Bjorn Andersson <andersson@kernel.org>
To:     agross@kernel.org, konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        quic_gurus@quicinc.com, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_mojha@quicinc.com, Robert Marko <robimarko@gmail.com>
Cc:     computersforpeace@gmail.com
Subject: Re: (subset) [PATCH v3 1/4] dt-bindings: firmware: qcom,scm: support indicating SDI default state
Date:   Wed, 20 Sep 2023 11:15:31 -0700
Message-ID: <169523372601.2994310.13795981750540613883.b4-ty@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230816164641.3371878-1-robimarko@gmail.com>
References: <20230816164641.3371878-1-robimarko@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 16 Aug 2023 18:45:38 +0200, Robert Marko wrote:
> IPQ5018 has SDI (Secure Debug Image) enabled by TZ by default, and that
> means that WDT being asserted or just trying to reboot will hang the board
> in the debug mode and only pulling the power and repowering will help.
> Some IPQ4019 boards like Google WiFI have it enabled as well.
> 
> So, lets add a boolean property to indicate that SDI is enabled by default
> and thus needs to be disabled by the kernel.
> 
> [...]

Applied, thanks!

[4/4] arm64: dts: qcom: ipq5018: indicate that SDI should be disabled
      commit: 79796e87215db9587d6c66ec6f6781e091bc6464

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
