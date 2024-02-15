Return-Path: <linux-kernel+bounces-67651-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91474856E86
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 21:24:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 08A39B280DF
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 20:24:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C11C13AA4B;
	Thu, 15 Feb 2024 20:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P7moCdGO"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1F1A13AA39;
	Thu, 15 Feb 2024 20:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708028650; cv=none; b=i/Z9+ROOLJPcBZNE2w/8c/2VyubjV/f6Ut20gU53PXIPlhFS1d3SOtNtz90a/qPi6EnxNArwEG8yd8sBFkFIm7Fy7wDWTjT/RgldZcpN50Xu9/+E+nulxUUpkU7dWvzvxR9elShsWsHg6SQKNiqeBn82dqDFFPRpjiWzcUOV5/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708028650; c=relaxed/simple;
	bh=mv9mlENQexGSSo1Sc2XFNHXYowzi7Aa84uwVlFA8XkM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tdoGPLMpTwNh+ujr0C5It3lgn9d2sjJf9/OEZLK8fnsVEXvuIEWD3c7NS0ulr9oIzNZv1hcYGtxo01L2UYiPu0bBrKnxZf95gvCQE3GdnNS9evVj2rgg6XDAlJea3ue2jQFIqBhB5XqCT024iUrZ3+XAnMhi4F6WzsduXKI31p0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P7moCdGO; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-563d32ee33aso567467a12.2;
        Thu, 15 Feb 2024 12:24:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708028647; x=1708633447; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=e9azb09fmov9b09XF/cIy5uUULMZogQrh+9yi0HxP2k=;
        b=P7moCdGOzPcKTs9CdWN9pkaTqbjfjgkEdfAHYmL9dX0nNWvSiUGkEczCgdx2SFWh5U
         bGpXH3df4tZ+xNWW2jo5MTm7r8wKl36MTmRm54wVhhDdixtVnRNrSCg2HRJF6vSqy7sj
         bBsQLvsVPFjql0NMOwkPFHCXQ/N1i4FldaM64DQJCateMu2cXgtbw0vnuMgemz/oa4gk
         XIieKgLQxADaGxvLeAN4TAYCffTasJoAklO735n6dPUDsqviK6+c4SFalXF1sloN+2xZ
         Sz/rWsGlS2o/kOnhr3+Ny7F2ylzFHSJBj8oCBmTi+PfY9Ywu+ferUlT8Un82ImvhStHB
         pjAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708028647; x=1708633447;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e9azb09fmov9b09XF/cIy5uUULMZogQrh+9yi0HxP2k=;
        b=rSn78lP3StDSZUuK2kEctVIiEYfivHQiu8t8b/QPZaCOuwvXNjUXuLOTaDigQOwFYw
         XW1ol21UzxCpZbbGurCUuLHPUQ7SYZD+8zAO6ylmIRBjlTmgHW9sZ69YXQCfS7D9H+Bb
         eyT5ML9l2/5QCyVlzi3QoZfXYv08T+QekzccE66E/s2gxTrhKwOJjVL37KBaeF2gwO3/
         l1BxKLB8zNdUUQNRXqxz2acuUtZiWU+rD0pQvYy2NfK/FiGhxZncnxg+5qLCcshUtFXR
         YedsBxjiNEygxfpExP2xsfzndI/nHMC6SePqaMx+Fg5pLJ9Oy5dW4ZXzT9PZ8PF+l+e4
         Km8Q==
X-Forwarded-Encrypted: i=1; AJvYcCVhLQs8STOwb6HV0sye/VbTdRWRMfcIoh90hj8Y6lPLoE/TDh4qru/STbWRfvlj1Y7/nCG26M6v/D6RPkGWfZOzNRMwCJBn/LKixzWZFruRl2LYSePQ/ALAPQa4yyS7zGDp9BXM
X-Gm-Message-State: AOJu0Yyu/oU3Z1TAml2OhsEN+CdVN3cqyUIhYoceuKsxfTqwAOjJyObi
	BBN/7DWCm5YSvXtJkf9Y57Z0TeDOCzyPvNfzG0PxF8+lcd645wjv
X-Google-Smtp-Source: AGHT+IF3yo64JFRXYGt7LWsqcUsipBJGbnyOa5A3LYQGqIy/uEVpWj3eAqcdhLylyTxMLwzT+xMVbA==
X-Received: by 2002:a17:906:2450:b0:a3c:168f:8d12 with SMTP id a16-20020a170906245000b00a3c168f8d12mr1946301ejb.18.1708028646780;
        Thu, 15 Feb 2024 12:24:06 -0800 (PST)
Received: from debian ([93.184.186.109])
        by smtp.gmail.com with ESMTPSA id vu4-20020a170907a64400b00a3cea63f7efsm886361ejc.30.2024.02.15.12.24.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Feb 2024 12:24:06 -0800 (PST)
Date: Thu, 15 Feb 2024 21:24:03 +0100
From: Dimitri Fedrau <dima.fedrau@gmail.com>
To: Gregor Herburger <gregor.herburger@ew.tq-group.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Stefan Eichenberger <eichest@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 net-next 05/14] net: phy: marvell-88q2xxx: add driver
 for the Marvell 88Q2220 PHY
Message-ID: <20240215202403.GA3103@debian>
References: <20240213213955.178762-1-dima.fedrau@gmail.com>
 <20240213213955.178762-6-dima.fedrau@gmail.com>
 <Zcy9E4riyFRk8B1P@herburgerg-w2>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zcy9E4riyFRk8B1P@herburgerg-w2>

Am Wed, Feb 14, 2024 at 02:20:37PM +0100 schrieb Gregor Herburger:
> Hi Dimitri,
>
Hi Gregor,

> On Tue, Feb 13, 2024 at 10:39:44PM +0100, Dimitri Fedrau wrote:
> >  static struct phy_driver mv88q2xxx_driver[] = {
> >  	{
> >  		.phy_id			= MARVELL_PHY_ID_88Q2110,
> > @@ -255,12 +439,26 @@ static struct phy_driver mv88q2xxx_driver[] = {
> >  		.get_sqi		= mv88q2xxx_get_sqi,
> >  		.get_sqi_max		= mv88q2xxx_get_sqi_max,
> >  	},
> > +	{
> > +		PHY_ID_MATCH_EXACT(PHY_ID_88Q2220_REVB0),
> 
> I tested the series on a 88Q2220 REV B1 (which is id 0x002b0b22). The
> driver works fine on this revision.
> 
> I understand that in the Marvell API the initialization for Rev B0 and
> B1 differ. For B0 some additional init sequence is executed. I did not look
> into the details of this sequence. However this patch seems to work on
> Rev B1.
>
> Would you consider adding compatibility for Rev B1 and following? I
> tested with:
> 		.phy_id			= MARVELL_PHY_ID_88Q2220,
> 		.phy_id_mask		= MARVELL_PHY_ID_MASK,
>

thanks for testing. I would stick to the exact initialization sequence
provided by the Marvell API. Registers and bits are mostly undocumented
and I think it is safest this way. Besides that it should be relatively
easy to add the support for rev. B1 by just adding the init sequence for
it.

Best regards,
Dimitri Fedrau

