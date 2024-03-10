Return-Path: <linux-kernel+bounces-98326-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7913D87786F
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 21:25:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34EB72810FF
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 20:25:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 484733A1DC;
	Sun, 10 Mar 2024 20:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XdznT4Kw"
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B86163987D
	for <linux-kernel@vger.kernel.org>; Sun, 10 Mar 2024 20:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710102315; cv=none; b=KGgzQhcgHO5EUsXOzKdYmUvuHaIQTa44840Y71HcNaEhIOusiXHf2hlN/PQUINuTpl6laXDeEoXCGgqitjSaMK1uf7+M1cCv6hAeUxgSfWDXQvTyDu4aBas1gXZgIRfI2njzpSm5kY2j2pJaIjB7b1QXuff1TTBPmzaNkJKww2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710102315; c=relaxed/simple;
	bh=dX2AMrq/7kp8z60Mca7/OzLoKxT4Q4mWoJ2VKPVk7I4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aJRn6e0iWuTTLPl+QIAo8SL4a7AxRngx3yOgZaEKSePfbOclYL+2LWOsj9jBY5m14hm2AMwMoSpuPbOMrk3LXeeNRnp+8e15LrDjx8c1Yj4w60YkgPvxWvLstmua39jkOgkwAwNgZG4+O+/ng1vwi+8cm/PT4TwhYzwzzSl+kXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XdznT4Kw; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-299b818d63aso2524061a91.0
        for <linux-kernel@vger.kernel.org>; Sun, 10 Mar 2024 13:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710102312; x=1710707112; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wgxsON1wX0X5ll1QPvTDk6MMOdNDfvszUycVnKDJ7XA=;
        b=XdznT4KwHCpUohU7NRJm5Nb5UzYQSlwRacPHS4vWUzIjr5lIQG4Wa1TQ7vtKoBLysy
         rz7nV4K2bWzCAOaxH3efBuPWVE+JUqh5RTkEc+mT71lla+JrjLalehFB0m/w9Zm9v1wV
         80nXQcjQPholUQQfvt+2jG7wuv2xQkklWHI9HxmidGO8cacwhGhlMR1kkcwEhsrEz7+7
         M/JUuJ6L/XcdNhOX7zBoKDiSl2Hc/b841dLlFqrDs62k+9f+VvNVia6yGZDT8CHeuqyj
         E3vSAfgc/q5G2LwXWCGMLLXu28MwuKjj00Sag1GhAHvMMWnr62Cq7SGb+a4aOR18HzRU
         tIaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710102312; x=1710707112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wgxsON1wX0X5ll1QPvTDk6MMOdNDfvszUycVnKDJ7XA=;
        b=RM4Qx/eWBv3DB3p8oXY+JkU3rIE77hzEAj0u/piidNbVPB/KhzcHUE/3G+7HrmUbt6
         6BJhAnsrhlfzZ3PaEevwhbEm9HisR5PSOR/E2amlhpdHfEIWTGgqfCxlwBF371KeRHpv
         5VlG36QIbHBJccbhPfkQf92DT3n14MB+2J1L/xf2lNiIjxQEoudrh4x0kv6zEMtzuAM8
         8gp8zDRCPW04bIu0yXDIkfuSrCQu6Hw+HPdOYXtZ3t+HwUQdzQMGj5OdqL4J5k6cGFVY
         3NN7pQ3FDWVL9q359MLGB7mxM+Mz+MQxdDZwYW7LY/Bd17eqJ1ZRCm4PnNg1I6cI25py
         Fryw==
X-Forwarded-Encrypted: i=1; AJvYcCWHKBdOtv63UySG6zciZb3zyw7/GwyMRAOqWmYEb6YKjZS6UhdymalAQAgIRHx/TTQ3GjVKh2MMUHeHlsCZQ7MgRxZKqPd99L4H8T8N
X-Gm-Message-State: AOJu0YzgtY048NFhI2qMD8sxO5jX5xsmjxjNTw8szzXTS9JpLfNHejX1
	rOdVxPdSDXSLcw7/lG2BFONX+UQ5IHWLycvY3pSulIjPKwqk1HKgxsRAGwkF2Q==
X-Google-Smtp-Source: AGHT+IFuuQ9QL7EHIljZVXvrBxDr5fqMxAMmld1+YwO0Nq+B5cB1dC46S6HnVmwhaGwLIzAJTjMfsw==
X-Received: by 2002:a17:90a:f992:b0:29a:decc:711f with SMTP id cq18-20020a17090af99200b0029adecc711fmr7689327pjb.20.1710102311843;
        Sun, 10 Mar 2024 13:25:11 -0700 (PDT)
Received: from google.com ([2620:15c:2c5:13:d1de:e5bb:fcf:1314])
        by smtp.gmail.com with ESMTPSA id g19-20020a631113000000b005cd8044c6fesm2923687pgl.23.2024.03.10.13.25.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Mar 2024 13:25:11 -0700 (PDT)
Date: Sun, 10 Mar 2024 13:25:06 -0700
From: Igor Pylypiv <ipylypiv@google.com>
To: John Garry <john.g.garry@oracle.com>
Cc: jejb@linux.ibm.com, martin.petersen@oracle.com,
	chenxiang66@hisilicon.com, jinpu.wang@cloud.ionos.com,
	artur.paszkiewicz@intel.com, yanaijie@huawei.com,
	dlemoal@kernel.org, cassel@kernel.org, linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 6/6] scsi: isci: Use LIBSAS_SHT_BASE
Message-ID: <Ze4XIlerHpox-INc@google.com>
References: <20240308114339.1340549-1-john.g.garry@oracle.com>
 <20240308114339.1340549-7-john.g.garry@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240308114339.1340549-7-john.g.garry@oracle.com>

On Fri, Mar 08, 2024 at 11:43:39AM +0000, John Garry wrote:
> Use standard template for scsi_host_template structure to reduce
> duplication.
> 
> Reviewed-by: Jason Yan <yanaijie@huawei.com>
> Signed-off-by: John Garry <john.g.garry@oracle.com>
> ---
>  drivers/scsi/isci/init.c | 23 ++---------------------
>  1 file changed, 2 insertions(+), 21 deletions(-)
> 

Reviewed-by: Igor Pylypiv <ipylypiv@google.com>

Thanks,
Igor

