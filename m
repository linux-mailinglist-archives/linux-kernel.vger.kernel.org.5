Return-Path: <linux-kernel+bounces-4431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AA91817D04
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 22:56:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 992452858D1
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 21:56:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7722374E12;
	Mon, 18 Dec 2023 21:55:59 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55D92740BD;
	Mon, 18 Dec 2023 21:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-7b3708b3eacso147561739f.2;
        Mon, 18 Dec 2023 13:55:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702936556; x=1703541356;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eIl3+miZ0G9Vwo7dKjzcYHAwvEgr2VOComYZIqzlsP0=;
        b=FcPAqZOaNCnnCBAUcysikjoU5cjRUJSnDfpt4rZaFHlXMMIJo061q2ry4pbQ8Cxq2z
         btyHMfX7+GbHv6VusdGDVIlRjipHXMOOByLmNx87TUv5aw6NgGpLV0mi8HVZTcGOinaT
         VIfcnZnFkbcuB+uiE20BgDTEBmvL6VEObBVdNvSY6/OszDpihxn93X9yZync63BmdG1E
         i6CPS8TMPXSj2DheACWdr7YoG8lmyCtgqSfXtSVGb9mCoQ+w9LFjfVFZelu2aqYNQ+//
         Pr0SV8nLg2oeT8rhWLi3t/6/teoZOrZf9i9C8fWvxA1biriqNrq+eSYDoeRp6TbxJbMz
         VDSQ==
X-Gm-Message-State: AOJu0YxUmP9rUWC+sFficL9z8CltGaSyNu85bm9eOjsUghJTba/1ijHX
	xxzcLFb99L5Upfz2+2WK45Q=
X-Google-Smtp-Source: AGHT+IHEewjCipB4PIrKNw9vqIIP/VSnGW9Uiv52Wv48DEo+dTLjJlbTKJ/7N8EqP5QpL2LNEbx/jA==
X-Received: by 2002:a92:c90b:0:b0:35d:59a2:92a6 with SMTP id t11-20020a92c90b000000b0035d59a292a6mr15410019ilp.58.1702936556465;
        Mon, 18 Dec 2023 13:55:56 -0800 (PST)
Received: from ?IPV6:2620:0:1000:8411:e67:7ba6:36a9:8cd5? ([2620:0:1000:8411:e67:7ba6:36a9:8cd5])
        by smtp.gmail.com with ESMTPSA id s7-20020a634507000000b005cd8bf50c13sm3114268pga.58.2023.12.18.13.55.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Dec 2023 13:55:55 -0800 (PST)
Message-ID: <9861ce52-8163-40aa-b156-dd656143a73d@acm.org>
Date: Mon, 18 Dec 2023 13:55:51 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V5 1/2] ufs: core: Add CPU latency QoS support for ufs
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
References: <20231213124353.16407-1-quic_mnaresh@quicinc.com>
 <20231213124353.16407-2-quic_mnaresh@quicinc.com>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20231213124353.16407-2-quic_mnaresh@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/13/23 04:43, Maramaina Naresh wrote:
> +static ssize_t ufshcd_pm_qos_enable_store(struct device *dev,
> +		struct device_attribute *attr, const char *buf, size_t count)
> +{
> +	struct ufs_hba *hba = dev_get_drvdata(dev);
> +	u32 value;
> +
> +	if (kstrtou32(buf, 0, &value))
> +		return -EINVAL;
> +
> +	value = !!value;
> +	if (value)
> +		ufshcd_pm_qos_init(hba);
> +	else
> +		ufshcd_pm_qos_exit(hba);
> +
> +	return count;
> +}

Please use kstrtobool() instead of kstrtou32().

> +static void ufshcd_init_pm_qos_sysfs(struct ufs_hba *hba)
> +{
> +	hba->pm_qos_enable_attr.show = ufshcd_pm_qos_enable_show;
> +	hba->pm_qos_enable_attr.store = ufshcd_pm_qos_enable_store;
> +	sysfs_attr_init(&hba->pm_qos_enable_attr.attr);
> +	hba->pm_qos_enable_attr.attr.name = "pm_qos_enable";
> +	hba->pm_qos_enable_attr.attr.mode = 0644;
> +	if (device_create_file(hba->dev, &hba->pm_qos_enable_attr))
> +		dev_err(hba->dev, "Failed to create sysfs for pm_qos_enable\n");
> +}

Calling device_create_file() and device_remove_file() is not acceptable because of
the race conditions these calls introduce for udev rules. Please add this attribute
into an existing group and update the is_visible callback function of that group.
See also ufs_sysfs_groups[].

Thanks,

Bart.

