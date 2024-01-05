Return-Path: <linux-kernel+bounces-18299-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFB40825B1E
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 20:34:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7ED13284D53
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 19:34:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E01435F1D;
	Fri,  5 Jan 2024 19:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LyEap7yp"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7038C35F03
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jan 2024 19:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dbe02d0c945so2182713276.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jan 2024 11:34:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704483246; x=1705088046; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=hEJDIB8qOx1bE60qtdVH7cfex36lZT4z+xm74XgRHuE=;
        b=LyEap7ypE/QS11sJ0FgAFFOTIhmY4IjoHNZGSbVT4nEkrRDVFaOiMNcuHtrP6WKzb4
         +iKmk9I3oYPS6jMEGHbkl/PTwDIBiM8zPr1Gf0YfRbZ/XcDdS+TSTvB6PNwZrw78+fjt
         Bggbs3lhMMwyOZ8UFAl4CLI7wbsGQRU9jMr0rx+fuV6qy/19bMDELE10tWJIyALC1HTt
         FncXHGAhVTp9g3GDvB72uRU8FNSrLvM9yob0YtZSNTrqKBhXVIvLlIOfkuuZ9NYN7acS
         sBWISYOfMFvawXy2S0vFTGIe9MMzMOHdtofggiBKz9mi90jr1p0zU9iYnwAHmb7tHYtT
         HXGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704483246; x=1705088046;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hEJDIB8qOx1bE60qtdVH7cfex36lZT4z+xm74XgRHuE=;
        b=UrVVoPSz9eYtletsTN9hpC+Lmvow6+RlEY06d8YAwrF8dnzPHDCZSD9TuzxkvpX5Ub
         MV7+llSdXc8ZZ7P5BGYhKIKzb9/zYx0JUJ3vV7E7sH8V2CSKlv3PPzA/HX2EK7oKj80+
         +F7AQXNaHLlk9PPipnT2NMyZrDOCzw8KkSitHslwdnBsQpOGPgW3AF8RISWioFsgmQcq
         Bn6Gw3/F4lZmGJZ6uhjYOUn4WcJSxQDTjnVo+M83d49tRERHvfDJcn8EmGxjesdXL11n
         O7iYPP0s8U2qpMXkiyioC4nilPH+g66bykF4nhaWnSeQXU7CmUyzRTkfq+LkngwoLuMa
         23Jw==
X-Gm-Message-State: AOJu0Yzs1J79DRUewtUYVF7tL7ah9Ytz+CXGWrFgbM4fUzYG8FVf0g4h
	GARZY6+IXELsH5lhO0XHVaMXdq5Vv6wR/rYMng==
X-Google-Smtp-Source: AGHT+IGd2T/rIWNY6+XdfFt1mC9WAJuF1uI08JFUWx+5BfKpWIv4SsIpc3Tn0gLNPBbxSVVTODLuj9c47+4=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:1347:b0:dbe:ab5b:c667 with SMTP id
 g7-20020a056902134700b00dbeab5bc667mr85020ybu.2.1704483246492; Fri, 05 Jan
 2024 11:34:06 -0800 (PST)
Date: Fri, 5 Jan 2024 11:34:05 -0800
In-Reply-To: <b6ed5961a3a73de532e2ff0610f43ca129151199.camel@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <5f57ce03-9568-4739-b02d-e9fac6ed381a@intel.com>
 <6179ddcb25c683bd178e74e7e2455cee63ba74de.camel@intel.com>
 <ZZdLG5W5u19PsnTo@google.com> <a2344e2143ef2b9eca0d153c86091e58e596709d.camel@intel.com>
 <ZZdSSzCqvd-3sdBL@google.com> <8f070910-2b2e-425d-995e-dfa03a7695de@intel.com>
 <ZZgsipXoXTKyvCZT@google.com> <9abd8400d25835dd2a6fd41b0104e3c666ee8a13.camel@intel.com>
 <CALMp9eRMoWOS5oAywQCdEsCuTkDqmsVG=Do11FkthD5amr96WA@mail.gmail.com> <b6ed5961a3a73de532e2ff0610f43ca129151199.camel@intel.com>
Message-ID: <ZZhVzNb4QHzGJO6W@google.com>
Subject: Re: [PATCH v8 00/26] Enable CET Virtualization
From: Sean Christopherson <seanjc@google.com>
To: Rick P Edgecombe <rick.p.edgecombe@intel.com>
Cc: "jmattson@google.com" <jmattson@google.com>, Chao Gao <chao.gao@intel.com>, 
	Weijiang Yang <weijiang.yang@intel.com>, Dave Hansen <dave.hansen@intel.com>, 
	"peterz@infradead.org" <peterz@infradead.org>, "john.allen@amd.com" <john.allen@amd.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "mlevitsk@redhat.com" <mlevitsk@redhat.com>, 
	"pbonzini@redhat.com" <pbonzini@redhat.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"

On Fri, Jan 05, 2024, Rick P Edgecombe wrote:
> On Fri, 2024-01-05 at 10:09 -0800, Jim Mattson wrote:
> > > 3. Task switching
> > 
> > Sigh. KVM is forced to emulate task switch, because the hardware is
> > incapable of virtualizing it. How hard would it be to make KVM's
> > task-switch emulation CET-aware?
> 
> (I am not too familiar with this part of the arch).
> 
> See SDM Vol 3a, chapter 7.3, number 8 and 15. The behavior is around
> actual task switching. At first glance, it looks annoying at least. It
> would need to do a CMPXCHG to guest memory at some points and take care
> to not implement the "Complex Shadow-Stack Updates" behavior.
> 
> But, would anyone use it? I'm not aware of any 32 bit supervisor shadow
> stack support out there. So maybe it is ok to just punt to userspace in
> this case?

Yeah, I think KVM can punt.

