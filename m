Return-Path: <linux-kernel+bounces-5616-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A6E95818D25
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 18:00:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4465B1F25F89
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 17:00:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1548320DD7;
	Tue, 19 Dec 2023 17:00:37 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84A3B20B16;
	Tue, 19 Dec 2023 17:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1d3ddccfaffso6589765ad.1;
        Tue, 19 Dec 2023 09:00:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703005235; x=1703610035;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GCKdQO85kQLbRZb+7q6diSEi1hXX9QrYCjY7VxGpZ0w=;
        b=Yk7BOPyzHrw7TG+qpCIvl1vOQU0ugekh6dbnfv1hzeckOZLAm2Qd2REo8uNjNLgSWt
         VgshO6MACYfWKcW814MK+qE+nWNKHeYdRnGWTNQx5EofZqm8CTF1N2S+5Aprg6iXMfBv
         b1bTmC7NkDaaz6LLz2C/bU4iHPKRO+3SCK0Cbbn8w9TU5IIrBveIq6p4mHihAxbFcuL1
         LTNcQoQTwElWDVUUYelL0+AwL6UBwbx17komr7awmP3V6iTckou+jc1Yv94OlywQV/sq
         KaQ52YerQMaVjXRKaApynpbclf94Yd7tFxF3ncCw/jASzMfwbsYEtptdFyBaIsRtkMlx
         TZWA==
X-Gm-Message-State: AOJu0YyV1S4U4/CYT0IMehrtoHs1XGXm3WdWMO2+Q8K86EAlwKX+0LnR
	cyeSO5eW4v/tmiDxevtEEg4=
X-Google-Smtp-Source: AGHT+IHjYDf4pLbHjRZhEwzGoga9cTlLdC9BiKX+JX/lxqRBvLuTDO73ZsFEUGEiQv1HqWpmnoEB6g==
X-Received: by 2002:a17:902:ecc3:b0:1d3:deb7:7c69 with SMTP id a3-20020a170902ecc300b001d3deb77c69mr1299161plh.20.1703005234420;
        Tue, 19 Dec 2023 09:00:34 -0800 (PST)
Received: from ?IPV6:2620:0:1000:8411:2c02:6167:94c9:999b? ([2620:0:1000:8411:2c02:6167:94c9:999b])
        by smtp.gmail.com with ESMTPSA id o14-20020a63e34e000000b005c67bb1585csm19711949pgj.68.2023.12.19.09.00.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Dec 2023 09:00:33 -0800 (PST)
Message-ID: <90d13f1f-79aa-4067-b949-6f18cb1bb229@acm.org>
Date: Tue, 19 Dec 2023 09:00:31 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V6 1/2] ufs: core: Add CPU latency QoS support for ufs
 driver
Content-Language: en-US
To: Maramaina Naresh <quic_mnaresh@quicinc.com>,
 "James E.J. Bottomley" <jejb@linux.ibm.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Peter Wang <peter.wang@mediatek.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Alim Akhtar <alim.akhtar@samsung.com>, Avri Altman <avri.altman@wdc.com>,
 Stanley Jhu <chu.stanley@gmail.com>, linux-scsi@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, quic_cang@quicinc.com,
 quic_nguyenb@quicinc.com
References: <20231219123706.6463-1-quic_mnaresh@quicinc.com>
 <20231219123706.6463-2-quic_mnaresh@quicinc.com>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20231219123706.6463-2-quic_mnaresh@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/19/23 04:37, Maramaina Naresh wrote:
> Register ufs driver to CPU latency PM QoS framework to improve
> ufs device random io performance.
> 
> PM QoS initialization will insert new QoS request into the CPU
> latency QoS list with the maximum latency PM_QOS_DEFAULT_VALUE
> value.
> 
> UFS driver will vote for performance mode on scale up and power
> save mode for scale down.
> 
> If clock scaling feature is not enabled then voting will be based
> on clock on or off condition.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>

