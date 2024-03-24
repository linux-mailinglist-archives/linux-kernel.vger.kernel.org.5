Return-Path: <linux-kernel+bounces-112528-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4617B887B35
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 01:37:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30E6F282321
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 00:37:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FDB181E;
	Sun, 24 Mar 2024 00:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VeOUJf54"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EF87399;
	Sun, 24 Mar 2024 00:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711240647; cv=none; b=Ix8UYpmeMSNS+LM1657M4cN6N9sNfD/PAahOG96WYyiic6aS4S1Kqa+knpwH+kqaOJp+yxGeOB8rEwKeHbo+K0TuxOwkorqULDxDaTmpe3KfxfSHZhGRZFOe86Znr0+PcV+ITTtRmPSk2DUXcvKhDnFADNQWybVEd5pJNwWtUEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711240647; c=relaxed/simple;
	bh=cIzNabmO/wIIEk6PzjySaf+efj9NqcfRU1AKQDQVcy0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=skdDvowSefeYXv/9FgDFTe9wpdnzQis/bk/b/gYBFn98EZfpGkXFwutm2tfREcRN4yTU5npm9TC0FS8XYtDKLurkxhjF4m+sJskU26sPeFF/h3nOR/hdjrQzVWWhHbG0BJNpYOwLWOdEWkKuob5Jm+ff01KiOhe79myW5gjgHt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=VeOUJf54; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=epiAq/uhOjFytLKsUkArgR/82Gp4Db9hW2gITSregD0=; b=VeOUJf540a8tuf9Bll54X21YBu
	/LJxaqcMokzI3nuUQ6MwR4o3c7FF9Vyrp++qtlTxSbYPxVZ/QbIvrn+Hq5SEeGBpivbNju5lJrvkN
	DIUIPUuZE7xjeq/YeLadaAkEOebhf8ZZj7gdX2sR7dqx45vFY8DomYUxUCf8sYUdiN28qKLxVZiow
	xDapCMQa2Jvr3UjJWODDgDXaJHezMVOwJCdNlonBQeX+FMMagvEc4c4n9PuT9R5qqYhWU0NatRrW1
	tPJqraJCrpvB1DjAJQ6ZVOTaRhuT9u2BYBwGQwbYyi0sklHkxsKa7NBSzkNZONfgTsqfQnh1L+Fhq
	eMuLGT5Q==;
Received: from [50.53.2.121] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1roBrY-0000000BTiB-1PUq;
	Sun, 24 Mar 2024 00:37:24 +0000
Message-ID: <40c96057-4bd8-4743-bea1-5d848f0e0c84@infradead.org>
Date: Sat, 23 Mar 2024 17:37:21 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] arch/riscv: Enable kprobes when CONFIG_MODULES=n
Content-Language: en-US
To: Jarkko Sakkinen <jarkko@kernel.org>, linux-riscv@lists.infradead.org
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 linux-kernel@vger.kernel.org, "Naveen N . Rao" <naveen.n.rao@linux.ibm.com>,
 Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
 "David S . Miller" <davem@davemloft.net>,
 Masami Hiramatsu <mhiramat@kernel.org>, linux-trace-kernel@vger.kernel.org
References: <20240323232908.13261-1-jarkko@kernel.org>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20240323232908.13261-1-jarkko@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/23/24 16:29, Jarkko Sakkinen wrote:
> +config HAVE_KPROBES_ALLOC
> +	bool
> +	help
> +	  Architectures that select this option are capable of allocating memory
> +	  for kprobes withou the kernel module allocator.

	              without

-- 
#Randy

