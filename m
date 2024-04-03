Return-Path: <linux-kernel+bounces-129655-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D6A3896DFE
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 13:21:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3AD481F28978
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 11:21:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40EB3142E82;
	Wed,  3 Apr 2024 11:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f/dqBOHw"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03A4873506;
	Wed,  3 Apr 2024 11:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712143275; cv=none; b=tG/m0yvnXEYd987PITA0XXaLSBa0pJpD+GWEfplxZwPA+uRIuekDQF8uB43Xr8vqXKpcyUekEYc8cxV1OVIojkRTjvMQl2VfJc0qvAy1ZmoOWkPUM6CoAw7B+EwPsDre5h1nb9t8PTCblfTIj9TI6tOoDhWCP9OaU2QxDsQ8f4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712143275; c=relaxed/simple;
	bh=Jy+6GamBtq0hLgPSbZPDgX1ADQqu8LXnkOWPtwPWOJE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SNFFaw5iEPXIE7ovD7+N/WrNytLQ90mdQuIrKDVSqQyMyaOKh8WmueOrw4WuafsA0SrElHsfU5MjrsHmQr4PlWX8o/DAC5afQxJyz6hP6rfH6zmiKuzTXWfvkbhBWWJHaZ1880z492R0nN3GEBKDQDWVeNufq8r4BzSHtCZOjjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f/dqBOHw; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-56e0a8733d8so456717a12.2;
        Wed, 03 Apr 2024 04:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712143272; x=1712748072; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Jy+6GamBtq0hLgPSbZPDgX1ADQqu8LXnkOWPtwPWOJE=;
        b=f/dqBOHwN8My/Kojoh4LPW4ngaGiOdP+bydMi0QiKpoHpqD0fKFfEpbKRDxMlTMBvR
         c3pDyLh+g2VUCpCYR9FaWSEAPy0dL6UbuTukAAzUHe/Ea8V8HbRphc4tdNaGyLq9M5cI
         uChpnz9tJAtfT7mRzJxH3Xa2X+RwPkUpsCjJviXiQbPdvD1CcNvpTevBuNqAK/XRQNf2
         /2KK+vIx8v145SRKQlljfOQ6C7coDjPrUEXpOwUevOl5TANCsyS7FMz6C6kaGPPZ864J
         ajQCuxO4PqWCihWlRbPZDX4A3Nwcg5l/3wMxn8FeFJsmX+MpnHZ/D/+F0hT7Js5cVH4y
         Xs/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712143272; x=1712748072;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jy+6GamBtq0hLgPSbZPDgX1ADQqu8LXnkOWPtwPWOJE=;
        b=L0bAW2+n9Fr91DFFrJr7LL+yyGOSsVrmDSL2TRANEltRMenT5IjH9o6IwNyzR2ecCv
         4VyPCYdBcokCBbK9Q5uCZa1OQmdwoYgZEWZVlksYQdY1VA7B0dkHUkclhO2zTh0DbI73
         bDj6NU9/9cSuckAeb+rGBoti0J2jXD4OxLpVGbLQhA4Ws6rfA0UeuJE6Cj+6ZtEb/BJg
         f17dDbJC6byVKadRYvP2Xc3eunQ9TtkSuklbKEB6X1P81sNpMJ77hJLubZa0w9IP8BAM
         JfjhyoS+3FQCCH9QrcL2hGmz9GCzvNgpvbMgR6+pfBF7eXYgPdnI10JOCnwKYcSth8eU
         6Ceg==
X-Forwarded-Encrypted: i=1; AJvYcCU40WkEfPsB1oFNPFUUt9mFqZTtLfZQXzA9IxDnPAZAt6riFFP4345H2Z/8EWnVUHVHUPd7bB/2xwFfd3Z0ShpwD4VPKwKixqATmjtNd8wgNH7RovcGR08fzrzzTc0WpGtMh+zi
X-Gm-Message-State: AOJu0YwS1L8kgKCtSplUdtEF6d97Qq0KBNMXdT4Ul/F1YbHFOuUcViPu
	ILSg/GVk4o+XRTte5f7Aoy7AedYJehznSrm631kMy5iNKe1W6bMY
X-Google-Smtp-Source: AGHT+IFmaulq//kjt9mR8n46ACLE6OYiDvcuC/qqqpFWh3/kElE10ARa3IH+VSgoRPdFICK8OkzpEQ==
X-Received: by 2002:a50:a6d7:0:b0:56d:eef3:31af with SMTP id f23-20020a50a6d7000000b0056deef331afmr2362447edc.38.1712143272229;
        Wed, 03 Apr 2024 04:21:12 -0700 (PDT)
Received: from skbuf ([2a02:2f04:d700:2000::b2c])
        by smtp.gmail.com with ESMTPSA id p12-20020a50c94c000000b005689bfe2688sm7869709edh.39.2024.04.03.04.21.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 04:21:11 -0700 (PDT)
Date: Wed, 3 Apr 2024 14:21:08 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: "David S. Miller" <davem@davemloft.net>, Andrew Lunn <andrew@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	Arun Ramadoss <arun.ramadoss@microchip.com>, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	UNGLinuxDriver@microchip.com,
	=?utf-8?B?U8O4cmVu?= Andersen <san@skov.dk>
Subject: Re: [PATCH net-next v1 0/8] net: dsa: microchip: ksz8: refactor FDB
 dump path
Message-ID: <20240403112108.tdxwyyih5kt4fhp7@skbuf>
References: <20240402131339.1525330-1-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240402131339.1525330-1-o.rempel@pengutronix.de>

On Tue, Apr 02, 2024 at 03:13:31PM +0200, Oleksij Rempel wrote:
> Refactor FDB dump code path for Microchip KSZ8xxx series. This series
> mostly makes some cosmetic reworks and allows to forward errors detected
> by the regmap.

Reviewed-by: Vladimir Oltean <olteanv@gmail.com>

