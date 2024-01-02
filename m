Return-Path: <linux-kernel+bounces-14434-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0946E821D01
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 14:44:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE58A1C221F9
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 13:44:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCE33101D5;
	Tue,  2 Jan 2024 13:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="k/RCcjZl"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21132FBFC
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jan 2024 13:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a27733ae1dfso408737066b.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jan 2024 05:43:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1704203005; x=1704807805; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+bDRUWUaNZrIC1BDlZCUyBYtQhqnA1B1qkIm9iDYj08=;
        b=k/RCcjZlSoAHvdTvil0lekWH5BcVHwBkuOk5b9MqYdB7xxQWDIhDp9M/6SWis9Df2g
         u8M0mYKmG7ksk7AI/H8R5Q+D4QhzLP91bD3jFpFDLgBJfvmfQRq7cPT+YnoFZsEPQrDP
         eWEdO2RXreCRJEVMrmf5zgSB1107XC8oNBDf3RChelGCmV9JyHTyl4glSDNftJWgxZza
         u8RzrsHGnD7C89XZK4UhjpSVB6p0XHugP2DlLn/aMStX1TKAe/U5TLhpg45T3/zwW0y+
         MeVhM39KDt27I5Cg0s5+BjLaoQxo4DIj9ryjji9jSztdsk6IL/dkZugsu9lei/YwnWjV
         nKKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704203005; x=1704807805;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+bDRUWUaNZrIC1BDlZCUyBYtQhqnA1B1qkIm9iDYj08=;
        b=VJzcA9lAL+zsDzxj7kqH6eh9D45JbnaM/z1Wga8aNQTKeGOVYdazq20FpZzlhx1K99
         kIKMTzlO68clMppJINIcGeW9vRus0ORsB2wS8kMit+mkx6KGO6tRFQNkeIdjRlE0Bwkc
         ApA3VAj+0UYYPEu/NbhYfYdnkZBMMidsZqiHSEuNOdl9PhvMKWPZYZ4iRadLmX1Xw+5y
         4zgd9hkt0RmqaissXyqy8WBznBU3IBp0SOessggL0/6Rkuquc7vFJAoV6klc0kbzRPut
         J+Hcr8zT7ygzrw4PnkyMqQ23SL/GMpsgNCm3PKT0Yp6yPTGMyEAgpc2HI35AeSDlnqxA
         4StQ==
X-Gm-Message-State: AOJu0Yz/Tnov9hY8D87/XlD4T3tommiM0ofrK4WnOZN7s9BggkqNqiXd
	2qcrc/agxADSwdnv6SBP+DynFsbYN/Kaaw==
X-Google-Smtp-Source: AGHT+IHShnGbweLS7L426nki7BjV4U//DR0ctPsYlNzzjkWe/DRESuEXGuRGLoyzbZ+6nP1K4QYbMg==
X-Received: by 2002:a17:906:54:b0:a26:d20a:f3cc with SMTP id 20-20020a170906005400b00a26d20af3ccmr2807342ejg.22.1704203005506;
        Tue, 02 Jan 2024 05:43:25 -0800 (PST)
Received: from localhost (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id ew18-20020a170907951200b00a1dd58874b8sm11679686ejc.119.2024.01.02.05.43.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jan 2024 05:43:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 02 Jan 2024 14:43:24 +0100
Message-Id: <CY49JOEDOEZX.1KNYT91GHL3MX@fairphone.com>
From: "Luca Weiss" <luca.weiss@fairphone.com>
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc: "Konrad Dybcio" <konrad.dybcio@linaro.org>, "Dmitry Baryshkov"
 <dmitry.baryshkov@linaro.org>, "Bjorn Andersson" <andersson@kernel.org>,
 "Rob Herring" <robh+dt@kernel.org>, "Krzysztof Kozlowski"
 <krzysztof.kozlowski+dt@linaro.org>, "Conor Dooley" <conor+dt@kernel.org>,
 "Heikki Krogerus" <heikki.krogerus@linux.intel.com>,
 <cros-qcom-dts-watchers@chromium.org>,
 <~postmarketos/upstreaming@lists.sr.ht>, <phone-devel@vger.kernel.org>,
 <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>
Subject: Re: [PATCH 0/3] Fairphone 5 PMIC-GLINK support (USB-C, charger,
 fuel gauge)
X-Mailer: aerc 0.15.2
References: <20231220-fp5-pmic-glink-v1-0-2a1f8e3c661c@fairphone.com>
 <8d042095-1e09-45cc-9762-909fe8d663a9@linaro.org>
 <CXTU5MLN0YDS.29PPV8KZF8G9R@fairphone.com>
 <CAA8EJpoD3x=kVLu4x2yLtAqCp=wmGSU4ssq5Oj_SD5VQ=GyAYQ@mail.gmail.com>
 <d2007240-2779-4881-8e9d-1c4f5daa55e5@linaro.org>
 <CXU22OZNAH2H.24YIQWBA4KE3C@fairphone.com>
 <2024010227-darn-litmus-4ddf@gregkh>
In-Reply-To: <2024010227-darn-litmus-4ddf@gregkh>

On Tue Jan 2, 2024 at 2:36 PM CET, Greg Kroah-Hartman wrote:
> On Thu, Dec 21, 2023 at 02:45:26PM +0100, Luca Weiss wrote:
> > On Thu Dec 21, 2023 at 1:53 PM CET, Konrad Dybcio wrote:
> > > On 21.12.2023 11:34, Dmitry Baryshkov wrote:
> > > > On Thu, 21 Dec 2023 at 09:33, Luca Weiss <luca.weiss@fairphone.com>=
 wrote:
> > > >>
> > > >> On Wed Dec 20, 2023 at 1:32 PM CET, Konrad Dybcio wrote:
> > > >>> On 20.12.2023 11:02, Luca Weiss wrote:
> > > >>>> This series adds all the necessary bits to enable USB-C role swi=
tching,
> > > >>>> charger and fuel gauge (all via pmic-glink) on Fairphone 5.
> > > >>>>
> > > >>>> One thing that could be made different is the pmic-glink compati=
ble.
> > > >>>> I've chosen to use qcm6490 compatible for it and not sc7280 sinc=
e
> > > >>>> there's plenty of firmware variety on sc7280-based platforms and=
 they
> > > >>>> might require different quirks in the future, so limit this PDOS=
 quirk
> > > >>>> to just qcm6490 for now.
> > > >>>>
> > > >>>> If someone thinks it should be qcom,sc7280-pmic-glink, please le=
t me
> > > >>>> know :)
> > > >>> IMO it's best to continue using the "base soc" (which just so hap=
pened
> > > >>> to fall onto sc7280 this time around) for all compatibles, unless=
 the
> > > >>> derivatives actually had changes
> > > >>
> > > >> Hi Konrad,
> > > >>
> > > >> I think at some point I asked Dmitry what he thought and he mentio=
ned
> > > >> qcm6490. Even found the message again:
> > > >>
> > > >>> well, since it is a firmware thing, you might want to emphasise t=
hat.
> > > >>> So from my POV qcm6490 makes more sense
> > > >>
> > > >> But yeah since it's likely that sc7280 firmware behaves the same a=
s
> > > >> qcm6490 firmware it's probably okay to use sc7280 compatible, wors=
t case
> > > >> we change it later :) I'll send a v2 with those changes.
> > > >=20
> > > > Worst case we end up with sc7280 which has yet another slightly
> > > > different UCSI / PMIC GLINK implementation, but the compatible stri=
ng
> > > > is already taken.
> > > > I still suppose that this should be a qcm6490-related string.
> > > Right, let's keep qcm then
> >=20
> > Ack from my side also. Thanks for the feedback!
>
> This doesn't apply to my tree, where should it be going through?

As far as I can see the dependency for the driver commit 1d103d6af241
("usb: typec: ucsi: fix UCSI on buggy Qualcomm devices") was applied to
Bjorn's qcom tree, so 2/3 should also go there then.

Patch 3/3 (arm64 dts) definitely also Bjorn's qcom tree.

So that leaves patch 1/3 which Bjorn can probably pick up as well but
looking at git log you also picked up some for that file in the past,
dunno.

Regards
Luca

>
> thanks,
> greg k-h


