Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58F2475DA23
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 07:15:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231530AbjGVFPG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jul 2023 01:15:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231336AbjGVFOY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jul 2023 01:14:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E19743AAD;
        Fri, 21 Jul 2023 22:14:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5CCF060AF9;
        Sat, 22 Jul 2023 05:14:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20E1CC433CD;
        Sat, 22 Jul 2023 05:14:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690002861;
        bh=KLChOWaNNBfyhZKoU9get3FXK14FS1go/56lRC2PXM4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JHWqveoXzCIl33i2pjiW5IFKyUnB0Uwst/sAeUy/zSaRKz6qjh9IBr9Xq6q4wELHI
         mcR3Nt7OPKpDO1Q9uubl6Arpdc/wlNmPs+8j7lB4KZUDu0UyiQItuYQf9qJ7fycgEA
         066fpNxvNisPekqumeaqPPVGTKLGRObg6w9bRjffI5HNN5N4e+D5vCZc85OAZAVQwN
         /MMHJbK4vs8/Grc4TQAqw248P8rALe7pZDV67cUM5wy005H5x5GrM4aZOxlyVfwkl2
         Q31w8xR2MSWfxV8ro0TDKzh0kqMhFv38SJYaCsahgnHNTgt7bufpGCMqFbYbdr8rmI
         ViHGOOoZE57pg==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Bjorn Andersson <quic_bjorande@quicinc.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: sc8180x: Fix LLCC reg property
Date:   Fri, 21 Jul 2023 22:17:19 -0700
Message-ID: <169000304219.3611206.10769059861627155969.b4-ty@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230612220632.1885175-1-quic_bjorande@quicinc.com>
References: <20230612220632.1885175-1-quic_bjorande@quicinc.com>
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


On Mon, 12 Jun 2023 15:06:32 -0700, Bjorn Andersson wrote:
> The LLCC binding and driver was recently corrected to handle the stride
> varying between platforms. Switch to the new format to ensure accesses
> are done in the right place.
> 
> 

Applied, thanks!

[1/1] arm64: dts: qcom: sc8180x: Fix LLCC reg property
      commit: 74cf6675c35ec3034053a69926f4d98e52852eb0

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
