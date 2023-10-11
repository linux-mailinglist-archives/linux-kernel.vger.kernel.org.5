Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42AFE7C5E40
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 22:20:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346999AbjJKUUu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 16:20:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233446AbjJKUUt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 16:20:49 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFF45A9
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 13:20:47 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id ca18e2360f4ac-7a29359c80bso832439f.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 13:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1697055647; x=1697660447; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lB/j2LtNeMz/W1YQQ732duppdg4xiLJo45Q+RSgVAQo=;
        b=xtMLL3AujsI8XG2mXYhKUB/spGXSmJKab1wO/UvQS/pPVYZARPmE+q8H5VdoRMh/IG
         2/ie0e4WfoJrxn7MwIUU1jey8Kz0OCtZ6Gx8F5yZ3p+Cql8E56xlX9sAnutWbqSzV7Kq
         Ml+SaWHjAa0ntgCwGDvYPs9VgVRqAlZxhKrgkyoCR/TmVHC41Waj0OVMNozcOCKhkZMi
         JkfvejHYT6yyKfAPLzUKORCZDE3qQxLDY+k0S0EbX2kS7B1G8gOsiw85/hYi4hp//0Al
         v8FQb1gOjr0mablPKIPxrSRweSLmtdr3J5joUQZASyPdGibvXxtduZF+i5hnEySIM4Ol
         v+hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697055647; x=1697660447;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lB/j2LtNeMz/W1YQQ732duppdg4xiLJo45Q+RSgVAQo=;
        b=gn0l0W9dghqNHyrQOgdIbkA+cIF3l7DhluxoPbpu7bGr03F3cZlSNOogVKmkPZtcFf
         I/QEWUUJyn3JPlxwMfdnU8CKTEOJhA6iu4i9XdMvjAA4fEBkmalZL/Yju6uUw3sfzIGm
         8BhkWXFVdmC6k/5PmtyJG+LqXvKmjkagcKfFvK6c+5NvfIZSFdHEnwV7i9X4hs7NnoOD
         RsFgnxvDDM9sI23CawSI9TU6Aw/GEeiatNtxfLJ5vshg3bpDwA52VNbRiT2M/9QejaXL
         d+giSaNP2D3v8npJI12Xmw1+h/1kbL52X5MSZlTaOIlbjt5ueIoOLLKATXK6AMVU+O7U
         6Gbg==
X-Gm-Message-State: AOJu0Yz9daRgb3VtB9A9jA3OcVuv7bA4+FjxVaGDNvuGMj9iC8+Mg/By
        t8Nt7Dh3MNEoQ3tTW80lr9QQuA==
X-Google-Smtp-Source: AGHT+IEruZKhD7bxlTjyy47l5LeM/sL4l3VP9Zm6qvwYHSSSMgVJNz0+ACbD8gaUX5jTiNivN3JKDQ==
X-Received: by 2002:a92:db4f:0:b0:350:f353:4017 with SMTP id w15-20020a92db4f000000b00350f3534017mr20611565ilq.0.1697055647337;
        Wed, 11 Oct 2023 13:20:47 -0700 (PDT)
Received: from [192.168.1.94] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id r13-20020a92ce8d000000b003513de0eae9sm177591ilo.24.2023.10.11.13.20.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Oct 2023 13:20:46 -0700 (PDT)
Message-ID: <b068c2ef-5de3-44fb-a55d-2cbe5a7f1158@kernel.dk>
Date:   Wed, 11 Oct 2023 14:20:45 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: Don't invalidate pagecache for invalid falloc
 modes
Content-Language: en-US
To:     Sarthak Kukreti <sarthakkukreti@chromium.org>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Bart Van Assche <bvanassche@acm.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        stable@vger.kernel.org, "Darrick J . Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Mike Snitzer <snitzer@kernel.org>
References: <20231011201230.750105-1-sarthakkukreti@chromium.org>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20231011201230.750105-1-sarthakkukreti@chromium.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/11/23 2:12 PM, Sarthak Kukreti wrote:
> Only call truncate_bdev_range() if the fallocate mode is
> supported. This fixes a bug where data in the pagecache
> could be invalidated if the fallocate() was called on the
> block device with an invalid mode.

Fix looks fine, but would be nicer if we didn't have to duplicate the
truncate_bdev_range() in each switch clause. Can we check this upfront
instead?

Also, please wrap commit messages at 72-74 chars.

-- 
Jens Axboe

