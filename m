Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 270CF808E55
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 18:13:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443006AbjLGRCT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 12:02:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232933AbjLGRCS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 12:02:18 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4EB11703
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 09:02:24 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0221C433CB;
        Thu,  7 Dec 2023 17:02:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701968544;
        bh=Fb3OEJrH9btLg9K1FmUX1cmvE3pr36zNrQMZ9E7ShWA=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=SUXL88G2c/Hr8KQtofUGU+sEfTDuCefgTxtVpsw3sxg7UMDVFje98c8wewAHxL/rM
         XaKam7ipwURuIuhShSovT85YC04IHDxnCP+Z4w6Ul+WmiR8nNJf/3lPDaG8ysRFaTY
         XfjfPlTMET2MT4XokKp+MgpEfMoQXMLs6H2EWglGLJZXpnkIkitkP+1mOR6+NM2DCm
         Ju1BxETuX8y6xgiMPgWAhGiL9z8e+p6lDJ2eXDv4cFonnDoREdMDqQniScuwMG+AZh
         ekoDzo3xG9bgTD8BA/eSL26MMJqX6RXYgJcw0PJ3EbykKR0MB9l8pSipBqvv44Q92E
         PrmXlTKszeQDg==
From:   Lee Jones <lee@kernel.org>
To:     Lee Jones <lee@kernel.org>, Johan Hovold <johan+linaro@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
In-Reply-To: <20231206111754.7410-1-johan+linaro@kernel.org>
References: <20231206111754.7410-1-johan+linaro@kernel.org>
Subject: Re: [PATCH v3 0/4] dt-bindings: mfd: fix up PMIC examples
Message-Id: <170196854169.143088.10044379957904828667.b4-ty@kernel.org>
Date:   Thu, 07 Dec 2023 17:02:21 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 06 Dec 2023 12:17:50 +0100, Johan Hovold wrote:
> When reviewing the various SPMI PMIC bindings, I noticed that several
> examples were incorrect and misleading and could also use some cleanup.
> 
> This series addresses the mfd ones along with some related issues.
> 
> [ The PM8008 actually sits on an i2c bus but it is related to the other
>   Qualcomm SPMI PMICs. ]
> 
> [...]

Applied, thanks!

[1/4] dt-bindings: mfd: hisilicon,hi6421-spmi-pmic: fix up binding reference
      commit: e23f1530eab97e8d9dfbbdd9af3802c9c1e026a4
[2/4] dt-bindings: mfd: hisilicon,hi6421-spmi-pmic: fix regulator binding
      commit: d5c005ff9fe33dc7c2c3e13d1bdca698f441ac86
[3/4] dt-bindings: mfd: hisilicon,hi6421-spmi-pmic: clean up example
      commit: 1aa77a7ed020721c6c4a3da16ea3a970f2ce4eea
[4/4] dt-bindings: mfd: pm8008: clean up example node names
      commit: 7bb6a356ed6392c5e78e3d668055090970c1f9da

--
Lee Jones [李琼斯]

