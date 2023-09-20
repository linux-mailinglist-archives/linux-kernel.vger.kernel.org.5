Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBC167A714B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 05:55:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232770AbjITDzm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 23:55:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232618AbjITDzJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 23:55:09 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63EBDD8;
        Tue, 19 Sep 2023 20:55:02 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21922C433C8;
        Wed, 20 Sep 2023 03:55:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695182102;
        bh=hK596dJoYGTkHfI4ZSE6n+owN4RF4o588Yyi0Dx7eaE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kt+S8y63VXWaI18RPpLiQeJY/17QLLroNPlP6rcOgRZU23SaZZTrEDCAby1Rmgpuc
         NFABu7ro1DeB84S1DefZSK5Kw5GeVsFrwO036Nj3hiLk/WPe5wwVMIMv9lSDaZtrNn
         bdlPw96n5z8Xd66vNCyyE3DEpskITSgebjRGv6VOo+2BEkdfj5Sbh/DpUQtoHC+2uc
         ewsDPxxvlY2rbZAm6JPnztdL8FukPYwqXe4bVcWbuuvS5ExK73GPlDZvrzq79hBd8q
         DiBn3kPcFeqsUK9AAFkU9xMwfaa/UbPqt48J1TgkAvzeXMoBh/xq0y5YxYvvt4yaFU
         oHsqvEhMI8PRw==
From:   Bjorn Andersson <andersson@kernel.org>
To:     cros-qcom-dts-watchers@chromium.org,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Souradeep Chowdhury <quic_schowdhu@quicinc.com>
Subject: Re: [PATCH RFT v2] arm64: dts: qcom: sc7280: drop incorrect EUD port on SoC side
Date:   Tue, 19 Sep 2023 20:58:53 -0700
Message-ID: <169518233714.1055386.9339650924194822510.b4-ty@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230820075626.22600-1-krzysztof.kozlowski@linaro.org>
References: <20230820075626.22600-1-krzysztof.kozlowski@linaro.org>
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


On Sun, 20 Aug 2023 09:56:26 +0200, Krzysztof Kozlowski wrote:
> Qualcomm Embedded USB Debugger (EUD) second port should point to Type-C
> USB connector.  Such connector was defined directly in root node of
> sc7280.dtsi which is clearly wrong.  SC7280 is a chip, so physically it
> does not have USB Type-C port.  The connector is usually accessible
> through some USB switch or controller.
> 
> Doug Anderson said that he wasn't ever able to use EUD on Herobrine
> boards, probably because of invalid or missing DTS description - DTS is
> saying EUD is on usb_2 node, which is connected to a USB Hub, not to the
> Type-C port.
> 
> [...]

Applied, thanks!

[1/1] arm64: dts: qcom: sc7280: drop incorrect EUD port on SoC side
      commit: 39c8af78cbefb8c71a5ad1fa088e761ef418f0a0

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
