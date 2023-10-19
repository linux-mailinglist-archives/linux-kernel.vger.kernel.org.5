Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 259E47CFD70
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 16:59:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346178AbjJSO7J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 10:59:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346174AbjJSO7E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 10:59:04 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C37012F
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 07:59:01 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id e9e14a558f8ab-3575732df7fso5210205ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 07:59:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1697727541; x=1698332341; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=H+fSKfoprD2xjep9haqaGcjsUyuDzAiaP8KcDuihTMA=;
        b=sUoD+aIcaveSUSQ0/cmDczMrbov3C1nT/mruXdO99rQ/odOehiiDEv6Z/HozS/9CPm
         Db6jo18+L18LikJf9G5Y8x1BXOo6bbBEbWvqIePhegMNknQfDWgqgNnHUkPW1nKqM0vu
         BaYMN96YJamvXWEfHQ5jxN/Q5apVFDPowcyEkVG7NfjtKQnat/a8p+VV8EzB5DmOMq+q
         99g+IbfVibMzeNYIZ4rkNNUjp/748Ko43Qesf+jkL5afgc8Ms2oPQvoaQFnJTpem83q9
         NwXZUumY1p79ks6jj74djdfnD86bWlWXITDuBUDGr9sDJ7U+5DkQLBuKb5LKR+3TVjUW
         Ap6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697727541; x=1698332341;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H+fSKfoprD2xjep9haqaGcjsUyuDzAiaP8KcDuihTMA=;
        b=n7jJAaTz32nmQZf4BC+ndOf+9cvPxjyxkucK9bK8ojPo3D6V/Pa7cgVjKcxp2qGxZw
         vAZ75ztyUdBT7/BaxpBwWfuCT2E+KMLvtyDpudDP2bXu75R4pGbb/uHCd553rkZrfcV6
         MV7v3ZBiFExwGe6DcRoxncUvRjhwZPmWF5s0ivggGC5Woda3CHlCXabJSRW/6KAtWhv0
         IzjQ7M8XOzhTTUYv6RBYRIQURfQRe1g2fRd5CW5YwxxcyKSdHEBzGU4ECPvyuRmkFu34
         fL8cWYEEyrn6RTMwu2ERkqq6uWKvcisQqcXBRPm4KeMz4YsLd4p+g8JChi9qwiJYAQNb
         yIOQ==
X-Gm-Message-State: AOJu0YxVkpORYI5OMWTRfiJDYAjRzlK8Ptqkd9xyMDtiazCksXZ2nbxr
        KjqK+KSAfvGzaMrwH3kSWHkTmg==
X-Google-Smtp-Source: AGHT+IEh/tK0F10IvZvGnoSbcbP2On+lPSGmusrkOrr9+UtW+WgbOIcoUk3HPRR/bznJy32nKzETUQ==
X-Received: by 2002:a5d:9d56:0:b0:79d:1c65:9bde with SMTP id k22-20020a5d9d56000000b0079d1c659bdemr2438497iok.1.1697727540691;
        Thu, 19 Oct 2023 07:59:00 -0700 (PDT)
Received: from [192.168.1.94] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id s1-20020a056638258100b0045b16bddb8fsm1932502jat.111.2023.10.19.07.58.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Oct 2023 07:59:00 -0700 (PDT)
Message-ID: <7bb74d5a-ebde-42fe-abec-5274982ce930@kernel.dk>
Date:   Thu, 19 Oct 2023 08:58:59 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 00/11] io_uring: Initial support for {s,g}etsockopt
 commands
Content-Language: en-US
To:     Breno Leitao <leitao@debian.org>, sdf@google.com,
        asml.silence@gmail.com, willemdebruijn.kernel@gmail.com,
        kuba@kernel.org, pabeni@redhat.com, martin.lau@linux.dev,
        krisman@suse.de
Cc:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, io-uring@vger.kernel.org
References: <20231016134750.1381153-1-leitao@debian.org>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20231016134750.1381153-1-leitao@debian.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/16/23 7:47 AM, Breno Leitao wrote:
> This patchset adds support for getsockopt (SOCKET_URING_OP_GETSOCKOPT)
> and setsockopt (SOCKET_URING_OP_SETSOCKOPT) in io_uring commands.
> SOCKET_URING_OP_SETSOCKOPT implements generic case, covering all levels
> and optnames. SOCKET_URING_OP_GETSOCKOPT is limited, for now, to
> SOL_SOCKET level, which seems to be the most common level parameter for
> get/setsockopt(2).
> 
> In order to keep the implementation (and tests) simple, some refactors
> were done prior to the changes, as follows:

Looks like folks are mostly happy with this now, so the next question is
how to stage it?

-- 
Jens Axboe

