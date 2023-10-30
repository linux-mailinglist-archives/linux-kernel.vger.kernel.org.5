Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC2CB7DB9BF
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 13:20:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233045AbjJ3MUp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 08:20:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232531AbjJ3MUn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 08:20:43 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7466C9;
        Mon, 30 Oct 2023 05:20:40 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-53d9f001b35so7014859a12.2;
        Mon, 30 Oct 2023 05:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698668439; x=1699273239; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:subject
         :references:cc:to:user-agent:mime-version:date:message-id:from:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tRAvOgi6qogXEjImiUor+DkPqw1Ot9Ogtre0wvi5M6k=;
        b=nqcCLdy5BkfZ2ly+kvgp4RantdlvoU4aMWj2ag9y62CfeIFVxBhT4sDv8MWxxHhQz6
         AwOjnIq0UrQE6WfcY4MoQR4Q9aHmkCLPpe05h7UhWsb1yTbYx5N/n8vMAeqa+7Z3mFBK
         sakoRSaiZya+jKItdc8TbAS0Tsnl+qRa0fK9m0gYKnh9eobWDKUE4KT0SyOqhvLx1zue
         /8rDcyS0eX1MLFNRwds0vKf+RbKFKYroq2hGVuuqXotl2YR0+KmNLn96d3aahl6Pmf+d
         A6ODm5bw3BennCXc+dZpagOltGe4tQ+SxCgxTQ6NmxpuWe/gz0Y/bVjOe+V5j+h18KZH
         Zq4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698668439; x=1699273239;
        h=content-transfer-encoding:in-reply-to:content-language:subject
         :references:cc:to:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tRAvOgi6qogXEjImiUor+DkPqw1Ot9Ogtre0wvi5M6k=;
        b=XqEaZzdyqBQkCdeitvkanUmaT3WpkpKZYIbpLtTymS6ZlnkpE8pQKraKYlrEqxkPhO
         iiahUaALC53aBIfI2nyAxJ1hBkAODODk/Col2Qke8wynAJc9NGtdw+H8BUMFh8USGPAV
         gIpFSHFRPNFOgJBjzeC9Xiem2JsDrlOJ4qHTXkA26bHmKrIRfa6u9yqWNuJruPrqXQLp
         Zwyo4XQg/EfFMqaJdCg938G33ozjGJ8QjcVUpWEauj7BR1xWXhI0WjObbPqY6uYiF3ox
         ftOynquIH065e/s10l8hXEiaPyu2adru8lb9kbryHiJ34i/87S22gzxxMtksqsASg4cN
         j9dw==
X-Gm-Message-State: AOJu0YwriaYqxZ9iNBs6p8Xqdmi+owWA3v9IJ53EghsMwPQt7gdqclTT
        +gliFFhPCa/Rv5dsF/8ubSY=
X-Google-Smtp-Source: AGHT+IEA4HEagqHQDt4CQKteRzlCff1bThN0D10TLJ2IhOR2hdu91b9A3yPlJ/I94joRwFOXZlnzxA==
X-Received: by 2002:a17:907:72c5:b0:9b2:f941:6916 with SMTP id du5-20020a17090772c500b009b2f9416916mr8109533ejc.17.1698668439086;
        Mon, 30 Oct 2023 05:20:39 -0700 (PDT)
Received: from [192.168.0.105] (5401D598.dsl.pool.telekom.hu. [84.1.213.152])
        by smtp.gmail.com with ESMTPSA id ci6-20020a170906c34600b009a1dbf55665sm5802219ejb.161.2023.10.30.05.20.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Oct 2023 05:20:38 -0700 (PDT)
From:   Kira <nyakov13@gmail.com>
X-Google-Original-From: Kira <Nyakov13@gmail.com>
Message-ID: <566c0155-4f80-43ec-be2c-2d1ad631bf25@gmail.com>
Date:   Mon, 30 Oct 2023 13:20:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To:     benjamin.poirier@gmail.com
Cc:     James.Bottomley@HansenPartnership.com, coiby.xu@gmail.com,
        corbet@lwn.net, davem@davemloft.net, deller@gmx.de,
        edumazet@google.com, error27@gmail.com, gregkh@linuxfoundation.org,
        kuba@kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
        linux-staging@lists.linux.dev, manishc@marvell.com,
        nandhakumar.singaram@gmail.com, netdev@vger.kernel.org,
        pabeni@redhat.com, raven@themaw.net, ricardoapl.dev@gmail.com,
        sumitraartsy@gmail.com, svenjoac@gmx.de
References: <20231020124457.312449-3-benjamin.poirier@gmail.com>
Subject: Re: [PATCH 2/2] staging: qlge: Retire the driver
Content-Language: en-US, ru-RU
In-Reply-To: <20231020124457.312449-3-benjamin.poirier@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I have a couple of QLogic QLE8142 10GbE Converged Network adapters.

They are pretty old yes, but also working well and energy efficient. 
They still can be considered as modern hardware because they was so 
advance back in the days.

And I think there is a lots of them out there, maybe not in 
production(but somewhere still is), but in used market.

So it will be really nice if drivers were still in kernel.


With best regards

Kira.

