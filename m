Return-Path: <linux-kernel+bounces-14909-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B63DD822469
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 23:04:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 452FD1F23836
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 22:04:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF90D1864B;
	Tue,  2 Jan 2024 22:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X/TvCjBQ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 019F218646;
	Tue,  2 Jan 2024 22:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3bbbdf0b859so5291183b6e.3;
        Tue, 02 Jan 2024 14:01:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704232894; x=1704837694; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mqI9o54z9qRSDIMHvl1bUrXAFI07BELIcpmN1oqYEIU=;
        b=X/TvCjBQswBhArHn8iAvqZQn+LS4Umi5sN1okgyimPa06RfzVL5AI9SG/dHlXJwYtP
         Oi4jPo+OMYgMqV/UCoFC4ievTPN1Y8p95t0tNQCopYzv1KqdRD/CFu0+JPO3Yzb0shUy
         IXTdAiJmM0k0DD53xsNMOkLj+RcEGZ0YzmS8EGg89Ntxn8b6e7xGXSrcgZWeqHp+djTM
         X5i5XPAAGFxpXRw/vX87UWAN5MycCYb7MJSXH60q3fRuWrkk/S8TRTc6cn3Tz+F7vrAU
         AN/NWRq9f02keRl7rcG1B5sLAAwpZsYn83BHA4ZlVNqArO8kP63ycAtxIJ4fBggf+joW
         k4Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704232894; x=1704837694;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mqI9o54z9qRSDIMHvl1bUrXAFI07BELIcpmN1oqYEIU=;
        b=g08vc57XNX+hVEJSpdEtzlpcDpMy1JyWmjWQvoVok4epaLiV2RwiClHenp1Y1/SryN
         UsIlA3s11E0l1BKeFJshfW5CWPRE/ZeoXT2mLggon5+6efWi2MBEto3SCfouOcn52a/7
         mVeQJfZxkuMDVRiG+1XiF8V2jdkBfw8Ql1LWorLfB2VSbdJ4Tzm+xDtejZQlsoZlMv8l
         BygJXm0Vc0dEG6oUEaUmJ+hboK923b/JDlQy7LeN4sdmhBiNjn/stb+G6Bb1VDfoQXLj
         FBLYtFoxyKWGBE3xpHqCSaR3ZVoZ+QyxV/4yEBWQbzNA+VlWOd+Q1cQ+4biMYq0gSIyx
         Pf0Q==
X-Gm-Message-State: AOJu0Yz2Ae6AgnEJJj1reQBumN6oigjK1lyyHplLTSlC2xkhu87gaEKM
	k7Ovaej0sewzbW79UCZqB/wbK/6SSTg=
X-Google-Smtp-Source: AGHT+IHZJgB/+lNjtSFxLat8Tr18hFlaFdVfpMJks0gtk8aynOT14d4JPagPUed58Sicz/NncFP23Q==
X-Received: by 2002:a05:6808:1708:b0:3b9:e2bf:c24e with SMTP id bc8-20020a056808170800b003b9e2bfc24emr24064815oib.15.1704232894093;
        Tue, 02 Jan 2024 14:01:34 -0800 (PST)
Received: from localhost (48.230.85.34.bc.googleusercontent.com. [34.85.230.48])
        by smtp.gmail.com with ESMTPSA id p13-20020a0cfacd000000b0067f678747ffsm9148761qvo.50.2024.01.02.14.01.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jan 2024 14:01:33 -0800 (PST)
Date: Tue, 02 Jan 2024 17:01:33 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Arnd Bergmann <arnd@arndb.de>, 
 Thomas Lange <thomas@corelatus.se>, 
 Netdev <netdev@vger.kernel.org>, 
 linux-kernel@vger.kernel.org
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 =?UTF-8?B?SsO2cm4tVGhvcmJlbiBIaW56?= <jthinz@mailbox.tu-berlin.de>, 
 Deepa Dinamani <deepa.kernel@gmail.com>, 
 "David S . Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
Message-ID: <659487bd95ff6_2aa3c62948e@willemb.c.googlers.com.notmuch>
In-Reply-To: <fb69e804-6a9d-4052-a96e-40f8a20c189a@app.fastmail.com>
References: <d1ce6aba-1b10-471c-ba60-10effa1dac10@corelatus.se>
 <fb69e804-6a9d-4052-a96e-40f8a20c189a@app.fastmail.com>
Subject: Re: [PATCH net] net: Implement missing SO_TIMESTAMPING_NEW cmsg
 support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Arnd Bergmann wrote:
> On Tue, Jan 2, 2024, at 22:13, Thomas Lange wrote:
> > Commit 9718475e6908 ("socket: Add SO_TIMESTAMPING_NEW") added the new
> > socket option SO_TIMESTAMPING_NEW. However, it was never implemented in
> > __sock_cmsg_send thus breaking SO_TIMESTAMPING cmsg for platforms using
> > SO_TIMESTAMPING_NEW.
> >
> > Fixes: 9718475e6908 ("socket: Add SO_TIMESTAMPING_NEW")
> > Link: 
> > https://lore.kernel.org/netdev/6a7281bf-bc4a-4f75-bb88-7011908ae471@app.fastmail.com/
> > Signed-off-by: Thomas Lange <thomas@corelatus.se>
> 
> Cc: stable@vger.kernel.org
> Acked-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Willem de Bruijn <willemb@google.com>

