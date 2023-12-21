Return-Path: <linux-kernel+bounces-8666-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 936D581BACF
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 16:32:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF85F1C22E8C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 15:32:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E7A0539E8;
	Thu, 21 Dec 2023 15:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="E8YsX6AS"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6B2E41C7A
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 15:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1d3d3f0afc4so2330705ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 07:32:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1703172734; x=1703777534; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2D76tlhhbN+LieyOjmTq+nQ6TD6w4dcAU8mFbIOe1Hk=;
        b=E8YsX6ASUAaE9M+i221yh+Cg/Lm2Mad69Sb0uNd+iXN4mS1AuznLY0ymisuMIuAk42
         GzSsHqXFF4VNdCOVGjXVSZm7gJYBZd5S1lQwfccy2d/ifkQQC9snSFhbF36FU1fLO6RJ
         sgefzdJh+aN4y+/3D2fzMjI3RLx3at8ACJBVSs57owyAMzBgeJOKU6EkwScsre2TTgds
         AhDxa6etHJWEKcVh0MA3BCUUIuwiR/5nqtBT6EbBG1ZN2ELdwR88txqys5nUqZIBNrle
         +ZSE0uRSdWlw9JdT0LO0iwW+VkW/y/yz4h4prIdIJyR1sPwfFBoY4vBUXg4sg06MVvGh
         bmIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703172734; x=1703777534;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2D76tlhhbN+LieyOjmTq+nQ6TD6w4dcAU8mFbIOe1Hk=;
        b=VHW66MSNAAi8ryG4sWKt4KqEM9m95Wkoyxd/AJ14O+6oLkpun9rtmkw9u7JStwMAWv
         fjR2P8xI8AUGOX96tEDPSgiGC0p12DuPja0hMQ9PHJ3bE0WU6U49PyljUJuJdocBZmT7
         664PtxN2I/whc8NLilNZPhVPddMIMKjtGRP6/g4M04+Fh3onG0D22Z9RQkp0YvL3v7sW
         DDlZZ7kt+z2L9bicsvYDW2BLIccV8WawpBQ9MQqw7H5GCcSgERQjkGkiSKXyau7Y1GrW
         Zgp2K5FiGGB7PFqonU7LZttLO2UE2DEkEmTdkut763PsK65Jl5xzjLchowTkjOxuX85n
         uGjA==
X-Gm-Message-State: AOJu0YzlxVkzoSshyDgOYtKtku5eVsM9xjOwLub5nPZt0zxNVoVsVLb6
	ymP9mJrSBv8WN+EcsoVV3iQGzr1cHh9MIXxD+bftbw==
X-Google-Smtp-Source: AGHT+IGE9qfigtthLWxUjNG9t11iY35QiLBmN7q1/A85uRWsKaA6Yrt2FV8Sp1aaba4ID6d5TdM31w==
X-Received: by 2002:a17:902:ac85:b0:1d3:f25c:7d73 with SMTP id h5-20020a170902ac8500b001d3f25c7d73mr4767237plr.5.1703172733713;
        Thu, 21 Dec 2023 07:32:13 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id d12-20020a170902c18c00b001cf8546335fsm1794357pld.5.2023.12.21.07.32.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Dec 2023 07:32:13 -0800 (PST)
Message-ID: <3c28298e-65a0-4416-aa7c-e6756273b1d2@kernel.dk>
Date: Thu, 21 Dec 2023 08:32:11 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: linux-next: duplicate patches in the block tree
Content-Language: en-US
To: Christian Brauner <brauner@kernel.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20231221135602.12bf82f5@canb.auug.org.au>
 <f31dae39-7c62-453a-8ca5-bd0b0e58769f@kernel.dk>
 <20231221-notieren-abbaggern-98327276ee4c@brauner>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20231221-notieren-abbaggern-98327276ee4c@brauner>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/21/23 5:29 AM, Christian Brauner wrote:
> On Wed, Dec 20, 2023 at 08:11:34PM -0700, Jens Axboe wrote:
>> On 12/20/23 7:56 PM, Stephen Rothwell wrote:
>>> Hi all,
>>>
>>> The following commits are also in the vfs-brauner tree as different
>>> commits (but the same patches):
>>>
>>>   24fa3ae9467f ("file: remove pointless wrapper")
>>>   253ca8678d30 ("Improve __fget_files_rcu() code generation (and thus __fget_light())")
>>>   372a34e66fb7 ("fs: replace f_rcuhead with f_task_work")
>>>   4e94ddfe2aab ("file: remove __receive_fd()")
>>>   7cb537b6f6d7 ("file: massage cleanup of files that failed to open")
>>>   a88c955fcfb4 ("file: s/close_fd_get_file()/file_close_fd()/g")
>>>   eac9189c9619 ("file: stop exposing receive_fd_user()")
>>
>> Hmm confused, assumed vfs.file got rebased again, but doesn't look to be
>> the case. Christian?
> 
> Nope, vfs.file definitely didn't get rebased. That was just me being
> stupid and not merging vfs.file cleanly into vfs.all. Sorry about this.
> Fixed now.

OK good, thanks!

-- 
Jens Axboe



