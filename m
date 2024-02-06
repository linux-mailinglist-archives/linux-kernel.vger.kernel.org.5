Return-Path: <linux-kernel+bounces-55721-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4873C84C0C7
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 00:20:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1E8E1F25803
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 23:20:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B8811CD1F;
	Tue,  6 Feb 2024 23:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="vHnXIfK6"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53C731CF96
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 23:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707261605; cv=none; b=lBBuRLKQM2IIB9DtlxTmu710xeEu+YKqa/J2piNfqA070yYSl9IkaNx9q1VzAr3QL9l1xiWAQVM1FHW2yDGM7No5AJaBoZKut35flIPAa82PGoCFS/8yrcUTV8kx/BVK7CS8eMFbA1OmCF1TMjU0Uqa+vX3bUdI5k3ByPhv91Mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707261605; c=relaxed/simple;
	bh=m+y3HMZaCJPRB55/Kjusqw16ffP7mgbzzM/LpvoQeJI=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=R5L/DfyjTdLHgHPfNV3ObjkX73pGJlVYLK1rq6xJGUba/39TpPhsCCv/Tykqn8t+kW3RbMHNc+5L574I65ahS7VP7fIxeZ3P9/H0ryZ7GQu6yla3sWWDaJla+AT/TFDtLAtw+VQvKvfPrR9Ez7HptM+j9dvZQFjfGplYDfSJmXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=vHnXIfK6; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-40f02b8d176so54060815e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Feb 2024 15:20:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1707261601; x=1707866401; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m+y3HMZaCJPRB55/Kjusqw16ffP7mgbzzM/LpvoQeJI=;
        b=vHnXIfK6P4iQ7iPcy+7IpycNZg7dLVdr0ew0To/mKZBzYuGjPsjKCUEpM5YD1sjgHt
         /RaG8dTJRUf0etD/2x0Q/14QP1+Tp1+isboMEHWZb3569PInWqye9GqaQVvIluNb2rPo
         XmcPlxXAIBrDieI24RiDbCwsq96O76a+0uq/FMn0XfTBpxHXgX2b4DOsloCHlWJTYITB
         iQyvXcUd7CWX1sqlf8c1J9lmRmdvTrENpPvE5lGUYjKr4D2iXquFOEeDm0Nd2Gxl9MiT
         Ynh55NqzjegdY+oOGTKIQ576noGsom5wCjCvn81Th2Z6HUvgZ1wjnWCwSgZGmVj72Npk
         3Tvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707261601; x=1707866401;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=m+y3HMZaCJPRB55/Kjusqw16ffP7mgbzzM/LpvoQeJI=;
        b=JMdEYut/ICel1awPfN2qJm+cMZNJMhNHsuqXnwpAIUkjddgp5OkXrYGcMGpdEgK56h
         9FuETaFP/WNhFSSoCReq7K1Ob6bkP68AKC/jbKfcIEjxpKil3unoEGnII2hLqNTyvX2W
         sPSjHBtHJthF0fz8lGjLTqQSKO2RKqUU/5R1cXcVc0pqgq3KHLmFmZ07MVdeFRetWuw6
         g+OT6O5wf6/nlk3kiEhw4EEyfL0xMxG2l5v6uQMBve0dDelVRAXBT4yHSBqb1HCDCQuX
         CDDaNDUOLhvV5km/8tSv15x4VOlNfUtho7aRrZy2iSAers64HK1D3TC7+w7YDRPAySQs
         K8kQ==
X-Gm-Message-State: AOJu0YxLahNXwB74Gw1IAXH+/+rEuqk+kIYtw8Gedktylbn0PK1fINdl
	ikdkmZbjX8xq+PUwsscdZfWISYlAoMVKu2wMu12LDu/KiOgWmPGXnez1gqnlJqI=
X-Google-Smtp-Source: AGHT+IENEbuIMFynxRe+Wi8NPp/CqyeM5LxIUwCMDFcU8gLj2jdJ1ytLAYX5dqEHv+2zydbn5noB1w==
X-Received: by 2002:a5d:598a:0:b0:33b:47cf:323b with SMTP id n10-20020a5d598a000000b0033b47cf323bmr2925394wri.9.1707261601525;
        Tue, 06 Feb 2024 15:20:01 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW349EHlkXDDbsZmbwaYsfxA2vIENiEKgFzpRZaaftD9z0CCD4Zj8CiKAkYwXT1IoZ/auwb1D3EOpPzDwkAwWoyEta0RG4Pgjj3v7Vq9gGhdJHj2CCAsKFymL3j0xZwEb84+sfzsCauHMExyFe5W0jyk94yJE9x+Ia/8xAcXJHc6qyzQ9XDzt0nj1DzUSfX9gs8F4RZmnPVGJ4PL3/s7JL4PR2aRSDawhmX52F86ewDGMsKzJyzY+0YIb2KURSNWnZw7jj1DOdi1okWBR9gISm6SY64ScpgvRBqiykC07EP5W+fxDCxZGCTdGNxz5oz+Q5FtE7hjKnHsTZBePmi1fN7Q1OpzI9tHngZ6BROJos4ITKTf/51HOCGzqTyIjSzhD5U8cnmYsXAlfRImTy5Q61h6Duxwf8ujHtcvpCyLfxyH3x0c2mI+3MQEftZd4nSgFAz0GrUG+mrYyZRch2IIc6cVaPyqX1tOQmDt9WlLY8nvJTDDBzcmagBoR5xgYAdQkPhb2jNrzdtNVb5w7LzgLAee7sTGO62aJANQW9TxJ/Czejd1nsKzhNelRV1
Received: from localhost ([2a02:a03f:6aef:6800:2f37:ce90:b91c:e85a])
        by smtp.gmail.com with ESMTPSA id s17-20020a5d4ed1000000b0033b17880eacsm94734wrv.56.2024.02.06.15.20.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Feb 2024 15:20:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 07 Feb 2024 00:20:00 +0100
Message-Id: <CYYDQ7RF0HB7.G7R6KHP1Z42U@fairphone.com>
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
From: "Luca Weiss" <luca.weiss@fairphone.com>
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
X-Mailer: aerc 0.15.2
References: <20231220-fp5-pmic-glink-v1-0-2a1f8e3c661c@fairphone.com>
 <8d042095-1e09-45cc-9762-909fe8d663a9@linaro.org>
 <CXTU5MLN0YDS.29PPV8KZF8G9R@fairphone.com>
 <CAA8EJpoD3x=kVLu4x2yLtAqCp=wmGSU4ssq5Oj_SD5VQ=GyAYQ@mail.gmail.com>
 <d2007240-2779-4881-8e9d-1c4f5daa55e5@linaro.org>
 <CXU22OZNAH2H.24YIQWBA4KE3C@fairphone.com>
 <2024010227-darn-litmus-4ddf@gregkh>
 <CY49JOEDOEZX.1KNYT91GHL3MX@fairphone.com>
 <2024010205-placidly-expire-221c@gregkh>
In-Reply-To: <2024010205-placidly-expire-221c@gregkh>

On Tue Jan 2, 2024 at 2:53 PM CET, Greg Kroah-Hartman wrote:
> On Tue, Jan 02, 2024 at 02:43:24PM +0100, Luca Weiss wrote:
> > On Tue Jan 2, 2024 at 2:36 PM CET, Greg Kroah-Hartman wrote:
> > > On Thu, Dec 21, 2023 at 02:45:26PM +0100, Luca Weiss wrote:
> > > > On Thu Dec 21, 2023 at 1:53 PM CET, Konrad Dybcio wrote:
> > > > > On 21.12.2023 11:34, Dmitry Baryshkov wrote:
> > > > > > On Thu, 21 Dec 2023 at 09:33, Luca Weiss <luca.weiss@fairphone.=
com> wrote:
> > > > > >>
> > > > > >> On Wed Dec 20, 2023 at 1:32 PM CET, Konrad Dybcio wrote:
> > > > > >>> On 20.12.2023 11:02, Luca Weiss wrote:
> > > > > >>>> This series adds all the necessary bits to enable USB-C role=
 switching,
> > > > > >>>> charger and fuel gauge (all via pmic-glink) on Fairphone 5.
> > > > > >>>>
> > > > > >>>> One thing that could be made different is the pmic-glink com=
patible.
> > > > > >>>> I've chosen to use qcm6490 compatible for it and not sc7280 =
since
> > > > > >>>> there's plenty of firmware variety on sc7280-based platforms=
 and they
> > > > > >>>> might require different quirks in the future, so limit this =
PDOS quirk
> > > > > >>>> to just qcm6490 for now.
> > > > > >>>>
> > > > > >>>> If someone thinks it should be qcom,sc7280-pmic-glink, pleas=
e let me
> > > > > >>>> know :)
> > > > > >>> IMO it's best to continue using the "base soc" (which just so=
 happened
> > > > > >>> to fall onto sc7280 this time around) for all compatibles, un=
less the
> > > > > >>> derivatives actually had changes
> > > > > >>
> > > > > >> Hi Konrad,
> > > > > >>
> > > > > >> I think at some point I asked Dmitry what he thought and he me=
ntioned
> > > > > >> qcm6490. Even found the message again:
> > > > > >>
> > > > > >>> well, since it is a firmware thing, you might want to emphasi=
se that.
> > > > > >>> So from my POV qcm6490 makes more sense
> > > > > >>
> > > > > >> But yeah since it's likely that sc7280 firmware behaves the sa=
me as
> > > > > >> qcm6490 firmware it's probably okay to use sc7280 compatible, =
worst case
> > > > > >> we change it later :) I'll send a v2 with those changes.
> > > > > >=20
> > > > > > Worst case we end up with sc7280 which has yet another slightly
> > > > > > different UCSI / PMIC GLINK implementation, but the compatible =
string
> > > > > > is already taken.
> > > > > > I still suppose that this should be a qcm6490-related string.
> > > > > Right, let's keep qcm then
> > > >=20
> > > > Ack from my side also. Thanks for the feedback!
> > >
> > > This doesn't apply to my tree, where should it be going through?
> >=20
> > As far as I can see the dependency for the driver commit 1d103d6af241
> > ("usb: typec: ucsi: fix UCSI on buggy Qualcomm devices") was applied to
> > Bjorn's qcom tree, so 2/3 should also go there then.
> >=20
> > Patch 3/3 (arm64 dts) definitely also Bjorn's qcom tree.
> >=20
> > So that leaves patch 1/3 which Bjorn can probably pick up as well but
> > looking at git log you also picked up some for that file in the past,
> > dunno.
>
> Ok, for any remaining ones that want to be merged before 6.8-rc1 is out,
> feel free to add my:
>
> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>
> If they don't get picked up by 6.8-rc1, feel free to rebase and send it
> for me to take through my tree.

Hi Greg,

This applies cleanly on -next as of next-20240206 still.

Could you please pick it up for v6.9? I can also send a v2 with only
the two remaining patches (dts was applied to qcom by Bjorn already).

Regards
Luca

>
> thanks,
>
> greg k-h


