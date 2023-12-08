Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD9708099E6
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 03:54:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573037AbjLHCyq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 21:54:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573081AbjLHCxw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 21:53:52 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 200D81BFD
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 18:53:43 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB756C43395;
        Fri,  8 Dec 2023 02:53:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702004022;
        bh=pysi8htMunee7u1NPHdnoL40w2QhPb/UHl0xep3gWU8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CzE4EsGvOarFmf/sIMpkUiaXOg1IWrsiAo7wAUEBwi+QtVLSNyqWxwQKr+Ngp3JSp
         czKmGjFMzTdsT+1Ooxt6rTyvYdM5agqFurmM7KZesdmaLDXP7fQ1b6XjYzqGOcUm18
         7FETakOm+HQH4F5to+gW7expKybUjTo3Mwb5u5ypCnRMy/Fdg+i5gVhHcS9g3y+UGZ
         AoGSDYJpGkNPHWvQQGjcNK4pNABgyLew53WdEs53RPXRNaqmyMd+luW9KGvynyo0IB
         70ojT/hxGR5rhKysG7SNV10xnK7V3S45AjD2x23b3l5FZuPW4YFrhuNyjmBUY/WCAn
         /aD5Gt6+w7Abw==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Imran Shaik <quic_imrashai@quicinc.com>
Cc:     Taniya Das <quic_tdas@quicinc.com>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        Ajit Pandey <quic_ajipan@quicinc.com>,
        Jagadeesh Kona <quic_jkona@quicinc.com>
Subject: Re: (subset) [PATCH V5 0/4] Add support for Qualcomm ECPRI clock controller
Date:   Thu,  7 Dec 2023 18:57:46 -0800
Message-ID: <170200426932.2871025.11902995660815720558.b4-ty@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231123064735.2979802-1-quic_imrashai@quicinc.com>
References: <20231123064735.2979802-1-quic_imrashai@quicinc.com>
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


On Thu, 23 Nov 2023 12:17:31 +0530, Imran Shaik wrote:
> The ECPRI clock controller support for QDU1000 and QRU1000. The clock
> controller has a special branch which requires an additional memory to
> be enabled/disabled before the branch ops.
> 
> Changes since v4:
>  - Aligned the lines as per the review comments
>  - Used the clk_hw_get_name implicitly in WARN as per the review comments
> 
> [...]

Applied, thanks!

[4/4] arm64: dts: qcom: qdu1000: Add ECPRI clock controller
      commit: 66ec7b4f471300003c13b87a99bbd55255da5ba9

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
