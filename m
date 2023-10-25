Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42D1C7D67BE
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 12:00:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234496AbjJYKAc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 06:00:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232985AbjJYKA2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 06:00:28 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2171510A;
        Wed, 25 Oct 2023 03:00:26 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43A68C433C8;
        Wed, 25 Oct 2023 10:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698228025;
        bh=F1/gkCmvsR0o6rzvIG81eu8MlRTMzJjQX+YLmYEwrMA=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=l8VjcJSrhRs8tIxsZBYqxOMp0/7laXlM4HHfU546QUO904cgQQ2OjwYm8I8x2EUqC
         MdOlQfdI1fgHBFXMnrJTG3hHaoTlh8UeBZ8NZaRbr2q+I6AOV07I7Kxn/hb0WfF8k/
         /cpR/Uh8ZoL0wcxmhIaTs/WKTDend/EBqQddzrDWLnCaCPEchMCAR/c6oSkAEerxS5
         n9048glGa39cv7afiYykRJiUkHKv28eNBZDZY7ukUXX8m1xz6+sgu3Cr5+EjUPf+Rg
         TWTbDBxEBuOyxb2Coo0NIJjiLzCsil6tgfelMLoUii5O7+wqLlayVaVoZ3JJ7R6hBA
         ApWawiwTHSVrA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: ath11k: fix htt pktlog locking
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20231019112521.2071-1-johan+linaro@kernel.org>
References: <20231019112521.2071-1-johan+linaro@kernel.org>
To:     Johan Hovold <johan+linaro@kernel.org>
Cc:     Jeff Johnson <quic_jjohnson@quicinc.com>,
        ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>, stable@vger.kernel.org
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <169822802217.891844.6410411832034607586.kvalo@kernel.org>
Date:   Wed, 25 Oct 2023 10:00:24 +0000 (UTC)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Johan Hovold <johan+linaro@kernel.org> wrote:

> The ath11k active pdevs are protected by RCU but the htt pktlog handling
> code calling ath11k_mac_get_ar_by_pdev_id() was not marked as a
> read-side critical section.
> 
> Mark the code in question as an RCU read-side critical section to avoid
> any potential use-after-free issues.
> 
> Compile tested only.
> 
> Fixes: d5c65159f289 ("ath11k: driver for Qualcomm IEEE 802.11ax devices")
> Cc: stable@vger.kernel.org      # 5.6
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

3f77c7d605b2 wifi: ath11k: fix htt pktlog locking

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20231019112521.2071-1-johan+linaro@kernel.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

