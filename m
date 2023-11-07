Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A68217E3EB9
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 13:41:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343687AbjKGMlC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 07:41:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344037AbjKGMji (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 07:39:38 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A40D36F91
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 04:28:43 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0DEFC433CB;
        Tue,  7 Nov 2023 12:28:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699360123;
        bh=UT5lonrit2LlwIl4rjREVNZ9SW/5EAlLOpoZpmK5k7M=;
        h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
        b=Nj/eqrYonXF9Ey1XVs4bi2m8NCH39uN/5Jk1/OzY/ljhQc+SstaXiZsVReDpzavau
         yp50EwXgmu8CNpW2tSd68BvrYHO/X4bKKJPG8B28nDpHyC/eT1gw1WNNhfvoRw4CxK
         /bHyQrexQeaA4+Tsqr2Vtc+jHVbl8DGOl9GzpdfFIhfwvR2m+5shuMpKjQsF/X24Ft
         twJxlq60JLJw/nA6BXfGHpehUZriNiR5rJnthEXp5l9olR8SFflQRVlS89DbAQE6U/
         3GWWuyk29p27/yGTbVUp9exAmjulih20pLukuyVyJjrJSdn5nIjSChJJD/E8DWryir
         RL682gtcIwEmw==
Message-ID: <973bcee0-a382-4a8d-8a2c-1be9b6d9d7ad@kernel.org>
Date:   Tue, 7 Nov 2023 13:28:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc:     hawk@kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: Re: [PATCH net] page_pool: Add myself as page pool reviewer in
 MAINTAINERS
Content-Language: en-US
To:     Yunsheng Lin <linyunsheng@huawei.com>, davem@davemloft.net,
        kuba@kernel.org, pabeni@redhat.com
References: <20231107113440.59794-1-linyunsheng@huawei.com>
From:   Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <20231107113440.59794-1-linyunsheng@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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



On 07/11/2023 12.34, Yunsheng Lin wrote:
> I have added frag support for page pool, made some improvement
> for it recently, and reviewed some related patches too.
> 

Yes, notice your frag stuff was applied while I was on vacation.
Thanks to Ilias, Jakub and other reviewers for handling this.

> So add myself as reviewer so that future patch will be cc'ed
> to my email.

I think is a good idea and I appreciate that you will review your
changes to page_pool.

There is a format issue below in patch.


> Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
> CC: Jesper Dangaard Brouer <hawk@kernel.org>
> CC: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> CC: David S. Miller <davem@davemloft.net>
> CC: Jakub Kicinski <kuba@kernel.org>
> CC: Paolo Abeni <pabeni@redhat.com>
> CC: Netdev <netdev@vger.kernel.org>
> ---
>   MAINTAINERS | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 14e1194faa4b..5d20efb9021a 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -16242,6 +16242,7 @@ F:	mm/truncate.c
>   PAGE POOL
>   M:	Jesper Dangaard Brouer <hawk@kernel.org>
>   M:	Ilias Apalodimas <ilias.apalodimas@linaro.org>
> +R	Yunsheng Lin <linyunsheng@huawei.com>

I think there is missing a colon ":" after "R".

>   L:	netdev@vger.kernel.org
>   S:	Supported
>   F:	Documentation/networking/page_pool.rst
