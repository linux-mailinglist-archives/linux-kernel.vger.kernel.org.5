Return-Path: <linux-kernel+bounces-117552-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA34588B1AB
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 21:37:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 86F91C225D5
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:54:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 802925D737;
	Mon, 25 Mar 2024 17:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZHE1u0cm"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5DA64691;
	Mon, 25 Mar 2024 17:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711386629; cv=none; b=IxkkQlUiq2phVXHQvCd1/4e7rVlpCOLUGafzrMImo1OKQczHrCtqRbZvdIsxCpX/euBD1IxGlDdOrEhHJjCJcNpSoztFFHqvd2y4I6F6U251Q3HEQS4roenK/WfZ0GbXtnNBoEtyBtpwTykXFIiFNyHAZSxdoRMiu7pGSQEGaPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711386629; c=relaxed/simple;
	bh=pFp4gPtTDKexn2npyj7o2olGRBQTvM/rJe6ltASYeT0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lEHptirc7LtJLgshslA6DvRXZK3K4X8m1r5QSS1keWjaM2O4EVoSzMHWKopkWU0XZUhc0je60P3EMTmTdYNT1M1PKDP0wXjgUkmKDiXuXz7KWog4/e2kfUTVfXZ2+u4z302OCycn5ITKCnxxCo0RAc6359MK0B5SsBTvxgJsGg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZHE1u0cm; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2d687da75c4so54141001fa.0;
        Mon, 25 Mar 2024 10:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711386626; x=1711991426; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BwMLgzH6wnxYe3UAd8y0FxS7cIE9QmN5MqBKxy7JrsM=;
        b=ZHE1u0cmtj8AcCfjJmjmqX1zSzJ9gFU1R93ERiu1LLRpBp5zNTk3nLPH2DoURHwe/T
         B6p6T1suif3mHqEWb6Ahs0DIbgjR1epaOsHeJ0hb7T3UhKmuhEx1HPpheBESVFG45vA6
         PgxS4sw4IsGbJ59ABFHHV3PKBtHte9zgU/9M6nsTjktSks86vkACkYX98fyQpU5W1GEf
         6aTu5tH5ku8C5vNIVM6PK9V2989+Z2JOwLR9wUKEQ8145THOXOK63CmIlZqNo0LXpiM5
         ItLPmXB9/C7e4iW/zIyxpRMX5ZTHnWN6BRCMDN60GED3ebl1ZFxYN1Vei3qxIGVxvDIt
         AUTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711386626; x=1711991426;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BwMLgzH6wnxYe3UAd8y0FxS7cIE9QmN5MqBKxy7JrsM=;
        b=LhgCoA3SQdED7jAra2/QXcxVQi9pHTdr0pYI6C1UUcQ1kI4e+1jRsnHvu68JCMJLPL
         wCWVlBXljXU0QUbAgfBHXlI3fauIk7tAOd3r+Ku9QAALx5dvDw5ZeM75lOKK147a7SXU
         AVxv8WBnBUEUytjhJtxu2/dP45NEC7n93ayyp4U5dGI5PlYJwBjfumLi73nTYq0ZAmrM
         Cfy5iAS2eYxI/XobV9VAmfeOoB+QMZrtvzVg87U5RzlJrd2cHLahez878tPtgKGHAN+9
         /SCDQV41uvf2Wy3/9AUFM6K8YI3zAcJGw3Oz3qTc7g6rXsrf91/jI2UWVei9ezeFxS8G
         /oww==
X-Forwarded-Encrypted: i=1; AJvYcCXcXEwQ1xjnoodfHtqz0pxPkM9XqC00rfnB2PJBrXHkY1mOB9ek7SCjG905U861KqdeDNzirECb8ZR0+KZ2qTOkp7NJ6Chmw0NBJwpeMPID6twXRbEL5VpkYiSM53e2kgw0zX40q4MAQvziFtwgrAqQaGiGBHILp6cRwZrznmlDSPZAeIyC
X-Gm-Message-State: AOJu0Yy5acxVv9rWSrxG61MJjBYM+KF/lhVuduQqsy6q68QzUvb++3i5
	8yo5WbdIgaKo27reY7RRNPpAG/gbBjRiOS9bZqnugNuOf4DmEoeJZytP1gRYVKGf2ePXzkgdqsr
	xT81WdydK7hbiYl+LZtzt+/FE5ZdDtIQWj4E=
X-Google-Smtp-Source: AGHT+IH0uLBDu+CPcEXoaO/ggiaMnED1lydzcIxcbXNL3AtmSh1RdhO63bQbgK7wy1bO4NKMyxlFdYHjUYZCH/wcP3E=
X-Received: by 2002:a2e:7804:0:b0:2d6:ab62:2eae with SMTP id
 t4-20020a2e7804000000b002d6ab622eaemr4734300ljc.17.1711386625643; Mon, 25 Mar
 2024 10:10:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240314084412.1127-1-johan+linaro@kernel.org>
 <CABBYNZJV1htg46Gyu=7_iUWdukM+rHLitsLjxmWWYFGXty3tVw@mail.gmail.com>
 <ZfMStHjwtCT1SW3z@hovoldconsulting.com> <964131ff-293d-47d1-8119-a389fa21f385@leemhuis.info>
In-Reply-To: <964131ff-293d-47d1-8119-a389fa21f385@leemhuis.info>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 25 Mar 2024 13:10:13 -0400
Message-ID: <CABBYNZJ0ukd_8=SFzy8CEwgP7hV5unodca0NZ2zDZh+jPJsEFQ@mail.gmail.com>
Subject: Re: [PATCH] Revert "Bluetooth: hci_qca: Set BDA quirk bit if fwnode
 exists in DT"
To: Linux regressions mailing list <regressions@lists.linux.dev>
Cc: Johan Hovold <johan@kernel.org>, Johan Hovold <johan+linaro@kernel.org>, 
	Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Janaki Ramaiah Thota <quic_janathot@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Johan,

On Mon, Mar 25, 2024 at 9:57=E2=80=AFAM Linux regression tracking (Thorsten
Leemhuis) <regressions@leemhuis.info> wrote:
>
> Bluetooth Maintainers, what's...
>
> On 14.03.24 16:07, Johan Hovold wrote:
> > On Thu, Mar 14, 2024 at 10:30:36AM -0400, Luiz Augusto von Dentz wrote:
> >> On Thu, Mar 14, 2024 at 4:44=E2=80=AFAM Johan Hovold <johan+linaro@ker=
nel.org> wrote:
> >
> >>> This reverts commit 7dcd3e014aa7faeeaf4047190b22d8a19a0db696.
> >>>
> >>> Qualcomm Bluetooth controllers like WCN6855 do not have persistent
> >>> storage for the Bluetooth address and must therefore start as
> >>> unconfigured to allow the user to set a valid address unless one has
> >>> been provided by the boot firmware in the devicetree.
> >>>
> >>> A recent change snuck into v6.8-rc7 and incorrectly started marking t=
he
> >>> default (non-unique) address as valid. This specifically also breaks =
the
> >>> Bluetooth setup for some user of the Lenovo ThinkPad X13s.
> >>>
> >>> Note that this is the second time Qualcomm breaks the driver this way
> >>> and that this was fixed last year by commit 6945795bc81a ("Bluetooth:
> >>> fix use-bdaddr-property quirk"), which also has some further details.
> >>>
> >>> Fixes: 7dcd3e014aa7 ("Bluetooth: hci_qca: Set BDA quirk bit if fwnode=
 exists in DT")
> >>> Cc: stable@vger.kernel.org      # 6.8
> >>> Cc: Janaki Ramaiah Thota <quic_janathot@quicinc.com>
> >>> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> >>
> >> Well I guess I will need to start asking for evidence that this works
> >> on regular Linux distros then, because it looks like that is not the
> >> environment Janaki and others Qualcomm folks are testing with.
> >>
> >> What I probably would consider as evidence is bluetoothd logs showing
> >> that the controller has been configured correctly or perhaps there is
> >> a simpler way?
> >
> > Well, in this case we actually want the controller to remain
> > unconfigured (e.g. to avoid having every user of the X13s unknowingly
> > use the same default address).
> >
> > I'm not sure why Qualcomm insists on breaking these quirks, but I guess
> > they just haven't understood why they exist. It's of course convenient
> > to be able to use the default address during development without first
> > having to provide an address, but that's not a valid reason to break th=
e
> > driver.
> >
> > From what I hear the Qualcomm developers only care about Android and I
> > believe they have some out-of-tree hack for retrieving the device
> > address directly from the rootfs.
> >
> > For the X13s, and as I think I've mentioned before, we have been trying
> > to get Qualcomm to tell us how to access the assigned addresses that ar=
e
> > stored in some secure world storage so that we can set it directly from
> > the driver. But until we figure that out, users will need to continue
> > setting the address manually.
>
> ...the plan forward here? This to me sounds like a case where a quick
> revert is the right (interim?) solution, but nevertheless nothing
> happened for ~10 days now afaics. Or am I missing something?
>
> Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
> --
> Everything you wanna know about Linux kernel regression tracking:
> https://linux-regtracking.leemhuis.info/about/#tldr
> If I did something stupid, please tell me, as explained on that page.
>
> #regzbot poke

I guess the following is the latest version:

https://patchwork.kernel.org/project/bluetooth/list/?series=3D836664

Or are you working on a v5?

--=20
Luiz Augusto von Dentz

