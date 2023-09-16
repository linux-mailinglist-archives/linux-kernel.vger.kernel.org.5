Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DC547A3260
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Sep 2023 22:03:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239093AbjIPUDC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Sep 2023 16:03:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232530AbjIPUC2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Sep 2023 16:02:28 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F15991AD
        for <linux-kernel@vger.kernel.org>; Sat, 16 Sep 2023 13:02:23 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id 46e09a7af769-6bf01bcb1aeso1875487a34.3
        for <linux-kernel@vger.kernel.org>; Sat, 16 Sep 2023 13:02:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694894542; x=1695499342; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nRVx5i+8USC91YzqQPV0HVkgXBAWAOVqx9+jbhEu9bM=;
        b=ezJyhtT6F40Pw19MmrlzduJK4G5vnk5txjT+utnqstmFxzqoe64C0LY/E1IVWR7FPX
         0X0XJJcGTEoNchPYDMgcF3QspCAVe0F4UMBIEKUjuUY2InS2i7mfP9YN1uO/LQqMyAEg
         4HnTga6D6YCL3IMTyO3SacTsNGtPx0yiEJaBoEZalO9fEzlfYl+w0TSqapBQ3zxAibxz
         xOLPXRmiToshS8akXuhmx+v0w0wbv33o7/EOEGAFwg1OvHGS5loIkuS6DIdM0P+140ta
         Xn5Et6ZylKOr2iW2Vh3Gu6n1mygXBGS4Zoz8iZABg2P6mKaufrTyyUknC5xS7MkkIuci
         zhNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694894542; x=1695499342;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nRVx5i+8USC91YzqQPV0HVkgXBAWAOVqx9+jbhEu9bM=;
        b=NNmGY23AwqhNC/AztJez0jJZG8dz+A+N6Jg0mElPUgmnSCRaMOGDgMxk6AS4byM4Mh
         FnuppP5SSCabO9Q2K5ZETm6gELYRw7Z4kwCi0QIseKtyUoVzzxYj27irQk7XlT4mCE5G
         Nz0jRx2ymm++Uznu0M9ZEz0f4/K2hsVCp+oV85Sx5jOaZjQG2Wa1L4ItR90/H4JhQfsp
         2/nFV40f5PhV/qQdYFnsflN9AexnuozLtiINlYf2ISpOWUZ2BHWRX6AiCwQe9CA0FICI
         KDDYUeVkPrkMyeh5/qzqRkIe0m2/QhUNEDIS2IL1obFJzqDL7u9BvBMU/0J4uBULx693
         rSuw==
X-Gm-Message-State: AOJu0YyHdfHZ8JY1+wtgQm7VwAzHplDC0pBbXu4RFhx+68nz5ajtnRMk
        /BmqlNUkF+g6IZUIbW1wcScScPBXEmk=
X-Google-Smtp-Source: AGHT+IGfq9Quhs+2BcXXfUTUkNAAmCSvlU7wBpIYBWCtnBshpMDm2EqbamIQRax0epuzd4llU2IYHw==
X-Received: by 2002:a05:6830:1d7:b0:6b8:7880:de9 with SMTP id r23-20020a05683001d700b006b878800de9mr5662922ota.19.1694894542607;
        Sat, 16 Sep 2023 13:02:22 -0700 (PDT)
Received: from [192.168.1.224] (067-048-091-116.res.spectrum.com. [67.48.91.116])
        by smtp.gmail.com with ESMTPSA id e15-20020a9d63cf000000b006b99f66444bsm2758972otl.71.2023.09.16.13.02.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 Sep 2023 13:02:22 -0700 (PDT)
Message-ID: <9770fe32-2b0c-639e-481a-dd8686e5eb7d@gmail.com>
Date:   Sat, 16 Sep 2023 15:02:16 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v2] driver core: shut down devices asynchronously
Content-Language: en-US
To:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Tanjore Suresh <tansuresh@google.com>,
        Martin Belanger <Martin.Belanger@dell.com>,
        Oliver O'Halloran <oohall@gmail.com>,
        Daniel Wagner <dwagner@suse.de>,
        Keith Busch <kbusch@kernel.org>, Lukas Wunner <lukas@wunner.de>
References: <20230913210516.3545-1-stuart.w.hayes@gmail.com>
From:   stuart hayes <stuart.w.hayes@gmail.com>
In-Reply-To: <20230913210516.3545-1-stuart.w.hayes@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/13/2023 4:05 PM, Stuart Hayes wrote:
> Shut down devices asynchronously, ensuring that each device is shut down
> before its parents.
> 
> This can dramatically reduce system shutdown/reboot time on systems that
> have devices that take many seconds to shut down, such as some NVMe drives.
> On one system tested, the shutdown time went from 11 minutes without this
> patch to 55 seconds with the patch.
> 
> Signed-off-by: Stuart Hayes <stuart.w.hayes@gmail.com>
> ---
> v1->v2: rewritten using kernel async code (suggested by Lukas Wunner)
> ---
> 
>   drivers/base/base.h   |   2 +
>   drivers/base/core.c   | 135 ++++++++++++++++++++++++------------------
>   include/linux/async.h |   6 ++
>   3 files changed, 87 insertions(+), 56 deletions(-)
> 

Please disregard this patch... I realized this could be done in a simpler way.  I'll send a V3 this week.
