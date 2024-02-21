Return-Path: <linux-kernel+bounces-74331-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1E5285D2E3
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 09:56:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2ED5C1C20FF0
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 08:56:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47C4E3C6AC;
	Wed, 21 Feb 2024 08:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="pAaTohn1"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C6DE3D0B4;
	Wed, 21 Feb 2024 08:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708505762; cv=none; b=lnTsFdjGL58ywciyJyKnEkBXfhrmnPbDsgmxjLhgQfKmlQs8XjJEdSxEQ5ZPvtHzTH+xs0tw3WJfFi+nxtLlvQ6Mj/PUQdUDwXHb/NLSXgeghFSYxgxdarAJJVafoIIaFPuvEQ0FhYvB8bItwZMHW3ymBwZdyqbGfumv8nQ39u8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708505762; c=relaxed/simple;
	bh=iXqKyZlYAG0/zPjYv6PTn321Y8DYnVDJsS4crisKR4o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LvjMsYwJyY979hJNc99w5itI5qghNRnzZsZCXEPd0IE5kqdmpSc0UTLsHZmgfMMoqIAigOfSrsb4crpMdwauved/RQiIa71V81Oy2IE5ybkZQsNkRSPJaW2NtlkLEPa1qjHXVaZcQIp00GQYPNXGBxo6Qn6h8MLr6GMF6ginH0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=pAaTohn1; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1708505753;
	bh=iXqKyZlYAG0/zPjYv6PTn321Y8DYnVDJsS4crisKR4o=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=pAaTohn1MyHq+SAwNPu+GqkZfMFd3G/bGJVCR+HOTAuI3e2P5UWBIVuta3APuP+m6
	 zXW9oWFDOmL6bAmanbK2XsC2lZm9dofQiSN0VBE9jAr+jqHehy5xbeaAhsekDlihI6
	 ifgYTirWC9wdBPzgg4AQ+h9xVhr+r/cBu1EsrtuvJ7WoVqwSghfDbU8qQjf1TmUNWw
	 Y/3KU7BAIDtYe6ZQNUq+E8TqxonVH4tTeEgj8tSlzkoR6D1cPBgStvYobQMUi8L32b
	 3zz/WwjEZ0BJVZiEBuUSGDBBqwOeewQD7xS26rwY4H3V2N5UacP4u26Z1WbFfWjLYE
	 KJaQXVY5jIgXw==
Received: from [100.115.223.179] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 1813D3781116;
	Wed, 21 Feb 2024 08:55:52 +0000 (UTC)
Message-ID: <22cb4ca8-7114-4162-b4a4-ded70d2a69d1@collabora.com>
Date: Wed, 21 Feb 2024 10:55:51 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] ASoC: SOF: amd: Move signed_fw_image to struct
 acp_quirk_entry
Content-Language: en-US
To: Venkata Prasad Potturu <venkataprasad.potturu@amd.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Liam Girdwood <lgirdwood@gmail.com>,
 Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
 Bard Liao <yung-chuan.liao@linux.intel.com>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Daniel Baluta <daniel.baluta@nxp.com>,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>, Mark Brown
 <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>
Cc: sound-open-firmware@alsa-project.org, linux-sound@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel@collabora.com
References: <20240220201623.438944-1-cristian.ciocaltea@collabora.com>
 <20240220201623.438944-2-cristian.ciocaltea@collabora.com>
 <133770ce-98b0-4e36-b21e-1468c45fad0e@amd.com>
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
In-Reply-To: <133770ce-98b0-4e36-b21e-1468c45fad0e@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/21/24 08:14, Venkata Prasad Potturu wrote:
> 
> On 2/21/24 01:46, Cristian Ciocaltea wrote:
>> The signed_fw_image member of struct sof_amd_acp_desc is used to enable
>> signed firmware support in the driver via the acp_sof_quirk_table.
>>
>> In preparation to support additional use cases of the quirk table (i.e.
>> adding new flags), move signed_fw_image to a new struct acp_quirk_entry
>> and update all references to it accordingly.
>>
>> No functional changes intended.
> 
> If there are no new flags currently being used in this patch, and also
> no functional changes added, in this case this patch is really required?

I would say yes, as it improves the ACP SOF quirk handling by making the
implementation more readable, less error prone and open for extension,
as already mentioned.

Additionally, it should facilitate the review process, since it's
unaffected by any potential changes that might be required for the
subsequent patch.

> Also please use scripts/get_maintainer.pl in CC while sending patches,
> then only
> maintainers get notified your changes.

I've already done that. Did I miss something?

Regards,
Cristian

