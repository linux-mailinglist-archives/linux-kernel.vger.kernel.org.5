Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DE5379E86E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 14:58:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240672AbjIMM6C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 08:58:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231620AbjIMM6A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 08:58:00 -0400
Received: from mail-vk1-xa2f.google.com (mail-vk1-xa2f.google.com [IPv6:2607:f8b0:4864:20::a2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B42BD19B4;
        Wed, 13 Sep 2023 05:57:56 -0700 (PDT)
Received: by mail-vk1-xa2f.google.com with SMTP id 71dfb90a1353d-495ea3299b0so1284888e0c.2;
        Wed, 13 Sep 2023 05:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=beagleboard-org.20230601.gappssmtp.com; s=20230601; t=1694609876; x=1695214676; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UtrxdtTp1EW7h6+dg/+5k5x050r9bil5U5brlIW9E/E=;
        b=RcpZYdwiMI3zsLUS0FmtFzHUsbybUN5Qqmv9Uoxo64RRInw/PB175oLLCrMpVAt1Pi
         /6a8seSMR/lpUaHvqjTgD9Asw7kMIaHhOixp71MaSiKZrXGTpF8pGhRRBKQX3+WObzWw
         49iqFQ0ROv7V7uLmLydv9PxdaJc+YpAntRaRraeiQMeJQYEEPZWYttgyQ9OmOt/AUDOY
         4i61QdYT9ZwX8jGN8++VBgRzU6M0uhqyM6K891ZRoETUErScaxXrFWsK9yOQcZv4LkQ+
         XJ8CGWkJrAhg/EAmV/je2VrHNptaec7t4d2lXJXePpJiou0gSexm3T+/qMewy7p2ExfD
         Ab3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694609876; x=1695214676;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UtrxdtTp1EW7h6+dg/+5k5x050r9bil5U5brlIW9E/E=;
        b=v/z/McaRU28i8BT6uFAkFErTjjwAz1DwEOdF9cPZA1rXpHaVeWmchneSfCX9wr6YXJ
         pnIuH8qcEGZVRfmYE2quhxtZ2EfAwSYSn7WUI8+tXMolWhLliVVSGZZXaWa0Q459pa4f
         KiVIaPwCwAlXkyykNqvJdlylahxnq25HeNZ+MSAoO+zyy5QsAUCnYHpHb49yKr0WLL4a
         MvK+AaIMJohnLZE6HrdGle69CBZS5AIz5wHpB1ZHOKPJ2oDo7nCfAAuRTlUynvT22VOm
         lsvnjdet/SaGEjcz5zjMMAG2j+Knw6nAzdlEyU6F+y3zBWP3rLpoAckYkXUReDtenVe3
         8v9Q==
X-Gm-Message-State: AOJu0Yy68vcIob9BrqXTF4/oizBPChG/4qiOkFDxvwBHzYrV6QCupvBx
        o2Vg5Qsa6WDRItNYE8lvf0nNipatNLdpSXNxasRP5D2n490=
X-Google-Smtp-Source: AGHT+IGBce9XpFUrQp4LmmTK00Ooh3AHj870mZ2euVBCDMHGPLWGSh+Dc6c9O1KrbGAnxc3aABrxwymZEOJokUcdp4w=
X-Received: by 2002:a1f:6d82:0:b0:493:7df9:bcc4 with SMTP id
 i124-20020a1f6d82000000b004937df9bcc4mr1747762vkc.4.1694609875558; Wed, 13
 Sep 2023 05:57:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230902182845.1840620-1-ayushdevel1325@gmail.com>
In-Reply-To: <20230902182845.1840620-1-ayushdevel1325@gmail.com>
From:   Jason Kridner <jkridner@beagleboard.org>
Date:   Wed, 13 Sep 2023 08:57:43 -0400
Message-ID: <CA+T6QP=gWS+7WzzyFmMtuN48cExThSQHXGgjAtQQsy_u-bhYDw@mail.gmail.com>
Subject: Re: [PATCH v4 0/3] greybus: Add BeaglePlay Greybus Driver
To:     Ayush Singh <ayushdevel1325@gmail.com>
Cc:     greybus-dev@lists.linaro.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        Vaishnav M A <vaishnav@beagleboard.org>,
        Nishanth Menon <nm@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 2, 2023 at 2:28=E2=80=AFPM Ayush Singh <ayushdevel1325@gmail.co=
m> wrote:
>
> BeaglePlay is a board by BeagleBoard.org. It contains a main AM62
> processor with a CC1352 co-processor. They are connected over UART.
>
> Greybus is a hardware protocol that was designed to provide Unipro with a
> sane application layer. It can be used in IOT and IIOT applications
> keeping the intelligence on the host.
>
> This driver has been tested on BeaglePlay by BeagleBoard.org. It serves
> as Greybus Host device and communicates with BeaglePlay CC1352
> co-processor which serves as Greybus SVC. This replaces the old setup wit=
h
> bcfserial, wpanusb and GBridge. This driver also contains async HDLC code
> since communication with SVC take place over UART using HDLC.

Ayush,

I think part of the problem you are seeing in getting this patch set
accepted is due to a lack of clarity from me on branding. Yes, this is
a Greybus driver that runs on BeaglePlay and talks to specific
firmware running on a CC1352P7 on BeaglePlay, but none of those
individual things explains what this is on its own, it has to be
comprehended a bit more collectively. Together, I've been calling this
the "BeagleConnect" concept and I need to do a bit more to smooth out
the rough edges in the communications, just as you have smoothed out
the rough edges in the implementation by moving GBridge out of
userspace and made a proper Greybus driver.

I have a draft of the concept at
https://docs.beagleboard.org/latest/boards/beagleconnect/index.html,
but it is really in rough form. Let me try to state it here for
clarity and I think you might paraphrase part of it in your next patch
set as I see you've had some comments that likely need to be addressed
such that a v5 will be on the way.

BeagleConnect is both a technology concept and a line of board designs
that implement the technology. Born from Greybus, a mechanism for
dynamically extending a Linux system with embedded peripherals,
BeagleConnect adds two key elements: a 6LoWPAN transport and mikroBUS
manifests. The 6LoWPAN transport provides for arbitrary connections,
including the IEEE802.15.4g long-range wireless transport supported
between BeaglePlay and BeagleConnect Freedom (the first BeagleConnect
board design). The mikroBUS manifests provide for rapid prototyping
and low-node-count production with sensor boards following the
mikroBUS freely-licensable embedded bus standard such that existing
Linux drivers can be loaded upon Greybus discovery of the nodes.

This patch set provides the Linux-side hooks required for the 6LoWPAN
transport for BeagleConnect on BeaglePlay. A different patch set,
currently in RFC, provides the mikroBUS manifest support to complete
the BeagleConnect functionality. (Be sure to use imperative mode if
paraphrasing this in the patch submission).

(If wondering, Beagle hasn't done any patent applications and
considers all public record of describing BeagleConnect technology as
evidence of prior art in public that will hopefully prevent anyone
else from trying to patent it. The name BeagleConnect is a trademark
owned by the BeagleBoard.org Foundation, but anyone should naturally
be able to implement Greybus over 6LoWPAN without any sort of
royalty--we just need to call it something so that people can
recognize compatible devices, so don't implement anything that isn't
interoperable and call it BeagleConnect, please.)

With this said, maybe the names can be a bit more clear? If I haven't
defined terms well enough, let me know.

So, when naming the binding, I'd think something like
"beagle,play-cc1352-connecthost". I removed the redundant use of
"beagle" if that seems right. I think it is accurate from a
hierarchical perspective because it runs on BeaglePlay, it talks to
the cc1352 and the cc1352 needs to be running the BeagleConnect host
firmware.

Hope this helps.

--Jason
(Board president at BeagleBoard.org Foundation)

>
> This driver has been created as a part of my Google Summer of Code 2023.
> For more information, take a look at my blog.
>
> This patchset has been tested over `next-20230825`.
>
> My GSoC23 Blog: https://programmershideaway.xyz/tags/gsoc23/
> Zephyr App: https://git.beagleboard.org/gsoc/greybus/cc1352-firmware
> GitHub Branch: https://github.com/Ayush1325/linux/tree/gb-beagleplay
> Video Demo: https://youtu.be/GVuIB7i5pjk
>
> This the v4 of this patch
> v3 -> v4:
> - Add DT Bindings
> - Reorder commits
> - Improve commit messages
>
> v2 -> v3:
> - Move gb-beagleplay out of staging
>
> v1 -> v2:
> - Combine the driver into a single file
> - Remove redundant code
> - Fix Checkpatch complaints
> - Other suggested changes
>
> Ayush Singh (3):
>   dt-bindings: Add beaglecc1352
>   greybus: Add BeaglePlay Linux Driver
>   dts: ti: k3-am625-beagleplay: Add beaglecc1352
>
>  .../bindings/serial/beaglecc1352.yaml         |  25 +
>  MAINTAINERS                                   |   7 +
>  .../arm64/boot/dts/ti/k3-am625-beagleplay.dts |   4 +
>  drivers/greybus/Kconfig                       |  10 +
>  drivers/greybus/Makefile                      |   3 +-
>  drivers/greybus/gb-beagleplay.c               | 494 ++++++++++++++++++
>  6 files changed, 542 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/devicetree/bindings/serial/beaglecc1352=
.yaml
>  create mode 100644 drivers/greybus/gb-beagleplay.c
>
> --
> 2.41.0
>


--=20
https://beagleboard.org/about/jkridner - a 501c3 non-profit educating
around open hardware computing
