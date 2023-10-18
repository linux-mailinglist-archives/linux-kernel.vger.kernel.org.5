Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EDA17CE625
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 20:19:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230119AbjJRSTX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 14:19:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbjJRSTW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 14:19:22 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AB94B8
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 11:19:19 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id d75a77b69052e-419b53acc11so42301cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 11:19:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697653158; x=1698257958; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yJ3EjA/DdMiQV83zq9nxbWMT9iDAMkZuiptuvkWigh4=;
        b=BTz8OPZ14p2SBsf7C+k46Mv36uyCYHcG30OofA9vkpq1bC1B5plgoS5fb6slmRpYSG
         Htz5l2RsEPqp7rZXhmwyGuVQr7BeogZ1W5AiYaNW1Bqv6iiz0VOmmUiqd2TsupGQajKt
         sl7RFUmu7pXLVqUBpme+iWtW50p0hWikNJJgUMN+4SpzpdkbtsFmJRgwbFCDoSLrMuuL
         3zKsNGLodUCFhQq7ETQaKk/bhaD4/tspsXlP0h0YqiIzVPxf7+EKVJxrp3eXz2XlcfqX
         JagTZxcfCuT3fQDOWsTFzxKwCc3LZ4ydDInZ5qplk1UvjC5ytBpWgPvUARCulnNgqfcu
         VDRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697653158; x=1698257958;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yJ3EjA/DdMiQV83zq9nxbWMT9iDAMkZuiptuvkWigh4=;
        b=k84qu2khl0KH3xILGuL7WyNZa9JP0L93SNiwCrQ43Nn09GNWS7GjBnGreOyes+mY10
         wio+kHtMBddlmgPWWfjKnz5qbXIU9rZuDTSiIAoLocJRQdPhhenjKLFUOy0nWfd/rIsb
         OovD2caGDhA7ieiIac2AfRmct3vPemt5NmQJTIolGldk574AaNTmoDL8jlatW/z3slsr
         inCLuh43LFPsER36z4QAwRTPp/+pc899o4vlcOIpBenjJVa06BGA9omGbDoPephqsoCl
         Mw4J0EXnf4Q8O3DIP1XwrGsuosmysYDgwZ5owF87NF7RVAhd/S06mqyZtQKo7KqFdG8B
         yfFw==
X-Gm-Message-State: AOJu0YxuucVCR0c7SK0nlNd0qWo1z+/1yMDF4t9IzwrGRJZD0aIO/l3x
        0MhChgmoSrc8BlQWuOyvOS/rhixH4ENwLWxnCTrAag==
X-Google-Smtp-Source: AGHT+IHK+i17Y9IcO2PQf/JmQCdGgPfi8myqP25zde2F1LpyFkrss81iwvqT1M8c7/8umDJKNWx3fRkodE5Ar/dsLV0=
X-Received: by 2002:a05:622a:a020:b0:41c:bd34:7e44 with SMTP id
 jt32-20020a05622aa02000b0041cbd347e44mr44659qtb.6.1697653157766; Wed, 18 Oct
 2023 11:19:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230807174159.1140957-1-kyletso@google.com> <20230807174159.1140957-2-kyletso@google.com>
 <20230821162517.GA1832382-robh@kernel.org>
In-Reply-To: <20230821162517.GA1832382-robh@kernel.org>
From:   Kyle Tso <kyletso@google.com>
Date:   Thu, 19 Oct 2023 02:19:01 +0800
Message-ID: <CAGZ6i=0ey+94YYgc=os5iQ_pNmNVB=qZQD0=jB4fRTKggZPSWA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: connector: Add child nodes for
 multiple PD capabilities
To:     Rob Herring <robh@kernel.org>
Cc:     krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux@roeck-us.net, heikki.krogerus@linux.intel.com,
        gregkh@linuxfoundation.org, badhri@google.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 22, 2023 at 12:25=E2=80=AFAM Rob Herring <robh@kernel.org> wrot=
e:
>

Sorry for the late response...

> On Tue, Aug 08, 2023 at 01:41:58AM +0800, Kyle Tso wrote:
> > Define a new optional property "capabilities" which is a child node
> > under connector to contain multiple USB Power Delivery capabilities.
> >
> > Define a new property with pattern (e.g. caps-0, caps-1) which is a
>
> A property in json-schema terms, but for DT it's a node not a property.
> 'Define a child node ...' would be clearer.
>

Will do in the future patch

> > child node under "capabilities". Each node contains PDO data of a
> > selectable Power Delivery capability.
> >
> > Also define common properties for source-pdos, sink-pdos, and
> > op-sink-microwatt that can be referenced.
>
> Why do we need this? What issue does this solve? The commit message
> should answer those questions (always).
>

Will state the rationale in the future patch

> > Signed-off-by: Kyle Tso <kyletso@google.com>
> > ---
> > v1 -> v2:
> > - move source/sink-pdos to $defs and reference them in properties
> >
> >  .../bindings/connector/usb-connector.yaml     | 80 +++++++++++++------
> >  1 file changed, 57 insertions(+), 23 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/connector/usb-connector.=
yaml b/Documentation/devicetree/bindings/connector/usb-connector.yaml
> > index 1c4d3eb87763..c6b02dbda83f 100644
> > --- a/Documentation/devicetree/bindings/connector/usb-connector.yaml
> > +++ b/Documentation/devicetree/bindings/connector/usb-connector.yaml
> > @@ -117,28 +117,10 @@ properties:
> >    # The following are optional properties for "usb-c-connector" with p=
ower
> >    # delivery support.
> >    source-pdos:
> > -    description: An array of u32 with each entry providing supported p=
ower
> > -      source data object(PDO), the detailed bit definitions of PDO can=
 be found
> > -      in "Universal Serial Bus Power Delivery Specification" chapter 6=
.4.1.2
> > -      Source_Capabilities Message, the order of each entry(PDO) should=
 follow
> > -      the PD spec chapter 6.4.1. Required for power source and power d=
ual role.
> > -      User can specify the source PDO array via PDO_FIXED/BATT/VAR/PPS=
_APDO()
> > -      defined in dt-bindings/usb/pd.h.
> > -    minItems: 1
> > -    maxItems: 7
> > -    $ref: /schemas/types.yaml#/definitions/uint32-array
> > +    $ref: "#/$defs/source-pdos"
> >
> >    sink-pdos:
> > -    description: An array of u32 with each entry providing supported p=
ower sink
> > -      data object(PDO), the detailed bit definitions of PDO can be fou=
nd in
> > -      "Universal Serial Bus Power Delivery Specification" chapter 6.4.=
1.3
> > -      Sink Capabilities Message, the order of each entry(PDO) should f=
ollow the
> > -      PD spec chapter 6.4.1. Required for power sink and power dual ro=
le. User
> > -      can specify the sink PDO array via PDO_FIXED/BATT/VAR/PPS_APDO()=
 defined
> > -      in dt-bindings/usb/pd.h.
> > -    minItems: 1
> > -    maxItems: 7
> > -    $ref: /schemas/types.yaml#/definitions/uint32-array
> > +    $ref: "#/$defs/sink-pdos"
> >
> >    sink-vdos:
> >      description: An array of u32 with each entry, a Vendor Defined Mes=
sage Object (VDO),
> > @@ -164,9 +146,7 @@ properties:
> >      $ref: /schemas/types.yaml#/definitions/uint32-array
> >
> >    op-sink-microwatt:
> > -    description: Sink required operating power in microwatt, if source=
 can't
> > -      offer the power, Capability Mismatch is set. Required for power =
sink and
> > -      power dual role.
> > +    $ref: "#/$defs/op-sink-microwatt"
> >
> >    port:
> >      $ref: /schemas/graph.yaml#/properties/port
> > @@ -228,6 +208,30 @@ properties:
> >        SNK_READY for non-pd link.
> >      type: boolean
> >
> > +  capabilities:
> > +    description: A child node to contain all the selectable USB Power =
Delivery capabilities.
> > +    type: object
> > +
> > +    patternProperties:
> > +      "^caps-[0-9]+$":
> > +        description: Child nodes under "capabilities" node. Each node =
contains a selectable USB
> > +          Power Delivery capability.
> > +        type: object
> > +
> > +        properties:
> > +          source-pdos:
> > +            $ref: "#/$defs/source-pdos"
> > +
> > +          sink-pdos:
> > +            $ref: "#/$defs/sink-pdos"
> > +
> > +          op-sink-microwatt:
> > +            $ref: "#/$defs/op-sink-microwatt"
> > +
> > +        additionalProperties: false
> > +
> > +    additionalProperties: false
> > +
> >  dependencies:
> >    sink-vdos-v1: [ 'sink-vdos' ]
> >    sink-vdos: [ 'sink-vdos-v1' ]
> > @@ -235,6 +239,36 @@ dependencies:
> >  required:
> >    - compatible
> >
> > +$defs:
>
> Make this:
>
> $defs:
>   capabilities:
>     properties:
>       ...
>
> And then just reference "#/$defs/capabilities" at the top-level and in
> caps-[0-9] node schema.
>
> You'll need to use unevaluatedProperties instead of additionalProperties
> as well.
>

I am sorry I don't understand this part. Could you explain more?

In $defs, define a whole structure of "capabilities" which has
patternProperties "caps-[0-9]+", and inside "caps-[0-9]+" there are
properties "source/sink-pdos" ?

Reference it in the property "capabilities" under connector node?
Reference it in the property "source/sink-pdos" under connector node as wel=
l?

And I don't know the usage of unevaluatedProperties. Where should it
be inserted and what is the value of it?

> > +  source-pdos:
> > +    description: An array of u32 with each entry providing supported p=
ower
> > +      source data object(PDO), the detailed bit definitions of PDO can=
 be found
> > +      in "Universal Serial Bus Power Delivery Specification" chapter 6=
.4.1.2
> > +      Source_Capabilities Message, the order of each entry(PDO) should=
 follow
> > +      the PD spec chapter 6.4.1. Required for power source and power d=
ual role.
> > +      User can specify the source PDO array via PDO_FIXED/BATT/VAR/PPS=
_APDO()
> > +      defined in dt-bindings/usb/pd.h.
> > +    minItems: 1
> > +    maxItems: 7
> > +    $ref: /schemas/types.yaml#/definitions/uint32-array
> > +
> > +  sink-pdos:
> > +    description: An array of u32 with each entry providing supported p=
ower sink
> > +      data object(PDO), the detailed bit definitions of PDO can be fou=
nd in
> > +      "Universal Serial Bus Power Delivery Specification" chapter 6.4.=
1.3
> > +      Sink Capabilities Message, the order of each entry(PDO) should f=
ollow the
> > +      PD spec chapter 6.4.1. Required for power sink and power dual ro=
le. User
> > +      can specify the sink PDO array via PDO_FIXED/BATT/VAR/PPS_APDO()=
 defined
> > +      in dt-bindings/usb/pd.h.
> > +    minItems: 1
> > +    maxItems: 7
> > +    $ref: /schemas/types.yaml#/definitions/uint32-array
> > +
> > +  op-sink-microwatt:
> > +    description: Sink required operating power in microwatt, if source=
 can't
> > +      offer the power, Capability Mismatch is set. Required for power =
sink and
> > +      power dual role.
> > +
> >  allOf:
> >    - if:
> >        properties:
> > --
> > 2.41.0.585.gd2178a4bd4-goog
> >
