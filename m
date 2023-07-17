Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE859756896
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 18:02:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230335AbjGQQCF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 12:02:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbjGQQCE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 12:02:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42B94F4
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 09:02:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D465461137
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 16:02:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 833F4C433C7;
        Mon, 17 Jul 2023 16:02:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689609722;
        bh=ffI63cg/wR9d3QTINg8TfUfPxuKNabP8/Vu78fgEiUY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=g+Liy6gVBUZf5t9h3Jx3jTQSesQczutO+BdrtqLZ+zRRF9ftMMyH103V1CeABi7tf
         55Ult7rd/Ck5MmQs8AzsJgENgLKbTd9kkidP9kSRxcdvlwXhGexeJHzG+VURZM4Bni
         OGp7fXRomSSZQZLQaNX7Rd2l16wJwM00tCG+KFdJSszVtLZKlN4NJz9dg5isU7iqo6
         bvTvVUolPSdVa9c747eGlCdCJ/mqndHs0PFqaHiwrx/+1+9j+ZOuEbWHW6DJkkfVvs
         JU7vZj33OOrzGPnUDUHjTUIAw8Ol2RYriWBpKwojCGgJYaP7R+2JP2RKJECTt6NVvc
         DSMnXWA9xy1OA==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Bjorn Andersson <quic_bjorande@quicinc.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [RESEND PATCH v2] arm64: defconfig: enable the SerDes PHY for Qualcomm DWMAC
Date:   Mon, 17 Jul 2023 09:05:27 -0700
Message-ID: <168960992486.1855614.16469942974128541322.b4-ty@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230622121141.218623-1-brgl@bgdev.pl>
References: <20230622121141.218623-1-brgl@bgdev.pl>
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


On Thu, 22 Jun 2023 14:11:41 +0200, Bartosz Golaszewski wrote:
> Enable the SGMII/SerDes PHY driver. This module is required to enable
> ethernet on sa8775p platforms.
> 
> 

Applied, thanks!

[1/1] arm64: defconfig: enable the SerDes PHY for Qualcomm DWMAC
      commit: a43274be0eb773851f9e3d987e48495b258c79e6

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
