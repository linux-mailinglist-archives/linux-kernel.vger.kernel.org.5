Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD87577B1AC
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 08:36:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233792AbjHNGfk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 02:35:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233764AbjHNGfH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 02:35:07 -0400
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0DF7120;
        Sun, 13 Aug 2023 23:35:06 -0700 (PDT)
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-3fe2fb9b4d7so35883695e9.1;
        Sun, 13 Aug 2023 23:35:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691994905; x=1692599705;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RvWL5ygYvQg4iADeTfZupGHf1uoCsOcnieToDywIMF8=;
        b=UV2MlgHqmXsdgWEJPewLiLd/Qq8HJ8GQz1rJobcymXjT30P/YfLh9VBIYKBuBjoQ9H
         ztacER4Dej777ZXUFo8sWw8sgSAA8Lxls9aUk2/5upoI+g3wjqt9XjReRuFN3U6H5TnH
         3kkRcb46VANVOZAdesMcujTc25GanTYi7gfQWG152whcPpCSuT2u7YSVRTUibgSGL83O
         0pWKG5IAsu0J1a5+BPsUkOEvcmPQhJEmwO/fSYXji27oAw1Puua16ZiDOdBj0bPPzZZG
         GNaUr28e1ALe7btKTufjSlHzfPowNoyvW4lPjHgd/CLFloE3DTsBfiBAo8/1EXct2VkA
         MlHA==
X-Gm-Message-State: AOJu0YxZhU+upjJHSjCPwiKjZcf+WVx69aWlvPl66LVLW74XQhWJQA82
        Hz7wfwpk+Qf93hpLRnMs774=
X-Google-Smtp-Source: AGHT+IFSLnyuj2XZMk1c4S6atLVobotH9Gyp+NX4zDJgbN8A4MH+17FO4bIhZQqECGNiK7f3LHACHA==
X-Received: by 2002:a05:600c:280b:b0:3fe:16c8:65fa with SMTP id m11-20020a05600c280b00b003fe16c865famr6874601wmb.4.1691994905047;
        Sun, 13 Aug 2023 23:35:05 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:59? ([2a0b:e7c0:0:107::aaaa:59])
        by smtp.gmail.com with ESMTPSA id h1-20020adffd41000000b0030ae499da59sm13448501wrs.111.2023.08.13.23.35.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 13 Aug 2023 23:35:04 -0700 (PDT)
Message-ID: <79d93731-74ca-d6b5-b31e-87a49153e8ab@kernel.org>
Date:   Mon, 14 Aug 2023 08:35:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 16/36] tty: use u8 for chars
Content-Language: en-US
To:     =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        William Hubbs <w.d.hubbs@gmail.com>,
        Chris Brannon <chris@the-brannons.com>,
        Kirk Reiser <kirk@reisers.ca>,
        Samuel Thibault <samuel.thibault@ens-lyon.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, Max Staudt <max@enpas.org>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Andreas Koensgen <ajk@comnets.uni-bremen.de>,
        Jeremy Kerr <jk@codeconstruct.com.au>,
        Matt Johnston <matt@codeconstruct.com.au>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Peter Ujfalusi <peter.ujfalusi@gmail.com>
References: <20230810091510.13006-1-jirislaby@kernel.org>
 <20230810091510.13006-17-jirislaby@kernel.org>
 <27366cad-30b2-e326-8d8f-c6fe17cf4899@linux.intel.com>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <27366cad-30b2-e326-8d8f-c6fe17cf4899@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11. 08. 23, 12:28, Ilpo Järvinen wrote:
> On Thu, 10 Aug 2023, Jiri Slaby (SUSE) wrote:
> 
>> This makes all those 'unsigned char's an explicit 'u8'. This is part of
>> the continuing unification of chars and flags to be consistent u8.
>>
>> This approaches tty_port_default_receive_buf(). Flags to be next.
...>> diff --git a/include/linux/tty_buffer.h b/include/linux/tty_buffer.h
>> index 6ceb2789e6c8..6f2966b15093 100644
>> --- a/include/linux/tty_buffer.h
>> +++ b/include/linux/tty_buffer.h
>> @@ -22,9 +22,9 @@ struct tty_buffer {
>>   	unsigned long data[];
>>   };
>>   
>> -static inline unsigned char *char_buf_ptr(struct tty_buffer *b, int ofs)
>> +static inline u8 *char_buf_ptr(struct tty_buffer *b, int ofs)
>>   {
>> -	return ((unsigned char *)b->data) + ofs;
>> +	return ((u8 *)b->data) + ofs;
>>   }
> 
> Any particular reason why b->data is left unsigned long?

Nope :):
https://git.kernel.org/pub/scm/linux/kernel/git/jirislaby/linux.git/commit/?h=devel&id=57c9d0cbe1ad69957a2092b66dc31dc1da4d1d4b

I am dumb not mentioning it in 00/36, see my e-mail there.

thanks,
-- 
js
suse labs

