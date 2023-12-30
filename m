Return-Path: <linux-kernel+bounces-13564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FE62820819
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 19:04:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 886B61C22063
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 18:04:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57D1BCA73;
	Sat, 30 Dec 2023 18:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HE+Zh+8p"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6839C2C5;
	Sat, 30 Dec 2023 18:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lwfinger.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-6dc1fe0889fso1421762a34.3;
        Sat, 30 Dec 2023 10:04:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703959447; x=1704564247; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=fpYHdg9CMaw6456egcFr0yg5mUTzURSDHrDt2C+JeYc=;
        b=HE+Zh+8pFO2ieNbxqgTwBhpGjMf1OeNdk4iyzIezJB1OJMs89w7vOurR1PbvVqa1U+
         o12sWzptz8euZYfw39jwnx1HoUfKSfCMZNE6PYPoH/WWUeWuA6sJMSA061kIEoKDgnub
         95J4DTb68z7kVdF8FAjB7Gth5qwqlRqtXsGh7aWmQmzadxKA2kFmjy+BEC94lpGyMxbt
         8Lem7Nouu8/IaEv4QYNYIrlbU7CHrGnfKT2fdkMWUgc9TiihErpZ5BBFuLkVEmFrQDpW
         PtbY6VAZvrpBtXa/2NvZeB3AKJqzlV22yM9PYja3mu+BRSUaGuDoQhrYQWlefpvUf/Qt
         gJ5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703959447; x=1704564247;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fpYHdg9CMaw6456egcFr0yg5mUTzURSDHrDt2C+JeYc=;
        b=jmHeTBCSESmA+ktp4NNteuYXfDpVBqHXkRsBCJB4KTQ0L4ic4EIliMe587mf/NVN/Q
         1LpN2HQAZju3T1vCPUvCBLCdJwWcEbYi+5emrNzlKV6y4E7v1GgJEbz1zmtp6XKAIcT+
         /cQr/htNn4ViWYWBtqTE9fWfGf70/TzcKWRnKF4k93VQ7+oaQWKS8HKTjn7Q4m4n+foL
         G40BAGmsafSsjELNpXBldGSxDR5hXj8mCW/CdR8n/dVMV9M9dqttPrkFyj/Xewhu8uOO
         M7ruuDDMiamdF9pBopzd9eh6RJKzyRj4HnuIa+pt04RdyakwSI2G3V47z3WybgCzejAl
         iN+w==
X-Gm-Message-State: AOJu0Yx4KiOpMXsfJGIh7YxCUO1jRGoUuRVCRSfZ0mwcHxPC+sqJDv9v
	GPnkEsJ82Zd7tKtUzTv8swk=
X-Google-Smtp-Source: AGHT+IGBLhlO2DsQhJl5YasbkNy/gvJ9k50GfzbjjS5fKNPrcVEIk2qhepd9yVSpqToecPLdE0nZEA==
X-Received: by 2002:a05:6870:c6a2:b0:203:bd9f:3be5 with SMTP id cv34-20020a056870c6a200b00203bd9f3be5mr15703938oab.106.1703959446795;
        Sat, 30 Dec 2023 10:04:06 -0800 (PST)
Received: from [192.168.0.162] ([216.130.59.33])
        by smtp.gmail.com with ESMTPSA id q9-20020a9d57c9000000b006dbfc48c7f0sm1437696oti.63.2023.12.30.10.04.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 30 Dec 2023 10:04:06 -0800 (PST)
Sender: Larry Finger <larry.finger@gmail.com>
Message-ID: <cb9dcb49-ad94-40df-9f01-a28df3daf6c3@lwfinger.net>
Date: Sat, 30 Dec 2023 12:04:02 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH wireless 3/5] wifi: b43: Stop/wake correct queue in PIO Tx
 path when QoS is disabled
Content-Language: en-US
To: Rahul Rameshbabu <sergeantsagara@protonmail.com>,
 Kalle Valo <kvalo@kernel.org>
Cc: linux-wireless@vger.kernel.org, b43-dev@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20231230045105.91351-1-sergeantsagara@protonmail.com>
 <20231230045105.91351-4-sergeantsagara@protonmail.com>
From: Larry Finger <Larry.Finger@lwfinger.net>
In-Reply-To: <20231230045105.91351-4-sergeantsagara@protonmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/29/23 22:51, Rahul Rameshbabu wrote:
> +		if (dev->qos_enabled)
> +			ieee80211_stop_queue(dev->wl->hw,
> +					     skb_get_queue_mapping(skb));
> +		else
> +			ieee80211_stop_queue(dev->wl->hw, 0);

This code sequence occurs in several places. Would it be better to put this in a 
routine specific to b43, thus it would only be used once?

We certainly could try extracting firmware from a newer binary. Any suggestions?

Larry


