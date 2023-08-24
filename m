Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E04F786827
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 09:14:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240298AbjHXHOY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 03:14:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240217AbjHXHOF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 03:14:05 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F318E4B;
        Thu, 24 Aug 2023 00:14:02 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id A424F5C00DD;
        Thu, 24 Aug 2023 03:13:59 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Thu, 24 Aug 2023 03:13:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1692861239; x=1692947639; bh=0M
        1ggo+Y5uf7UUVSVo0EZMwFgA9JMrcAzE/eU4EniSg=; b=mH1VKkNFAk/EotMeC/
        eybnamqF4p4Jd5Glywnp+vEbXM2RtRuWwM6l8lhYD+jcmReG78yWAAuvgHzg7OXv
        G0HMtJFKbCndygI2vqMP6ThULjxlDKnpGDE3LCTd9f96UW71NNPXaiWmsIugz8m4
        NwJBCvnv/SnG3H5PkjOTD8xmruv7WPKQkY/+MvOGTqpY5uWE522TTHcBtpzB6gXn
        P2BnmlZYj26cYb1hk7sPAfWMdBq8KAUy8e5Y8VgjGTOGB7y2mJUJLC4c3bYwz+Vn
        rG7/x8Dp64akDA8AKm7Fu7v3bvg9ihipAFG/A+ICrW9Mg22yz+s+vI69JOP88Hej
        dOoQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1692861239; x=1692947639; bh=0M1ggo+Y5uf7U
        UVSVo0EZMwFgA9JMrcAzE/eU4EniSg=; b=f7Pgqc9dTkJixdZ88VhyBjFH/DdIv
        q0FIdrBU/A6lMB3BDVzypp5O+cEjHfKnQwqQnlnqSduYE+0UyjxMXz/l2Xo7dQDC
        vj9rXcm2g8U1NnQs5GuKaWZdNenWpuRomUFoTr6BcVOkLAndty9V8gwrF7PN+LK5
        CWzW8ikcCryreQDkr1w6+Qmj23HtSOMdhytDT4GRyxSvKtBp+HIwW/pkJJW6ymtt
        dyPt3dJFeVhH5ldUuGrZlgd9bDJBIgFpn8tMvO9PxZqKdQcB4doHbmUVN13R0m+I
        rm1z74IztXJud9NUHy/6Vis9/xvAEdUZRRtJsX9t1wFHPVamNqfNCHZiQ==
X-ME-Sender: <xms:NwPnZJ5OZn36HEz27Dz03ZSPDU26oHkTMywluqbvXUNgsgPdNEZ9Ug>
    <xme:NwPnZG6JzxTB7l-blrTkCWRrtfMlK_pIvxNs1nGNhOBIiXYc8A0HGp40TrhQkne6w
    oQt7WrQH5hN4w>
X-ME-Received: <xmr:NwPnZAewnl6GqlqyyAdimjYxb0PSTNYf7B6ju7KBqp4y2hEdMfsOSFSDDy1VPl1PN_HTtpCEHMy0ABJx7nDQVEf6AJYDjOzdJMVh6A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedruddvhedgudduiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesth
    dtredttddtvdenucfhrhhomhepifhrvghgucfmjfcuoehgrhgvgheskhhrohgrhhdrtgho
    mheqnecuggftrfgrthhtvghrnhephfeugfdthfeijeekveekuefgudfgffevhfehgeehvd
    ehheetlefgkedtlefghefgnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghdpshihiihk
    rghllhgvrhdrrghpphhsphhothdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskhhrohgrhhdrtghomh
X-ME-Proxy: <xmx:NwPnZCKpDnnNrxpQjgspKw5xYozl9nTfAhFSqSePwTUVhFOHdbYiKg>
    <xmx:NwPnZNJTzlqxYZg_sxq3ctseECddogb1NhXBI0P4GCdLzEHN94BSng>
    <xmx:NwPnZLz4pusTJ-edvs_P6FiymCqwDsaEwZJH8LK5jI0xFyc5muqdNg>
    <xmx:NwPnZPhr4VOwAZrkt29wC6cfAmZoVFammo5ZDAXUvt3HAL6m-y030w>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 24 Aug 2023 03:13:58 -0400 (EDT)
Date:   Thu, 24 Aug 2023 09:13:54 +0200
From:   Greg KH <greg@kroah.com>
To:     coolrrsh@gmail.com
Cc:     hverkuil@xs4all.nl, mchehab@kernel.org, slark_xiao@163.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        syzbot+e27f3dbdab04e43b9f73@syzkaller.appspotmail.com
Subject: Re: [PATCH v2] UBSAN: shift-out-of-bounds in set_flicker
Message-ID: <2023082425-argue-tartar-4652@gregkh>
References: <20230824070630.8209-1-coolrrsh@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230824070630.8209-1-coolrrsh@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 24, 2023 at 12:36:30PM +0530, coolrrsh@gmail.com wrote:
> From: Rajeshwar R Shinde <coolrrsh@gmail.com>
> 
> Syzkaller reported the following issue:
> 
> UBSAN: shift-out-of-bounds in drivers/media/usb/gspca/cpia1.c:1031:27
> shift exponent 245 is too large for 32-bit type 'int'
> 
> shift-out-of-bounds error was triggered when variable 
> 'sd->params.exposure.gain' is greater than the number of bits of int.
> When the variable 'currentexp' is left shifted beyond 31 bits then
> the error is produced. Therefore added the conditional expression to 
> verify valid range.
> 
> Tested via syzbot.
> 
> Reported-by: syzbot+e27f3dbdab04e43b9f73@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/all/20230818164522.12806-1-coolrrsh@gmail.com
> 
> Link: https://syzkaller.appspot.com/bug?extid=e27f3dbdab04e43b9f73
> 
> Signed-off-by: Rajeshwar R Shinde <coolrrsh@gmail.com>

Please do not have blank lines beween these tags.

You also have trailing whitespace in your changelog text :(

> ---
> v1->v2
> changed the patch
> changed commit message and tested with checkpatch 
> 
> ---
>  drivers/media/usb/gspca/cpia1.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/media/usb/gspca/cpia1.c b/drivers/media/usb/gspca/cpia1.c
> index 46ed95483e22..dafc522d5e7b 100644
> --- a/drivers/media/usb/gspca/cpia1.c
> +++ b/drivers/media/usb/gspca/cpia1.c
> @@ -1028,6 +1028,8 @@ static int set_flicker(struct gspca_dev *gspca_dev, int on, int apply)
>  			sd->params.exposure.expMode = 2;
>  			sd->exposure_status = EXPOSURE_NORMAL;
>  		}
> +		if (sd->params.exposure.gain > 31)
> +			return -1;

Do not make up error codes, please return a valid one and not a random
negative number.  Unless -1 is a valid value for this function?

thanks,

greg k-h
