Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9597F786FDC
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 15:03:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237536AbjHXNC7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 09:02:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238145AbjHXNCg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 09:02:36 -0400
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [205.139.111.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 707DC1987
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 06:02:34 -0700 (PDT)
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-74-lZCG3vAwOQyzvKQ69jrznQ-1; Thu, 24 Aug 2023 09:02:30 -0400
X-MC-Unique: lZCG3vAwOQyzvKQ69jrznQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 897078D40A2;
        Thu, 24 Aug 2023 13:02:29 +0000 (UTC)
Received: from hog (unknown [10.39.192.31])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4C42F140E962;
        Thu, 24 Aug 2023 13:02:28 +0000 (UTC)
Date:   Thu, 24 Aug 2023 15:02:27 +0200
From:   Sabrina Dubroca <sd@queasysnail.net>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     linux@weissschuh.net, "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Robert Marko <robimarko@gmail.com>
Subject: Re: [PATCH net-next] net: generalize calculation of skb extensions
 length
Message-ID: <ZOdU432SDOykeDso@hog>
References: <20230822-skb_ext-simplify-v1-1-9dd047340ab5@weissschuh.net>
 <20230822184644.18966d0f@kernel.org>
 <1e1dde74-edc6-4306-9b1b-0a1b5a658b67@weissschuh.net>
 <20230823075318.4860cebc@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230823075318.4860cebc@kernel.org>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2023-08-23, 07:53:18 -0700, Jakub Kicinski wrote:
> On Wed, 23 Aug 2023 10:14:48 +0200 (GMT+02:00) linux@weissschuh.net
> wrote:
> > > Could you include more info about the compiler versions you tried
> > > and maybe some objdump? We'll have to take your word for it getting
> > > optimized out, would be great if we had more proof in the commit msg.
> > > --
> > > pw-bot: cr  
> > 
> > Thanks for the feedback.
> > I'll send a v2 with more background soon.
> > 
> > On the other hand this function is only ever
> > executed once, so even if it is slightly inefficient
> > it shouldn't matter.
> 
> Oh you're right, somehow I thought it was for every alloc.
> You can mention it's only run at init in the commit msg if 
> that's easier.

We could also add __init annotations to skb_ext_total_length and
skb_extensions_init to make that clearer.

-- 
Sabrina

