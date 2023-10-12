Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5679E7C7216
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 18:08:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347311AbjJLQIq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 12:08:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235744AbjJLQIp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 12:08:45 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E897D94;
        Thu, 12 Oct 2023 09:08:43 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44987C433C8;
        Thu, 12 Oct 2023 16:08:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697126923;
        bh=WyU9XAjD3B9ziyuyYmadcf6A83tJF/r6+JldUx4J6k4=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=vJIpcU+8lFVMrB0+9NB9EOFaYhBF5ZoeaoBXMvDGYQeGcP5TY0HW5M8bZ7yvNQaQy
         PBVoCzDMuR1LKz9Yem8VzxIIqVztMe8j8WDJ10nf5/Y7KiRt8irnmU62D51XtVXUxv
         qvDY1izlR7shUVG9/4mps0ZL4zocF8xXrO1MjgSk3netYAsx7DoaWaiicEmQOz/nvm
         WC4J+Y/TpsukuzpKFqUZKCb9vAm0Wb+Uop3e6FQnnvKlDKAypfdtbP+FKGmhdi3Bre
         0uvFOiQOFxemVdHMae7Xg+K1QiQiSxBxly3lqE/MQ/fnFxlzUk9RIO0imCndGhjsQ6
         D0E7PJ+n6ZQJw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: ath11k: Introduce and use ath11k_sta_to_arsta()
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20231009-ath11k_sta_to_arsta-v1-1-1563e3a307e8@quicinc.com>
References: <20231009-ath11k_sta_to_arsta-v1-1-1563e3a307e8@quicinc.com>
To:     Jeff Johnson <quic_jjohnson@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Jeff Johnson <quic_jjohnson@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <169712692043.3501995.15122826028111120811.kvalo@kernel.org>
Date:   Thu, 12 Oct 2023 16:08:42 +0000 (UTC)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Johnson <quic_jjohnson@quicinc.com> wrote:

> Currently, the logic to return an ath11k_sta pointer, given a
> ieee80211_sta pointer, uses typecasting throughout the driver. In
> general, conversion functions are preferable to typecasting since
> using a conversion function allows the compiler to validate the types
> of both the input and output parameters.
> 
> ath11k already defines a conversion function ath11k_vif_to_arvif() for
> a similar conversion. So introduce ath11k_sta_to_arsta() for this use
> case, and convert all of the existing typecasting to use this
> function.
> 
> No functional changes, compile tested only.
> 
> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

10c65f97b424 wifi: ath11k: Introduce and use ath11k_sta_to_arsta()

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20231009-ath11k_sta_to_arsta-v1-1-1563e3a307e8@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

