Return-Path: <linux-kernel+bounces-75330-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76F8485E6A8
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 19:51:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A86CD1C2232D
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 18:51:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B67D85937;
	Wed, 21 Feb 2024 18:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cu-phil.org header.i=@cu-phil.org header.b="qF81sfdW"
Received: from smtp.domeneshop.no (smtp.domeneshop.no [194.63.252.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58DAC82D97
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 18:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.63.252.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708541467; cv=none; b=uSTCVwLdIwyv4S11HCx/hQNs/i/zU/yG/Iq3WnSKPUpu822El/HHsK6hU2CddpD4fo3Vml+4tSwQ2jsXtO5u1meLNL7lkBhxmYv0v0HzAdop7Df3GVPVvkSo0Q0VH6wid7BfkNbPIExFQv0E1EZMUNcs5ki0rcxaCs+rztQVVKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708541467; c=relaxed/simple;
	bh=72r8HXinkfQSWVDr9vUzxkaMp15DahzYpwYlY37MTyE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=TfiQWUkNzjgV3nT13dst3dp7vITnU3FZoQwI11hIseCLfiPxZkuX0sSiH1KGCfOa45Mak3F8TjgtKfoGsl+Tb92NBLHhUz3bqhuZWdF3m9Fi2UhOBtYJJt8orwvQKRVRyoB5cddb5Tm0/uKmb24iJ/XGOql66/IGJhsgHBO8Q3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cu-phil.org; spf=pass smtp.mailfrom=cu-phil.org; dkim=pass (2048-bit key) header.d=cu-phil.org header.i=@cu-phil.org header.b=qF81sfdW; arc=none smtp.client-ip=194.63.252.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cu-phil.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cu-phil.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=cu-phil.org
	; s=ds202401; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=72r8HXinkfQSWVDr9vUzxkaMp15DahzYpwYlY37MTyE=; b=qF81sfdWvWJpbSzn2NoKx3e2SX
	RvMRc+zQHSwe6asrgjhMss4p3AZ5hlSLWTlNm3Bz7AjoPKA0xfBJXjFYYHJ5XavsQq+aFUHgzSM4c
	IP0uET3rXznGBU3F0sYT1UCcfElMtcfk9N2mtkUlRRireSI8Aifwlq5Z6UKb2kxNJXHnrotWPW+N1
	2PC/GB1hmIr7DE6mAtl5htxTjrs1qq0Z9ZKenIqXORxr0TSqSUKRogpd54pqvwRQkz4E536ovcVNo
	JkM/EOI+YddhHlpmHCaFcaC+urmY91NQhs82+6+65C0lL7OKpdvzyQZ8c6hvZEZZGB/vJZOQwtIDN
	ZiXdrdqA==;
Received: from [2a02:fe1:7001:f100:c492:34c2:9e52:66a6] (port=51631)
	by smtp.domeneshop.no with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <Ywe_Caerlyn@cu-phil.org>)
	id 1rcrgM-00EREn-7V
	for linux-kernel@vger.kernel.org;
	Wed, 21 Feb 2024 19:51:02 +0100
Message-ID: <8e07ce4d-1647-40d2-91a9-4a7734f31916@cu-phil.org>
Date: Wed, 21 Feb 2024 19:51:00 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: San OS, Philosophy, Low Jitter, Fair Source
To: linux-kernel@vger.kernel.org
References: <Yr2dD5NZNNVIap6XB69yS3f5xXZ4gxuAZWd56YZdHedKAviTzu-qjMfXBUJeIlujlE7NAVu7PBclfHOHqSOwIQ==@protonmail.internalid>
 <f0669840-b3aa-4829-8e52-849e053df5cd@cu-phil.org>
 <34a7ba630bbf06114d135e6e9536d869ded39108.camel@gmx.de>
From: Ywe Caerlyn <Ywe_Caerlyn@cu-phil.org>
In-Reply-To: <34a7ba630bbf06114d135e6e9536d869ded39108.camel@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Yes, Mike Galbraiths CFS vs Colivas followup EEVD, seems to loose aswell.

Go EEVD! Indeed not respecting Colivas work here is not at all fair.

!

