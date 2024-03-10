Return-Path: <linux-kernel+bounces-98321-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 55CF6877864
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 21:17:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51BD81C2096D
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 20:17:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC16C3A1DC;
	Sun, 10 Mar 2024 20:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nEUjC3om"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3824383AC
	for <linux-kernel@vger.kernel.org>; Sun, 10 Mar 2024 20:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710101856; cv=none; b=dxk4KaBeww9eZl/pEj4h/pGxPsPdt+pfQegCTWwA1UgN+10xGHACYH49wKK1cVydDiBGFrae2/T/ziB/OGpH6mLgJNrumri0+wcXvLka4lihOmXkL8nn0Rm9m13g/nIBzcodyCR2WyV1R/3U0GvDpmTIFg1MdTDXbunoat/1z7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710101856; c=relaxed/simple;
	bh=yYpWxaTagmqVzXIXxrJg3aLLEPUItswmEUTywcZvkUo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mMQMYlkTcGcgD2T2XRCpxn0c6oRuxI3+RNR8RXNhWMn9bNKtOFoPD6Umu0LQNigklFa/7yYU/z+79Y1Va+HUcaOkZk4DF282idN+Sly/jrjK5CvUp0o7rFX+thsDyu0iup5FJirPb0WV/5dshWVzEaI7vFUnBfv769yfZCYHR4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nEUjC3om; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1dd916ad172so3484935ad.2
        for <linux-kernel@vger.kernel.org>; Sun, 10 Mar 2024 13:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710101854; x=1710706654; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WbiSzw26+9373KYouYTfVHpboWaxNLA5RmqGKrJSo98=;
        b=nEUjC3om9ooDnd/4bTXaTwNJz6rGWVy5+4Ugqzje0Zfpljlc4x46/ZBEg+oSHFXO+F
         YWzwZzSMSLFJv1uDm+ZqgttR4CyH8RPyXJNaV06RPZP74sbAu+Muiu/yqmUzikyhkedt
         2NfXe3Ujj95W1L812F/XqBdHFGPJVncgLAi5R5kpCQs7QTKH1mQbkzAOfux0jj2JT+8p
         qTN9lSoyx8fcIS7qvMD+KybR1d7pQT1jQd+5T+g4qqQyR3p3GjI7d9U9B6aejoFyWxrc
         sa5IiUFntLhJOtupSTDe67BJhC5X2+H6nR6GleqCLyMe9ggqdfd7JkVnVrdbteHYcN6C
         HeUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710101854; x=1710706654;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WbiSzw26+9373KYouYTfVHpboWaxNLA5RmqGKrJSo98=;
        b=rLg7QNk9LmBnAiZebDeItzZMjyg9qjyYt5gcAn4igTgwX5YUlsScAr2dYCLq0MJPfw
         OnsdK2HFmI+krY3SCfNgxaxK++6GOh3mNRDb+G9K84YwM+XrNpVWHinGKnrLngDDMG+d
         n9F2SXijbsYkPOT14AZAe4NdYZNhIeilpsDXV/9zyfjcAO7k1YDuWxg7YJsKOWVkAl90
         V2E5gK2hbQq46MQHRqNZuYKt6argGpfr2ph5NYncMgQ1y+09sbKT1PdMfTpvnittGGcS
         vVKVIyXanh53jZwkTQ1aLKf/Ee2Lu3wFKoXtUbP9Xzo4CvR9R5yO6r83AjwhHdr+4DLS
         daJw==
X-Forwarded-Encrypted: i=1; AJvYcCXWlNSlDlEBTDgxRERMGekRBovNNDRcTP54gCEv5zCvJscgPzAO7M4snQ40X0/YIIdHZ/8d64BUN9cYcWdjkEfGwRRCSZJEJe6Sherc
X-Gm-Message-State: AOJu0YwMtIleG8cEWh/nPfKoSCF8FzAUoCf6pBvMJV3VdUnjOWqdUerD
	+MU9lFsm2E63RKEZK2ohX+Rgptq28mbhH0Z2Ss+QQ6+7uk6A3Ow6ACCgpnQ6AQ==
X-Google-Smtp-Source: AGHT+IHpNG92iH7XTGOkJLBcMhmM9mRBUygQpDgdmRz9qp4hXq7hh1jlRbGd45dyAql9JF0l5lIGaQ==
X-Received: by 2002:a17:902:7608:b0:1dc:90c0:1e9a with SMTP id k8-20020a170902760800b001dc90c01e9amr5153297pll.64.1710101853807;
        Sun, 10 Mar 2024 13:17:33 -0700 (PDT)
Received: from google.com ([2620:15c:2c5:13:d1de:e5bb:fcf:1314])
        by smtp.gmail.com with ESMTPSA id p8-20020a170902e74800b001dd6298a3efsm3039369plf.118.2024.03.10.13.17.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Mar 2024 13:17:33 -0700 (PDT)
Date: Sun, 10 Mar 2024 13:17:28 -0700
From: Igor Pylypiv <ipylypiv@google.com>
To: John Garry <john.g.garry@oracle.com>
Cc: jejb@linux.ibm.com, martin.petersen@oracle.com,
	chenxiang66@hisilicon.com, jinpu.wang@cloud.ionos.com,
	artur.paszkiewicz@intel.com, yanaijie@huawei.com,
	dlemoal@kernel.org, cassel@kernel.org, linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/6] scsi: pm8001: Use LIBSAS_SHT_BASE
Message-ID: <Ze4VWDO6_X6BbH53@google.com>
References: <20240308114339.1340549-1-john.g.garry@oracle.com>
 <20240308114339.1340549-3-john.g.garry@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240308114339.1340549-3-john.g.garry@oracle.com>

On Fri, Mar 08, 2024 at 11:43:35AM +0000, John Garry wrote:
> Use standard template for scsi_host_template structure to reduce
> duplication.
> 
> Signed-off-by: John Garry <john.g.garry@oracle.com>
> ---
>  drivers/scsi/pm8001/pm8001_init.c | 20 +-------------------
>  1 file changed, 1 insertion(+), 19 deletions(-)

Reviewed-by: Igor Pylypiv <ipylypiv@google.com>

Thanks,
Igor

