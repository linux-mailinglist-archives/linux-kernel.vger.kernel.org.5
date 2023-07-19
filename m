Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BECA4758BF1
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 05:18:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229831AbjGSDSb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 23:18:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbjGSDS2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 23:18:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE28E1BDB;
        Tue, 18 Jul 2023 20:18:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7DA506162D;
        Wed, 19 Jul 2023 03:18:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2C97C433C8;
        Wed, 19 Jul 2023 03:18:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689736706;
        bh=37tXsPKuHMdcUXhiGXZghHeu9H0sEeSJBg+bUoVfEKY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fFpCuIG2p0E3FlyfIcqZxf53Kfxa4PgIffOfzQKgucSlv6fXyjDUJw2u+8mS0z8Nf
         LZ2EtuJPpXQBvelsQe0wwdEineMCOQ5gsFbE4dDqUGB/PWbEJeou473lknmq+dzt+S
         rqS/mCrFDJKYcEisoZ8lPaqQQAEe0DK6I9XIfFd4WaZu25OkcrEl3Z29kxbBMmoBiA
         IRPI0Rh2Ve1+ffGhs5ldHp6NHflemw1xW+MRnGUCQcZEqRZQolAB0E9K625mVmjXFs
         6RTIeEQ6Pv13Zy5yzqxnoc9MYFq1FxITuBXMzlrhREY/n8tBGbmSVb6gKkK6jwGY8P
         +wF5jZ7NWge3g==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Christian Marangi <ansuelsmth@gmail.com>
Cc:     stable@vger.kernel.org
Subject: Re: [PATCH] hwspinlock: qcom: add missing regmap config for SFPB MMIO implementation
Date:   Tue, 18 Jul 2023 20:21:48 -0700
Message-ID: <168973689569.3446802.8548756605942770542.b4-ty@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716022804.21239-1-ansuelsmth@gmail.com>
References: <20230716022804.21239-1-ansuelsmth@gmail.com>
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


On Sun, 16 Jul 2023 04:28:04 +0200, Christian Marangi wrote:
> Commit 5d4753f741d8 ("hwspinlock: qcom: add support for MMIO on older
> SoCs") introduced and made regmap_config mandatory in the of_data struct
> but didn't add the regmap_config for sfpb based devices.
> 
> SFPB based devices can both use the legacy syscon way to probe or the
> new MMIO way and currently device that use the MMIO way are broken as
> they lack the definition of the now required regmap_config and always
> return -EINVAL (and indirectly makes fail probing everything that
> depends on it, smem, nandc with smem-parser...)
> 
> [...]

Applied, thanks!

[1/1] hwspinlock: qcom: add missing regmap config for SFPB MMIO implementation
      commit: 23316be8a9d450f33a21f1efe7d89570becbec58

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
