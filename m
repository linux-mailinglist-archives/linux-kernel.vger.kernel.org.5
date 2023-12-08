Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4680809A1C
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 04:15:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573047AbjLHDPP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 22:15:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231892AbjLHDPO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 22:15:14 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C07D810CA
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 19:15:20 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1d072f50a44so3674965ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 19:15:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1702005320; x=1702610120; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jGfLZ/anCgoizin3EJrsBtWsOUnIV8oEkhHw3KAoiyE=;
        b=R1dbJvL4+eLjEhhg0VgKY1AyJG3WfUpl2uxQt+FrXUBP2zJo3ZTU1KPTLIGLtnpSvl
         WVtby8UN9DTj5oBxNmDlOmfjSz+86PVJOXQ5XTk+0QOpU32ClIiM52GlRRfnjv+o2wTL
         FJ7mn4tve4W+KE7AhVjKoQ3JwmfPod4VQDdS0O8aO+OdAlidD2cS5xY04gE/Ncwb52Wv
         s6PoYDk+M7xrGj8YUaBpbUjLRNaqZsqHilmMLjBcI2UZhYP9cXdprcq/USkp3IGdSp3p
         aJoJSuaraEW1cwQgBvbsqF0FH/fjvDJWvCwZzNPe5TpdyvDb/0JOGMriSqLcnHEEKCuR
         Jz8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702005320; x=1702610120;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jGfLZ/anCgoizin3EJrsBtWsOUnIV8oEkhHw3KAoiyE=;
        b=YUQQY+9m0tyeujUXxEcYjK/RUrzuBu1FV6NQL2UD0AGrUp9hbbxJoW1nJkTzO6J8b6
         IrLtQlWiPl6Paq9o408SDJbEg0KPJfi7y6ocKl4j7RoWeYyk5CvQOcH+15AV4p+Gt39y
         mgDiIRELhZo3WO4LUAekXLcxhd/Oep2xzsTIelqJBuoPlleScJdqKAXzdLCXlqvEbSXL
         A2D7twjQhtlpx2knsBba7FKbDyRBQoEM6uYi06F3plwls0ZKCVZF83Oospzp0JYg7LgX
         ZU7/7GNwMgte1nV6ahX4eRDMCPMhtDKz0IC96sNAvj/7lKF/0lr7ZKuq0XSTJ6Gx03uS
         KVCQ==
X-Gm-Message-State: AOJu0Yw8c4CvUh8UGFZo0GvvB+3zYkcQHsmuVqP+t3yjinm4vceMFApp
        lr2trnYCX9sMyXgQfb2G1AMrNQ==
X-Google-Smtp-Source: AGHT+IEb0VGLsYlBNxLkCRq834nrTlhul/JW2q5GdSZUzgMVZYylVw6G7cr3f6N2ts4MFxlhZfZU8A==
X-Received: by 2002:a05:6a20:1583:b0:18b:4b84:3a1 with SMTP id h3-20020a056a20158300b0018b4b8403a1mr7015450pzj.5.1702005320251;
        Thu, 07 Dec 2023 19:15:20 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id w4-20020aa78584000000b006ce5c583c89sm532425pfn.15.2023.12.07.19.15.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Dec 2023 19:15:19 -0800 (PST)
Message-ID: <d9afeea8-2e67-4a90-8f7e-98b4c904a314@kernel.dk>
Date:   Thu, 7 Dec 2023 20:15:18 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] virtio_blk: set the default scheduler to none
Content-Language: en-US
To:     Keith Busch <kbusch@kernel.org>, Ming Lei <ming.lei@redhat.com>
Cc:     Li Feng <fengli@smartx.com>, "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        "open list:BLOCK LAYER" <linux-block@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:VIRTIO BLOCK AND SCSI DRIVERS" 
        <virtualization@lists.linux.dev>
References: <20231207043118.118158-1-fengli@smartx.com>
 <ZXJ4xNawrSRem2qe@fedora> <ZXKDFdzXN4xQAuBm@kbusch-mbp>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <ZXKDFdzXN4xQAuBm@kbusch-mbp>
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

On 12/7/23 7:44 PM, Keith Busch wrote:
> On Fri, Dec 08, 2023 at 10:00:36AM +0800, Ming Lei wrote:
>> On Thu, Dec 07, 2023 at 12:31:05PM +0800, Li Feng wrote:
>>> virtio-blk is generally used in cloud computing scenarios, where the
>>> performance of virtual disks is very important. The mq-deadline scheduler
>>> has a big performance drop compared to none with single queue. In my tests,
>>> mq-deadline 4k readread iops were 270k compared to 450k for none. So here
>>> the default scheduler of virtio-blk is set to "none".
>>
>> The test result shows you may not test HDD. backing of virtio-blk.
>>
>> none can lose IO merge capability more or less, so probably sequential IO perf
>> drops in case of HDD backing.
> 
> More of a curiosity, as I don't immediately even have an HDD to test
> with! Isn't it more useful for the host providing the backing HDD use an
> appropriate IO scheduler? virtio-blk has similiarities with a stacking
> block driver, and we usually don't need to stack IO schedulers.

Indeed, any kind of scheduling or merging should not need to happen
here, but rather at the lower end. But there could be an argument to be
made for having fewer commands coming out of virtio-blk, however. Would
be interesting to test.

-- 
Jens Axboe

