Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72AF67EB2E7
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 15:58:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233435AbjKNO6C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 09:58:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232211AbjKNO6B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 09:58:01 -0500
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51872126
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 06:57:57 -0800 (PST)
Received: by mail-qk1-x72c.google.com with SMTP id af79cd13be357-7788ebea620so379875885a.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 06:57:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google; t=1699973876; x=1700578676; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0omwKjZO36oOtpVcRUQ8TGf8+sgjpXfzAdK40qZ0DdQ=;
        b=ACBNFO2o1FPi15AQj4/EsQlDiYLergA830rThHmqrnO5mvepfjhMWtnswrA1nBTIvh
         xMvWG2Z4+XnRezwF2HAsc/QqmTH9RFmJhx5NSBJLsQI/esnSpawwjFBuYcMDQp30Bc0f
         Uzx8sV0Q6C/WsRMNAAleQ8Lkdpx+Na1hTzDHA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699973876; x=1700578676;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0omwKjZO36oOtpVcRUQ8TGf8+sgjpXfzAdK40qZ0DdQ=;
        b=eSy+nlrUyY9R0sCUzjs9uZbQ4Y3O41tPmMTaQyVR9WfsRMnNySpE5Trq1v1lKtsfE9
         Fl/iYNmcYKkANpUGc2xRxhfU4F9O+keItdxdLqXuhKN8NUJ/N4qmJADl4Hb21fBhJTjj
         uK3VZImm1izhSuzViuTE8UvrUN6koRW9hhvFlixcMgKczRxinKMfkacBWGtFIR7HkOYD
         9DxKipEDbNbIzYeOuTQmWOj3G34JlHVrrLmtkYD7QxxXedewH7K6G9Z1jAyNNuuDDqnP
         UvQ2JCewtNNxKHh6JvaCNCIb6VoizohF1GFCOzheBNc3lS2mUy820PAD6bnBbam+VS/T
         uRSQ==
X-Gm-Message-State: AOJu0YyxuWbirg5isaqEpWStGA7MSUZiUucizrll5Mxw74w936qnNLE9
        yWnFMKa0FTtKM0S7Ya0BKY02nA==
X-Google-Smtp-Source: AGHT+IEU7mXjd4iwajg3ygSHbWGVpV2vyFg8BCggObCNLgClTkbOomPqo+FLfnN2n9rz7mmRdI+h1g==
X-Received: by 2002:a05:620a:46a1:b0:779:de1c:e547 with SMTP id bq33-20020a05620a46a100b00779de1ce547mr2785860qkb.3.1699973876488;
        Tue, 14 Nov 2023 06:57:56 -0800 (PST)
Received: from [10.211.55.3] ([12.186.190.1])
        by smtp.googlemail.com with ESMTPSA id vr2-20020a05620a55a200b007757fefea79sm2695950qkn.130.2023.11.14.06.57.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Nov 2023 06:57:55 -0800 (PST)
Message-ID: <fea9d86b-54c7-493b-a7bd-8320bc2e8ced@ieee.org>
Date:   Tue, 14 Nov 2023 08:57:54 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] greybus: gb-beagleplay: fix restricted __le16 degrades to
 integer warning
Content-Language: en-US
To:     Ayush Singh <ayushdevel1325@gmail.com>,
        greybus-dev@lists.linaro.org
Cc:     johan@kernel.org, elder@kernel.org, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org,
        kernel test robot <yujie.liu@intel.com>
References: <20231114140103.784484-1-ayushdevel1325@gmail.com>
From:   Alex Elder <elder@ieee.org>
In-Reply-To: <20231114140103.784484-1-ayushdevel1325@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/14/23 8:01 AM, Ayush Singh wrote:
> greybus message header->size are of type __le16, so to fix this warnings
> we are using le16_to_cpu() macros.

This is more than a warning, it's a bug (though it has no
effect with a little-endian native CPU).

I suggest you add:

Fixes: ec558bbfea671 ("greybus: Add BeaglePlay Linux Driver")

Should your hdlc_payload->len field be defined as little-endian?
I've only scanned through this file at this point but I'm thinking
there might be other endianness fixes needed as well.

					-Alex



> 
> Reported-by: kernel test robot <yujie.liu@intel.com>
> Closes: https://lore.kernel.org/r/202311072329.Xogj7hGW-lkp@intel.com/
> Signed-off-by: Ayush Singh <ayushdevel1325@gmail.com>
> ---
>   drivers/greybus/gb-beagleplay.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/greybus/gb-beagleplay.c b/drivers/greybus/gb-beagleplay.c
> index 43318c1993ba..b3f47b5cbbfa 100644
> --- a/drivers/greybus/gb-beagleplay.c
> +++ b/drivers/greybus/gb-beagleplay.c
> @@ -344,7 +344,7 @@ static int gb_message_send(struct gb_host_device *hd, u16 cport, struct gb_messa
>   	dev_dbg(&hd->dev, "Sending greybus message with Operation %u, Type: %X on Cport %u",
>   		msg->header->operation_id, msg->header->type, cport);
>   
> -	if (msg->header->size > RX_HDLC_PAYLOAD)
> +	if (le16_to_cpu(msg->header->size) > RX_HDLC_PAYLOAD)
>   		return dev_err_probe(&hd->dev, -E2BIG, "Greybus message too big");
>   
>   	memcpy(msg->header->pad, &cport, sizeof(cport));

