Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BE8F7722F2
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 13:44:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232946AbjHGLn7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 07:43:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233180AbjHGLnE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 07:43:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 330EF1FC8
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 04:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691408316;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oMQdzYvM+Pe5aw7tEIhxWj87hwS9adLKe0i6Mj8H6Ns=;
        b=N0bZYKIFqs4JI7Yxp10r/ZmnESnFeL1hcvPX28fCqw0ln/f+dt5XXtDuAJLCQkqgylB01W
        F9opbJ4VCQbu1sFUiKP9kEayo0WlqTWFRg8q0/l5aczbQtHICGnnKHrh+xheQUqP9Mv7Eo
        3wxGaj4hww4vx0Zh+5XOWaZFbhVBHRw=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-171-gnOnpn0WOUiUlDiYxCH8zg-1; Mon, 07 Aug 2023 07:38:35 -0400
X-MC-Unique: gnOnpn0WOUiUlDiYxCH8zg-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-99cc32f2ec5so117374366b.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Aug 2023 04:38:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691408314; x=1692013114;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oMQdzYvM+Pe5aw7tEIhxWj87hwS9adLKe0i6Mj8H6Ns=;
        b=IFStzBlJuOngGZLUrUC7S10tFZWwInh4DcxR562hSNCtN24r5DX4/ute1G9bLKkHyt
         RALeTMNyq3SRyM9YuHmrLw9XR/cfjFDUC9T2vHKs6K3/RvoNjVKzJ02OOmNgIHwcPjHL
         kBe5vQM/0nCNbwImyLrj+ClpLf9EZTWjUZ4Vzc2/rs8hde46nkQQrQkZ+ze8TzOAvdpT
         vHV5zC/VgCzzeG0cB6Pm0y6n2RxchZMYdV5CCc5Wt1Oy5MzNNo0+U9nKQac+Qq1+jqyv
         Z3KcNRgPMj6G2EMMkxG524AdLZhuhWaZ96JJPvNHPNhwaht1AlM/7H1Fyml/vBvucMxa
         dUDw==
X-Gm-Message-State: AOJu0YxAWMGL30Kes9aNAsBjer3QFTHE9sSMfKBKApirJsp0vXUls4GP
        Jzkk8jWXtR8WfLpF8R9ds+ui+QmGYRwRPXUspfI7beL19ayyvHmaO2bqD8y+pIpYiQt08Ezg7hP
        P3fLXejE6IStLSvap70rNcP7y
X-Received: by 2002:a17:906:5a48:b0:98c:e72c:6b83 with SMTP id my8-20020a1709065a4800b0098ce72c6b83mr6759513ejc.45.1691408314630;
        Mon, 07 Aug 2023 04:38:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEednnRIFSijaQW/ULGrqvXgaSTiwrn9ONCcNWwL9t4vr8DBCCz8S3u7jBD/hirMYouKTl9Pw==
X-Received: by 2002:a17:906:5a48:b0:98c:e72c:6b83 with SMTP id my8-20020a1709065a4800b0098ce72c6b83mr6759504ejc.45.1691408314388;
        Mon, 07 Aug 2023 04:38:34 -0700 (PDT)
Received: from [10.40.98.142] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id 4-20020a170906058400b00992c92af6f4sm5134795ejn.144.2023.08.07.04.38.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Aug 2023 04:38:33 -0700 (PDT)
Message-ID: <92096817-0183-566a-cdd3-74e6fa3a09c8@redhat.com>
Date:   Mon, 7 Aug 2023 13:38:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 0/8] hp-bioscfg: Overall fixes and code cleanup
Content-Language: en-US
To:     Jorge Lopez <jorgealtxwork@gmail.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        thomas@t-8ch.de, ilpo.jarvinen@linux.intel.com,
        dan.carpenter@linaro.org
References: <20230731203141.30044-1-jorge.lopez2@hp.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20230731203141.30044-1-jorge.lopez2@hp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 7/31/23 22:31, Jorge Lopez wrote:
> Submit individual patches to address memory leaks and uninitialized 
> variable errors. 
> Addressed several review comments making the source code more readable.
> Removed duplicate use of variable in inner loop.
> 
> Changes were tested with a HP EliteBook x360 1030 G3
> 
> Jorge Lopez (8):
>   hp-bioscfg: Fix memory leaks in attribute packages
>   hp-bioscfg: Fix uninitialized variable errors
>   hp-bioscfg: Replace the word HACK from source code
>   hp-bioscfg: Change how prerequisites size is evaluated
>   hp-bioscfg: Change how order list size is evaluated
>   hp-bioscfg: Change how enum possible values size is evaluated
>   hp-bioscfg: Change how password encoding size is evaluated
>   hp-bioscfg: Remove duplicate use of variable in inner loop
> 
>  .../x86/hp/hp-bioscfg/enum-attributes.c       | 24 ++++++++----
>  .../x86/hp/hp-bioscfg/int-attributes.c        | 15 +++++--
>  .../x86/hp/hp-bioscfg/order-list-attributes.c | 39 ++++++++++++-------
>  .../x86/hp/hp-bioscfg/passwdobj-attributes.c  | 27 +++++++++----
>  .../x86/hp/hp-bioscfg/string-attributes.c     | 13 +++++--
>  5 files changed, 82 insertions(+), 36 deletions(-)

Thank you for your patch-series, I've applied the series to my
review-hans branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans

Note it will show up in my review-hans branch once I've pushed my
local branch there, which might take a while.

Once I've run some tests on this branch the patches there will be
added to the platform-drivers-x86/for-next branch and eventually
will be included in the pdx86 pull-request to Linus for the next
merge-window.

Regards,

Hans

