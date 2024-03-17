Return-Path: <linux-kernel+bounces-105349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB98787DC81
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 08:33:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEEA8281778
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 07:33:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC4D21CD1F;
	Sun, 17 Mar 2024 07:33:13 +0000 (UTC)
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F176E1CD04
	for <linux-kernel@vger.kernel.org>; Sun, 17 Mar 2024 07:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710660793; cv=none; b=T6OCr+7GXEXnbRByJw9u6mJwFE/fIeJRit2Lb3xqu6giPC0tLSFP0hcfsPTv/Bk3HesrW1hscSPjyXvbIancKMU3xR9VnMItl2X+p6Ug+FFM9xzTDJytgHGJQoSJu+RIzm8lo5HMaOfa/EKypGWDWz8QERq4yXqMRrYFQ8pnQe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710660793; c=relaxed/simple;
	bh=Dzf9HkPavBqg3tIvWy98WN0LdnXe6unSBkuUeEE1SEY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EhsTzlibcjbiCTQOumodB+75/O6BJHMOXEluUKvFpT5DllW7N7r0ky+lM4OJsttiPl6nTBny48/rBV2RdTeAx49ZV+L7oo4u/T1OfzspohqtWca2CaFg8CXHnqjAVY7xfGsrttOLp5If8ClWnkLSImEZn8zUOhDnQ2U2YdrbwMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3416fd2463dso13222f8f.1
        for <linux-kernel@vger.kernel.org>; Sun, 17 Mar 2024 00:33:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710660790; x=1711265590;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Dzf9HkPavBqg3tIvWy98WN0LdnXe6unSBkuUeEE1SEY=;
        b=O6PWmWOBbEv1V7h6qnMEAGEXEYBjWmm517L+9a5xLjMcNFhz9idbbydjpQ8+ezyPDK
         C/IwrCnyb22N+GSuRw1TfNAcOS6g8QrNA06vnCCWkuerPpXN2FLVBK6OPLXJG+ty1q12
         aTI1Oo5S9kM5dxivjqk+7wxIJeXtNQ5wktjJIJYteenUqPKLmjydNTNrtSDjrvKMxkhm
         rlHGotWvv1f1bdAz/1f53GvO1d6ThuH4jHQfZKZEnnLi5Ik33Lp36tz6rnmEsIe4sTmC
         jghy1VFL6Qk2zJWT+ZUJHteKIwUCCvBkDOxqMmko1IWkCoIPk6GTP0Oi3BY8v96W+J9L
         XWTA==
X-Forwarded-Encrypted: i=1; AJvYcCXlJgt37gxV9FGNqsnlLQmwKP6b3Xt4Azzwbceea1QpIBbfwF2v5FSw+mjvxf8eoBTKV5h9O9Z7QjOB2teLTWYyk1m3OCRUE5dLOYOR
X-Gm-Message-State: AOJu0YzjAHRZUJA3YKESMDXFTDNv/1KmoBPZ0NQg6mayY9G5WOMHa0O+
	bcJw0TpY7wMI4wFkKbeCP1vjs4qTxcGnj+rLpmmnox7Wh2n5czVo
X-Google-Smtp-Source: AGHT+IH6xz5FONLbWgJbpeZCcnU7KCx71IIql3lifGelyNFxEjHilP63cGBHWCq5YrJWdSIWbV2ksg==
X-Received: by 2002:a05:600c:1d2a:b0:413:f1c0:a888 with SMTP id l42-20020a05600c1d2a00b00413f1c0a888mr5259968wms.1.1710660790230;
        Sun, 17 Mar 2024 00:33:10 -0700 (PDT)
Received: from [10.50.4.153] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id d6-20020a05600c3ac600b004140b96dd4dsm1503659wms.21.2024.03.17.00.33.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 Mar 2024 00:33:09 -0700 (PDT)
Message-ID: <2db9e75c-7c17-4f1d-9328-5eb18fd86d23@grimberg.me>
Date: Sun, 17 Mar 2024 09:33:08 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme-multipath: fix bogus request queue reference put
Content-Language: he-IL, en-US
To: mengfanhui <mengfanhui@kylinos.cn>, Christoph Hellwig <hch@lst.de>
Cc: kbusch@kernel.org, axboe@kernel.dk, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org
References: <20240117065043.79192-1-mengfanhui@kylinos.cn>
 <b926d754-130d-424e-b099-001e14badc50@grimberg.me>
 <20240117143952.GA27918@lst.de>
 <c934831a-ec84-4ea4-a156-782880086ffe@kylinos.cn>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <c934831a-ec84-4ea4-a156-782880086ffe@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 14/03/2024 8:13, mengfanhui wrote:
> Purpose that to check if we ever added a live path (using
> NVME_NS_HEAD_HAS_DISK flag) and if not, clear the disk->queue
> reference.The purpose is to perform security checks and remove the disk.

Does this issue happen in upstream? If it isn't I don't see a reason to fix
a non-existing bug here.

