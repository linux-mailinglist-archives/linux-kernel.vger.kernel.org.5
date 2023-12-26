Return-Path: <linux-kernel+bounces-11682-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DBE581E9F3
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 21:19:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFF9A1C22060
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 20:19:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 424E7525B;
	Tue, 26 Dec 2023 20:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="l1RPWUn9"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0978C23C9
	for <linux-kernel@vger.kernel.org>; Tue, 26 Dec 2023 20:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1d3fde109f2so444205ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Dec 2023 12:19:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1703621964; x=1704226764; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Qy7OBrlPSY6+TWnz2A3BwrQfBm97ETQ3NJPDilJmZtI=;
        b=l1RPWUn9Zle3L0MAKudeQtmVbbVjwZRmKBGirnqjvewX8Atpty8rVyv8IUrOlmfuuN
         LVZ5unXZL3+8Q7WIXsX+s/SPcrecdf7xAfnzqDCghwW0dy10qfaqXO5CCQ3EfAOhmjs7
         UIssLbjOboegejHuC8EJ9MoFKLAkSp/4yEZ8WICTxmIf75BAXa//EiVeT+uCyc6wOd8J
         PS2/MxvBNGIqK9kH4oxPUHqIQwGf7Wr4gCFxAcVzr6SD3YetBSIQd4X4la2ADE15xdss
         jivLlNhuXzif/QgfFDoavGhmmyMd5fQpRuuK9VMIC3U/UFPk4O6mM90FckpRhBoO4JJU
         AHGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703621964; x=1704226764;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Qy7OBrlPSY6+TWnz2A3BwrQfBm97ETQ3NJPDilJmZtI=;
        b=xKPIFKIf3oeX8+vPM3bVRsLR06osyo3PjHAIA8ePxQ6h/hmVD7/gFbBFCRLPpNYaQj
         lTNnLCFmmzHYO6GLO4oAmF/8IlfvuBXGYlgl9xTJmvQYvLFI1ZbiQozzqSRXBgasIXXU
         QA94MC8HyZS17wSCmqNuwwaF2Th/KDp9PbpJkIqvDCKWOv+zOUTH4eyIjXUOPRw5kTHR
         sKjHLH1F/Qzfro8UfCB231PERcNHIFpjm8aSy8RfD6sNVcldRAPP1swDLx+0mIEhUHhe
         /+teE2JxCd0O0xtZ1IX+r4qqLY+slu6nnTgEKlzhnaTAiLTZolhVA4KQcxEHzj1Kckt9
         RdmA==
X-Gm-Message-State: AOJu0YyCr3LmDxivm0HT2pTR6WnxyPltGRq7lLtB0/2DTGBMoCo82PUC
	EvC7369Ol5K0PHUy14EZg0a9ZMK66fu4
X-Google-Smtp-Source: AGHT+IGb8BUs88EqjDGKSeSrkFRE+ApjMpYa7VzQ0qV38ikOSCyzYuc1Yj/kXHPVV1FhfDw5/Q0rNA==
X-Received: by 2002:a17:902:fd43:b0:1d3:f25c:7d69 with SMTP id mq3-20020a170902fd4300b001d3f25c7d69mr470013plb.12.1703621964106;
        Tue, 26 Dec 2023 12:19:24 -0800 (PST)
Received: from [2620:0:1008:15:5a8c:89e6:ca2f:ea30] ([2620:0:1008:15:5a8c:89e6:ca2f:ea30])
        by smtp.gmail.com with ESMTPSA id pg6-20020a17090b1e0600b0028c30430deesm6700117pjb.33.2023.12.26.12.19.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Dec 2023 12:19:23 -0800 (PST)
Date: Tue, 26 Dec 2023 12:19:22 -0800 (PST)
From: David Rientjes <rientjes@google.com>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
cc: akpm@linux-foundation.org, linux-mm@kvack.org, mst@redhat.com, 
    jasowang@redhat.com, kvm@vger.kernel.org, virtualization@lists.linux.dev, 
    netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] vhost-vdpa: account iommu allocations
In-Reply-To: <20231226182827.294158-1-pasha.tatashin@soleen.com>
Message-ID: <a9721920-6a87-8f68-3ff8-6cb691fe9465@google.com>
References: <20231226182827.294158-1-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 26 Dec 2023, Pasha Tatashin wrote:

> iommu allocations should be accounted in order to allow admins to
> monitor and limit the amount of iommu memory.
> 
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> Acked-by: Michael S. Tsirkin <mst@redhat.com>

Acked-by: David Rientjes <rientjes@google.com>

