Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42848781C90
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Aug 2023 08:01:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229959AbjHTGBE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Aug 2023 02:01:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbjHTGAq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Aug 2023 02:00:46 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A841BB24A
        for <linux-kernel@vger.kernel.org>; Sat, 19 Aug 2023 21:41:02 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-3fe4f3b5f25so4300825e9.0
        for <linux-kernel@vger.kernel.org>; Sat, 19 Aug 2023 21:41:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692506461; x=1693111261;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sEUiRsdPM8OsMS9j6lOuFSmnlNffxKK6lGvWrTtGvTc=;
        b=Z2LoOFLQhoSyIRraDxLb1NhBh3Hbx7fewSTMOey4roIQfcP2N4PJ+Z7Xd84gNb42Qi
         kFzV9P7JyLZR4EmuMD2tFnSi/ECqhbTaO6BWwPohhtKcarlyqwDS/9VTu8nkhO60LXs2
         MrojCqtqFZKtv3qgDas/bt2LvbK/eLZ8YjfFdoTZVldUToobmVMkkPHn9dTv3gyNXhYA
         LH/EkCFjuctFPeHnnXiN4UAjq+8YwxYRGLLyKj1+Z2iTnC3bybpWO+rkP1QYlgdVQ7gV
         UzzcAHO0YRA98206N4sIBVWz9LsYmNJ7iDkMgwCfijn9f6fbxgm1xw0bVlA7Mn419q6l
         KbtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692506461; x=1693111261;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sEUiRsdPM8OsMS9j6lOuFSmnlNffxKK6lGvWrTtGvTc=;
        b=EFrwTPFyytwiDWZN3i2uu5MGn2qclO+Yib/mMZ+qEAX+xJa9xHKFsJO1oLhyUu3p9f
         +8QuO+vXD8u6YWsccj5n+AeYqeyW8NnqlcPaTDSAXtmA+83PcHrLnd1gIg+hyaJP0+zd
         Ofsvg2PATOWYFyoRAzJ9Owu6OF6Tt/Tnk3jOfvE5xlFSz7QjW1DEfhmCqrnZtVqhpUyl
         LdOKvkS1rSNJOao37si8jB8tWg8CWOKqNdELBxnSN0OBO1GNetYfpLAv8pnUIZhqU6Lc
         YIKI+J3MkLU3gi0l5Z8uXV1Zt9d1IxsQK6sTle2sLLTS3z900Z/inKNfD2NJZFQwn5mO
         3fEA==
X-Gm-Message-State: AOJu0YwwceXjcaEmuNuJh8mc7VSY7SJz19y83bNuqiG4cMkHrut6AeQl
        PQPeSQiUx4POU5ZCk6+Ptn44+QRZIkY=
X-Google-Smtp-Source: AGHT+IHvwx3O+C7FQgW4JE6fShqykkLZpAPUcfCqh6aGflD2JZBqoZqiYujZjgbqd15ea+dn66nCsQ==
X-Received: by 2002:a05:600c:54ea:b0:3fe:d780:4f93 with SMTP id jb10-20020a05600c54ea00b003fed7804f93mr2909656wmb.0.1692506460508;
        Sat, 19 Aug 2023 21:41:00 -0700 (PDT)
Received: from [192.168.0.100] (p579356c7.dip0.t-ipconnect.de. [87.147.86.199])
        by smtp.gmail.com with ESMTPSA id q13-20020adffecd000000b00317643a93f4sm8144019wrs.96.2023.08.19.21.40.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 19 Aug 2023 21:41:00 -0700 (PDT)
Message-ID: <f84189f9-6561-67cf-2e4f-8bc80d6e06f9@gmail.com>
Date:   Sun, 20 Aug 2023 06:40:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 00/16] Staging: rtl8192e: Rename struct rx_ts_record
 references
To:     Tree Davies <tdavies@darkphysics.net>, gregkh@linuxfoundation.org,
        anjan@momi.ca
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20230820004744.278022-1-tdavies@darkphysics.net>
Content-Language: en-US
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <20230820004744.278022-1-tdavies@darkphysics.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/20/23 02:47, Tree Davies wrote:
> The goal of this series is to fix checkpatch warning Avoid CamelCase,
> for all references of struct rx_ts_record. In most cases renames the
> references to, ts, to make the naming consistent.
> 
> The first 8 patches have been sent before, and versioned appropriately.
> 
> Thank you in advance to the reviewers,
> ~ Tree
> 
> Tree Davies (16):
>    Staging: rtl8192e: Rename variable pRxTs in function rx_ts_delete_ba()
>    Staging: rtl8192e: Rename variable pTS in function
>      rtllib_rx_ADDBAReq()
>    Staging: rtl8192e: Rename variable pRxTs in function rtllib_rx_DELBA()
>    Staging: rtl8192e: Rename variable pRxTs in function
>      rtllib_ts_init_del_ba()
>    Staging: rtl8192e: Rename variable pRxTs in function
>      rtllib_rx_ba_inact_timeout()
>    Staging: rtl8192e: Rename variable pRxTs in function
>      RxPktPendingTimeout()
>    Staging: rtl8192e: Rename variable pTS in function ResetRxTsEntry()
>    Staging: rtl8192e: Rename variable pRxTS in function TSInitialize()
>    Staging: rtl8192e: Rename variable tmp in function GetTs()
>    Staging: rtl8192e: Rename variable pRxTS in function RemoveTsEntry()
>    Staging: rtl8192e: Rename variable pTS in function prototype
>      rtllib_FlushRxTsPendingPkts()
>    Staging: rtl8192e: Rename variable pTS in function AddReorderEntry()
>    Staging: rtl8192e: Rename variable pTS in function
>      rtllib_FlushRxTsPendingPkts()
>    Staging: rtl8192e: Rename variable pTS in function
>      RxReorderIndicatePacket()
>    Staging: rtl8192e: Rename variable pRxTS in function
>      rtllib_rx_check_duplicate()
>    Staging: rtl8192e: Rename variable pTS in function
>      rtllib_rx_InfraAdhoc()
> 
>   drivers/staging/rtl8192e/rtl819x_BAProc.c | 36 ++++-----
>   drivers/staging/rtl8192e/rtl819x_TSProc.c | 73 +++++++++---------
>   drivers/staging/rtl8192e/rtllib.h         |  2 +-
>   drivers/staging/rtl8192e/rtllib_rx.c      | 94 +++++++++++------------
>   4 files changed, 102 insertions(+), 103 deletions(-)
> 

Tested-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>



