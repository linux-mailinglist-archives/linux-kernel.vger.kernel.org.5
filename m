Return-Path: <linux-kernel+bounces-165886-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 402918B92F1
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 02:52:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CD291C21100
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 00:52:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 568D811184;
	Thu,  2 May 2024 00:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yn+UjKbQ"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DF93D299;
	Thu,  2 May 2024 00:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714611160; cv=none; b=OC7Knn1OjkZws+/AE0GUOmv9lM9wXpZXqSNpJ5KW38V+qoXqspz67oxhUw2Znjg5iVxtHY9nVCACNwG1NQfhJlAPtQW8jGEkdHX9NNhfhv4MVaMnhlN00EaTbErPcIBmAaYn24sx2ZiHEY3WFwjJ/uq1ciiU/zE2oyxQfERShBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714611160; c=relaxed/simple;
	bh=xnGH4XbmTFoht1KOiwCMDV60ppiri5Zo8GDKQxKyPXM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=rYcd1wW0Xwhe+3J4Tu+bvYIckL6973zJiWcde9NqSOw2qamVAUokGr6mdItPt20m3YRvqjr+KUcHHhjsPphiU6/DOhszTjoilEejh2ckDmW2oABIERW0DH8YwaFProilR1/MFmWLgrUPFcOIPVKgK8cPn6cA537BWOmZDEEzL+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yn+UjKbQ; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1e3ff14f249so10328725ad.1;
        Wed, 01 May 2024 17:52:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714611157; x=1715215957; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KiClpx8en7jGiPuIVIRk6u5bdQ8fzLhRfc1W/iVK5Q8=;
        b=Yn+UjKbQfww9UgA9m3F9SXjn3tXee6kTkTlAI7u2aHA66CtOSZTxjLPsFw0Rr1bKXG
         b4UrJ9Mi0wnMSC0rS/lH98qMMscScqWfjnzmChkxAmu+id1mFKgsw0JgMz18TMG/gkEn
         VrSQUPfFLc2QoOan3P05QHecPBoQrT8h3fJx3r/44jFNv2lMn8QTh6TBpL7MzQ0dbRd/
         5iDERryrShij6n+M76Ju6Rwph5iAdOoKo4XxtcwhDgHp1yqyvh14+ZJL4tncGR8RtKKk
         qJDKT5X+aKiQ/1y/lpuO6pbFAuiDVTn//pP9vrLzHHodd6V82ZO1NVXg4t4a096FQtUE
         VrZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714611157; x=1715215957;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KiClpx8en7jGiPuIVIRk6u5bdQ8fzLhRfc1W/iVK5Q8=;
        b=KecSJoEes+yditCxnqygS4yVBe4J2ME5MC0+SmLTt/viWrv2A9eJTkKJH8rA9guTO5
         mxrukNa0rGYMYPvgxzoTUqbj4ZhvGqGuDhV5T47ieXB2oku5pJwG1kxheZZfWNhGjqGh
         c8rNzNNOkQxAqAU0jmrd0N3eWnvOtAuvbF3KAm/IcSqbbP7basvckxvBP9tLmo839s9b
         Oz4U78zrGREejz3+0I6OmNdluE1NCkmRZz/jyR/6gw/fzhp8dG9PZxjJdBnZQ5S8htWe
         af67Grpt/bvD0HM+rM6sEwOaQnvRUp3+K+m/JK7Qmz5MwAIRYE8ys09gkMZgD+5Q27ru
         JWBQ==
X-Forwarded-Encrypted: i=1; AJvYcCXcOelisGY3558NLnGwEtl+SlVjDgAyTQewh4Y20yqf+AYN2SlG2GjMGHH2AWBbmSK+aIPg0hVx+8xKF8GDw0Pdg3lUl2RQVFdtLm4lbUItfFB3bi83kVgenhK/iA0/I2GudS/Ex3G5
X-Gm-Message-State: AOJu0Yxc3xjDm+Xbi5lRkYbwIeO20jFKgkgUbrIUHUwBQknFh4/HyxPH
	Izx1pc8VTAgY++oB3p5oopl3kV+M51FeBzwR1O3LYH02AIwxveWH
X-Google-Smtp-Source: AGHT+IG8oQUiorwBnxV0eC3LSJCQz1jnCAKbHg0kvh6Mr6O3B8VYhbFrkPHTmVFdcX+SYpsnDbIWlw==
X-Received: by 2002:a17:902:ec87:b0:1e5:e676:4b09 with SMTP id x7-20020a170902ec8700b001e5e6764b09mr1984424plg.25.1714611157329;
        Wed, 01 May 2024 17:52:37 -0700 (PDT)
Received: from [192.168.0.107] ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id w3-20020a170902a70300b001e83a718d87sm24844659plq.19.2024.05.01.17.52.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 May 2024 17:52:36 -0700 (PDT)
Message-ID: <33862156-cd95-4b74-bd64-82a4a4d2583f@gmail.com>
Date: Thu, 2 May 2024 07:52:31 +0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/1] Documentation/core-api: Add swiotlb documentation
To: Michael Kelley <mhklinux@outlook.com>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>,
 "joro@8bytes.org" <joro@8bytes.org>, "will@kernel.org" <will@kernel.org>,
 "hch@lst.de" <hch@lst.de>,
 "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>,
 "corbet@lwn.net" <corbet@lwn.net>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
 "petr@tesarici.cz" <petr@tesarici.cz>,
 "roberto.sassu@huaweicloud.com" <roberto.sassu@huaweicloud.com>
References: <20240429151337.1069470-1-mhklinux@outlook.com>
 <ZjHxxzRb-63ARo6Z@archie.me>
 <SN6PR02MB41574D7C31507EA7AD10FAA5D4192@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Language: en-US
From: Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <SN6PR02MB41574D7C31507EA7AD10FAA5D4192@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/2/24 01:05, Michael Kelley wrote:
> From: Bagas Sanjaya <bagasdotme@gmail.com> Sent: Wednesday, May 1, 2024 12:40 AM
>>
>> On Mon, Apr 29, 2024 at 08:13:37AM -0700, mhkelley58@gmail.com wrote:
>>> From: Michael Kelley <mhklinux@outlook.com>
>>>
>>> There's currently no documentation for the swiotlb. Add documentation
>>> describing usage scenarios, the key APIs, and implementation details.
>>> Group the new documentation with other DMA-related documentation.
>>>
>>> Signed-off-by: Michael Kelley <mhklinux@outlook.com>
>>
>> Other than outstanding reviews, the doc LGTM. Thanks!
>>
>> Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>
>>
> 
> Thanks for your review!  I realize that I forgot to carry your Reviewed-by
> forward to v4.   If you care to do it again for v4, that would be great.
> 

Done [1], thanks!

[1]: https://lore.kernel.org/linux-doc/ZjLieHFvjlTJrCUM@archie.me/

-- 
An old man doll... just what I always wanted! - Clara


