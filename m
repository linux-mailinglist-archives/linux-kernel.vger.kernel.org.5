Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 865F4767E34
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 12:29:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230476AbjG2K3o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jul 2023 06:29:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjG2K3m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jul 2023 06:29:42 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6C5B10EC;
        Sat, 29 Jul 2023 03:29:41 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id d9443c01a7336-1bb2468257fso17541635ad.0;
        Sat, 29 Jul 2023 03:29:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690626581; x=1691231381;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=26nEHVYnYeLp95zdV1lP7AKLAdrhqC2Fd3XUTK/CPSs=;
        b=fHCzV9oy4MUXDmLhqfZQ153yMK92b3OeWw+7AJOkTmx/jSUdKvNavxJFz/npIDQjg3
         z55oNUVG+Bsj6YxOsHUJHYwOOyAtZ1Y1J5hQygG98M0Ubzi24web6YSk4LVXiEXrjds6
         P7kI++q15bzx+hh24CCS5KkKyXqIEEUBHVZGLlsctPaoQXsLQuMAq0h7LUJYROhUwPEA
         5rFm0nbfq+ApxmsyNbYgCV9BWjjceXPoiQN5A7Qrj5nKW4qK25yUj26h48D48zuOf7nu
         3Z2bcecQPQ50WTkg1hcKhf73IhDHGjSLqHEQBsqkWGyFDrUCmH8XRfAZ+pY4b6CGG+Bs
         BRCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690626581; x=1691231381;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=26nEHVYnYeLp95zdV1lP7AKLAdrhqC2Fd3XUTK/CPSs=;
        b=RDzjpbHzbiRsMoCfECsaMpdRKf1m/IieMLqthED5soqe83yXoHkoVgD85gTZauQDyR
         edbY+XfbSt+t+PqJ5jUL05mRgXMaR2DjNFnOVbMBlYYL0qHUgUrVKowilYcXLXVZTehH
         lUldrUT0n3UWvJ5FYWaGEd6UyvIZr6hJ8UwvjwqzS+10syOog3jt93ehjkeF+LZpf1e2
         ewxjDOb0Z43IXcDZVH/pzPa7stAElfjQGBotm1P2zyCGZ8il2ibBt7Yaz1LZPH5eXaga
         2dna5T7bnWgbJK6a0sU//q/GIBzqR5RdGgPWko0lcwt631MjNlH8xYyy5wlqvXOD9LfZ
         q2tA==
X-Gm-Message-State: ABy/qLbY2hM0XW523qTAaZTcL7LzdXiK0Ny4EJPvsQI45A235mF97ozw
        I+VpS73znXKS7NEp8S6t9+0yDdOV9YfBIw==
X-Google-Smtp-Source: APBJJlEHC+kTQlhUmkRaKWUcHP+RpOs2OoWpFv/faTGmaD9xoiik7cEHm1GP8AusoFc0Q+Sxi0oQvg==
X-Received: by 2002:a17:902:d88d:b0:1b6:af1a:7dd3 with SMTP id b13-20020a170902d88d00b001b6af1a7dd3mr3773219plz.23.1690626581035;
        Sat, 29 Jul 2023 03:29:41 -0700 (PDT)
Received: from [172.23.111.174] ([113.251.0.37])
        by smtp.gmail.com with ESMTPSA id n4-20020a170902e54400b00198d7b52eefsm4979085plf.257.2023.07.29.03.29.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 29 Jul 2023 03:29:40 -0700 (PDT)
Message-ID: <6ae7f65b-593f-75bc-2f34-c08de719b2fc@gmail.com>
Date:   Sat, 29 Jul 2023 18:29:15 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 0/6] docs/zh_TW: update zh_TW's documentation from an
 ascensive aspect
Content-Language: en-US
To:     corbet@lwn.net
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230724041715.20050-1-src.res.211@gmail.com>
From:   Hu Haowen <src.res.211@gmail.com>
In-Reply-To: <20230724041715.20050-1-src.res.211@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/7/24 12:17, Hu Haowen wrote:
> Update zh_TW's documentation concentrating on the following aspects:
> 
>      * The file tree structure changes of the main documentation;
>      * Some changes and ideas from zh_CN translation;
>      * Removal for several obsoleted contents within the zh_TW translation
>        or those which are not exising anymore in the main documentation.
>      * Replacements for some incorrect words and phrases in traditional
>        Chinese or those which are odd within their context being hard for
>        readers to comprehend.
> 
> v2:
>      * Remove the fancy character U+feff (ZERO WIDTH NO-BREAK SPACE) reported by Corbet
>        in https://lore.kernel.org/lkml/87bkg5dp6x.fsf@meer.lwn.net/
> 
> v1:
>      https://lore.kernel.org/lkml/20230720132729.1821-1-src.res.211@gmail.com/

Dear Corbet,

Did you receive my patches? Please get down to them soon because I have
another series of patches pending on until the current patches are
resolved.

Thanks,
Hu Haowen
