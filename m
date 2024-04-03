Return-Path: <linux-kernel+bounces-129690-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A2B08896E7B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 13:50:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C903C1C21595
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 11:50:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB914143899;
	Wed,  3 Apr 2024 11:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zlgp1buZ"
Received: from mail-lj1-f195.google.com (mail-lj1-f195.google.com [209.85.208.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A60617583;
	Wed,  3 Apr 2024 11:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712145049; cv=none; b=L/PSK7/+m+LzIfmblUmnp2fjfAQrl8KSnJFbrOUnYsnRHNEc9UCUw+K9eP+wVBKb0+Il5LslkMz3sFm521Y0F8aCqPX/Eijl80BJrfEs6nkuf3/Ner//yqbVRUebF7FI04iDGXFGqVjSE1hryieWmc3RwG7c0qbDW8ZoA8wqHXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712145049; c=relaxed/simple;
	bh=VoHb9zztW8CmcerqewWCsyC+d/Zbw+VvDoHAWVhf7y8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kW7ebR/fm87tWL5tSzcuiWtetbPApIFpTCq6KxCbKBlg5dy/7V8C8WbbcJM2ry5nFlwrLL25DVnvuTBHiL08JnfxjL4k+IOU80Tzzqq/d+M8f+V4umyGDU4uTCzCGnLpTBSSSfTMgZiQ9cbNs7Jg3LhKVGgp16A+Dxbp7a5IrqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zlgp1buZ; arc=none smtp.client-ip=209.85.208.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f195.google.com with SMTP id 38308e7fff4ca-2d6a1af9c07so73330821fa.3;
        Wed, 03 Apr 2024 04:50:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712145045; x=1712749845; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f0EsZLszr4GEkfYPPMqQsCNoYiwlbaIZZo6tSjHZ6l4=;
        b=Zlgp1buZuVy9WKiH+xB4pagHF0jaL6PZEY6Y0SICLqNeSMrfskNGiS8kRygSrRbbmr
         pV30uOVFpuOaNSkAdHk3SDazhWKWvf+6MHyEBL49mZFALDbgsrlynl9STB0bcj9CzlnD
         h/UT4PsWBsd1UI9nNQRAIZwWw/eK9pqeaF45IEnI0lFOzvj2BqWf8oc4D93fvTQ8/fpN
         bp34JvYDj4kwJ0VzXbE3xIc0/pIYaJQEaTzU/ve5m8qWGx6QIyy/WJqWtyEzvVscIvhw
         AkBo5nRr/FAlzHsb/x2jL8c6EoNU4h6hfXKH36YnnA2ce65Fo/X9XsokaRtl2gSkCfGI
         anDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712145045; x=1712749845;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f0EsZLszr4GEkfYPPMqQsCNoYiwlbaIZZo6tSjHZ6l4=;
        b=p1ptA1NIbTC5Nmx+BKVEgcDdMbCKp1BOow/l3O9XsumeSPjXT5bUssCsR9ojEnIlO+
         oU6zha6i0buqmGwxwVQ5ZfyJvyXDMjfF/E7yaqUn/ZiJQfSiE1y9fzWeaSRcuXUFTdXe
         dPQInk7CkUFZqkBE+HP0czL6qMpPJ8c2aZmtoC9TzBzcuufkVSrzzMGNsoter0CfBPz9
         6mM3VOme6kzVWOrWKVpaTrx6Uj2BXMio3PtV1nMuqZ54XbLIgdi48yDf6x5N9ednoJVP
         CdBgtSAOhu8qyl67MTjhP+sh99YaQ18JeBsy5c7a0v7zcynqQV8mQDs7n+U2QLuoxXEE
         DkVg==
X-Forwarded-Encrypted: i=1; AJvYcCVO8+4Dw9yCkvId8R4UV7uRtQlAflCJVm8dz+s1M6IhOOwjI6NLT5BuaTn5yT4jhKk2mn/QDKQ8PGyhGj+3COpDWRfIL8ByziMmOz+N
X-Gm-Message-State: AOJu0YzaFOb0YBh0Nvx4wcsJY82zYAnTzNZUO3nrlSQev739ZPybNUf7
	edKAXLNwjhGRVEjm4mnEbfvt3BGxFSz2SoH1MatUHAqoEB5tIZs3xgVEkwODoYE=
X-Google-Smtp-Source: AGHT+IFQO1CbssgeGtwKX4YhcElc2stT81r/6YDPYIYejXWn24Pn30PdsXqqNROQHpycDmMcyga5cw==
X-Received: by 2002:a2e:908f:0:b0:2d8:3b49:f831 with SMTP id l15-20020a2e908f000000b002d83b49f831mr1294154ljg.2.1712145038258;
        Wed, 03 Apr 2024 04:50:38 -0700 (PDT)
Received: from localhost ([217.212.240.69])
        by smtp.gmail.com with ESMTPSA id i5-20020a05600c354500b00414924f307csm21383579wmq.26.2024.04.03.04.50.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Apr 2024 04:50:37 -0700 (PDT)
Message-ID: <3e8f39e2-ef6d-485d-9a39-a36b04266a62@gmail.com>
Date: Wed, 3 Apr 2024 13:50:21 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next 0/4] net: route: improve route hinting
Content-Language: en-US
To: David Ahern <dsahern@kernel.org>, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, willemb@google.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240307171202.232684-1-leone4fernando@gmail.com>
 <9ce73c04-ee8f-4aa5-ab15-c31dbe409401@kernel.org>
 <4bf87e9a-71a4-4586-a112-43f8ce20eb46@gmail.com>
 <2893a096-c07d-4ba3-85a8-db18616810f3@kernel.org>
From: Leone Fernando <leone4fernando@gmail.com>
In-Reply-To: <2893a096-c07d-4ba3-85a8-db18616810f3@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi David,

> 
> For the rest of it, Jakub's response was a good summary: it is hard to
> know if there is a benefit to real workloads. Cache's consume resources
> (memory and cpu) and will be wrong some percentage of the time
> increasing overhead.
> 

I understand what you are saying here.
Do you have an idea for extra tests or measurements to make sure
the patch also improves in real workloads?

> Also, it is targeted at a very narrow use case -- IPv4 only, no custom
> FIB rules and no multipath.

Implementation for IPv6 is almost identical. I decided to start with IPv4 
and I plan to submit IPv6 support in a future patch. 
This patch basically improves the hinting mechanism that Paolo introduced
and it handles the same cases.
Adding support for FIB rules and multipath is a bit more complicated but 
also possible. I am willing to keep working on this patch to meet the 
remaining cases including IPv6.

Thanks,
Leone

