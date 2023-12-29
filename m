Return-Path: <linux-kernel+bounces-13038-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 759D581FEB3
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 10:29:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3187328476A
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 09:29:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE13D10A1C;
	Fri, 29 Dec 2023 09:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="aMJyCzf4"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 473D811184;
	Fri, 29 Dec 2023 09:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 5D84640E01A1;
	Fri, 29 Dec 2023 09:29:16 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id wnHWluQJn0sJ; Fri, 29 Dec 2023 09:29:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1703842154; bh=4N7Kr/MGSg7tikDeaMTSR6yCealwOw+LHZRbN09RIsU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aMJyCzf4v7ql2qBmsCvnNfdzwM6/znzmWeVs3SNkzOR6Gnf+gqtceacA6hDUteVqa
	 Q77PMNMe3A4DsCyCsI8WkrrSB+vaBg6gewhx4p7RnoNZw0qWfTjJARmvgTMTS0FRwx
	 8k5YharTbMf2jdEFNfVxCsAmRCc58bQo7cZKKpu51Be9PyGGpJ28qedYt1MOU7DPkU
	 kALk7BCAmahZhoZXeVr96hFe8W3wmldFYeKFiEgvfA70bE9b3PhKJuHloB7EUvE4nj
	 46XkE1m1+dQApy9WsaR6N8RlxctGaUFtog7hs3fiYMjpjuiaKcVihplY6uTVRJOAVh
	 NQ5WkTsiBbLnAZN2id6Sc03jIe8XuLTMQ4nmKjm/7bfwutMwpgeP2W5NHgSWEUAOhj
	 PKqnafZywXmFBRLDD4gqWvmFBWjq0c45XeHoUb7wBF33YurZi3r4LFoypt5Oj70hPI
	 bk4AnFPYubi6XC3ogzRjUeEaTaTNOopzK2XwW2EHUppckA6JOcHRFHUrgHRumb+xBc
	 gbx5cAToPFHji2eBBHYGHqYrd+O0HECI6UNXTOxndl2rimNBQje01YPTfnw2oDotVU
	 ovBNbnqDIYI6QDRsW/jsYNWiR8+1cK2iPOSmmxI+3Fk/709/Aio3qfCeDezQeaoMlp
	 I+/AAFNNAvV9iKGZRZ3zC0yU=
Received: from zn.tnic (pd9530f8c.dip0.t-ipconnect.de [217.83.15.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 1C0A540E00CB;
	Fri, 29 Dec 2023 09:29:07 +0000 (UTC)
Date: Fri, 29 Dec 2023 10:29:01 +0100
From: Borislav Petkov <bp@alien8.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: tony.luck@intel.com, linux-kernel@vger.kernel.org,
	James Morse <james.morse@arm.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Robert Richter <rric@kernel.org>, linux-edac@vger.kernel.org
Subject: Re: [PATCH] EDAC: constantify the struct bus_type usage
Message-ID: <20231229092901.GAZY6RXUVHsq1d8gEI@fat_crate.local>
References: <2023121909-tribute-punctuate-4b22@gregkh>
 <20231228150003.GAZY2Nc38sAIa0bat/@fat_crate.local>
 <2023122918-tiring-isolating-3f4a@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2023122918-tiring-isolating-3f4a@gregkh>

On Fri, Dec 29, 2023 at 09:10:02AM +0000, Greg Kroah-Hartman wrote:
> Hey, we could be using German and then it would be something like
> "Konstantifizierung" :)

Ewww. Or to say in German: "Oh nee". :-P

Lemme guess, that must sound similar in Dutch. google translate says
"constantificatie". Fun.

> Ah, oops, that means this depends on a patch in my trees already that
> fix this up.  You can wait until after 6.8-rc1 to get to this, or I can
> take it in my tree if you want now, which ever is easiest for you.

Either's fine with me so I leave it up to you.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

