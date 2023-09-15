Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF2007A22DB
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 17:46:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236291AbjIOPpz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 11:45:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236309AbjIOPp2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 11:45:28 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A7FFE78
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 08:45:23 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1bf57366ccdso24649435ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 08:45:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1694792722; x=1695397522; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Th8NoXT19fs06IrPnES4vcAsMrYG/0js4/EA9rEsqpw=;
        b=GKq65H6JA1W1dliPy/GlfT3r1SP7qTE17EPxUtrIs2pfoR/f13wgNjmV+SDHXdfXSl
         4EMqNtHTwGs7Zt/xKWaQt4FQbWpcj39uMOQ3vqlov3os3IL+OTQgJk6SaN4ZuJau+rwY
         rAQH1YqhB+arZAAcDLZJJABkvQ2UmO8+iYZfsqDF0ZekpRJOMsIMjmvGbdHBVR0rd1BS
         rYj7+h75RX+rOGPEILwCVry3FMwj/D/ofM7m3HQPsVjDjFuO4doz8tcJ5faXro3f28YJ
         +jxCYYux5nQUpAhUQ+fHcuoQ5McagiadShN9aloBazXQsfp5JT0BdLWMLqlqIBV+k6ya
         R3Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694792722; x=1695397522;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Th8NoXT19fs06IrPnES4vcAsMrYG/0js4/EA9rEsqpw=;
        b=HxhsOx6ag4bF1XsoHi9maW/xryHQyLnLAxjGmVtl3dSDtiGGkzn4cUx3ez28W5vXIy
         uMJIeXLbjxAaQYVtWjIFVbpP/JXoDbqWpmDEPag/8wNUDIs2VBGIp2kOWYxY5UfyV9vF
         5wsZZY5NqfqOwWNaN5N5+g77BOTL3VbjcbbLNPFxTtWRyy2MO3ebroFthahKYJ7Qgk7f
         ES9nV87kitGQ+zG7fXfH8MBuoWxATEsNGhzdirzdUKL1hp434emNZulUkTp2GFomnLAl
         yevqpngW29bjc7CtNlAt3U4paONKkD2ypF74dQ/SkVVINZkClzU+Zjj9CCkrpvjzWBsj
         y5+A==
X-Gm-Message-State: AOJu0YwT33muF7KxiZ7g07E0tGmtti7xk2aWkKaklmnDi2PJZnZCrxJS
        TheIiWHTe1hyWcoRFEhb5CUD+Q==
X-Google-Smtp-Source: AGHT+IFzz6+B5OKe9dHaMHtROHjdT+of6Br718R8Aq13I6lpQoCwBt1c/60xCps1YzrgztPc4tY0Ig==
X-Received: by 2002:a17:902:ea0b:b0:1c3:9928:7b28 with SMTP id s11-20020a170902ea0b00b001c399287b28mr7149415plg.6.1694792722551;
        Fri, 15 Sep 2023 08:45:22 -0700 (PDT)
Received: from ghost ([50.168.177.76])
        by smtp.gmail.com with ESMTPSA id u6-20020a170902b28600b001b672af624esm3640532plr.164.2023.09.15.08.45.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 08:45:22 -0700 (PDT)
Date:   Fri, 15 Sep 2023 11:45:19 -0400
From:   Charlie Jenkins <charlie@rivosinc.com>
To:     David Laight <David.Laight@aculab.com>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Conor Dooley <conor@kernel.org>,
        Samuel Holland <samuel.holland@sifive.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Subject: Re: [PATCH v5 1/4] asm-generic: Improve csum_fold
Message-ID: <ZQR8DyY2wlHE1QHZ@ghost>
References: <20230914-optimize_checksum-v5-0-c95b82a2757e@rivosinc.com>
 <20230914-optimize_checksum-v5-1-c95b82a2757e@rivosinc.com>
 <b6bd38541255470b97bbaf3e6cdb4265@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b6bd38541255470b97bbaf3e6cdb4265@AcuMS.aculab.com>
X-Spam-Status: No, score=1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_SBL_CSS,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 15, 2023 at 07:29:23AM +0000, David Laight wrote:
> From: Charlie Jenkins
> > Sent: 15 September 2023 04:50
> > 
> > This csum_fold implementation introduced into arch/arc by Vineet Gupta
> > is better than the default implementation on at least arc, x86, arm, and
> > riscv. Using GCC trunk and compiling non-inlined version, this
> > implementation has 41.6667%, 25%, 16.6667% fewer instructions on
> > riscv64, x86-64, and arm64 respectively with -O3 optimization.
> 
> Nit-picking the commit message...
> Some of those architectures have their own asm implementation.
> The arm one is better than the C code below, the x86 ones aren't.
I can clean up the commit message to be more accurate.
> 
> I think that only sparc32 (carry flag but no rotate) and
> arm/arm64 (barrel shifter on every instruction) have versions
> that are better than the one here.
> 
> Since I suggested it to Charlie:
> 
> Reviewed-by: David Laight <david.laight@aculab.com>
> 
> > 
> > Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> > ---
> >  include/asm-generic/checksum.h | 5 +----
> >  1 file changed, 1 insertion(+), 4 deletions(-)
> > 
> > diff --git a/include/asm-generic/checksum.h b/include/asm-generic/checksum.h
> > index 43e18db89c14..adab9ac4312c 100644
> > --- a/include/asm-generic/checksum.h
> > +++ b/include/asm-generic/checksum.h
> > @@ -30,10 +30,7 @@ extern __sum16 ip_fast_csum(const void *iph, unsigned int ihl);
> >   */
> >  static inline __sum16 csum_fold(__wsum csum)
> >  {
> > -	u32 sum = (__force u32)csum;
> 
> You'll need to re-instate that line to stop sparse complaining.

I will add that back, thanks.

- Charlie
> 
> > -	sum = (sum & 0xffff) + (sum >> 16);
> > -	sum = (sum & 0xffff) + (sum >> 16);
> > -	return (__force __sum16)~sum;
> > +	return (__force __sum16)((~csum - ror32(csum, 16)) >> 16);
> >  }
> >  #endif
> > 
> > 
> > --
> > 2.42.0
> 
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> Registration No: 1397386 (Wales)
