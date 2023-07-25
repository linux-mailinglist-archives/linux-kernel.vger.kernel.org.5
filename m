Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C2B176066A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 05:10:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230208AbjGYDKd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 23:10:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231482AbjGYDKU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 23:10:20 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A612110E4;
        Mon, 24 Jul 2023 20:10:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=2BZ1mkxRsZ5oPo0ZGgsAL/9N8fGxAaKjK1Iw/ywtEs4=; b=wmvMbu6WPwbv4pbGfPOscP3q+f
        7CLvSnqBemJ8dma9HKHKEq7866mI76iISMAjsHR1YhQuzIhJNHeK0IrvmpwRtKletQV8SZz/Evnvo
        Xjr+vBvv9E38DjsxgMEahRVWTrWNgRz18nV0qYkvO/8wb3biU8w4joKDu2u2UGlZuzIM+kL9MrNii
        o918gd58+X7hiZp9bpPrNPJ39k/Y83GpNBAoe6WTPpT7AvNSCuT7VHykNcXtdEzhTX/q6IEs7zRm7
        xp2Pv4eibOpirhxcb5NtfeHHuGsKYTXZAYrQvvQKHb7mui2BqLeQMs0FG7fXzB71NRWzUddZgWmvk
        Ht9YlaDg==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qO8R7-0060Kt-2h;
        Tue, 25 Jul 2023 03:10:09 +0000
Message-ID: <e11e6287-9b27-90d7-da95-1dc88348b8b0@infradead.org>
Date:   Mon, 24 Jul 2023 20:10:09 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 1/1] kconfig: port qconf to work with Qt6 in addition to
 Qt5
Content-Language: en-US
To:     Boris Kolpackov <boris@codesynthesis.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
References: <20230724074625.458456-1-boris@codesynthesis.com>
 <20230724074625.458456-2-boris@codesynthesis.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230724074625.458456-2-boris@codesynthesis.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/24/23 00:46, Boris Kolpackov wrote:
> Tested with Qt5 5.15 and Qt6 6.4. Note that earlier versions of Qt5
> are no longer guaranteed to work.

Was there such a guarantee somewhere?

> 
> Signed-off-by: Boris Kolpackov <boris@codesynthesis.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>

> ---
>  scripts/kconfig/qconf.cc | 40 ++++++++++++++++++++++++++--------------
>  1 file changed, 26 insertions(+), 14 deletions(-)

Thanks.
-- 
~Randy
