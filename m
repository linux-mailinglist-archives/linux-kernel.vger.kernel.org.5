Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D2D97BC477
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 05:43:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343525AbjJGDng (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 23:43:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343491AbjJGDne (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 23:43:34 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9140BD;
        Fri,  6 Oct 2023 20:43:33 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F1D1C433C8;
        Sat,  7 Oct 2023 03:43:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696650213;
        bh=/XnJFcvVU6ZpIin+GOGN2gLHcNQTV4L7LTIlpf+1yQY=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=nai38z5tQi/p+Yb92wCONFYch2eSpqfHrzRMrnJ7iVeumcdV887o0orT0t+lcNxbD
         i40XIhm1BvRGR2ZMm9DH7dxV++olEpvAkXVd2E4mYUe8BtD/3KIZunE3wZ200+FA4e
         BVzRxvSlnUrshY2lDc56P5Hdequv+9GOndP7+nYDi1H3p7tMgPUekIdu2PwlCkjMAH
         KJ956YKUgrVkzSVW8EgLKj7UAnqXalGPoLumnXY8f5ot1+bmNpwT0pPydbsN+uByu4
         U3sdDb8y3JeAf6SLYC8az7syBFG43FhZ4FKz8XJST4Ym/fAmRDep1oEenb1kvF2zue
         xGX8o2/Ru1yfg==
From:   Kalle Valo <kvalo@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-wireless@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] wifi: mt76: Annotate struct mt76_rx_tid with __counted_by
References: <20230915200612.never.786-kees@kernel.org>
        <202310061320.8630F7E51@keescook>
Date:   Sat, 07 Oct 2023 06:45:52 +0300
In-Reply-To: <202310061320.8630F7E51@keescook> (Kees Cook's message of "Fri, 6
        Oct 2023 13:21:13 -0700")
Message-ID: <87cyxrgknj.fsf@kernel.org>
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

Kees Cook <keescook@chromium.org> writes:

> On Fri, Sep 15, 2023 at 01:06:12PM -0700, Kees Cook wrote:
>> Prepare for the coming implementation by GCC and Clang of the __counted_by
>> attribute. Flexible array members annotated with __counted_by can have
>> their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
>> (for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
>> functions).
>> 
>> As found with Coccinelle[1], add __counted_by for struct mt76_rx_tid.
>
> Friendly ping. Can this get picked up by the wifi tree, or should it go
> via something else?

It's already in mt76 pull request and should be in wireless-next next
week:

https://patchwork.kernel.org/project/linux-wireless/patch/a5a2baaa-0db4-403e-9ebd-a7ff089675b4@nbd.name/

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
