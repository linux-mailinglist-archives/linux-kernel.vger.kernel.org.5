Return-Path: <linux-kernel+bounces-137584-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 452C789E444
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 22:16:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76CE51C223F1
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 20:16:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40BE0158205;
	Tue,  9 Apr 2024 20:16:44 +0000 (UTC)
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E0A412A14F
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 20:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712693803; cv=none; b=Mgbqn9RFm02g9YiW+7OBZ50Uq8KRgWARCljm5G1X2Xtjm52/SQDPOuLgqV1W6406njWeXhZz3WzFPE7rn72pNoSOvPFyHM/36Avvi1cO91YZHJUrLhlS1wdidvPARwwQNC6CSXMXnKHFmHVcMG2+V1mpRRUvSHH+GCcyN/6sVxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712693803; c=relaxed/simple;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Nd/aDUvxh79RNFPtMBV9/+nnD2oCoUodVz8jLdqHv0atL0TOfor1ZoPGXtDoZPj6wfUxXyVLCQl98hlGswSrjmwUfm6hoiCyg7q6WD0vnt/aso8jVJvzzLTphVgVPoLYvp8LckHYU6a/bvCV8tcPQkhw7AaVsQdOC5FfIByJCzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-34666e92263so8246f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2024 13:16:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712693799; x=1713298599;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=KCoxYqxK+g+Yqp2xmLZ+Q7pVDxKJXu8enx6Mx8HGfI2iCA3Ca8VgIC9cwxTsJIso3O
         G/VU3zrS8BW2enPXJce4qD7FG0W47a7r488L+cBP0EqlVznbYy0LkOkYjf0SkjAVbvY6
         XYgGX0hYuedysqwJT2UByx5DBNwMGx+JahE/TidjAMry88mMluLvT/YU8nu5hopJBxK/
         TaBzd0oQEG/d5jwlgKP06/L2RQ3/PKatytQ8yduePoGiO8hJ+zGL0DeVRD7+mV85HZi7
         cdRHHST7C1jkAlWw0bmT8dqqIYA8SI/H4al3uRTUM+/TBPqlZBUxCEErzJf0SWasL/hg
         6K2Q==
X-Forwarded-Encrypted: i=1; AJvYcCXCAFhVmvUTzwZBZSgD8cVZcjk711f2FAf1z79ve4G42TKThxQKXV01X52d817pC5su8+EHw8S6xn8TngkyYvUOjS73V10hLGosQLoP
X-Gm-Message-State: AOJu0Yyip0aRXr2Teiwol1Rdtn3XDMN0VkJw57EcCrRXeQAVFdLHfGbf
	vNwXwx2bMfL799SeXtVY3bpqN8nvV6DlbbUc/e9lj9p6w7x4yi0N
X-Google-Smtp-Source: AGHT+IEAw8Ud/DZYXLuF0Ti4Gwfc4RZM1GUl7VCALLm99aqqj02/FLBtuP4dF6uBPZfuojYb5ihDCA==
X-Received: by 2002:a5d:64e3:0:b0:343:dd78:d82b with SMTP id g3-20020a5d64e3000000b00343dd78d82bmr549821wri.4.1712693799278;
        Tue, 09 Apr 2024 13:16:39 -0700 (PDT)
Received: from [10.100.102.74] (85.65.192.64.dynamic.barak-online.net. [85.65.192.64])
        by smtp.gmail.com with ESMTPSA id n8-20020a5d4c48000000b0033e7b05edf3sm12227562wrt.44.2024.04.09.13.16.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Apr 2024 13:16:39 -0700 (PDT)
Message-ID: <0677f10b-1f5d-4e0f-b83f-b59cc28d9dde@grimberg.me>
Date: Tue, 9 Apr 2024 23:16:37 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/6] nvme: authentication error are always
 non-retryable
To: Daniel Wagner <dwagner@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, James Smart <james.smart@broadcom.com>,
 Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20240409093510.12321-1-dwagner@suse.de>
 <20240409093510.12321-2-dwagner@suse.de>
Content-Language: he-IL, en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240409093510.12321-2-dwagner@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

