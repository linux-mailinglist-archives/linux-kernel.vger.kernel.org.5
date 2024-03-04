Return-Path: <linux-kernel+bounces-91387-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA5658710D4
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 00:02:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D71FB1C21E4C
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 23:02:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDE2C7C6C9;
	Mon,  4 Mar 2024 23:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hLSrZ2S0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A0067B3FA;
	Mon,  4 Mar 2024 23:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709593347; cv=none; b=Eh0FXVnFNDd/DIjenZyRuX0Rw3VFoJ/qtIrQx4SvpA4/hWqkbXHQ4rlSi0p3uwZ/vglHJu6KTxORYwfvJB17LGDxiAe1QAAWqC7aMl01kK6HPAFLciu49Wo75ueOdTrWrdbshvAXC26fTsAP2tKn70Ry2D8TC5AbnTRO7FcnTEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709593347; c=relaxed/simple;
	bh=8s3rhoaVWDD9dh7rGLfJ4Uu5zG4qUAoq6ZECch3DUvY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JBValmE4McWEgbbAuH82T0CZC6UuqvGEc9o+881KdnWOLXf2NIZGF5Td3VbgKY5HQ0/ISzYL8RjEcZkyrFGypAQNxKmnGUXtiLaWPwMJHON+HMva3Ncf+Kiyt93v9Vl+A2vTYPdBtlSh0uAlr8UmiBxUZu4b/MNFh0T6oq+5JPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hLSrZ2S0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6837BC43399;
	Mon,  4 Mar 2024 23:02:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709593346;
	bh=8s3rhoaVWDD9dh7rGLfJ4Uu5zG4qUAoq6ZECch3DUvY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=hLSrZ2S0xAeiE5BctUD/BCMiUxrw+aDhuOJsvU6FCjANj2UsfXb+q7sVM/UTGqdI0
	 vhcyRBXkrJ9o2aN3O7A2f0SLL8DBNtDtsuckJv52k3X7My/4/89VrXWuKK/koyadnX
	 0a6lcKCR/q/R4YD3GYIMB1otp/H8DuQai16mloeTq3QLwiM84T2/4EOrjp3/jyB+Xa
	 p6neNqLafrOfXcdh3fjprp+jXdC12utL7xDYKeYnAl05y2oGQJfkgz1eeLPH7V0p3X
	 PQ1FyNi7AInReSBwWAit3J/u8GzOtH9A8pTsmgYk5OvbSHc1ob8w6F1FcW6dUofjsK
	 Nvn/Vh3o4DS1w==
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2d275e63590so72111741fa.2;
        Mon, 04 Mar 2024 15:02:26 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXJ6QcLS7HemLOLjvTMKDRZ2aVS1ju8VJ2Wo4G//K79d8MLF6IUpYnV3DagPPoqu/fOnPfK80+Z5mp8fmrjkeUXLWoFNOYhprXvv786UqfWpWmQFKGbp+qcxTFsXzUd+j1sVs1Ge7/cP+R5tsOKginCI8797ADQrWdIaoFda50Gu8aU
X-Gm-Message-State: AOJu0Yz7ZAJKzKMwHiDH31x5MMQfxIPsLDn9HAcjl2JbVeU3NfJOTakl
	IMZx/NZMQlbuDYc0BXc422OlbtUxDIlHnGGie3nkuazH7Q5E1KppU8EPf40/NpqYmdrtotsLnJv
	2PIuFwXmYhyXpxdx0MTKadO+Uxg==
X-Google-Smtp-Source: AGHT+IHajaW7ao8oszFfzNUf6WEtIArJcqWeT/LVDUm4oHEI1OMP9txP4fYJa9ko2AQVpY1RT8JCfUQCyX+YOBErgQY=
X-Received: by 2002:a2e:81c8:0:b0:2d3:4b84:9176 with SMTP id
 s8-20020a2e81c8000000b002d34b849176mr157840ljg.19.1709593344541; Mon, 04 Mar
 2024 15:02:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231229191038.247258-1-david@ixit.cz> <2c9e91c7-8588-4260-8f5d-22c822019f62@linaro.org>
 <20240102235815.GA3700567-robh@kernel.org> <20240130170625.GA1847581-robh@kernel.org>
 <eb21360c-9a08-4cb7-a25d-83679aa87ead@ixit.cz>
In-Reply-To: <eb21360c-9a08-4cb7-a25d-83679aa87ead@ixit.cz>
From: Rob Herring <robh@kernel.org>
Date: Mon, 4 Mar 2024 17:02:11 -0600
X-Gmail-Original-Message-ID: <CAL_JsqL41h=BceT=eqNiFs+aQtZmiAXR5p-D0sL_jLFEiMpKDA@mail.gmail.com>
Message-ID: <CAL_JsqL41h=BceT=eqNiFs+aQtZmiAXR5p-D0sL_jLFEiMpKDA@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: opp: switch inner and outer min/maxItems
 rules for opp-hz
To: David Heidelberg <david@ixit.cz>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Viresh Kumar <vireshk@kernel.org>, 
	Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 4, 2024 at 2:34=E2=80=AFPM David Heidelberg <david@ixit.cz> wro=
te:
>
> On 30/01/2024 18:06, Rob Herring wrote:
> > On Tue, Jan 02, 2024 at 04:58:15PM -0700, Rob Herring wrote:
> >> On Sat, Dec 30, 2023 at 03:17:21PM +0100, Krzysztof Kozlowski wrote:
> >>> On 29/12/2023 20:10, David Heidelberg wrote:
> >>>> Fixes issue as:
> >>>> ```
> >>> Drop, it's not RST, but commit msg.
> >>>
> >>>> arch/arm64/boot/dts/qcom/sdm845-oneplus-enchilada.dtb: opp-table: op=
p-200000000:opp-hz:0: [200000000, 0, 0, 150000000, 0, 0, 0, 0, 300000000] i=
s too long
> >>>> ```
> >>>>
> >>>> Fixes: 3cb16ad69bef ("dt-bindings: opp: accept array of frequencies"=
)
> >>>>
> >>>> Signed-off-by: David Heidelberg <david@ixit.cz>
> >>>> ---
> >>>>   Documentation/devicetree/bindings/opp/opp-v2-base.yaml | 5 ++---
> >>>>   1 file changed, 2 insertions(+), 3 deletions(-)
> >>>>
> >>>> diff --git a/Documentation/devicetree/bindings/opp/opp-v2-base.yaml =
b/Documentation/devicetree/bindings/opp/opp-v2-base.yaml
> >>>> index e2f8f7af3cf4..86d3aa0eb435 100644
> >>>> --- a/Documentation/devicetree/bindings/opp/opp-v2-base.yaml
> >>>> +++ b/Documentation/devicetree/bindings/opp/opp-v2-base.yaml
> >>>> @@ -55,10 +55,9 @@ patternProperties:
> >>>>             to relate the values to their clocks or the order in whi=
ch the clocks
> >>>>             need to be configured and that is left for the implement=
ation
> >>>>             specific binding.
> >>>> -        minItems: 1
> >>>> -        maxItems: 32
> >>>>           items:
> >>>> -          maxItems: 1
> >>>> +          minItems: 1
> >>>> +          maxItems: 32
> >>> This does not look like correct fix. The original code looked fine -
> >>> only one item is allowed in each sub-element (array).
> >> This one is special being 64-bit values so we have an exception in
> >> property-units.yaml. The constraints here don't get used in decoding t=
he
> >> dtb and the default way of 1 outer element is used.
> >>
> >> It doesn't look like opp-hz needs to be a matrix as it is really just =
an
> >> array. Perhaps it should just be changed to an array type.
> >> Alternatively, adding 'items: { maxItems: 1 }' to the definition in
> >> property-units.yaml fixes the issue as well.
> >>
> >> Though we can fix this, I'm looking into if we have other cases where =
we
> >> need this to work as-is. There's probably some room for improvement in
> >> how matrix dimensions are handled.
> > I've made some improvements on matrix dimensions, but this one is still
> > an issue. Can you respin this dropping 'items: {maxItems: 1}'. I'm goin=
g
> > to change the definition in property-units.yaml to uint64-array.
>
> Keeping the rest of my changes still generates warnings (today dt-schema
> git) even with `maxItems` dropped.
>
> The only working scenario is when I do only the dropping of `items:
> {maxItems: 1}` from the original code.
>
> Is it the standalone change of just dropping this what did you desired?
> If yes, I have the patch prepared.

Yes. I still need to look at changing the type, but that shouldn't
hold up the kernel change.

Rob

