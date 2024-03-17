Return-Path: <linux-kernel+bounces-105593-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 71C5187E125
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 00:46:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 100931F21602
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 23:46:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3017C21A06;
	Sun, 17 Mar 2024 23:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rlB4L63U"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2B3B200C1;
	Sun, 17 Mar 2024 23:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710719169; cv=none; b=QzUONhs5GRT1mqjiMNTATVWZhojMBwJG54zVrzUNnp8rg54lfJDyJ1mv81zRyNMcUG6zk7WID7IFe52dtdcwirq0dBY6pATs2eOQQaSB7OQq0dfOQR/qmJTIx+KVjts1cMSi1EolybSJEcER0yw9JzgTe2fLb3rzyouWvRR00JA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710719169; c=relaxed/simple;
	bh=SVxblDoudq9PHcODUtk4BsvYy2oDwE0xdXlz9rX9rUA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I+vBK+9sB7YyKpAfq/0SpAE0eKK1BB/BCT1AOJGOGlzdX5thM5tb+UbhIxSyPGIxTAKaZrsRmZLwWlGzQ2KGwXQLBQeBlrVqmpe+DHbWRKu/jqCotqLS7q3xXBkhxpk4XSnIgdoeQ2uIrvXSzSr31KMqo3905Kae00lb9HNA4Tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=rlB4L63U; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=QFBf/caIb5p2jvUZxxDRK/HPlLy+K7oPE7bIqYNOvJA=; b=rlB4L63UKzcCgDPYscar4DzDRq
	33ACSaSQA3Ecv3uLUK18IEc86+wl6KAuqTZbGg7qbqeqLTlKnyXtJckiXDOuNEsSrXGLCSWIOwziH
	+AbJAZfaj5ZbWXzxUVnES49kxCBPZpD7vOXvsq7FQw2c3+HzVT55oxsObwZtReTmM02XahK4LPixN
	RKLo0ECxCxdBlWFxfO/fxXaGO+uV3lhL2wQDXBPm7wV3BxsAVYTT9YAO8m6beRV8ZLTp4wfohRIWa
	r3aQQhIa90XQnDeX4jCiJ7zIdrM1Bfd1/bxGzvhtVKi1LbZvIRYTXxWNaDcxhjSRYx45pG7unJu5X
	L43YeidA==;
Received: from [50.53.2.121] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rm0Cb-00000006m3N-3TlJ;
	Sun, 17 Mar 2024 23:46:06 +0000
Message-ID: <33c49440-8706-49e7-8bff-5df1cc828034@infradead.org>
Date: Sun, 17 Mar 2024 16:46:05 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] xfs: Fix typo in comment
Content-Language: en-US
To: Thorsten Blum <thorsten.blum@toblux.com>
Cc: Christoph Hellwig <hch@infradead.org>,
 Chandan Babu R <chandan.babu@oracle.com>, "Darrick J. Wong"
 <djwong@kernel.org>, linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240317154731.2801-2-thorsten.blum@toblux.com>
 <Zfdcrtk3b6UfgQRF@infradead.org>
 <40effb4e-9ea5-4102-a31f-43892e258b09@infradead.org>
 <F2971741-5EBB-481B-BA46-0536AC77F1F5@toblux.com>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <F2971741-5EBB-481B-BA46-0536AC77F1F5@toblux.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/17/24 16:34, Thorsten Blum wrote:
> On 17. Mar 2024, at 22:53, Randy Dunlap <rdunlap@infradead.org> wrote:
>>
>> Also s/straight away/straightaway/
> 
> Apparently, both are grammatically correct.

OK :)

-- 
#Randy

