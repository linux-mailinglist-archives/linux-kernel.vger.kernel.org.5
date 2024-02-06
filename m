Return-Path: <linux-kernel+bounces-55563-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C4F0784BE2B
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 20:35:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0359F1C2337A
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 19:35:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B35B175BD;
	Tue,  6 Feb 2024 19:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hCmeBxbP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 981A418EB8;
	Tue,  6 Feb 2024 19:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707248124; cv=none; b=KrAPla3tIj9gfDwfdgoux1gUal0qee/j06gmarhoBNuswPkBWHbH9b8RtrUQCpsAkh6+HphVZ01XYOe2XNDcR5iKoNXVAh2uRfTUY0v9/qWOvMRwHKC79J1qS5tS3uTo2jHKnB28lQx+gqbjD0Ko5yTXnH0/xE93in6bgZ8h994=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707248124; c=relaxed/simple;
	bh=VcMUhBJzCMvFkw6yy4caxGpPNtGcOssoN/sMaO6Et8o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ksj3l7jmo9HzMnAy8qu98AffQhckC5Z9i+OocNbruIpsT65niQU/rX0DDDvFEe3KbfEz3KGcGkWkEhMbbOjr6Ll1fAscOcrQwELRoOH65R+8/hDJ4oiHATJLM9kiH9VIreGRGf8psoDBMQewBwglq7yFHa1iilJmgLo6ePNesws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hCmeBxbP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B51FC433C7;
	Tue,  6 Feb 2024 19:35:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707248124;
	bh=VcMUhBJzCMvFkw6yy4caxGpPNtGcOssoN/sMaO6Et8o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hCmeBxbPO6Pi2OEha8/Iq9oDSMwM8/oHvWcIriMU8r0FPoK0QhiXbbd3iFlVY282+
	 6mu74Dai7ldME1f5iwnc1XEwudPuF94OczM+E65CcQ7xoUKAodzXQJJsXtcLCKa/C8
	 c7q7utY5SJ73VWEEAbD5cDbpl02e4/rzUzic4q5BwQl+1evudU7d88V8C+ye+rcI5H
	 dHxjeYXUYOgC0kH3ubfT9mQ6brTALotpA0gnhgDVkrxLzeIakZ4Hop9+SFdcEVbiLO
	 e671Xe32GTj2Srpyyp+kufjR9eYrLHUMqXvGeNM7xShm5qMrLDTeo29NuhEyK3XH1R
	 r/656eJBgdqaw==
Date: Tue, 6 Feb 2024 19:35:19 +0000
From: Simon Horman <horms@kernel.org>
To: Wen Gu <guwen@linux.alibaba.com>
Cc: wenjia@linux.ibm.com, jaka@linux.ibm.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	alibuda@linux.alibaba.com, tonylu@linux.alibaba.com,
	linux-s390@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net/smc: change the term virtual ISM to
 Emulated-ISM
Message-ID: <20240206193519.GI1104779@kernel.org>
References: <20240205033317.127269-1-guwen@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240205033317.127269-1-guwen@linux.alibaba.com>

On Mon, Feb 05, 2024 at 11:33:17AM +0800, Wen Gu wrote:
> According to latest release of SMCv2.1[1], the term 'virtual ISM' has
> been changed to 'Emulated-ISM' to avoid the ambiguity of the word
> 'virtual' in different contexts. So the names or comments in the code
> need be modified accordingly.
> 
> [1] https://www.ibm.com/support/pages/node/7112343
> 
> Signed-off-by: Wen Gu <guwen@linux.alibaba.com>

Reviewed-by: Simon Horman <horms@kernel.org>


