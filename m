Return-Path: <linux-kernel+bounces-140748-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 53BF98A18BE
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 17:31:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 26343B2A9A8
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 15:28:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA501179AB;
	Thu, 11 Apr 2024 15:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uUIo93Yo"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE794168B1
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849182; cv=none; b=c4SECBPLc4jxVdDsadMJGSn/8XjRU5O8LoD52/A9YRS2XZzbiIu31fc38yHphBgZWIUvseApRujZhAeSYvlkwUZuIOjEb70M55vGpnHKAkby/UXTh3hjXSDnd9XMiqR1Fj+UUG2K0XtYeQhQr3fxdJvT/nZN5EyC03eFTbDDHFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849182; c=relaxed/simple;
	bh=ynCGKHUPmUHZ+eVS7oiWK85Hpo5+9fAUqkAqFmpGSb0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=pfmRGWaGi95jM6EKmxjUryDW3nlvEM6Ce0uOH3GAJNrqIWMQ86BsSl41q/6w1drvgG0JWiroc37kba98jJDpEiqlVZ9TKOIi8VsQRmhx4UT4lkJ7hltxl+0rSSqxkOQOyEEaGKP/AfatwaBGSflQNDdBYYdW6WMKMAIXEh4ASg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uUIo93Yo; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-61510f72bb3so136751167b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712849179; x=1713453979; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ynCGKHUPmUHZ+eVS7oiWK85Hpo5+9fAUqkAqFmpGSb0=;
        b=uUIo93YoOGCDFs1jtXz2iCvyVaG2gi36EqMkvEr8IygR/8RjD6hWUN9+o7qUoHDcza
         bR+SWdkj36sRWqPb4vVUxLJu96gaNBq3FXIU7sQ473nbhrTnptwNGMZIqAyvPwddn25j
         W1X2vRnZoXGSEZcKwcH2Rhwx9MaaI1zMc0DN1S1yuNE9BnfaITxyajdfEg80cz2Qop8G
         KvGoTRTmHNhGgY80OLAopKWtIAzAV/h3UcziSpGUpkCS7Lb7L43oP2YX8QK78QHP8QnH
         1bUMJm7Ethf3XpyntlZUZZSA2937JaL+LaDK/hVcnwEwXfidAI7ekL8WcZ9G1jWlwlpZ
         bO0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849179; x=1713453979;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ynCGKHUPmUHZ+eVS7oiWK85Hpo5+9fAUqkAqFmpGSb0=;
        b=TOEMg0xp0Hqy5oQmUsKCgmIFp4Ok8fnTFW+r7UpwxGT1ADpjcKEqqfarCahwro2+/H
         4chLGOWAICdoqns3rIi6kBdXr3IieZxrQwZLSUJWB+Ur94494en9aIPNQa8p7Sip0IR4
         bhlJ3z08vRN8gfZzk+EfhH0jVCEy/lG0/R2MpGwzzzNe8I/Of8HdB/ykBXMrMEMoCNzy
         mGZyKp0C2tDL1kOH3mi+U20IsWK5yUySkFvdZr6EH8BVDEvfVdetvAVmPRDhMGvnlsZ6
         7ve8gbFIh2dB3UXHl0bPk7q23yLLAkJFJzrORTkH7qtbM0TFIXxZt23zFOOVW0HMTSXi
         p2bw==
X-Forwarded-Encrypted: i=1; AJvYcCV+4pf2J31bbDzFVJs+AJkrRnOae2ZSFUmZBsYfZaJdnrCXYGc1yB8Z51ShmZcPvy97VaX4ahN+NvX39BLsl/WBks+X9oFqHVeYfdq5
X-Gm-Message-State: AOJu0YzN7ng26eHkdjYH/Hkn10sA6ou66s2Gqfjes+vLOWsMHjZVwRue
	ivtM4RKg0eDfBeyx81LGatcsxcPE0ri40UqjWMzqwpPO45qMbA6yUjlYfPgm6ImCoDYL7hssf/Y
	5PA==
X-Google-Smtp-Source: AGHT+IG8bllVA4yO1On7u5D5SxgvY3UE9xXuWus++v8c5DRGnYKSN91qnF5DOtTx85qDgLE/siI6+aiJ3uw=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a81:4e50:0:b0:615:1579:8660 with SMTP id
 c77-20020a814e50000000b0061515798660mr1439958ywb.7.1712849179687; Thu, 11 Apr
 2024 08:26:19 -0700 (PDT)
Date: Thu, 11 Apr 2024 08:26:18 -0700
In-Reply-To: <2c11bb62-874e-4e9e-89b1-859df5b560bc@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <ZhRxWxRLbnrqwQYw@google.com> <957b26d18ba7db611ed6582366066667267d10b8.camel@intel.com>
 <ZhSb28hHoyJ55-ga@google.com> <8b40f8b1d1fa915116ef1c95a13db0e55d3d91f2.camel@intel.com>
 <ZhVdh4afvTPq5ssx@google.com> <4ae4769a6f343a2f4d3648e4348810df069f24b7.camel@intel.com>
 <ZhVsHVqaff7AKagu@google.com> <b1d112bf0ff55073c4e33a76377f17d48dc038ac.camel@intel.com>
 <ZhfyNLKsTBUOI7Vp@google.com> <2c11bb62-874e-4e9e-89b1-859df5b560bc@intel.com>
Message-ID: <ZhgBGkPTwpIsE6P6@google.com>
Subject: Re: [ANNOUNCE] PUCK Notes - 2024.04.03 - TDX Upstreaming Strategy
From: Sean Christopherson <seanjc@google.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Rick P Edgecombe <rick.p.edgecombe@intel.com>, 
	"davidskidmore@google.com" <davidskidmore@google.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"srutherford@google.com" <srutherford@google.com>, "pankaj.gupta@amd.com" <pankaj.gupta@amd.com>, 
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, Isaku Yamahata <isaku.yamahata@intel.com>, 
	Wei W Wang <wei.w.wang@intel.com>
Content-Type: text/plain; charset="us-ascii"

On Thu, Apr 11, 2024, Xiaoyao Li wrote:
> flexible (configurable) bits is known to VMM (KVM and userspace) because TDX
> module has interface to report them. So we can treat a bit as fixed if it is
> not reported in the flexible group. (of course the dynamic bits are special
> and excluded.)

Does that interface reported the fixed _values_?

