Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B42A67A9B8C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 21:02:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230274AbjIUTCb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 15:02:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230018AbjIUTCI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 15:02:08 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30C1E80FBE;
        Thu, 21 Sep 2023 10:36:58 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7765CC116B3;
        Thu, 21 Sep 2023 08:04:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695283446;
        bh=ikVEGvz/AoDXxl7OJz8v3M6JEuj84GWYAzbM3pSuSfs=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=Q0AAb/hTsyZsWcttt+LH9287e9g6+ilMDd07ifknyZdtsttuFD/C7e8WN86RofEdm
         UVMgUWeJlRHX1OVx0DTpFzJzn/OV51Ppg+FiMaRtZ55XYp0MY90NMR/KifyziH12cN
         fY+4NSCJBY8omAlRFugv8mJ87l5UCi4RvZbpHJeyOcekfqgcDsGWuLI0hHWm4hpO3u
         ixqDd/UTnuHp1aDa0bDudiQM+yPoqEahXZhOI1AvRrVtWpm1NSqqQ90jomTQdCDwVS
         b1x+bH8jl7UBlk3Wxfu0SY+aur5ipB2vp+GmJgZGgehROHGImkqJ7iBSKcv+IT4mjc
         81QyDj+54D/BA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] ath9k: clean up function ath9k_hif_usb_resume
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230905013556.2595854-1-dzm91@hust.edu.cn>
References: <20230905013556.2595854-1-dzm91@hust.edu.cn>
To:     Dongliang Mu <dzm91@hust.edu.cn>
Cc:     =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
        hust-os-kernel-patches@googlegroups.com,
        Dongliang Mu <dzm91@hust.edu.cn>,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <169528344376.1539628.7025381317587339647.kvalo@kernel.org>
Date:   Thu, 21 Sep 2023 08:04:05 +0000 (UTC)
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dongliang Mu <dzm91@hust.edu.cn> wrote:

> In ath9k_hif_usb_resume, the error handling code calls
> ath9k_hif_usb_dealloc_urbs twice in different paths.
> 
> To unify the error handling code, we move the else branch before
> the if branch and drop one level of indentation of the if branch.
> 
> In addition, move the ret variable at the end of variable declarations
> to be reverse x-mas tree order.
> 
> Note that this patch does not incur any functionability change.
> 
> Signed-off-by: Dongliang Mu <dzm91@hust.edu.cn>
> Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>
> Acked-by: Toke Høiland-Jørgensen <toke@toke.dk>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

dc73b2059354 wifi: ath9k: clean up function ath9k_hif_usb_resume

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230905013556.2595854-1-dzm91@hust.edu.cn/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

