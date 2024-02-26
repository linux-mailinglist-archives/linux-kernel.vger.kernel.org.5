Return-Path: <linux-kernel+bounces-81401-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 380AB8675DD
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 14:00:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 91268B2A7BF
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 12:45:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69AC87F7DE;
	Mon, 26 Feb 2024 12:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=infineon.com header.i=@infineon.com header.b="A+BOZT7K"
Received: from smtp2.infineon.com (smtp2.infineon.com [217.10.52.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4007A1D54B;
	Mon, 26 Feb 2024 12:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.10.52.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708951510; cv=none; b=l3ruT69LkFlUH88XUZo+8shGVcdimbnSOai1JAvrRPddJXxIMd1QTEktLrbU+mZbsnyUQrnLaBH7jlwNPrAnblW/NokPBnxvrFUDVEk5PrpalyC+SUrfLe/cQ5Px515YGhPL5nTqNM48WgtTerErzl07w9UtUah+4wK+kR2Nnxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708951510; c=relaxed/simple;
	bh=uopANXtSJT51k4uIm3FZj2qxgzsKx67DpU6Vep4VvQU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=n254ky+SS0yX9HR7ona3hZvArTcc2O2W7Ip4mUWcF863vZgeQOP6KyZ0U2XgpRX34k2uxskY4T6T9Qvzb0KLLpJg6k47Yjt4xtl1HiPUtruvY1bD+l8MTnPjeoUAbpsLDnss6qc7fuK/DzbPtSQGpI5RhmHIM3BGF1bzDO4tJtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infineon.com; spf=pass smtp.mailfrom=infineon.com; dkim=pass (1024-bit key) header.d=infineon.com header.i=@infineon.com header.b=A+BOZT7K; arc=none smtp.client-ip=217.10.52.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infineon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infineon.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
  t=1708951509; x=1740487509;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=uopANXtSJT51k4uIm3FZj2qxgzsKx67DpU6Vep4VvQU=;
  b=A+BOZT7KA3BZTWASeXZ5D2m8w64M+6DJk98LVJ/ywMFq2UP4H12ejBH6
   nKnXi1+PJ9LrQX+4Fe/1MaN1RcWauWCFro/OGjQ5Tchdre1zVH5J0bzbc
   IdjUlS7RDap4wzCamWWrLUb0cHu3vVg5EZSC7aLAk2LprAs1u07WlHzvi
   Q=;
X-IronPort-AV: E=McAfee;i="6600,9927,10995"; a="69010008"
X-IronPort-AV: E=Sophos;i="6.06,185,1705359600"; 
   d="scan'208";a="69010008"
Received: from unknown (HELO MUCSE814.infineon.com) ([172.23.29.40])
  by smtp2.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2024 13:43:57 +0100
Received: from KLUSE844.infineon.com (172.28.156.184) by MUCSE814.infineon.com
 (172.23.29.40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 26 Feb
 2024 13:43:56 +0100
Received: from [10.160.239.31] (10.160.239.31) by KLUSE844.infineon.com
 (172.28.156.184) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 26 Feb
 2024 13:43:56 +0100
Message-ID: <fd34e752-b6ce-4880-9ef5-4feda985bf42@infineon.com>
Date: Mon, 26 Feb 2024 13:43:55 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] tpm: protect against locality counter underflow
To: "Daniel P. Smith" <dpsmith@apertussolutions.com>, Lino Sanfilippo
	<l.sanfilippo@kunbus.com>, Jarkko Sakkinen <jarkko@kernel.org>, "Jason
 Gunthorpe" <jgg@ziepe.ca>, Sasha Levin <sashal@kernel.org>,
	<linux-integrity@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Ross Philipson <ross.philipson@oracle.com>, Kanth Ghatraju
	<kanth.ghatraju@oracle.com>, Peter Huewe <peterhuewe@gmx.de>
References: <20240131170824.6183-1-dpsmith@apertussolutions.com>
 <20240131170824.6183-2-dpsmith@apertussolutions.com>
 <CYU3CFW08DAA.29DJY7SJYPJJZ@suppilovahvero>
 <2ba9a96e-f93b-48e2-9ca0-48318af7f9b1@kunbus.com>
 <ae3fecc4-7b76-4607-8749-045e17941923@infineon.com>
 <f52546f1-acca-4915-924c-cdd2018215d5@apertussolutions.com>
From: Alexander Steffen <Alexander.Steffen@infineon.com>
In-Reply-To: <f52546f1-acca-4915-924c-cdd2018215d5@apertussolutions.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MUCSE822.infineon.com (172.23.29.53) To
 KLUSE844.infineon.com (172.28.156.184)

On 23.02.2024 02:55, Daniel P. Smith wrote:
> On 2/20/24 13:42, Alexander Steffen wrote:
>> On 02.02.2024 04:08, Lino Sanfilippo wrote:
>>> On 01.02.24 23:21, Jarkko Sakkinen wrote:
>>>
>>>>
>>>> On Wed Jan 31, 2024 at 7:08 PM EET, Daniel P. Smith wrote:
>>>>> Commit 933bfc5ad213 introduced the use of a locality counter to
>>>>> control when a
>>>>> locality request is allowed to be sent to the TPM. In the commit,
>>>>> the counter
>>>>> is indiscriminately decremented. Thus creating a situation for an
>>>>> integer
>>>>> underflow of the counter.
>>>>
>>>> What is the sequence of events that leads to this triggering the
>>>> underflow? This information should be represent in the commit message.
>>>>
>>>
>>> AFAIU this is:
>>>
>>> 1. We start with a locality_counter of 0 and then we call
>>> tpm_tis_request_locality()
>>> for the first time, but since a locality is (unexpectedly) already 
>>> active
>>> check_locality() and consequently __tpm_tis_request_locality() return
>>> "true".
>>
>> check_locality() returns true, but __tpm_tis_request_locality() returns
>> the requested locality. Currently, this is always 0, so the check for
>> !ret will always correctly indicate success and increment the
>> locality_count.
>>
>> But since theoretically a locality != 0 could be requested, the correct
>> fix would be to check for something like ret >= 0 or ret == l instead of
>> !ret. Then the counter will also be incremented correctly for localities
>> != 0, and no underflow will happen later on. Therefore, explicitly
>> checking for an underflow is unnecessary and hides the real problem.
>>
> 
> My apologies, but I will have to humbly disagree from a fundamental
> level here. If a state variable has bounds, then those bounds should be
> enforced when the variable is being manipulated.

That's fine, but that is not what your proposed fix does.

tpm_tis_request_locality and tpm_tis_relinquish_locality are meant to be 
called in pairs: for every (successful) call to tpm_tis_request_locality 
there *must* be a corresponding call to tpm_tis_relinquish_locality 
afterwards. Unfortunately, in C there is no language construct to 
enforce that (nothing like a Python context manager), so instead 
locality_count is used to count the number of successful calls to 
tpm_tis_request_locality, so that tpm_tis_relinquish_locality can wait 
to actually relinquish the locality until the last expected call has 
happened (you can think of that as a Python RLock, to stay with the 
Python analogies).

So if locality_count ever gets negative, that is certainly a bug 
somewhere. But your proposed fix hides this bug, by allowing 
tpm_tis_relinquish_locality to be called more often than 
tpm_tis_request_locality. You could have added something like 
BUG_ON(priv->locality_count == 0) before decrementing the counter. That 
would really enforce the bounds, without hiding the bug, and I would be 
fine with that.

Of course, that still leaves the actual bug to be fixed. In this case, 
there is no mismatch between the calls to tpm_tis_request_locality and 
tpm_tis_relinquish_locality. It is just (as I said before) that the 
counting of successful calls in tpm_tis_request_locality is broken for 
localities != 0, so that is what you need to fix.

> Assuming that every
> path leading to the variable manipulation code has ensured proper
> manipulation is just that, an assumption. When assumptions fail is how
> bugs and vulnerabilities occur.
> 
> To your point, does this full address the situation experienced, I would
> say it does not. IMHO, the situation is really a combination of both
> patch 1 and patch 2, but the request was to split the changes for
> individual discussion. We selected this one as being the fixes for two
> reasons. First, it blocks the underflow such that when the Secure Launch
> series opens Locality 2, it will get incremented at that time and the
> internal locality tracking state variables will end up with the correct
> values. Thus leading to the relinquish succeeding at kernel shutdown.
> Second, it provides a stronger defensive coding practice.
> 
> Another reason that this works as a fix is that the TPM specification
> requires the registers to be mirrored across all localities, regardless
> of the active locality. While all the request/relinquishes for Locality
> 0 sent by the early code do not succeed, obtaining the values via the
> Locality 0 registers are still guaranteed to be correct.
> 
> v/r,
> dps


