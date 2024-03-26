Return-Path: <linux-kernel+bounces-118350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 43B1188B938
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 05:04:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E9591C2F5A0
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 04:04:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9932129A99;
	Tue, 26 Mar 2024 04:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cu-phil.org header.i=@cu-phil.org header.b="hkgQUann"
Received: from smtp.domeneshop.no (smtp.domeneshop.no [194.63.252.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B26E112838F
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 04:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.63.252.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711425885; cv=none; b=epwqRVLbn2vG7yF99mpoYxXileV/xZdsRb1TxO7fg6Mi2TI1K9E7yT5n+2peAwtlAHz9xh0Hlux9Q4kQt3Po0Ukkuz8xu3F4lT9QjmtFiJ9ZJ5Bc6HQe+tjSci/b4Y9c0qibdtf0Eh9pAV3AhFBBlkkCBgOKzwb/us1raTi/Ykg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711425885; c=relaxed/simple;
	bh=nKdVvGrrprgDRddCqBzMUaD5OOtqLZ35FVvYnuNeIiw=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=Qer/aT32rcC6wsF3HwB3Jm1pKsukmZTC8k7ldT9zlIhY1c9nPT9x0okPd+Sbhu+91gGEJs9E0dOoct678lyqKnd6l+q/aHSrHiRcT38XbNTAmWoy5TP60cK+H8jkfzDNzmEZ2sphJa0+OGN69JGESz09fb9x42LcK3WgYR5zO8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cu-phil.org; spf=pass smtp.mailfrom=cu-phil.org; dkim=pass (2048-bit key) header.d=cu-phil.org header.i=@cu-phil.org header.b=hkgQUann; arc=none smtp.client-ip=194.63.252.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cu-phil.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cu-phil.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=cu-phil.org
	; s=ds202401; h=Content-Transfer-Encoding:Content-Type:Subject:From:To:
	MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=ji6leQkYevaGIRnnvcWRAPyigxnDIGXQnKeNozxcHgw=; b=hkgQUannsF246FRmtGak/3ABjE
	dU3m1cIoh42wbmvfmpv+qvDMWAccRyMm2ogPkPB53q02cBZTKecwINY8XdRNJTlYVIMKEDPU4xx8b
	8Iaj2gACjJ5YCo2RPMTYJh+hdg23yjUNf6bG3aKkeohJf4lxWMbqorLww4aJ0dYEm7VeuEHv5/17A
	JI24rfjq9wc/ien7NcpoAUujZyjqH1mVoYaHmPanup427wssZ19U6wqdxA9Sqc+Tw2TJXVSjEQzyJ
	bD83jc86U8d0DTNCA8rKFfwqOdquwqH2libFB+JMyKlD1CLyIezd1DpYf2vwoW8xw2HRdzKmxvEOh
	kZWhvSDw==;
Received: from [2a02:fe1:7001:f100:4454:57b9:ceb7:6e55] (port=65066)
	by smtp.domeneshop.no with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <Ywe_Caerlyn@cu-phil.org>)
	id 1roy39-007N6H-Km
	for linux-kernel@vger.kernel.org;
	Tue, 26 Mar 2024 05:04:35 +0100
Message-ID: <bbce54ef-5df6-42f0-a0a3-12ee8eb01fa2@cu-phil.org>
Date: Tue, 26 Mar 2024 05:04:33 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-kernel@vger.kernel.org
From: Ywe Caerlyn <Ywe_Caerlyn@cu-phil.org>
Subject: Project Bit (90s) current derivatives (Was Fair Source)
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Yes, I ran the project Bit in the 90s.

It has now factioned into three projects:


Saint I T - Fair Source philosophy for the Unix/Irix derivative We X.

https://www.youtube.com/@Saint_I_T


Bit of Rahman - My personal project, if you wonder about the worship of 
The Deity, maybe you should try Rahman.

https://www.youtube.com/@Bit_T_V


Vadd Psy - I qualify as both Rabbi and Imam, and Psychologist is based 
on these. This is the psychiatric part of the project. This is also a 
suggestion for AI Archetype Correlation.

https://www.youtube.com/@Lyra_Analysis

Serenity,
Ywe Cærlyn.

