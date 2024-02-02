Return-Path: <linux-kernel+bounces-50225-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 207008475FD
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 18:20:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFD512897AB
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 17:20:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C3F514A4F0;
	Fri,  2 Feb 2024 17:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jFHZy+v1"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3943214900B;
	Fri,  2 Feb 2024 17:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706894404; cv=none; b=E90p3aFeIcp9exo/7TOUfVFjf3vOKHpxXdl/tQUmjs1Axq3sIDFkJcWqSHUxpdCb1lio8YoIAu08ANXBpbrEnVI7ACBbn+vjxey4+2Ro4X7E/mhbt/loKxCh+m4TOCjUx2REepgYYDE7x/xNN3cNNjc2oQmbKLJiFd17I5yUWuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706894404; c=relaxed/simple;
	bh=78qt5n19+ABzavo24dA2OgwBbqzfP5wwEHfKdQ2/2QE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o30ikaiQaikbzNIBnj+m6rl6S04tdL41WKCk7RCGHPPOyDPIh/uWNxbfSF9fgznsO6+9GKB4J5sEhzTKaAvfT89EaXv8EKeBKwtjIqikfCrQk4Teg91amPhhogPna9sXajf6F41ogOOJGkv3aB6e8dJ63FDduntbenbxhJV7X1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jFHZy+v1; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a35b32bd055so304722566b.2;
        Fri, 02 Feb 2024 09:19:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706894395; x=1707499195; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=llNg+QcCC9Etp1BNz1xZAuQs7//rlGxRQyEuMd7b5bY=;
        b=jFHZy+v1xoxE50D2Gflcec0qmlOxY/BgUETrwzjctGlKww7fNYn8/O0qyOFxHDTgKI
         /PZSJFeTdien7rE+F5T5hNsBFnLSv0/1DK9e6W2qqm0/Yw0ms2Nna1vO9c/c/3w0z16J
         eYVGpBDtt8PGsUKVmmyykmWjC7iK0XFusL3kvhi3s3fcvdZMSTawtkKa3iemWV4Up2JG
         OSJofApHiiJ2YNmnHNZvQ8eF3+3Mg7OJyGmFWGsyfkMMtAU7BlkQqXDsI8yhFE4ExTq8
         Z0E105SklSX+bgq7ABLZtXV2iD3PLcXdaoXKZxMYhS71gqycSyAIhcA4Wc336FoFaUwt
         Z9lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706894395; x=1707499195;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=llNg+QcCC9Etp1BNz1xZAuQs7//rlGxRQyEuMd7b5bY=;
        b=iH8Owt81wpUeFGR6JxI1x504EoeImu1mjOtHqq/vt4isTm9HqGYhxt57Sf3HX+kq6K
         wpmCB80JhT+xluO87lBMHsCpyfH4KhXQps7qLxgCjGRgqY0EqwG6st25SwVuTmTNAaGu
         3VJLd6Ocox8afCthyB52Ek1PlBtXy+qIVakw27VIRTHqU2FlZvvYxqSLDuR4rCrlbTf+
         agFEx6Im6rg4dVONUxGzzhqwuIl/f5uYgyLwallBppCeu/HTozanjzhGbOoZJnNprbTY
         +AnlQ5Ur40UDFqmKCaxa2h4JxUwr9GKUDQiig+9hahMEYnqaGAhx+6nAyA4iJ8asLiTi
         yijQ==
X-Gm-Message-State: AOJu0YzxCpF/Ju48R7GOU2OtYQSD8VOg0jejJyqam01qw6ycsJRhuGPE
	0iCrcpU8NPQ9IxmhfL1M1q8g16DURZSai5idcJEjc/icdW4DDmB2
X-Google-Smtp-Source: AGHT+IEVATz8TpD0QMxyZUcSqhdJycffCOdk+ClTcUz03fAivZ8ttOQQJ7vcKqJeauYKlwmCauVz7A==
X-Received: by 2002:a17:906:3ad1:b0:a36:84f5:5186 with SMTP id z17-20020a1709063ad100b00a3684f55186mr1876891ejd.77.1706894394990;
        Fri, 02 Feb 2024 09:19:54 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWDvfxhhgzxO5Gfg+4UUjZiGoqU6Tf9D6fdnebwX3NWkI1A093EndT+vlq9iYIienwd2C7vHRkmVRHplohQfV1ruzQQRr+44llYuw/ZQVfRZigzzJMKxGWjtr8p3MHLRwyxPm8aW1+ikC+790Du5lFcqPFOalk+PXR0XprpYdAGDw6FJKt+iqxgnrz2ZpGT+jqKdKEeexxbg3vrToweszpNRPEfp3q51pOvpHzKANjAChgve3nkxtKUoNobsMKLskICt0k0UE3jrELVq+1wsfF+JdpuLu1R2W0OX7HV
Received: from debian ([93.184.186.109])
        by smtp.gmail.com with ESMTPSA id ti10-20020a170907c20a00b00a3687cde34asm1075135ejc.5.2024.02.02.09.19.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 09:19:54 -0800 (PST)
Date: Fri, 2 Feb 2024 18:19:52 +0100
From: Dimitri Fedrau <dima.fedrau@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Stefan Eichenberger <eichest@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 net-next 12/13] net: phy: marvell-88q2xxx: cleanup
 mv88q2xxx_config_init
Message-ID: <20240202171952.GA14633@debian>
References: <20240122212848.3645785-1-dima.fedrau@gmail.com>
 <20240122212848.3645785-13-dima.fedrau@gmail.com>
 <c2bb9f1b-2003-4c0c-b6c0-1cee6ac6a5b8@lunn.ch>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c2bb9f1b-2003-4c0c-b6c0-1cee6ac6a5b8@lunn.ch>

Am Wed, Jan 31, 2024 at 04:21:44PM +0100 schrieb Andrew Lunn:
> On Mon, Jan 22, 2024 at 10:28:45PM +0100, Dimitri Fedrau wrote:
> > mv88q2xxx_config_init calls genphy_c45_read_pma which is done by
> > mv88q2xxx_read_status, it calls also mv88q2xxx_config_aneg which is
> > also called by the PHY state machine. Let the PHY state machine handle
> > the phydriver ops in their intendend way.
> > 
> > Signed-off-by: Dimitri Fedrau <dima.fedrau@gmail.com>
> 
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
>
Thanks, for reviewing. Is there a chance that you also have a look on
patch 13 of the series ? It relies on this patch.

