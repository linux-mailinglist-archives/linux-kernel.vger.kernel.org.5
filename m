Return-Path: <linux-kernel+bounces-61810-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BEE708516D1
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 15:16:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1B7E1C215B3
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 14:16:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A3E23B287;
	Mon, 12 Feb 2024 14:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PaSZUKx+"
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B0063B18A
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 14:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707747284; cv=none; b=Xjn/yPAxEaaAgAHYrVyeogJjgv1yd2HURmI7JNi0Nf4SLwkSl4dop6SbQXh7pwxTRBNFLk1LVgWtBsFmA5O7sMHeyyXa5BGWfnbNHhO0Az4t9YieexpAHqkPP6P/RT3cLbROicUG535AD3YGIYdKr4Nrw1T25asTImLgQZoXkwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707747284; c=relaxed/simple;
	bh=gVicl3RswclgeVVuPEpB5nW5Ga4M/HMFlfdw+YVH3cI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Uwx1u6cYDgyImBOdQLsH/DbJqNfDsHf93Jietty1Z7R4KN9M0MAhne8iiJP1nAhkyDYuloPAmmPOpGGy132gW8R1gOROXmLlM3auyg6/2WJqmHuXFx9aGjftRuYK+XGjIwKOuQ0Z5as7GEOfMp/vtfrmQTnJadUUSAvOTbKkqhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PaSZUKx+; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-5ce9555d42eso2524635a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 06:14:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707747282; x=1708352082; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UjO3tmeDqSfXjMSar0lNGn5BmL/XIyPFGpdugjnb3SQ=;
        b=PaSZUKx+H4oSzZfLKbzQfrubOcbPnC+DIlFQz3Z3bsiio1DU56+iMHJShUWWr5U3S3
         Nl9ynmp7+l8UXWMc1pAn0XpyaebeiakcBdUpuwRrH1NwsTWGoAri6AfcM9DBlc9tvJlL
         fKhYlSdOw+VQfoffHCBSF8zCRbekLrggOlIQACgCtYIQ4zskhDNzZ7Z4Bk3Hd6cEMS1c
         DQmFrllJLzQVKqubMNv2kht1sPa06WU8533+rnLs2mgcwdfrnqRCeqOE4fJmNfZxVe2j
         CfDS40xTkmFyZ/OaD/1b23FDXkH5C1Pugl3PC+2lUdi/GK4HFM1mOGWbw378b5WcwYhc
         lSww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707747282; x=1708352082;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UjO3tmeDqSfXjMSar0lNGn5BmL/XIyPFGpdugjnb3SQ=;
        b=AGde9CnXdcbElPbTwBMeTr6JtUnsdd6Qq2K7r0+l5EkJ6MHPhy7aUdDiHQKc4qXDw8
         WHTxyXTqmHgU5WcEMhvoA2vxOJQsdSS4DTevSazXcNohysWoRxswt34PNv9VZN6obY0Z
         LJtrHjqSeiYALP/wnl0pRZJ4up7iDg2nPepuqOn7F+EIRa1CRc9FafAHaatUxcG5N9Tc
         0Nl8fa/PZa8mgAh1TugzMqfOP3utbR6IgH4skDslG7z/iI0LbmDYEZ/V9BV+3Dfayb96
         qCBWWk64dQ6TnmZkltTPoWQ4j7fYdsMO578yef9QS+kxUM/7kCauixoYIQnzynBP3pI8
         xiTw==
X-Forwarded-Encrypted: i=1; AJvYcCUFm6F8Wbpnb3fca0PmNIR4QcDnpL4lGjSd5ahBXCgHD9Sro7cZJgawerjBE9zD1FmxOBTQxs265ykj75SgeoWblsNnT85Z2p9l63yw
X-Gm-Message-State: AOJu0YxqesdyMllSesNvC5CTKpA1MpvnR91jryg5zBd3vnulwDI+qKvb
	nh/tLkWx4diHUhTxOt3cfXutTVYl7qN/aq7QgX+fjmlYlWR+AWCb
X-Google-Smtp-Source: AGHT+IHBPE2IUt1n597gx69KZ1vfZj7edkTdGiIKU/JprqQfv1zIY5dT8AxSWKci98MkPQvxjNOSlQ==
X-Received: by 2002:a05:6a20:d386:b0:19e:b8a2:6572 with SMTP id iq6-20020a056a20d38600b0019eb8a26572mr7963308pzb.6.1707747282214;
        Mon, 12 Feb 2024 06:14:42 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXAD+AY0eEshXcWFUlP5w1JXzY85s65WDZ+Dg3eNOBZTv+VZzaie2Bk/0Hw2ftL7KRj/ouIgYblUWtbdVygDxuuZu2p7efBxTH4+rMExGb5VAEEV6MVgKHK2cCpkGYWDW1c245fyvFtv0khXwXHSH/gIcTeYzp3mWiGKLFoxDC79x5yJfh8VwkJJjZJ/pPOb1yaXUOp3ZrYcz+bVaKgrqm1D70RjhC+Rzk=
Received: from five231003 ([2405:201:c006:31f8:4630:e95b:8a0d:b0d0])
        by smtp.gmail.com with ESMTPSA id bm6-20020a056a00320600b006e054704c7dsm5560815pfb.123.2024.02.12.06.14.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 06:14:41 -0800 (PST)
Date: Mon, 12 Feb 2024 19:44:36 +0530
From: Kousik Sanagavarapu <five231003@gmail.com>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH] gpu: drm: display: indent fix in comment
Message-ID: <ZconzKCU8CST45KF@five231003>
References: <20240124183659.511731-1-five231003@gmail.com>
 <ZcTxUDb3_Xtqk8uW@five231003>
 <7b17f021-cff8-4110-ac8f-c8f635263293@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7b17f021-cff8-4110-ac8f-c8f635263293@infradead.org>

On Sat, Feb 10, 2024 at 10:49:50PM -0800, Randy Dunlap wrote:
> 
> 
> On 2/8/24 07:20, Kousik Sanagavarapu wrote:
> > On Thu, Jan 25, 2024 at 12:05:56AM +0530, Kousik Sanagavarapu wrote:
> >> The comments explaining the function "drm_dp_mst_atom_check_mgr()" had
> >> uneven indentation which made "make htmldocs" complain:
> >>
> >> 	Documentation/gpu/drm-kms-helpers:296:
> >> 	./drivers/gpu/drm/display/drm_dp_mst_topology.c:5496:
> >> 	ERROR: Unexpected indentation.
> >>
> >> 	Documentation/gpu/drm-kms-helpers:296:
> >> 	./drivers/gpu/drm/display/drm_dp_mst_topology.c:5500:
> >> 	WARNING: Block quote ends without a blank line; unexpected unindent.
> >>
> >> Fix this by getting the indent right.
> >>
> >> Signed-off-by: Kousik Sanagavarapu <five231003@gmail.com>
> >> -- 
> > 
> > Ping again.
> > 
> > Thanks
> 
> Hi,
> This seems to be fixed by commit 1a84c213146a.

Makes sense.  Sorry for the noise.

> If you don't agree, please explain.
> Thanks.
> 
> -- 
> #Randy

