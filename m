Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3089C8112F0
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 14:32:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379209AbjLMNbw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 08:31:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379228AbjLMNbt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 08:31:49 -0500
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08C33115
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 05:31:55 -0800 (PST)
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-40c192f488cso11417825e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 05:31:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702474313; x=1703079113;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=bUl9T1yQsgUYmtWgGeaEZoD3vOONiLXtjfefowz3r9XVyANd4CepUWOXypvfvvHKGr
         lbj8mv0t6HIzaOW6JQbF8wyHWULZ76a74bzTwlLZH9NkNAyf4uLON/655/FJ2hj5aivR
         nmdvHFeKd9etefOQ1inX9QbgqNLrVpeVCh7WL5rJOfiRON/B99EgVASXbPCRNciaiXiA
         NzMSegkwVE/c4BeXwv/bjBHdRlyZU8vwlTyN2Gb3oXvYiQX/zGjNE+DzGryjBcYQ1BWE
         gPrVXZhlIyi+j+9AC22r+xiPbZcC96MvbnOvVjsoBcMHmTvOJcVEZRO/tCeGlUqP8jUp
         p27g==
X-Gm-Message-State: AOJu0YzFIKmNJ8L5cfRpZMV8IswaxO3wPQoKVhvVyl4KPgeYmXhLODaF
        KI7/lOCLPpgbuj0n7TZhyy8=
X-Google-Smtp-Source: AGHT+IGh1eaw0Hl61JrzotywNG9+7JxMrT618PD/xeUqmNoCx2I/ZtN+xxfRtsLhCb5l6GKFmeSsaQ==
X-Received: by 2002:a05:600c:1d9b:b0:40c:2960:9603 with SMTP id p27-20020a05600c1d9b00b0040c29609603mr9826466wms.3.1702474313260;
        Wed, 13 Dec 2023 05:31:53 -0800 (PST)
Received: from [192.168.64.177] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id k14-20020a5d524e000000b00333479734a7sm13308331wrc.99.2023.12.13.05.31.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Dec 2023 05:31:52 -0800 (PST)
Message-ID: <26c02e67-cf59-4eb4-8dd0-c8f7f2a2b820@grimberg.me>
Date:   Wed, 13 Dec 2023 15:31:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 6/6] nvme: repack struct nvme_ns_head
Content-Language: en-US
To:     Daniel Wagner <dwagner@suse.de>, linux-nvme@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.de>
References: <20231208105337.23409-1-dwagner@suse.de>
 <20231208105337.23409-7-dwagner@suse.de>
From:   Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20231208105337.23409-7-dwagner@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
