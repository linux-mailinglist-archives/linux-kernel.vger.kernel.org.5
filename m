Return-Path: <linux-kernel+bounces-137592-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DA36889E45C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 22:28:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 805851F22649
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 20:28:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C6CB15820E;
	Tue,  9 Apr 2024 20:28:09 +0000 (UTC)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EE668562A
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 20:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712694488; cv=none; b=lFEL77Fp8lhYlKQyns24d4us6srPv9jTaH09qodfJfjg0DrCqL9v4k8asz1K9oNunrwFhRnxWLH9W8AEDBgSJcEOeGxMSaTL2gZcXm+Py+NYy66Cq44Wt79KbgaS4E0BYurHAEo8ox4yFBX7biSjgzDt1OJBuaGZvyHx77gYCWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712694488; c=relaxed/simple;
	bh=dDKLW8Vda1EOTDIWVyntcnhV0aZcCM3F8o1fDN0biGo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AIidSvAMthxXR61Yw80vEyl6r++KLG6v3yRyhValkW9jR1kUxe3E70pzntZMr408X2eUP4k4FGW86TP65yzkdBel3/o8r6J6W3UmBGp85MoPcpb4C98vLvssoAVa6InMqPhX8kFY9UVanQEtNIufmNDJSX5B6u3cAgBvMuQCTtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-416902dfb4bso3675845e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2024 13:28:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712694486; x=1713299286;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dDKLW8Vda1EOTDIWVyntcnhV0aZcCM3F8o1fDN0biGo=;
        b=v1T6pQfSbkNSbQHT+rFFOWZcLxLmZs3sJ76902shanElfPeqVuzQQt5aS8pMgvt0gm
         EXual34Pyqb2GMHuBpu/iN4zBZJwFQMHe94m4FEb779uRJDIdFnkxZMaAInBTP5eDVbu
         wLpgQwPQoDwE4QsaPRJy3PXNpVOHwJ1WLRLCMkDs48x9pPbOZhQ7Y8y8d6Eun1VUs8d8
         2txAF0sBLIdkup73ZX0rsUhojvhYpaXlhsSNyDow0XWS8WDGGXVGPLrn00zoQN8LMOI+
         85ptiNlLwKFWXNTmgzfet4V/EAaCxeJw4zB1Bj2jBoRzNmby8yBcdXxIxfjtv5V8aTld
         hAmw==
X-Forwarded-Encrypted: i=1; AJvYcCVfux6/kfPl2ZGMMflLi+gOjZ3zL/myBg6uppqzEUZhRON2MzoUA/NH3FT+RjgWQuxgkfH9P6FGXQavi7/l5yi347bzK6Y+y9qNBS8m
X-Gm-Message-State: AOJu0YwzcgFD1+GVIzCEaXgApfuAOdE0QAQt2g8lWrclQoFaxy46Hngr
	PPRxbhP6PODAA/bDZGtaRpa1Hine1XE4MYxncaJxtVWRxKdER+8F
X-Google-Smtp-Source: AGHT+IG2oKybZ/vpNLz4G/LmBDYs1vE20g/HCsYkCpwVxafRYg4FBFY0Z6es4kdn/mW5M2qNYJpkxw==
X-Received: by 2002:a05:600c:1c89:b0:416:9877:c8bf with SMTP id k9-20020a05600c1c8900b004169877c8bfmr546930wms.3.1712694485444;
        Tue, 09 Apr 2024 13:28:05 -0700 (PDT)
Received: from [10.100.102.74] (85.65.192.64.dynamic.barak-online.net. [85.65.192.64])
        by smtp.gmail.com with ESMTPSA id c12-20020a05600c0a4c00b00416770871f7sm16077wmq.25.2024.04.09.13.28.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Apr 2024 13:28:05 -0700 (PDT)
Message-ID: <50a7e52a-c590-4281-9168-55ed7d5f2f3b@grimberg.me>
Date: Tue, 9 Apr 2024 23:28:04 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 4/6] nvme-rdma: short-circuit reconnect retries
To: Daniel Wagner <dwagner@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, James Smart <james.smart@broadcom.com>,
 Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org, Chaitanya Kulkarni <kch@nvidia.com>
References: <20240409093510.12321-1-dwagner@suse.de>
 <20240409093510.12321-5-dwagner@suse.de>
Content-Language: he-IL, en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240409093510.12321-5-dwagner@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 09/04/2024 12:35, Daniel Wagner wrote:
> From: Hannes Reinecke <hare@suse.de>
>
> Returning an nvme status from nvme_rdma_setup_ctrl() indicates that the
> association was established and we have received a status from the
> controller; consequently we should honour
honor ?

