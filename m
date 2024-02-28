Return-Path: <linux-kernel+bounces-84546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7086B86A818
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 06:44:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FE9C1F24F81
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 05:44:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7488D21379;
	Wed, 28 Feb 2024 05:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cu-phil.org header.i=@cu-phil.org header.b="oVADMDBW"
Received: from smtp.domeneshop.no (smtp.domeneshop.no [194.63.252.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9167A21345
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 05:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.63.252.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709099071; cv=none; b=DRy34NSsQHzXwl7CLAJ4roW0jlapBcvqrHCdP9lux6yyr4xyuwt6AGoSICyvV7e/ediIaYXhGy/xl6rH//qReTb6PqOJYM3IqWNAB9vqOFqXpwKZLs6HnI6PEGWCGfnMTS2Jwtbr4MjoFVGw50EG99S7IPlqmjFiT8yoZ/CC8cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709099071; c=relaxed/simple;
	bh=tZ5qMV0EWYEvmAQt65v9lJOpgxAxDDCW1cmk2g+Chz8=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=M5f9j7/aH8ErsEr5blXYBqmLAwPGisz9Scg8IOWX8m6sF9oGRA6lMXFK1yVJgvuc8W92x8CtxUV2YnKbRe4FtMh5NOFIeuDpvub4YrokdpxnLNlB3W6xhhlYj+GkqkzgoirLQrAOeUuMICjI1HFiZ7RugI0fWsm+8P+4EoRJyzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cu-phil.org; spf=pass smtp.mailfrom=cu-phil.org; dkim=pass (2048-bit key) header.d=cu-phil.org header.i=@cu-phil.org header.b=oVADMDBW; arc=none smtp.client-ip=194.63.252.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cu-phil.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cu-phil.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=cu-phil.org
	; s=ds202401; h=Content-Transfer-Encoding:Content-Type:Subject:From:To:
	MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=SX0jf8/nISdL79qiKsf1WcehRToFU/U5pmcA1jNskMo=; b=oVADMDBWyp7gGS+hd72yfPRhny
	HkeOrY25CTZrvRLTKCTt0rqY1Qm3sv3aY2dLcAlZROmgtwi5ryv/u6THpJh24dP0AlqCmwGnZJ4qo
	7AOf+pSHd4LLdJ5+KSNYDD7f/uVDA0Yv/BRVHXEwE0AGmOVZVyCND4YFIO3rjAjUCjorWZO5f1XJ5
	r/NBT4+GDRqGlqiaDzLjLHHOaYUMSKZDj7tcRdL/mGeE7DnGQcF4xpkjLDoeDNzAuHRxDxdUq+tQs
	2jg7sWCMG9e+N9PJ/DzAzNFFndf3fcdPFPQhS/GqzCVGo5obvsfuSVBZFsIDitzj8+sj7167zWTAH
	GaijmLLw==;
Received: from [2a02:fe1:7001:f100:687b:84d0:4dc1:8a8d] (port=55431)
	by smtp.domeneshop.no with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <Ywe_Caerlyn@cu-phil.org>)
	id 1rfCjz-00G4oz-Ed
	for linux-kernel@vger.kernel.org;
	Wed, 28 Feb 2024 06:44:27 +0100
Message-ID: <3647027e-3379-413a-8b7b-a63a9a51b6a5@cu-phil.org>
Date: Wed, 28 Feb 2024 06:44:27 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-kernel@vger.kernel.org
From: Ywe Caerlyn <Ywe_Caerlyn@cu-phil.org>
Subject: San OS, relation to Irix (Was Fair Source Philosophy, Fair Pay)
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

A further note on San, the concept of The Deity used for computer design.

Irix is also this, from the eye. And anyone can use San, which is the 
native form.

So if you liked Irix, which is really what is behind the Amiga computer 
again, the most popular homecomputer of all times, and where really this 
kind of indie movement came to critical mass, then you will definately 
like San OS.

-Peace!
Ywe Cærlyn
https://www.youtube.com/@Saint_Bit

