Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6ED16787174
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 16:25:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241594AbjHXOZB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 10:25:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241628AbjHXOYi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 10:24:38 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4962A1BC7
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 07:24:34 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id ca18e2360f4ac-790b9d7d643so21611339f.1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 07:24:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1692887073; x=1693491873;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=u2rdgs0bNKtgv3WwpKskkcELp4/NYKTYeYa5R7hjORQ=;
        b=PghVr6XpNCTC0YcDXEWmX/8Sbx4aRWMVPt5TN4TWeOJ8+ziUkKoCvl80ZP8/Eoap8v
         H66hGolecyFr0Jkaazv0hsy4+A31lSVeHkDOOEoumEXA8eZzXGh8Tm/q/u0FMtq1fpkW
         uokiXm+KVbjSB//5WcOzrNNjTsSf12jCjHqEQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692887073; x=1693491873;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u2rdgs0bNKtgv3WwpKskkcELp4/NYKTYeYa5R7hjORQ=;
        b=BwZ2qojlyndBKKglSfD3DM1S6Fw4YRWA/wyqO0v3XYknjqGvATfFOpYt5HX7yvOK8U
         pnNydMPcXzOAUlvT1JqG1bPHULRgiviv1cArnF1vpAApS7qphUZzEBA51Afqa6v8RUlJ
         USVkBZli6KD/GrYWOsCWD4hrOrnatLJ5ntBJ6i44UmskP8wdJ9kvNNloAkQs1c0BmA3U
         6wWmzXXFwLXTsxqqmk7ty29j4Z/G65eGdBIgL1c8/Ox+XmrRmLv/f+7/8wfaF2pb4xk5
         uAtYwnslMLefJIG321Qeup72AUUhR96asTqIHy6ajFNigeLM9DSltj6VAqzmL3f8yWSv
         kn2A==
X-Gm-Message-State: AOJu0YzBQPFNQhNnWIa0RMWoq9Bm0nogFN7p8MtvzsX6k3BjyLziR3JF
        TuZA1boVw9Fwvxuwyr6HUbFdTg==
X-Google-Smtp-Source: AGHT+IHo52NzvdB/s7cLnaajlVu450EcadR2gri3DooqQ9t5Se11B1M7Gtd5esFo7mhSRsx0N+sbFg==
X-Received: by 2002:a05:6602:3706:b0:791:e6ca:363 with SMTP id bh6-20020a056602370600b00791e6ca0363mr19829661iob.1.1692887073656;
        Thu, 24 Aug 2023 07:24:33 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id dl28-20020a056638279c00b0042b320c13aasm4550889jab.89.2023.08.24.07.24.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Aug 2023 07:24:33 -0700 (PDT)
Message-ID: <b7105474-bec9-f08b-b623-bf350909cab5@linuxfoundation.org>
Date:   Thu, 24 Aug 2023 08:24:32 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: linux-next: manual merge of the nolibc tree with the vfs-brauner
 tree
Content-Language: en-US
To:     Christian Brauner <brauner@kernel.org>,
        =?UTF-8?Q?Thomas_Wei=c3=9fschuh?= <thomas@t-8ch.de>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>, Willy Tarreau <w@1wt.eu>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Zhangjin Wu <falcon@tinylab.org>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20230824141008.27f7270b@canb.auug.org.au>
 <3028a552-bd75-4ded-9211-62d10768d9ea@t-8ch.de>
 <20230824-moment-wehten-5a47e319ae66@brauner>
 <26bc62c7-32c7-4ef1-b8d1-77738fa98598@t-8ch.de>
 <20230824-randfigur-emittenten-de303734445c@brauner>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20230824-randfigur-emittenten-de303734445c@brauner>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/24/23 02:52, Christian Brauner wrote:
>> Anyways Linus should also be able to resolve the conflict for v6.6 with
>> a small hint in the PR.
> 
> Suprisingly, we've done this before. :)

Right. This is how resolve these types of merge conflicts. I will add
note to Linus about this one.

thanks,
-- Shuah
