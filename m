Return-Path: <linux-kernel+bounces-34726-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 846178386C9
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 06:35:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39BB11F25750
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 05:35:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33AA453A2;
	Tue, 23 Jan 2024 05:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bQAp8pd4"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 372DE5384;
	Tue, 23 Jan 2024 05:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705988126; cv=none; b=uVnpIwNxeLOHUGLuXe5VXtM+XOzgTAoe4yhOfOy0cXlHsvRzuqXelmlg7RTITgqOxUL7DRRlzXy0h4TvBb7rglkETsIoKrvJwV0krfiExLLnjcf1Zh138Wur8/aJDLSmDT/AA9RVNNSlzLX+UahevtBO+qshRqSbqThzHLPQ0Ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705988126; c=relaxed/simple;
	bh=G0i8ABk8bIFhc72+G43lLFfaXDQOIFl3RDw12t8PJLA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fGyEyWnGRoJoVgOja0b2X+He/4I/bzCKgh6ZOunMdPZH3pki5na5jWWV6rNSf1B1hL1E5skF79e7UYNw3qOob9BuMLVlnOfaZGWZ1Fumm+fKKy3p2eimNYOhjZ/brIjkw7nlLE21ut8Xp/PL5BY2TpfjyJKaouJ8n25R9yK6orQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=bQAp8pd4; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=cG4TekG4FZrxDIG08XX8xVoJMlnXJe2uSPlfvgRslZE=; b=bQAp8pd4TqcIonLOvSIUc9Ako+
	Xm18nUIMJHXS576f/IfzAjW4Jk44JgE+582jMNqhjAuaD0HLJ2TQQEXmM3Bipn9UejRJMHFHCIj+6
	5Ixoh4Hoe3FlTaYfxVcySuW1OG9RMZ40t6iam9B1H7MnDTuDs01WCOJlYC1DKgLGixd3FF6aT6szm
	7j0IcaIIPr12BDpuyNLp+udSJ39zmDwRkUgVpDnT5jMlUdqYZ+xjuPI0/d83O9BbKRYydDU26M0XS
	t2buAzL5p7pQwPstNCFMfb+Mi4FE8RS9cCZoDJWDPDBgCCWmNVyHwEnnIiii+dyhwsqlsQWGrRV6h
	hplxRfdg==;
Received: from [50.53.50.0] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rS9RU-00FA8p-2G;
	Tue, 23 Jan 2024 05:35:24 +0000
Message-ID: <1c3d8e15-f6e2-475e-8884-e5e42ce57eb1@infradead.org>
Date: Mon, 22 Jan 2024 21:35:24 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] soc: qcom: smp2p: fix all kernel-doc warnings
Content-Language: en-US
To: linux-kernel@vger.kernel.org
Cc: Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>, linux-arm-msm@vger.kernel.org,
 Jeff Johnson <quic_jjohnson@quicinc.com>
References: <20240123053329.12893-1-rdunlap@infradead.org>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20240123053329.12893-1-rdunlap@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/22/24 21:33, Randy Dunlap wrote:
> Use the documented notation for nested struct members.
> Add a Return: comment for qcom_smp2p_intr().
> 
> These changes prevent these kernel-doc warnings:
> 

Sorry about the duplicate v2 emails.
pebkac :(

-- 
#Randy

