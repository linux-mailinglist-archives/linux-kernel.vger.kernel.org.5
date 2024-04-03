Return-Path: <linux-kernel+bounces-129648-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23471896DD1
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 13:13:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF8BAB2B582
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 11:12:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44285142E75;
	Wed,  3 Apr 2024 11:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CZrXfoFq"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01BBA7317F;
	Wed,  3 Apr 2024 11:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712142720; cv=none; b=FcVj6Mo4Gmw5Zj/Kl75dPmVGhygkLv3awn8N09JecH4tCgWBtKUFWPbzhT9Ya6VBvkdGurXLn9or2Mf++eF6jwY88W1UzTwzIsXNKLuprPgc6ASkJjmKBxF8KbC+g1lSPVtRU62KpWxFQmQhvADdsxcJdQJdpdn1xBeigdPJF/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712142720; c=relaxed/simple;
	bh=/VaNHH7OXnX6xRXyrMV1sFuKn4WnR5gB6la3Xx+0COk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oNchJUvE+ExCb/TZadKlBNXityvBTOX/g1EqBiQ3bhM2s18M/hJus+kyZe/UNyar9tkR2u2sGJcDgse1Kqjvn1gSwXtQxMvGAALzt/PHYEY208ABVgU2YHtnjJ9k5/dIIHyzdJNEB8WevpZ/d0FIwE4GbYH42ZUYl0rIkpSCEOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CZrXfoFq; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-56c5d05128dso4996470a12.0;
        Wed, 03 Apr 2024 04:11:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712142717; x=1712747517; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kusQcMg0fEKZMOXrdCO/VutgKZFLYZe73+kfKMTWYZA=;
        b=CZrXfoFqtDWfc2bmzOHsrXg8cNQEgTge5XkGTm4WQGM9Zx6Doib131AxnLuc2ou2mh
         Levq+9NotzNOpe80424b2feMNJRo7h8q9SSOuG46AicjlL/aT9wTFs8iRVioteseFH1P
         gqecJYg6Tk1P3er7KrXI6GzQU1LbKTBCeHqqU65Rto2ZSAcUkv8aPdmgHHiZMS5XyvMK
         oE13WW5L4Bsjz+xz2KT5V/NE783fb6b97x4IbxCOX0RNPbCW/54Cst/f1YMI19M2rXz0
         8CFB+t4v8c5rImd1yPAHZYidbHrpBaA0+E0sQILPLDBLXXwPhZuDORvf+saLTeMYrxFJ
         /1mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712142717; x=1712747517;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kusQcMg0fEKZMOXrdCO/VutgKZFLYZe73+kfKMTWYZA=;
        b=C3FW7HX3Km8sFL1QD6pwX2OJNZhxrD6qQrCczQPXkrf487ZYgODIj65NgX8JwMFZQU
         BW90lJ6bUbavsykmL9cH8Qw1s9ketAcCixxCpbQTzCJlh3HLP0DZFee830PWsvTygIPm
         sJin/RSUWphq5F1qTvdlgNx6gsRjjqWH75fIUjzqYbMynKZe1y9zlAkccKvdpxBo0Lu3
         /CVMVlyUJAf6f8vDpfKD0o7BjQH3Okap5TIX3gEzg2GzKp8HZY/x6TXueCAFGTYUHiG/
         4uLOQ7aVkiriHOF8h/KGE/iU67jGnZ1PCo68ptHcB3XM6B6ckSDqQF7l33VrLfUd04t8
         seXw==
X-Forwarded-Encrypted: i=1; AJvYcCX15bIB+Cr9MxiwS19t5q/wX2fXMaxpVRVlFYL62iPboLUJe/cMiZTaNkPeuHXEXe7THdxKq9mHI37g3bRT0pJa1AgfUTTE+b890zpfsG/TntB7TS8djUiWfvu20oJ5KvEn6/dqU6XmMba0kboRrSiX7NicpR9NStB2gBhrJ8HSMYCvzdD9
X-Gm-Message-State: AOJu0Yyk69k/2OsBpxW6Ow2kfwaruUaFsD42/0tR5mPOoChUoRWDBVgb
	lN7aNhn78bWAY59Ky4GMIYX6+VdYiUWlpzfmztCAM32F5ct0TUz+
X-Google-Smtp-Source: AGHT+IHcGN/ynXiQNOtaEymy1W6bBw/sJqcBsR9M3p5VjZ76l9Y9kEHQqpyQNgcykhiAAQzlXtrsyQ==
X-Received: by 2002:a17:906:595a:b0:a4e:1966:1874 with SMTP id g26-20020a170906595a00b00a4e19661874mr9977058ejr.37.1712142716897;
        Wed, 03 Apr 2024 04:11:56 -0700 (PDT)
Received: from skbuf ([2a02:2f04:d700:2000::b2c])
        by smtp.gmail.com with ESMTPSA id w17-20020a170906185100b00a4e9359fbe8sm1333271eje.44.2024.04.03.04.11.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 04:11:56 -0700 (PDT)
Date: Wed, 3 Apr 2024 14:11:53 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Michael Walle <michael@walle.cc>, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH net] net: dsa: sja1105: Fix parameters order in
 sja1110_pcs_mdio_write_c45()
Message-ID: <20240403111153.en2357al7oerkvug@skbuf>
References: <ff2a5af67361988b3581831f7bd1eddebfb4c48f.1712082763.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ff2a5af67361988b3581831f7bd1eddebfb4c48f.1712082763.git.christophe.jaillet@wanadoo.fr>

On Tue, Apr 02, 2024 at 08:33:56PM +0200, Christophe JAILLET wrote:
> The definition and declaration of sja1110_pcs_mdio_write_c45() don't have
> parameters in the same order.
> 
> Knowing that sja1110_pcs_mdio_write_c45() is used as a function pointer
> in 'sja1105_info' structure with .pcs_mdio_write_c45, and that we have:
> 
>    int (*pcs_mdio_write_c45)(struct mii_bus *bus, int phy, int mmd,
> 				  int reg, u16 val);
> 
> it is likely that the definition is the one to change.
> 
> Found with cppcheck, funcArgOrderDifferent.
> 
> Fixes: ae271547bba6 ("net: dsa: sja1105: C45 only transactions for PCS")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> Compile tested only.
> ---

Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>

