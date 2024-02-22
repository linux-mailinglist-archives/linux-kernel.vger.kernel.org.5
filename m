Return-Path: <linux-kernel+bounces-76772-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5295985FC4B
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 16:26:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5FDE1F264D2
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 15:26:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BFE014D433;
	Thu, 22 Feb 2024 15:26:04 +0000 (UTC)
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AE98148FE6;
	Thu, 22 Feb 2024 15:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708615563; cv=none; b=kVNugSdzrWnZTPCQX5kyiyNUlDWJU53aPZrsOa2/RF/N+F9RUtE7yHJfIhN+7bDcA+rCR9wcAUtAAzxV3EZiS86wqV6tkuSsdE/wwD3tSDCYQyRoHi/vXiUvy6IMxYEPk9fJu0T1yzohy0qJDJMlnfDq/DzZIZ2ItKgDsEBbFEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708615563; c=relaxed/simple;
	bh=pxGFUVTrbZPJfKG+upRmbGZUX3s9YKgFEYM4kUrXt64=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bZGd4FdNLMQvyg/sCUseiIx0GweJz+CzNr1FF1JsZPAzkBakiaguzX46TOH1LINQl5f6GAAc36dxTSQ1vLvADhJ7OrSN6sQoou2hH1UaJCqwsRy5+wvuRCkZksn7F/EWe5c+RzvVLaQkxAKg8TLTzn8MDr6jyZRGB5Wyvz+0vGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-517ab9a4a13so1468577a12.1;
        Thu, 22 Feb 2024 07:26:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708615561; x=1709220361;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pxGFUVTrbZPJfKG+upRmbGZUX3s9YKgFEYM4kUrXt64=;
        b=sMoX+uv8SJfqmWLmilSLrqgTBfaC/RyY5ufKYRFzxPGCa9ZOM1Ez37gn2IWm3egmXa
         qeEp7yEmdxmMBBBdzfkT7k947q+N+pH2gncFYNXV+qQFFKeHW3eFQBLCttMxR3mImWLJ
         4b01cVakX7TZytVwOPUMUFJTYwni46MCk/D4HnFiplNliemsxIX5NsIsSYMMIyknG9Vr
         76jfmsToYU6tVHazBvoLQUMmcbyngDelpUwlu6/OliB1xaknco2hIIedajqcLGtejiQe
         +dIHizxNjdqFzoWOAb76V8SczGHgkeSn/ZzCeqxnSTUYz1WeoH2xDSTna1h5EXj+xvIM
         CBdQ==
X-Forwarded-Encrypted: i=1; AJvYcCXiggNblgjUK9plk/6We0XAQaVYbYCcd5XJw+uxWZVd6WpPLdw55SInfy8K+KQF5AGJ4Vu7vuPVo0ou9qswM/jbd4DWLpf/CG5d/ydBGn7lWo8tctvxb0x4p3MpLPgFKDdx2lvEUdqFHg==
X-Gm-Message-State: AOJu0YwxebacmlxCEAdjpRNhhgCYjO2klQw8L87djLerE+ZDDGOMYpIS
	hwCd6kyHDRq4l/9gLpmF5Yx2sbmgGgEa6cejZ2xl3mtVIt9EEjod
X-Google-Smtp-Source: AGHT+IEtY5t4SoyDE22WAnGk1TFMYazaRWiTFd5NBAfeuZG1MzybiNSL6vDHjZ36lbzDLncKBirGVA==
X-Received: by 2002:a17:90b:8cd:b0:29a:6695:7c74 with SMTP id ds13-20020a17090b08cd00b0029a66957c74mr584374pjb.45.1708615561363;
        Thu, 22 Feb 2024 07:26:01 -0800 (PST)
Received: from [192.168.51.14] (c-73-231-117-72.hsd1.ca.comcast.net. [73.231.117.72])
        by smtp.gmail.com with ESMTPSA id db16-20020a17090ad65000b002973162eca1sm4110518pjb.17.2024.02.22.07.26.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Feb 2024 07:26:00 -0800 (PST)
Message-ID: <f5ac9637-99e2-487a-998c-5e63fdd3ccff@acm.org>
Date: Thu, 22 Feb 2024 07:25:57 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] scsi: ufs: core: Fix setup_xfer_req invocation
Content-Language: en-US
To: Rohit Ner <rohitner@google.com>, Can Guo <quic_cang@quicinc.com>
Cc: Bean Huo <beanhuo@micron.com>, Stanley Chu <stanley.chu@mediatek.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Jaegeuk Kim <jaegeuk@kernel.org>, Avri Altman <avri.altman@wdc.com>,
 linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240220090805.2886914-1-rohitner@google.com>
 <1920a2f6-e398-47af-a5d7-9dad9c70e03d@acm.org>
 <c7635c10-1724-4db5-9568-d554e1c64f72@quicinc.com>
 <CAGt9f=T5352bo=K2OAa7QRMds=tQC1JspN+zQ2aYxNRDWGSVnA@mail.gmail.com>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <CAGt9f=T5352bo=K2OAa7QRMds=tQC1JspN+zQ2aYxNRDWGSVnA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/22/24 00:27, Rohit Ner wrote:
> Can we stick to the current approach of moving the .setup_xfer_req()
> up, keeping in mind the following pros?
> 1. Avoid redundant callbacks for setting up transfers
> 2. Trim the duration for which hba->outstanding_lock is acquired unnecessarily

No, we can't. The Exynos implementation of the .setup_xfer_req() callback
is not thread-safe and relies on serialization by the caller. This patch
breaks the Exynos driver. A better title for this patch would be "Break
the setup_xfer_req() invocation".

Bart.


