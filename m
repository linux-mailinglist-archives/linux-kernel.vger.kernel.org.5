Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8055D7F55FF
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 02:42:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232591AbjKWBm1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 20:42:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232009AbjKWBmZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 20:42:25 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5306212A
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 17:42:28 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id 41be03b00d2f7-55b5a37acb6so56285a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 17:42:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1700703748; x=1701308548; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oORLPdmSkT7fywiwae+wqCVAqBVgc5XZ8rvnAnGFiYc=;
        b=rQCcA41nyqanAC0xOBPZ48vRZ5TiRxUb8kOey3R6jbvdcxuSnGWDrjU5yWR9Qcs8KJ
         FsbBzokBu97+m9uKEZMTAqE1VHugBSYNTOdNenctK8KQJwtO/G0OWb7rBd70ZqBHLswH
         CHa6Y9bBZY/als9ftO9mH12WsLXZy7YezCMr/PLcnO/ak/VZL4DI5QV9abXoR3kliqGc
         SODhnksgqgSELjw4KoIAJRmDuzbZzgfiGQeV6yeGaQn+IbF1ZhYMg8617umtVvXZ61m6
         MsjB6VA2EPCaJx7GTRGtRSjdbSwcQNLWsmyrHPnnsHLhQgbnF33HRM/LyTKQfgT3JgF5
         /fCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700703748; x=1701308548;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oORLPdmSkT7fywiwae+wqCVAqBVgc5XZ8rvnAnGFiYc=;
        b=MdpYTcwT1nane6i67Am5xNgqhAfTwOY1KmPMRFEsTz0D71rnzC18mYcy4H4Fp8aeHN
         CZonaZ1SWlgIDuTlDL4HY0BuD+SuCkEMyrhbjmF3v7ZwMGHYwY572CcSwwH95lMiAWVJ
         RfyI6LXjW28D2QGqvvh7VlV1KGKoLNsWNJjiM8lCtjUGYGtpgg2rbslF5grRAXcOjT2m
         SR0vhcR4qG/6gd8LNNoCp+EdFHwz96VzfLCDksQS9IBgVlQ8AVRTKzIYUN2qK1Obrl+p
         pOlunLwb9d7yPl3ri6pbW/Udqg0V69rqeSJUogF8IQaPMNxfhtcy8LDXZPKz8BbY1LeZ
         kiBA==
X-Gm-Message-State: AOJu0YyFV89+lIOV3wfPP1YsXVJekWOmTJVxcDYCfnQ1FLUhd33IaX1B
        KZ9GXj9O/Y+xrAd63oYEqj7O37nQTIL0fZGkLbSuRQ==
X-Google-Smtp-Source: AGHT+IFmhw56H/FIo6SGkKRX/ecBGszAJ+QW7KRUVB+NGb8s0mU1FnZYOsHxXGDdys/4OgZqZtF/xg==
X-Received: by 2002:a05:6a21:99a3:b0:18a:d4c2:cbee with SMTP id ve35-20020a056a2199a300b0018ad4c2cbeemr4888126pzb.2.1700703747526;
        Wed, 22 Nov 2023 17:42:27 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id p47-20020a056a0026ef00b006c052e08813sm128761pfw.50.2023.11.22.17.42.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Nov 2023 17:42:26 -0800 (PST)
Message-ID: <ca200ed6-a70e-401e-b862-f690368e0266@kernel.dk>
Date:   Wed, 22 Nov 2023 18:42:25 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/3] nvme link failure fixes
Content-Language: en-US
To:     Arnd Bergmann <arnd@kernel.org>, linux-nvme@lists.infradead.org
Cc:     Arnd Bergmann <arnd@arndb.de>, Keith Busch <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        linux-kernel@vger.kernel.org
References: <20231122224719.4042108-1-arnd@kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20231122224719.4042108-1-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/22/23 3:47 PM, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> There are still a couple of link failures that I tried to address
> with a previous patch. I've split up the missing bits into smaller
> patches and tried to explain the bugs in more detail.
> 
> With these applied, randconfig builds work again. Please either
> merge them or treat them as bug reports and find a different fix,
> I won't do another version.

Applied, but had to hand-apply hunk 9 of patch 3 due to a previous
attempt at this:

commit 23441536b63677cb2ed9b1637d8ca70315e44bd0
Author: Hannes Reinecke <hare@suse.de>
Date:   Tue Nov 14 14:18:21 2023 +0100

    nvme-tcp: only evaluate 'tls' option if TLS is selected

-- 
Jens Axboe


