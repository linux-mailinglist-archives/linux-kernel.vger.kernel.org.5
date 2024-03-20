Return-Path: <linux-kernel+bounces-108523-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CF8B880BAD
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 08:07:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB22D1C223B6
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 07:07:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53B3D224F2;
	Wed, 20 Mar 2024 07:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="nV3H0kTM"
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13FB522309;
	Wed, 20 Mar 2024 07:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710918435; cv=none; b=c+sunBrfO530/2QUgXtTE61A8cwbMhXlAA/qCSNwqRNIX7LmW0U9s86JWmargx4zV5ZwRZcpamPojRn6VUOIojlWnv5G3hrCnhPREroC/aQNrp4JXPl7vEsaA/wm23ltgptma288Qe31h+YYxU7OFPdFM43VsAUopCudM8h+JzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710918435; c=relaxed/simple;
	bh=imsC85LZ7G8ryotC8eiV2WIjFk665S1ivdu0dBN6TLo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TF9L5exZP4vbZOe/0sys90wzA33vbx5BX8ZBAn3oyWRtLdV8XFa2wcmwf3L8Bx63OVu5AwNDfpwjMwd3pI1WYHYjeltl1Qf4aDHEndEGuJ0FbydKYRohhkEnCORd6NbeA+14N1yZSmwo6gaydV5vS0kbpAwsDiNn7KoZqM4JpEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=nV3H0kTM; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=imsC85LZ7G8ryotC8eiV2WIjFk665S1ivdu0dBN6TLo=;
	t=1710918432; x=1712128032; b=nV3H0kTMhVWxNse2y56aeYAJ3Dcvv5S4zwhrbZiPA4iYC33
	L+dXS+r6hJ/yZPX4GWr19fkdV8xdRb+I32nEkxUJsOTu9yS/g7frgB+eXZwJQx48vecB4P2yOc+Zy
	PSYQ3dk+igjAvSp5EL/agjl1gz7dMpRJtjpWjoi6yUX01xBdVMNFLx/09RGF7jTjhPNVF1ztqo+PB
	tvqvohDvjFczN0LSwDed8RJQC8ouDKxy299hw6/8heH3IuCJPN1jGVsVXBI95NQW0PxN9dsA3hE67
	LtB1Bl8wS0kFGT7pTcCdv31HKB3F+PMMuxsMvYsOoBlit3+43KpczfSevlA0dL/g==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rmq2P-00000006pAa-3J1Q;
	Wed, 20 Mar 2024 08:07:02 +0100
Message-ID: <638df3bb659caef38480aa97277207b89c101344.camel@sipsolutions.net>
Subject: Re: [PATCH 0/3] wifi: nl80211: fix nl80211 UAPI kernel-doc
From: Johannes Berg <johannes@sipsolutions.net>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 20 Mar 2024 08:07:00 +0100
In-Reply-To: <20240319-kdoc-nl80211-v1-0-549e09d52866@quicinc.com>
References: <20240319-kdoc-nl80211-v1-0-549e09d52866@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Tue, 2024-03-19 at 11:26 -0700, Jeff Johnson wrote:
> As part of my review of patches coming from the Qualcomm Innovation
> Center I check to make sure that no checkpatch or kernel-doc issues
> are introduced. An upcoming patch will propose a modification to
> include/uapi/linux/nl80211.h. My review process flagged both
> checkpatch and kernel-doc issues in the file, but these are
> pre-existing issues. So this series fixes those pre-existing issues.
>=20

Thanks Jeff.

Can you say what you're running for this? I've been running kernel-doc
and builds with W=3D1 for a long time, and not seen issues. Is this
perhaps checks from a newer kernel (we're currently on 6.8-rc1 for
$reasons)?

Thanks,
johannes

