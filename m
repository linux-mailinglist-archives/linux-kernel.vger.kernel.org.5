Return-Path: <linux-kernel+bounces-152366-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 821C18ABCFF
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 22:04:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6CBFCB20CB9
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 20:04:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC09146439;
	Sat, 20 Apr 2024 20:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="j3lY3CJL";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="yRueW/iE"
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DF578F6C;
	Sat, 20 Apr 2024 20:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713643442; cv=pass; b=sH24KfBaFSt1f2NJI1u3/80+y5KUTBU3HdAqRsR/Bx94WYwwWwfa+rBblVDR2FHlkWM+TWiDt39XjFr92mhbwvnBxHAw5Oci8GNVLpCCwnNqY2Ch9x2Mn5J5XOQiujQwRmmlIpzK2iTFEsBVvh+RMUem+V5qxCve/k39Vy/sz3A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713643442; c=relaxed/simple;
	bh=YOCb9Lvhpyh6uO9nM0yZEUXgPUXcBP+r9iY8ZDH3A74=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D0jv2XqXLCpdJZwQze0CwOn8yWK70z3sD0t1N6btYygrqiH9fUv0fC5qX045mGMk3RhkLbK2BquNDwKdTnL/1pAAoEx8dBPC3ZzfQSO8jlPOiu+wkuhClYsd0y7RMzk2k9d0637kq5IJzO0u1K/JsUqRK/0mUFv2vYdzZuqK46k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=j3lY3CJL; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=yRueW/iE; arc=pass smtp.client-ip=85.215.255.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1713642708; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=WJgyMNQ76DYDUf6tIvAgMn7cznb8nP7PHuhPxUMrBHKXl7svl9oEhrUx0BBlVd4/Mq
    0LC8OoKMFgICsL3mUhvqlmC0BVyrAjwGOSV8QmAi7ub2xauRFEgeCjjSRN7imMQSgOrj
    LUhLJIRr5dzfwHgCJBS9xbiOdApYIrQ9uTOKimdLBq67T22WdJ+KtpneRYHaNUG1uXmL
    uDVUYl+xqw1JRNBNiwWQVVn/t7l5dnfjNZWhMMHq2bipEiaNV0M5n11L22VUJHkR/iT9
    LNhwC78N03HxO0vwpyenrvP+6OAUcQVoDz5sI7UNzWm12Re/UYndv6l0cHUxqQzMxvk4
    thZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1713642708;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=OOv8quEQR+pry8H7q+Hyf/AV7Ufsx5pckJ8GDT9hxW8=;
    b=PApfboGKuB/BdbDsIPXxhU1+rGvBtTKE4MY01mCq3S8DZ+W9yd56Le50SePAnizmO4
    yafAHxgrDHtvGzHoCaJ9DbtdHcspYKjOLTrgAPbk+CBxQQpCnOPvyWFhYGSnuhjzpiNl
    RBg+Mlgysq/HtGlPYj1U6R9RcWzC+lFBZZUwxGjb//ALdeBAKz2RBmFa6O6tMuLh+Dai
    FLOArR4CJu4UVD9nFeYQp+auT9anRTjcSDUr9nmVB99Pybf+1p1oSrHAOCSUE824xP7K
    o7lJUW5qFesAYBLHErPIpJfywRlahyW5KaHRz3l8fJLrmS+aIqMJnb2hk+m/jwB5h2jR
    cYnA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1713642708;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=OOv8quEQR+pry8H7q+Hyf/AV7Ufsx5pckJ8GDT9hxW8=;
    b=j3lY3CJL+q2sdfAyuMoNpuxwGAA3nuRZh7ysGFwxmSZB8j07+/4YssZqwVJrpU9ZuG
    2atKCEzMeCY4y9UOjpZkVyiy1sZxfaO+3NYSixr1c7V5DjPi7kaHawm1MRgp11m4HJ4v
    gtuSQd7xrPM0O7VgzSls6CYlh1KoZrHZIAMdi/3mZfS1hsLtH3yqCncGNSF1BeRGWnfe
    7wHlgb5nFGlYyKNZ0Rhj9g/I1MR3FHpkEUE0O5J1jx4rUP7uSqnk07M/lF+h6hfMm4A3
    dxhreYXW7D1BekV3B32H/ESDGUPze3SlSDqONsJJp/Ew/VVAuI9X1S2L/NlsgrZpZigk
    in4w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1713642708;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=OOv8quEQR+pry8H7q+Hyf/AV7Ufsx5pckJ8GDT9hxW8=;
    b=yRueW/iEe00dE8W/uuGfgB9CF87bNsuVrmbS2Lz0k1Ckh4l+LwwbF9ruV1+Qgy5NGq
    /+IMNuHUKvcvhp8ya2DQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1o3TMaFqTF1ViO8sG"
Received: from [192.168.60.177]
    by smtp.strato.de (RZmta 50.3.2 DYNA|AUTH)
    with ESMTPSA id K701d603KJpmhBE
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Sat, 20 Apr 2024 21:51:48 +0200 (CEST)
Message-ID: <94638dbd-4768-4110-b85f-f158ced21ba0@hartkopp.net>
Date: Sat, 20 Apr 2024 21:51:41 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] Documentation: networking: document ISO
 15765-2:2016
To: Vincent Mailhol <vincent.mailhol@gmail.com>
Cc: Francesco Valla <valla.francesco@gmail.com>,
 Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Simon Horman <horms@kernel.org>, Bagas Sanjaya <bagasdotme@gmail.com>,
 fabio@redaril.me
References: <20240329133458.323041-2-valla.francesco@gmail.com>
 <20240329133458.323041-3-valla.francesco@gmail.com>
 <CAMZ6RqKLaYb+8EaeoFMHofcaBT5G2-qdqSb4do73xrgMvWMZaA@mail.gmail.com>
 <9f5ad308-f2a0-47be-85f3-d152bc98099a@hartkopp.net>
 <CAMZ6RqKGKcYd4hAM8AVV72t78H-Kt92NXowx6Q+YCw=AuSxKuw@mail.gmail.com>
 <64586257-3cf6-4c10-a30b-200b1ecc5e80@hartkopp.net> <Zh6qiDwbEnaJtTvl@fedora>
 <d4a55991-0ccc-4e8f-8acb-56077600c9e0@hartkopp.net>
 <CAMZ6RqJUHJdq30CrAzT26_RqpDOH_iMP8A6SKSAYrWBe-T+Oww@mail.gmail.com>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <CAMZ6RqJUHJdq30CrAzT26_RqpDOH_iMP8A6SKSAYrWBe-T+Oww@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 17.04.24 17:21, Vincent Mailhol wrote:

> If we bump the version to :2024, then I suggest to:
> 
>    - add a first patch in this series to update Kconfig.
>    - add your documentation as a second patch directly with the :2024 version.
> 

Ok.

> I can also use ISO 11898-1 as an example. Our documentation says that
> we support ISO 11898-1:2015. The previous version: ISO 11898-1:2003 is
> not mentioned a single time in the full kernel tree. Yet, I do not
> think that any one was ever confused that the kernel may not be
> compatible with ISO 11898-1:2003.
> 
> If you really think that there is a risk of confusion, then maybe just
> adding a sentence to say that we support ISO 15765-2:2024 and all
> previous versions would be enough?
> 
> But overall, I do not see the benefit to keep the older version.

We currently have different occurrences of the 15765-2 term:

$ git grep "15765-2"
include/uapi/linux/can.h:#define CAN_ISOTP      6 /* ISO 15765-2 
Transport Protocol */
include/uapi/linux/can/isotp.h: * Definitions for isotp CAN sockets (ISO 
15765-2:2016)
net/can/Kconfig:        tristate "ISO 15765-2:2016 CAN transport protocol"
net/can/Kconfig:          ISO 15765-2:2016 for 'classic' CAN and CAN FD 
frame types.
net/can/isotp.c:/* isotp.c - ISO 15765-2 CAN transport protocol for 
protocol family CAN
net/can/isotp.c:MODULE_DESCRIPTION("PF_CAN isotp 15765-2:2016 protocol");
net/can/isotp.c:/* ISO 15765-2:2016 supports more than 4095 byte per ISO 
PDU as the FF_DL can
net/can/isotp.c:/* maximum PDU size before ISO 15765-2:2016 extension 
was 4095 */

I've sent a patch to remove the ISO 15675-2 specification version/date 
where possible:
https://lore.kernel.org/linux-can/20240420194746.4885-1-socketcan@hartkopp.net/T/#u

This also makes clear where the ISO 15765-2:2016 remains helpful IMHO.

I would be fine to remove the version/date in the documentation from 
Francesco where possible too.

Best regards,
Oliver

