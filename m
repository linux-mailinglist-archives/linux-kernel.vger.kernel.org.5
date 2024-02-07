Return-Path: <linux-kernel+bounces-56434-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E5B8D84CA1C
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 13:01:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A41D51F21D99
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 12:01:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A19735A10A;
	Wed,  7 Feb 2024 12:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cu-phil.org header.i=@cu-phil.org header.b="mrhRr4OX"
Received: from smtp.domeneshop.no (smtp.domeneshop.no [194.63.252.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 996A15A0EF
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 12:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.63.252.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707307274; cv=none; b=WEmlS5EtiwU8SpnNdCFa5Gb8tgyv/MG6ww3O+AckQLr98FPSTLV1J+6u9/M03LpoIjHkLl5s/qZ5mZ1qpUhn3gowB3l5M7dZYZeTIt+5k8+C6bfN2rEOo6quF+j0muPx+zPgAtWtBxwOHH9LHgluR09slUN0yZs5zJk6qPo5sG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707307274; c=relaxed/simple;
	bh=67KECD5OSFZOmccg11XyUA2OmhZ9LNtqC7TrfpvVn/s=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=kXwUc67u6Dtp7/rDOlANWj93IJ/r1h0EcBs4jCIzSNsP2RFmwueS1yEtpsFfDXViKQoPc+Sk9iA76DX6G3XTeIJuVZuJZFckxxTqsnW3vXquFSgAe7uHGuVySQqUFYK/lMbctyEuo9/o9IttqUWKUCNH4Zi6p8ARCL1FnxVFWPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cu-phil.org; spf=pass smtp.mailfrom=cu-phil.org; dkim=pass (2048-bit key) header.d=cu-phil.org header.i=@cu-phil.org header.b=mrhRr4OX; arc=none smtp.client-ip=194.63.252.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cu-phil.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cu-phil.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=cu-phil.org
	; s=ds202401; h=Content-Transfer-Encoding:Content-Type:Subject:From:To:
	MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=FnlsycCm69kvDFBxnl5KTi+bvA4RTut6A5GHZCoX6Cg=; b=mrhRr4OXix+lD7Hu2d7Ra3VVba
	gkpsL3TH51pWFS+fM6Af8Fj+VK+GDAq3XoA4Jtl8+SZFFyHfWH2H/eVIH7yZItEQmBHjj+wjTreHY
	HLNM6MmAFkPM4SGCqK5m4whZNM/PiBqWJepLCboalvu9FPrd1i5cQvwr14cgASFd5Y8HVjUL8Hvrg
	fKqC47cHEFquBG27nZRFFTXQanaxw6qwhXW+cpCtphCTeG/csCghijQJU32ChJk0yFqiLgLEhDgKp
	TYXKOVxpD8N5oCeHE3CpxUM0xjgPYyhDyhozSYDBU1qKrpQH+6QhVoBo9MP/I5xtMnqUWGAjH7CQr
	1KCPgcJQ==;
Received: from [2a02:fe1:7001:f100:5032:a5e9:361e:fb99] (port=60365)
	by smtp.domeneshop.no with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <Ywe_Caerlyn@cu-phil.org>)
	id 1rXgbx-00DTsb-0D
	for linux-kernel@vger.kernel.org;
	Wed, 07 Feb 2024 13:01:05 +0100
Message-ID: <756d1b9f-e7bd-45a7-a485-0e9290fdca6d@cu-phil.org>
Date: Wed, 7 Feb 2024 13:01:04 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-kernel@vger.kernel.org
From: Ywe Caerlyn <Ywe_Caerlyn@cu-phil.org>
Subject: =?UTF-8?Q?=40_X_Philosophy=2C_LEL_/_=D0=93=D1=83_=28Was_Fair_Source?=
 =?UTF-8?Q?=2C_Low_Jitter=29?=
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

A last iteration on philosophy. Lel can be used for italic script, and 
Гу for russian as I said.

Lel also separates references to it out of the name Linux aswell. The 
name Linux has been debated, often for ego-reasons not suitable, and 
also really references to what is Lel.

This is the best thing to do.

I support more use of Rust as I said in my previos post, it all is low 
jitter centric for an optimal mail system, which also is optimal for 
gamers (which I am not particulary related to myself, but it will be so.)

Researchers will have theirs, gamers will have theirs, and it all 
supports a Fair Source system, and optimal Labour Party politics, with 
referance basis in The Kuran.

This has been going for quite some time now, and I have been a mascot 
for this in the 90s, and did research on philosophy later. And combine 
it all now.

Go against it and you are Into Deep Impact. https://youtu.be/ZdF2LDerwvo

-Peace!

