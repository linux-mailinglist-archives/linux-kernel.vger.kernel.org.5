Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09902792779
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 18:36:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236012AbjIEQT2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:19:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353962AbjIEIwy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 04:52:54 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BE73BF;
        Tue,  5 Sep 2023 01:52:49 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id 5614622812f47-3a76d882052so1674888b6e.0;
        Tue, 05 Sep 2023 01:52:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693903968; x=1694508768; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qKlFBdT69991S4JouznjRtmsXJ6kfeTl4DK2mPOKTKw=;
        b=DZz/4IeaamMpxVBjZCugIsu7B7msWvnnsljoszWagQY7hsGxJ9kjtNNTTHmqCu8lNs
         zF1foPNBbKEQyDFV5Ubb+IlkWTLCcAYHxMNhSIlc6llUyAv9cL/R6PuHKH+Cf/b4f1Xx
         h/9vXkxKkVf6QBPdUgSd/Dc6CmnYpXGxlS4X4q0UjJo1eJW0DZacj2B8qKlFtu7dqzNZ
         I9qtpBTfws8GwPcu7WQkHn+RFqxUSaxJxQHnJWFHjK5I3O1SlGmz1OTlQiOnjroN6RdS
         NDz216kyB9BU1J4JRaFcdDP/Vk6zvZEUcO5fN73Y1IyxcWSDEjCsn5fFxTSP7jN5cXbK
         3uyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693903968; x=1694508768;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qKlFBdT69991S4JouznjRtmsXJ6kfeTl4DK2mPOKTKw=;
        b=ZhQw1iKJUBwUYEaZB6kbMxHV3nseo+f+7/dLimcOawygH8hxBV7FbOqy6rOBSOOsxb
         f46w2HRisJ5GNu7yaqlXu5W2xQaCQ9PypO1vSIaBpntYvK2LY/BZtnNkjEQrnSf4EIyU
         ENArEe2YbpJ0ZZuuIKiuwxXnnkDAf3ULE0IuEOoLTUvrV9TAZJcC6kU93bo4QQS6DgBp
         jzZXRGnCct8+aN8aJSb88uTASk3zJTQjL42YVy4l9h+ehZpO6K5SSsOxU8DKE3M2EuAx
         3a07r5QyqfIvvONuY4ojQ1Twxt/UcDIdSMQdZSPP98golIUTq8VxeKa8i9cQVBtJeDDh
         Mfuw==
X-Gm-Message-State: AOJu0YywrcKhfUhVoaJXm7dQYFvplRTSfg4b/l3NA6wz0FfQmt/KlZJH
        gpSPArlKOS5p3dhmlgoLP/4=
X-Google-Smtp-Source: AGHT+IGKsBYD96Y9PIesIV969naQHZRiGscrONh4e6FH/zoYp/Qr77D6jcDFGDxUve00lLjI5RAUhQ==
X-Received: by 2002:a05:6358:3994:b0:13e:bd8d:c2a2 with SMTP id b20-20020a056358399400b0013ebd8dc2a2mr11467833rwe.23.1693903968280;
        Tue, 05 Sep 2023 01:52:48 -0700 (PDT)
Received: from Laptop-X1 ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id x52-20020a056a000bf400b0063b898b3502sm8606742pfu.153.2023.09.05.01.52.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Sep 2023 01:52:47 -0700 (PDT)
Date:   Tue, 5 Sep 2023 16:52:43 +0800
From:   Hangbin Liu <liuhangbin@gmail.com>
To:     Ziyang Xuan <william.xuanziyang@huawei.com>
Cc:     jiri@resnulli.us, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] team: fix null-ptr-deref when team device type is
 changed
Message-ID: <ZPbsW/bOGeO9Ww8+@Laptop-X1>
References: <20230905074638.3304732-1-william.xuanziyang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230905074638.3304732-1-william.xuanziyang@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 05, 2023 at 03:46:38PM +0800, Ziyang Xuan wrote:
> diff --git a/drivers/net/team/team.c b/drivers/net/team/team.c
> index d3dc22509ea5..12fb5f4cff06 100644
> --- a/drivers/net/team/team.c
> +++ b/drivers/net/team/team.c
> @@ -2127,7 +2127,10 @@ static const struct ethtool_ops team_ethtool_ops = {
>  static void team_setup_by_port(struct net_device *dev,
>  			       struct net_device *port_dev)
>  {
> -	dev->header_ops	= port_dev->header_ops;
> +	if (port_dev->type == ARPHRD_ETHER)
> +		dev->header_ops	= &eth_header_ops;
> +	else
> +		dev->header_ops	= port_dev->header_ops;
>  	dev->type = port_dev->type;
>  	dev->hard_header_len = port_dev->hard_header_len;
>  	dev->needed_headroom = port_dev->needed_headroom;

Hmm.. Do we need to export eth_header_ops? I got error like
ERROR: modpost: "eth_header_ops" [drivers/net/team/team.ko] undefined!

But I saw function loopback_setup() could reference this. Not sure what
I missed here.

Thanks
Hangbin
