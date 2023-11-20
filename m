Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B62557F1121
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 12:01:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233135AbjKTLBG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 06:01:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233118AbjKTLBE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 06:01:04 -0500
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF412A0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 03:00:59 -0800 (PST)
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-40a279663a2so10859865e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 03:00:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700478058; x=1701082858;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=KCH7Drnp131se/Jz+PsSQGoX9lLTLMnfWh5qNvF6Ja4nmAz/X44FzaFIzK2zFVTjNV
         bIt0+hA9oXXZ9uGYP5eC3qpxbGDylTDuZ083Tqw3qMtEhgz5iFgoPQXjSyfLrqswomcl
         FI5P8em1IQriAxCnC149jwje0Vkj0IIjeMKcnNGqXptkdLKuYydRhNIf0NrJwuT3yczi
         hTCP7/45zJXsuhDEx/hkrJC4M9Ux9wUEedkA27fMtNHXLJ3KP3U9iWnArwySymFyztzK
         NuX6h6Oj0b1FNMsntJcVjN8C0k7faACpQSBSe1Xgmjzb7CR5Dps3bc+1475YeNr1gkJu
         Wy/Q==
X-Gm-Message-State: AOJu0YwAdmgJdznvJ0kFSe4TfeWtanuDAsZtFlldPCI8vvMriiwA+dTw
        iM8F/cnUXVgAxYfHsHsLPi4=
X-Google-Smtp-Source: AGHT+IHVR99i7EbRPsVjoH9MxHPDPPxBEwlF1A7Xh544f7NN8cZjI45w+Jq78sPjPFMrh6c7vFQgPQ==
X-Received: by 2002:a05:600c:4514:b0:408:3836:525f with SMTP id t20-20020a05600c451400b004083836525fmr6605378wmo.1.1700478058165;
        Mon, 20 Nov 2023 03:00:58 -0800 (PST)
Received: from [192.168.64.177] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id t13-20020a05600c450d00b004094e565e71sm13041848wmo.23.2023.11.20.03.00.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Nov 2023 03:00:57 -0800 (PST)
Message-ID: <bc8e8f13-b622-4a91-9440-8d9912a76612@grimberg.me>
Date:   Mon, 20 Nov 2023 13:00:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2 RESEND] nvme-auth: unlock mutex in one place only
Content-Language: en-US
To:     Mark O'Donovan <shiftee@posteo.net>, linux-kernel@vger.kernel.org
Cc:     linux-nvme@lists.infradead.org, hch@lst.de, axboe@kernel.dk,
        kbusch@kernel.org, hare@suse.de
References: <20231011084512.1835614-1-shiftee@posteo.net>
From:   Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20231011084512.1835614-1-shiftee@posteo.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
