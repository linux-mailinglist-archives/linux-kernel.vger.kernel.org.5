Return-Path: <linux-kernel+bounces-35065-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A84C838B5C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 11:05:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E8961C230CA
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 10:05:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11D975A10B;
	Tue, 23 Jan 2024 10:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="YQmDWkOh";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="YQmDWkOh"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DA6D5C5ED;
	Tue, 23 Jan 2024 10:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706004318; cv=none; b=ZR3HR1VU0vIxOe0XkUh1eJATKbiTlYtNbwY6knWypLJ5PNHFU5Oh2cTt2p8c7nOli9qfe82Fryot4ObuezLD4Wi+vVzwcGrxvPJW+hgTIwDEbchRjEoJM4b5laz2ZjI1eYbslBlCfsSi/9Wp+FfKa4oHITpO6qUJ2CezrnVnfO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706004318; c=relaxed/simple;
	bh=dod4ySizz+UXy9hLArED1qnGN6vM5M8n8D354HPBERk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S2r/1ALIJLhpAM+Dn1ZWHExYC0LwM7EAfBmnTSdbdKwf62o8qntORTu1IUDHiyQEyWojjfClN9V/PAvy2G6kzsaRxEnZWdG+8dCf9ff77zHFtZJKS1PHHRuOzK9Z32c+/uhRUsfwRhbPeQLrLwCHTKHs0+FK9TO7PXUpV5/mQ2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=YQmDWkOh; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=YQmDWkOh; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7B4221FD48;
	Tue, 23 Jan 2024 10:05:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1706004314; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hCbpUW79UBQklyQUgghM/5s8J/FybqEF+7dXOs7C6RM=;
	b=YQmDWkOho0o9ZGR4Yz5FT2ornPOxmnaXzF1wFcirQzSlzqcZ1+L9N59/6ddEgse4ImivCc
	h/g0vRBjHe/GxLL9CXT3pnbv5FNc+gHynszHaDZQFNAQ2/8oVRsQ/UzBCijfdt/1eVnLLg
	jeAmopyVcBKlmkgDTg/Cxt2GNC4BZ70=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1706004314; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hCbpUW79UBQklyQUgghM/5s8J/FybqEF+7dXOs7C6RM=;
	b=YQmDWkOho0o9ZGR4Yz5FT2ornPOxmnaXzF1wFcirQzSlzqcZ1+L9N59/6ddEgse4ImivCc
	h/g0vRBjHe/GxLL9CXT3pnbv5FNc+gHynszHaDZQFNAQ2/8oVRsQ/UzBCijfdt/1eVnLLg
	jeAmopyVcBKlmkgDTg/Cxt2GNC4BZ70=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 55E5013786;
	Tue, 23 Jan 2024 10:05:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id CuWXElqPr2WJEQAAD6G6ig
	(envelope-from <mhocko@suse.com>); Tue, 23 Jan 2024 10:05:14 +0000
Date: Tue, 23 Jan 2024 11:05:13 +0100
From: Michal Hocko <mhocko@suse.com>
To: Joakim Tjernlund <Joakim.Tjernlund@infinera.com>
Cc: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"david@redhat.com" <david@redhat.com>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"hannes@cmpxchg.org" <hannes@cmpxchg.org>,
	"mgorman@techsingularity.net" <mgorman@techsingularity.net>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"quic_pkondeti@quicinc.com" <quic_pkondeti@quicinc.com>,
	"vbabka@suse.cz" <vbabka@suse.cz>,
	"quic_charante@quicinc.com" <quic_charante@quicinc.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	"quic_cgoldswo@quicinc.com" <quic_cgoldswo@quicinc.com>
Subject: Re: [RESEND PATCH V2] mm: page_alloc: unreserve highatomic page
 blocks before oom
Message-ID: <Za-PWcwmHFl3wmth@tiehlicka>
References: <1700823445-27531-1-git-send-email-quic_charante@quicinc.com>
 <3fe3b3edd33cd784071dd9b459d20a79605ec918.camel@infinera.com>
 <2024012205-undrilled-those-2435@gregkh>
 <PH0PR10MB461565CEE892267025BC697BF4752@PH0PR10MB4615.namprd10.prod.outlook.com>
 <2024012210-outshoot-dragonish-fe8e@gregkh>
 <01010dd280badd149291cf4d2a4a88847113cf6d.camel@infinera.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01010dd280badd149291cf4d2a4a88847113cf6d.camel@infinera.com>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: 0.70
X-Spamd-Result: default: False [0.70 / 50.00];
	 TO_DN_EQ_ADDR_SOME(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 TO_DN_SOME(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 NEURAL_HAM_SHORT(-0.20)[-0.996];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-0.01)[45.75%];
	 ARC_NA(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 RCPT_COUNT_TWELVE(0.00)[13];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Flag: NO

On Mon 22-01-24 23:14:59, Joakim Tjernlund wrote:
> On Mon, 2024-01-22 at 15:04 -0800, Greg KH wrote:
[...]
> > For mm patches like this, that are not explicitly tagged by the
> > maintainers to be included in the stable tree, we need their ack to be
> > able to apply them based on their requests.  So can you get that for
> > this change and provide tested patches, we will be glad to queue them
> > up.
> 
> I asked the author and he acknowledged it could be backported. Charan, please chim in.

The patch itself is safe to backport but it would be great to here what
kind of problem you are trying to deal with. The issue fixed by this
patch is more on a corner case side than something that many users
should see. Could you share oom report you are seeing?
-- 
Michal Hocko
SUSE Labs

