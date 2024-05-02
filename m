Return-Path: <linux-kernel+bounces-166660-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BD4D18B9DB7
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 17:46:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 25189B21795
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 15:46:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AF5815B56C;
	Thu,  2 May 2024 15:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="UdrzkB1A"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43E6815B552;
	Thu,  2 May 2024 15:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714664765; cv=none; b=eTkinY2pamSMxmhSXcktPjNTiOEwA7DMNAGFdkRS58pQZWNTLP9jQxmpTTXUNjiZrjK7v7e+aVWOdUHF3KTk0XDW6BUPE6+wpAPvEmT55gOWTughrRtr95lCmUPNpq90jq1LTVClErLyY7zFuwb6iYPSwN+xQ4YIHMKqaaRe4Lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714664765; c=relaxed/simple;
	bh=ke5fV4sGRwndayA7Ai35n4IndDXJW3aZT4TXL/Tq40E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ilVMCOXOLXz959ORx2xcHS4R/I6k7dT10ALyj5A/mCzrL57tI3hRmnuHbDYGgPb47Gjagy/pYOfQls3wAN3XHhw2TjhhCKssf8jMfyH69InO3kKIbA8b0CV0bm4TxDlR1L7SMu2eUX1HiIuxGdSAOJnHHATfYSaklmQoUP69obI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=UdrzkB1A; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 616AB47C39
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1714664761; bh=ousXZmiImu7YU7q0/as6YIRuE8ckEwwhEQWCYCHx7eU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=UdrzkB1A2m8ezcEzlyMFxGByPirJ58/ZO3aC3ejiH6m9yyVvc9r1AH4axJLj4r5CF
	 f+w44Bg7lL6n5Zdv4cYVupy7LcuCvpyvQ/7TWP6Yhwd7vne+6ZhJaS16yGsBdYsds9
	 2VEW2w3/MbEIOUVFwUrGNARQm3HeG49ymsVWfJOgUf45zr5ygDo9QVlKI8otd4/aG6
	 d1eUXqy4lXAcgLmz7f+hnx/WK3hqaq9e7anwfwfGQk5kg7A7OebRnbN1bUDt+Ng/5X
	 COH1Vj3CSVkyRyqoXO21kxqjN4HJZBE4/akI5I0KpLoMZqymFUExVWynBM8rbrXoAN
	 UwttCRC3HCRDw==
Received: from localhost (unknown [IPv6:2601:280:5e00:625::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 616AB47C39;
	Thu,  2 May 2024 15:46:01 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Federico Vaga <federico.vaga@vaga.pv.it>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] doc:it_IT: align Italian documentation
In-Reply-To: <f63524e3bc9d110c96255f27580c680d@vaga.pv.it>
References: <20240316225400.22590-1-federico.vaga@vaga.pv.it>
 <f63524e3bc9d110c96255f27580c680d@vaga.pv.it>
Date: Thu, 02 May 2024 09:46:00 -0600
Message-ID: <87a5l88bev.fsf@meer.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Federico Vaga <federico.vaga@vaga.pv.it> writes:

> Hello Jonathan,
>
> I'm pinging you on this patch, just in case it got somehow lost.

It did indeed fall through the cracks, not quite sure how.  Applied now,
thanks.

jon

