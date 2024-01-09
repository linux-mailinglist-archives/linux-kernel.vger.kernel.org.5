Return-Path: <linux-kernel+bounces-20983-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B8DA82881B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 15:30:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1AC11C238A8
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 14:30:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 500E839AE1;
	Tue,  9 Jan 2024 14:29:55 +0000 (UTC)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A8B339ACB;
	Tue,  9 Jan 2024 14:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-55770379ed4so2934381a12.3;
        Tue, 09 Jan 2024 06:29:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704810592; x=1705415392;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l+JEdot1C2wy41EbgID07d5DatcMtHbmHDaS5rfc6aA=;
        b=mBTCh0Pd3HWH/pOX2cWYMFy15XxrDWQmrZmx27E+YYr0xrk7MYry6TJqOSfaYlO3Cr
         yf+NjTkvVUmD5dV/flTDrfPUnmYfKqzkSH8dwZ2lOowM3A16xEJDsbeNaXDCNKfNsLXv
         lLX/mYyxkLQLC8oQBPDsMp1ONm1rGJjW6O88En+VtnoGnWxuNXQf5ZAYnbKeFEnmT6dr
         lspOR7IZlH6Qrci8CvyFfZu7a0UZhD4nM0B1DRnDtDvF2Twua3FtkNvaCNxK7Pk84pNg
         sx4ZbkCWSYJtwVbgZ+6iBXxxNXV/Fm/D5/fTfLHehNJORSrvVEclVF/qm42/8UoeVVgC
         Sl/Q==
X-Gm-Message-State: AOJu0Yzq/e8p+Gl3FpicXpJ1RKL1RzfF8qFYHRiXyz3OAoULtOj4XlVw
	SMk2PiubBfKwMqqOn1K7WRY=
X-Google-Smtp-Source: AGHT+IGU14+WX8vx3R9NsxrdK0yVQf5tEVFZPyghsTxzKm/sx8Drlwwz2boIWJwFOQjI9KuUOcITPw==
X-Received: by 2002:a17:907:987a:b0:a27:f0da:f6d8 with SMTP id ko26-20020a170907987a00b00a27f0daf6d8mr455832ejc.104.1704810591370;
        Tue, 09 Jan 2024 06:29:51 -0800 (PST)
Received: from gmail.com (fwdproxy-cln-023.fbsv.net. [2a03:2880:31ff:17::face:b00c])
        by smtp.gmail.com with ESMTPSA id gr5-20020a170906e2c500b00a2327e826ccsm1082737ejb.201.2024.01.09.06.29.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jan 2024 06:29:50 -0800 (PST)
Date: Tue, 9 Jan 2024 06:29:49 -0800
From: Breno Leitao <leitao@debian.org>
To: Stefan Schmidt <stefan@datenfreihafen.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, Alexander Aring <alex.aring@gmail.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>, netdev@vger.kernel.org,
	"open list:IEEE 802.15.4 SUBSYSTEM" <linux-wpan@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next 06/10] net: fill in MODULE_DESCRIPTION()s for
 ieee802154
Message-ID: <ZZ1YXTEgZePZW5Dh@gmail.com>
References: <20240108181610.2697017-1-leitao@debian.org>
 <20240108181610.2697017-7-leitao@debian.org>
 <45711bec-e0f3-43c2-b8f2-b9a55654710b@datenfreihafen.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45711bec-e0f3-43c2-b8f2-b9a55654710b@datenfreihafen.org>

On Tue, Jan 09, 2024 at 08:25:21AM +0100, Stefan Schmidt wrote:
> Hello.
> 
> On 08.01.24 19:16, Breno Leitao wrote:
> > W=1 builds now warn if module is built without a MODULE_DESCRIPTION().
> > Add descriptions to ieee802154 modules.
> > 
> > Signed-off-by: Breno Leitao <leitao@debian.org>
> > ---
> >   net/ieee802154/6lowpan/core.c | 1 +
> >   net/ieee802154/socket.c       | 1 +
> >   2 files changed, 2 insertions(+)
> > 
> > diff --git a/net/ieee802154/6lowpan/core.c b/net/ieee802154/6lowpan/core.c
> > index 2c087b7f17c5..b88f6a96d961 100644
> > --- a/net/ieee802154/6lowpan/core.c
> > +++ b/net/ieee802154/6lowpan/core.c
> > @@ -280,5 +280,6 @@ static void __exit lowpan_cleanup_module(void)
> >   module_init(lowpan_init_module);
> >   module_exit(lowpan_cleanup_module);
> > +MODULE_DESCRIPTION("IPv6 over Low power Wireless Personal Area Network IEEE802154.4 core");
> 
> If we want to nitpick you could write it as IEEE 802.15.4.

Thanks. I will update.

