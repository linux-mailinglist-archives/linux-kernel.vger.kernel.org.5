Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A1D580EE95
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 15:23:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376581AbjLLOXs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 09:23:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376565AbjLLOXq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 09:23:46 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52FDE8F
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 06:23:53 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E53CC433C8;
        Tue, 12 Dec 2023 14:23:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702391033;
        bh=RFzRehKbJal1Ks9fvN2tnfICVyLscWmgOdTrzxAZvZg=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=aQ3Yp75gmNkZuCijEJY1nQKZftJVe08ds9T555jbNMl0x6BxVvBXBghGlPxXPxPLE
         i1tyxUsZdS7O0ZJQmEz6kDXr/iCnAa5OC2yn3DGJYpHIIbwf3gX2wR6drV+BX28FSB
         lj+oM/27DX5TIvyXEIlxthtv463T3Pi9lpOBfcnqXfHkwwP2uICFQcuAaIf5+GEpBk
         cbdfqWZENCDsgNeqU5L6GFSBJTKe5NbwRhkli0x/kadIhNjswpPt8voM5D301BE5Nn
         9s4k3wd9IGQoC0lzhYUN+AlWgexr+CE6duCMD75JcYEYWSU8zG3JzR5hIR3rp5B2Hg
         exYaho6TqvtJw==
From:   Kalle Valo <kvalo@kernel.org>
To:     "Arnd Bergmann" <arnd@arndb.de>
Cc:     "Arnd Bergmann" <arnd@kernel.org>,
        "Ping-Ke Shih" <pkshih@realtek.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        "Ching-Te Ku" <ku920601@realtek.com>,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rtw89: avoid stringop-overflow warning
References: <20231204073020.1105416-1-arnd@kernel.org>
        <170196405395.2897000.836367709392997740.kvalo@kernel.org>
        <f39d5940-2030-4378-9a44-3355a4429e31@app.fastmail.com>
Date:   Tue, 12 Dec 2023 16:23:49 +0200
In-Reply-To: <f39d5940-2030-4378-9a44-3355a4429e31@app.fastmail.com> (Arnd
        Bergmann's message of "Thu, 07 Dec 2023 17:11:06 +0100")
Message-ID: <87plzbo5xm.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Arnd Bergmann" <arnd@arndb.de> writes:

> On Thu, Dec 7, 2023, at 16:47, Kalle Valo wrote:
>> Arnd Bergmann <arnd@kernel.org> wrote:
>>> From: Arnd Bergmann <arnd@arndb.de>
>>> 
>>> Fixes: 89741e7e42f6 ("Makefile: Enable -Wstringop-overflow globally")
>>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>>
>> ERROR: 'wifi:' prefix missing: '[PATCH] rtw89: avoid stringop-overflow 
>> warning'
>> ERROR: Failed to find commit id: Fixes: 89741e7e42f6 ("Makefile: Enable 
>> -Wstringop-overflow globally")
>>
>> I can add the "wifi:" prefix but where can I find the commit 89741e7e42f6?
>
> It's in linux-next and came in from Gustavo's tree at
> https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git/log/?h=for-next/kspp

Ah, I think then I'll drop the Fixes tag to avoid warnings or reports.
My understanding is that a commit in the Fixes tag should be a parent.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
