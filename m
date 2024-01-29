Return-Path: <linux-kernel+bounces-42284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D21783FEFF
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 08:30:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 183AA2828C8
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 07:30:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B65A4F1F4;
	Mon, 29 Jan 2024 07:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cu-phil.org header.i=@cu-phil.org header.b="l/XJ42Yh"
Received: from smtp.domeneshop.no (smtp.domeneshop.no [194.63.252.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23FF14F1EA
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 07:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.63.252.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706513432; cv=none; b=M/tNyEIEdx0SI4QM7AfauF3qJcrs+M9yBYm0+Cl720q3fzCCbWPJkQlEoulT7EQfYWDyerqnZ/bbpEclAuaohI05fWc9ZF38K1Hgbhhxv/55OyShEjqh5GbTOCG175urx7Qfwol2AsMCDWK/inWHoMDuuZ3PdON70/hVDCzjY0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706513432; c=relaxed/simple;
	bh=RF9qsk72IRMY3eSbQpjccOhLtCKySy5fndAtSOJ6YmY=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=l80jaAkrHKYhXhqrYY/cmTpMEIEF0bjXpFH5OMvuZKAiBneLNPWb6YKHlpyVzcRQp1lwrbW9FoMS0MdZJfgEyqOOtxrT7IR39pilSV3rn5QOEls1nTSyHB1ShtmeJ/VEeZg7hJXyp0jhaeyi5eaE646B8YWt+Yqe5PaaFvK1oaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cu-phil.org; spf=pass smtp.mailfrom=cu-phil.org; dkim=pass (2048-bit key) header.d=cu-phil.org header.i=@cu-phil.org header.b=l/XJ42Yh; arc=none smtp.client-ip=194.63.252.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cu-phil.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cu-phil.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=cu-phil.org
	; s=ds202401; h=Content-Transfer-Encoding:Content-Type:Subject:From:To:
	MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=8u1qxOzJnK9c0z6QjRx9iToy9c9hLFaYN0/NwTHDn6s=; b=l/XJ42YhqebprpDY4QOTfVaVXP
	lFSW0raz++qX/h63SbP/xLVsWyAS3gI2Si8wa1ZYGDtRbaPZMsRTkivMZxvCbiTGfvao/pBnGd3QV
	5ipUKMQWUqvlkgdFB6/1SCdlIKxpPudYqq+aVhEhhSbEkIucRHZOdRLeP93rWQM4n9gRPAYpngmFt
	LnOhUUj1fQG3sNtEijuPHDJFEZ0hMo04+M7vcf0lf6Foivug9QRtd/GMFpOwutq2MEbBFut06mNcP
	5xJg6Afh9u+1UhLw1r0w+0ylqaF52lPUUS2VdkCeOF+mcwfUxAiY7gDJ05uaJR7uho9COLoKC8w5c
	WijlQbYg==;
Received: from [84.215.119.50] (port=56226 helo=[192.168.0.2])
	by smtp.domeneshop.no with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <Ywe_Caerlyn@cu-phil.org>)
	id 1rUM61-004mpa-Ny
	for linux-kernel@vger.kernel.org;
	Mon, 29 Jan 2024 08:30:21 +0100
Message-ID: <391c02a0-0444-4431-8122-b3c345cc602f@cu-phil.org>
Date: Mon, 29 Jan 2024 08:30:20 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-kernel@vger.kernel.org
From: Ywe Caerlyn <Ywe_Caerlyn@cu-phil.org>
Subject: @ X - Finalized Philsophy
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

@ X is the concept I have been researching for a while now. It supports 
the much wanted (and demanded) Fair Source angle, for broad societal accept.

The background of Fair Source is in Iclam, via the italic script Tio, 
and supports and fully fluent translation. Hail Tio, The Great, The Good.

I have done mascot work as Saint-Bit for this aswell, summarized here: 
https://www.youtube.com/@Ywe_Caerlyn_Norway/videos

The other angle I have called "Coolians", and is mostly a "jungian" 
psychiatry perspective, where one can consider there to be 7 archetypes 
in popculture. Supporting Fair Souce Labour Party politics. And the @ 
can also be considered to be in line with their symbol aswell.

A test channel for this here aswell. 
https://www.youtube.com/@Labour_Party_Digital/

The OS will mostly have their angle, but ofcourse researchers will have 
theirs, all the way to fully fluent translation of The Quran, and a 
complete expression of Truth.

I hope you have enjoyed my discussions.

-Peace.
Ywe Cærlyn



