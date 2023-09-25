Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C15737AD107
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 09:03:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232449AbjIYHDz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 03:03:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232347AbjIYHDj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 03:03:39 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FCB41AD;
        Mon, 25 Sep 2023 00:03:33 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D16FC433C8;
        Mon, 25 Sep 2023 07:03:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695625412;
        bh=bmAGW7IJt2ztTo1zPNp1/mpQS4/bkBknIARLsF7U394=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=DMVQlaEf67tOHftNFThuKdXgyAdtD0mbBEB7T2XUg9CW8RtZ+qst2VlYRKN+qAAqJ
         76PIUfdXIBbH/l/TIrP2QcdDHXCp0kEZA8gk4qUGnMi6gq/OOcHZDqy1PQYyFDbl2V
         ZqXsSIcDeaKBdRFnbHWxvsOvjwMsQktd5Nm+o9AIudLwKUTSmr5e/FFI5uUthLQIaP
         oe9waQLEXCWd5t/rbEiTcIBTEMHZxxj1YyIAWrw+4yQfGa1MDbxhO4QoB7uSfWLaaY
         mTqKUE+uCmO9DJxkRA8pyn5QH0F8g5abc+2wpDgp6TbUPZftUrry5rzIgbqd/fPwug
         VThTcFwX2JDww==
Message-ID: <0981d982-45db-d069-e26b-801b67ad1ae3@kernel.org>
Date:   Mon, 25 Sep 2023 09:03:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH] libata: Annotate struct ata_cpr_log with __counted_by
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-ide@vger.kernel.org, Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
References: <20230922175210.work.239-kees@kernel.org>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20230922175210.work.239-kees@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/09/22 19:52, Kees Cook wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
> (for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> As found with Coccinelle[1], add __counted_by for struct ata_cpr_log.
> 
> [1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci
> 
> Cc: Damien Le Moal <dlemoal@kernel.org>
> Cc: linux-ide@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>

Applied to for-6.7. Thanks !

-- 
Damien Le Moal
Western Digital Research

