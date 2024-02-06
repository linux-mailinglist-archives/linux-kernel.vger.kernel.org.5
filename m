Return-Path: <linux-kernel+bounces-54587-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A41484B13D
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 10:27:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB105284E0B
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 09:27:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B9DE12D14E;
	Tue,  6 Feb 2024 09:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RH4QTPNR"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33BE874E2A;
	Tue,  6 Feb 2024 09:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707211666; cv=none; b=N/b7DnPUiprO4e+M6bNYjlGJiTHYrkuGT/gW5dM1UqZxHVEQntzx+gzVHAb/ZQP/z4fcDd7NI8tb96MxcUcYf9v0SWWuybbYojer42sM49xtTT8U6/4eKLsDfhFWiOCVIjf+LC2ZXmwMchUJdUKzAl+QTPhabse0MA4q02ojksg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707211666; c=relaxed/simple;
	bh=ITxHgj/HKver78KkpB/A9c0skZ5CAVBg6r/R2aNy218=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WkavaJYhNQJ3AMlKjoS30myrN5HdB0A9tX7vxbJsE9e74CMMbCuUdB60gNCC7j0oc3IUYB+j//DK3tj3cjd9GxPzBx938RZf2nds83stObxryGe5MHKCElY9ZYXHnIzcsyY+7wWmQ0TnLbqi8cKe9fIChI8pSY2AaP2IQP/FR2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RH4QTPNR; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6e04eca492fso928015b3a.1;
        Tue, 06 Feb 2024 01:27:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707211664; x=1707816464; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mvhTyBVNUZ9ioizrTOoXbcsU/A9dZDN/VfmQnyeAdwU=;
        b=RH4QTPNRMOEUqvCHeRAht2MOMa0rIhxQNTkDRNPh3F7FxeqCXroEjt9uTeYPXkgUAL
         8gAPFGAINtrRIzBqHoPwragxookwGSSbPdks40IhpElDfg/7IK+WJe24GiV4ZUkzUtob
         xpWVy3Z5h+lihrCEKXmsJjIA1Xv2nWgumybDp8+1XDt10MvRXy45OBqEoeoFOZbjo1kR
         Og629/hpoHD4VD0xM14YRGZRdSdy6SNASfmYGscsPR0HYe5aetRrozPs8eFbMGLsmJqC
         /M2QTh1wCCWEsiTGOb08pdkSXyqKqX18dw/fHAFsfAeAsYbNEwBwlkT745HK+hgy8pYF
         NraA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707211664; x=1707816464;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mvhTyBVNUZ9ioizrTOoXbcsU/A9dZDN/VfmQnyeAdwU=;
        b=SDmfgsgYoCzYYsOFExnjyW18XW1KwPMBLABX/hVWGXEr7ge8aWENlROL9lV1QJhc2c
         tpnahdKcQKmGWBFipbbB3cZ1hxnD57k2s6JBl2ts1qac07/eravpA5AoNa40gkOWxoOc
         9Vo3OXLC7Mb+TlKGcPgt3Ddp5d34jLx7yhCJSmNfEnJ1eNHVN5ccteJ/gMDJrjNoOkU0
         R5Y2Cll/2orDK4wXWeFFwEE7CYAAKA9s8YdxIrwtNjp8X9Xd08BWJC5pWxH6/SqOVQkl
         rqqhjpeRePuXd5uuH3CVEZUncu8W2j+fy0uFLzzUI7jtaSnq9LSfF1CsrqUGobivf4u3
         w1Mw==
X-Gm-Message-State: AOJu0YwJsDTI2OACW6dbLKbwHsHGlBCQLK1PC0Qejl9IsMNjYmWtGMP/
	2hVojJ1PKAKaOPEeaCZTU0j7z6x6RatbwAzyzGUuOz/HUyvithz6/UfEhP0lkxJRGg==
X-Google-Smtp-Source: AGHT+IGzFrTe1/hBI8CQ3sgpfJnoz/OEGzNIZ8ZdA+2fVAyYdWU4zc8d93v4q05weBH2FL+s6QT+8A==
X-Received: by 2002:aa7:8594:0:b0:6e0:4a24:e91 with SMTP id w20-20020aa78594000000b006e04a240e91mr1979754pfn.15.1707211664287;
        Tue, 06 Feb 2024 01:27:44 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWWPT/DSbkR/OaMobx/mOFfKnXv87qCdSxXXXbnu5/o/i1ElAKvmZR0I/RwaxfHdbyMFfusz5mxgp/x0sJd3ySR6fYXfr61Yq7096KP107G+jh1ETc5ujLKI48yDFbZ4IXibSk7xxPjebZvk1D+NzhnjWCsRCu+fnoneUd22yQndEApd8N2TfPG0xRiT3UWg/cMvLvGvOotmk2BeBAm6JW7/heSgYDA9c/wWDjy2A5UJ2PLtm07E6F28q2p0M2BA+O1WZDJmcdtJ5S/JeHTlWQBY5waBjoLNV8ggxPyntT4XaPshGuIR1/FOT2xlsHy3iWkuSg3RanyVPicVf8pOHRuiqwNOM3x3wgDl8ucmtMx/rgBCm7g4xHNAmE3FCQVNPxjsXDchDIDJpMPz9PnbpqdYgu8yYfw9K+9CvyjpwJAmwi76asJq7RG0M/BIQ==
Received: from Laptop-X1 ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id i11-20020a63584b000000b005c6e8fa9f24sm1541854pgm.49.2024.02.06.01.27.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 01:27:43 -0800 (PST)
Date: Tue, 6 Feb 2024 17:27:37 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: Aahil Awatramani <aahila@google.com>
Cc: David Dillow <dave@thedillows.org>,
	Mahesh Bandewar <maheshb@google.com>,
	Jay Vosburgh <j.vosburgh@gmail.com>,
	Andy Gospodarek <andy@greyhouse.net>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v7] bonding: Add independent control state
 machine
Message-ID: <ZcH7icQHZdRchADi@Laptop-X1>
References: <20240202175858.1573852-1-aahila@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240202175858.1573852-1-aahila@google.com>

On Fri, Feb 02, 2024 at 05:58:58PM +0000, Aahil Awatramani wrote:
> Add support for the independent control state machine per IEEE
> 802.1AX-2008 5.4.15 in addition to the existing implementation of the
> coupled control state machine.
> 
> Introduces two new states, AD_MUX_COLLECTING and AD_MUX_DISTRIBUTING in
> the LACP MUX state machine for separated handling of an initial
> Collecting state before the Collecting and Distributing state. This
> enables a port to be in a state where it can receive incoming packets
> while not still distributing. This is useful for reducing packet loss when
> a port begins distributing before its partner is able to collect.
> 
> Added new functions such as bond_set_slave_tx_disabled_flags and
> bond_set_slave_rx_enabled_flags to precisely manage the port's collecting
> and distributing states. Previously, there was no dedicated method to
> disable TX while keeping RX enabled, which this patch addresses.
> 
> Note that the regular flow process in the kernel's bonding driver remains
> unaffected by this patch. The extension requires explicit opt-in by the
> user (in order to ensure no disruptions for existing setups) via netlink
> support using the new bonding parameter coupled_control. The default value
> for coupled_control is set to 1 so as to preserve existing behaviour.
> 
> Signed-off-by: Aahil Awatramani <aahila@google.com>

Reviewed-by: Hangbin Liu <liuhangbin@gmail.com>

