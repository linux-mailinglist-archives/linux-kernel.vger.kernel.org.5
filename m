Return-Path: <linux-kernel+bounces-5589-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 87523818CB9
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 17:46:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26D441F259F0
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 16:46:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD211224F9;
	Tue, 19 Dec 2023 16:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="ocpztQ/Q"
X-Original-To: linux-kernel@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73C512C841
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 16:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1703004197;
	bh=H8sLbkr3dhTaZTNxKROToKvhNjueaxhINN7MbWkd15g=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ocpztQ/QAAnlc1sim0K0sM3WJmuCm4XTk8kOvg0HMRV3nykmn4c4VX9XQ3CHJdljS
	 rI1N8Iq6i8Gf5Q0UvgHvHx7qWF/cQhQK1vPjC677suqQwk2r13p2YlVI4zZ0rmv+oD
	 uB6zHxj1tOMzpacfINdTQgwIy+Qi6smGuPdJXCbJZpHxapXr3tIkkjCErqWJnBe31v
	 gJIm2HaiiN3kDnnKuLvon1YdUuetSzxyZw8x3lhThMs1lnzXTVjs0ltTwHuZrJ2KfG
	 hQIqodSdUY9ZwXNdjb+ZfXYoH06H3okcYuSXh0Nde7O100nRozmyAStLdjKxHnG6iA
	 Z1038Pcd7FZmg==
Received: from [IPV6:fd00::2e:42e5] (cola.collaboradmins.com [IPv6:2a01:4f8:1c1c:5717::1])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: koike)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 4DA7A37813EB;
	Tue, 19 Dec 2023 16:43:15 +0000 (UTC)
Message-ID: <1844c32e-13f9-4225-88a7-1c621a3bfc75@collabora.com>
Date: Tue, 19 Dec 2023 13:43:12 -0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Automatically update drm CI dependencies?
Content-Language: en-US
To: Bagas Sanjaya <bagasdotme@gmail.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux DRI Development <dri-devel@lists.freedesktop.org>
Cc: Thomas Zimmermann <tzimmermann@suse.de>,
 Maxime Ripard <mripard@kernel.org>,
 David Heidelberg <david.heidelberg@collabora.com>,
 Dorine Tipo <dorine.a.tipo@gmail.com>
References: <ZXrNI9Pqln9HVYVc@archie.me>
From: Helen Koike <helen.koike@collabora.com>
In-Reply-To: <ZXrNI9Pqln9HVYVc@archie.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 14/12/2023 06:38, Bagas Sanjaya wrote:
> Hi all,
> 
> I'm referring to dependabot PR on torvalds.git GitHub mirror [1]. I know
> that PRs submitted there are not accepted (the repo is essentially read-only
> mirror), hence this mail question.
> 
> In summary, dependabot submitted automated PR that bumps package versions
> in `drivers/gpu/drm/ci/xfails/requirements.txt`. In this case, pip was
> upgraded to 23.3.
> 
>  From my experience, such automated PRs can pollute commit history (in
> some GitHub projects these PR kind can contribute up to half of total
> commits since the beginning of project). And in some projects, dependabot
> PRs are automatically merged without any maintainer intervention.
> 
> Does such PRs (when submitted to LKML these will be patches) make sense
> for DRM subsystem?
> 
> Thanks.
> 
> [1]: https://github.com/torvalds/linux/pull/807
> 

imho I rather not having this automated patches, but I would like to 
hear the opinions from others.

Thanks
Helen

