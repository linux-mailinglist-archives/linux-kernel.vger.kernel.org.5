Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F4A07A06ED
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 16:09:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239766AbjINOJh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 10:09:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239724AbjINOJg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 10:09:36 -0400
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EE89DF;
        Thu, 14 Sep 2023 07:09:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1694700569; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=ECLa/iHpIzlyQADfvAVjpjAHb1awJ9StlaEXiaobB3JIdM1a4GUSND4YJYWJBPNGwR
    hrwqEPXmUZt4bibYgVIs7YnUMjjYSVwkOPzKQoM/etytRJ4YShrBUZPY/mflT+MsZYvn
    ChVQYoZly5Kkcs/lFCum9Q/fv0WbcOdY7gh4LV/ua0ZZS6REr+D2LVziwxyKHMXnvz0H
    HLXy5i6et4oRsbFMJMvDzwAaz32WVUDv83jRe9NepkUgxFyG1E7ZEMHrkpnDHWBxXBCn
    l621AxGE0YTQfkrX3IfB8cs6JC+C9weeWXiGKgSLdWk4EgldsbtGyzi9ySXHiFOIMdYe
    HS1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1694700569;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=Jd84c8VCl84O/X9LEKWHRrmMX+GqRKSgI/d7fqGsbbA=;
    b=gcH5zWtdkG7/49Jc58d3hNdcfi8OvFZZSXgAoQNlWV27kLJnLY7Vtg2s8AfKO9t6YI
    K4W5M98yRErJum5bpJp2j0Q9R2fUFWX59AyrH+pUM8JmJFEfoUlnbIXd7FyvdKm5itCm
    Tsp7Ej/TZ8XfgNPpMUpgWqzXG3LTnjGJfLhMRsN2g6LYWM2S6qOeV+iGo5YZoPFjuEjo
    T7vt+gueNYKp9RwP8sRpUT2it36KdbytjzffNhqXu9Qx1hH+QLjYVSjo52llUOPTYyZT
    ja98zf3w8Ft7S6/7wVqiSYMQUTsZdd5blyhTIKpJAs387wUjMbIOS2VBCGqS3HoXiSL0
    ToLw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1694700569;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=Jd84c8VCl84O/X9LEKWHRrmMX+GqRKSgI/d7fqGsbbA=;
    b=OCmbhFhTcMki8DZuV5mKGQPIclWAc7xMHZe785354ILcIz2tXydZ+dg+YaKRpgZb8Q
    EnimhNLOqgph6ByCK/78wZO9pRLvk9p35WimNkjGIgQVb2qNGSgUIAIQs0OogN+KfXWJ
    Syv0ElFqF+3is1f5fCgs2slH5pxEnk+LJPIlrby5pSbacFlXhxLQ0MAG+PoRSZjVmPHi
    d1hCgMT7SxdN1MtgvYEYypXHkgXis2FM96rePqWBU2xX8JwPU0RpNP4ylm4Dhg7Lc6gi
    8hpJL11/1ntTX662Pl8xCOv4fgR9tV3lL8OC3X+eQpQ3qVGx9UfKtXJ676iDihpbGHhX
    Rcxw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1694700569;
    s=strato-dkim-0003; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=Jd84c8VCl84O/X9LEKWHRrmMX+GqRKSgI/d7fqGsbbA=;
    b=Q4mPF6ZxHdSrbpH757k/hUpbtKmpalM7zTUSBR1Wx2XHTvqA01GsNSK82g1jl2e8Uf
    jJUYh9lLf+gePq50wZBg==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u261EJF5OxJD4paA95vh"
Received: from gerhold.net
    by smtp.strato.de (RZmta 49.8.2 DYNA|AUTH)
    with ESMTPSA id R04c57z8EE9T47Q
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Thu, 14 Sep 2023 16:09:29 +0200 (CEST)
Date:   Thu, 14 Sep 2023 16:09:22 +0200
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/9] arm64: dts: qcom: msm8916: Reserve firmware memory
 dynamically
Message-ID: <ZQMUDia6cYA0mGmL@gerhold.net>
References: <20230911-msm8916-rmem-v1-0-b7089ec3e3a1@gerhold.net>
 <20230911-msm8916-rmem-v1-4-b7089ec3e3a1@gerhold.net>
 <912f90ee-0816-43ae-bc6f-a9a9a3e33d8a@linaro.org>
 <9b1beb38-9ec2-4bdb-97f5-fccf98d3b0c3@linaro.org>
 <ZQGLioVhjCK3TRva@gerhold.net>
 <568b4e18-1ade-4a12-9766-d16d8ca9838d@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <568b4e18-1ade-4a12-9766-d16d8ca9838d@linaro.org>
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 13, 2023 at 09:39:50PM +0200, Konrad Dybcio wrote:
> On 13.09.2023 12:14, Stephan Gerhold wrote:
> > On Wed, Sep 13, 2023 at 10:12:12AM +0100, Bryan O'Donoghue wrote:
> >> On 13/09/2023 10:06, Konrad Dybcio wrote:
> >>> On 11.09.2023 19:41, Stephan Gerhold wrote:
> >>>> Most of the reserved firmware memory on MSM8916 can be relocated when
> >>>> respecting the required alignment. To avoid having to precompute the
> >>>> reserved memory regions in every board DT, describe the actual
> >>>> requirements (size, alignment, alloc-ranges) using the dynamic reserved
> >>>> memory allocation.
> >>>>
> >>>> This approach has several advantages:
> >>>>
> >>>>   1. We can define "templates" for the reserved memory regions in
> >>>>      msm8916.dtsi and keep only device-specific details in the board DT.
> >>>>      This is useful for the "mpss" region size for example, which varies
> >>>>      from device to device. It is no longer necessary to redefine all
> >>>>      firmware regions to shift their addresses.
> >>>>
> >>>>   2. When some of the functionality (e.g. WCNSS, Modem, Venus) is not
> >>>>      enabled or needed for a device, the reserved memory can stay
> >>>>      disabled, freeing up the unused reservation for Linux.
> >>>>
> >>>>   3. Devices with special requirements for one of the firmware regions
> >>>>      are handled automatically. For example, msm8916-longcheer-l8150
> >>>>      has non-relocatable "wcnss" firmware that must be loaded exactly
> >>>>      at address 0x8b600000. When this is defined as a static region,
> >>>>      the other dynamic allocations automatically adjust to a different
> >>>>      place with suitable alignment.
> >>>>
> >>>> All in all this approach significantly reduces the boilerplate necessary
> >>>> to define the different firmware regions, and makes it easier to enable
> >>>> functionality on the different devices.
> >>>>
> >>>> Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
> >>>> ---
> >>> [...]
> >>>
> >>>>   		mpss_mem: mpss@86800000 {
> >>>> +			/*
> >>>> +			 * The memory region for the mpss firmware is generally
> >>>> +			 * relocatable and could be allocated dynamically.
> >>>> +			 * However, many firmware versions tend to fail when
> >>>> +			 * loaded to some special addresses, so it is hard to
> >>>> +			 * define reliable alloc-ranges.
> >>>> +			 *
> >>>> +			 * alignment = <0x0 0x400000>;
> >>>> +			 * alloc-ranges = <0x0 0x86800000 0x0 0x8000000>;
> >>>> +			 */
> >>> Do we know of any devices that this would actually work on?
> [...]
> >  - On DB410c it works just fine. All addresses I tried work without any
> >    problems.
> > 
> >  - On longcheer-l8150 the modem firmare works fine when the memory
> >    region starts somewhere between 0x86800000 and 0x8a800000. It also
> >    works again after 0x8e800000. But on anything between 0x8a800000 and
> >    0x8e800000 it's broken for who knows what reason.
> > [...]
> Were you able to find a phone (likely a very reference-design-based
> one) that this worked on, btw?

Actually I would count the Longcheer devices (l8150 = Wileyfox Swift and
l8910 = BQ Aquaris X5) to the category of close-to-QRD-based devices.
Based on quick tests both behave like described above (only
0x8a800000-0x8e800000 is broken). Same for wingtech-wt88047.

In other words, for those using the dynamic allocation would work fine,
because the alloc-ranges = <0x0 0x86800000 0x0 0x8000000>; only includes
working start addresses from 0x86800000 to ~0x89800000 (with a size of
0x5000000).

I guess I could use it for them and only make other devices use a fixed
address. But I also don't quite have the capacity to test every device
to see if relocating the region works or not.

I think it's still easiest to allocate mpss on a fixed address
everywhere. The only real disadvantage is that overriding "reg", e.g.

	&mpss_mem {
		reg = <0x0 0x86800000 0x0 0x5100000>;
	};

is a bit more ugly than overriding size:

	&mpss_mem {
		size = <0x0 0x5100000>;
	};

but well, this is a very minor disadvantage.

Thanks,
Stephan
