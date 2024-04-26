Return-Path: <linux-kernel+bounces-159526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A2EB8B2FC7
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 07:37:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 115C51F226D5
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 05:37:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31F8113A271;
	Fri, 26 Apr 2024 05:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=malaika-12.net header.i=@malaika-12.net header.b="ElHyFnoQ"
Received: from smtp.domeneshop.no (smtp.domeneshop.no [194.63.252.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D14713A3E3
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 05:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.63.252.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714109810; cv=none; b=DEdThnO7LTeedcci0nEysrjS862JJbmp5AojWxV+P4uXfinGLvP0NAz2u/ItQW6qsKAeUlezRsQGsSlMspZ5GARHEerYsVz5lduW09HX2fb5fH+3fSnno2NLK/172ynsgc5sbAMJ9u25ey1rv9KqM8hwTJGDWSW+jHj8jSMs+xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714109810; c=relaxed/simple;
	bh=CNw2Y0AP8jB/x3HV5DSSYHNMON2PcPXoJ9fa+UitcrQ=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=MceKbzb5u9ZFGLAuZORSUBqvb+YIM/gsXSnI9/GZvSVQ2cCkjMw3iYXmoqhUeROSv2zW5NPD3Rc5YWWCMePkEww+m0qDdin57kdS2fElekU8csxRn/5KoMg4b6q952hrqcGR004ZgQUNYFsfeBOXUFDQI+fUl+TL+hsyVujqF1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=malaika-12.net; spf=pass smtp.mailfrom=malaika-12.net; dkim=pass (2048-bit key) header.d=malaika-12.net header.i=@malaika-12.net header.b=ElHyFnoQ; arc=none smtp.client-ip=194.63.252.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=malaika-12.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=malaika-12.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=malaika-12.net; s=ds202404; h=Content-Transfer-Encoding:Content-Type:
	Subject:From:To:MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=0VBnxfb65WAipnGm7jkG0NPmHc1gSmsqVXH2RNZJPXI=; b=ElHyFnoQFjvdwVP27vYH9tNqqa
	5UYVnq7aPofWOMq3Kqfew2ZnRH3glx75u6A4TlcLmGbPOghkerixreNUuqrD89rq1fYaH5ttSajTn
	I7/CR/N8ehPssNGSpXAzvg6f0QIO6Pn1OgCtlcXkJT6o2HoQOuXK7/CMIzb5vmxdAgGlqM4XMPOTS
	0d1FOKNRs+u80Px2lYjJif90YD+rr/o9z5xMCcDkaI47HZZCpCQyffepNEnx6RJpp3arq7cp5XbkV
	e4mBCn2uEvQ7+Q/PHr6N1hVOEWzgidRfLrKe5DjESCK16QokCXHJoPYI+SsIarjrrcPrtMedXMbMA
	RqeIn+uw==;
Received: from [2a02:fe1:7001:f100:d563:54e6:3312:27b1] (port=57322)
	by smtp.domeneshop.no with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <B7t@malaika-12.net>)
	id 1s0EGH-00AGnF-0i
	for linux-kernel@vger.kernel.org;
	Fri, 26 Apr 2024 07:36:41 +0200
Message-ID: <c02e4fca-c295-4eaf-9809-f3542fe481b2@malaika-12.net>
Date: Fri, 26 Apr 2024 07:36:18 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-kernel@vger.kernel.org
From: =?UTF-8?Q?Ywe_C=C3=A6rlyn?= <B7t@malaika-12.net>
Subject: Haq God
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Everything I talked about can be summarized by Haq God.

So rephrasing: All computerdesign can be designed according to Haq God.
This is also compatible with Sin, and can also replace Sin in 
electronics industry, for a total unification of electronics, operating 
system design, and Fair Pay philosophy, all with Islamic background.

PEACE.
https://www.youtube.com/@Ywe_Caerlyn_Samilands_East

