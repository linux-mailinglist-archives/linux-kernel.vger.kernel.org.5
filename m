Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7071780F127
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 16:35:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376877AbjLLPff (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 10:35:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377002AbjLLPfc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 10:35:32 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 640B1EB
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 07:35:39 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9778AC433C8;
        Tue, 12 Dec 2023 15:35:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702395338;
        bh=Uze0pxeBdkOUy3U6m/Mh1/d2tI9SnM/+x1V/99wkX3E=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=sRTNP8W3M8DChOJFfMhLF2+Q9C/ce8wSirbdPGEhroZatcWxA5Z1ofqtZdZykIpQH
         xjzACOHrkmAAnFZoIWpRaqma0iie7zLY/8l0shx6ONOJqCbS2gVmu1qaNeY8Mf1lkX
         s+NmZjqH8IE9MA3f3wnN8rc1HN0cKxyYQfZcHO7IO4Zw1UM4c2mQTxynxMGxlPwirj
         hNCo2UJG6gHqvu1Z071xtKoZzteruv24oYWu67XCIeLSYG7YkE4VswbtCAHDxrr82+
         M5mqBriHhDSVoui49dOd2qgNnwkyPlWCzmyIbFJ0poClwQzzKjS2WUPBquq00YontM
         P50AdTZuPgg3w==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: wifi: iwlegacy: Add null pointer check to il_leds_init()
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20231211033019.238149-1-chentao@kylinos.cn>
References: <20231211033019.238149-1-chentao@kylinos.cn>
To:     Kunwu Chan <chentao@kylinos.cn>
Cc:     stf_xl@wp.pl, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org, Kunwu Chan <chentao@kylinos.cn>,
        Kunwu Chan <kunwu.chan@hotmail.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <170239533573.306086.10663897206558625486.kvalo@kernel.org>
Date:   Tue, 12 Dec 2023 15:35:37 +0000 (UTC)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kunwu Chan <chentao@kylinos.cn> wrote:

> kasprintf() returns a pointer to dynamically allocated memory
> which can be NULL upon failure.
> 
> Cc: Kunwu Chan <kunwu.chan@hotmail.com>
> Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
> Acked-by: Stanislaw Gruszka <stf_xl@wp.pl>

Patch applied to wireless-next.git, thanks.

afd549903ea9 wifi: iwlegacy: Add null pointer check to il_leds_init()

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20231211033019.238149-1-chentao@kylinos.cn/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

