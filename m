Return-Path: <linux-kernel+bounces-97259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FAF18767D6
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 16:55:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2485F1F22020
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 15:55:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 957AE25757;
	Fri,  8 Mar 2024 15:55:20 +0000 (UTC)
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A49F81DFE8;
	Fri,  8 Mar 2024 15:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709913320; cv=none; b=TF2P5hKrMrtKoKqjNWmcdvMKCm0XqvuQTYdSYAQy2RSK2kQZ/wX58qM8t64Oi9TI42fBE439y76UMA3Jlw8jilskiL5+0C2q8f/QNQzWChjO/6s8rH1YTqbXQpw9VOym3tl4/5WTAe1dODiE9TTDtpXJH6KbL3hIPe6fDK/J2qI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709913320; c=relaxed/simple;
	bh=4aCBrDzbrxkls0geNxwqOGYmmPlNrUHv/ManABWlWw8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kU9GH0obCxWZMNBrdWM9OtYmfUtmxhnGm7i8Non7flsptkAO7iPacYSAk9ZDgrItf9Ql37mkSAYqVcV0sqyH4znRNgJkdSd2VFICeF2iHhvjTDSJ0okBX75wiCRlakChfCeJQYfwow3hInVLh2Wkx4JvnNNK+mwIuXzNFHiML+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@strlen.de>)
	id 1ricYw-0000Tr-1G; Fri, 08 Mar 2024 16:55:10 +0100
Date: Fri, 8 Mar 2024 16:55:10 +0100
From: Florian Westphal <fw@strlen.de>
To: Lena Wang =?utf-8?B?KOeOi+WonCk=?= <Lena.Wang@mediatek.com>
Cc: "fw@strlen.de" <fw@strlen.de>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"pablo@netfilter.org" <pablo@netfilter.org>,
	"kadlec@netfilter.org" <kadlec@netfilter.org>,
	"jiri@resnulli.us" <jiri@resnulli.us>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"netfilter-devel@vger.kernel.org" <netfilter-devel@vger.kernel.org>
Subject: Re: [PATCH net v3] netfilter: Add protection for bmp length out of
 range
Message-ID: <20240308155510.GE22451@breakpoint.cc>
References: <571b3e3f7191b5f67792d1090fc537bf4045c522.camel@mediatek.com>
 <e1f1a2ebbbf95d6aa8d2a12811ce379f438ab21b.camel@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e1f1a2ebbbf95d6aa8d2a12811ce379f438ab21b.camel@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

Lena Wang (王娜) <Lena.Wang@mediatek.com> wrote:
> the patch is not applied and it may be due to format error with
> evolution. I will try to resend v4 version with git send-mail.

Its applied:

767146637efc ("netfilter: nf_conntrack_h323: Add protection for
bmp length out of range")

