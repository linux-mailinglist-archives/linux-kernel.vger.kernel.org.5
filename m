Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F0388099E3
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 03:54:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573211AbjLHCyi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 21:54:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573087AbjLHCxn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 21:53:43 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E06741BF3
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 18:53:41 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B748BC433C8;
        Fri,  8 Dec 2023 02:53:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702004021;
        bh=ZjBph3S+MouDonqSk4JFIDw5YNr4/TApy2qSl27sTdM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jnmZlhJmhjrjXxFGbj59agG52p/57d76SbviKFXgM2QKUwooRXyGzCMSvnQmHckDX
         oelAWkOXXqpFb+/+YkUTn7/3XhpRybr9SIbZodIif+0C2LOsxtIINpxGgh5E6Fze8A
         tKSd8CYiUE0TUOSr3TQF0/wpbW7Pxa90dUe2SFIuHdaPn2qiFQ8Wep8ubuPIuZs7GQ
         X5pwead9A18y/onSNAfwqTzzcp8smT3ZX2f+9BJjg2yYLTkVUnXRcdZu9bH1N/DCkK
         BGR3QGPifCSvT7ItXMiu7YQuZN5sWrEM0GuOJqZ6kiqwcU4n3yAXn9NYccTqcalpP3
         zFZUNWI4Ped8g==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Nikita Travkin <nikita@trvn.ru>
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH v4 0/3] pm8916: Add BMS and charger
Date:   Thu,  7 Dec 2023 18:57:45 -0800
Message-ID: <170200426930.2871025.3838394626757670176.b4-ty@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231120-pm8916-dtsi-bms-lbc-v4-0-4f91056c8252@trvn.ru>
References: <20231120-pm8916-dtsi-bms-lbc-v4-0-4f91056c8252@trvn.ru>
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


On Mon, 20 Nov 2023 19:03:02 +0500, Nikita Travkin wrote:
> This series enables VM-BMS and LBC blocks in the pm8916 pmic.
> 
> The VM-BMS is a simple voltage monitoring block that allows the software
> to estimate the battery capacity left.
> 
> The LBC is a linear battery charger for lipo batteries.
> 
> [...]

Applied, thanks!

[2/3] arm64: dts: qcom: pm8916: Add BMS and charger
      commit: 26b87a3dc3337315c9834aa94e01da7030ec2e6c
[3/3] arm64: dts: qcom: msm8916-longcheer-l8150: Add battery and charger
      commit: 12fbe58560d6f974339cc30e44c0c5452db331da

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
