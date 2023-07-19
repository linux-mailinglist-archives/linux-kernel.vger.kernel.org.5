Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41EA8759AD7
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 18:34:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229825AbjGSQeQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 12:34:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbjGSQeP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 12:34:15 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44F30B6
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 09:34:14 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id e9e14a558f8ab-34770dd0b4eso3024425ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 09:34:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1689784453; x=1690389253;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iieXIi4cTzyX5sU/8yPoIFAVtn6YDcW57zqx5TU7ebg=;
        b=09WDlvC5f3GHlUlyn7LLHiT2uEm9wFMXxoxDrEG8gH4lw3bi3yOTAr3tbp+QZZfUAz
         I5FYc7PXZDulRrB2oJo+MvElwG733Aav7+9YolhYjS+9zHALaiNiW0TmvdPf9S9Wfe4/
         j/nSTRCoxOpEtrfOA5SRXC7xfWEiY+teBOjagU/fYxuEaN9JVFvFau9pQw6T2HVrkjZE
         p8+DShYM9cRWom2iG89hFEdBVOY3EK0CwSzOWkWXIP7VvGFQMAO2fJwFynw0wMxKYtES
         bJ1kqi7KY1Ut0cCHCYdiNpadLAk5U7UfOeYqr/YqkClojs90CGAo2za7Plp746lVXLkM
         U81Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689784453; x=1690389253;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iieXIi4cTzyX5sU/8yPoIFAVtn6YDcW57zqx5TU7ebg=;
        b=TiJ6NVWaJITfmd/SdcTlbFa1xc9zF9NIXU+mDFxMye0T3DRoeKFYMq2IN823GmdSyu
         egVTYeKSTI/YBz8uqFPxVUCRCinOoN/yLdnzczTw7FdQBdzqlw+o8LQ/PldfsBMgd+A4
         MVLh8sIbWoghHwXqx6QxqkvQcnQy/5hQrskVbLWAR+7awGDVpAPPQF+Uvv7objjix/lZ
         OYbLCNAOSMSONjqaRQz6Gz2Gi98qXD8iq3w2hWgwgz77JscI+0Vev5mvezjo1Azwx2Qb
         aeIxxiw5lY0e6WmyKL04x1JYXOZ6p2nVhcAgZokSPkUp8pIIcmZA9CnSAFT0ML76jCgN
         11kw==
X-Gm-Message-State: ABy/qLbD5UbzUhoeMPd5xgLz1lvZHEW9TTXqvq/aTTAgXNUDmCQYb6kA
        s5SuwRPXuWD4b8Kkze/B6cIiyQ==
X-Google-Smtp-Source: APBJJlHh1Ulh9YNQ/Kx0yxnv+q8TVdGiL9skL9b/HxsOgkmxJ1VEsju4EJ1CyOQA9JHtCZSwQ9vgxA==
X-Received: by 2002:a92:da83:0:b0:33b:d741:5888 with SMTP id u3-20020a92da83000000b0033bd7415888mr299113iln.0.1689784453679;
        Wed, 19 Jul 2023 09:34:13 -0700 (PDT)
Received: from [192.168.1.94] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id t2-20020a056e02060200b00345aaa564a6sm1519038ils.44.2023.07.19.09.34.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Jul 2023 09:34:12 -0700 (PDT)
Message-ID: <ac099071-a16d-46a4-a1b1-2cc786a0a337@kernel.dk>
Date:   Wed, 19 Jul 2023 10:34:11 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] scsi/sg: fix checking return value of blk_get_queue()
Content-Language: en-US
To:     Yu Kuai <yukuai1@huaweicloud.com>, mhartmay@linux.ibm.com,
        bblock@linux.ibm.com, bvanassche@acm.org, hch@lst.de
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        "yukuai (C)" <yukuai3@huawei.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
References: <20230705024001.177585-1-yukuai1@huaweicloud.com>
 <d112d30e-d144-4c76-db98-5de4767f5945@huaweicloud.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <d112d30e-d144-4c76-db98-5de4767f5945@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/18/23 7:09?PM, Yu Kuai wrote:
> Hi, Jens
> 
> ? 2023/07/05 10:40, Yu Kuai ??:
>> From: Yu Kuai <yukuai3@huawei.com>
>>
>> Commit fcaa174a9c99 ("scsi/sg: don't grab scsi host module reference")
>> make a mess how blk_get_queue() is called, blk_get_queue() returns true
>> on success while the caller expects it returns 0 on success.
>>
>> Fix this problem and also add a corresponding error message on failure.
>>
>> Fixes: fcaa174a9c99 ("scsi/sg: don't grab scsi host module reference")
>> Reported-by: Marc Hartmayer <mhartmay@linux.ibm.com>
>> Closes: https://lore.kernel.org/all/87lefv622n.fsf@linux.ibm.com/
>> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> 
> Sorry about the trouble... Can you apply this patch? I notice that the
> original patch is applied to stable.

I can, I had assumed that Martin would pick it up on the SCSI side?

-- 
Jens Axboe

