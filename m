Return-Path: <linux-kernel+bounces-50330-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AC2B84777B
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 19:30:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 72099B2A6FE
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 18:30:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C250F38FA1;
	Fri,  2 Feb 2024 18:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dh/lLRrp"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7277D26ADB;
	Fri,  2 Feb 2024 18:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706898636; cv=none; b=d98NZcNAygJAf1/TGHUUzN2iubzWDbUfxuMwb/r82WzZK+ZAIp6Hl/smIDU4W0m9GmOr8RO8Qzi3OxV0rvOmjLukvrBzIAhWcfd4zaqILEdELLUESTxXlRfI7hIxW3sr0Qjocvq8bV6/yJtp/NWwyy4yhBeZ2iC8UjFOJIdUpx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706898636; c=relaxed/simple;
	bh=7+ZNXe8RQ6WizeFSYfqEWIhFGaKx/uASmD7TBJc1N1U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ryo5gu+f82JMt9kihvx51GXpMods9b5WnHlYd0mINP9gJGkUqE2RnoHXGbXmBNffl/umyn4+7OXZhQ4Mow94hx7JWRE1ydch+O6gPGscral1DosuZT6fJX/WiFb7Zmjikl8QIXzGlI33hk2oHFkBRoAoGPPRmtGopbv6zacL0wE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dh/lLRrp; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2d07d74be60so21146531fa.3;
        Fri, 02 Feb 2024 10:30:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706898632; x=1707503432; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7+ZNXe8RQ6WizeFSYfqEWIhFGaKx/uASmD7TBJc1N1U=;
        b=Dh/lLRrpUN0q6k8yNu0J0kyB6oupbsBan23vE+VjwBPsqs75dtQ53+3N+rQb5eg+fr
         2JKU6EsBUBWCQw/inxUmdukkXj+QAehOQp/p//6GzbLK0gUfh+ZMN/d7zvST5XHCIpK5
         md8YE+/pO8sUHQfzxSPX4eq37IQxREEdSpcTpEgCELadQQDIs/yfAB2H68eZG+wG9oQ6
         Akd/ysEgdyHrXf2L7p3aWxOjfeA65KtdlrkD0LSqco39s0HXR4gnuOMbl3l+74ezU8kn
         Zu7Q3nwTt4pALcG8XTXw2hKillRXrK9rKGMy0xkfil0QDEHZBWeMzSi8awI1YwCJd8ad
         bq7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706898632; x=1707503432;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7+ZNXe8RQ6WizeFSYfqEWIhFGaKx/uASmD7TBJc1N1U=;
        b=X8DVMzofIoEdGqbPBGAplrvUA1CZJYlt50xv9m02kW9LA9barINRRafpGZJ5B12eGe
         YjNgQB8bZKm6kXcrIouPaPm8LZp3bcvGi4qFD+CsR2682vECpmzGgqJ7lCthQ0izfS5p
         Y9eyeC0REKZZP7zv0AqBAQZsQZrNFsQpSg1uqQpHPGe7js43c22IMmqhhe08wg4VD9A8
         DXGzHFQUWDJodIfB3kdbwuHKj/LqHEFpBaRMR6T65zIjXYQqjxuGXswEvLQDzSS3laRS
         +SE0AguBkHwRFhN7DdnD5tg5zxGFNO5ucEvVkesP1C726jL5kA3NpLiuLWJ3E7Tvc+Ej
         MbJQ==
X-Gm-Message-State: AOJu0YyG+bl1jOOwhB6rtMW+FMaOo0T6JWW9Rk2+3VyXBbhiwaxiKvjt
	QqM7xWSWzjeXcEIA6PsL9RmxYz5JWfjQFZ+dMteiG8GhTlGdl0LE
X-Google-Smtp-Source: AGHT+IG7ezzuPRxz5SVex2fFfr2/a66lZzV0Rrx/3HqeYAfchXqybAbCKp6y4o59FQqdgN7NyQnVVA==
X-Received: by 2002:a05:651c:220f:b0:2d0:97e9:99c with SMTP id y15-20020a05651c220f00b002d097e9099cmr205872ljq.19.1706898632403;
        Fri, 02 Feb 2024 10:30:32 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCU4ZOzHlOWJQAWr1fWkzCjy59iCNCMAl7Ra78JQSvdffgM6v+DxCAQMDzmV/gZeP1Kyvsaan1JbZc7bWaxkLVEAt0Id0EkOV2pvGgpIux9l1/Pb/O9Hh3pDoo0mMoR7I570cRKvQthAjkSd5AgRiIApdFwYWax+s+RXuCHKpYEV78wGbzHG1rDtqNCXiEDAa/ef4tLWIgumBjaNTzFWHLWZ8PwSBBdnQs6y1p+Bpw/1DdfKwCmqMBlFTHobyrDpDHgiB+WpWIMYCfUPqZFDCgEmqH8BMOwYucL1j6s8GkzVuKk=
Received: from debian ([93.184.186.109])
        by smtp.gmail.com with ESMTPSA id eo15-20020a056402530f00b0055eeb5f0efcsm1027391edb.58.2024.02.02.10.30.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 10:30:31 -0800 (PST)
Date: Fri, 2 Feb 2024 19:30:29 +0100
From: Dimitri Fedrau <dima.fedrau@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Stefan Eichenberger <eichest@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 net-next 00/13] net: phy: marvell-88q2xxx: add driver
 for the Marvell 88Q2220 PHY
Message-ID: <20240202183029.GA16692@debian>
References: <20240122212848.3645785-1-dima.fedrau@gmail.com>
 <20240129180959.582dbc88@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240129180959.582dbc88@kernel.org>

[...]

Probably late, but there are parts of the code which are based on the
sample code provided by Marvell. The sample code is licensed under BSD
2 Clause. Should I change the license in the driver to dual license ?

Best regards,
Dimitri

