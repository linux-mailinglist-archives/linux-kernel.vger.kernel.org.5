Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DA6A7C8979
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 18:02:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232553AbjJMQA1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 12:00:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232565AbjJMQAP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 12:00:15 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A3B0E6
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 09:00:13 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id ca18e2360f4ac-79fb8f60374so26883939f.1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 09:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1697212812; x=1697817612; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QAM2fFfPiP1Mnp6RwSY6WoqTNoSbS2pT2DLPBUGrp7w=;
        b=rrCrw5s1DsfXmhMFj10FRwq/HSz6GDwOsJh/3tTWTTuOEmekMD6+D3FDakwbVXIEJx
         KcZ+SdOqCbnFznYxpDeFRM6L+SkEmr2xApTI7vwZ2W1TWvPIWs301oerHIEf9VQGalTt
         OeMyr+7ElAMNIEzAylCtjtaKVNEBqGUksZUr7koL8XsUQkPdtHFXTKcpOk225fIjXk3/
         L2usDCporBC2e7IRX1lPm4USPJcGD/nFDC3yfuzhYRqyTe09XLtHfWp5GkdGPX4xGEM2
         V65JIylkzY03qxieHx+w+qivOo0mWr6g5NmAz21tlJEcb2t3z9KYcHmIWbuznxEH6z+y
         Fjnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697212812; x=1697817612;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QAM2fFfPiP1Mnp6RwSY6WoqTNoSbS2pT2DLPBUGrp7w=;
        b=qDXDHqgdjBnUgWVVsxbM/JsuOUN1XZBhi9nWDD+RirGkQl+fErL2r6PlLL9NtAHy0a
         PGcmXLdZxf3eXWCQy1+zgWb5i+t9ND+2eC5I462VCXB+Tr6OjffRL96vkSXT16Px+qgf
         HQDp2EalcKjImCSznYtC8kuopXJLTuWauWs06GYxl9gIXoiiOfP+8iBenEF1/i+06fJM
         7daESF0xXUfXwYkVY+hD8/qEURw4LRzl/4+as9jLu4GFXCR+746fvwA6G7e9m7C2ukvS
         Sp0uuQNBNsT+ml8S+hjb8F0R6iYoaSAtSr8xZjevjOXq/4+4mI6r/t/GgBJx9BhB9+wM
         Xlbg==
X-Gm-Message-State: AOJu0YzOj2CqkVvcCKYwvkuMhbt2iM4yT66z3E1LkhWzmw8jv8TbPz5M
        UhcmMl1lXErRWls6wsuF2vPWVQ==
X-Google-Smtp-Source: AGHT+IFzjem69ePBCBqDP5L3fTUJ3gv63iLK3duQ9K4PYEd++2EOb3gD3dGfha97sNftPIO0xQJWSQ==
X-Received: by 2002:a05:6602:2a44:b0:792:9b50:3c3d with SMTP id k4-20020a0566022a4400b007929b503c3dmr33400985iov.1.1697212812650;
        Fri, 13 Oct 2023 09:00:12 -0700 (PDT)
Received: from [192.168.1.94] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id h15-20020a0566380f0f00b0042b5423f021sm4605218jas.54.2023.10.13.09.00.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Oct 2023 09:00:12 -0700 (PDT)
Message-ID: <55620008-1d90-4312-921e-cef348bc7b85@kernel.dk>
Date:   Fri, 13 Oct 2023 10:00:11 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] audit,io_uring: io_uring openat triggers audit reference
 count underflow
Content-Language: en-US
To:     Paul Moore <paul@paul-moore.com>,
        Christian Brauner <brauner@kernel.org>
Cc:     Dan Clash <daclash@linux.microsoft.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        dan.clash@microsoft.com, audit@vger.kernel.org,
        io-uring@vger.kernel.org
References: <20231012215518.GA4048@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <20231013-karierte-mehrzahl-6a938035609e@brauner>
 <CAHC9VhTQFyyE59A3WG3Z0xkP6m31h1M0bvS=yihE7ukpUiDMug@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CAHC9VhTQFyyE59A3WG3Z0xkP6m31h1M0bvS=yihE7ukpUiDMug@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/13/23 9:56 AM, Paul Moore wrote:
> * You didn't mention if you've marked this for stable or if you're
> going to send this up to Linus now or wait for the merge window.  At a
> minimum this should be marked for stable, and I believe it should also
> be sent up to Linus prior to the v6.6 release; I'm guessing that is
> what you're planning to do, but you didn't mention it here.

The patch already has a stable tag and the commit it fixes, can't
imagine anyone would strip those... But yes, as per my email, just
wanting to make sure this is going to 6.6 and not queued for 6.7.

-- 
Jens Axboe

