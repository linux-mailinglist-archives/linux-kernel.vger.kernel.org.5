Return-Path: <linux-kernel+bounces-152618-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 38B4B8AC13A
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 22:42:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 42D7BB209E4
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 20:42:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C118B4437D;
	Sun, 21 Apr 2024 20:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CNfD9/qz"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 708B453A9;
	Sun, 21 Apr 2024 20:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713732125; cv=none; b=m3D/Pe5FSSXd+Hq7cWAQoXn/B4Ojva0s7thaniNLozuzBoP1KpL8ZjFilaXnn4piOEMQrMZVqA1dHcYE0qDkPxVFBMVJm8DEuDxgFdqaL2wxQLVbCgJENDoxmb/feXxehK8hYTI4GLaKSW3w+l71RvOe7ck8EdI63XMEsA9iqCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713732125; c=relaxed/simple;
	bh=z4824Ee6qqvC/GnseeCAJpGQcHhKN07+uO/XSuUiVX4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QiL1629+eDmHX8VIf1Z3PbVtsVknp+wG1KCqqMJjV+4WGtT22AqAM7ZCoGYNkfypNtDtAbGT3hUjmOwLj8Lo+slEEngVUHgeguHXBrrCctx8pQYSIgP5Qjek0B784N61hYqGLEJCv431cxgDr6F/hygYKXu1j/ysNe7PEE3Si5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CNfD9/qz; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-343cfa6faf0so3571473f8f.0;
        Sun, 21 Apr 2024 13:42:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713732122; x=1714336922; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aNPRXKeC6yyHWdrE6FYU8LBAnN64lHTdyumHo/WiS+U=;
        b=CNfD9/qzhUxVcizi/rCwFYVfJNwXmrtpa0jupZMd3OpcBL0Qy2PG4mRzpAIwBaTFkC
         gPZXgPhN185XVnYb0KKA4dekWsWoV7pxpATmc1eiofO+sserdehQYbOSw6ayATA4URlt
         tzb2yjYJ0tQnOZNnmDax27zrTRMx2ocTsWwNVgXui0k16CRdReqiUVDAsGZRgyQgWy+o
         VN6KhTvsoNXys/Kc9fvylWaO9U1dO0PE+fBVQL2sQm6bhiB4bkMOTe2W5Nzq06UmVWLI
         xt4qK4YoS9TzwRnXNWK5eKs8SlnnuyGyX0F34Ps14hZZnvTirMGpyri67wrO61GxNpKf
         mmkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713732122; x=1714336922;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aNPRXKeC6yyHWdrE6FYU8LBAnN64lHTdyumHo/WiS+U=;
        b=oDudI5/nkdAgmQ61WxmiV4SD5Xx02stwlj7vyWDxM2RXj7Y+iicCthKAI/o++5GHU7
         il6ddLkCkBxK9KAaz6e26USB1rBMK8gzSpdgNE3Qr57S8F3c88Uttbs80+i6uUsm3E19
         8fOq++8te77OciHWFceDQ0llSood/GJIVffOx6AcE6tP5ex8yM5fQ8UD64haDmXdpg0K
         VFcGh3uLvUq3k6/38bWSOANSWk8TbDfc9KGWxdEVETtWv9hkGb+AMubAWvc7NOYs7MPr
         FCR/lrU9AYLsc1XClqyu6NaBAQTPUUvWZl+e+FAWvD6OZEAO9FAKJhZjFyEFWikRIwcY
         odFA==
X-Forwarded-Encrypted: i=1; AJvYcCV1Ey5RnmgQWgAX+brOiKBt8xwAQsdd2qHWOuDWjuohY0PqFlX8xLtB5KTCqR5g743bWYd02eMiSJ2pg64DxycfWIXI0mebEaLeeq9KKHzeQ/Sbc+TU34U077Zz6ssIvZCaOpBOe68YdFxcZYi/BnRnOYdk+UcCV7eGzi2o3p+z
X-Gm-Message-State: AOJu0YwwrCGkpkbXg+ZQlBHY6K8DGCHnkvVzJwCvsrv8OgY+sCB4Uw3R
	Ww+ndyRKFToAT5FFDP8Hc2chVPjqvQeoowguw0J9oR7f6P8jvBhg9V3QhMhU
X-Google-Smtp-Source: AGHT+IG5XSpMhWBthw2oiOgEK9uBpkPJ1mVBk29Xr2Q0Bsmq5YBrrBRZMUzwD1AikBpM/o6mx9JxJw==
X-Received: by 2002:adf:e683:0:b0:345:605e:fa38 with SMTP id r3-20020adfe683000000b00345605efa38mr6152183wrm.60.1713732121412;
        Sun, 21 Apr 2024 13:42:01 -0700 (PDT)
Received: from fedora (host-79-27-41-113.retail.telecomitalia.it. [79.27.41.113])
        by smtp.gmail.com with ESMTPSA id z13-20020a17090655cd00b00a4739efd7cesm4944632ejp.60.2024.04.21.13.42.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Apr 2024 13:42:01 -0700 (PDT)
Date: Sun, 21 Apr 2024 22:41:59 +0200
From: Francesco Valla <valla.francesco@gmail.com>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Vincent Mailhol <vincent.mailhol@gmail.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Simon Horman <horms@kernel.org>,
	Bagas Sanjaya <bagasdotme@gmail.com>, fabio@redaril.me
Subject: Re: [PATCH v2 1/1] Documentation: networking: document ISO
 15765-2:2016
Message-ID: <ZiV6FwQWECidli7D@fedora>
References: <20240329133458.323041-2-valla.francesco@gmail.com>
 <20240329133458.323041-3-valla.francesco@gmail.com>
 <CAMZ6RqKLaYb+8EaeoFMHofcaBT5G2-qdqSb4do73xrgMvWMZaA@mail.gmail.com>
 <9f5ad308-f2a0-47be-85f3-d152bc98099a@hartkopp.net>
 <CAMZ6RqKGKcYd4hAM8AVV72t78H-Kt92NXowx6Q+YCw=AuSxKuw@mail.gmail.com>
 <64586257-3cf6-4c10-a30b-200b1ecc5e80@hartkopp.net>
 <Zh6qiDwbEnaJtTvl@fedora>
 <d4a55991-0ccc-4e8f-8acb-56077600c9e0@hartkopp.net>
 <CAMZ6RqJUHJdq30CrAzT26_RqpDOH_iMP8A6SKSAYrWBe-T+Oww@mail.gmail.com>
 <94638dbd-4768-4110-b85f-f158ced21ba0@hartkopp.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <94638dbd-4768-4110-b85f-f158ced21ba0@hartkopp.net>

On Sat, Apr 20, 2024 at 09:51:41PM +0200, Oliver Hartkopp wrote:
> On 17.04.24 17:21, Vincent Mailhol wrote:
> 
> > If we bump the version to :2024, then I suggest to:
> > 
> >    - add a first patch in this series to update Kconfig.
> >    - add your documentation as a second patch directly with the :2024 version.
> > 
> 
> Ok.
> 
> > I can also use ISO 11898-1 as an example. Our documentation says that
> > we support ISO 11898-1:2015. The previous version: ISO 11898-1:2003 is
> > not mentioned a single time in the full kernel tree. Yet, I do not
> > think that any one was ever confused that the kernel may not be
> > compatible with ISO 11898-1:2003.
> > 
> > If you really think that there is a risk of confusion, then maybe just
> > adding a sentence to say that we support ISO 15765-2:2024 and all
> > previous versions would be enough?
> > 
> > But overall, I do not see the benefit to keep the older version.
> 
> We currently have different occurrences of the 15765-2 term:
> 
> $ git grep "15765-2"
> include/uapi/linux/can.h:#define CAN_ISOTP      6 /* ISO 15765-2 Transport
> Protocol */
> include/uapi/linux/can/isotp.h: * Definitions for isotp CAN sockets (ISO
> 15765-2:2016)
> net/can/Kconfig:        tristate "ISO 15765-2:2016 CAN transport protocol"
> net/can/Kconfig:          ISO 15765-2:2016 for 'classic' CAN and CAN FD
> frame types.
> net/can/isotp.c:/* isotp.c - ISO 15765-2 CAN transport protocol for protocol
> family CAN
> net/can/isotp.c:MODULE_DESCRIPTION("PF_CAN isotp 15765-2:2016 protocol");
> net/can/isotp.c:/* ISO 15765-2:2016 supports more than 4095 byte per ISO PDU
> as the FF_DL can
> net/can/isotp.c:/* maximum PDU size before ISO 15765-2:2016 extension was
> 4095 */
> 
> I've sent a patch to remove the ISO 15675-2 specification version/date where
> possible:
> https://lore.kernel.org/linux-can/20240420194746.4885-1-socketcan@hartkopp.net/T/#u
> 
> This also makes clear where the ISO 15765-2:2016 remains helpful IMHO.
> 
> I would be fine to remove the version/date in the documentation from
> Francesco where possible too.
>

Ok, I'll follow this path (first RFC for this patch was without dates).
I'll try to send a revised v3, also with the details on the mixed
addressing, as soon as possible.

Thank you

Regards,
Francesco


