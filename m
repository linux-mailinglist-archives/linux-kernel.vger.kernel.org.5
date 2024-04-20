Return-Path: <linux-kernel+bounces-152056-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D6858AB818
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 02:18:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41B191C20A76
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 00:18:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 026FE63B;
	Sat, 20 Apr 2024 00:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aLO5fcDD"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17ACB6FD0
	for <linux-kernel@vger.kernel.org>; Sat, 20 Apr 2024 00:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713572328; cv=none; b=BD1Jqo4/FOGSBI1R5KETS25GRKp8+sEQ6VvjXvtrfiv57TeEPHeoJamT5VMp7BzG7I7whUK2qirWeRW2uCy/JNKYgtCliwKE6L2o9DaDlypkthSIYtz/qonSvDM/DnAAnAwdgtiFsxAELVvojA2mIxzxky5evwVp8yKtSPCjNaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713572328; c=relaxed/simple;
	bh=a+F0Ai7kMJcZiUKlcnNgoBnK1div0CAstJ3S0ivBgKU=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=aIr5kOIEooT/HrQeH2m+APGW8wssd763ti8Y77RHibDElrz2sbRuXq6WDe2moLLe0Y8Ce2LF5pEHrD0yOuJJgs8mB0pOy7cIQhyD0lcNA2wqZcEXvH7jKHhHGpMp4FYizVw53bz9r/p5m23iX8Uvg/+RUmWr+HG6I4LHcA9CrPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aLO5fcDD; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1e8414dc4e8so30695ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 17:18:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713572326; x=1714177126; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7HwuxwPzmT/z3ihEcWAQkbcsMHdUvyid59MaSuYG0fk=;
        b=aLO5fcDD7EYZVTnXWRgWJgkbjekxkJ4tgpO5KyOJVtg++HFYtRGpZy3mQzZkEbRBcT
         wUbJsOSXDxwZrMr5kmAXcbNuO0kJfX+YI+XqMQDerWsWrGY9f0AecHDksADQdZgyNqSO
         WDzDFM6uSVcrfJJJ1Ble4W1QLrLckQefwfOJ1o0r9Gt46q5MVrDNhC98x/A3BcEJ3UMD
         tsg5ff/uIIx5zVAlQqqWjL53FFzh3W6mGuNE6YzbqU1pHDKWr/FRd9RJghrgLFto5Pat
         tieZbniKfMW7RO2xZ51THVmVeMviq+GGNsTVbhRhgmi7NGCGTWo3ZljoYNyaxZsheryC
         LQZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713572326; x=1714177126;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7HwuxwPzmT/z3ihEcWAQkbcsMHdUvyid59MaSuYG0fk=;
        b=nBsYRwBl1DdFglEEuRlAkRa14DzW36mKuVQS/cgZMo+D3D1oesOWlFvZQiGdFGRq94
         6ZLpqGswBHdbVdSu9wGaIHKI/LrdUbeX0IIiauCZNrOugOj/iOgmcqgfGOIjQT/LfdXs
         zdjS9lS79YemRqtVGU2uejyAE1sofnrnVBW7D6eWpTeGqRECrpQ8Epon04OWen1khBLZ
         vLO/EoKGnZJL23BTtqRjn13pDXvaBhyOr80SoEv9EFRZV3kKGdtq4unUraaq7yJfv0h6
         6f6751itszDU0xqRqLpkwPkLzUtEAktuY6ksbpM+YJfw11QGIGE3ayMbmhMAqRt1Gch9
         bsdg==
X-Forwarded-Encrypted: i=1; AJvYcCW0SubslWn1bHy93hq3+doB9wbY1RSoybsfaTXyiFft8NV8+AX+0EOw+vgdPyVNxzKPpZzfshIWUINwP2xk6sNgfE5p3Nhg3K2NywVU
X-Gm-Message-State: AOJu0YySv2ESNBzcN0D/V3pCIijoDpgmsjbou1Mkb1d24JPAiUfvV71/
	LithPMrr0sjG6QB00NGZ+wtWIqnZa0ctHGnbwd7kD71ELjsGcd/oPW3iKVhn/Q==
X-Google-Smtp-Source: AGHT+IG4F01l9vOXAGAgTrRJloE92W55eOltoeObPXGlHwb1tAyTJhQcF9ONRTHfml/l8PjYgelomA==
X-Received: by 2002:a17:902:6bca:b0:1e0:a7ee:18b2 with SMTP id m10-20020a1709026bca00b001e0a7ee18b2mr49126plt.15.1713572326106;
        Fri, 19 Apr 2024 17:18:46 -0700 (PDT)
Received: from [2620:0:1008:15:1ed1:e8c8:9e4a:e624] ([2620:0:1008:15:1ed1:e8c8:9e4a:e624])
        by smtp.gmail.com with ESMTPSA id fd16-20020a056a002e9000b006e5808b472esm3944337pfb.95.2024.04.19.17.18.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 17:18:45 -0700 (PDT)
Date: Fri, 19 Apr 2024 17:18:44 -0700 (PDT)
From: David Rientjes <rientjes@google.com>
To: Jianfeng Wang <jianfeng.w.wang@oracle.com>
cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, vbabka@suse.cz, 
    cl@linux.com, akpm@linux-foundation.org, penberg@kernel.org
Subject: Re: [PATCH v3 2/2] slub: use count_partial_free_approx() in
 slab_out_of_memory()
In-Reply-To: <20240419175611.47413-3-jianfeng.w.wang@oracle.com>
Message-ID: <3f53b749-46b3-d1a6-8984-c8a3fc9481ac@google.com>
References: <20240419175611.47413-1-jianfeng.w.wang@oracle.com> <20240419175611.47413-3-jianfeng.w.wang@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 19 Apr 2024, Jianfeng Wang wrote:

> slab_out_of_memory() uses count_partial() to get the exact count
> of free objects for each node. As it may get called in the slab
> allocation path, count_partial_free_approx() can be used to avoid
> the risk and overhead of traversing a long partial slab list.
> 
> At the same time, show_slab_objects() still uses count_partial().
> Thus, slub users can still have the option to access the exact
> count of objects via sysfs if the overhead is acceptable to them.
> 
> Signed-off-by: Jianfeng Wang <jianfeng.w.wang@oracle.com>

Acked-by: David Rientjes <rientjes@google.com>

