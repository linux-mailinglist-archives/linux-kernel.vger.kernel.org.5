Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E19AC80CB3D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 14:40:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343674AbjLKNkI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 08:40:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343631AbjLKNkG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 08:40:06 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D75A2E5;
        Mon, 11 Dec 2023 05:40:12 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-a1f6433bc1eso642048266b.1;
        Mon, 11 Dec 2023 05:40:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702302011; x=1702906811; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1DOYBiSnMBUZpB8aPlwqoVslXzDkYwM7n0lC23HDZjU=;
        b=hpOdkLMSt1RyI9O1R1wm6OMHxty6zNq50Bs7jaoDW5EjOg58xfp6XrXY/Yj5tSAvIE
         P30gYgxz+hQFsVyYNa0Kqk7d0A864v/L8cajZpK2be3f5u+k+oWFXAsBs7VgK0wulFWD
         b4gnQGhq5VlhdkqRQvglu+6suJTg0WNjx6Le4ZMvGlA2aTV9L0KVWGSU1/n/cMLTerpu
         a/KI1lLYr2OHNvX+rBzed6NX7gmo6k8pakUs92zuWQR/aufhJmaXgbzFXRlJ1T/qVihF
         Zj742/oi9h1wMW9s7Oeo6HWz7bJRlnxoxP532EoAtRhkz8dykE3S0Med6OhwFx51d1h5
         Ee/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702302011; x=1702906811;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1DOYBiSnMBUZpB8aPlwqoVslXzDkYwM7n0lC23HDZjU=;
        b=klaco6CzWTigCXFUqbs1E+gyVqqstolEYx4Z1kzU8LCEXZMyGRwLujyHgePweGdf2X
         xCoVdCR3DgIhMGZAwDoKKJaEe7NYcgK+ELuhXL9+YXgbLJHLhCArs2EgZpZv6YCWzymo
         wUQ5yR7/ZGS3HhU4zy3I5OU4MTu34syzpmlNsb9kaqch5SLQmI/rKlvGbJ1FrmSkMc9p
         a9has4aEGcRXjNsdQCKAOEfFAkgYhCPQNApfoqfXtPyzEl924Qfsh0aPjC3cCeTN4BPy
         t58KQZGZVYioN6M37vTyu+TYwGjjQfcCVIAQQJrflbD+2jDI2XMzU45IqeCwdtPrr9pr
         gawg==
X-Gm-Message-State: AOJu0Yx7YK/P0S51GpPNleI14Hidu8NIZjEI+D30rAIv54QM3ERIYcKw
        3G1JkD/j9YN4smd+G7Th84U=
X-Google-Smtp-Source: AGHT+IG1DcEeU91kg6P+z6Hh0pDv+PfBGoLPpOL7Q7t0PdRFfZLow75jSesZQXYB3JHKVwCeNnRYBQ==
X-Received: by 2002:a17:906:241:b0:a1e:842d:ccd5 with SMTP id 1-20020a170906024100b00a1e842dccd5mr3960239ejl.48.1702302010984;
        Mon, 11 Dec 2023 05:40:10 -0800 (PST)
Received: from skbuf ([188.27.185.68])
        by smtp.gmail.com with ESMTPSA id vx6-20020a170907a78600b00a1e852ab3f0sm4911417ejc.15.2023.12.11.05.40.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 05:40:10 -0800 (PST)
Date:   Mon, 11 Dec 2023 15:40:08 +0200
From:   Vladimir Oltean <olteanv@gmail.com>
To:     Jianheng Zhang <Jianheng.Zhang@synopsys.com>
Cc:     Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <Jose.Abreu@synopsys.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        "open list:STMMAC ETHERNET DRIVER" <netdev@vger.kernel.org>,
        "moderated list:ARM/STM32 ARCHITECTURE" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "moderated list:ARM/STM32 ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        James Li <James.Li1@synopsys.com>,
        Martin McKenny <Martin.McKenny@synopsys.com>
Subject: Re: [PATCH net-next] net: stmmac: xgmac3+: add FPE handshaking
 support
Message-ID: <20231211134008.lbtm6pjtufkhtvfj@skbuf>
References: <CY5PR12MB63726FED738099761A9B81E7BF8FA@CY5PR12MB6372.namprd12.prod.outlook.com>
 <CY5PR12MB63726FED738099761A9B81E7BF8FA@CY5PR12MB6372.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CY5PR12MB63726FED738099761A9B81E7BF8FA@CY5PR12MB6372.namprd12.prod.outlook.com>
 <CY5PR12MB63726FED738099761A9B81E7BF8FA@CY5PR12MB6372.namprd12.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jianheng,

On Mon, Dec 11, 2023 at 06:13:21AM +0000, Jianheng Zhang wrote:
> Adds the HW specific support for Frame Preemption handshaking on XGMAC3+
> cores.
> 
> Signed-off-by: Jianheng Zhang <Jianheng.Zhang@synopsys.com>
> ---

It's nice to see contributions from Synopsys!

Have you seen the (relatively newly introduced) common framework for
Frame Preemption and the MAC Merge layer?
https://docs.kernel.org/networking/ethtool-netlink.html#mm-get
https://man7.org/linux/man-pages/man8/ethtool.8.html
https://man7.org/linux/man-pages/man8/tc-mqprio.8.html # "fp" option
https://man7.org/linux/man-pages/man8/tc-taprio.8.html # "fp" option

I think it would be valuable if the stmmac driver would also use it, so
it could support openlldp and pass the selftest at
https://github.com/torvalds/linux/blob/master/tools/testing/selftests/net/forwarding/ethtool_mm.sh
