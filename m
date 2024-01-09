Return-Path: <linux-kernel+bounces-20972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC3598287EB
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 15:18:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 85A7EB239FC
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 14:18:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FD333987A;
	Tue,  9 Jan 2024 14:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=avm.de header.i=@avm.de header.b="J+mmfbRB"
Received: from mail.avm.de (mail.avm.de [212.42.244.94])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 243EE39AC3;
	Tue,  9 Jan 2024 14:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=avm.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=avm.de
Received: from mail-auth.avm.de (dovecot-mx-01.avm.de [212.42.244.71])
	by mail.avm.de (Postfix) with ESMTPS;
	Tue,  9 Jan 2024 15:18:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=avm.de; s=mail;
	t=1704809914; bh=U+vldAfh5/nLtIv1m4acjz14ho6yNXMM8DQJmOys7t8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=J+mmfbRBp37YElkZ9SCgN+a0S0LaIMC0L3s29FaN6fWt6khveIfauFANY2q105RS2
	 GY/Y3wdIjNKgFvs7wrACbtZxGKE0zPdGQAdh5Z4gI/Jkan/EwiKUq55+y/p6N6tQ7Y
	 ayhazLblRCDT3/9vwKy+TjXb6NoaSmNba55x4t44=
Received: from buildd.core.avm.de (buildd-sv-01.avm.de [172.16.0.225])
	by mail-auth.avm.de (Postfix) with ESMTPA id CF9008058E;
	Tue,  9 Jan 2024 15:18:33 +0100 (CET)
Received: from reykjavik.ads.avm.de (unknown [172.17.89.91])
	by buildd.core.avm.de (Postfix) with ESMTPS id C250C180D04;
	Tue,  9 Jan 2024 15:18:33 +0100 (CET)
Date: Tue, 9 Jan 2024 15:18:29 +0100
From: Nicolas Schier <n.schier@avm.de>
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: linux-kbuild@vger.kernel.org, Ben Hutchings <ben@decadent.org.uk>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Nicolas Schier <nicolas@fjasle.eu>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/5] kbuild: deb-pkg: use debian/<package> for tmpdir
Message-ID: <ZZ1Vtak4SG3KKVnA@reykjavik.ads.avm.de>
References: <20231230135200.1058873-1-masahiroy@kernel.org>
 <20231230135200.1058873-3-masahiroy@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231230135200.1058873-3-masahiroy@kernel.org>
X-purgate-ID: 149429::1704809914-6460392C-5A89843D/0/0
X-purgate-type: clean
X-purgate-size: 283
X-purgate-Ad: Categorized by eleven eXpurgate (R) http://www.eleven.de
X-purgate: This mail is considered clean (visit http://www.eleven.de for further information)
X-purgate: clean

On Sat, Dec 30, 2023 at 10:51:58PM +0900, Masahiro Yamada wrote:
> Use debian/<package> for tmpdir, which is the default of debhelper.
> This simplifies the code.
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---

Reviewed-by: Nicolas Schier <n.schier@avm.de>

