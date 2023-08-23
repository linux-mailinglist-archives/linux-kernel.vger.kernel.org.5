Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A64DC7859FE
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 16:04:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236045AbjHWOEu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 10:04:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234430AbjHWOEt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 10:04:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE900CF3;
        Wed, 23 Aug 2023 07:04:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 871C065C18;
        Wed, 23 Aug 2023 14:04:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A91D3C433C7;
        Wed, 23 Aug 2023 14:04:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692799486;
        bh=fMzG+5ZYJwqkyX40cSxyRVnbZtJ1KnHDIN0uI3j8Kco=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=BwZHZvPS+jqnh3gwaYlj7T7Siw6JGXZC7PSfeGq1tYJs1g5OuJDU8ARmJZwpth2Vn
         AOFvWMxU3yG+v1UdBm7LGOr2wSyzjZlIZnLPOtpCNVxQ/1qappXwy/qSN5DXMSB3X0
         3ch7nSVmxllTqzMuozBXFECvZIhdnhYA5SZ6bDdulxWd/AA3GWK2qBqAWShvc8M5fm
         7jsB3Uwy5pvK0kg2zj+6BXJAAIXUUgGvIiU9LAX2jF64n0ixgshlG/4Vocuh8IR+V6
         CTPmQ28trxzJGZrrLsc6JGJndrw1XDnAHZudZ7RJvfR79YEjjhC7HKpC3R0Bmt6BbI
         VQMLIizTB6LWA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: ath11k: Consistently use ath11k_vif_to_arvif()
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230821-ath11k_vif_to_arvif-v1-1-fa2c3b60b5cf@quicinc.com>
References: <20230821-ath11k_vif_to_arvif-v1-1-fa2c3b60b5cf@quicinc.com>
To:     Jeff Johnson <quic_jjohnson@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Jeff Johnson <quic_jjohnson@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <169279948369.1241462.6552260393066152478.kvalo@kernel.org>
Date:   Wed, 23 Aug 2023 14:04:45 +0000 (UTC)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Johnson <quic_jjohnson@quicinc.com> wrote:

> Helper function ath11k_vif_to_arvif() exists to retrieve a struct
> ath11k_vif from a struct ieee80211_vif. However, in multiple places
> this logic is open-coded with inline typecasting. Since the
> typecasting prevents the compiler from type-checking the source and
> destination, update the driver to consistently use the helper
> function.
> 
> No functional changes, compile tested only.
> 
> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

9476cda44c13 wifi: ath11k: Consistently use ath11k_vif_to_arvif()

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230821-ath11k_vif_to_arvif-v1-1-fa2c3b60b5cf@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

