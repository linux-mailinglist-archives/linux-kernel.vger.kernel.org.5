Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E4747F4B12
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 16:39:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344704AbjKVPjt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 10:39:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344703AbjKVPje (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 10:39:34 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19CE63C3C
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 07:36:34 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE038C433CD;
        Wed, 22 Nov 2023 15:36:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700667393;
        bh=OKh33AzVm9uxL93RkAbKxEVBTDGFce76r325kliI7Zw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=mZPX+pE6BgQhCxnyvz2us7GgaC44S5Pm6jVPhcdDLXl90vZs0wDYN5mgcYmJS9oV3
         5Tb/Vq+g8RXzDFpRFiNg4Wtyzl8+l/BYT1etESchluIJmgYh1EmHDNbK1rU/R4Gmyi
         H0JnKPpKkFQ/VYScjMQqwZBecPdIQibiQ7bh0YkPhHwYVxVLQXFcITDcrqhUyNPdvY
         PTNzGNAxjIm3fKgEDJ2Vpb9Dw+R+kAzRJj/avhXp55kO85BQ43eL+DdLFN15trIPGK
         YUDtYXB+oHgIAzwu48xkIaDsbIcJCvOJnZMlfApmACGPwvFpnH/pFBao3qsnBe1xJj
         cKM8+EHFSbViQ==
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-507f1c29f25so9498010e87.1;
        Wed, 22 Nov 2023 07:36:33 -0800 (PST)
X-Gm-Message-State: AOJu0YyTLyZBgJbvGlNlGor8cbnopohkC3Gn2zrFk1g65U6T4gzjOuq0
        vAdEA5oqmmOjB1XbyP5Fqk6AKQ71+f79qSSQkg==
X-Google-Smtp-Source: AGHT+IE1SGDtuVjfqEZvGhD647pUyiDxFC2qDwkSydBk3Fmn9SBROP8ROhE5tj24cuC1kE1Iu0iZc4ZOeqnYn86teZs=
X-Received: by 2002:a05:6512:158e:b0:507:a766:ad27 with SMTP id
 bp14-20020a056512158e00b00507a766ad27mr2845995lfb.16.1700667391875; Wed, 22
 Nov 2023 07:36:31 -0800 (PST)
MIME-Version: 1.0
References: <20230807174159.1140957-1-kyletso@google.com> <20230807174159.1140957-2-kyletso@google.com>
 <20230821162517.GA1832382-robh@kernel.org> <CAGZ6i=0ey+94YYgc=os5iQ_pNmNVB=qZQD0=jB4fRTKggZPSWA@mail.gmail.com>
In-Reply-To: <CAGZ6i=0ey+94YYgc=os5iQ_pNmNVB=qZQD0=jB4fRTKggZPSWA@mail.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 22 Nov 2023 08:36:19 -0700
X-Gmail-Original-Message-ID: <CAL_JsqLjAooY27pG4GQHRdpiB_=0RCYrkKOjzAvmvz=5yU71Og@mail.gmail.com>
Message-ID: <CAL_JsqLjAooY27pG4GQHRdpiB_=0RCYrkKOjzAvmvz=5yU71Og@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: connector: Add child nodes for
 multiple PD capabilities
To:     Kyle Tso <kyletso@google.com>
Cc:     krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux@roeck-us.net, heikki.krogerus@linux.intel.com,
        gregkh@linuxfoundation.org, badhri@google.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 18, 2023 at 12:19=E2=80=AFPM Kyle Tso <kyletso@google.com> wrot=
e:
>
> On Tue, Aug 22, 2023 at 12:25=E2=80=AFAM Rob Herring <robh@kernel.org> wr=
ote:
> >
>
> Sorry for the late response...
>
> > On Tue, Aug 08, 2023 at 01:41:58AM +0800, Kyle Tso wrote:
> > > Define a new optional property "capabilities" which is a child node
> > > under connector to contain multiple USB Power Delivery capabilities.
> > >
> > > Define a new property with pattern (e.g. caps-0, caps-1) which is a
> >
> > A property in json-schema terms, but for DT it's a node not a property.
> > 'Define a child node ...' would be clearer.
> >
>
> Will do in the future patch
>
> > > child node under "capabilities". Each node contains PDO data of a
> > > selectable Power Delivery capability.
> > >
> > > Also define common properties for source-pdos, sink-pdos, and
> > > op-sink-microwatt that can be referenced.
> >
> > Why do we need this? What issue does this solve? The commit message
> > should answer those questions (always).
> >
>
> Will state the rationale in the future patch
>
> > > Signed-off-by: Kyle Tso <kyletso@google.com>
> > > ---
> > > v1 -> v2:
> > > - move source/sink-pdos to $defs and reference them in properties
> > >
> > >  .../bindings/connector/usb-connector.yaml     | 80 +++++++++++++----=
--
> > >  1 file changed, 57 insertions(+), 23 deletions(-)
> > >
> > > diff --git a/Documentation/devicetree/bindings/connector/usb-connecto=
r.yaml b/Documentation/devicetree/bindings/connector/usb-connector.yaml
> > > index 1c4d3eb87763..c6b02dbda83f 100644
> > > --- a/Documentation/devicetree/bindings/connector/usb-connector.yaml
> > > +++ b/Documentation/devicetree/bindings/connector/usb-connector.yaml
> > > @@ -117,28 +117,10 @@ properties:
> > >    # The following are optional properties for "usb-c-connector" with=
 power
> > >    # delivery support.
> > >    source-pdos:
> > > -    description: An array of u32 with each entry providing supported=
 power
> > > -      source data object(PDO), the detailed bit definitions of PDO c=
an be found
> > > -      in "Universal Serial Bus Power Delivery Specification" chapter=
 6.4.1.2
> > > -      Source_Capabilities Message, the order of each entry(PDO) shou=
ld follow
> > > -      the PD spec chapter 6.4.1. Required for power source and power=
 dual role.
> > > -      User can specify the source PDO array via PDO_FIXED/BATT/VAR/P=
PS_APDO()
> > > -      defined in dt-bindings/usb/pd.h.
> > > -    minItems: 1
> > > -    maxItems: 7
> > > -    $ref: /schemas/types.yaml#/definitions/uint32-array
> > > +    $ref: "#/$defs/source-pdos"
> > >
> > >    sink-pdos:
> > > -    description: An array of u32 with each entry providing supported=
 power sink
> > > -      data object(PDO), the detailed bit definitions of PDO can be f=
ound in
> > > -      "Universal Serial Bus Power Delivery Specification" chapter 6.=
4.1.3
> > > -      Sink Capabilities Message, the order of each entry(PDO) should=
 follow the
> > > -      PD spec chapter 6.4.1. Required for power sink and power dual =
role. User
> > > -      can specify the sink PDO array via PDO_FIXED/BATT/VAR/PPS_APDO=
() defined
> > > -      in dt-bindings/usb/pd.h.
> > > -    minItems: 1
> > > -    maxItems: 7
> > > -    $ref: /schemas/types.yaml#/definitions/uint32-array
> > > +    $ref: "#/$defs/sink-pdos"
> > >
> > >    sink-vdos:
> > >      description: An array of u32 with each entry, a Vendor Defined M=
essage Object (VDO),
> > > @@ -164,9 +146,7 @@ properties:
> > >      $ref: /schemas/types.yaml#/definitions/uint32-array
> > >
> > >    op-sink-microwatt:
> > > -    description: Sink required operating power in microwatt, if sour=
ce can't
> > > -      offer the power, Capability Mismatch is set. Required for powe=
r sink and
> > > -      power dual role.
> > > +    $ref: "#/$defs/op-sink-microwatt"
> > >
> > >    port:
> > >      $ref: /schemas/graph.yaml#/properties/port
> > > @@ -228,6 +208,30 @@ properties:
> > >        SNK_READY for non-pd link.
> > >      type: boolean
> > >
> > > +  capabilities:
> > > +    description: A child node to contain all the selectable USB Powe=
r Delivery capabilities.
> > > +    type: object
> > > +
> > > +    patternProperties:
> > > +      "^caps-[0-9]+$":
> > > +        description: Child nodes under "capabilities" node. Each nod=
e contains a selectable USB
> > > +          Power Delivery capability.
> > > +        type: object
> > > +
> > > +        properties:
> > > +          source-pdos:
> > > +            $ref: "#/$defs/source-pdos"
> > > +
> > > +          sink-pdos:
> > > +            $ref: "#/$defs/sink-pdos"
> > > +
> > > +          op-sink-microwatt:
> > > +            $ref: "#/$defs/op-sink-microwatt"
> > > +
> > > +        additionalProperties: false
> > > +
> > > +    additionalProperties: false
> > > +
> > >  dependencies:
> > >    sink-vdos-v1: [ 'sink-vdos' ]
> > >    sink-vdos: [ 'sink-vdos-v1' ]
> > > @@ -235,6 +239,36 @@ dependencies:
> > >  required:
> > >    - compatible
> > >
> > > +$defs:
> >
> > Make this:
> >
> > $defs:
> >   capabilities:
> >     properties:
> >       ...
> >
> > And then just reference "#/$defs/capabilities" at the top-level and in
> > caps-[0-9] node schema.
> >
> > You'll need to use unevaluatedProperties instead of additionalPropertie=
s
> > as well.
> >
>
> I am sorry I don't understand this part. Could you explain more?
>
> In $defs, define a whole structure of "capabilities" which has
> patternProperties "caps-[0-9]+", and inside "caps-[0-9]+" there are
> properties "source/sink-pdos" ?

No, define a list of properties under a def. Here's a more complete example=
:

$defs:
  capabilities:
    properties:
      source-pdos:
        ...

      sink-pdos:
        ...

And then add "$ref: '#/$defs/capabilities'" at the top-level of this
schema doc and under "caps-[0-9]+":

    patternProperties:
      "^caps-[0-9]+$":
        description: Child nodes under "capabilities" node. Each node
contains a selectable USB
          Power Delivery capability.
        type: object
        $ref: "#/$defs/capabilities"
        unevaluatedProperties: false

unevaluatedProperties is needed because it can "see" properties
defined in a $ref to get the full list of properties for a node.

Rob
