Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E3007CD686
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 10:31:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344680AbjJRIbI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 04:31:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344678AbjJRIbF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 04:31:05 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23CD4109;
        Wed, 18 Oct 2023 01:31:03 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 542E1C433C8;
        Wed, 18 Oct 2023 08:31:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697617862;
        bh=DmaIORX38lsk+s8u9A1sNW59yUVMPJkqJEYyV4bNIhY=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=HBIxPtGUhN/JlZd7seAMtycPXYiSRFWhQXCYyKYdLKpJxh+LujAL0rBktmZ8OJNjK
         Uf/vRvEIg1V8qOiEFI/Nq3+fyTcORNb77V/qxVNfc2E8eLdMnPeszKtlqEwkTc0oKM
         C05h5vWMEnLnr0y7WGymgR+VpIIDuZLmjlzcdgA6nzA8aoR97fjzxVDFKnt5HyoeS8
         FryJn4jKuvHbtc5hdtj9EvmxTuxGpNwL12pvLeRewiw6iXQLPXmZCQE/J7J1fNmAZ7
         5d0nTXsUNhUhNBZXcpIVLYPDOMuxrAMw0Qg+IKdImFurJWrPZ8a6lEiRGmpcBlGdYf
         +/QogbGs6uNcA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/2] wifi: ath11k: Remove ath11k_base::bd_api
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20231013-ath11k_bd_api-v1-1-3fefe4629706@quicinc.com>
References: <20231013-ath11k_bd_api-v1-1-3fefe4629706@quicinc.com>
To:     Jeff Johnson <quic_jjohnson@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <ath12k@lists.infradead.org>,
        Jeff Johnson <quic_jjohnson@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <169761785908.48072.2555690903765273261.kvalo@kernel.org>
Date:   Wed, 18 Oct 2023 08:31:01 +0000 (UTC)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Johnson <quic_jjohnson@quicinc.com> wrote:

> Currently struct ath11k_base defines the member bd_api. However, this
> member is only accessed within ath11k_core_fetch_bdf(). Since the
> scope is local just to that one function, remove it from ath11k_base
> and instead just use a local stack variable.
> 
> No functional changes, compile tested only.
> 
> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

2 patches applied to ath-next branch of ath.git, thanks.

b4f70ac0fa88 wifi: ath11k: Remove ath11k_base::bd_api
2180f7ac0abe wifi: ath12k: Remove ath12k_base::bd_api

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20231013-ath11k_bd_api-v1-1-3fefe4629706@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

