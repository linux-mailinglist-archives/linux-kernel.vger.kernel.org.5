Return-Path: <linux-kernel+bounces-117956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CEDB88B1C5
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 21:42:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 123B5323F85
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 20:42:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD1BF5A0EA;
	Mon, 25 Mar 2024 20:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YxSZEf10"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC8F45339E;
	Mon, 25 Mar 2024 20:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711399319; cv=none; b=T2i+gNNfXpplFhamEPPM3FC4AwGaptV+Nw1ZWUl5LrOTnPnXlOcaGZlw7ovFn3iyxG+7cdKdbiEEW45DGRboYK+Zi86E/9lI94BJYXXeS2LTUZvrBpJ2tMpA2vDFeL+t5YZMo0AX7H0MGYtLkNLtXvuO6j68PH1Purwrd80u268=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711399319; c=relaxed/simple;
	bh=LDNB8MZMwXrL8S6ylSiuXJSNm5wf/KceWfNVqWIj7Ps=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r27VjjxLhc7WqXjvPDkaPAM3MTNJqvWrHO3Wo6JHFrdfTe9lnlJ95ZE/ihCGS8+iRvutCEg9r1+VJ40hOdM9fMqrurWANZZg7LGVKEHOnAOjRedNJg3P510Qb3rgHdK1UfDGuePuvCIrbfi2JW1YQUIvpydOgbRQqXL1x5uj5So=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YxSZEf10; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C18CC43390;
	Mon, 25 Mar 2024 20:41:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711399318;
	bh=LDNB8MZMwXrL8S6ylSiuXJSNm5wf/KceWfNVqWIj7Ps=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=YxSZEf10DCNuFAJ+hBMCwedXbUZW4WhJp/a3TTsHgBsNZYlYI1lzW/Y+QTo7mB5e+
	 5bl5rPQImyXVsKBOtzTB8qz9h+6bL34feN2H1OXaGaJUtq1eZ9QFttgpRAVgPH3FOP
	 4ztHHtyUCvLd63KPjf9dmSH5klmQDhblZvfdOviUKT94DO4rO3XMZDNmUrEolVUPns
	 +FjkvUTpAe7Yg82VzWUuFs7L98b7ZgPScdLFiQsL6842T1OeE3vr1QNLZFCYbBePpX
	 0K25wcoCh0NBJj50smqScFbBloy63naxQqapwxKxsRroqhgTXBlw16lfSUHuUmnCa0
	 0fLNy8vnvH5Qw==
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-515ac73c516so896865e87.0;
        Mon, 25 Mar 2024 13:41:58 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXvJ3pzI/tF7WEikt0wl+/2tLl5F3wYKJwOW6PER6v34W1CHG5O9lZRZ8YVV+9xk503E7b74AiZlFOKGiJtXz8vE8Wr6wnNwJhWKfjj6HAXqN3rlDP5l83QUAC4N0m1KMfPVv3cxDIfdg==
X-Gm-Message-State: AOJu0YwyVJZ8lGJ45CW8/tpyc/G41DS9GhY0fOmDJvICaxuFqWPONq2q
	zk7Em0TPktv3vScjnyReeFMwo78wAN3IfvDFGfKMUl/WctAYNm2P8pvsCRNm/brFOg4j5ngwtl9
	1JMS6LZtVfO1K/krU9XuEWqJqOQ==
X-Google-Smtp-Source: AGHT+IEwnbOvcIUeEmXjxX6ZWWANfgT/u+HKxY7xcgBOoOJIymf8Z3Vko5Ki1hkJTGTNTczZEZeHlY1OKBt3p6Coyd8=
X-Received: by 2002:a19:7701:0:b0:513:d6d9:b0dc with SMTP id
 s1-20020a197701000000b00513d6d9b0dcmr2168645lfc.23.1711399316766; Mon, 25 Mar
 2024 13:41:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240321025105.53210-1-sudanl@amazon.com> <20240321025105.53210-4-sudanl@amazon.com>
 <20240325150609.GA3477574-robh@kernel.org> <51403072-f5ca-450e-9206-19ca627ead11@amazon.co.uk>
In-Reply-To: <51403072-f5ca-450e-9206-19ca627ead11@amazon.co.uk>
From: Rob Herring <robh@kernel.org>
Date: Mon, 25 Mar 2024 15:41:42 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKpp+J2a_+wmcaOX8RfTEEyZBESWBX7GWGa_u_5_=4gsg@mail.gmail.com>
Message-ID: <CAL_JsqKpp+J2a_+wmcaOX8RfTEEyZBESWBX7GWGa_u_5_=4gsg@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] dt-bindings: rng: Add vmgenid support
To: "Landge, Sudan" <sudanl@amazon.co.uk>
Cc: Sudan Landge <sudanl@amazon.com>, tytso@mit.edu, Jason@zx2c4.com, 
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	sathyanarayanan.kuppuswamy@linux.intel.com, thomas.lendacky@amd.com, 
	dan.j.williams@intel.com, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, graf@amazon.de, dwmw@amazon.co.uk, 
	bchalios@amazon.es, xmarcalx@amazon.co.uk
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 25, 2024 at 3:11=E2=80=AFPM Landge, Sudan <sudanl@amazon.co.uk>=
 wrote:
>
>
>
> On 25/03/2024 15:06, Rob Herring wrote:
> > CAUTION: This email originated from outside of the organization. Do not=
 click links or open attachments unless you can confirm the sender and know=
 the content is safe.
> >
> >
> >
> > On Thu, Mar 21, 2024 at 02:51:04AM +0000, Sudan Landge wrote:
> >> Virtual Machine Generation ID driver was introduced in commit af6b54e2=
b5ba
> >> ("virt: vmgenid: notify RNG of VM fork and supply generation ID"), as =
an
> >> ACPI only device.
> >>
> >> VMGenID specification http://go.microsoft.com/fwlink/?LinkId=3D260709 =
defines
> >> a mechanism for the BIOS/hypervisors to communicate to the virtual mac=
hine
> >> that it is executed with a different configuration (e.g. snapshot exec=
ution
> >> or creation from a template).
> >> The guest operating system can use the notification for various purpos=
es
> >> such as re-initializing its random number generator etc.
> >>
> >> As per the specs, hypervisor should provide a globally unique identifi=
ed,
> >> or GUID via ACPI.
> >>
> >> This patch tries to mimic the mechanism to provide the same functional=
ity
> >> which is for a hypervisor/BIOS to notify the virtual machine when it i=
s
> >> executed with a different configuration.
> >>
> >> As part of this support the devicetree bindings requires the hyperviso=
rs or
> >> BIOS to provide a memory address which holds the GUID and an IRQ which=
 is
> >> used to notify when there is a change in the GUID.
> >> The memory exposed in the DT should follow the rules defined in the
> >> vmgenid spec mentioned above.
> >>
> >> *Reason for this change*:
> >> Chosing ACPI or devicetree is an intrinsic part of an hypervisor desig=
n.
> >> Without going into details of why a hypervisor would chose DT over ACP=
I,
> >> we would like to highlight that the hypervisors that have chose device=
tree
> >> and now want to make use of the vmgenid functionality cannot do so tod=
ay
> >> because vmgenid is an ACPI only device.
> >> This forces these hypervisors to change their design which could have
> >> undesirable impacts on their use-cases, test-scenarios etc.
> >>
> >> The point of vmgenid is to provide a mechanism to discover a GUID when
> >> the execution state of a virtual machine changes and the simplest
> >> way to do it is pass a memory location and an interrupt via devicetree=
.
> >> It would complicate things unnecessarily if instead of using devicetre=
e,
> >> we try to implement a new protocol or modify other protocols to someho=
w
> >> provide the same functionility.
> >>
> >> We believe that adding a devicetree binding for vmgenid is a simpler,
> >> better alternative to provide the same functionality and will allow
> >> such hypervisors as mentioned above to continue using devicetree.
> >>
> >> More references to vmgenid specs:
> >>   - https://www.qemu.org/docs/master/specs/vmgenid.html
> >>   - https://learn.microsoft.com/en-us/windows/win32/hyperv_v2/virtual-=
machine-generation-identifier
> >>
> >> Signed-off-by: Sudan Landge <sudanl@amazon.com>
> >> ---
> >>   .../devicetree/bindings/rng/vmgenid.yaml      | 57 +++++++++++++++++=
++
> >>   MAINTAINERS                                   |  1 +
> >>   2 files changed, 58 insertions(+)
> >>   create mode 100644 Documentation/devicetree/bindings/rng/vmgenid.yam=
l
> >>
> >> diff --git a/Documentation/devicetree/bindings/rng/vmgenid.yaml b/Docu=
mentation/devicetree/bindings/rng/vmgenid.yaml
> >> new file mode 100644
> >> index 000000000000..4b6ab62cc2ae
> >> --- /dev/null
> >> +++ b/Documentation/devicetree/bindings/rng/vmgenid.yaml
> >> @@ -0,0 +1,57 @@
> >> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> >> +%YAML 1.2
> >> +---
> >> +$id: http://devicetree.org/schemas/rng/vmgenid.yaml#
> >> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> >> +
> >> +title: Virtual Machine Generation Counter ID device
> >> +
> >> +maintainers:
> >> +  - Jason A. Donenfeld <Jason@zx2c4.com>
> >> +
> >> +description:
> >> +  Firmwares or hypervisors can use this devicetree to describe
> >> +  interrupts and the shared resources to inject a Virtual Machine Gen=
eration
> >> +  counter.
> >> +
> >> +properties:
> >> +  compatible:
> >> +    const: linux,vmgenctr
> >
> > Why 'linux'? It should be named for a particular host implementation
> > (and that implementation's bugs/quirks). However, this thing is simple
> > enough we can perhaps avoid that here. As the interface is defined by
> > Microsoft, then perhaps they should be the vendor here.
> >
> We chose "linux" because the current implementation and usage of
> devicetree was Linux specific. However, I think "virtual" would be a
> better choice than "Microsoft" since this is a generic virtual device
> that could be configured by any hypervisor or firmware not owned or
> related to Microsoft. I have updated this as part of the new version if
> it looks good. I don't have a strong opinion for "virtual" though so if
> that is the right choice as per you I can update it.

I'm not really a fan of 'virtual' and its one and only existing use.
Don't add to it.

Someone has defined how to read a GUID from register(s). I can think
of many ways that could be implemented. The data itself could be hex
or ascii. You could read N times from one register or read from N
sequential registers. And again, there's endianness and access sizes.
Given the only source of any of that is a Microsoft spec, then that
makes sense to me. Or just no vendor prefix is possible, but I prefer
to avoid those cases.

Also, consider 'vmgenctr' has basically 0 search results. 'vmgenid'
returns some relevant results. Not that search results are a
requirement for naming, but perhaps something to consider.

> >> +
> >> +  "#interrupt-cells":
> >> +    const: 3
> >> +    description: |
> >> +      The 1st cell is the interrupt type.
> >> +      The 2nd cell contains the interrupt number for the interrupt ty=
pe.
> >> +      The 3rd cell is for trigger type and level flags.
> >> +
> >> +  interrupt-controller: true
> >
> > Why is this device an interrupt controller?
> >
> My devicetree references I took initially were incorrect which led to
> the addition of this, I have removed this in the next version. Sorry
> about that.

Try again...

> >> +
> >> +  reg:
> >> +    description: |
> >> +      specifies the base physical address and
> >> +      size of the regions in memory which holds the VMGenID counter.
> >
> > Odd wrapping, but drop unless you have something specific to say about
> > region like perhaps the layout of the registers. Or maybe thats defined
> > somewhere else?
> >
> > Does the spec say anything about endianness or access size? DT assumes
> > native endianness by default. We have properties to deal these, but
> > would be better to be explicit if that's defined already.
> >
> The spec doesn't mention anything about the endianness but, I have
> updated the description with some more data.

Then what does your driver assume? Microsoft may not have thought
about it because they don't care, but now you want to use DT so you
have to because it is frequently used on BE systems. If we define
something, then there's some hope. Otherwise, it's pretty much a
guarantee folks will do the opposite.

Rob

