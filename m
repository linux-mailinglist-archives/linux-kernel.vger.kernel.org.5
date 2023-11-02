Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B8DE7DF075
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 11:46:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347251AbjKBKqA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 06:46:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347144AbjKBKp5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 06:45:57 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A037138;
        Thu,  2 Nov 2023 03:45:55 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-540fb78363bso1288023a12.0;
        Thu, 02 Nov 2023 03:45:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698921953; x=1699526753; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XjL++vViYaDWI2YtfsqD0BSYvDF9i1i+EJlr9p5UOfE=;
        b=F2tlDWgX41deut2CSj+12fzK/QWrx3oA4+ifHIyxF3xUA7NbSZ6ioLx/2maxgrl9OC
         5RaDeSvA36z7XohbDTypZE52hswz3FfgwAtwJXdb16gUgWmncARiSUH+ltaGEkpInwBa
         makr6+EIW/5Q06AomJm2pVhBZwm4huvM+MmCGwp4/SLe37Awt0spXuBnt5b5s/rf3j/w
         +alOAnEA03UAuiIPxChSIbM+LOtfQ0ICZPHfHtbGapbZjTj70JuCimMPbUZbp1kbrwY/
         MN/wuy1B2JZZ07qJGCZgLfHFqgF8gDxubJLBnwiRW1uFBVg3xessjXv29EcRjZDpZE9t
         hcAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698921953; x=1699526753;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XjL++vViYaDWI2YtfsqD0BSYvDF9i1i+EJlr9p5UOfE=;
        b=ddAMrYiRTgTFvM6JVqw0GWmBgeTog8nYAVVA58kX4HsWcrd4D+yP5ibK72zBS8N5D4
         KRDmvwlRTrrUj3f7jWnlRnQclsvbFVUM2W5LkOPM8NCpH+qiBkby/JXgYb4HP2bNnV09
         bJKyo/wRUHD+7nljHQkKu9M57iCl/JxbGrVuSNm6ZW35rBv3cUQ6lZMczxWTmWyVXmCO
         TlkSoNxdV77MELGPj//cQnWIUlebyjKx1xQLDEx/L9WXA2DY/LrejcZDX6eAi5WLtx30
         bqf6FpD1MYIsCDBkLdMXAaQ2EPI65vFEp2cENy7d0Wpca6UEmXBwopJ+asfc7nyvk+/4
         3ceQ==
X-Gm-Message-State: AOJu0YzMlKq6ly8xvfSjb+pGPgBfgkihl68z0RjKc7XQdOwlNZTw9ydG
        MdJHwsQNG1Mb/jxcaQ/RquU=
X-Google-Smtp-Source: AGHT+IFj4hzOG4wSgbi6JwMGNCHVvolStewuOWlcu3gxxyWR4UxSSlAg7EilxG3Tyqxpq+VKL0er9w==
X-Received: by 2002:a17:906:fe41:b0:9b6:aac1:6fa5 with SMTP id wz1-20020a170906fe4100b009b6aac16fa5mr4194163ejb.55.1698921953286;
        Thu, 02 Nov 2023 03:45:53 -0700 (PDT)
Received: from skbuf ([188.26.57.160])
        by smtp.gmail.com with ESMTPSA id j19-20020a170906279300b009ae69c303aasm976244ejc.137.2023.11.02.03.45.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Nov 2023 03:45:53 -0700 (PDT)
Date:   Thu, 2 Nov 2023 12:45:50 +0200
From:   Vladimir Oltean <olteanv@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Luiz Angelo Daros de Luca <luizluca@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] net: dsa: tag_rtl4_a: Bump min packet size
Message-ID: <20231102104550.iuw5ozfchbm3u667@skbuf>
References: <20231030141623.ufzhb4ttvxi3ukbj@skbuf>
 <CACRpkdaN2rTSHXDxwuS4czCzWyUkazY4Fn5vVLYosqF0=qi-Bw@mail.gmail.com>
 <20231030222035.oqos7v7sdq5u6mti@skbuf>
 <CACRpkdZ4+QrSA0+JCOrx_OZs4gzt1zx1kPK5bdqxp0AHfEQY3g@mail.gmail.com>
 <20231030233334.jcd5dnojruo57hfk@skbuf>
 <CACRpkdbLTNVJusuCw2hrHDzx5odw8vw8hMWvvvvgEPsAFwB8hg@mail.gmail.com>
 <CAJq09z4+3g7-h5asYPs_3g4e9NbPnxZQK+NxggYXGGxO+oHU1g@mail.gmail.com>
 <CACRpkdZ-M5mSUeVNhdahQRpm+oA1zfFkq6kZEbpp=3sKjdV9jA@mail.gmail.com>
 <CAJq09z6QwLNEc5rEGvE3jujZ-vb+vtUQLS-fkOnrdnYqk5KvxA@mail.gmail.com>
 <CACRpkdaoBo0S0RgLhacObd3pbjtWAfr6s3oizQAHqdB76gaG5A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACRpkdaoBo0S0RgLhacObd3pbjtWAfr6s3oizQAHqdB76gaG5A@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 01, 2023 at 09:26:50PM +0100, Linus Walleij wrote:
> On Wed, Nov 1, 2023 at 1:35 PM Luiz Angelo Daros de Luca <luizluca@gmail.com> wrote:
> 
> > Sorry but I noticed no issues:
> 
> Don't be sorry about that, it's good news because now I know
> where to look, i.e. in the ethernet controller.

Don't look too deeply into the code just yet, just try to see what
happens with dsa_loop on an identical Ethernet controller that isn't
physically attached to a switch.
