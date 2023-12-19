Return-Path: <linux-kernel+bounces-5617-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1407D818D2A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 18:01:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B83691F263DF
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 17:01:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C435C20DEB;
	Tue, 19 Dec 2023 17:00:50 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A93520B2F;
	Tue, 19 Dec 2023 17:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-7b7fdf6e7c1so4980139f.1;
        Tue, 19 Dec 2023 09:00:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703005248; x=1703610048;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LgJX2iXSXNpamsAV8ozi86d6tRWgjGnRgb3PlM33YpU=;
        b=feXTkwy+BvmyfcDWCRLbc+lE6eZicUCr5X5aN/7Nu9AMyNaNrvgYyYLB9ouUJ42Uu0
         wPxyAsI2qc7qcvxA9l7+l0fy4MQnIbF06px2U4NKW9lWcuDNDZimQslbNjuvkXEhtdjl
         rs7bLZqWh7o/T4M8/LtrqQsLK5P0g3xxNnbjZNjPvUHDNSsgpKPTU9PGBCQ9RRtduX3o
         DtBasCWLGekyFBPOsBYL3Du+JYm3a/xKmQSKIK5n487kQcO5ACzXqCM5xwNa8x4oaKKf
         nAgZ/LwyAlulh2uI2viCMjmiaQYz9NExwN+HBO5kLQSc77w1dFurgd4KfqxaX0XGTHmd
         hUPQ==
X-Gm-Message-State: AOJu0YwjbqISkGqcu1w7gV0e//ULVmJy/Ps0K0V56RGbg8OzSVuUkxZQ
	LsQv3LHoL5XPUqoaGL80aqs=
X-Google-Smtp-Source: AGHT+IE/pXRsxDbNpnav7+8+DbpUu0omybNbu8s/xeK7S/bDGQfZgSlrOcqQHPwT4Qt848RSe0jwWA==
X-Received: by 2002:a05:6e02:1c8a:b0:35c:e8ee:f7d7 with SMTP id w10-20020a056e021c8a00b0035ce8eef7d7mr23488887ill.8.1703005247984;
        Tue, 19 Dec 2023 09:00:47 -0800 (PST)
Received: from ?IPV6:2620:0:1000:8411:2c02:6167:94c9:999b? ([2620:0:1000:8411:2c02:6167:94c9:999b])
        by smtp.gmail.com with ESMTPSA id o14-20020a63e34e000000b005c67bb1585csm19711949pgj.68.2023.12.19.09.00.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Dec 2023 09:00:47 -0800 (PST)
Message-ID: <04a6f477-2666-4873-8612-a4fc643a462f@acm.org>
Date: Tue, 19 Dec 2023 09:00:45 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V6 2/2] ufs: ufs-mediatek: Migrate to UFSHCD generic CPU
 latency PM QoS support
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
 <20231219123706.6463-3-quic_mnaresh@quicinc.com>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20231219123706.6463-3-quic_mnaresh@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/19/23 04:37, Maramaina Naresh wrote:
> The PM QoS feature found in the MediaTek UFS driver was moved to the UFSHCD
> core. Hence remove it from MediaTek UFS driver as it is redundant now.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>

