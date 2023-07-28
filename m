Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D871D7663F5
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 08:16:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233330AbjG1GQK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 02:16:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232575AbjG1GQI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 02:16:08 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDF851FF5
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 23:16:06 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-98273ae42d0so47267966b.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 23:16:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690524965; x=1691129765;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ulD+jGAERfOBD4mt/Di4lPdx1Csw98WhuKZo73fBdX8=;
        b=qJlp/+OIBvM8DpMP7qbgBsja1aFwxPLSMRVPLB34OJOf6sMHBpEqLl8mS1KgbdOkMz
         1H8jKiMJ3yeUt7EbYPcJo293wZofNByvPYpDTQc13fLA2/AWFR33opRGPxCGe7nWDvlI
         W18+nFdg2Bc2ersWy91UKtlm2XT7a3bthNQYnxad90T0yc7T7ZRo7bmg/idWwqQpeZRE
         4pTMoMQnoI+E6Kf6vxI+LOJ7N94IWe8kTTebMMdAAYoXhbvyPLvv3XmLAQhxR5ftvkH4
         q/b906KvatDToadFNrXBYaau1pRADrjzd8RbutAKzeU3sWlSpfrwF8VmBC9aLa4dajtD
         gxZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690524965; x=1691129765;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ulD+jGAERfOBD4mt/Di4lPdx1Csw98WhuKZo73fBdX8=;
        b=Wpk1sRHW4+M4FoRVvurmU0R0CoOgNyWtJAyFU1YaRRkMYcMwMev2YlybpKzVmOH9oW
         IaVb3rSwRdPH3fFOqOnkIF555ukIU5Yqo7lfr5icOdr1UM2xiYg0vde0RTaCCpGvNvcd
         Rm7gYj8xAM8KY/B0/CeZDP3lzHuPPDO9Mm1nB8IkXqRySKBgwpyXZ8bzuTMDC1khzIQ0
         BYCYujH3LyixP9gfpjP519ws+arH6QO1rJUSTAL6QVbnSugh6CR8eNn81ewRhxnPscNq
         O+VvU79fYb+sqT8dBqRCzMC5/rD7HqJ7cAs0fadFDVeuXydruFW7nsOSd6B0dub/0bm7
         eSKQ==
X-Gm-Message-State: ABy/qLbh4pVgkDSeKdTg4c8DKnsYi1Qkz8w1t8MOWIDgEpbzUyLTd16M
        Fy28X2Ogt1CYlYT4EiT6Vuv+cbU3/9g=
X-Google-Smtp-Source: APBJJlFHa1n5RUu6Fkxms5HcSulXc3nohRDrQPmwIIBghyF0PnEOvLUeKqc89gxjeZp3otiaOkHq/g==
X-Received: by 2002:a17:906:51dd:b0:993:eed1:8f7 with SMTP id v29-20020a17090651dd00b00993eed108f7mr1150254ejk.3.1690524964961;
        Thu, 27 Jul 2023 23:16:04 -0700 (PDT)
Received: from [192.168.0.103] (p57ba2e0b.dip0.t-ipconnect.de. [87.186.46.11])
        by smtp.gmail.com with ESMTPSA id t7-20020a1709063e4700b0098d15d170a0sm1633773eji.202.2023.07.27.23.16.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jul 2023 23:16:04 -0700 (PDT)
Message-ID: <f4aaf5f5-a6b0-ef10-0d9b-fc52035ca309@gmail.com>
Date:   Fri, 28 Jul 2023 08:16:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 0/5] Staging: rtl8192e: Function name cleanup series 1
To:     Tree Davies <tdavies@darkphysics.net>, gregkh@linuxfoundation.org,
        anjan@momi.ca, error27@gmail.com
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20230728054742.622297-1-tdavies@darkphysics.net>
Content-Language: en-US
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <20230728054742.622297-1-tdavies@darkphysics.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/28/23 07:47, Tree Davies wrote:
> Rename functions to fix checkpatch warning: Avoid CamelCase
> 
> 
> Changelist:
> v3: Changed patch #5, Rename global function ResetBaEntry to rtllib_reset_ba_entry
> v2: Sent to mailing list via git send-email, patches are the same.
> 
> Tree Davies (5):
>    Staging: rtl8192e: Rename function ActivateBAEntry
>    Staging: rtl8192e: Rename function DeActivateBAEntry
>    Staging: rtl8192e: Rename function TxTsDeleteBA
>    Staging: rtl8192e: Rename function RxTsDeleteBA
>    Staging: rtl8192e: Rename function ResetBaEntry
> 
>   drivers/staging/rtl8192e/rtl819x_BAProc.c | 44 +++++++++++------------
>   drivers/staging/rtl8192e/rtl819x_TSProc.c |  6 ++--
>   drivers/staging/rtl8192e/rtllib.h         |  2 +-
>   3 files changed, 26 insertions(+), 26 deletions(-)
> 
Hi Tree,

those patches have been accepted and cannot be applied again.

commit c928e84ce577262da288c0178c8c77620ba8b430 (HEAD -> 
staging-testing, origin/staging-testing)
Author: Tree Davies <tdavies@darkphysics.net>
Date:   Wed Jul 26 23:19:47 2023 -0700

     Staging: rtl8192e: Rename function RxTsDeleteBA

     Rename function RxTsDeleteBA to rx_ts_delete_ba in order to Fix 
checkpatch
     warning: Avoid CamelCase

     Signed-off-by: Tree Davies <tdavies@darkphysics.net>
     Link: 
https://lore.kernel.org/r/20230727061948.579480-5-tdavies@darkphysics.net
     Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

commit 7b31905582358d566332182653a4e5552dba1574
Author: Tree Davies <tdavies@darkphysics.net>
Date:   Wed Jul 26 23:19:46 2023 -0700

     Staging: rtl8192e: Rename function TxTsDeleteBA

     Rename function TxTsDeleteBA to tx_ts_delete_ba in order to Fix 
checkpatch
     warning: Avoid CamelCase

     Signed-off-by: Tree Davies <tdavies@darkphysics.net>
     Link: 
https://lore.kernel.org/r/20230727061948.579480-4-tdavies@darkphysics.net
     Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

commit 8dd56eaa9450fb19f6bcc73956b3b1477331d28b
Author: Tree Davies <tdavies@darkphysics.net>
Date:   Wed Jul 26 23:19:45 2023 -0700

     Staging: rtl8192e: Rename function DeActivateBAEntry

     Rename function DeActivateBAEntry to deactivate_ba_entry in order 
to Fix
     checkpatch warning: Avoid CamelCase

     Signed-off-by: Tree Davies <tdavies@darkphysics.net>
     Link: 
https://lore.kernel.org/r/20230727061948.579480-3-tdavies@darkphysics.net
     Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

commit ca77687ae3f6d65fb26a0e1f93b54753af3581fc
Author: Tree Davies <tdavies@darkphysics.net>
Date:   Wed Jul 26 23:19:44 2023 -0700

     Staging: rtl8192e: Rename function ActivateBAEntry

     Rename function ActivateBAEntry to activate_ba_entry in order to Fix
     checkpatch warning: Avoid CamelCase

     Signed-off-by: Tree Davies <tdavies@darkphysics.net>
     Link: 
https://lore.kernel.org/r/20230727061948.579480-2-tdavies@darkphysics.net
     Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>


Bye Philipp
