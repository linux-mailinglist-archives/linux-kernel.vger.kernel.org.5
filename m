Return-Path: <linux-kernel+bounces-41158-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5029683ECBD
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 11:39:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2D31281F4D
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 10:39:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB4871F61D;
	Sat, 27 Jan 2024 10:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cu-phil.org header.i=@cu-phil.org header.b="Hfh5WzEw"
Received: from smtp.domeneshop.no (smtp.domeneshop.no [194.63.252.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48E6E1D6B6
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jan 2024 10:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.63.252.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706351952; cv=none; b=QKqhq1j2ljGRxVPgzow64UAWN9X5JSZ3EaQz5ZKuA4HMGBkI6ogAYleNNYc1+kOth2KOaAc7TH1pvg9uEzuKucn+Bb7W9WFp0ApheWcgUvaEH9Mdx2RvE97tXFW5Yfv819vo9s44QUiX3Jo6Ud63Q8cSEompsb/BzWeWy0+o2Mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706351952; c=relaxed/simple;
	bh=hWef8dY3Cq8vbL3O9JeuQR/SY/N5Q1IcekOdVW0r+OQ=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=RST9pjvnE5aKf2GuMu1hCu01T9iADS+5oYEevLKQlPqkw9mif0XM6UrcYaOmlnNMrXE3BSBnZgro/nSqVn4K68SbatC6d4V7i/OjKWIWq26Qf8kmfvovJGVa/MUC3fjEmSjUdpm9OWwmO6y4BCugHSUEAVkEpktybDLBYAnTD5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cu-phil.org; spf=pass smtp.mailfrom=cu-phil.org; dkim=pass (2048-bit key) header.d=cu-phil.org header.i=@cu-phil.org header.b=Hfh5WzEw; arc=none smtp.client-ip=194.63.252.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cu-phil.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cu-phil.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=cu-phil.org
	; s=ds202401; h=Content-Transfer-Encoding:Content-Type:Subject:From:To:
	MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=x8VUbLvty4gWk7MrMrDBpJsuH7AEfmNXUbN66WEnmuY=; b=Hfh5WzEwiYw1nYaU+YuGBFLb14
	k0vUMP4hzGhSKrJTsvB/rlRikBSj3RaSz0xVuYxHSshFMGndh0fZPbDs4H2KPZqERmrIYnKVQJXky
	AhLVjTR/iX9yrkyqsSnBuyytcTTtXu5pgxJuBrfxsoAhRi1w0EdtbAXbQmxV8zMARNGN1EzOQCnKp
	ntCQruHaRx4wP7CH/oRTD397sqkrkk3NQKMYgLP7ie+jDHzJDOmRe+jBxX5yQcOg8HouzchmORxSx
	7oiTY4VAZ0srXm2wYI+Q6EW62D5Gh17eASf09cmB8mrF0XVqkH9pDy/+oxfJXx5Vw6cUsPRCgei3F
	BMCHB9gA==;
Received: from [84.215.119.50] (port=49841 helo=[192.168.0.2])
	by smtp.domeneshop.no with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <Ywe_Caerlyn@cu-phil.org>)
	id 1rTg5c-00ExFC-99
	for linux-kernel@vger.kernel.org;
	Sat, 27 Jan 2024 11:39:08 +0100
Message-ID: <7bc3e587-4f7c-4118-ab55-134feb274a8b@cu-phil.org>
Date: Sat, 27 Jan 2024 11:39:06 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-kernel@vger.kernel.org
From: Ywe Caerlyn <Ywe_Caerlyn@cu-phil.org>
Subject: @ X (total integration of politics, system, philosophy)
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Or one can just call the whole thing @ X. @ being a common symbol used 
in Labour Politics, where we want Fair Source politics in aswell.

This is a total integration of politics, system, and philosophy. And 
system design is according to @, supporting already existing Labour 
Party politics on this.

-PEACE!






