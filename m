Return-Path: <linux-kernel+bounces-35083-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A3CDE838BA0
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 11:23:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A6251F25FD5
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 10:23:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37D1D5A78B;
	Tue, 23 Jan 2024 10:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L+aZ+skN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CB1B59B5B;
	Tue, 23 Jan 2024 10:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706005398; cv=none; b=SFdieHqFl5Baoy8OViG3o8bve4j8/QAP0pPt912NJoEyjrdtQ92utpwEMniNjTUQ98kh5h3NxIDL1gqVVHJUiFWAIHOmJaazB/8s9l7bFziBqWCk/noae/uG6UZdbao3SuCygJeuFBiojE8tuX2+cESeKgfWk4kNsoP55yhl6d0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706005398; c=relaxed/simple;
	bh=L6rwmbIP8oH+1dk4XDVm6rZq+NdKHW+y+FrjBFZ1HcQ=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=b6cpfLyOf6ItQbEYBr9RprakJxYc76jr30Otmk0t6H1C8to/7TDv4EvIKt93lmWqS8od3rCZ8V9KJBjOPqt6pkKoLKqwbw5Mz3ume8GV9h0dipzRw3Z1NP+hznCJwLRHJTcUPHLPMQqw0uaw+UGpfr4Xvz9qZzhxJxv9YFigxi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L+aZ+skN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B412BC433F1;
	Tue, 23 Jan 2024 10:23:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706005398;
	bh=L6rwmbIP8oH+1dk4XDVm6rZq+NdKHW+y+FrjBFZ1HcQ=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=L+aZ+skNUG/IcPsJTjqshqyvjYSynZybazN2PZGkdW16Kh+zr3/EWf/YIswd+oRcX
	 Bj2+VEY1TBsYQCR4rrVdt4Rf0kGHS/G2R83Z6m8WIY1XfVrTsNgtBQBjt4YLGbNfQH
	 zCWl0Y1Sfh9lsOqes1s0rTxuEQJFs+jMaXzIPMMMVg+K5P0m0jCRreCFzKZcgnsEfI
	 KaRhapJplpgdnpD4eK9WruGVTRdCv2dyni3/0ZTAQnmuQz6k8CDcne/5JLGA6EJJl1
	 qHAk/K7VCi8v7k3jGebB9+S0jUXj9OWkrGZt4aP5zxHDhwpeSOjtK4+x+WwPvjNnCj
	 3UZG4TQS9Ogcw==
Date: Tue, 23 Jan 2024 11:23:18 +0100 (CET)
From: Jiri Kosina <jikos@kernel.org>
To: Rahul Rameshbabu <rrameshbabu@nvidia.com>
cc: Kunwu Chan <chentao@kylinos.cn>, benjamin.tissoires@redhat.com, 
    linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HID: nvidia-shield: Add some null pointer checks to the
 hid-nvidia-shield.c
In-Reply-To: <87o7dhx2ny.fsf@nvidia.com>
Message-ID: <nycvar.YFH.7.76.2401231123050.29548@cbobk.fhfr.pm>
References: <20240119060714.258635-1-chentao@kylinos.cn> <87o7dhx2ny.fsf@nvidia.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 18 Jan 2024, Rahul Rameshbabu wrote:

> > devm_kasprintf() returns a pointer to dynamically allocated memory
> > which can be NULL upon failure. Ensure the allocation was successful
> > by checking the pointer validity.
> >
> > Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
> > ---
> 
> Just one comment about the subject for future submissions (this one is
> fine). I would just leave the subject as "HID: nvidia-shield: Add some
> null pointer checks". We know what file is being edited from the commit
> content, so the additional filename detail isn't necessary.
> 
> Thanks for the patch. Really appreciate it.
> 
> Reviewed-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>

I have tweaked the changelog a little bit and applied, thanks.

-- 
Jiri Kosina
SUSE Labs


