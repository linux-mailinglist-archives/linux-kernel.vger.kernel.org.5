Return-Path: <linux-kernel+bounces-50321-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 97A2C84775B
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 19:26:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 463EB1F24607
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 18:26:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4371914E2EF;
	Fri,  2 Feb 2024 18:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WqF9dGZh"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D62614E2C1;
	Fri,  2 Feb 2024 18:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706898297; cv=none; b=RAc/cT2j0WBVNdzDmOylAhUjYyvhd+1NbaEyMPVguHemu0Sn0xJPZu60284ChTH/rwDrgEw+x0kRBkn26T/w2hqCrRRDJ9REJyYUs9ivO8ZXy4HdedbqiPwzJqHlWhtHf7wDw5AbvTxRAkkx/c/trvkoo0R5Oq9hk8WJmfVTf3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706898297; c=relaxed/simple;
	bh=VX1jZtActYDGIG5lwScAs4SneAKQp6YFv39czrMMmS8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LXybeLKGDX63QIpGyV/z7tB/nucM2iBx4TrFhff+ioWGK1CMIhkl8+Y0XqKW9Caw5ERR5gxquMJ+2cl2Cawg4mQG8DloED5DfX0k/bu+MN3PmFRxSj/TPHq9Gom+H+usvB5LXpXZf08qYHCh/Udxrx6rY4QKs2DymhnZCuUcOok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WqF9dGZh; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1d51ba18e1bso22141345ad.0;
        Fri, 02 Feb 2024 10:24:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706898295; x=1707503095; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x3+DUrka/k3FJRa3dwdH9/9lCLjbfQ72NhSQ0ErLdyQ=;
        b=WqF9dGZhnojUj4TtqjnmH1SSJ8LL1tIKDunHR0iXkr7BSlIPmrnGGwCCJOQ/H52WZp
         3fjyfYZkR0VItMuQY1gELeFYiDunJe8dmBiJRSTghUPGRbP+Do6hxoWeUdefb/cnCyzD
         2HcU9TZER3uuUpHxdOA+0cjz98XW4J7WT0ABBXSk92nn7GZyme38HldfCJYgU9AwXec0
         y7h8Q89Kc2iaWJfOmYXc3pQtz3mSjyIrqRN7utCLjs9OhZDEWM24q4tz77cGiL3xTHII
         6LEGEqwws/teSuu48YdVW5bXuM/DhZSX4OlnTlY6CD0pfOhqxXMHL1uavNHQHj1NvH7U
         Ta3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706898295; x=1707503095;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x3+DUrka/k3FJRa3dwdH9/9lCLjbfQ72NhSQ0ErLdyQ=;
        b=hfRYB+HKOLIxCeXoH1wK20UCn8oyqPD45++F/qtXA+Nh8/bOLdneKu0/c7SRsu+CGZ
         hcCCSmizUUUDcNiuc9Pf8rDlKCK9YmCDyj/EwJpSDGtNg8eqBFefM4undQkclpW03yFR
         0buMidvyZT04j/z9rOb4lpWyG4+f5r+PRxST1hI7O+3woVsgF8uoz6qSXgNKThEnxYi/
         jk+CLY+8iU4BcerBWmGd88C7Uspuik56m33n3nIrDXKbBk18yLqQZ9GajbtIBWp8/4Fv
         ux+ucS8Gbed4bEVL/QuMoa92hgPOcFSWUpjq9G+KVztsO2PrX9C/mfVcH9SN1h3xaDN1
         tTmw==
X-Gm-Message-State: AOJu0Ywj+tmE55miZfEU/FHSWhXIruJhR3x/Ls3LZJv7HLW5et6iuky1
	UjxCvuOGS0+zYXDZjGu1IzHMMv/BnFzAqQxsS6U6DjusasqeyPyU
X-Google-Smtp-Source: AGHT+IFVPXYSRJ8Qf5DHwNlXmQeiuZ4lle4IZ6zjwoeyv2tUuNskG023hQ8xJQCkry6vegligpbthg==
X-Received: by 2002:a17:903:594:b0:1d7:b1f:be9e with SMTP id jv20-20020a170903059400b001d70b1fbe9emr2721229plb.66.1706898295311;
        Fri, 02 Feb 2024 10:24:55 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWHCywM81DMLQLMH9rk0oZ5wfgvX9MiTr+v37IVoxcA7FbHPPZ7WFeCy8nSlw4wdvRH2Ho58Nm9jN/KOxiQw3tgyq8lZwC0/H9IBjtUE4GV4la0YtkOVTkY+PlyhPuj6lH8KOOxiGl0RbA=
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id ix3-20020a170902f80300b001d8d7323ea2sm1914801plb.74.2024.02.02.10.24.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 10:24:54 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Fri, 2 Feb 2024 10:24:53 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Bo Liu <liubo03@inspur.com>
Cc: jdelvare@suse.com, linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: (adt7x10) convert to use maple tree register cache
Message-ID: <13d99f92-1a8a-4c7b-a66f-2246584046a1@roeck-us.net>
References: <20240202071355.40666-1-liubo03@inspur.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240202071355.40666-1-liubo03@inspur.com>

On Fri, Feb 02, 2024 at 02:13:55AM -0500, Bo Liu wrote:
> The maple tree register cache is based on a much more modern data structure
> than the rbtree cache and makes optimisation choices which are probably
> more appropriate for modern systems than those made by the rbtree cache.
> 
All patches of this series (into drivers/hwmon) applied.

Guenter

