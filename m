Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09E4B761C27
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 16:45:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230523AbjGYOpy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 10:45:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230496AbjGYOps (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 10:45:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B94B4E78;
        Tue, 25 Jul 2023 07:45:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4FAD4617A0;
        Tue, 25 Jul 2023 14:45:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31F62C433C8;
        Tue, 25 Jul 2023 14:45:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690296338;
        bh=adx9Xg6ZI56xI0/gdi/9LXx1avRHstRCDy37Yg1vsjk=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=LWp9C1lHlwcYz4edRmwkFvtoNVIX9kbkJQfCXHhnRTTLntk3CcdJto4FM9JsRbCJ0
         logfno4rAoDo04Rt/Q8pcddi+suTt8R/jockzxZ77BXwe/bdKJCVqq8jn2VQZ39nz9
         de3AY4UF/FiUdxtI6cLRVU++JNSKoUi//r+rneZgEIEAaKd7pqUgZmURizDx6O3bvv
         A6EOBJZWua1sOPzSJ4LpRV5i5mgaz2TvVFRLnyGM3eVCklZXLXe01U8YOVQe9xSUmB
         araB+5bgVpsxxoe6wImT7VM6VKEcUL5t8yHz9xtOXcxMn1w6MuO2kzL8oJDg5+zt4Y
         /BbgCaB6ydWeA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v4] wifi: rtw89: debug: Fix error handling in
 rtw89_debug_priv_btc_manual_set()
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <tencent_1C09B99BD7DA9CAD18B00C8F0F050F540607@qq.com>
References: <tencent_1C09B99BD7DA9CAD18B00C8F0F050F540607@qq.com>
To:     Zhang Shurong <zhang_shurong@foxmail.com>
Cc:     pkshih@realtek.com, Markus.Elfring@web.de, kuba@kernel.org,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zhang Shurong <zhang_shurong@foxmail.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <169029633544.3309254.7388836685392352626.kvalo@kernel.org>
Date:   Tue, 25 Jul 2023 14:45:37 +0000 (UTC)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Zhang Shurong <zhang_shurong@foxmail.com> wrote:

> If there is a failure during kstrtobool_from_user()
> rtw89_debug_priv_btc_manual_set should return a negative error code
> instead of returning the count directly.
> 
> Fix this bug by returning an error code instead of a count after 
> a failed call of the function "kstrtobool_from_user". Moreover
> I omitted the label "out" with this source code correction.
> 
> Fixes: e3ec7017f6a2 ("rtw89: add Realtek 802.11ax driver")
> Signed-off-by: Zhang Shurong <zhang_shurong@foxmail.com>
> Acked-by: Ping-Ke Shih <pkshih@realtek.com>

Patch applied to wireless-next.git, thanks.

59b4cc439f18 wifi: rtw89: debug: Fix error handling in rtw89_debug_priv_btc_manual_set()

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/tencent_1C09B99BD7DA9CAD18B00C8F0F050F540607@qq.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

