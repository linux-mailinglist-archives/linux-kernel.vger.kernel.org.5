Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D057761BB0
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 16:30:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230263AbjGYOaR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 10:30:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbjGYOaP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 10:30:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48D27102;
        Tue, 25 Jul 2023 07:30:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D68236177D;
        Tue, 25 Jul 2023 14:30:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8007DC433C7;
        Tue, 25 Jul 2023 14:30:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690295413;
        bh=KtnE5dhLNoiRTXkG83CVq0c4MoLSC/g14BIHi5712yA=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=UFJqsqrdVYDzkb111b+WY8IfFVpYAbcpMIXP5Kx/w7E13GQo1REYEFa9w6dTRqI12
         ePMUDHni89hp/ApW1oE+zmavdGt04xnpRDcs4PyfrwhgQa3wXCStkrdHwNM6hshfoL
         TeSDdy2ECDI6SYO8M+XXD6FC4AKmUeqFfwBy1TCiX9e5RPXgkIW57z+1QbNJ7aDzPc
         RaXTv2xBBy/JxJD5+D67fcffKnow1ZFEG/cJRFBqns0VektMi5dttUQqTjyqvTuzEN
         Uk0mN4vwAEcAX7zS7Xg2bJytNCmpF6t0+s3mREeGfInj+8GEB2eF59RpvSieGrRmNC
         6BSYmU6DfDxww==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v6] wifi: ath5k: remove phydir check from
 ath5k_debug_init_device()
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230714081619.2032-1-duminjie@vivo.com>
References: <20230714081619.2032-1-duminjie@vivo.com>
To:     Minjie Du <duminjie@vivo.com>
Cc:     Jiri Slaby <jirislaby@kernel.org>,
        Nick Kossifidis <mickflemm@gmail.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        linux-wireless@vger.kernel.org (open list:ATHEROS ATH5K WIRELESS DRIVER),
        linux-kernel@vger.kernel.org (open list),
        opensource.kernel@vivo.com, Minjie Du <duminjie@vivo.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <169029540951.3210124.15107643923652179216.kvalo@kernel.org>
Date:   Tue, 25 Jul 2023 14:30:11 +0000 (UTC)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Minjie Du <duminjie@vivo.com> wrote:

> 'phydir' returned from debugfs_create_dir() is checked against NULL.
> As the debugfs API returns an error pointer,
> the returned value can never be NULL.
> 
> Therefore, as the documentation suggests that the check is unnecessary
> and other debugfs calls have no operation in error cases,
> it is advisable to completely eliminate the check.
> 
> Signed-off-by: Minjie Du <duminjie@vivo.com>
> Reviewed-by: Jiri Slaby <jirislaby@kernel.org>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

f7eb8315b22a wifi: ath5k: remove phydir check from ath5k_debug_init_device()

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230714081619.2032-1-duminjie@vivo.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

