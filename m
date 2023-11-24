Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B313D7F79FD
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 18:03:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231173AbjKXRDf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 12:03:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbjKXRDd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 12:03:33 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1052F172E
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 09:03:39 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id 98e67ed59e1d1-2809748bdb0so458110a91.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 09:03:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1700845418; x=1701450218; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EttzaI0nhO53eCepTQDlN4y1aR++7e9+n9jNRJSBAnI=;
        b=HAUFzsZI2Mbe//QMJ9qZ0qOduLtiU/G5Cayf5GCyLZzSHg+4BLErpmMjIIEI5taAZo
         MGKdFuGcfeBo7Z5iWgp53OgvLpXbMrUMnvMDwANX8U2CrMdOHn1D9RVYLygzOhAHridc
         Wtk7iQVdMP1a6pPikuye1fi97oFJ28nCaroqmrT0IiU3Jbb2g5FbzSmFbWOXPFvUx6On
         d98ejXcJqvtec5E/st5pg7SM36ftePSwvQc4U3DVU+2ErlFq5HqKKFXT5kSirD6r+Vn7
         FFPUnYkc6PXc8rnMjlie3AeTVV1iMCrs6nZ7mSeD8iKwsVxFxql8Gd8pclFTchp6lHXG
         rGzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700845418; x=1701450218;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EttzaI0nhO53eCepTQDlN4y1aR++7e9+n9jNRJSBAnI=;
        b=UKHnNJOLGPlAfPwqmxkg+LpOi7sGBeQuqChhU+/0u74Xvnv8ArIuyOa809dxXNssH0
         SDjF6R3JAh2AQMxcd6RppK4OnR3f5gicLFnlgRY72izk5fx0FG3Z2UsahmT+rCoFFJ72
         hlNJBCBh3hiUaIVWn8Gij3Qkmkg1crtyqRoGT6S437DGZFg1m21HcsMGZz4OHNg0ioJL
         PgmsMEa7rbRYKqzw2kfSvVVCBGhUcBM9Qb4Xi+kT1DKVvTyxt+RvfVWnF0bw+8cBzz1Y
         yuIYHBkn1NZ0RTrQKJwU+PPEh9rq3bZ1O/IdaHXO2/LJo6y3IP7jR2DIbcOS2PnVeg1x
         /mzQ==
X-Gm-Message-State: AOJu0YwWoTQX6la6WulQ74ya2UmlOzwqlUX7VNtoS84ChjPUmurCjVVa
        c9CEMP8lDs1CEn2SlCfm2E1FSQ==
X-Google-Smtp-Source: AGHT+IGjjL47Qg76W6NQQX8rc0L7riURgvwZXOQh1P8ZYDi+tPV1SXHJVTouJXnyPT02+qTwWoeFJA==
X-Received: by 2002:a17:90a:7408:b0:285:6f2b:4e82 with SMTP id a8-20020a17090a740800b002856f2b4e82mr3395923pjg.1.1700845418428;
        Fri, 24 Nov 2023 09:03:38 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id k2-20020a17090a590200b0028571e2a759sm2616351pji.48.2023.11.24.09.03.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Nov 2023 09:03:37 -0800 (PST)
Message-ID: <7a54a166-56fd-4d6c-a5bf-792aa58a8fe5@kernel.dk>
Date:   Fri, 24 Nov 2023 10:03:36 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 00/11] blksnap - block devices snapshots module
Content-Language: en-US
To:     Sergei Shtepa <sergei.shtepa@linux.dev>, hch@infradead.org,
        corbet@lwn.net, snitzer@kernel.org
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        viro@zeniv.linux.org.uk, brauner@kernel.org,
        linux-block@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Sergei Shtepa <sergei.shtepa@veeam.com>
References: <20231124165933.27580-1-sergei.shtepa@linux.dev>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20231124165933.27580-1-sergei.shtepa@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/24/23 9:59 AM, Sergei Shtepa wrote:
> From: Sergei Shtepa <sergei.shtepa@veeam.com>
> 
> Hi all.
> 
> I am happy to offer an improved version of the Block Devices Snapshots
> Module. It allows creating non-persistent snapshots of any block devices.
> The main purpose of such snapshots is to provide backups of block devices.
> See more in Documentation/block/blksnap.rst.

Please stop posting the same version, this is the third one of the
morning. What's going on?

-- 
Jens Axboe

