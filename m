Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD5377585E1
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 21:56:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230461AbjGRT4a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 15:56:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjGRT42 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 15:56:28 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F343C9D
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 12:56:27 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-5216095a698so1590723a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 12:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689710186; x=1690314986;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3CY7+PgSAsXutcSH1Yn+6ncOfnCiV685Lm0M61o0+6s=;
        b=Rlle29OTppJXuHRJzGoaprZRTTHtBAkQwbxVbI/Urz1Hb2u3yOfU17sl8CAuivGUCN
         d5akXLeaOeS5Wjh3kM0R7IX/8+2yCBIHON1oD4tYQaB1SshauYy0OFGOEXjy47Q9Dr1S
         9q9ekPUoUfXZWF6dSgi34/v92qtKN8Tkg/6NfGHTIvwXn4wRQb+jNzV0DEjKdeGLLjby
         c92gzJDAaMZOC0zou62fldpqWiQV5O6N0lRUKiwYXpxm0LhbcONcIYDVuUDDufuwRvvP
         arGhAkRMP3VjJTPGrZVmUZ8pUEW/Sze7er0XjYudmZPzhEg4DN/RPm/Kbtz2RjzW8HOG
         L2Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689710186; x=1690314986;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3CY7+PgSAsXutcSH1Yn+6ncOfnCiV685Lm0M61o0+6s=;
        b=PpzkgVzeIV9H27i622ZekxgBEApEnVgw+2BmLlVrih+Kw0ARZS0Thvw6ODzfGlNejs
         IVKuv/+0nOyYh2RA9rK/hdhHgaHfi2ZPPbfP1YXsLRb14aTErcNA0ojpXVR0Kr0QPP7Z
         3a0QsQvej6TFUULh9H0NsK/HAHoPp+L/ufwQaCQugW3+U8i8UfjfhtP67HbgrNKvRNsg
         3G+7NwUMED5q3oOebTTVd4hSjn/nKvH98CQD5EAuxeY56cJC3A+hiL5feIInmyHGPoDw
         kgB/VP7515Dib+p3Ygw8QA6KHCxbmFWzC7wwui1+LUkLcYXRqW/IwGInkONeU2yp88NO
         t40w==
X-Gm-Message-State: ABy/qLZQut9NgEGwlvtgPvVtTEy0OovWL0BRzDdgiligZwnyOff0zqDy
        bRvrROdpETnEQUCU5zw7rVg=
X-Google-Smtp-Source: APBJJlEiS7xGjuFFPbusmNeCkIK7mQdYKMlzpb6h0P6tICWSRq99VU2ojB5d7HphHULpHrZw/vTWUA==
X-Received: by 2002:a05:6402:5110:b0:51e:2de8:70fb with SMTP id m16-20020a056402511000b0051e2de870fbmr522422edd.0.1689710186311;
        Tue, 18 Jul 2023 12:56:26 -0700 (PDT)
Received: from [192.168.0.103] (p57ba2e0b.dip0.t-ipconnect.de. [87.186.46.11])
        by smtp.gmail.com with ESMTPSA id t11-20020a056402020b00b0051dd1c10c13sm1634338edv.29.2023.07.18.12.56.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jul 2023 12:56:25 -0700 (PDT)
Message-ID: <95e0287d-3211-3c0d-7a52-740acdb75f45@gmail.com>
Date:   Tue, 18 Jul 2023 21:56:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] staging: rtl8192e: Rename variable bCurrentHTSupport
Content-Language: en-US
To:     Tree Davies <tdavies@darkphysics.net>
Cc:     gregkh@linuxfoundation.org, dan.carpenter@linaro.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <ZKYgH/BvkE9bdcPm@kimchi.darkphysics>
 <6dee04ae-4129-cd7c-0d31-70d29b86c8ff@gmail.com> <ZLL+Q0tcW5S8Xjmj@basil>
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <ZLL+Q0tcW5S8Xjmj@basil>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/15/23 22:14, Tree Davies wrote:
> Philipp,
> 
> I think I understand what I did wrong. Each of these original patches were
> created/based from the same commit hash. So it makes sense that only the
> first one applied would apply cleanly and the others would fail.
> 
> My apologies,
> Tree

Hi Tree,

you could work this way if you ensure that each patch does not modify 
code (and some lines above and below) a previous patch modified. But it 
is not a good way to do so. Existing tools assume that you create your 
commits onto each other and then make patches out of them.

Another issue right now is that approximately 18 patches send in and are 
possibly applied (for rtl8192e). Your patches need to fit onto those 
patches. Otherwise they cannot be applied and will be rejected.

Typically Greg applies all patches once a week. But it seems that he has 
a bunch of other more urgent tasks. So you need to focus on other kernel 
related task like educate yourself or prepare patches without sending 
them in.

Thanks for your support.

Bye Philipp




