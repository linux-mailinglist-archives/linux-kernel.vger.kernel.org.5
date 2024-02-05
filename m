Return-Path: <linux-kernel+bounces-53066-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0D4484A03D
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 18:09:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3C56CB2206E
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 17:09:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBBFF45974;
	Mon,  5 Feb 2024 17:09:02 +0000 (UTC)
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28DA34594E;
	Mon,  5 Feb 2024 17:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707152942; cv=none; b=IQnm0CjKBojePwQf72Mzf6ligvOLfikDxgVC5zhydApb13cBbKed7lqvyehqrTEvX2UEL87AYFxqHHRlE+SbBNJiOVrlZJQkk944e+vSxl65Bvkje2jUXUPT7XqUfu7/i857IuQomTmv4v8OvZTKnK5ISpEwKVm/1JVeJ6bWaGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707152942; c=relaxed/simple;
	bh=oAYNX3KP98Y/jeec7UIwq34nPFyWbvV+ib/tzgMvbDo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XEHlGQwIaNlMCefDhN+q9kBNag63xEK7MLob38jWEPva3jiSugQW+lKGLr2evWvGhnmciQH6zTDVpdQ5bX73+4b0FRIzie87rLFDRypW2Lwku8nOmbSXo1BpXlezFHUmaZndkTGdFW62U8cO+hmOEQzYj2tiF+wTEZrM/sjkv7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6e0507eb60cso346294b3a.3;
        Mon, 05 Feb 2024 09:09:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707152940; x=1707757740;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1kuiOuDoqUN+LX9cDleVQRc2hrmBbqV3FFSoOhvfn0k=;
        b=F09Z4gOo0OTaKBwY3Z0rPwROUtgbJAqrUCS4ela1Qz7wxLlQNbOYpI3jnjg90vbcWQ
         ZIWagDyFLqlHSKNhWZa1ceLLMDjnyVAmD5QrjiccPM+uloF26iJ486oUiq0o/y3/nOWI
         yUfG0j3L3JrwEIphxsVFs//i7Jd7mwRyGPoenaaAAem8BVU6eV3KB3ODQkJYI3vv7d+a
         mdh9FBjCoVw2s6U/2OdGjnsXEjnMY2SL9vp8qf2yleXNMeeit1ene2j9ElpW/I9JBn86
         84cbMLrkAze9bw3wj1DVYL59ZIjx5u5ThqqLVLCPYKYpm1UJH+SXutvGcgHXmQ3ksUYx
         OyFw==
X-Gm-Message-State: AOJu0YzPRd+hA7T4YKum4+tMhJr28D/Fohwd3UL3+4j0wT1gSOfo25cp
	RvTds0AryxeFa+rtWSXulUiWd0RjUfxRo+ULlrYd6FFAxjse6KTr
X-Google-Smtp-Source: AGHT+IGo8WjL/bdJNre0s9vbNXMioQJbq7p0P7eat1QWk+GpzjwXOG+PVh0O+BBrUAB/OnFm8hgfVg==
X-Received: by 2002:a05:6a00:17a6:b0:6e0:3c66:cb7d with SMTP id s38-20020a056a0017a600b006e03c66cb7dmr237031pfg.3.1707152940419;
        Mon, 05 Feb 2024 09:09:00 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWu8XlNN/hkZ/9Zm2dU5w8AJcapRa4uNKA/c1kpyak8eUdL+cXsVcyJxRMGpC5CM71G75GPwFeDLeQ441Gw+UK5qkD00mvVvuRZ6KXXdfjQJQgg1VFURjpS3OQ9hRZTqTz2Z6n0bmgQac14QbCtItb5OPDToRBa0oSicntyXHe96ubYsyjFKaGauSqIF5zd8V/lFFi/5Yu8AvTXEMhfZgzisbMc8892fgG0BHO86Zk3lvkT35ACj0XCVRoThEYFSkEUOc01lMK0caNg1IEj5L3jtbIz4Exm+qoXYt4l7Z+V1je1qWGC77lp7d2Oqa7XSZf4wpqvj7hOKe4w2fd5E17VVsFXVgivQjIjXPyfaOXAbhs71NhY1UvbqeqHyWke52eT14ZfpDoUsHWk7pYMc4lWnZJhZ8KcJ9cAOut62wB2xDL8O4wFTNzLBBK538wgs5nSCetKQu4yzw3YZqjvDCZJc7K+XjsCEBoGUOMO0BSN024Dm2sUrCFjyvF15tyKW1PgyYeeaauFXdjsNBgajZVVMI/SqPX/WZrXE2tMh6L4yI7AySbghqGBNgFq81fnI0MslK2VvIMJmbr9QzN32Lz3BwP/YP9wXQ/vNlBPWqXD3Z6nkBvam9PcXYG17ibBWgV/3KjnuKRTsow+dctcDzNafxz79afwfzzd59FeB4QsbQhNc0qaQusNviw25q0dnh/nwS0wow==
Received: from ?IPV6:2620:0:1000:8411:be2a:6ac0:4203:7316? ([2620:0:1000:8411:be2a:6ac0:4203:7316])
        by smtp.gmail.com with ESMTPSA id x16-20020aa79a50000000b006e03be933cesm67976pfj.96.2024.02.05.09.08.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Feb 2024 09:08:27 -0800 (PST)
Message-ID: <55fa1c14-87ef-46ef-8871-f7139f86e8b7@acm.org>
Date: Mon, 5 Feb 2024 09:08:08 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] ufs: core: fix shift issue in ufshcd_clear_cmd
Content-Language: en-US
To: alice.chao@mediatek.com, Alim Akhtar <alim.akhtar@samsung.com>,
 Avri Altman <avri.altman@wdc.com>, "James E.J. Bottomley"
 <jejb@linux.ibm.com>, "Martin K. Petersen" <martin.petersen@oracle.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: wsd_upstream@mediatek.com, stanley.chu@mediatek.com,
 peter.wang@mediatek.com, powen.kao@mediatek.com, naomi.chu@mediatek.com,
 cc.chou@mediatek.com, tun-yu.yu@mediatek.com, chun-hung.wu@mediatek.com,
 casper.li@mediatek.com, linux-scsi@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <20240205104905.24929-1-alice.chao@mediatek.com>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20240205104905.24929-1-alice.chao@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/5/24 02:49, alice.chao@mediatek.com wrote:
> When task_tag > 32 (in mcq mode), 1U << task_tag will out of bound
        ^^^^^^^^^^^^^
        task_tag >= 32 and sizeof(unsigned int) == 4

> for u32 mask. Fix this bug to prevent SHIFT_ISSUE (Bitwise shifts
> that are out of bounds for their data type).

Anyway:

Reviewed-by: Bart Van Assche <bvanassche@acm.org>

