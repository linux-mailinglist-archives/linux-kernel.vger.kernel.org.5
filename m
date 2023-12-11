Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AABB80BFB2
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 04:08:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230006AbjLKCtr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Dec 2023 21:49:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjLKCtq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Dec 2023 21:49:46 -0500
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 428D5E3
        for <linux-kernel@vger.kernel.org>; Sun, 10 Dec 2023 18:49:52 -0800 (PST)
Received: by mail-qt1-x832.google.com with SMTP id d75a77b69052e-4258b6df295so378181cf.0
        for <linux-kernel@vger.kernel.org>; Sun, 10 Dec 2023 18:49:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702262991; x=1702867791; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xAKWZkH+/lnkBoBv416M+3qlIhJzFPIoQWktBVQdFFQ=;
        b=cbxefL5xpn51FpKhA18WVgq4YxQrsbDB+Uh1DbdrwjIw0CpBDDyvAdMtlVhdMw3Q3T
         5X8rC3ZKMi+PpVvEEk96DWGEdkrMaziaRItMPidBE/WnkOn6nB4HYtjDXef09kMLuggb
         wONwsxWcFFZaxn4+dRK9HBKAR3xUIDj7dtFptmAiEDeAe54nhceIeHsUgj+8jEkGgzDG
         0l0ztBDclI2E7MnsCj0qc42clcUE5xQrRhp6MXZAHNmIswIcy154Sbvr1236oBPGAUhv
         mkxreMuflAEfhpG/F8AuRCGy25s6WPDietwINapdk3DrU5YHWrsbBRVXq0brF571UTlX
         nnfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702262991; x=1702867791;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xAKWZkH+/lnkBoBv416M+3qlIhJzFPIoQWktBVQdFFQ=;
        b=v8JlN8Ko9B0cylVNq9zPcWRtcAOdK6PZjtqHcyQ75VPp74oYCd5P892oUa4tZ7bLif
         U1hKR5p0vOBDG188gyh3kRnn6d1wSxOCl46Dl35KSh21N7GBOnupkcVPjcz5KoB53Vw9
         JaipNSz2XTF3JQ0FPuUkICREJuR7wd1vPJjrVStzECQ19HaROiDAVeA7TUs25tjjbEKn
         ePziMXiXxzdyyrZ8EHSifs9QYsZOX6wp6Vt6g5eEV5iYV6ilWWsCmJN6CMtnrPcjuMJM
         WEOEi7P4KFcki+EyKWQsws1AZ0AEbprSYruQzgdxdGE9BwjmRjBD61gwcvx7gn0bkNW3
         3+zA==
X-Gm-Message-State: AOJu0Ywjrh7TQIF3kY5zwuKtnrC+VzAeD6RYEpKVSe1rpvHGzFeDF+N2
        Ujkg2f0ie0kE0fyvaUl+Jub56KeWfQ0a8Gi59B2hWw==
X-Google-Smtp-Source: AGHT+IGtAkZ7CEXELZD8kIrd7WU2TqPRqxsegaLZE9xIsDpVMVAgmYmUSqDu0X+QbaslW+OGRI1klNYqhoP7SvcXAk0=
X-Received: by 2002:ac8:5908:0:b0:423:98a3:422 with SMTP id
 8-20020ac85908000000b0042398a30422mr470684qty.11.1702262991017; Sun, 10 Dec
 2023 18:49:51 -0800 (PST)
MIME-Version: 1.0
References: <20231205030114.1349089-1-kyletso@google.com> <20231205030114.1349089-2-kyletso@google.com>
 <20231208165039.GA1756077-robh@kernel.org>
In-Reply-To: <20231208165039.GA1756077-robh@kernel.org>
From:   Kyle Tso <kyletso@google.com>
Date:   Mon, 11 Dec 2023 10:49:35 +0800
Message-ID: <CAGZ6i=1FPUaN4Ji4T3t3-_g2KHEngCcZ0rLR9AyG5RBpv5OCeA@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] dt-bindings: connector: Add child nodes for
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
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 9, 2023 at 12:50=E2=80=AFAM Rob Herring <robh@kernel.org> wrote=
:
>
> On Tue, Dec 05, 2023 at 11:01:13AM +0800, Kyle Tso wrote:
> > Commit 662a60102c12 ("usb: typec: Separate USB Power Delivery from USB
> > Type-C") allows userspace to configure the PD of a port by selecting
> > different set of predefined PD capabilities. Define the PD capability
> > sets in DT for better configurability in device modules.
> >
> > Define an optional child node "capabilities" to contain multiple USB
> > Power Delivery capabilities.
> >
> > Define child nodes with pattern (e.g. caps-0, caps-1) under
> > "capabilities". Each node contains PDO data of a selectable Power
> > Delivery capability.
> >
> > Also define common properties for source-pdos, sink-pdos, and
> > op-sink-microwatt that can be referenced.
> >
> > Signed-off-by: Kyle Tso <kyletso@google.com>
> > ---
> > v4 -> v5:
> > - Fixed DT_CHECK errors
> >
> >  .../bindings/connector/usb-connector.yaml     | 88 +++++++++++++------
> >  1 file changed, 59 insertions(+), 29 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/connector/usb-connector.=
yaml b/Documentation/devicetree/bindings/connector/usb-connector.yaml
> > index 7c8a3e8430d3..7945d09d1f59 100644
> > --- a/Documentation/devicetree/bindings/connector/usb-connector.yaml
> > +++ b/Documentation/devicetree/bindings/connector/usb-connector.yaml
> > @@ -14,6 +14,8 @@ description:
> >    of a USB interface controller or a separate node when it is attached=
 to both
> >    MUX and USB interface controller.
> >
> > +$ref: "#/$defs/capabilities"
> > +
> >  properties:
> >    compatible:
> >      oneOf:
> > @@ -67,6 +69,15 @@ properties:
> >        model it as a regulator. See bindings/regulator/fixed-regulator.=
yaml
> >
> >    # The following are optional properties for "usb-c-connector".
> > +  source-pdos:
> > +    $ref: "#/$defs/capabilities/properties/source-pdos"
> > +
> > +  sink-pdos:
> > +    $ref: "#/$defs/capabilities/properties/sink-pdos"
> > +
> > +  op-sink-microwatt:
> > +    $ref: "#/$defs/capabilities/properties/op-sink-microwatt"
>
> With the $ref above, these aren't needed. But you have to use
> unevaluatedProperties instead of additionalProperties.
>
> I fixed this up and applied.
>
> Rob

Thank you, Rob!

--
Kyle
