Return-Path: <linux-kernel+bounces-138318-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A0D1089EFBE
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 12:22:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D21871C20DFC
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 10:22:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C21D158D94;
	Wed, 10 Apr 2024 10:21:57 +0000 (UTC)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 397E6154C00
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 10:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712744517; cv=none; b=B7SXe9iX+U+HvHHW0tt/2XmmE/h5RZ3JlxhTJQP4NrRY9T8J/FW8hFP5ypbu6Ho68Ff+//umzL6A4mr5NC9EyAc1zwK+P08Jv6yq1Mom47rxxO9EVG5nEO333m6OUqD5dv4D0ktKYsZi8taJyif2CGoBnm2jik3sLyidnhnaop0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712744517; c=relaxed/simple;
	bh=XoiJz6/2bNSH3H7sc6zn0b/Oq3MnQZ9fYN+VNxksKVM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hYakGgP3GNPm54whpsZfrCcTNKluAfARwakS7Iw673TuDhIABaZPIRDe4k26K8o3fG/bj5QQhhHz7PvFqp2xfN42TedP3m4GGaAeN/+YDgXVD8l23vBJCChqJKQM6bzh5Ub1ac5BWi7z/rwf4SGc2aU7jxLei1l6+/isrdYjCPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-417bfd4418aso115265e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 03:21:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712744513; x=1713349313;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=N8U80+37Ey0cYnbu7WdMhmM1N+pNOXuEuXzMIMzques=;
        b=c+cNmKybQ3TK77nAW147kXv5IcJgiakAEiGdzbIqjh/NLHgnyEUMYdKSeOAI+IC8V5
         zhGZZ1DvINrb8a2JWs7QssZEJ348G3qzn7USCAX364ZiQCX+a/vdZZaapsxaFwrkr2FW
         s45VZq+QrTgj33Chuo0c5t6Hs8WqooYiUz0D53ZxlgUyFibW26d9azJtcUPMBRGzycb7
         4YD14861WuY3uAU1pN+jhDvBKzQoa0Dn0MZuk8p66Xe+sBYzSWDbd8Xih7KouvOK4sJM
         MS9WRTa9+daLEM720UE2sj8ksIu2ReHoWx7t7yeLVEQchCJEj04PJqlO+vLQPk5ZLHKV
         ATLA==
X-Forwarded-Encrypted: i=1; AJvYcCWpStBJqIAbsuVmLFi+zfYJ6at4EIeWZIPg6ZxSonhwLWrQPTZnDYmmQECs+kbKFvHmso4ADGFX1rKS2zz/2Lo/4Fz6lLm/ruMKoBxI
X-Gm-Message-State: AOJu0YzhWLYY1W7wSbTjsNhIZHB4ODlu+KD1J/8gAs4sm7UGzch6orTj
	+nlLK7Zrz6aKYAA4rLdreLNphTjLkiQCGAd8HU1VYK6+UW5SUlmD5gPAqDjv
X-Google-Smtp-Source: AGHT+IEWRd7BwEL1or8KxIbk0RSRElXoUZ3t8B7ISeWGwnKkBTGE1l4AYCRIIraSp3xnwqgK8rdbnQ==
X-Received: by 2002:a05:600c:3507:b0:416:ac21:9666 with SMTP id h7-20020a05600c350700b00416ac219666mr1712000wmq.4.1712744513213;
        Wed, 10 Apr 2024 03:21:53 -0700 (PDT)
Received: from [10.50.4.160] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id m5-20020a05600c4f4500b00416cac63b11sm1770331wmq.3.2024.04.10.03.21.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Apr 2024 03:21:52 -0700 (PDT)
Message-ID: <8c9a980f-4885-479c-9078-7f87dc92175c@grimberg.me>
Date: Wed, 10 Apr 2024 13:21:51 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/6] nvme: authentication error are always
 non-retryable
To: Daniel Wagner <dwagner@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 James Smart <james.smart@broadcom.com>, Hannes Reinecke <hare@suse.de>,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240409093510.12321-1-dwagner@suse.de>
 <20240409093510.12321-2-dwagner@suse.de>
 <ac48d955-8169-467d-962c-e7f55854ba06@grimberg.me>
 <7jqbhmskuzfvpjlavk7oqefmc72m5j2wj7525c7y2vlsfnaajx@57pfbmfvf4kt>
Content-Language: he-IL, en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <7jqbhmskuzfvpjlavk7oqefmc72m5j2wj7525c7y2vlsfnaajx@57pfbmfvf4kt>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/04/2024 9:52, Daniel Wagner wrote:
> On Tue, Apr 09, 2024 at 11:26:00PM +0300, Sagi Grimberg wrote:
>>
>> On 09/04/2024 12:35, Daniel Wagner wrote:
>>> From: Hannes Reinecke <hare@suse.de>
>>>
>>> Any authentication errors which are generated internally are always
>>> non-retryable, so use negative error codes to ensure they are not
>>> retried.
>> The patch title says that any authentication error is not retryable, and
>> the patch body says "authentication errors which are generated locally
>> are non-retryable" so which one is it?
> Forgot to update the commit message. What about:
>
>    All authentication errors are non-retryable, so use negative error
>    codes to ensure they are not retried.
>
> ?

I have a question, what happens if nvmet updated its credentials (by the 
admin) and in the period until
the host got his credentials updated, it happens to 
disconnect/reconnect. It will see an authentication
error, so it will not retry and remove the controller altogether?

Sounds like an issue to me.

