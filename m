Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18A0E7A7146
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 05:55:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232625AbjITDzh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 23:55:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232545AbjITDzG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 23:55:06 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45528DD;
        Tue, 19 Sep 2023 20:55:01 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EFCCC43397;
        Wed, 20 Sep 2023 03:55:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695182100;
        bh=zYeb75WtdFqsQ498+NDNEBkGhkVa81ZkDRsZUSt8gCo=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=QYeBhBhxR0iKfvAaDvKwSSE2p+COykJmWb0dsS2v3ifs7KX1qEv0O13VDs2DnTn91
         zoIL5EV5VxGJLeIhOub9KtbXEe/66DdAi+gvpYFi3N5BNZuZmtSVmJGhHwhCEIfN2/
         gW2EtRo4HosaOEMmEAE/Jix7LqNAHgEDQ24pYjDUkBvkV83g6HuNB3tZ9M8WnQA+0D
         xwh1WO19wJCVmyUHgIWIJ50ywPe0f/xTSUsm9gijrsBHz6JfOwmCJDFUEToqaG4qqn
         ydcoJy8V+AbqSqC8jDdS8MGWZD4Rs/Y279n2LYJFUiIdDYH46A7u+0JWzhg1m9wbpD
         ckSpIlSBNjCow==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Rohit Agarwal <quic_rohiagar@quicinc.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH] arm64: dts: qcom: sdx75-idp: align RPMh regulator nodes with bindings
Date:   Tue, 19 Sep 2023 20:58:52 -0700
Message-ID: <169518233726.1055386.45697761517790968.b4-ty@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230905163103.257412-1-krzysztof.kozlowski@linaro.org>
References: <20230905163103.257412-1-krzysztof.kozlowski@linaro.org>
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


On Tue, 05 Sep 2023 18:31:03 +0200, Krzysztof Kozlowski wrote:
> Device node names should be generic and bindings expect certain pattern
> for RPMh regulator nodes:
> 
>   sdx75-idp.dtb: rsc@17a00000: 'pmx75-rpmh-regulators' does not match any of the regexes: '^regulators(-[0-9])?$', 'pinctrl-[0-9]+'
> 
> 

Applied, thanks!

[1/1] arm64: dts: qcom: sdx75-idp: align RPMh regulator nodes with bindings
      commit: 815ea491460766dbd4b39a3c9904b44b5880c41c

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
