Return-Path: <linux-kernel+bounces-20653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 56F1B828301
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 10:21:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7C881F21FAD
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 09:21:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A79B364B0;
	Tue,  9 Jan 2024 09:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hLhFpub+"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F0C82EB11;
	Tue,  9 Jan 2024 09:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-40e5280a381so917395e9.2;
        Tue, 09 Jan 2024 01:19:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704791943; x=1705396743; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DJQguPbha7MXCmeJtqCzdTaw5Ni1LUD1cj0B0gGvNS4=;
        b=hLhFpub+Fkghf4pxKAB/+ijFJvNw/oCruLQn1MA1aYnftCul6ahyAkKdq89AhvCiI5
         NYiyK2kY3XBh/2j1pE78PaCnOZuGm6lxCZLqiLv+9elIXsndxx6ZuRa/M0xnNvEX37JF
         UIBgSAUUDP1Z4p08itFmqJEbsPWVHEw7clkbXJ3UtYMpjQUdYmJ46ixAdsBdufoWN4E7
         LIHUXyc0r2x4K7QXjsotKYjyjmp8cmGaHhUzVfLGIfJ1iqhJfJ7yaIv/h3rD6Vzsa61a
         f2dlyVDJm1P5aEpnub621Umyym7qeIt/6n9t+PA4uhVj7v3bxn5G8dLuG960heSeWL5T
         Ubsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704791943; x=1705396743;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DJQguPbha7MXCmeJtqCzdTaw5Ni1LUD1cj0B0gGvNS4=;
        b=wmQvbT6OLSTqUGtMJ4qN9CPzEmf7bvma6hN/5fAaabSCZ9ZVx2iS5d47PqXCcT+rgA
         vj2eLQRr2fS1e5X9Ch3tza0kPy8plIePvYz0HHaAE+yIw4upgxfLn8bRLZSoOrYsw6do
         ayVH3dwW6W8BUm25z9qmufdvJ0uOCGdc1J8SMliFn7h32V3U3o+kJiPvJUwq0Zp0fwGF
         3GsCCYtQNGkBkFrUjYwRq1vXgj594uh5RlVQfyWYb47oK48zgfNdQN7G/nutGsRbcVt3
         ogJkVbNS9/mn5x10F4mEmcr38MtZik7VCTlN638lBtuic6nrjpaNulHz+8MOecIRVxWG
         hohQ==
X-Gm-Message-State: AOJu0Yyj659jgWFYd694L9YOit/yyC6Vuxma3eCJ2vs5bJak3/G4C3U9
	Q21ZV3Y2Wf0VKTpLYbYFV3G6qyegn26KSLSVj04=
X-Google-Smtp-Source: AGHT+IH8kjBr6y/PUVs76Dmc5ivmhvqMJo6M7Nycjc2+bCF2ImQ4/rGA/kQrj8cLE6C6hFpmgE0ip2s1p/rhyjCeWRA=
X-Received: by 2002:a05:600c:4745:b0:40e:491d:acaa with SMTP id
 w5-20020a05600c474500b0040e491dacaamr968576wmo.22.1704791942945; Tue, 09 Jan
 2024 01:19:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAM+7aWvmmyyLN5YHuJhg_X402OFmP_sVe6h_mr5tURjv0Ti5vQ@mail.gmail.com>
In-Reply-To: <CAM+7aWvmmyyLN5YHuJhg_X402OFmP_sVe6h_mr5tURjv0Ti5vQ@mail.gmail.com>
From: =?UTF-8?Q?G=C3=A1bor_Stefanik?= <netrolller.3d@gmail.com>
Date: Tue, 9 Jan 2024 10:18:53 +0100
Message-ID: <CA+XFjiqUxOPwP7O1qa0zUO8p8deVHQEqQ5kJtr6QsHcSf+YkMQ@mail.gmail.com>
Subject: Re: USB PD TYPEC - FUSB302B port controller hard reset issue
To: Suniel Mahesh <sunil@amarulasolutions.com>
Cc: Guenter Roeck <linux@roeck-us.net>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, 
	USB list <linux-usb@vger.kernel.org>, Jagan Teki <jagan@amarulasolutions.com>, 
	Da Xue <da.xue@libretech.co>, Da Xue <da@lessconfused.com>, Da Xue <da@libre.computer>, 
	Kyle Tso <kyletso@google.com>, RD Babiera <rdbabiera@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Unfortunately this seems to just be the behavior of many wall
chargers, triggered by either an excessive delay between first drawing
power and beginning PD communication, or by an incorrect sequence
number. From what I've heard, this is a workaround for a bug in the
earliest USB-C MacBooks, but it unfortunately makes those chargers
unusable for powering anything that doesn't have an internal battery.

Suniel Mahesh <sunil@amarulasolutions.com> ezt =C3=ADrta (id=C5=91pont: 202=
4.
jan. 9., K, 8:17):
>
> Hi Guenter/Heikki/Greg and all,
>
> This email is a narrowed version of the earlier discussion at:
> https://lore.kernel.org/all/CAM+7aWt7hJSmJQ78Fes0jMcrF9E8yhN=3DsDgYuU-hBx=
O0+1Uj0g@mail.gmail.com/T/
>
> Please guide/suggest on why the FUSB302B port controller on a target boar=
d
> is getting reset(hard reset) on reception of a 0x0 packet from source(PD =
Wall
> charger 100W - 20V@5A).
>
> log when reset:
>
> [    1.599049] FUSB302: IRQ: 0x80, a: 0x00, b: 0x00, status0: 0x83
> [    1.602836] FUSB302: IRQ: 0x00, a: 0x40, b: 0x00, status0: 0x83
> [    1.606210] TCPM: tcpm_pd_event_handler: in TCPM_CC_EVENT
> [    1.968179] FUSB302: IRQ: 0x80, a: 0x00, b: 0x00, status0: 0x83
> [    2.133140] FUSB302: IRQ: 0x41, a: 0x04, b: 0x00, status0: 0x93
> [    2.133704] FUSB302: IRQ: PD tx success
> [    2.136046] FUSB302: PD message header: 161
> [    2.136392] FUSB302: PD message len: 0
> [    2.136845] TCPM: PD TX complete, status: 0
> [    2.139382] FUSB302: IRQ: 0x51, a: 0x00, b: 0x00, status0: 0x93
> [    2.142192] FUSB302: IRQ: 0x51, a: 0x00, b: 0x01, status0: 0x93
> [    2.142804] FUSB302: IRQ: PD sent good CRC
> [    2.145274] FUSB302: PD message header: 1a3
> [    2.145674] FUSB302: PD message len: 0
> [    2.146072] FUSB302: fusb302_pd_read_message: to tcpm_pd_receive
> [    2.146478] TCPM: PD RX, header: 0x1a3 [1]
> [    2.147042] TCPM: tcpm_pd_ctrl_request: type:0x3
> [    2.147435] TCPM: tcpm_pd_ctrl_request: case PD_CTRL_ACCEPT
> [    2.146309] TCPM: tcpm_pd_ctrl_request: case SOFT_RESET_SEND
> [    2.148266] TCPM: tcpm_pd_rx_handler: done
> [    2.158196] FUSB302: IRQ: 0x51, a: 0x00, b: 0x01, status0: 0x93
> [    2.158600] FUSB302: IRQ: PD sent good CRC
> [    2.161283] FUSB302: PD message header: 0
> [    2.161710] FUSB302: PD message len: 0
> [    2.162092] FUSB302: fusb302_pd_read_message: to tcpm_pd_receive
> [    2.162608] TCPM: PD RX, header: 0x0 [1]
> [    2.163181] TCPM: tcpm_pd_rx_handler: done
> [    2.179843] FUSB302: IRQ: 0x41, a: 0x01, b: 0x00, status0: 0x83
> [    2.180314] FUSB302: IRQ: PD received hardreset: interrupta: 1
> [    2.181125] FUSB302: fusb302_pd_reset:
> [    2.182597] TCPM: tcpm_pd_event_handler:
> [    2.182937] TCPM: tcpm_pd_event_handler: TCPM_RESET_EVENT
> [    2.183292] TCPM: _tcpm_pd_hard_reset: Received hard reset
> [    2.183770] TCPM: _tcpm_pd_hard_reset:
>
> Let me know if you need anymore details.
>
> Thanks and Regards
> --
> Suniel Mahesh
> Embedded Linux and Kernel Engineer
> Amarula Solutions India
>

