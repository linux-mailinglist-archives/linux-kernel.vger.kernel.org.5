Return-Path: <linux-kernel+bounces-110286-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AE746885CA8
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 16:54:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBFC01C22AA5
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 15:54:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A72D1292D5;
	Thu, 21 Mar 2024 15:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dotat.at header.i=@dotat.at header.b="pm4Y72zA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="P3ZjLmKa"
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 282CC8528F;
	Thu, 21 Mar 2024 15:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711036448; cv=none; b=kY5SbYmK6pnwHXcEvxaoWB09KU22FGK7hzyZaGzmG4iNp/hn5cz26YqHd25EedTsFIAqul89R2QZcBy4BU6iqYgKjYkbWskSkanOo7nk0+akJhQPeO9TN1dqqE76doMfhHQmHX++CBEgjHxijSIFmQfpEvmUxnMekP+CNl2Wh7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711036448; c=relaxed/simple;
	bh=lZh6FJjCNw8BxJ1mYjcCZc2XnOoGrsVZuAlW6za1z0M=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=fPlqwYtfulkaF5TdLgjo/jExxGnuembn/qJblX3N+2L3KMRtMaOojQhlGXb6hoyTnM2TdzZV517oNCBKhiNn6QYtDd859CYPbrDfalfHLKgFFOPBUPHrwEtghbqQXA+yvUAXWEwDeEn0OWqROjm1ubT2xQIeXK9YyVndWL8s34Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dotat.at; spf=pass smtp.mailfrom=dotat.at; dkim=pass (2048-bit key) header.d=dotat.at header.i=@dotat.at header.b=pm4Y72zA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=P3ZjLmKa; arc=none smtp.client-ip=66.111.4.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dotat.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dotat.at
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id 410C05C0073;
	Thu, 21 Mar 2024 11:54:04 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Thu, 21 Mar 2024 11:54:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dotat.at; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1711036444; x=1711122844; bh=74R41r958Q
	IJgb+sYpqH2zLkkkSNydXL94h/nGSYDtA=; b=pm4Y72zAof26ffjI4nSoqGoTsr
	rWSujizkxjOTwyHAHRzmug6yuB1nUN5a7JlXQi5hKf46ctFqdVTBtrFiyXGE6Y2w
	L81XzNk1wzWzk3Cd4Z56f1EDnJzxFraZW3oETLeQv3fiUZTgcomjDV6ie8dPekWb
	110di22AhtineDpNuimpudYA0tuUIHyeXAkSiGudgL8l70bThzw69cRs/xfVD2HZ
	XRC3DHulQ/R/NmNE9sZscDZCOtxHF4qxP2AT7YSAWEPcjS1UaxILfoF863gFJht1
	axUX5W9eVkoYGoiYU6ZjRkytVQj+CDuY5lue1Lu8KaiNkTjN26mdBkgofCgA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1711036444; x=1711122844; bh=74R41r958QIJgb+sYpqH2zLkkkSN
	ydXL94h/nGSYDtA=; b=P3ZjLmKaezUgXZeTPx9PF3NZ0m6hW0Mr/SnzolPtZhY1
	6MED3WhzeKWh/7hJ9Vz4TVz6szmy9GDXYAGE0JhIWEN7jTgel7qALpC6vpfgHDlf
	zDxt4IMqt4LjQa7zZEHMFsOFLE0KKH/ip9NFfwuAZH+u/pDtTpQDYcJd/mHtrFy8
	gj0k7WZN4BV+TU8A+PcKZiBnGDtoMatTXm00gXW8Ly3TaaaqEBDUvl2w9d/ByXRv
	7Qv9VjLsX5VlK1nZxzbOFiQ5DMIMzZmtu4b7jvlzFsRSeS1YICteNHzkHL5ibDck
	WoJS8UBeP9ZVtvlcJm4F5WJ0LSuS+3UNSSBOyaz9iQ==
X-ME-Sender: <xms:G1j8ZSU8V0rgAILW-AvRY4rCzLQfdd-VnAc-zV2hJ-je0hYuOAzhLg>
    <xme:G1j8Zen1P9elTwFshRewMsjm5X1hY1NrXGCzQqHKlQsfbP5PSoClYQbu89lwwisYa
    5nrBGNTmzV2jp0>
X-ME-Received: <xmr:G1j8ZWZiV9W5NjmNVgjXjIjGUp80Y8UPLY2XPue_-Qe9T_Y58Eww4Iw5yc9I-q_TQRjJyi9I1jrxXUkPN1QVIHg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrleejgddvtdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefujgfkfhggtgesthdtredttddtvdenucfhrhhomhepvfhonhihucfh
    ihhntghhuceoughothesughothgrthdrrghtqeenucggtffrrghtthgvrhhnpeetffejue
    ehieekveegffduleelfefhtdekheehfeeuheduleehieeigfduffduvdenucffohhmrghi
    nhepohhpvghnqdhsthgurdhorhhgpdguohhtrghtrdgrthenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpeguohhtseguohhtrghtrdgrth
X-ME-Proxy: <xmx:G1j8ZZX1h8ch1i8cWKPzsqKeRiH3o0M5xE59G6hjlsc6_35yga0sBg>
    <xmx:G1j8ZckyJ_NJuTDsHT9MWtyXENiJMF_tbfThC0Vm-_ATsz34uK-0Rw>
    <xmx:G1j8ZefRg1_U8Q1p4Oj2pRpOMeH6r15PRbDzQAvmItEZwxXc65rhKA>
    <xmx:G1j8ZeF6R1-9QxC4zdF6mxAedIX4a3Rm7op_9VFRciq3EbjISnI2tA>
    <xmx:HFj8ZZilCf5BTCDxlkFSudAUrlKtiDNqC-qAO2906B30GBZjwAEGPg>
Feedback-ID: i7158435c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 21 Mar 2024 11:54:01 -0400 (EDT)
Date: Thu, 21 Mar 2024 15:53:59 +0000
From: Tony Finch <dot@dotat.at>
To: Arnd Bergmann <arnd@kernel.org>
cc: Sam Ravnborg <sam@ravnborg.org>, Arnd Bergmann <arnd@arndb.de>, 
    Masahiro Yamada <masahiroy@kernel.org>, 
    Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, 
    linux-kbuild@vger.kernel.org, Michal Marek <mmarek@suse.cz>, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scripts/unifdef: avoid constexpr keyword
In-Reply-To: <20240320180134.100863-1-arnd@kernel.org>
Message-ID: <196e71e0-6b17-f970-c034-4452e0c44052@dotat.at>
References: <20240320180134.100863-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

Arnd Bergmann <arnd@kernel.org> wrote:
>
> Starting with c23, 'constexpr' is a keyword in C like in C++ and cannot
> be used as an identifier:

So it is! Can you please incorporate the fixup patch below? Other than
that, LGTM.

Reviewed-By: Tony Finch <dot@dotat.at>

PS. I've been reviewing some other details of C23 recently. According to
the Editor's Report https://open-std.org/jtc1/sc22/wg14/www/docs/n3221.htm
the working draft that is closest to the official C23 Draft International
Standard is https://open-std.org/jtc1/sc22/wg14/www/docs/n3220.pdf
(There were significant changes and fixes even quite late in the process
so don't rely on earlier versions - I encoutered a bug when I did!)


--- scripts/unifdef.c
+++ scripts/unifdef.c
@@ -819,7 +819,7 @@ static const struct ops {
 /*
  * Function for evaluating the innermost parts of expressions,
  * viz. !expr (expr) number defined(symbol) symbol
- * We reset the constexpr flag in the last two cases.
+ * We reset the constexpression flag in the last two cases.
  */
 static Linetype
 eval_unary(const struct ops *ops, int *valp, const char **cpp)


-- 
Tony Finch  <dot@dotat.at>  https://dotat.at/
South Utsire: Variable 2 to 4 becoming south or southwest 5 to 7.
Moderate or rough. Rain or showers. Moderate or good, occasionally
poor.



