Return-Path: <linux-kernel+bounces-17399-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D0B1E824CA7
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 02:50:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFCD71C20AD7
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 01:50:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 324B64428;
	Fri,  5 Jan 2024 01:49:54 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A7342114
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jan 2024 01:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=perches.com
Received: from omf15.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay06.hostedemail.com (Postfix) with ESMTP id 56909A20D4;
	Fri,  5 Jan 2024 00:34:14 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf15.hostedemail.com (Postfix) with ESMTPA id B30D01E;
	Fri,  5 Jan 2024 00:34:11 +0000 (UTC)
Message-ID: <13fd63b7e8e0f197842ae1f1264e50c9614d0667.camel@perches.com>
Subject: Re: get_maintainer.pl: penguin chiefs, maintainers and the rest
From: Joe Perches <joe@perches.com>
To: Anthony LOISEAU <anthony.loiseau@allcircuits.com>, 
	"linux-kernel@vger.kernel.org"
	 <linux-kernel@vger.kernel.org>
Date: Thu, 04 Jan 2024 16:34:10 -0800
In-Reply-To: <AS8PR07MB894183C6DE3473F23D5A046FF9602@AS8PR07MB8941.eurprd07.prod.outlook.com>
References: 
	<AS8PR07MB894183C6DE3473F23D5A046FF9602@AS8PR07MB8941.eurprd07.prod.outlook.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Stat-Signature: carfib1pzimtqftjayft59xkqese3nbw
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: B30D01E
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1/xPWXw9wdTk03rHjwIaHhJRcLLTBTknZ4=
X-HE-Tag: 1704414851-616272
X-HE-Meta: U2FsdGVkX19EeMUNmeQ9DCkzGPwjaiy346hmeo1+CApDaFBCr5d66wIRg6tZV3fmmHwMMbz7eOnrtqEGPdd+AI9ZEnjrH3zRbF/ye8w2A0QOx6UdrLpbiUZAa6hmJ4D0tMa62N/xeYzi0B2zEVUo71l8oZWkHOGqMaZqMyitaGlb7SF03o4rlZIF91Jq8c4JPICNsUGYUbGPOzvnvh5jSgS6MEeTccSf6fwRZd1Dj0LUkLes52zhahmSsvvObvOdSSpzn0kNGodEhMOmAxKDqA88j/oIMUiOohBqjJz+U4ZvjIwh2/EaC36Z42fHvF1K

On Wed, 2024-01-03 at 16:12 +0000, Anthony LOISEAU wrote:
> Hello,

Hello Anthony.


> I am a little bit cluttered about a few things around
> get_maintainer.pl and the fact that penguin chiefs may also be
> maintainers, at least in third party projects also using
> get_maintainer.pl script. My feeling is that get_maintainer.pl
> mishandles penguin chiefs without it being an issue for Linux case,

[]
> My feeling is that this would be the cleaner way to address this
> issue. What is you opinion?mmm

For the various modified versions of get_maintainer.pl
for other projects, any change should be made there.

I think the linux specific get_maintainer.pl works as-is
and does not particularly need modification.

An option might be to externalize the 'penguin-chief'
block into something like a separate file that is parsed
at initialization.

Maybe with a rename as penguin_chief is generally Tux,
umm Torvalds...

