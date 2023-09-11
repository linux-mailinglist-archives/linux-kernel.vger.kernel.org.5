Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3ADA79BA02
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:10:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357724AbjIKWF5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 18:05:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243771AbjIKRmS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 13:42:18 -0400
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20809DD;
        Mon, 11 Sep 2023 10:42:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1694454122; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=N+TVBgIMChzsBZC3X8e8tF6LFurwrcV9H4sAi16wP5rwpYNDgx0cS8Ll+kVPQXwNne
    bomDRWC/Tk6yPye9riPSXcOnwJPrqAO87g/HTFxBMIJUstqb1Tp312sZxdi/asrrLKp8
    5lqbKgXjOl4C1sgoe5VvULGyOLTZljkM4lySYlC/mRABcuDBXYtXXHRUfA/TvbDwv3D8
    jRC6wqQ7v3ILJLrxFh+pruzedRp15Fr29tjB06FCuhellMpEqyciHtfiuLUAm2j77ScS
    I3IsNP0UhRp29+MG075qo+kyiJJedxmp1wivjS8oKDhFsyvdJZdHLqYrlWyiMmnIfMck
    loZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1694454122;
    s=strato-dkim-0002; d=strato.com;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=sj0xOwwGDhfTex5d/nIzyWMG4KtbTUJUlLMa7VStVX0=;
    b=mXvELaDCNUlDWrdjiJA24pnEkthpAbJIktMa/eoHwX9/XHLqmVDwQV60EkVV4gk2wB
    6YrQ1tFKllPwoleXksuRaKrS2JtfMOkVGPB9tIDeB728z+YocjtYT2/wGlTGXnmfmIrW
    VJfJjzUNyhw9heYpTksSy4qJ60jhcrm+CmIfJsLgms27hALnIMmwdGnNY4M3JjDAu+Jv
    jrCu+cvxdIN5Fd6RV0nblriK1oBIfkwTQoCucTX8275O1HX/UQ6Q8T2YNnEGpEL1TK8w
    WzDQcJdpzvxQsBIlDOrHRpeKG4/R8XfMzzylhgonyl4roZcfMrNMhmDxbUzmtEo3IfNg
    nJ0Q==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1694454122;
    s=strato-dkim-0002; d=gerhold.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=sj0xOwwGDhfTex5d/nIzyWMG4KtbTUJUlLMa7VStVX0=;
    b=dNoWz1K3EZ/2kh+w1mls3jZ6T0RTa3TacGvuHNBBF4o50lo7Kwon0Q6q5KOJsWLy4N
    dYkVkYKpYEMYp2uF2U6ZA1Inu+HQ6J07+6nqdHrz3n8EAmKZ3EJOVbUD7KsuTcPpMMru
    jfkNk5FnEliNBmYohb73hol8vC0klxOnU6xm4cdCYxyV0bfbiUMUXWeXEDMIBRlf1YxU
    +qibEhO6gBSUFgDWV9esdmlmfW+O76S19z0DcdGDENwQWuXkPCCLTAl5yJrwoyPzL6Df
    KwfuZ/r7JQrBy21AkYtTgQ8WJjnzJHOn4Dfh7cXhlCf7e5SHT6D5UCUIL8TTGTp18xmG
    eShg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1694454122;
    s=strato-dkim-0003; d=gerhold.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=sj0xOwwGDhfTex5d/nIzyWMG4KtbTUJUlLMa7VStVX0=;
    b=33/99UBYStpOUYO0vR8YtdjMeMV5KPgSsotHpIfo6I5ucD7cJjWCS5/g8Djy75DpyP
    90Gu13Gk/T2ajBEo7iAQ==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQjVd4CteZ/7jYgS+mLFY+H0JAn8u4l38TY="
Received: from [192.168.244.3]
    by smtp.strato.de (RZmta 49.8.2 DYNA|AUTH)
    with ESMTPSA id 60372az8BHg2awN
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Mon, 11 Sep 2023 19:42:02 +0200 (CEST)
From:   Stephan Gerhold <stephan@gerhold.net>
Date:   Mon, 11 Sep 2023 19:41:45 +0200
Subject: [PATCH 3/9] arm64: dts: qcom: msm8916-ufi: Drop gps_mem for now
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230911-msm8916-rmem-v1-3-b7089ec3e3a1@gerhold.net>
References: <20230911-msm8916-rmem-v1-0-b7089ec3e3a1@gerhold.net>
In-Reply-To: <20230911-msm8916-rmem-v1-0-b7089ec3e3a1@gerhold.net>
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

gps_mem is needed by the modem firmware for GPS to work. However, it is
accessed via QMI memshare [1] which is not available upstream yet.
Until it lands upstream reserving this does not provide any advantage.

[1]: https://lore.kernel.org/linux-arm-msm/20210319172321.22248-1-nikitos.tr@gmail.com/

Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
---
 arch/arm64/boot/dts/qcom/msm8916-ufi.dtsi | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8916-ufi.dtsi b/arch/arm64/boot/dts/qcom/msm8916-ufi.dtsi
index c759c0544dd9..69f268db4df9 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-ufi.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916-ufi.dtsi
@@ -22,11 +22,6 @@ mpss_mem: mpss@86800000 {
 			reg = <0x0 0x86800000 0x0 0x5500000>;
 			no-map;
 		};
-
-		gps_mem: gps@8bd00000 {
-			reg = <0x0 0x8bd00000 0x0 0x200000>;
-			no-map;
-		};
 	};
 
 	gpio-keys {

-- 
2.42.0

