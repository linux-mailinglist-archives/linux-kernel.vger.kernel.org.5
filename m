Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D27307F3A49
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 00:33:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231314AbjKUXdG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 18:33:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjKUXdF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 18:33:05 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4FB483;
        Tue, 21 Nov 2023 15:33:01 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-332ca7f95e1so1534533f8f.0;
        Tue, 21 Nov 2023 15:33:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700609580; x=1701214380; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=UmYW1vk7X8EaOO6oHl6rUwKJWkJ/lZRnUq8F+Hg+/E8=;
        b=UrH52+7whC6RwyhZYcdIRFvX4Zz80w1IAqv52E9yq5W+ojVaJcOC96UTcR3DeKeRtY
         /U0F7gNoa5L5I8WfbOevH/gPyILMtDulwYE4c27K4JO4ndCP4zAAjmnuWyDIW4uljmus
         AW4J3xr9mgQyBbBGTBrjkBW3om7Oireq7VoU/GZzAJs/SXGajbR+TmGWJTBOLNekKNBP
         TqKTZD6TEpBwa48gn49kmHq+lpYDDqNG9+B58Wj4INz4oZlV5BydNpudcBHyLwJQi3j/
         v5GUwaCzP3vDYqVIbBXMPkXWb1UGiY/OZYov+90zHqUJ/+gfnrRbXn2DHsV85thCqJyK
         RTHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700609580; x=1701214380;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UmYW1vk7X8EaOO6oHl6rUwKJWkJ/lZRnUq8F+Hg+/E8=;
        b=MTM2XsRfMKMwyFqoT1EnJc1rJZIauRHT1B6fcL/WlGMXbyqE5qd072EaCPEaxKlQ6q
         rfQFFw9+Xu8RiDg73zKb5vViC3Tei/X75k3j5RlJoEMXtgH6N+afZUnkql91L/JuhILp
         +kIR3MRrvzRayA2m5rvcHrY70moodbiEy5MPQr0Dkl3W3JEYXG9sRpPzAaNVyVfcvfvX
         vyQKEukkEt6/UTPM8t0QWUAYOnxzfnhjlT9+g7zrwxcpPi37QKCE6QxhuB1a3AhUT8M9
         XDaJXTtbwfz/nuGEjhDTl9T/fbaJXr6kKkx/svMZq8Rj4fCaVLj5R+A4Ih4bCOuWqlgf
         0CMg==
X-Gm-Message-State: AOJu0Yw9TRMd23pCpN0mh+fArKUQZqsmjIu9tNce2/GIbsigQ6xS52pQ
        MiGxOnuNo6cgMVFzAFEco4E=
X-Google-Smtp-Source: AGHT+IHyfv6EWwGzl/lZkCkfwESfRcrM/6tpQNhRcWQvhACfnXXxJs/frsdZmI9lwhU6OUelW8wUug==
X-Received: by 2002:adf:f082:0:b0:332:c4e3:9b09 with SMTP id n2-20020adff082000000b00332c4e39b09mr277073wro.30.1700609579780;
        Tue, 21 Nov 2023 15:32:59 -0800 (PST)
Received: from Ansuel-xps. (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.gmail.com with ESMTPSA id k5-20020adfe8c5000000b00331733a98ddsm12625716wrn.111.2023.11.21.15.32.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Nov 2023 15:32:59 -0800 (PST)
Message-ID: <655d3e2b.df0a0220.50550.b235@mx.google.com>
X-Google-Original-Message-ID: <ZV0+KC9dw/lS4xCS@Ansuel-xps.>
Date:   Wed, 22 Nov 2023 00:32:56 +0100
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Robert Marko <robimarko@gmail.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: Re: [net-next PATCH] net: phy: aquantia: make mailbox interface4 lsw
 addr mask more specific
References: <20231120193504.5922-1-ansuelsmth@gmail.com>
 <20231121150859.7f934627@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231121150859.7f934627@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 21, 2023 at 03:08:59PM -0800, Jakub Kicinski wrote:
> On Mon, 20 Nov 2023 20:35:04 +0100 Christian Marangi wrote:
> > It seems some arch (s390) require a more specific mask for FIELD_PREP
> > and doesn't like using GENMASK(15, 2) for u16 values.
> > 
> > Fix the compilation error by adding the additional mask for the BITS
> > that the PHY ignore and AND the passed addr with the real mask that the
> > PHY will parse for the mailbox interface 4 addr to make sure extra
> > values are correctly removed.
> 
> Ah. Um. Pff. Erm. I'm not sure.
> 
> Endianness is not my strong suit but this code:
> 
> 	/* PHY expect addr in LE */
> 	addr = (__force u32)cpu_to_le32(addr); 
> 
> 	/* ... use (u16)(addr)       */
> 	/* ... use (u16)(addr >> 16) */
> 
> does not make sense to me.
> 
> You're operating on register values here, there is no endian.
> Endian only exists when you store or load from memory. IOW, this:
> 
> 	addr = 0x12345678;
> 	print((u16)addr);
> 	print(addr >> 16);
> 
> will print the same exact thing regardless of the CPU endian.
> 
> Why did you put the byte swap in there?

the 2 addr comes from a define

#define DRAM_BASE_ADDR		0x3FFE0000
#define IRAM_BASE_ADDR		0x40000000

it wasn't clear to me if on BE these addrs gets saved differently or
not. PHY wants the addr in LE.

On testing by removing the cpu_to_le32 the error is correctly removed!

I guess on BE the addr was actually swapped and FIELD_GET was correctly
warning (and failing) as data was missing in applying the mask.

If all of this makes sense, will send a followup patch that drop the
cpu_to_le32 and also the other in the bottom that does cpu_to_be32 (to a
__swab32 as FW is LE and mailbox calculate CRC in BE)

-- 
	Ansuel
