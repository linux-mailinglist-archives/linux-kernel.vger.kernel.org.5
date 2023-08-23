Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D0ED785508
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 12:12:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233037AbjHWKMM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 06:12:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234390AbjHWITi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 04:19:38 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C696935BF;
        Wed, 23 Aug 2023 01:15:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1692778507;
        bh=UdKH51HqsKN9rWM3wGkZ2xvYLTpyww+HuWDOQXzqjbQ=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=cAnSn0CNF3nmMQf+gdUSihMSHVYsrwwjHFYmTOuENkMgMMYgHA6U+xPEe/XGJ0GYS
         qL77JrqloZH/Anql86ZX7Hiu0QKSLg6CU0fkMsli0ka6NJlX8sO6/4Eyhy/11qzmHk
         3QIhWKAoHDFL5z1FCMAGo9YQm3wiSn6MiPSiuWIw=
Date:   Wed, 23 Aug 2023 10:14:48 +0200 (GMT+02:00)
From:   linux@weissschuh.net
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Robert Marko <robimarko@gmail.com>
Message-ID: <1e1dde74-edc6-4306-9b1b-0a1b5a658b67@weissschuh.net>
In-Reply-To: <20230822184644.18966d0f@kernel.org>
References: <20230822-skb_ext-simplify-v1-1-9dd047340ab5@weissschuh.net> <20230822184644.18966d0f@kernel.org>
Subject: Re: [PATCH net-next] net: generalize calculation of skb extensions
 length
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Correlation-ID: <1e1dde74-edc6-4306-9b1b-0a1b5a658b67@weissschuh.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jakub,


Aug 23, 2023 03:46:48 Jakub Kicinski <kuba@kernel.org>:

> On Tue, 22 Aug 2023 08:51:57 +0200 Thomas Wei=C3=9Fschuh wrote:
>> Remove the necessity to modify skb_ext_total_length() when new extension
>> types are added.
>> Also reduces the line count a bit.
>>
>> With optimizations enabled the function is folded down to a constant
>> value as before.
>
> Could you include more info about the compiler versions you tried
> and maybe some objdump? We'll have to take your word for it getting
> optimized out, would be great if we had more proof in the commit msg.
> --
> pw-bot: cr

Thanks for the feedback.
I'll send a v2 with more background soon.

On the other hand this function is only ever
executed once, so even if it is slightly inefficient
it shouldn't matter.

Thomas
