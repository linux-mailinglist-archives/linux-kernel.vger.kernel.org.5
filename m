Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1B9277BF9F
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 20:14:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231137AbjHNSOM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 14:14:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231633AbjHNSOI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 14:14:08 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7FB110F7;
        Mon, 14 Aug 2023 11:14:07 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id d75a77b69052e-40fe3850312so37324941cf.1;
        Mon, 14 Aug 2023 11:14:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692036847; x=1692641647;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bQ30wqdeg8nr7ZRQafCO5qwZZMxf2DmPJcwtIDeAlUI=;
        b=L7rX82DFdCBBlRhELLoTNACiriFy2EDfqfuDBkX/5MW1YTQVFaJzBPIz6r3wOZb50L
         lL861vaiMxhMWkCKWsJ0NXtYQZhz8m31LhhXhqlDQrK8cuPh6+guoJQlE4F39bCgUk69
         f/p86fQRuDOGdvK1ot0ckY2eqar2lO2kw8JRCtNp9iYEhCWuf7s6uA54+VRCeTgZu3DY
         wB/oGd2xKyKhHxKbxwwYsijjFo+Ax4J5gY+8ZF5wgjb8ztGW7vlQ9SoqfCd5W0tmQ+5Y
         0el2ElDCD3GaQLl6xFPsJLxbmQJ77RxN/DOpiIqG75V9lLAW8brOvctCrfS5OOr0S+HF
         xSDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692036847; x=1692641647;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bQ30wqdeg8nr7ZRQafCO5qwZZMxf2DmPJcwtIDeAlUI=;
        b=Ai3DodU7hofORzS56ASbvOcSBwMlCEqOP7cKcFFkVCKFkcPcjb3BFNZS/xb1KKYA35
         EgRHnmFK6lobn88toCwwrmGrg1JeZ+o5WLhpayuhl90CSYKg/349ypo8DSvcXYG5i5MJ
         cE9wS95LGc2wjRgQplBqAW/HQHc+ZCPJnnB7QjUrEkmFBOVAVG0uaAFSjzaL1KLPmQbL
         WOCGIW3Kd2Ki3hlp2xAYNvY60I18Pk91rXrZzkrikqe5rGtXtIylwFDWo1Jn5l27Xwpp
         DCu5s0To3vx0VZ26CxeJAJ9+2XIE/LmEX+uHX47li/9DQF1XfOp9vlAnKCby6erj4QVQ
         cygQ==
X-Gm-Message-State: AOJu0YxdSgwibE/EuTvnvOKHDyOvXgig1KnJfVvV3xw1OJBFAyNnbn0m
        zH7JLkB1KrTV6trlpoLFWys=
X-Google-Smtp-Source: AGHT+IEGJyHHUiEWi1GEqe5WGG+iVU5PzxMqV9svYC2zgs923yYZdmQgVloQbalZmrd90RlZWCGLTw==
X-Received: by 2002:ac8:5d91:0:b0:403:c8c4:fd42 with SMTP id d17-20020ac85d91000000b00403c8c4fd42mr14945085qtx.20.1692036847014;
        Mon, 14 Aug 2023 11:14:07 -0700 (PDT)
Received: from [10.69.49.209] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id c16-20020ac87d90000000b00407ffb2c24dsm2849239qtd.63.2023.08.14.11.13.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Aug 2023 11:14:06 -0700 (PDT)
Message-ID: <59da69e7-611c-7ea1-f18f-89c7a732bb46@gmail.com>
Date:   Mon, 14 Aug 2023 11:13:31 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH] serial: 8250_bcm7271: improve bcm7271 8250 port
Content-Language: en-US
To:     Justin Chen <justin.chen@broadcom.com>,
        linux-serial@vger.kernel.org
Cc:     Al Cooper <alcooperx@gmail.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        John Ogness <john.ogness@linutronix.de>,
        Jiaqing Zhao <jiaqing.zhao@linux.intel.com>,
        "open list:TTY LAYER" <linux-kernel@vger.kernel.org>
References: <1691792050-25042-1-git-send-email-justin.chen@broadcom.com>
From:   Doug Berger <opendmb@gmail.com>
In-Reply-To: <1691792050-25042-1-git-send-email-justin.chen@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/11/2023 3:14 PM, Justin Chen wrote:
> The 8250 bcm7271 UART is not a direct match to PORT_16550A. The
> Fifo is 32 and rxtrig values are {1, 8, 16, 30}. Create a PORT_BCM7271
> to better capture the HW CAPS.
> 
> Default the rxtrig level to 8.
> 
> Signed-off-by: Justin Chen <justin.chen@broadcom.com>
Acked-by: Doug Berger <opendmb@gmail.com>

Thanks Justin!
--
Doug
