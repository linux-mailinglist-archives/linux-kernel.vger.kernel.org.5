Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33BAA75756C
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 09:35:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231714AbjGRHfg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 03:35:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229708AbjGRHfe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 03:35:34 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E14210CC
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 00:35:08 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id 46e09a7af769-6b9c9944da8so2113840a34.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 00:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1689665707; x=1692257707;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jgI1g6KuDBssW0xC2nWGPlICaywUY7ceINZ1wtR5IPw=;
        b=H/tYDf5V6RHvpXFgIkCToL5GtUIew+xvwozbim+IhHlQmCr479On8EkLrGZKqf9hgR
         3P1+0qGv//OMygTBbkgmruNLt4uGERle7yBqWEKsnz/fMXUOyNWUqyldPHCL40S+qcaR
         VJnw5EcTGf6NHnxpsEBKtiASa5kY8D/WIXJUsS5mI4q0AVC1wKR+QLPHUl39iyGVHQkY
         iQXBLn/FU2BmqhYeT3Sh36UI6sWqHTDzkTEn3fax9EGcRcA5jACL+Ot3e+Ih1bKVbRF+
         vXSoVJMf2a6nnUx0EwjKk3HIocnA0/hGOM9wlT9AVA4MfLZNXhFGY257fN29gZcgIv6R
         R1WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689665707; x=1692257707;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jgI1g6KuDBssW0xC2nWGPlICaywUY7ceINZ1wtR5IPw=;
        b=h8bAKsXp10wOfzEfNFlPNTTXHmWMAT0GsRdG+k7+xQKJZ/72GupA60681vbsm8+qED
         dx6SwVd7t+e0daOxafAOWsNS3yz//VqXVDbKvVHoPgFelL1e///nX2sb2JLacnvQr/g7
         zT3wTagixqRCs/0SFFwG1SfYXIns/76IQrUWuMH+PoreVaR7EpfauYYeUSuiOYehBhIR
         jpeQraIQrvbSN0U0lFNN6bxg1mg8Zaj1Yat0FjKNAC87PQxe3wycLBTKd8CzAGFTuSgI
         HuiVW4kbs4u9yVVQg/cdR38VX6RV1ZtGEKNNbpTSWkgZB6Ngo7MblhxauZNALrOnY4nE
         MuWA==
X-Gm-Message-State: ABy/qLYE2qgNkY0f8Mk0taSgoXVb8A46BlS94zUQp5xco0ZbgG+W8kku
        qgrWOAn7Cu8uzLHuEbTZVIE3tg==
X-Google-Smtp-Source: APBJJlFtJNdi6mp4u89yYehQEAYYKXQ414hO2eU19t8VWoeIfjD/7PCVSU5EULs8aGQ/k4oWNw7ekg==
X-Received: by 2002:a05:6358:428e:b0:135:85ec:a092 with SMTP id s14-20020a056358428e00b0013585eca092mr12638757rwc.26.1689665707481;
        Tue, 18 Jul 2023 00:35:07 -0700 (PDT)
Received: from [10.254.181.133] ([139.177.225.252])
        by smtp.gmail.com with ESMTPSA id m22-20020a637116000000b0055c558ac4edsm1028564pgc.46.2023.07.18.00.35.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jul 2023 00:35:07 -0700 (PDT)
Message-ID: <f0aa25be-8f44-b71c-baf9-f22890c32329@bytedance.com>
Date:   Tue, 18 Jul 2023 15:35:01 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH v2] mm: kfence: allocate kfence_metadata at runtime
To:     Marco Elver <elver@google.com>
Cc:     glider@google.com, dvyukov@google.com, akpm@linux-foundation.org,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, muchun.song@linux.dev,
        Peng Zhang <zhangpeng.00@bytedance.com>
References: <20230712081616.45177-1-zhangpeng.00@bytedance.com>
 <CANpmjNOhNQuBZAgOKLv4+4UoFK1b_8PP0EzWzkuyyGE0bg+weg@mail.gmail.com>
From:   Peng Zhang <zhangpeng.00@bytedance.com>
In-Reply-To: <CANpmjNOhNQuBZAgOKLv4+4UoFK1b_8PP0EzWzkuyyGE0bg+weg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you for your review, I have updated v3[1] with all
the changes you mentioned.

[1] 
https://lore.kernel.org/lkml/20230718073019.52513-1-zhangpeng.00@bytedance.com/

Thanks,
Peng

