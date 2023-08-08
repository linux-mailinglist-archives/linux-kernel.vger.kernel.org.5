Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29FDD77408D
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 19:05:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233691AbjHHRFF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 13:05:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229928AbjHHRET (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 13:04:19 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77A255C0CE;
        Tue,  8 Aug 2023 09:01:55 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-522ab557632so7769686a12.0;
        Tue, 08 Aug 2023 09:01:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691510474; x=1692115274;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wVJtUMt/BxMqwUFh+dHgnZF1r8XeCDF5odP/kn3cxz0=;
        b=UP4ke88wT6rw7s4obg4WhmguB/ppbK4Z90v0PPgDZugD48ER5dhOnJXFdg4ITEep6E
         UWG8uDKIovsLXBz++gT/HxuQszgsBaRC3YTQMWXJaEt9c0kbk10jThHh5evtyfiPRpLo
         1hcFAmEYbXaw4oI3QvJEfaN96s4/e1IWQfocoiagY+eME3X98tTz+Honl0wdkq54r2Nn
         wR14wmaoVYElrL65AChWdKg1kk/twBRvJEsZLkcuknlV3brwmZjZUni/Dir9PbOePmcS
         SbA4qUceLUo0d5octECVD16W7ZaKZgOoN09iZHla9aE8vJK+xTXA3H5TepFsFdT24Hg6
         eltQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691510474; x=1692115274;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wVJtUMt/BxMqwUFh+dHgnZF1r8XeCDF5odP/kn3cxz0=;
        b=AX5KGsKOxbZGBQH4NTcvgnmDTotQaipZ0cowqh36YyrtJtMWV7Zgol5iuAJJb0gjiv
         s4IzmACwUpDyGAgFaXiQi33C5k3/dMCUSDJEgY9rJxxf8XEoE0AZCCF4qbrZjGKEuO8W
         u0SKZF4545yzFybpwS5vQMVI/VHtWp+tTyXQWV6gzCRGzthqsfrcbOrj6xZuKF+fyvWO
         Ji+zX7cRHn0X0urSumHKjrPHdwHn6m+5sEzyFaapSPviieeDZ4b/2X8s32PQVTqqooJU
         HBz/sOdyLrvNco6SeunR5ewetfFhSX7VSpWnBzvcBhOHzQWXBhnwp+W/gLl1cH75tS1Q
         pZSQ==
X-Gm-Message-State: AOJu0YwHkEl1DUtitQlx199fq2LINSzeUJnnUejSNV3fnNa1l1NlXBpj
        G/+OZOKWS9lVLszhzPhI2guCji71wgE=
X-Google-Smtp-Source: AGHT+IHekyGUIBsdZLnGJtKwLjfmqf/nwXuqIVItxJnBXOcDL5IYT9fu0CviRy0Yt0Hox5cwVcQCWw==
X-Received: by 2002:a2e:9c8a:0:b0:2b6:b6c4:6e79 with SMTP id x10-20020a2e9c8a000000b002b6b6c46e79mr8090041lji.1.1691475969105;
        Mon, 07 Aug 2023 23:26:09 -0700 (PDT)
Received: from ?IPV6:2001:14ba:16f8:1500::5? (dc78bmyyyyyyyyyyyyyct-3.rev.dnainternet.fi. [2001:14ba:16f8:1500::5])
        by smtp.gmail.com with ESMTPSA id e22-20020a2e8ed6000000b002ba123cb784sm2121390ljl.99.2023.08.07.23.26.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Aug 2023 23:26:08 -0700 (PDT)
Message-ID: <f7a20a95-48fa-edc0-9724-bfb4484c155a@gmail.com>
Date:   Tue, 8 Aug 2023 09:26:08 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: linux-next: Signed-off-by missing for commit in the iio tree
Content-Language: en-US, en-GB
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20230808083925.7109a675@canb.auug.org.au>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20230808083925.7109a675@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Stephen!

On 8/8/23 01:39, Stephen Rothwell wrote:
> Hi all,
> 
> Commits
> 
>    a00cf70f16c9 ("iio: light: bd27008: Support BD27010 RGB")
>    16a9947646f7 ("iio: light: bu27008: add chip info")
>    ae8c47c51e5c ("dt-bindings: iio: ROHM BU27010 RGBC + flickering sensor")
> 
> are missing a Signed-off-by from their committer.
> 

I am 99% sure I had SoB tags added in patches. Seems like they have been 
lost in the action.

Jonathan, do you need me to respin patches or how do you think we should 
fix this?

Yours,
	-- Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

