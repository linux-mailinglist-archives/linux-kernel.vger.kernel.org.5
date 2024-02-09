Return-Path: <linux-kernel+bounces-59260-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 060E784F414
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 12:02:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5B8728A20F
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 11:02:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0923128DC9;
	Fri,  9 Feb 2024 11:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="V/9zbXJ9";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="W/CSpT8S";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="V/9zbXJ9";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="W/CSpT8S"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5D5320332;
	Fri,  9 Feb 2024 11:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707476555; cv=none; b=ESL/pqXXCrVA3NHAPjL9YpIbFlVAAV/zKZebRL0IIRndYpDsLU8HZwK8mt7v3L8K61RSRHmn5aq0X9q7eCaPOj9y4B/6LrxXjzHk4dn0QA1Iqu6rypKB7BV4mcYtBPql3p0FBvB2ZroKXW/Bgp4iPtVve7b4L2djVJHrRBGgpo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707476555; c=relaxed/simple;
	bh=DYL2Vo7wXZo44LWPSiZJxteFaz2Bsb/d2g1o9IIqOik=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MMap17bd87HEIksxXYmjohUrkYjcpL2u8zmR/O8e3S/tPxhYIsDUoFac5v5DIBi1kk5RzvQbWjy64FndA7+56wSwYWdfUZzp0vrXyELCnip3X8l3pC2bRRe2xmpx3YRE95GU8TKt6aCZPIm5w0ZAW7FGRCi+akaaKve8uJPzZjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=V/9zbXJ9; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=W/CSpT8S; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=V/9zbXJ9; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=W/CSpT8S; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id CD71C1FD32;
	Fri,  9 Feb 2024 11:02:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707476551; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5zQwm5kPigELiJNBBb9hvLn79vg8BzIewehmXpsozFI=;
	b=V/9zbXJ9ahmqdhj3d/guoVKUJNMAwhxR5fBRCqxWSwO+m9z1l5126BwbhI0x4jy3GjWggO
	4xCcSrHi8rOLslSG4tR3Af2xPqspGT/oyWLALcgTUcSC5XCi32CuYVM4cDgjaj/LgYuRd1
	Fo1U0kTOJD5d1gHtOkrwVliwrSLeet4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707476551;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5zQwm5kPigELiJNBBb9hvLn79vg8BzIewehmXpsozFI=;
	b=W/CSpT8SMhOtfjNq/AoNqGM6+Is88NEcwU2+ottuiG4PdFTjaF8A234VY0NaFfEZZ2D/Fi
	EP1eGUP2PYwE50BA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707476551; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5zQwm5kPigELiJNBBb9hvLn79vg8BzIewehmXpsozFI=;
	b=V/9zbXJ9ahmqdhj3d/guoVKUJNMAwhxR5fBRCqxWSwO+m9z1l5126BwbhI0x4jy3GjWggO
	4xCcSrHi8rOLslSG4tR3Af2xPqspGT/oyWLALcgTUcSC5XCi32CuYVM4cDgjaj/LgYuRd1
	Fo1U0kTOJD5d1gHtOkrwVliwrSLeet4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707476551;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5zQwm5kPigELiJNBBb9hvLn79vg8BzIewehmXpsozFI=;
	b=W/CSpT8SMhOtfjNq/AoNqGM6+Is88NEcwU2+ottuiG4PdFTjaF8A234VY0NaFfEZZ2D/Fi
	EP1eGUP2PYwE50BA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2F6361326D;
	Fri,  9 Feb 2024 11:02:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 1iklCkcGxmVoLwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Fri, 09 Feb 2024 11:02:31 +0000
Date: Fri, 09 Feb 2024 12:02:30 +0100
Message-ID: <87plx5294p.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Wesley Cheng <quic_wcheng@quicinc.com>
Cc: <srinivas.kandagatla@linaro.org>,
	<mathias.nyman@intel.com>,
	<perex@perex.cz>,
	<conor+dt@kernel.org>,
	<corbet@lwn.net>,
	<lgirdwood@gmail.com>,
	<andersson@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>,
	<gregkh@linuxfoundation.org>,
	<Thinh.Nguyen@synopsys.com>,
	<broonie@kernel.org>,
	<bgoswami@quicinc.com>,
	<tiwai@suse.com>,
	<robh+dt@kernel.org>,
	<konrad.dybcio@linaro.org>,
	<linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>,
	<linux-sound@vger.kernel.org>,
	<linux-usb@vger.kernel.org>,
	<linux-arm-msm@vger.kernel.org>,
	<linux-doc@vger.kernel.org>,
	<alsa-devel@alsa-project.org>
Subject: Re: [PATCH v14 45/53] ASoC: usb: Create SOC USB SND jack kcontrol
In-Reply-To: <20240208231406.27397-46-quic_wcheng@quicinc.com>
References: <20240208231406.27397-1-quic_wcheng@quicinc.com>
	<20240208231406.27397-46-quic_wcheng@quicinc.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -0.16
X-Spamd-Result: default: False [-0.16 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 BAYES_HAM(-1.36)[90.57%];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[dt];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 R_RATELIMIT(0.00)[to_ip_from(RLjs3ec4aura4kmsd6wxjjm4hg)];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_TWELVE(0.00)[23];
	 MID_CONTAINS_FROM(1.00)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[linaro.org,intel.com,perex.cz,kernel.org,lwn.net,gmail.com,linuxfoundation.org,synopsys.com,quicinc.com,suse.com,vger.kernel.org,alsa-project.org];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Flag: NO

On Fri, 09 Feb 2024 00:13:58 +0100,
Wesley Cheng wrote:
> 
> Expose API for creation of a jack control for notifying of available
> devices that are plugged in/discovered, and that support offloading.  This
> allows for control names to be standardized across implementations of USB
> audio offloading.
> 
> Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>

Again, use a more intuitive control element name.


thanks,

Takashi

