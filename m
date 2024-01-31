Return-Path: <linux-kernel+bounces-46917-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62AF4844659
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 18:40:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CCBC4B23FD1
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 17:40:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9437D12F597;
	Wed, 31 Jan 2024 17:40:25 +0000 (UTC)
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C31E9129A97;
	Wed, 31 Jan 2024 17:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706722825; cv=none; b=SM+JH/b4HmeNaHLn4eely1rG96F+Elj8O8QjftTW0y519jQK2qLEfU47F7c+CMKW0z8cEnHIZlwfFJqD3FToWHeUjcEBDibUzgHGUphKjt0VqNXjO+FmMEL0YSyQkbdIwK/s+vQWpuljvCTOmrPq598yiUbr53ctKJxU2X3CRJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706722825; c=relaxed/simple;
	bh=WVQUYt7nObgji6RFwgn4j76fQwqbn8mFnobCYg5rFBM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Wfb/YLA+iUJ/iH6SNGlzlEhYBbXgA28x/tARCoqvxa7itLXN8SSFbuxP/hiTrM5Y+kBcwQjUywQE2E+LD8841+OqjyKpP60bBdcygrxmPxZjq9ybt4x5oOx5/BT1dsWIDQU0DPFsJdgnqGQExcW5QDqh16b05J/oDRnqUt3iHkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6d9b37f4804so878622b3a.1;
        Wed, 31 Jan 2024 09:40:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706722823; x=1707327623;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WVQUYt7nObgji6RFwgn4j76fQwqbn8mFnobCYg5rFBM=;
        b=quolsnTQu8P2p9+PcIT8G9W72GbvbnR/tlhazx3PcWIP4ALFk+WjlWEPEJYxFGdA5/
         44Apj9pc8XqF7Y9BNaI77qL0XF67kvii6rg8oytf77PimSTgSv6wr81IkGHQa716YtpT
         mkGm/6+TennbY4ptD8CJi8pUI72LCKlJgFNMtyXL6xKaI327evVWTAkm4tc0UPlyTBlM
         lX0O9w4O0CUGVXto9aJ+c/S9V3LJ+muaXc5Qy+iESTdLGMVsvV5ZurWv5qGBtZ5sMPyD
         MIU1DWZugXuh5LopK/XSUBiZnfsk0yw/Mj+dqju1vmOZKykZX3PjVre7XuKiPfkl+YdD
         jRTQ==
X-Gm-Message-State: AOJu0YxDKGguB1mIOqR2fn0DuckXghCzCHfRLVMFLeT8V5TViLoQ1DzH
	X31D+l9Dja9pBr5mCYg+JXIb+vdfLnEdxeWXaSKqFWuwXvx0Vmp3
X-Google-Smtp-Source: AGHT+IG3sN7FENJhtQosKxqrU/9yRjZ4zCCxV5eRAx8N5SW8oU49klZibVnon9HTej0Alj50otyPbA==
X-Received: by 2002:aa7:92c8:0:b0:6db:b1f3:fb66 with SMTP id k8-20020aa792c8000000b006dbb1f3fb66mr2494676pfa.8.1706722822627;
        Wed, 31 Jan 2024 09:40:22 -0800 (PST)
Received: from ?IPV6:2620:0:1000:8411:1d95:ca94:1cbe:1409? ([2620:0:1000:8411:1d95:ca94:1cbe:1409])
        by smtp.gmail.com with ESMTPSA id y12-20020aa7854c000000b006dbd3aec001sm10508915pfn.146.2024.01.31.09.40.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Jan 2024 09:40:21 -0800 (PST)
Message-ID: <2e1ce85f-9397-4d67-a847-eba8b8c05594@acm.org>
Date: Wed, 31 Jan 2024 09:40:19 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] scsi: ufs: core: Remove the ufshcd_release in
 ufshcd_err_handling_prepare
Content-Language: en-US
To: hoyoung seo <hy50.seo@samsung.com>, linux-scsi@vger.kernel.org,
 linux-kernel@vger.kernel.org, alim.akhtar@samsung.com, avri.altman@wdc.com,
 jejb@linux.ibm.com, martin.petersen@oracle.com, beanhuo@micron.com,
 kwangwon.min@samsung.com, kwmad.kim@samsung.com, sh425.lee@samsung.com,
 sc.suh@samsung.com, quic_nguyenb@quicinc.com, cpgs@samsung.com,
 grant.jung@samsung.com, junwoo80.lee@samsung.com
References: <CGME20240122083204epcas2p26a1bca522e201972ca072e0b24d23a52@epcas2p2.samsung.com>
 <20240122083324.11797-1-hy50.seo@samsung.com>
 <06e0ae57-f567-4b90-ad68-4ae73909c29e@acm.org>
 <017501da4da5$405e5ec0$c11b1c40$@samsung.com>
 <92463403-ea32-4545-a466-21243cd454e2@acm.org>
 <000001da541e$bb358590$31a090b0$@samsung.com>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <000001da541e$bb358590$31a090b0$@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/31/24 00:23, hoyoung seo wrote:
> I do not understand. why you said my patch is wrong.

My apologies - I misread the patch.

Bart.


