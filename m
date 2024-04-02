Return-Path: <linux-kernel+bounces-127457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AE1F894BA4
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 08:42:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E274F1F23089
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 06:42:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 682D236AEF;
	Tue,  2 Apr 2024 06:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="gOEBAKo+"
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E0B12C683;
	Tue,  2 Apr 2024 06:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712040157; cv=none; b=jTo2fDk2hplyxq9ISDlpnLOS9yCeXn1BqUUTyyaYotmXToLMMB8e0+vamBrWpmr80Hw39Qqzlw5WoNhrnTXpwLbMPuHXqqwq3ON/XbtsyKkbVGSbw25C//gsUMUHgBEkHM+DaAkLUsXLonBksFAU1vesaOrs+thyfGGKATWgVm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712040157; c=relaxed/simple;
	bh=4Ciphw3v/0eaq2NINfS6PY2B58XLCzpIwHinJUIINd4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uaOGeI6Bb1+BQuaK07Wa15opDUhFoI0T2zeB5slgUNtWW1ibqEJpBQaxmf4J/hoQaFKRoNpU21eYfe6fSAvZfINwDzZVAl3HqfMLNeiSMCmmbGSzCge+mzXOpPo6VgEXfRrAuX99twJrl+iFQc21wepCHx/d69VexyH41jYkaYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=gOEBAKo+; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	In-Reply-To:References; bh=4Ciphw3v/0eaq2NINfS6PY2B58XLCzpIwHinJUIINd4=;
	t=1712040155; x=1712472155; b=gOEBAKo+PX3TPbICgSuNXG864kAMpFsdxyqFZqZvw5LkgC/
	cFDa2lRpy8k/xMaKM5r/STAQ96vuRnmDzFQV2nDYPuXiwsGBAHlHYXjYw8uHVGin96LBuBb0Ec2/u
	LEfLq+IZQ+Z1j0fNSIJBH2P5Lkfi3j5dB/yKrQAwDwbsuYMM819jQSlcg/wMajyT6phc0C9i/3XYH
	yj+GA/CuNFlckV0bDKh9vsXv3pK1wXxXlxKg2s7aT/1iBjO3s5ljNE+13oM9tc5QZ2vDmW9M4yxSJ
	9g0+a7O4p9biDsTOaUwqGiB9hlpsw8YGZSoAMYG8j3AKsD8bOi7XTkzryMRrOmpg==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1rrXqq-0006Mx-BC; Tue, 02 Apr 2024 08:42:32 +0200
Message-ID: <84da1f26-0457-451c-b4fd-128cb9bd860d@leemhuis.info>
Date: Tue, 2 Apr 2024 08:42:31 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Bluetooth broken for some people with 6.8.2 [Was: [PATCH 6.8
 308/715] Bluetooth: hci_core: Cancel request on command timeout]
To: Greg KH <gregkh@linuxfoundation.org>, Sasha Levin <sashal@kernel.org>,
 Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Jakub Kicinski <kuba@kernel.org>,
 Linux regressions mailing list <regressions@lists.linux.dev>
References: <20240324223455.1342824-1-sashal@kernel.org>
 <20240324223455.1342824-309-sashal@kernel.org>
 <bf267566-c18c-4ad9-9263-8642ecfdef1f@leemhuis.info>
 <2024033018-speller-supremacy-5436@gregkh>
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Content-Language: en-US, de-DE
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <2024033018-speller-supremacy-5436@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1712040155;5860bd99;
X-HE-SMSGID: 1rrXqq-0006Mx-BC

On 30.03.24 17:23, Greg KH wrote:
> On Sat, Mar 30, 2024 at 03:59:22PM +0100, Linux regression tracking (Thorsten Leemhuis) wrote:
>> On 24.03.24 23:28, Sasha Levin wrote:
>>> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>>>
>>> [ Upstream commit 63298d6e752fc0ec7f5093860af8bc9f047b30c8 ]
>>>
>>> If command has timed out call __hci_cmd_sync_cancel to notify the
>>> hci_req since it will inevitably cause a timeout.
> [...]
>>> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>>> Stable-dep-of: 2615fd9a7c25 ("Bluetooth: hci_sync: Fix overwriting request callback")
>>> Signed-off-by: Sasha Levin <sashal@kernel.org>
>>
>> Hey stable team, I wonder if it might be wise to pick up 1c3366abdbe884
>> ("Bluetooth: hci_sync: Fix not checking error on hci_cmd_sync_cancel_sync") from next
>> (https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=1c3366abdbe884)
>> for the next releases of all series that a few days ago received
>> 63298d6e752fc0 ("Bluetooth: hci_core: Cancel request on command timeout").
>>
>> The latter patch sadly on quite a few systems causes a Oops due to a
>> NULL pointer dereference and breaks Bluetooth. This was reported for
>> mainline here (yes, coincidentally it was reported by yours truly):
>> https://lore.kernel.org/all/08275279-7462-4f4a-a0ee-8aa015f829bc@leemhuis.info/
>>
>> Now that the patch landed in 6.8.2 it seems to happen there as well
>> (guess in 6.7 and others, too), as can be seen from this bug report
>> where multiple people already joined:
>> https://bugzilla.kernel.org/show_bug.cgi?id=218651
> [...]
> Now queued up, thanks for letting us know.

FWIW, at least one user reported additional BT problems in bugzilla that
might or might not be related to the backports. But I write for a
different reason:

Luiz replied in bugzilla
(https://bugzilla.kernel.org/show_bug.cgi?id=218651#c20) and you might
want to know about it:

"'"
Hmm, was the original change [63298d6e752fc0 ("Bluetooth: hci_core:
Cancel request on command timeout")] backported to stable kernels, afaik
I didn't mark it to Cc stable: [...]

I wonder why it got selected to be backported, in any case I don't think
it is a good idea to attempt to do backporting without having at least a
Fixes tag to begin with otherwise we risk having problems like this
widespread to people not really running the latest where this sort of
problem is sort of expected during the early rc phase, so instead of
having these 2 patches backported we could just remove the above from
the stable trees.
"'"

Luiz: Sasha and Greg can speak for themselves, but the "Stable-dep-of:
2615fd9a7c25 ("Bluetooth: hci_sync: Fix overwriting request callback")"
tag above is a strong indicator why 63298d6e752fc0 was backported.

Ciao, Thorsten (who now hopes the developers sort this out without him
as accidentally man-in-the-middle)

