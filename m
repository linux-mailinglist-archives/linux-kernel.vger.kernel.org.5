Return-Path: <linux-kernel+bounces-48554-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27D8C845DBF
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 17:52:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8FBA287C06
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 16:52:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 766354C67;
	Thu,  1 Feb 2024 16:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cu-phil.org header.i=@cu-phil.org header.b="LUTaZc0/"
Received: from smtp.domeneshop.no (smtp.domeneshop.no [194.63.252.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 735CF468C
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 16:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.63.252.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706806336; cv=none; b=aqelEsljsH6ru72+M1HuRUCqg1+3SyZu6JYkJgpLQ7zdG261IY3h6Ur00DsWIw3Egf0//C6IpRUZ+MEZbxIzVCUZPZHj4UwV6Dq/XRJM7Xh5yg3uUYWwhLvBb0NP2oNLBEElbok3LFYsYh2R1P/q9r9IFKvL62ttnE6yaBVu7vY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706806336; c=relaxed/simple;
	bh=Ll+E/ccE9MWalp7N+1Q+hk5af9uBZGR9lumCFHRezB0=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=SHLAftmpkmS5MW2dwxd9iXHWrulzcEWnoSvkSlyeq1dvu9OventiD8X93pNz0EpMEKo1yJVHWnxDGTVbOtXPKfdCx50wUFGeMTEDI5qRyOCVHq81D7Lx/NmHurlxiwI8K59M452lPod1D+8XjcllKtxRngRITp5MQJqwn5d2NA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cu-phil.org; spf=pass smtp.mailfrom=cu-phil.org; dkim=pass (2048-bit key) header.d=cu-phil.org header.i=@cu-phil.org header.b=LUTaZc0/; arc=none smtp.client-ip=194.63.252.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cu-phil.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cu-phil.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=cu-phil.org
	; s=ds202401; h=Content-Transfer-Encoding:Content-Type:Subject:From:To:
	MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=yH+fpeeaX7Dh1iqiitpQgZEHj5z9HkgWk2sZcjZxDxo=; b=LUTaZc0/g2BwrROOIPcOOT/Fc1
	TmFTmev237hkjzjC/mtHTEtcC3ibstFTX+HBZgL4BdcRtJSffs+EBLkPqppR2DY0Cslo6evZ57JcV
	xwMxBWjB9FBdk09pKnC2MuXGLVP7fJOlYHxh61rBSO6TZRfmA74eu6+kBaPmg1WXnAOe16lNICFsN
	aJEik+5jnsUoswOot4dW16lb7Itc+RCmV6f9gduYvQaPf6GAv2g6KN0/cixC10RPaKGMUxG3n5Nlu
	eIvtT4fcqkkC6+o6rrDuSS1cxmVmgaHitmo1p5PFhPTxeA/BBR94reS9fSnha3Onp8SCYv8FgxLbh
	GQxG1sDw==;
Received: from [84.215.119.50] (port=61748 helo=[192.168.0.2])
	by smtp.domeneshop.no with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <Ywe_Caerlyn@cu-phil.org>)
	id 1rVaIJ-00DUxn-3g
	for linux-kernel@vger.kernel.org;
	Thu, 01 Feb 2024 17:52:07 +0100
Message-ID: <1c5121b5-6d4e-4a35-b2f4-c834dc0a12c6@cu-phil.org>
Date: Thu, 1 Feb 2024 17:52:06 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-kernel@vger.kernel.org
From: Ywe Caerlyn <Ywe_Caerlyn@cu-phil.org>
Subject: @ X (was: Fair Source Philosophy, Low-Jitter)
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Yes, further iterating the background philosophy, it seems we get a 
polarisation Right of LSD culture, which seems to be a semibuddhistic 
self-destruction philosophy, to understand LGOD. (These are terms fitted 
to this, as I tried to be correct in this culture myself growing up.)

And what is wrong with LSD Culture: Lord Paradox.

Understanding this, one moves on to Iclam, and a correct translation of 
the Quran, and Tio, The Great The Good.

Where today, satellite gods, are more forbidden than amanita.

The culture will iterate to @ X, so everything can be designed that way, 
and is a bit similar to CMOS if anyone can remember that, with modus 
operandi accordingly.

Leaving the labour party the clear winner, politically, for fair source.

-Peace!
Ywe Cærlyn
https://www.youtube.com/@Labour_Party_Digital


