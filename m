Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 520877939F8
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 12:33:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234982AbjIFKdU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 06:33:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229927AbjIFKdT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 06:33:19 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5E00CE2;
        Wed,  6 Sep 2023 03:33:12 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id 98e67ed59e1d1-26fe4997871so1902570a91.3;
        Wed, 06 Sep 2023 03:33:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693996392; x=1694601192; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dZQ8wt1OcjisCZpLbfzFz5n18+5fQLoWCA+NTtpxCgE=;
        b=YSrPFXclH1rEG9v5awuCgn0YvzkOfdFj9Hjp+eFbzFtqWPq/yQS2CnkyL0DAj1ibOC
         YUxHP2KYCdIV/OgAZ2btxH+vFW6VpjAccR/YnYANF2R6TM8zKM0Ng+D09U39cKqyL2lC
         ZH9mbctLFpyKiL4M4ORlX377picL7RodKnCAlH+JXUH+ayVgbaZsBw+sq1ecxhnU1IUB
         rvGXL/H2+hWMZtTXitypp0U81mw2rwdX1MMDeTxxIcvRKZZkbbMFoV8LbhhRBiQT/Gq4
         NzpXRhFIJW10sAxgH57jo6zo347HtfOX/fj08Kv3p50p1tRbgyx68Y/rb7eeUgEX7an+
         C4yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693996392; x=1694601192;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dZQ8wt1OcjisCZpLbfzFz5n18+5fQLoWCA+NTtpxCgE=;
        b=OiSr0sr0BWmUFRUX0GsMhNnkLO8MnGWYEcHrWQaZSugZU+CWiELaQXXhTRDHQdq1YR
         MwYirH/Cm0BZl68arBSZIph5USb+sxQLj4ybaQSMzu+1dY2YQn1QbRvpbu4RQNGJCUar
         MKVBC5mYMyh//Zgpx8lQzCZ0GLe6vI59esdRfjk3WaM1VSkMbGhN4SySVVhvVkJoAZBN
         XIcJivlXyLNAS8T/Qgp8UczdYmYbg3m5fvFHraH+DB6Pfr3k9c8QvbqLfas33Yq9TvER
         v3q6t/eKA8i1OSQkvk1zUd/BSPK8BNph2P7L+r+c/qsUz+2q99B8cKgtUdaHdlzMwUcb
         fmZw==
X-Gm-Message-State: AOJu0Yyqe/LXBGkrFd/ofSU9DW+tabyuYZ1+wDf6XcHEmQ/7LhYSPSWc
        cxX492Rhzcqw+MnEK2hXNZg=
X-Google-Smtp-Source: AGHT+IEvmMcrChGZLiPN933WjYKZmL8PyeTwmMitOCF5itYlCF4stuJmLKQ1uC6Qg+XXTvzQWSo3dw==
X-Received: by 2002:a17:90b:11d1:b0:26d:1986:f7ec with SMTP id gv17-20020a17090b11d100b0026d1986f7ecmr12223211pjb.1.1693996392056;
        Wed, 06 Sep 2023 03:33:12 -0700 (PDT)
Received: from [172.16.116.58] ([103.15.228.93])
        by smtp.gmail.com with ESMTPSA id l19-20020a17090aec1300b0026b26181ac9sm12167302pjy.14.2023.09.06.03.33.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Sep 2023 03:33:11 -0700 (PDT)
Message-ID: <2746d50a-5658-5058-4369-1a1b34f85710@gmail.com>
Date:   Wed, 6 Sep 2023 16:03:06 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v4 2/3] greybus: Add BeaglePlay Linux Driver
Content-Language: en-US
To:     Krzysztof Kozlowski <krzk@kernel.org>, greybus-dev@lists.linaro.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org,
        Vaishnav M A <vaishnav@beagleboard.org>,
        Jason Kridner <jkridner@beagleboard.org>,
        Nishanth Menon <nm@ti.com>
References: <20230902182845.1840620-1-ayushdevel1325@gmail.com>
 <20230902182845.1840620-3-ayushdevel1325@gmail.com>
 <27a445d6-d904-244f-266c-ffb2d68d0e27@kernel.org>
 <1bbe7772-09f4-6c5a-8c4d-c88988b34c99@gmail.com>
 <608ddca9-4ab8-1aef-767f-92a90e7e0970@kernel.org>
From:   Ayush Singh <ayushdevel1325@gmail.com>
In-Reply-To: <608ddca9-4ab8-1aef-767f-92a90e7e0970@kernel.org>
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

On 9/6/23 15:29, Krzysztof Kozlowski wrote:

> On 05/09/2023 18:27, Ayush Singh wrote:
>>>> +static void hdlc_handle_rx_frame(struct gb_beagleplay *bg)
>>>> +{
>>>> +	u8 address = bg->rx_buffer[0];
>>>> +	char *buffer = &bg->rx_buffer[2];
>>>> +	size_t buffer_len = bg->rx_buffer_len - 4;
>>>> +
>>>> +	switch (address) {
>>>> +	case ADDRESS_DBG:
>>>> +		hdlc_handle_dbg_frame(bg, buffer, buffer_len);
>>>> +		break;
>>>> +	case ADDRESS_GREYBUS:
>>>> +		hdlc_handle_greybus_frame(bg, buffer, buffer_len);
>>>> +		break;
>>>> +	default:
>>>> +		dev_warn(&bg->serdev->dev, "Got Unknown Frame %u", address);
>>> ratelimit
>>> Probably as well in several places with possible flooding.
>> I don't think `hdlc_handle_rx_frame` is the correct place since it only
>> processes a single completed HDLC frame.  The more appropriate place
>> would be `hdlc_rx` if we want to limit based on the number of HDLC
>> frames or `gb_beagleplay_tty_receive` to limit based on the number of bytes.
>>
>> I would like to ask, though, why is rate limiting required here? Won't
>> `serdev_device_ops->receive_buf` already rate limit the number of bytes
>> somewhat? Or is it related to blocking in the
>> `serdev_device_ops->receive_buf` callback? In the case of latter, it
>> would probably make sense to ratelimit based on number of frames, I think.
> My comment might not be accurate, so I do not insist. The name of the
> function suggested something being called very often (on every frame),
> thus you would print warning also very often.
>
> Best regards,
> Krzysztof
>
Rate limiting the logs is not a bad idea. Initially I was not aware you 
meant about logging, hence the question. With proper firmware in CC1352, 
the warning will never be printed. But maybe it can cause problem with 
improper firmware.


Ayush Singh

