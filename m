Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DFD479DE79
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 05:10:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235893AbjIMDKJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 23:10:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231181AbjIMDKG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 23:10:06 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD719170E
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 20:09:51 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id 98e67ed59e1d1-2740f8d73aeso2412716a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 20:09:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1694574591; x=1695179391; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8Pf7pTuUGrfS3QfAFTCC6m/hHffMqkAAMnuVf+s/49s=;
        b=QZIHmIgCZ6f4BhJ7kkc7w9nwkefUydaKLIvCzRibASi1MP2IpETq+K48Z/NxhsxYeo
         HLEZkermQg0gdLhU6LL/FB2xI3076jQx3rZVPKE3j2qpnZNtL/nRLwmRqMIoaJaFiw4z
         wPQExOrgfNpOXTsXp+IoEK8ZFvaANuxI6VB/qNFCMmA+4F3Tz7OhpHWZJFQSgzKINLPI
         TGU0qq4673zAOvL7JAT9YIb235nh8RlpL7GqDm4mSCMHqeCHIsAWZzpinySGY1KrkOPh
         YesruQeuytiVaZiSGgpknCe3T0qRNiNi2QocNIeRuQ7sRBBTCA+zSfrrxK1WHXlg4cBR
         lMNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694574591; x=1695179391;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8Pf7pTuUGrfS3QfAFTCC6m/hHffMqkAAMnuVf+s/49s=;
        b=RLLwytfGYlppOnkhwB+gC8YFlletIGhA6J12M1ynosW8RagWIvEqhuG1uVsVJS2TZ7
         kQZCDuWAmgU7UmKj/GuBzGSPq6ZU6WkQ0rSm5qrHNd1H8SvJ4nBbUOkiowwQjHHUdIRH
         atpfWdu9omYOOcK5riwyHCg+XMiL5Hh2u4abjrpX09SMs2iZiWKFV0sfBlxkoMLlSn+T
         azPm8dTeJhgwEikUH0CvkOKwEFE0WoyU2pqsdkotXVLkEcz7B97SFHLdMWnWPbYMVsVo
         P+Ub+uJqPOrNHpvhELvbrPwXt+AWQWLW0T5jCfvjkrNXVDnGHK2s376HhRKlulXK/Nso
         NyWg==
X-Gm-Message-State: AOJu0Yxxhv4gDMNgJkysqx1nM7dEzKLccK6Bc+TLsJNFTFSUEeDD2u/X
        7o7Vc3Actf3/58Y1j9ZVeNqCnA==
X-Google-Smtp-Source: AGHT+IFHQ29VVzv/3z2zxjYAkgPTTSd7MOKanaKnrXStCrAsFSBQwNstzkKsyq5oK02IXkEjSYHhKA==
X-Received: by 2002:a17:90a:668f:b0:274:1f99:290 with SMTP id m15-20020a17090a668f00b002741f990290mr986168pjj.34.1694574591042;
        Tue, 12 Sep 2023 20:09:51 -0700 (PDT)
Received: from ghost ([50.168.177.76])
        by smtp.gmail.com with ESMTPSA id fv23-20020a17090b0e9700b002740e66851asm333095pjb.35.2023.09.12.20.09.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 20:09:50 -0700 (PDT)
Date:   Tue, 12 Sep 2023 20:09:47 -0700
From:   Charlie Jenkins <charlie@rivosinc.com>
To:     David Laight <David.Laight@aculab.com>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Conor Dooley <conor@kernel.org>,
        Samuel Holland <samuel.holland@sifive.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Subject: Re: [PATCH v4 2/5] riscv: Add checksum library
Message-ID: <ZQEn+8Bi8dxNgg3g@ghost>
References: <20230911-optimize_checksum-v4-0-77cc2ad9e9d7@rivosinc.com>
 <20230911-optimize_checksum-v4-2-77cc2ad9e9d7@rivosinc.com>
 <1818c4114b0e4144a9df21f235984840@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1818c4114b0e4144a9df21f235984840@AcuMS.aculab.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 12, 2023 at 08:45:38AM +0000, David Laight wrote:
> From: Charlie Jenkins
> > Sent: 11 September 2023 23:57
> > 
> > Provide a 32 and 64 bit version of do_csum. When compiled for 32-bit
> > will load from the buffer in groups of 32 bits, and when compiled for
> > 64-bit will load in groups of 64 bits. Benchmarking by proxy compiling
> > csum_ipv6_magic (64-bit version) for an x86 chip as well as running
> > the riscv generated code in QEMU, discovered that summing in a
> > tree-like structure is about 4% faster than doing 64-bit reads.
> > 
> ...
> > +	sum   = saddr->s6_addr32[0];
> > +	sum  += saddr->s6_addr32[1];
> > +	sum1  = saddr->s6_addr32[2];
> > +	sum1 += saddr->s6_addr32[3];
> > +
> > +	sum2  = daddr->s6_addr32[0];
> > +	sum2 += daddr->s6_addr32[1];
> > +	sum3  = daddr->s6_addr32[2];
> > +	sum3 += daddr->s6_addr32[3];
> > +
> > +	sum4  = csum;
> > +	sum4 += ulen;
> > +	sum4 += uproto;
> > +
> > +	sum  += sum1;
> > +	sum2 += sum3;
> > +
> > +	sum += sum2;
> > +	sum += sum4;
> 
> Have you got gcc to compile that as-is?
> 
> Whenever I've tried to get a 'tree add' compiled so that the
> early adds can be executed in parallel gcc always pessimises
> it to a linear sequence of adds.
> 
> But I agree that adding 32bit values to a 64bit register
> may be no slower than trying to do an 'add carry' sequence
> that is guaranteed to only do one add/clock.
> (And on Intel cpu from core-2 until IIRC Haswell adc took 2 clocks!)
> 
> IIRC RISCV doesn't have a carry flag, so the adc sequence
> is hard - probably takes two extra instructions per value.
> Although with parallel execute it may not matter.
> Consider:
> 	val = buf[offset];
> 	sum += val;
> 	carry += sum < val;
> 	val = buf[offset1];
> 	sum += val;
> 	...
> the compare and 'carry +=' can be executed at the same time
> as the following two instructions.
> You do then a final sum += carry; sum += sum < carry;
> 
> Assuming all instructions are 1 clock and any read delays
> get filled with other instructions (by source or hardware
> instruction re-ordering) even without parallel execute
> that is 4 clocks for 64 bits, which is much the same as the
> 2 clocks for 32 bits.
> 
> Remember that all the 32bit values can summed first as
> they won't overflow.
> 
> 	David
> 
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> Registration No: 1397386 (Wales)
Yeah it does seem like the tree-add does just do a linear add. All three
of them were pretty much the same on riscv so I used the version that
did best on x86 with the knowledge that my QEMU setup does not
accurately represent real hardware.

I don't quite understand how doing the carry in the middle of each
stage, even though it can be executed at the same time, would be faster
than just doing a single overflow check at the end. I can just revert
back to the non-tree add version since there is no improvement on riscv.
I can also revert back to the default version that uses carry += sum < val
as well.

- Charlie

