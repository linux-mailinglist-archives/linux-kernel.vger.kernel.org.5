Return-Path: <linux-kernel+bounces-146099-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ABD28A60AD
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 04:09:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 511D12824DE
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 02:09:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9099EAE7;
	Tue, 16 Apr 2024 02:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Qe3ZwLvf"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39213E56A;
	Tue, 16 Apr 2024 02:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713233337; cv=none; b=TSNHVaVe9cWG1Ch05d9w8IjovpVEwShtjYyL9wSJI0e3LwM5DWqm/XUD+DO9ZX3431fSLyVFPRDY245MfGQ/F/9+R31QQ35fwpJtHgSYfoaMjxupstEmhKwL9h2bme3Sfow9aeg6IcQx2QiwPwnL0LuFXOJXPncrEJpXCeN7MD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713233337; c=relaxed/simple;
	bh=Iyj54HUQP+Qsvc+etz0QrWEECprIhcb8cLlp/IDiDQw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p5sCrxP/mpgjL8zmAd34HTfSWHo66AgxIU8EE+rBHxKKsoe+W20FAQoHQpAhQS2zcb2p2eVZYBhC+PyTEFASpRUzZwcMTOyiH8SeiqyJ2SbTxGMF523GuSUXDAIf7HHRmHo/HlmqE7qLywOOofLODF1H4wyPy3RYOlB0nPiGA20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Qe3ZwLvf; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3D23920002;
	Tue, 16 Apr 2024 02:08:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1713233333;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b9Egc/Fg8xHLi5Mts732z9c41kzvRH7tFrpKcVjJQOk=;
	b=Qe3ZwLvftYzkG9UU9XYO9v03X2YD++1fkwyTE+20XSAdL4Liu66/Tv4h8MIIGP/xR5hyj7
	yMLjJpgLN3g7IbBGKZPHDvh7a+PXeMXL9uhhm8dt1PE8aosGHTy30XJ2RGq2Eu0dzNNWZj
	iY/D6LsOHpCxLeO5M5wbT4TkhuQtSK4Zr2Yyglx/J7idyTZ3K+Da3n4t505AI55ip5wQuB
	0S98jqVMpA3h43Hpsn9W+IEbU9ZSYdQmg+lU/w64/NwzQP0o/FQHVmuq/9VME/q4kEU1gt
	RPGk87NmMpkGVklGWyBJE8AGuw69hW+SVgQk8xEzUnpcrzw2qCg5MHR+/DMfpg==
Date: Tue, 16 Apr 2024 04:08:46 +0200
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>
Subject: Re: TP_printk() bug with %c, and more?
Message-ID: <20240416040846.00de86aa@booty>
In-Reply-To: <20240415044431.308f2e09@rorschach.local.home>
References: <20240315174900.14418f22@booty>
	<20240315132146.29edf416@gandalf.local.home>
	<20240315190312.2bd6a198@booty>
	<20240315145852.46125ac5@gandalf.local.home>
	<20240318164307.53c5595f@booty>
	<20240415044431.308f2e09@rorschach.local.home>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-Sasl: luca.ceresoli@bootlin.com

Hello Steven,

On Mon, 15 Apr 2024 04:44:30 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Mon, 18 Mar 2024 16:43:07 +0100
> Luca Ceresoli <luca.ceresoli@bootlin.com> wrote:
> 
> > However the arrows are still reversed.  
> 
> This requires a kernel change. The problem is that the print fmt has:
> 
> print fmt: "%c%s %s %s %s %s", (int) REC->path_node && (int) REC->path_connect ? '*' : ' ', __get_str(wname), (((REC->path_dir) == SND_SOC_DAPM_DIR_OUT) ? "->" : "<-"), __get_str(pname), (((REC->path_dir) == SND_SOC_DAPM_DIR_OUT) ? "->" : "<-"), __get_str(pnname)
> 
> User space (trace-cmd and perf) have no idea what SND_SOC_DAPM_DIR_OUT
> is. The kernel needs to convert that, otherwise the parsing will fail,
> or it will default it to zero.

Thanks for the insight. I'm definitely trying to fix this based on your
hint as soon as I get my hand on a board.

Luca

-- 
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

