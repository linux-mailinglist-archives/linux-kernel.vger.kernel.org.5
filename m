Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F34D7DE4C6
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 17:42:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344134AbjKAQmB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 12:42:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231233AbjKAQmA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 12:42:00 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68505122;
        Wed,  1 Nov 2023 09:41:58 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-409299277bbso45745815e9.2;
        Wed, 01 Nov 2023 09:41:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698856917; x=1699461717; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ehLytG5Lm/m8qAHZ+syDbxWvnyxatw+QyGWbeWWsGIU=;
        b=cxVMYWGgjnJc20QcJxLCN64jwi4Ce2dL0Osu/gIGtLuGXvl3HKUEHUa1s5dclyYIEH
         NEP1VimUh7rugT+lPvYBnPvnWu+NK54v3Is2DxHGCeM+6veVc78L8vmEB3G3TMoVELl/
         gV8DReXLLcDYLcUPE6eS1Rb+o8059yWhKLMsQktYGxWos9749H+NijnOC5JfhIf6f3Vc
         LBobY1iKFP0mFL8oif9sAlLxh38bRRiLFEeiUq1KAVnKVL01iSpqjksFePU/nhHvx7z4
         fk7/12rjHgBWIDLAlAfb3PN90chuYxVkiibd1d8CHK2YMr3BkPWw6AKX97jROEIIx0eh
         CM+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698856917; x=1699461717;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ehLytG5Lm/m8qAHZ+syDbxWvnyxatw+QyGWbeWWsGIU=;
        b=i4t9p2fRlI39eoCZzuHy0lG5/5Gp5eH1T+YE7Pvvcwpa47J61N9gNFKIwbXBlTKzpd
         EuzKwQtbPtHWnluPOZAnf++w3junMIZQ+r+KHi/LtynjiWienCDf6xhf2Y8G+xH2eFqa
         ZktyKW6tXjEjhpqu4Q9DlU/pO9zw23KFdl2U2XeF0jgL0F8VWOZps6Os1sxB1n0anayn
         ozvqVh92pkp9KRXYq8bYPHyDembGGkVYXf82F20X6fQUdIoaBTLY8c/+JOwb1DsS3IIc
         849StTSGLg+nJEHC+hgI28mn1fHqXbKhSHi1IYbYlJZjRjuOndl9C40+ZYxmmCavWL4T
         B1+A==
X-Gm-Message-State: AOJu0YwXI6YhS8QVV2SGi4/S92UjEkguiCs5FJskxO8akLsSeAk36Fqq
        ZlaYrkyUyLgmb5a8FUHi91s=
X-Google-Smtp-Source: AGHT+IH1cv3srURZBKYzAKH61o4WsiM1ZhlAF4FyGZIbI6s1ew2ZAr1yiNQIy/qjfyExiMcfVELg0A==
X-Received: by 2002:a5d:4d09:0:b0:32d:9d99:94e7 with SMTP id z9-20020a5d4d09000000b0032d9d9994e7mr13885540wrt.49.1698856916448;
        Wed, 01 Nov 2023 09:41:56 -0700 (PDT)
Received: from Ansuel-xps. (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.gmail.com with ESMTPSA id e16-20020adff350000000b0032daf848f68sm253005wrp.59.2023.11.01.09.41.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Nov 2023 09:41:56 -0700 (PDT)
Message-ID: <65427fd4.df0a0220.28d26.1955@mx.google.com>
X-Google-Original-Message-ID: <ZUJ/0gYlnN7GwSuC@Ansuel-xps.>
Date:   Wed, 1 Nov 2023 17:41:54 +0100
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Robert Marko <robimarko@gmail.com>
Subject: Re: [net-next PATCH v2 1/2] net: phy: aquantia: add firmware load
 support
References: <20231101123608.11157-1-ansuelsmth@gmail.com>
 <4b536ad3-2112-4f28-90e4-586b5745be20@lunn.ch>
 <65427400.5d0a0220.41c58.0ded@mx.google.com>
 <34a0b76e-aa0e-4148-ba01-c3b4608f17f7@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <34a0b76e-aa0e-4148-ba01-c3b4608f17f7@lunn.ch>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 01, 2023 at 05:32:29PM +0100, Andrew Lunn wrote:
> > > > +	for (pos = 0; pos < len; pos += min(sizeof(u32), len - pos)) {
> > > > +		u32 word = 0;
> > > > +
> > > > +		memcpy(&word, data + pos, min(sizeof(u32), len - pos));
> > > 
> > > Rather than do a memcpy, use the get_unaligned_ macros. They might map
> > > to a memcpy(), but some architectures can do unaligned accesses
> > > without problems.
> > > 
> > 
> > I don't think this is doable for this loop, think we would end up in
> > some funny situation where for the last run we have to copy less than
> > u32. (get_unaligned would always take u32 of data and that would end up
> > reading more than requested) Am I wrong?
> 
> Does it happen in practice that the last chunk is not 4 bytes?  Since
> this is firmware, its probably produced by some sort of linker, and
> they often round segments to words. Could you take a look at the
> firmware images you have access to and see if this is true?
>
> It could be we do need to keep with the memcpy, but it would be nice
> if we could limit it to words, at least until somebody has a firmware
> which is not word aligned.
>

There are plenty of firmware around so it can be checked by from what I
have, it looks like they are word aligned... Ok I will use the
get_unaligned and add a comment saying that we assume the iram and dram
section are always word aligned.

Is it ok?

-- 
	Ansuel
