Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BEAC80A587
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 15:33:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573961AbjLHOdD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 09:33:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573929AbjLHOdB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 09:33:01 -0500
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80B75173B
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 06:33:03 -0800 (PST)
Received: by mail-il1-x12e.google.com with SMTP id e9e14a558f8ab-35d7ccadf6aso1386265ab.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Dec 2023 06:33:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1702045983; x=1702650783; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FhKB2NnA3QfPl8JS/+/Dz6ofNDQVrqehkPOlELsJS+E=;
        b=wIXkXK7VclHcncaay17vBIRE/l0+1pJHu5VoCf8i6xUTgwTwH2Zd/fbWG0xePZGEaY
         P2Sk7Np3sQD4oAsQ4lrxNMoK9bPRsm4yMn2in+J4P3jgcOZ4Y8ViQFHYhdAefAkUYMlA
         41FNb4+QkHTnRMI2AvnRBNr03u8249/8vijuicNoFgjoi864Vls+ZvTSWZw8Aw8v3GCQ
         HyYIlUwfauNOfTlhvlvuo67dif5YmSPOTUa733pVhKVd70yJ8DHrWsnmi/NAgLMuh5c3
         o6/dd06gj2ldBogaPImHJ5jdfT2O2Hf+w5+ppLli5wWong93Bvf0EnAMesra5Fs6nPmz
         chbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702045983; x=1702650783;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FhKB2NnA3QfPl8JS/+/Dz6ofNDQVrqehkPOlELsJS+E=;
        b=Oyg99sfUuIhBZGFs0HqFJ57Gb1inius8nmeLNe9l2wEK0x5kj7KpanoZL1mNxzKvfB
         j/Y5yKcOZMOjUBYJSSky2wVBb/1shDNmRIO3qajAvtb3APhViXG+SXvqIsrmWQVAvFO0
         CwrAocSH7xht1/VIgU8EmcVp6te4bLJIyykr+YfKVZ5DlkgluCmepn70ZS8IUBGUoqAT
         UNEOez5nZWIxhrl0ose8jzAI/lNbbCsLjEtQAu9cN5IdnTmcT4NpOvzeSbSUmpYlQXON
         1ZQlpk6NSxSPHbo13hVFesjZueYKjkZkdUUEX8v6j7txbD7DJCtviUb+dO8akwKW05WB
         mJFA==
X-Gm-Message-State: AOJu0YysoRJhaXJgSIuUnIshcBra5HDAXBYmlCWMqVJPqUvLBPUcDoAJ
        f9DXIXM/1y79ZLcTwCu3w9I5PQ==
X-Google-Smtp-Source: AGHT+IHtnfwS/1QYLNszRS02hyT365XtE7NQd2W0lYKD1LjknRMEQiKkxW7ZSV+rSbha8MlTxHOiHg==
X-Received: by 2002:a6b:a0d:0:b0:7b6:f0b4:92aa with SMTP id z13-20020a6b0a0d000000b007b6f0b492aamr484458ioi.0.1702045982860;
        Fri, 08 Dec 2023 06:33:02 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id h5-20020a02c725000000b0043167542398sm466537jao.141.2023.12.08.06.33.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Dec 2023 06:33:01 -0800 (PST)
Message-ID: <815dd284-14c7-4990-9ef7-41bd7087b724@kernel.dk>
Date:   Fri, 8 Dec 2023 07:33:00 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] nfsd: fully close all files in the nfsd threads
Content-Language: en-US
To:     NeilBrown <neilb@suse.de>, Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nfs@vger.kernel.org
References: <20231208033006.5546-1-neilb@suse.de>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20231208033006.5546-1-neilb@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/7/23 8:27 PM, NeilBrown wrote:
> This is a new version of my patches to address a rare problem with nfsd
> closing files faster than __fput() can complete the close in a different
> thread.
> 
> This time I'm simply switching to __fput_sync().  I cannot see any
> reason that this would be a problem, but if any else does and can show
> me what I'm missing, I'd appreciate it.

Much better than the previous attempts, imho.

Reviewed-by: Jens Axboe <axboe@kernel.dk>

-- 
Jens Axboe

