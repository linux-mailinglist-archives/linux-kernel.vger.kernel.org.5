Return-Path: <linux-kernel+bounces-40351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DF20F83DEE7
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 17:38:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92AC31F21AB4
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 16:38:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF3B41DFD1;
	Fri, 26 Jan 2024 16:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="XwDKVD2R"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0ECA1D559
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 16:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706287097; cv=none; b=t0R3KDga+Tl5pZhCmulkTWIgeoi8eAw0EVz5Ohixcrxr4R4KGbe/DOkjjFOcYSozR1ZU0sdMnHkKfquoVh1WLzsNu24HWRWXyc+xgDpzXpzMtjZoFz0TxKA4ODUNflgNYg+LVRw8lCt97x7mpDZalgzfpgRXtJ2hYDtn1tOrZGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706287097; c=relaxed/simple;
	bh=/FfErPD7fPuY6n+IL4H7hJhZx3N0+Izam7zb+o4a8ac=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TAtC27O3dA6X/iHsd5zSEF6y1kpC0M5eksHhTS8WEGpLTRtUa0imXcZwpt+urJmypQmGTlsIrMy3KxyECnGdZIZuh9PDV3cBJ18UfYOLAZ6vyNdVcwjFiOFt6Ped8+jSWEN7/ayI84jNqsua+m762kV7c9biApREhDGGRPVeUGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=XwDKVD2R; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-50ea9daac4cso588764e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 08:38:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1706287093; x=1706891893; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yIxa+CX1/TJs1SziOesxW18rUtHS0l1URIjIkyBIsA8=;
        b=XwDKVD2RLd1CZDfeeMEsBkWMS2jUFIsglljV6SKUUpnli4HJJuW2lf6H4R3ndVcBEF
         /IGT4Mt6B/olhQvxoqkE9YPjbaRvWAnacgmBn6lgZZ31J7ytw9mzqp67ifkSCWw5NmYH
         nzKxbeyCYLjesvcbGWnnP6aM92m1I2ylFLxh9vxCqwLUg4daJZsx8THaTnt6TTlDD89Q
         ZQuAqzqRCcZUp4TPKH+nC6CP9zXb6x1VdAIvgsN2CtqTK4IbgFPxF9uK9S/razHH4FWT
         FjsEspWwDMr+lMvDu329Vnit8qkf8tYWKIKCbs72DOFaio5V/+4QyMIEO1h5CKzBS0uU
         1+PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706287093; x=1706891893;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yIxa+CX1/TJs1SziOesxW18rUtHS0l1URIjIkyBIsA8=;
        b=b49VrPD2lO6To3CzaBY71TWVrjpraBNmOeP8eckFtqvPbyfFoc9SLRbF5fnGh23ECX
         fX6P2JamjETR7wvvNS0HIsGsff0YsbXc75/qr4hRHycb6zW7lPVBSmt9NcidMwhgsQGO
         /Y+lXg07MqSVusil+hJnrv55rdYMPUwDG8eK5WhXZxQqC9icW3vfsdZ+o2vQiRK9L6St
         i76ZLJQWmdBoZOqxb4jf2hpNzUvsd1lUOSp5nuSik2XQOAcgSnsobpArG1kxqS+ieEsS
         rZ9GynlS+ev45vf2Dojg6R8C9rt9GFRApvVBV6bmhsET0MvU6gSBPdHQR7elfKiMjZKs
         JtDQ==
X-Gm-Message-State: AOJu0Yzy89zUDg3h9z0j/q0HxE+wq/iMjSVJodr/+wC8vaEk0nl2Jkpt
	bKWE3h3aDCGxpXQ6N4PtnaBzbfD3i3YksLhRQTv4JOcwciDZc4sTbCQLo+hfn4U=
X-Google-Smtp-Source: AGHT+IE8xcb1wWSISj/bWqhgPC2j6HpUh+TnOucjqd3fNKnHetPqYqz6sgdZkACsOKi6NIy3PvfbbA==
X-Received: by 2002:ac2:5a51:0:b0:510:1777:9559 with SMTP id r17-20020ac25a51000000b0051017779559mr821159lfn.86.1706287092847;
        Fri, 26 Jan 2024 08:38:12 -0800 (PST)
Received: from ?IPV6:2a10:bac0:b000:7589:7285:c2ff:fedd:7e3a? ([2a10:bac0:b000:7589:7285:c2ff:fedd:7e3a])
        by smtp.gmail.com with ESMTPSA id c9-20020ac25f69000000b005101772e298sm220688lfc.19.2024.01.26.08.36.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Jan 2024 08:36:41 -0800 (PST)
Message-ID: <4f717166-863e-4145-8b8b-37e09415e855@suse.com>
Date: Fri, 26 Jan 2024 18:35:59 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] Randomness on confidential computing platforms
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 "Reshetova, Elena" <elena.reshetova@intel.com>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>,
 Theodore Ts'o <tytso@mit.edu>, "Jason A. Donenfeld" <Jason@zx2c4.com>,
 Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
 "Nakajima, Jun" <jun.nakajima@intel.com>,
 Tom Lendacky <thomas.lendacky@amd.com>, "Kalra, Ashish"
 <ashish.kalra@amd.com>, Sean Christopherson <seanjc@google.com>,
 "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20240126134230.1166943-1-kirill.shutemov@linux.intel.com>
 <6afe76be-90a7-4cf7-8c6c-23e6a14f8116@suse.com>
 <DM8PR11MB5750C6641F0951928E95439BE7792@DM8PR11MB5750.namprd11.prod.outlook.com>
 <ZbPWht37uWZGhp4m@redhat.com>
From: Nikolay Borisov <nik.borisov@suse.com>
In-Reply-To: <ZbPWht37uWZGhp4m@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 26.01.24 г. 17:57 ч., Daniel P. Berrangé wrote:
> If the CPU performance counters could report RDRAND exhaustion directly,
> then the host admin could trust that information and monitor it, but the
> host shouldn't rely on the (hostile) guest software to tell it about

I guess it really depends on the POV - from the POV of an encrypted 
guest the VMM is hostile so we ideally don't like to divulge more 
information than is absolutely necessary.

OTOH, from the POV of the VMM we could say that the guest could be 
running anything and so a facility like that could cause some confusion 
on the VMM site.

I think it would be very hard to reconcile the 2 views.

> exhaustion.

