Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9BB47F4FC4
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 19:40:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235132AbjKVSkI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 13:40:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235368AbjKVSjy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 13:39:54 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12F6D10C0;
        Wed, 22 Nov 2023 10:39:50 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-40b2ad4953cso7028945e9.0;
        Wed, 22 Nov 2023 10:39:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700678388; x=1701283188; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=YDjLfRk2WpjpKzC7NBxti8sskFBWWzZRE9jVKMLQcIQ=;
        b=a2VxqY8AFbaZqVN/EzNNPCTNHVTEkWs0FTnjuFfqqZ+fTgIWNGW7kDjJH/sSdjRGOy
         rqX0eHCewNJ/G5xE08LppATj/KQP6/aYDJYN8bmxXCmAlGtA5JgrG75lp39xQDpmjXcy
         SAk7eH46ySz/RXoKtpjxnQHJBTSF+/Gf0E6XSu1WrSdso/8kw138kN5OxGj0UrDWvdM8
         FajheAMITgZgX2vX10V6l/7/j1dpMTsBc4PQ8aqMKzSeyHqFi7CupLt9yxrN/l8CMmQi
         7IxyiMtXx1uNY/71vhX3W7AgatN7d9BNaBusoCJ4iO1XyTvrI8a5BloIJqufi7cICHWX
         3Ppg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700678388; x=1701283188;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YDjLfRk2WpjpKzC7NBxti8sskFBWWzZRE9jVKMLQcIQ=;
        b=GY+prxma71JZUGNYmDoTcgo+Cqq0NqkwJc2mDNu6zeu1Sh63Gil8uRES9VJREMPiyj
         MMXqeoPRl0dd16a+UZPlM4CW8j87gaqBCi5TWDz5+goxO7n3kWNIBhTfqMlrnn6ulB/P
         gkIGzaS9YCvmkKXfJrU9aEe9Xglq4jwx800G8gZDE5wrVrAFTye4qvKOFgMAzAzslpF1
         nZ+UUsDBaPH5CVAQxFaByli26vQeHs1AHaQn5LqGfxDPCe0JrqqkQaQ2lBx+lVd4GKjd
         YWc58EugfSg9u1tlEZwGKOPYRn8JdJWRBl1bausYaEpbVIRgvMxMfDJ+0AqKXrP7Qb9c
         oKOQ==
X-Gm-Message-State: AOJu0Yy+SS+BvBgeD9IT/Z/5SNVWvHwmr0yCEinkR8Zr5ujvXfmxzl4/
        8RiTjlkvtaRRWXNMb0cpelU=
X-Google-Smtp-Source: AGHT+IEODA7sDfQRz1z/Fo5qEgzJagOOGYIc58x1MDSPqo64Jmqfvu9AnwF2LW8TEm+brrJaQvylhA==
X-Received: by 2002:a05:600c:274e:b0:406:5a14:5c1e with SMTP id 14-20020a05600c274e00b004065a145c1emr321071wmw.1.1700678387986;
        Wed, 22 Nov 2023 10:39:47 -0800 (PST)
Received: from Ansuel-xps. (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.gmail.com with ESMTPSA id je20-20020a05600c1f9400b0040836519dd9sm208462wmb.25.2023.11.22.10.39.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 10:39:47 -0800 (PST)
Message-ID: <655e4af3.050a0220.54c5a.113b@mx.google.com>
X-Google-Original-Message-ID: <ZV5K8P1tTC3HUkqE@Ansuel-xps.>
Date:   Wed, 22 Nov 2023 19:39:44 +0100
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     "Russell King (Oracle)" <linux@armlinux.org.uk>,
        Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Robert Marko <robimarko@gmail.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: Re: [net-next PATCH] net: phy: aquantia: drop wrong endianness
 conversion for addr and CRC
References: <20231122170813.1222-1-ansuelsmth@gmail.com>
 <ZV45UY6nYZ/WAHpG@shell.armlinux.org.uk>
 <655e4025.df0a0220.50550.3d70@mx.google.com>
 <20231122102347.0bde86bb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231122102347.0bde86bb@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 22, 2023 at 10:23:47AM -0800, Jakub Kicinski wrote:
> On Wed, 22 Nov 2023 18:53:39 +0100 Christian Marangi wrote:
> > So they DO get converted to the HOST endian on reading the firmware from
> > an nvmem cell or a filesystem?
> 
> They don't get converted when "reading from nvmem / fs". 
> They get converted when you do:
> 
> 		word = get_unaligned((const u32 *)(data + pos));
> 
> get_unaligned() is basically:
> 
> #if BIGENDIAN
> #define		get_unaligned	get_unaligned_be32
> #else
> #define		get_unaligned	get_unaligned_le32
> #endif
> 
> so you'll get different behavior here depending on the CPU.

Ugh... If that is true this is bad...

When get_unaligned was suggested, I checked if the thing was doing any
kind of conversion and from [1] I tought it was just getting the
pointer.

I can't find the entry where the thing is done. Is this some kind of
include magic with asm specific API?

[1] https://elixir.bootlin.com/linux/latest/source/include/asm-generic/unaligned.h#L22

-- 
	Ansuel
