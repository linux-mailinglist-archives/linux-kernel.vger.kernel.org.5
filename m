Return-Path: <linux-kernel+bounces-37317-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FA1483AE2B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 17:17:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2B301C20978
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 16:17:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D0CB7CF1D;
	Wed, 24 Jan 2024 16:17:22 +0000 (UTC)
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D9557CF03;
	Wed, 24 Jan 2024 16:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706113041; cv=none; b=nkva5FqsHOYhOUy/BV+/9MzYS8VYbVP5fTy97gf4b7B/aMcO4ocwxjCPzaePHXDcMElnhaeOJygRIs4LWC/k+U1M3VjoyFPCD1UgieGJbqDgdiX1Y0DqcGk3LjrjUzREQp/tFl4rgz6+v1mLmlFnDH2ogcPN/3gMitV3treV8ZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706113041; c=relaxed/simple;
	bh=+Bdszo43BcEN1DaJmlTgTYQHqv7S0WaelZBt5xQMMkk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=OYsOldU5Y7Lui+84/d78E3/42PUM9oP3EAUZlWs/viySsfXZLeR2OkIQ31lK739YxbWASsTAgxGRsLGL6I6IVlpkkThtEC4IKCFipQv0p8HHfu5IMaTQ8KXQr/FDArTDnEVuIVw1hKpvX6HVSVdySH5AXkrSIt0f0IUJ2F4GDpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1d71cb97937so35391665ad.3;
        Wed, 24 Jan 2024 08:17:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706113040; x=1706717840;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+Bdszo43BcEN1DaJmlTgTYQHqv7S0WaelZBt5xQMMkk=;
        b=LQPlerVEU/Z/il4ETbt/YPKvr2U9deooywEryFeaedP5WUbUsj/ZwnhANpYhhmDnZ/
         xlSLog0836bnZK0bsNBM8CucZNk5wVYGpCfu4MRKQB2szOJkJhX0VAa1F6FTOfukM33g
         hy/nvoJq7U+sO4QhEbF9ZDza3ntK/cvTp5QMuSj38lklAndhKiqs8jE1Y+rI1UYEqbMz
         HPG09o6NxSBlBoXQE28oSdpIt+VhzaIbAUvosRGnletuQug1r4x5S7bTJBIW8Coy87uY
         E0Dz6lVGB9WZp7zdDdcV2lvU6OIYT0XSBYph+JYFgfnH5h61c76aGc1PCTtatNrFErqh
         3rew==
X-Gm-Message-State: AOJu0Yz1tPza+EUtj6zS5/9RVu5JMOw2L7qhVBvCwgrIlvHLR9YzGWUT
	4u7NvFwVT9c1jwlpj69c15lRpa7iA2XJJUoMbrFlIxUXnyTd15xn
X-Google-Smtp-Source: AGHT+IHzXI4gTNMTprrybtMnYNEdZMgcb7EzH7OPaLzl3Mu0L6JmbLJygZk48DrcvYjzZoRbZqrPgg==
X-Received: by 2002:a17:903:41c6:b0:1d7:55c7:e5c with SMTP id u6-20020a17090341c600b001d755c70e5cmr720214ple.25.1706113039707;
        Wed, 24 Jan 2024 08:17:19 -0800 (PST)
Received: from [192.168.51.14] (c-73-231-117-72.hsd1.ca.comcast.net. [73.231.117.72])
        by smtp.gmail.com with ESMTPSA id y4-20020a170902d64400b001d7465c213bsm5767988plh.197.2024.01.24.08.17.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jan 2024 08:17:19 -0800 (PST)
Message-ID: <92463403-ea32-4545-a466-21243cd454e2@acm.org>
Date: Wed, 24 Jan 2024 08:17:16 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] scsi: ufs: core: Remove the ufshcd_release in
 ufshcd_err_handling_prepare
Content-Language: en-US
To: hoyoung seo <hy50.seo@samsung.com>, linux-scsi@vger.kernel.org,
 linux-kernel@vger.kernel.org, alim.akhtar@samsung.com, avri.altman@wdc.com,
 jejb@linux.ibm.com, martin.petersen@oracle.com, beanhuo@micron.com,
 kwangwon.min@samsung.com, kwmad.kim@samsung.com, sh425.lee@samsung.com,
 sc.suh@samsung.com, quic_nguyenb@quicinc.com, cpgs@samsung.com,
 grant.jung@samsung.com, junwoo80.lee@samsung.com
References: <CGME20240122083204epcas2p26a1bca522e201972ca072e0b24d23a52@epcas2p2.samsung.com>
 <20240122083324.11797-1-hy50.seo@samsung.com>
 <06e0ae57-f567-4b90-ad68-4ae73909c29e@acm.org>
 <017501da4da5$405e5ec0$c11b1c40$@samsung.com>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <017501da4da5$405e5ec0$c11b1c40$@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/22/24 18:38, hoyoung seo wrote:
> When err_handler is completed, active_reqs becomes negative because
> ufshcd_release() is called again in ufshcd_err_handling_unprepare().
> I tested it while printing the log, and if I misanalyzed it, let me know.

Please repeat your analysis. I think this patch is wrong.

Thanks,

Bart.

