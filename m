Return-Path: <linux-kernel+bounces-25545-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1580282D22A
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jan 2024 23:04:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82DE91F21347
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jan 2024 22:04:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A437B1A287;
	Sun, 14 Jan 2024 22:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="H7xT3mof"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35B47171B1
	for <linux-kernel@vger.kernel.org>; Sun, 14 Jan 2024 22:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2cd84600920so46531151fa.1
        for <linux-kernel@vger.kernel.org>; Sun, 14 Jan 2024 14:03:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1705269835; x=1705874635; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UFYzOX2YkYM9mlUweetGb8tIBD3lmOP9Q6kGfQIYqc8=;
        b=H7xT3mofivda3UqcP0VvZnPxqYkBCzou/v7jh9XgiQYhmrW8e+gEVyM/flr3oC9hU2
         JeVCWucHRP6y8cyjq0AmaxIca+62svGlLSQh+I00SLKY8eLSGmoBFbUI+0uMZh3fpp4W
         EMeeLC3qNpZbbEAThl9iX9cGkfxcWDoqRpcbI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705269835; x=1705874635;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UFYzOX2YkYM9mlUweetGb8tIBD3lmOP9Q6kGfQIYqc8=;
        b=Hqp6bmyZwpjegihXvIPVIxICkrfCw/G/lerMtvVqA16zAm98KoxoEoxrI9i8Xfbeqt
         qhQ8UeF8YsOpBKShginwk723ialBI4GPj8mtOgwHGhBmfJvboXdaSpbE61bNvga+toHi
         cYexdKlsazH9m1LC5DJ6uMLDTBZjfF3JuB7cUzP3FdkHH8AkNwJN2MJgz5Y/ZZaZBLLE
         WWoq2FtNIv65o1O+NI+xPzFcVRe5LOOJZdDHabbAXoRbbrt37y7XIXZQFcyAYqg+fpAu
         Co2rsPtGGF/Lv83vK1RYc1L3IOLwccIy0+1PYOZ5UXGKTE/cJAWB3ld8cKgZ+QgKNWDT
         vUEQ==
X-Gm-Message-State: AOJu0YwBMoTQ9hK8hIpsbX/tKQb0JEi+zmFby6Q8a2aLgGUc3Z+3ieQz
	LvbZX3zWRYyManVRpYmuVeRpwYdlnTSDGe26KMp8/nJ1scq5
X-Google-Smtp-Source: AGHT+IEWv2yawFl+PENi/PRVPWJUrqvbzN41ilVqwWiWkEJiRfjHqZFI7scma/2/EqVvSNL6B22NtwkgadblL/zozOI=
X-Received: by 2002:a2e:a801:0:b0:2cd:ac63:feeb with SMTP id
 l1-20020a2ea801000000b002cdac63feebmr1385925ljq.35.1705269835277; Sun, 14 Jan
 2024 14:03:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+-6iNy03Bz1-Wftf4PpuVFF0FS01d2Yo6coG+gHqwwwpRdFMw@mail.gmail.com>
 <20240111205404.GA2190297@bhelgaas>
In-Reply-To: <20240111205404.GA2190297@bhelgaas>
From: Jim Quinlan <james.quinlan@broadcom.com>
Date: Sun, 14 Jan 2024 17:03:43 -0500
Message-ID: <CA+-6iNyLZV42KqeBwYEE-sxhbE3bbwwbSVii3fY4nmrd0W_LkA@mail.gmail.com>
Subject: Re: [PATCH v8 2/2] PCI: brcmstb: Configure HW CLKREQ# mode
 appropriate for downstream device
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, Nicolas Saenz Julienne <nsaenz@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, 
	Cyril Brulebois <kibi@debian.org>, Phil Elwell <phil@raspberrypi.com>, 
	bcm-kernel-feedback-list@broadcom.com, 
	Florian Fainelli <florian.fainelli@broadcom.com>, Jim Quinlan <jim2101024@gmail.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
	Rob Herring <robh@kernel.org>, 
	"moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" <linux-rpi-kernel@lists.infradead.org>, 
	"moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000cc1490060eef121f"

--000000000000cc1490060eef121f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 11, 2024 at 3:54=E2=80=AFPM Bjorn Helgaas <helgaas@kernel.org> =
wrote:
>
> On Thu, Jan 11, 2024 at 01:20:48PM -0500, Jim Quinlan wrote:
> > On Thu, Jan 11, 2024 at 12:28=E2=80=AFPM Bjorn Helgaas <helgaas@kernel.=
org> wrote:
> > > On Mon, Nov 13, 2023 at 01:56:06PM -0500, Jim Quinlan wrote:
>
> > > > Previously, this driver always set the mode to "no-l1ss", as almost=
 all
> > > > STB/CM boards operate in this mode.  But now there is interest in
> > > > activating L1SS power savings from STB/CM customers, which requires=
 "aspm"
> > > > mode.
> > >
> > > I think this should read "default" mode, not "aspm" mode, since "aspm=
"
> > > is not a mode implemented by this patch, right?
> >
> > Correct.
>
> Thanks, I changed that locally.
>
> > > > In addition, a bug was filed for RPi4 CM platform because most
> > > > devices did not work in "no-l1ss" mode.
> > >
> > > I think this refers to bug 217276, mentioned below?
> >
> > I guess you are saying I should put a footnote marker there.
>
> I added a hint here.
>
> > > > Note: Since L1 substates are now possible, a modification was made
> > > > regarding an internal bus timeout: During long periods of the PCIe =
RC HW
> > > > being in an L1SS sleep state, there may be a timeout on an internal=
 bus
> > > > access, even though there may not be any PCIe access involved.  Suc=
h a
> > > > timeout will cause a subsequent CPU abort.
> > >
> > > This sounds scary.  If a NIC is put in L1.2, does this mean will we
> > > see this CPU abort if there's no traffic for a long time?  What is
> > > needed to avoid the CPU abort?
> >
> > I don't think this happens in normal practice as there are a slew
> > of low-level TLPs and LTR messages that are sent on a regular
> > basis.
>
> OK, I'll have to take your word for this.  I don't know enough about
> PCIe to know what sort of periodic transmissions are required when a
> device is idle.
>
> LTR messages are required when endpoint service requirements change,
> but I wouldn't expect those if the device is idle.
>
> > The only time this timeout occured is when  a major customer
> > was doing a hack: IIRC, their endpoint device has to reboot itself
> > after link-up and driver probe,  so it goes into L1.2 to execute
> > this to reboot and while doing so the connection is completely
> > silent.
>
> > > What does this mean for users?  L1SS is designed for long periods of
> > > the device being idle, so this leaves me feeling that using L1SS is
> > > unsafe in general.  Hopefully this impression is unwarranted, and all
> > > we need is some clarification here.
> >
> > I don't think it will affect most users, if any.
>
> I'll try to get this into -next today or tomorrow.

Bjorn, you are right -- I need to cajole our PCIe HW team to tell me
why this timeout can never
happen and/or why it is not a bug.
Until then,
Jim Quinlan
Broadcom STB/CM


If
>
> Bjorn

--000000000000cc1490060eef121f
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
mOAplh6h3nMZUZxBguxG3g2p3iD4EgibUYneEzqOQafIQB/naf2uetKb8y9jKgWJxq2Y4y8Jqg2u
uVIO1AyOJjWwqdgN+QhuIlat+qZd03P48Gim9ZPEMDUCAwEAAaOCAdswggHXMA4GA1UdDwEB/wQE
AwIFoDCBowYIKwYBBQUHAQEEgZYwgZMwTgYIKwYBBQUHMAKGQmh0dHA6Ly9zZWN1cmUuZ2xvYmFs
c2lnbi5jb20vY2FjZXJ0L2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwLmNydDBBBggrBgEFBQcw
AYY1aHR0cDovL29jc3AuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAw
TQYDVR0gBEYwRDBCBgorBgEEAaAyASgKMDQwMgYIKwYBBQUHAgEWJmh0dHBzOi8vd3d3Lmdsb2Jh
bHNpZ24uY29tL3JlcG9zaXRvcnkvMAkGA1UdEwQCMAAwSQYDVR0fBEIwQDA+oDygOoY4aHR0cDov
L2NybC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAyMC5jcmwwJQYDVR0R
BB4wHIEaamFtZXMucXVpbmxhbkBicm9hZGNvbS5jb20wEwYDVR0lBAwwCgYIKwYBBQUHAwQwHwYD
VR0jBBgwFoAUljPR5lgXWzR1ioFWZNW+SN6hj88wHQYDVR0OBBYEFGx/E27aeGBP2eJktrILxlhK
z8f6MA0GCSqGSIb3DQEBCwUAA4IBAQBdQQukiELsPfse49X4QNy/UN43dPUw0I1asiQ8wye3nAuD
b3GFmf3SZKlgxBTdWJoaNmmUFW2H3HWOoQBnTeedLtV9M2Tb9vOKMncQD1f9hvWZR6LnZpjBIlKe
+R+v6CLF07qYmBI6olvOY/Rsv9QpW9W8qZYk+2RkWHz/fR5N5YldKlJHP0NDT4Wjc5fEzV+mZC8A
AlT80qiuCVv+IQP08ovEVSLPhUp8i1pwsHT9atbWOfXQjbq1B/ditFIbPzwmwJPuGUc7n7vpmtxB
75sSFMj27j4JXl5W9vORgHR2YzuPBzfzDJU1ul0DIofSWVF6E1dx4tZohRED1Yl/T/ZGMYICbTCC
AmkCAQEwazBbMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTExMC8GA1UE
AxMoR2xvYmFsU2lnbiBHQ0MgUjMgUGVyc29uYWxTaWduIDIgQ0EgMjAyMAIMSO43VW7D5NP1X/KD
MA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCDzRDgRhdKLt21D+SAXiI7WFl4Az3mK
EX515JNwHBNm7DAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yNDAx
MTQyMjAzNTVaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjALBglg
hkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsGCSqGSIb3DQEBBzALBglghkgBZQME
AgEwDQYJKoZIhvcNAQEBBQAEggEAgCHH7oP3w3VrZynq6Nf8moEk36paFTCXy2wzejvj4W0obf40
PcyouH6kq9Z1Id213MUNeB+uzQ3EOn5lz8Hqut/rOEF7p8Y33DKRKHLQhZ+LWtNa5t3M9ywwwxJM
Zjne7Q1UFt9f7W6rbF5Drrq73hiH7Oto0ipoGx3FscwMyJOLL9yT0D0VGbCHHBDEhVNuwcft7Dw9
2KIAZl8EuBAgAwo730N0aIIT6pg/5rshgLt5+1YnC+8JqAHX9u+/hdoMH9juXhv3RhISAPET2alL
ePeHMTrOenm36XUC1NT2f7A4jNkhUh9juLnWy7HBf2eKSrrkqk/x326TRiC+0suBtg==
--000000000000cc1490060eef121f--

