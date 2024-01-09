Return-Path: <linux-kernel+bounces-20965-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 19B398287D8
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 15:15:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C031D1F2537A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 14:15:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0490639877;
	Tue,  9 Jan 2024 14:14:59 +0000 (UTC)
Received: from mail.avm.de (mail.avm.de [212.42.244.94])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 112E939863;
	Tue,  9 Jan 2024 14:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=fjasle.eu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=fjasle.eu
Received: from mail-auth.avm.de (unknown [IPv6:2001:bf0:244:244::71])
	by mail.avm.de (Postfix) with ESMTPS;
	Tue,  9 Jan 2024 15:14:33 +0100 (CET)
Received: from buildd.core.avm.de (buildd-sv-01.avm.de [172.16.0.225])
	by mail-auth.avm.de (Postfix) with ESMTPA id 5246280152;
	Tue,  9 Jan 2024 15:14:33 +0100 (CET)
Received: from reykjavik.ads.avm.de (unknown [172.17.89.91])
	by buildd.core.avm.de (Postfix) with ESMTPS id 45F8618163E;
	Tue,  9 Jan 2024 15:14:33 +0100 (CET)
Date: Tue, 9 Jan 2024 15:14:30 +0100
From: Nicolas Schier <nicolas@fjasle.eu>
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: linux-kbuild@vger.kernel.org, Ben Hutchings <ben@decadent.org.uk>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] kbuild: deb-pkg: make debian/rules quiet by default
Message-ID: <ZZ1UxkCgKQ9J6Iut@reykjavik.ads.avm.de>
References: <20231230135200.1058873-1-masahiroy@kernel.org>
 <20231230135200.1058873-2-masahiroy@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231230135200.1058873-2-masahiroy@kernel.org>
X-purgate-ID: 149429::1704809673-C10A692C-BB77F18E/0/0
X-purgate-type: clean
X-purgate-size: 571
X-purgate-Ad: Categorized by eleven eXpurgate (R) http://www.eleven.de
X-purgate: This mail is considered clean (visit http://www.eleven.de for further information)
X-purgate: clean

On Sat, Dec 30, 2023 at 10:51:57PM +0900, Masahiro Yamada wrote:
> Add $(Q) to commands in debian/rules to make them quiet when the package
> built is initiated by 'make deb-pkg'.
> 
> While the commands in debian/rules are not hidden when you directly work
> with the debianized tree, you can set 'terse' to DEB_BUILD_OPTIONS to
> silence them.

Reading Debian Policy §4.9 [1] I'd expected some fiddling with V=1 or
'make -s', but I am ok with the simple '@' silencing (which matches my
personal preference).

Reviewed-by: Nicolas Schier <n.schier@avm.de>

