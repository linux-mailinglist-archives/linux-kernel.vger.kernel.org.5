Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02E7C7CB7F2
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 03:27:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233655AbjJQB1c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 21:27:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231955AbjJQB12 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 21:27:28 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90D659B
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 18:27:27 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9245CC433C7;
        Tue, 17 Oct 2023 01:27:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697506047;
        bh=s+jRDW+2r/hfeMcX43wig5Zoi67P+MBXYRuEZHkr50I=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=HogMLJfecZN17MTZr096mjcZ2IDGruz/FY7v83Gb7/ZDvPTIL+WdGM2mSjH7TIQeV
         lkrcwJlrreWA553L9DrttaF+M7rIPrW9D9ajMAl90ghSw45tWbn0TqygnVdba71bsJ
         BvKjL+VYXfZH4UypliqZOJuU3w2NObAhUxlv8cKc2lrEzWW7ASoP3AVNUGpU8o8sPF
         UnRi6125QGaEN9A5JIvhzI7DWQnCDQH6LUuKqXlkSo5Jy3x640fO1wpZfyv1n/b4q+
         D0RssdFIOutKYuMPzDFSpjElHznI23230BDvGHOLDdKzk7TVCqfAwWBq2gAt0PN03C
         fcg5fAqQT0iKw==
Date:   Mon, 16 Oct 2023 18:27:25 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Yunsheng Lin <linyunsheng@huawei.com>
Cc:     <davem@davemloft.net>, <pabeni@redhat.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, <bpf@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Subject: Re: [PATCH net-next v11 0/6] introduce page_pool_alloc() related
 API
Message-ID: <20231016182725.6aa5544f@kernel.org>
In-Reply-To: <20231013064827.61135-1-linyunsheng@huawei.com>
References: <20231013064827.61135-1-linyunsheng@huawei.com>
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

On Fri, 13 Oct 2023 14:48:20 +0800 Yunsheng Lin wrote:
> v5 RFC: Add a new page_pool_cache_alloc() API, and other minor
>         change as discussed in v4. As there seems to be three
>         comsumers that might be made use of the new API, so
>         repost it as RFC and CC the relevant authors to see
>         if the new API fits their need.

I have looked thru the v4 discussion (admittedly it was pretty huge).
I can't find where the "cache" API was suggested.
And I can't figure out now what the "cache" in the name is referring to.
Looks like these are just convenience wrappers which return VA instead
of struct page..
