Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8520A78F23D
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 19:59:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346989AbjHaR7M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 13:59:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346986AbjHaR7J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 13:59:09 -0400
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com [IPv6:2607:f8b0:4864:20::c33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2C4FCF3;
        Thu, 31 Aug 2023 10:59:02 -0700 (PDT)
Received: by mail-oo1-xc33.google.com with SMTP id 006d021491bc7-570e63f5224so1212126eaf.0;
        Thu, 31 Aug 2023 10:59:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693504742; x=1694109542; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=Zoo4asRBCh5Mcl054IXKgumuqNZfUTCOkxRnpebmvaQ=;
        b=j8CeqmD94QefSmPt6geo0tfWG5pTNVVA8VcN5+j+sSXVqrTUCE+S5qK1ETBtwmGRR3
         p92kwrl08slPXIdzsRxyFKoHJ9KiylWUi8912qCNlyErXBh9lil2XQHUzn8sLFYlT128
         PpyvGYDMZQeJsrTNT4/mciSKkCLyMKTey7wdX43MlLHRFmJ2NiMUkAaLvQFFFCrPdxKv
         WmFR5W6leswsfinmQALKalMSTHgfmBcQeMaNBaKjpxmY35A2pWuvwPUugqJIqB+k15mf
         WV5w61HRJuK6X50E8S1woZ6rnsfEbAvCzkLhfF8RsKqh6U/8nRvaepKnsRpkGin2rKZO
         zKGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693504742; x=1694109542;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Zoo4asRBCh5Mcl054IXKgumuqNZfUTCOkxRnpebmvaQ=;
        b=AeXd5zcR3Sf3ga6r4Y5Rue/iVNxrihxjGhPoq2dUinpmQWdO6+m84X/RayMiMfduIC
         6Lp3iRTLSDNeQe+l4zNtq/kwr/gozx+uftUWALdgHJnUesqzqLyh1fLo66Y/VAlXbaNA
         LCqGOgA2sIaaos83COayB8YHaRwcyoBUoU3k1RXbxo9UBbiuV24OIMazUCxiBT45wV1x
         r6mi1D5JrzKK37x7cwZMGgl+DFxfhuIjSIttmGPEIMZYA5Gj/h4T7xrMequUt44wzyb3
         m5eZLH8OsSTmRCshbnieuhY2pNVdPngoZlnPTPtwoliUhQq08FEYH1zeydfOw2KxvpAG
         R6Lw==
X-Gm-Message-State: AOJu0Ywo01gUEKqQRX6U1lA5/Q28ckn1zoIpZt+NT3yO5ZThJAVxXqDH
        M3pJ41XK2IEiBzEWXMUQHAx1SzUgZr8=
X-Google-Smtp-Source: AGHT+IHVstGOLsQMD7P/4SDuK0yHgQX0Z12bPW/XuSLTkXGMqE2IvKKfNp2wkwyobxf7IYEYtaoKNw==
X-Received: by 2002:a05:6870:204e:b0:1bf:8978:1eb8 with SMTP id l14-20020a056870204e00b001bf89781eb8mr331258oad.17.1693504742083;
        Thu, 31 Aug 2023 10:59:02 -0700 (PDT)
Received: from [192.168.1.119] ([216.130.59.33])
        by smtp.gmail.com with ESMTPSA id f12-20020a9d5e8c000000b006b87f593877sm946510otl.37.2023.08.31.10.59.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Aug 2023 10:59:01 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
Message-ID: <60b97eea-c8ac-9f9b-6c7b-903124e9ae51@lwfinger.net>
Date:   Thu, 31 Aug 2023 12:59:00 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH] ssb-main: Fix division by zero in ssb_calc_clock_rate()
To:     =?UTF-8?Q?Michael_B=c3=bcsch?= <m@bues.ch>,
        =?UTF-8?B?0KDQsNC90LQg0JTQtdC10LE=?= <deeb.rand@confident.ru>
Cc:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        lvc-project@linuxtesting.org,
        =?UTF-8?B?0JLQvtGB0LrRgNC10YHQtdC90YHQutC40Lkg0KHRgtCw0L3QuNGB0LvQsNCyINCY?=
         =?UTF-8?B?0LPQvtGA0LXQstC40Yc=?= 
        <voskresenski.stanislav@confident.ru>
References: <20230830082759.23336-1-deeb.rand@confident.ru>
 <4c6d01bf-1a0f-27de-54e1-4afdcf4bc8d5@lwfinger.net>
 <531722477.1139813.1693465653233.JavaMail.zimbra@confident.ru>
 <20230831180506.30466e8a@barney>
Content-Language: en-US
From:   Larry Finger <Larry.Finger@lwfinger.net>
In-Reply-To: <20230831180506.30466e8a@barney>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/31/23 11:05, Michael Büsch wrote:
> On Thu, 31 Aug 2023 10:07:33 +0300 (MSK)
> Ранд Дееб <deeb.rand@confident.ru> wrote:
> 
>> 1- Yes, I agree that your solution is simpler, and I thought about
>> it, but I thought that the one who set the value zero put it for some
>> reason, so I did not want to change it.
> 
> 
> Yes, I understand your reasoning and I had the same thought initially.
> But I looked into the code and I am pretty sure that there is no reason
> for the default case returning 0.
> In fact, I think returning a 1 as default makes much more sense as the
> default value for a factor.
> 
> Changing this from 0 to 1 will get my ack.

As far as I can tell, that return 0 is there only to silence the compiler as the 
switch statement has no default. As I said earlier, there have been no reports 
of divide by zero entries in this ancient driver, thus the value returned is not 
relevant. As a static tool sees the possibility of a returned zero leading to a 
potential divide by zero, making it a one it the only thing that makes sense.

I have no idea why this part of the patch has led to so much discussion!

Larry


