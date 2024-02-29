Return-Path: <linux-kernel+bounces-86083-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2648E86BF5A
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 04:13:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 162CEB2267B
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 03:13:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FB9936B16;
	Thu, 29 Feb 2024 03:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b="l5JxK9ba"
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C48B2E851
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 03:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709176375; cv=none; b=iqXqvaTU2oEtmr/wVebUeQgYFE58aIDM2zHdtQvRpgnNIaZaeKphinaQNjmkKEVdRUrmv4BMIQNFtqSIflAR5e+WGsYJCwuE1ynIbruwb9ki5vxyYEdo+HVNhhhlKdaAKm2Ct/IWPEcGT/QGKCrTbwX/4UyWwhoVq141Ofy4vrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709176375; c=relaxed/simple;
	bh=b21SZcrtxETP46BZ5OtDVSrmPOUozzVmmKoU49bk4no=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o7Scqu1F4SyvMUlhsjytbkQf6YaaGnmhu5wd9mn/h33BkdBPrV7SYggazkpQvFXUg5v9E68HDqUcGK0TeWKwXX4W1kpWPSCtN1Exycb/LX2XEdlMQ/o0PSdFu99JQFYgkqt3wYRc7oUgIL4aJZpXsY//w/rQVG9+/cDVfzbsoWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com; spf=pass smtp.mailfrom=shopee.com; dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b=l5JxK9ba; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shopee.com
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-214ca209184so200806fac.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 19:12:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1709176373; x=1709781173; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oKTaJJvcz6ukUnHCjiAcv2W8DHAWX21S/CGeGiPRnVA=;
        b=l5JxK9bana2mK5OM/6gdmgDxfXiNVa4hAgrBM477NE5tT4jAjOQYoAksIcGOAhDGzm
         RfeiI5smxvPWhK6oTY4xkDFWiJ1V44UTz6gc9nPt4a7tGirHF/58gTovgY/M4A3SvWLe
         JUVw3qhmhk/oHf6+RwUxb4dW4NpysJr7aaAfWvwR3eVnBonSBwhafAexquLqEtRjX+VY
         P0L2VyjC2B9V5lYfIst+7Iv9e6A3gb+O1eHOes54QSGET/jInGLS3UlO7257l/34AeUY
         /ZlTQKbhmLnHqhveHo7htlfo7scHT1pSWv/re5+dQ78T7DizLMMPp2s4zsnUZhd+qNO+
         2NAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709176373; x=1709781173;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=oKTaJJvcz6ukUnHCjiAcv2W8DHAWX21S/CGeGiPRnVA=;
        b=ODBWedNfX0KN5sv+eON7oG5LJ1Wb3OuLAEMFFFipe380Ftc4P02+J3GLQLnHkCbkyC
         agcCoGfExclM7G1hJQJR/ejB7FEQSMnTqtsfwrLOQ4MExkQps9cdnccaS9IyRtYkQfSs
         bVM37bqfOsmGiriskcLjd35WpOMVnhBTTeqH7z+VeKkIp2QlcsoCx6AhrE21yd430eRJ
         e+xGcaRUpb2RgQqXNus27huWtr9QRxyPAw/X4aIP/tg5vA9In0Y0tAuHFO3JASNfmZm3
         26RlB/gRqZ8EZPRvppy2OiX2TIdcR964FKczY9xctqHejdDgl19n6Lh0fhFyqOi8BXeo
         zWzg==
X-Forwarded-Encrypted: i=1; AJvYcCWg1kRUdly8V7NATrh3aQDcVQhx0hre7kV5tY2Yu1OnMVycy1ffRpUj10b8gYJ8jpJHJhK6H+7Pq+tLXALpZ+/nIZKnRqf4l61qNABu
X-Gm-Message-State: AOJu0YzGyU9mxU20dTbDDEqs8dPmJsaarXIe7GW/CSpEANJ+otmSkTjf
	dWM6nrm17eZQxyBXfBb1CGGZ8xr4jnrVN51Fb6MJLBbMf1DY0pDSxZjAFdE3r+g=
X-Google-Smtp-Source: AGHT+IETuRoUdWOvCe1c/L0v8m7WmXHi+8fpOfvps0CIXM92NqmOzYhgqtTj3UK+qsI+4VVDxAbnnQ==
X-Received: by 2002:a05:6870:4d13:b0:220:9327:2019 with SMTP id pn19-20020a0568704d1300b0022093272019mr373066oab.55.1709176373176;
        Wed, 28 Feb 2024 19:12:53 -0800 (PST)
Received: from [10.54.24.74] ([143.92.118.3])
        by smtp.gmail.com with ESMTPSA id n13-20020aa7984d000000b006e560069a95sm171834pfq.174.2024.02.28.19.12.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Feb 2024 19:12:52 -0800 (PST)
Message-ID: <d5b4d538-aee1-4dd1-970c-20f86cce2a81@shopee.com>
Date: Thu, 29 Feb 2024 11:12:49 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] x86/resctrl: Rename pseudo_lock_event.h to trace.h
To: Reinette Chatre <reinette.chatre@intel.com>
Cc: fenghua.yu@intel.com, babu.moger@amd.com, peternewman@google.com,
 x86@kernel.org, linux-kernel@vger.kernel.org
References: <20240221092101.90740-1-haifeng.xu@shopee.com>
 <20240221092101.90740-2-haifeng.xu@shopee.com>
 <9055ee27-0860-4701-9ae9-801c25cf2aef@intel.com>
From: Haifeng Xu <haifeng.xu@shopee.com>
In-Reply-To: <9055ee27-0860-4701-9ae9-801c25cf2aef@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2024/2/24 04:00, Reinette Chatre wrote:
> Hi Haifeng,
> 
> On 2/21/2024 1:21 AM, Haifeng Xu wrote:
>> Now only pseudo-lock part uses tracepoints to do event tracking, but
>> other parts of resctrl may need new tracepoints. It is unnecessary to
>> create separate header files and define CREATE_TRACE_POINTS in different
>> c files which fragments the resctrl tracing.
>>
>> Therefore, the new tracepoints should be placed in the same header file,
>> and the header file needs a more generic name.
> 
> Please do stick with imperative mood [1]. For example, something like:
> "Give the resctrl tracepoint header file a generic name to support
>  its use for tracepoints that are not specific to pseudo-locking."
> 
> (Please feel free to improve.)


Thanks for you suggestion.

> 
> Reinette
> 
> [1] https://urldefense.proofpoint.com/v2/url?u=https-3A__www.kernel.org_doc_html_latest_process_maintainer-2Dtip.html-23changelog&d=DwICaQ&c=R1GFtfTqKXCFH-lgEPXWwic6stQkW4U7uVq33mt-crw&r=3uoFsejk1jN2oga47MZfph01lLGODc93n4Zqe7b0NRk&m=JoQ5pMB6FFBeGHFDWQYyFgKF2Y5VYhBeykX4853MHrTi-O0Jk3H_K9bh3NaxwLRx&s=482No-jEnFTObHttNwp2LTS-Dc3cP5jQOhL2cEj77MM&e= 
> 

