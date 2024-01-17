Return-Path: <linux-kernel+bounces-29515-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CFCD830F83
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 23:49:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD1F928AE39
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 22:49:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0626724B25;
	Wed, 17 Jan 2024 22:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iIVKaUCh"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E9461E87F;
	Wed, 17 Jan 2024 22:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705531764; cv=none; b=KCWEIPMAeRVp2hEMG3HYRHP8G7T+muA2FYTZD8e3mA4NtBXprKEdUXQVrEqmaUcsFBz+zkUuxexkElHEAjr0/S3W6YghErQTOG/d7lAyoGq9JMlzORQmzE61L4t7WL1/yZ1SKd2kl9LRsZpIFbp0ee7X4FkX+ehwNg6Vp4HcwrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705531764; c=relaxed/simple;
	bh=qaE/HlWhBZGUp+I9ZP25s5E7Fw4PribzaVcu0eirskc=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding; b=S59IA3M2IZVU5GSBe01KNd3izmr9i8dTQzTTN5Z6nZtc2codFpOjbxe7o2TONHGUkq+9FRkbTY5xLwvJKWIoshNXBMAGvuSVaZHVgd0ECd85cCCksBtGqr51CUF5gGdGi+H0s0+Z/dd0pnB1Oy9sRL3QsnwMR5BHKfHiOzy+qkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iIVKaUCh; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2cd2f472665so123538171fa.2;
        Wed, 17 Jan 2024 14:49:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705531760; x=1706136560; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9/mowEtNIcXszHVTA9q/88Y6qPyzZTlnvSSg/H5073M=;
        b=iIVKaUChX9CXCmbFeQ7zAO48WoaIyCbPgpIjTjxU+Wcim++YI8r4FFBJhEmDxF5Bdn
         Pop2+iI/0oAY1bldPdZokSI4CFI46H/vnx2cnbNoNu9O5Pd/ESK6nNhDHb/aBMALGPNE
         NWm3TEBSLSS+rj5VmsYnN/nKUObq+qJBCb+TB+d2ApFYsmiXArgwL0JhNQyAHFYIdm55
         Y5pP+hmLtmPo+j3H7yb1GzvJIoz/5bmMYLY8ZymGgG3Wq2rfnrPYRNhq4W9DJy8soThJ
         ZxqdMtSTUQF7eeg4uBrLkMyDLhtDNhKGw7CSjoFGU2O8IQX46llokz3adSqHb/eDQTJw
         HKkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705531760; x=1706136560;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9/mowEtNIcXszHVTA9q/88Y6qPyzZTlnvSSg/H5073M=;
        b=kh8BfgiakWlwOgLzzHEldSElysIt7FeGyOeGRL85+SwcLCzOvpgMkFHaGdfURpkUbz
         quVL2Ck5JJ+M/ofk7qx3AC12nEOt6cZyuGZ2OaYo8YXcDlUOk9vSbHBJ48KWA3OYdnFk
         P27to6enh4lfB9P8ahjEeWOlvworoIHl7hqxHiJuy6dNu3cwpoVLPiWYTVyRWkpUjh3H
         kFCBY0DYitkEwr2OD4a6BipUWnITqvI0j8fCFqP8btgOiOgGLyoYfFg30pa9QL6LnVgQ
         mlXtbUD9WwHLaDkW5Go48R/OlwmKsnRKfRq+6/4hZgD/tamwaAYo6ehXQo5k6cnz/3lQ
         6HDQ==
X-Gm-Message-State: AOJu0YyrsgVaR4+R0E3zh/ZJC9dyvIWvhX4CwTwt7bfjB/Y4VGo6pnX7
	IdAar9MzvNH7n9NMyHtt9cQ6GnExmqVJPBz71tM=
X-Google-Smtp-Source: AGHT+IEUPDQNOlmNlr9Q7Qccr51WOHkRZxqKucf6Ci5wug+N0hT4DADtN5YAKbeFLlZqrJzLfSQ7B68V+QZk4yoFQuw=
X-Received: by 2002:a2e:b6c1:0:b0:2cd:279a:d3a9 with SMTP id
 m1-20020a2eb6c1000000b002cd279ad3a9mr4183206ljo.51.1705531760260; Wed, 17 Jan
 2024 14:49:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231227180306.6319-1-johan+linaro@kernel.org>
 <ZZ15c1HUQIH2cY5o@google.com> <ZZ1-ehpU-g6i9Qem@hovoldconsulting.com>
 <ZZ2IOQEekFffJoHQ@google.com> <ZZ5RVpL88XNbgKIy@hovoldconsulting.com>
In-Reply-To: <ZZ5RVpL88XNbgKIy@hovoldconsulting.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 17 Jan 2024 17:49:07 -0500
Message-ID: <CABBYNZJ_EAuGEdeW+vZzXu20nVqLkLwiQbYQ9XzoABxQ5rAzdQ@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: qca: fix device-address endianness
To: Johan Hovold <johan@kernel.org>
Cc: Matthias Kaehlcke <mka@chromium.org>, Johan Hovold <johan+linaro@kernel.org>, 
	Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg <johan.hedberg@gmail.com>, 
	Bjorn Andersson <quic_bjorande@quicinc.com>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	linux-bluetooth@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Balakrishna Godavarthi <quic_bgodavar@quicinc.com>, Doug Anderson <dianders@google.com>, 
	Stephen Boyd <swboyd@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Johan,

On Wed, Jan 10, 2024 at 3:12=E2=80=AFAM Johan Hovold <johan@kernel.org> wro=
te:
>
> On Tue, Jan 09, 2024 at 05:54:01PM +0000, Matthias Kaehlcke wrote:
> > On Tue, Jan 09, 2024 at 06:12:26PM +0100, Johan Hovold wrote:
>
> > > That depends on in what way the current devices are broken.
> > >
> > > Any machines that correctly specify their address in little-endian or=
der
> > > in the devicetree would no longer be configured using the wrong addre=
ss.
> > > So no problem there (except requiring users to re-pair their gadgets)=
.
> > >
> > > And tools like btgmt is broken on all of these Qualcomm machine in an=
y
> > > case and would now start working as expected. So no problem there eit=
her
> > > (unless user space had adapted an inverted the addresses to btmgmt).
> > >
> > > So the first question is whether there actually is any boot firmware =
out
> > > there which passes the BD_ADDR in reverse order?
> >
> > Yes, (at least) the boot firmware for sc7180-trogdor devices.
> >
> > hexdump -C /proc/device-tree/soc\@0/geniqup\@8c0000/serial\@88c000/blue=
tooth/local-bd-address
> > 00000000  8c fd f0 40 15 dc
>
> Indeed, this should have been LE order.
>
> > hciconfig
> > hci0:   Type: Primary  Bus: UART
> >         BD Address: 8C:FD:F0:40:15:DC  ACL MTU: 1024:8  SCO MTU: 240:8
> >         UP RUNNING
> >         RX bytes:1700 acl:0 sco:0 events:95 errors:0
> >         TX bytes:128949 acl:0 sco:0 commands:578 errors:0
>
> And any user space tool overriding the address would currently need to
> provide the address in reverse order on Qualcomm platforms like this
> one (e.g. if generating the address for privacy reasons).

Perhaps we could attempt to resolve the address byteorder, in
userspace we use hwdb_get_company to resolve the company but since
this shall only really care about Qualcomm range(s) perhaps we can
hardcode them check in which order the address is, that said if the
device is configured with a Static Random Address then that would not
work, but that is only really possible for BLE only devices.

> > > > I suggest adding a quirk like 'local-bd-address-msb-quirk' or
> > > > 'qcom,local-bd-address-msb-quirk' to make sure existing devices kee=
p
> > > > working properly.
> > >
> > > I don't think that would work. If this is something that we really ne=
ed
> > > to handle, then there's probably no way around introducing new
> > > compatible strings for boot firmware that isn't broken while maintain=
ing
> > > the current broken behaviour with respect to 'local-bd-address' for s=
ome
> > > of the current ones.
> >
> > I think it should work for sc7180-trogdor. For these devices the device=
 tree
> > is bundled with the kernel image and can be updated. That might not be =
true
> > for other devices though.
>
> Thanks for confirming.
>
> I'm still hoping we can get away with not having to add quirks to
> Bluetooth core for broken Qualcomm boot firmware. Let's see if anyone
> knows of a use case that makes that impossible to avoid.
>
> Johan



--=20
Luiz Augusto von Dentz

