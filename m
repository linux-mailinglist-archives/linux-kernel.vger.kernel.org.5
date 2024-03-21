Return-Path: <linux-kernel+bounces-109990-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C7B368858AA
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 12:58:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6668F1F212F8
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 11:58:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 868AB5FB81;
	Thu, 21 Mar 2024 11:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MuZnIPiU"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B7B958129;
	Thu, 21 Mar 2024 11:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711022315; cv=none; b=HHEpbuQXUBha7l+iZQgXRkdAou2ukqc6RSxKKO+cWWJZPf2v4qgJhPDL6VlK8Ew+D7/znPL7b5c+aWWeDuLN5e0LWXkKO+MMf6sXRnRMp8psJHF6+n1oWmGjHUgNpIJM9hqF/Vkh4NmIG9/3ur1A/grR3SRpZAY/y6Xf1KHsJ0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711022315; c=relaxed/simple;
	bh=fkUBrpoYx1ATKFVJL/j0P62CoCtirla+CHXyhjvnFhk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N0Bwk/VVhIEq7bryKF0yhOpya5ZPrePTiVQr4v+y42bctZBSdUaycuCQrA6tKjZYz3vCboiUtzWrarqE0eIDGeCHLYGA0VDTll+adE8omcWOMqFUVWQMKT59JBCmdp56APP7doV+/6WAISTtibXD5UHvKFelB2i1maigN93yerI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MuZnIPiU; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-51381021af1so1387670e87.0;
        Thu, 21 Mar 2024 04:58:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711022312; x=1711627112; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Lg7XPh+CmMjSrvskyjTz4DOgGAvevT98Cl2JzAVnwSg=;
        b=MuZnIPiUXx7m1T9ydJQDsRmg5e9WvCz3xwvbkezqCrj/jjGvNmj5SRG8GpfC3ybuji
         bxEQgIdDmtJbh9ymvFnRo8Tjx5e7S1cK9OcM/TU5oNYZA+G9E1/ljdzLUAiAWlYDgsgW
         nZR8zhTtLFK1w+iZmF5vFrmPgLB20NRJb1w+n/AnQwSNG2IWaNlUQP33yIIiNDzfFvph
         IzR3Ewi2/VXA+lW5/WBhkFKBfbsv4yyiyMbW2tIyVAkeY+4uCRMAZl4XY8+rVJC5mwIv
         cEmCR93vQ7gZyo9AjEA33ebW5q6i0msu06kQzpJ3kGh8ubkE4vlOmzETsqAVtjrL9xLQ
         sNDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711022312; x=1711627112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Lg7XPh+CmMjSrvskyjTz4DOgGAvevT98Cl2JzAVnwSg=;
        b=P5HIY8ngqs+kO5ELy0d2ARqPOm4nQKNXoQjNegbfp1/iIDwDz1pOw5ROxt95xw8KoN
         4W/+b85RQ66r9vRjdKd18Mb4yiRR0Efru2SB8qY1TdW/Hr2y00iA9YuxJPwn6aMEOnwW
         ng8kgtUkixxFm4kVRYQw1N5temDlZT0c22Mzu2hLhPi6bQnU4Rh+40Q1QutFLuehcIQI
         kxnDN8UhfYXBdHcLF6jF9HtrCdDF+nuOLFtA95cgDXrcJe5Cb0bxeNOjiQ86ssCUM9uB
         dZOIgiiVUMpHTt8sepOLDAD1fmZlGdgzfipqBjBkZbfVrBUE6THMFBWjqpqHgzk+xBCm
         vQJg==
X-Forwarded-Encrypted: i=1; AJvYcCVm+LBN04zJXqupWtOKrYYbqUwmcAF9/+a2RLLutA8VsYWL991LUxy5XGQqOXOm6+3lZ+cG0jHU5acH3fGQsSB0Sxw+l8YRpmRvuLdE4Ea63NGYeuP00sk8UJw+cqbrgOvdcEUV5OVWT6dOEiej6JoOaqO6FFoMOkDtEeDkme8J2w==
X-Gm-Message-State: AOJu0YxATGbzGRcZ967Rzva0j8ENj5mpV6w6ojgszfM/biWTfpyqEmAk
	Ckxdq4nXfOcXQr52YTcfJUQE3HKGnxoiUF6bx3cYf+p2CkmQ8cxY/z/TeFHhxPDaSpC098zkygK
	KN11vSUfDP06lIG6HlWpITfU6WxI=
X-Google-Smtp-Source: AGHT+IFmvFGsX+AsNhUeRNMeg16urp0jTvglZhVWZEy18X/aYK1Pz52OqOcqdqZPvrcm6AZoMyhROkso76tXKFsr9Fk=
X-Received: by 2002:a19:a416:0:b0:513:80b3:3eef with SMTP id
 q22-20020a19a416000000b0051380b33eefmr1680700lfc.24.1711022312248; Thu, 21
 Mar 2024 04:58:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240310-realtek-led-v1-0-4d9813ce938e@gmail.com>
 <20240310-realtek-led-v1-1-4d9813ce938e@gmail.com> <80fee2d0-356b-4baf-bd7a-b338df3644fa@lunn.ch>
In-Reply-To: <80fee2d0-356b-4baf-bd7a-b338df3644fa@lunn.ch>
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Thu, 21 Mar 2024 08:58:20 -0300
Message-ID: <CAJq09z5puvUCkvR+zJx5Jd3EAELQ56PtctspZwzuSBnMPZCASg@mail.gmail.com>
Subject: Re: [PATCH net-next 1/4] dt-bindings: net: dsa: realtek: describe LED usage
To: Andrew Lunn <andrew@lunn.ch>
Cc: Linus Walleij <linus.walleij@linaro.org>, =?UTF-8?Q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>, 
	Florian Fainelli <f.fainelli@gmail.com>, Vladimir Oltean <olteanv@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Andrew,

>
> > +                properties:
> > +                  reg:
> > +                    description:
> > +                      "reg indicates the LED group for this LED"
> > +                    enum: [0, 1, 2, 3]
>
> Having read the code, i don't think the binding needs to say anything
> about the group. It is implicit. Port LED 0 is in group 0. Port LED 1
> is in group 1. So there is nothing here which is outside of the
> standard LED binding. So as Linus said, i don't think you need any
> YAML at all, the DSA port binding should be sufficient.

The only purpose for this patch is to limit led numbers to 0-3 and
describe that the reg number is the group. If that is not important,
I'll just drop it.

Regards,

Luiz

