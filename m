Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFB38751591
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 02:54:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232902AbjGMAyM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 20:54:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233305AbjGMAyF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 20:54:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA0582115;
        Wed, 12 Jul 2023 17:53:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A360A619EB;
        Thu, 13 Jul 2023 00:53:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C39E9C433C7;
        Thu, 13 Jul 2023 00:53:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689209635;
        bh=NVtdLL8+xBR7hSGyKtnjjHvGDMITqkluq9Z4RcbYLcY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=X/8mgt68l7feMz0hsXgsMTNUkn0ONkHeP5UBKgp99f/bxTz8LMoGZFmyn4A1/AkKP
         cattpVEPet5zNiBKZ2BzIqpL2E43KBGfSEd9HR8EyEKlvyeKyseTaMyihI1k5F5fbZ
         K/CHYNUswo+EFn0/n/t54vsjh3+6mSvQ7adfTb9Ujai/N9a2n0mmOYdH8yCI5FZjia
         WDSOl+5nAa2Yk/FI2pUcTGSHpEmYlPyINWd3TyJcGRy10S9NeCC7GcXk9MxljrCiK+
         5tHUjG09w/vomiNcCqGKZm0qZZZ96xkLKuCUuNVuOYRecgJ7gsin6LoyWxTZHQyGaZ
         TJDJEvizn1ieQ==
Date:   Wed, 12 Jul 2023 17:53:53 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Zhang Shurong <zhang_shurong@foxmail.com>
Cc:     pkshih@realtek.com, kvalo@kernel.org,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] wifi: rtw89: debug: fix error code in
 rtw89_debug_priv_send_h2c_set()
Message-ID: <20230712175353.01ca65c5@kernel.org>
In-Reply-To: <tencent_AD09A61BC4DA92AD1EB0790F5C850E544D07@qq.com>
References: <tencent_AD09A61BC4DA92AD1EB0790F5C850E544D07@qq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  6 Jul 2023 10:45:00 +0800 Zhang Shurong wrote:
> If there is a failure during rtw89_fw_h2c_raw() rtw89_debug_priv_send_h2c
> should return negative error code instead of a positive value count.
> Fix this bug by returning correct error code.
> 
> Fixes: e3ec7017f6a2 ("rtw89: add Realtek 802.11ax driver")
> Signed-off-by: Zhang Shurong <zhang_shurong@foxmail.com>

Applied, thanks!
