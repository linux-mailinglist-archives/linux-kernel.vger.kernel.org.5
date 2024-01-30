Return-Path: <linux-kernel+bounces-45402-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 860F3842FBC
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 23:32:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8C9B1C21558
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 22:32:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D42779941;
	Tue, 30 Jan 2024 22:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oz8t5h00"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0694B7866A;
	Tue, 30 Jan 2024 22:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706653947; cv=none; b=tuaWgHXkMyGfM15cTNI5etd55ahqZwpanh09YdnORkdyLeoHHcOgqMGcKm/1xi1MMTMTO9CIP3XFW1N1DGEjYmumjaZ5G+2OASVGgLoIccpeRFuzFwvJBtf4NC/IQTAGzGOnx6sEKuq66OdbBq3nA3gOVDUbFWKKjIOLE5bok5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706653947; c=relaxed/simple;
	bh=3JIOZ13F04bYjY3n9eEAQmLaX0QN3tAJ0w2x2SGciug=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AD0CP45YP/Zn7IXLbxVZhZFupO017gtekVghcV6i18feiJTU1eiVbS04n54sd1vYHgMAH5C8PBbFfoB7VSDchhm1r4SZNBfyyJLuRJcxR1hz3EW/V8fyeY9FfnXfYFVPtAXW3PDIFUprTiXkAZezod2H7FLUUy5kfT0DkO1NWmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Oz8t5h00; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1d7431e702dso31969295ad.1;
        Tue, 30 Jan 2024 14:32:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706653945; x=1707258745; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JAB2kkVVtLto1O0phcXvL9Nli468Klpnx1Dh/SQOK10=;
        b=Oz8t5h00Y2wRqYqLs9BcaZtAPAwhbWzL0Lmwk/flPJpaAo7tk905wOwi3ht1tAKKpC
         vN78l+kRVeWHm3+ieCyMNxe0JCMd5MKKabcNrW6R4FDXPd10Kv2+g+pTLL5NADOEAEPl
         sDz8OmovObfxqVdcAQfeblSiHKQr/+lBUgEhsgdb3IIEHl4BsuNTb2PxVV7WRI0QiXYO
         K60cGfH/fto+jfTx4Av+Zlsb699SFiWM6d/Kd/bb1sVzJ7/3uRASQLTbSafAyZ30tqM3
         pMciXNPdElA7QybUDpYJpLI1HBPC9Aauir/I/trBLBqLiWfBLz+oNs9GIdonFbeajl1T
         f+cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706653945; x=1707258745;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JAB2kkVVtLto1O0phcXvL9Nli468Klpnx1Dh/SQOK10=;
        b=J+byJbLwybIjW3SUzuPQIxxn55K3BpAPWM9vnXGpp4ZySn61XD7XHOTZjWFWFSKYcp
         U5Lht01dB9KuHW6FX7Va8LT/tBAHoyR4SgFjuRYmQYFjn+kfmGBF23dGG3If4SUtmoZ0
         RUy6aIJuRJzOjCb3YdSFjR2FOMpghP2RfCKWRibuMWvVoeCbO5YxNiv5ZcQ6iCoISjS/
         msb5el3492bxqAbPk16w5olEGzuBRMvTGTN3eCFzOv8NC7UbGWgFOmZaJ4sRt0gVz5BS
         uUfl0yW4H5cY20/jKyyMZ+999R8+xPpowqAXEJugBmuMdsG5n94ytMKeSHgHSHiMNkWF
         yKeQ==
X-Gm-Message-State: AOJu0Yyhb6ahA8RHBtuInN/+RJ6dcTOZsxfppP7K5DR3uM1x1sdugg8l
	FQqXbfJou7fenBBh+1+DULdPKZHuGd03PcwsFQ7sbI4acPAU0no/rYf8uq/2
X-Google-Smtp-Source: AGHT+IHio4lYEpw285b/K45D5Mn4X9d6W7i0wVkxRpjiduy2r9GWUlbCG6xz5wBKi+9NE3XwhImWjQ==
X-Received: by 2002:a17:903:2301:b0:1d8:f827:d9d2 with SMTP id d1-20020a170903230100b001d8f827d9d2mr4889287plh.23.1706653944935;
        Tue, 30 Jan 2024 14:32:24 -0800 (PST)
Received: from google.com ([2620:15c:9d:2:955e:133f:54ba:f642])
        by smtp.gmail.com with ESMTPSA id x15-20020a1709027c0f00b001d717e644e2sm7647661pll.247.2024.01.30.14.32.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 14:32:24 -0800 (PST)
Date: Tue, 30 Jan 2024 14:32:21 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Brenton Simpson <appsforartists@google.com>
Cc: Vicki Pfau <vi@endrift.com>, Hans de Goede <hdegoede@redhat.com>,
	Cameron Gutman <aicommander@gmail.com>,
	Erica Taylor <rickytaylor26@gmail.com>,
	Ismael Ferreras Morezuelas <swyterzone@gmail.com>,
	Jonathan Frederick <doublej472@gmail.com>,
	Matthias Benkmann <matthias.benkmann@gmail.com>,
	Matthias Berndt <matthias_berndt@gmx.de>, nate@yocom.org,
	Sam Lantinga <slouken@libsdl.org>, linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org, trivial@kernel.org
Subject: Re: [PATCH] Input: xpad - add Lenovo Legion Go controllers
Message-ID: <Zbl49VAMZx2qrz-p@google.com>
References: <CAAL3-=88exVfuL1Y-kvPNbsU+d-UTfDLFViWVObFLtbC4xueeA@mail.gmail.com>
 <20240118183546.418064-1-appsforartists@google.com>
 <da6f1483-1ae2-40b5-9c1e-684321e12288@endrift.com>
 <CAAL3-=-RRWyCbq_B=Lh7tnG2i3MOLL+2bqPOUS54oTC4+vVk_g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAL3-=-RRWyCbq_B=Lh7tnG2i3MOLL+2bqPOUS54oTC4+vVk_g@mail.gmail.com>

Hi Brenton,

On Fri, Jan 19, 2024 at 12:22:45AM -0800, Brenton Simpson wrote:
> Thanks Vicki.  I didn't realize they were meant to be sorted.

Please try avoid top posting.

> 
> Would it be appropriate to add comments explaining the sorting?  The
> second stanza, in particular, is sorted by the IDs rather than
> lexicographically.  If someone sorted it naively, they'd end up with a
> bigger diff than expected.

Yes, we usually sort by VID/PID rather than the name of the device.

> 
> It looks like a few others have escaped sorting; for instance,
> "Microsoft X-Box One Elite 2 pad" appears in the wrong place.

Yep, sometimes we mess up.

> 
> If Dmitry wants to land this and then follow on with a sort + comment
> commit (or do that first and then rebase this on top), that would be
> great.  I can take a stab too if that's helpful.

I applied the patch (moving the entires to the right place). If someone
would send a patch fixing the Elite 2 entry and noting the sorting rules
I'd be happy to apply it.

Thanks.

-- 
Dmitry

