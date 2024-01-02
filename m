Return-Path: <linux-kernel+bounces-14941-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73EE08224C6
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 23:33:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC9CA2846AA
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 22:33:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8949B1799F;
	Tue,  2 Jan 2024 22:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="drZpLk1E"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84E251798E
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jan 2024 22:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704234796;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=InpOfT2E7Tqmz/iJUFZq/GV7WFjIogIQCOUR5Q83uaQ=;
	b=drZpLk1Eqy9naXLC9bMTsEYaZ0FHL+5+jMnguk6sNH3FH4v1TpdH5eW2l4KJA1V8uSJmuf
	DtDQRMBjG55/hyIgVCmF7eKbvQ+Rs3VMieqieov6lge+UdBULhj2YFjl+KDPRbNQyIQHeU
	c6Axzco6SByeM+PqPiM4tKzSz+/B/no=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-516-XdNZTOH0MriiI6NNVO1_iQ-1; Tue, 02 Jan 2024 17:33:12 -0500
X-MC-Unique: XdNZTOH0MriiI6NNVO1_iQ-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-40d3c533083so95665435e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jan 2024 14:33:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704234790; x=1704839590;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=InpOfT2E7Tqmz/iJUFZq/GV7WFjIogIQCOUR5Q83uaQ=;
        b=jxIuxONOb/ba7cltelgE4bcfWWDXOFAfuQWt6L6M/jeaK4YQe3aurRp0LvFeJl0+hf
         Le2XUCsKzrziBruelYlbZCf95e5W5Z1jyW6Z226pusTDsR4MCfiV3/3/fgMd/7qfphXW
         8r2p3z6pbIx8Oo7AwPM8oSo7YdAT8TZRr8LgUsdrgFzXyaMoHzNq6PpQM/QRAlLNHl3i
         vO0VbVi+o8WOp8IOmulgQsSZM92Vq6mHgsYIB24W9epQbx+h2AHLKvF4MKQzncGlOTmw
         HVKTd6KH00Gk13qCmYHBITchs0VBRAFaB2t5U8T726UhW9IYxasEB7ocYEqFJ+btue+E
         w2vA==
X-Gm-Message-State: AOJu0YxFW1z8upV9mC7Ge4xgYxJtd44xosBXPwlldaBdlT+W7caARitr
	wMNoJ/0STWagsx2ZdVjmQ3WbjfD7qH+b9pSRV6EMSD4Qdd/gpwBieG9GhwFqfc0TxJFyE3EEYUC
	1npoPYRJwDfCMv/OVdftA/O/OlTLPoEh7
X-Received: by 2002:a05:600c:ce:b0:40d:87c6:5e9c with SMTP id u14-20020a05600c00ce00b0040d87c65e9cmr1987518wmm.181.1704234790129;
        Tue, 02 Jan 2024 14:33:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFoRoaDqBAgyBHODiEey6e4bbsAjQYmWR5eN6/aHsnYO/Lfx5lRPxLMrx6jq8/V3SSd+YzUqQ==
X-Received: by 2002:a05:600c:ce:b0:40d:87c6:5e9c with SMTP id u14-20020a05600c00ce00b0040d87c65e9cmr1987513wmm.181.1704234789917;
        Tue, 02 Jan 2024 14:33:09 -0800 (PST)
Received: from starship ([147.235.223.38])
        by smtp.gmail.com with ESMTPSA id m1-20020a05600c4f4100b0040d5b849f38sm370659wmq.0.2024.01.02.14.33.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jan 2024 14:33:09 -0800 (PST)
Message-ID: <55f330aee9267a0ab7bb7dfbbd9ca0f41e59eaae.camel@redhat.com>
Subject: Re: [PATCH v8 07/26] x86/fpu/xstate: Warn if kernel dynamic
 xfeatures detected in normal fpstate
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Yang Weijiang <weijiang.yang@intel.com>, seanjc@google.com, 
	pbonzini@redhat.com, dave.hansen@intel.com, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Cc: peterz@infradead.org, chao.gao@intel.com, rick.p.edgecombe@intel.com, 
	john.allen@amd.com
Date: Wed, 03 Jan 2024 00:33:07 +0200
In-Reply-To: <20231221140239.4349-8-weijiang.yang@intel.com>
References: <20231221140239.4349-1-weijiang.yang@intel.com>
	 <20231221140239.4349-8-weijiang.yang@intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

On Thu, 2023-12-21 at 09:02 -0500, Yang Weijiang wrote:
> Kernel dynamic xfeatures now are __ONLY__ enabled for guest fpstate, i.e.,
> never for normal kernel fpstate. The bits are added when guest FPU config
> is initialized. Guest fpstate is allocated with fpstate->is_guest set to
> %true.
> 
> For normal fpstate, the bits should have been removed when initializes
> kernel FPU config settings, WARN_ONCE() if kernel detects normal fpstate
> xfeatures contains kernel dynamic xfeatures before executes xsaves.
> 
> Signed-off-by: Yang Weijiang <weijiang.yang@intel.com>
> Reviewed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
> ---
>  arch/x86/kernel/fpu/xstate.h | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/x86/kernel/fpu/xstate.h b/arch/x86/kernel/fpu/xstate.h
> index 3518fb26d06b..83ebf1e1cbb4 100644
> --- a/arch/x86/kernel/fpu/xstate.h
> +++ b/arch/x86/kernel/fpu/xstate.h
> @@ -185,6 +185,9 @@ static inline void os_xsave(struct fpstate *fpstate)
>  	WARN_ON_FPU(!alternatives_patched);
>  	xfd_validate_state(fpstate, mask, false);
>  
> +	WARN_ON_FPU(!fpstate->is_guest &&
> +		    (mask & XFEATURE_MASK_KERNEL_DYNAMIC));
> +
>  	XSTATE_XSAVE(&fpstate->regs.xsave, lmask, hmask, err);
>  
>  	/* We should never fault when copying to a kernel buffer: */

Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>

Best regards,
	Maxim Levitsky


