Return-Path: <linux-kernel+bounces-96796-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4491487618E
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 11:10:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D83981F2324B
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 10:10:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88A8654BE4;
	Fri,  8 Mar 2024 10:09:54 +0000 (UTC)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9251854BD7
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 10:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709892594; cv=none; b=aPzDpmJy4Try/psWyBvwpjQYX2DmE5jWJzyaaXqWGee3cMvvM7rHZIdYok72Z+4zECWlL7g1Q18ND0JzDtFcKlaf3zF9q0WJtxTj1VzK6IT2WX6te4nDpyJZc1SRMDRjc0qnjeD/c9DU8wWY1l5RfeWwefqfhBxdYY7XWqDW28M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709892594; c=relaxed/simple;
	bh=iqZQrV/XzwOsxRcoa9RzarjdIIcoC8TyED19bYZr0Wc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O3ASOx08Gn2aGGvqLpoYtbpz5w+wWq75Tsuggi7mKYk5uJtYEA2/4gyoHlidyNzWwmhqR9wZ52m9qnq+wTig3qk3MZe0H1qCMsuLHMdeUEKytxUlYf8P7l+oBhq5i4T0QK0N0EoiljyW9/TuQjNFM2yiIaidskoMcHL7G8VQarU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-33e79eca772so31444f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2024 02:09:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709892591; x=1710497391;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iqZQrV/XzwOsxRcoa9RzarjdIIcoC8TyED19bYZr0Wc=;
        b=dREeCGlaHuCFAkZ2bG3POwR1/rDjis6W7rUoLM3/UPoeWSCC7guYmGrlM2BgMmtg3k
         YcgeOxrbmWYqw6nYlGIVwi5vyQOStTWSV64ApBX3Oz1UK46nX5tDmIiD+F/FgEzQdHJk
         7GORcnLcJHK0mmUgOIleKX6dU08qDN9BtFnQ9+Demcg955WwSj6+65v4Yap8x79W5zXc
         eGaosll3kid7vAvQQE25DCGgIzGD33gdQt9D8bhiB15fzMBJ6C6vtz8OhBDvu5q9eKB6
         wFupiIncQWGa6r2NYBEOnjiSf5faWddJBM5YL6w0anZL1RRpwN73ITukySFFrCh6yS6c
         NUeQ==
X-Forwarded-Encrypted: i=1; AJvYcCWG1iiNqP9eWKuaJ6QsgtPJdNpW0DHNZo0MmhbVsDVQeRECdX5r4NGA/kdGcgNhMWd6hxJ2bgJ90zCD9zH/N6fmDd11dMlkYtPBckNI
X-Gm-Message-State: AOJu0Yx2VwII6qljaDwtrf7mCp9IwXl08+jEsunqPAnsur3s91Kp7z+G
	i0C+fWuuW+Pv0EmclDBcYg5/UNh2SxG12g4dgJ83JgVJ+WfmnGAM
X-Google-Smtp-Source: AGHT+IGPiOezysgKiskWm4w6mYNdeHoKKtPk5JWEyQfa75/eSn4zbs2x/KvaANk5jvOWJ/MpzqaJ6A==
X-Received: by 2002:a05:600c:5009:b0:412:f887:644f with SMTP id n9-20020a05600c500900b00412f887644fmr1023843wmr.0.1709892590718;
        Fri, 08 Mar 2024 02:09:50 -0800 (PST)
Received: from [10.100.102.74] (46-117-80-176.bb.netvision.net.il. [46.117.80.176])
        by smtp.gmail.com with ESMTPSA id ba27-20020a0560001c1b00b0033e68338fbasm3537593wrb.81.2024.03.08.02.09.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Mar 2024 02:09:50 -0800 (PST)
Message-ID: <2bed335b-b5d4-4dc5-a934-f0f04f9c54f7@grimberg.me>
Date: Fri, 8 Mar 2024 12:09:49 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme: Re-word D3 Entry Latency message
Content-Language: he-IL, en-US
To: Len Brown <lenb@kernel.org>, kbusch@kernel.org,
 linux-nvme@lists.infradead.org
Cc: maxg@mellanox.com, axboe@kernel.dk, hch@lst.de,
 linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>
References: <63ff4f9aedcb73ec5d8cc7f3e77ec4c72d72b4ae.1709839023.git.len.brown@intel.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <63ff4f9aedcb73ec5d8cc7f3e77ec4c72d72b4ae.1709839023.git.len.brown@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Whatever is taken...

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

