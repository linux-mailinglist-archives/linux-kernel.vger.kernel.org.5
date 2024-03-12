Return-Path: <linux-kernel+bounces-99988-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F40A387905A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 10:06:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E010284B71
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 09:06:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51AB077F1D;
	Tue, 12 Mar 2024 09:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ffk7M/qV"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 981ED42A9E
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 09:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710234369; cv=none; b=PVGQjSuZeq+39+7iELW7senv0OtTJsDekN4P77nd48mTHjGCPIE+ILep9Eik0Zl/g5M9XbZM1UTz5bo79jeVoLK+7FmyoVsowi0OJW0tDDhtFqV7peqIbHCtAgGOlblg36U04MR0lhHv+immwU5Lh7f9ypUD7BjFLKazFPee3ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710234369; c=relaxed/simple;
	bh=xJXtaBA08CJQ7wZp1LsDWo3O9eXpGvNkX0ALzUkIiAk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JBdMFqKMO3Gyl/BoqaFBVC+DmljAjwvrw/wgdQ560ef1zrVfDX/XBIP57Zo8/pe/rpSnclIIJgxawPlwYScjqB8regI8ZFNmtXEZuQl/Ggmy0/o77zCoLKbu8jUHjG64WYgGeU8N2zLsA1PY/B6pXbaAVLoBoRj1smXIp4ahdmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ffk7M/qV; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a45ecef71deso443969766b.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 02:06:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710234365; x=1710839165; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GF2Syo3clnYBOqKcfzEliTm1lj0XlDsoPVwTUC8i/bE=;
        b=ffk7M/qVXPDuyL+qHdyC7MLTipIRrDmFp9zHz8TVGZtw24GkZ6RvObqjxW2B6eE4Pv
         1pVAMsGV3wPIAN88cl25WUfaaTU5hK6fojARDBeGbAW0SAqEer6o6D6L6i+vHVcGjfCZ
         2l9MOFK6vJvXyJ+sLvmZO/JTnulW1OQKXpDonCw3fFEDuNr1WyZUaxM0UcbrNuTFitEN
         Y/OKSirThCKsQrvTdyPO+edDGTIk9Ai6sgTpU7nf+TSvqgNqe13kaknpXcWvfaoSxP7v
         FxIXdM8/AeMm1HS7enRDN/IUDNI4XS8hYtUL6hRkyRZ2GjEBgWfnri4OSZVbGrIjRPlQ
         LGrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710234365; x=1710839165;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GF2Syo3clnYBOqKcfzEliTm1lj0XlDsoPVwTUC8i/bE=;
        b=emzWRaTcf/9itBVb6J4M4MP0lyzLhITDj9CrWqIoCI6XKNd6TQkH3NBz2898IJovpq
         0J598TmPAjcYyITCT9B25zXzMs1f8svFcG74fjlVDzmXu8M1vSucLUi7Z66uRazpuA+c
         LNDbZinUIbcwEH1QbxOna9wKS83tjU6HFp+2tomohPMFPB0dk9Pvr1hygkqOdBQl+QzI
         WxHxM2xZ1Z0ESi+bzVX6FgBheyp2oAiz/XYkwmUbSwD2s6Ijh0DNuG3YcWGGVU3lpXdI
         SFTf8bNwiT2gQcATVg/nO1rlxNV/hhz5KirgQt/HchEstSO4SH1c3fnyTzNGu1+E6+3z
         uIuA==
X-Forwarded-Encrypted: i=1; AJvYcCWWhxt+24Eqdk/lIalIfe5c1XsomB6RQWsCjlLwNStu7OS+pZ37WZHnm7XiitM+LrSybFZgPuLvrFjnVVAw57Nz+/FNJvpzejVLuybS
X-Gm-Message-State: AOJu0YzgZcUc65Kz2X4/nspaj6NU/I1+y9vETyoy4KIZT7naRqhmXV+M
	d37rM4Clsdoh4d8d72vSsgzJJ8fDuN3Zfy2ibo7Je8hvbj5IWHQjBGHNPvJsbSQ=
X-Google-Smtp-Source: AGHT+IECTtkVFXHQj+8/2yUZqtRCHjC+Zcl1H3VxfSmiJOzGD2qP48df52pGfPMonTdlZd0DNYsb3A==
X-Received: by 2002:a17:906:4551:b0:a46:1e69:a336 with SMTP id s17-20020a170906455100b00a461e69a336mr844973ejq.22.1710234364632;
        Tue, 12 Mar 2024 02:06:04 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id bn25-20020a170906c0d900b00a460040a102sm3494349ejb.124.2024.03.12.02.06.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Mar 2024 02:06:04 -0700 (PDT)
Date: Tue, 12 Mar 2024 12:06:00 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Michael Straube <straube.linux@gmail.com>
Cc: gregkh@linuxfoundation.org, philipp.g.hortmann@gmail.com,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8192e: replace variable with direct return
Message-ID: <64141031-4bb9-46fa-9adb-ea1a7056945d@moroto.mountain>
References: <20240312051816.18717-1-straube.linux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240312051816.18717-1-straube.linux@gmail.com>

On Tue, Mar 12, 2024 at 06:18:16AM +0100, Michael Straube wrote:
> Remove the variable rt_status from rtl92e_send_cmd_pkt() and return
> true/false directly to improve readability.
> 
> Signed-off-by: Michael Straube <straube.linux@gmail.com>

Thanks!

Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>

regards,
dan carpenter


