Return-Path: <linux-kernel+bounces-33019-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 52840836349
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 13:34:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E70B61F21CD7
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 12:34:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CB1238FA5;
	Mon, 22 Jan 2024 12:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e5+MoYN6"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5423A31A61;
	Mon, 22 Jan 2024 12:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705926835; cv=none; b=FdeCRydcyFojSVxXwp99R13Se/QsM4S66uwpQAcypStoIXuTytUpgHnzE5N2ks2aM0IUZTDhkKFmDnXErhnlozyGb9ZaVdB8jzpEA8Q8MHn5UCwVwK71EIWjQ+3twu+WdrF1dYEWy6ZaZbwxbsXBFdOeWTwlpGMgrFZNthcKu10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705926835; c=relaxed/simple;
	bh=XTDB6//crJGG/H3m1XnEvHrPWpGka2r/ZPypNjVQ76w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZtX0nEL1T3fVJdoDThT46inC30R64wFu+TJDn8Yc5rWBmwYqgytvfnBAGtCDv03hT/j1TQNKREkzxB0v+ZRr8nr7JEm0O3h8QJlPPy23uwadDpwYTju/O+Q3eIli5oXBxYk2gnx+dkbYcsOU+L6TW0JEcy1DhadRy+6MEOXUVT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e5+MoYN6; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-50ec948ad31so3291941e87.2;
        Mon, 22 Jan 2024 04:33:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705926832; x=1706531632; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bFxRSXpfyegZX74xz8OgyH0TqgyPmSRwyVAL2eqo6Q0=;
        b=e5+MoYN6jNiDGC3rkIDjt65kly1odEFlx95Qv8pbnLFOT9JJU1Je3RH/FBHgp1hEXf
         Ph3MUr6nBNqxOoAzV9z7JMBkmXyzo+9zWGP9orMd8X5/pW8YTErOWX13Cw+5L/ig6Ipv
         nhSEZX8HkyKvx6RQ3kV2+1/LyQNKtb1SMVObxnwEpgbq2TnpcjJd+541HC2FiV0My9Wg
         ydHwI1eCjmztKgoafFRu3MNYNPCD+MNaPuNuB79wPBmiP2sXLjedmMF9hilyNxJbVVJ5
         Zbl0TckF4QFk7BLNZzz3IP9ckkMosJ4rqlDr79Zp3RwSumaJLNGO6mV/nV5IDHvyqXME
         jASA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705926832; x=1706531632;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bFxRSXpfyegZX74xz8OgyH0TqgyPmSRwyVAL2eqo6Q0=;
        b=d8Qpy5gCDVdSb5nOd9NOO6dYM7KTL5re3oDyWi5L2EdOZxS6XsrW7x8Y/bWdG2x3tN
         sbMlF3OYEV1rcp1pureOojeEVDXuizWmI6lwRTsTtdbB033xmNckA6sK385A8MUg01Jy
         Eu85hSdSPs+efGQS6gTidHZOBUBXky8az0bNOIPheD4q2il3W2ttrP/gccqTv/FdvSL4
         0ALVu2fOdBA42v6aBxSkmQkvZV+65iQk77vQr7khHgaiC3zNjLpfQRKn1WfTSwsnIXqr
         RvlfRiFdeXlQhK1qlQP4bSKvpdp1/2ffN96zgSIU/xWpWio1Lzd5N1vatGHJ/ZFlErQe
         M3uw==
X-Gm-Message-State: AOJu0YywLhMdYz2JW4aYrrAOoj7OVdxMxoNNzqPuAp2rIE2mjeNtX7Ev
	tBUPNoepLatojUZw6HY4l3lZZcgA8C/aE/mfNE5jVmT/b8RVzxSE
X-Google-Smtp-Source: AGHT+IE27PJB1NHdKUDjIrtru5lVJQa/6wd07V7mmwsTZ2/nxlWmOfso3vPr5kcpEXy5gjqP7xfJ8A==
X-Received: by 2002:a05:6512:a8b:b0:50e:ccd8:f9d9 with SMTP id m11-20020a0565120a8b00b0050eccd8f9d9mr1771847lfu.24.1705926831991;
        Mon, 22 Jan 2024 04:33:51 -0800 (PST)
Received: from skbuf ([188.25.255.36])
        by smtp.gmail.com with ESMTPSA id q9-20020aa7cc09000000b00558a3e892b3sm14008365edt.41.2024.01.22.04.33.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 04:33:51 -0800 (PST)
Date: Mon, 22 Jan 2024 14:33:49 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Tim Menninger <tmenninger@purestorage.com>
Cc: Andrew Lunn <andrew@lunn.ch>, f.fainelli@gmail.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: dsa: mv88e6xxx: Make *_c45 callbacks agree with
 phy_*_c45 callbacks
Message-ID: <20240122123349.cxx2i2kzrhuqnasp@skbuf>
References: <20240116193542.711482-1-tmenninger@purestorage.com>
 <04d22048-737a-4281-a43f-b125ebe0c896@lunn.ch>
 <CAO-L_44YVi0HDk4gC9QijMZrYNGoKtfH7qsXOwtDwM4VrFRDHw@mail.gmail.com>
 <da87ce82-7337-4be4-a2af-bd2136626c56@lunn.ch>
 <CAO-L_46kqBrDdYP7p3He0cBF1OP7TJKnhYK1NR_gMZf2n_928A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAO-L_46kqBrDdYP7p3He0cBF1OP7TJKnhYK1NR_gMZf2n_928A@mail.gmail.com>

On Tue, Jan 16, 2024 at 05:51:13PM -0800, Tim Menninger wrote:
> My impression is still that the read_c45 function should agree with the
> phy_read_c45 function, but that isn't a hill I care to die on if you still
> think otherwise. Thoughts?

FWIW, Tim's approach is consistent with what drivers/net/mdio/mdio-mux.c does.

		if (parent_bus->read)
			cb->mii_bus->read = mdio_mux_read;
		if (parent_bus->write)
			cb->mii_bus->write = mdio_mux_write;
		if (parent_bus->read_c45)
			cb->mii_bus->read_c45 = mdio_mux_read_c45;
		if (parent_bus->write_c45)
			cb->mii_bus->write_c45 = mdio_mux_write_c45;

My only objection to his patch (apart from the commit message which
should indeed be more detailed) is that I would have preferred the same
"if" syntax rather than the use of a ternary operator with NULL.

