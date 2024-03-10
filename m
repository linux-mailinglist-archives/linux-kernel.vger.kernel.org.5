Return-Path: <linux-kernel+bounces-98080-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 93AB28774CC
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 02:35:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 332F81F21375
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 01:35:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ADBC1102;
	Sun, 10 Mar 2024 01:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mmK3Y/8R"
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1781DA3D;
	Sun, 10 Mar 2024 01:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710034505; cv=none; b=nSsmzUPvadVoU5LjhM/zYnpQ9+45yKYLz34QYU+GH/diWJDEpHF/DQ2MUdVDdSJ6KyhQEOTFxqttTrUuBqtdkRUAkpBnIWvvRa4ndHrnuH+lNDSlHffe8XjFOFCikz2DJMlGXUMLXtxvQzkEa+esptyULHiiUfCPt7i6/7R/1q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710034505; c=relaxed/simple;
	bh=u2ahYEe/OC/MKqhEiuSRF20YFFHhwbPowZ5IkhqOI1U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F5U8ORE1fClbJQ7j6sw68nk1KPzSTTNJbq1girh6YaA4Km07+cWvi5OUddXQcwuQGxvn/zbbjJ3o5fMzGW2by7cfe8ubjH9GmbkBFRk34WJUgvrv9kNeZ30vimDLmBGBNT/eDsL1EVMUaWCOZS9YDBmUWKblL8dm1G6YaOFMfyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mmK3Y/8R; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3c1ea5e54d3so1928429b6e.0;
        Sat, 09 Mar 2024 17:35:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710034503; x=1710639303; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7FC31QWLbYl7pppwjrQr/52Z3jxKLet9upvA4dWzNUo=;
        b=mmK3Y/8ROBoPoMaI4Sj+lVsVPIFh0zb9v1bkaiMFlawqj2YKRo9xdAA5GYL5WL4u5R
         PuMFipV+IhDNiD92eq++DqjR8rmaduVRff8OHO78BjvOeAwpPRcTYvGTh5CIYl/4aZ8W
         r8jus9DiJMh8XzBMvKu7Ru22bAu3wKO4YABqXYjLg4XsWDGivAhEgmUsHjyFDJX+kcXC
         afL6twXEnG92pfHbj9nfeoPlhJ5+s2pkyQszijF7mQB9B61lO1l+WFIdc6MXQ+wu/H7e
         KIWt2QUfR0KtzZHSDPjskLW2C8eaOrmzdt1G0MGMOUuxY3R+k/7ct24+V4evtkj3kZdQ
         tW8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710034503; x=1710639303;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7FC31QWLbYl7pppwjrQr/52Z3jxKLet9upvA4dWzNUo=;
        b=sDbpAZqSezP7kE26ddFu/BHN3gK6MU1cf8xxzAXS9E9ebB2+iRv9WHmAdENOs7nC0C
         a96AGzTgV0JUfSGRGcs3zDnbBezDaNHAdMkQfiD/PhWl99UtHaZDT8d+8eNjOIaRnxkT
         rurESZOcJmC/C8gdDCaF9q5jOe+ag+HhWJPuB02ayAZXL1vEXc7DHKIfe8d7w2H1P7lO
         ClRzQKZQ3DXoXmLOFMVfUrFSWh6pKsJS375j3BdeWVz8P7ksk0KbyYXhVAogX3xpNnl2
         qFVwgLVTt9t5y0U5WHMKhB6LB5iYp4OHwVhMV6FxhuJaLAMbodL5KsAcRXQHFh8YZFKw
         mIcA==
X-Forwarded-Encrypted: i=1; AJvYcCW3UNpBrjubqQJYJ2G0gI3x5nYF+dyfTYDPv44s+6+i1V/wQCl1sveBVZWHEaSLfWXc4xrQAhyOlRnBgmYmFl2CQWjU11fs5otjWlF4eHyQIYV5Dm4nX7TAL1aVoNICPLRcdWfzMR4x1g==
X-Gm-Message-State: AOJu0Yy5n3CYh7BAsT7rTmUZBnZEqkE5MB71OCgcMLsVJek+eDffb6si
	ajhOocckJQHoyrzWg2bFJRwJjVGlJMbYCZg5scFz1Yq7Iji/uTVM
X-Google-Smtp-Source: AGHT+IFbSJaiVTEIBHx3v+a/OskZBR/IbC3D4hxvxa8psF6bCaN2sK8jpJZkYviIW8ZM6dFrnzpEOw==
X-Received: by 2002:a05:6808:23cf:b0:3c2:1d8d:267a with SMTP id bq15-20020a05680823cf00b003c21d8d267amr3848400oib.6.1710034502832;
        Sat, 09 Mar 2024 17:35:02 -0800 (PST)
Received: from google.com ([2620:15c:9d:2:5296:fec3:1fa8:a601])
        by smtp.gmail.com with ESMTPSA id d1-20020a62f801000000b006e6253bbcb7sm1758401pfh.61.2024.03.09.17.35.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Mar 2024 17:35:02 -0800 (PST)
Date: Sat, 9 Mar 2024 17:34:59 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Sebastian Reichel <sre@kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	NXP Linux Team <linux-imx@nxp.com>,
	Dong Aisheng <aisheng.dong@nxp.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Mark Brown <broonie@kernel.org>,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 04/17] dt-bindings: input: touchscreen: fsl,imx6ul-tsc
 convert to YAML
Message-ID: <Ze0OQ0DB1TZEtJ-6@google.com>
References: <20240213010347.1075251-1-sre@kernel.org>
 <20240213010347.1075251-5-sre@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240213010347.1075251-5-sre@kernel.org>

On Tue, Feb 13, 2024 at 02:00:53AM +0100, Sebastian Reichel wrote:
> Convert the i.MX6UL touchscreen DT binding to YAML.
> 
> Signed-off-by: Sebastian Reichel <sre@kernel.org>

Applied, thank you.

-- 
Dmitry

