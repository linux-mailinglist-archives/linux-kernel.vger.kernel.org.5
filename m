Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86D9180AB70
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 18:57:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574576AbjLHR5o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 12:57:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233796AbjLHR5m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 12:57:42 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DB42FA
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 09:57:49 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D37FC433C8;
        Fri,  8 Dec 2023 17:57:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702058269;
        bh=MZC8OXd/xhYpQFY9QXSMpIHOKQcKILf1nuFEeLx1Z1k=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=IrhW+No2LIvscdmhlUWqrjJiqbzeddYeZMlOvgrxLv9Pp/gv65XNGK+d/kQvyt9F8
         eWeHCO3AAqSqLgKmc7Ik62hbdVifPyu/Z9BpeaTSYwEumWm4CM5RdsEVq3wTqAc8Yt
         0Mtxfy6ckCdT2CkRx53DyJYDR5tIlMzrGiRqLFkqVd6vRp5p0uaNNgnc/icx60AhME
         T4jAdjX/YdISDa0zROBRF880qcvvvYg4KCcH3HTEvBilmN+djnGudGA6yjwLQu61zC
         QQA9Js/3CQoJWElJJO/mXVHwonG1Z2FbVz8Cwm/aqWQC4pxhlM1WCn1Hu4n/x0J3l+
         Hql17ZKbnZbkA==
Message-ID: <3fea9ae9-e9e6-4ba5-812b-2775a6ed9e6a@kernel.org>
Date:   Fri, 8 Dec 2023 10:57:47 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next v1 00/16] Device Memory TCP
Content-Language: en-US
To:     Mina Almasry <almasrymina@google.com>,
        Shailend Chand <shailend@google.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org,
        bpf@vger.kernel.org, linux-media@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Jeroen de Borst <jeroendb@google.com>,
        Praveen Kaligineedi <pkaligineedi@google.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Shuah Khan <shuah@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Yunsheng Lin <linyunsheng@huawei.com>,
        Harshitha Ramamurthy <hramamurthy@google.com>,
        Shakeel Butt <shakeelb@google.com>
References: <20231208005250.2910004-1-almasrymina@google.com>
From:   David Ahern <dsahern@kernel.org>
In-Reply-To: <20231208005250.2910004-1-almasrymina@google.com>
Content-Type: text/plain; charset=UTF-8
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

On 12/7/23 5:52 PM, Mina Almasry wrote:
> Major changes in v1:
> --------------
> 
> 1. Implemented MVP queue API ndos to remove the userspace-visible
>    driver reset.
> 
> 2. Fixed issues in the napi_pp_put_page() devmem frag unref path.
> 
> 3. Removed RFC tag.
> 
> Many smaller addressed comments across all the patches (patches have
> individual change log).
> 
> Full tree including the rest of the GVE driver changes:
> https://github.com/mina/linux/commits/tcpdevmem-v1
> 

Still a lot of DEVMEM references (e.g., socket API). Any reason not to
move those to DMABUF?

