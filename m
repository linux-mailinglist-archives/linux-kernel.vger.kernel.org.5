Return-Path: <linux-kernel+bounces-165142-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 240378B8896
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 12:27:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 552D71C226C8
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 10:27:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0552B535AF;
	Wed,  1 May 2024 10:27:40 +0000 (UTC)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE5A8524DC
	for <linux-kernel@vger.kernel.org>; Wed,  1 May 2024 10:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714559259; cv=none; b=H240EHVmRaF+jeUiAXZxPc+Zfmh0U4YmfWM05ogd2RSmeUyqfXkj3xjY644cG2NalCWQNJ9yRTdD/RIrZO5zn9YXQKY39rxQJSaq4mBjI/1KUcSqCPWd3XMxRMLyzN3a57aOLwtRNguegG6Wkj2cjnvXgeFjJdvZ7TL1m3WeYHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714559259; c=relaxed/simple;
	bh=cGWvhIgXrNI2O6VT23pX5aJQXgnkmeYOaGQGYm6iAHE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f9o7nSdKpBhkHNvaWLysmToPq6uvOp2bCy327lUNppnvoajJgB0iU3mApQRo8T/zNI/vlSrQJy9/BQZxqUXPaxlZYUp2kSjpoTW66cPEl2yCmjgaWt0JolQ634zytbhfs7duLSpAWM6XtsOx9/0VIogmUKJyxWuJ3Ace0APxYNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-34aa836b948so1133726f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 01 May 2024 03:27:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714559256; x=1715164056;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cGWvhIgXrNI2O6VT23pX5aJQXgnkmeYOaGQGYm6iAHE=;
        b=PJnJaEyFZWhLvFYk56rgUYQc+xEcLU2T4TDyYGkigkaSxsL4D4VsJbgTgdktYdAXl6
         QHmV5HHqqBU/mShJCw2LBfnR4BnBLSRBlpo1j9fkz5Y3TkQdMw9X+DhWllxCU3r0hb0I
         ymbSGxP0EK4hHHFbJPBUabFW77SPIMv/LUIxchavUPBvcJifIqXJxV3+YMbNa6NYBKqf
         09pYJeskd7wV0oGx/e1OcPYMvK80xMeztRSKb4x9nBhNtxL1Tk3eKa7NHMD9dGbfc/OZ
         PJ1H+c7D1QkRKZhjcZX8d/HnLXR/ZkRbJhp7KF2D+R4OW1j492OzFS7JzFAf8ONcoC/Q
         O3qQ==
X-Forwarded-Encrypted: i=1; AJvYcCUs0dH4T9cLtIqEAmPBwwKv9fdpJ3uE8FZKBhP72ahsYC9xQVG7AjCMnBPeQ/CtE4nhRz3dNUVwMq1bH/tM3UHT/Kv+IDsQjJPdWZ9t
X-Gm-Message-State: AOJu0YyZufTfewx0bUDb31gVTyM4EECpl3ef52UooxUHr8drT5y1mQsW
	dvY/NdfQTCSrEiKlkud/CEUKYFywQrQDwpKPryRYBsvZweRm/B9Y
X-Google-Smtp-Source: AGHT+IGdo7WdSn7uiTyrlyHt2sqja0G+7Zbm23lHxjfFi1wsrQsC4k2QcR2AqvEHWLQDICbuhjAirQ==
X-Received: by 2002:a05:600c:138d:b0:41b:fdf9:98b5 with SMTP id u13-20020a05600c138d00b0041bfdf998b5mr1507047wmf.4.1714559256137;
        Wed, 01 May 2024 03:27:36 -0700 (PDT)
Received: from [10.50.4.180] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id v17-20020a05600c471100b0041abdaf8c6asm1755829wmo.13.2024.05.01.03.27.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 May 2024 03:27:35 -0700 (PDT)
Message-ID: <8f7fae86-414a-455c-8e5d-332c3c78cc60@grimberg.me>
Date: Wed, 1 May 2024 13:27:34 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 5/5] nvme: do not retry authentication failures
To: Daniel Wagner <dwagner@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, James Smart <james.smart@broadcom.com>,
 Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20240430131928.29766-1-dwagner@suse.de>
 <20240430131928.29766-6-dwagner@suse.de>
Content-Language: he-IL, en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240430131928.29766-6-dwagner@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 30/04/2024 16:19, Daniel Wagner wrote:
> When the key is invalid there is no point in retrying. Because the auth
> code returns kernel error codes only, we can't test on the DNR bit.

I still think that this patch has issues in the sense that in certain cases
the controller can suddenly disappear.

