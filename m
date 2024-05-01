Return-Path: <linux-kernel+bounces-165712-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 674A58B900E
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 21:31:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 983F81C21294
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 19:31:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BED23161302;
	Wed,  1 May 2024 19:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dMAnDhpn"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E33812FB21
	for <linux-kernel@vger.kernel.org>; Wed,  1 May 2024 19:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714591859; cv=none; b=TrNls1Qm4p4/EsaD1XJNibsOKT28D9GSEdctIGd3ttzSPk9AGBClqW3f6f1pfHeFybzHnLPzMLCO1Am3oGN0uBGX98FKt4HcKe1fzYR5j+6kvug4/ai7CkZTr8QOrNqVA0rGG8GAkTCg8JP0CdWEqGKQK1e90ZZ6S/h3MNphqR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714591859; c=relaxed/simple;
	bh=1a8IGgt0atPExNL0kQlcJPYtvH5vrk5eOtxf0vuFGSE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=InMEQatzOFDlhKQ8zHLtSc8iQgOFUU5bzjhwQmXN88pua0/epqO+gtYLIbmvPgd7cOusQnIXBUlI3RoG5HcGj/xqjVzoX1mnlj8chr752gOoIduilQV3VrUMZVN9DRUInuRukfWLQt4Qp+aFmZvVR5cXjJFkvHmhME/xVMGYWM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dMAnDhpn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714591856;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0DpMH3OPKUdeatip9xrDr22zswVgKLvrfLJ6qW8iRrc=;
	b=dMAnDhpnb1wXgklkKWShvpfGGbPYAykJCXOsipGQ/UbDyDX5PgmbmPgP1IKDXiqpykAEW3
	AnCwqgeF3BQOrJH5x0M8tuuNlMoCNFymiG76ZLwisao9q34FCdjdlRtXyPXKf87Smqadvm
	LxMgsCX1igGhpZOHZOnV1YdA2TcxIM0=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-649-2AYy3yQlN3-Hqug-eHzfVA-1; Wed, 01 May 2024 15:30:55 -0400
X-MC-Unique: 2AYy3yQlN3-Hqug-eHzfVA-1
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-69b601a248dso89095516d6.2
        for <linux-kernel@vger.kernel.org>; Wed, 01 May 2024 12:30:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714591854; x=1715196654;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0DpMH3OPKUdeatip9xrDr22zswVgKLvrfLJ6qW8iRrc=;
        b=X4H77EfGBjOu0K2ueJjJjZuQYi/pL2R1MvbdPb+KoSNR5r+FgcyuK9eEoUzJO0mYT9
         SP3zj99wSCDqtCsddc9UKIvo9h1arU0gs6h1Zq4m1vzt00uNTGrxi8SAZ0ePrJXA+UF+
         V5N55jqTZG3qYEBgxx/c7HyHhRIMeIQunoDG9O5zWajNz0Bm/c+XDJ1FapXAFh3IIr/o
         fZkkb0jAmsMPW7+f4Q7RTl5vtsY3Ntw/iLBOwAyHWyMmrTeUY/TiI+jO1c4M4raHI3ZJ
         5W9vScu6NfRbLH+cCFJSMm0feDv3Y51JM0KonO5uxrnRwj4rTg+B7JK18/a+0XRmIw36
         A63g==
X-Forwarded-Encrypted: i=1; AJvYcCU4SG3Ih+eAiX28hT2gjwMwgPVcln8zDxn/mMaDt9Fp+ylMAgzTckwHmwspvoZAymRqcm+9BmqCETCNwAeM9C8JzNicue1Ivoga3uiC
X-Gm-Message-State: AOJu0YwEiW0S2HfgBgGbKLc8r1rUx4eDwg7RO9EJGa7SzkOGqhHXKLAf
	2MwW8Lcwg7s1QBO+Ns6PsPY1bwpusHiqKhg4wxAKhiQyU3/rcOWkl8YROBGdw00YvOkIPgXZDJL
	LQzyiWrMKty/HthASzhM3pe3I+7FwN6RQjeOksydLSC6XsO32HP53JghpRhVFAA==
X-Received: by 2002:ad4:5f86:0:b0:6a0:b2bc:bc86 with SMTP id jp6-20020ad45f86000000b006a0b2bcbc86mr2846295qvb.12.1714591854528;
        Wed, 01 May 2024 12:30:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF3bWXYpLEJh92rPxL57n6U+eQww159xQ4NM+NP8YOjyTp+DBAE5EN2Ij8n9qCiPiyz//h92A==
X-Received: by 2002:ad4:5f86:0:b0:6a0:b2bc:bc86 with SMTP id jp6-20020ad45f86000000b006a0b2bcbc86mr2846262qvb.12.1714591853943;
        Wed, 01 May 2024 12:30:53 -0700 (PDT)
Received: from x1gen2nano ([2600:1700:1ff0:d0e0::33])
        by smtp.gmail.com with ESMTPSA id kh14-20020a056214514e00b006a0fb776a77sm391077qvb.137.2024.05.01.12.30.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 12:30:53 -0700 (PDT)
Date: Wed, 1 May 2024 14:30:51 -0500
From: Andrew Halaney <ahalaney@redhat.com>
To: Bjorn Andersson <andersson@kernel.org>
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Mukesh Ojha <quic_mojha@quicinc.com>, 
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bjorn Andersson <quic_bjorande@quicinc.com>
Subject: Re: [PATCH] soc: qcom: pmic_glink: Make client-lock non-sleeping
Message-ID: <vhvuux6xxrepe5isqsbqg2hwt7k7vpjikatg27427jwsjxva3n@ywgfiptf4llx>
References: <20240430-pmic-glink-sleep-while-atomic-v1-1-88fb493e8545@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240430-pmic-glink-sleep-while-atomic-v1-1-88fb493e8545@quicinc.com>

On Tue, Apr 30, 2024 at 08:38:57PM -0700, Bjorn Andersson wrote:
> From: Bjorn Andersson <quic_bjorande@quicinc.com>
> 
> The recently introduced commit '635ce0db8956 ("soc: qcom: pmic_glink:
> don't traverse clients list without a lock")' ensured that the clients
> list is not modified while traversed.
> 
> But the callback is made from the GLINK IRQ handler and as such this
> mutual exclusion can not be provided by a (sleepable) mutex.
> 
> Replace the mutex with a spinlock.
> 
> Fixes: 635ce0db8956 ("soc: qcom: pmic_glink: don't traverse clients list without a lock")
> Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>

Reviewed-by: Andrew Halaney <ahalaney@redhat.com>


