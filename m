Return-Path: <linux-kernel+bounces-147928-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40FB18A7B73
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 06:38:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A0A34B22CF8
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 04:38:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1936232182;
	Wed, 17 Apr 2024 04:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thefossguy.com header.i=@thefossguy.com header.b="Hn0Cnc4P"
Received: from mail-4022.proton.ch (mail-4022.proton.ch [185.70.40.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7AA2249FF;
	Wed, 17 Apr 2024 04:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713328681; cv=none; b=DXuILphBTfCbwGkMbYi5WoOx8RURokxhykKVcLpyjQ5JlDRAd5WrLiLOlGIV5wwvm1n8URcqbpD0IYe7bax3zgkypwAzarXObCFihGL8U2AMxa16WDFCzD1D0Xg2glus+I8AOaURekfxiQgKYtvAkmlEOZUDCiew8Cnq8V6LmMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713328681; c=relaxed/simple;
	bh=KX5dGt60kRXkSBH8M6UZCTSOzlReUUj2VrWu2VzGTP8=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=flDM29dy3Kye4oowssiB/SG9JB2NDdWj+qPVjBw7s+FTawcPVAgTIM7V7dABC5gLUYOWz9ubr54Cy+ONmjgOzuljqQCNVVNlKubH24jBeSfnY2gRsJ9EZMLcCyb78f57ykntL9N7E2w5ZOQ1PgLHrbZAv/LJdttMjE3gIoe/wsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=thefossguy.com; spf=pass smtp.mailfrom=thefossguy.com; dkim=pass (2048-bit key) header.d=thefossguy.com header.i=@thefossguy.com header.b=Hn0Cnc4P; arc=none smtp.client-ip=185.70.40.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=thefossguy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thefossguy.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thefossguy.com;
	s=protonmail; t=1713328677; x=1713587877;
	bh=KX5dGt60kRXkSBH8M6UZCTSOzlReUUj2VrWu2VzGTP8=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=Hn0Cnc4Pkbu6KMaU1AGxgDMbM5vaIPjmlxIdYfg3zIHx+5PBIIOSEyNZ6CGF7Uifi
	 pLQe/89ehnOmoWS9KG2VKKEausXHxGZkMuigygbEVsSaU4sK49wsGt5DhDVRFs7CRa
	 4UlUrf9iCRvqZsmP0ORdXPJAZbp6cGw8SJ9AJhTXdFOi712Ugca8/JmvzLC+KW+OjW
	 27FjH64l324YsHH4fYlLrbpw1TjDymKmw3jpHiSBHdnjG7Kftxz3PK73Ohpd3cF1FB
	 5pp0FQ2VPRJcR3hI9e4QZkmOUzVriCnuKVlJ7saaiTTNuK+OHI0rWL72LivZlycMc8
	 uw4ZAelDRwVqg==
Date: Wed, 17 Apr 2024 04:37:54 +0000
To: Masahiro Yamada <masahiroy@kernel.org>, Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, Jonathan Corbet <corbet@lwn.net>
From: Pratham Patel <prathampatel@thefossguy.com>
Cc: linux-kbuild@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Pratham Patel <prathampatel@thefossguy.com>, thefirst1322@gmail.com
Subject: [PATCH 2/2] docs: kbuild: document KBUILD_RPM_WITH_DEVEL
Message-ID: <20240417043654.60662-3-prathampatel@thefossguy.com>
In-Reply-To: <20240417043654.60662-1-prathampatel@thefossguy.com>
References: <20240417043654.60662-1-prathampatel@thefossguy.com>
Feedback-ID: 104309535:user:proton
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

KBUILD_RPM_WITH_DEVEL was added to toggle the `with_devel` RPM macro.
Add brief documentation on its usage.

Signed-off-by: Pratham Patel <prathampatel@thefossguy.com>
---
 Documentation/kbuild/kbuild.rst | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/kbuild/kbuild.rst b/Documentation/kbuild/kbuild.=
rst
index 9c8d1d046ea5..0b7ae268ac67 100644
--- a/Documentation/kbuild/kbuild.rst
+++ b/Documentation/kbuild/kbuild.rst
@@ -310,6 +310,12 @@ These two variables allow to override the user@host st=
ring displayed during
 boot and in /proc/version. The default value is the output of the commands
 whoami and host, respectively.
=20
+KBUILD_RPM_WITH_DEVEL
+---------------------
+This variable dictates weather creating an RPM package also builds a `-dev=
el`
+package or not. Set to 1 if you want a `-devel` package. The default value
+is 0.
+
 LLVM
 ----
 If this variable is set to 1, Kbuild will use Clang and LLVM utilities ins=
tead
--=20
2.42.0



