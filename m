Return-Path: <linux-kernel+bounces-142020-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BE3C8A2647
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 08:13:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4F7F28743F
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 06:13:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B3DA2374D;
	Fri, 12 Apr 2024 06:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b56st5sr"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB4C71759F;
	Fri, 12 Apr 2024 06:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712902396; cv=none; b=hfxD5irNQAKVqQrOkpn7ucZFFusmIeoDh/WSvhvvcb2aP7d7el4bx6Ux7G4zvk5MpUpt0r/2+N7y14oAKz9aflTOkxkxNrbDcqXaQ+IYaeeBoUefoH0iKcFhXLXi0mJjJmNsuapADSA6hdHtm9DI6rAXcwbDWVVNTFLTCak94uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712902396; c=relaxed/simple;
	bh=ZOQ9bpjvf/6reQsS6q1TZnUe9UNjGabsh8ljks9sWFw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IyfRiGHiIpsFbOkLGjgV9BEKy0EUSQh3GrzjZ94RQY8AyXe8VpLu0qg/jfcxUMR1fyM4qjv5JN0ShsIbVoTGaK0GMcJgIhZtRgns773tt6Q96NZm0T8q0JVjjxi2Nl2kQhDH62BNj2e31VF/7vnw5ZcjpLb30NCpDuM/wOVyJlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b56st5sr; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a51b5633c9cso58586566b.2;
        Thu, 11 Apr 2024 23:13:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712902393; x=1713507193; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F7iCBwG9sJpqIjM0v4w9gJoiRWHY9cFrYeHvYwymUuY=;
        b=b56st5sra+JnQGdesvIWnOEsHyqCTKdglvT9024o8ueUbdfAjff1KxNfgfqq4JyNuk
         biT3H/FimrXijzYFk9nyU7J2xMSQEMXx6hdDoYZT9gIc3B8eCEkP/uaWQJVu3fdZZVuO
         +hxqfHhhC5YB7oa3iaMUXd7OGmRu9EHpi4QRSC7rRLjPh7a3izyqt++VJYF9ED5Joiau
         NbXNFpqq9EK8Py/UiORZEXWoQvXQIGvfetVl2xm5xhcLQmT8p+B89ZZZ6VOZZzDSGdHY
         IsJDVzvAnQaTY70vFddmKWS1D6alJkTBKrJwyop7hckwLedVyMkfYjoUp+NVEx+1ypqK
         WDEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712902393; x=1713507193;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F7iCBwG9sJpqIjM0v4w9gJoiRWHY9cFrYeHvYwymUuY=;
        b=JEVgj5Qolt0NMAnUpVlZZBsnWo0Z7zDHGt9ateL7InFyyHCDYFOfYdP8pCnsHdmFyW
         GRnoRs8T9JFr+/jA22+V9N2zV+g9eEog3uOd8hLm1sACTJMMemD63PbpyfSSDKtY9cha
         YQM1E7QXW4Rq4sQ/4rYfBKh0+/3gUID01nqnFOcsm6KijVCBvEU2eNN6YZViB9nqCQfy
         a3cN2S9ezohLrIPyxBjUMgj86wtU1tPAlTg2Q17uPp28UrpnJCQgCBQ3Cpl7R/WX1+v6
         5R//Ah9x/uCIT4BUBZ+Q9E+22P/LzISLZrT9EV48gXTlxf9tJz8xLKkPdYeRYDDNZqGE
         n9HA==
X-Forwarded-Encrypted: i=1; AJvYcCUwffuIXTKAVdpI1Pbc3OjBmP9ZrW7EkfMs4EaqRmidQgZhKzeTNWQavLtwvPIdRr2OrYlbO3S7TzmyAtJ4/zL91T3jEk34AUfBYuu2kAox23O9RZqyqvWqRghAXomlhkrOHP4Pj/bZn+SkM06DQhjTUZuWYWgCaWyaRhwSosR4ch2exgM=
X-Gm-Message-State: AOJu0YzulomAgGXJdn0I9qxj9lECWExnGV6CdQnHptpIcisuF77GfBjN
	Yb5qxE9odBPN/wyjFjYm/bqjFE/Whj+jFo5Cs49zPUl8kTZFBOSMehKj4vYfzJI6o5sXMLjzHbQ
	I7rVuR8hzw5C26hrMLQ3Ag2IhgHg=
X-Google-Smtp-Source: AGHT+IGwoOhpNX/WPOw3LP6tnEamZPl1hHzlbxiqF68dmWwi7XZ2d02JJtd6troOsd0mq6CtSA5zMGwaCDxWo0XqGWc=
X-Received: by 2002:a17:906:dfc9:b0:a52:30e1:289c with SMTP id
 jt9-20020a170906dfc900b00a5230e1289cmr780399ejc.54.1712902393012; Thu, 11 Apr
 2024 23:13:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240412-pinctrl-scmi-v9-0-b817344d3a9a@nxp.com>
In-Reply-To: <20240412-pinctrl-scmi-v9-0-b817344d3a9a@nxp.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 12 Apr 2024 09:12:35 +0300
Message-ID: <CAHp75VfBaU+F-+3zte66mxgJ+gW9N7j8E+0gw9_T9J5DHTnsBA@mail.gmail.com>
Subject: Re: [PATCH v9 0/4] firmware: arm_scmi: Add SCMI v3.2 pincontrol
 protocol basic support
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>, Cristian Marussi <cristian.marussi@arm.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Conor Dooley <conor+dt@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, 
	Dan Carpenter <dan.carpenter@linaro.org>, Dhruva Gole <d-gole@ti.com>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-gpio@vger.kernel.org, 
	Peng Fan <peng.fan@nxp.com>, Oleksii Moisieiev <oleksii_moisieiev@epam.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 12, 2024 at 3:13=E2=80=AFAM Peng Fan (OSS) <peng.fan@oss.nxp.co=
m> wrote:

> ---
> Changes in v9:
> - Rebased to next-20240410

> - Because "pinctrl: pinconf-generic: check error value EOPNOTSUPP" was
>   applied, so pinctrl-scmi.c not convert to err return value for
>   'pinctrl_ops->settings_get_one()'.

Because it's there it does not mean we want it right now. I pinged
Linus about it again.

> - Add R-b for patch [1,2,4]/4 from Dhruva Gole
> - Link to v8: https://lore.kernel.org/r/20240405-pinctrl-scmi-v8-0-5fc8e3=
3871bf@nxp.com


--=20
With Best Regards,
Andy Shevchenko

