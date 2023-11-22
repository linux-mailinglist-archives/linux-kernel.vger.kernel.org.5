Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F01C37F4F7E
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 19:26:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235223AbjKVS0b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 13:26:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235418AbjKVS0F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 13:26:05 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0758B10D8;
        Wed, 22 Nov 2023 10:25:31 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47EFDC433C7;
        Wed, 22 Nov 2023 18:25:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700677530;
        bh=H92zqDBjuciQLmNG2J9FvGopKpP6F0Nuszp0E+9FHPU=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=Kh2zKVD/cDLyT0ybZywCRR22UaWGUHUvRaP8CQESw5naXMWn1slrkx/OLlCehvqx6
         GIjLemepdfkA3vt72g7w8kElOiyL+on6K/zbWMoXWiTvlsWFv7c37CQftKp9xRF32T
         l2nxFY7wPz95xjypX9wExma/dPj4fN80ahgIFellj1ay0XShQWZGQ/uLl83igZzCwZ
         q0h2TkLk6bqnPcC1wgOC90bW1c6+VbK+Rt2hWXN9uK55gqcNJZwyoamoJLgOgLkTQ4
         ZnFT8NQ1ZSzmdf+RxGRC4cD0r2v01MINPdE9nScVXzlkJavPzVmllxpvqmJwF02brG
         e7PCurzbuacaA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/4] wifi: ath11k: Remove obsolete struct
 wmi_peer_flags_map *peer_flags
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20231106-ath-peer-flags-v1-1-781e83b7e8e8@quicinc.com>
References: <20231106-ath-peer-flags-v1-1-781e83b7e8e8@quicinc.com>
To:     Jeff Johnson <quic_jjohnson@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <ath12k@lists.infradead.org>,
        Jeff Johnson <quic_jjohnson@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <170067752747.158537.2182756707529538748.kvalo@kernel.org>
Date:   Wed, 22 Nov 2023 18:25:29 +0000 (UTC)
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

> Currently both struct ath11k_pdev_wmi and struct ath11k_wmi_base
> define:
>         const struct wmi_peer_flags_map *peer_flags;
> 
> But that member is not used, and in fact, struct wmi_peer_flags_map
> is not defined within ath11k; these are obsolete remnants inherited
> from ath10k. So remove them.
> 
> Compile tested only.
> 
> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

4 patches applied to ath-next branch of ath.git, thanks.

53bcb41d9eda wifi: ath11k: Remove obsolete struct wmi_peer_flags_map *peer_flags
69bc79faa616 wifi: ath12k: Remove obsolete struct wmi_peer_flags_map *peer_flags
7d4a70201204 wifi: ath11k: Consolidate WMI peer flags
51516d9842a3 wifi: ath12k: Consolidate WMI peer flags

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20231106-ath-peer-flags-v1-1-781e83b7e8e8@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

