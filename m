Return-Path: <linux-kernel+bounces-135977-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 00ACC89CE81
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 00:36:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F2EC1F2364C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 22:36:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEE8F2AF14;
	Mon,  8 Apr 2024 22:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="duLf6SKb"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93E7817745
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 22:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712615775; cv=none; b=Qfk7txuCsWPnkXCh/aBBxEwLMb1zMMFzhvtoP2fcsqtgOBsomclN54/Zz4bEdQnJudpqmX/hmPpN9SG1l5Xyjd8VStnCFnRjP67VrBLs1XFW39K0uYG3jWmyA+8Ng63Ulu2z4DR74bdinSMrtF+RAOJLWbiPqYdWSWNfjVyg6MI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712615775; c=relaxed/simple;
	bh=wd9auWj6neAH4mwPBANg9G0rtjJL6aqclc7lajDKiYg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hma8U7ZKjL8EW85naVTW3zsSiHR8tMk1Q9Ihndpysa0ffTZuTnFLfV06//6h4rrrL2conQtN74/Q9uTHr8y0MkhqJz8l9N6LF2tSqMnohxlGtKLaQ5Hyiyw4k6yieWpPX4mXcJNbqrZ09Af742EJuAX1A4ZeZ5rkOJe+tWGv8Mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=duLf6SKb; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-1e278ebfea1so46377745ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2024 15:36:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712615773; x=1713220573; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H3IyoUWCaMuOsrSmdtiAaHOAeX0T2/iesX+PuEFhG/o=;
        b=duLf6SKbk9ruf+aEZLiUtDpW0RGBgbPH30ZOBaR1wAaybjARXGQUQ994/OaZmZlOid
         A18DKxs3nd0A340wmKgBZtU91VKnlhAw6uVCEhX1Iiu5EU0Nki9wRrrackSe5N50PZXq
         C7t6A8xTtYI2WeJB1AgNG09I5lHnzle3OfURmBgupr2/J9/W6tePa0lyMdePy1a5gdWZ
         L+Dm9Ky8eH7M39zwMiSmCiB2dnepn7Az6sqQ5wHDaSJcm5lW9nndKlUmWlRcRsrLNgri
         EYMqD9BzrRyOC00KTabTi3ZmbQCuu9Vk4R++CnXpHRB7ijewPsQs7BJNBiaswKhD8OKN
         GN0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712615773; x=1713220573;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=H3IyoUWCaMuOsrSmdtiAaHOAeX0T2/iesX+PuEFhG/o=;
        b=U93hJ3sMsyomfyDRMuDgGR5D6ge2X7DBWphxFFchUmKkRU8Dk8RLfS50Yz2oVLEX1B
         ePAo9NHgWE6pdjtZOrZpUFmdN0b9nc8jw3sWrbWofULpDwUDHex58Qp5M4PUJc1tkv4E
         qM+WgYsT9L3jRy7fUIITO1ywiPA5TkYft/62bdEFnxbLrYiTuVehWfrmAKOab4LtNal1
         TWqqAtIJIF7MzzP6wqzotb1fTdutZP8+OHT+pHvVXS/CbxVp91cRy42DSukimzQqI8ar
         zXoIL+HdmgiQuSPni15oxXuQlcWYMOrX+J1JCPkrdbFWPWc2iKVpqdTuLyOhsrHc5fyV
         BHcw==
X-Forwarded-Encrypted: i=1; AJvYcCVk2V9bbupCFl8n3bHc582GPxsSejK9fHnHIeEJ+oVch6TMl6Jjgj/D2gjlrb4CL3rlF8akaWsV96rJY6NNdpOJyTIeHh25DFfFj0oK
X-Gm-Message-State: AOJu0YxpFntcLan6Ac6qX19kH1OEeex/QvcDjhuivmkA/aK9AbXA02yA
	CHP70HRb2Des+l0wWSHzbbuy3I7DpD4Urxi+A+a7nrYvshmgb9qAdZtE3TzWUgwXjEkTQyRzNXW
	yDA==
X-Google-Smtp-Source: AGHT+IGA02QPgUvTHLSjG35tJY/y8cz2zBR88FLhWwtJO2ItlMMNLpk97KO76IwFPepitjBhAf8k/cmoAGo=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:ea01:b0:1e2:b75e:37b5 with SMTP id
 s1-20020a170902ea0100b001e2b75e37b5mr352811plg.2.1712615772902; Mon, 08 Apr
 2024 15:36:12 -0700 (PDT)
Date: Mon, 8 Apr 2024 15:36:11 -0700
In-Reply-To: <5faaeaa7bc66dbc4ea86a64ef8e8f9b22fd22ef4.camel@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240405165844.1018872-1-seanjc@google.com> <73b40363-1063-4cb3-b744-9c90bae900b5@intel.com>
 <ZhQZYzkDPMxXe2RN@google.com> <a17c6f2a3b3fc6953eb64a0c181b947e28bb1de9.camel@intel.com>
 <ZhQ8UCf40UeGyfE_@google.com> <5faaeaa7bc66dbc4ea86a64ef8e8f9b22fd22ef4.camel@intel.com>
Message-ID: <ZhRxWxRLbnrqwQYw@google.com>
Subject: Re: [ANNOUNCE] PUCK Notes - 2024.04.03 - TDX Upstreaming Strategy
From: Sean Christopherson <seanjc@google.com>
To: Rick P Edgecombe <rick.p.edgecombe@intel.com>
Cc: "davidskidmore@google.com" <davidskidmore@google.com>, Xiaoyao Li <xiaoyao.li@intel.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"srutherford@google.com" <srutherford@google.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"pankaj.gupta@amd.com" <pankaj.gupta@amd.com>, Isaku Yamahata <isaku.yamahata@intel.com>, 
	Wei W Wang <wei.w.wang@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 08, 2024, Rick P Edgecombe wrote:
> On Mon, 2024-04-08 at 18:51 +0000, Sean Christopherson wrote:
> > > I'm not following the code examples involving struct kvm_vcpu. Since =
TDX
> > > configures these at a VM level, there isn't a vcpu.
> >=20
> > Ah, I take it GPAW is a VM-scope knob?
>=20
> Yea.
>=20
> > I forget where we ended up with the ordering of TDX commands vs. creati=
ng
> > vCPUs.=C2=A0 Does KVM allow creating vCPU structures in advance of the =
TDX INIT
> > call?=C2=A0 If so, the least awful solution might be to use vCPU0's CPU=
ID.
>=20
> Currently the values for the directly settable CPUID leafs come via a TDX
> specific init VM userspace API.

Is guest.MAXPHYADDR one of those?  If so, use that.

> So should we look at making the TDX side follow a
> KVM_GET_SUPPORTED_CPUID/KVM_SET_CPUID pattern for feature enablement? Or =
am I
> misreading general guidance out of this specific suggestion around GPAW?=
=20

No?  Where I was going with that, is _if_ vCPUs can be created (in KVM) bef=
ore
the GPAW is set (in the TDX module), then using vCPU0's guest.MAXPHYADDR to
compute the desired GPAW may be the least awful solution, all things consid=
ered.

