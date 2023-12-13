Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32A938112FC
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 14:32:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379241AbjLMNcd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 08:32:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379261AbjLMNc1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 08:32:27 -0500
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D483F18A
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 05:32:21 -0800 (PST)
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3333b0e0e02so719148f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 05:32:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702474340; x=1703079140;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=Ky8LAzK7nAqd2tH9LL3w2O1SVVDdicI8PvYGs7z7sOLjee8TRHWIKBj1dMtF8AFfry
         yZmae3Xm+dP+qq9WmFo2ok6Tnnc2V2nijuoTjvjyMaMOcJy1ZOj9VqK4HelSrfZg7LWR
         KPn4XLMqa76I991QCcS5SzTmt60L3pTD5klTJX75TyCPZ8eIUwhIfK3kpTVwv0l220gV
         XbkAwXvf5jJjv7TMVw7mWlOIPcw0X7epWElcwPugh3rxQ/z730jIZ9oYTq2JkRjWFx8U
         AUfU8ZLGGqhIP1qVnArk1Lq7lLOPZT+PrHkju3RtCxdEUuA05/mkPB64VgsVkFPvH9qU
         Vntw==
X-Gm-Message-State: AOJu0Yz6H4hfR4hnplKRp1kWSkQxopkeyuWhaVLxO8PL9cqvOmdojivH
        4G9+PBYZwZuQ3d4mLFxbuvQ=
X-Google-Smtp-Source: AGHT+IHtiL6TJ1f/jklrbpRjsZM2kHXTri1pJJ+Uo6bFpgPODUxd/iNWnh/lfKZOIQHTwXfHtWPWbg==
X-Received: by 2002:a5d:44ca:0:b0:336:34d8:3da with SMTP id z10-20020a5d44ca000000b0033634d803damr2202195wrr.4.1702474340141;
        Wed, 13 Dec 2023 05:32:20 -0800 (PST)
Received: from [192.168.64.177] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id k14-20020a5d524e000000b00333479734a7sm13308331wrc.99.2023.12.13.05.32.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Dec 2023 05:32:19 -0800 (PST)
Message-ID: <2fff2da6-1955-4a02-817d-2ab5fa9ee249@grimberg.me>
Date:   Wed, 13 Dec 2023 15:32:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 5/6] nvme: add csi, ms and nuse to sysfs
Content-Language: en-US
To:     Daniel Wagner <dwagner@suse.de>, linux-nvme@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.de>
References: <20231208105337.23409-1-dwagner@suse.de>
 <20231208105337.23409-6-dwagner@suse.de>
From:   Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20231208105337.23409-6-dwagner@suse.de>
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
