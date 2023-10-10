Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 698047BF449
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 09:27:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442674AbjJJH11 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 03:27:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442663AbjJJH1R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 03:27:17 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C96DE35BB;
        Tue, 10 Oct 2023 00:25:32 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 434B8C433C7;
        Tue, 10 Oct 2023 07:25:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696922731;
        bh=dsCZmko66D3I+q0qFacuady/BZUkjXk+jklN8wRloNo=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=ZjUd9XjIf3+GJhrLG21e4SoChwZb4r6IPXzxVLEAgP0bzhj5oYKSVyzOP5UDUqfSF
         w/WRhciTfr+SoC4epz3u7sJC0tq5ACwAJNOTD0bKS/7AJdbADkVQDQGAirRO/sHCPO
         XZtc9g2J3WXE3XI5DLaFs6mfYLpAvR/jQeKjRt6rf/GefJWEPxn0A0+sI5RwkSRWwY
         vB/X40PbgsfX9NjEs7suul/REky4do1/N+GijCGI5Jm21l0qyx6Nlbc9HBkJ7+uoWL
         Wqy3qBkxvsYE7Jkpx0h7jC8cF/2PPvHzeIlUhLgi/2FaSfVhvE9zPI83Fo9CKs+9D8
         4PLQXr8UQ3a4g==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: ath12k: Consistently use ath12k_vif_to_arvif()
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20231004-ath12k_vif_to_arvif-v1-1-3f38f6882d33@quicinc.com>
References: <20231004-ath12k_vif_to_arvif-v1-1-3f38f6882d33@quicinc.com>
To:     Jeff Johnson <quic_jjohnson@quicinc.com>
Cc:     <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Jeff Johnson <quic_jjohnson@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <169692272808.2589238.531453282923447433.kvalo@kernel.org>
Date:   Tue, 10 Oct 2023 07:25:30 +0000 (UTC)
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

> Helper function ath12k_vif_to_arvif() exists to retrieve a struct
> ath12k_vif from a struct ieee80211_vif. However, in multiple places
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

13556aef0bdc wifi: ath12k: Consistently use ath12k_vif_to_arvif()

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20231004-ath12k_vif_to_arvif-v1-1-3f38f6882d33@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

