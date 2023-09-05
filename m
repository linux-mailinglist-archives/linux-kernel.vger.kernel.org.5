Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B098792C1C
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 19:10:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353942AbjIERGw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 13:06:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356017AbjIEQbw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 12:31:52 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17D2E1FDF;
        Tue,  5 Sep 2023 09:29:08 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id 98e67ed59e1d1-26fe4997871so1337468a91.3;
        Tue, 05 Sep 2023 09:29:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693931278; x=1694536078; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0lXaZC4lJgr9JMdxNZHELcwQzbUjuJdgxkRaJXVL56E=;
        b=dI1yIOJ7f/gKrBLYTC8kLvhDaiv45hoSjTOYqIUmfw8exnOouryHfzBsi0jH7/LRgE
         zNe04XWrWluOz0gBMteD0jCEaWhdulvADUuFLMrnSqXXqpwuwfNPG80ZK/kQCdo1iUvA
         x3bHHQuGsNsDo8mk2Kh8CH+xPM7StKt8XNL4kLz+9jI2uagzVOAIP16Ns9rT36pW//wP
         TAswtbCgWiwnr1zOfk94l1XCPnGIbvF5BhgmdoBHkOGZmoUDxHtjhRJjrZviAhRlL2Jo
         mexAdDGkn5iib+ZubMT7dM36ZptrQQHenJFbU8Xb/3LFHTYZSRmScSsHqJa8aY8tOqPQ
         o8dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693931278; x=1694536078;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0lXaZC4lJgr9JMdxNZHELcwQzbUjuJdgxkRaJXVL56E=;
        b=ho7XILYpNDWDBPUmi7pwYl0c9+5FYGfPE0kK2KZbJSPDbo/HjHt8j8B6Zfc9RbaK46
         8qElKLtBukEHgytDtX0CrigJ/IbtlsgVrQJv3ROV3xhONwf7VUqKLzd4oFx2+L2J+qKZ
         XiLryrrzn/BIIQNjtOTWe9XXmZFxZ3BBVEeKIJkfNg1oONV9xV0ANAwcBpnGJN0oGA8+
         6arNKOP9TNTKDvgFtNKE/8nDr6PyrVOHts+zZK3o1/tNJNSFyzi5TiB1RM8Vavy4RQL3
         NtOf9HIFdEDHquLY6JUcPd2+1l2LmzeRXStAtE8UZmogd/Q/iNwyNB9hbzBXaE0LZ08I
         Ew6w==
X-Gm-Message-State: AOJu0YwyY8GjdozlGjx3r/sL7JijMWGoFCzTkuzuA4oeAkuOy6jQbSdI
        9TgQykXyO6Tz4TrGxHManic=
X-Google-Smtp-Source: AGHT+IHgQ4W+ASzS7VkGl3S7peWoxrNZhGjnSAhyH7Vq/Wl8souodszOsjfMAmTu9d1TJ/zDISXEMg==
X-Received: by 2002:a17:90a:a684:b0:26d:3d3a:a198 with SMTP id d4-20020a17090aa68400b0026d3d3aa198mr9655941pjq.42.1693931277904;
        Tue, 05 Sep 2023 09:27:57 -0700 (PDT)
Received: from [172.16.116.58] ([103.15.228.93])
        by smtp.gmail.com with ESMTPSA id p10-20020a17090a868a00b00263f41a655esm9411178pjn.43.2023.09.05.09.27.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Sep 2023 09:27:57 -0700 (PDT)
Message-ID: <1bbe7772-09f4-6c5a-8c4d-c88988b34c99@gmail.com>
Date:   Tue, 5 Sep 2023 21:57:52 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v4 2/3] greybus: Add BeaglePlay Linux Driver
To:     Krzysztof Kozlowski <krzk@kernel.org>, greybus-dev@lists.linaro.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org,
        Vaishnav M A <vaishnav@beagleboard.org>,
        Jason Kridner <jkridner@beagleboard.org>,
        Nishanth Menon <nm@ti.com>
References: <20230902182845.1840620-1-ayushdevel1325@gmail.com>
 <20230902182845.1840620-3-ayushdevel1325@gmail.com>
 <27a445d6-d904-244f-266c-ffb2d68d0e27@kernel.org>
Content-Language: en-US
From:   Ayush Singh <ayushdevel1325@gmail.com>
In-Reply-To: <27a445d6-d904-244f-266c-ffb2d68d0e27@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> +static void hdlc_handle_rx_frame(struct gb_beagleplay *bg)
>> +{
>> +	u8 address = bg->rx_buffer[0];
>> +	char *buffer = &bg->rx_buffer[2];
>> +	size_t buffer_len = bg->rx_buffer_len - 4;
>> +
>> +	switch (address) {
>> +	case ADDRESS_DBG:
>> +		hdlc_handle_dbg_frame(bg, buffer, buffer_len);
>> +		break;
>> +	case ADDRESS_GREYBUS:
>> +		hdlc_handle_greybus_frame(bg, buffer, buffer_len);
>> +		break;
>> +	default:
>> +		dev_warn(&bg->serdev->dev, "Got Unknown Frame %u", address);
> ratelimit
> Probably as well in several places with possible flooding.

I don't think `hdlc_handle_rx_frame` is the correct place since it only 
processes a single completed HDLC frame.  The more appropriate place 
would be `hdlc_rx` if we want to limit based on the number of HDLC 
frames or `gb_beagleplay_tty_receive` to limit based on the number of bytes.

I would like to ask, though, why is rate limiting required here? Won't 
`serdev_device_ops->receive_buf` already rate limit the number of bytes 
somewhat? Or is it related to blocking in the 
`serdev_device_ops->receive_buf` callback? In the case of latter, it 
would probably make sense to ratelimit based on number of frames, I think.


Ayush Singh

