Return-Path: <linux-kernel+bounces-47105-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A0156844948
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 21:58:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59FBB28BE42
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 20:58:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2690538F8F;
	Wed, 31 Jan 2024 20:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="Xqo6CuYo"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 507943985A;
	Wed, 31 Jan 2024 20:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706734714; cv=none; b=kzb4miMBSq5CceflmhCUS+OfzaTSkxKXTzMphllfKHyRH+TdnA5PWxgWSOCT2MGPcA54Az4cGKp3GjN//ZsPGs7307buSMi2lRXEkXA/bP5JxsLzy1xqHPnW2h/+W0wbMwxf/rqsP0LbiF57JskyU5vBPnPbOJQ0aVV2N/rZVP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706734714; c=relaxed/simple;
	bh=rPMC5cU+Nyq+sFBsKBFbVltshjTEvmOAtMoftXoiX7E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lqHlkglt/VoM81I4f2Nro0+4Xv0orEzaBwQf/NsebqG0Z03TihOaVGg4Q5iipEmKDi9RbjSgacs+CvaYaTzXhMkbl1XJcTJ900UEA/INbOm0BCUKr7ko/rQD7fD8PcI/TZOILlsVU/2T+p/L8aurw/+6BUxZyrpSkTU2WYiNIF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=Xqo6CuYo; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id ADBB940E016C;
	Wed, 31 Jan 2024 20:58:28 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id qW6VHcQ9oDn9; Wed, 31 Jan 2024 20:58:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1706734706; bh=X/M3CRf/7J/jGncONPz+Kryk1EvhpJloRvQ9Nn42wI8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Xqo6CuYor7xU/s3jrsDwZPHRIXeS9D9clChrM1leGkFn1ezh65cbl2Bl3ABABJhM/
	 hMuqi2U6+nfJ1z7Kr7cjrMa1o1mvE7wmtnIIOmvcxzoEJC3O5TwCvDYtwTR30Di134
	 HMXRPs2Y/nIIg5PhdBVTcnq24HjRZbAhdST/K8KxoukJ8iqAFjXbiiCE+L+YxRtyog
	 h8I7JPk9Px/gCskH4BF/i5/HKmvqQKMyPVn+lZzVLBh/6IpBuB/ft0+6Ssc3+s/jSd
	 ZlR/w8nEcIi6wfgm7qfIxn3t0U/8i6tnTwrjeO4yAa0ikD3CQsrgvYvBVhh5DFfF9r
	 2+Shep780NtDmpk0Gkx56EBI5Vp8fi6WCazqM5fcA55ETnAsTCCCSFsmPeRQmNlzPh
	 PrHR5P3UlFL7iiuNJMQXiN6X780+F3RGOHKGCIIUfBfM4GU9sMZhOva0E3tUHuzNB7
	 UnGescROGXYSTueHqsG1iYs49syAtbfrwMP58WcSg3HfvYfDm6oY7ZH9QxTMxoGFjh
	 fgrFziW46c7C1t+I5lONMHEn62VCvhlMSBb3crzbXr09y9sGp7ulX/TXLm+vWNbZwN
	 RCetH0gydsyLfdKuyfJQNRJlBJsTcrA5a8t0wrodvl+ifZwwYC9NcZCnvjK8B/7etO
	 AN36X+T+wjs6i+nuRbC9Im64=
Received: from zn.tnic (pd953033e.dip0.t-ipconnect.de [217.83.3.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 8885040E00C5;
	Wed, 31 Jan 2024 20:58:19 +0000 (UTC)
Date: Wed, 31 Jan 2024 21:58:14 +0100
From: Borislav Petkov <bp@alien8.de>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: Signed-off-by missing for commit in the tip tree
Message-ID: <20240131205814.GMZbq0ZgKtxHZ9d4k7@fat_crate.local>
References: <20240201074102.00726258@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240201074102.00726258@canb.auug.org.au>

On Thu, Feb 01, 2024 at 07:41:33AM +1100, Stephen Rothwell wrote:
> are missing a Signed-off-by from their committer.

Yes, I decided to rebase the branch in order to have it clean from build
breakages. Lemme add my SOB to all the commits which got their SHA1s
changed in the process.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

