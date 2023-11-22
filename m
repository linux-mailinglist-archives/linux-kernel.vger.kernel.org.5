Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4130C7F4B9B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 16:51:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232173AbjKVPu5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 10:50:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235326AbjKVPuY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 10:50:24 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CEDCD65;
        Wed, 22 Nov 2023 07:50:21 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69230C433C8;
        Wed, 22 Nov 2023 15:50:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700668220;
        bh=EAuNV6GFL1gROKV359hi74ROMi6D7CaImnK5M9xYF7A=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=VJ79rfoQvdBfUeuE7YQtYQaT473nPmyP9qzkIuYJb3Lbs6O3L0ExwIhow9kjnYby+
         x3kaM2f7EP0KQDdjcboyMQYv2dTvj/lMTHvZO/jgTaQtt2GHT52r6/FYojpl59S5iW
         5/8j/Yf5Uqcaji9tAeVbR94Ty5MeZ8s452N/1qiBfQArJviG7lwmf9n3xE+41pRa53
         ZUm71aHX0g6yBVSLii4cWS9UKEqdavhZz0kwVB6rSgFN87wH5gVj3uU3UBgTMIhcyo
         WT552Lh7LfBQGXc/VRa2oQ4fu9jn+L8WsQQh0D8IJYitRaFmTwCwfqjb1mQTypDafG
         rxNXROb760XTw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: wifi: mwifiex: mwifiex_process_sleep_confirm_resp(): remove
 unused priv variable
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20231115092328.1048103-1-suhui@nfschina.com>
References: <20231115092328.1048103-1-suhui@nfschina.com>
To:     Su Hui <suhui@nfschina.com>
Cc:     nathan@kernel.org, ndesaulniers@google.com, trix@redhat.com,
        Su Hui <suhui@nfschina.com>, briannorris@chromium.org,
        lukas@wunner.de, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        kernel-janitors@vger.kernel.org
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <170066821641.4178710.6166900995489303046.kvalo@kernel.org>
Date:   Wed, 22 Nov 2023 15:50:18 +0000 (UTC)
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Su Hui <suhui@nfschina.com> wrote:

> Clang static analyzer complains that value stored to 'priv' is never read.
> 'priv' is useless, so remove it to save space.
> 
> Signed-off-by: Su Hui <suhui@nfschina.com>
> Acked-by: Brian Norris <briannorris@chromium.org>

Patch applied to wireless-next.git, thanks.

a85198c9f068 wifi: mwifiex: mwifiex_process_sleep_confirm_resp(): remove unused priv variable

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20231115092328.1048103-1-suhui@nfschina.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

