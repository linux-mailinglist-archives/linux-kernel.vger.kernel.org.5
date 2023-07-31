Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27FEB769002
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 10:22:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231356AbjGaIW3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 04:22:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231264AbjGaIVn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 04:21:43 -0400
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21FC3170A;
        Mon, 31 Jul 2023 01:21:36 -0700 (PDT)
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-3fb4146e8deso48693565e9.0;
        Mon, 31 Jul 2023 01:21:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690791694; x=1691396494;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CGrOiQUjR65DkbtD6EqnfPx/Pruzs918gvMQ/Htu0IU=;
        b=fmWJmECZICb1j7AsHvQ+DSk6HnniZRcwSCCSN9NJohukOXWCXxUhHFwVhLdHnhVxO3
         Wuw+FrlzLF99Ok4kwFUArilcJmlFZVn2mZO9qOyyZZlkOdYrjjYKvyvwoM9FNxxSQ6RO
         gX1RRW/qBEF1zK9BPWwU1NMn2VNrKPJ761/E5LShTauoLqKu2eXueFl3vb1uD5yL84yK
         Uy9leb84eqhp4N9s7H1xKJ4weUSggAnQgUtukvm+7ej6iiRocdmRSk5JABD5s2+/CvMH
         3H0CNajFeCc5H5dutVQgBFFMNGhqpEhbFAxb/Jkjk2F+Q+aHgOh9ehJ0dvkFRHYD9HqU
         vp/A==
X-Gm-Message-State: ABy/qLZ+x2gOV0izhEV5WLXjoU5mp2NVSentbhDJE1doX/41Er72qMs0
        pp6AYcBwsbo7SDsCxznvze0=
X-Google-Smtp-Source: APBJJlFhSq9Zp/+1SqFu8GEkJVvPqTbdXliiUNmZnVCfFl4nKgfWFG9TdDL1dgA7/Ygyk/EPvIgzwQ==
X-Received: by 2002:a05:600c:2296:b0:3fe:ad3:b066 with SMTP id 22-20020a05600c229600b003fe0ad3b066mr7565312wmf.41.1690791694356;
        Mon, 31 Jul 2023 01:21:34 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:59? ([2a0b:e7c0:0:107::aaaa:59])
        by smtp.gmail.com with ESMTPSA id b17-20020adfde11000000b003143765e207sm12294324wrm.49.2023.07.31.01.21.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Jul 2023 01:21:33 -0700 (PDT)
Message-ID: <a16816d3-f49e-7c10-e7d3-fdb38fc2fcb7@kernel.org>
Date:   Mon, 31 Jul 2023 10:21:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 00/10] tty: minor cleanups
Content-Language: en-US
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     gregkh@linuxfoundation.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230731080244.2698-1-jirislaby@kernel.org>
 <20230731-dimple-creed-192b053bc4a9-mkl@pengutronix.de>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <20230731-dimple-creed-192b053bc4a9-mkl@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31. 07. 23, 10:15, Marc Kleine-Budde wrote:
> On 31.07.2023 10:02:34, Jiri Slaby (SUSE) wrote:
>>    can: slcan: remove casts from tty->disc_data
> 
> You can do the same for drivers/net/can/can327.c

OK. And in net/nfc/nci/uart.c and that all should be it.

thanks,
-- 
js
suse labs

