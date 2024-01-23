Return-Path: <linux-kernel+bounces-35466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FB2E839198
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 15:42:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC98A2844DE
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 14:42:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CF9C56755;
	Tue, 23 Jan 2024 14:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nwl.cc header.i=@nwl.cc header.b="ZfDBlhUz"
Received: from orbyte.nwl.cc (orbyte.nwl.cc [151.80.46.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42C002B9C0;
	Tue, 23 Jan 2024 14:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=151.80.46.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706020910; cv=none; b=PuUbyIiiMhlPdOmMdgxlKUZNzMm8E+ZeKqpUKdm/uUxHgWkIUt2JUd2H8ez+yiwWrkQhMNqQLLJl/T1N7xocjwV1Tl2m9miqollIlwMXan+Mz+QiR537BK4z+ZV7ZZZ35tYGp4ClgKsrzAn7hh3fWhOBQsEW5yq+YDeD5E3K3Xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706020910; c=relaxed/simple;
	bh=Fugrd7Xd23UiFFUWmNQ6MW06YWe/PAihiB2USFF2qRw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uqxVF/fa32w+2dvzGDvp3e2XK+O3+Y4otr0Bse+HTWxlbz7+WBSYF+EPMcUMMcerlptSaIy2MqCTKW4KhboT6/+GD1VYg1O7t9BxSRUBXtqjQ4HL8rxmfcoxPKC4ZCvfYQEqSBwaVy1JRJRYJ9z8ywOqYPignQ9v/ExAQg8JI8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nwl.cc; spf=pass smtp.mailfrom=nwl.cc; dkim=pass (2048-bit key) header.d=nwl.cc header.i=@nwl.cc header.b=ZfDBlhUz; arc=none smtp.client-ip=151.80.46.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nwl.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nwl.cc
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nwl.cc;
	s=mail2022; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=BTsxL2QSNrFW7p5bkgMQqWW/siZMS6ojxp3iHaXXt+w=; b=ZfDBlhUz5V4aHvs9rQBiO80jj7
	CI9zxEIc96m8NF3GAnPX4hosYiRwHSQ/Lp6wLLb9JCCjW2uPNAz5qfN5Vo39HqcBhtZEWJj6UJkOQ
	Edzjv7Ocz6iFfAtYO6pHDlY2+yxtLPTA0qDec1y9awtlfhzeWZEe9pKIfWayGJkm31N6uvsQiD9NG
	Lf3J9MdybNdO83XxTUsaqZcOSDuk2Ge6jUmgkw89ML94jVI1bp3Hpj+dIN3rxS1JjcSW2EZ/+fv+X
	N15T8udR80HXFL7tPBuehz9JBbFnbOhxNXnsSGucRVQZoxauXiebE4K+lDwWm8wCTzUiCuDw0X1Ov
	AnZ+Kfrw==;
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.97)
	(envelope-from <phil@nwl.cc>)
	id 1rSHy9-000000002rA-1YHh;
	Tue, 23 Jan 2024 15:41:41 +0100
Date: Tue, 23 Jan 2024 15:41:41 +0100
From: Phil Sutter <phil@nwl.cc>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
	netdev@vger.kernel.org, kernel-janitors@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Florian Westphal <fw@strlen.de>,
	Jakub Kicinski <kuba@kernel.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Paolo Abeni <pabeni@redhat.com>,
	LKML <linux-kernel@vger.kernel.org>,
	Kunwu Chan <chentao@kylinos.cn>
Subject: Re: [PATCH] netfilter: nf_tables: Add a null pointer check in two
 functions
Message-ID: <Za_QJZhWKoq5wg52@orbyte.nwl.cc>
Mail-Followup-To: Phil Sutter <phil@nwl.cc>,
	Markus Elfring <Markus.Elfring@web.de>,
	netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
	netdev@vger.kernel.org, kernel-janitors@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Florian Westphal <fw@strlen.de>,
	Jakub Kicinski <kuba@kernel.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Paolo Abeni <pabeni@redhat.com>,
	LKML <linux-kernel@vger.kernel.org>,
	Kunwu Chan <chentao@kylinos.cn>
References: <c49c716a-e070-4ad5-9a90-896537bcd1b5@web.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c49c716a-e070-4ad5-9a90-896537bcd1b5@web.de>

Hi Markus,

On Tue, Jan 23, 2024 at 02:45:12PM +0100, Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Tue, 23 Jan 2024 14:28:31 +0100
> 
> The result from a call of the function “kasprintf” was passed to
> a subsequent function call without checking for a null pointer before
> (according to a memory allocation failure).
> This issue was detected by using the Coccinelle software.

This is correct and I'm fine with the patch if it avoids ringing alarm
bells somewhere, yet it doesn't fix an actual issue here since the
allocated buffer is merely passed to vsnprintf() which detects and
sanitizes %s args being NULL.

Cheers, Phil

