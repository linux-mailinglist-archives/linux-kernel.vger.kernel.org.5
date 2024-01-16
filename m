Return-Path: <linux-kernel+bounces-27053-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F80F82E9C2
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 08:03:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 906EC1C22FF4
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 07:03:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF3E41118A;
	Tue, 16 Jan 2024 07:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rmmwY1bA"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B3FE11181
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 07:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-40e857ce803so1497925e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 23:03:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705388604; x=1705993404; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7ubEpkO6/Y13Ky3MlzkPlkr59ZgnN/6fY2ZD40DKlH8=;
        b=rmmwY1bAIfjyw/w39xCNgvAIWqQSztJDG/Z8twJml4Cj5WAQ9lkdN0dpr70tvSQ3S+
         XcnQvLiCQro5YpjN3dVPcX69fETYClKFgGJiUYKy0K+JGQej373k68/mQh3e/hh9M386
         aTOnunSu0y762h2WItYKTNKzcq+Vb/pa+JF8P5dCxkJWZUBjaEa8phRf2NLludtvVOo1
         gRmRiZciQ61axTdwz7SzovaasHhQiw/kqE/tfx+No8gXXI9G49eqWVIBWH2nNJSr8Y8w
         7Hc/9opvvg3U/pNZU90i1TihN8zrv/Pv+2+anB2vzhbwPiBImLSoUzz9awR5wPcNaIhk
         UTlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705388604; x=1705993404;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7ubEpkO6/Y13Ky3MlzkPlkr59ZgnN/6fY2ZD40DKlH8=;
        b=P1RsF1MUyxGfrxyC8GTz8I5bypO7sydaKksH051aMm+EIJloG4eI15coX8ekUxTRu7
         4p8su2JS3AHc0RNT6zQovZXd0cbR+1v4gnksotO5unj7SkOr1PWDHoY1QAc8nPHy72SD
         wgEkLrGgNuTVqKFj/bJfDD2k2tVGmdV2e+irC0wnQ4ElBiJZd6P5NS7OaTQ0KJyutXIL
         enFSm1NVw+yKkcYPWDVST51Wnzo3wJP0icV042v+e0STL9yDMAyVFKOJL/1K/t1GzgTd
         +0g/AvPUCgL/0AkS/3tI759CGT/VHtS1jtErUci1bTL0L6vlHRkrzuM1D1kXUMvr42xr
         UxWg==
X-Gm-Message-State: AOJu0Yx2fwU756MS4eSd+P2O75uhAFyLdy4IX8a+sKchGk16aznGSFhK
	X96G0oL+lvWWnlYJetSip6Q2aqVaKK5erg==
X-Google-Smtp-Source: AGHT+IFuPymM0Is/pp9GG5BAAkrpd+are7WyNdnD46YLBfk1DLQZLbFjRh2GAT2wfLMHO8TCSTOueA==
X-Received: by 2002:a05:600c:3c89:b0:40e:4f7a:bc29 with SMTP id bg9-20020a05600c3c8900b0040e4f7abc29mr3274254wmb.159.1705388604648;
        Mon, 15 Jan 2024 23:03:24 -0800 (PST)
Received: from localhost ([102.140.209.237])
        by smtp.gmail.com with ESMTPSA id k9-20020a05600c1c8900b0040d772030c2sm18087654wms.44.2024.01.15.23.03.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jan 2024 23:03:24 -0800 (PST)
Date: Tue, 16 Jan 2024 10:03:20 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: Julia Lawall <Julia.Lawall@lip6.fr>, Kees Cook <keescook@chromium.org>,
	"Gustavo A . R . Silva" <gustavoars@kernel.org>,
	cocci@systeme.lip6.fr, linux-kernel@vger.kernel.org,
	Harshit Mogalapalli <harshit.m.mogalapalli@gmail.com>
Subject: Re: [PATCH] coccinelle: semantic patch to check for potential
 struct_size calls
Message-ID: <6ee33330-134c-4bdd-a5eb-e8ff0db6cc8b@moroto.mountain>
References: <20230227202428.3657443-1-jacob.e.keller@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230227202428.3657443-1-jacob.e.keller@intel.com>

What happened to this patch?  These sorts of patches go through Kees?

Also it would be nice if it could handle char arrays.  It doesn't warn
for the kmalloc in dg_dispatch_as_host():

drivers/misc/vmw_vmci/vmci_datagram.c
   227                          dg_info = kmalloc(sizeof(*dg_info) +
   228                                      (size_t) dg->payload_size, GFP_ATOMIC);

The Cocci check is looking specifically for:

	sizeof(*dg_info) + (sizeof(*dg_info->msg_payload) * dg->payload_size)

But since this flex array is u8 there is no multiply.  I don't know how
are it is to add support for char arrays...

Also another common way to write the multiply is:

	sizeof(*dg_info) + (sizeof(dg_info->msg_payload[0]) * dg->payload_size)

That should be pretty straight forward to add.

regards,
dan carpenter



