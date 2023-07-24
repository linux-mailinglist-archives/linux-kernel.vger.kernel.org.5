Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A0C875F9CC
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 16:26:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232019AbjGXOYR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 10:24:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231991AbjGXOYJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 10:24:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F4B4E70;
        Mon, 24 Jul 2023 07:24:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 827256122E;
        Mon, 24 Jul 2023 14:24:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D12D5C433CA;
        Mon, 24 Jul 2023 14:23:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690208640;
        bh=4x/lXBD11qRjeCltOoQZr+xF6TdB6bL9wbxYaXHsFY0=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=Lubu4N04Aw8qL5huv3ZWO+MLegdqvUkQ1aXNPEXAlwlJ70wEx/68x06L2YZOvKsvU
         lk9dNzh1iuEskZReHSLX66G3R96jWypb0wEWEjUJWQaACgUT3o68pIYPVGvNhjSZNi
         8FWZVUSPc0bSOxb2ghm3ncfX7mxwBP7VM+5LrDR8fCdVIeUUCjfN1bPd++QP303rFD
         8LbCAfnbSumP3hfvbOZ+31wnTw71qrQvg4j55ZfZAGygOZag2a7pOWVH5bp3ksQS5Q
         qErcuxyjNA9a3zSqhxw1rOtcp89M3pmTgn0J/iHbrKsODWUuJ7Jv+xSAxCO3I1gWHe
         AYQ1gG4djCHpQ==
From:   Kalle Valo <kvalo@kernel.org>
To:     hanyu001@208suo.com
Cc:     pkshih@realtek.com, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rtlwifi: rtl8192de: phy: "foo * bar" should be "foo *bar"
References: <tencent_56B12E143DA8D1D6A9C3669E04C963914905@qq.com>
        <8ef50a4e96014949bbfde956edd07108@208suo.com>
Date:   Mon, 24 Jul 2023 17:23:57 +0300
In-Reply-To: <8ef50a4e96014949bbfde956edd07108@208suo.com> (hanyu's message of
        "Wed, 19 Jul 2023 17:54:33 +0800")
Message-ID: <878rb52xs2.fsf@kernel.org>
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

hanyu001@208suo.com writes:

> This patch fixes the checkpatch.pl error:
>
> ./drivers/net/wireless/realtek/rtlwifi/rtl8192de/phy.c:2434: ERROR:
> "foo * bar" should be "foo *bar"
>
> Signed-off-by: Yu Han <hanyu001@208suo.com>

Please don't submit checkpatch fixes to wireless, they are too much work
with very little gain.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
