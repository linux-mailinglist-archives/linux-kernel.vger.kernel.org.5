Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB4857BF370
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 08:57:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442365AbjJJG5u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 02:57:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442363AbjJJG5s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 02:57:48 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD44199;
        Mon,  9 Oct 2023 23:57:46 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4F33C433C8;
        Tue, 10 Oct 2023 06:57:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696921066;
        bh=TIRu023yRiAn4rr+cVhgd1+H6BjEpKUsZCa1Z/im/zU=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=eGoBSQjbQGUMyzFoSyJfbtWDcVCfyhQnmnKf1C58Cre/eyW9BSnD1X6qSu/KgVJwL
         CuYTKv2kCCa/5qmXQbltfB84K7Unkx/9oqPkHAPg5Z0oBf5wR37XihttMeMlOURRG8
         kwJZGqR6MiCd1iGkpJKvNhEOu+K+bXFXuFq0EnrDNmI4A2LARuG2NdYTNOM+b+LVnc
         5odic9AdqSNJmPmuZXRI7x45Hqpr1a0zO2bKcnHLNeukJb1hP/kD9ki84d+4yGPTv0
         6+J0ED+5upIMUz86XpvNNUrcxSzl3TFpGDrnqqrVCuTGs38IM3SEtR6Cbqm1V3eP3T
         WL3uvlp4W9nIA==
From:   Kalle Valo <kvalo@kernel.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-wireless@vger.kernel.org,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-wpan@vger.kernel.org,
        Michael Hennerich <michael.hennerich@analog.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Eric Dumazet <edumazet@google.com>,
        "David S . Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org, Doug Brown <doug@schmorgal.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 09/10] wireless: hostap: remove unused ioctl function
References: <20231009141908.1767241-1-arnd@kernel.org>
        <20231009141908.1767241-9-arnd@kernel.org>
Date:   Tue, 10 Oct 2023 10:00:12 +0300
In-Reply-To: <20231009141908.1767241-9-arnd@kernel.org> (Arnd Bergmann's
        message of "Mon, 9 Oct 2023 16:19:07 +0200")
Message-ID: <87v8bfezcz.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Arnd Bergmann <arnd@kernel.org> writes:

> From: Arnd Bergmann <arnd@arndb.de>
>
> The ioctl handler has no actual callers in the kernel and is useless.
> All the functionality should be reachable through the regualar interfaces.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

In the title we prefer "wifi:" over "wireless:" but that's nitpicking. I
assume this goes via a net tree so:

Acked-by: Kalle Valo <kvalo@kernel.org>

Let me know if I should take this to wireless-next instead.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
