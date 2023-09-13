Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 401AF79E4A4
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 12:14:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239625AbjIMKOt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 06:14:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239536AbjIMKOr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 06:14:47 -0400
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 152CA19A9;
        Wed, 13 Sep 2023 03:14:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1694600081; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=lCIuN2PlVT5HDLZOFxnq6P5CJz3HrTVmnZC4aO0u7GlTwvC6wlgPdDaXarO5hEAvUP
    MZInFcXNh5SkJn8hggTI4Hdr8jySmaonXJDe82hUsczK5MFL29qB0qbe/7+os79KLj6+
    em45M4kbhwGWYuRMCDJtzg+rk112dr4bavHrla+bwZCsv5vVhvaYcUzGi6Sk5yvgXbLX
    niuL34f3UOVasmjn8oD2rQ82SBQdTTYTbRmlMb2soKkYyBEHDWpW1iOmWpxocQbEHT3S
    4zZoM+RFNmlqnKlMHsUDYxIkWtH0Z27xc4lzGUKBH0djtgITpMa/9t8aEXmUBNpxVm7S
    cVtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1694600081;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=4TrT2WOHy3wT/9UuqDgfHvXjpnKQcLSFiiLgz13mjFE=;
    b=UVwZA1hK7hpvcu0vTZ+s8GHZznTuH/s/i85nrWQH9pDUmvQ3lutA7x8LBds+/2d1oM
    yBr85vGQ0glWLxXQ2PBrynsxF6MgjDju9xtjUwhB5OsDRTn+UeHRDIqHRM+b69LaQMMu
    Pfsuk2PDa9wINUnxJ3srCnpoNObspG+jj5VVZ3Y7A2HzcrJBDujGk+wUnalaWVLY5Iil
    1slU61xbI2ytT8yCxI5Uf/2h1Cz+avL06PI1LNUMi+8gKUTMkkrQk1FgQRJekC8qgU83
    LQ6ywXuYzY249oCnE2wykyHIqDzDWmymBywFbHGxJwfcw3f6SOeq2A5tUtyMvpOQ7GZh
    7x7w==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1694600081;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=4TrT2WOHy3wT/9UuqDgfHvXjpnKQcLSFiiLgz13mjFE=;
    b=cc0qdML+eisNqhEZZDq4x/QWJua4EbWgM2qdYvDc7cr4kbt2IC/1zmsMJH/IidAUm+
    GRB6CebL7HoiZVWy+Eukvn8I9DmqZppOptVbrr5qJzBxL6FdwpcVIEA2azkIiXbtHv5O
    bvkpTlVwYY6MBZqPOeIQzS16t+zwEdghF7nqtQ6scKySDEyQVLq2sNNOoyQbkEemTZ0+
    JPAZGnz/7EXr8tDNdzhsuy9pY4lzvWHsdFl2cKxxpvRc6SF1sMF7H53DawNjiqdGglQ6
    EqqFz9EHciyabvi+FQvCrX9vNycVxE06QSNCAsQ2Cn5Rdi3zBrxw4VmW5W+xYJV0+1AK
    YV4A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1694600081;
    s=strato-dkim-0003; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=4TrT2WOHy3wT/9UuqDgfHvXjpnKQcLSFiiLgz13mjFE=;
    b=npksid5vFULF2mlG7Fin7kKNpUoIPFbe+Re8ZAv87CwQ0GNFdkcoWuJIKK+WO8+/+c
    H68z4BQ03S+aXY1r/YDw==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u261EJF5OxJD4peA8Z/h"
Received: from gerhold.net
    by smtp.strato.de (RZmta 49.8.2 DYNA|AUTH)
    with ESMTPSA id 60372az8DAEegt4
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Wed, 13 Sep 2023 12:14:40 +0200 (CEST)
Date:   Wed, 13 Sep 2023 12:14:34 +0200
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/9] arm64: dts: qcom: msm8916: Reserve firmware memory
 dynamically
Message-ID: <ZQGLioVhjCK3TRva@gerhold.net>
References: <20230911-msm8916-rmem-v1-0-b7089ec3e3a1@gerhold.net>
 <20230911-msm8916-rmem-v1-4-b7089ec3e3a1@gerhold.net>
 <912f90ee-0816-43ae-bc6f-a9a9a3e33d8a@linaro.org>
 <9b1beb38-9ec2-4bdb-97f5-fccf98d3b0c3@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9b1beb38-9ec2-4bdb-97f5-fccf98d3b0c3@linaro.org>
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 13, 2023 at 10:12:12AM +0100, Bryan O'Donoghue wrote:
> On 13/09/2023 10:06, Konrad Dybcio wrote:
> > On 11.09.2023 19:41, Stephan Gerhold wrote:
> > > Most of the reserved firmware memory on MSM8916 can be relocated when
> > > respecting the required alignment. To avoid having to precompute the
> > > reserved memory regions in every board DT, describe the actual
> > > requirements (size, alignment, alloc-ranges) using the dynamic reserved
> > > memory allocation.
> > > 
> > > This approach has several advantages:
> > > 
> > >   1. We can define "templates" for the reserved memory regions in
> > >      msm8916.dtsi and keep only device-specific details in the board DT.
> > >      This is useful for the "mpss" region size for example, which varies
> > >      from device to device. It is no longer necessary to redefine all
> > >      firmware regions to shift their addresses.
> > > 
> > >   2. When some of the functionality (e.g. WCNSS, Modem, Venus) is not
> > >      enabled or needed for a device, the reserved memory can stay
> > >      disabled, freeing up the unused reservation for Linux.
> > > 
> > >   3. Devices with special requirements for one of the firmware regions
> > >      are handled automatically. For example, msm8916-longcheer-l8150
> > >      has non-relocatable "wcnss" firmware that must be loaded exactly
> > >      at address 0x8b600000. When this is defined as a static region,
> > >      the other dynamic allocations automatically adjust to a different
> > >      place with suitable alignment.
> > > 
> > > All in all this approach significantly reduces the boilerplate necessary
> > > to define the different firmware regions, and makes it easier to enable
> > > functionality on the different devices.
> > > 
> > > Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
> > > ---
> > [...]
> > 
> > >   		mpss_mem: mpss@86800000 {
> > > +			/*
> > > +			 * The memory region for the mpss firmware is generally
> > > +			 * relocatable and could be allocated dynamically.
> > > +			 * However, many firmware versions tend to fail when
> > > +			 * loaded to some special addresses, so it is hard to
> > > +			 * define reliable alloc-ranges.
> > > +			 *
> > > +			 * alignment = <0x0 0x400000>;
> > > +			 * alloc-ranges = <0x0 0x86800000 0x0 0x8000000>;
> > > +			 */
> > Do we know of any devices that this would actually work on?

Yes, the "modem" firmware on DB410c seems to be fine with literally all
correctly aligned addresses I've tested so far. But when I manually
experimented with other addresses on actual smartphones it exploded on
certain addresses, specific to the firmware version / device.

> I have the same question here.
> 
> How was this tested ?
> 

Bryan, your question sounds more general, about the dynamic allocation
of the firmware regions in general (also for wcnss etc).

I'll just explain my tests for both with more detail :D

For wcnss/venus a different memory region has been used in postmarketOS
for years because I shifted it early on to make room for the larger
modem firmware. I've never heard of any problems with this on the 50+
different MSM8916-related devices we support there, with many different
firmware versions. When preparing this patch set I experimented some
more and noticed there is a limit (I think around 0x90000000) where TZ
refuses to load/verify the firmware. The alloc-ranges is chosen
conservatively to avoid potential trouble. Also because I didn't see
any use case to have a huge range specified there...

For mpss it's more tricky. First, if you'd comment out the alignment and
alloc-ranges it would most likely work correctly because Linux just
allocates it at the start of the range, on 0x86800000 like it was
before. However, the DT spec doesn't strictly specify where inside the
range the region is allocated, so I manually experimented with some
other addresses within the range:

 - On DB410c it works just fine. All addresses I tried work without any
   problems.

 - On longcheer-l8150 the modem firmare works fine when the memory
   region starts somewhere between 0x86800000 and 0x8a800000. It also
   works again after 0x8e800000. But on anything between 0x8a800000 and
   0x8e800000 it's broken for who knows what reason.

 - On some Samsung devices only 0x86800000 and maybe one or two other
   addresses worked, again for who knows what reason. Most other
   addresses were broken.

The symptom is usually some timeout while starting, the actual signature
verification seems to work fine. I believe that in theory it's supposed
to be relocatable, but in practice they hardcoded some addresses or did
some other funny stuff in some of the firmware versions.

To be safe my conclusion was to keep mpss at a fixed address and only
allocate the others dynamically. This is how the patch implements it.

Thanks,
Stephan
