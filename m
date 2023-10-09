Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 523667BE4D0
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 17:33:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376835AbjJIPdF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 11:33:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376813AbjJIPdD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 11:33:03 -0400
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::228])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 472A9B6;
        Mon,  9 Oct 2023 08:33:01 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id EFD021BF20E;
        Mon,  9 Oct 2023 15:32:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1696865579;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=h5uR8GlJJ9hw2iaAFoYRtX9ssm9ebzBLDOO9Zonebpk=;
        b=om1kJRbEKiWtDDZOeuB6xt10jIol8Hmv8kDDWF+Nrx3Z1QVrg4o8t1iyl2erofrHITSIb1
        pMZT1T8Qffq1tJaKxpFwHkyJX2mdxusc/cvLSqT346nX7NG17kOPraOsW5Q8gDpFfjaSSZ
        3ZnliRx9/ixeQCTzU8GaAhNdpFkjYiFUNzpczwNUPdjCC4IpoGR4YAL8CcXlhiqftIYlwb
        YNaw9XfxF/r0U3U8SuzrbAxJntUY938lEfxlvHeX0keNIDJ7LcKGCEq8pk9KqEZwhVP255
        JlUiTc0iZn7OILTgoExVmvTtOaSBRRRupfPmUiNfzZFharOvXLpX4zlVxoa7Yw==
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     Rob Herring <robh@kernel.org>, Arnd Bergmann <arnd@arndb.de>
Cc:     Serge Semin <fancer.lancer@gmail.com>,
        Phil =?utf-8?Q?Mathieu-Daud?= =?utf-8?Q?=C3=A9?= 
        <philmd@linaro.org>, Paul Burton <paulburton@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vladimir Kondratiev <vladimir.kondratiev@intel.com>,
        Tawfik Bayouk <tawfik.bayouk@mobileye.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        =?utf-8?Q?Th=C3=A9o?= Lebrun <theo.lebrun@bootlin.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH 05/11] dt-bindings: mips: cpu: Add I-Class I6500
 Multiprocessor Core
In-Reply-To: <20231006164019.GA4040344-robh@kernel.org>
References: <20231004161038.2818327-1-gregory.clement@bootlin.com>
 <20231004161038.2818327-6-gregory.clement@bootlin.com>
 <hu5ksk2gw7zbbeiwi4unfo242qm2wfn36bpgea5inlamn4kqrf@magwi4w7gp3x>
 <87sf6pcebd.fsf@BL-laptop>
 <53050bbd-6a46-470d-9764-c83b8588698e@app.fastmail.com>
 <20231006164019.GA4040344-robh@kernel.org>
Date:   Mon, 09 Oct 2023 17:32:57 +0200
Message-ID: <87jzrvbyl2.fsf@BL-laptop>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-Sasl: gregory.clement@bootlin.com
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rob Herring <robh@kernel.org> writes:

> On Fri, Oct 06, 2023 at 12:48:03PM +0200, Arnd Bergmann wrote:
>> On Thu, Oct 5, 2023, at 16:51, Gregory CLEMENT wrote:
>> >> On Wed, Oct 04, 2023 at 06:10:32PM +0200, Gregory CLEMENT wrote:
>> >>> The MIPS Warrior I-class I6500 was announced by Imagination
>> >>> Technologies in 2016 and is used in the Mobileye SoC EyeQ5.
>> >>> 
>> >>> Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
>> >>> ---
>> >>>  Documentation/devicetree/bindings/mips/cpus.yaml | 1 +
>> >>>  1 file changed, 1 insertion(+)
>> >>> 
>> >>> diff --git a/Documentation/devicetree/bindings/mips/cpus.yaml b/Documentation/devicetree/bindings/mips/cpus.yaml
>> >>> index cf382dea3922..87fd2842ba68 100644
>> >>> --- a/Documentation/devicetree/bindings/mips/cpus.yaml
>> >>> +++ b/Documentation/devicetree/bindings/mips/cpus.yaml
>> >>> @@ -39,6 +39,7 @@ properties:
>> >>>        - mti,mips24KEc
>> >>>        - mti,mips14KEc
>> >>>        - mti,mips14Kc
>> >>
>> >>> +      - mti,i6500
>> >>
>> >> Since the CPU core vendor is Imagination Technologies thus it would
>> >> be more appropriate to have the "img," prefix. Wouldn't it?
>> >
>> > According to Documentation/devicetree/bindings/vendor-prefixes.yaml
>> >
>> > "^mti,.*":
>> >     description: Imagination Technologies Ltd. (formerly MIPS
>> >     Technologies Inc.)
>> >
>> > So I think it's OK.
>> 
>> I don't see any good solution, they changed their name and
>> ownership too many times. I would actually revert back the
>> description here to "MIPS Technologies Inc" instead of trying
>> to keep track of what they currently call themselves.
>> 
>> Since we already have both the 'mips,' and 'mti,' vendow
>> names for the 14Kc, 14KEc and 24KEc parts, maybe we can
>> just go back to 'mips,' for all cores past the mti era
>> rather than trying to date and geolocate each of the
>> classic cores as one of 'mti', 'img', 'wavecomp', 'tallwood',
>> 'mips' 'cipunited' etc.
>
> I would reserve 'mips' for anything common. Much like 'riscv' is only 
> for things based on RiscV specs/standards.
>
> I would use 'img' here if we know this was designed/implemented by 
> Imagination.

If there is no objection I will use 'img' then.

Gregory

>
> Rob

-- 
Gregory Clement, Bootlin
Embedded Linux and Kernel engineering
http://bootlin.com
