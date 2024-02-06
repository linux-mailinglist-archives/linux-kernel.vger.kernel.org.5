Return-Path: <linux-kernel+bounces-55654-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DF05F84BF80
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 22:49:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9274A1F234F5
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 21:49:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F05631BDDC;
	Tue,  6 Feb 2024 21:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="JC6yFLYr"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8D9B1BC41
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 21:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707256143; cv=none; b=XFTT/1PZDRgllqvWbYZErgJPM5XpjgkhWr6eIrMC17Ai2VXuS7DCnANivH9Uik9ovl+g6Or9SY7Ii1RDTdrc6DVHdTevTwY2A/wpuLwD2U7CPNgHpvGnqgjb0SBi62V9aKgEZjzwf1VmJKSAZ7GIIurxtJxiwYEp/MkZTcWCnMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707256143; c=relaxed/simple;
	bh=HJ8gyDEghruX3EGZ4mJzSN5tcBHEBVjqi2RXDsk0v+U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FOT7uBbCy605xeZtrVdfRfDj4gC/1XxShEp6JT2y3pvB6KBcGKLqSeCR3Atl4uT5CMS/of+jxdte6iPR+PsjsJRaHLfAKVDHUydryeS9y38L/O3c9Jb+vd5HjFFsf7sXOep34RqRfWN0A/O7eQAz6yrY3jfOMZ4J0uFSiwqGyVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=JC6yFLYr; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6e053b272b0so335b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Feb 2024 13:49:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1707256141; x=1707860941; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hzPiCzCuvNHfI44nRtGxsU+1WoDZJnFG4Y1a2Kn+1U8=;
        b=JC6yFLYrluXrH0KLGD2Xs7YOK/e9McDFx1ZFdJ69r0oQkR20tKE37gnSOwQj4kR0PR
         gEutj8cLwx5BCeQ+JsQDiL7/KpoFMu3GHCP2aBmKfaSMVlgdstww/vqd5zp+9iPU/Htn
         yPnP8udgmtjJ+nz2kbu/52SzBP6T3BLmeQz9KAKNxRDQhw9mTbgI9YVrRjtk0lmfs2GF
         jr4AQ7bjdJn4McumIr3N24H2QBtIBnqw9oFK/aEUXhm96XUFHZ6iImCTA2x++8ux9c8y
         KFqKNP+Wc/XcE09rczh1g3ruodRSG7n40VMIW4iT3NQmcnObexxllMWNCs9gASvtd8PA
         F7mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707256141; x=1707860941;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hzPiCzCuvNHfI44nRtGxsU+1WoDZJnFG4Y1a2Kn+1U8=;
        b=m4Ik+7sj2gVQkimweWm66e0zgoJ3ncLlvwfiJGfZZT0njc9OipJIUyCb1rnJdCjRGC
         OZzMiCDoXePYKtknmgIvFSMwVE0Tit8jIlri4OIkgBPt491IZLsAGRtAJhIuCP6W33eh
         yiMUYonez9lWDs68cSjALKa0hjE0Yf9RXlbRkIWmP82jmrg9E5VRQCrzzfPEUDDqKmUi
         Ldq0zvJL9Yz6I5lHSnWDB8A7NNfl1c5gTAGLTlfaP2YsW3IjmMZWCcA3UYqzUi+kDR/3
         2WB/3sPd1RLzndStPrZVUjcOaG8/3EAvqeGsYwoCTfZP4jt9pVe42HYFC4s9JWoo6LYg
         Co7g==
X-Gm-Message-State: AOJu0YxGK4825YZKGNXTQL/sozhfk+8cQ8NyeiuiLxGi4CTk++6hm221
	WkuJpxesHQBZ/cYe0WYg3QbTILsjSsP+1ntCSuokuOJAf4Uu8qmVNiLTK0WzL/Q=
X-Google-Smtp-Source: AGHT+IG80FHwVNd1kGFv5ZA5HKSWUl97TMLb1zrUlYxf9evC3X85Em2cLZocPz5oIDA6ituEZ+rgIw==
X-Received: by 2002:a05:6a00:6805:b0:6e0:3cce:f70c with SMTP id hq5-20020a056a00680500b006e03ccef70cmr761443pfb.31.1707256141018;
        Tue, 06 Feb 2024 13:49:01 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXrlrHRcbpmeOVIw0efERgcHal8p7mIf1VpPmEGI3jbzRo6Mo2qQXDwyMKG2D/ijrD2qwrGYPsRLc1BD/7MMF4kkGJ7y21ky3JcyVYDdJjQ80nBdntG/rEu2vtinbyq9fGRW028sx7uCYHv28fb3dhBGkg+9pXHoH0PAACSZjonhilHvbi/AYboYRRu7NSl6ChhxCpANbg122xJv9O5dgdTpqB82C3e7HLU0HdBoQI41MM=
Received: from dread.disaster.area (pa49-181-38-249.pa.nsw.optusnet.com.au. [49.181.38.249])
        by smtp.gmail.com with ESMTPSA id 21-20020a631355000000b005c19c586cb7sm2661767pgt.33.2024.02.06.13.49.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 13:49:00 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1rXTJJ-00307R-30;
	Wed, 07 Feb 2024 08:48:57 +1100
Date: Wed, 7 Feb 2024 08:48:57 +1100
From: Dave Chinner <david@fromorbit.com>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: brauner@kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>,
	Amir Goldstein <amir73il@gmail.com>, linux-unionfs@vger.kernel.org
Subject: Re: [PATCH v2 2/7] overlayfs: Convert to super_set_uuid()
Message-ID: <ZcKpSU9frvTUb2eq@dread.disaster.area>
References: <20240206201858.952303-1-kent.overstreet@linux.dev>
 <20240206201858.952303-3-kent.overstreet@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240206201858.952303-3-kent.overstreet@linux.dev>

On Tue, Feb 06, 2024 at 03:18:50PM -0500, Kent Overstreet wrote:
> We don't want to be settingc sb->s_uuid directly anymore, as there's a
> length field that also has to be set, and this conversion was not
> completely trivial.
> 
> Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
> Cc: Miklos Szeredi <miklos@szeredi.hu>
> Cc: Amir Goldstein <amir73il@gmail.com>
> Cc: linux-unionfs@vger.kernel.org
> ---
>  fs/overlayfs/util.c | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/overlayfs/util.c b/fs/overlayfs/util.c
> index 0217094c23ea..f1f0ee9a9dff 100644
> --- a/fs/overlayfs/util.c
> +++ b/fs/overlayfs/util.c
> @@ -760,13 +760,14 @@ bool ovl_init_uuid_xattr(struct super_block *sb, struct ovl_fs *ofs,
>  			 const struct path *upperpath)
>  {
>  	bool set = false;
> +	uuid_t uuid;
>  	int res;
>  
>  	/* Try to load existing persistent uuid */
> -	res = ovl_path_getxattr(ofs, upperpath, OVL_XATTR_UUID, sb->s_uuid.b,
> +	res = ovl_path_getxattr(ofs, upperpath, OVL_XATTR_UUID, uuid.b,
>  				UUID_SIZE);
>  	if (res == UUID_SIZE)
> -		return true;
> +		goto success;
>  
>  	if (res != -ENODATA)
>  		goto fail;
> @@ -794,14 +795,14 @@ bool ovl_init_uuid_xattr(struct super_block *sb, struct ovl_fs *ofs,
>  	}
>  
>  	/* Generate overlay instance uuid */
> -	uuid_gen(&sb->s_uuid);
> +	uuid_gen(&uuid);
>  
>  	/* Try to store persistent uuid */
>  	set = true;
> -	res = ovl_setxattr(ofs, upperpath->dentry, OVL_XATTR_UUID, sb->s_uuid.b,
> +	res = ovl_setxattr(ofs, upperpath->dentry, OVL_XATTR_UUID, uuid.b,
>  			   UUID_SIZE);
>  	if (res == 0)
> -		return true;
> +		goto success;

This is a bit weird. Normally the success case is in line, and we
jump out of line for the fail case. I think this is more better:

	if (res)
		goto fail;
success:
	super_set_uuid(sb, uuid.b, sizeof(uuid));
	return true;
>  
>  fail:
>  	memset(sb->s_uuid.b, 0, UUID_SIZE);

And then the fail case follows naturally.

-Dave.

-- 
Dave Chinner
david@fromorbit.com

