Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B775808619
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 12:02:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229963AbjLGKPy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 05:15:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231543AbjLGKPt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 05:15:49 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF027A5
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 02:15:55 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D38D5C433C7;
        Thu,  7 Dec 2023 10:15:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701944155;
        bh=tFwkGv86AFFJXmIQAmk+BCCUjDOTKzu6KJoufVC72Nw=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=ceNszMbLhUEHsT8JEqxyUMeVOGN24Be3AsHYAdKcok5JSbKLD7cII4b1XQhnm+u/u
         6OsSkIa4juic5Jyntdfl1CqQjhs12eXt4Cf67bhgRVq7EWcsjeqJ3GWz5QK3ikNIk0
         y0f68BGaP1bw95DRbT2gv7+y0kB75mM46ohfktY1PBqwEKK9s4uAiKecflx25axWoM
         qsNwGaWJSKjHHb2zEP4tZ85RJXWxnt8bVxrPSjClbD4Zpj9f82YAPqgDqZQ2DqYkbv
         ntMuyejSRQfyYWUUka5aVtiENlG18oHgjRUxGtA4gfMW/bcHJixWE1aa0fGLjL0CJW
         Rj5so2+fhVmVw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ath5k: remove unused ath5k_eeprom_info::ee_antenna
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20231205111515.21470-1-jirislaby@kernel.org>
References: <20231205111515.21470-1-jirislaby@kernel.org>
To:     "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Cc:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
        Felix Fietkau <nbd@openwrt.org>,
        Nick Kossifidis <mickflemm@gmail.com>,
        Luis Chamberlain <mcgrof@kernel.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <170194415180.2678961.10511256344434552497.kvalo@kernel.org>
Date:   Thu,  7 Dec 2023 10:15:53 +0000 (UTC)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Jiri Slaby (SUSE)" <jirislaby@kernel.org> wrote:

> clang-struct [1] found that ee_antenna in struct ath5k_eeprom_info is
> unused. The commit 1048643ea94d ("ath5k: Clean up eeprom
> parsing and add missing calibration data") added it, but did not use it
> in any way. Neither, there is a later user.
> 
> So remove that unused member.
> 
> [1] https://github.com/jirislaby/clang-struct
> 
> Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
> Cc: Felix Fietkau <nbd@openwrt.org>
> Cc: Nick Kossifidis <mickflemm@gmail.com>
> Cc: Luis Chamberlain <mcgrof@kernel.org>
> Cc: Kalle Valo <kvalo@kernel.org>
> Cc: linux-wireless@vger.kernel.org
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

6783f10a1d07 wifi: ath5k: remove unused ath5k_eeprom_info::ee_antenna

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20231205111515.21470-1-jirislaby@kernel.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

