Return-Path: <linux-kernel+bounces-18057-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B0D48257FB
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 17:21:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 193651F21957
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 16:21:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB3023174E;
	Fri,  5 Jan 2024 16:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mT8PKoOa"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAC2C2E855
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jan 2024 16:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-5f250d8f876so37517037b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jan 2024 08:21:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704471692; x=1705076492; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=MXm45250HWKbY5wkv7Vjw2Gmncasex98nduvFn+4ss0=;
        b=mT8PKoOaoF7OEMdLSl9andwm/itss5Pa5uA4LUNk9gr1Ai6/aOFfDSqaK2LtekQWDG
         8EtSVgq3LnRtAXqeZHeXaSCALIUPl8N6zl3sh/enspWclTk3Zp0wi4N8/ye5/bCCeW2p
         gJ1bwhKHLHq7WUVOB1DuNmLWboyQrwWJjXDDntj1dYgtmTdv24EuSuwS2KAWcP5bej62
         l+kfjGIzNbplsg/TKVGErEzET5OfnKSNC9lEyeGN6X9o0obD+BJD2xVnbTGVova7xcF+
         aV6JH4Qkeaf7aDd40KRaLwgYblsx1TD97TeHrYCQMkLDg60A6pjzOKuOn2kiab2JNAr5
         QakA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704471692; x=1705076492;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MXm45250HWKbY5wkv7Vjw2Gmncasex98nduvFn+4ss0=;
        b=ShcqKUBuozI2GnkxAhfl8OTiUt5EZ8XkCAJOkIH3alWW7HsFW3i9f2pwA79CmCs496
         zOqvDyAOebnFPE2J9dQkBdWl9QEJUMkFNLjqaOjJ4s41vn8q1gSM6++7HvCaSQm8jD4j
         1bLVr9qLEb5sjrsUzLtecVutFr/uOKlym/HTnxc4WWB/NsWXWkuZzoAAjxwIt1rTlOE7
         LHTVECKKyF2vK0Lk5W1Mmf2vJT1FD2X6DsRh/zX95YVaXdtc3qS80qrgREpAVtP/RU51
         isZPmRhEsmtZB3EcskI9Jj1jB7sAVbba+OwQ6HRYXO3HJjek+ibO0hD8KyFaMKAwyIaT
         sfHw==
X-Gm-Message-State: AOJu0Yy2YItfVwWuWuuMD+F8OzFX5Xm4l5OVneuqhW7rTm1OSnw/aGk3
	ORV+MdrA2l1DecvOLQIgHjsFrAug9D2nj4pd8w==
X-Google-Smtp-Source: AGHT+IHbZOPlgrjAii1E9O+SqoqtCwWsRXudkq0R8ogO++CZtGPTxxRXLvIotMFHgEtxhKEH+RYgbe9S+8w=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:690c:311:b0:5e8:4440:c52e with SMTP id
 bg17-20020a05690c031100b005e84440c52emr1250912ywb.7.1704471691862; Fri, 05
 Jan 2024 08:21:31 -0800 (PST)
Date: Fri, 5 Jan 2024 08:21:30 -0800
In-Reply-To: <8f070910-2b2e-425d-995e-dfa03a7695de@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231221140239.4349-1-weijiang.yang@intel.com>
 <93f118670137933980e9ed263d01afdb532010ed.camel@intel.com>
 <5f57ce03-9568-4739-b02d-e9fac6ed381a@intel.com> <6179ddcb25c683bd178e74e7e2455cee63ba74de.camel@intel.com>
 <ZZdLG5W5u19PsnTo@google.com> <a2344e2143ef2b9eca0d153c86091e58e596709d.camel@intel.com>
 <ZZdSSzCqvd-3sdBL@google.com> <8f070910-2b2e-425d-995e-dfa03a7695de@intel.com>
Message-ID: <ZZgsipXoXTKyvCZT@google.com>
Subject: Re: [PATCH v8 00/26] Enable CET Virtualization
From: Sean Christopherson <seanjc@google.com>
To: Weijiang Yang <weijiang.yang@intel.com>
Cc: Rick P Edgecombe <rick.p.edgecombe@intel.com>, Chao Gao <chao.gao@intel.com>, 
	Dave Hansen <dave.hansen@intel.com>, "peterz@infradead.org" <peterz@infradead.org>, 
	"john.allen@amd.com" <john.allen@amd.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "pbonzini@redhat.com" <pbonzini@redhat.com>, 
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "mlevitsk@redhat.com" <mlevitsk@redhat.com>
Content-Type: text/plain; charset="us-ascii"

On Fri, Jan 05, 2024, Weijiang Yang wrote:
> On 1/5/2024 8:54 AM, Sean Christopherson wrote:
> > On Fri, Jan 05, 2024, Rick P Edgecombe wrote:
> > > > For CALL/RET (and presumably any branch instructions with IBT?) other
> > > > instructions that are directly affected by CET, the simplest thing would
> > > > probably be to disable those in KVM's emulator if shadow stacks and/or IBT
> > > > are enabled, and let KVM's failure paths take it from there.
> > > Right, that is what I was wondering might be the normal solution for
> > > situations like this.
> > If KVM can't emulate something, it either retries the instruction (with some
> > decent logic to guard against infinite retries) or punts to userspace.
> 
> What kind of error is proper if KVM has to punt to userspace?

KVM_INTERNAL_ERROR_EMULATION.  See prepare_emulation_failure_exit().

> Or just inject #UD into guest on detecting this case?

No, do not inject #UD or do anything else that deviates from architecturally
defined behavior.

