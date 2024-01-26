Return-Path: <linux-kernel+bounces-39571-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C90683D2FC
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 04:40:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52B7D1F25741
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 03:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F843B657;
	Fri, 26 Jan 2024 03:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fisica.ufpr.br header.i=@fisica.ufpr.br header.b="XJgU9qQR"
Received: from hoggar.fisica.ufpr.br (hoggar.fisica.ufpr.br [200.238.171.242])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4A6CAD27;
	Fri, 26 Jan 2024 03:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=200.238.171.242
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706240424; cv=none; b=kd5FjaraJbu0KHH1yqdCp0H204IpPLbLk1IY0Ej7wzdWdD421Lv7oXgA9H2jTsmHbASNrCa90TpyEM8U2N6kJ1RQi2h70XHFnChLJNk7Gl33GDqUkhSKPyJ+u0IpTkM7lKrCCb+eBFn9Hury2Fj9fIys7UQ2DHWVReq7w+sOhtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706240424; c=relaxed/simple;
	bh=dHyfVG6TbOGkccm1sKx4Jajh2CRdhy3ae2G7u64QOdc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YMK9bHqiQmMUcI0AevU8ZI4bBsY2gWXJiiWs47ExQG9qUOuB6DSS9hZRLoYlL9p8Oeqg06S0Xk4KoAElpoNxQuyPavRkrJIUI4zElQnogRX8l7SNpE8sV6iNJH4+GocuF1cHRSz7XU0+8AdXYOTvDJZqJ7MtdkbC/0zEzJwoUZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fisica.ufpr.br; spf=pass smtp.mailfrom=fisica.ufpr.br; dkim=pass (2048-bit key) header.d=fisica.ufpr.br header.i=@fisica.ufpr.br header.b=XJgU9qQR; arc=none smtp.client-ip=200.238.171.242
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fisica.ufpr.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fisica.ufpr.br
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=fisica.ufpr.br;
	s=201705; t=1706239847;
	bh=dHyfVG6TbOGkccm1sKx4Jajh2CRdhy3ae2G7u64QOdc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XJgU9qQRu5n9FGjXoZbOtNDHtRGNNEHCc+/qwq0OSLgAkAKQu2JYYIsKoS4lSVEEo
	 Vps9bkmtz03MtGWCD2zkuB2ey9/IWVNnzhpR+k1XIx70mVD8U8CCuzr9bOpnrHzrS8
	 QSqSArVhXcYA76ezYcFbWnt1doigKynIUwPXUBGibrwS9zXT8yB8plvObbNXgYJDag
	 G31e7JUJYUwimSXPfheTrzUzndoOUGkY5KbgbxQV1anKCmLEt+1Jr+GonU7Yf815pP
	 e5yirFTOlAuPW7nMc23uDpx3SIrl0klUxXbYs8uYTYFZBD47XMQElvrM8LMQgoTgUj
	 1ThVsEcd4knjQ==
Received: by hoggar.fisica.ufpr.br (Postfix, from userid 577)
	id 0778F9A0B4A40; Fri, 26 Jan 2024 00:30:46 -0300 (-03)
Date: Fri, 26 Jan 2024 00:30:46 -0300
From: Carlos Carvalho <carlos@fisica.ufpr.br>
To: Dan Moulding <dan@danm.net>
Cc: junxiao.bi@oracle.com, gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
	regressions@lists.linux.dev, song@kernel.org,
	stable@vger.kernel.org, yukuai1@huaweicloud.com
Subject: Re: [REGRESSION] 6.7.1: md: raid5 hang and unresponsive system;
 successfully bisected
Message-ID: <ZbMnZnvyIyoWeIro@fisica.ufpr.br>
References: <2ef7d741-3df8-402a-967f-53ec77c73e2c@oracle.com>
 <20240125203130.28187-1-dan@danm.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240125203130.28187-1-dan@danm.net>

Dan Moulding (dan@danm.net) wrote on Thu, Jan 25, 2024 at 05:31:30PM -03:
> I then created an ext4 file system on the "data" volume, mounted it, and used
> "dd" to copy 1MiB blocks from /dev/urandom to a file on the "data" file
> system, and just let it run. Eventually "dd" hangs and top shows that
> md0_raid5 is using 100% CPU.

It's known that ext4 has these symptoms with parity raid. To make sure it's a
raid problem you should try another filesystem or remount it with stripe=0.

