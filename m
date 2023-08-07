Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2E89771826
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 04:05:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229633AbjHGCFd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Aug 2023 22:05:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjHGCFb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Aug 2023 22:05:31 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EA6299;
        Sun,  6 Aug 2023 19:05:30 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id d9443c01a7336-1bbc64f9a91so35307775ad.0;
        Sun, 06 Aug 2023 19:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691373930; x=1691978730;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xzqkz0xaGk6z113IiqwoO8SGlH2v+RBIOXZiNkod9NE=;
        b=Eh4eAqYIZroph0TkppI+mL2PKdud4AgBGYmXe5oaefUeVeGzslhhP9ftc+LdUTh72R
         8Y/P8FcGPKoZIFDnXsYob3GaHCzsL59VT6Puhb69RnpxCGdBIun0OGciAP9Yf/o8rAsq
         SYo3E+p1moZJtpeldXVxdA1+Zfm8Uey5B4GiLb38YpL8kzsdgO8s+JnWn4GkqBuPqdEn
         XTrE77wsTGH7QNleI0lfLDJ8rjQck0z+1a3lckXJ3d5jKU6GDecoZZCzOKQo2Sgyfe4t
         6cPwnlo2E0UC8SmjO4uamH5d87fKJ2FZiVZ+GM9ZVT0ulReZ/x+JsuMR8aS5OXEe0je0
         O64w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691373930; x=1691978730;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xzqkz0xaGk6z113IiqwoO8SGlH2v+RBIOXZiNkod9NE=;
        b=leMkd0kEgFHLKxS46I18lbs4HtyeLt9BNNvQpgBqWM6dZc3WH0gFYPJNbnFzMestM/
         An2EOwieGXx3b+hUiMHz4/BcqQWTmrQEWthkEkJIeq98U2vAyG5tMs9JppriaXh/7p8/
         t0BV4EYlKKida6Snx7twQZyCX21JgeBB8+NdkJ+TBSoskAqddyznunwEcMhyWeMsf1p5
         xZB7gINGWI9SdT/dQO3F2MGi4jzmDMrbqP+KrmKsWGXtXse2gioY53q+Jnc0BMlFNCuk
         lRBkQrRnsGRhlZfRDwQFJTR7B7JrCUd2ZExx+5SG/KfW0/TVGJJ+jJyVseegjDOejGOr
         KD1g==
X-Gm-Message-State: AOJu0YyeSWyae9iJOUEQprFYyqDhA6XT59lxRofTPrCotxmBs5R0RXII
        s0p56bVjshvXqrDifWC3IAc=
X-Google-Smtp-Source: AGHT+IHMqxJeTx7HN8szhCwQKRlCR4wtLOKl+kaQLssDiYBl/5gnrxixJSad+dOvu3J5IM90t3y6rw==
X-Received: by 2002:a17:903:2310:b0:1bb:d048:3173 with SMTP id d16-20020a170903231000b001bbd0483173mr9530028plh.61.1691373929657;
        Sun, 06 Aug 2023 19:05:29 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id g5-20020a170902c38500b001bbd1562e75sm5482839plg.55.2023.08.06.19.05.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Aug 2023 19:05:29 -0700 (PDT)
From:   xu <xu.xin.sc@gmail.com>
X-Google-Original-From: xu <xu.xin16@zte.com.cn>
To:     vadim.fedorenko@linux.dev
Cc:     davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
        kuba@kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, yang.yang29@zte.com.cn,
        xu.xin16@zte.com.cn, si.hao@zte.com.cn, dai.shixin@zte.com.cn
Subject: Re: [PATCH] net/ipv4: return the real errno instead of -EINVAL
Date:   Mon,  7 Aug 2023 02:05:25 +0000
Message-Id: <20230807020525.248349-1-xu.xin16@zte.com.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <3e38a143-b683-6368-8e76-277394155bc6@linux.dev>
References: <3e38a143-b683-6368-8e76-277394155bc6@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> @@ -236,7 +234,8 @@ static int ip_finish_output2(struct net *net, struct sock *sk, struct sk_buff *s
>>   	net_dbg_ratelimited("%s: No header cache and no neighbour!\n",
>>   			    __func__);
>>   	kfree_skb_reason(skb, SKB_DROP_REASON_NEIGH_CREATEFAIL);
>> -	return -EINVAL;
>> +	res = PTR_ERR(neigh);
>> +	return res;
>
>I believe this part could be written as
>
>-	return -EINVAL;
>+	return PTR_ERR(neigh);
>
>
>and there is no need to change the code is other places. This will be
>easier to track/backport.

Sure, I initially wrote the same thing with you, but considering the convenience of maintainer review,
I deliberately modified some other parts of the code to present a clear context of the core
modifications.

From your reply, I can see you agree with my key idea of this patch, so I have sent a v2 patch[1] according
to your view.

[1] https://lore.kernel.org/all/20230807015408.248237-1-xu.xin16@zte.com.cn/

