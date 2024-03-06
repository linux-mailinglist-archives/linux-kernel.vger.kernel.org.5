Return-Path: <linux-kernel+bounces-93461-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00BCD873030
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 09:06:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC292287E0F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 08:06:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 444D05C8F9;
	Wed,  6 Mar 2024 08:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="uMaM97xM";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="uMaM97xM"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C51DF5CDDC
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 08:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709712406; cv=none; b=Y8i/UkXPj9zHr3AkO5lrHXFJSlXHXy0+eNVAJrNo1wQE06Zb1MddpU5LV5J8xjNRMzoxGid88pKUcoCxKoAh0+xfexDcbbc5FhbL/cS/to6P5GcT24BtzQWhVCb2ZVgRTQsiiB5v561VqoE8pnxbeHG5C05ogSLG9KOVPoQw+q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709712406; c=relaxed/simple;
	bh=MqQXZ9imZCuItatNwAjp9sOkRK9vVNm4gr2kYvZTvn0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HLfzjgM95P2wWIjeqCeLJKX5Pi2zqp1ZnFYj6whSYVVhrUVok0svgwxLvK0r81N/z5wCSjdn2B8I9ZPziUaGableYkdgnMTX+fa9V9UJD1QFKkOBOr2GWBdJX0CUfFem/TWmfTGJVyMAuueN5dPbsQlqE2rpncKpaJcG/v2/cKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=uMaM97xM; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=uMaM97xM; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 09AC46732A;
	Wed,  6 Mar 2024 08:06:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1709712403; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xJyqNxLf+jZXOXYD+8fg3XBfC72ZeiyXKr8oxT9zAQk=;
	b=uMaM97xMyVH5AQI463diHs9G6GIX6zVf53LthBxh2ifNA6xCxBpYaEii2NAFISC/QB2m5X
	/6pKPiTZZHa3fC9DgHnriuOg750S82tmsrU/M9R/PeP3ZeIGdHo05QLx+VlVO/ewVsCe58
	C9stWHUMpgAqY5UHNTNuQiJZZXNYqD8=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1709712403; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xJyqNxLf+jZXOXYD+8fg3XBfC72ZeiyXKr8oxT9zAQk=;
	b=uMaM97xMyVH5AQI463diHs9G6GIX6zVf53LthBxh2ifNA6xCxBpYaEii2NAFISC/QB2m5X
	/6pKPiTZZHa3fC9DgHnriuOg750S82tmsrU/M9R/PeP3ZeIGdHo05QLx+VlVO/ewVsCe58
	C9stWHUMpgAqY5UHNTNuQiJZZXNYqD8=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E72AB13AAD;
	Wed,  6 Mar 2024 08:06:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id MI9qNRIk6GUqZAAAD6G6ig
	(envelope-from <mhocko@suse.com>); Wed, 06 Mar 2024 08:06:42 +0000
Date: Wed, 6 Mar 2024 09:06:42 +0100
From: Michal Hocko <mhocko@suse.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: cve@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: CVE-2021-47090: mm/hwpoison: clear MF_COUNT_INCREASED before
 retrying get_any_page()
Message-ID: <ZegkEqtGcC1p_7Xb@tiehlicka>
References: <2024030413-CVE-2021-47090-a429@gregkh>
 <ZedoMIyhF8d_XLIV@tiehlicka>
 <2024030541-unhappily-staff-8662@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024030541-unhappily-staff-8662@gregkh>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-2.60 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[3];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -2.60

On Tue 05-03-24 22:20:17, Greg KH wrote:
> On Tue, Mar 05, 2024 at 07:45:04PM +0100, Michal Hocko wrote:
> > On Mon 04-03-24 19:11:17, Greg KH wrote:
> > > Description
> > > ===========
> > > 
> > > In the Linux kernel, the following vulnerability has been resolved:
> > > 
> > > mm/hwpoison: clear MF_COUNT_INCREASED before retrying get_any_page()
> > 
> > I would like to dispute this CVE. The interface is behind CAP_SYSADMIN
> > and allowing access to this to any untrusted party is risking serious
> > troubles. This is a testing only feature.
> 
> This fixes a weakness in the kernel, one that is allowed to crash it,
> why isn't that a good thing to have a CVE entry for?  Are we saying that
> all VM_BUG_ON_PAGE() instances should not be accounted for?  That's not
> what the config option for CONFIG_DEBUG_VM says, it just says it will
> affect performance.

I wouldn't personaly recommend anybody using CONFIG_DEBUG_VM=y in
production. But I am not questioning if somebody does that. This is
not really what I am objecting to. Hwpoisoning or soft offlining is not
aimed for other than testing purposes. Things can go wrong during
these oprations.

If you insist this still qualifies as a vulnaribility/weakness fix then
I would propose a new category pig-with-a-lipstick-CVE.

> Also /sys/devices/system/memory/soft_offline_page doesn't say "can crash
> the system", so it should work properly, even if an admin uses it, it
> shouldn't shut the box down.

I agree that Documentation/ABI/testing/sysfs-memory-page-offline would
benefit from an update. Documentation/admin-guide/mm/memory-hotplug.rst
is explicit about this being a testing feature.
-- 
Michal Hocko
SUSE Labs

