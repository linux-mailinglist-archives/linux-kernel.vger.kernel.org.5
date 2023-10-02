Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 747DE7B5365
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 14:44:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237147AbjJBMn6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 08:43:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237062AbjJBMn4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 08:43:56 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C26D2B7;
        Mon,  2 Oct 2023 05:43:53 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-405361bb9f7so168805385e9.2;
        Mon, 02 Oct 2023 05:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696250632; x=1696855432; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:subject:cc:to:from:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SuVrzPEkZXL/nyUjcTtIVN8e2SSFUAE0S6M5VXieAtg=;
        b=AqXQZirnDGAekKRLbc4u0C2B3HwBPKNpBUoC3rFBnZC6YSMrLxe/of1yCWfhjBAm66
         4QG7gUluMe3c2Nji+jLjXKlbsoUrWWmObux+hMeviM5TenzJARfioRxVvH3VOjfzR3qo
         UFEqmlbIbFEjcCywl7tSfKXrSAfc+eJDIkKaMdqQIvZn4Pv5A+jl/xBg5nzPNEEyrFBk
         JC0fKojztto3bYUNjN5aAJ6r7TLdAezcbw1uFsjz39TFBgm+cpmE0ZkxnknASEdWhd8l
         Yalvpnyk6uNfZr5zkZEhLXCk+jkmAtAtVfdkupjPiOLK6XmJW8odFug44hNBSl2Qh27h
         q3GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696250632; x=1696855432;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:subject:cc:to:from:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SuVrzPEkZXL/nyUjcTtIVN8e2SSFUAE0S6M5VXieAtg=;
        b=MwLJRcEXa0UWgU3EVH0ji5BbxcpGl+66sG0xk7ClmLY5Q/JKRyeUwzJOV3vRsmjJ6D
         0e/38kFt6cq2iVxRnXIWztJoorXLJzJ0T+UQL0qHXTF8BVu9xnzzAD8D3SGadTHwMiIE
         z432p4u3cSYdhQ7/Jh+8XMBJwmfwMjZ7w88SCb6DraJv9VW4JcFS/EOCr7lqmqcPV8xR
         tmRooM7KiuzwSzCrPj464CKUh7+rUndBJnRULE2ucDKWigkHiezuvdVRS5tVoB0kYYt5
         LyJMjMEGHczWido+Byf+HT4TfLFSBvpN55hoIku0usdjX/+O5VGbFSldzzh7+qBBVG7N
         hjaA==
X-Gm-Message-State: AOJu0YzWPNCZTBk9WnZg4cNt4l5F9IKXXP5ags9Knue2eRxNld2Tc0uV
        ZaGzM5mnqGYZbqbjVHWCPls=
X-Google-Smtp-Source: AGHT+IFtmy+jvrK149JttUDtopSV0OsgZK6d3UGZg2M3FSqCFBhgRvjmI/KdY93XL4lsSqC/RF9hkQ==
X-Received: by 2002:a05:600c:ac4:b0:401:aa8f:7570 with SMTP id c4-20020a05600c0ac400b00401aa8f7570mr9569818wmr.1.1696250631957;
        Mon, 02 Oct 2023 05:43:51 -0700 (PDT)
Received: from Ansuel-xps. (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.gmail.com with ESMTPSA id 11-20020a05600c248b00b003fefe70ec9csm7185549wms.10.2023.10.02.05.43.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Oct 2023 05:43:51 -0700 (PDT)
Message-ID: <651abb07.050a0220.5435c.9eae@mx.google.com>
X-Google-Original-Message-ID: <ZRq7Ax0+6OAd2NIn@Ansuel-xps.>
Date:   Mon, 2 Oct 2023 14:43:47 +0200
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Eric Dumazet <edumazet@google.com>
Cc:     Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Raju Rangoju <rajur@chelsio.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Ping-Ke Shih <pkshih@realtek.com>,
        Kalle Valo <kvalo@kernel.org>, Simon Horman <horms@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jiri Pirko <jiri@resnulli.us>,
        Hangbin Liu <liuhangbin@gmail.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        linux-wireless@vger.kernel.org
Subject: Re: [net-next PATCH 1/3] net: introduce napi_is_scheduled helper
References: <20230922111247.497-1-ansuelsmth@gmail.com>
 <CANn89iJtrpVQZbeAezd7S4p_yCRSFzcsBMgW+y9YhxOrCv463A@mail.gmail.com>
 <65181064.050a0220.7887c.c7ee@mx.google.com>
 <CANn89iJqkpRu8rd_M7HCzaZQV5P_XTCzbKe5DOwnJkTRDZWEWw@mail.gmail.com>
 <651ab7b8.050a0220.e15ed.9d6a@mx.google.com>
 <CANn89iJqFC-Z3NZwT+CXEG7R9rc9g4LRwNm6Zm=nZKpD3Mon7Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANn89iJqFC-Z3NZwT+CXEG7R9rc9g4LRwNm6Zm=nZKpD3Mon7Q@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 02, 2023 at 02:35:22PM +0200, Eric Dumazet wrote:
> On Mon, Oct 2, 2023 at 2:29 PM Christian Marangi <ansuelsmth@gmail.com> wrote:
> 
> > Ehhh the idea here was to reduce code duplication since the very same
> > test will be done in stmmac. So I guess this code cleanup is a NACK and
> > I have to duplicate the test in the stmmac driver.
> 
> I simply wanted to add a comment in front of this function/helper,
> advising not using it unless absolutely needed.
> 
> Thus my question "In which context is it safe to call this helper ?"
> 
> As long as it was private with a driver, I did not mind.
> 
> But if made public in include/linux/netdevice.h, I would rather not
> have to explain
> to future users why it can be problematic.

Oh ok!

We have plenty of case similar to this. (example some clock API very
internal that should not be used normally or regmap related)

I will include some comments warning that this should not be used in
normal circumstances and other warnings. If you have suggestion on what
to add feel free to write them.

Any clue on how to proceed with the sge driver? 

-- 
	Ansuel
