Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F12B768B84
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 08:06:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbjGaGGA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 02:06:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbjGaGF7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 02:05:59 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 769BE19A;
        Sun, 30 Jul 2023 23:05:57 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id D81695C0114;
        Mon, 31 Jul 2023 02:05:56 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Mon, 31 Jul 2023 02:05:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1690783556; x=1690869956; bh=n2
        wRoW24j0gLnWuzE6UjK8lJLJEmTRp50vltai64yVg=; b=h9Xd/lU1jK78dcBIAL
        zNwwR1IP3iGnPs+iGlOKE2ryAQ9BbRcrM71HjAgMRuo9lOHsoizmURDU+mThE1O5
        caa5ScNbLRcGXMvnIMW4o6h1/v9yxtVMqKFDLj1I+9TkaBwoXQI2uhEG9AYPlBJl
        Q0qrLmm5hzSxXPjD2m+kxkYPkAXNLPQpXKQbY4b9Xz5HhsZjCZBRu8A0yBIx+nIZ
        3qthTJ9UF1Q2SMNluiw/85eBmO5stBLtbSFe5AFhtKv3H2gf637BOhuvXsvGa8CA
        tc/Qu1Ktc4prMZjhDNMZ/ujAPnWpp/9jn66yW8OCDH50xrLUrhLTvh7gi6ymEnpU
        f5cA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1690783556; x=1690869956; bh=n2wRoW24j0gLn
        WuzE6UjK8lJLJEmTRp50vltai64yVg=; b=kPcuabCPpEFRWBS96eZKgi+DQp1/Y
        crhFUquo8BHzGW4z8zfIuT7b7/vufTnBGhOdH/XOrf6mHgwznzwV4jSL0LCRTcF8
        VVj+Vuz1p8zlT3rnP0+xc4z17LWUE5vhAQwJ1XnmPYBGI1TA/Z0+AlNsLLmLRzEP
        nKm2PArS5X7jLg2gZSrWA7cJYQ7JvqEBjZvW/x5RryRQ/zOqigjD3wFPGjjIn3hK
        iPVN7TuBbXplL6l/+WDaVwmmaYXmZF7Z5a7N6+liO1himXO6mlXFlYlTzGA6ZKNr
        /gC+1IHb1G4jMUwxJsxjcGrxCVq16trI63RvV9Dw+C9K23Cyssu7/xzjQ==
X-ME-Sender: <xms:RE_HZL9MKCCz0CmQ1-QJcAh2kSmMoeSXx0jMfT42RNs5B_vsWKjx2Q>
    <xme:RE_HZHtjJpAP-rI6quB-LYUG3zlro6sIm_PnNOYuMsqI7p_BjKwDpdsRETsaJZG4E
    5uZnBfAUHEv-Q>
X-ME-Received: <xmr:RE_HZJA1fTQzrsdMytRKA-BX8JPbhNBZ3ugFXwlZUBc6uI1_QzIYMlGPyFOz>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrjedvgddutdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepifhrvghg
    ucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnhepgeehue
    ehgfdtledutdelkeefgeejteegieekheefudeiffdvudeffeelvedttddvnecuffhomhgr
    ihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehgrhgvgheskhhrohgrhhdrtghomh
X-ME-Proxy: <xmx:RE_HZHeaEl2SxRzBA6BlogEs0vpV8IMpgYy69KYrRNTw93exNz0Dfg>
    <xmx:RE_HZANzqisCuUImHxKoybeFLY-za0s0VFRIwSyPuFgyohdjATR-3w>
    <xmx:RE_HZJlGktx1xbG8sIdCmWfFZU4RO6pydQa9JRSOL2IUBnxwpxHBcA>
    <xmx:RE_HZBiiJMs5YIxiLlN9H5Pa8Bh-QgFz6ItDn3-vK4HJO-8CamBsYA>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 31 Jul 2023 02:05:56 -0400 (EDT)
Date:   Mon, 31 Jul 2023 08:05:52 +0200
From:   Greg KH <greg@kroah.com>
To:     Atul Raut <rauji.raut@gmail.com>
Cc:     kvalo@kernel.org, linux-kernel-mentees@lists.linuxfoundation.org,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ath6kl: Replace zero-length arrays with
 DECLARE_FLEX_ARRAY() helper
Message-ID: <2023073103-basket-ranking-b6e6@gregkh>
References: <20230731012941.21875-1-rauji.raut@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230731012941.21875-1-rauji.raut@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 30, 2023 at 06:29:41PM -0700, Atul Raut wrote:
> Because zero-length arrays are obsolete, replacing them with
> C99 flexible-array members.
> Instead of defining a zero-length array, use the new
> DECLARE_FLEX_ARRAY() auxiliary macro.
> 
> This fixes warnings such as:
> ./drivers/net/wireless/ath/ath6kl/usb.c:109:8-12: WARNING use flexible-array member instead (https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays)
> 
> Signed-off-by: Atul Raut <rauji.raut@gmail.com>
> ---
>  drivers/net/wireless/ath/ath6kl/usb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/wireless/ath/ath6kl/usb.c b/drivers/net/wireless/ath/ath6kl/usb.c
> index 5220809841a6..bb3771a3897c 100644
> --- a/drivers/net/wireless/ath/ath6kl/usb.c
> +++ b/drivers/net/wireless/ath/ath6kl/usb.c
> @@ -106,7 +106,7 @@ struct ath6kl_usb_ctrl_diag_cmd_write {
>  	__le32 cmd;
>  	__le32 address;
>  	__le32 value;
> -	__le32 _pad[1];
> +	DECLARE_FLEX_ARRAY(__le32, _pad);

This is not a 0 length array, or a variable array.  Look at the work
done on the hardening mailing list for more details, I think this is
wrong.

good luck!

greg k-h
