Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBD1776C1E4
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 03:07:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231266AbjHBBHp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 21:07:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230477AbjHBBHn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 21:07:43 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33A4B12B;
        Tue,  1 Aug 2023 18:07:42 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id e9e14a558f8ab-348dfefd1a4so31491525ab.1;
        Tue, 01 Aug 2023 18:07:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690938461; x=1691543261;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=s/fwGGoY0CBXI3KqyyOIfAkFvSeZq3jl3v4eWbf/W0A=;
        b=W6bXsAVQfwRmTtN4NVDB/2ncV9wpTScZENedZ7g8lylW5JaJQzIQLjMGQU9ds2jaH1
         MG4RB6FGRIwnXvj/IEXrxHWimcuJNZbOoMS04MqMhx9ZYMWxd3siFim2BJ4U76MC6lz/
         rM4YwjnbCF5/90HpqsRRN3P96O7510vO45prO4WRYHfLlPUk/jaed3T5F4DNB8/Fyxhh
         UUzZCo7YAxF4VBPWk4gYYs+/HgvZL/WG2kLzNJDbmReP1CmfUgXFv2nQB7k1UJ4gW3BX
         EQe5igdlwLlZuIHCXn1mGTmJPlRI0g93NqmEQsV13x7Opzh1oChFfRz2sybs3ABdJ6b0
         4gbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690938461; x=1691543261;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s/fwGGoY0CBXI3KqyyOIfAkFvSeZq3jl3v4eWbf/W0A=;
        b=TzvZ/JBpAN8XfHmlwBjQ+ZjwKFmVVwWimGWkz7DvuaRS2GlF4pG+7lrLCmF+flYeUm
         aojen9tizgM/UBbkpzq7keIJVppJ4o4Olu1RLmVhlliX1TpuODZlHiEXw8Ae+MXq6iep
         XUehhSP5q+bWBKtE1AbcbSOSi30vnGucaAVJOgIjQhPn5fdlKdNF6zxSEsvTWWP1EFOL
         +xIBJN9mXecS4IQ0Vh+dxYlJW785MsSuywkWQd3veK/nS9+VkPdtX+T0NormU5UFp9ZP
         nXee6Yt4esENdGHWf0dxnOqJvtXEF7KTA0iGYR3TDSCCxnUbVB9b+ifaoAcrti55vdBv
         OvDg==
X-Gm-Message-State: ABy/qLbJ0g4jp68mKaQmx5F0Zy/8JVoye2PaTaYCuDEI0LqqFeCCWDmz
        TZzv41PX5/U0z84NxVRu13s=
X-Google-Smtp-Source: APBJJlHzcsws0HnhCWDSlqL8LQbx4JfHTGvaLjmVda6PJ0CL8Pz4baGK1PtFu7//xFpUWiQtQeLxPw==
X-Received: by 2002:a05:6e02:f51:b0:346:5bd7:4a17 with SMTP id y17-20020a056e020f5100b003465bd74a17mr12677625ilj.17.1690938461267;
        Tue, 01 Aug 2023 18:07:41 -0700 (PDT)
Received: from ?IPV6:2601:282:800:7ed0:211e:b7c4:92fe:76f4? ([2601:282:800:7ed0:211e:b7c4:92fe:76f4])
        by smtp.googlemail.com with ESMTPSA id a14-20020a92d58e000000b00348d41ffd13sm4164159iln.85.2023.08.01.18.07.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Aug 2023 18:07:40 -0700 (PDT)
Message-ID: <3fa4d25d-7fea-d25b-fa83-4ada2c550725@gmail.com>
Date:   Tue, 1 Aug 2023 19:07:39 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH v4 1/2] drivers: net: prevent tun_build_skb() to exceed
 the packet size limit
Content-Language: en-US
To:     Andrew Kanner <andrew.kanner@gmail.com>, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        jasowang@redhat.com, netdev@vger.kernel.org, brouer@redhat.com,
        jbrouer@redhat.com, john.fastabend@gmail.com,
        linux-kernel@vger.kernel.org
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        syzbot+f817490f5bd20541b90a@syzkaller.appspotmail.com
References: <20230801220710.464-1-andrew.kanner@gmail.com>
From:   David Ahern <dsahern@gmail.com>
In-Reply-To: <20230801220710.464-1-andrew.kanner@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/1/23 4:07 PM, Andrew Kanner wrote:
> @@ -1594,7 +1597,13 @@ static bool tun_can_build_skb(struct tun_struct *tun, struct tun_file *tfile,
>  	if (zerocopy)
>  		return false;
>  
> -	if (SKB_DATA_ALIGN(len + TUN_RX_PAD) +
> +	rcu_read_lock();
> +	xdp_prog = rcu_dereference(tun->xdp_prog);
> +	if (xdp_prog)
> +		pad += XDP_PACKET_HEADROOM;
> +	rcu_read_unlock();


since you do not care about the actual xdp_prog (only that one is set) I
believe you can use rcu_access_pointer here.
