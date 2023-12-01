Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 756DA800608
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 09:42:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377851AbjLAIly (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 03:41:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235220AbjLAIlv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 03:41:51 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59E57131;
        Fri,  1 Dec 2023 00:41:56 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-50bc743c7f7so2543814e87.3;
        Fri, 01 Dec 2023 00:41:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701420114; x=1702024914; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=M0Ll8PM6R+fMhWbSgXfCkmatPjtexOoM35q2s1+XB8Q=;
        b=LY2nKbK2o2TN13NXUZ70AF6gVC30rAo8vlWw9EQALqMY+Pstt7UIBEMRJnVPtwadCf
         dqe/m8FMysLwT4zs6fDR/mnHiQHYOmIPJ+NVyzkaXSZBAJ1a//igRjV+ktgbhSX+PZsV
         vehDRV98Ts7P7QiPtyrwSMlLM9yj8B+4FhXUU95WFktZdBb6n7nsb4d0dCWz6FjkScC6
         3qjU0X8zYIk/SnAJsf9cunYt2jKPujECtWFfDUnprM4F9g7N1G2iE7C8CGop8RuYfvsO
         VHQfZz1kv1XZNto7GMWt/VdMlXKteLQBleiuXwfaAsm3d8LZVBA4Gv5PWWd/PwVUX1kX
         x3Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701420114; x=1702024914;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=M0Ll8PM6R+fMhWbSgXfCkmatPjtexOoM35q2s1+XB8Q=;
        b=atAc+hGGPUXATBDqAhlWmi+ndo/8Hci87ZZ++xrMhwQYHqlZgy0GL4EwT1BWslgnAf
         zul41MPyeSlBdgEHNs4eIywRfjbiSccAStVbPlvfurldepXXNyVT1RoAg66743Z5s+Wu
         BXZHoVhse0+L9WdfNI9t6SLkeVxMhIJt/r4t0P2ZHdVsgwMKlXuuRfNZ7hil5a5eOQdt
         3T5VBGbXzscEDz1mTK8rIQnxAzxVLYdRzBygQCHIfDAa1D/0/2DZkF2VLfxjvoIg1mOz
         NHLargQ8uM64M5t+wfye0c+8WuyleNcuCVNunbnTxH6a/bey5kfGJaE8E1Kaq4bMuEiZ
         noDQ==
X-Gm-Message-State: AOJu0YwpG/gbD+VntMhe4v4CP08e4abx17wdOKWS41OTOyx/ZV6tbrHk
        pg7Fv9UNX5YVittym2TFd4M=
X-Google-Smtp-Source: AGHT+IF0K0RFQAaOmMN/ds4GXvEqLt37rMcid31qfCGk+nL+I9t+V1O0HpkrY3DDZx2XEuw8iHpiYA==
X-Received: by 2002:a19:5052:0:b0:50b:c0f7:d1a1 with SMTP id z18-20020a195052000000b0050bc0f7d1a1mr495038lfj.41.1701420114195;
        Fri, 01 Dec 2023 00:41:54 -0800 (PST)
Received: from ?IPv6:2001:a61:3456:4e01:6ae:b55a:bd1d:57fc? ([2001:a61:3456:4e01:6ae:b55a:bd1d:57fc])
        by smtp.gmail.com with ESMTPSA id fb13-20020a05600c520d00b0040b3e7569fcsm8256193wmb.11.2023.12.01.00.41.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 00:41:53 -0800 (PST)
Message-ID: <0afd52940147b14db33d4712368c5dcc9ee90882.camel@gmail.com>
Subject: Re: [PATCH 00/12] iio: add new backend framework
From:   Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To:     David Lechner <dlechner@baylibre.com>, nuno.sa@analog.com
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org,
        Olivier MOYSAN <olivier.moysan@foss.st.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>
Date:   Fri, 01 Dec 2023 09:41:53 +0100
In-Reply-To: <CAMknhBH0pF_+z_JqWGscELBmAEDyxLAtgQ-j3=6P2MeFXnzhWQ@mail.gmail.com>
References: <20231121-dev-iio-backend-v1-0-6a3d542eba35@analog.com>
         <CAMknhBH0pF_+z_JqWGscELBmAEDyxLAtgQ-j3=6P2MeFXnzhWQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2023-11-30 at 17:54 -0600, David Lechner wrote:
> On Tue, Nov 21, 2023 at 4:17=E2=80=AFAM Nuno Sa via B4 Relay
> <devnull+nuno.sa.analog.com@kernel.org> wrote:
> >=20
> > Hi all,
> >=20
> > This is a Framework to handle complex IIO aggregate devices.
> >=20
> > The typical architecture is to have one device as the frontend device w=
hich
> > can be "linked" against one or multiple backend devices. All the IIO an=
d
> > userspace interface is expected to be registers/managed by the frontend
> > device which will callback into the backends when needed (to get/set
> > some configuration that it does not directly control).
> >=20
> > The basic framework interface is pretty simple:
> > =C2=A0- Backends should register themselves with @devm_iio_backend_regi=
ster()
> > =C2=A0- Frontend devices should get backends with @devm_iio_backend_get=
()
> >=20
> > (typical provider - consumer stuff)
> >=20
>=20
> The "typical provider - consumer stuff" seems pretty straight forward
> for finding and connecting two different devices, but the definition
> of what is a frontend and what is a backend seems a bit nebulous. It
> would be nice to seem some example devicetree to be able to get a
> better picture of how this will be used in practices (links to the the
> hardware docs for those examples would be nice too).
>=20
> In addition to the backend ops given in this series, what are some
> other expected ops that could be added in the future? Do we need some
> kind of spec to say "I need a backend with feature X and feature Y" or
> "I need a backend with compatible string" rather than just "I need a
> generic backend"?

Bah, I know saw that I messed up in the cover letter. This was the link [1]=
 I wanted
to add. In there, you'll see the RFC patch which already has lots of info. =
It also
has a link to a previous discussion  had with Jonathan about this kind off
arrangement.

You already more or less figured the frontend + backend story in one of you=
r replies.
So, yes the data is received or transmitted (if we think DAC/DDS) by the ac=
tual
converter which makes sense to be seen as the frontend. This connects to an=
other
device capable of handling the high sample rate (typically a core in a FPGA=
) of these
converters. But this is ADI usecase, note that STM also wants to have somet=
hing like
this in order to link devices. Ah, and one of the things that Jonathan want=
s to see
is that only the frontend device exposes the IIO interface to userspace.




[1]: https://lore.kernel.org/linux-iio/20230804145342.1600136-1-nuno.sa@ana=
log.com/

- Nuno S=C3=A1
