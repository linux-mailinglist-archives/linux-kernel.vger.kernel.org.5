Return-Path: <linux-kernel+bounces-88309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6254D86DFE7
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 12:12:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BD6F285969
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 11:12:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50E0E6CDC3;
	Fri,  1 Mar 2024 11:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=avm.de header.i=@avm.de header.b="OYt9+PHK"
Received: from mail.avm.de (mail.avm.de [212.42.244.94])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADFBC6F51A;
	Fri,  1 Mar 2024 11:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.42.244.94
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709291423; cv=none; b=XiHu1hiT1Hzs98CnhtAYqQVfle+RVey6NmDtdETgpCSO4YcqKU1CP+Mir5EuBELOTytyNp/o1b/ss1JH2tVTug/073ktpzQTup0nTq+coqDBrpFEu0lJcvlWtI9heV+pxmDdsa+u/2NYUtdAVCpIcMqzkALjESvK7q/+kqJZ4I8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709291423; c=relaxed/simple;
	bh=e51zttODIbyBxyNN35mjWWt+KgFVjTSgZK3n2T+b+wA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R1DZdtpBrvgIph4L8I4Z+guafltAM/7N8I1pEZ3YaaKo5AcPLSpXNiWOI00JTvmtb0zGjK2MvpXcVfLPWdQFxMCDI0ZjIq5k+GUu0Tl7he3ykDy7jMignxlTiOdxfxZQ7stxzCqHmbAcMXvDP4O8pPsm3ewu+P8ZwnWuQLU8WF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=avm.de; spf=pass smtp.mailfrom=avm.de; dkim=pass (1024-bit key) header.d=avm.de header.i=@avm.de header.b=OYt9+PHK; arc=none smtp.client-ip=212.42.244.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=avm.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=avm.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=avm.de; s=mail;
	t=1709291069; bh=e51zttODIbyBxyNN35mjWWt+KgFVjTSgZK3n2T+b+wA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OYt9+PHKFGKyVmiw2Fu9C7UcOW5wT3FzEZ/vWjYUpxiWfoxQhPxe16pyMOZ1ur80b
	 vbPCGtdskDaris+wLpPUCg6CjTEhwz7GNYFgp69zBmGfTeypJokCTCH0zCWCudmsgG
	 kWhfadgrV4lfaX/AabDRTdJ+1RNWWHtrA03vRyv0=
Received: from mail-auth.avm.de (dovecot-mx-01.avm.de [212.42.244.71])
	by mail.avm.de (Postfix) with ESMTPS;
	Fri,  1 Mar 2024 12:04:29 +0100 (CET)
Received: from buildd.core.avm.de (buildd-sv-01.avm.de [172.16.0.225])
	by mail-auth.avm.de (Postfix) with ESMTPA id 809C680152;
	Fri,  1 Mar 2024 12:04:29 +0100 (CET)
Received: by buildd.core.avm.de (Postfix, from userid 1000)
	id 744511812F7; Fri,  1 Mar 2024 12:04:29 +0100 (CET)
Date: Fri, 1 Mar 2024 12:04:29 +0100
From: Nicolas Schier <n.schier@avm.de>
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Masahiro Yamada <masahiroy@kernel.org>, linux-kbuild@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCHv2] kconfig: add some Kconfig env variables to make help
Message-ID: <ZeG2PRYmdO0r44kS@buildd.core.avm.de>
Mail-Followup-To: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240222032559.496127-1-senozhatsky@chromium.org>
 <CAK7LNARo4L6qxoqRU-0dgABarukJKAaZpCRtfA3MyUHhSuDQxQ@mail.gmail.com>
 <20240222051621.GH11472@google.com>
 <20240228045652.GH11972@google.com>
 <CAK7LNAQ8OyNMeGzVoTRg-sHDZ4YK0EKY_eEWNepekaibO_ZKwg@mail.gmail.com>
 <20240229021010.GM11972@google.com>
 <CAK7LNASujf8m4PpMyoCC1cTN_YGeG1HVaOR+3pZx5=3OJp=85A@mail.gmail.com>
 <20240229034739.GN11972@google.com>
 <CAK7LNAS-mOxY884pLEMwWaX+wgzXdc6+=vqN=wfHBekuKL5ryA@mail.gmail.com>
 <20240301043316.GO11972@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240301043316.GO11972@google.com>
Organization: AVM GmbH
X-purgate-ID: 149429::1709291069-3ED8F9CD-E71215DF/0/0
X-purgate-type: clean
X-purgate-size: 1915
X-purgate-Ad: Categorized by eleven eXpurgate (R) http://www.eleven.de
X-purgate: This mail is considered clean (visit http://www.eleven.de for further information)
X-purgate: clean

On Fri, Mar 01, 2024 at 01:33:16PM +0900, Sergey Senozhatsky wrote:
> On (24/03/01 00:35), Masahiro Yamada wrote:
> > > >   "I am interested only in these. I do not care about the rest,
> > >
> > > It's "I *do NOT know* what the rest do".  I cannot document something
> > > that I have no knowledge of, can I?  So as a reasonable start I added
> > > only those that I'm familiar with (and I have explicitly stated that
> > > in previous emails), and I disagree with the "bad attitude" label.
> > 
> > 
> > You were aware of:
> > 
> >  - several env variables are listed in the document
> >  - your patch would introduce a new "inconsistency"
> >  - somebody else would need to make efforts to solve it
> 
> OK.
> 
> > > So the rational for that was that people run "make help" and find
> > > out about new build targets, for instance, but there is no way for
> > > people to find out about new Kconfig features (and yes, we are talking
> > > "new features" here) that are controlled by env variables.  We need
> > > to do something about it, don't you agree?
> > 
> > Disagree.
> > 
> > I maintain the entire Kconfig, not like you only caring about
> > a particular feature.
> > 
> > If you add only two in help, I have no idea about
> > what it will look like in the end.
> > I am not convinced that it will be in good shape.
> > So, it is reasonable for me to reject it.
> 
> Yes, OK.  I wasn't talking about this patch in particular at that
> point, I was more curious whether you agreed that we need to document
> in some way those vars in `make help` or not.  If you see value in
> documenting them then I can sit down and try to come up with v3 that
> will (in one way or another) give a simple "help" description for
> each of Kconfig's vars.

Perhaps it might be a compromise to let 'make help' point to the
kbuild/kconfig documentation?

Kind regards,
Nicolas

