Return-Path: <linux-kernel+bounces-1297-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 23581814D0C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 17:30:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF5EC2871F2
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 16:30:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A55763DB93;
	Fri, 15 Dec 2023 16:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="e9/7rq6F"
X-Original-To: linux-kernel@vger.kernel.org
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A1BB3C48A;
	Fri, 15 Dec 2023 16:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
Received: from localhost (unknown [IPv6:2601:280:5e00:7e19::646])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 5EC5F2ED;
	Fri, 15 Dec 2023 16:30:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 5EC5F2ED
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1702657806; bh=OQVXZTeba2LNUlZHGrTPJnHYEPWu6rsuCl/p8uGfzuw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=e9/7rq6Fm9mKEEQz8Fkevxn3Pz1BvrxaRsrHQ8rtPLb6GWEcGgLaYz8kD+UBD1PDK
	 7zD4H7yjDONwohGzkqRFLmrq78/yPlsV3kure7xr1vXBaYiNayL6+fha3K3PgzUU7r
	 n/RM/hvr+GiB8S49NVUV/udwkJEJR0YiBYZ+ymFphW/FZGCJvd4aJB6udlGHY29QST
	 uAH0UXLf81TAWLrkhBOzQVjveCg3kL2diaSRK27nDDVllW5ZW8dlD2sGl8x6h7VggW
	 J7Xm0qXumPGgrtA1o5JxqVFTB8wOOtBHonExeR3QVOTUYGREbmJGXpTpdXWH7e4vmc
	 X2iXNUCVriO5g==
From: Jonathan Corbet <corbet@lwn.net>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Tim Chen
 <tim.c.chen@linux.intel.com>, "Kirill A. Shutemov"
 <kirill.shutemov@linux.intel.com>, Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH v2] Documentation, mm/unaccepted: document accept_memory
 kernel parameter
In-Reply-To: <20231214-accept_memory_param-v2-1-f38cd20a0247@suse.cz>
References: <20231214-accept_memory_param-v2-1-f38cd20a0247@suse.cz>
Date: Fri, 15 Dec 2023 09:30:05 -0700
Message-ID: <871qbnqvhu.fsf@meer.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Vlastimil Babka <vbabka@suse.cz> writes:

> The accept_memory kernel parameter was added in commit dcdfdd40fa82
> ("mm: Add support for unaccepted memory") but not listed in the
> kernel-parameters doc. Add it there.
>
> Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> ---
> changes since v1:
> - use shorter sentences (Tim Chen)
> ---
>  Documentation/admin-guide/kernel-parameters.txt | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 65731b060e3f..91bd74b2e203 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -1,3 +1,14 @@
> +	accept_memory=  [MM]
> +			Format: { eager | lazy }
> +			default: lazy
> +			By default, unaccepted memory is accepted lazily to
> +			avoid prolonged boot times. The lazy option will add
> +			some runtime overhead until all memory is eventually
> +			accepted. In most cases the overhead is negligible.
> +			For some workloads or for debugging purposes
> +			accept_memory=eager can be used to accept all memory
> +			at once during boot.
> +

Applied, thanks.

jon

