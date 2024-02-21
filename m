Return-Path: <linux-kernel+bounces-75233-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28E3385E4FA
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 18:55:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6104A1C212A5
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 17:55:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF7DE84FD7;
	Wed, 21 Feb 2024 17:55:11 +0000 (UTC)
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F334584A45;
	Wed, 21 Feb 2024 17:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708538111; cv=none; b=cqbQb9NDDZnoK9bCxpLUEWfYC0qyArxFcVpoVlX38Eij8TpjCjEMHv5O2AR7bujYh6+0oc5gOC/5SRLnqecOFGREpth+n8NKrfPOcQ6B8kfa+MR1iIGmslIQaXl51h9Hhy6jYaWzFcdGyZQq6bSLCvnPdeHk5SrFYKMPMAbbcIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708538111; c=relaxed/simple;
	bh=V5g39ReTMQQQdgjvi0X/fnE23YA0xre0R2QtYw1EiXo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ebICfPpi+KO/cZRVT6R52PxeBHYJsxY0ToM9r7ddAIOFXiYh574AykqJfmylol71HDXvifn/RUDyRpK7drhm6XULM+2SlnvElu0ZGLPMBBkpoyH6RW7zEY2IAM+m6jilRmxDewR5I0rj36v2K3RUPZYeDjRDLzsadpaFGYHETLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6d9f94b9186so784666b3a.0;
        Wed, 21 Feb 2024 09:55:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708538109; x=1709142909;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ixNT6lrCynAY5FEQSBY8l84PkqF4jn/V5s3vgWDx/rI=;
        b=RChN+00dRsrg9CQiFJNWkx7o6SkhflkJeuMNf0Kplt38U/EWiF6c+MgLFi4l7dqtPE
         RntoC8eWX3/tS8MmgcTF1I+UG0QPTxP7u8Ut2wNOG3+FxG9VvqDeJbpLiSHJWcqrcptu
         Ne82yaeXwE2fXWbyXtfbgCbFKhhBo+AMfllPoHzF8LbhqC0qfHer2Y3LHbTm87hujz2L
         GcVa0sJ+1s+pn54ZFjETV2GgntGh46BeuFTFjMK1kP6X4ZSIo5GO0IaO8qoId5ZjVsu5
         9NAv9IUGFJwySEVkY+mkcw8gyfgxvSO1/C4IPb5gwZ3rgN9UP1jCqEl96WfwL1Ho5fFL
         b+hg==
X-Forwarded-Encrypted: i=1; AJvYcCXbRUHs2piLzBIRJ/yxAXv4cFca/cMyHiPUU9SiMBS2WuBADKhhXdNPlT3c2IAJJOfdZQtDphbMgJvuNuIGJpEUyBT9gSHGeKM0Ey7qk/RaznKIOkGwn48cXzXpVLGYJS+dkmXdiYyZhQ==
X-Gm-Message-State: AOJu0Yw5IiAKCgeoI49Tr3iLgbS7EkIs3FP3WivToF70UMfehxC2sk46
	TuOAs8PWyyFRWasZ1nvOMUd93EPawCPdOcBJrnWP5AbRqj6+pTAw
X-Google-Smtp-Source: AGHT+IHQLN7ypibCh6ZCJi6S6WsHEXut1dsRaeKs0vJ089o8BXr73jDTqM3k6MiJPtLd2vwCn0Cklg==
X-Received: by 2002:a05:6a00:2309:b0:6e4:c3ec:1193 with SMTP id h9-20020a056a00230900b006e4c3ec1193mr1106867pfh.32.1708538108610;
        Wed, 21 Feb 2024 09:55:08 -0800 (PST)
Received: from ?IPV6:2620:0:1000:8411:d74f:a168:a26a:d7fe? ([2620:0:1000:8411:d74f:a168:a26a:d7fe])
        by smtp.gmail.com with ESMTPSA id fb19-20020a056a002d9300b006e42bc22725sm7310727pfb.113.2024.02.21.09.55.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Feb 2024 09:55:08 -0800 (PST)
Message-ID: <0f959cca-ad29-4b8b-966d-55eb37156ef8@acm.org>
Date: Wed, 21 Feb 2024 09:55:06 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] scsi: ufs: core: Fix setup_xfer_req invocation
Content-Language: en-US
To: Can Guo <quic_cang@quicinc.com>, Rohit Ner <rohitner@google.com>,
 Bean Huo <beanhuo@micron.com>, Stanley Chu <stanley.chu@mediatek.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Jaegeuk Kim <jaegeuk@kernel.org>
Cc: Avri Altman <avri.altman@wdc.com>, linux-scsi@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240220090805.2886914-1-rohitner@google.com>
 <1920a2f6-e398-47af-a5d7-9dad9c70e03d@acm.org>
 <c7635c10-1724-4db5-9568-d554e1c64f72@quicinc.com>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <c7635c10-1724-4db5-9568-d554e1c64f72@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/21/24 01:13, Can Guo wrote:
> I am going to push some BUG fixes for Qualcomm UFSHCI MCQ engine, one of 
> which would count on a vops in ufshcd_send_command(). My original plan 
> was to add a new vops.mcq_setup_xfer_req() to differentiate from the 
> existing one used in legacy mode. But if Rohit moves the existing 
> .setup_xfer_req() up, I can use it instead of introducing the new one.

Hi Can,

If an if-statement can be avoided in the hot path by introducing a new
callback pointer for MCQ code then I prefer the approach of introducing
a new callback instead of moving the setup_xfer_req() call.

Thanks,

Bart.


