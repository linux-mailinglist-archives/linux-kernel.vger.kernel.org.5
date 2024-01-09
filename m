Return-Path: <linux-kernel+bounces-21313-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 72F99828D6D
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 20:32:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2154D287B4C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 19:32:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84E603D387;
	Tue,  9 Jan 2024 19:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cQOLlmca"
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90C8C3D3B9
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 19:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-7bee9f626caso7750939f.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jan 2024 11:31:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1704828716; x=1705433516; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BX6WX/X3x+sI97fYVnBXml21yMAcf1vyq5kAEe0Em5I=;
        b=cQOLlmcaqUhwLAlPb+YoK3cpqG/tM8PhBonRBnB5rSFHDbv9gltx+ferLiG2ju6r9G
         iMPRslGBbDavGiQMV8dbOmz3cYbsLyFAhy/ICM4Y6nmP4tZmKAxZ8lRnwQQypWQ8XnlM
         7d3Mi6ANWHBF7ByciB6j+Aeu8Lig//xPys6BE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704828716; x=1705433516;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BX6WX/X3x+sI97fYVnBXml21yMAcf1vyq5kAEe0Em5I=;
        b=CO1FGeGjSZhZmE/ZDlsltmg4K1h9ZZPkZw3gr5RB6Fv/oAKpvOxnpVBr9qQOo+A1vS
         KJRIc6+0HDyL14b8i6/mlBFIyOrQ5PmkfzHZRGFtXmNEyLGk00K9rbx1dWs2JiPhOV7d
         yU98uBZiLDF9KX/Sb9hchP9hK37AffgUkioeyp9DqqdhUjFFto0JzuqdnXUxo5R4it1M
         2ol/O/kMdZIhcDpRHxSbQmkZ5cNuhN37lgFjRDZ5hOkObxrBm/YSH8fA2JjAlDOoSBY5
         noHreBJMsHkMUnY/bAUE287rlcG9npfM/yggNlhJEJRw79MN+8v4I4pYOOCIoIESu7yT
         fsPg==
X-Gm-Message-State: AOJu0YyDS7eGErJSIrKqO8OooNbGHBPY8V8rN1s9o80Os1w+XKjrBB6A
	0/ATg7G3LpPasX71uSQW7ehpXD17D2A+3A==
X-Google-Smtp-Source: AGHT+IF17YouLb8dLiAWKBE/dIFNs+76nEgViYUyT37MYA3oOcuaMwflJbAwRKNo9bXNPVTnggdieA==
X-Received: by 2002:a5d:804a:0:b0:7bc:207d:5178 with SMTP id b10-20020a5d804a000000b007bc207d5178mr10285797ior.2.1704828715769;
        Tue, 09 Jan 2024 11:31:55 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id dq33-20020a0566384d2100b0046dd0db4a14sm800066jab.99.2024.01.09.11.31.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jan 2024 11:31:55 -0800 (PST)
Message-ID: <87b55a25-4288-4add-b2b3-0038ed41b08e@linuxfoundation.org>
Date: Tue, 9 Jan 2024 12:31:53 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v4 1/3] kselftests: lib.mk: Add TEST_GEN_MODS_DIR
 variable
Content-Language: en-US
To: Marcos Paulo de Souza <mpdesouza@suse.com>,
 Joe Lawrence <joe.lawrence@redhat.com>
Cc: Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, Josh Poimboeuf <jpoimboe@kernel.org>,
 Jiri Kosina <jikos@kernel.org>, Miroslav Benes <mbenes@suse.cz>,
 Petr Mladek <pmladek@suse.com>, linux-kselftest@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-s390@vger.kernel.org, live-patching@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20231220-send-lp-kselftests-v4-0-3458ec1b1a38@suse.com>
 <20231220-send-lp-kselftests-v4-1-3458ec1b1a38@suse.com>
 <ZZSOtsbzpy2mvmUC@redhat.com>
 <4fb169fd-393c-441e-b0f7-32a3777c1d11@linuxfoundation.org>
 <11c112df801008f6bc4b7813645d505388894e29.camel@suse.com>
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <11c112df801008f6bc4b7813645d505388894e29.camel@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/8/24 10:13, Marcos Paulo de Souza wrote:
> On Wed, 2024-01-03 at 15:09 -0700, Shuah Khan wrote:

>>
>> Copying source files and object files doesn't sound right. This isn't
>> how the ksleftest installs work. Let's fix this.
> 
> Hi Shuah,
> 
> what do you think about the proposed solution? Could you please amend
> the fix into the first patch if you think it's the right approach?
> 

I would like to see a new revision of the patch series with the fix to
the problem. I will pull this into a separate test branch for us all
to test different scenarios. I would like to make sure the repo will
stay clean after install in the case of when out of tree builds.

Sorry I can't amend the patch as this isn't a trivial merge change.
This change requires more testing.

thanks,
-- Shuah




