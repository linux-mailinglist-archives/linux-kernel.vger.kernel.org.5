Return-Path: <linux-kernel+bounces-117935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DC2C88B457
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 23:41:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 97528C4719C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 20:33:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68B41524B4;
	Mon, 25 Mar 2024 20:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ktz1eJQk"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFFCC6EB69;
	Mon, 25 Mar 2024 20:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711398729; cv=none; b=sjCOhbzlA+01KSjQoZt56vXMxJYP8f3P0siROZtNeQ0Hk7QCa3H/69/qWq+qVm+ocTPZ8nOVZmxXTwdCtNf/lwGLQOGNttu1Jb9BIIUBNeX5PBOb/L+xSAQMxIbLbZl0rZWHru48FZcka5LSCW3wpFV1Fk1wkYTx0ldk9SzzMhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711398729; c=relaxed/simple;
	bh=Y1Qv7WFRuuhXfFyptMkixf3iEE+4tSJqSv5rHXMWASQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cKlgvFn+Y3NnALSEUgYW1KyCYMcjftG2RDb0sljV7N2LfGfTnuN9PCpPP2el4drvDrMvcB96Gd+Dw4yghoe/UMm2H9LXZgyPsb7xI1FHRIJsC1GhIFV36y+FwPnLGFEDwDfx1fPvhg6vZF87oERtKcCOAfCrxPguTxf3pQaPn68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ktz1eJQk; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2d228a132acso66132791fa.0;
        Mon, 25 Mar 2024 13:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711398726; x=1712003526; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h7RKIz/MrNg9cMTI1c37D8VVxet1bDqKEYSB/zPacp8=;
        b=ktz1eJQkNBWg0qpOhYEE2ijuc3jI17rb0piMfkvOaxUW0t6vpIwYKVOIsCcfy4JPVV
         iqBCmpnWofgQ2TmsG7IBHKXs7b3XlBajqBilXEvB6YLnQEPRRbKCacrBmAVeMpr5B5SR
         Hq9eMADab2rCA2wkugGCXOXmEDsfpcQRCLjakDB0auRY/G4sAMXpGk2vGZ+1K4GO9PP5
         JzFbu0YTMls1SKVuaTLOF1kNOoF8WSWzQeWjQGks1VuweQohjQpcGliPyGiw/vlAMKCM
         djAjctOpW+05Q7/a0CiB5OajOG/hQrfpIy/YT3OGZkbcC/fk//P5U63snp8ajOHhazg1
         HM0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711398726; x=1712003526;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h7RKIz/MrNg9cMTI1c37D8VVxet1bDqKEYSB/zPacp8=;
        b=F1nZvH93y1KaVG/bNYJT/ZEJ0UV/pfntbDWF/2+ROM5v5EhwGBRLWoncPmDR495F1+
         WGa62GhMO2jJEhjQpBbnrazqHIHO45UMvkGC3v3hjqKo640GUrIjQef30mX87rilRFz3
         Mv5yLjmS+VdhHZsEap4u3eaLcU4un1xaC/0BWfWY5h2WREfOS4sQ1ikCBeQ7CBTT9GF+
         ZCDmohkooQkMlhWZ7aZuTtNZqFgoXmDtOL7D0LmSD+TwpQOZTWBAIym6wgL29/7o4B9r
         zaKENoVNwjbKqg731zi8VhM05V1utGJMmlxHo6piferUNdqT2BunM3STAmnTMJdyvoo6
         X/2g==
X-Forwarded-Encrypted: i=1; AJvYcCXWu0eJwXQqoqoJsQ66bBGrB3gzlAIkXNzOint+XyvC66ymOaY6t5SZkk973IhOFezpwWqLplsupvIkAuHfxsx09F0MQ7D2zx7YZy7STY0ZaoMpbgpQEbyMlNuOkEaerpAsdupgID+S7u5uX1y6XPei1h4oUkwzz+QqT8T0n0r/u/CVHj8a
X-Gm-Message-State: AOJu0YzELjhedUIyDOzYY2lB7n7c6ZAGIHT2tOxkDOaVIO8ohFcinWEv
	RjjrzghaHYkBIgpCBHvkwJ2DhU1lZeZDXgqf/wasiBUpUL1QIusHT8HEG9+tDK7JRCZiHv3WN7+
	ORucYPHNao/6d7J/VQ+HwlYHA9td5ojMF
X-Google-Smtp-Source: AGHT+IFCzjTe1PrD1iEgUFB5Rziw5BPMZsUhry6xjN8/w0epyu0Je9rqlozlFF04zGALoUPk2yD3Wyk4FTTYaqbbkeI=
X-Received: by 2002:a2e:938e:0:b0:2d4:668f:baac with SMTP id
 g14-20020a2e938e000000b002d4668fbaacmr5741497ljh.28.1711398725984; Mon, 25
 Mar 2024 13:32:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240314084412.1127-1-johan+linaro@kernel.org>
 <CABBYNZJV1htg46Gyu=7_iUWdukM+rHLitsLjxmWWYFGXty3tVw@mail.gmail.com>
 <ZfMStHjwtCT1SW3z@hovoldconsulting.com> <964131ff-293d-47d1-8119-a389fa21f385@leemhuis.info>
 <CABBYNZJ0ukd_8=SFzy8CEwgP7hV5unodca0NZ2zDZh+jPJsEFQ@mail.gmail.com>
 <ZgGzWWV4Lh2Nal--@hovoldconsulting.com> <CABBYNZJaXUhu1A+NyVT-TAJw49zcV6TMdGeVy2F+AVKWBOVC-g@mail.gmail.com>
 <ZgHVFjAZ1uqEiUa2@hovoldconsulting.com> <CABBYNZJUVhNKVD=s+=eYJ1q+j1W8rVSRqM4bKPbxT=TKrnZdoQ@mail.gmail.com>
 <ZgHbPo57UKUxK7G8@hovoldconsulting.com>
In-Reply-To: <ZgHbPo57UKUxK7G8@hovoldconsulting.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 25 Mar 2024 16:31:53 -0400
Message-ID: <CABBYNZJFzDaLdXsdNEP1384JaJEN5E78cgmWfOus_LGOREGsWA@mail.gmail.com>
Subject: Re: [PATCH] Revert "Bluetooth: hci_qca: Set BDA quirk bit if fwnode
 exists in DT"
To: Johan Hovold <johan@kernel.org>
Cc: Linux regressions mailing list <regressions@lists.linux.dev>, Johan Hovold <johan+linaro@kernel.org>, 
	Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Janaki Ramaiah Thota <quic_janathot@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Johan,

On Mon, Mar 25, 2024 at 4:14=E2=80=AFPM Johan Hovold <johan@kernel.org> wro=
te:
>
> On Mon, Mar 25, 2024 at 04:07:03PM -0400, Luiz Augusto von Dentz wrote:
> > On Mon, Mar 25, 2024 at 3:48=E2=80=AFPM Johan Hovold <johan@kernel.org>=
 wrote:
> > > On Mon, Mar 25, 2024 at 03:39:03PM -0400, Luiz Augusto von Dentz wrot=
e:
> > > > On Mon, Mar 25, 2024 at 1:24=E2=80=AFPM Johan Hovold <johan@kernel.=
org> wrote:
> > > > > On Mon, Mar 25, 2024 at 01:10:13PM -0400, Luiz Augusto von Dentz =
wrote:
> > >
> > > > > > I guess the following is the latest version:
> > > > > >
> > > > > > https://patchwork.kernel.org/project/bluetooth/list/?series=3D8=
36664
> > > > > >
> > > > > > Or are you working on a v5?
> > > > >
> > > > > This patch (revert) fixes a separate issue than the series you li=
nk to
> > > > > above, but it is also a prerequisite for that series.
> > > > >
> > > > > v4 is indeed the latest version, and it has been acked by Rob and=
 Bjorn
> > > > > so you can take it all through the Bluetooth tree. Just remember =
to
> > > > > apply this patch (the revert) first.
> > > >
> > > > Doesn't seem to apply cleanly:
> > > >
> > > > Applying: Bluetooth: qca: fix device-address endianness
> > > > error: patch failed: drivers/bluetooth/hci_qca.c:1904
> > > > error: drivers/bluetooth/hci_qca.c: patch does not apply
> > > > Patch failed at 0004 Bluetooth: qca: fix device-address endianness
> > >
> > > Did you apply this patch (the revert) before trying to apply the seri=
es?
> >
> > Probably needs rebasing:
> >
> > Applying: Revert "Bluetooth: hci_qca: Set BDA quirk bit if fwnode exist=
s in DT"
> > error: drivers/bluetooth/hci_qca.c: does not match index
> > Patch failed at 0001 Revert "Bluetooth: hci_qca: Set BDA quirk bit if
> > fwnode exists in DT"
>
> I just verified that it applies cleanly to 6.9-rc1.
>
>         $ git checkout tmp v6.9-rc1
>         $ b4 am -sl ZgHVFjAZ1uqEiUa2@hovoldconsulting.com
>         ...
>         $ git am ./20240314_johan_linaro_revert_bluetooth_hci_qca_set_bda=
_quirk_bit_if_fwnode_exists_in_dt.mbx
>         Applying: Revert "Bluetooth: hci_qca: Set BDA quirk bit if fwnode=
 exists in DT"
>         $ b4 am -sl 20240320075554.8178-2-johan+linaro@kernel.org
>         ...
>         $ git am ./v4_20240320_johan_linaro_bluetooth_qca_fix_device_addr=
ess_endianness.mbx
>         Applying: dt-bindings: bluetooth: add 'qcom,local-bd-address-brok=
en'
>         Applying: arm64: dts: qcom: sc7180-trogdor: mark bluetooth addres=
s as broken
>         Applying: Bluetooth: add quirk for broken address properties
>         Applying: Bluetooth: qca: fix device-address endianness
>
> Do you have anything else in your tree which may interfere? What tree is
> that exactly?

bluetooth-next tree, why would it be anything other than that? All the
CI automation is done on bluetooth-next and if you are asking to be
done via bluetooth tree which is based on the latest rc that is not
how things works here, we usually first apply to bluetooth-next and in
case it needs to be backported then it later done via pull-request.

> Johan



--=20
Luiz Augusto von Dentz

