Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 606317DA25F
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 23:23:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346529AbjJ0VXW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 17:23:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232518AbjJ0VXU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 17:23:20 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2CB6129;
        Fri, 27 Oct 2023 14:23:16 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id 41be03b00d2f7-53fbf2c42bfso2021946a12.3;
        Fri, 27 Oct 2023 14:23:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698441796; x=1699046596; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Q4Q8nuDM9k/u/LkEVyOR5WiT5bOMm5Q+OB4cIkeRtaU=;
        b=cmhlaWbN1TGM8ws9BFqH5zPVIf7v18ASDhEzHwt7V41QZxn+4AjnATuM/ebrDhwob6
         R76iOK4rJSa82QRaPnrhH2duIPcc/1A0RcX7IKInGXWwYmvOkiMda73BPV76waQILJdL
         +zqe2/IMTqvIGzQ+vjIzNvS7nIwU/NJlNuSasZ9vvLFVJ2aZ35tGake3DOi0WnAdZ9wE
         cRNo/20r3aLJEJyoOM0tlcYnNiXwT+hvauEYXz/rAy5xucUMXPjlBOagAXGcWbf5N1MM
         Wr/Cgl4mFGP8ruSfFOOXaLoatwqVtgPNeUsNdQdD5zMgg3LQRP11c4nzCfhTej6G3+qq
         x19w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698441796; x=1699046596;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q4Q8nuDM9k/u/LkEVyOR5WiT5bOMm5Q+OB4cIkeRtaU=;
        b=oGJltj/dtRtw5faMumG1coWGEfUViIj5K5WqDrvuSFdKH4dBp7E9sZugTgWyzy3o2k
         rqUPDcJJQT4BcWuXL7Lkkdi8QUfAHOAmc1B74AsCOLhpVwYHlLhWZyDiRr1J+MRETnJi
         6cY08Zjck/iiAt/imglO/ygcGRZOXJ4AL1ebknDrwrt2f3FJvbS4+Y8EJcR+KkxKqXL1
         vjoigxZV5Zck16L4v7pqxdKoPxkbV+ogW+cyvl14mLyrmaZ0SrxgUwOtXIRyuuhnvKUR
         QWRh7xsJ+6vtkpP0Kac1KMZ58rPVJy0Em0vD1gJSY023sD5YRcjbpLshGJNsfrStQN90
         Kz7w==
X-Gm-Message-State: AOJu0YxHzgNLTIiXSlvYQ1NOKwM2CNqQsq7+1FCdUpCRjdZ6WP/yhuUU
        z0gBv2stbWDqh0q4VvlzMtU=
X-Google-Smtp-Source: AGHT+IHOo+0S/yy4dCT4+non5a027LK29puQBNN6VplAOiPcx9hoopgfc8N7HSD0Q+p+5xmzhH/UxQ==
X-Received: by 2002:a17:90b:103:b0:27d:9b67:7fa6 with SMTP id p3-20020a17090b010300b0027d9b677fa6mr3543660pjz.3.1698441796212;
        Fri, 27 Oct 2023 14:23:16 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id p1-20020a17090a0e4100b0027768cd88d7sm5171675pja.1.2023.10.27.14.23.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Oct 2023 14:23:15 -0700 (PDT)
Message-ID: <95f324af-88de-4692-966f-588287305e09@gmail.com>
Date:   Fri, 27 Oct 2023 14:23:13 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dsa: tag_rtl4_a: Bump min packet size
Content-Language: en-US
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231027-fix-rtl8366rb-v1-1-d565d905535a@linaro.org>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20231027-fix-rtl8366rb-v1-1-d565d905535a@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

You would want your subject to be:

net: dsa: tag_rtl4_a: Bump min packet size

On 10/27/23 13:21, Linus Walleij wrote:
> It was reported that the "LuCI" web UI was not working properly
> with a device using the RTL8366RB switch. Disabling the egress
> port tagging code made the switch work again, but this is not
> a good solution as we want to be able to direct traffic to a
> certain port.
> 
> It turns out that sometimes, but not always, small packets are
> dropped by the switch for no reason.

And we are positive that the Ethernet MAC is also properly padding 
frames before having them ingress the switch?

> 
> If we pad the ethernet frames to a minimum of ETH_FRAME_LEN + FCS
> (1518 bytes) everything starts working fine.

That is quite unprecedented, either the switch is very bogus or there is 
something else we do not fully understand...
-- 
Florian

