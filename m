Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D2477B4678
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Oct 2023 11:11:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234666AbjJAJLW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Oct 2023 05:11:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234530AbjJAJLU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Oct 2023 05:11:20 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACC62C6;
        Sun,  1 Oct 2023 02:11:17 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-5346b64f17aso11708887a12.2;
        Sun, 01 Oct 2023 02:11:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696151476; x=1696756276; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nWGRyz+YIuv74qkbiCqoaXcuRZTJ/y0eHD6SlcR52QA=;
        b=SHn4hIVMC7/9lyshVD+BG9Leyji0cKbtt+aYjL8ToZ4nwrzF4k22t4kQly6APOsSlz
         AZyU0l8A0dXSqiVHppa33dyyd4Wg6qrCuKZnb4nsSzMsQ8FdQZXuMgSzx0kcHRCjEX0G
         f8z0wH5hKBk+aKm7Yr13FREcA0Bq3CTg3zqWdSiJ+cOAigetQj7CzwV3pn071TtSmiua
         D3ZJSx7HdpfXDgvqlbk4vC4Wblpilz9gk2R/gwxFwlVFUS7PbSiVRfx8oIertNENVxIv
         Jypyp6UhWMN1Eq7HsiEMX4/J2xOINTCxczzqsF3LxefiJL2gAJIHVluFi07fFwyZhGDP
         djMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696151476; x=1696756276;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWGRyz+YIuv74qkbiCqoaXcuRZTJ/y0eHD6SlcR52QA=;
        b=ReSSBi0E+m0h/qpgzBdSLbfsTiS1ga/dNp7BhX1nVNR0i5hnfwtyrUh8HG2813xkL5
         0+pvtd/4uEr/16V5f4Soy4FkVJqVGTUvx+MJU+dT47oMBPcW0dAzAS1kUE13jhn6eDWi
         Uii9DxC7fIDx+4kgFOTSZtpbchMpkf3mbg8oYO0j4quZpwyEdsHV8orKr1HtWPnQ2B4A
         edmigg52oz+6X1Or2FwDOyxvp6cw1XMV38XB/n5b4VqxZqSDAkJBEEo0TQyClxqW4Lvo
         BLSzZjZFNxmQwpmB0Jhp0Yyd9dusecJQQcjqGKDg3RMmoL2vLI08EBDjBRzylOsUTD7u
         ASww==
X-Gm-Message-State: AOJu0YziLWiyG3w0I3Br90mBbBF0exE2QNcnSNuYPcAdGC181PhbTZRR
        PySuOvi5J0kM2vcQIEMdgGeHvXltEZE8Yg==
X-Google-Smtp-Source: AGHT+IHlUZerKdqKGCIyQigyrjWoqOu0heKLByitH9ldieUyFdKUm6CW3w7ZCA+nfu8AqoH2Be6rFw==
X-Received: by 2002:aa7:df17:0:b0:530:d6e5:9229 with SMTP id c23-20020aa7df17000000b00530d6e59229mr8468289edy.10.1696151475932;
        Sun, 01 Oct 2023 02:11:15 -0700 (PDT)
Received: from ?IPV6:2a02:8389:41cf:e200:4c68:6c03:863b:ad4e? (2a02-8389-41cf-e200-4c68-6c03-863b-ad4e.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:4c68:6c03:863b:ad4e])
        by smtp.gmail.com with ESMTPSA id b7-20020a056402350700b0053613c8312bsm5492900edd.42.2023.10.01.02.11.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 01 Oct 2023 02:11:15 -0700 (PDT)
Message-ID: <710ed88d-462b-17ed-ae4d-906ddd0dee8a@gmail.com>
Date:   Sun, 1 Oct 2023 11:11:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] Input: powermate - fix use-after-free in
 powermate_config_complete
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230916-topic-powermate_use_after_free-v1-1-2ffa46652869@gmail.com>
 <CAPnbTwKqNghcoPj-FGQQxo0xr-AYTm8pYBYCUgyKT6VxZpZCOA@mail.gmail.com>
 <ZQjKwQDKmU8L9C9e@google.com>
Content-Language: en-US
From:   Javier Carrasco <javier.carrasco.cruz@gmail.com>
In-Reply-To: <ZQjKwQDKmU8L9C9e@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dmitry,

On 19.09.23 00:10, Dmitry Torokhov wrote:
> On Mon, Sep 18, 2023 at 06:51:49AM +0200, Javier Carrasco Cruz wrote:
>> Hi,
>>
>> There's an obvious error in the patch I introduced when cleaningup
>> (urb->status should be used instead of just status). I will send a v2.
> 
> I think what we need is call to usb_kill_urb(pm->config) in
> powermate_disconnect(), right after call to input_unregister_device().
> 
> Thanks.
> That is definitely a more meaningful and elegant solution, so I will
check it out and eventually send a v2 with it if everything seems ok. On
the other hand usb_kill_urb() is already used on pm->irq before calling
input_unregister_device(), so I would move the existing usb_kill_urb to
have both calls right after the unregister_device call for code
consistency, if that is alright.

Thanks and best regards.
