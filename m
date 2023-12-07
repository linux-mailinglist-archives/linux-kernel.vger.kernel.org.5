Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E421807F1D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 04:15:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbjLGDPj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 22:15:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbjLGDPh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 22:15:37 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CD09D5A
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 19:15:43 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10411C433C8;
        Thu,  7 Dec 2023 03:15:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701918942;
        bh=SRAZz73xZ/wQzq9LmH5D7EgARdnZgItIkeFCCGRI57E=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=aSLju+4eEJeIUkqF6JDwTQfuLhzmDJ3EawX3T13ddxPpFum1+fPbsj9nN606wV3Mq
         i9fFZsr1jJtPLFJNEBZz4TSt7+0iMaPrlnhPsLXKTaMRuk17aZaO+Xjbh0r7MKa/F4
         PiIH69Ri+ANuMK62qJSvqZjqDCCS9PtCMGtT8zcdxxb20oB1v5wc/DBO0yiVpeXBst
         TLQIuVhMPSr0RjbRX8EWaqJCX4ZR0hYyOXcBq2USAcsHg5Nhm8CKxAe04C5MAIt5zP
         JKlDkDFzKEPewUkcECvkdDBN0H/53XREjVLSBABKEG/VUThI5J8G349GXQk+Z7+6Ce
         ixELhIZx2p/cw==
Date:   Wed, 6 Dec 2023 19:15:39 -0800
From:   Jakub Kicinski <kuba@kernel.org>
To:     Yunsheng Lin <linyunsheng@huawei.com>
Cc:     <davem@davemloft.net>, <pabeni@redhat.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Alexander Duyck <alexander.duyck@gmail.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Eric Dumazet <edumazet@google.com>, <kvm@vger.kernel.org>,
        <virtualization@lists.linux.dev>, <linux-mm@kvack.org>
Subject: Re: [PATCH net-next 2/6] page_frag: unify gfp bit for order 3 page
 allocation
Message-ID: <20231206191539.06d955f3@kernel.org>
In-Reply-To: <20231205113444.63015-3-linyunsheng@huawei.com>
References: <20231205113444.63015-1-linyunsheng@huawei.com>
        <20231205113444.63015-3-linyunsheng@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Dec 2023 19:34:40 +0800 Yunsheng Lin wrote:
> __GFP_DIRECT_RECLAIM is xor'd to avoid
> direct reclaim in skb_page_frag_refill(), but it is not
> xor'd in __page_frag_cache_refill().

xor is not the same thing as masking a bit off.
The patch itself LGTM.
