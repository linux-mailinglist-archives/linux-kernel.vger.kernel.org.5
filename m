Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A081759C3B
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 19:18:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231325AbjGSRSF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 13:18:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229874AbjGSRSD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 13:18:03 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4307C0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 10:18:01 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-52173d4e9f9so6892964a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 10:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorfullife-com.20221208.gappssmtp.com; s=20221208; t=1689787080; x=1690391880;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VpanezAzu84K2PT3l9Qm4yWODhyTjKr1+lccrDthOWY=;
        b=XU/VomcLAmXsx964ps1s5pM8W//6vNOkaApSD2qONISxOQUCb1A4SNqq5mW02VDdvv
         YZ4eD2tyzpV795obfaW9OOGv0jlO5iFkDUihk6gpzFZqiOyQHfTmNYMlug7cELF+fmRD
         bKv+TAgQqVFLdQWDLdfm/zkfHtoU6MtuW4ZeXcz93PTKEdjfOT57BJfFOcoDm23A54Vh
         VkuwCni4xH6yVZDfJfo8itWyNnZDZhx9hwh2IYe0Z7vLCEPKdgjM+nU3BARh/z0mOcUN
         UmF+P6b6Zk0SW0rZq0xxXJSsA3fJLnre7DemgO5vSoiY/WLGZRtVBCGduloQqL/uQCek
         rReg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689787080; x=1690391880;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VpanezAzu84K2PT3l9Qm4yWODhyTjKr1+lccrDthOWY=;
        b=MDM+y7QLpKABTIxoA2URiYx7H2boY+iRdDj9bQ8KCSlt5ZMqux0IRFBkdknAfmyZAA
         AX7dBppYq02/PDIGSFaNN+/byqyhVGQCLQT0czWjWh4uLbe9QbfD+BT88atCrwE+jo49
         rz9ZWgbSa2jiXBIezMJymR2sEaeQRPnfPaB/vb2kLbN+iyvr8DvFf2vuLZZ9tgLqGVUW
         SpLybEHSzvO5R2VK8YjLEJ986UYH6/xhaGtrZ6edKUCQXIZ/dzYkSH+GdXaB1O1HjC0/
         sx7Y1lnqT0fQO1CJEKDAuS2dDw/DcctHX1/Bx5uLr/a/i2lnfE99P53P8ZRwYEvq1RYs
         3Pcg==
X-Gm-Message-State: ABy/qLZtgQ6yZoGdxvG18eHEOIMYwFIQLT0bugmuHk/PFhGbcAIhoy6d
        Jq8qCvB5sDL9Q8e1XnHHeN7OPMkyDeYDkQ89pkP45w==
X-Google-Smtp-Source: APBJJlHFp1CtMF4dbTFViAWN68WZduWoGhdFBG5WMcbwMlSLmD+6mL8MTrZbQmiUWUf9ZusEZmgNtQ==
X-Received: by 2002:a05:6402:618:b0:521:8777:b00d with SMTP id n24-20020a056402061800b005218777b00dmr2621456edv.15.1689787080209;
        Wed, 19 Jul 2023 10:18:00 -0700 (PDT)
Received: from ?IPV6:2003:d9:9722:8200:65a8:65f4:1458:5415? (p200300d99722820065a865f414585415.dip0.t-ipconnect.de. [2003:d9:9722:8200:65a8:65f4:1458:5415])
        by smtp.googlemail.com with ESMTPSA id e22-20020a056402105600b00521cb435d54sm1028210edu.37.2023.07.19.10.17.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Jul 2023 10:17:59 -0700 (PDT)
Message-ID: <42ccb0ff-f6ab-5fb1-09a6-e212f9b15582@colorfullife.com>
Date:   Wed, 19 Jul 2023 19:17:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: + ipc-sem-use-flexible-array-in-struct-sem_undo.patch added to
 mm-nonmm-unstable branch
To:     Andrew Morton <akpm@linux-foundation.org>, jannh@google.com,
        dave@stgolabs.net, christophe.jaillet@wanadoo.fr
References: <20230710203557.2BBB0C433C8@smtp.kernel.org>
Content-Language: en-US
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
From:   Manfred Spraul <manfred@colorfullife.com>
In-Reply-To: <20230710203557.2BBB0C433C8@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christophe,

On 7/10/23 22:35, Andrew Morton wrote:
> The patch titled
>       Subject: ipc/sem: use flexible array in 'struct sem_undo'
> has been added to the -mm mm-nonmm-unstable branch.  Its filename is
>       ipc-sem-use-flexible-array-in-struct-sem_undo.patch
>
> This patch will shortly appear at
>       https://git.kernel.org/pub/scm/linux/kernel/git/akpm/25-new.git/tree/patches/ipc-sem-use-flexible-array-in-struct-sem_undo.patch
>
> This patch will later appear in the mm-nonmm-unstable branch at
>      git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
>
> Before you just go and hit "reply", please:
>     a) Consider who else should be cc'ed
>     b) Prefer to cc a suitable mailing list as well
>     c) Ideally: find the original patch on the mailing list and do a
>        reply-to-all to that, adding suitable additional cc's
>
> *** Remember to use Documentation/process/submit-checklist.rst when testing your code ***
>
> The -mm tree is included into linux-next via the mm-everything
> branch at git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
> and is updated there every 2-3 working days
>
> ------------------------------------------------------
> From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> Subject: ipc/sem: use flexible array in 'struct sem_undo'
> Date: Sun, 9 Jul 2023 18:12:55 +0200
>
> Turn 'semadj' in 'struct sem_undo' into a flexible array.
>
> The advantages are:
>     - save the size of a pointer when the new undo structure is allocated
>     - avoid some always ugly pointer arithmetic to get the address of semadj
>     - avoid an indirection when the array is accessed
>
> While at it, use struct_size() to compute the size of the new undo
> structure.
>
> Link: https://lkml.kernel.org/r/1ba993d443ad7e16ac2b1902adab1f05ebdfa454.1688918791.git.christophe.jaillet@wanadoo.fr
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> Cc: Jann Horn <jannh@google.com>
> Cc: Manfred Spraul <manfred@colorfullife.com>
> Cc: Davidlohr Bueso <dave@stgolabs.net>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

Reviewed-by: Manfred Spraul <manfred@colorfullife.com>


--

     Manfred

