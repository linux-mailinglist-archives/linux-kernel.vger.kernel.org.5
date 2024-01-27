Return-Path: <linux-kernel+bounces-41404-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E855E83F037
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 22:35:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 31D10B22CEF
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 21:35:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62AB71B285;
	Sat, 27 Jan 2024 21:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="Pm1Cz2uc"
Received: from mail-40134.protonmail.ch (mail-40134.protonmail.ch [185.70.40.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E07E21AAA5
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jan 2024 21:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706391333; cv=none; b=o1j44PM64OduP7fqmWDRjzB6Gt/jqg9fNO+jpHuDQajiJlGzCnyXy/0G/FgWQDOLYYRF92V+8cep8S9t0UyvRuHaAMiastCe292pXaRwohKcCAXlawrEugmqAJac8b33doV5f2CAjsBkeYIBTLp7q7PY3ePXeMbaaaLy3f3zDaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706391333; c=relaxed/simple;
	bh=XjB14sOEcNCjSPSGzjsVDfkM3EVNBsHsxxs1Zo++7WQ=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=mHCnjCZIWayoMzBiBPqdZf0aL6Upvh8RcvLS5J/Ql39gk2Io1ipnXhMQ3pfYZpBiE5Jh0cqM/iLkBsNsIuqOTZ+w06IIRt4thg3a4PHPmPH7vVpAJGvar8JCbSn8cr2TYnr4NaxpdPo5GRZpXdEKoVFI9MHnN8IY2AmF/qotFaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=Pm1Cz2uc; arc=none smtp.client-ip=185.70.40.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1706391328; x=1706650528;
	bh=XjB14sOEcNCjSPSGzjsVDfkM3EVNBsHsxxs1Zo++7WQ=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=Pm1Cz2uc1Irqqa4Cker3zmeykpfVQuifl8xy4t6U7zGR2y0xekfG+hoH88A6YFGp1
	 c2um+AowgVouh3DM5EsszQ3krku+Uv/2iwNfGK5kO6piUUHHAv2WUVDIfW00R3a/G7
	 QRWVjUO1ZCK2GvMo043xwp2oYnA09r70boCOOdrAXwOW+k0Trk2R1vG+c8CwxUNqny
	 9VFrgXLpJSDZ6BQ2+BiUAxyRS4xf3aM8y/2Id33Zs2lZJb51T+sPyNYBWIUn4FiLz3
	 xwiN8lOS5TCJc+4Tj+qVnpry5Q3N+o//wdp+F65tkaaaJ76mqrkpz5gp04G0OJxQmh
	 aJ0UiQMTwTvTA==
Date: Sat, 27 Jan 2024 21:35:15 +0000
To: linux-serial@vger.kernel.org, jirislaby@kernel.org
From: Emil Kronborg <emil.kronborg@protonmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: mxs-auart broken in v6.2 and onwards
Message-ID: <miwgbnvy3hjpnricubg76ytpn7xoceehwahupy25bubbduu23s@om2lptpa26xw>
Feedback-ID: 20949900:user:proton
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

After updating Linux on an i.MX28 board, serial communication over AUART
broke. When I TX from the board and measure on the TX pin, it seems like
the HW fifo is not emptied before the transmission is stopped. I
bisected the bad commit to be 2d141e683e9a ("tty: serial: use
uart_port_tx() helper"). Since it concerns multiple drivers, simply
reverting it is not feasible. One solution would be to effectively
revert the commit for just mxs-auart.c, but maybe you have a better
idea? Any pointers is appreciated.

Regards,
Emil


