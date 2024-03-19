Return-Path: <linux-kernel+bounces-107898-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 420F888033E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 18:15:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72DCC1C229AB
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 17:15:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF8F220B21;
	Tue, 19 Mar 2024 17:15:31 +0000 (UTC)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77B1F1CD24;
	Tue, 19 Mar 2024 17:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710868531; cv=none; b=cGdOwGztCJ8x6ZYNS8eaH5w/w1cD7Vnqs4MkvocTnSiwU+qOgKcHzw0nz0YXk328lLCuQWXY1JI+aclhMAflbbPswp02nS94WGe5sBAVVt/4KoaSM+9KJ6bDR2DEL+9J8htMvpkw52j+hirQEyGH+NcU2y5ykgLtDuZY2qbZSCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710868531; c=relaxed/simple;
	bh=8DLRFwiwIRBdYtKTyM4tHfoBmc/mf1kPlKzzdsnOGlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FbSlbNMP2R6qBx3oMWOzxZCzr/GieyJkg9T3P7Eou2jgnT7p+mE+/0OZchh3B13WJwd1gcEktakwtUySR6F4nmZvt1SRB9pIXrgwZxFL1VsUwtp7agSmXGEMf3d9JwAhm5c8TVmokXuhIDNFKohgVVnpYynfzw6K396FhWu8agk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-56845954ffeso7798372a12.2;
        Tue, 19 Mar 2024 10:15:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710868528; x=1711473328;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OmXgZZ6GaxcwZLA1WFIg0B/+xgHaSvLSd69ytRYOKx4=;
        b=Rr1ZechNcz9Teph6TmrgeeuHEJG9geLrAvKSsJPD/0PR52x4y8UZNA9RCNOf5LEuMW
         o28G219/vRwPoBS48M925JcS0wZlW4ooJOBYPNE4pAJnZ0eYSfcpVTrX3gYwbd12KYJc
         jReX3pM45e0VyZKSyrcpJfoEE1RjhFi31E4xD3Tp347UHNTiaud0UZ9nOKzJDi8KTwvI
         PvCzj/GsfxaVUB6j/4usuGqrH//qbGvGMplNETtc3E2iz7/LI9Xul2umTF+/LhcaW12j
         EXAsnaDXJRo4lvNEqRHdvkPRYDjgP3VbcgjRvtdGF+jlYtBA98X3D232Yv6Fmb5PKxXG
         J6kA==
X-Forwarded-Encrypted: i=1; AJvYcCXT00FyZp+/OG+j3wZAw3CQuv4vG83rxsXskcGv0Wfj5LIkq2hKCHpMfqGG3Ot4WlOdHmKsDIHrjT0Mp4kHkfPeYuEt8zhNBAPSCNY14bPT0BiWeAdDtQ8UeEId7dcTcJwSF/j560coh+CZlAg=
X-Gm-Message-State: AOJu0YzNWMBJ9W5pKPixd2l8FRkdemhYLquxK1EHdViqEqZsbWmu8Jsz
	bo4aVngMVl7Mb8I4hwqV3DrPCco22xsaGVYKl3qe5Oqz/lplg+RA
X-Google-Smtp-Source: AGHT+IFm+ZPcuLTEBvsUGrK5gK3tb7P/G5UH9t7dK0EWm87J9RHQQ6XGn0irQ9hNFMsqFrQ7wzLo4g==
X-Received: by 2002:a05:6402:31bb:b0:564:7921:37c3 with SMTP id dj27-20020a05640231bb00b00564792137c3mr1836242edb.19.1710868527534;
        Tue, 19 Mar 2024 10:15:27 -0700 (PDT)
Received: from gmail.com (fwdproxy-lla-005.fbsv.net. [2a03:2880:30ff:5::face:b00c])
        by smtp.gmail.com with ESMTPSA id cb4-20020a0564020b6400b005663b0d7243sm5996664edb.83.2024.03.19.10.15.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Mar 2024 10:15:27 -0700 (PDT)
Date: Tue, 19 Mar 2024 10:15:25 -0700
From: Breno Leitao <leitao@debian.org>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: Kalle Valo <kvalo@kernel.org>, Jeff Johnson <jjohnson@kernel.org>,
	kuba@kernel.org, keescook@chromium.org,
	"open list:NETWORKING DRIVERS (WIRELESS)" <linux-wireless@vger.kernel.org>,
	"open list:QUALCOMM ATHEROS ATH10K WIRELESS DRIVER" <ath10k@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ath10k: allocate dummy net_device dynamically
Message-ID: <ZfnILSPBiqk8JdJ4@gmail.com>
References: <20240319104754.2535294-1-leitao@debian.org>
 <8771e856-3d9f-41c6-88c8-3c75e77b2aab@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8771e856-3d9f-41c6-88c8-3c75e77b2aab@quicinc.com>

On Tue, Mar 19, 2024 at 09:05:24AM -0700, Jeff Johnson wrote:
> On 3/19/2024 3:47 AM, Breno Leitao wrote:
> > @@ -3687,6 +3690,8 @@ struct ath10k *ath10k_core_create(size_t priv_size, struct device *dev,
> >  
> >  err_free_coredump:
> >  	ath10k_coredump_destroy(ar);
> > +err_free_netdev:
> > +	free_netdev(ar->napi_dev);
> >  err_free_tx_complete:
> >  	destroy_workqueue(ar->workqueue_tx_complete);
> >  err_free_aux_wq:
> > @@ -3708,6 +3713,7 @@ void ath10k_core_destroy(struct ath10k *ar)
> >  
> >  	destroy_workqueue(ar->workqueue_tx_complete);
> >  
> > +	free_netdev(ar->napi_dev);
> >  	ath10k_debug_destroy(ar);
> >  	ath10k_coredump_destroy(ar);
> >  	ath10k_htt_tx_destroy(&ar->htt);
> 
> looks like there is a pre-existing issue that the order of operations in
> _destroy() doesn't match the order of operations in the _create() error path.

Right. I found it weird as well. Basically "ath10k_coredump" and
"ath10k_debug" operations are swapped between ath10k_core_create() and
ath10k_core_destroy().

If you wish, I can submit a patch ordering it properly.

> but the placement of your changes looks ok to me

Right. It is done in-between the workqueues and the coredump/debug
creation/destroy.

Thanks for the review.

