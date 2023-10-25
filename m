Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D1B17D766C
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 23:11:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230162AbjJYVLy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 17:11:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbjJYVLw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 17:11:52 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC1E112A
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 14:11:49 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id 46e09a7af769-6c7c2c428c1so650694a34.0
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 14:11:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1698268309; x=1698873109; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vvbiAXR+3VKhNIamhbP5xxZpWhK78+hpTb+9JSqRlGg=;
        b=nvQrVEzmmYXghmwAo0bUmrf14IegRxYqpJnacGqGbH462cekhTO7o31RAQcT1ySrhQ
         o+cpU4aDhSkcIbldBOPj9os1C9UMs0pGk83LZ/slH7BMhS9GFX3EbCWauFCVdm9Gyz/x
         6dPdecuBZ59Q6xywY2PseK1T4Jeo842pZdfMkTr4Jox5tbvVxSqLAfoWMxhn0M3akRxz
         pGIXWysq1TtVBH70GaFpmWnQIKZKzlGQhLV6tGWyRPJJEyqGDMMB81BH8AwTG5l1FM83
         mMGe3rdlPL3+2Nr3m1JYoY+whcT0KRTPagJoKoP8cfy3pGtbe2WfNx2zotbUYuofeaMb
         Pusg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698268309; x=1698873109;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vvbiAXR+3VKhNIamhbP5xxZpWhK78+hpTb+9JSqRlGg=;
        b=b4iMglA/cz1TuI/Lkkge5kNG4O6GUGq+0Cy7qwfLc8G4tFUvhb5+v+046YjVq1QHzi
         SmVtb/dqJvc7jQK//5cOg4Nea0rLfb7p82vsMO1Sq3euODRgXKOFo1DNFtrHbybiZRXA
         aD3lWEtx1Dgqnx3H4GfJX4mHoXh99d0un3yifpp1U0Ir07VXBcUC7grtCfBcQguYV3sM
         RpP/cIJgd3J0Q/UDE/isSzQWuukrRwu0N93FlSSaZu0ZzEYdAH9qFccWcjW7sP/9AFFu
         VR6ibwLUYFElI8QW8qan8+tN8dafxgvQPymqnOa+sLF8CmgBmLApozFGU5uii0XCAVRT
         PLIg==
X-Gm-Message-State: AOJu0Ywx7KQI1mwCxhh1XeL2FYxiuBod4pSSuxFycp9EHJcjSBVvF20S
        AsOA/8wlCdqHYeUtU3qhL33FaQ==
X-Google-Smtp-Source: AGHT+IFoPbLj21nNX14WA1MId9RviICvQbQvwuMrq6I5HACQKpRbIKPLDice73bnzAn5gIazBDjylQ==
X-Received: by 2002:a05:6808:10d6:b0:3af:63ac:2f96 with SMTP id s22-20020a05680810d600b003af63ac2f96mr532334ois.6.1698268309130;
        Wed, 25 Oct 2023 14:11:49 -0700 (PDT)
Received: from ghost ([208.116.208.98])
        by smtp.gmail.com with ESMTPSA id bm23-20020a0568081a9700b003af638fd8e4sm2540029oib.55.2023.10.25.14.11.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 14:11:48 -0700 (PDT)
Date:   Wed, 25 Oct 2023 14:11:45 -0700
From:   Charlie Jenkins <charlie@rivosinc.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     "Wang, Xiao W" <xiao.w.wang@intel.com>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Conor Dooley <conor@kernel.org>,
        David Laight <David.Laight@aculab.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>
Subject: Re: [PATCH v7 2/4] riscv: Checksum header
Message-ID: <ZTmEkYn1NcUvL58n@ghost>
References: <20230919-optimize_checksum-v7-0-06c7d0ddd5d6@rivosinc.com>
 <20230919-optimize_checksum-v7-2-06c7d0ddd5d6@rivosinc.com>
 <DM8PR11MB575134C301E7E17E72281CFAB8DEA@DM8PR11MB5751.namprd11.prod.outlook.com>
 <ZTl8gauEst2NGrw6@ghost>
 <059f17e6-e240-40fa-8742-7844ad3b3502@app.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <059f17e6-e240-40fa-8742-7844ad3b3502@app.fastmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 25, 2023 at 10:52:22PM +0200, Arnd Bergmann wrote:
> On Wed, Oct 25, 2023, at 22:37, Charlie Jenkins wrote:
> > On Wed, Oct 25, 2023 at 06:50:05AM +0000, Wang, Xiao W wrote:
> 
> >> > +
> >> > +/*
> >> > + * Quickly compute an IP checksum with the assumption that IPv4 headers
> >> > will
> >> > + * always be in multiples of 32-bits, and have an ihl of at least 5.
> >> > + * @ihl is the number of 32 bit segments and must be greater than or equal
> >> > to 5.
> >> > + * @iph is assumed to be word aligned.
> >> 
> >> Not sure if the assumption is always true. It looks the implementation in "lib/checksum.c" doesn't take this assumption.
> >> The ip header can comes after a 14-Byte ether header, which may start from a word-aligned or DMA friendly address.
> >
> > While lib/checksum.c does not make this assumption, other architectures
> > (x86, ARM, powerpc, mips, arc) do make this assumption. Architectures
> > seem to only align the header on a word boundary in do_csum. I worry
> > that the benefit of aligning iph in this "fast" csum function would
> > disproportionately impact hardware that has fast misaligned accesses.
> 
> Most architectures set NET_IP_ALIGN to '2', which is intended
> to have the IP header at a 32-bit aligned address, though
> some other targets don't bother:
> 
> arch/arm64/include/asm/processor.h:#define NET_IP_ALIGN 0
> arch/powerpc/include/asm/processor.h:#define NET_IP_ALIGN       0
> arch/x86/include/asm/processor.h:#define NET_IP_ALIGN   0
> include/linux/skbuff.h:#define NET_IP_ALIGN     2
> 
> I think it's considered a driver bug if an SKB ends up
> with a misaligned IP header, but it's also something that
> some of the more obscure drivers get wrong.
> 
>     Arnd

Thank you for pointing that out, I had not realized that macro existed.
Since riscv keeps NET_IP_ALIGN at 0 it should be expected that
ip_fast_csum is only called with 32-bit aligned addresses. I will update
the comment and refer to that macro. riscv supports misaligned accesses
but there are no guarantees of speed.

- Charlie

