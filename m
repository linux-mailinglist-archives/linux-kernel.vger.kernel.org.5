Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 438377C582A
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 17:36:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232743AbjJKPgW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 11:36:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbjJKPgU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 11:36:20 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A04E92
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 08:36:19 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8486DC433C7;
        Wed, 11 Oct 2023 15:36:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697038579;
        bh=lTq1DkG7l+QHbQBfr/sAWfclw9fYk69n6jbHGMTIKvo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Bcp/JOIA9l1V1uVU1FUbmq0Pqf6ndX+uIezQSz1L/ygwBQ1JSnAur/Abq56GCrHgR
         wm6Yku1xyZegc67Mp5b1n8rlqPDRplqtPaHXyGo5hj0mGDVr0mpv0VEU7tjiVOyDpy
         4iG2/mZTyp9YRmpCiFzGLklBIEqA5locMQH4RRgiBZwLnKLk0qa8LgZyqa2mpNpFSf
         xTz2/scGbNti2vmRU2Iju+xBGxQTklEfCaV/yAXr/b522Fn8AkRrbxUflhsRy1Syfc
         QOxJtrpbObzH7w37wQNqdz1ct4rbsZ+uxorFZGqMQs9f764duHDqMTwFhSXr4qcs+Q
         E9jhx8hXs9Qtw==
Date:   Wed, 11 Oct 2023 08:36:17 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Yunsheng Lin <linyunsheng@huawei.com>
Cc:     <davem@davemloft.net>, <pabeni@redhat.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <bpf@vger.kernel.org>
Subject: Re: [PATCH net-next v10 0/6] introduce page_pool_alloc() related
 API
Message-ID: <20231011083617.61bba987@kernel.org>
In-Reply-To: <20230922091138.18014-1-linyunsheng@huawei.com>
References: <20230922091138.18014-1-linyunsheng@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Sep 2023 17:11:32 +0800 Yunsheng Lin wrote:
> In [1] & [2] & [3], there are usecases for veth and virtio_net
> to use frag support in page pool to reduce memory usage, and it
> may request different frag size depending on the head/tail
> room space for xdp_frame/shinfo and mtu/packet size. When the
> requested frag size is large enough that a single page can not
> be split into more than one frag, using frag support only have
> performance penalty because of the extra frag count handling
> for frag support.
> 
> So this patchset provides a page pool API for the driver to
> allocate memory with least memory utilization and performance
> penalty when it doesn't know the size of memory it need
> beforehand.

Could you rebase & repost? Patches no longer apply :(

