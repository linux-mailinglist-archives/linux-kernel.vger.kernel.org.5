Return-Path: <linux-kernel+bounces-95341-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CC69A874C77
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 11:35:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7EC121F23A4A
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 10:35:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F75E85297;
	Thu,  7 Mar 2024 10:35:16 +0000 (UTC)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E2BDDDC9
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 10:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709807716; cv=none; b=oNac82JjhH09hIHOL3ewcigeRnn49YVe3wOm+69mXfXRAyfPmIV8jWeNRq+D8CMFSWcxsmrxynyN0CBTzaSfLTWttPVTVfMH0n4J/AuN6NXE+/DXvrkEaJHOLA3VF4zaChMVVA0miDemcX6/7iMtTRsB7nWZ4rJzI3WaOE2EcLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709807716; c=relaxed/simple;
	bh=NIXd/wun5vI5O4exlkOmVe5O81g123Q0De+oCZGUlJg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j7uUisOPlYFWDlGQfolcuOVWJhLOpZZFnS+ASMs7ILwRY/ZnT17r/iXX6/AA8ziXs4jIS8CsdgujdvWA2zezHJdDIiwn+hOs2A40cvh2f11BAx2J38ELTzTd0nKHmt7Z6gYDwUWTZd4mzTsly7DaAERwud8UbC9ti9vHGyyP3H0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-33d90b322b0so181282f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2024 02:35:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709807713; x=1710412513;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZverQupovyQBVLcCaMqXYvLWmkxxy059MNcR8Yf1dCQ=;
        b=NV+gAR+cJ5jbM2hBh8VxLH+HqLV6BVOuLE0wOO2l1WART3LGo9d0YGrksJeJLk617F
         vdE3YrT0JbN4HEvtkc//a6TGtDG9b2XBaRYzJzz9zzb4kvWVLRrt6WmX4JVrLKdNnmtp
         W5kBCSe0Kg7LR8EuBgwBdLdDhSfsbk77HkDoyTK1X8cbRD/8blA7zmAyrGOaTbcdtpUf
         5B1yqg5x/KlN5NXXiPMjmFkFNRJX0YNY0QfKIAc03vMHLGQiNhz/wntWpXnqkPeWlQ1r
         mX64XB5+hDg0FewsrEJ3myREO/lA5fPCNjGhb29F5jsEe9K6BkKVIBinOx7gSMCr0IJY
         uPJg==
X-Forwarded-Encrypted: i=1; AJvYcCWReU9432As7qJeSfk2hNUwClDdnm9peu89MhMifatBhQ9rX1sWYWiwFqE6MGYBRAOMHEkeew9SKtttQeaqtyGPSPIYNJ7eL8AV2gt3
X-Gm-Message-State: AOJu0YxYltFTSYVueYCSHoTVCNlnuvn0NzpjltcPQJgom8nCt5mG+5Xh
	85Rdk7hI7XNWZuI/3u3Vdy7W6YDSkJyXYAtX3ojvlwUPKo60IK9dVoiH7T+z
X-Google-Smtp-Source: AGHT+IEIJZQhQs2F+Rri5mKflCqfzveuIo65qwHrUcNVvg6olRch2xhCYoB66Z5E4FBZIkiVUnZLMA==
X-Received: by 2002:a05:600c:4711:b0:412:f3f0:d8af with SMTP id v17-20020a05600c471100b00412f3f0d8afmr1136723wmo.0.1709807712697;
        Thu, 07 Mar 2024 02:35:12 -0800 (PST)
Received: from [10.100.102.74] (46-117-80-176.bb.netvision.net.il. [46.117.80.176])
        by smtp.gmail.com with ESMTPSA id gw6-20020a05600c850600b0041273fc463csm2210845wmb.17.2024.03.07.02.35.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Mar 2024 02:35:12 -0800 (PST)
Message-ID: <5a6ceb89-c242-4e76-b6f3-91c83099794a@grimberg.me>
Date: Thu, 7 Mar 2024 12:35:11 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme: fix reconnection fail due to reserved tag
 allocation
Content-Language: en-US
To: =?UTF-8?B?6K645pil5YWJ?= <brookxu.cn@gmail.com>
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240228091417.40110-1-brookxu.cn@gmail.com>
 <6eae3879-f9d2-4fe3-96b1-c9e2aa939264@grimberg.me>
 <CADtkEeeiNDO87L9MwC392gEp7YhhGGxojRu8nW_epkTe-jxcyg@mail.gmail.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <CADtkEeeiNDO87L9MwC392gEp7YhhGGxojRu8nW_epkTe-jxcyg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 07/03/2024 12:32, 许春光 wrote:
> Thanks for review, seems that we should revert this patch
> ed01fee283a0, ed01fee283a0 seems just a alone 'optimization'.  If no
> double, I will send another patch.

Not a revert, but a fix with a Fixes tag. Just use 
NVMF_ADMIN_RESERVED_TAGS and NVMF_IO_RESERVED_TAGS.


>
> Thanks
>
> Sagi Grimberg <sagi@grimberg.me> 于2024年3月7日周四 17:36写道：
>>
>>
>> On 28/02/2024 11:14, brookxu.cn wrote:
>>> From: Chunguang Xu <chunguang.xu@shopee.com>
>>>
>>> We found a issue on production environment while using NVMe
>>> over RDMA, admin_q reconnect failed forever while remote
>>> target and network is ok. After dig into it, we found it
>>> may caused by a ABBA deadlock due to tag allocation. In my
>>> case, the tag was hold by a keep alive request waiting
>>> inside admin_q, as we quiesced admin_q while reset ctrl,
>>> so the request maked as idle and will not process before
>>> reset success. As fabric_q shares tagset with admin_q,
>>> while reconnect remote target, we need a tag for connect
>>> command, but the only one reserved tag was held by keep
>>> alive command which waiting inside admin_q. As a result,
>>> we failed to reconnect admin_q forever.
>>>
>>> In order to workaround this issue, I think we should not
>>> retry keep alive request while controller reconnecting,
>>> as we have stopped keep alive while resetting controller,
>>> and will start it again while init finish, so it maybe ok
>>> to drop it.
>> This is the wrong fix.
>> First we should note that this is a regression caused by:
>> ed01fee283a0 ("nvme-fabrics: only reserve a single tag")
>>
>> Then, you need to restore reserving two tags for the admin
>> tagset.


