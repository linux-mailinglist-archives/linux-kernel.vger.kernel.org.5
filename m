Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 825527EAB4C
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 09:03:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232369AbjKNIDp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 03:03:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232341AbjKNIDo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 03:03:44 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E98F219B;
        Tue, 14 Nov 2023 00:03:41 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C1EEC433C8;
        Tue, 14 Nov 2023 08:03:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699949021;
        bh=en3QOVgsWe7HU+LBcOQv05X+cpfd58h4zxSJZwEEZqM=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=RNLrjbY7hsz6H1MAKpEq1aYBxYWTS2sp4lE8aqXE0aqNjqocX2M8gCeyNnzNXe4I6
         5Cv4qDunlExXySHepa6L1+ItxDqN/W2XT1GNoEmTdHDVSs43uLYJtvusIakBHFnfB5
         +hDuXFrd0Qbvu60PGgdcUPZFHvc+g6od//sJdMQhtkeZ0BPfnq0OXL+E/cuawWAl+X
         mj9BTo/MSPlDKcfOS/xKaGZuOFg6Z1D6N8kUnqp66azpDeHTfuHxKj4B0DzLTofUkk
         vER7GkbUtwnnx2IkpDkkgV8bxeHqBLUBzKqc+Rt5+mxHpz9I/aVoy67XYCZ6ztOmve
         a/lxqtbMuJaKw==
From:   Kalle Valo <kvalo@kernel.org>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Ping-Ke Shih <pkshih@realtek.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>
Subject: Re: [PATCH][next] wifi: rtw89: coex: Fix -Wstringop-overflow
 warnings in _append_tdma()
References: <ZVJ6lRCRaywGktxJ@work>
        <fd0d79048efa47868173c5fd8950b956@realtek.com>
        <192fbb0d-f4f6-4384-98d8-b7422349dafb@embeddedor.com>
Date:   Tue, 14 Nov 2023 10:03:37 +0200
In-Reply-To: <192fbb0d-f4f6-4384-98d8-b7422349dafb@embeddedor.com> (Gustavo A.
        R. Silva's message of "Mon, 13 Nov 2023 19:23:49 -0600")
Message-ID: <871qcsahie.fsf@kernel.org>
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

"Gustavo A. R. Silva" <gustavo@embeddedor.com> writes:

>> wireless-next has taken my patch [1] that is identical to yours.
>
> Great!
>
> I had mine ready on Oct 31, but I was waiting for the merge window to close
> before sending it.

BTW we keep wireless-next open also during merge windows. So no need to
hold up wireless patches because of the merge window. I know it's
confusing that we do differently than how net-next works but this is
easier for us, less patch build up.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
