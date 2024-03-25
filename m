Return-Path: <linux-kernel+bounces-115269-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 82A6C889C08
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 12:09:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3F501C32E58
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:09:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6F8D142916;
	Mon, 25 Mar 2024 02:11:46 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B61A32FF8DD;
	Mon, 25 Mar 2024 01:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711328682; cv=none; b=bwaRGmmNkj+gLRpCuM8gyJi9/+RNoxXjhtNOcWhS/Z6u3JT2Lwoia5Vxgy8OlX9zCGvy9vHRnAoFzJItFxeAtNJZwaXd387SIpT4KlcuxUHoaTnCaZU2Rh2PeutRp+q0zVNId0H8ERX+XkW926cqFXW7I5Q3FfLO/e0ytGvimms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711328682; c=relaxed/simple;
	bh=T8yTxU4Eui1MfMeCTFM2FN2owUwRQgjJfS547SQLQKo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P0lyDLWrpJwrNnUupLv3vMdJf0k6UcLOYgX4uD7jma1PZzLHnfqV1KP0O5KCRqJd+Yf4rIuyCWT22Pqt++QtxkNK0UkgVbyJUkCNXWZERlSyHP0oGVVyhRM/AMW82faPsqHxCPFDNWQif9iWt+Qz3LlnXh1KlOfgextgE/w9Fcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 89D5468B05; Mon, 25 Mar 2024 02:04:35 +0100 (CET)
Date: Mon, 25 Mar 2024 02:04:35 +0100
From: Christoph Hellwig <hch@lst.de>
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>, Song Liu <song@kernel.org>,
	Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 5.10 033/238] md: implement ->set_read_only to hook
 into BLKROSET processing
Message-ID: <20240325010435.GA23652@lst.de>
References: <20240324234027.1354210-1-sashal@kernel.org> <20240324234027.1354210-34-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240324234027.1354210-34-sashal@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

How did we end up backporting all these block layer API changes?


