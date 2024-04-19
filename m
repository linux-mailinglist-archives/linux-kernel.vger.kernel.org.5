Return-Path: <linux-kernel+bounces-151990-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 13F158AB711
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 00:06:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7B261F224A7
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 22:06:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6B0B13D276;
	Fri, 19 Apr 2024 22:06:23 +0000 (UTC)
Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B822112DD97
	for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 22:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713564383; cv=none; b=Pj8mb23ct2M9XwbtG1aXRDFkoc62hRCIe0NQSd3W2Kfg18viS0p3TS0oOm5WBMDNOySLZmYhOMKcvQqttd3KeMpBtlMjNoW3jpRLjuDadoAPaeLpGU4u+MKY5xeYoNXGthbyQRTcAK+jMK3GCbSW1Pz64LPGTMAT3kziziQ3pGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713564383; c=relaxed/simple;
	bh=bIxAvRq6L2zzjIpRx7OKVnLi7wh8LjrLZgLH8vgFTaw=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=mJqkvjDHAfmFOfTExpV/vC84Yod9pr1/+ZCN0Zv8rpqQx+fYAQA8DDYWugpoZiAXnwA0NiMWShCPN6JdgRb65I+odxnBRi+ewR2ZOgXzrsSEChBA3FdVe106Xg0CRA+JrdNpdoolmw6RVjsA8+/VH3u7Y3ZAZQ/5vBRIB5DK23A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com; spf=pass smtp.mailfrom=perches.com; arc=none smtp.client-ip=216.40.44.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=perches.com
Received: from omf02.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay05.hostedemail.com (Postfix) with ESMTP id 12403402D3;
	Fri, 19 Apr 2024 22:06:13 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf02.hostedemail.com (Postfix) with ESMTPA id 8FA018000E;
	Fri, 19 Apr 2024 22:06:11 +0000 (UTC)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 19 Apr 2024 15:06:11 -0700
From: Joe Perches <joe@perches.com>
To: Nam Cao <namcao@linutronix.de>
Cc: apw@canonical.com, dwaipayanray1@gmail.com, lukas.bulwahn@gmail.com,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] checkpatch: add "Reported-and-tested-by:" tag
In-Reply-To: <20240419191957.42396-1-namcao@linutronix.de>
References: <20240419191957.42396-1-namcao@linutronix.de>
Message-ID: <a8094ffbabd308752cb02cd1c1d5b67c@perches.com>
X-Sender: joe@perches.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 8FA018000E
X-Rspamd-Server: rspamout08
X-Stat-Signature: 4h1jzcch15oxde4gtxjctqzeis6jwom3
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1/V99VF3JUryd/wDD311w/E4pPjNqFfcv0=
X-HE-Tag: 1713564371-530570
X-HE-Meta: U2FsdGVkX1+wVXJq/h+He4mGv143z+UE3fbEaWqNK/PXgyCAgaeI242w2CxfjPOREbFmi4dMBImk8IpLm6FfhBzkdgdZ4mgv5pvHJrrCglWNvU3kT7ixQv+O8wBsBJCyXGKPtEOBkv6cDOnqVuo2eOLSFrWbeV4czMURwghJ5yIP4k2H09T/bgSGxQCD1plTwNiTUsTOPwa4JfSD4wwy+bmbwYWtcXBN2BliLTjir32qWXzk6RZ5X28tNu0rErXYjZTsvEhViCpbkoNrNhjXyQ==

On 2024-04-19 12:19, Nam Cao wrote:
> The tag "Reported-and-tested-by:" is used all the time. Add this tag.
> 
> Signed-off-by: Nam Cao <namcao@linutronix.de>
> ---
>  scripts/checkpatch.pl | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 9c4c4a61bc83..ff44720fcf23 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -618,6 +618,7 @@ our $signature_tags = qr{(?xi:
>  	Tested-by:|
>  	Reviewed-by:|
>  	Reported-by:|
> +	Reported-and-tested-by:|
>  	Suggested-by:|
>  	To:|
>  	Cc:
> @@ -712,7 +713,7 @@ sub find_standard_signature {
>  	my ($sign_off) = @_;
>  	my @standard_signature_tags = (
>  		'Signed-off-by:', 'Co-developed-by:', 'Acked-by:', 'Tested-by:',
> -		'Reviewed-by:', 'Reported-by:', 'Suggested-by:'
> +		'Reviewed-by:', 'Reported-by:', 'Suggested-by:', 
> 'Reported-and-tested-by'

Missing a colon
>  	);
>  	foreach my $signature (@standard_signature_tags) {
>  		return $signature if (get_edit_distance($sign_off, $signature) <= 
> 2);

