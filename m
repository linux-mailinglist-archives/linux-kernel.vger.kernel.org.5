Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05A657F9747
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 02:47:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231230AbjK0BoC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Nov 2023 20:44:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjK0BoB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Nov 2023 20:44:01 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6653D119
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 17:44:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701049447;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9Bvi0onyKrPRy//cmVZxUGyJ/FKofWO2WQpLW2x6wuY=;
        b=OhXKHxmUa7iZ0pn0oUe1meDRR5ftLPv7vOuQAZqP06KCht1aRUI2JRPE13bm8vYRINXjyl
        RW1zBX/obu4Ryr0HA21lEEyeIv+LS7x40hiNuY0qTofKs0B83+QlT8Veu7DS51x0zWYWsl
        jwOjh9NZcMJfwXLTHBc4YMGYqFLDzzE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-526-lnm--71tMcKb3DPHjxvYDA-1; Sun, 26 Nov 2023 20:44:04 -0500
X-MC-Unique: lnm--71tMcKb3DPHjxvYDA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9F717811E8D;
        Mon, 27 Nov 2023 01:44:03 +0000 (UTC)
Received: from [10.22.32.84] (unknown [10.22.32.84])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 42F231121307;
        Mon, 27 Nov 2023 01:44:03 +0000 (UTC)
Message-ID: <29e6d420-2d23-4631-bb45-a5de6a5f485b@redhat.com>
Date:   Sun, 26 Nov 2023 20:44:03 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: add include/linux/lockdep*.h
Content-Language: en-US
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        peterz@infradead.org, mingo@redhat.com, will@kernel.org,
        boqun.feng@gmail.com
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <e722abd043e5de64d2acd28d581e4a952994a94e.1700989248.git.christophe.jaillet@wanadoo.fr>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <e722abd043e5de64d2acd28d581e4a952994a94e.1700989248.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/26/23 04:00, Christophe JAILLET wrote:
> Have lockdep_api.h and lockdep_types.h match as well.
>
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>   MAINTAINERS | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index f2b2cd60eb20..2a1480051583 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -12492,7 +12492,7 @@ S:	Maintained
>   T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking/core
>   F:	Documentation/locking/
>   F:	arch/*/include/asm/spinlock*.h
> -F:	include/linux/lockdep.h
> +F:	include/linux/lockdep*.h
>   F:	include/linux/mutex*.h
>   F:	include/linux/rwlock*.h
>   F:	include/linux/rwsem*.h
Acked-by: Waiman Long <longman@redhat.com>

