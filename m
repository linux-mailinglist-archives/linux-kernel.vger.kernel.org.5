Return-Path: <linux-kernel+bounces-19723-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1452C8271EF
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 15:53:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8EB38B2202C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 14:53:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01CA147768;
	Mon,  8 Jan 2024 14:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="ECV6rE3A"
X-Original-To: linux-kernel@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6DA145C18
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 14:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1704725609;
	bh=HwnTz4t3mWsSACsYhKCWnCNgw+Mn9ntXkEQii6pJHDw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ECV6rE3AJ9MZjGytt3Wij0O+flNMUirNnAnh5Mz/kBHDLKBlv1/gFfCFcZbYhcGcS
	 Yl5VJbThreJ8n6GmgObhHz8YMNrmNHIcdzu4nOUxoaAP3hXFZ8YU17A1HhqAge1P1W
	 DI0lqWnVCcmxvzycZQp/vjFUwQf5D4lCN0vVU8iXGXWChiGY8axRk/awiDPJxEdjQc
	 p0AHjo1wjRhLvkbQ0ISdcxiqCS4995fnnHlPKyGXQceqDpCjSwkbTr7h66R2LIxjqP
	 Nu+/7n2hSeK0KG36U2r4jhT3lU61NSf60CEFRykpT8KA4A6B0buG/A0YkqoQmyVf8z
	 z1w/g8WM0sgYg==
Received: from [100.95.196.25] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: koike)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id BFC80378146C;
	Mon,  8 Jan 2024 14:53:27 +0000 (UTC)
Message-ID: <dfa99bb8-9b7d-4db2-b5bf-35da39b80eda@collabora.com>
Date: Mon, 8 Jan 2024 11:53:24 -0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Automatically update drm CI dependencies?
To: Bagas Sanjaya <bagasdotme@gmail.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux DRI Development <dri-devel@lists.freedesktop.org>
Cc: David Heidelberg <david.heidelberg@collabora.com>,
 Dorine Tipo <dorine.a.tipo@gmail.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>
References: <ZXrNI9Pqln9HVYVc@archie.me>
 <1844c32e-13f9-4225-88a7-1c621a3bfc75@collabora.com>
 <846e883c-e3ae-426f-83e3-38e357e53ef3@gmail.com>
Content-Language: en-US
From: Helen Koike <helen.koike@collabora.com>
In-Reply-To: <846e883c-e3ae-426f-83e3-38e357e53ef3@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 20/12/2023 08:11, Bagas Sanjaya wrote:
> On 12/19/23 23:43, Helen Koike wrote:
>> Hi,
>>
>> On 14/12/2023 06:38, Bagas Sanjaya wrote:
>>> Hi all,
>>>
>>> I'm referring to dependabot PR on torvalds.git GitHub mirror [1]. I know
>>> that PRs submitted there are not accepted (the repo is essentially read-only
>>> mirror), hence this mail question.
>>>
>>> In summary, dependabot submitted automated PR that bumps package versions
>>> in `drivers/gpu/drm/ci/xfails/requirements.txt`. In this case, pip was
>>> upgraded to 23.3.
>>>
>>>   From my experience, such automated PRs can pollute commit history (in
>>> some GitHub projects these PR kind can contribute up to half of total
>>> commits since the beginning of project). And in some projects, dependabot
>>> PRs are automatically merged without any maintainer intervention.
>>>
>>> Does such PRs (when submitted to LKML these will be patches) make sense
>>> for DRM subsystem?
>>>
>>> Thanks.
>>>
>>> [1]: https://github.com/torvalds/linux/pull/807
>>>
>>
>> imho I rather not having this automated patches, but I would like to hear the opinions from others.
>>
> 
> But why? Did you mean that making the CI always depends on latest version
> of dependencies create another maintenance variable (and may constantly
> broke CI)?
> 
> Confused...

Sorry I didn't reply earlier.

I'm ok with that if it doesn't produce much noise, I also think that we 
need an automated test to see if the tool is still working as expected 
before merging the patch.
The pip there is just used for a helper tool, it is nothing critical.

Regards,
Helen

> 

