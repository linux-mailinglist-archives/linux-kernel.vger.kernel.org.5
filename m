Return-Path: <linux-kernel+bounces-166698-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F40D58B9E4B
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 18:14:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A935B287701
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 16:14:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E939915D5B7;
	Thu,  2 May 2024 16:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=finest.io header.i=parker@finest.io header.b="AiMtJSxM"
Received: from mout.perfora.net (mout.perfora.net [74.208.4.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9287460BB6;
	Thu,  2 May 2024 16:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.208.4.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714666458; cv=none; b=kfQUITt5yb5Q2AaO1BgSwQxZT0sZJVJUmw6D8JbzzyC13JuoK3bVUFX9L4tyUYsBS9YaskUchvZQv7Pp/EdDqz0NWd4s6DBDgDSA0W74zRSouVZYuy6CBAHRVZ2jzeag8BQxQhrEOviZyhTfEPMkJpmMj58qMB0NHbrulLR2UqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714666458; c=relaxed/simple;
	bh=EYyBIpXtLbrojJ0gwTNmKNe8NZCDfNPHVGhDJtgJFL4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JUL30wiflJi+rftvnzMcIvpQYinozrNNQMxfA0sZfNMjMUVO/xQeQlWSXL+XggEmadHpJ47K0/Ly3PK8p6uSgnygwuWxrOacbvVaVlEsRlqKsIRgn2Xd2JOES0qp/atencdO7WiX97AicW0WJF8S2K+OaWsN4FWAiIsaOYs7EWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=finest.io; spf=pass smtp.mailfrom=finest.io; dkim=pass (2048-bit key) header.d=finest.io header.i=parker@finest.io header.b=AiMtJSxM; arc=none smtp.client-ip=74.208.4.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=finest.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=finest.io
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=finest.io;
	s=s1-ionos; t=1714666452; x=1715271252; i=parker@finest.io;
	bh=F1Ux9cZrOuJh9vuypt4bqQwJFsHtjYpAaryxJnzC8UU=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=AiMtJSxMjCb+kfDU2A/JPuN5r3PE1QqXY10l88NeBVQF0PAXqKDa2MwZtZpKshhN
	 PnEPGikcO1ZX5rmLRufde5ecl2HnXURqQZUz44/hKK/m+InG+FuYJ1WqTOD+Q8tCr
	 8saN3QuXY+W4cWq2ReaC/CU70YgImhhOlCFIBl115upW9Gz/X3j8pjBB05Posyeb/
	 2UByhCmoOy2IRfKU+TJORwY3LyE2IG540b8ikdE9/SYUtZ4+p2xq/y0J3ftJCkHqD
	 IvkSht3zcLKRoCYcYTF33BMRdqnPfb+ljxaBGfSXEUIdwANSCIC1tRIFcwcm8JtKT
	 Yy9d1sxO5RsLZI2viA==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from SWDEV2.connecttech.local ([98.159.241.229]) by
 mrelay.perfora.net (mreueus002 [74.208.5.2]) with ESMTPSA (Nemesis) id
 0MNa9c-1rzmlW1OiQ-001dPt; Thu, 02 May 2024 18:08:48 +0200
Date: Thu, 2 May 2024 12:08:40 -0400
From: Parker Newman <parker@finest.io>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Parker Newman <pnewman@connecttech.com>, linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH v1 00/13] serial: 8250_exar: Clean up the driver
Message-ID: <20240502120840.02c65f30@SWDEV2.connecttech.local>
In-Reply-To: <ZjO4vYEBzxU3fpzC@smile.fi.intel.com>
References: <20240502144626.2716994-1-andriy.shevchenko@linux.intel.com>
	<20240502114645.4445b3da@SWDEV2.connecttech.local>
	<ZjO4vYEBzxU3fpzC@smile.fi.intel.com>
Organization: Connect Tech Inc.
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:wQQFg7JqXeyMc7J73yaQ3i6/8bCsSfUwf0eyYZhDGpSV4C2Mv2x
 JTendR9EQupIO/Pd9qAVsd5yJShMGZ8QXCgqhinFWqRPUwGI0rs5phSJZ2QzJ5Nf6qfJNUB
 V9pSo9Xm7tTTzNBK90bs7WZN+q2Y6qHhlQ9hWlpOopnhoE30t8rHvdjl/rDnPVvJCjmnJgu
 V4wtVuG/m/6Dzm91mmp9Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:s0b9kt01wnY=;NqVlvOczYkO9YsE+8ETmlKaC1Zx
 RckKbwJGmHeqMNlH6eJsN2Kllaw9z36miib9msAcsG1svYihv8ITSlLGeeUK0HUv3xOU0cmO6
 GpWVh80Q2uhCOzwylw1/6zAkCHrQHvmcbREydYiVhDb8gcUZhgc3jM1ObTqUrx1sU1WCCOEwh
 Y6Y4OC74tRozI8LWRE090MIZ8pj3O8HDO5BJkcU4FqoNSDTM4SSfc+pSbA+X92SUanqNmfBz0
 z3VVX5aCst+d4NGwh75IRMOuOAOzUNxUlrdQo9OOrYrCeDDdkc12r5xWRrjkpMX97McvOjw1i
 2xvTGO4ty+/wYFJE4jtaBzB6GYYpj2KSym+LwP4jcYT9kCS802GqHs3wtjvX/NtCump+5kWnH
 RRiU30o/CihhCeScbNHvPUVd0ZXRCc/2F1GFi1vdNpk8m8bxrEfWUWtsjLT94dp8EUbTBQzwS
 1ghS+If3FsRmpcZ2//g+dPgLBhbFsxj0rcsgJtxgJNOzWQJWMlecNwuu0gMZ8HvlpAWxskDwf
 +LzeZEzqF8zhezgAM9K0T5lkRexY+106+XxSwIq41+iSyzLIAhRhBqVV397jDiLyJMaFlq9PZ
 am6SHL3ufrLaoJbIrlNHJGzhvJAkqE3ffIPW3TpqI5+vL21Zj1WxaQycHm3Z6v11GFigra0uE
 XRg1hCwh48ETNB9k2o4hfEc8HNvM5IaayZvD7UMk4iJ6V9KQDVXlpZvRaY49UDpDXHVOorExg
 1P8S4u+aHqc5FiyYfBokzztxV7CZPrLYinY+C1LAfrgIMkuZ84ssNs=

On Thu, 2 May 2024 19:01:01 +0300
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> On Thu, May 02, 2024 at 11:46:45AM -0400, Parker Newman wrote:
> > On Thu,  2 May 2024 17:43:54 +0300
> > Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> >
> > > After a rework for CONNTECH was done, the driver may need a bit of
> > > love in order to become less verbose (in terms of indentation and
> > > code duplication) and hence easier to read.
> > >
> > > This clean up series fixes a couple of (not so critical) issues and
> > > cleans up the recently added code. No functional change indented by
> > > the cleaning up part.
> > >
> >
> > Just an FYI I submitted a patch series that fixed several of these iss=
ues but I
> > think it fell through the cracks (I know everyone is very busy!).
> >
> > Link: https://lore.kernel.org/linux-serial/cover.1713533298.git.pnewma=
n@connecttech.com/
> >
> > I believe my previous patch series is no longer required. This one fix=
es
> > everything.
>
> I haven't noticed that, if it contains duplicated patches, I may replace=
 mine
> with yours if you insist.
>
> In any case it's better to reply there that you prefer this series to be
> applied, so Greg will not pick it up.
>

I do not have a preference. I am fine with using yours if it is easier on
the maintainers.

I will send a reply on my previous series that it is not needed and link
to this. I am new to the mailing lists so I didn't know what the procedure
is for this situation.

Thanks for the fixes :),
Parker


