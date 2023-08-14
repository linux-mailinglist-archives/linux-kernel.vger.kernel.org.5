Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 737BA77BF81
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 20:05:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229927AbjHNSE3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 14:04:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231499AbjHNSEV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 14:04:21 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A883110F0;
        Mon, 14 Aug 2023 11:04:18 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-4fe44955decso5353855e87.1;
        Mon, 14 Aug 2023 11:04:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692036257; x=1692641057;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EwKZNNozHZ+Il8fPOfH+Jl4RZxqiP6+ZQxkumA1ZNZ8=;
        b=NnZy32KQijyIfMmpb8IZAIxhcBOcASo6kkWF++uNQNglrGcISSKUuxUM/emEhpIZmL
         IkMysiBhGHdJW/K0pzmjdwomWfDGQRslv/nS0lKe6D/KYqerr0nrK52/RpO7yo/ztCfo
         2+7/GS8fSSP0UbPxRa0QLhczDxouHZ4zfTXcJCgOBFf1ykTN65zplqAiHFpTnMoW4vF4
         XKq4nkrG/CKjz0EUvN+VsMq9tuNxeKczINYO9Bst+WP7kkXDqLkVJiTcUmYSfZ7u73D0
         vRB2AmSQcqci/yVaB3pkWWAkbpF19OQGKmjR6xuHacxkAZvxTApl4R0lTVKWde98h0wb
         aayQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692036257; x=1692641057;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EwKZNNozHZ+Il8fPOfH+Jl4RZxqiP6+ZQxkumA1ZNZ8=;
        b=eQDz6hqx6A/GtekuUtHIkhWEgr1SSxnKYyLytNjp60QMHd3R5GDH5bImphiWQO4SBH
         uvtnVv7u5bWzu8qeskUB+ov2IgmnbHIK/TIPTo9ZKZnlYX+IMnI1vh56cZoBXloxTymc
         IHEG+qyyqYALd5mTE/r3dUB5yaSC6mmHie72Hp6PP3PuxJXbIiY1q7lzDRZsLWyOEXfz
         swNukgv5J3He06Z/Wl8TbGBLMBH884zEnZgSCzwYy7IX+Y3RJCqo9Sdld1aB0R6Wx+vU
         9NhVP32G+KIucydnJ8MaPYd/jWQFtX5k5PZisDHc0vFdq0LacFG7brmLbZCzzPyH/pmC
         X/KQ==
X-Gm-Message-State: AOJu0YwQmJnZSXJ1x7IatpZb463opGxksFxnNR5HbInkHZQl3qj4/hFt
        C3Ke5B/uR3ejQKrKJFDYOug=
X-Google-Smtp-Source: AGHT+IGBafs4A+Xan6sFQYjKy//bN2Ej7Zphd5x7sYO6bBtNZrIH2ISpFDVM1uszz2Kb/MeZ6Jex8A==
X-Received: by 2002:ac2:4e14:0:b0:4f8:6831:fd70 with SMTP id e20-20020ac24e14000000b004f86831fd70mr4100545lfr.3.1692036256652;
        Mon, 14 Aug 2023 11:04:16 -0700 (PDT)
Received: from ?IPV6:2a00:1370:8180:6b00:a1a8:4887:1af4:637a? ([2a00:1370:8180:6b00:a1a8:4887:1af4:637a])
        by smtp.gmail.com with ESMTPSA id t4-20020ac243a4000000b004fe061269edsm2077622lfl.249.2023.08.14.11.04.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Aug 2023 11:04:16 -0700 (PDT)
Message-ID: <a3721585-c38f-f222-9a0e-4b268a48491b@gmail.com>
Date:   Mon, 14 Aug 2023 21:04:15 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] crypto: fix uninit-value in af_alg_free_resources
Content-Language: en-US
To:     David Howells <dhowells@redhat.com>
Cc:     herbert@gondor.apana.org.au, davem@davemloft.net,
        pabeni@redhat.com, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        syzbot+cba21d50095623218389@syzkaller.appspotmail.com
References: <20230813122344.14142-1-paskripkin@gmail.com>
 <3954480.1692001609@warthog.procyon.org.uk>
From:   Pavel Skripkin <paskripkin@gmail.com>
In-Reply-To: <3954480.1692001609@warthog.procyon.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

David Howells <dhowells@redhat.com> says:
> Pavel Skripkin <paskripkin@gmail.com> wrote:
> 
>> Syzbot was able to trigger use of uninitialized memory in
>> af_alg_free_resources.
>> 
>> Bug is caused by missing initialization of rsgl->sgl.need_unpin before
>> adding to rsgl_list. Then in case of extract_iter_to_sg() failure, rsgl
>> is left with uninitialized need_unpin which is read during clean up
> 
> Looks feasible :-).
> 
>> +		rsgl->sgl.need_unpin = 0;
>> +
> 
> The blank line isn't really necessary and it's a bool, so can you use 'false'
> rather than '0'?
> 
> Alternatively, it might be better to move:
> 
> 		rsgl->sgl.need_unpin =
> 			iov_iter_extract_will_pin(&msg->msg_iter);
> 
> up instead.
> 

Thank you for review! I've just posted v2 :)



With regards,
Pavel Skripkin
