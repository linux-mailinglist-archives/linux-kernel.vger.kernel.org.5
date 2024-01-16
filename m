Return-Path: <linux-kernel+bounces-27363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 752F582EEB6
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 13:09:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 160CAB23238
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 12:08:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62F651BC3D;
	Tue, 16 Jan 2024 12:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=avm.de header.i=@avm.de header.b="b/0aKTBh"
Received: from mail.avm.de (mail.avm.de [212.42.244.119])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 547331BC37;
	Tue, 16 Jan 2024 12:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=avm.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=avm.de
Received: from mail-auth.avm.de (unknown [IPv6:2001:bf0:244:244::71])
	by mail.avm.de (Postfix) with ESMTPS;
	Tue, 16 Jan 2024 13:01:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=avm.de; s=mail;
	t=1705406464; bh=LTvkD50jnbDyC8Lwck8C4IOhXUM+7Ro962nBVa5evZk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=b/0aKTBheQflYtrNmb+bkO8c6Unq4RO+G+asjb4jdzprQvi3LMBjwCJFZFt6N73GD
	 GgZ0kGZI6ED/G+Bt7XQfrSEIlTAT/tGZid0ZPcVilfK80xlTdf6geykExZp+v9cI9O
	 LzyH/A/AOeI6X6of0RHOix6IpTmcuQ1Ys2sw4MTs=
Received: from buildd.core.avm.de (buildd-sv-01.avm.de [172.16.0.225])
	by mail-auth.avm.de (Postfix) with ESMTPA id 6F19380397;
	Tue, 16 Jan 2024 13:01:04 +0100 (CET)
Received: from reykjavik.ads.avm.de (unknown [172.17.89.91])
	by buildd.core.avm.de (Postfix) with ESMTPS id 54D51180C48;
	Tue, 16 Jan 2024 13:01:04 +0100 (CET)
Date: Tue, 16 Jan 2024 13:01:01 +0100
From: Nicolas Schier <n.schier@avm.de>
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: Tomasz Figa <tfiga@chromium.org>, linux-kbuild@vger.kernel.org,
	linux-kernel@vger.kernel.org, Jesse Taube <Mr.Bossman075@gmail.com>
Subject: Re: [PATCH] kconfig: menuconfig: Make hidden options show as dim
Message-ID: <ZaZv_TNR5_1zOCji@reykjavik.ads.avm.de>
References: <20231228054630.3595093-1-tfiga@chromium.org>
 <CAK7LNATBipJtprjvvRVYg8JcYOFXQdpLEyEc+4+8j1PtBQ+PUg@mail.gmail.com>
 <CAAFQd5C3vAUJhKiQ1LPkZv3dJxNvK4QinRezV9Q8rz_Ov6FSUQ@mail.gmail.com>
 <CAK7LNAQcaDneE4rnjvV+GTSBBMozm5deu_q9+STTn60ervZJbA@mail.gmail.com>
 <CAAFQd5DcxL80cb8w9OZs0mpD=Y3K=LmM7exG7U_DaSsMkfni7Q@mail.gmail.com>
 <CAK7LNASyiYasGa2_Ppp54nEq2m08q_Z_keViZDCavmNN0rBAzQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAK7LNASyiYasGa2_Ppp54nEq2m08q_Z_keViZDCavmNN0rBAzQ@mail.gmail.com>
X-purgate-ID: 149429::1705406464-FCD755FF-BEEFE864/0/0
X-purgate-type: clean
X-purgate-size: 2232
X-purgate-Ad: Categorized by eleven eXpurgate (R) http://www.eleven.de
X-purgate: This mail is considered clean (visit http://www.eleven.de for further information)
X-purgate: clean
X-purgate: error

On Tue, Jan 16, 2024 at 07:58:05PM +0900, Masahiro Yamada wrote:
> On Mon, Jan 15, 2024 at 2:04 PM Tomasz Figa <tfiga@chromium.org> wrote:
> >
> > On Sat, Jan 13, 2024 at 8:23 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
> > >
> > > On Wed, Jan 10, 2024 at 10:05 PM Tomasz Figa <tfiga@chromium.org> wrote:
> > > >
> > > > On Fri, Dec 29, 2023 at 1:10 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
> > > > >
> > > > > On Thu, Dec 28, 2023 at 2:46 PM Tomasz Figa <tfiga@chromium.org> wrote:
> > > > > >
> > > > > > When hidden options are toggled on (using 'z'), the number of options
> > > > > > on the screen can be overwhelming and may make it hard to distinguish
> > > > > > between available and hidden ones. Make them easier to distinguish by
> > > > > > displaying the hidden one as dim (using the A_DIM curses attribute).
> > > > > >
> > > > > > Signed-off-by: Tomasz Figa <tfiga@chromium.org>
> > > > >
> > > > >
> > > > >
> > > > > Do you think this is useful?
> > > > >
> > > > > This changes the color only when you select a hidden item.
> > > > >
> > > > >
> > > > > For unselected items, you cannot distinguish hidden ones,
> > > > > as A_DIM has no effect to black text.
> > > > >
> > > > >
> > > >
> > > > Hmm, are you sure about that? For me it seems to dim the text. it
> > > > seems to be also used in the existing code for dlg.button_inactive.atr
> > > > of the mono theme:
> > > >
> > > > https://elixir.bootlin.com/linux/latest/source/scripts/kconfig/lxdialog/util.c#L26
> > >
> > >
> > >
> > > Then, your code works only on the mono theme.
> > > (when your terminal does not support color, or
> > > "MENUCONFIG_COLOR=mono make menuconfig")
> > >
> >
> > No, that's not what I meant. It works for me for all themes, see the
> > screenshot at https://postimg.cc/sBsM0twT . The terminal is tmux
> > inside hterm (which in turn is supposed to be compatible with xterm).
> > I guess I can test a couple of different terminals.
> >
> > In which terminal is it not working for you?
> 
> 
> I use gnome-terminal.
> The disto is Ubuntu 23.10

I see the same behaviour as Masahiro described with foot 1.13.1 on
Debian 12.

Kind regards,
Nicolas

