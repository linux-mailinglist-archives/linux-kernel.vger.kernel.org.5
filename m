Return-Path: <linux-kernel+bounces-49509-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 67E88846B49
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 09:53:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C5C91C219ED
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 08:53:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C03060862;
	Fri,  2 Feb 2024 08:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="Mn66opd0"
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 029166087F
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 08:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706864016; cv=none; b=J/MKB7VaTXWHHiDIaC/gFBb0C+KIUl0WA+1uQHvKduPlzHbOJyStQhnFglgYwNRo5wa2iC6I9B7zoU31ealSsYpztssYUh1dfuGI1vMbT+Qq177kKiyIbX2NTKwLQRiQ6txCGEcSPJEo6kL69CgLAAN2xNa/Z4jXfDhQLyT5C4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706864016; c=relaxed/simple;
	bh=6jJF3I5RQlfKmEysGWvz+9eVXHYV0GPPm4uqzgG+YWE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lSiEESaiEBhwSyAGXW6HYg8QQDig1bcbewpSE1KA2hWXwEuqDc7qEomxVv5P7gGzwHKONzyHz7gyuRn3Q7SwEBzerLxT+sRj6OLrSNtC0wSuXsOMDfg576shHel9dZk8A0JxRTNxMl++K6ZcLjar42B+NYYN6nG/AOwqSxX/dBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=Mn66opd0; arc=none smtp.client-ip=209.85.217.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-46cf02b9f7eso568876137.3
        for <linux-kernel@vger.kernel.org>; Fri, 02 Feb 2024 00:53:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1706864013; x=1707468813; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fweGICSQuC+kkWu0MFeaJvTIV5rHykluRzEMbGnW8LY=;
        b=Mn66opd0Oro3u+o1/DG9Hr/evljHZby1wbdYApW8v/qJLcmMHXxWrnW1qzQQ6iQ5w1
         XmETIrkQsxxke4h9/ErrOuDFSEb4DUIWj42V0aPP77Yk8+tYRNnAX8an4SxmviOmOHv7
         hikYk3F3sVx7PAe57TqcpEy7aOPD/NY0yTeS4jXHNGlmlBYh8tvFruPUpHnKgFWMviAp
         0zyCkHdm+1X93/LOqdtHIQopBV9YVMHKSNTefxpBA5gQxlU/lDp600RN2BpmOP4BT4tM
         abMRWPD0sn9NVidJmQEIVzoP0VLmJ+fGxo3TxYzaKtoKo/Eoe/kzl2K5C91WbkA61ln7
         91dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706864013; x=1707468813;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fweGICSQuC+kkWu0MFeaJvTIV5rHykluRzEMbGnW8LY=;
        b=NVm0inxYY6iyzbuf/34QkMmyNpw7sigdMafzpSqnZul8p/VHsEybMz4Wr56053zuNA
         3NldJIboYiD0j3iUU0oWjwQgaoV9KV4r+NNrzhIerdO3kI0LgN4/TIW2UFJ/0NrCDln7
         RStOilpZuoLaYwCBjQcHGcZgDOV2/+is2Ijh4mQv9nmUeCw/xAmh7hqlcHUlgPeP14Lw
         QC2ftmYgOle5OQuoPNKOMYA2aXce2oDs/xr3R91w0HYblrY1w862BG/hdZPZa1CHGOAt
         w2FbDbQJ1ABhDBR9epvJmUsJx9KGBAsll8IEUA5kyz/zk8REdqzoe1WCHygFxjz3O89s
         EsLA==
X-Gm-Message-State: AOJu0YyrQakyBy+xGGHYq01Q41w/3h0xxQv04D4w7iyfl02uqJ7/rvzg
	bykaF5wwLsBh/sebhvTTw0cX5iX7VuqZEEnTS/D5yUXC47f6RG5PB+6aNpr4qWEE2mbG/+tWt0P
	JtlrJ/CrncZYx9Mv+/cjqNMwQGqDIZFc8dBX9CA==
X-Google-Smtp-Source: AGHT+IEE+tz3AhgGkJ5fHg3WomvfRi7OSRDt6jRo6sSUxFz6L/3wUjPw6MpyMT6PwjPDO7tO7EtfzmiT4yeJjqGEHZ4=
X-Received: by 2002:a05:6102:3f4d:b0:46c:f612:9515 with SMTP id
 l13-20020a0561023f4d00b0046cf6129515mr4187903vsv.15.1706864012789; Fri, 02
 Feb 2024 00:53:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240201155532.49707-1-brgl@bgdev.pl> <xdef5sjo5bvdvgx2ezgubeboos45mkeb2dcua63qhmztqrk6ja@m5ylrmdrwmia>
In-Reply-To: <xdef5sjo5bvdvgx2ezgubeboos45mkeb2dcua63qhmztqrk6ja@m5ylrmdrwmia>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Fri, 2 Feb 2024 09:53:21 +0100
Message-ID: <CAMRc=MdZy+niwU19Ey8CQ7=TYS711YfiZ8B0=YHaFCxqRw2MsQ@mail.gmail.com>
Subject: Re: [RFC 0/9] power: sequencing: implement the subsystem and add
 first users
To: Bjorn Andersson <andersson@kernel.org>
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Alex Elder <elder@linaro.org>, Srini Kandagatla <srinivas.kandagatla@linaro.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, 
	Abel Vesa <abel.vesa@linaro.org>, Manivannan Sadhasivam <mani@kernel.org>, Lukas Wunner <lukas@wunner.de>, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org, 
	linux-pci@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 2, 2024 at 1:40=E2=80=AFAM Bjorn Andersson <andersson@kernel.or=
g> wrote:
>
> On Thu, Feb 01, 2024 at 04:55:23PM +0100, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
>
> We now have 3 RFC and 1 PATCH versions of these patches on the list in
> under a month. Please at least add a version to your subject...
>

So there was an RFC for the PCI power sequencing (now renamed to PCI
power control - pci_pwrctl), then a proper series for it (with changes
listed). Then an RFC with just proposed DT changes (sent mostly to DT
maintainers to clear it with them) and now an RFC with power
sequencing + PCI power control. Hard to figure out how to version it
if these are pretty much separate developments.

I'll provide links to everything next time.

> > I'd like to preface the cover letter by saying right away that this
> > series is not complete. It's an RFC that presents my approach and is se=
nt
> > to the list for discussion. There are no DT bindings nor docs in
> > Documentation/ yet. Please review it as an RFC and not an upstreambound
> > series. If the approach is accepted as correct, I'll add missing bits.
> >
> > The RFC[1] presenting my proposed device-tree representation of the
> > QCA6391 package present on the RB5 board - while not really officially
> > accepted - was not outright rejected which is a good sign.
> >
> > This series incorporates it and builds a proposed power sequencing
> > subsystem together with the first dedicated driver around it. Then it
> > adds first two users: the Bluetooth and WLAN modules of the QCA6391.
> >
> > The Bluetooth part is pretty straightforward. The WLAN however is a PCI=
e
> > device and as such needs to be powered-up *before* it's detected on the
> > PCI bus. To that end, we modify the PCI core to instantiate platform
> > devices for existing DT child nodes of the PCIe ports. For those nodes
> > for which a power-sequencing driver exists, we bind it and let it probe=
.
> > The driver then triggers a rescan of the PCI bus with the aim of
> > detecting the now powered-on device. The device will consume the same D=
T
> > node as the platform, power-sequencing device. We use device links to
> > make the latter become the parent of the former.
> >
> > The main advantage of the above approach (both for PCI as well as
> > generic power sequencers) is that we don't introduce significant change=
s
> > in DT bindings and don't introduce new properties. We merely define new
> > resources.
> >
>
> How can we tell? There are still no Documentation/dt-bindings changes in
> your series.

Noted.

Bartosz

>
> Regards,
> Bjorn
>
> > [1] https://lore.kernel.org/all/CAMRc=3DMckG32DQv7b1AQL-mbnYdx4fsdYWtLw=
CyXc5Ma7EeSAKw@mail.gmail.com/T/#md5dc62007d12f6833d4e51658b14e0493954ba68
> >
> > Bartosz Golaszewski (9):
> >   of: provide a cleanup helper for OF nodes
> >   arm64: dts: qcom: qrb5165-rb5: model the PMU of the QCA6391
> >   power: sequencing: new subsystem
> >   power: pwrseq: add a driver for the QCA6390 PMU module
> >   Bluetooth: qca: use the power sequencer for QCA6390
> >   PCI: create platform devices for child OF nodes of the port node
> >   PCI: hold the rescan mutex when scanning for the first time
> >   PCI/pwrctl: add PCI power control core code
> >   PCI/pwrctl: add a PCI power control driver for power sequenced device=
s
> >
> >  arch/arm64/boot/dts/qcom/qrb5165-rb5.dts  | 128 +++++-
> >  arch/arm64/boot/dts/qcom/sm8250.dtsi      |  10 +
> >  drivers/bluetooth/hci_qca.c               |  30 ++
> >  drivers/pci/Kconfig                       |   1 +
> >  drivers/pci/Makefile                      |   1 +
> >  drivers/pci/bus.c                         |   9 +-
> >  drivers/pci/probe.c                       |   2 +
> >  drivers/pci/pwrctl/Kconfig                |  17 +
> >  drivers/pci/pwrctl/Makefile               |   4 +
> >  drivers/pci/pwrctl/core.c                 |  82 ++++
> >  drivers/pci/pwrctl/pci-pwrctl-pwrseq.c    |  83 ++++
> >  drivers/pci/remove.c                      |   2 +
> >  drivers/power/Kconfig                     |   1 +
> >  drivers/power/Makefile                    |   1 +
> >  drivers/power/sequencing/Kconfig          |  28 ++
> >  drivers/power/sequencing/Makefile         |   6 +
> >  drivers/power/sequencing/core.c           | 482 ++++++++++++++++++++++
> >  drivers/power/sequencing/pwrseq-qca6390.c | 232 +++++++++++
> >  include/linux/of.h                        |   4 +
> >  include/linux/pci-pwrctl.h                |  24 ++
> >  include/linux/pwrseq/consumer.h           |  53 +++
> >  include/linux/pwrseq/provider.h           |  41 ++
> >  22 files changed, 1229 insertions(+), 12 deletions(-)
> >  create mode 100644 drivers/pci/pwrctl/Kconfig
> >  create mode 100644 drivers/pci/pwrctl/Makefile
> >  create mode 100644 drivers/pci/pwrctl/core.c
> >  create mode 100644 drivers/pci/pwrctl/pci-pwrctl-pwrseq.c
> >  create mode 100644 drivers/power/sequencing/Kconfig
> >  create mode 100644 drivers/power/sequencing/Makefile
> >  create mode 100644 drivers/power/sequencing/core.c
> >  create mode 100644 drivers/power/sequencing/pwrseq-qca6390.c
> >  create mode 100644 include/linux/pci-pwrctl.h
> >  create mode 100644 include/linux/pwrseq/consumer.h
> >  create mode 100644 include/linux/pwrseq/provider.h
> >
> > --
> > 2.40.1
> >

