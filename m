Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35B917F3BB6
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 03:21:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229877AbjKVCV2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 21:21:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjKVCV1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 21:21:27 -0500
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75EA3181;
        Tue, 21 Nov 2023 18:21:23 -0800 (PST)
Received: by mail-ot1-x334.google.com with SMTP id 46e09a7af769-6ce2cf67be2so3333324a34.2;
        Tue, 21 Nov 2023 18:21:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700619683; x=1701224483; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jeGm3fxGNWvBQCvQzvUQ2JuG11fQHIZo42Sf8MQg8+w=;
        b=AQBZdBC68Qv94nZTZ/he7carL4QxdgpBvR4yHjeOwfWiJMJsJ38QRn0SygHdPo7xXY
         xEUL6+onwt2ndGKO10CxtkGkuQwd3i5T2I7CzT5XEz5sUDmJYTWy8TD6ct5V6r6vmBH8
         2LuNXcZlgB2cqz6PW35tAMXn/2ACDNhbLqiSnik66VfWN2YMaEGP55cM7K0xA7Sam8iH
         suFoPqKQITgCMx5BKtqNAuJ6blpEAixb4Y7XqFCk2TRUms3zALdIL2LNhG/BJnZfuqjm
         Tfvw72XfMN0THpwELEUAIWFjedRM4mPEzaxU+62GhjhxYoIaN35aiEuNeoWJhyNtAXAN
         aBPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700619683; x=1701224483;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jeGm3fxGNWvBQCvQzvUQ2JuG11fQHIZo42Sf8MQg8+w=;
        b=mVWtaBj9kXfsB3lLrUIFtwkaqMbVzb6Zixufg3h2xm6DPjKBEqt+i+bJw8uvMdwMu0
         OS0lJSkvZD7444XSb23LYh0ibPTpYo9qIErq0I/ZWkLb8cCiK1L3JnDaU4StyGJmuo9a
         MiiPeh+6Cj2g1RxyFjNTjB+1nehkUZs6XwqFTpRDJjRsxkZVwEP7pBkPnCH1uy+5+gES
         7aFOeRZsRWIRm3C4pblVQDE2sXdPiIDhSqmCnRtz7M/ZSftjmn7Utv7KE4O6wlwGukGv
         ss1ElOf8K3P3nRPJZulaGlcxXVuUMpiwE8VrjcOGAqEe8MeAezWuPZEsdCd3d4wRBcRo
         TtLg==
X-Gm-Message-State: AOJu0Yw4JWOK3ZtyBwmACC4zNCcr4Cz6sfv+KFDEJINSB85MQeWJTV8a
        sKA4DNJ+YI3coht8P/89IqnGnbuSd8RpinFLFvBMjkyuAW40uA==
X-Google-Smtp-Source: AGHT+IEEJhLoFe3a49x0x2186Fm334AW4JVqeWUeOrtc50QYUPXDENPUCh0JwIH9qhxtqwrrVcl52q0iUOXECMNpgac=
X-Received: by 2002:a9d:6d04:0:b0:6c4:a65c:f7bb with SMTP id
 o4-20020a9d6d04000000b006c4a65cf7bbmr1333897otp.33.1700619682728; Tue, 21 Nov
 2023 18:21:22 -0800 (PST)
MIME-Version: 1.0
References: <20231119023454.1591-1-linux.amoon@gmail.com> <20231119023454.1591-2-linux.amoon@gmail.com>
 <20231119-phrasing-reverse-bbc1fde515d5@spud> <CANAwSgQ6H9FUEBKz7sCf4kUZSMnCfyXG-cpGTMZoT15W9187Kg@mail.gmail.com>
 <20231120-grinch-upbeat-05f7a32a99fa@spud> <CANAwSgQGhDMeHLFpe8gnM2c26CjqX8QHOL1GdHrZJSvnBj39bA@mail.gmail.com>
 <20231121-defendant-hemstitch-a728c39b4e7d@spud>
In-Reply-To: <20231121-defendant-hemstitch-a728c39b4e7d@spud>
From:   Anand Moon <linux.amoon@gmail.com>
Date:   Wed, 22 Nov 2023 07:51:07 +0530
Message-ID: <CANAwSgS638Giuha+Kv0Vkunw3NqfahhbZfMYLc3AUrRoiXpDxg@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: usb: Add the binding example for the
 Genesys Logic GL3523 hub
To:     Conor Dooley <conor@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Icenowy Zheng <uwu@icenowy.me>, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Conor

On Tue, 21 Nov 2023 at 22:30, Conor Dooley <conor@kernel.org> wrote:
>
> On Tue, Nov 21, 2023 at 09:36:37AM +0530, Anand Moon wrote:
> > On Mon, 20 Nov 2023 at 21:15, Conor Dooley <conor@kernel.org> wrote:
> > > On Sun, Nov 19, 2023 at 08:57:28PM +0530, Anand Moon wrote:
> > > > On Sun, 19 Nov 2023 at 19:28, Conor Dooley <conor@kernel.org> wrote:
> > > > > On Sun, Nov 19, 2023 at 08:04:50AM +0530, Anand Moon wrote:
> > > > > > Add the binding example for the USB3.1 Genesys Logic GL3523
> > > > > > integrates with USB 3.1 Gen 1 Super Speed and USB 2.0 High-Speed
> > > > > > hub.
> > > > >
> > > > > But no comment in the commit message about the new property for the
> > > > > "peer hub". $subject saying "dt-bindings: usb: Add the binding example
> > > > > for the Genesys Logic GL3523 hub" is misleading when the meaningful
> > > > > parts of the patch are unrelated to the example.
> > > > >
>
> > > > > > +  peer-hub:
> > > > > > +    $ref: /schemas/types.yaml#/definitions/phandle
> > > > > > +    description:
> > > > > > +      phandle to the peer hub on the controller.
> > > > >
> > > > > What is this, why is it needed? Please explain it in your commit
> > > > > message.
> > > > >
> > > > Ok, GL3523 integrates Genesys Logic self-developed USB 3.1 Gen 1
> > > > Super Speed transmitter/receiver physical layer (PHY) and USB 2.0
> > > > High-Speed PHY
> > > >
> > > > peer-hub is used to cross-connect those phy nodes so that it can help
> > > > hub power on/off simultaneously.
> > >
> > > I said please explain it in your commit message, but on reflection I
> > > think that would be insufficient. Extending the description to explain
> > > what the peer-hub is would be great too. "peer hub on the controller"
> > > doesn't seem to make sense to me either, as the peer hub phandle is to
> > > another phy, not to the controller. I think that would probably also be
> > > resolved by explaining what the peer hub is in a more detailed manner.
> > >
> > > If this is purely a genesys thing, the property should grow a genesys,
> > > prefix also.
> > >
> > No, some USB Hub have combined phy for USB 3.x and USB 2.0 and have common
> > reset-gpios and power supply, peer-hub node helps connect the USB controller and
> > bring up the USB hub.
>
> I don't know what this is a response to.
>

This was the response to your comment, it is a generic property
"If this is purely a genesys thing, the property should grow a genesys,"

Please find the link to the schematic of the board which shares the
details of the binding example. USB_HUB_GL3523.

https://dn.odroid.com/S922X/ODROID-N2/Schematic/odroid-n2_rev0.6_20210121.pdf

> > I was waiting for more feedback on these changes.
> > Once it's ok I will update with proper the commit message in v4.
>
> And the property description too, so that a reader can understand how to
> implement it.

Yes, I will do that.

>
> Cheers,
> Conor.

Thanks
-Anand
