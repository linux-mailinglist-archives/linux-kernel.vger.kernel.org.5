Return-Path: <linux-kernel+bounces-147029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8982F8A6E67
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 16:35:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ABF211C2292D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 14:35:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA413131186;
	Tue, 16 Apr 2024 14:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="czGt5a0D"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E7F8130E44
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 14:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713278026; cv=none; b=r2Nu8ACsJcvte8+DjeB3MGPtxhaiZyq+IDjFC+6gTnodFq2BqQ95Qak7pML1R8cctgRPNbLOYzYUIyGuorX5rmi5/yJlBz5Bpcc/tQdXcmWlbxLv1CssG9jk7a2erjLc16xktf0vE/tRsgRWbB7dD7gjrlXiZsIkOBAK36MPSi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713278026; c=relaxed/simple;
	bh=FUyv0NtfjWgQR6OUBvhEgz4KRfytTZXEfryXpJkG4jE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P2UUKaTpPkLGu+2VMW35DiiisEjqhPDRL8Oe84/TCaAOmdDa8HIs3gr5DnUX376EqxuJ73GwKvqhGboRFYYm6Zcs/q+Pn9aA2tE4nX3UkSxZfp317z52QJj+AIybFpTNrLGAqOyf/dwW83ASTkaW5zWmSG9giJl3DKTUnXh/jAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=czGt5a0D; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2d82713f473so83703331fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 07:33:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713278022; x=1713882822; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=c+9nPjOVu5Pf5mma6CPtxz0axFmvz1ttoYWLOCI1v/I=;
        b=czGt5a0DwOl83Zbn4NKU/IK2/IP39vVqczik2HdZk+PlEyvSEExDWz97SJjJ0h7xXo
         itw1nuMB3k7MBqMmS69mQpE9lYDeR3Q06+asvmMCBSbYPvhiVghLpF6BVqfQF2Ej6Zrh
         rKnU/qUerTtTXuG85fR2K8nBuKYnCwma4X3hT2eQfraDSqafwE95oJoblIkuhYWOAtKD
         eZrw0eA/vNnGg6VayM+SQkPUOm7a6ouqNGbVQ1oGxMr0VPMMGIA8/rxXbmi0SfYGSObv
         5d53k1dfkVNbmueO8vtfXI97J3TYiHIb4PLKPQw54jxvIcduRkUv4E4naeCtWVZPc5Mu
         XzPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713278022; x=1713882822;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c+9nPjOVu5Pf5mma6CPtxz0axFmvz1ttoYWLOCI1v/I=;
        b=X34klbgrqBlv9NtF7e8T+i6GHtqHrBWH4CnKlDoMjeBvP/EHABlCV6Ns2SCqZ+purT
         a8Up+iDYJjbKCwbdU24BJ1ziLzu86UkxvTAKvSVZoJQmKueix6h6wDXCXwVFAI6pYdyR
         iP/SyDYTaO1a2sZ0ZBqIqxygJNjePNkeD5jehdtwB9WpNx8jLNdfnY4ZiPM0wwXWpiLq
         iyRf4Uh0AN8OxP2mNJYyoBr7d8OYjD9Bb6oRmQfwZzHRdZGiL9A6bWvwjsWC2wcNIlLO
         byBddPfLvGpdh8aQJNSegwmBMRrN18QFAKGNmgjF1FnHX7EMQeBYF08S88MlFk4qXfZ9
         89Lg==
X-Forwarded-Encrypted: i=1; AJvYcCXgKafkdspjVkQNiNDehtOYzgjts/aJj+X4tz89NacPC1NW7ob/gyH5kOFr47VrlvYPCtXJ9Ty75CwX1bxAGTgnFP6z03JvbFeGcRte
X-Gm-Message-State: AOJu0YznuCoyqGAJYUuXoJy9y6/VkPrlsAGCGra8H31oOGvnCHA+aTxQ
	5IHtHwHx4WnZOCBsbfSd9EpqF3KaTiRy2JXcZ+H7UvmiXwpw6LpHFGlnmeBgTwQ=
X-Google-Smtp-Source: AGHT+IGL+ME3YooCYObcuCO1LfAPA5J4bnpf8IzOPa6orBn1PpHGOydAs/es6+R5/yPtPUtVbGF1LQ==
X-Received: by 2002:a2e:908c:0:b0:2d4:5370:5e8a with SMTP id l12-20020a2e908c000000b002d453705e8amr10336108ljg.22.1713278022601;
        Tue, 16 Apr 2024 07:33:42 -0700 (PDT)
Received: from [172.30.205.49] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id y1-20020a2e95c1000000b002d2d1c11703sm1587994ljh.76.2024.04.16.07.33.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Apr 2024 07:33:42 -0700 (PDT)
Message-ID: <1545d3fb-88f3-44e7-b981-610df6bdf6f7@linaro.org>
Date: Tue, 16 Apr 2024 16:33:40 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/8] usb: typec: ucsi: glink: check message data sizes
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Bjorn Andersson <andersson@kernel.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org
References: <20240416-ucsi-glink-altmode-v1-0-890db00877ac@linaro.org>
 <20240416-ucsi-glink-altmode-v1-3-890db00877ac@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20240416-ucsi-glink-altmode-v1-3-890db00877ac@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4/16/24 04:20, Dmitry Baryshkov wrote:
> The driver gets data from the DSP firmware. Sanitize data size before
> reading corresponding message structures.
> 
> Fixes: 62b5412b1f4a ("usb: typec: ucsi: add PMIC Glink UCSI driver")
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---

I think more backstory would be beneficial here.. Does this happen often?
What are the consequences? What are the causes? Can there be one-off invalid
messages, or does that mean the firwmare has entered some unstable state?

And I suppose, if answer to the last question is "unstable state", are we
doing something incorrectly in Linux that causes it to happen?

Konrad

