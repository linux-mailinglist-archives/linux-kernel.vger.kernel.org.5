Return-Path: <linux-kernel+bounces-80023-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 200598629D8
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 10:05:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B06B51F216AA
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 09:04:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C73ADE556;
	Sun, 25 Feb 2024 09:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cu-phil.org header.i=@cu-phil.org header.b="QBLB3GFk"
Received: from smtp.domeneshop.no (smtp.domeneshop.no [194.63.252.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4CC78BF1
	for <linux-kernel@vger.kernel.org>; Sun, 25 Feb 2024 09:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.63.252.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708851893; cv=none; b=CeiGajxZs6suZ0RGcfbyVGIhTiD82G0r8esoc6bIR8Bji3xFz3tsHt3guFMnar5jd6FZvyPbVaa2aENpu8gCOghZcyFikdWUi5bdKTuaxrFBljO4opo3KEEf1MjjJpozoJhz14taIsXIi20X06ME3npr60xNdY+VPHxOKvwDCBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708851893; c=relaxed/simple;
	bh=6Vi8Vn81IR6RDv9GlgF7+lupUmamlBU674vTJFQBCws=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=GiFlZU/N2mM6P7gMFXxFsCCkaJu3Ab96b8lvReyQqbxdqiytpF1qmNrhP54eno/b6z8YWAy1mxjB0dUHpb0hy+G5wtQOiY6AjtDqF7xzLK83nxQ/0YhRlVGtdz9T8M5VvhvZqlVs2u+09CpfJvCd2aQJiwM/hmJOBmhty8s7W+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cu-phil.org; spf=pass smtp.mailfrom=cu-phil.org; dkim=pass (2048-bit key) header.d=cu-phil.org header.i=@cu-phil.org header.b=QBLB3GFk; arc=none smtp.client-ip=194.63.252.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cu-phil.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cu-phil.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=cu-phil.org
	; s=ds202401; h=Content-Transfer-Encoding:Content-Type:Subject:From:To:
	MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=6Vi8Vn81IR6RDv9GlgF7+lupUmamlBU674vTJFQBCws=; b=QBLB3GFkqUqru4/ABm2BdJvFLB
	/IH7cUwe8auA3PYTOi2TRouPx6iIKICXBXjlJlM+MKq5TkoZoQZOvSYZ8QuVDQ9UWQUg2qQn+FnNb
	xE1sL8MM7XMa/D932NxsfK/l21GcXHX077m3RaoO8oCBFf9QcBaWmOg6odIptHGPxjT3v3F02a1Io
	qkdYDEcxQZxEEksURCzBy6A4cWyvnQuH3y308ySX60829z+WtTfjzq4Le64iBEU1lpEhJhXAMOURN
	UKOe+OYxBNrgDixQxIrZfgECmgULqAY2m0+e3YytiO7WEbwH2xUrPe5i3STc+qjtQVFs5FGf0NbiW
	jMEeNrXw==;
Received: from [2a02:fe1:7001:f100:ccef:d53a:cfe3:be8b] (port=60965)
	by smtp.domeneshop.no with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <Ywe_Caerlyn@cu-phil.org>)
	id 1reAR8-00FUlb-Hr
	for linux-kernel@vger.kernel.org;
	Sun, 25 Feb 2024 10:04:42 +0100
Message-ID: <499a0907-c391-4f50-9710-50c68c3a76be@cu-phil.org>
Date: Sun, 25 Feb 2024 10:04:41 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-kernel@vger.kernel.org
From: Ywe Caerlyn <Ywe_Caerlyn@cu-phil.org>
Subject: San OS Youtube playlist on Background (Fair Source)
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

https://www.youtube.com/playlist?list=PLkx2Fi-LyBi1KFKeO860eb09YF_d3BGAJ

