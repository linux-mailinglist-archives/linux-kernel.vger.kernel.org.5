Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E1637792B9
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 17:18:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236323AbjHKPSH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 11:18:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236209AbjHKPSC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 11:18:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1912530C4;
        Fri, 11 Aug 2023 08:17:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A4C2267489;
        Fri, 11 Aug 2023 15:17:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52BA7C433C9;
        Fri, 11 Aug 2023 15:17:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691767073;
        bh=G82+yTsJCBhOpWsx9f3grwSqceli0aNSpPZReeQbCOs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dA3CEUX3ZkYGWcgG8v84yJe2O24jNHjapJKrk/yS11VhIwnTmvhdbx3WKixwcmQSc
         o5/sSVKIa+nS8ij3jyTEiwW/TUC2ZGRkjJFbmSsptTFRGESDNY6yp4Nn7RVxo6kp1F
         tEEPROab7KiWYVIG/41KxNQdlkTR9FeF5rgPcLRPYRVCJmWgXm7HSJIAoR0gSnYXP8
         A8LBe7k4k6e/cmzHArx+dblRvPquLLtVW7KhpyGVub4kYcv7ejmQ6ac8Q8hL4OLI89
         ar/XDu2QYPIWdQx0osuRuIsLzJaAqEv5Ao4wclKZoIUVRln11nWjceDY/ac9PVGIAy
         tKMAWYcaykQYw==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Eric Chanudet <echanude@redhat.com>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Caleb Connolly <caleb.connolly@linaro.org>
Subject: Re: [PATCH v3] arm64: dts: qcom: sa8540p-ride: enable rtc
Date:   Fri, 11 Aug 2023 08:20:40 -0700
Message-ID: <169176724023.691796.11632685615217512319.b4-ty@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809203506.1833205-1-echanude@redhat.com>
References: <20230809203506.1833205-1-echanude@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 09 Aug 2023 16:32:33 -0400, Eric Chanudet wrote:
> SA8540P-ride is one of the Qualcomm platforms that does not have access
> to UEFI runtime services and on which the RTC registers are read-only,
> as described in:
> https://lore.kernel.org/all/20230202155448.6715-1-johan+linaro@kernel.org/
> 
> Reserve four bytes in one of the PMIC registers to hold the RTC offset
> the same way as it was done for sc8280xp-crd which has similar
> limitations:
>     commit e67b45582c5e ("arm64: dts: qcom: sc8280xp-crd: enable rtc")
> 
> [...]

Applied, thanks!

[1/1] arm64: dts: qcom: sa8540p-ride: enable rtc
      commit: e85cbb34f3eabc27d6e77cfde6c9afbab3d70b4b

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
