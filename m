Return-Path: <linux-kernel+bounces-84694-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F2F986AA49
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 09:42:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C153D1C21B22
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 08:42:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EB752D05A;
	Wed, 28 Feb 2024 08:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cu-phil.org header.i=@cu-phil.org header.b="YZnxaG/0"
Received: from smtp.domeneshop.no (smtp.domeneshop.no [194.63.252.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D805F2D03C
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 08:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.63.252.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709109734; cv=none; b=idzby302pXDv7jE7yyeB8R8Sr1xwbNPhbuPwI2s5tdrh0zC/xnvgFVBfrhkz/vSN2ndD21f4W5+rQErHVkdxQ8lHnaLwRv1wpKluHARmDNQr5FCxYH7pqj2GZcBQR8xJidhswkQGxP+wKlUFwPib5iEB09PZLMWFWNpw3hPDTdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709109734; c=relaxed/simple;
	bh=1gdw1Zdc1gidpZF/SiKsj0G748eSc+I7M8BEkwsdFuQ=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=j7MyH/yM6FlXJxDCIYrYKG28XGdiZgpaNLuYEi7Oe7by0SW6qCRIkXfSJqzkr5XxzmrZAo7Vr81FEvMJxmvvNbZfuQQyV2ewwoaeaLuUvxFffNpsbqa4D3VnTytdDip47/oiV/3h1QJOZU62GkVD+mT102ntDAPmRNr4DnzJ2vI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cu-phil.org; spf=pass smtp.mailfrom=cu-phil.org; dkim=pass (2048-bit key) header.d=cu-phil.org header.i=@cu-phil.org header.b=YZnxaG/0; arc=none smtp.client-ip=194.63.252.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cu-phil.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cu-phil.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=cu-phil.org
	; s=ds202401; h=Content-Transfer-Encoding:Content-Type:Subject:From:To:
	MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=qPT+WU1peeyPpuoi/DgUNIAhfXPp0Hcnfyr7TCgu+2Y=; b=YZnxaG/0/sLtOOH27pCuUmm+z3
	leQ/qL9KbPPO4Hwi20QnU7UQBsGivE0HwEOs154r205vpMVMnzgFwqC2KAcuR6sc8M+OmnOCTWUOP
	r8siAp7YZzJzVObTxd4t+T6p7C4Tbyp4975P05nTizsSUWUjXKSZvA3UO8BuIiBS7mgGezHpqzEy9
	gNudL5sl6oR5RxOSCLAFZqj2Q3fcl5T8UzjOcarQulMMUdrt8YBfSTTuuBOxjPSpHaR7YU0xGQjZ6
	099Vj+ckRzgtdcrMj6mo7bu2OesHh3eKMIXfcg7WsPALzRQdxFsygE/hubq0ZL7Ovige9ikZN0Bv4
	iGyjIfTA==;
Received: from [2a02:fe1:7001:f100:687b:84d0:4dc1:8a8d] (port=54597)
	by smtp.domeneshop.no with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <Ywe_Caerlyn@cu-phil.org>)
	id 1rfFVx-00H1ZH-Ol
	for linux-kernel@vger.kernel.org;
	Wed, 28 Feb 2024 09:42:09 +0100
Message-ID: <bc9676a6-3e24-4f0e-b2ca-d0cb875a76e5@cu-phil.org>
Date: Wed, 28 Feb 2024 09:42:08 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-kernel@vger.kernel.org
From: Ywe Caerlyn <Ywe_Caerlyn@cu-phil.org>
Subject: San OS, Politics (Was Fair Source, Low Jitter)
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Also regarding politics, I think Red Party is an even more instense Fair 
Source sympathetic politics instance, and this also coincides with "Red 
Hat" if that is about the same, which is a very central distribution here.

-Peace!
https://www.youtube.com/@Saint_Bit




