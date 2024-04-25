Return-Path: <linux-kernel+bounces-157987-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D9B78B19D9
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 06:14:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8776286F00
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 04:14:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFCA9381B8;
	Thu, 25 Apr 2024 04:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rIt/x2cr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E69252BB01;
	Thu, 25 Apr 2024 04:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714018434; cv=none; b=K8zWJTAFhVlgQcl5zHChM1MOfZFHleY4msHiovfbKQ9JQ0IA7Tj6iGvOHNEXmh7sC3FSDhcrecEfL0p0rHGi2haMmUfcsbfta0o88+eAA3TbxU3VivgSmytBU3PrhSlZbUAywbgqj32NDS2Vs/MDKTj4wNI/qejJAR635od8STQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714018434; c=relaxed/simple;
	bh=J4cDat+gq68hFHW1ovqxOk5nlgVOG8GqMRt7W/o8VEc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hv9uhUvWw/dlBA368uOAFQBvJdnzdw4Z0OyjfMHsjrRQtsUErBW1GnN5HyW+fVwO050p2a4h/AOJIkS8R4+DKQIxBJZXdaijLoTaj/YNqxAd5l6yJjLavmdTu5LWbOY2SDnPd4mnzIHZUeKcPNS5PvWs/bTNzqTVhTaqXRQw2eQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rIt/x2cr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF953C113CC;
	Thu, 25 Apr 2024 04:13:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714018433;
	bh=J4cDat+gq68hFHW1ovqxOk5nlgVOG8GqMRt7W/o8VEc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rIt/x2crwQB/cp53V1g6Kfzj9H7hyi9yp/MVdDv7qb0i4mLEEtWGY0dCZwTRy/ULd
	 8t2W6Xi6YcFw9ZjINtWkk8L51Y1xXLDfAk01roM6PLthdnIoQIZr2wnReLJ3C7UfM3
	 oE2pHsK4gF4NVrA9sYB0hNfum8pWWu7BBBqkr5fiWqr0Kr+RoaKNeC7Dn0Xo5JfiUF
	 FhwBFtWOeRLA3W/DTHbt074TzsLQ8kEu4YQb722k72l2tCriBZCy+U5ZdJLoTyRwxJ
	 R7RevDB+0x9A3vbBnxVoJsHWV7UZBt2Hz5VNjJfwjVdUvhgkJc4PSvalXuTKZc1whk
	 Q8zxMRbAapaSw==
Date: Wed, 24 Apr 2024 21:13:51 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Fan Wu <wufan@linux.microsoft.com>
Cc: corbet@lwn.net, zohar@linux.ibm.com, jmorris@namei.org,
	serge@hallyn.com, tytso@mit.edu, axboe@kernel.dk, agk@redhat.com,
	snitzer@kernel.org, eparis@redhat.com, paul@paul-moore.com,
	linux-doc@vger.kernel.org, linux-integrity@vger.kernel.org,
	linux-security-module@vger.kernel.org, fsverity@lists.linux.dev,
	linux-block@vger.kernel.org, dm-devel@lists.linux.dev,
	audit@vger.kernel.org, linux-kernel@vger.kernel.org,
	Deven Bowers <deven.desai@linux.microsoft.com>
Subject: Re: [PATCH v17 20/21] Documentation: add ipe documentation
Message-ID: <20240425041351.GD1401@sol.localdomain>
References: <1712969764-31039-1-git-send-email-wufan@linux.microsoft.com>
 <1712969764-31039-21-git-send-email-wufan@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1712969764-31039-21-git-send-email-wufan@linux.microsoft.com>

On Fri, Apr 12, 2024 at 05:56:03PM -0700, Fan Wu wrote:
> +dmverity_roothash
> +~~~~~~~~~~~~~~~~~
> +
> +   This property can be utilized for authorization or revocation of
> +   specific dm-verity volumes, identified via its root hash. It has a
> +   dependency on the DM_VERITY module. This property is controlled by
> +   the ``IPE_PROP_DM_VERITY`` config option, it will be automatically
> +   selected when ``IPE_SECURITY`` , ``DM_VERITY`` and
> +   ``DM_VERITY_VERIFY_ROOTHASH_SIG`` are all enabled.
> +   The format of this property is::
> +
> +      dmverity_roothash=DigestName:HexadecimalString
> +
> +   The supported DigestNames for dmverity_roothash are [#dmveritydigests]_ [#securedigest]_ :
> +
> +      + blake2b-512
> +      + blake2s-256
> +      + sha1
> +      + sha256
> +      + sha384
> +      + sha512
> +      + sha3-224
> +      + sha3-256
> +      + sha3-384
> +      + sha3-512
> +      + md4
> +      + md5
> +      + sm3
> +      + rmd160

It's not the 90s anymore.  Insecure algorithms like md4, md5, and sha1 should
not be here.

> +dmverity_signature
> +~~~~~~~~~~~~~~~~~~
> +
> +   This property can be utilized for authorization of all dm-verity
> +   volumes that have a signed roothash that validated by a keyring
> +   specified by dm-verity's configuration, either the system trusted
> +   keyring, or the secondary keyring. It depends on
> +   ``DM_VERITY_VERIFY_ROOTHASH_SIG`` config option and is controlled by
> +   the ``IPE_PROP_DM_VERITY`` config option, it will be automatically
> +   selected when ``IPE_SECURITY``, ``DM_VERITY`` and
> +   ``DM_VERITY_VERIFY_ROOTHASH_SIG`` are all enabled.
> +   The format of this property is::
> +
> +      dmverity_signature=(TRUE|FALSE)
> +
> +fsverity_digest
> +~~~~~~~~~~~~~~~
> +
> +   This property can be utilized for authorization or revocation of
> +   specific fsverity enabled file, identified via its fsverity digest.
> +   It depends on ``FS_VERITY`` config option and is controlled by
> +   ``CONFIG_IPE_PROP_FS_VERITY``. The format of this property is::
> +
> +      fsverity_digest=DigestName:HexadecimalString
> +
> +   The supported DigestNames for fsverity_roothash are [#fsveritydigest]_ [#securedigest]_ :

fsverity_digest, not fsverity_roothash.

> +Allow any signed fs-verity file
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +::
> +
> +   policy_name=AllowSignedFSVerity policy_version=0.0.0
> +   DEFAULT action=DENY
> +
> +   op=EXECUTE fsverity_signature=TRUE action=ALLOW

As elsewhere, ideally this would be more specific about what is meant by a
signed file.  The goal is not to allow *any* signed file, but rather only allow
files that are signed by a particular someone/something.

> +Prohibit execution of a specific fs-verity file
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +::
> +
> +   policy_name=ProhibitSpecificFSVF policy_version=0.0.0
> +   DEFAULT action=DENY
> +
> +   op=EXECUTE fsverity_digest=sha256:fd88f2b8824e197f850bf4c5109bea5cf0ee38104f710843bb72da796ba5af9e action=DENY
> +   op=EXECUTE boot_verified=TRUE action=ALLOW
> +   op=EXECUTE dmverity_signature=TRUE action=ALLOW

This example is a bit weird because it's a denylist, not an allowlist.  In
general this could be trivially circumvented by creating a new binary that has
fsverity disabled or that doesn't meaningfully differ from the original.

> +.. [#fsveritydigest] These hash algorithms are based on values accepted by fsverity-utils;
> +                     IPE does not impose any restrictions on the digest algorithm itself;
> +                     thus, this list may be out of date.

It's the kernel's fsverity support, not fsverity-utils, that matters here.
fsverity-utils is kept up to date with the kernel, so in practice the list of
algorithms is the same on both sides, but it's the kernel that matters here.

> +.. [#dmveritydigests] These hash algorithms are based on values accepted by dm-verity,
> +                      specifically ``crypto_alloc_ahash`` in ``verity_ctr``; ``veritysetup``
> +                      does support more algorithms than the list above. IPE does not impose
> +                      any restrictions on the digest algorithm itself; thus, this list
> +                      may be out of date.

References to specific functions and locations in the code tend to get out of
date.  I think you mean something like: any hash algorithm that's supported by
the Linux crypto API is supported.

> +
> +.. [#securedigest] Please ensure you are using cryptographically secure hash functions;
> +                   just because something is *supported* does not mean it is *secure*.

Instead of giving insecure algorithms like md4 as examples and then giving this
disclaimer, how about only giving secure algorithms as examples?

- Eric

