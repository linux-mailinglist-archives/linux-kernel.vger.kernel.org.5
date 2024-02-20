Return-Path: <linux-kernel+bounces-73539-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2876485C3E2
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 19:46:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6C80282F22
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 18:46:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46C641339B5;
	Tue, 20 Feb 2024 18:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=infineon.com header.i=@infineon.com header.b="HhWKPaps"
Received: from smtp14.infineon.com (smtp14.infineon.com [217.10.52.160])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E41C7867A;
	Tue, 20 Feb 2024 18:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.10.52.160
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708454637; cv=none; b=c2fYJcfkCkzOYJeTMtFV7jNiyFU5GyVjAcqRPjvGSmBE4ECo3tPYCAKYqblvpM6IRMAD7P9HgDRPEG+rTa2wFABPkOA5HwGf0Hi3H5wAC6FCKr6UaEdsAqegwW040JQL/D2hMy2ps5e7ubT0sDlwDOaYtri3WaMXnB8ft6C4F0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708454637; c=relaxed/simple;
	bh=xDL0JSxjxG7/b+TV7BEy12asrlHmC93tIe/YLW8fv74=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=FjK+0yz0z5BVqPgY8BPn6rJzblVJSku4D+SNVNICKywpNR4/4oiF+IPTHiWREPXwkVPIE+RaOjJe+nqm5uOOxuuIdV2xu9yR/whln2tCdPDRfrx0auBhyESm1UvUFiBi0bJ4W/zXFGsHQQCSY/md8cp6i3QDTAL+35wslQnK+3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infineon.com; spf=pass smtp.mailfrom=infineon.com; dkim=pass (1024-bit key) header.d=infineon.com header.i=@infineon.com header.b=HhWKPaps; arc=none smtp.client-ip=217.10.52.160
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infineon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infineon.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
  t=1708454636; x=1739990636;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=xDL0JSxjxG7/b+TV7BEy12asrlHmC93tIe/YLW8fv74=;
  b=HhWKPaps02UAU72fmBijPP6Y6J+SmEBSDjeng2gYP0/fSCUIIZJWIEOF
   8TL9REbXhR6Qj/vA9UrWDWkqnAlAZaQ0lWSKeWENFqSG0osVJ7kxHVk9d
   08EklaP0FPZAoE/sfBiRpZK97tnsLJpMWE2UPid18FZ0Q6XyMztCbYTUG
   E=;
X-IronPort-AV: E=McAfee;i="6600,9927,10990"; a="43400251"
X-IronPort-AV: E=Sophos;i="6.06,174,1705359600"; 
   d="scan'208";a="43400251"
Received: from unknown (HELO MUCSE805.infineon.com) ([172.23.29.31])
  by smtp14.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2024 19:42:44 +0100
Received: from MUCSE844.infineon.com (172.23.7.73) by MUCSE805.infineon.com
 (172.23.29.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 20 Feb
 2024 19:42:43 +0100
Received: from [10.165.32.120] (10.165.32.120) by MUCSE844.infineon.com
 (172.23.7.73) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 20 Feb
 2024 19:42:43 +0100
Message-ID: <ae3fecc4-7b76-4607-8749-045e17941923@infineon.com>
Date: Tue, 20 Feb 2024 19:42:24 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] tpm: protect against locality counter underflow
To: Lino Sanfilippo <l.sanfilippo@kunbus.com>, Jarkko Sakkinen
	<jarkko@kernel.org>, "Daniel P. Smith" <dpsmith@apertussolutions.com>, "Jason
 Gunthorpe" <jgg@ziepe.ca>, Sasha Levin <sashal@kernel.org>,
	<linux-integrity@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Ross Philipson <ross.philipson@oracle.com>, Kanth Ghatraju
	<kanth.ghatraju@oracle.com>, Peter Huewe <peterhuewe@gmx.de>
References: <20240131170824.6183-1-dpsmith@apertussolutions.com>
 <20240131170824.6183-2-dpsmith@apertussolutions.com>
 <CYU3CFW08DAA.29DJY7SJYPJJZ@suppilovahvero>
 <2ba9a96e-f93b-48e2-9ca0-48318af7f9b1@kunbus.com>
From: Alexander Steffen <Alexander.Steffen@infineon.com>
In-Reply-To: <2ba9a96e-f93b-48e2-9ca0-48318af7f9b1@kunbus.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MUCSE820.infineon.com (172.23.29.46) To
 MUCSE844.infineon.com (172.23.7.73)

On 02.02.2024 04:08, Lino Sanfilippo wrote:
> On 01.02.24 23:21, Jarkko Sakkinen wrote:
> 
>>
>> On Wed Jan 31, 2024 at 7:08 PM EET, Daniel P. Smith wrote:
>>> Commit 933bfc5ad213 introduced the use of a locality counter to control when a
>>> locality request is allowed to be sent to the TPM. In the commit, the counter
>>> is indiscriminately decremented. Thus creating a situation for an integer
>>> underflow of the counter.
>>
>> What is the sequence of events that leads to this triggering the
>> underflow? This information should be represent in the commit message.
>>
> 
> AFAIU this is:
> 
> 1. We start with a locality_counter of 0 and then we call tpm_tis_request_locality()
> for the first time, but since a locality is (unexpectedly) already active
> check_locality() and consequently __tpm_tis_request_locality() return "true".

check_locality() returns true, but __tpm_tis_request_locality() returns 
the requested locality. Currently, this is always 0, so the check for 
!ret will always correctly indicate success and increment the 
locality_count.

But since theoretically a locality != 0 could be requested, the correct 
fix would be to check for something like ret >= 0 or ret == l instead of 
!ret. Then the counter will also be incremented correctly for localities 
!= 0, and no underflow will happen later on. Therefore, explicitly 
checking for an underflow is unnecessary and hides the real problem.

> This prevents the locality_counter from being increased to 1, see
> 
>          ret = __tpm_tis_request_locality(chip, l);
>          if (!ret) /* Counter not increased since ret == 1 */
>                  priv->locality_count++;
> 
> in tpm_tis_request_locality().
> 
> If now the locality is released the counter is decreased to below zero (resulting
> in an underflow since "locality_counter" is an unsigned int.

