Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 419717788FD
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 10:30:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234474AbjHKIap (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 04:30:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234473AbjHKIan (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 04:30:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 631D92D44;
        Fri, 11 Aug 2023 01:30:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ECE1F6615F;
        Fri, 11 Aug 2023 08:30:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C4C4C433C7;
        Fri, 11 Aug 2023 08:30:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691742639;
        bh=2rCSNftBj2l3sZobEVt9yAKRPfz2ibaoTTFNCHd526U=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=Fxip8SEP1vpDph1cm3Fq2T3ftEhCQZ2yuT7C+4+7deD4btOXlzOnNQ95IsoFnsBht
         EDrAfTWelyH9mmkndPwVTee5spDWFZVeetQnn57dozUR+GKbHv++WcA414160Qye9A
         K2hzNefIgHBQtYg8XMUdWOyuDfXcl8xdEEzlGVdpNxqq/S0ZydPE9WR5bOG5fsXWXC
         3QHhHIYhPLjemh2actuvaZ9Q71hqvPC0pPM0CtXq3QEL3cykOhSyLmnGgMTsVK0shX
         DNGsOWHZFJ8HWkihqndi4D93tzH9YTcsmN7AfALL1agRYRYZcyD9e5XmhEdReOoGDF
         OeIJ4+gy3JvcQ==
From:   Vinod Koul <vkoul@kernel.org>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        kishon@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        abel.vesa@linaro.org, Rohit Agarwal <quic_rohiagar@quicinc.com>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org
In-Reply-To: <1691415534-31820-1-git-send-email-quic_rohiagar@quicinc.com>
References: <1691415534-31820-1-git-send-email-quic_rohiagar@quicinc.com>
Subject: Re: (subset) [PATCH RESEND v2 0/9] Add pmics supported in
 Qualcomm's SDX75 platform
Message-Id: <169174263722.106197.4875571006403929155.b4-ty@kernel.org>
Date:   Fri, 11 Aug 2023 09:30:37 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 07 Aug 2023 19:08:45 +0530, Rohit Agarwal wrote:
> Changes in v2:
>  - Added compatible for pm7550ba for eusb2 repeater and used it in DT.
>  - Addressed some minor comments from Konrad to add fixes tag, labels
>    and update the labels
> 
> This series add support of pmics that are found in SDX75 platform and
> add the corresponding regulators in the IDP platform as well.
> It also parallely updates the pmic found in SDX65 to PM7250b and add pinctrl
> support for the same pmic chip.
> This series is based on the new header inclusion[1] and movement of the
> regulators level from rpmpd to rpmhpd[2].
> This series can be picked after successfully picking [2] and [3] as [1] has
> already been applied.
> 
> [...]

Applied, thanks!

[1/9] dt-bindings: phy: qcom,snps-eusb2-repeater: Add compatible for PM7550BA
      commit: aff7625322ceaf32c930ebf43c75db442067a88d

Best regards,
-- 
~Vinod


