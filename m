Return-Path: <linux-kernel+bounces-28869-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5709E8303FE
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 11:58:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5C19AB21182
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 10:57:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1BB51C688;
	Wed, 17 Jan 2024 10:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="SZoNNMed"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5038D1DDCA
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 10:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705489070; cv=none; b=q1ZlWAFl1RCL0GMg41KdQrKP35dDyHmTuC9Av4/b+aswUb9OQ+MnWWXh5g7e+1SDHxuVXDdnbs1F/3H0J5VPlwUAl9WOgn4b6i5j1cVViehgsIBSuAN2MQpR2kdV/McI89zIyVW5wKGY7A8VA06bqASl1YFFUtn5foXyHuu6Ne8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705489070; c=relaxed/simple;
	bh=dFrcmnmkmmZdK1/Cl3suXD/fcMVdImKuOSnKRYIPDMQ=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:
	 References:User-agent:From:To:Cc:Subject:Date:In-reply-to:
	 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding; b=Z1dRmoM4iWHNNVHdTvYgqEg2hV/p3er34K0gFJ2mQ/Xx6o4txtFMrID66zPR6yzt4WNGme7GpYWEDGllxeHnaD3WipX7os+J0uWMPYh2cu8cilmeFiU1ru2sBCeZvlN/biV/qO/soGFgez4u8sJymB2g76B2Aee40k8xeqoNZnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=SZoNNMed; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-40e8ca16511so1730525e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 02:57:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1705489066; x=1706093866; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
         :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AZ0irsFSW2hXq1lOFv0C5tcSeX7I48ojxIzsNWQWXR4=;
        b=SZoNNMedalO4Md7WPsiM4gwIJgP0t5mz/ggMg3LqIBvVGCPw+b5m+sxqhbiZMti8w6
         q4z7C5q9ZQTGV+l65wwrsUcfNAOzwTJ2wXMvAmUJ+wVPA5JEIKx9IpQ3qcjnmotKsQ1b
         pSWtRgx1cgxhN3wi3Q/TmzxpkiaQHb25BF/B70MKHW0SztFwvevWvunv7+dcch1G+lt3
         /sK2tzZivYaJ+RuFRS7jdJS5pHk5hFgitvwb2TdXoiIgOcMty61EOfwqLgx4CkbWk5oQ
         2B8vyfkVy46/qEk9oIoRs12XjqWcDz4rvxDWQkIzNlmXmfs58QtEji059HpeBKfDbMCv
         Nk3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705489066; x=1706093866;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
         :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=AZ0irsFSW2hXq1lOFv0C5tcSeX7I48ojxIzsNWQWXR4=;
        b=Ek8MGrYXyc+/8hMMc2o1gP+UL55p6tjb53bqif+bo1YHIdtLTPFadikIgxtIvpQgLB
         oqndigETVNby5MKl2gR6EeDpZGaHCN3tXEwIKsPxwgMPj001KZL7GeRG56w2aonbW2BR
         9EGrZZpE1lQrEpL7LaqSgt64RXzIpKw6WVnslqauH4wOHRsiXpAjpY4gvfMn4gf6vZ8+
         Y0025YPlaOorR0fgA8bXSYp+WTrjgZ1U2pjZBRHqqg8ijmSWJqR+DFS7OV+20nM5y49c
         hw6bzslRC9H7teXRdh+AZaDkUXvnEDM8GG/6C1NDB6auzt+sSCyUpZmhPJK4OFB5hudM
         Frzg==
X-Gm-Message-State: AOJu0YxmD5/Q8bdl5ZwsudD5F3Kj/HQRZolitR16n6g2HohCnvOrMV+j
	9XJw2bAL31uvMH2AX9i5A74C5UcN5yzkmg==
X-Google-Smtp-Source: AGHT+IG34Dap1ZJ3WGb+r28aPogMiJUvvKsLDnVhtoSaXpgGSZDDBQgsqehv2GQXT9TcoQZSM36iVw==
X-Received: by 2002:a05:600c:364c:b0:40e:89f6:e2b with SMTP id y12-20020a05600c364c00b0040e89f60e2bmr434240wmq.31.1705489066317;
        Wed, 17 Jan 2024 02:57:46 -0800 (PST)
Received: from localhost ([2a01:e0a:3c5:5fb1:c1f6:14ce:b96f:2df5])
        by smtp.gmail.com with ESMTPSA id f7-20020adffcc7000000b00337bf3586d6sm1376674wrs.103.2024.01.17.02.57.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jan 2024 02:57:45 -0800 (PST)
References: <20231222111658.832167-1-jbrunet@baylibre.com>
 <20231222111658.832167-2-jbrunet@baylibre.com>
 <awxboh3nv4r5p7v7vcgwttu2m74fws47johb73c5f7econ2qqu@zl5xbnoeyclq>
User-agent: mu4e 1.10.8; emacs 29.1
From: Jerome Brunet <jbrunet@baylibre.com>
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Jerome Brunet <jbrunet@baylibre.com>, Thierry Reding
 <thierry.reding@gmail.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Kevin Hilman <khilman@baylibre.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
 linux-pwm@vger.kernel.org, JunYi Zhao <junyi.zhao@amlogic.com>, Rob
 Herring <robh@kernel.org>
Subject: Re: [PATCH v4 1/6] dt-bindings: pwm: amlogic: fix s4 bindings
Date: Wed, 17 Jan 2024 11:30:08 +0100
In-reply-to: <awxboh3nv4r5p7v7vcgwttu2m74fws47johb73c5f7econ2qqu@zl5xbnoeyclq>
Message-ID: <1jbk9kxm52.fsf@starbuckisacylon.baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


On Wed 17 Jan 2024 at 11:03, Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutr=
onix.de> wrote:

> [[PGP Signed Part:Undecided]]
> On Fri, Dec 22, 2023 at 12:16:49PM +0100, Jerome Brunet wrote:
>> s4 has been added to the compatible list while converting the Amlogic PWM
>> binding documentation from txt to yaml.
>>=20
>> However, on the s4, the clock bindings have different meaning compared to
>> the previous SoCs.
>>=20
>> On the previous SoCs the clock bindings used to describe which input the
>> PWM channel multiplexer should pick among its possible parents.
>>=20
>> This is very much tied to the driver implementation, instead of describi=
ng
>> the HW for what it is. When support for the Amlogic PWM was first added,
>> how to deal with clocks through DT was not as clear as it nowadays.
>> The Linux driver now ignores this DT setting, but still relies on the
>> hard-coded list of clock sources.
>>=20
>> On the s4, the input multiplexer is gone. The clock bindings actually
>> describe the clock as it exists, not a setting. The property has a
>> different meaning, even if it is still 2 clocks and it would pass the ch=
eck
>> when support is actually added.
>>=20
>> Also the s4 cannot work if the clocks are not provided, so the property =
no
>> longer optional.
>
> s/no/is no/
>
>> Finally, for once it makes sense to see the input as being numbered
>> somehow. No need to bother with clock-names on the s4 type of PWM.
>>=20
>> Fixes: 43a1c4ff3977 ("dt-bindings: pwm: Convert Amlogic Meson PWM bindin=
g")
>> Reviewed-by: Rob Herring <robh@kernel.org>
>> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
>> ---
>>  .../devicetree/bindings/pwm/pwm-amlogic.yaml  | 67 ++++++++++++++++---
>>  1 file changed, 58 insertions(+), 9 deletions(-)
>>=20
>> diff --git a/Documentation/devicetree/bindings/pwm/pwm-amlogic.yaml b/Do=
cumentation/devicetree/bindings/pwm/pwm-amlogic.yaml
>> index 527864a4d855..a1d382aacb82 100644
>> --- a/Documentation/devicetree/bindings/pwm/pwm-amlogic.yaml
>> +++ b/Documentation/devicetree/bindings/pwm/pwm-amlogic.yaml
>> @@ -9,9 +9,6 @@ title: Amlogic PWM
>>  maintainers:
>>    - Heiner Kallweit <hkallweit1@gmail.com>
>>=20=20
>> -allOf:
>> -  - $ref: pwm.yaml#
>> -
>>  properties:
>>    compatible:
>>      oneOf:
>> @@ -43,12 +40,8 @@ properties:
>>      maxItems: 2
>>=20=20
>>    clock-names:
>> -    oneOf:
>> -      - items:
>> -          - enum: [clkin0, clkin1]
>> -      - items:
>> -          - const: clkin0
>> -          - const: clkin1
>> +    minItems: 1
>> +    maxItems: 2
>>=20=20
>>    "#pwm-cells":
>>      const: 3
>> @@ -57,6 +50,55 @@ required:
>>    - compatible
>>    - reg
>>=20=20
>> +allOf:
>> +  - $ref: pwm.yaml#
>> +
>> +  - if:
>> +      properties:
>> +        compatible:
>> +          contains:
>> +            enum:
>> +              - amlogic,meson8-pwm
>> +              - amlogic,meson8b-pwm
>> +              - amlogic,meson-gxbb-pwm
>> +              - amlogic,meson-gxbb-ao-pwm
>> +              - amlogic,meson-axg-ee-pwm
>> +              - amlogic,meson-axg-ao-pwm
>> +              - amlogic,meson-g12a-ee-pwm
>> +              - amlogic,meson-g12a-ao-pwm-ab
>> +              - amlogic,meson-g12a-ao-pwm-cd
>> +    then:
>> +      # Historic bindings tied to the driver implementation
>> +      # The clocks provided here are meant to be matched with the input
>> +      # known (hard-coded) in the driver and used to select pwm clock
>> +      # source. Currently, the linux driver ignores this.
>
> I admit I didn't understand the relevant difference between the old and
> the new binding yet.

Let's try to explain differently then:
* So far each AML PWM IP has 2 pwm.
* Up to G12, 4 input PLL/clocks are wired to the HW IP and there=20
  mux/div/gate to select which input to take.
  - The historic bindings just described how to setup each of the 2
    internal muxes - 2 optionnal clocks.
    The actual 4 inputs names from CCF are hard coded in
    the driver. This is a pretty bad description. The driver has been
    updated since then to use CCF to figure out the best parent
    according to pwm rate so this setting is ignored now.
  - The 'new' bindings (introduced in patch #2) fixes the problem above
    but the meaning of the clock binding is different. It describes the
    actual HW parents - 4 clocks, optionnal since some are not wired on
    some PWM blocks. To avoid breaking the ABI, a new compatible for
    these SoC is introduced.
=20=20=20=20
> (The driver currently doesn't support the s4, right?)

Indeed. I know Amlogic is preparing the support. I could do it in this
series but I prefer to encourage them to contribute. It should come
shortly after this series is merged.

Starting from s4 (prbably even a1 - up to people contributing this SoC
to say) the mux/div/gate is no longer in the PWM IP. It has moved to the
main clock controller. Again the clock binding describes something
different. It is the 2 input clocks of each block, they are mandatory
this time.

> Is it possible to detect if the dt uses the old or the new
> binding?

Apart from the compatible, no.

> If yes, I suggest to drop the old one from the binding and only
> keep it in the driver for legacy systems.

I don't this would be allowed by the DT maintainers.
My understanding is that the old binding doc is here to stay.
What could happen after sufficient time has past it remove the support
for the old/historic binding in the driver. Driver are not required to
support all possible bindings after all, especially if it is not used/tested
anymore.

>
>> +      properties:
>> +        clock-names:
>> +          oneOf:
>> +            - items:
>> +                - enum: [clkin0, clkin1]
>> +            - items:
>> +                - const: clkin0
>> +                - const: clkin1
>> +
>> +  # Newer IP block take a single input per channel, instead of 4 inputs
>> +  # for both channels
>> +  - if:
>> +      properties:
>> +        compatible:
>> +          contains:
>> +            enum:
>> +              - amlogic,meson-s4-pwm
>
> The expectation is that this list contains all compatibles that are not
> included in the "historic" list above, right? Then maybe use "else:"
> instead of another explicit list?
>

I suppose if, elseif, else is possible.

I've done it this way because is slightly easier for human to read the
doc and find what is related to what. If you this is important for you,
I can change it.

>> +    then:
>> +      properties:
>> +        clocks:
>> +          items:
>> +            - description: input clock of PWM channel A
>> +            - description: input clock of PWM channel B
>> +        clock-names: false
>> +      required:
>> +        - clocks
>> +
>>  additionalProperties: false
>
> Best regards
> Uwe


--=20
Jerome

