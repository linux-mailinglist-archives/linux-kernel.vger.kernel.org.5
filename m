Return-Path: <linux-kernel+bounces-163457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A83188B6B4F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 09:18:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CCD17B21AD7
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 07:18:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65BF938DD2;
	Tue, 30 Apr 2024 07:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tP+u1jH8"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABFE72C184
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 07:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714461488; cv=none; b=nlPlArtMS+/NIcPAhv5JKwXhZBaFnCfuTGZZTdXGJhvQAIa5j55e57XVEtLwRbAdma0MyaVbFL9ZiVgYO73begw0+TUR0D1zCtDPMMGbKs63WwTqVvi//2CwVKNVlvGaYpP+L44trX/ymPdmFC7lgVfq4/0lyv0lJ7J4RrW67ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714461488; c=relaxed/simple;
	bh=gYjD/L9hhfN50Ps9Y9MHFLTnRz+JNZ4XvkTy/yEmsi8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qvYikL2Su4qE1LaJgY+hgvLjTMpv9xf2QkWDlW+hMamRu5pKW11OrAjja/NVeqMyQBfFnLEfAOJroeNFDTNVT1jH2VqsUGYIhUsaAEHb8yqq4D5fKDhfcznvd0QsnqtrWBQIeMt/17q/2L1KX/XBjoR6hS1isW2EQT4cu1VEISM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tP+u1jH8; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a58f1f36427so321176666b.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 00:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714461484; x=1715066284; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0BPb7ImAff8lr+4NxPMpbVa+ZVOYDgWvOqFiGV9m05s=;
        b=tP+u1jH88wQgo4uYeE/NYc6b56PmOx0k4deajcWljYRGFvi8nMeh7CpSUZhBJ7LtUy
         fMCTFBZ6oeB66dqZW/NAmAHK4BM9s26QGxuvGUdWlKPSt3UNYnCm+PmeT7WYOfneb20B
         DACa4T0fOphSVNsx+U76eJTkpJqusHP8GGSAj5pDQNS2kSVl1FH/XW2uLTQbF85PXhSC
         Zoz13RQJqyh8nJm5Ftt7xLawrQOH45Q9hfGbcHhIEiuuj1sYl894WgNYsVmBbvhCogd0
         WPaD6VJvXjGUiTm1nC4m50Qc8PmEK1GkFd5JOg/e1a6nt7B3R8TXNLojvk7Y4JXs9Yz+
         vosw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714461484; x=1715066284;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0BPb7ImAff8lr+4NxPMpbVa+ZVOYDgWvOqFiGV9m05s=;
        b=TNFGUNVuZrIBvmK6DmstXPHtwp+7S6WGvxZEuyZ3hNCff9nOmMoVqodxk0zFHXO31O
         PqIQjd3f163EcCuI1hrkJu6fAs3r1+J2Vzgq3aiAr6XHF5lQ14Ax/4EOep4hEmemxzdw
         Wf7X9zRuRHZ++cMNmKf67OgkUNLrHjmGa7dJovbzVFWq59VkpgDQsyq1ZxGrbITF6AHm
         p0dTE5otP9JXxDe1hZADNrl5IKIx8j62MMAWhDhE6esTnSY6M29u2NxpmwKZeNdMbx/r
         5JU7ohLRl/voDBR2tCXNtJ6iWabfPOPWS/9ugpFrahoYYMe5Su6JyRgyeRqDCVLvMbuu
         1dpQ==
X-Forwarded-Encrypted: i=1; AJvYcCUp3PkAaS2b8dyDcNgmHi6AmBeD3jyqZuzqWbSCLFr3DkfAGdtWKXXNuARyoXhyLtUV94yltXl8JM5oKqgr6LHILEMdGRYheZCK/SNm
X-Gm-Message-State: AOJu0YxZlso8k8rO2dPPDx9BcUPtONRfouVFS5SUMO0Icz/pmXfeif/3
	zmkgvT6WoTbvoul0JKlvwY/IIyDMVSMq6d5Bbh7Qjfy1GPcXlYuiYttxXD0mZ2g=
X-Google-Smtp-Source: AGHT+IG+O/XTMqMHGbpqGOnwmoixz0hzGXrkxyCkjoDOsOV96VRhtmo4H/tetmj5Fz4yK3hhi1Uvwg==
X-Received: by 2002:a17:907:334b:b0:a58:f1f3:626e with SMTP id yr11-20020a170907334b00b00a58f1f3626emr1104497ejb.56.1714461483594;
        Tue, 30 Apr 2024 00:18:03 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id f20-20020a17090624d400b00a5575cde7cdsm14423007ejb.220.2024.04.30.00.18.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 00:18:03 -0700 (PDT)
Date: Tue, 30 Apr 2024 10:17:59 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Jameson Thies <jthies@google.com>
Cc: heikki.krogerus@linux.intel.com, linux-usb@vger.kernel.org,
	pmalani@chromium.org, bleung@google.com,
	abhishekpandit@chromium.org, andersson@kernel.org,
	dmitry.baryshkov@linaro.org, fabrice.gasnier@foss.st.com,
	gregkh@linuxfoundation.org, hdegoede@redhat.com,
	neil.armstrong@linaro.org, rajaram.regupathy@intel.com,
	saranya.gopal@intel.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/4] usb: typec: ucsi: Fix null deref in trace
Message-ID: <32855f4c-f219-4396-81c3-42cbea9fe4da@moroto.mountain>
References: <20240424014821.4154159-1-jthies@google.com>
 <20240424014821.4154159-2-jthies@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240424014821.4154159-2-jthies@google.com>

On Wed, Apr 24, 2024 at 01:48:18AM +0000, Jameson Thies wrote:
> From: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
> 
> ucsi_register_altmode checks IS_ERR on returned pointer and treats
> NULL as valid. This results in a null deref when
> trace_ucsi_register_altmode is called. Return an error from
> ucsi_register_displayport when it is not supported and register the
> altmode with typec_port_register_altmode.
> 
> Reviewed-by: Jameson Thies <jthies@google.com>
> Signed-off-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>

This is not the correct way to fix this.  The normal thing to do would
be to add NULL checks.

https://staticthinking.wordpress.com/2022/08/01/mixing-error-pointers-and-null/'

regards,
dan carpenter


