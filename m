Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 052BB7A702B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 04:10:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231911AbjITCKE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 22:10:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231840AbjITCKC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 22:10:02 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D556BE;
        Tue, 19 Sep 2023 19:09:57 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2ED8CC433CD;
        Wed, 20 Sep 2023 02:09:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695175797;
        bh=X231F0W4UNjrve3JRnUM4cCtW/rxv8gXIFxjWMkm1Yw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=c5BR//i5gD2qkTtwKeEJrlvf7gPrylBzHrbXB2qeguKAO/fEhtc221UyK3wSlu6kB
         OH4ZX0ain5DaFpJnhe3dDNBQnpJdRtzRcuVHcfmMPUmirvRXGRWdo/rAmevd3V4wsw
         oWgXQ7Zm4tzaj2RxAOZcYtAqNMYTOKEPTu92QKMWCBEux5aHAYfcX52DNClYJ+GYjD
         7nekmamYzI7+Lj3Zt/K4eaiRGnd8nuCE42twU5YYnolgn8RIHGW+oCsWdJKBzkO7I/
         wDIpIdDbc9G+HKJeE3R9fkd9e8RXVkrTDDWqKZnsMi3AFZrOE54ZbaTtNQ6hzPvhtC
         qpI+fo1Hu5zjQ==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Sheng-Liang Pan <sheng-liang.pan@quanta.corp-partner.google.com>,
        Andy Gross <agross@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        cros-qcom-dts-watchers@chromium.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH 1/2] arm64: dts: qcom: sc7180: Move trogdor rt5682s bits to a fragment
Date:   Tue, 19 Sep 2023 19:13:57 -0700
Message-ID: <169517603992.822793.4084645192755492251.b4-ty@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230816112143.1.I7227efd47e0dc42b6ff243bd22aa1a3e01923220@changeid>
References: <20230816112143.1.I7227efd47e0dc42b6ff243bd22aa1a3e01923220@changeid>
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


On Wed, 16 Aug 2023 11:21:53 -0700, Douglas Anderson wrote:
> Several trogdor boards have moved from the older rt5862i to the newer
> rt5862s, at least on newer revisions of boards. Let's get rid of the
> dts duplication across boards and promote this to a fragment.
> 
> Note: The old boards used to override the "compatible" in the "sound"
> node with the exact same thing that was in "sc7180-trogdor.dtsi"
> ("google,sc7180-trogdor"). I got rid of that.
> 
> [...]

Applied, thanks!

[1/2] arm64: dts: qcom: sc7180: Move trogdor rt5682s bits to a fragment
      commit: 8ff1aaba032dd00e71aadeafa0ef2f79d3693c99
[2/2] arm64: dts: qcom: sc7180: Reorganize trogdor rt5682 audio codec dts
      commit: 214945cbf375cc27d684f4cd2abb569e8c888688

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
