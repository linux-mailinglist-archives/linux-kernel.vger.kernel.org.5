Return-Path: <linux-kernel+bounces-19924-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C454C8276DC
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 19:03:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4C1ACB20C4B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 18:03:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A71F55E74;
	Mon,  8 Jan 2024 17:57:58 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 028EC55E52;
	Mon,  8 Jan 2024 17:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1d3eb299e2eso10019785ad.2;
        Mon, 08 Jan 2024 09:57:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704736676; x=1705341476;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FsJws2GBQTqVuL0zDyeQXawwmM6nlw+BJqfE/TGg9/g=;
        b=bFRJBM8P2R2uEq0JQIGwcmW34f4D4G0uW0m9eBK46E11VMenWfUOzcEAhFYBoRpYWt
         09jgAhwYyCJKrWNdwJzHiPVa06pxT4AUQhRf6jlRcis70CiHmro38RScgr3TliiTRo6M
         v2T4gP7Ee6ZWhF3nbBKq53Y09YxUpu2NxkoW054DCYKRG/5DsnyNL/GMHUh+bjJnEKkn
         zRfm7jpeJTiahoYT0bc8lFxw76+w7zN5S8pFr1/tEymQg9cgUiw7UAFmFmnXi+6GBfHk
         Bjow5RibNu4LrOeQ+DAwkudFyEHotNh9GM4NCwV6VRK5wKAk4kIMdmbUSxyDs/Cko4r0
         eTXw==
X-Gm-Message-State: AOJu0YzTxJ2sCPXITLW0pcljJwCcIeZNrmsUzTC/xrnKS20S9D8MDAGH
	lzikBV65FIKBgjf2+UAOj1Y=
X-Google-Smtp-Source: AGHT+IHLtStDtgCU08Axpj6/fVlaoUMqBauKXKas/k+5UZBD649yTmWj4FpPjb982/WaQgr8+5tSGw==
X-Received: by 2002:a17:902:b681:b0:1d4:6274:b4fb with SMTP id c1-20020a170902b68100b001d46274b4fbmr1489185pls.20.1704736676177;
        Mon, 08 Jan 2024 09:57:56 -0800 (PST)
Received: from ?IPV6:2620:0:1000:8411:cee:c48d:78d6:ed9a? ([2620:0:1000:8411:cee:c48d:78d6:ed9a])
        by smtp.gmail.com with ESMTPSA id n2-20020a170902e54200b001d058ad8770sm169957plf.306.2024.01.08.09.57.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jan 2024 09:57:55 -0800 (PST)
Message-ID: <f95ce17f-f42b-4784-b725-8081df27a7a8@acm.org>
Date: Mon, 8 Jan 2024 09:57:52 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] ufs: mcq: Add definition for REG_UFS_MEM_CFG register
Content-Language: en-US
To: Chanwoo Lee <cw9316.lee@samsung.com>, alim.akhtar@samsung.com,
 avri.altman@wdc.com, jejb@linux.ibm.com, martin.petersen@oracle.com,
 peter.wang@mediatek.com, chu.stanley@gmail.com, matthias.bgg@gmail.com,
 angelogioacchino.delregno@collabora.com, stanley.chu@mediatek.com,
 quic_cang@quicinc.com, mani@kernel.org, quic_asutoshd@quicinc.com,
 powen.kao@mediatek.com, quic_nguyenb@quicinc.com,
 yang.lee@linux.alibaba.com, athierry@redhat.com, linux-scsi@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org
Cc: grant.jung@samsung.com, jt77.jang@samsung.com, dh0421.hwang@samsung.com,
 sh043.lee@samsung.com
References: <CGME20240102014248epcas1p4d49dcf2cd3f020bed88eebaeba648789@epcas1p4.samsung.com>
 <20240102014222.23351-1-cw9316.lee@samsung.com>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20240102014222.23351-1-cw9316.lee@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/1/24 17:42, Chanwoo Lee wrote:
> Instead of hardcoding the register field, add the proper definition. While
> at it, let's also use ufshcd_rmwl() to simplify updating this register.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>

