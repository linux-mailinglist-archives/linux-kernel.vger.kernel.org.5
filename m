Return-Path: <linux-kernel+bounces-57382-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 90DB084D7B7
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 03:10:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2C2C7B21D2F
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 02:10:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F197C1CF9A;
	Thu,  8 Feb 2024 02:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="zQatQ0ii"
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F2EB1A5AC
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 02:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707358199; cv=none; b=WxRwprrxuW5CZ9vwFe62MSLMkYxvfsHYmVNVj8me4Niran87y7EYblTdqVg/qegJF03QCmLicTbnSReSj5RB6oKOT2nE8L1ru9wY6x+Yc+Fs5VheAP/vOoAXmr3Z6dpjUfLNB/6qC+wn6McR1CSNF4zYaoB8ZUHlMtaws+XDN1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707358199; c=relaxed/simple;
	bh=TfvLcW0AaWo0jF/GFwr/ysyJukKV80l/EijTkTJJUTc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bj7PNAaSN+x6rxBKNdf3DEa/ovGqmwkSY60I6BZCHIsXNjCWF9+VH/7sH33E69QJy2uhCXoNd1cX6c5I9IqaMa6Q9D07WsdAkD1egtH1Yv1LDw5HUkULnuFf99FykiL4X73BUSEWF6QJtLbpO+PndgqIvny4bUuyIPqAoNYeOLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=zQatQ0ii; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-5ce942efda5so979487a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 07 Feb 2024 18:09:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1707358196; x=1707962996; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=j/vrrvCBh74wQdZw168bRLizyhvDVNhT8sXIBRaKLKA=;
        b=zQatQ0iiM1mXK3vKiFDjjyc2U3bSbfFgnSXwZFJU7uI1IwOg+jo3G4jfLKU/aKoCxu
         T3wKMCXGfc4USwYeoZfd8QyfE2T6gR2Bz8hXs6NroxZiID8NpWLLdZuMQiPYny4OCJCx
         S25CPaz+mEvdmRw7wI2G7Pbp2XgSfpR1iRKGA6AntApjR8UFUglHF0cq1ylZrDheUspw
         kFKXKmU8128ygDSrpYnbHVXRnw7Gy9SmsLEDYGM4M8sPnJUkTntbZP9TwrSqfdmffvwh
         O716YI6hPEFXydE58Xx6tQiB0WkSUduRzvv+x242F2nlNPnnHdj/HMua/UR2QW8F8LDL
         h2WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707358196; x=1707962996;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j/vrrvCBh74wQdZw168bRLizyhvDVNhT8sXIBRaKLKA=;
        b=wuMGqRK6PwFdEA/QWeNvEGhdkEq2qppV6IhLtJJzCuC43IQSHxnqZub4KSLP2xOAT+
         IITMYOx7wv67OMF8gnzkaEC9JnVsaWhWEMwigmBgwUyWOhai/VR9N0wD97niuZmYP7aK
         mJ1bHSzTJIZIUYQBUrXX3MlX76bLL3y36cXm6X3KeLs2VB+L3NhURon2PRQiegvS8iJk
         J8t247LiEAJjZmV1sNiN0f4bKYkDnYIQ6kJrwpIP5hXWhhstePdwSItcXweuT4MrasTK
         l0pUtUpqK9KKsq5ByGwWUTdWanup5Wp3/YDEj5W1pftZaQnQ6nyfx95Q/t9ikuGI3OUs
         2X3w==
X-Forwarded-Encrypted: i=1; AJvYcCXbOHqzuaFnm7DlDtafYEfm3Ep2vGy4y9LWFc8hQYY/MbFv6R/+71ED/7xr7x+IWlFOwhLIgtLLVl3/w+NIx3Z+8dq9M0YAMYMVYUTh
X-Gm-Message-State: AOJu0Yyi+ZDTnCc9JeEKNsixpHBQqVp/XpAMuru6zjkXfCJWm6V0E+zd
	Sc4qlaF52eGeNrt8kjL5hRoYvMtPzfPqyHrWZwdTHd/6ACHIr1vtIcr41247qdU=
X-Google-Smtp-Source: AGHT+IH5uGfj7cVEVFZPlbYnB/8hHC4v55s9GTRjLxuTTvy0Bi2PIezM4pg+8IOR0WnCR63AMivsZg==
X-Received: by 2002:a17:90a:b10d:b0:296:df84:da3 with SMTP id z13-20020a17090ab10d00b00296df840da3mr3380252pjq.35.1707358196377;
        Wed, 07 Feb 2024 18:09:56 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXNr3Z9Z2yHahSiFVFo8QdlMvjKHToKPMPvCn+BKX1zYI+a52VlLjdU6HAwha/dPyVj2g7NUYMVm+n7leHF4XQLsRxWm9/IbcQHBLW39F85odpYOgEmeAauPq4AYf8R9GG7jDTX8QX3Wuh3Djd0fZA4KH8j7oxW4gN4RQQPBzNi/dXmH6uvkzYC
Received: from ghost ([12.44.203.122])
        by smtp.gmail.com with ESMTPSA id a15-20020a17090abe0f00b0028df5c748e4sm143647pjs.44.2024.02.07.18.09.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 18:09:55 -0800 (PST)
Date: Wed, 7 Feb 2024 18:09:53 -0800
From: Charlie Jenkins <charlie@rivosinc.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Guenter Roeck <linux@roeck-us.net>,
	David Laight <David.Laight@aculab.com>,
	Palmer Dabbelt <palmer@dabbelt.com>, linux-kernel@vger.kernel.org,
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v6 0/2] lib: checksum: Fix issues with checksum tests
Message-ID: <ZcQ38U20MLSdIxHP@ghost>
References: <20240207-fix_sparse_errors_checksum_tests-v6-0-4caa9629705b@rivosinc.com>
 <20240207174522.2d19729ec2e014d521335a04@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240207174522.2d19729ec2e014d521335a04@linux-foundation.org>

On Wed, Feb 07, 2024 at 05:45:22PM -0800, Andrew Morton wrote:
> On Wed, 07 Feb 2024 16:22:49 -0800 Charlie Jenkins <charlie@rivosinc.com> wrote:
> 
> > The ip_fast_csum and csum_ipv6_magic tests did not have the data
> > types properly casted, and improperly misaligned data.
> 
> Neither this nor the two patch's changelogs describe *why* these changes
> are needed.  They merely assert that we need to do this.
> 
> IOW, when fixing a bug please always describe the user-visible effects
> of that bug.
> 

I can add a description that says that the tests are being fixed because
they caused failures on systems without misaligned access support. As
for the casting patch it's a bit less pertinent but I can add that it
allows the code to pass sparse checks.

- Charlie


