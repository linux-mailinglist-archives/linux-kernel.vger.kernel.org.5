Return-Path: <linux-kernel+bounces-52826-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19C87849D1A
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 15:32:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 60D05B23D11
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 14:32:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B57042BB1F;
	Mon,  5 Feb 2024 14:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DguGEhfh"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 598CC1F602;
	Mon,  5 Feb 2024 14:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707143530; cv=none; b=E87seTCp4Ld6EjL8hN8vF6xCaNlyjesVRFWQ2gqcL+XDBnvFC1QGiTjjPm7fubcL26NcZA+g+srd1Hk2IyN88hR1Aa8DLtkuhexNoDyCSJqtFEljJllTfWNEeZK0AFd1b1m5BTJNNZU9TU6eX1vCpH38l7yEXi87pCMPWdHIIQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707143530; c=relaxed/simple;
	bh=aq2Ahj8o6guk3NeDyYxvkEpgJfVVNXFcxeqlZGg2Tjs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RuXNHPNApaNUnAWWyE3DbOHZbHXoQTh97Ptlt57qMTTC5jYoWJWYIEQgMJ7YT/dgQKY3fkpUaWHvS8TatlWPoz9kQa5LB6W2eM9TJtgZaySFsvk9qEZDhMoR4KzDHYi/80fQTOEHI9H4xTzO5726SirRiDarufdDNK4vZEZKASA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DguGEhfh; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-511538be947so756905e87.3;
        Mon, 05 Feb 2024 06:32:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707143526; x=1707748326; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=aq2Ahj8o6guk3NeDyYxvkEpgJfVVNXFcxeqlZGg2Tjs=;
        b=DguGEhfhNZiU+Cgw8eFd/+kj9QIYnVq1M5PJoFl7H6sufb+HMISKYUU7Ax7RxoulnB
         1An0XeQmw2ZyMvlA9YMQZdLkSLETNFtETUqdlgF/1WmJ6fVoleYEiWGhMtXsdRlYqrhD
         2GfX2rrOetIlX9bivaLc7Z2oKGMnQHOGSWECkO7rUDkH+hZXOx2rxpFofbMXPLlbvzH8
         ekUUcyxiOXq0mH1pmPpvpAm6a2rIH261gEKRBBsnd1FPVQg2ELJzmZ7xSJdTiV+3UD/G
         g5qrCtDAzW6YhgK5XDy8lHzVnd/dvBzstfdZV1QPgCmapeDPEvZ3P/HQoGPA/QY2vjSU
         Xnjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707143526; x=1707748326;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aq2Ahj8o6guk3NeDyYxvkEpgJfVVNXFcxeqlZGg2Tjs=;
        b=r3aGfXAIR4tmycThLWIxm6ft0mOIKnwvtn6ZVYTOSuFvXO+1YflssDNBCIvNx0KAdR
         N9mMVqOU4BOHqXNPFxyGq/GKwRyS7D2vMTOQjPFc+9hBUVzyjmw7fKwJwtQcgNj4/ORv
         krjfbMFIBH8FDXEm8tcwKbKugkZiENBX2IRaBcW4HXx1VRk+5VSjoxu8QCoQWtcV4a2l
         SNkGg006CgtalVRVSwflxTw/WnWv7hrmBR1iFgUam7KJiK9Csv62lOKAFVA3dUorOTkU
         FzIQGqdULxUJk2uQlPwOjTpBIXPdckD879+KHGMqiQWCq2n7A4A7ChUMWekt7SQpohy9
         UHag==
X-Gm-Message-State: AOJu0Yxv8o4YDf+99RNeQxEcc1S7G3YphUl3d5T55PRQDEQRxsoQ9Uge
	UEk4M/bcRKPunPqZ3eByVkCtcDF2WlnzD9H67tTI2n/VKKWXQncT
X-Google-Smtp-Source: AGHT+IGOFxLMMGfTYawVAKjkwNalqGesYkIVBKX1p9mzhohT3vL5VDcd/7MNG121tkuWp3H/O9ecvA==
X-Received: by 2002:ac2:505c:0:b0:511:4684:2719 with SMTP id a28-20020ac2505c000000b0051146842719mr3729738lfm.34.1707143525949;
        Mon, 05 Feb 2024 06:32:05 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXemqaaq2BVyn/jK5oeSqt8QgXdqQDufwHZcd2H6yipgTsNFhHHSxsceU2tybFd+R1TF+dfIwk377+ihPANl4HW35aeP+qDNtUFv6wSuXq5opD8gtDEMJnb7T4+EB9NKYC6LF9dYs0FsUN3lsHrhn8EB9Jd/R+fqfK4AO9zacS8J/3jsD+ZM2ssq9un+77/1pPFxzFF3dMIBQOu94TWqhlcxqqaTfsLbJP7D7/nq/l57sLgzmq7x2mp0MUMIXwP7rG+Ri1mOVWdN7iJHIzrwo1YBUorraz2s3m1Ocvgw1mIynoTnhg7o/zQ/4G2UwWV9tnWDCNr86iVBo8tmp5KEflq77wBPCFrNes7lzCOGdqvwYD6IZjO9PsT8x7Ckyc8DxLBBobFDp6zg2YLJLmlA4NVSRl4lPKkumQypP6X
Received: from ?IPv6:2001:a61:3456:4e01:6ae:b55a:bd1d:57fc? ([2001:a61:3456:4e01:6ae:b55a:bd1d:57fc])
        by smtp.gmail.com with ESMTPSA id v11-20020a05600c470b00b0040fdd7cbc8dsm1749050wmo.47.2024.02.05.06.32.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 06:32:05 -0800 (PST)
Message-ID: <31f7c989e9ee1eae49976466543f7192865775ff.camel@gmail.com>
Subject: Re: [PATCH v2 1/2] driver: core: add dedicated workqueue for
 devlink removal
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, nuno.sa@analog.com
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Frank Rowand <frowand.list@gmail.com>, Rob Herring
 <robh+dt@kernel.org>, Daniel Scally <djrscally@gmail.com>, Heikki Krogerus
 <heikki.krogerus@linux.intel.com>, Sakari Ailus
 <sakari.ailus@linux.intel.com>,  Len Brown <lenb@kernel.org>,
 linux-acpi@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org
Date: Mon, 05 Feb 2024 15:32:04 +0100
In-Reply-To: <ZcDV9epWJf_oTCMK@smile.fi.intel.com>
References: 
	<20240205-fix-device-links-overlays-v2-0-5344f8c79d57@analog.com>
	 <20240205-fix-device-links-overlays-v2-1-5344f8c79d57@analog.com>
	 <ZcDV9epWJf_oTCMK@smile.fi.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 (3.50.3-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-02-05 at 14:35 +0200, Andy Shevchenko wrote:
> On Mon, Feb 05, 2024 at 01:09:32PM +0100, Nuno Sa via B4 Relay wrote:
> > From: Nuno Sa <nuno.sa@analog.com>
> >=20
> > Let's use a dedicated queue for devlinks since releasing a link happens
> > asynchronously but some code paths, like DT overlays, have some
> > expectations regarding the of_node when being removed (the refcount mus=
t
> > be 1). Given how devlinks are released that cannot be assured. Hence, a=
dd a
> > dedicated queue so that it's easy to sync against devlinks removal.
> >=20
> > While at it, make sure to explicitly include <linux/workqueue.h>.
>=20
> ...
>=20
> > +++ b/include/linux/fwnode.h
> > @@ -213,5 +213,6 @@ extern bool fw_devlink_is_strict(void);
> > =C2=A0int fwnode_link_add(struct fwnode_handle *con, struct fwnode_hand=
le *sup);
> > =C2=A0void fwnode_links_purge(struct fwnode_handle *fwnode);
> > =C2=A0void fw_devlink_purge_absent_suppliers(struct fwnode_handle *fwno=
de);
> > +void fwnode_links_flush_queue(void);
>=20
> I am not sure if you have seen my comment against v1.
>=20

I did received it like 30min ago...

> I find the namespace a bit messy for devlinks. And to me seems the best p=
lace
> for this line is to be before fwnode_links_purge().
>=20

TBH, I'm not really keen on sending a v3 just for that (unless I'm asked ot=
herwise).
But If I have (still missing DT guys feedback), I'll do as you suggested.

- Nuno S=C3=A1

