Return-Path: <linux-kernel+bounces-165979-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D2148B942D
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 07:18:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36F7C283C20
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 05:18:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA2321F95E;
	Thu,  2 May 2024 05:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bit-x.org header.i=@bit-x.org header.b="kHu0uI8i"
Received: from smtp.domeneshop.no (smtp.domeneshop.no [194.63.252.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 904471CD2D
	for <linux-kernel@vger.kernel.org>; Thu,  2 May 2024 05:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.63.252.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714627088; cv=none; b=pTQHM8QOY57aULVXu+LnssocdhZCs7UY21IBH7rtz/wN1S42abAB7a5wD+Nc/R0Uuq+tfRCliRRE2bHIEl8yivhlLUTa1DT6bXKumoGikNo8CtbD2uD4tUFudOtiw2NE+6SdCZ39TBGPNM28SbX1sTpEJR/R/m5i8/Kd2GN2ErQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714627088; c=relaxed/simple;
	bh=hMF1YpAJGDyLA2fOzshPNOHGzfR5hREuASFY8JXyQZA=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=CHxraR87NV+WgfSJSoz1wid43era1p7/FQec/YRb7QNWzW/1rUm4wwCD8hYWqlmA05dVSjW9NukbjKU08ysHmQ5D75TCWLLhRXH2DjriHXa9pOy+KxuMXyOFZe/ONj/qHrwSEAlIuX1tJZGzFg+D0VS+uhVztrXgLKw1fIwv7Co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bit-x.org; spf=pass smtp.mailfrom=bit-x.org; dkim=pass (2048-bit key) header.d=bit-x.org header.i=@bit-x.org header.b=kHu0uI8i; arc=none smtp.client-ip=194.63.252.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bit-x.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bit-x.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=bit-x.org;
	s=ds202404; h=Content-Transfer-Encoding:Content-Type:Subject:From:To:
	MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=24Rvq+fclbQ4hPou7YSyzdFVsM8niQVyfXJXS4ear7I=; b=kHu0uI8irhwXSu1+pDtWG6ISB7
	/3VwvswMS+luSviwhan/WS+h20lu+IlCJPvssNiCEuU4xOYaLte760OOjzXjfDg4XF+hnl60jSlp7
	Y15pHysGZ8wocmE94ptQAsYJOJq/9V5fSwrNsJG1hwVsH9SCsrS/gbs0Eojci1YcqgtjJzUdfnlPz
	Tuoylhrg79xEs9HaOAay/dwedWXZJiLmJ00QfrfDmbE5kWTmwFqtO8xmuC/d8zflrN0XYY4cwPC89
	iY3IOIOuyR8zm/qKXRIKEKnrxsfgJSKrY/qyv22edq17GJNlXz1F9/8l6NerwB1puD9UqsKgmowKP
	WJARbkPQ==;
Received: from [2a02:fe1:7001:f100:e8d1:4752:2997:ba78] (port=55794)
	by smtp.domeneshop.no with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <ywe_caerlyn@bit-x.org>)
	id 1s2OpR-009wyK-Hx
	for linux-kernel@vger.kernel.org;
	Thu, 02 May 2024 07:17:57 +0200
Message-ID: <b7f6da52-b310-4707-8249-278fecf41481@bit-x.org>
Date: Thu, 2 May 2024 07:17:57 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-kernel@vger.kernel.org
From: =?UTF-8?Q?Ywe_C=C3=A6rlyn?= <ywe_caerlyn@bit-x.org>
Subject: Fair Pay, Low Jitter, Philosophical Background SUMMARY DIAGRAM
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

I made a little summary diagram of all I know, on

https://bit-x.org/BIT/BIT_Banner.png

 From research talk on Indus Valley, Dispilio Tablet, which is typical 
there, and centric to a good requantification of the computing sphere, 
for Islamic background. Which is what everybody wants here, which became 
rooted in the c64, so this is really the c64 paradigm correctly 
requantified.

This also includes my findings on the correct translation of ALLA: Val. 
(for italic script, which supports a wholly accurate translation).

The Light Be With You,
Ywe Cærlyn

