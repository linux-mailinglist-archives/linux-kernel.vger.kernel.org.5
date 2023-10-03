Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF5317B5EE2
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 04:02:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229848AbjJCCCc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 22:02:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbjJCCCb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 22:02:31 -0400
Received: from mail-ua1-x932.google.com (mail-ua1-x932.google.com [IPv6:2607:f8b0:4864:20::932])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC4CCBB
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 19:02:28 -0700 (PDT)
Received: by mail-ua1-x932.google.com with SMTP id a1e0cc1a2514c-7ab9d4d4317so64365241.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Oct 2023 19:02:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1696298548; x=1696903348; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BZrutkVbMBVvwGrOxYI2YPR8cwqjWmpv0Ny3maTyQSA=;
        b=ifhJBRvphyAcLSLp4WCa342DijKu6xt77s/SYvZvjwO2zSRG3VDPZCARQ5tCrQQAlU
         eiN4eud3pC3dpxBIY2nUVWwFBhQMStD/QaoldwRq9NkxdBOmQTYTFV0D6s05w8ir3EWQ
         RmBCddu4MkHMfOT3V5cG7m4XMwlRp5Z5Q4xw4KIVKbtC8GejItDn0Iqo/WryYjJXWlUz
         BxTFfTrqBa7FVT7vSwzxG3qWh+3XNuRjP4W0QHfqyth9Zs9nJuxZOM0GyA3wPG23E55q
         FKL1hjVgKlbMsQ9ZH7ieZbdwMcGALQCHsiuy9kSqxPpwHhq7tpG7NrKWA+IzVoudoUo3
         w/ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696298548; x=1696903348;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BZrutkVbMBVvwGrOxYI2YPR8cwqjWmpv0Ny3maTyQSA=;
        b=f5Pk4po4ROVrDCTuuikabFSkqWgpysV2N2LRkIM2K//DmrKnZUx7ORKCzyx1IGZkq+
         JvGJWBOhWWZdLzk1yV9pyKNySYZf/8qyYnHVciGzkSjCydP3paSAT89X1AiP0Ni7U9Ih
         PAs0jMN+wcyIcBcJB+JmelMggPrzlwGbEOK9BfOOlclT05Ib/Baqy9HSmsEmLfQZEOs7
         Hqseaodt6yLNv7j0Tt+4wxfqvTR44KLurk/AzkludMTm9WEvFvdgBlHuVA02YNWB2Gmb
         DuTWo9zTtIH0F3UWyNg3tS954olAafBL0EB4PgF3NBiHh0fjFDJhr7nsDoIzj1FIJVib
         BhVA==
X-Gm-Message-State: AOJu0YxQ21hH2YUXPfBku1FOdQCqU7nN3i2Ic8GrAet0Z/5stdk/8qTm
        bI1i2sECkHmAJJzCWVJ+ISLZGQ==
X-Google-Smtp-Source: AGHT+IF/CqQdMgBSJsU3qQ4/45xdl8B9booe/B5e3sVB/2EBQFrKUfrG55I47wBABg83GysdFApgcw==
X-Received: by 2002:a05:6122:1797:b0:48d:8ba:b5d0 with SMTP id o23-20020a056122179700b0048d08bab5d0mr5862839vkf.0.1696298547894;
        Mon, 02 Oct 2023 19:02:27 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id v14-20020a17090ad58e00b002777ba600fdsm6903982pju.25.2023.10.02.19.02.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Oct 2023 19:02:27 -0700 (PDT)
Message-ID: <039d664c-b25e-4d68-80da-ba460ea7f269@kernel.dk>
Date:   Mon, 2 Oct 2023 20:02:26 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [io-uring?] general protection fault in
 io_get_cqe_overflow
Content-Language: en-US
To:     syzbot <syzbot+efc45d4e7ba6ab4ef1eb@syzkaller.appspotmail.com>,
        asml.silence@gmail.com, io-uring@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
References: <000000000000ab32d40606bcb85e@google.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <000000000000ab32d40606bcb85e@google.com>
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

#syz test: git://git.kernel.dk/linux.git io_uring-6.6

-- 
Jens Axboe

