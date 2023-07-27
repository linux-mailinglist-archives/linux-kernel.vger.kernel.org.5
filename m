Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27B7C765814
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 17:55:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233794AbjG0Pzf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 11:55:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232070AbjG0Pzd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 11:55:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DD87BC;
        Thu, 27 Jul 2023 08:55:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BF42461EBA;
        Thu, 27 Jul 2023 15:55:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AA1FC433C8;
        Thu, 27 Jul 2023 15:55:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690473332;
        bh=DAdNaKTtTBA/3Io3SkqTp38JscNchiNy5CKdvBKYCIo=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=FK7DCDQaWv3SyLv/v3DAAAeo6JWudkm4nUty4dSq1TMFlFG2grAFXd8fZlsNY8VGi
         ejW/DUCHSdxaP0RxZSjrCTfhjXUYuPNItrHuD17dO59vYGEEbsT54YmgcpkfwbBu3z
         0ITnNqZimChffFAOsdSE9z/v9+oj0eIoI4VxwZJQdVla4oBJdRhqlcNQLF4ARBviIN
         V5/2ryMTFAP0ndB1fbcYc52QGYQTWgnn6OwI7/xZe3Yrrdl2tEKoqy9GViOnXTaTwB
         puBKZk3+buOKT5AAuwX4UddLBRcrJDrQAxlMFtSA4Sdakyi/J2LRFlbF27XLlvvhrB
         y55QVttcSHo7g==
From:   Kalle Valo <kvalo@kernel.org>
To:     Wang Ming <machel@vivo.com>
Cc:     Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        opensource.kernel@vivo.com
Subject: Re: [PATCH net-next v3] wifi: ath9k: Remove error checking for
 debugfs_create_dir()
References: <20230726110750.3925-1-machel@vivo.com>
Date:   Thu, 27 Jul 2023 18:55:28 +0300
In-Reply-To: <20230726110750.3925-1-machel@vivo.com> (Wang Ming's message of
        "Wed, 26 Jul 2023 19:07:39 +0800")
Message-ID: <8735191h8v.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wang Ming <machel@vivo.com> writes:

> It is expected that most callers should _ignore_ the errors
> return by debugfs_create_dir() in ath9k_htc_init_debug().
>
> Signed-off-by: Wang Ming <machel@vivo.com>

ath9k patches go to ath-next, not net-next. So do *not* put net-next
into Subject. No need to resend because of this.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
