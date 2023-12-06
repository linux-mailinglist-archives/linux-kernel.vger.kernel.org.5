Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF6B380793D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 21:16:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442878AbjLFUQf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 15:16:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379461AbjLFUQe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 15:16:34 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AF40CA
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 12:16:40 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-6cdcef787ffso219853b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Dec 2023 12:16:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1701893800; x=1702498600; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qHDdFruPzZ1Pb4ZidhpAKqlDu1RUv7Xj40kMDRXWKOw=;
        b=seUOAm2EBwc/WuIGST4vJT01SqITGy+RszSSQlP4KcbRIiehIyjU/Nal2SAsPI7KN7
         1h26ZqnBXZyIPFAjkPLag2VLXOhVqf5K+7onpVUjH9ShcM0kShN+Iuu2tP+dhV9C3BN7
         zdhd6ynJxvxUtFI/I6s7erTPndlmgkBd9nyhYP8SEvwT7OyMlAp2ha+zfRfgddO/L5cA
         hvi0AMOnvPM3Ws2zgbQjSAVnLWO8g8tKkP9nUd+9kH/lX039CJvuEH25QOl1AIvnLfgt
         ddY9DsFYaDMTROMVIiPcnCcKltKA41a5HXIX03CxnWb8jGQjZVhskeIlVjQW/P0MGNVb
         C6BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701893800; x=1702498600;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qHDdFruPzZ1Pb4ZidhpAKqlDu1RUv7Xj40kMDRXWKOw=;
        b=ChwZndCezQUMtdzWFAXoWJKb3n2T6C6ZqGCIlT+zSNzRE1Nmx+azToyX5w16wll9Ot
         qy+LUEtEJP+0KxTCtvzLIiylTc4+83Lz/CNiHHuCAzKy5+T3qQtQQVeD0x5+8dGXISdB
         M7g14XKueovlHmcqm0DE+y62RxJofZMpNevpfxKauBCLQp+MLuPuY5rmOuJf0mSzB/+l
         y2Oo/nmch4wWAYppN6ZKRq8JNSX/7/sKrtN0VHSStzGQp7JN6nf7+ibVtUKLRLvXEWL5
         1mBWeIjYOzjGVunhFTbfSMiwkLMBzrRlX7E0j6z8vAP9Wib4Sau9mr0fEkIwEhx0qMId
         wWYw==
X-Gm-Message-State: AOJu0YyruZAwngHjeHrSvzo4aQ+P33nryVstwtnU8sgBJWpP9V+EnGg5
        G9A4FHqSDneF/5s+dd/fHwkqrQ==
X-Google-Smtp-Source: AGHT+IEJjGg7cjU8bDiExvmdFdxPzabdESP6PC+IZS/5jqk/UWm39U57AGakQVtdh8kYN2CMcrru8A==
X-Received: by 2002:a05:6a00:430f:b0:6ce:7631:8d7f with SMTP id cb15-20020a056a00430f00b006ce76318d7fmr1579922pfb.51.1701893799957;
        Wed, 06 Dec 2023 12:16:39 -0800 (PST)
Received: from [192.168.50.25] ([201.17.86.134])
        by smtp.gmail.com with ESMTPSA id b3-20020aa78ec3000000b006cb60b188bdsm348444pfr.196.2023.12.06.12.16.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Dec 2023 12:16:39 -0800 (PST)
Message-ID: <7789659d-b3c5-4eef-af86-540f970102a4@mojatatu.com>
Date:   Wed, 6 Dec 2023 17:16:28 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] net/sched: Load modules via alias
To:     =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, cake@lists.bufferbloat.net
Cc:     "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Jamal Hadi Salim <jhs@mojatatu.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Jiri Pirko <jiri@resnulli.us>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>,
        Yonghong Song <yonghong.song@linux.dev>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
        Vinicius Costa Gomes <vinicius.gomes@intel.com>,
        Stephen Hemminger <stephen@networkplumber.org>,
        Petr Pavlu <ppavlu@suse.cz>, Michal Kubecek <mkubecek@suse.cz>,
        Martin Wilck <mwilck@suse.com>
References: <20231206192752.18989-1-mkoutny@suse.com>
Content-Language: en-US
From:   Pedro Tammela <pctammela@mojatatu.com>
In-Reply-To: <20231206192752.18989-1-mkoutny@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/12/2023 16:27, Michal Koutný wrote:
> These modules may be loaded lazily without user's awareness and
> control. Add respective aliases to modules and request them under these
> aliases so that modprobe's blacklisting mechanism (through aliases)
> works for them. (The same pattern exists e.g. for filesystem
> modules.)
> 
> Original module names remain unchanged.
> 

Can't you just keep the sch-, cls-, act- prefixes for the aliases?
They look odd in the current patchset TBH

