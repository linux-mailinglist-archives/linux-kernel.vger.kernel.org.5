Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAAB47DBC15
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 15:49:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233536AbjJ3Otc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 10:49:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231919AbjJ3Ota (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 10:49:30 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40DC5C2
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 07:49:28 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id 5614622812f47-3b2b1af09c5so2268934b6e.0
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 07:49:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698677367; x=1699282167; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CMVahbLSn8lXQnXquOs+Qvt810+vZKKWXEX1fvH4e6I=;
        b=Sld/oczm/prCPuZJtjkWPIZ9kxsgj1j6datRZ3tFdobOz+CGQDRA7zzlingZvibmAy
         4qiCwXSRPfFxOalvXqBuHLuWCB6MC/ZkHL9DU6b/hx7NJo9cT17psz80sefXCxdjNeER
         3qTaiYN32bmNNE+0T4dGUIjB5WbnUeBzS9Rd3O5RXDAFLQg1MTvvaES5IgJhf9p7sdlB
         Ag0wihvPQmjFjGCb8j1KwjsykBUaKxr8jQz48BtHm/daWswRGFbUHTqmCfxZWmuIoZXD
         NCCMbH0kBjVgAZ/PprzNcfCyjYHGWsSKnVmoq8ROsYi6/ruK4PG3TrPY2hTlH58+rE7j
         Je6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698677367; x=1699282167;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CMVahbLSn8lXQnXquOs+Qvt810+vZKKWXEX1fvH4e6I=;
        b=aynuTi+DGp4/7f9YyGxUSmCQtuB61k1cJ9uOOPnelLWPhTnk7AhRdMGioy3Xi+d33a
         gXaFZKG0tD0DNzLSR8P5oVuOHRdoOktaG31aQrXPEgcnZPfcdwJ4DVVDzV5K2L92wvjW
         WiUIsH8Cbtmf7aBrQhotllg2Cl9HnNDrZd/BlA2igQrnjWPtGBbk6nJrofsDIRH7M7OK
         9eEJjxmKo2v4JFGmKcm67B06l8LtfnSqShyVc9Nn1iSZgnQnUtWi6WhXkpeAWDOlzIxs
         F2oMeIhS3OYJrsjLBxoNH2VPFvCtYXfw2C3i9UcVrLOUAITG+bjkr0ilS2aqLw+9qIYL
         PglA==
X-Gm-Message-State: AOJu0Yw/pg9i2HCEvApx13hYFHVFgzf8rmb/OBlnYR3E/rWOywzfPSuO
        /8+Se+8Zr8w1C3HNp64O5Jw=
X-Google-Smtp-Source: AGHT+IHgmY33b+zRR/3NEzXKawFh2MQG5Y8mEVCIt2a2TxgPHOwRTfXD1zgoZUCNK4vF7Xbsmqeq5g==
X-Received: by 2002:a05:6808:189c:b0:3af:795d:b74b with SMTP id bi28-20020a056808189c00b003af795db74bmr10436603oib.50.1698677367554;
        Mon, 30 Oct 2023 07:49:27 -0700 (PDT)
Received: from localhost (modemcable065.128-200-24.mc.videotron.ca. [24.200.128.65])
        by smtp.gmail.com with ESMTPSA id oo22-20020a05620a531600b0076ef3e6e6a4sm3387832qkn.42.2023.10.30.07.49.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 07:49:27 -0700 (PDT)
Date:   Mon, 30 Oct 2023 10:49:26 -0400
From:   Benjamin Poirier <benjamin.poirier@gmail.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Bjorn Andersson <quic_bjorande@quicinc.com>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        Stephen Hemminger <stephen@networkplumber.org>
Subject: Re: [PATCH] .mailmap: Map Benjamin Poirier's address
Message-ID: <ZT_Cdul7kwRgZv2z@d3>
References: <20231030142454.22127-2-bagasdotme@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231030142454.22127-2-bagasdotme@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-10-30 21:24 +0700, Bagas Sanjaya wrote:
> Map out to his gmail address as he had left SUSE some time ago.
> 
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
> ---
>  I first contacted him when reporting tx-nocache-copy regression [1],
>  I emailed to his old SUSE address, but bounces. Now, he submitted
>  qlqe removal [2] using his gmail address.
> 
>  Ben, can you give an ACK? I intend to route this patch through mm or
>  driver-core tree.

Thank you for the addition.

Acked-by: Benjamin Poirier <benjamin.poirier@gmail.com>
