Return-Path: <linux-kernel+bounces-110030-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CD34885913
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 13:27:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FFFC1C21BFF
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 12:27:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7B6B762C6;
	Thu, 21 Mar 2024 12:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ECbi3uxl";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="RNmT1Du+";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="byVF52Rr";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="X4r3nGBb"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23F9176038
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 12:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711024046; cv=none; b=Qj9k8iuFvkPsj+W2UrxHSIv0eajkyiCbVQCUisT0ie5XW/4TgnDOBp6S3UlMiLt2/ZW1h0+v/S9/SrjrLYk+EntKDU7cHbgb0Q+TW2V9K3M9GKA9tWjDmsW3s0IrSeneRC+iDqCqHDfXwKMgJ45AnUnVS8DSsN2KMi1FZQTscT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711024046; c=relaxed/simple;
	bh=r/vkhsrtDC4BozCRHETcAE+rtg6KEBigqx5R+DSn+yw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PAzXDitfOsOaBzfi+wKys6Mv93ohgA/ABgVvpUh2HK3N2g4NrmZ1qxTFVQutlnNt1F86rjbif//9ZzbYrCHrG600RYaDtWdAO1E6ZeMQ3lKhS9M3rE7ZNO5mzz+bFAmuc5uj+it1ny/pAYnmtdbTsLYSwga3sYPjJrZ4R7d/dx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ECbi3uxl; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=RNmT1Du+; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=byVF52Rr; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=X4r3nGBb; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id DF18F5CE09;
	Thu, 21 Mar 2024 12:27:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1711024043; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YBhWND0ryss6lCSKLM4pcKLq3Gj0T65ZOOAL7ikG1uc=;
	b=ECbi3uxlh5b2BX89WIOgb+NT/qs3X/YnVy8/S4+JzSXIL80nhr5zOx9Qf/WBMFthdICbIY
	xZ4CMxtlZKXVBxUf/tUmHDtEdmEikrU53Hv4PTc48nrEmHDcZze3ltpDZShS5TkyewGTgn
	hTd0AxF0570Yl1Nt0SvqYujmYC04LDA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1711024043;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YBhWND0ryss6lCSKLM4pcKLq3Gj0T65ZOOAL7ikG1uc=;
	b=RNmT1Du+NH69R2tTvcdfbvDl0G0turNP3tOce5F4UBjG1+qzVRh6SO5mWrD8EroKdHjfDr
	I5Xf2H9KFAOSBDBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1711024042; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YBhWND0ryss6lCSKLM4pcKLq3Gj0T65ZOOAL7ikG1uc=;
	b=byVF52Rrow4hPfbf7lXYsOtmJaqDjpMl767JhZzkRsfOigv3eII3pPvE3iQnXtk56USQg7
	3PMUW1Ve52NSbutG9CLreO69yLap6O0AX+M2L1J7IykoMLhUHR+26ZbIm/crINmzjsLEpV
	8aLTu1bukPsiKConDuJraYVQHhIzfLY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1711024042;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YBhWND0ryss6lCSKLM4pcKLq3Gj0T65ZOOAL7ikG1uc=;
	b=X4r3nGBbZ3noekWI6+d6J/kjRzYGkAJaEBHfDPysIJ+qtheWexgw9IoHgLOA/yB+RLYW+8
	GA74UNTlpltY92Dw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6C3BB13976;
	Thu, 21 Mar 2024 12:27:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id N6+iE6on/GUzRgAAD6G6ig
	(envelope-from <jdelvare@suse.de>); Thu, 21 Mar 2024 12:27:22 +0000
Date: Thu, 21 Mar 2024 13:27:18 +0100
From: Jean Delvare <jdelvare@suse.de>
To: Sean Rhodes <sean@starlabs.systems>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dmi: Adjust the format of EC versions to match edk2 and
 Windows
Message-ID: <20240321132718.59d1ad36@endymion.delvare>
In-Reply-To: <a2b3d8253c5915619cd70ff884e1b57e4b0bbead.1708700494.git.sean@starlabs.systems>
References: <a2b3d8253c5915619cd70ff884e1b57e4b0bbead.1708700494.git.sean@starlabs.systems>
Organization: SUSE Linux
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.34; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=byVF52Rr;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=X4r3nGBb
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-5.51 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 HAS_ORG_HEADER(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 RCPT_COUNT_TWO(0.00)[2];
	 DWL_DNSWL_LOW(-1.00)[suse.de:dkim];
	 MX_GOOD(-0.01)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Score: -5.51
X-Rspamd-Queue-Id: DF18F5CE09
X-Spam-Flag: NO

Hi Sean,

On Fri, 23 Feb 2024 15:01:58 +0000, Sean Rhodes wrote:
> Currently, Linux displays the raw bytes for EC firmware versions, which can
> lead to confusion due to formatting mismatches with other platforms like edk2
> and Windows.
> 
> These platforms format EC versions as `%d.%02d`, ensuring that the minor
> version is zero-padded to two digits. This discrepancy becomes particularly
> noticeable with version numbers where the minor version could be
> misinterpreted, such as interpreting `1.02` as `1.2`, which does not clearly
> distinguish it from `1.20`.

Software version strings are not mathematical numbers. The use of a dot
between the major and minor version numbers is only a convention, and
as a matter of fact, versions with more than 2 fields (and thus more
than 1 dot) are frequently used. Therefore, nobody with even basic
knowledge about software should think that versions "1.2" and "1.20"
are the same.

Padding the minor version number with a leading 0 is indeed seen
sometimes, but I can't see a major trend in that direction. This is
essentially a vendor habit, and even then, not all vendors are
consistent in doing or not doing it.

> To align Linux's presentation of EC firmware versions with these platforms
> and to minimize confusion, this commit adjusts the format to `%d.%02d`,
> matching the convention used by edk2 and Windows.

It turns out that the Linux (and dmidecode [1]) representation matches
the SMBIOS specification [2]. See in particular Chapter 7 (Structure
definitions), section 7.1 (BIOS Information (Type 0)), description of
field 17h (Embedded Controller Firmware Minor Release) :

"(...) for example, the value is 16h for revision 10.22 and 01h for
revision 2.1."

As you can see, the example given in the specification itself is
"revision 2.1", not "revision 2.01". So I would question why Linux and
dmidecode would have to align on edk2 and Windows and not the other way
around.

[1] https://savannah.nongnu.org/projects/dmidecode/
[2] https://www.dmtf.org/standards/smbios

Technical review follows for completeness (but I do not intend to
accept the change anyway).

> Cc: Jean Delvare <jdelvare@suse.com>
> Signed-off-by: Sean Rhodes <sean@starlabs.systems>
> ---
>  drivers/firmware/dmi-id.c | 20 ++++++++++++++------
>  1 file changed, 14 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/firmware/dmi-id.c b/drivers/firmware/dmi-id.c
> index 5f3a3e913d28..5bb921c4f62d 100644
> --- a/drivers/firmware/dmi-id.c
> +++ b/drivers/firmware/dmi-id.c
> @@ -114,12 +114,20 @@ static ssize_t get_modalias(char *buffer, size_t buffer_size)
>  		if (!c)
>  			continue;
>  
> -		t = kmalloc(strlen(c) + 1, GFP_KERNEL);
> -		if (!t)
> -			break;
> -		ascii_filter(t, c);
> -		l = scnprintf(p, left, ":%s%s", f->prefix, t);
> -		kfree(t);
> +		if (f->field == DMI_EC_FIRMWARE_RELEASE) {
> +			int major, minor;
> +			if (sscanf(c, "%d.%d", &major, &minor) == 2)
> +				l = scnprintf(p, left, ":%s%d.%02d", f->prefix, major, minor);
> +			else
> +				l = scnprintf(p, left, ":%s%s", f->prefix, c);
> +		} else {
> +			t = kmalloc(strlen(c) + 1, GFP_KERNEL);
> +			if (!t)
> +				break;
> +			ascii_filter(t, c);
> +			l = scnprintf(p, left, ":%s%s", f->prefix, t);
> +			kfree(t);
> +		}
>  
>  		p += l;
>  		left -= l;

The implementation is technically poor. Having to resort to scanf to
parse a string which we have encoded ourselves from fields which
contained exactly the numbers we need, is quite inefficient.

Furthermore, it adds more inconsistency than it intends to solve, as it
only enforces the padding of the minor EC firmware version in the
modalias string. This would make this field inconsistent with the
ec_firmware_release sysfs attribute, and would also create inconsistency
with the and the "br" modalias field (BIOS release) which does not get
the same zero-padding.

-- 
Jean Delvare
SUSE L3 Support

