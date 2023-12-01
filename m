Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 162C47FFFEF
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 01:12:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377387AbjLAAMU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 19:12:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbjLAAMT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 19:12:19 -0500
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD25D10FD
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 16:12:24 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2c9ccf36b25so15228001fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 16:12:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1701389543; x=1701994343; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w+S6ZNm0KY70bzKBdaXHGr9e7p3t5vwxIYL3G+hCH9Y=;
        b=EgkiEx+Vcd230vMg3k+g1khMK+c/37irFitUfftbLmkI4ENDgI9Hg11raTawsFLvBg
         ThtPknKqohzR7RhnFKEi0fh8/BUGUhpO7meziEFNb+uNz4Mrifx8ZGIcNL9qtbONjUh0
         MS07QKpp73AUuaD2UcQOp+uSSM+wKSXnh1JlYClAl7sFd/ZN1HSA5LX7WtZC1jv9xrpS
         Ft2jse4sT+pgn/7jiIDv6JkhHsJoZWpyTbDOATsrGrR0OaibWQDkfQEURJRZUG1+piTX
         Kd+WCKjx5d9+FlO9qX9O0speDuN7qjHmZrArsy6r3uViBuOE492X6gueHImwp+WHY1fq
         Wh5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701389543; x=1701994343;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w+S6ZNm0KY70bzKBdaXHGr9e7p3t5vwxIYL3G+hCH9Y=;
        b=tA99n+G4X6hWVlN/sWUOnHDv0b7VvN+2Azn9WNv/sWvVv3HfyEB3YhRBcyPJw+ns3g
         LeMJDXMUfW8SIoBInpV6TM2u7Q0piZ1n7qvIwbaCiuz6NztMT+x2o8grv0VtaRouhfE0
         5+qGy1K3DbJy6M5NuHTQKZBC6Sj+jK8GPj7QXEyxXb5bwA2Yv4IVsAPcRykze+lbhceq
         1NeggaaauV6AX/YxZX0h+AgC4NPMomSvHD7/hBxKoSPRajS754OgCkkZ4/vMkcx+2zN6
         //qe9W4lSxcXt/5VSie4XOTGEeEwY5GHXe+YlBPWkdyxIeC7O2TFJILc/MlxOxs6MgA5
         85Fw==
X-Gm-Message-State: AOJu0YywLZujKkln7fDBGaTMRcrLYFi07lH/a7T33N3LBa39FCQSDVAq
        TV9/xatuzNC7CYTBBlp3mAtscaK3yHxEBLSg8Y5ehA==
X-Google-Smtp-Source: AGHT+IGsS1+sHRmFzKHBh3sQJBe24WgzbWubLmdDK9T41aJOvKZPFcBk2x+6D8vxIXt5dM/JwNd7Cmh+ItiUzD/BwPg=
X-Received: by 2002:a05:651c:23a:b0:2c9:d862:c66f with SMTP id
 z26-20020a05651c023a00b002c9d862c66fmr217019ljn.92.1701389542959; Thu, 30 Nov
 2023 16:12:22 -0800 (PST)
MIME-Version: 1.0
References: <20231121-dev-iio-backend-v1-0-6a3d542eba35@analog.com>
 <20231121-dev-iio-backend-v1-10-6a3d542eba35@analog.com> <CAMknhBFbLju8UQJ7Uz85kHKrbK4mzt=wTRdnp40+PwWCJa5dsA@mail.gmail.com>
In-Reply-To: <CAMknhBFbLju8UQJ7Uz85kHKrbK4mzt=wTRdnp40+PwWCJa5dsA@mail.gmail.com>
From:   David Lechner <dlechner@baylibre.com>
Date:   Thu, 30 Nov 2023 18:12:12 -0600
Message-ID: <CAMknhBEdXNkpEt-kXBez7zC0XGvo8AZ1G0Y9Y0XVr2EmpA_Qpw@mail.gmail.com>
Subject: Re: [PATCH 10/12] iio: adc: ad9467: convert to backend framework
To:     nuno.sa@analog.com
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 30, 2023 at 5:30=E2=80=AFPM David Lechner <dlechner@baylibre.co=
m> wrote:
>
> On Tue, Nov 21, 2023 at 4:17=E2=80=AFAM Nuno Sa via B4 Relay

<snip>

> > +       st->back =3D devm_iio_backend_get(&spi->dev, NULL);
>
> Based on the descriptions given of IIO frontend and backend, I was
> expecting this driver to be the backend since SPI is only used to
> configure the chip while the adi-axi-adc driver is the one determining
> the scan data format, providing the DMA (INDIO_BUFFER_HARDWARE), etc.
>
> Also, from a devicetree "describe the hardware" mindset, it doesn't
> seem like this chip (AD9467) should dictate a specific backend. I know
> it doesn't make sense practlically for this chip to not use DMA given
> the high sample rate, but why should the devicetree for this chip
> require it when there is nothing intrensic about this chip itself
> related to DMA?
>

Afterthought:

Put another way, it seems like it would be much easier to say "I, the
arbitrary frontend that actually handles the data from the LVDS
outputs, need a backend that provides a SPI connection to an AD9467
chip and takes care of turning on power supplies" than it is to say
"I, the AD9467 chip frontend, need an arbitrary backend that handles
reading data from the LVDS outputs in a very specific manner that is
determined by the driver, not the hardware".
