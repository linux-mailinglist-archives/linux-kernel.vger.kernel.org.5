Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04B147F4F5F
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 19:24:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344164AbjKVSY3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 13:24:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231478AbjKVSY1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 13:24:27 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80C771BF;
        Wed, 22 Nov 2023 10:24:24 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0D59C433C9;
        Wed, 22 Nov 2023 18:24:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700677464;
        bh=uEpmgyO2p6pkPeAJKJ2rj0J4ai28EXrVdy4cfpMdf+4=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=i9XO28Hhada/rH6RHoiEK9h0S8bM0G5BNDWTyD3RB0NJfur5jVQKbugoZPxB8bSK/
         Qs12wUEfKg5KhO+svT2F/0FzB12M7+Ha1P3S04ZYWBdht8rFAtUFQHXM0GxuaroiGr
         H2ECRw8wdtovAoumpvrg/RH/t2E9wbk++Zn5/XiS6rgqpNZDtJUdMJ3e79Q9o8y3bE
         85n5wxs13KBo0DgYlYcOWa1wF83vp3K7u9pR6bpK6h1RlAJBhfXMglpjerL4LWESZl
         TUjAo7N2aLb9BOwL9Yi56DvymjMmRRE789qWeDn+682yuhyLF+df69Yrz7jryLL/T5
         sge5daIwplRXw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/2] wifi: ath11k: Remove struct ath11k::ops
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20231106-ath12k-remove-ieee80211_ops-v1-1-d72cef1a855b@quicinc.com>
References: <20231106-ath12k-remove-ieee80211_ops-v1-1-d72cef1a855b@quicinc.com>
To:     Jeff Johnson <quic_jjohnson@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <ath12k@lists.infradead.org>,
        Jeff Johnson <quic_jjohnson@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <170067746080.158537.6690430337439338561.kvalo@kernel.org>
Date:   Wed, 22 Nov 2023 18:24:22 +0000 (UTC)
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Johnson <quic_jjohnson@quicinc.com> wrote:

> Currently struct ath11k defines the following member:
>         struct ieee80211_ops *ops;
> 
> This is being flagged by checkpatch.pl:
> WARNING: struct ieee80211_ops should normally be const
> 
> The original plan was to add the const qualifier.  However, it turns
> out this is actually unused, so remove it.
> 
> No functional changes, compile tested only.
> 
> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

2 patches applied to ath-next branch of ath.git, thanks.

199a78565cc2 wifi: ath11k: Remove struct ath11k::ops
3b6ec0409fe8 wifi: ath12k: Remove struct ath12k::ops

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20231106-ath12k-remove-ieee80211_ops-v1-1-d72cef1a855b@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

