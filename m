Return-Path: <linux-kernel+bounces-144050-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AA08F8A413E
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 10:35:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14FC7281AFB
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 08:35:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBC7A224EF;
	Sun, 14 Apr 2024 08:35:03 +0000 (UTC)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB4C4219F3
	for <linux-kernel@vger.kernel.org>; Sun, 14 Apr 2024 08:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713083703; cv=none; b=ZogDvrz/Kwy8RDv1XuMvoNdsDIbZzxwxoL5lpOYUasRYfGKcMBg28/vtgvSlkScV2PE1n6GZPVD/Ms5Yn83l0tDBZzJDPLK6EuW7iPq72MTIpUlKY8ZOwnQz5P8imsVTqQVybBCNZYyNxkrEw7zVU3cbpYz4o6+HSoLkuA8+dHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713083703; c=relaxed/simple;
	bh=rODNJ0Ukhp6xqvTSkV55aTTmI0Z+BHUMDDSzoazWTg4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g0Zk86DU/KNROPvCMO6nLJ8TAvQP9WX0V4NXBQWPR/7F4B3APrQwhMjW/7y5wknXTMyNkfxCw4YeDpBpMobw63M4wbmtWDnjacRGz62qcuTv7JV/DuBmPQlOdUS+sDEaXdZypVPtBThfA5mvoNitcDJK7+jPea3vn3Kvo2Svmrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-516d8764656so831125e87.1
        for <linux-kernel@vger.kernel.org>; Sun, 14 Apr 2024 01:35:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713083700; x=1713688500;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rODNJ0Ukhp6xqvTSkV55aTTmI0Z+BHUMDDSzoazWTg4=;
        b=fzU3hQ1OHNDuXvkgZt6N5Gh2L79nQ2jfjGA54FFeAUAAIIOQ1IIJW19vpBFfHt7xPG
         3HtE6HJrKbxCzE7KNeGpQDhkqOfNRYecRjcnrrJte51HogxLev+F4nhG518ecefDp/Uv
         NB1ZJ/+cU5t8gcDy91YKgFIKvR5oGZ5e9M2HADFZ9R/7nSnH/QKeuP5G8RN0DUACnvrp
         JdC9KQBnJ8MkQVYbBdeiHXDKpeQ0QmTml1KxOFjzoWQLI7vx86WmxzOFBwZ3m06l3NnQ
         uvdBdINdFjeKG0fywO0a4IiIIbWDJRTtZ9Wd7CkfpD9h15eHstl10uclaY1zliDWMF45
         9SBg==
X-Forwarded-Encrypted: i=1; AJvYcCVmYbV+n/5/x2skgFrDu/CNQgJbQItIizxnoqd39QRVQ7X9MVh4LtGtXNy6Bs+7YvwHSHQseGCDyfJ4ynUSyi4euFPwDjZaqxUZ1q6E
X-Gm-Message-State: AOJu0Yy62B68DG7YtcVKHPl2ltjS8n00O/dSldPfHBNnDhPY50KT6QoX
	miZyYYvKYHEm6rLnDlVHR+AvkzbyteOxaEXIACoFbl5J9VIdm+MuVHRnwA==
X-Google-Smtp-Source: AGHT+IHUerSoHWBsGEYAfYQTKd/vCWDjdmSOFzRHu8Rk87rKdywP2XPry+/l30vZZvfgcddZaKXuMA==
X-Received: by 2002:a2e:3a18:0:b0:2d4:25c5:df1e with SMTP id h24-20020a2e3a18000000b002d425c5df1emr3891400lja.5.1713083699832;
        Sun, 14 Apr 2024 01:34:59 -0700 (PDT)
Received: from [10.100.102.74] (85.65.192.64.dynamic.barak-online.net. [85.65.192.64])
        by smtp.gmail.com with ESMTPSA id gw7-20020a05600c850700b004146e58cc35sm14861616wmb.46.2024.04.14.01.34.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 14 Apr 2024 01:34:59 -0700 (PDT)
Message-ID: <bd345f52-3435-4e40-975d-321f706857be@grimberg.me>
Date: Sun, 14 Apr 2024 11:34:58 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/6] nvme-fabrics: short-circuit connect retries
To: Keith Busch <kbusch@kernel.org>, Daniel Wagner <dwagner@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, James Smart <james.smart@broadcom.com>,
 Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20240409093510.12321-1-dwagner@suse.de>
 <ZhiBzXBvjTeDuHbS@kbusch-mbp.dhcp.thefacebook.com>
 <vbptto5zefkdadnpyhcjelfrsgadb2stjh3sole6n6mdd4h7dq@lrdxk5p5qh6w>
 <ZhlSJcTwGVrlk8OP@kbusch-mbp.dhcp.thefacebook.com>
Content-Language: he-IL, en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <ZhlSJcTwGVrlk8OP@kbusch-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 12/04/2024 18:24, Keith Busch wrote:
> On Fri, Apr 12, 2024 at 09:24:04AM +0200, Daniel Wagner wrote:
>> On Thu, Apr 11, 2024 at 06:35:25PM -0600, Keith Busch wrote:
>>> On Tue, Apr 09, 2024 at 11:35:04AM +0200, Daniel Wagner wrote:
>>>> The first patch returns only kernel error codes now and avoids overwriting error
>>>> codes later. Thje newly introduced helper for deciding if a reconnect should be
>>>> attempted is the only place where we have the logic (and documentation).
>>>>
>>>> On the target side I've separate the nvme status from the dhchap status handling
>>>> which made it a bit clearer. I was tempted to refactor the code in
>>>> nvmet_execute_auth_send to avoid hitting the 80 chars limit but didn't came up
>>>> with something nice yet. So let's keep this change at a minimum before any
>>>> refactoring attempts.
>>>>
>>>> I've tested with blktests and also an real hardware for nvme-fc.
>>> Thanks, series applied to nvme-6.9.
>> Thanks! I have an updated version here which addresses some of Sagi's
>> feedback, e.g. using only one helper function. Sorry I didn't send out
>> it earlier, I got a bit side tracked in testing because of the 'funky'
>> results with RDMA.
>>
>> Do you want me to send a complete fresh series or patches on top of this
>> series? I'm fine either way.
> Oh sorry, I didn't notice the discussion carried on after the "review"
> tag. Please send me the update, I'll force push.

I think that what we want is to have a special handling in the very specific
connect failure when the host/ctrl credentials mismatch, because out of all
the reasons to a connection failure, this _could_ be transient.

