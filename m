Return-Path: <linux-kernel+bounces-77383-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D0D4860498
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 22:17:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 581D11C2103F
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 21:17:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E16ED73F17;
	Thu, 22 Feb 2024 21:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="PWp/sb/T"
Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 971F06E5E3;
	Thu, 22 Feb 2024 21:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.238.236.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708636623; cv=none; b=F7xU5/Ii3zOIAaypIsGtICLpcrnFrZBXmRzuSBerIq3F9beVAobHTf89GoA6RWQg4xnL1CIxB2QHP8CwCHL8HUPsNipuvfX7ZBwAOGvK5/4WMaAby7v70LQC1QflpYC2Jxesv8h3u9ICfz4WlbxsRWJDW2R5wtgoxC9PpUFycUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708636623; c=relaxed/simple;
	bh=rV39Ga1J5+CgU5ZUDzQiNwYJNphtiD5kBKlyf/IiyYc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tMFGbNePLHeNHk+h+nns/xeM0FutfahwDIIFhMlY9EJV08yr3lPh/K+RV86Aej0UsRfvq9JVJxPzBHMzc8NyOhZy+pUkhc+00mbE64XXogRyhlTTWYNIzuzXuKZYML7JF5TKhQCEMF2/XLvD6H47fmuRfbLdbr11C345k7ZiJio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=PWp/sb/T; arc=none smtp.client-ip=178.238.236.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=pjgWZk04wZhO8GEohWmFeGtMs1kVhFIlzgnHQzXsJ0I=; b=PWp/sb/TvZKqnonSSaaTufNB0E
	lf2n4rY19nNI54fRXII7ssNFTJdZroOEJZjKSqhYy+5Ydd2HRgN9Vk03DLwxSnOYcRAt1QqKLLd7k
	1yYKH8AEkBfA84ATQYnReqtD/Ezn8LpYmchhz004j/QiQa5K2SFLYE5vFFTQjDvuys/z/YvSViiZR
	Mwo9t+jB8MhiG0pxu6DTPdziFyydYMzk6toJErdvlX7Y87951K8v7q6SX6c0V4bC713UPNTcBiksg
	TNXLfca0vb97BU/lFxol4RiDXmL5cspz3/+8U+l+RJdGXzR8Gwi/TkN7pbQLV2+MYTqmWRdOoLZvr
	zPul6+Vw==;
Received: from p200301077700b1001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:107:7700:b100:1a3d:a2ff:febf:d33a] helo=aktux)
	by mail.andi.de1.cc with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <andreas@kemnade.info>)
	id 1rdGR2-009gQ1-2I; Thu, 22 Feb 2024 22:16:52 +0100
Date: Thu, 22 Feb 2024 22:16:47 +0100
From: Andreas Kemnade <andreas@kemnade.info>
To: "A. Sverdlin" <alexander.sverdlin@siemens.com>
Cc: linux-kernel@vger.kernel.org, Lee Jones <lee@kernel.org>,
 stable@vger.kernel.org
Subject: Re: [PATCH] mfd: twl: select MFD_CORE
Message-ID: <20240222221647.7bbd344c@aktux>
In-Reply-To: <20240221143021.3542736-1-alexander.sverdlin@siemens.com>
References: <20240221143021.3542736-1-alexander.sverdlin@siemens.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 21 Feb 2024 15:30:18 +0100
"A. Sverdlin" <alexander.sverdlin@siemens.com> wrote:

> From: Alexander Sverdlin <alexander.sverdlin@siemens.com>
> 
> Fix link error:
> ld.bfd: drivers/mfd/twl-core.o: in function `twl_probe':
> git/drivers/mfd/twl-core.c:846: undefined reference to `devm_mfd_add_devices'
> 
> Cc: <stable@vger.kernel.org>
> Fixes: 63416320419e ("mfd: twl-core: Add a clock subdevice for the TWL6032")
> Signed-off-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>

oops, sorry, thought it would be enabled if any mfd thing is compiled... but
it is not
so,

Reviewed-by: Andreas Kemnade <andreas@kemnade.info>

