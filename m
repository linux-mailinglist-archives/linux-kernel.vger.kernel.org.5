Return-Path: <linux-kernel+bounces-75925-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B9FC85F0C8
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 06:15:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51EA1283070
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 05:15:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F7AA749F;
	Thu, 22 Feb 2024 05:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nbQaCYzF"
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52D866FCB
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 05:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708578899; cv=none; b=iKwUMtkLCfE9dPzAlhJp1HLVd7MOqgIBQlMTiVE6YLnvk0nLHGuJxV3DAb/L+fnfsIjkZh+HcGqYbyCW21dMNnSoDS7w2xwDuoi7TqLtkEtkDMp6Ui4sJfKz6+7BaYZSZxNS0feJwwf0b8+HI7q1w7fzpFT3jFSM1Y2ByN1emSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708578899; c=relaxed/simple;
	bh=3qny8yzuMmyJ1HQecd7Y6U83EBozIttdj4TJ16oo/RA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bf6daFW1UwmnGmljmzsGP+FgeIs5QI0D0MlWv91Los/QUPPCz8qDEh95ifB1LI5HryTQzTK82+qTSkR0fQ4LhY+eR2BgswNLW4WhzW2xkDYtkxMFtsbJ4yKQ5jEJVTQnFThQ7ASu/Kml1EE4aMjTBIFmYnHRyPtrrjef6YWhMdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nbQaCYzF; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-5d4d15ec7c5so6134765a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 21:14:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708578898; x=1709183698; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SjzQi95PdLFUOi++bhedl7ZKNdPeeAhvaDxnULICb2Q=;
        b=nbQaCYzFHkSsh5xuQmilSY8caKzng7EsQVlrt0dnXkF0ss7nOHTAG5hGAOAWJvWpoI
         NgKvwLyUV9VDTIz0RjIAdBrhQdxYX2DJo6jbri4kL8qc00JgB81yovWj8ZC0j14/2pNt
         C8SSQWpgYZPydqS8B8ptc9VpTJ4xPaQB6rx0EIyJD0f9m/eBS+kNliKShqaVi+OKzDOV
         fieXFpCRfs/VjpObzj2P5ZBlBhh2K4IcaLSnmsJdHJa81h61qAtkz2MMaPuNIvv/aJU5
         B1rqQ28lMF1De2os6/HLPzuZM5k4mx7DdYjgYxPPZkWARBJ/uAalDSNV4769+tIHyPRt
         r9/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708578898; x=1709183698;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SjzQi95PdLFUOi++bhedl7ZKNdPeeAhvaDxnULICb2Q=;
        b=ct2DTiYBrqb7PH9hcBockaPnb4+PLXLa4ojzXkN5Bbe2hBxEbL7rrHVDM0W/cWu1VQ
         qRDWm2oyU0uK3btJXOooeeIe8AaDEg55lUfVs5O+eFukKyP5KV/Qpe7/+vx/bGmin2V1
         NHlYrNsQISk9BcQ0WZ8YTPMkqlOn9Edvgaoe3Z9BJfkV1PcKdzwh5Y2Hz9T/ztHC5kVY
         wtk3oDp4sZtz1oi8elSR8m8Yl6v4LoIL540g4f2micT63ipvSGLoVoopaq9GbY2RByis
         1PVqVcYMWYh8hnSqViBQemYyrbqZS2K54ndncwjuzx0qyYGJbYuNbDW6qEwS0zkf9OBL
         H+cw==
X-Forwarded-Encrypted: i=1; AJvYcCUA/1lv7qCB7Egj57xog5dprmxsmHpv+c7LV8NtW2+pus/j4UGPzH236TgyHhQgFr3qPEW7bbKf0ej+Ca3TGrCrlqkKdU8ykw/NtIj1
X-Gm-Message-State: AOJu0YxtxuAm+V8MtBqalFLMdmWfqtAdLl0MBZRzNVIyIks0Q6dUd1rg
	ppptlZx8q/VKZMUs7j6J2aN6L/Wbe0lt/fEreKz6xndSQ0jUZKcl3wM4Nhpogw==
X-Google-Smtp-Source: AGHT+IGu63MPfTR0XWOYa6xte+sdI5ID4/pSdH0NA8SBF3CrpzvthDgTRKHWJ6IOCsRKwwxCAnXzlQ==
X-Received: by 2002:a05:6a20:d04c:b0:19e:9a59:20df with SMTP id hv12-20020a056a20d04c00b0019e9a5920dfmr26902478pzb.9.1708578897688;
        Wed, 21 Feb 2024 21:14:57 -0800 (PST)
Received: from thinkpad ([117.193.212.166])
        by smtp.gmail.com with ESMTPSA id li7-20020a170903294700b001db35d8ea6esm7109815plb.294.2024.02.21.21.14.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 21:14:57 -0800 (PST)
Date: Thu, 22 Feb 2024 10:44:50 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Krishna chaitanya chundru <quic_krichai@quicinc.com>,
	linux-kernel@vger.kernel.org, mhi@lists.linux.dev,
	linux-arm-msm@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	quic_vbadigan@quicinc.com, quic_ramkri@quicinc.com,
	quic_nitegupt@quicinc.com, quic_skananth@quicinc.com,
	quic_parass@quicinc.com
Subject: Re: [PATCH] bus: mhi: host: Change the trace string for the
 userspace tools mapping
Message-ID: <20240222051450.GC3374@thinkpad>
References: <20240218-ftrace_string-v1-1-27da85c1f844@quicinc.com>
 <20240221061146.GF11693@thinkpad>
 <20240221091103.37497ed0@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240221091103.37497ed0@gandalf.local.home>

On Wed, Feb 21, 2024 at 09:11:03AM -0500, Steven Rostedt wrote:
> On Wed, 21 Feb 2024 11:41:46 +0530
> Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org> wrote:
> 
> > On Sun, Feb 18, 2024 at 02:13:39PM +0530, Krishna chaitanya chundru wrote:
> > > User space tools can't map strings if we use directly, as the string
> > > address is internal to kernel.
> > > 
> > > So add trace point strings for the user space tools to map strings
> > > properly.
> > > 
> > > Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>  
> > 
> > Reported-by: Steven Rostedt <rostedt@goodmis.org>
> 
> Suggested-by: may be more accurate?
> 

Sure. Will change it while applying.

- Mani

> -- Steve
> 
> > Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> 

-- 
மணிவண்ணன் சதாசிவம்

