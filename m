Return-Path: <linux-kernel+bounces-4652-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DE4281804B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 04:53:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B07D4285B05
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 03:53:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89BDA53BD;
	Tue, 19 Dec 2023 03:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RVv+5zx5"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC7D75232;
	Tue, 19 Dec 2023 03:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-7b70c2422a8so45378939f.0;
        Mon, 18 Dec 2023 19:52:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702957973; x=1703562773; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VbWLFBtyAplRUFACvI5DMGuOtgKln1xEAx0ADZAOZvs=;
        b=RVv+5zx5ounedfYmgw1E76X6TqzmNhxYaLpnIMSlNNiYMYrQWmcKY4Ojl5btvK+Ez2
         5lphJDqD/jzcqXbMTCgqKVmQNlHn1/q+NKZncCVIDPvh+jaFLlY4Dr6TQi5WgQcVk86h
         m0VAGpl3WDy41OdstVAGBpDF5k76l9txC5Da1M5ynV3s5mmFvc63v+wRlv8RHg8Osi6v
         S7fUc0zYi7pyNUuf2FfPU/I0R5/xN6E4ObHKFk7RW4uFwZwcbiDqr8znjTUb+NIAgKoK
         q3yqgWkB1xXboX7uxJeAbOCEQPN4RSNh8gl6YCH9AOUMBWv0BWq/ex8ML6lkSKk1f2QE
         fkGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702957973; x=1703562773;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VbWLFBtyAplRUFACvI5DMGuOtgKln1xEAx0ADZAOZvs=;
        b=Z5JAMMJAy3VYTHYcbKsN3UlyX9vVAJxY1oOxNpy9mYj73EOnMpmKuSm/emmP9mCbTG
         QYWB+SLORrvXsyGWGZ2sZHRyoy5rVWIBaPwyBlQ//UsL7hGVTvbM/isaWnsrQd54kiwe
         S9oemRxcRMzB5rwrCoSWxjrTO/lfzz84De8ZzbeOWea9rB3xGzje6hvR+z0OQkDj79m9
         ij1GOO5oQO94ZFHAeRC2/NDs89DUBN4rvPfEV0NQRZfU69dGjpQidWGV/IWWMkJUHK+c
         WcJf8llxSZ07XA+JXCBTjy/hW0pOF1Mp/PXfrAwh96RnCJe6Jl20F4Rsi1MiK+Czd+sC
         P+Hw==
X-Gm-Message-State: AOJu0YynKkCnfEOvg+yAuwMEMs3xebdsqE+IBpvELe00Sdvk86hBf1xq
	q2kpLo1sSV7v8FL82IvJNCk=
X-Google-Smtp-Source: AGHT+IHqwILNzHq9Znt1NMHD9YqI9sR3dgZOD2VHNoAOEXofNHBXUdaunMZMP7YFTu18vM19urNoKA==
X-Received: by 2002:a5d:9f05:0:b0:7b7:d4c3:65c0 with SMTP id q5-20020a5d9f05000000b007b7d4c365c0mr3938876iot.2.1702957972740;
        Mon, 18 Dec 2023 19:52:52 -0800 (PST)
Received: from hoboy.vegasvil.org ([2601:640:8000:54:e2d5:5eff:fea5:802f])
        by smtp.gmail.com with ESMTPSA id w2-20020a654102000000b005c65ed23b65sm15635364pgp.94.2023.12.18.19.52.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 19:52:52 -0800 (PST)
Date: Mon, 18 Dec 2023 19:52:50 -0800
From: Richard Cochran <richardcochran@gmail.com>
To: Min Li <lnimi@hotmail.com>
Cc: lee@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	Min Li <min.li.xe@renesas.com>
Subject: Re: [PATCH net-next v4 1/2] ptp: introduce PTP_CLOCK_EXTOFF event
 for the measured external offset
Message-ID: <ZYETkpALegYmGMZU@hoboy.vegasvil.org>
References: <PH7PR03MB7064ADDCABE34B67FA9C30E8A090A@PH7PR03MB7064.namprd03.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH7PR03MB7064ADDCABE34B67FA9C30E8A090A@PH7PR03MB7064.namprd03.prod.outlook.com>

On Mon, Dec 18, 2023 at 11:50:44AM -0500, Min Li wrote:
> @@ -50,6 +52,11 @@
>  					 PTP_RISING_EDGE |	\
>  					 PTP_FALLING_EDGE)
>  
> +/*
> + * flag fields valid for the ptp_extts_event report.
> + */
> +#define PTP_EXTTS_EVENT_VALID_FLAGS	(PTP_ENABLE_FEATURE)

Nit: Can we please call this PTP_EXTTS_EVENT_VALID without the _FLAGS suffix?

Thanks,
Richard

