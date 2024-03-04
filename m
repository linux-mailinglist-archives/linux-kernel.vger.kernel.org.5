Return-Path: <linux-kernel+bounces-90330-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05FE086FDBC
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 10:31:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 374DA1C22521
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 09:31:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E79CD2574D;
	Mon,  4 Mar 2024 09:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b="0UBIHd55";
	dkim=pass (2048-bit key) header.d=fjasle.eu header.i=@fjasle.eu header.b="Ohqp62fV";
	dkim=pass (1024-bit key) header.d=fjasle.eu header.i=@fjasle.eu header.b="44xz7tw8"
Received: from e2i652.smtp2go.com (e2i652.smtp2go.com [103.2.142.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 811B01B814
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 09:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.2.142.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709544477; cv=none; b=ekLZS/MBDPLfZF4YnEr+wdpc+wpYIMsm2tXDtM2t/qqcYA8A+ftWPn6QlnUSFvO8Dtj12tW7LAUkxAFcPkDNGhZpHM0ncFBucW+TEQr8pPiabELbK2iE2Z/AQ/C8NEYICGqr1aAu1pW/5hlZClta8YwbsXk02t/46/u+pArbUWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709544477; c=relaxed/simple;
	bh=QmqJ7UhtuVE/HMfCaaiIwMG4Sf8WNDWahWxOP3KDP1E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D9PhckLbJmmfSumO39QwAykLM/dxcoiyITiF8bUk322KpXHh0H8OSCa8FNhvxg69+2p86hopYGuyOh1j8ij+uFE3xLu1A/3HC/Bws/lbb2lcwGrg8BQbsrEVzsFeMwmEy9A7jGhnrc3avVCaPV4YllMrO7QS9Elcdzi6q8zZ2ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fjasle.eu; spf=pass smtp.mailfrom=em1174286.fjasle.eu; dkim=pass (2048-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b=0UBIHd55; dkim=pass (2048-bit key) header.d=fjasle.eu header.i=@fjasle.eu header.b=Ohqp62fV; dkim=pass (1024-bit key) header.d=fjasle.eu header.i=@fjasle.eu header.b=44xz7tw8; arc=none smtp.client-ip=103.2.142.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fjasle.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em1174286.fjasle.eu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=smtpservice.net; s=mp6320.a1-4.dyn; x=1709545370; h=Feedback-ID:
	X-Smtpcorp-Track:Message-ID:Subject:To:From:Date:Reply-To:Sender:
	List-Unsubscribe; bh=Qfb6bThjmv/VgqZhejNoWiotxzCbE3kVarYQxzt4WaA=; b=0UBIHd55
	7vPQl4MSib0zGMz/xjdHVkc0negxI4gXNeF+A8jlYlPEQqVc2rRkJFP12hRjLSE/4f4umqZHj2p8b
	Q3n5eQL8zGO+U9pLm7o0zvGSV8pC3z0va7rydc+lax/GbbyQiSobgMOJCW63JAThIhNiyMOqUJII/
	MBqaVW2JMIJTL6q6oJ2i12BGzQjn1dfhdKHBTwEan3rH+SJ9DLMglQEQGa+lZQHUElUFoUjO7pH98
	J4KufAj/6gMoZtj4KNopyVwkp2XGzKdXB9KxLjO6SkVzb1jSf+Z7sGwOayvNkiVhx1PletjA9wjL0
	mEdVdmgmtpLgZ9niMfjxjwXLBQ==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fjasle.eu;
 i=@fjasle.eu; q=dns/txt; s=s1174286; t=1709544470; h=from : subject :
 to : message-id : date;
 bh=Qfb6bThjmv/VgqZhejNoWiotxzCbE3kVarYQxzt4WaA=;
 b=Ohqp62fVXyQ6VCJICPFwl9/zIeMjZl9r7/U5fRNYVSDXvw360Rx5QDubCAusGvJx32E07
 zxCIrc+usO8kYepljJlkGQMUSTOz6hAnLPLIzroBzSj1SS5NvEVoJKXYa+ojZxlyJeFWrVX
 7Mn79cm9bWDFfJmDdWTwY88cy+xcqmPN+ZbtoTl5WhxwJY1jqHBkr6a02G6KhyJkkBuC8fW
 bhHUD2inEw3qnyO8/x8n23B3BIJKLhQSzNwiDMUWBnwwdRi4MgdYP11X0yw1JPaGo/Jd2xo
 tYPwbKqRLr+Y7yQLeu1iqeujfP2NwaQ7rAQukaSG/LT/+/cfecS3NB70cgHQ==
Received: from [10.176.58.103] (helo=SmtpCorp) by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.94.2-S2G) (envelope-from <nicolas@fjasle.eu>)
 id 1rh4bK-qt4Bsz-RR; Mon, 04 Mar 2024 09:27:14 +0000
Received: from [10.85.249.164] (helo=leknes.fjasle.eu)
 by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.96.1-S2G) (envelope-from <nicolas@fjasle.eu>)
 id 1rh4bJ-9EUhbQ-3C; Mon, 04 Mar 2024 09:27:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fjasle.eu; s=mail;
 t=1709544430; bh=QmqJ7UhtuVE/HMfCaaiIwMG4Sf8WNDWahWxOP3KDP1E=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=44xz7tw8p+f3Vh25lAH4uNCGrh7BZZ93ShKdQYLxl4MDS/WNfvJVuoTE+BDI+MzRN
 Qf1nKbySvlIOOzVI3+r0Mg7pXlVWvDgMQz4MZBX9ScZcrs9i58NTy2dSw966tqcGip
 /MR+ab46lJht8yGpguI02pUatUgqG8UTR1f5RGeM=
Received: by leknes.fjasle.eu (Postfix, from userid 1000)
 id CEAA53C312; Mon,  4 Mar 2024 10:27:09 +0100 (CET)
Date: Mon, 4 Mar 2024 10:27:09 +0100
From: Nicolas Schier <nicolas@fjasle.eu>
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
 Jonathan Corbet <corbet@lwn.net>,
 Nathan Chancellor <nathan@kernel.org>, linux-doc@vger.kernel.org
Subject: Re: [PATCH 3/3] kconfig: remove named choice support
Message-ID: <ZeWT7XdgZb2_WJuv@fjasle.eu>
References: <20240303040035.3450914-1-masahiroy@kernel.org>
 <20240303040035.3450914-3-masahiroy@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240303040035.3450914-3-masahiroy@kernel.org>
X-Smtpcorp-Track: 1rh4PJ9ElhPQ3C.5le39HMBaNLI2
Feedback-ID: 1174286m:1174286a9YXZ7r:1174286svisR9M6AQ
X-Report-Abuse: Please forward a copy of this message, including all headers,
 to <abuse-report@smtp2go.com>

On Sun, Mar 03, 2024 at 01:00:35PM +0900 Masahiro Yamada wrote:
> Commit 5a1aa8a1aff6 ("kconfig: add named choice group") did not provide
> enough explanation. A use case was found in another project [1], but
> this has never been used in the kernel.
> 
> [1]: https://lore.kernel.org/all/201012150034.01356.yann.morin.1998@anciens.enib.fr/
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
> 
>  Documentation/kbuild/kconfig-language.rst |  6 +-----
>  scripts/kconfig/parser.y                  | 10 +++-------
>  2 files changed, 4 insertions(+), 12 deletions(-)
> 

Reviewed-by: Nicolas Schier <nicolas@fjasle.eu>

