Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87D73768A68
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 05:47:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbjGaDrQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jul 2023 23:47:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjGaDrO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jul 2023 23:47:14 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8911E53;
        Sun, 30 Jul 2023 20:47:12 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1bc02bd4eafso10246055ad.1;
        Sun, 30 Jul 2023 20:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690775232; x=1691380032;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0+Iq8rjthuWxB9vm3ZVIy+baoDKsYpVrmoMrfb4dLKY=;
        b=YStm9bVWepmcQguvBLejF2BBxgRQqDiSzZ3kCJaYEePpdHArTHnp/xb1yJZo6Oekwy
         KPpLCt1fGbbA5gZfZNdZO9ozUCa+//Z4YC5wNkrR0VVZTPVmJvLk9O0Ml9drDsB+rYMA
         R0SO51OiSS0wxj3AL6PBGxheppHXcW6ZaL/x5HS3jfIqXv+STFIE/RuwWBVBBynzQ+aQ
         BqG6M1h6U9HwQk6wZ8KiPZ4akXnSgixTE0ZTiDKHvt7GFMSMpXUFheIMLbhw5PVwNLmd
         uafLu7StnqFFyzk2ayMT/tJ1RsYePwCaT74eqh9Hx06vJ+M6r2iXEX65/aH01XyDsF7O
         LsmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690775232; x=1691380032;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0+Iq8rjthuWxB9vm3ZVIy+baoDKsYpVrmoMrfb4dLKY=;
        b=QwGUNJdV9PRnMOTFj0Gj5GozbErQ5VJ6u4D+onRuFxiSQCoWJsJAIYt7leV8H2sxFv
         sfxZxT+cUQ1F5o6yZEOKrCkHb2u6CAN5pyXv0aR8lHd8uyyuUzTMUjZXCjbwXR1QfJ4T
         fBZrg5+0Qus1MIMQrh2F8c4zNaH8djlUHrqA5rWjqy9skpbGBAJM4VXMDPoQZEojuSTD
         3H6TboC/rsb/AVIOwZ2lLisVptRn9Z2fqete8dN+7okVAvCXgUJt03hPvw8/dG6lrq8n
         HFUd6AeMFLRda5dPns/0NIP8ibEsgW6SkwqWDl+xvPJ0nsInT1WASNOkEVI3bdDTX4eB
         vdhw==
X-Gm-Message-State: ABy/qLZhFao1DgcZ5iG9+fRhLzZDs6viFHmdU7I+IHcSCyMxJ+DWlMJE
        tbGzjBZwf8za8BNUr1zciyE=
X-Google-Smtp-Source: APBJJlFTyP6ZfRWoW3McU9rAP40CAOmt4Cfdu3V0g/Fm6FNad28/o1TXHMe2Q5WqQPKReghuDGX0cg==
X-Received: by 2002:a17:902:eccf:b0:1b5:694:b1a9 with SMTP id a15-20020a170902eccf00b001b50694b1a9mr10899480plh.32.1690775232164;
        Sun, 30 Jul 2023 20:47:12 -0700 (PDT)
Received: from [192.168.1.121] ([65.129.146.152])
        by smtp.gmail.com with ESMTPSA id ix13-20020a170902f80d00b001b9d7c8f44dsm7325338plb.182.2023.07.30.20.47.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 30 Jul 2023 20:47:11 -0700 (PDT)
Message-ID: <ec2a2031-366d-c6c1-ff11-accd1cccae8f@gmail.com>
Date:   Sun, 30 Jul 2023 21:47:11 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Scsi_bus_resume+0x0/0x90 returns -5 when resuming from s3 sleep
To:     Damien Le Moal <dlemoal@kernel.org>,
        Thorsten Leemhuis <regressions@leemhuis.info>
Cc:     regressions@lists.linux.dev,
        Mario Limonciello <mario.limonciello@amd.com>,
        Bart Van Assche <bvanassche@acm.org>,
        LKML <linux-kernel@vger.kernel.org>, stable@vger.kernel.org
References: <0e272abe-292d-d58f-cf80-55868e793abc@gmail.com>
 <6b66dd9a-8bd5-2882-9168-8e6e0848c454@leemhuis.info>
 <c70caa9e-164c-fee5-8f85-67f6d02373ab@kernel.org>
 <b0ed86e0-3e4a-d4d1-7b9d-c57f20538a80@gmail.com>
 <86435987-734e-c6c1-a857-1ba80da709fe@gmail.com>
 <48bc1736-5e4e-3a9b-3715-60509c333bb1@kernel.org>
 <f7e7b601-571f-bd2e-6410-a8a27e510c2f@gmail.com>
 <40365501-283a-408b-3514-48c29db36861@kernel.org>
 <d44e4057-0758-4cb8-ca29-02b5bb340b8b@gmail.com>
 <2b7e9239-fd48-0f74-f69b-e0039809c857@kernel.org>
Content-Language: en-US
From:   TW <dalzot@gmail.com>
In-Reply-To: <2b7e9239-fd48-0f74-f69b-e0039809c857@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Oh excellent I'll go do that now.

On 7/30/23 18:41, Damien Le Moal wrote:
> I posted a proper patch and CC-ed you. A "Tested-by:" tag from you 
> would be much appreciated (please use your full name in that case, 
> instead of only "TW"). Thanks.
