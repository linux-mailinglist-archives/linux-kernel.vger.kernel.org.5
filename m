Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1F3A753174
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 07:45:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234966AbjGNFph (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 01:45:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233976AbjGNFp1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 01:45:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F2322735;
        Thu, 13 Jul 2023 22:45:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C8E6C61C18;
        Fri, 14 Jul 2023 05:45:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 858F2C433C8;
        Fri, 14 Jul 2023 05:45:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689313526;
        bh=qnFCU2M7mxpf4fLSHykrtLGzoHTQms/TXEwosDAhPl0=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=ei7e5UTTbZDxWJd2Xc06dWv3wYGBMY5HDtXkJikgRTy2C/OZOb72RWXG2v/oTNV8p
         jAswcL7id1FRAdZv5mA8IxG/Qw1HOMoJAqkX26NhCpHfiwK34BLqpSDVSiG27Q3qY2
         HiUzyMa+hk4NLYU12J97Uns0dDkJmFVtbVvqS0d/sujr0RlZRMGlH+UL/VOJV3X+DE
         71d2MYtxRJ/b0Vt9wW1DZgn6Ao5HxjyWWiXDKqbWKYO8ZOk16uhqvzk2ctdPaYFLSe
         U7qQ1kIJ5jhptw1+OSyJZVoILzIu3+ys6ppt9rjghk+L/2ZSI1pJkgXeZpo7xyF1c1
         007twPH+h9INw==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [RFT PATCH] arm64: dts: qcom: sdm850-c630: add missing panel supply
Date:   Thu, 13 Jul 2023 22:48:53 -0700
Message-ID: <168931373090.1571673.5019531971615708837.b4-ty@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230617171512.286795-1-krzysztof.kozlowski@linaro.org>
References: <20230617171512.286795-1-krzysztof.kozlowski@linaro.org>
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


On Sat, 17 Jun 2023 19:15:12 +0200, Krzysztof Kozlowski wrote:
> Panel bindings (boe,nv133fhm-n61) require supply which here actually can
> be turned on/off via GPIO control:
> 
>   sdm850-lenovo-yoga-c630.dtb: panel: 'power-supply' is a required property
> 
> 

Applied, thanks!

[1/1] arm64: dts: qcom: sdm850-c630: add missing panel supply
      commit: 6b0fd355e9572f4db52880e63e0bc74a2a3bfd84

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
