Return-Path: <linux-kernel+bounces-99996-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3991D879075
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 10:16:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CF0E3B21D96
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 09:16:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 222D17829C;
	Tue, 12 Mar 2024 09:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bOccOup7"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFA7678298;
	Tue, 12 Mar 2024 09:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710234977; cv=none; b=E+FTWTH8ld59v/V2aj/N5PN5YfT5w4ZGP3kiUyjq615jfo/6fiRTyQVDB9YzW+/shxiduIPsK/+Jd01sFlswHwT1G1aL48qRiKm9R6V+OoXRW4fmY9aIajdZy7hCD8pSOdEXlvghmWKDiHVxAMs0cqMJ8UwS8KpVbG6PCJqGBng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710234977; c=relaxed/simple;
	bh=G315+vLg/P531vku2rclRXAdHwlitSZmCc23+i2KxfA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EgyDOSJT86lUVlG49Jl0pOPB/FJ49kbeG1hBGu+WAvfKcCUV60taV5Dy5d775l1ZnQ3MVJymxslI7UL4U7u35j2P/SZTEu4ZffUN5JSrPcnbuvhaYMVrolOl7bf5ef96fImMRXWPyXINgElIfNE7aMUVIebHOuUDtY0vjYszLWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bOccOup7; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-412e784060cso36730305e9.1;
        Tue, 12 Mar 2024 02:16:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710234974; x=1710839774; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UCbSTMWCq5rGAqV7JzOZ4N2Vb64C/jbpTS2kzFs2kkE=;
        b=bOccOup76rMcwJB1laqu3jM/MkpQwcYJz7hhT1tzMPfuUzwUOLIeBa+jcXd7tzP0Zm
         iPwxRIDNRPVDhVjHjESZusVgmLql9sPVSr25I47nf84DGYsnHkzd9JQGxcEDz0E6H05P
         exQjypyPMk403ZEUEnFNRtnEs3dw+oi8ZppxUK1JK5/2pSREGf0Fsefdd2mevOy1VFcY
         bAv93MTkh0qtf5uLqRz4Aat9Nu0hjqn4QTUvF6uoIeUZ7pJ9MHaXxa/LdU48lN/FTfXO
         ULCzivhbpyXHlwawLren4gmzhe3zzpVsVN4bQjRP1lFV07A/X72IyXLhNYPgzlV2toLH
         6YeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710234974; x=1710839774;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UCbSTMWCq5rGAqV7JzOZ4N2Vb64C/jbpTS2kzFs2kkE=;
        b=swpwePqeL1vtK5xj7vf2tunWhAeuPzBZKnBazO+mO+SFFqv7o76Th6lSKj7eCoTDvC
         mf3VANtn8UOnfqMn90YkTn2M3sTxwAaycWK4B1RDraF0ok0bV0dX9WzCVv296UVrpbsj
         MRQvB7Ed+P/6z3DAvtrrQXcRcE7y1eoC8ob7bB5EXmZLj0LocLzK6PSWUjnqw66Ve3yV
         qfMoMQPYBKd1xtwwHdIKFpCOFjB/TOkT1Un/jImTZDJOmrT0dU5X5hSBTjiray+WB0XP
         UHlIQLr7rTaV70xcBrcMvp61C8Q7vUnuiYI/sf5vZHq50ybvG2E7xC4zENPmF6AvnQAN
         c94g==
X-Forwarded-Encrypted: i=1; AJvYcCW9U+YPVHMMXBAEAQ1MPVX/abeY9VDYc/sjoUJrmTBw2EugyBu/xYnB5FPsFfGJDbQS2urKiObaQb/IEwn09tHkwe02mJq6VmpcNWfXM0aow6TkaasEhDYTtViLUFf/XJRrT6UQfw7sug==
X-Gm-Message-State: AOJu0YzT/fjt2njRccRJFr6F6b+MPTM0sA+KRlfGznRtm5+7ZZ1mcXPr
	QKiRonCxbwm0QA98dfH+431o/QbjMqQ2NOdT8du1eamiphX1hSz8
X-Google-Smtp-Source: AGHT+IHmU0FvtYtu5lBbAmRgmihLpj93b7PVuFWiQadP2jJglX3kSh5T0uFL6LAq6aLv/ier94I00A==
X-Received: by 2002:adf:c684:0:b0:33d:27c3:9f47 with SMTP id j4-20020adfc684000000b0033d27c39f47mr8029417wrg.35.1710234973550;
        Tue, 12 Mar 2024 02:16:13 -0700 (PDT)
Received: from gmail.com (1F2EF295.nat.pool.telekom.hu. [31.46.242.149])
        by smtp.gmail.com with ESMTPSA id jg4-20020a05600ca00400b004134540ae3asm1044464wmb.3.2024.03.12.02.16.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Mar 2024 02:16:12 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Tue, 12 Mar 2024 10:16:10 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Borislav Petkov <bp@alien8.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, x86-ml <x86@kernel.org>,
	lkml <linux-kernel@vger.kernel.org>,
	linux-edac <linux-edac@vger.kernel.org>
Subject: Re: [GIT PULL] EDAC updates for v6.9
Message-ID: <ZfAdWtBt60hAx//4@gmail.com>
References: <20240311155651.GAZe8pw0urOnUZj1y_@fat_crate.local>
 <CAHk-=whTBKoHrBpMxh7OHQ=pcdy6K2zqqsJOZeCC4xSqRXb5Bg@mail.gmail.com>
 <20240312074504.GAZfAIANxTdC5Tb0vb@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240312074504.GAZfAIANxTdC5Tb0vb@fat_crate.local>


* Borislav Petkov <bp@alien8.de> wrote:

> On Mon, Mar 11, 2024 at 06:12:54PM -0700, Linus Torvalds wrote:
> > Ho humm. Lookie here:
> > 
> >     static inline unsigned int topology_amd_nodes_per_pkg(void)
> >     { return 0; };
> > 
> > that's the UP case.
> > 
> > Yeah, I'm assuming nobody tests this for UP,
> 
> Unless it gets randomly enabled in my randconfig builds once in a blue
> moon, I'd say pretty seldomly. I've heard people raise the question
> multiple times whether we should simply make CONFIG_SMP default y on x86
> and frankly, it'll get rid of a whole bunch of stupid corner cases like
> that...

Making it 'default y' in the Kconfig alone changes very little, as people & 
bots will still stumble on !SMP via allnoconfig or randconfig builds.

If you mean forcing CONFIG_SMP via 'select SMP' on x86 on the other hand, 
that's worth considering - although I think there will be a ton of extra 
cross-build breakage as most patches still get created & tested on x86.

In other words, the x86 UP build basically has the side-effect utility of 
covering a lot of UP cross-build scenarios in generic code.

I think the most viable approach would be to make SMP the only model all 
across the kernel (and eventually removing the CONFIG_SMP option), while 
propagating UP data structures and locking primitives to the UP arch level, 
instead of having CONFIG_SMP #ifdefs in generic code.

Maybe not today, but certainly in a few years.

Thanks,

	Ingo

