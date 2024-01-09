Return-Path: <linux-kernel+bounces-20431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DAFD827EC3
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 07:26:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1CE001C20FEE
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 06:26:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06BF779DD;
	Tue,  9 Jan 2024 06:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Aky2la1f"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D68236132
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 06:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704781604;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=o5muih4kLDuaOJ79kxaRis+p0HII4Xana+6AsswLR/c=;
	b=Aky2la1fe0Xh6j+lD69acniS2kC09dQdxnY6ww4z8svMco9xxlYt9F4tdyyHaKkmKxr30A
	vqorS8BzPjjJ1rKk78NyE5UDnpVfQM9zSnRSoXdfD7YjX/IvSxkYTbtSbGowIgaFr+1jms
	n/4GhFZHDcwFh6nDpBcpUvRoXYGsfUk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-417-4LJdWG4yOXCNjI4oGSg-kA-1; Tue, 09 Jan 2024 01:26:43 -0500
X-MC-Unique: 4LJdWG4yOXCNjI4oGSg-kA-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-40e439092a0so16714905e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jan 2024 22:26:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704781602; x=1705386402;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o5muih4kLDuaOJ79kxaRis+p0HII4Xana+6AsswLR/c=;
        b=BWHpKMRNu9CsJUgN8kvHE8UlhlOvdhvVBRGKq11SnZkq08PTPNTcod1EqqYcYJSlGi
         8G2nNFPVU04xh7vZB5Q5PZVMBDg1aS9VXAuBouihJCH5T7galGrRVJufFtVmSbUeH5Na
         sYIS/XG3jzoAT0UbWOakyzDqeMmmoa+MHVwCWiX+6bujrSvyqMZ6USdBlBJkz/exHbP/
         Xd2ealV1fR3dX8SN8gMMEp3dOtq1+PzEe/sGgV0zCe3EZqx+k04jCamCZJ7+DD2TpO4A
         HpflaDx5E3etI5S5d6mmHNv2lutWiYoKYl2sMtGTqEaJ3IZYUqtGmCGqxAkHm3o74X8m
         ecaA==
X-Gm-Message-State: AOJu0YzXlEgW1h2bpjVPNsmuFPeJCrZoU6JcGiZ90zoQH5RnE9gYDGlC
	ACaIhOXj5KT6jw2PrxLKOxQNtWk6WJcc7ZV3c6WKJx7oviLO1HCAPlasRucs4Ac8LIPz1Bd1Q/K
	fP17cOX5VvR3oHVbp4Bv4YWEqiVWMpuynJqWiaTO35wSumm5f
X-Received: by 2002:a7b:cd0d:0:b0:40e:4239:506d with SMTP id f13-20020a7bcd0d000000b0040e4239506dmr2027380wmj.175.1704781602231;
        Mon, 08 Jan 2024 22:26:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFVUTxD6fI8GCkCwWKDNUsc5oILgZSUFknu9p75wtGYWi8UpdMljIYYVfvPmZx7Kmqt0v8T7GDBV1OM+0Mt1QY=
X-Received: by 2002:a7b:cd0d:0:b0:40e:4239:506d with SMTP id
 f13-20020a7bcd0d000000b0040e4239506dmr2027375wmj.175.1704781601960; Mon, 08
 Jan 2024 22:26:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240103075343.549293-1-ppandit@redhat.com> <CAE8KmOwPKDM5xcd1kFhefeJsqYZndP09n9AxaRbypTsHm8mkgw@mail.gmail.com>
 <ZZwy-wCpHs-piGhJ@google.com>
In-Reply-To: <ZZwy-wCpHs-piGhJ@google.com>
From: Prasad Pandit <ppandit@redhat.com>
Date: Tue, 9 Jan 2024 11:56:25 +0530
Message-ID: <CAE8KmOxk+Vesh_y_gwM+GD8F9VwK2x_MmcQ_b6CiGKORZu52ZQ@mail.gmail.com>
Subject: Re: [PATCH] KVM: x86: make KVM_REQ_NMI request iff NMI pending for vcpu
To: Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 8 Jan 2024 at 23:08, Sean Christopherson <seanjc@google.com> wrote:
> This is on my list of things to grab for 6.8, I'm just waiting for various pull
> requests to fully land in order to simplify my branch management.

* Okay, cool.

Thank you.
---
  - Prasad


