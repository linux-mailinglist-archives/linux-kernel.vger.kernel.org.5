Return-Path: <linux-kernel+bounces-86084-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEB9186BF5B
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 04:13:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 437142864E3
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 03:13:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46EC936B16;
	Thu, 29 Feb 2024 03:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b="LAH4+1IQ"
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 320A42A1A5
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 03:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709176413; cv=none; b=Ac4fDct0c2+bcnIUmDKGx83E24ccOSDkunIZ0kH2kGdtdfBRhJVunSFTQmhRBIwpJnmdCkFXajZw5jwjYWPz3TuuZKAB//lHJr03eMQ89dfHMyKkImeaMbiO/BDQyZELKbdDYspqoZNDm7oWqrZ9uw4XXbnswsqRYsvO0iNSIXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709176413; c=relaxed/simple;
	bh=GvYB01IMzg17PiArVVQOB3u6dfLN8+nUMwqPe0f/v40=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=krIX6v6opvMR3X4h3F3uGqw56+PeEUJDc+g0pl+M9alGbT1DambBWcSJZt+mtEVAgfVuZNTVd+eeMx4NwaR/6azZN6NEKcq+AE88SjP7W1QDW1rVlm7yNsqsZBxh1sLORY047iWefA+OH88Z6vhmIGYF/QD7KM1S7ikabnwr5SQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com; spf=pass smtp.mailfrom=shopee.com; dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b=LAH4+1IQ; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shopee.com
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3c1a172e46bso285615b6e.3
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 19:13:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1709176411; x=1709781211; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uMkpNJ4uFCi2vxjYV3Jq89JCvNZv/l3X1Nyx5cKLkBE=;
        b=LAH4+1IQFNEq/s/OsxFTisKUZYk2rFuK3dCbwTflBvGq6Hp1kotKfvMe/u+0S/WTpz
         MdvqWOGlVP6i2pV3V7YOSj88fzPxox3ygfgVwxOgl4NdkDcAoa4EKJm4xXI9NqhrRRWl
         eBi/sQu3OLrS/4ZhagDQacMlMUTvzz5QqpFNuXTA8t+cVEUa9ccNK20kCk+pdrw1MUlM
         yTv7leau0euER0mqia4idO4o/BwmqbykOkYHYc4oFIjEENUKP/Q7dSXdZDd2r/W8nY8x
         OOfegPS8EMl+QhfyeGkme4bOgDLFRJ3ECg+N4Tinf3XJwLl8Nt4IQtU3v3Disw8Xp6uv
         6YHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709176411; x=1709781211;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uMkpNJ4uFCi2vxjYV3Jq89JCvNZv/l3X1Nyx5cKLkBE=;
        b=vNV3uNdibG1hK7PH6fvzhVvWVS+tnC9spvu2GPBW2GVNOwMOxfwBX2qYCGG9UI5/oT
         B2Mjo8cPfuPzWLb/N4aIn6bh3+/xT6zuVOoe1pUvATefbsce3cosHAHNJNNfUYwatwu+
         JY8YH5BQE6pTb5XFeHHJMygT4o0WVLTzQM30vN3Ousl51uXUyctuRO0+rxV8umtigJgR
         4LtTWDZEPmdctl+L0z3fcLL0MVm1KdusHFVmeNrY9nnVBBfODKMvdp5vDGbXa7jO9bS0
         d5BzaEPaBqiMiemSsh1zGiSwRXXVLJ/Tw5Vd4iC0SosBIkSpKWXUI7kP+cYywHfD+lLW
         K7jA==
X-Forwarded-Encrypted: i=1; AJvYcCV5pJurowG30NENDtZkYHdDp+y2gEqjP8yblCNzg/7KpbCicbU0fa8ZDdyx1m+97Rr/hyz/fE2+0MoNBtUQg0tNXr12H9Cz7n4bCIGi
X-Gm-Message-State: AOJu0Ywd4d+rkhVEgztF7by80aSRWQxgiLqGBYw+N7GcByCP63kEI99y
	iLUvTpgmeg0cDl81hpiHQ8QH7o4QTSaJ8jNU1pPIrO6tf/9jyiqTf8RollSu1ErCflPO0EyKtKd
	MC2c=
X-Google-Smtp-Source: AGHT+IFnvd8tIRd46HO/ckGiyiz/P85mHOKTag8JryRQSSRx/3Ls/XFalAZiM+3Z6HOuL9a2hHyEEg==
X-Received: by 2002:a05:6870:b601:b0:21f:2010:364b with SMTP id cm1-20020a056870b60100b0021f2010364bmr837177oab.39.1709176411368;
        Wed, 28 Feb 2024 19:13:31 -0800 (PST)
Received: from [10.54.24.74] ([143.92.118.3])
        by smtp.gmail.com with ESMTPSA id n13-20020aa7984d000000b006e560069a95sm171834pfq.174.2024.02.28.19.13.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Feb 2024 19:13:31 -0800 (PST)
Message-ID: <fb4ff6d3-ad96-4673-b6eb-2ceb2e72a9ca@shopee.com>
Date: Thu, 29 Feb 2024 11:13:29 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] Track llc_occpuancy of RMIDs in limbo list
To: Reinette Chatre <reinette.chatre@intel.com>
Cc: fenghua.yu@intel.com, babu.moger@amd.com, peternewman@google.com,
 x86@kernel.org, linux-kernel@vger.kernel.org
References: <20240221092101.90740-1-haifeng.xu@shopee.com>
 <8513d475-3a3a-418a-9cba-75d640619f6e@intel.com>
From: Haifeng Xu <haifeng.xu@shopee.com>
In-Reply-To: <8513d475-3a3a-418a-9cba-75d640619f6e@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2024/2/24 07:24, Reinette Chatre wrote:
> 
> Hi Haifeng,
> 
> Typo in subject:  llc_occpuancy ->  llc_occupancy
> Could you also please use the x86/resctrl subject prefix in the cover letter?

OK, thanks.

> 
> Thank you
> 
> Reinette

