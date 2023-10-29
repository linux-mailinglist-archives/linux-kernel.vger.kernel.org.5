Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB2757DAD77
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Oct 2023 18:14:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230197AbjJ2ROH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Oct 2023 13:14:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbjJ2ROF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Oct 2023 13:14:05 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EB56AB;
        Sun, 29 Oct 2023 10:14:03 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2c523ac38fbso54710521fa.0;
        Sun, 29 Oct 2023 10:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698599641; x=1699204441; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:cc:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0udIX/zF2kSnASkvlQwLeoGUtYljUF4NEJO2MWzKKgs=;
        b=NTaVx9en9O7jV6ZPs8M0WUNGOXxT721DjssriRNZsJWGUfW0H8GNNY1G/qmI88cxCL
         rgOx8HUgkpUodjjodoZBFsFiPbEtMjcyRNPjfoaL1i0IErq0phQrtc3+PvUD9JBh6Qky
         miSI/2xZZ96bqnLY+qWavNzizFM+9RHkMN5Wymr6D62HyJR/G6fdePbtPnQWfM9RS4pr
         rJb2Av2CkpGuCcuE+ZsFcVnWZ6eLN/v8W2fUpUOstNCcDEIl/zXdQ720HtFRH3QPqcfe
         B4Zze8qljFhaLdP/cxYHegrQhf+IVPIULUeBBY30SDIjVBKB73f/lKH/r9jdcJ4PesPN
         x4lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698599641; x=1699204441;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:cc:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0udIX/zF2kSnASkvlQwLeoGUtYljUF4NEJO2MWzKKgs=;
        b=EGJfSDErOTTbO+Cu4/GzdOX/WlKZ8KKbsYLt2uaYXKIw6qngrPEULB87SVIctcBGz+
         TDENS7vFqVi2qaKfAU4B/B1+1Y1w3u+XE98IG63zhIjsxk2gG0aSen+M2zOj0PbSNdWV
         dpI6XtauIcM6qMshSBy/yUit6ykMHSmThhx6M065TsuYffPxYsYz8cWrmFOgXru3Ozwq
         P7u5AtduE1sIVoEeZAgww+7KlssKsEuBnpZcdYuV0nzCVXXElNUXaP95LNQV813dnnTE
         DqPJ2+CNxHAhxJz8TibCIBB+S1lpjYpWkcB6087o6S3rX1BgmP36ES8Jza2fNTH3GuJJ
         77zw==
X-Gm-Message-State: AOJu0YzE6tHyw8Yf4rOT8fZMXsiwDJx+17hruAoFVx9oJ2LyJStM2Elp
        HiBRyProDjakKfGEblirXrg=
X-Google-Smtp-Source: AGHT+IHfVAPdZ/3t/WMgsC6wkvvBghKD/3oAdqyNckbm/9Tzzwvo6clZZQV7RKkUWrtJA4fU0EbaOQ==
X-Received: by 2002:a05:651c:39a:b0:2c5:ee7:b322 with SMTP id e26-20020a05651c039a00b002c50ee7b322mr5780342ljp.18.1698599641279;
        Sun, 29 Oct 2023 10:14:01 -0700 (PDT)
Received: from [192.168.0.28] (cable-178-148-234-71.dynamic.sbb.rs. [178.148.234.71])
        by smtp.gmail.com with ESMTPSA id gw18-20020a05600c851200b00405442edc69sm10382411wmb.14.2023.10.29.10.14.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 29 Oct 2023 10:14:00 -0700 (PDT)
Message-ID: <613efff5-f99a-4a18-ae27-44f3687d10da@gmail.com>
Date:   Sun, 29 Oct 2023 18:13:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc:     savicaleksa83@gmail.com, linux-hwmon@vger.kernel.org,
        leonard.anderweit@gmail.com, Jack Doan <me@jackdoan.com>,
        Jean Delvare <jdelvare@suse.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] hwmon: (aquacomputer_d5next) Add support for
 Aquacomputer High Flow USB and MPS Flow
To:     Guenter Roeck <linux@roeck-us.net>
References: <20231016083559.139341-1-savicaleksa83@gmail.com>
 <20231016083559.139341-3-savicaleksa83@gmail.com>
 <c08d04b4-8e6d-4221-93f1-cf5fff8c54c4@roeck-us.net>
 <576a2923-1705-48e8-81b9-f53a43c2b6f7@gmail.com>
 <c5981e81-2f0c-41f0-b2c4-0a786fe13c2e@roeck-us.net>
Content-Language: en-US
From:   Aleksa Savic <savicaleksa83@gmail.com>
In-Reply-To: <c5981e81-2f0c-41f0-b2c4-0a786fe13c2e@roeck-us.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-10-29 17:59:52 GMT+01:00, Guenter Roeck wrote:
> On 10/29/23 08:58, Aleksa Savic wrote:
>> On 2023-10-28 18:24:38 GMT+02:00, Guenter Roeck wrote:
>>>
>>> Applied.
>>>
>>> Thanks,
>>> Guenter
>>>
>>
>> Thanks. Maybe I'm missing something, why is the first patch
>> from the series not applied as well?
>>
> 
> Because I missed your reply to my question. Sorry, I have to admit that I am less
> than perfect. Applied now.
> 
> Guenter
> 

Thank you, much appreciated :)

Aleksa
