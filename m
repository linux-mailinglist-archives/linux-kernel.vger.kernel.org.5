Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 034C97DF02F
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 11:35:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346765AbjKBKbc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 06:31:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346802AbjKBKba (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 06:31:30 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0FAE187;
        Thu,  2 Nov 2023 03:31:27 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-9d242846194so111823066b.1;
        Thu, 02 Nov 2023 03:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698921086; x=1699525886; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CpjOzif0QjYVITE4SJqbyNSX7vVCExngH+2bDixVO2k=;
        b=EwgFi+JsreEx26PQchIxW9xob6QlXxDTvO9COoSPNCvMBhEp9rre2XRhvrX3i/uPro
         NKeNAwil1do8CU0Rpw3RjyMzQL7Gao1WsPM4UzR67/yy74tBtmQgSrOO6Bebo+ritXjN
         3e4l+3uNOTyOg7sSgNjtdOUUDSRnAvHINqTqMD3V5jBN8kZoOr7b0Mu9eNj1hxkh3vSZ
         FqEiY43YJI3W4xhVtQYmZhz4ziRCWH7xlJR0PfyE4b7DuoGPOLlW5O5KmL0wumGMiqLk
         itkqoYh3uHyQmIuWDlq5M5yc/7HQpoNBiMu8WityL+ZyiY+uB9hM7ZkIzmcQk8WWH0It
         MDqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698921086; x=1699525886;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CpjOzif0QjYVITE4SJqbyNSX7vVCExngH+2bDixVO2k=;
        b=aaZbk+fKTUxVAiQ7RzTcMt5+F7vb50ADaTvRzTOPwKCkBqbQP1k+TQbDSY34Kb9osA
         bVAVZ0A1zNXA9FHdZi3MOnHFKWkoHtIEcrKfqesPBhfgZj2bmxL15hB3b8qMYrsSffnv
         s6RlwI+PnaQeCMcqH886B7I5yIGWALnqLU9oscTc+xuUwHZ6IVECwXHPYkybceF8SYpn
         8cBtAxwRmNekViIcjkbrHda8Q3POlv/2eJ9VoeDv7ux8pcaOvl4UWeqiPqdY7NfbRIRY
         dG5WYpaad/4Q1OA6iKzBY2xoOS2hYXb4/3z4Gl0/SG6uRfxq4rsKpaFPj+Prqv03d0Ae
         zpHw==
X-Gm-Message-State: AOJu0YyMG4TSER5TsXJtwmtW/90syhA7I2rqe+MSzf+xtAhzSEgbe3kR
        rQ7LVM/itQxgRKbthDa4iPRpjFKvofzoxA==
X-Google-Smtp-Source: AGHT+IEgF66vZ93tpDzSJ96lPj90OBOGERBzlE/mKany2i7Stpw9vhjKWrwM/6gBEQu265ysQYNbFA==
X-Received: by 2002:a17:906:3b53:b0:9c3:afd3:6136 with SMTP id h19-20020a1709063b5300b009c3afd36136mr3685529ejf.72.1698921086079;
        Thu, 02 Nov 2023 03:31:26 -0700 (PDT)
Received: from skbuf ([188.26.57.160])
        by smtp.gmail.com with ESMTPSA id d14-20020a170906370e00b009b2d46425absm969205ejc.85.2023.11.02.03.31.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Nov 2023 03:31:25 -0700 (PDT)
Date:   Thu, 2 Nov 2023 12:31:23 +0200
From:   Vladimir Oltean <olteanv@gmail.com>
To:     Luiz Angelo Daros de Luca <luizluca@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] net: dsa: tag_rtl4_a: Bump min packet size
Message-ID: <20231102103123.hklqlsbb5kbq53mm@skbuf>
References: <20231030-fix-rtl8366rb-v2-1-e66e1ef7dbd2@linaro.org>
 <20231030141623.ufzhb4ttvxi3ukbj@skbuf>
 <CACRpkdaN2rTSHXDxwuS4czCzWyUkazY4Fn5vVLYosqF0=qi-Bw@mail.gmail.com>
 <20231030222035.oqos7v7sdq5u6mti@skbuf>
 <CACRpkdZ4+QrSA0+JCOrx_OZs4gzt1zx1kPK5bdqxp0AHfEQY3g@mail.gmail.com>
 <20231030233334.jcd5dnojruo57hfk@skbuf>
 <CACRpkdbLTNVJusuCw2hrHDzx5odw8vw8hMWvvvvgEPsAFwB8hg@mail.gmail.com>
 <CAJq09z4+3g7-h5asYPs_3g4e9NbPnxZQK+NxggYXGGxO+oHU1g@mail.gmail.com>
 <CACRpkdZ-M5mSUeVNhdahQRpm+oA1zfFkq6kZEbpp=3sKjdV9jA@mail.gmail.com>
 <CAJq09z6QwLNEc5rEGvE3jujZ-vb+vtUQLS-fkOnrdnYqk5KvxA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJq09z6QwLNEc5rEGvE3jujZ-vb+vtUQLS-fkOnrdnYqk5KvxA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Luiz,

On Wed, Nov 01, 2023 at 09:35:30AM -0300, Luiz Angelo Daros de Luca wrote:
> Hi Linus,
> 
> Sorry but I noticed no issues:
> 
> From the router:
> 
> No. Time Source Destination Protocol Length Info
> 1 0.000000000 192.168.1.1 192.168.1.2 ICMP 1514 Echo (ping) request id=0x0789, seq=23/5888, ttl=64 (reply in 2)
> 2 0.000040094 192.168.1.2 192.168.1.1 ICMP 1514 Echo (ping) reply id=0x0789, seq=23/5888, ttl=64 (request in 1)
> 
> From the host:
> 
> No. Time Source Destination Protocol Length Info
> 1 0.000000000 192.168.1.2 192.168.1.1 ICMP 1514 Echo (ping) request id=0x0002, seq=8/2048, ttl=64 (reply in 2)
> 2 0.000391800 192.168.1.1 192.168.1.2 ICMP 1514 Echo (ping) reply id=0x0002, seq=8/2048, ttl=64 (request in 1)
> 
> If I go over that limit, it fragments the packet as expected.

Could you run the shell command that sweeps over the entire range, fromhere?
https://lore.kernel.org/netdev/20231030222035.oqos7v7sdq5u6mti@skbuf/
