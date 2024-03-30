Return-Path: <linux-kernel+bounces-125751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A016892BA3
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 15:59:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3EC9D282CA2
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 14:59:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36D0238389;
	Sat, 30 Mar 2024 14:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="iAh+n0oQ"
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C745137714;
	Sat, 30 Mar 2024 14:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711810768; cv=none; b=hr6ZVuT1mPRz6gQKoxXHnZdRsMtQmTEkYIKYrAVpNFqp+vEDiW/84rYmUOPk+McH82MGs6gJYBSrCPnr3nQ4UxuczHPGMYp6y1AczUB8rljxzTp+D5KITbBgGm4hS9KD7AHtJQnO0MDKdw5shfvSnbjooilxQ4e5dEDN0T20KAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711810768; c=relaxed/simple;
	bh=rZ8tdPh1C+hRTf8PLer5uxXElPXls2N8CqlXiFribAc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i/yOWNo99Y8phvLoG13KqSPAG1kIz5nPGvS6aOzc50w0FgDqqWc90y5LhF1k6pCfur87YDZW3P9LshAU0F3jhY03nIar9b+NWPwyG9d8MF2ghQqrtyybHs8z6gOx/VPUteOMqpsRIVlbjfF7AcATDGCWPBm68q59mSHmIGTswfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=iAh+n0oQ; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:Reply-To:MIME-Version:Date:
	Message-ID:From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	In-Reply-To:References; bh=ZkD5ajmB6EjozrfKJAzN2VG60x9g0fXxfM+nKI7AEdo=;
	t=1711810765; x=1712242765; b=iAh+n0oQcXBg7bwAUUS/CsjAaMIrT3XpLCgS+D1Pxiqsk9W
	8brHSJjjf7ETVnAPwqxb1daxFaAY1R6fmJZtcxFwILzFuSFKv+sY6qR7X36zitq2ZuO23auRWDpCk
	RnmtR9Iyl/G6PZvm37+M1bwxZRp7t191z52k+eoXm74Tr9gGwmM6oM7mY5HuHRqFsjoxft6HIwXll
	ryng6/qv26fua9Ad3ryI4dGNEwmznYQE/TYHDwQQ44AM7Qnje6NCkI5OogQGJwGrkGSpL/s7GrrBN
	+XUi+A4xXmkHDOu25m6QVa0nwku24MzIra49BUGppBkqDpz2bIQ+aLrkjpS/Nmtw==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1rqaB0-0001NX-O7; Sat, 30 Mar 2024 15:59:22 +0100
Message-ID: <bf267566-c18c-4ad9-9263-8642ecfdef1f@leemhuis.info>
Date: Sat, 30 Mar 2024 15:59:22 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
Subject: Bluetooth broken for some people with 6.8.2 [Was: [PATCH 6.8 308/715]
 Bluetooth: hci_core: Cancel request on command timeout]
To: Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>
Cc: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Linux kernel regressions list <regressions@lists.linux.dev>
References: <20240324223455.1342824-1-sashal@kernel.org>
 <20240324223455.1342824-309-sashal@kernel.org>
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Content-Language: en-US, de-DE
In-Reply-To: <20240324223455.1342824-309-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1711810765;f882f0bc;
X-HE-SMSGID: 1rqaB0-0001NX-O7

On 24.03.24 23:28, Sasha Levin wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> [ Upstream commit 63298d6e752fc0ec7f5093860af8bc9f047b30c8 ]
> 
> If command has timed out call __hci_cmd_sync_cancel to notify the
> hci_req since it will inevitably cause a timeout.
> 
> This also rework the code around __hci_cmd_sync_cancel since it was
> wrongly assuming it needs to cancel timer as well, but sometimes the
> timers have not been started or in fact they already had timed out in
> which case they don't need to be cancel yet again.
> 
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> Stable-dep-of: 2615fd9a7c25 ("Bluetooth: hci_sync: Fix overwriting request callback")
> Signed-off-by: Sasha Levin <sashal@kernel.org>

Hey stable team, I wonder if it might be wise to pick up 1c3366abdbe884
("Bluetooth: hci_sync: Fix not checking error on
hci_cmd_sync_cancel_sync") from next
(https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=1c3366abdbe884)
for the next releases of all series that a few days ago received
63298d6e752fc0 ("Bluetooth: hci_core: Cancel request on command timeout").

The latter patch sadly on quite a few systems causes a Oops due to a
NULL pointer dereference and breaks Bluetooth. This was reported for
mainline here (yes, coincidentally it was reported by yours truly):
https://lore.kernel.org/all/08275279-7462-4f4a-a0ee-8aa015f829bc@leemhuis.info/

Now that the patch landed in 6.8.2 it seems to happen there as well
(guess in 6.7 and others, too), as can be seen from this bug report
where multiple people already joined:
https://bugzilla.kernel.org/show_bug.cgi?id=218651

The fix mentioned above is on the way to Linus, but due to unlucky
timing missed this weeks network pull, hence will likely only reach
mainline next Thursday. But the fix afaics has a stable commit id, so
might be worth picking up soon for the stable releases to fix the
regression quickly.

Ciao, Thorsten

