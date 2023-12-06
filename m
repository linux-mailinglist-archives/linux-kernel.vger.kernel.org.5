Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 658508067DD
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 07:59:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376909AbjLFG7a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 01:59:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjLFG71 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 01:59:27 -0500
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4523CD66
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 22:59:26 -0800 (PST)
Received: by mail-oi1-x22a.google.com with SMTP id 5614622812f47-3b8b463c7c6so2625623b6e.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Dec 2023 22:59:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1701845965; x=1702450765; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sfqEHLbUHYLDNr52xzISlLf7TCD393bK+BO/LsCYG3E=;
        b=fUSpwS4eOnOAGq42BJJsGCIFQ/B9Irk8wkv2pvh7rJyakFee1e4KO8DdtpUFyjdN+r
         sdVnELKBo3QYdv7oJNjDF+4agJYjC6tatCCmFX6PtdIO4rNeVxwMLE5Kw3QAV8rz0nJY
         beM8rT1Vpqtn4aQtoa1uEPj0RtXgzU8LBT4FI2djrk7E40kGkpuU1A9K4LtS6P4NazX2
         HTC4oHMjiQfOdXlXuL1GU+bOWZHjNz1ZNMVUsPWoa7ZKeeznBEHD8bamwsBaZT4eam/O
         9CWxePrrvOcflLCX95Fna7WJP6HCkGFxQiIeAjgzk5J19coUht5SLUeubOGVKSMS1l28
         XPmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701845965; x=1702450765;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=sfqEHLbUHYLDNr52xzISlLf7TCD393bK+BO/LsCYG3E=;
        b=PA6FmpdnPTZLxDPMfm3V0sapDkBfXW7+LTwHwyrp7+iDJb8D9K/J1axlHNuOF2GBRB
         RsUaFeiweg4qj35bLWmwT7MS8ILcZjvSr3p7lX70ZnleDQNpRF3JXJgfijb2gdHwZikd
         vHpnKAm9+9UHGYtxw9Ozx0b98c197WLKag2nK1NhIEp/amfLDIf8Pdt7N0AWE6EvHhSJ
         AVdPt/BRxqyJwqoOmLn77z1TZcYqTWmBAtpvXCoNLAP5lmUNKidFtyPGDRy/smD0yMZe
         +g7fsSgNaMzKZ+dEejg3qhxyEDQyWq/dV+ArLDXFtmtekIRA38AObEENjx44BLXMtkEL
         Pwmg==
X-Gm-Message-State: AOJu0YyiECq3Ou/Sq9YoLexnokE6BDiO/HBjeZTL0QkXOWUG+CAd7dAR
        A142uIMtdL1ZMSN0o8jCfm9Kxw==
X-Google-Smtp-Source: AGHT+IEe1DCMs1vCS65e5ggb9jvVWH07VbtqqRGVbP9+tHVKJFmcpLj5v7Cl/x3LWwioPRdxmFGjsw==
X-Received: by 2002:a05:6808:1494:b0:3b8:b4c6:ce0d with SMTP id e20-20020a056808149400b003b8b4c6ce0dmr729443oiw.81.1701845965611;
        Tue, 05 Dec 2023 22:59:25 -0800 (PST)
Received: from [10.84.153.17] ([203.208.167.146])
        by smtp.gmail.com with ESMTPSA id e15-20020aa78c4f000000b006ce5f2996d4sm3967316pfd.143.2023.12.05.22.59.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Dec 2023 22:59:25 -0800 (PST)
Message-ID: <b7053425-65eb-46a0-abd9-59ade5e78211@bytedance.com>
Date:   Wed, 6 Dec 2023 14:59:18 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Re: [PATCH bpf-next] netkit: Add some ethtool ops to provide
 information to user
To:     Daniel Borkmann <daniel@iogearbox.net>,
        Nikolay Aleksandrov <razor@blackwall.org>, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, yangzhenze@bytedance.com,
        wangdongdong.6@bytedance.com, tangchen.1@bytedance.com
References: <20231130075844.52932-1-zhoufeng.zf@bytedance.com>
 <51dd35c9-ff5b-5b11-04d1-9a5ae9466780@blackwall.org>
 <16b4d42d-2d62-460e-912f-6e3b86f3004d@bytedance.com>
 <94e335d4-ec90-ba78-b2b4-8419b25bfa88@iogearbox.net>
 <57587b74-f865-4b56-8d65-a5cbc6826079@bytedance.com>
 <2a829a9c-69a6-695d-d3df-59190b161787@iogearbox.net>
From:   Feng Zhou <zhoufeng.zf@bytedance.com>
In-Reply-To: <2a829a9c-69a6-695d-d3df-59190b161787@iogearbox.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2023/12/4 23:22, Daniel Borkmann 写道:
> Thanks, so the netkit_get_link_ksettings is optional. 

Yes, netkit_get_link_ksettings really not necessary, I just added it in 
line with veth.

I don't quite
> follow what you
> mean with regards to your business logic in veth to obtain peer ifindex. 
> What does
> the script do exactly with the peer ifindex (aka /why/ is it needed), 
> could you
> elaborate some more - it's still somewhat too vague? 🙂 E.g. why it does 
> not suffice
> to look at the device type or other kind of attributes?


The scripting logic of the business colleagues should just be simple 
logging records, using ethtool. Then they saw that netkit has this 
missing, so raised this requirement, so I sent this patch, wanting to 
hear your opinions. If you don't think it's necessary, let the business 
colleagues modify it.

Thanks.

