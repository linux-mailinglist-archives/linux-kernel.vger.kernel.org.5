Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 114738020D3
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Dec 2023 05:52:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233163AbjLCEwA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Dec 2023 23:52:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232971AbjLCEvt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Dec 2023 23:51:49 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E7EA198
        for <linux-kernel@vger.kernel.org>; Sat,  2 Dec 2023 20:51:49 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 640B5C433D9;
        Sun,  3 Dec 2023 04:51:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701579109;
        bh=/k3GHFIjLKIEJGyjTW6+pmhuxqAPdfix7jA0G957+Oc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VJBVSdpCYr4w+VT2ZZw9L9YjI1AnC9QkkD74+oyAt6lxQZQGtq7HW79iuSp+tZs+Q
         m3uucki5o931FGDbE7oyDQLJVadjdKpfYoOXDTzkqDXuyXOglfEYiZIVUkPK4DvqDZ
         eRzF79a3MGuypEza+a+M6ZQ1up28zDmQ7mCe6p83cWj+muQcjpscvlTXeyxbA+cxvj
         HxLWPnaE4hALBq+hlCO6H2mpPZyMpeefEXgycUEYKBnCSgwdb9qJJCsLW7fcW97dcY
         /b/Qvc11ix/btRbL5AKEgrqkV/rap1mdlwhOA9eBiUrA8KtF+/7wRnPu2jCD46SuCt
         iPaz0IiY+1hog==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Luca Weiss <luca.weiss@fairphone.com>
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 0/4] Add Fairphone 5 thermals (PMK7325, PM7250B, PM7325)
Date:   Sat,  2 Dec 2023 20:54:38 -0800
Message-ID: <170157925809.1717511.3113832457495825027.b4-ty@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231013-fp5-thermals-v1-0-f14df01922e6@fairphone.com>
References: <20231013-fp5-thermals-v1-0-f14df01922e6@fairphone.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 13 Oct 2023 10:09:52 +0200, Luca Weiss wrote:
> Configure the necessary components to register some thermal zones in
> Linux for the different thermistors found on the Fairphone 5.
> 
> The names for the thermal zones and ADCs were taken from the downstream
> kernel but double checked against hardware schematics.
> 
> 
> [...]

Applied, thanks!

[1/4] iio: adc: Add PM7325 PMIC7 ADC bindings
      commit: 18c74d56fe6070c7c38058d7b43ccf2102abebcd
[2/4] arm64: dts: qcom: qcm6490-fairphone-fp5: Add PM7250B thermals
      commit: 4c343fe9b68adeca1aa3a851bd06e62ecdaed180
[3/4] arm64: dts: qcom: qcm6490-fairphone-fp5: Add PMK7325 thermals
      commit: 46a2f77e1eb81990d303a94ab62f1bf79d0c9926
[4/4] arm64: dts: qcom: qcm6490-fairphone-fp5: Add PM7325 thermals
      commit: ae1122c375707a36c8fecebba745421a1e0ff93f

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
