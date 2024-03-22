Return-Path: <linux-kernel+bounces-112047-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FC84887491
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 22:48:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4EB4D1C210EE
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 21:48:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E2848062D;
	Fri, 22 Mar 2024 21:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ifxMvzu1"
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7485960B91
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 21:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711144096; cv=none; b=Byoowz1yOIpxEIwyR//fyKeZvlaOqOQO+03oIjqR8/JyNZtGxOriocwNW5OMGdsxfcQ/4r+QTXdE7ND9uBwq5vFYoKj4Oig4rr3meUOmny07CPddZhE5EDc4heuiRHTXmY2TGdoSujDoN6hkuIB9B/sLF0rCBMwS1mCGfmE5WnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711144096; c=relaxed/simple;
	bh=r2JygysBSznEYrREqtBGYtwD29MF8jgYZVNy9hfOPrA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KfnA4QNws/1I1++RHnEFjGknJqX+ZXC3yRxf5Oub5Sxv78HoMKQpKrXmM2jyvyUyiHOD7wmj7o2YXdMWpqOCnDKLD/42zozpnhjF0AHrKZYg0B8TAQTvEf6at6Nb7fQLcT5iMWCtAyE6+p2Vr6AUI66vCI7FH7uEB5S/7W+r9n0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ifxMvzu1; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-36864f7c5cdso9206155ab.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 14:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711144093; x=1711748893; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Qwc2S1fB5ESIk5rQRrelB9J3ow8t5FCTnSuALstuIMg=;
        b=ifxMvzu1WkyAZFlPDR9q0b0DRF8bQeixL2JY88Y4L2eNKu3lSGwkDGamZeji41h8ZB
         yLZ9flnKZzgl/fhX7qsYPDbZmGtpQ+MlMH6drDX3K0AcAoAPkRjeCBtOlBCsRQW/bcIY
         MTjrjqLrH1qfAMrRzB7LThLNn1F4AhQcfLDaLKKVApGka98StBsqL21w+wD3hlonJYJv
         UruT5JU+1mEESZCWiyhSMyNj0pxbEpk9Cn2aOYWSHF7hci95JUkrGeL/cjRQDC/aA2Io
         uEarlIUVGS8jRvIX9si+ZDD6pnVahBfk37XRtt8O/P1iRPszAbSAzF+kR44h08+OmtqS
         vKSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711144093; x=1711748893;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qwc2S1fB5ESIk5rQRrelB9J3ow8t5FCTnSuALstuIMg=;
        b=SfYVR2jUCfvfhOp7SfxedX8ir7tViHI1RwlQPHduBiZa0wL6HSGOGwW13hzzN09fwL
         2iP5471aDuALiV8drLw7gILZTKinRKJHlMhxEj/+7a73sHemtMTFjSey8ACFnZxyiYd4
         0Bw6JGgJfcd/ytKA/N1lg9Fgph4JA/Z6y0BdEQbZ9K5QMzaeYLwj5lYvEvPacfF3jlqB
         sRXhNQrm0v2Eepg1P4YFuRACCVHMiweGZwqJeilgM4jFCN5tK+rTnxaWHE8vZPKGoUB+
         QbrW0LRrIFus+LOowVRn240H+XJiMLEMYZWhRIr/oCNPoE9uuo8H1a0v0IeraTGoyyQV
         g3jA==
X-Gm-Message-State: AOJu0YwDF5t5NyRKD3EluH/ecaJtA42G/v0hJdP+t6iO+8qswASSnV4D
	jrSoyYrFvQmP4z/vtJ/ocRok6lwzmIqegI7Qvyddz3U61PkcJ0UCOAnoMj44
X-Google-Smtp-Source: AGHT+IHv7JzzyKtLaB1Mfa2ZTimFOraoyUonWxUYUTMXvDQ9b4TQIAPKoFP1agrZeRwgZN5yr0YWEw==
X-Received: by 2002:a05:6a20:3ca3:b0:1a3:a933:a9c7 with SMTP id b35-20020a056a203ca300b001a3a933a9c7mr1157474pzj.6.1711143677836;
        Fri, 22 Mar 2024 14:41:17 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id gl3-20020a17090b120300b00298cc4c56cdsm5977617pjb.22.2024.03.22.14.41.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Mar 2024 14:41:17 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Fri, 22 Mar 2024 14:41:16 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [patch 2/4] x86/topology: Dont evaluate logical IDs during early
 boot
Message-ID: <3e8c08e0-dbfe-42b8-9668-bdcaac9eef4f@roeck-us.net>
References: <20240322184944.141421692@linutronix.de>
 <20240322185305.186943142@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240322185305.186943142@linutronix.de>

On Fri, Mar 22, 2024 at 07:56:36PM +0100, Thomas Gleixner wrote:
> The local APICs have not yet been enumerated so the logical ID evaluation
> from the topology bitmaps does not work and would return an error code.
> 
> Skip the evaluation during the early boot CPUID evaluation and only apply
> it on the final run.
> 
> Fixes: 380414be78bf ("x86/cpu/topology: Use topology logical mapping mechanism")
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Tested-by: Guenter Roeck <linux@roeck-us.net>

Guenter

