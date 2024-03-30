Return-Path: <linux-kernel+bounces-125706-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CCBBA892AE1
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 12:38:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A4FC1C20D53
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 11:38:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3E1B2D057;
	Sat, 30 Mar 2024 11:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cu-phil.org header.i=@cu-phil.org header.b="eVuTLshh"
Received: from smtp.domeneshop.no (smtp.domeneshop.no [194.63.252.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB2C17FB
	for <linux-kernel@vger.kernel.org>; Sat, 30 Mar 2024 11:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.63.252.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711798711; cv=none; b=Kyuz9dVBgBwYBbXyOuWz2lJ9Z2ps9nlhhRf9IbpJh36J57Tc9ACHPsaGY7D+5NG2dyZe7NQkoTa+N1uXDmXEqreKTrBF352OES6fWsU9sPrwQ/izELA45816GGW2orxexkh7eCgeJSepzqy3Nhxgp8I3b6NsxRoK299obSJCu2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711798711; c=relaxed/simple;
	bh=Z7n3SVKIyn6ofE3rXuMsoyemhdKBRbWmSGB1vqbtU74=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=cYpZ2Al+qGPafmZfL0siJEwcFA9IDaic3tJmaUh2ZI6zNBoq62xy0FX2vx+8fCCQJXYqCb1eCG+NxLa1rDiOMjQvDoRkOjZoAQUuHFQlnWhBhUiijOoRHl/VZyQukoi9crF45kKozI+3wRHvf9gZEHyUzhWaFW/3Eo/XmVbNLzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cu-phil.org; spf=pass smtp.mailfrom=cu-phil.org; dkim=pass (2048-bit key) header.d=cu-phil.org header.i=@cu-phil.org header.b=eVuTLshh; arc=none smtp.client-ip=194.63.252.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cu-phil.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cu-phil.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=cu-phil.org
	; s=ds202401; h=Content-Transfer-Encoding:Content-Type:Subject:From:To:
	MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=0cCMGJINXZlVkOaUSC+lBYKtvy9U4LPHUm3aMMiTADs=; b=eVuTLshhKz138SHSZ7MJUZn5ac
	Ed70r95pa0vUVTomhZf/8Ei+5rz9/+RvL/hgKXL9lllMXohQAcIxxIdn20yhrJlKrn7DODluxqC40
	f5rVteax4qfDivDmemHuQFqLPGZDP+Aov8EpxlXmPDNzletjo3WCc6Wsc7lTgRRyoxfAuXOrNSHIz
	ZToTJthNJGaqQ6j5CVQgobbLil4SDHOIt2DddZjBP8ploaW01yuJSNo6Mn+VjDQ1WDqmcefT2K7gx
	pFyI3HWQKZej1F8ZS20/swtZ+Yitc7wfwqIoRbk7dlAPz4UoICxeDeFbiUVwJovEHTtV8drtQlgDV
	MxRM38QQ==;
Received: from [2a02:fe1:7001:f100:fd7e:4fff:d7e3:bc49] (port=54894)
	by smtp.domeneshop.no with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <Ywe_Caerlyn@cu-phil.org>)
	id 1rqX2T-00A7bc-7X
	for linux-kernel@vger.kernel.org;
	Sat, 30 Mar 2024 12:38:21 +0100
Message-ID: <dc3d3224-48c6-48c9-8009-d826b10e9902@cu-phil.org>
Date: Sat, 30 Mar 2024 12:38:19 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-kernel@vger.kernel.org
From: Ywe Caerlyn <Ywe_Caerlyn@cu-phil.org>
Subject: Was Fair Source Philosophy, Low Jitter (Final Listmail On Subject)
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Its really outdated with text based email.

Unix for many was a text based user interface, and still is for many 
here. This is however wrong. Irix corrected this, and really was Unix 
with graphics modules loaded, as originally intended.

I feel this text based interface really follows in the flawed thinking 
of Unix being a text-mode OS, and this will be my last mail.

For anyone interested, please see my Youtube channel: 
https://www.youtube.com/@IT_Rabbi_Norway

Hail Dou, The Grand, The Good.
Peace,
Ywe Cærlyn.

