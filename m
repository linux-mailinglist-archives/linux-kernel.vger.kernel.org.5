Return-Path: <linux-kernel+bounces-92848-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A44048726D8
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 19:45:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FD6628AD8A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 18:45:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 564A91B597;
	Tue,  5 Mar 2024 18:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Vdu527ov";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Vdu527ov"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4082B18E28
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 18:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709664309; cv=none; b=V9KC9TiI3Xx761wufVXn/HwYF4V5D1VpBRtmN1TpKbk0LKN7Gfp0QfObWygT8IzCMLl+2hUZYaoNNZtnS62WUiqr04pkYEhOeBE7/z+Y8Ot9WKPCUx1AMoPgMkbA0IV902j4/22UdNjmJa01pgHz8yXrDtPWvJDLVhsGZRQnZm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709664309; c=relaxed/simple;
	bh=lye0DpAsC42d9XChxvMPpAQh0UmOMXRtj4qUbum2TdU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CXY6OtfMKD7YsnLLiEtNojmr0TWI+7c87gLvtxzZ/xN5ExS2IZZJx2MzjOZd/QVBL6Z4WoRuaLZFs9KwRDs+OPOJSW6YQvt9rDAziE6PWaROXvuvwCP2jPq/VtCzHhF9e377hRl83aW3x5Czhc8PA3SnV+i7qPqDYulg3ZT42aM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Vdu527ov; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Vdu527ov; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 548D2200F9;
	Tue,  5 Mar 2024 18:45:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1709664305; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ifIruBCyt4thzjRoYLGDg4K7N31QP9uhPhkn0R8tpmw=;
	b=Vdu527ovlhNeWMx6RazrucY4ZUalDPZ9E16lquLNFjaofi0w0yknpoajlcUwoDzDdUnuVa
	KwiIK8567wzvqLhR9u3wQ5HRrhHu3lc/Up6FtyRA8afimKCPxJ4KVsHjIPHofS/DYySBlo
	d/nqs2wjnFy9oZqqP1CuH3PxmMrtfCM=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1709664305; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ifIruBCyt4thzjRoYLGDg4K7N31QP9uhPhkn0R8tpmw=;
	b=Vdu527ovlhNeWMx6RazrucY4ZUalDPZ9E16lquLNFjaofi0w0yknpoajlcUwoDzDdUnuVa
	KwiIK8567wzvqLhR9u3wQ5HRrhHu3lc/Up6FtyRA8afimKCPxJ4KVsHjIPHofS/DYySBlo
	d/nqs2wjnFy9oZqqP1CuH3PxmMrtfCM=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3AF6D139D0;
	Tue,  5 Mar 2024 18:45:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id D5gDDDFo52XIIwAAD6G6ig
	(envelope-from <mhocko@suse.com>); Tue, 05 Mar 2024 18:45:05 +0000
Date: Tue, 5 Mar 2024 19:45:04 +0100
From: Michal Hocko <mhocko@suse.com>
To: cve@kernel.org, linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: CVE-2021-47090: mm/hwpoison: clear MF_COUNT_INCREASED before
 retrying get_any_page()
Message-ID: <ZedoMIyhF8d_XLIV@tiehlicka>
References: <2024030413-CVE-2021-47090-a429@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024030413-CVE-2021-47090-a429@gregkh>
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=Vdu527ov
X-Spamd-Result: default: False [-2.75 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[3];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 DKIM_TRACE(0.00)[suse.com:+];
	 MX_GOOD(-0.01)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-2.94)[99.73%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 548D2200F9
X-Spam-Level: 
X-Spam-Score: -2.75
X-Spam-Flag: NO

On Mon 04-03-24 19:11:17, Greg KH wrote:
> Description
> ===========
> 
> In the Linux kernel, the following vulnerability has been resolved:
> 
> mm/hwpoison: clear MF_COUNT_INCREASED before retrying get_any_page()

I would like to dispute this CVE. The interface is behind CAP_SYSADMIN
and allowing access to this to any untrusted party is risking serious
troubles. This is a testing only feature.

-- 
Michal Hocko
SUSE Labs

