Return-Path: <linux-kernel+bounces-100147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E70E87928F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 11:56:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFDEB1C224F0
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 10:56:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E05078693;
	Tue, 12 Mar 2024 10:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sty/69dJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7319E3AC2B;
	Tue, 12 Mar 2024 10:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710240997; cv=none; b=bXlBNH9JBuPQA+XyVFCWVb6/UfkMFLUBLEPQTwZeXW759ngc0cnvIckPqCkG2HAJvrN2TBlIEs+1i+8n9ANnEkSLUBDyrmJBFGCuvn1zzIgXZdTCyA0Bo1qzR0G5bz0JSI2OrNCu7ZDJesvpdjYEqoGoUAGP5OPlUiLjPPikPlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710240997; c=relaxed/simple;
	bh=ai/uN4Yzr0+Mmqa1S4fkSbDiSadGm0/mKTGNm+G5JO0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KE9NhgqT3uLTnLA2jnJfdhI9IoixeZPv2v90nsG3ypchfLpQxm8E2oe9YPZwjPo34MgHnKopeLkSUifgCtqXuSR+qY5izDR7KWj1nLyG9dVDwId0FGdruaaoepZgOtyo1jfd+PBYdVXiImR6uhk+vD9dESdHiO21zQq7mgr/zDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sty/69dJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 534D5C433F1;
	Tue, 12 Mar 2024 10:56:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710240996;
	bh=ai/uN4Yzr0+Mmqa1S4fkSbDiSadGm0/mKTGNm+G5JO0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sty/69dJ024y9fnJSDdCy9eCgi0qSub/KMuklpbcNUVFqnoHGAwW1MxwTBaLNL+W/
	 p4CTMQamQuWR7FpDLk22S/Mc49fJMMFCBEW3LUpVS0eFUMHQy5jRewy2pUXlipTMxy
	 R3c+MTr+3Vz0vt5u5yruTUc+IpwZwO2tIV6Su1dtZNwpg4njM2OJxmcIfKwPgRXMTX
	 uf4WCghzc+EK1pMTdqgoOYMD2VGUcvu61GZToqUWOvJYTCj1PBUJtIjSo2+zBpayel
	 DfNjnYjxKpLC/Rv8idSW052HDBWA529XcewplKWB08/Xmvz33JdgTfb737syye1F9l
	 /c5H+QM94U3Dw==
Date: Tue, 12 Mar 2024 11:56:32 +0100
From: Andi Shyti <andi.shyti@kernel.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: Signed-off-by missing for commit in the i2c-host tree
Message-ID: <sbeyxniwmf5elgxoytyk7drts4d5xsp6aoppjxcmvpcaqsxpbk@ji5qcmuufldc>
References: <20240312082109.3b040f7b@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240312082109.3b040f7b@canb.auug.org.au>

Hi Stephen,

> Commit
> 
>   43f58f3e4b66 ("i2c: nomadik: simplify IRQ masking logic")
> 
> is missing a Signed-off-by from its committer.

Thanks, fixed it... I did a reword in the commit log and forgot
to add the SoB.

Andi

