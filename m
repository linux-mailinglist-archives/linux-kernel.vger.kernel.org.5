Return-Path: <linux-kernel+bounces-52118-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A33CE849450
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 08:19:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6B141C23220
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 07:19:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 493DB11700;
	Mon,  5 Feb 2024 07:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QWLJ9THn"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4553F1118D;
	Mon,  5 Feb 2024 07:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707117542; cv=none; b=uO0HdgRluuIIyMVdVQ3gh4+w68x5nX9pyk7enjoeAyLqbi18V2hzjfn/8BkWy/qeDBWUL88prz6pzL5sjxJ5DC4cIgfAj3ch6xlVgEL8PK2xFuwp1tE20Sa2m6haSi4/g4etBfQc9gakroueyn0xBEahI3OSCvNzU2AdIc18dtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707117542; c=relaxed/simple;
	bh=6Q9FAuK999aVUWr++MZ8IARkp2Q2Bxgj4j4ZB6Vd88U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UmSbV9+uexPDeHl57Z5PoexsCydjVyvlgCL1OPZ2b9W1RBrqKPkhtOhFyyPOyn6VehQWIQXTUJsEqyofrj+JFm/SC59M1kfnPcO7BW8mfGI1W8ZUXp02W6nVlUraGXvvmeY6i5JQm9XEwlGq4lmAyAs48GL7Uxi8OvSUzE9aTtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QWLJ9THn; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1d918008b99so30098895ad.3;
        Sun, 04 Feb 2024 23:19:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707117540; x=1707722340; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tRc4akgOpOwlwT4cBYDrRpwQQ9jaqVcrSCEEImQCS8g=;
        b=QWLJ9THn/Psdfg7vBpJK4KGIZGl4aX7u+swIJn9kOBHq5H2m/WYcTLmYzcr1cute51
         QnKfEUorKcb3U3DLE3q7fghB/Oo640zycR1AHy96ZzuTtwy+EXTYQ8GZOaOhE8JEY8vq
         RE9dj642FadZZ9y/DAtzUzSP04d4p6xaReayICkwVAJR3cJGvsFb6hU8AC6bm5xsakmP
         /s24Rf/5znmr0+N/+ZVHTSFOiy80si15vP83YAVQwxHN5h4lai10diOIwkzdmHjYdTIa
         pAF8NOd5xnKDMGDZ3UUtBqu8LKZAIIorzEzWef1rb6NphDPpHLn3t550q/sUmMYANU2m
         iffw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707117540; x=1707722340;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tRc4akgOpOwlwT4cBYDrRpwQQ9jaqVcrSCEEImQCS8g=;
        b=wawQ74KThJzmzV/3XMi3u/tUzD1Fn9W4nY/Knocp1KadiVe8MaEIovKBp2lC/9obqw
         kdBO1RGK0zy8SeIyrgTrC69CKPkyBIbkCThe1ro4k9hEdOIwC6URNDo6BymkP5e1IPtW
         4xQEPdJIfsw4Y4wg2DJb1wDtjBFAFsXVHsmIsFtuc4onjgDDZR/DoTCoNZAJLCsNFZUY
         unekv4QzEmC1k3pzu8B6723H/2WfcF6HosPBLewDevk3bWCOL9t+BuQQOAxzW1tyrZaX
         2gWjEA396caZgVgKXupkzI0WAPANHXPVrCOzCuZZqkQLN61vdgOkkQhEQlISgei/iFxA
         sKAQ==
X-Gm-Message-State: AOJu0YyDvw5KIDyhmV6V9neFC3VtZGB7kzmAknbXHlOz2zCOkxdeNJv5
	XVrsqM+CpviCQ4wJ0UUdSyiCGPmZvnEO2lD6gk0Az0dlClowV3cW
X-Google-Smtp-Source: AGHT+IETgI5m/w2xEtVGSLzqssRG/OmseyYM3n6OJtf1nctDX4OSzOdeAPC90KEo3Pn2QYRpinYKlg==
X-Received: by 2002:a17:902:eb92:b0:1d9:7046:fbcd with SMTP id q18-20020a170902eb9200b001d97046fbcdmr8040808plg.3.1707117540558;
        Sun, 04 Feb 2024 23:19:00 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWS3PZGLLU/LDrL7hZG9semER1/jng5pvV9UYNyq81NsZGDHZ6bWOzpl9ohUV5psMYts9qgKQseBXNgcd2pKPO2n2BFfL2bMelzGzUCKpTzs70MBOfJf6CyWFTWOWpzIE7LxlX/gN9vkGrkYvrQ2ETIazvueeFyd6yBRXMF8TXzdm4Fc0WeWGYJLHHw7rJpGthOZQELYEFlDhtDWLaan+ysfvsFwFVr07lZiT4wOgrNzznr5g02JLHwUxVQkPSMYRmVuHH8zfHie8YahbYT+jGucDU+vVpgXNH6zkshn3owEghuNSfHlXVYwKLLgdX+k6liSgQHEgkT3LxA6jBPRlptr21hCJ9sHgEp0P4tSGTlMkRj/R9xN75SxTScSEjRANkEOgv3MTY+ZM1N4ZcsR+xGgLwFZhFau7fyl0VXopHxdSSXmE0u5OvYEKX0SCjVh2B4TZV+l1mr
Received: from t480 (144.34.186.27.16clouds.com. [144.34.186.27])
        by smtp.gmail.com with ESMTPSA id v3-20020a170902b7c300b001d99530e3eesm2960693plz.282.2024.02.04.23.18.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Feb 2024 23:18:59 -0800 (PST)
Date: Mon, 5 Feb 2024 15:18:54 +0800
From: Shawn Guo <shawn.gsc@gmail.com>
To: Mathieu Othacehe <othacehe@gnu.org>
Cc: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>, Li Yang <leoyang.li@nxp.com>,
	Stefan Wahren <wahrenst@gmx.net>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v7 0/2] Add Variscite VAR-SOM-MX93 support
Message-ID: <ZcCL3vG2JwDkU8Aq@t480>
References: <20240108110241.8555-1-othacehe@gnu.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240108110241.8555-1-othacehe@gnu.org>

On Mon, Jan 08, 2024 at 12:02:39PM +0100, Mathieu Othacehe wrote:
> Mathieu Othacehe (2):
>   dt-bindings: arm: fsl: Add VAR-SOM-MX93 with Symphony
>   arm64: dts: imx93-var-som: Add Variscite VAR-SOM-MX93

Applied both, thanks!

