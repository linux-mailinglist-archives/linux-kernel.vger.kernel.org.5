Return-Path: <linux-kernel+bounces-89493-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CC9586F11B
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 17:13:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DACA128341A
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 16:13:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD9631BC47;
	Sat,  2 Mar 2024 16:13:17 +0000 (UTC)
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20F901947E
	for <linux-kernel@vger.kernel.org>; Sat,  2 Mar 2024 16:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709395997; cv=none; b=oyyAFCJCXYJ3BOxoWtS+e/FWDOrQT2gZrSl789zXsP1qeVvwFbAWBJMOP0kKYeHgS8YVI9c4YgQhRZA3u3Mcr78YzBXWgizZI64T7ahTsnXiLbe5uSNaBt7HHHPQ0+av2RT933jfltTIh70pRQKDewNTjxe/lIp5e/mqmCkczJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709395997; c=relaxed/simple;
	bh=FbjTuTWqBDQsWRS0dZyGAKYtWVxCCDP+Jy5p1Tkb6xY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MLcFhPpft+TrN5oU4LQxl10oRlj0Pm7ktHUWLRaX/Bfi782CzkqNAIyZs/4lZ/Z+HL+bUYfOm8bR3D8OUVigOPemCNHhm8Ua2EKHQhdsH+q6WEex053R0kARpILGm8HB2UC3GfY1XCR2RXZVTc/cWqHGjq0mVqn+OPvP1/wN2jM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=redhat.com; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-59fd6684316so1170043eaf.0
        for <linux-kernel@vger.kernel.org>; Sat, 02 Mar 2024 08:13:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709395993; x=1710000793;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9z4aaL+eoV7uAuWVMK9/aYASmrv+Wksdp8IvJ6mzxpQ=;
        b=bv/HvKNg5WHyFpIBp/pEWLQDPEOmFSnJT/LEFYAsCCKc1o9XoeJ+Zw/wWGM2gHTT+f
         RB6JB/RCIGyX/6sHmo/OqpOdxg1WuvYmMoM9RmlAE6tbTTbRdygUkjEQzppB9fZDpCTy
         vPAfmbOAGSQsyLNCrGrZp/dgaAzCgii6C20Tmmffl2jmy0E9tVSVZ7ppJ6L/jhvbA3+1
         Z9OGECVyUnU/Obug+t61EX3e2lLm0UOWyVbAbelu4OrWURHXJyy8ZPehzR6QKBpsILlH
         NZv9X9Oc0XpHAlB2lMlBeCi+X/G9pPu62avUQbhbBYYrkJtZoyL2ti6BjjGqaqC02YP4
         DjBQ==
X-Forwarded-Encrypted: i=1; AJvYcCV0ynA1wHcoHJh+fQJUSVMfrOk561j4wSU8+vVrsLpNgASvkGIN6XJI/ibFUuqAaHcX9mAnF41xCfE/aPWNVn1J0qAldiumHmfsbRJU
X-Gm-Message-State: AOJu0Ywop3coxy/L2bOh3rLMK2vZqRR0eUCRzKGaSf/a48ILVG91qFI4
	qUhqaKmUMO/Hi7EGDNx+XZHQ7HlpBzC/g7/2uFWde5NyFF4L5Yt0lLtbs/BpNA==
X-Google-Smtp-Source: AGHT+IGf9jgOeoj362uKhi105PtehqMD4txWWxwWyWfRjF/hG3odid6G8dwTAJ8IfpCY0YN3OcPPAA==
X-Received: by 2002:a05:6358:181:b0:17b:eec9:8ee8 with SMTP id d1-20020a056358018100b0017beec98ee8mr4991319rwa.12.1709395993108;
        Sat, 02 Mar 2024 08:13:13 -0800 (PST)
Received: from localhost (pool-68-160-141-91.bstnma.fios.verizon.net. [68.160.141.91])
        by smtp.gmail.com with ESMTPSA id kr9-20020a0562142b8900b0068fcd643b9dsm3093596qvb.22.2024.03.02.08.13.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Mar 2024 08:13:12 -0800 (PST)
Date: Sat, 2 Mar 2024 11:13:10 -0500
From: Mike Snitzer <snitzer@kernel.org>
To: Fan Wu <wufan@linux.microsoft.com>
Cc: corbet@lwn.net, zohar@linux.ibm.com, jmorris@namei.org,
	serge@hallyn.com, tytso@mit.edu, ebiggers@kernel.org,
	axboe@kernel.dk, agk@redhat.com, eparis@redhat.com,
	paul@paul-moore.com, linux-doc@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-fscrypt@vger.kernel.org, linux-block@vger.kernel.org,
	dm-devel@lists.linux.dev, audit@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v13 13/20] dm: add finalize hook to target_type
Message-ID: <ZeNQFlw74KJ9Spdr@redhat.com>
References: <1709168102-7677-1-git-send-email-wufan@linux.microsoft.com>
 <1709168102-7677-14-git-send-email-wufan@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1709168102-7677-14-git-send-email-wufan@linux.microsoft.com>

On Wed, Feb 28 2024 at  7:54P -0500,
Fan Wu <wufan@linux.microsoft.com> wrote:

> This patch adds a target finalize hook.
> 
> The hook is triggered just before activating an inactive table of a
> mapped device. If it returns an error the __bind get cancelled.
> 
> The dm-verity target will use this hook to attach the dm-verity's
> roothash metadata to the block_device struct of the mapped device.
> 
> Signed-off-by: Fan Wu <wufan@linux.microsoft.com>
> 
> ---
> v1-v10:
>   + Not present
> 
> v11:
>   + Introduced
> 
> v12:
>   + No changes
> 
> v13:
>   + No changes
> ---
>  drivers/md/dm.c               | 12 ++++++++++++
>  include/linux/device-mapper.h |  7 +++++++
>  2 files changed, 19 insertions(+)
> 
> diff --git a/drivers/md/dm.c b/drivers/md/dm.c
> index 8dcabf84d866..15b46edae49f 100644
> --- a/drivers/md/dm.c
> +++ b/drivers/md/dm.c
> @@ -2266,6 +2266,18 @@ static struct dm_table *__bind(struct mapped_device *md, struct dm_table *t,
>  		goto out;
>  	}
>  
> +	for (unsigned int i = 0; i < t->num_targets; i++) {
> +		struct dm_target *ti = dm_table_get_target(t, i);
> +
> +		if (ti->type->finalize) {
> +			ret = ti->type->finalize(ti);
> +			if (ret) {
> +				old_map = ERR_PTR(ret);
> +				goto out;
> +			}
> +		}
> +	}
> +
>  	old_map = rcu_dereference_protected(md->map, lockdep_is_held(&md->suspend_lock));
>  	rcu_assign_pointer(md->map, (void *)t);
>  	md->immutable_target_type = dm_table_get_immutable_target_type(t);
> diff --git a/include/linux/device-mapper.h b/include/linux/device-mapper.h
> index 772ab4d74d94..627400b2d9af 100644
> --- a/include/linux/device-mapper.h
> +++ b/include/linux/device-mapper.h
> @@ -160,6 +160,12 @@ typedef int (*dm_dax_zero_page_range_fn)(struct dm_target *ti, pgoff_t pgoff,
>   */
>  typedef size_t (*dm_dax_recovery_write_fn)(struct dm_target *ti, pgoff_t pgoff,
>  		void *addr, size_t bytes, struct iov_iter *i);
> +/*
> + * Returns:
> + *  < 0 : error
> + *  = 0 : success
> + */
> +typedef int (*dm_finalize_fn) (struct dm_target *target);

This needs some documentation, e.g.: this hook allows DM targets in an
inactive table to complete their setup before the table is made
active.

Mike

>  
>  void dm_error(const char *message);
>  
> @@ -210,6 +216,7 @@ struct target_type {
>  	dm_dax_direct_access_fn direct_access;
>  	dm_dax_zero_page_range_fn dax_zero_page_range;
>  	dm_dax_recovery_write_fn dax_recovery_write;
> +	dm_finalize_fn finalize;
>  
>  	/* For internal device-mapper use. */
>  	struct list_head list;
> -- 
> 2.43.1
> 
> 

