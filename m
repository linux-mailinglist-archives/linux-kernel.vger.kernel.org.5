Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E6FB7BF367
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 08:56:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442344AbjJJG4j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 02:56:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442233AbjJJG4g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 02:56:36 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0215099;
        Mon,  9 Oct 2023 23:56:36 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05159C433C7;
        Tue, 10 Oct 2023 06:56:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696920995;
        bh=l9c92wWaaUlL412ziyk84LFOr/63o2bETtDk0X6EBBA=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=mSnAx1cJ2tXbkPJDmce/e+Yy4go10RrHu4x650kLfqEAXwWWmpcT0ihmLphmtqK7E
         09RQwYuIRROk3F45mk6xIAD+bK8S274BmefacWsy8ChMk4mIsglJgtSqE7+DFUsU98
         6giQVCMtiv+6iuzToRofql/G8roZjHhhlOtaf2MVJLkycpyZ5itKLwRt2dftwYHaDW
         Kwvq0kGYUzowhzLPd/bb2QhHNYAQc3MfEd2gVyLwPTMeCwTCzRJr4jdvig5ZopgtxU
         wv2YZgpfJjf3awObRRfybEHwDShK1aVVxh4vW0oP+VSCYE55bclxgDyMoET4xQs7b1
         5Kjg24lXwnSNw==
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
Subject: Re: [PATCH 08/10] wireless: atmel: remove unused ioctl function
References: <20231009141908.1767241-1-arnd@kernel.org>
        <20231009141908.1767241-8-arnd@kernel.org>
Date:   Tue, 10 Oct 2023 09:59:01 +0300
In-Reply-To: <20231009141908.1767241-8-arnd@kernel.org> (Arnd Bergmann's
        message of "Mon, 9 Oct 2023 16:19:06 +0200")
Message-ID: <87zg0rezey.fsf@kernel.org>
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
> This function has no callers, and for the past 20 years, the request_firmware
> interface has been in place instead of the custom firmware loader.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Yuck, good riddance. In the title we prefer "wifi:" over "wireless:" but
that's nitpicking. I assume this goes via a net tree so:

Acked-by: Kalle Valo <kvalo@kernel.org>

Let me know if I should take this to wireless-next instead.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
