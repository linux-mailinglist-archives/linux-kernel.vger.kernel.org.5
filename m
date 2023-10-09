Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 885F17BE513
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 17:38:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377854AbjJIPiB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 11:38:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377730AbjJIPhr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 11:37:47 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB99E138;
        Mon,  9 Oct 2023 08:37:19 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 9FE615C037D;
        Mon,  9 Oct 2023 11:37:16 -0400 (EDT)
Received: from imap50 ([10.202.2.100])
  by compute5.internal (MEProxy); Mon, 09 Oct 2023 11:37:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1696865836; x=1696952236; bh=n/
        RImUrhGUlSskecpFuZth4nSILi0fI4B8WAhPM6nNA=; b=A9UkaYTIxgEdYlaJyp
        nwZTqRq27xI1szesIvtaBAOxsr932PXgwVWE5jTi9alLFy3tRdCrT8ciibCKEWwJ
        mvGjiDah1kbGXiziKzDBazmeewTbzLmScvzAS/OvOHTgmqKvY2+Z5cynvF9M+gJJ
        Tn2ueSiWnw0s0o/cqRt0TsHDIMFrSSDIc/Dhg2ptiBHaUmuO5Zxklha7U60viMBQ
        tU4tKhqHKbBL2PktZ0h/WgaXiN+mPtVFVJQelgeh5ldEhFAL5dMc/qUHtnLdhedo
        nuDcHsqykgFwcIqcWxZaBwKcHGOoBsHF0zIbjpWz6PnETjhIzVzdV6EnKTIjBVV2
        xctQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1696865836; x=1696952236; bh=n/RImUrhGUlSs
        kecpFuZth4nSILi0fI4B8WAhPM6nNA=; b=VD2mSF2nDLWkTNwmu8uZYUut8IUwx
        US5Vx1q2Yvrt2+kmFUmkTTuLrk14KUvESIfT/oiARe7bFaIFkLq+uc6bRUf5oklN
        GUC6uNCFXFrLzItmbdPNJFN5oDKxUKgsnzIwKslfitt4mOrsg2Dku+tXY411Bhqg
        o7SKVlt6CbBK49g/LnT1BOJzxQmkN2TFSlEXnhkuUxOKwudmvDWUNl5tidvecJ9C
        o7mPACrHKy0Heig9rR72bRURA3fc9PLVauEQ6HdWEeRSSIZr9gB/Andv4gYPAvrz
        GKcONUveG+aI2szGWjUQ8VJhZvTfg+VGFAO3rU+C8g5VJR6AI6+bvQAyQ==
X-ME-Sender: <xms:Kx4kZcV_NHPm4hqtovSwgAcPaVip2ImLvMHSlq_P0U2vM8Q6C9T3Dg>
    <xme:Kx4kZQmBtx9P7xy8sGi9mv6Ngys8qFbvMn7wx8vWkRXpU8LtevbtcEUr5WY0TS071
    diy0k_5VP7mDhBatMs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrheefgdeludcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedtkeet
    ffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
    hnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:Kx4kZQZfvBhMIMLbpU1SiI-8B57HzvBnU8g5fBaUbpyPrDY24LljKA>
    <xmx:Kx4kZbVF_9d4wLj7tFiWSGLk2IlsjO6hJF04avwkRry3_BtkInez6A>
    <xmx:Kx4kZWkQccWNZA8xEK9fWUdnhdwf5gl0GGowbssJ1oP0T5r4FsWQyg>
    <xmx:LB4kZb_KjUPlyDUU1g5xBskN6fDz3P3FXQVJUbVQcvuo0cjbJ0FEPQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id C45B91700089; Mon,  9 Oct 2023 11:37:15 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-958-g1b1b911df8-fm-20230927.002-g1b1b911d
MIME-Version: 1.0
Message-Id: <2abaad09-b6e0-4dd5-9796-939f20804865@app.fastmail.com>
In-Reply-To: <20231009134826.1063869-1-arnd@kernel.org>
References: <20231009134826.1063869-1-arnd@kernel.org>
Date:   Mon, 09 Oct 2023 17:36:55 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Arnd Bergmann" <arnd@kernel.org>,
        "Marcel Holtmann" <marcel@holtmann.org>,
        "Johan Hedberg" <johan.hedberg@gmail.com>,
        "Luiz Augusto von Dentz" <luiz.dentz@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        "Eric Dumazet" <edumazet@google.com>,
        "Jakub Kicinski" <kuba@kernel.org>,
        "Paolo Abeni" <pabeni@redhat.com>, "Lee, Chun-Yi" <jlee@suse.com>
Cc:     "Kees Cook" <keescook@chromium.org>,
        "Luiz Augusto von Dentz" <luiz.von.dentz@intel.com>,
        stable@vger.kernel.org,
        "Iulia Tanasescu" <iulia.tanasescu@nxp.com>,
        "Wenjia Zhang" <wenjia@linux.ibm.com>,
        linux-bluetooth@vger.kernel.org, Netdev <netdev@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: mark bacmp() and bacpy() as __always_inline
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 9, 2023, at 15:48, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>
> These functions are simple wrappers around memcmp() and memcpy(), which
> contain compile-time checks for buffer overflow. Something in gcc-13 and
> likely other versions makes this trigger a warning when the functions
> are not inlined and the compiler misunderstands the buffer length:
>
> In file included from net/bluetooth/hci_event.c:32:
> In function 'bacmp',
>     inlined from 'hci_conn_request_evt' at 
> net/bluetooth/hci_event.c:3276:7:
> include/net/bluetooth/bluetooth.h:364:16: error: 'memcmp' specified 
> bound 6 exceeds source size 0 [-Werror=stringop-overread]
>   364 |         return memcmp(ba1, ba2, sizeof(bdaddr_t));
>       |                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>
> Use the __always_inline annotation to ensure that the helpers are
> correctly checked. This has no effect on the actual correctness
> of the code, but avoids the warning. Since the patch that introduced
> the warning is marked for stable backports, this one should also
> go that way to avoid introducing build regressions.
>
> Fixes: d70e44fef8621 ("Bluetooth: Reject connection with the device 
> which has same BD_ADDR")
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Lee, Chun-Yi <jlee@suse.com>
> Cc: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> Cc: Marcel Holtmann <marcel@holtmann.org>
> Cc: stable@vger.kernel.org
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Sorry, I have to retract this, something went wrong on my
testing and I now see the same problem in some configs regardless
of whether the patch is applied or not.

     Arnd
