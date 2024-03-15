Return-Path: <linux-kernel+bounces-104933-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4313F87D614
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 22:20:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7AF81F22E0C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 21:20:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E604854903;
	Fri, 15 Mar 2024 21:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=beagleboard-org.20230601.gappssmtp.com header.i=@beagleboard-org.20230601.gappssmtp.com header.b="SJsDv1GQ"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 184D74F8A1
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 21:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710537631; cv=none; b=VsqdbmYUYWqKToaLeU68kxKbh4iHRNOtFvVOQBNZM9hZ/r49OpeoJNKbLjk71tDxmxxbeUYSIBpCMSLk/53Gr5NUEG2lFDD89yNmySb71C8C8DGtaysJBwXx6R9B9J3f1kVKmnKQs9f5CqdqbiXDNTjSIdgs72FOFvil13ZuSug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710537631; c=relaxed/simple;
	bh=nvuEUt1n2fgmz3yyWKQvSYgQU5Hy1fuxQ6UNYsk1qiY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h4X+1ukC5hAXxPFH7JJQQU78UbQa7TZtpb/0RhTyysqhXAzSZV7b6lzBxMCnSk+YIW9a6Tg9FJoZH/3vXmb5r6NCXDIL7NW+RIuZ+KHueBUEKMZ3qJH8X37kM3Xx45ihqUQfaC6bm0Zdg8cKOIakg9ln5rxRn2JZlhb5tx3u/dY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=beagleboard.org; spf=fail smtp.mailfrom=beagleboard.org; dkim=pass (2048-bit key) header.d=beagleboard-org.20230601.gappssmtp.com header.i=@beagleboard-org.20230601.gappssmtp.com header.b=SJsDv1GQ; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=beagleboard.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=beagleboard.org
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2d485886545so28966691fa.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 14:20:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=beagleboard-org.20230601.gappssmtp.com; s=20230601; t=1710537625; x=1711142425; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qhQYqFTZpSvyzqRZ4R//8NCPFsK5Cfx9302tirVTjw0=;
        b=SJsDv1GQz4xaNmHDmYdDIKfusLKLzcH0fI2AmCmSZ8mZ5jR6IWvABjjsmt+ncO2V7a
         IGTVJP8cw3/ED/Dh/V1r/ixSsCMyfM9RpnjF5+QGFeyBvJFhrKZTVpabOR0iY0IyF4mO
         BlP+lv8upTdDfIiD+gPITT0q2rIVffHzirurP8w26y7epgeor0hGnGpfgdTZDG2Pce7V
         voye1fUEz56vwrpoVTPDiKswTLV1nUnyhwMOREYsSYVZbGAcnh6AE10Lr6tA2Xem7dDf
         qhKD+Vzk/0HYb0xsFWP8Z2Qf91zlCPclsIWMYgsHOeQTBKpRJdBJs9opZ+qWIuO5CHTP
         QtsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710537625; x=1711142425;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qhQYqFTZpSvyzqRZ4R//8NCPFsK5Cfx9302tirVTjw0=;
        b=cbf9RutbxI0rBtoyNEtIt9w1nj8DFo3mSvuKz4V0RZXcj7HGuNdrVx1dV1prNmfFjo
         1NEfCooOyfLx8HEeedQmKSBNUHBHpxDfRfljZvr7B51JIpy+1RBHOlpmoruj4PtIgY2Q
         UbOv4GdMHE09dWSvOr34yLyDT067b4nBhP0JoWFZ3kS8hEn/ZncBVQ1nN0y42aqQyYQr
         bYJ778btESIQCbC4lLbSBJqlVmb4WjpIHBOyWdQef3qbYlaC94QZITTh6TZ6xuSCnlH+
         GvhZnUzb4t+LHG+ReM69eyxWJqyH/Qm3WeX9xK6TVp638TqxfxVOsLDN0wZUpL5QIgyo
         tl7A==
X-Gm-Message-State: AOJu0YzPTaqi+dpHbRlF+fC3WDS9sCzraYd+J9jX6kca9vp10R+uDAOV
	ylTrbowBlSvEKC1aq5AO4WdnOi6k2QMnzaPW3LNbWzjhHJy+LZsijBByZD5cBVMW4J4zMdG1+bp
	Hx7v5pFXr9AqL08TDlFp0A89ZkjgTdvXdRBc=
X-Google-Smtp-Source: AGHT+IEjDNqTIf91jmyd0ACknC8C/IveOoxg+8FMZYxQ/7WpNERxy0nqNaqZnN+hus67K69hU9E4L/U41yukVQ8aPgY=
X-Received: by 2002:a2e:a164:0:b0:2d4:3e96:47ee with SMTP id
 u4-20020a2ea164000000b002d43e9647eemr246475ljl.26.1710537624874; Fri, 15 Mar
 2024 14:20:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240315184908.500352-1-ayushdevel1325@gmail.com>
In-Reply-To: <20240315184908.500352-1-ayushdevel1325@gmail.com>
From: Vaishnav M A <vaishnav@beagleboard.org>
Date: Sat, 16 Mar 2024 02:50:13 +0530
Message-ID: <CALudOK5v_uCUffxHGKS-jA-DKLNV7xwmKkxJwjHaMWWgDdPDqA@mail.gmail.com>
Subject: Re: [PATCH v3 0/8] misc: Add mikroBUS driver
To: Ayush Singh <ayushdevel1325@gmail.com>
Cc: linux-kernel@vger.kernel.org, jkridner@beagleboard.org, 
	robertcnelson@beagleboard.org, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>, 
	Derek Kiernan <derek.kiernan@amd.com>, Dragan Cvetic <dragan.cvetic@amd.com>, 
	Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Jiri Slaby <jirislaby@kernel.org>, Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-spi@vger.kernel.org, linux-serial@vger.kernel.org, 
	greybus-dev@lists.linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ayush,

On Sat, Mar 16, 2024 at 12:19=E2=80=AFAM Ayush Singh <ayushdevel1325@gmail.=
com> wrote:
>
> MikroBUS is an open standard  developed by MikroElektronika for connectin=
g
> add-on boards to microcontrollers or microprocessors. It essentially
> allows you to easily expand the functionality of your main boards using
> these add-on boards.
>
> This patchset adds mikroBUS as a Linux bus type and provides a driver to
> parse, and flash mikroBUS manifest and register the mikroBUS board.
>

As Russel had provided the feedback, this patchset does not add support
for mikrobus, but a subset of mikrobus add-on boards which have a
1-wire click ID EEPROM with an identifier blob that is similar to the greyb=
us
manifest. This series lacks the necessary context and details to the
specifications that is implemented.

https://www.mikroe.com/clickid - you should atleast point to this specs.

> The v1 and v2 of this patchset was submitted by Vaishnav M A back in
> 2020. This patchset also includes changes made over the years as part of
> BeagleBoards kernel.
>
> Link: https://www.mikroe.com/mikrobus
> Link: https://docs.beagleboard.org/latest/boards/beagleplay/
> Link: https://lore.kernel.org/lkml/20200818124815.11029-1-vaishnav@beagle=
board.org/ Patch v2
>

Thank you for making the effort to upstream this, arriving at the
latest revision of the public available click ID hardware took almost 2-3 y=
ears
and I could not personally keep up with upstreaming, my sincere apologies t=
o
the maintainers that provided feedback on the earlier revisions. I hope an
updated version of this series lands upstream with your work as the  effort=
s
made at BeagleBoard.org Foundation makes development simpler by adding
plug and play support to these add-on boards. Also this series mentions onl=
y
the case where mikroBUS port is present physically on the board, but there
can be mikroBUS ports appearing over greybus and that is the reason why
greybus manifest was chose as descriptor format - the series needs to
describe these details so that a reviewer has the necessary information
to review your patches. A link to beagleconnect is also helpful to reviewer=
s.

https://docs.beagleboard.org/latest/projects/beagleconnect/index.html

> Changes in v3:
> - Use phandle instead of busname for spi
> - Use spi board info for registering new device
> - Convert dt bindings to yaml
> - Add support for clickID
> - Code cleanup and style changes
> - Additions required to spi, serdev, w1 and regulator subsystems
>
> Changes in v2:
> - support for adding mikroBUS ports from DT overlays,
> - remove debug sysFS interface for adding mikrobus ports,
> - consider extended pin usage/deviations from mikrobus standard
>   specifications
> - use greybus CPort protocol enum instead of new protocol enums
> - Fix cases of wrong indentation, ignoring return values, freeing allocat=
ed
>   resources in case of errors and other style suggestions in v1 review.
>
> Ayush Singh (7):

It looks like the version you have sent is very similar to the
version I had previously updated for Beagleboard git with
only rebases and cleanup, but I don't see major functional
changes. I request you give credit to the original author
atleast as a Co-author with Co-developed by tag, As there
there was a significant amount of work done by myself to
come up with this specs and get everything working on close
to 150 mikrobus add-on boards on physical mikroBUS ports
and over greybus:
https://github.com/vaishnavachath/manifesto/tree/mikrobusv3/manifests

The driver today is poorly written and was one of the first
Linux kernel development work I did while I was still in college
so I might have made a lot of blunders and just rebasing and
reposting will not get this to an acceptable state, here is what
I would recommend:

* Drop all the unnecessary changes in the mikroBUS driver to
support fixed-regulators, fixed-clocks, serdev device .etc and
implement minimal changes to support the mikroBUS clickid
devices.

* Provide necessary justification to why the particular descriptor
format (greybus manifest) is chosen, with pull request to manifesto
and greybus-specification.
https://github.com/projectara/greybus-spec
and similar to : https://github.com/projectara/manifesto/pull/2

* Move the mikrobus W1 driver to w1/ subsytem, it is a standard
W1 EEPROM driver (also a standard part with updated family code)
* Keep a RFC series of changes where mikroBUS ports can appear over
greybus to justify why the identifier format needs to be extended greybus
manifest.

>   dt-bindings: misc: Add mikrobus-connector
>   w1: Add w1_find_master_device

Dependent patches that goes to different subsytems should
be sent first separately to avoid confusion and then your series
should mention the necessary dependencies. (same for
spi).

>   spi: Make of_find_spi_controller_by_node() available
>   regulator: fixed-helper: export regulator_register_always_on
>   greybus: Add mikroBUS manifest types
>   mikrobus: Add mikrobus driver
>   dts: ti: k3-am625-beagleplay: Add mikroBUS

Send this patch as DONOTMERGE till your bindings are
accepted.

>
> Vaishnav M A (1):
>   serdev: add of_ helper to get serdev controller
>
Drop this from initial series,
I will provide further feedback from my TI e-mail,
Vaishnav Achath <vaishnav.a@ti.com>

Thank again for taking this up,

Thanks and Regards,
Vaishnav

>  .../bindings/misc/mikrobus-connector.yaml     | 110 ++
>  MAINTAINERS                                   |   7 +
>  .../arm64/boot/dts/ti/k3-am625-beagleplay.dts |  76 +-
>  drivers/misc/Kconfig                          |   1 +
>  drivers/misc/Makefile                         |   1 +
>  drivers/misc/mikrobus/Kconfig                 |  19 +
>  drivers/misc/mikrobus/Makefile                |   6 +
>  drivers/misc/mikrobus/mikrobus_core.c         | 942 ++++++++++++++++++
>  drivers/misc/mikrobus/mikrobus_core.h         | 201 ++++
>  drivers/misc/mikrobus/mikrobus_id.c           | 229 +++++
>  drivers/misc/mikrobus/mikrobus_manifest.c     | 502 ++++++++++
>  drivers/misc/mikrobus/mikrobus_manifest.h     |  20 +
>  drivers/regulator/fixed-helper.c              |   1 +
>  drivers/spi/spi.c                             | 206 ++--
>  drivers/tty/serdev/core.c                     |  19 +
>  drivers/w1/w1.c                               |   6 +-
>  drivers/w1/w1_int.c                           |  27 +
>  include/linux/greybus/greybus_manifest.h      |  49 +
>  include/linux/serdev.h                        |   4 +
>  include/linux/spi/spi.h                       |   4 +
>  include/linux/w1.h                            |   1 +
>  21 files changed, 2318 insertions(+), 113 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/misc/mikrobus-conne=
ctor.yaml
>  create mode 100644 drivers/misc/mikrobus/Kconfig
>  create mode 100644 drivers/misc/mikrobus/Makefile
>  create mode 100644 drivers/misc/mikrobus/mikrobus_core.c
>  create mode 100644 drivers/misc/mikrobus/mikrobus_core.h
>  create mode 100644 drivers/misc/mikrobus/mikrobus_id.c
>  create mode 100644 drivers/misc/mikrobus/mikrobus_manifest.c
>  create mode 100644 drivers/misc/mikrobus/mikrobus_manifest.h
>
>
> base-commit: 61996c073c9b070922ad3a36c981ca6ddbea19a5
> --
> 2.44.0
>

