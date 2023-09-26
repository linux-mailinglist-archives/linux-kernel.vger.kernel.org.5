Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4DE07AEABE
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 12:51:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234458AbjIZKvV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 06:51:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234451AbjIZKvS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 06:51:18 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECF4A120
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 03:51:10 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id 46e09a7af769-6c4d625da40so3657663a34.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 03:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1695725470; x=1696330270; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oVHWYYZF7IWZQwYjRKgttRtydqd0ImaiVelgwSHmu9k=;
        b=jQ/RX7sPZiCQL9S/d41bA4SDhVxJH3Whqw1Sqi1+/QX4N1GghutSVqVt1AgCmEJ2V1
         eU2nOpqOei6HEuNo2t/zIJePWzd8Zutt/h1uzZTn85zuSJ5UMe5r7fr/4jVgwMRkiUkn
         96uWmrBPwZV9eo5dDOLwr4cM3c7orzPQ2W093WubD+yDkMmtgmO8Tw0eFr3pFAOThgyq
         vQW1CG8ezEXCkfHCBMKW+tEAWXv450QmVv98DKHuNMtdMhquLSza++z5AbscS2y7ucvQ
         EZm6Z4EjUYpB1pMpghfBVEEhFwUYcULwj499bRL9vkZesa/hbT2aeRjXX9dMNAuXd1oU
         ZyjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695725470; x=1696330270;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=oVHWYYZF7IWZQwYjRKgttRtydqd0ImaiVelgwSHmu9k=;
        b=Tgt7o5rgn1G1ErkkRdmkQ7h0KSEMX4Q9yOv8LUUO4gqA9PnqKNHWOdnwKgUgi6ozgl
         GCRzfnlPbfqUEsR2pX3vw8ezhVtLSgOg45IlMJQVNwKMnZwRN03g3+5FGVdqODxNMhqQ
         c6jlQABrA5CTfBDIRASyhN3alOrIAl7tD7SqNAxUIFVoS0f/5j8CPJlg8ve9w69er7O8
         pZkJV6gjukXA6TKNI/ODJmxjnI3qjS2UHmx2Ju629NkSznUBXXlPcMc5ak+8BfEND77q
         K7Q6J0KMOlG8iiO0SEIhCt3WxwxkPk+CD/nnsVCnNbVmSwGhGEYJkawl3OS2wmFOKvoC
         TQpw==
X-Gm-Message-State: AOJu0YzqUxp/zVhTaBO5rSxPURjBm7MhU/ih+65j0qzIBpzwl8pswA7h
        Z05UUILvB46wMnDRtSPETGmTujvcejnsyxuOcMo=
X-Google-Smtp-Source: AGHT+IGD2gKm9S/Z2injrtRA6YnUVtxM9Rzs8I/X6/ewsVn04nFVPko57tLZcoS4O5n8ld0EJ7u4dA==
X-Received: by 2002:a9d:62c6:0:b0:6bf:1f5f:ed18 with SMTP id z6-20020a9d62c6000000b006bf1f5fed18mr9878036otk.1.1695725470335;
        Tue, 26 Sep 2023 03:51:10 -0700 (PDT)
Received: from [10.54.24.10] (static-ip-148-99-134-202.rev.dyxnet.com. [202.134.99.148])
        by smtp.gmail.com with ESMTPSA id j17-20020aa78dd1000000b0068c1ac1784csm9723150pfr.59.2023.09.26.03.51.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Sep 2023 03:51:10 -0700 (PDT)
Message-ID: <16513744-f6db-d96e-92df-15184e6bbb7f@shopee.com>
Date:   Tue, 26 Sep 2023 18:51:06 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH] sched/psi: bail out early from irq time accounting
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     surenb@google.com, linux-kernel@vger.kernel.org
References: <20230925102143.462545-1-haifeng.xu@shopee.com>
 <20230925123106.GB347250@cmpxchg.org>
From:   Haifeng Xu <haifeng.xu@shopee.com>
In-Reply-To: <20230925123106.GB347250@cmpxchg.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/9/25 20:31, Johannes Weiner wrote:
> On Mon, Sep 25, 2023 at 10:21:43AM +0000, Haifeng Xu wrote:
>> We could bail out early when psi was disabled.
>>
>> Signed-off-by: Haifeng Xu <haifeng.xu@shopee.com>
> 
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>
> 
> Can you please resend this with Peter Ziljstra <peterz@infradead.org>
> in CC? Thanks

thanks, I'll send a new mail later.
