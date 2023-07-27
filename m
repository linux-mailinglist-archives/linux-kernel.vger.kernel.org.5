Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB997765818
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 17:56:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233900AbjG0P4J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 11:56:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232070AbjG0P4H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 11:56:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CB272719;
        Thu, 27 Jul 2023 08:56:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C4CD161EA1;
        Thu, 27 Jul 2023 15:56:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EFB6C433C8;
        Thu, 27 Jul 2023 15:56:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690473366;
        bh=YfT9LpbNIIGzW+n5UebVWO4oipT4XM9jgA1njRlxVFM=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=pVBRKj7w1A3zYvY+0+R4aS3OCOyATy5IE4kdq5ZtlbIk9wmhU1HzpzdJqs3LSoo7C
         KWBRK1mHK08DjtJtwMZMDEd8zi+1RXdYEvIUgB5n91eUuHSSTvuzbr6hE6TpmKalRm
         dtQ+Wini1g3F/w4h6vY8tuE4kS/uT5dlxbFuYR4zapvpbhmLjbxv7uQNwLDT9dCvNm
         c4lRBg3QDPlenJDsZyKrCAvO7NpHpgValMGYSlHyiV9tdk3tpyF0Csf9aKR1H+9DbA
         gRlAFZ3FFQb1WDsSaxihnIOkuzJX8aEUeVmp/VPJ/jrn31N/14UYq6kf+LBbALqvdt
         n6WnkPjQPQ2FA==
From:   Kalle Valo <kvalo@kernel.org>
To:     Wang Ming <machel@vivo.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        opensource.kernel@vivo.com
Subject: Re: [PATCH net-next v4] wifi: ath6kl: Remove error checking for
 debugfs_create_dir()
References: <20230726111209.4096-1-machel@vivo.com>
Date:   Thu, 27 Jul 2023 18:56:02 +0300
In-Reply-To: <20230726111209.4096-1-machel@vivo.com> (Wang Ming's message of
        "Wed, 26 Jul 2023 19:11:59 +0800")
Message-ID: <87y1j1z6ul.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wang Ming <machel@vivo.com> writes:

> It is expected that most callers should _ignore_ the errors
> return by debugfs_create_dir() in ath6kl_debug_init_fs().
>
> Signed-off-by: Wang Ming <machel@vivo.com>

ath6kl patches go to ath-next, not net-next. So do *not* put net-next
into Subject. No need to resend because of this.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
