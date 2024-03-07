Return-Path: <linux-kernel+bounces-95069-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 401708748E3
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 08:40:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 423FF1C211CB
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 07:40:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8319763113;
	Thu,  7 Mar 2024 07:39:57 +0000 (UTC)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66846629EE
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 07:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709797197; cv=none; b=fNhYQXtAtZwSU0gg8Vlp2pVO6RO83hHTpdUsdUid3LNJsHCVg6I2z0aF0wrcjH2SKXPALYCwPjY/66MP1V06yqx/p1SPkxbPYocmH8EWpTeAiBaKMxwfFFr43C4ednCxRcoWwi83efe4XI/I2opcLltKEXXudsdeonXBcJBTwyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709797197; c=relaxed/simple;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ks8S8hGt9He+janFHLamNkjBhMnw/1yYp6ANf6xAS19qQLDb9LbyT6Q7AHsfe6Pph4EHbfzA/lYaZgScxn0DyAZfqmrTZme4cPF7OsyTzeQrK9JxX/yyuTBt1ClxqjS/H/UUlCHGaDhVp+ZimJOZEGDCa+ytXBhz0hwGatUQwCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-33db19538d0so140445f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2024 23:39:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709797194; x=1710401994;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=Qapn1xZgsRDLh/lZ8/Z7gzo5Eza49wVSp6zWt2CluwLv10BzAuH+e4JDaJ9n5yAXLd
         VSOfL29BcJr1Sa0s0Wum2DpmiacT7ah0jZZpUiNDN/FkMZNLzbrNG2/8Bnr/A8eNEPKs
         62rBUYVyaIQP6ku+Rw4XpXg5rwXzPSv8c5vqMg3Y6vHujAt7uCl64If6sgtc8mNHNQ1b
         vdU1p0ekfD6UHBHoi9mNRgxLxLYJf9On42JNXVJZAVdVd940EfpY4x6buXLsW+efySw8
         4THCvMuPdCUpwK5mrm2GCCSFKU5MuhEATZB0oYcPPkx/NqwD9lSBk9G8UdR+rWPfbmS0
         f06w==
X-Forwarded-Encrypted: i=1; AJvYcCVs8Y+d3hfpRIFDL9U1pTO+1dlvCxTfJsgXGlUMTFMO38ud9HKGDOjBOj/BIl3l5EdRDFRAMvTDYP07/bj4WRlAk39OLrH5/kcglKGU
X-Gm-Message-State: AOJu0Ywu90qzMX8OtBMVQq8sTgwhtvjTi48HHhFzbjKEQRDxNpG/5rAh
	jOAId7nrTS/8PbaiMcW5iqiPXuiUWNtVMNNxmoNEZpLHaO7juLxI
X-Google-Smtp-Source: AGHT+IHHA6QKnLsezv1ouyL4F6PQAR02XSpxiQiCnDoo76btFiTKNzBGsZ1UC4cGPITyjK4VMXd2Ig==
X-Received: by 2002:a05:600c:444c:b0:412:eee0:a5e4 with SMTP id v12-20020a05600c444c00b00412eee0a5e4mr829823wmn.1.1709797193445;
        Wed, 06 Mar 2024 23:39:53 -0800 (PST)
Received: from [10.100.102.74] (46-117-80-176.bb.netvision.net.il. [46.117.80.176])
        by smtp.gmail.com with ESMTPSA id je13-20020a05600c1f8d00b00412fb4f5756sm1696207wmb.27.2024.03.06.23.39.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Mar 2024 23:39:53 -0800 (PST)
Message-ID: <91726839-6c3c-4b22-adf4-380239e45fa3@grimberg.me>
Date: Thu, 7 Mar 2024 09:39:51 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] nvme: Use pr_dbg, not pr_info, when setting shutdown
 timeout
Content-Language: en-US
To: Len Brown <lenb@kernel.org>, kbusch@kernel.org,
 linux-nvme@lists.infradead.org
Cc: maxg@mellanox.com, axboe@kernel.dk, hch@lst.de,
 linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>
References: <49a7c0b667abe23d95d67cf0cf7ea7e193d9f2a1.1709773065.git.len.brown@intel.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <49a7c0b667abe23d95d67cf0cf7ea7e193d9f2a1.1709773065.git.len.brown@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>


