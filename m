Return-Path: <linux-kernel+bounces-84130-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E540086A28A
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 23:33:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA2501C24E57
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 22:33:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0FDF5576C;
	Tue, 27 Feb 2024 22:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KieL0+o7"
Received: from fhigh4-smtp.messagingengine.com (fhigh4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8A4B1DFEB
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 22:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709073216; cv=none; b=e5Jhs+em0ljF+W2aCrxl73bQnQDOncbWXuwJOLEKGiIMji+FQHhh/+mRm/qyRAgNLQUHRlJ6AZW/b6iPad0b8jWwfXatwlcMzJpRfoDUicmvJdmEYWdxuHSjPmgbe6SmhSQEugZrc4BGe72ZjKIxhuhV5JqYmyOCK2YT2PYMa6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709073216; c=relaxed/simple;
	bh=nnwG3mRvKkA3Pi3upJQXACW/sjaCvLb+WV1MsFlMvkY=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=U/UcTQ+doDn70egvsTRjdY3bxCdGIZP+RbcCm3E9qYb1QryltGDV+05CY85lDIqHbeaxteNhlI04pkA7u8uw7VIzxF0hdsamEw6HruHrQGbr4hn0dZAwpbAprUncoCYRkcM+Sf+hWAYz2rJbILmS6oWk95Ry6v6AvULpPBmsBJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KieL0+o7; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id AEEBD114010D;
	Tue, 27 Feb 2024 17:33:32 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Tue, 27 Feb 2024 17:33:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1709073212; x=1709159612; bh=QsDDfsPXgEVmr4MGVJnIEfhbulQo
	q9yDKGrErTDLAIM=; b=KieL0+o7n5DsCaKjl8aibg30zK4RjuagX4QplQSJGSb2
	d5tuvhnt+PVIMxhVyU1KNjWSJtp9JR+kzKS5gpyIbzx9zlIU9gFsWbj758XPbu72
	4HdeGfTC/AMyvGETBZLMv4jJNuEVSBnel56eajM1Dds81BzkPMF1ScRMe62Z7jJU
	KTkjT/yF0ZZEujW/X1AlksfP4aW5MYIrGHqyDEPUHkCi/CrgGdohSz2Avj1fx99L
	JlbYtwCjn1J7YBefJBUTkw90HdJsMaTO9vk9588LXOSqk6daMyl0iF04dihN4yic
	sdx8v0x1bvY3OHLZRLDBN/kZvtCJnKxv9IJsrP5xoA==
X-ME-Sender: <xms:PGPeZVvjxPLX5kGvp3tTCeCfm1ICQ2nbffEJOd6xfBF4BGtrj7SlxQ>
    <xme:PGPeZeer8gtYDg58NiBpSbztH-MxSKVJS7-sqWyqLTs06QFdzgeyzDof9Tpu5b1-a
    bRALBCw9IgZOWD3q0c>
X-ME-Received: <xmr:PGPeZYwTGd86dguhoVt0-WyJZeVDdHHiEqYs9G987svuoRNV3lJEu9C_TkLnv0n0MRAdYCY3SbcbitLEeLV8EJ_jdqL4sNj79aA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrgeehgddufeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevufgjkfhfgggtsehttdertddttddvnecuhfhrohhmpefhihhnnhcu
    vfhhrghinhcuoehfthhhrghinheslhhinhhugidqmheikehkrdhorhhgqeenucggtffrrg
    htthgvrhhnpeelueehleehkefgueevtdevteejkefhffekfeffffdtgfejveekgeefvdeu
    heeuleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hfthhhrghinheslhhinhhugidqmheikehkrdhorhhg
X-ME-Proxy: <xmx:PGPeZcOGMDfOjW-0SXxZqZO-rudBIeNjzAVoCO0snP0nJUIky9CiGA>
    <xmx:PGPeZV9XxKrn8UtzEiVeFtmBf9-KL2FU9ioUWiq3RCeeiBwc1us_og>
    <xmx:PGPeZcUpk4oECEtoqs5_ew2Ib8gYmeGuZL6C7xzwukrbLKFMSQ5VtQ>
    <xmx:PGPeZRbtUNKuazoeJKmB0RaSYPDD-g-qMtjiN4SXnMeGmZtjTUXv8g>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 27 Feb 2024 17:33:29 -0500 (EST)
Date: Wed, 28 Feb 2024 09:33:44 +1100 (AEDT)
From: Finn Thain <fthain@linux-m68k.org>
To: Kees Cook <keescook@chromium.org>
cc: Geert Uytterhoeven <geert@linux-m68k.org>, 
    Guenter Roeck <linux@roeck-us.net>, linux-m68k@lists.linux-m68k.org, 
    linux-kernel@vger.kernel.org
Subject: Re: stackinit unit test failures on m68k
In-Reply-To: <202402271401.CB43AB2E8@keescook>
Message-ID: <1278e7aa-135b-0919-340a-788b9be6b5da@linux-m68k.org>
References: <a0d10d50-2720-4ecd-a2c6-c2c5e5aeee65@roeck-us.net> <CAMuHMdXMsxRRMV8g6+9vTy_4o8HF49SUh2deNdFjgKwDLEWrxQ@mail.gmail.com> <202402271401.CB43AB2E8@keescook>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII


On Tue, 27 Feb 2024, Kees Cook wrote:

> 
> I'll send a patch!
> 

Or you could just not run the test on m68k. It's said that, "What the eye 
does not see, the heart does not grieve over." Is that not true for bugs?

