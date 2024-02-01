Return-Path: <linux-kernel+bounces-48518-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 525F9845D55
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 17:33:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 13B28B31987
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 16:26:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F31CE5A4DB;
	Thu,  1 Feb 2024 16:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V4mw59lV"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B99087E11A;
	Thu,  1 Feb 2024 16:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706804635; cv=none; b=ma2w6JyQg1A+sQoOjqNKeZ8ZBnUMRDYVk0G4IzXAz5yerM/imjOL7bM2vxCp9KTfg3aX1X1q+4DRk0Sy4PDilS18+9lG1vhDpoxAM24BwqCf+CrWfjVT9rFFwj154xQOVQYml9k4h7GcMe1Fm0foNkJoLjkAgrwpweYbhLmh/7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706804635; c=relaxed/simple;
	bh=Lc6vsJuq2InNpQ6ROo4kJykXV1gLlEdgQidNBeqY9d4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NDklixJFpOe6ohN1X6+HHLsI+kjxjYFZcWCyMdmTwo8ZoBFbxPU/Aiu7pv3VQODOCFPyB5d9bysfm9v1beOqMgnlAEn5uuA2oMtvoEoctE6yIAXiv2Un7e0N5K7ecSyRmtCiFLvz7VGwvznBe/z945fDaU39RIRZlC3/VBtxVic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V4mw59lV; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-33adec41b55so731670f8f.0;
        Thu, 01 Feb 2024 08:23:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706804632; x=1707409432; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KWMLBwwrq98cpw9j+C9MMkDHh6iPJbtOGOBB2hDS5dA=;
        b=V4mw59lVpZYGYdGbE+8tEKpxZIiNzmiazR8veF5o+ZwoNAAQEvCwNmT7zohyqg4d9Y
         1Q7odb8Lsxxvv0iDHLH9QpnSx2RaZnuEgJbx5YTXJkg6dUKen3EUR/QK1eSrrfZ0gxte
         /ENQX/0XkdFXCejct2Hv+yefS/yYnwTef4j+HHzaGePr38thbxf54nt6QmslkRtcKmI0
         D0TFCKKyPyFOcx7lz6OZEWtj8VKVhx7RmDSRozB3UcF15P+gnDDUiSbspTrJoL9qAcgw
         lluvUtvwwAUPTNFgCQIzEHv10BXKT+UnJHnB4Ot4ka9RhkxLLbk5QtjPC8A5SIyFWsRG
         UrjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706804632; x=1707409432;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KWMLBwwrq98cpw9j+C9MMkDHh6iPJbtOGOBB2hDS5dA=;
        b=RbRDbg/KQ/ukId4kgoCmUT5BoKz+sZJoq52SKUMdKzkM/Y2f33gAptLWZP1350KN4P
         iIYKdHdP7932dOp0e6lGcd3KWXrglRHA0NHP83NQMUeMi+u8Fppq7G63y4HFq4OzYmOK
         G+2XYmV6c06hdVtRlvuuLXymgAwmEMtyTPzxH9ng1vFLIPED5PHoXbv17pf6bthAbbNj
         AeXMUqA7FlwmunSheCPCBWQBiPkwcrDjfZd5gVc/SPJVO1FDZdP9/n4zLtNEa8ZHC5pU
         8By3bhwZdw1TwiXsafZwk8jAPEyLnSVyKeZrxXqQijKWTSI8lIDHiHlKYfxKcG7rJOyn
         klaA==
X-Gm-Message-State: AOJu0Yx+JYSUPZyZxHKDZbIe6Ob8jWGRkXDu63MYxScVKtYYXnehb0qv
	TRLOpxYGNF0oaFvweZhY12J3qwRwn66Aka1isN28ND+pv+XtlJLu
X-Google-Smtp-Source: AGHT+IHUrVZJvvXQO/F46SGvBHmFou+tBmeLgmTv2/pnii7M0QlMF4iDYFSM3/RgIsONEWdeHYZ0vw==
X-Received: by 2002:adf:db4b:0:b0:337:6bc5:8c8 with SMTP id f11-20020adfdb4b000000b003376bc508c8mr2158116wrj.68.1706804631659;
        Thu, 01 Feb 2024 08:23:51 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCU5GpK2fzf9u83rld5cXo1En8vk92nshy0BA1uku4maQvP1GT71F+EOXlw7kWnJA7Cu38Ch1f8tAay1ILKEyzceIUxFjihKsJ8gVU4L/EuiOSAqa4fQwOeRu2z/7MSVluE8GXHMy+jfP4AcXamts5SmRejcWXNC3tHuVTv7XmJktEDtHpbnnBwUdHCy5n7F9wsNSnXcZRUkkCme+4SqRWhHMhhA8YuJyBBpbKALk4P0E++5KwLI4qjpiq6EaQsfT9IstaWoZybGOBbBoAP7xbf2Q82Hc6RZChngNU6XIBTgA7I2EAYxbyUlYLyhnc3EXKPbOAVBvQgZxkGjKgPRMOwYwP5a7352Oitve7+NY5f5z2RR7UDTMHFnUSr1ZkSroPastA==
Received: from debian ([93.184.186.109])
        by smtp.gmail.com with ESMTPSA id cc9-20020a5d5c09000000b0033afb963d0dsm7482152wrb.101.2024.02.01.08.23.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 08:23:51 -0800 (PST)
Date: Thu, 1 Feb 2024 17:23:49 +0100
From: Dimitri Fedrau <dima.fedrau@gmail.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jean Delvare <jdelvare@suse.com>,
	Stefan Eichenberger <eichest@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org
Subject: Re: [PATCH v5 net-next 08/13] net: phy: marvell-88q2xxx: add support
 for temperature sensor
Message-ID: <20240201162349.GC48964@debian>
References: <20240122212848.3645785-1-dima.fedrau@gmail.com>
 <20240122212848.3645785-9-dima.fedrau@gmail.com>
 <88a60be9-083b-4618-845c-6983bcad3540@roeck-us.net>
 <c9866a56-d82e-4a3d-b335-db22c0413416@lunn.ch>
 <a02c7451-8515-45d4-ae7b-9e64b03b5b38@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a02c7451-8515-45d4-ae7b-9e64b03b5b38@roeck-us.net>

Am Thu, Feb 01, 2024 at 05:39:25AM -0800 schrieb Guenter Roeck:
> On 2/1/24 05:27, Andrew Lunn wrote:
> > > > +#ifdef CONFIG_HWMON
> > > 
> > > HWMON is tristate, so this may be problematic if the driver is built
> > > into the kernel and hwmon is built as module.
> > 
> > There should be Kconfig in addition to this, e.g.
> > 
> > config MAXLINEAR_GPHY
> >          tristate "Maxlinear Ethernet PHYs"
> >          select POLYNOMIAL if HWMON
> >          depends on HWMON || HWMON=n
> >          help
> >            Support for the Maxlinear GPY115, GPY211, GPY212, GPY215,
> >            GPY241, GPY245 PHYs.
> > 
> > So its forced to being built in, or not built at all.
> > 
> 
> Even then it should be "#if IS_ENABLED(HWMON)" in the code.
> 
>
If using "#if IS_ENABLED(HWMON)" do I have to add the dependency in
the KConfig file ? When looking at other PHY drivers, they do.

Dimitri

