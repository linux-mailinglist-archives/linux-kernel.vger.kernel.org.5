Return-Path: <linux-kernel+bounces-130397-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EEAE4897786
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 19:57:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8D2728DC31
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 17:57:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEC8E153591;
	Wed,  3 Apr 2024 17:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Uz6aO2El";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="K5PuXrV4"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F4631C33;
	Wed,  3 Apr 2024 17:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712166944; cv=none; b=rCmzZj4FkAGoqIb3JzBaLWy/VFD3/eXFNa2IlvHpu6lSy6UP87neW2Vr3vVCZK5sT3fzXjJeeh+dnDQMxSV4WWfXIoGuxzRJ/A8QujPTnoxMqNFgWCSGp5LAP55h0xVtRdiu+hSXd8u88ZM88fIM4rWyeQH6/g7TYJyS3POFOG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712166944; c=relaxed/simple;
	bh=UVpatiKVwhxLWX8puZya+ICdNXhPi/+rGPkrIR89hYE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p2/y9vZr92GlBYsfsKwWKbJ0tkGH57xIWKwKbkQVFU2oxM2AV6L+Jkd8z3neVf2XbdTx9PjS/VmaKLRbjnO5n1utwoP7sAjf3TC/uxLpM4gwzd6706NsnyN/tEQBn3+e4n/sTRzJQ8eYZUzpZ4t269s1FIKOM8Uq/T0xXXivB5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Uz6aO2El; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=K5PuXrV4; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3D6373738F;
	Wed,  3 Apr 2024 17:55:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1712166938;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3uqlK5tXRDv3ca7TX0f01adWVqFvHQM/F9oaiZDI7WU=;
	b=Uz6aO2Els/Bd6BydT4d/H4yDZW/jMs7o0dqb4xJTFCMDHtTkVBSKZ6is/AOBVLEJSRaA1X
	C4h0KcbzLxXrXmV0QbafHjPXmzJEf0BURIkx5Am/6e3wCn5wfWb891n4JQgX2Erf4n8QYH
	SOe+Ayw+rj3BNr5gTe41XPYWhRbiBUg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1712166938;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3uqlK5tXRDv3ca7TX0f01adWVqFvHQM/F9oaiZDI7WU=;
	b=K5PuXrV4xP1HKiHsbvq3HpjavqCgWFNm93Dyw0Bn980te9dmAPBRAiLeMt07IX/BXhFPNe
	S3+u7utXKCozqEDA==
Authentication-Results: smtp-out1.suse.de;
	dkim=none
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id CA59F1331E;
	Wed,  3 Apr 2024 17:55:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id 0VT/JxeYDWYiIwAAn2gu4w
	(envelope-from <pvorel@suse.cz>); Wed, 03 Apr 2024 17:55:35 +0000
Date: Wed, 3 Apr 2024 19:55:33 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Rob Herring <robh@kernel.org>
Cc: Alexander Reimelt <alexander.reimelt@posteo.de>,
	konrad.dybcio@linaro.org, devicetree@vger.kernel.org,
	andersson@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, linux-arm-msm@vger.kernel.org,
	robh+dt@kernel.org, linux-kernel@vger.kernel.org,
	Petr Vorel <petr.vorel@gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: arm: qcom: Add LG G4 (h815)
Message-ID: <20240403175533.GA462665@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20240403104415.30636-1-alexander.reimelt@posteo.de>
 <20240403104415.30636-2-alexander.reimelt@posteo.de>
 <171216461463.4018435.3466905061314737419.robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <171216461463.4018435.3466905061314737419.robh@kernel.org>
X-Spam-Score: 1.40
X-Spam-Flag: NO
X-Spamd-Bar: +
X-Spamd-Result: default: False [1.40 / 50.00];
	 HAS_REPLYTO(0.30)[pvorel@suse.cz];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	 TO_DN_SOME(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 MX_GOOD(-0.01)[];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_SEVEN(0.00)[11];
	 FROM_EQ_ENVFROM(0.00)[];
	 R_DKIM_NA(2.20)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-0.29)[74.68%];
	 ARC_NA(0.00)[];
	 REPLYTO_EQ_FROM(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 TAGGED_RCPT(0.00)[dt];
	 MIME_GOOD(-0.10)[text/plain];
	 TO_MATCH_ENVRCPT_SOME(0.00)[];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[posteo.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 MID_RHS_NOT_FQDN(0.50)[];
	 FREEMAIL_CC(0.00)[posteo.de,linaro.org,vger.kernel.org,kernel.org,gmail.com];
	 RCVD_TLS_ALL(0.00)[];
	 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:98:from]
X-Spam-Level: *
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 3D6373738F

Hi all,

> On Wed, 03 Apr 2024 10:43:29 +0000, Alexander Reimelt wrote:
> > International variant of the LG G4 from 2015.

> > Signed-off-by: Alexander Reimelt <alexander.reimelt@posteo.de>
> > ---
> >  Documentation/devicetree/bindings/arm/qcom.yaml | 1 +
> >  1 file changed, 1 insertion(+)


> Acked-by: Rob Herring <robh@kernel.org>

Reviewed-by: Petr Vorel <petr.vorel@gmail.com>

Kind regards,
Petr

