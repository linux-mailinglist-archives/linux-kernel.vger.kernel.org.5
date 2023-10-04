Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4A2F7B76FE
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 06:06:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232586AbjJDEEE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 00:04:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232115AbjJDEEC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 00:04:02 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9279AC
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 21:03:58 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 838083200BD9;
        Wed,  4 Oct 2023 00:03:55 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Wed, 04 Oct 2023 00:03:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
         h=cc:cc:content-type:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1696392235; x=
        1696478635; bh=SWFPw/0TEHgJsNbMuYRSrl82EkyqBVdnsb+uJkEkozM=; b=E
        ictTuO+6v9WQ/or0362c5W74YzAgReFIvbZ8pAJ6+M6j8PJD/il4KXzIum3NYEby
        laTklbiYwQ/bTb7NMOpPWWPio1NLE0TdjveqYD/M7ELJDr07z6KVhIJ3URCHGj7/
        L4byZ+HpLQ+OyKOSLyfd7BuJK4V4cmB4KleblbmgEYcuW6vQcqZRRj47pim2NomS
        qVatxrebR6o6Ndc/RHh7ZyrcnKB0kOOm5vNjju81ODSTnEa+LSs5T7+I7LxPAaPx
        Y8sh2WxU8X0LHbpUkNA1lwOE/qjxXVWtGFvGZmOUJf1cKiH+42YJ/Mb8sxfH/688
        IkY439oBsuIDeLJWvSoiw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1696392235; x=1696478635; bh=SWFPw/0TEHgJs
        NbMuYRSrl82EkyqBVdnsb+uJkEkozM=; b=TYmlVbbEeehLmcgEDjVjI7QR+rA/G
        mCEE+cGmWgwxbeFG2VLE6PjCR93LFM0Us44dKm/U6ywjwyKd7qB+Z7g47H/zIo06
        OMSseeZ1CBDK13XgwNJX5tzoXltstCZMj76GT8NUitWbC8WgeqQ8Et9VUTAsavku
        qKAp0Qtw3aDrP9ZtTYzZ0M/DHMWN9HmDm0cle9q9M3O6YC0xe/2Vq7uvTN73Mwr3
        dKkwWBm/isRZ8RopgBXsNc091H3p7Stndsz/Yz8B7Ve2V8s8NyC3iUDxfSjioyhr
        6pmJDt0vQq6GIYWTu0grcD1CQuqn6pd2RD8ium0TjRrKnGqYyE/443wNA==
X-ME-Sender: <xms:KuQcZXas0h1PIRSqLnGrtFLb6JF0aRz-LqbdG5J6zfzUrkqQebCsfw>
    <xme:KuQcZWaOY5JOq49l1vrDT6wSuXzoyBErmm_H_0zv-dW_7BCHzaBMfrhNFihnb0og_
    pldBH25m0sz6nnTvBY>
X-ME-Received: <xmr:KuQcZZ-du3fgP35bSQ2cvzr6Oo5uSVzi3G2-XP3zpJemdwiyOFCEKkunun6dQCVnBbDcmqvEZ8xgJM-y5Y4JLWdrJVoIMHI9HA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrgedtucetufdoteggodetrfdotffvucfrrh
    hofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    epfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepvfgrkhgrshhhihcu
    ufgrkhgrmhhothhouceoohdqthgrkhgrshhhihesshgrkhgrmhhotggthhhirdhjpheqne
    cuggftrfgrthhtvghrnhepveeilefhudekffehkeffudduvedvfeduleelfeegieeljeeh
    jeeuvdeghfetvedvnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvg
    hrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehoqdhtrghkrghshhhisehs
    rghkrghmohgttghhihdrjhhp
X-ME-Proxy: <xmx:KuQcZdpi9v9lmmiZzjLRSaYK4oo46Dom6vZaEaIc3B0uXw3LmkKBqg>
    <xmx:KuQcZSq388GqD3KrmvZK6Pr6C9YsAKG-tX45GnfK4ZZAuk3alVJ-1A>
    <xmx:KuQcZTRV81LIjQiVfpY6M8S4eAZwe1-UP3Ivo9f2R3kQY6i7b45iQQ>
    <xmx:K-QcZZ2_CquhgATFDOsWxnhXu2mhP3gvH74Bo2PZNkFzMvDXYBk-mw>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 4 Oct 2023 00:03:53 -0400 (EDT)
Date:   Wed, 4 Oct 2023 13:03:49 +0900
From:   Takashi Sakamoto <o-takashi@sakamocchi.jp>
To:     Kai Bosch <kellerassel@gmail.com>
Cc:     linux1394-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Kai Bosch <kbosch@protonmail.com>
Subject: Re: [PATCH] Firewire: IP over IEEE 1394: replaced implicit mentions
 of unsigned int
Message-ID: <20231004040349.GA53158@workstation.local>
Mail-Followup-To: Kai Bosch <kellerassel@gmail.com>,
        linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Kai Bosch <kbosch@protonmail.com>
References: <20231003211650.349521-1-kbosch@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231003211650.349521-1-kbosch@protonmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Thanks for your sending the patch.

On Tue, Oct 03, 2023 at 09:16:50PM +0000, Kai Bosch wrote:
> ---
>  drivers/firewire/net.c | 48 +++++++++++++++++++++---------------------
>  1 file changed, 24 insertions(+), 24 deletions(-)
 
As long as I know, the coding style of Linux kernel[1] does not forbidden
brief expression of 'unsigned int' (= just 'unsigned'). Furthermore,
in C language specification, 'unsigned' and 'unsigned int' are the
same[2]. I have no functional change over the patch.

If the intension of patch is in the point of human readability, please
note it in the commit comment. It is the most important for the kind of
change.

I'm waiting for your next post.

[1] Linux kernel coding style
https://www.kernel.org/doc/html/v4.10/process/coding-style.html
[2] See '6.7.2 Type specifiers' in ISO/IEC 9899:1999, so called 'C99'.


Regards

Takashi Sakamoto
