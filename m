Return-Path: <linux-kernel+bounces-90092-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 726C186FA38
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 07:47:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 824EEB20B62
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 06:47:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3466011729;
	Mon,  4 Mar 2024 06:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=avm.de header.i=@avm.de header.b="bnySA/Af"
Received: from mail.avm.de (mail.avm.de [212.42.244.119])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 689BE1170A;
	Mon,  4 Mar 2024 06:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.42.244.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709534870; cv=none; b=HjCOnqo8pkDnGE9iY9BYxEGYyhjSY650B+xeuyA+PiShWZaJuO6YqNzBGPf5zKnDwgCA0rxPuHkig3ZLelAlvEJaaQ3qp1gtnAQflapIm8BhDFgd2IFEqjILcB8wk9xS+/Q5oSTs3nlURMKB8gaX6SxKYgVH9IavPb5OnViguFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709534870; c=relaxed/simple;
	bh=hQ6Jbd6lK1sLeGDCv6wXrJMCC6sO0zy1JnqZUvapV3Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t7yjThxYVT5yrsysPnAAfIfmRw130viOMVnRN97fRY1z8HtJDI+wfbS84exrOSfmaHJGqklCD61/Ubb91PmlrZLJGu2IpNNcr9w4IN18/Q1/9n1R2qm5q+foyvzLeUPLpc5u7BfLFf+OifpD9YIjy2FKMaE/Zcr75iuVt5fdIFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=avm.de; spf=pass smtp.mailfrom=avm.de; dkim=pass (1024-bit key) header.d=avm.de header.i=@avm.de header.b=bnySA/Af; arc=none smtp.client-ip=212.42.244.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=avm.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=avm.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=avm.de; s=mail;
	t=1709534499; bh=hQ6Jbd6lK1sLeGDCv6wXrJMCC6sO0zy1JnqZUvapV3Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bnySA/AfsrQ0mFyJajhUib64TkUtodY0AzXmbSo84b0V/XPMByaqAqPeIXvEzwsQW
	 KzqoIXFEufsGnLEaoiz0diXPFYWxFw0O7d1DLS4DHsAaw1qVPWLHBprWMs2QMSOSY0
	 znssIervezbWe9xzCFTSDTMQx6RfBYcQJNi9UfzA=
Received: from mail-auth.avm.de (dovecot-mx-01.avm.de [212.42.244.71])
	by mail.avm.de (Postfix) with ESMTPS;
	Mon,  4 Mar 2024 07:41:39 +0100 (CET)
Received: from buildd.core.avm.de (buildd-sv-01.avm.de [172.16.0.225])
	by mail-auth.avm.de (Postfix) with ESMTPA id 53AE280155;
	Mon,  4 Mar 2024 07:41:39 +0100 (CET)
Received: by buildd.core.avm.de (Postfix, from userid 1000)
	id 484C018B3F5; Mon,  4 Mar 2024 07:41:39 +0100 (CET)
Date: Mon, 4 Mar 2024 07:41:39 +0100
From: Nicolas Schier <n.schier@avm.de>
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Masahiro Yamada <masahiroy@kernel.org>, linux-kbuild@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCHv2] kconfig: add some Kconfig env variables to make help
Message-ID: <ZeVtIwua9T5prwUl@buildd.core.avm.de>
Mail-Followup-To: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240222051621.GH11472@google.com>
 <20240228045652.GH11972@google.com>
 <CAK7LNAQ8OyNMeGzVoTRg-sHDZ4YK0EKY_eEWNepekaibO_ZKwg@mail.gmail.com>
 <20240229021010.GM11972@google.com>
 <CAK7LNASujf8m4PpMyoCC1cTN_YGeG1HVaOR+3pZx5=3OJp=85A@mail.gmail.com>
 <20240229034739.GN11972@google.com>
 <CAK7LNAS-mOxY884pLEMwWaX+wgzXdc6+=vqN=wfHBekuKL5ryA@mail.gmail.com>
 <20240301043316.GO11972@google.com>
 <ZeG2PRYmdO0r44kS@buildd.core.avm.de>
 <20240301142844.GP11972@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240301142844.GP11972@google.com>
Organization: AVM GmbH
X-purgate-ID: 149429::1709534499-E2E59402-6B815460/0/0
X-purgate-type: clean
X-purgate-size: 895
X-purgate-Ad: Categorized by eleven eXpurgate (R) http://www.eleven.de
X-purgate: This mail is considered clean (visit http://www.eleven.de for further information)
X-purgate: clean

On Fri, Mar 01, 2024 at 11:28:44PM +0900, Sergey Senozhatsky wrote:
> On (24/03/01 12:04), Nicolas Schier wrote:
> > Perhaps it might be a compromise to let 'make help' point to the
> > kbuild/kconfig documentation?
> 
> Yes, I was thinking the same. A one-liner description per-env var
> and point to documentation if one-liner is not enough
> 
> 	KCONFIG_BARREL_ROLL	- kconfig does a barrel roll
> 	KCONFIG_FOO_BAR		- kconfig does foo and then bar (see
> 	documentation for details)

No, I thought about leaving out any concrete examples but just adding a
sentence like:

  kconfig and kbuild allow tuning and checks by settings various
  environment variables, cp. Documentation/kbuild/ for details.

Then there is no need to re-document each variable in 'make help' but
those who are new are explicitly pointed to the maintained
documentation.

Kind regards,
Nicolas

