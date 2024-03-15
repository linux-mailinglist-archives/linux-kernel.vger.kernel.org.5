Return-Path: <linux-kernel+bounces-104160-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3045187C9E2
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 09:24:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9149DB23569
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 08:24:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86E4B171BB;
	Fri, 15 Mar 2024 08:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="o+UikrMa"
Received: from out203-205-251-60.mail.qq.com (out203-205-251-60.mail.qq.com [203.205.251.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 583C317581;
	Fri, 15 Mar 2024 08:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.251.60
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710491054; cv=none; b=g5QzmcivQkp3usydCyzWzeMW6GkHfK9Q8bAvT0P8cAMiFf389bhH5F5MmqqFOBC+UUT9/nostny3DPggiENYUNNsZ6SIiBqMDyeqn0yH/dmllGBCqu3450OctFHhY09MZ4j/SYzb5LmEuTt1JyBtZ4OaABDemHIFgEMEOCvxn4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710491054; c=relaxed/simple;
	bh=SJ1d6HM2ppo1Lagc/S/fy34kNmWoGtAn2E8xi+w2KLs=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References; b=KVHchaMpcy6e4iEtCtTf3AjOjQotxZW4Y9LL13qGdEuF9UL7NjZzLAyM8P3kj8ybMVP4raBGsLVxtmchFjS7MohdNaTxAAhFwB9NG2jflOawdnJfGFmzZSTLZwBg08mNFj71gRsPVIcQfa/USMhCp7DiJDLrTO3lXWCeny2PSVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=o+UikrMa; arc=none smtp.client-ip=203.205.251.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1710491044; bh=mvWpwO3HvK2uh5n8xsSS1KQWmAQgyr3MnTUg9RwoM/A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=o+UikrMae0w11FQBZyI8BlFiNFnXQ+s4O9b9t3o6myVDXotwNWpUGT3aKWAtU8u4K
	 NmzGNCRalBfbzYS1LsCj5risUQzH7XOTx+Lppn3X8ue0pYMPY1qNuBBD9WUzXMvwC/
	 w9uBFh7oGvSPSGuyDTjdqRii8K9Dcgp5l1SJyw0s=
Received: from ubuntu.vimicro.com ([121.225.188.5])
	by newxmesmtplogicsvrsza10-0.qq.com (NewEsmtp) with SMTP
	id 48035EBB; Fri, 15 Mar 2024 16:18:00 +0800
X-QQ-mid: xmsmtpt1710490680tpmj0qha8
Message-ID: <tencent_6920550C9D5A9AA1C4DC19D8ED24310DCB07@qq.com>
X-QQ-XMAILINFO: MRw/zKT/0BpPL5R3YesptnnXUdCQxMxhl6IEFTU4EDf+TMH8jscK1hPRXlAGin
	 IQHLgQZxh4UeDbYQEHfvyJWK9GIZTTJgTmWpbgtrzYNistqps1Zl9ypLGj5x5X/G+zen4ASijpAt
	 hHMKfM/DeCx0VwHGlCmSuC5/gxuJgxJw3N8QklypBEC8OfpYsAZfxVWRq3nGiQf6x6TaeKzVHlKs
	 RjYOUfUbstNyFe/wnmvu8RbUujlXMPl3aIEqqLJd706EmzvSrhkTqd5jGBzoVVa3teHUPeN6GMMT
	 6XV+nYA280q/eZdkRC2GyJYOWcOZBysIVLc3Ks8ztV04ZJOT4OeNTGB1H9pXlEmkY97cFP12zQ7H
	 w4LX3NKLmLiNKq8my+ZmaitAEVhNlPJix+1igUEa/WxIut5ceGgGuSz5mnuGTyxpfQfBygyx5Fk6
	 NDH2L7JMHSwf9CZP3Glkrb2DPxFHXXkbUjLloiNKYKXCNCCdnOJ0/KFbKc+EeUbMfbirSlJ1I25b
	 Ifezy7naHCoEeuALzvUeMAPd+X4mlOItJPf6IBbbjNwmxzyoEqhPT/7iu53hB6vaNJHuFsMc6mTu
	 4zmLgNCZN8JrhH+Pxr+8VEOPOHAj5oBVnnRlxlECHJI/HWMzUPTd8BQFHSdcwkMnvecitB1nFp+P
	 qQSIwb+jpUQZ9Xt8ZmRJSQKQXjO6Q6oD6puEkWW2MDXzWXT2ZY9PwN54M/i1f09s39aCsPhGId6E
	 SzVuKCFI1UAWua/nIRNTojI7kmzaMG0IPqQkhU8fshinTr1fQ1Tu/+Jky6vZZYlnixCx7YQrcmSV
	 VLB4ydUPofu/YONXDdamnsPEImkxw2NO8nd6i35MwPXj8p6dSCuL3OuA05C0spzTWvhCstREG+hj
	 9QCev6NT/bh1H2i+E45xHHaMbd+sOGrdmKCGljcNka6QVtAnF29OCj9UJSEherJ0+NJ3RSip7G5X
	 XQH30/NdmSo3d575lLlTOiY1W1ayaGpZ2HNhK6GpnMtaXirTZK7an/Asfw+xaQD43U42yr8/PTER
	 e2K6S0YQ==
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
From: xuhanwu <2433926602@qq.com>
To: 2433926602@qq.com
Cc: broonie@kernel.org,
	lgirdwood@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	perex@perex.cz,
	tiwai@suse.com,
	xu.hanwu@zxelec.com
Subject: [PATCH] ASoC: soc-pcm: add a check for unsupported commands to the soc_pcm_trigger
Date: Fri, 15 Mar 2024 16:18:00 +0800
X-OQ-MSGID: <20240315081800.4559-1-2433926602@qq.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <tencent_8A7C0C985AE1A1975C25D8DE24010D8B2007@qq.com>
References: <tencent_8A7C0C985AE1A1975C25D8DE24010D8B2007@qq.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Dear broonie

Issue: Before and after Linux version 6.2, when the cmd is 
SNDRV_PCM_TRIGGER_DRAIN, calling the function soc_pcm_trigger results 
in different return values.
Through your guidance, I've realized that the code logic has been adjusted. 
I will further deepen my study of the code. Thank you for your guidance.

Thank you for your help.
xuhanwu


