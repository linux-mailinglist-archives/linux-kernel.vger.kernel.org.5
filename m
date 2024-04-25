Return-Path: <linux-kernel+bounces-159040-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F6748B2888
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 20:55:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81E7C1C21CE9
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 18:55:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A43B715219C;
	Thu, 25 Apr 2024 18:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=z3ntu.xyz header.i=@z3ntu.xyz header.b="q42dYI3c"
Received: from ahti.lucaweiss.eu (ahti.lucaweiss.eu [128.199.32.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2A66149DFD;
	Thu, 25 Apr 2024 18:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=128.199.32.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714071292; cv=none; b=USwEjdpt1zfxxrydXRMro67Sc8dwVo98SE1KXqFrumm5y65bpi8jaZyXAOmRXIn+vCD0PJKONJOUaGFs53V+tR2SU5yg3rLkAabdnM76E0pUWsbmL0lgiDIYhgiUbc2PPIOQnpc3c6DJkLhoI3y1uWHZnfeIhNlStwvi8fEQVHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714071292; c=relaxed/simple;
	bh=b0y26d8frlS0cfjGXw7FBAkrdyqVJAluEQvE7mbwPoI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hvbtGfeOgqdrQotyAQ9h6npcwtgs3eIdXivYML6cVTrWT9fVTy5ayBI60GLGW82d/x2R4vSfe/Q04mC4Rn0P7CDhJchU2lwcGt2bfCpS1VmAwyRHSlnGtq5mgJGchFWjqJppXkLwk4U/Dq8hRNArS9Okm0gNDgm36VDPRFkcFNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=z3ntu.xyz; spf=pass smtp.mailfrom=z3ntu.xyz; dkim=pass (1024-bit key) header.d=z3ntu.xyz header.i=@z3ntu.xyz header.b=q42dYI3c; arc=none smtp.client-ip=128.199.32.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=z3ntu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=z3ntu.xyz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=s1;
	t=1714071282; bh=b0y26d8frlS0cfjGXw7FBAkrdyqVJAluEQvE7mbwPoI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=q42dYI3cxAykpMzfZNfZfIHXxU8aybz95go4HuO3noXh3QW91bIqI6BA7RMj77EOB
	 PvHTbRMOXghUdzQAfHVjOq6t0VthDuJnoiStpo6PqP45pUpoFsa6PzsJF3dgbpAYrK
	 w0r2nr5rAWJFBI8nZ9HUi+zsLFtFtI8lIXxlVxOg=
From: Luca Weiss <luca@z3ntu.xyz>
To: Rob Herring <robh@kernel.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Andy Gross <agross@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject:
 Re: [PATCH RFC 1/2] dt-bindings: soc: qcom,smsm: Allow specifying mboxes
 instead of qcom,ipc
Date: Thu, 25 Apr 2024 20:54:40 +0200
Message-ID: <5087455.31r3eYUQgx@g550jk>
In-Reply-To: <20240425161715.GA2759240-robh@kernel.org>
References:
 <20240424-smsm-mbox-v1-0-555f3f442841@z3ntu.xyz>
 <20240424-smsm-mbox-v1-1-555f3f442841@z3ntu.xyz>
 <20240425161715.GA2759240-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

On Donnerstag, 25. April 2024 18:17:15 MESZ Rob Herring wrote:
> On Wed, Apr 24, 2024 at 07:21:51PM +0200, Luca Weiss wrote:
> > The qcom,ipc-N properties are essentially providing a reference to a
> > mailbox, so allow using the mboxes property to do the same in a more
> > structured way.
> 
> Can we mark qcom,ipc-N as deprecated then?

Yes, that should be ok. Will also send a similar change to the other bindings
that support both qcom,ipc and mboxes.

>  
> > Since multiple SMSM hosts are supported, we need to be able to provide
> > the correct mailbox for each host. The old qcom,ipc-N properties map to
> > the mboxes property by index, starting at 0 since that's a valid SMSM
> > host also.
> > 
> > The new example shows how an smsm node with just qcom,ipc-3 should be
> > specified with the mboxes property.
> > 
> > Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
> > ---
> >  .../devicetree/bindings/soc/qcom/qcom,smsm.yaml    | 48 ++++++++++++++++++----
> >  1 file changed, 40 insertions(+), 8 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,smsm.yaml b/Documentation/devicetree/bindings/soc/qcom/qcom,smsm.yaml
> > index db67cf043256..b12589171169 100644
> > --- a/Documentation/devicetree/bindings/soc/qcom/qcom,smsm.yaml
> > +++ b/Documentation/devicetree/bindings/soc/qcom/qcom,smsm.yaml
> > @@ -33,6 +33,13 @@ properties:
> >        specifier of the column in the subscription matrix representing the local
> >        processor.
> >  
> > +  mboxes:
> > +    minItems: 1
> > +    maxItems: 5
> 
> Need to define what each entry is.

The entry is (description from qcom,ipc-N)

  "the outgoing ipc bit used for signaling the N:th remote processor."

So you want me to add 5 times e.g.

- the IPC mailbox used for signaling the 0th remote processor
- the IPC mailbox used for signaling the 1st remote processor

etc? I don't really have any extra knowledge on smsm to be able to write
something better there..

Also what are your thoughts on this binding vs the alternative I wrote
in the cover letter? I'm not really happy about how the properties are
represented.

Regards
Luca


> 
> > +    description:
> > +      Reference to the mailbox representing the outgoing doorbell in APCS for
> > +      this client.
> > +
> >    '#size-cells':
> >      const: 0
> >  
> > @@ -98,15 +105,18 @@ required:
> >    - '#address-cells'
> >    - '#size-cells'
> >  
> > -anyOf:
> > +oneOf:
> >    - required:
> > -      - qcom,ipc-1
> > -  - required:
> > -      - qcom,ipc-2
> > -  - required:
> > -      - qcom,ipc-3
> > -  - required:
> > -      - qcom,ipc-4
> > +      - mboxes
> > +  - anyOf:
> > +      - required:
> > +          - qcom,ipc-1
> > +      - required:
> > +          - qcom,ipc-2
> > +      - required:
> > +          - qcom,ipc-3
> > +      - required:
> > +          - qcom,ipc-4
> >  
> >  additionalProperties: false
> >  
> > @@ -136,3 +146,25 @@ examples:
> >              #interrupt-cells = <2>;
> >          };
> >      };
> > +  # Example using mboxes property
> > +  - |
> > +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> > +
> > +    shared-memory {
> > +        compatible = "qcom,smsm";
> > +        #address-cells = <1>;
> > +        #size-cells = <0>;
> > +        mboxes = <0>, <0>, <0>, <&apcs 19>;
> > +
> > +        apps@0 {
> > +            reg = <0>;
> > +            #qcom,smem-state-cells = <1>;
> > +        };
> > +
> > +        wcnss@7 {
> > +            reg = <7>;
> > +            interrupts = <GIC_SPI 144 IRQ_TYPE_EDGE_RISING>;
> > +            interrupt-controller;
> > +            #interrupt-cells = <2>;
> > +        };
> > +    };
> > 
> 





