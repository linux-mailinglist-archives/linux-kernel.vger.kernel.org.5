Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E13677547E
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 09:54:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230458AbjHIHyc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 03:54:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229940AbjHIHya (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 03:54:30 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FDC91981;
        Wed,  9 Aug 2023 00:54:29 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 039675C0131;
        Wed,  9 Aug 2023 03:54:29 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Wed, 09 Aug 2023 03:54:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1691567668; x=1691654068; bh=DH
        c7EanQeNX/QQ/uq+f3JdAK4tpVBLXjKe3azii2mx4=; b=v8sBC55pPEOLE9a2kA
        zYr4BcIUgk7BOI1wc2HRD78kduQLTOFWL48ALFAAJkeaRmmRnoO56fzEZslOWhiW
        kY/RJ/0YwOeuWIR7ie9XFMKoST67MNhUowEXCXwkiJ5O2cAOQCXeg2RUC/eBdK10
        9tw2fgKRVL3aIExk3hpVXx1+B1RBnJo5pI+iFnGOYFGb+gDOOltW0nG8jxe+bkWN
        jAF+aCV/P2FvS/xBbKYgU0hMY+Ah22DF8iQmXpRBg6xoWcjnU5rEY/Y7ab3C0yUR
        ZS/4ZXBthtU1KmT0ToZ5FHaZI3MlsaG+WSIHtEVzEj67fOs5vD/ev36KXew2XJyg
        U7UA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1691567668; x=1691654068; bh=DHc7EanQeNX/Q
        Q/uq+f3JdAK4tpVBLXjKe3azii2mx4=; b=JPKklhIJlY22KrylRBkrUlJFXZOBT
        5UpEsut9FHeqYMOMG9C8o62muyaQC+0SN+9IkMbAdViOWkXKbVPCecuGsGmYRDK+
        nsf5EEP7qAs14uAqW9LFEpZ/cK2JJxsv0vtOqw9DhbOxFGawG04ohOO6vVbLefZZ
        FYI7cwvgsc8DauTQN8QDJbPYPQXsFkBufX12epUr53hm+43g+olhCY2SSJhXauS7
        +lm2tUebBPjcRGYUMr+UmvJKTpr7+FCvHdooP+0Z9FGxqz6YladryKH0PSSn+jLR
        PcN/qO1x49C3UydG1IQCvqZFAw59CbsH6GwXV7vTPnOYJUakseVY7xOfA==
X-ME-Sender: <xms:NEbTZGRfyUkUmHnpD1ObV82PXt4u_Z0AUE0KPKNT5sRS7T9R933CJg>
    <xme:NEbTZLyRl0ZSOdTw1diXaUiD5F5-BFtvFvDB6DFlr8G4RcEacq7Se2GY5YowpjMBD
    Dkbiwwos_qlYA>
X-ME-Received: <xmr:NEbTZD1NKJRyt7U_1qBPVD14Jvu-dNj2VGDjAjKTHuSsJrbaQy56S0FUy2krDL7tpDw_cvLKfi2J2gshz5VJd15awZY6Ite-KqhKQw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrleefgdduvdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepifhrvghg
    ucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnhepheegvd
    evvdeljeeugfdtudduhfekledtiefhveejkeejuefhtdeufefhgfehkeetnecuvehluhhs
    thgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepghhrvghgsehkrhhorg
    hhrdgtohhm
X-ME-Proxy: <xmx:NEbTZCAdral-z7-wspUUvsVDzdOwcOT35DhTjDN66hbaUrHhbKCIsw>
    <xmx:NEbTZPjqo5y3QtCEvLyRyUxCBXC_NWHJ960bpJjjvJNT30he-wyMjw>
    <xmx:NEbTZOp3bCRwdallPE2sWgsknv03nyLquveedrZFkMqpLI9jN1szYw>
    <xmx:NEbTZP58N0MQDg9tYVHcXX8LnCMZGz4sR2In240x6g9wWDw4r6ePog>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 9 Aug 2023 03:54:28 -0400 (EDT)
Date:   Wed, 9 Aug 2023 09:54:26 +0200
From:   Greg KH <greg@kroah.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Networking <netdev@vger.kernel.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the tty tree with the net-next tree
Message-ID: <2023080917-deafness-fanfare-f6cb@gregkh>
References: <20230809134051.1167e40d@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230809134051.1167e40d@canb.auug.org.au>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 09, 2023 at 01:40:51PM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the tty tree got conflicts in:
> 
>   arch/powerpc/platforms/8xx/mpc885ads_setup.c
>   arch/powerpc/platforms/8xx/tqm8xx_setup.c
> 
> between commit:
> 
>   33deffc9f19f ("net: fs_enet: Don't include fs_enet_pd.h when not needed")
> 
> from the net-next tree and commit:
> 
>   a833b201d908 ("serial: cpm_uart: Don't include fs_uart_pd.h when not needed")
> 
> from the tty tree.
> 
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.

Fix looks good to me, thanks!

greg k-h
