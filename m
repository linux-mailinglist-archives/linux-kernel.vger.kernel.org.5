Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F1A07A2053
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 16:00:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235412AbjIOOAU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 10:00:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234618AbjIOOAS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 10:00:18 -0400
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.167])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 689111FC9;
        Fri, 15 Sep 2023 07:00:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1694786408; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=asMdek7bCDmutDcPy9V8xVeg2ougTliZc42QuQZ91ba/7byS0WDBMJ2C6WUeA4fGx1
    ULmH8DENnrvWI0Axqm4Xxldg5BZFPUhJiKAB8z5NDq1bsK4oOskRSuY/dPCD768jbLmn
    5dkwPmolVIi5O+TkMSGpxMU02b3lb9jmzFXRDZtL8Vv+250bASTsvHIc9uKl7BgCcl32
    7AqZlgykHES74YYGuHsUB6k4so7H1aFMjsVxCkGSEuWSBAOqZZ05JuEj0OzrJz/8vhfs
    mSzr/q5prnl5JUNkM7KdT7W4GZO5LT1C7TdwgejtB5maRdoMJJKIvsVhZIV9YzQaN4RV
    vY+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1694786408;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=HtbQRTxZWQ5OD+fZsR5DoNgw/jvevRClqbJXoD2DrIs=;
    b=r6H6ysR1nYM6Bc8IYvjYrWAvIvhwhXE5zsKJ/TJQRBnczks0+qs1/pUIVHKGTj7sn8
    hnNVuzhVoxLTb7LazVhQXIlIvmwaYwDOrD7aAXhK9V69qLEphOnlfTPl9sRRjKtIidK2
    h8e6Uy3n1cYsPiVb2TqPnM8+iIk2ZKKdiOuKaU8uS+ZUfijC2+IBI0Kz/7k2Fd6lJnTm
    AH+G/nsVyPS5Ai2UMN0BSPkrx3wRtw8oFVRJHXwGUsR13Jkaw4WbP7kCgoCGijm0rQEn
    MLtBOAc0ZWlbTsogy3QarXqr1ygDts4ZvL1t1FMfpUgCapL8vam8PxSqmxTlaT8mwzxH
    ZISA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1694786408;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=HtbQRTxZWQ5OD+fZsR5DoNgw/jvevRClqbJXoD2DrIs=;
    b=NnlCs4AGnpfda2I0HU+33XVVG6JGT4fCGdxJ+Pmgt4o6QlnGey8dfFD+nwJpcZmcN4
    rSvvi+/iVlMqHixs/7rYX91M2jVblgcSDVwaG2w1RIj1LLo4WJ5BzZcT4MixC0oPu+sN
    PO0JFyyFplVlNyWJW4OhzzoFKBk1YfAooLa8pnFqKaETmGZHUK6hVmkxKUqfjbZVvXJH
    8lLLXnH048hloWol8sAb8CzCfkc/Zg8JJHPt9m8kWiu3aJc2a8Uhg8bsB5LyCIvE+751
    KguTkDMouFB+Fzqvdqx1j8LO4Hz22Y5AuaSxdMyle45NZ2dmvKvYlgE8wXLTnppjW8KY
    ypYA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1694786408;
    s=strato-dkim-0003; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=HtbQRTxZWQ5OD+fZsR5DoNgw/jvevRClqbJXoD2DrIs=;
    b=swuCRrrJEqjG5fbn9+9dNI+h0JYa6BnNAzyAOIV+xGs2Kig460sYKpBeAmvIXNgwIf
    ZL0oDGE0g/5AYcccTuCw==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u261EJF5OxJD4paA8piJ1A=="
Received: from gerhold.net
    by smtp.strato.de (RZmta 49.8.2 DYNA|AUTH)
    with ESMTPSA id R04c57z8FE0880Z
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Fri, 15 Sep 2023 16:00:08 +0200 (CEST)
Date:   Fri, 15 Sep 2023 16:00:02 +0200
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/9] arm64: dts: qcom: msm8916: Reserve firmware memory
 dynamically
Message-ID: <ZQRjYhepSCYCB2XC@gerhold.net>
References: <20230911-msm8916-rmem-v1-0-b7089ec3e3a1@gerhold.net>
 <20230911-msm8916-rmem-v1-4-b7089ec3e3a1@gerhold.net>
 <912f90ee-0816-43ae-bc6f-a9a9a3e33d8a@linaro.org>
 <9b1beb38-9ec2-4bdb-97f5-fccf98d3b0c3@linaro.org>
 <ZQGLioVhjCK3TRva@gerhold.net>
 <568b4e18-1ade-4a12-9766-d16d8ca9838d@linaro.org>
 <ZQMUDia6cYA0mGmL@gerhold.net>
 <9ad1264f-efb5-40b5-bd7a-1477e86501a1@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9ad1264f-efb5-40b5-bd7a-1477e86501a1@linaro.org>
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 15, 2023 at 03:52:36PM +0200, Konrad Dybcio wrote:
> On 14.09.2023 16:09, Stephan Gerhold wrote:
> > On Wed, Sep 13, 2023 at 09:39:50PM +0200, Konrad Dybcio wrote:
> >> On 13.09.2023 12:14, Stephan Gerhold wrote:
> >>> On Wed, Sep 13, 2023 at 10:12:12AM +0100, Bryan O'Donoghue wrote:
> >>>> On 13/09/2023 10:06, Konrad Dybcio wrote:
> >>>>> On 11.09.2023 19:41, Stephan Gerhold wrote:
> >>>>>> Most of the reserved firmware memory on MSM8916 can be relocated when
> >>>>>> respecting the required alignment. To avoid having to precompute the
> >>>>>> reserved memory regions in every board DT, describe the actual
> >>>>>> requirements (size, alignment, alloc-ranges) using the dynamic reserved
> >>>>>> memory allocation.
> >>>>>>
> >>>>>> This approach has several advantages:
> >>>>>>
> >>>>>>   1. We can define "templates" for the reserved memory regions in
> >>>>>>      msm8916.dtsi and keep only device-specific details in the board DT.
> >>>>>>      This is useful for the "mpss" region size for example, which varies
> >>>>>>      from device to device. It is no longer necessary to redefine all
> >>>>>>      firmware regions to shift their addresses.
> >>>>>>
> >>>>>>   2. When some of the functionality (e.g. WCNSS, Modem, Venus) is not
> >>>>>>      enabled or needed for a device, the reserved memory can stay
> >>>>>>      disabled, freeing up the unused reservation for Linux.
> >>>>>>
> >>>>>>   3. Devices with special requirements for one of the firmware regions
> >>>>>>      are handled automatically. For example, msm8916-longcheer-l8150
> >>>>>>      has non-relocatable "wcnss" firmware that must be loaded exactly
> >>>>>>      at address 0x8b600000. When this is defined as a static region,
> >>>>>>      the other dynamic allocations automatically adjust to a different
> >>>>>>      place with suitable alignment.
> >>>>>>
> >>>>>> All in all this approach significantly reduces the boilerplate necessary
> >>>>>> to define the different firmware regions, and makes it easier to enable
> >>>>>> functionality on the different devices.
> >>>>>>
> >>>>>> Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
> >>>>>> ---
> >>>>> [...]
> >>>>>
> >>>>>>   		mpss_mem: mpss@86800000 {
> >>>>>> +			/*
> >>>>>> +			 * The memory region for the mpss firmware is generally
> >>>>>> +			 * relocatable and could be allocated dynamically.
> >>>>>> +			 * However, many firmware versions tend to fail when
> >>>>>> +			 * loaded to some special addresses, so it is hard to
> >>>>>> +			 * define reliable alloc-ranges.
> >>>>>> +			 *
> >>>>>> +			 * alignment = <0x0 0x400000>;
> >>>>>> +			 * alloc-ranges = <0x0 0x86800000 0x0 0x8000000>;
> >>>>>> +			 */
> >>>>> Do we know of any devices that this would actually work on?
> >> [...]
> >>>  - On DB410c it works just fine. All addresses I tried work without any
> >>>    problems.
> >>>
> >>>  - On longcheer-l8150 the modem firmare works fine when the memory
> >>>    region starts somewhere between 0x86800000 and 0x8a800000. It also
> >>>    works again after 0x8e800000. But on anything between 0x8a800000 and
> >>>    0x8e800000 it's broken for who knows what reason.
> >>> [...]
> >> Were you able to find a phone (likely a very reference-design-based
> >> one) that this worked on, btw?
> > 
> > Actually I would count the Longcheer devices (l8150 = Wileyfox Swift and
> > l8910 = BQ Aquaris X5) to the category of close-to-QRD-based devices.
> > Based on quick tests both behave like described above (only
> > 0x8a800000-0x8e800000 is broken). Same for wingtech-wt88047.
> > 
> > In other words, for those using the dynamic allocation would work fine,
> > because the alloc-ranges = <0x0 0x86800000 0x0 0x8000000>; only includes
> > working start addresses from 0x86800000 to ~0x89800000 (with a size of
> > 0x5000000).
> > 
> > I guess I could use it for them and only make other devices use a fixed
> > address. But I also don't quite have the capacity to test every device
> > to see if relocating the region works or not.
> > 
> > I think it's still easiest to allocate mpss on a fixed address
> > everywhere. The only real disadvantage is that overriding "reg", e.g.
> > 
> > 	&mpss_mem {
> > 		reg = <0x0 0x86800000 0x0 0x5100000>;
> > 	};
> > 
> > is a bit more ugly than overriding size:
> > 
> > 	&mpss_mem {
> > 		size = <0x0 0x5100000>;
> > 	};
> > 
> > but well, this is a very minor disadvantage.
> So in other words, this only *really* works on apq8016?
> 

Hm no? As I wrote, with alloc-ranges = <0x0 0x86800000 0x0 0x8000000> it
also works on the close-to-QRD MSM8916 devices. There are some addresses
that don't work but those might also exist on APQ8016. I haven't tested
placing the firmware all over RAM on all sorts of obscure addresses (and
there is probably little advantage doing so).

With the limited alloc-ranges it would likely work on all devices that
are close to the reference design/firmware from Qualcomm.

Thanks,
Stephan
