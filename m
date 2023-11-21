Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68FD57F3A76
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 00:48:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234928AbjKUXse (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 18:48:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234947AbjKUXs3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 18:48:29 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9932D5D;
        Tue, 21 Nov 2023 15:48:06 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-40b31232bf0so821735e9.1;
        Tue, 21 Nov 2023 15:48:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700610485; x=1701215285; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=VBeHNSHlYzzQwTF3+YkOxYsnRgTfqfmH+Kq7QdBX0s8=;
        b=Mjhm+RyBj+5n/A6JFftElcYZiJTSAsaNz1FPLYHMbFeAvE7y9UFs4INIRUROqjG4CL
         1t/tHpzLLp2QbfbfavbPTCPxZcxKVOUPvvZwkdaUMePHORQdcaps/CopoehQEhapf0oH
         S2XdYuwzATR0YcktlGHaFR6bIBhYz4UAHlrxbXnxPXEWrKO/ti8k/g37hECq12W/0FKJ
         prffzexHf/96v28YqSFcz16kQqFYR2YNmeUS7ZMTHL6uGNczVQyH+LK0PsgVDAiAczIi
         KpH5xJHgKjZiQwWGJDhnl20ZaklXdD5AdoIazNxGkGzvQgDAhe32ZQuIGVuc6zKLWZmR
         3mHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700610485; x=1701215285;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VBeHNSHlYzzQwTF3+YkOxYsnRgTfqfmH+Kq7QdBX0s8=;
        b=qr8Vs4IWNXq3vUBCQ1T/0gXWN6robNlaIs23iYud+++VrJYQ7TGi0eyeDGkJ+qmBk2
         Q800huhjXqvP/WoGsoj5waltE1g7/MTbgZwB83ip5hcDCT/RjXh2h8mcbktQ5ZLnjXNR
         qHw9e0+CC1tzIGFxo5drjzfM+/a83NFqae9cLoJ4pC/gQaNykqUYtsPemfOszUrSmMIE
         uLsB+ml880M8ntniH9MLDrlLWcERc9aJhJkOOUjJ/JOoZAjx2nKsc9k3tbaY4XWcaEh+
         YQTtol2csxBMw8Qyk+BnfsnrcezVAng91TEEK6xBs/rtp9+9FYv5HIydEpRljuAP8Jzj
         rkng==
X-Gm-Message-State: AOJu0Yx76AuYWmpgNvt4487x/X9yLIKQPYAZWmt5C8pnUsx/5EDcLdoh
        iBlqh7ZEauLJc3uZ+sNlRjc=
X-Google-Smtp-Source: AGHT+IHv6MdpBsrVXzQcC6DvSrRhR1h/jO8Wc1F01dDMNaYYIvvTW+MeqF6ZRNP9pe4hHwL0SK50IA==
X-Received: by 2002:a05:6000:144f:b0:32f:8248:e00 with SMTP id v15-20020a056000144f00b0032f82480e00mr336935wrx.51.1700610484678;
        Tue, 21 Nov 2023 15:48:04 -0800 (PST)
Received: from Ansuel-xps. (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.gmail.com with ESMTPSA id co8-20020a0560000a0800b00332c32d7ab2sm9876924wrb.88.2023.11.21.15.48.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Nov 2023 15:48:04 -0800 (PST)
Message-ID: <655d41b4.050a0220.36e34.359e@mx.google.com>
X-Google-Original-Message-ID: <ZV1BsQCoN3bIEW0i@Ansuel-xps.>
Date:   Wed, 22 Nov 2023 00:48:01 +0100
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
 <655d3e2b.df0a0220.50550.b235@mx.google.com>
 <20231121153918.4234973d@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231121153918.4234973d@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 21, 2023 at 03:39:18PM -0800, Jakub Kicinski wrote:
> On Wed, 22 Nov 2023 00:32:56 +0100 Christian Marangi wrote:
> > the 2 addr comes from a define
> > 
> > #define DRAM_BASE_ADDR		0x3FFE0000
> > #define IRAM_BASE_ADDR		0x40000000
> > 
> > it wasn't clear to me if on BE these addrs gets saved differently or
> > not. PHY wants the addr in LE.
> > 
> > On testing by removing the cpu_to_le32 the error is correctly removed!
> > 
> > I guess on BE the addr was actually swapped and FIELD_GET was correctly
> > warning (and failing) as data was missing in applying the mask.
> 
> I think so. It's the responsibility of whether underlies 
> phy_write_mmd() to make sure the data is put on the bus in
> correct order (but that's still just within the u16 boundaries,
> splitting a constant into u16 halves is not endian dependent).
> 
> > If all of this makes sense, will send a followup patch that drop the
> > cpu_to_le32 and also the other in the bottom that does cpu_to_be32 (to a
> > __swab32 as FW is LE and mailbox calculate CRC in BE)
> 
> Not so sure about this one, it puts the u32 on the stack, and takes 
> the address of it:
> 
> 	u32 word;
> 
> 	word = (__force u32)cpu_to_be32(word);
> 	crc = crc_ccitt_false(crc, (u8 *)&word, sizeof(word));
> 
> so the endian will matter here. My guess is that this part is correct.

Ehhh this is problematic. Data comes from nvmem or filesystem, in theory
they should not be touched/converted.

nvmem_cell_read or request_firmware return pointer to u8 and it's the
firmware (that is always in LE)

If data is not converted and passed AS IS from what is read to the
allocated data, then data should be always swapped.
(this PHY is fun... it's probably BE internally but expect LE stuff in
the mailbox, as it does emit BE CRC.)

Any idea where I can verify if nvmem_cell_read or request_firmware makes
any kind of endianess conversion on the data it does read?

-- 
	Ansuel
