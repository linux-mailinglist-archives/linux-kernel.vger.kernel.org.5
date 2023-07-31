Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 180C976A520
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 01:50:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232022AbjGaXuJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 19:50:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231903AbjGaXt6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 19:49:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 625CC170D;
        Mon, 31 Jul 2023 16:49:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 341F16135A;
        Mon, 31 Jul 2023 23:49:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2F2BC433C7;
        Mon, 31 Jul 2023 23:49:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690847387;
        bh=Q6oelgC8jKgNI/h/bkUK7XNUbBy7e2PwN4KKsfMGqac=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ayzd2Vg6eY5qgVVFxcAuhroPaVPGEcS0Bv5RcQb4O7+eBhf/C4hVLyp4zPv4ZJuMZ
         pgurKIHcjzQwL8V/qdJBwswXdKaxD4gjX4+rwUvJZk+llG76+rUvsUFTz4krLDWOxU
         mi1MZbBpjrwGYPGdn+s8/kbUvUVeOq29TEqsNVsm9xfO17S1ctG4OhOkJiuTcuMWFH
         fsy3FqCilB7Q48a5yss1xL5iGz5PGAehSP0er/h2CH2Xfa8PLiI3cTeneBopN60s47
         Zh1uJeRrLVaAVGvCjuiXD5bWAXdrKPAAHG8chgq2qdH+uxYbWMqzmYzoES2iGFVdYn
         4gu99+4clMsTQ==
From:   Bjorn Andersson <andersson@kernel.org>
To:     agross@kernel.org, konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        Rohit Agarwal <quic_rohiagar@quicinc.com>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/2] Add rpmhpd support for SDX75
Date:   Mon, 31 Jul 2023 16:52:45 -0700
Message-ID: <169084756378.3010488.13325717224618131355.b4-ty@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <1690803007-8640-1-git-send-email-quic_rohiagar@quicinc.com>
References: <1690803007-8640-1-git-send-email-quic_rohiagar@quicinc.com>
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


On Mon, 31 Jul 2023 17:00:05 +0530, Rohit Agarwal wrote:
> Changes in v4:
>  - Moved the generic bindings patch to a separate series [4].
>  - Corrected the subject of dt-bindings patch.
> 
> Changes in v3:
>  - Removed the macros from rpmpd.h and created new generic
>    bindings in patch [1/3] for rpmhpd only.
>  - Corrected the versioning in this version of patch series.
>  - Updated the patch series subject.
>  - Updated the drivers change according to the new binding in
>    patch [3/3]
> 
> [...]

Applied, thanks!

[1/2] dt-bindings: power: qcom,rpmpd: Add compatible for sdx75
      commit: 0b9d94e1f19acd19613386096d924af2333b620a
[2/2] soc: qcom: rpmhpd: Add SDX75 power domains
      commit: 668e08c2e7b02124da573e29a67e013627ebf9ea

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
