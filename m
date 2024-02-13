Return-Path: <linux-kernel+bounces-63361-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77F61852E2A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 11:39:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3408F282FDC
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 10:39:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A695376FA;
	Tue, 13 Feb 2024 10:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LOoQAgYF"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B93C374F6
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 10:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707820745; cv=none; b=Qp1/SAANT+gmyYB5DWdQ4A3nSw6HrlnXf5TFWfQEyk/pYGJbtgPrAcmcZYqPMBlnp5NKHJtGl4a2noGj1SH8sknGS8riWFPDh9xiKnoVGdQbc4HO4Pl2wCnW1H2LxZMY10fISMLLlVxego4vWl8HD8c6VuclkfxIwuTEsG6rHIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707820745; c=relaxed/simple;
	bh=DPAJJ6+Tl3KYxFgSKAZZFfKjslshlSYUsBea4Y0f2Dw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qtY6PPpzq5cepcG0rzOQJKqd5SfvNeMsaD6aw0FlRaD7m/5s6Kj43MTCcLS3RhfpY4LbcEcLgAuUAmntRY39mU5m1vrzmxwnmFZD1X8ulByQsA6xwJFDJSGo+DkZ7C4yBXyFQZIiox4jwzqoWxHQ2nSsXgyUR3oDcxHVvGp+l3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LOoQAgYF; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-560c696ccffso8877332a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 02:39:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707820742; x=1708425542; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=99+dlQnmmbwfzZHXcOtlcot/gJ/sAgU+2AfoLVc2BmA=;
        b=LOoQAgYFcgKgxPvVHPm0ZQ0i6QkMFk2UcobFWdWcyxBAq/AntruIUB4VFr8hpRMheD
         Il+ksI3DT7lLqGhEyjHybDkFg/ATqbx966p8amU7gpC0KM/tpwIcstMmCcPPtTksOyXM
         kUNdoR9nmZB2HxGllqjcNRNiNuGLHD+FxjAEIvTMpVw30zRrWDchX5XU+frV/BOg7012
         ZEjkvTXOLjLLT8yD2KNalpYljzaJOhOCnxDz7NF5EeA7bQLTs+klEFbc7zyMWUSiM1rq
         402avbyqtcwK+5ZAf5TnOC9IGrlRUFwgUrMaYBmfExfJBX/w4Jlw7C4BhfiosqOEBhUe
         VEOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707820742; x=1708425542;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=99+dlQnmmbwfzZHXcOtlcot/gJ/sAgU+2AfoLVc2BmA=;
        b=DN9/FPsjTrw942F/fKLQe3r/prQNhO1NYAdw8M1c8rue2d3AFqb1sZUkSV3LDRIDan
         k1mObZujeu5NVXShhmoEtBAAYAbAKNU+zWVptpCdDd+JVPLIrw9ys6EFBokTkVtKcG4D
         UWHX9M5d6y8tWLnGti9G+1JsZk4T0LLTSaxujzXQS56vWBabzgVV/5wtLvC/0s3qgSCf
         8JvaFj86ulu4Gv+iqM0KviXYbLnn5nMwBZFSkJbrHcBlWkECW3Zslk4iUxEnxEVtQEUi
         poDBhUeXdlPFqQu1msDyqmsMdrZ4eQA7ep5aAuPh7KgQbEh3LClcAJnRPn6gu0mf+9Kb
         k0fw==
X-Forwarded-Encrypted: i=1; AJvYcCW+JotiA/sZkPhFJmTX0ShruCNk8MoeSMQfsCQhAJ69SThNGGBxQkRALkMY5dBjecr9U8GZs4uA1cWFn1ZBOpr34flLQFCfNHv5TkJX
X-Gm-Message-State: AOJu0Yy9oxT6fpb0PZAk7oo3GhYa+RuxhmjCjEbgU3IR2vqu94AIRzT/
	YtZaD7/74rRrl2UTtfdSvzI+0yw40RyoYSsN0jGUphwbe2dLstUg
X-Google-Smtp-Source: AGHT+IEwDNgVcPUJWxRahWyBCf8IjXub0vy03iUtob4mGtDxKnzJrX/QbaA4pxRUih2wB3UnEMrt0Q==
X-Received: by 2002:a05:6402:3605:b0:55f:d7f8:1072 with SMTP id el5-20020a056402360500b0055fd7f81072mr1864764edb.3.1707820742256;
        Tue, 13 Feb 2024 02:39:02 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV0v2tlfdoYrSx2OW8B07sma4E5XVwxOFU7X4nbYjErD8VpRK/rL7Ls7WZ/hBHTrpztXy3A8miT+AxqWDKLupkTGYM3nB2MC2Hdho90ar1lupWY9YTHdQIAmYoLb1JWGpiaoMZhH0ubAiL3JraxdUT/G7OaAJxKB+sEVX4Bu0mbO/KjqLTkFUWjJ4sOPF6gL2yFhSNDGbs4oJ0KyCWtIppixKEoris8x2UhvmLHRFXryekQ
Received: from andrea ([31.189.95.98])
        by smtp.gmail.com with ESMTPSA id f17-20020a056402355100b005620a2b5cedsm102875edd.49.2024.02.13.02.39.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 02:39:01 -0800 (PST)
Date: Tue, 13 Feb 2024 11:38:57 +0100
From: Andrea Parri <parri.andrea@gmail.com>
To: Eric Chan <ericchancf@google.com>
Cc: conor.dooley@microchip.com, aou@eecs.berkeley.edu,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
	palmer@dabbelt.com, paul.walmsley@sifive.com
Subject: Re: [PATCH v2] riscv/fence: Consolidate fence definitions and define
 __{mb,rmb,wmb}
Message-ID: <ZctGwaTnEfkum50a@andrea>
References: <20240212-projector-dangle-7815fa2f7415@wendy>
 <20240212105946.1241100-1-ericchancf@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240212105946.1241100-1-ericchancf@google.com>

Eric,

On Mon, Feb 12, 2024 at 10:59:46AM +0000, Eric Chan wrote:
> Disparate fence implementations are consolidated into fence.h.
> 
> Introduce __{mb,rmb,wmb}, and rely on the generic definitions
> for {mb,rmb,wmb}. A first consequence is that __{mb,rmb,wmb}
> map to a compiler barrier on !SMP (while their definition remains
> unchanged on SMP).
> 
> Introduce RISCV_FULL_BARRIER and use in arch_atomic* function.
> like RISCV_ACQUIRE_BARRIER and RISCV_RELEASE_BARRIER, The fence
> instruction can be eliminated When SMP is not enabled.
> 
> Also clean up the warning with scripts/checkpatch.pl.
> 
> Signed-off-by: Eric Chan <ericchancf@google.com>

I suggest to split this patch into multiple patches ("one problem per
patch" and all that), say:

  1/3 - riscv/barrier: Define __{mb,rmb,wmb}
  2/3 - riscv/barrier: Define RISCV_FULL_BARRIER
  3/3 - riscv/barrier: Resolve checkpath.pl warnings

Please also review the changelog(s), since the description above (in
particular the information about __{mb,rmb,wmb}) doesn't seem to match
the code changes.

  Andrea

