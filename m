Return-Path: <linux-kernel+bounces-51273-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 531D4848895
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 20:39:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 100C328512F
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 19:39:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92C345FBB4;
	Sat,  3 Feb 2024 19:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aYebAlo+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC51D5FDB1;
	Sat,  3 Feb 2024 19:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706989184; cv=none; b=Pcrdbk7dIrOSQWfwdukBiCaq8y2vu3RvmS7Mc+NpThli3umiG+jRDnuMpPUj8OjzIcjfQJ+G2F+t05l9oE5CHpiiZQZK+6sjR5wvpmwL5TFNQpxYa2ixCLn7uwd+JhZ0WXgrvoGh8d4JuaZw/ANP+cP9ut7lh6RNmHMFtF8/ACs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706989184; c=relaxed/simple;
	bh=oF/O0RgKO6FjhFeZq12tKC5kTirMGa/o9nYb4NrI7F0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gRmFnkwrSGjqCGkLbGxFOMHefGYvC7rGB1g1fdq3zNJ1UmCynNL6iHMmV/Dbrn2s5pAnbAcmNmSkEkyi7Iwz01nlDbvU1sQiWz0WYUsKNLeI+1QM6W72NmuXgnvHMCTEyCbqwDmUeHpJnzC+JbMu9RIlEwd+rjrDcwZqdOeofgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aYebAlo+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12664C433F1;
	Sat,  3 Feb 2024 19:39:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706989184;
	bh=oF/O0RgKO6FjhFeZq12tKC5kTirMGa/o9nYb4NrI7F0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aYebAlo+zlzuBOzvuh+YauZ1AdWs0PFZ1omCK+q6QPADxo/ayoG6jdsFRuE1PD226
	 KNwkNRssep+odoNoZrMboHJhOoHrWMjUTKsmoJijpnfxy31YJRNi4bSl8kvYKPo+IF
	 9X3A7RVC+GaPuJnu1OxScp1CGdDGw1i3PmccE8g00VtOt2JY9HFzXEGloJNnpjGLeS
	 trLca74HuvFXskjNGmmOj/FBpzQAQMxeYnYZsaEg4ZXrTYZzuytEOwLd7Mqjtk5LWq
	 2zloqmuZW/fnplUvfydrbOOKcBqgQjSg1fX5omFAicT28lkxqwxCIgVte6KJkKnfW1
	 IHl+MC2rwiSjA==
Date: Sat, 3 Feb 2024 19:38:09 +0000
From: Simon Horman <horms@kernel.org>
To: Ravi Gunasekaran <r-gunasekaran@ti.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, andrew@lunn.ch, rogerq@kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	s-vadapalli@ti.com, srk@ti.com
Subject: Re: [RFC PATCH net-next 2/2] net: ethernet: ti: inter-core-virt-eth:
 Register as network device
Message-ID: <20240203193809.GA706477@kernel.org>
References: <20240130110944.26771-1-r-gunasekaran@ti.com>
 <20240130110944.26771-3-r-gunasekaran@ti.com>
 <20240201131912.GB530335@kernel.org>
 <32f49a1d-7974-4dc6-be20-f21f5aabc264@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <32f49a1d-7974-4dc6-be20-f21f5aabc264@ti.com>

On Thu, Feb 01, 2024 at 07:54:24PM +0530, Ravi Gunasekaran wrote:

..

> Thanks for taking time to review the patches.
> 
> The primary intention of this series was to know if the RPMsg based approach
> would be upstream friendly or not. But I would not like to use that as an excuse
> for not fixing checks/warnings/errors reported by checkpatch completely.
> Even though if its RFC, I will treat it as an actual upstream patch  and address the
> checkpatch/smatch/sparse findings or atleast mention in the cover letter that the
> findings have not been fully addressed.

Understood. TBH, I am unsure of the value of this kind of review for an RFC
- I understand it is important to get the bigger picture questions out of
the way at this point.

..

