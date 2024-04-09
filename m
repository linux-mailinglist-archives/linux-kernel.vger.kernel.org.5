Return-Path: <linux-kernel+bounces-137590-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C203789E451
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 22:23:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3A021C226ED
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 20:23:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 568BF15820E;
	Tue,  9 Apr 2024 20:23:31 +0000 (UTC)
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C5B18562A
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 20:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712694210; cv=none; b=J3eejNva0/isIH6xOu7WY+FMH/l+muh6vPbH41PCpTQ9mTkyzTmWC+6lUyPYYUYijiId5tmAnUbZBFPNRW8OqVwy9Qoxd00tfRn0N2aL+6LPY8x2IpIS11pqyl0DWeRNLeii7HX0sE2oetBUnLKl/8Z+0sVpRZBK4tEWPw4vUcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712694210; c=relaxed/simple;
	bh=QCOR0WJudJbzjB5pv2Hf85CU5+m3kodzezwqXEzi7ZI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Mpt3tnjyV9ZOleQfEUAvmVw1SyOUHtMjE6KWnFhhv7iVJrRO2yHSqUckOALRU1zXKwf6NbiwEN59yJB5q5P/ZMF4oa2WqRh1Kh6Udr6EGknl6aWGr3T5XXV7LqgPTI2ygO2xVEhefzzlJLwbr643u1BroFKjB6Zm8y7Up80dqSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-343c8d7064aso998906f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2024 13:23:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712694208; x=1713299008;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QCOR0WJudJbzjB5pv2Hf85CU5+m3kodzezwqXEzi7ZI=;
        b=UXrA1ofCfEceSHEc80J6GdmE6kYUh/pb16+Z4vcX3gEAOlZZLSDE4D0MJzO8K/GpYO
         MZC5Ywtzuwq/N1hRvw3WSajBJJo+WEHa1d2rXSdRHHjL54HTUfmCDLRkPIiMDibBryfg
         958NaNdLyUCFrMTWueeTOxzqCIkAQi+CpaKZh4Iv+VjfGqT7amTL3EYyJNOP+mdRd/eU
         Teacxay0wewG5jbD3MeOOWe0W9llzvQMZqK/2+wtCpR4ODeO+pjzuQZoe8YinWHqBlrc
         SVZX311oLqYlqF5tmGLMsHGBAgyxG+MB/cBmGlbarLGo6IqOHtb6ikAwoN2Iw/4vO43V
         ZJDQ==
X-Forwarded-Encrypted: i=1; AJvYcCXL3WVRc8tmOn3N1hSq02ZAwn4f3fHSfs58JtOZXnPipRH+H9nFrjNGflmQTbMMbTLjCI9tuzC5extEBPG+a8/wBModKtOo/TFPyj9N
X-Gm-Message-State: AOJu0YypY0caG4cVgi0t+AgZWM6urERBNDyhIla9YxwdgDfPrNZHxpe0
	zIlg7GmGzFSVA9jpktelV7DKXSpGLokUdG/a96BCOyf1nHIGsCU2
X-Google-Smtp-Source: AGHT+IFnaFGh5uosiCZ9pYjIkJ0Yrx9c2LHdTt/7noZRXAhQS4rHVxW5Vylh/D3s5fo/SVsxcj2Zgw==
X-Received: by 2002:a5d:51c3:0:b0:346:408d:4341 with SMTP id n3-20020a5d51c3000000b00346408d4341mr495890wrv.1.1712694207679;
        Tue, 09 Apr 2024 13:23:27 -0700 (PDT)
Received: from [10.100.102.74] (85.65.192.64.dynamic.barak-online.net. [85.65.192.64])
        by smtp.gmail.com with ESMTPSA id f13-20020adfdb4d000000b00341c6b53358sm12222367wrj.66.2024.04.09.13.23.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Apr 2024 13:23:27 -0700 (PDT)
Message-ID: <f8c84937-a3e6-479b-b6a7-be5affc9a937@grimberg.me>
Date: Tue, 9 Apr 2024 23:23:25 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 6/6] nvmet: return DHCHAP status codes from
 nvmet_setup_auth()
To: Daniel Wagner <dwagner@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, James Smart <james.smart@broadcom.com>,
 Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org, Hannes Reinecke <hare@kernel.org>
References: <20240409093510.12321-1-dwagner@suse.de>
 <20240409093510.12321-7-dwagner@suse.de>
Content-Language: he-IL, en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240409093510.12321-7-dwagner@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 09/04/2024 12:35, Daniel Wagner wrote:
> From: Hannes Reinecke <hare@kernel.org>
>
> A failure in nvmet_setup_auth() does not mean that the NVMe
> authentication command failed, so we should rather return a protocol
> error with a 'failure1' response than an NVMe status.
>
> Also update the type used for dhchap_step and dhchap_status to u8 to
> avoid confusions with nvme status. Furthermore, split dhchap_status and
> nvme status so we don't accidentally mix these return values.

What is the implications of this on the host behavior? In other
words, why is this a part of the series?

