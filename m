Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67CC47ADD82
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 19:00:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231393AbjIYRAm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 13:00:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229966AbjIYRAk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 13:00:40 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48D4D107
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 10:00:29 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2c01f2eab3fso21142171fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 10:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695661227; x=1696266027; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jjkZJBC6Gty9hVSaOaJYhVYV6erBLLSXof8lytqRb4k=;
        b=eKYCc9FlHZJHEY/F3UPmvez5ypZaQEEBZ4wcMN+7hvIgfYAmIlnAnIAtTlptDwgo+2
         zhcHA4vJ8bBCvO5y1yqSut36nV2X35Q2rqv2WgMN9+Be+6HiLVZp+H/tfXwneoDmhtcO
         HtYd+0nFndxRBgQ0zSsXhCTGaf5iOSd/COMZRRfQDLFtCs1L0yzKd2vfDv+ZggPsJ6l3
         HjuitdJ0US9RLXNAgd5/jxFg86GIZ/UxOPzniF7DklNW/gRQoB4oJo1bfX9UcTwruZGd
         o/K2yo4a+JUuXL80UnGUxNgzTKVX3vpVIR35f66cVj7YhjbT3Dy30L1O3jEaqIv4mKGR
         wqzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695661227; x=1696266027;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jjkZJBC6Gty9hVSaOaJYhVYV6erBLLSXof8lytqRb4k=;
        b=qQ+SZaCjLSXMCn9gpbzdAIMNqfpP0hWxcgR0YxC1w07Ew9MhfI9/7ElW40qpt8/Q/G
         m0/74HIYcLcD5QV+WbXzW6Jv5Dulrq5uMokAOb8vErokY53j60JBoJQtXJSH+X6pKQ90
         tXSETrZQnpW6rf2r5zSfqQQpeQ9xVd0XRB9z3WZtLIw9bhMnh/tU4kIwtkAATBrOGc4E
         N4K01m4a4hePTLqWrKsGr2hoUbCf7PTT0HBXxYG7TrTd1OnlQjREXFySaaRJdbVt9MPZ
         tnlfadS7tbvClQQhkUBMaAxZTKixistc3+7+yAQ8hq30UJaY/GZFacE4/HOI089q/B1I
         ii8w==
X-Gm-Message-State: AOJu0YyNBzCvqOjlAqHlWEhb9CC+tcEd9pX8VdCNyFqm8gbcGlkrn6d3
        vXQr6np13gnMXmKvXI8t0xM=
X-Google-Smtp-Source: AGHT+IE9o4RgPGsDQ/lC2M5jHxfW50sXuyYNDwwSDJ7pHK6hEfy1YgWYsN6WCfwkjd+56Y8ghe6GuA==
X-Received: by 2002:a05:651c:1a22:b0:2bf:fac2:d06c with SMTP id by34-20020a05651c1a2200b002bffac2d06cmr6645226ljb.4.1695661226373;
        Mon, 25 Sep 2023 10:00:26 -0700 (PDT)
Received: from [192.168.0.104] (p579356c7.dip0.t-ipconnect.de. [87.147.86.199])
        by smtp.gmail.com with ESMTPSA id jx14-20020a170906ca4e00b0099caf5bed64sm6584214ejb.57.2023.09.25.10.00.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Sep 2023 10:00:26 -0700 (PDT)
Message-ID: <cc39920b-6d2f-fdc7-ec7f-d821423c7a80@gmail.com>
Date:   Mon, 25 Sep 2023 19:00:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 0/3] rtl8192e: renamed (1) mixed case variable
To:     Gary Rookard <garyrookard@fastmail.org>, gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20230925151157.3893-1-garyrookard@fastmail.org>
Content-Language: en-US
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <20230925151157.3893-1-garyrookard@fastmail.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/25/23 17:11, Gary Rookard wrote:
> Hi!
> 
> This patch set of (3) addresses the correction of mixed case useage
> in (3) driver/staging/rtl8192e files.
> 1/3) rtllib.h
> 2/3) rtl819x_HTProc.c
> 3/3) rtllib_module.c
> 
> Variable renamed: HTUpdateDefaultSetting -> ht_update_default_setting
> 
> Linux kernel coding style "cleanup", no change in runtime logic,
> compiles with no errors or warnings.

Hi Gary,

you need one patch to change all three usages of the variable.
You need to be able to compile the driver after each patch.

For the next patch you send to the mailing list you need a version 
history of your patch.

If you like you can send the patch first only to me. In case of 
questions feel free to ask.

Bye Philipp


