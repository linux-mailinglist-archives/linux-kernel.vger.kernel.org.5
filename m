Return-Path: <linux-kernel+bounces-147019-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D49698A6E48
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 16:31:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 119641C2279A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 14:31:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20E5912DD99;
	Tue, 16 Apr 2024 14:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ca2BeV89"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF46112AAE6
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 14:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713277841; cv=none; b=eCTnQtcc17aI7UAxtJlMF9UP7vBKlJGy1EDD47bYRfHT1OYF9WDpDgUXoeZn9BF9hUV4D9dq80MJ2tJvQtavDVKkcZ30eDVTGu4xUUsk3KFGNbY6jIdEBvynBP7q6chIJiN9WKR8eEBYX1U4tT76VAoAV8ezPl9bqNkGRuRo7rQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713277841; c=relaxed/simple;
	bh=CAARwFVs3yKtCFYh6SSnNVSgkeqkGD+D2UB4mgMiryI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G2zZWScykXymYeGyH8p7k/7wYhpSZruR4p8JDmEV1c0jmjuzAot8E+BZ005QIhPXF0PR+VAM75AJUayzYrnF6+jdDMyOXkyW4C+KGrr2ek92Sl8Ej+ccdaCLPBjGepOkB7SLGY5Y2twaBB0s0KmACfuMSz0EQLD9Boy8o29Wd4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ca2BeV89; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-516d4d80d00so5492663e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 07:30:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713277838; x=1713882638; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qtlZKHIIRTPrmMPlNl8Y4g3IVRv6I4I2Gd41GRQ6SNE=;
        b=Ca2BeV89Guy6F32bAlZwvBBu+IIfV9BGYU2y4i2dQl3lcI+5qbmD84jaxX5KpcSc5k
         tw6ZHUXgC8zpmojotXgwUYTQT8LZ3gMoQDTEASVUrYA4nKmxepySJvtt/4dbjomCkt9t
         tfgtGdjDaNpiUI/U4XaihQ7rYx8C5pZL0hQGQIweCzekCP8nTRNG0RIqr6wfVepq0D5L
         kzjxS97DpHp3RpV+bQer2ymb5G5EJygtAbBaLheE0W6qnAVUg7cv6bdEP+DmInLWUiSg
         QUqCBjwcJqw5B+YpiiVG8Xpr68C+HhhVmem4O6tA0T3yBnxgZG5qbAocng2SjDDGdlv8
         O03g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713277838; x=1713882638;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qtlZKHIIRTPrmMPlNl8Y4g3IVRv6I4I2Gd41GRQ6SNE=;
        b=NipxzNDmQspcwr2asJe5pemmwWQu9yKxy7lzmbdCRwCHsycL6af737LZhSlunJVXJ8
         G7EhGue2K2/UbwfRhcWwEWp4VLvN7EzQogceJzwhSdxWlk6sy9U4shNGVPeokgR81+fa
         GKEZLbEVRGZmuo/iUO+pI+1l23jm0Z3quA2QB8yvIScdgLK6/rpQttk6ly69+YPa8Bdv
         15ZTZllznslQToCnlakfBwivXGF3tEvSNzuakFDC0FZdeBiquUd4W+7S4HtHREW7GZ3y
         YcYqi/6efk5+wmgRuGnNKaAGlahhZwHjPtrSQ6B6+kj8xZ8kK+Z9K8eIM+AMf7clRvae
         2Kkg==
X-Forwarded-Encrypted: i=1; AJvYcCWQyQLk0hdPVN9o2WdW4ry0dBUZV22OcejPedIE2VkC5TXAYvWwFkbVDmmQds6px4oZbZy1oB7fkgmwdaVEKcnSPUhvjMbnCSD59W24
X-Gm-Message-State: AOJu0YwKU22gCNC6j42eHgMRsfmv/NP9B7A+PXuXoN7VzD9cm1nC3XuB
	MhDriWogMBNOsniQnKGF0ZqiRVQ0Z/lEWEcHC9ooPZ713sDgrBWcw9sGmbCf5zo=
X-Google-Smtp-Source: AGHT+IEMK3ToPpFre8TBGqqiH04egFU2RIZe5ZOa5Ve6c3up7Osw5BJsl/VXC/ZDiEBh5lIfs2bIVQ==
X-Received: by 2002:a05:6512:280a:b0:518:e249:c10d with SMTP id cf10-20020a056512280a00b00518e249c10dmr5163603lfb.37.1713277838030;
        Tue, 16 Apr 2024 07:30:38 -0700 (PDT)
Received: from [172.30.205.49] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id g8-20020a19e048000000b00516d2c05b3dsm1633547lfj.299.2024.04.16.07.30.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Apr 2024 07:30:37 -0700 (PDT)
Message-ID: <548f4b0e-b765-4184-8b90-eec7fe0e7f69@linaro.org>
Date: Tue, 16 Apr 2024 16:30:36 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/8] usb: typec: Handle retimers in typec_set_mode()
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Bjorn Andersson <andersson@kernel.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org
References: <20240416-ucsi-glink-altmode-v1-0-890db00877ac@linaro.org>
 <20240416-ucsi-glink-altmode-v1-1-890db00877ac@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20240416-ucsi-glink-altmode-v1-1-890db00877ac@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4/16/24 04:20, Dmitry Baryshkov wrote:
> Make typec_set_mode() also handle retimers in addition to muxes. Setting
> the USB mode requires retimers to be configured in addition to just
> switching the mux configuration.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad

