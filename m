Return-Path: <linux-kernel+bounces-94571-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E4AB87418C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 21:50:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61E122822C2
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 20:50:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A77D31758B;
	Wed,  6 Mar 2024 20:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="1TuGxxOc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB12814F64
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 20:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709758205; cv=none; b=tDfGtqfIu7932Kq/jNNZ8Wt9MwQWj8enO3/ZV42tUd9Jx6urxPb3IZ5v+3J8DZtfmh3hLGogxkNR5HpxMbEBk7DeSX2S1j2WMG46tz5qozP/FtNuAeSO3zqFjxez9Ff0RtGwzJn6Em7bZvPMxpg4XE+OUrziCEyjr4L91/GnqZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709758205; c=relaxed/simple;
	bh=SkVFxuNWnmPwBPPgA2P0sX8lwL6v2czzucDGHVRz4d4=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=rc50JwwfciOJIcyuTXzbMnts31XrE5mMMp/fSdDG841LrfgimRczMa3CdEznfqBaLY63gSniX2ms6nM2uLo1qYTxIek4YSY/4SDfSR+bpSfvk9eV6H1BSNPyZesMj/pZIYtOGrB3+QClBE/o6p+ny+OzQz07jrCMVy9T/gLYMR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=1TuGxxOc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B82B5C433F1;
	Wed,  6 Mar 2024 20:50:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1709758204;
	bh=SkVFxuNWnmPwBPPgA2P0sX8lwL6v2czzucDGHVRz4d4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=1TuGxxOc3MPYXw4PsN9o5lpoPaFhlknEex/5NjmqxjkWuFWwPYdcmLtR1D06Q7u1R
	 2L4paIpccukCXOVTXg0Yz8tkDWTQYnu4JWJyxbIC+bpoZlZL/UiUNZ7EzZ2TTdDXEd
	 c/TfhcwgqLeQlPXAJaQ9/0x/dfK/WGAj6A+5XX4s=
Date: Wed, 6 Mar 2024 12:50:03 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
Cc: linux-kernel@vger.kernel.org, axboe@kernel.dk,
 stephen@networkplumber.org, o.rempel@pengutronix.de,
 quic_bjorande@quicinc.com, heiko@sntech.de, konrad.dybcio@linaro.org,
 kuba@kernel.org
Subject: Re: [PATCH] mailmap: add entry for Jean-Michel Hautbois
Message-Id: <20240306125003.de7b09d64e28a7685eb22f17@linux-foundation.org>
In-Reply-To: <20240306085934.35904-1-jeanmichel.hautbois@yoseli.org>
References: <20240306085934.35904-1-jeanmichel.hautbois@yoseli.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  6 Mar 2024 09:59:34 +0100 Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org> wrote:

> Despite having contributed several patches, my email address was not
> previously included. This update ensures that my contributions are
> correctly attributed.
> 
> Signed-off-by: Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
> +++ b/.mailmap
> @@ -250,6 +250,7 @@ Jayachandran C <c.jayachandran@gmail.com> <jchandra@broadcom.com>
>  Jayachandran C <c.jayachandran@gmail.com> <jchandra@digeo.com>
>  Jayachandran C <c.jayachandran@gmail.com> <jnair@caviumnetworks.com>
>  <jean-philippe@linaro.org> <jean-philippe.brucker@arm.com>
> +Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
>  Jean Tourrilhes <jt@hpl.hp.com>
>  Jeevan Shriram <quic_jshriram@quicinc.com> <jshriram@codeaurora.org>
>  Jeff Garzik <jgarzik@pretzel.yyz.us>
> -- 

Well, this isn't ./CREDITS.  Why do we need this?

mailmap has:

#
# This list is used by git-shortlog to fix a few botched name translations
# in the git archive, either because the author's full name was messed up
# and/or not always written the same way, making contributions from the
# same person appearing not to be so or badly displayed. Also allows for
# old email addresses to map to new email addresses.
#

Now if this entry was mapping your ideasonboard.com and/or veo-labs.com
and/or vodalys.com and/or gmail.com addresses onto one address then I
can see why we'd need the change.


