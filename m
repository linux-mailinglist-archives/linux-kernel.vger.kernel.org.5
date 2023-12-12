Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0758A80EBA5
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 13:24:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232296AbjLLMYN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 07:24:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230055AbjLLMYM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 07:24:12 -0500
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11878C3;
        Tue, 12 Dec 2023 04:24:18 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2ca2573d132so70921021fa.0;
        Tue, 12 Dec 2023 04:24:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702383856; x=1702988656; darn=vger.kernel.org;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=1ZVZWM9e8YBZqep1rmFbMgHvWIEA71KL+wfFhrMdLLQ=;
        b=iYsi7mxAYpMuFS6LwkpXhkQYZc9bfir6/3TtemB5Xa+TyFoSyogFVmqx3bG0aN/fGB
         w68ST4aTAjBJ0Nsn7GfM/V0El5N7WS1pp2gEigMI+2GOXZjw+GZgnQJPKz+MKfz0w9yC
         qXfd/Y6F/ZMPEbSuwCOTZQgJWp98FqTDw8GI/r0bIbFY/Ta+8TQZ8HI+TuyoXzBTgeUb
         P95fLS0QVQ3IE0dkHJcoKwtusy239BdM60NotG/tcaKGSTOSMnS5sGKWiP5+ye9gVnlW
         2I9fNZTdd+9taJ1wl/ezGCkENFPzjPo9dBh5rTXsAh9EeVSRrWBGz2iOG8F9oBVzAeb7
         foeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702383856; x=1702988656;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1ZVZWM9e8YBZqep1rmFbMgHvWIEA71KL+wfFhrMdLLQ=;
        b=wa9zJIzMPU7EdZuZThAlZ1qLaw47SiBniaJP3NPVuOiuc7qx+80v9i30E2uPaeKbQ4
         ZRT0eK1j8Ralm5VLhTWzO7A3JVAMSM4eipAsY1AA69a3fMtZNLDuRZttG1WZBIjmOaX2
         D5tll4P+artJeSe/2O8iChUC1JxFMbKG3yKtqE3gqQnar9o38jRpwquwEe/fydVfDGzy
         PF2D89F7CW4oglkZ/jWxkqQhUS2A/Arjjrx7W2jMXaSxmUZrgA0g9FRihvj6W43j+qQq
         KqQToKoGQoWfqnZKaCGutU0KVfGyV/ah14hh4x1vdGpgPQa5bVVZgvN8x7DTeOQi7U0u
         KWVQ==
X-Gm-Message-State: AOJu0YwaaAqaHSs5NN6DTB70fCVRGfUQJKG3zZ+38XR0JjsrBa25TpsE
        LbodeQHyG+Q5o3CmUtiayZ2Rz/XDVoCemyM+
X-Google-Smtp-Source: AGHT+IF9coVJbPpQSGt+xDlllVc9s8rwTIhi+78jH5wFIHS9b7GMbwahf6Y07+lJ+5xF0sVe/0eGgw==
X-Received: by 2002:ac2:4a7c:0:b0:50b:f07f:5308 with SMTP id q28-20020ac24a7c000000b0050bf07f5308mr3008857lfp.122.1702383855944;
        Tue, 12 Dec 2023 04:24:15 -0800 (PST)
Received: from razdolb (95-24-149-38.broadband.corbina.ru. [95.24.149.38])
        by smtp.gmail.com with ESMTPSA id v25-20020ac25939000000b0050bef1c5b39sm1355454lfi.61.2023.12.12.04.24.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 04:24:15 -0800 (PST)
References: <20231211175023.1680247-1-mike.rudenko@gmail.com>
 <20231211175023.1680247-3-mike.rudenko@gmail.com>
 <20231211180142.GA27535@pendragon.ideasonboard.com>
User-agent: mu4e 1.10.7; emacs 29.1
From:   Mikhail Rudenko <mike.rudenko@gmail.com>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: Re: [PATCH 02/19] media: i2c: ov4689: Fix typo in a comment
Date:   Tue, 12 Dec 2023 15:22:40 +0300
In-reply-to: <20231211180142.GA27535@pendragon.ideasonboard.com>
Message-ID: <8734w7r4lt.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2023-12-11 at 20:01 +02, Laurent Pinchart <laurent.pinchart@ideasonboard.com> wrote:

> On Mon, Dec 11, 2023 at 08:50:05PM +0300, Mikhail Rudenko wrote:
>> Fix a spelling error in a comment.
>>
>> Signed-off-by: Mikhail Rudenko <mike.rudenko@gmail.com>
>
> Starting with the easy one,
>
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
>

Hi Laurent,

and thanks for the review!

>> ---
>>  drivers/media/i2c/ov4689.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/media/i2c/ov4689.c b/drivers/media/i2c/ov4689.c
>> index ff5213862974..53dcfc8685d4 100644
>> --- a/drivers/media/i2c/ov4689.c
>> +++ b/drivers/media/i2c/ov4689.c
>> @@ -692,7 +692,7 @@ static int ov4689_set_ctrl(struct v4l2_ctrl *ctrl)
>>
>>  	switch (ctrl->id) {
>>  	case V4L2_CID_EXPOSURE:
>> -		/* 4 least significant bits of expsoure are fractional part */
>> +		/* 4 least significant bits of exposure are fractional part */
>>  		ret = ov4689_write_reg(ov4689->client, OV4689_REG_EXPOSURE,
>>  				       OV4689_REG_VALUE_24BIT, ctrl->val << 4);
>>  		break;


--
Best regards,
Mikhail Rudenko
