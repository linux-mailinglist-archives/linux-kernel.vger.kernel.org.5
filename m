Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BFC87A8795
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 16:52:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235216AbjITOwr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 10:52:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235086AbjITOwn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 10:52:43 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1FEA91;
        Wed, 20 Sep 2023 07:52:37 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CADFC433C7;
        Wed, 20 Sep 2023 14:52:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695221557;
        bh=5h6v16wWKhONz72yVfPnsD86/kim+Vey7bcx5sp9XPw=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=H1BGfj0tjIThLBRbQg1ItMQ3Ju2K+XPPDe3C5H2KlmI88xRnwSjHZltwSGjWGQDTn
         Hz+lKxfdNxKpN+fMYhTSOm/7uuiX0n5H4muLu3dtYhbiXDNytLCfSXTP0tTeZqfIB0
         3Utoa4RnTSjOe50PQWHNtQ/W/mGaEgtO/2tC3oer65fgBtzbWMjaGVkieF1iiomoDr
         nCqKQZwSmLd1yg4z0xr66clgZDgQlkB5KWtKCBVEHLiwaaKYTakZAIm2V1pzWTlou/
         cV5s+YiBtBjlZd+7+bUFPMj4B8+oSLVlVt0ptF0jgwOFURs6wQ5duwOj4u3w37VZ7C
         4krVl8Seq4tNw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 wireless-next 7/9] wifi: ath12k: Remove unnecessary
 (void*)
 conversions
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230919045142.524226-1-yunchuan@nfschina.com>
References: <20230919045142.524226-1-yunchuan@nfschina.com>
To:     Wu Yunchuan <yunchuan@nfschina.com>
Cc:     quic_jjohnson@quicinc.com, ath12k@lists.infradead.org,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Wu Yunchuan <yunchuan@nfschina.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <169522155403.1418260.5064455550425202498.kvalo@kernel.org>
Date:   Wed, 20 Sep 2023 14:52:35 +0000 (UTC)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wu Yunchuan <yunchuan@nfschina.com> wrote:

> No need cast (void*) to (struct hal_rx_ppdu_end_user_stats *),
> (struct ath12k_rx_desc_info *) or (struct hal_tx_msdu_ext_desc *).
> Change the prototype to remove the local variable.
> 
> Signed-off-by: Wu Yunchuan <yunchuan@nfschina.com>
> Suggested-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

This added new warnings:

drivers/net/wireless/ath/ath12k/dp_mon.c:25: line length of 92 exceeds 90 columns
drivers/net/wireless/ath/ath12k/dp_mon.c:26: line length of 95 exceeds 90 columns

I fixed them in the pending branch by renaming ppdu_end_user to stats and
moving rx_user_status to it's own line:

https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/commit/?h=pending&id=5c0910fdf1d800f1aeb8ab3e860e61bebec0091b

No need to resend because of this.

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230919045142.524226-1-yunchuan@nfschina.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

