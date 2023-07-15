Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB1FD754CBA
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jul 2023 00:10:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230293AbjGOWKh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jul 2023 18:10:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230090AbjGOWKV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jul 2023 18:10:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E4282723;
        Sat, 15 Jul 2023 15:10:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 318BF60C47;
        Sat, 15 Jul 2023 22:10:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36E0AC433C7;
        Sat, 15 Jul 2023 22:10:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689459019;
        bh=wg3gQs+CZ4wlzlacPdDFW5G/hgcmzR3RDndodc/Clrg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Cq7uHBFD3h8wnQ2G1mml0l6V5nAQbhmjBMTucBTKtC1quhW1XaYL85btXRFR1xTBF
         Fil1oxXHyrWNF9VM0NKVEaTJTPez8RxI4DXSh8tm6X+uR1rasHa1xmAIDf5CjWhlHO
         vimFngSHJM4nUcsYxv4cK+aa/q+8oZe+dPRL3UnJ7z7dkXuHXzmrzeG/7/pgvmUIdR
         Thr+uNpJpqKU8pFgOvUoKxQ4Iw6OJ3zXae6fTJn+iSXAKp2SHxAfw3zFIRMeOd7XGn
         EXdLHY0UQ4rZXjrLUv4bY9HgVjkif67bvTO5XR0OxbesZtBurqC3c7BclUls4qFomQ
         OjF/lWCzRwUww==
From:   Bjorn Andersson <andersson@kernel.org>
To:     agross@kernel.org, konrad.dybcio@linaro.org, corbet@lwn.net,
        keescook@chromium.org, tony.luck@intel.com, gpiccoli@igalia.com,
        catalin.marinas@arm.com, will@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        linus.walleij@linaro.org, linux-gpio@vger.kernel.org,
        srinivas.kandagatla@linaro.org,
        Mukesh Ojha <quic_mojha@quicinc.com>
Cc:     linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org
Subject: Re: (subset) [PATCH v3 00/18] Add basic Minidump kernel driver support
Date:   Sat, 15 Jul 2023 15:13:34 -0700
Message-ID: <168945921478.1805013.7211960599963339759.b4-ty@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <1683133352-10046-1-git-send-email-quic_mojha@quicinc.com>
References: <1683133352-10046-1-git-send-email-quic_mojha@quicinc.com>
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


On Wed, 03 May 2023 22:32:14 +0530, Mukesh Ojha wrote:
> Minidump is a best effort mechanism to collect useful and predefined data
> for first level of debugging on end user devices running on Qualcomm SoCs.
> It is built on the premise that System on Chip (SoC) or subsystem part of
> SoC crashes, due to a range of hardware and software bugs. Hence, the
> ability to collect accurate data is only a best-effort. The data collected
> could be invalid or corrupted, data collection itself could fail, and so on.
> 
> [...]

Applied, thanks!

[01/18] remoteproc: qcom: Expand MD_* as MINIDUMP_*
        commit: 318da1371246fdc1806011a27138175cfb078687

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
