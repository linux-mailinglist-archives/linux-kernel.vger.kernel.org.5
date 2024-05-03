Return-Path: <linux-kernel+bounces-167502-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CCBC48BAA7F
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 12:08:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 097441C22320
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 10:08:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 147E314F9FE;
	Fri,  3 May 2024 10:08:42 +0000 (UTC)
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D8AB1E493;
	Fri,  3 May 2024 10:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714730921; cv=none; b=IBWbeTZ/hCqVI94M70/hutp5TVgk4lSFZ8+9wHDykWAoi1OQkLI8pT8dN35sCPMaUEa6HQnaiHXua2pddtYWNHrBNuHXqk8PywTqsKoHzXLlOezZ2sSwZ0NLbP/XAI1q9o2fEdurhyr65TTcSVIXPeXDOg57kJ9PSFJOmc6kgDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714730921; c=relaxed/simple;
	bh=mhX5A1Y04AoRa49GFo8bG3cgSqc/Wl1fdNUEsXNzf4E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ka4fNzY3dA9i2L2U9zTnnJrH3Pi7VurpY74DyCGjBtufVy5k5ALSr4pifA2M8Pwg4/feVbQxBXzksUxZtJa8VlOI4/IOBRiV99/BO85H9AGBgsPvjoUxCAcujXmIBV6irj7ZAbWVwN0xF3MO3Ijb5Vy0Q2zehj6j76czXLbU4jI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a5544fd07easo1328280566b.0;
        Fri, 03 May 2024 03:08:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714730918; x=1715335718;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yMpYjlBazhzpHCwuPFitIuy7d7NQaAnw9Mgkl9WFu48=;
        b=dHhT1apQQNeFs5CrUTOQIBNszdKrHfDrGEbuN1rqMsPQLKuoyj6E67BdHJZXHHv/6A
         lSUclcYLA86xj4s8e9UJN+vlzHIA0Hl9KR1fQMpdt2PG9oyYRNeLNuQPEJzyPl4qfLD8
         ig3p7mOdl6FwcgCxuai3xtoC5Md7ayafA8z5eq4qvBRkl0tDbLuRkEb5qZv33JmNZFGn
         nsVuRmn1zrE7KwcDedX9A8SFATHE8w1j+xmcq7SIV21RKb2/IEHuHJptbGI4snhYJ6kI
         mrQt+664CQB3cYUgozZ+glKpb2uXYwM23hf7OEyb2BrYNoo0zuJZ2jD+Pv8bpS8FZqDA
         qXqw==
X-Forwarded-Encrypted: i=1; AJvYcCXqhRfd9ghDTOD5uMVVlFRDzAofyLmfz3eIVDFQzf7GPzdWEyNpeg9An5gnwgKMaoXiNNQR+vlvANUxJzjXgcnWs9bKl9toSrlB3+gunTld4oJKsoEZdLl6FV4+1lo5fMG7Bky0
X-Gm-Message-State: AOJu0YxMlYWczKI1Y8M92yj5Mwvi01RGv86pl0ypUw2fjl7UCcKIG8YT
	4jbGxB3WbZwTe8JSqGoO/PgKdJgy5YPSeghGuZ6DBMz9h4Za0ahD
X-Google-Smtp-Source: AGHT+IETjDqpksWA62sq7sJNDTlrF9Ntfcd1ZnPt4IqNIOgywKI/vxRfwiriTzx0HR71qpTupgT8ng==
X-Received: by 2002:a17:906:cb85:b0:a58:a721:3a61 with SMTP id mf5-20020a170906cb8500b00a58a7213a61mr1064303ejb.3.1714730918194;
        Fri, 03 May 2024 03:08:38 -0700 (PDT)
Received: from gmail.com (fwdproxy-lla-002.fbsv.net. [2a03:2880:30ff:2::face:b00c])
        by smtp.gmail.com with ESMTPSA id n1-20020a1709062bc100b00a522fb5587esm1564769ejg.144.2024.05.03.03.08.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 May 2024 03:08:37 -0700 (PDT)
Date: Fri, 3 May 2024 03:08:35 -0700
From: Breno Leitao <leitao@debian.org>
To: linux@treblig.org
Cc: 3chas3@gmail.com, linux-atm-general@lists.sourceforge.net,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] atm/fore200e: Delete unused 'fore200e_boards'
Message-ID: <ZjS3o+EUp2VwfqK9@gmail.com>
References: <20240503001822.183061-1-linux@treblig.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240503001822.183061-1-linux@treblig.org>

On Fri, May 03, 2024 at 01:18:22AM +0100, linux@treblig.org wrote:
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
> 
> This list looks like it's been unused since the OF conversion in
> 2008 in
> 
> commit 826b6cfcd5d4 ("fore200e: Convert over to pure OF driver.")
> 
> This also means we can remove the 'entry' member for the list.
> 
> Build tested only.
> 
> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>

Reviewed-by: Breno Leitao <leitao@debian.org>

