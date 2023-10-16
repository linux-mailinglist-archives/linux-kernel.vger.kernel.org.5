Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0964C7CA857
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 14:47:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233205AbjJPMq6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 08:46:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233256AbjJPMqz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 08:46:55 -0400
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com [IPv6:2001:4860:4864:20::2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 395E0EB
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 05:46:53 -0700 (PDT)
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-1e5bc692721so2511676fac.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 05:46:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1697460412; x=1698065212; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QQn52arwsdlU29PQnPUmt11cUghW1KEbpQJERkynB38=;
        b=mHs0jN2JyCgWWmOVLzDbHdbX7Yc+arb8AC3OgKm/udJ2jmgw+t+dPSWnsIS8hOTmyF
         EnuAZJWXTCVeql5wRmiN8ncP4PgqEay7OAzt4BTv90T9omUAPIPt/uD8KqD14uu+vbDp
         6gOEOQlfTiydNDSRAc0BVOoVwZ16qobwiBbklql/c0jG2PkBOHEyzMyjbdKJZUyum/u+
         4IxXHO0yv4PwMV9qee+DJoaApz9YsHk+4LNHMX03KMiYOMVDZNHeD/pVE68hY6Z3bk0o
         3GSg1VNXUmnRDIowKjsevXQGXyeY5k2HaIjfkyouahOfFOW+GSXbZ0zNkLpHU1fAb1u5
         WWZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697460412; x=1698065212;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QQn52arwsdlU29PQnPUmt11cUghW1KEbpQJERkynB38=;
        b=pMp3Sz75GnVlaE5sd3c00bCMb7GWZ0KJawNLOUFUYzxU24Y3MVHpuZBAzeNSk7TuSM
         JqXj14secBVskJXWcWil3N1LQCMoZXgPen3Pqmcyt4N7AaCKxwF1WKMX+MPPjHJDtEyq
         r8mPeG906rhIP0waYFEhEqo1QWnNy8kMSyxSah1e7hyDkqTiEi32SPxXIUTDZuM0nzVn
         GO2JJwItuWyt/1oO6d3gBV/ZWUwVMDEvlER2JvPw3CiWASK6srG+nhSWQzRmAaVrmt3b
         zigIf7T4tj3KE5M0VGCrtt8Ypn8GRUpP9JRykwyzU1/7AgLUxY/qfc//Gyay33SJxkP8
         QVWA==
X-Gm-Message-State: AOJu0YxtxXZUiPuoCVJu80HTGXe8izSCAX/YrFt1fSQHHtkyPR53zyxu
        e7G6hB/XMKCqqB382cmz8x64mw==
X-Google-Smtp-Source: AGHT+IFvrhrpIu8cV2fbdx301eoOk6upJqN7PRTBdpuJFrIHudU6DCIRXETrY2BPEMiiSd3o90G1Vw==
X-Received: by 2002:a05:6870:588c:b0:1b4:4a2e:33f1 with SMTP id be12-20020a056870588c00b001b44a2e33f1mr39706890oab.29.1697460412561;
        Mon, 16 Oct 2023 05:46:52 -0700 (PDT)
Received: from ?IPV6:2400:4050:a840:1e00:78d2:b862:10a7:d486? ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
        by smtp.gmail.com with ESMTPSA id d15-20020a63360f000000b0058ac101ad83sm7926569pga.33.2023.10.16.05.46.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Oct 2023 05:46:52 -0700 (PDT)
Message-ID: <a158470f-6393-4a24-ad8f-ce6c3474db9f@daynix.com>
Date:   Mon, 16 Oct 2023 21:46:47 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] selftests/bpf: Use pkg-config to determine ld flags
Content-Language: en-US
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     Andrii Nakryiko <andrii@kernel.org>,
        Mykola Lysenko <mykolal@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>,
        Yonghong Song <yonghong.song@linux.dev>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Shuah Khan <shuah@kernel.org>, Nick Terrell <terrelln@fb.com>,
        bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20231016115438.21451-1-akihiko.odaki@daynix.com>
 <f2af3626-deb5-2830-9e41-4f6b7537baa6@iogearbox.net>
From:   Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <f2af3626-deb5-2830-9e41-4f6b7537baa6@iogearbox.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/10/16 21:19, Daniel Borkmann wrote:
> On 10/16/23 1:54 PM, Akihiko Odaki wrote:
>> When linking statically, libraries may require other dependencies to be
>> included to ld flags. In particular, libelf may require libzstd. Use
>> pkg-config to determine such dependencies.
>>
>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>> ---
>> V1 -> V2: Implemented fallback, referring to HOSTPKG_CONFIG.
> 
> This still does not work with BPF CI, BPF selftest build fails again :
> 
> https://github.com/kernel-patches/bpf/actions/runs/6524480596/job/17716169959 :

I was so careless forgetting to put "echo". I have just sent v3.
