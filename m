Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71F00787F49
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 07:34:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232159AbjHYFeS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 01:34:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232037AbjHYFds (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 01:33:48 -0400
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE8C2198E;
        Thu, 24 Aug 2023 22:33:45 -0700 (PDT)
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5230a22cfd1so769289a12.1;
        Thu, 24 Aug 2023 22:33:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692941624; x=1693546424;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EinPb1gqc6wVAwHvf5ANWNWV9ybtUjcZw0hI0QOAiKI=;
        b=EqgNHxZbBLpz86PdKGLgKyKeIxibUmKq5S+UTgmso4ueXbeOQjWcq+VSUbq/mo+qUa
         HIj30C56/cOl9lWeZftsL0XK9hIxS79V7MF1sDkT92afIIG5Foirm6T0eelIrtZ92/DQ
         5yzBaZjALUefA4vYUwsS3bEieQWSbwnoyVPcdUe2mifmHRIFjCUszIKxWbIjGskopd63
         lBmlXjZc+KXSlaxSuIgsjpHC1HfRVg9e0EbKRjPQM2qCImSi/yLxAN/W/b4494M0gWsn
         l67YdTfhO/GwmLK8jnT1vEiT6SSRHyFFYkMVvpVjHuSVctF7u/q0mfBS5ktqzX/1mT2j
         R6Cw==
X-Gm-Message-State: AOJu0YxD8nHFh07YejCXQ453kQTTpeAs9RCO6I+Ecs8OoyOKgU2tYkaP
        dae3Hw0Fi90XzpwN1FTcQSc=
X-Google-Smtp-Source: AGHT+IFfeSK/0G8/XxZakxZnT8wHMuaJDVecTFoSrtldfH7WJxUJmjt9Ja+/lOgYH/YTJVSDgF3p7w==
X-Received: by 2002:a17:906:1444:b0:99b:c845:791d with SMTP id q4-20020a170906144400b0099bc845791dmr12494645ejc.76.1692941623971;
        Thu, 24 Aug 2023 22:33:43 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:59? ([2a0b:e7c0:0:107::aaaa:59])
        by smtp.gmail.com with ESMTPSA id rk17-20020a170907215100b00988c0c175c6sm526549ejb.189.2023.08.24.22.33.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Aug 2023 22:33:41 -0700 (PDT)
Message-ID: <2a3647bf-91a8-7a5f-9edb-c792a6031f57@kernel.org>
Date:   Fri, 25 Aug 2023 07:33:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH] docs: ABI: sysfs-tty: close times are in hundredths of a
 second
Content-Language: en-US
To:     Simon Arlott <simon@octiron.net>, Oliver Neukum <oneukum@suse.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-serial@vger.kernel.org
References: <ea1a13ad-a1e0-540a-e97a-4c44f6d2d33b@0882a8b5-c6c3-11e9-b005-00805fc181fe.uuid.home.arpa>
 <40c5c70f-46ff-c5f3-212b-2badc47e49a3@0882a8b5-c6c3-11e9-b005-00805fc181fe.uuid.home.arpa>
 <27304225-c8b0-9cac-94a3-e985e45aa41a@0882a8b5-c6c3-11e9-b005-00805fc181fe.uuid.home.arpa>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <27304225-c8b0-9cac-94a3-e985e45aa41a@0882a8b5-c6c3-11e9-b005-00805fc181fe.uuid.home.arpa>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24. 08. 23, 9:18, Simon Arlott wrote:
> The times for close_delay and closing_wait are in hundredths of a
> second, not milliseconds. Fix the documentation instead of trying
> to use millisecond values (which would have to be rounded).
> 
> Signed-off-by: Simon Arlott <simon@octiron.net>
> ---
> If you'd prefer, I can fold the second part of this into my previous
> patch which shouldn't have documented it as milliseconds in the first
> place (but I copied it from the other entry).
> 
>   Documentation/ABI/testing/sysfs-tty | 12 ++++++++----
>   1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-tty b/Documentation/ABI/testing/sysfs-tty
> index e04e322af568..6ee878771f51 100644
> --- a/Documentation/ABI/testing/sysfs-tty
> +++ b/Documentation/ABI/testing/sysfs-tty
> @@ -87,7 +87,8 @@ What:		/sys/class/tty/ttyS<x>/close_delay
>   Date:		October 2012
>   Contact:	Alan Cox <alan@linux.intel.com>
>   Description:
> -		 Show the closing delay time for this port in ms.
> +		 Show the closing delay time for this port in hundredths
> +		 of a second.
>   
>   		 These sysfs values expose the TIOCGSERIAL interface via
>   		 sysfs rather than via ioctls.
> @@ -96,7 +97,8 @@ What:		/sys/class/tty/ttyS<x>/closing_wait
>   Date:		October 2012
>   Contact:	Alan Cox <alan@linux.intel.com>
>   Description:
> -		 Show the close wait time for this port in ms.
> +		 Show the close wait time for this port in hundredths of
> +		 a second.
>   
>   		 These sysfs values expose the TIOCGSERIAL interface via
>   		 sysfs rather than via ioctls.

Could you send these two hunks as a separate patch? It's correct 
regardless of your other patch.

And I would use "centiseconds" instead, which is used (IMO) in these cases.

thanks,
-- 
js
suse labs

