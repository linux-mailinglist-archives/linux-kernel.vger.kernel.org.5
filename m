Return-Path: <linux-kernel+bounces-104854-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6F1C87D492
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 20:45:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF3A11C21BB0
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 19:45:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9CD152F97;
	Fri, 15 Mar 2024 19:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h7pancyN"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 644F93A28B;
	Fri, 15 Mar 2024 19:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710531950; cv=none; b=giupAplda8hj36WvbSUNI+ts4M9p0Tn97Dv77x1dNZodr5CCENibZD90LZCNSVLjqL49iY2wEWSuzTMpYKpZdsujLTwfymDBUR5i8Cb5m9o7PKNZEtAV4vA7EuC1l6PmLXLUDAbyvYsxQe9yUaGGH4vAV28Ro4uoq3w6FSoV/bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710531950; c=relaxed/simple;
	bh=2u/C8aOZXdXL/b7f7wq6/lnCWQkIGXoxDZ4FHukuK00=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vDnhOuowo3hBtSeGAeE2fmuyl6ePJILSRVN43lWVxFMdvA9tTr6kEg5M+MP2WqYtfKeLjxpNQxHyENknPcuhV641SYHf0d1rNJNu8EOBTL/5Dv8InlVOL57i5OBlmXSD3Y844ahVHVhoht5wKnm79dhp6ZEV9BOu96TFJtjuVhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h7pancyN; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1dddb160a37so18382375ad.2;
        Fri, 15 Mar 2024 12:45:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710531947; x=1711136747; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JHIHZMcAvUSB3NwhXGN0zV7BH8xLrGFQUkZhkrV6No4=;
        b=h7pancyN+/Bq3/nXybWS5M8eljkn8YKPx824rKBgmW79XZW+BvW7zdZ8YmRXIBDsuH
         ctzzv+i28TixH2wYWOMY/l+Ut7UDKUVa1E3UHu88GUqcEn3fkMBEb0Y4rMCKqyo2cMt3
         /8DFKJN02QJLVxiytOoH++iJvO7XYIJ//ZviAhYqGxVDk5K+DtWOqEGIb4uAULYqy0Px
         +Ka61+3vGejtmZ+yBGSewBC1w9n6tMUt3oywu7plwrH2BRktYuaTJIAC3MDADKwk7hRH
         WvG5xbbF3Sd5o0yxmah8FInkXDMZBxY4l/TWICvrsyrQ7G3Sp9YjYw/WfwauFqXeTAld
         34Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710531947; x=1711136747;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JHIHZMcAvUSB3NwhXGN0zV7BH8xLrGFQUkZhkrV6No4=;
        b=Mt5WcC1oJr/Fz4adCebfU0YXLGcctaG5At/noieDyg9kQ7IOm62iZvBh/oD9RopPTI
         iLfwqfePhNTyslly+Nq/ET4s3njAsf54V7rhjGSn+HOIxGXr09SlrYHthE9YbqvFKlkS
         l533KKlpgISGnUe4osSWBSuBl9qAOHHqtHOHm//sawzZKAvnubWR7srLFU9OXuuzOt/T
         M3g1uybRkWRcE8Kj4+qnd2mcFBezbf409cZq/XHTwKZ6kxPygX7TRHjN888F5yDUDjNf
         AjFlALigMMfbwFj47HcXA2PjRUZMV/tJvGsWcWlB1Pq35wecR0raCuKAvZ3HtYmoV0XL
         OK4A==
X-Forwarded-Encrypted: i=1; AJvYcCVbB+Lgd6/mb7b8a/fNmxt//XWIeEgGT25v8ikux+25QVdJv/BduKFCmziGFAfkpVHaWVQXSapXSml01fgoMhzp6FfGpRjKp+v1AGoxGBrJ0UZJPEhe2ew4kL9qdolOm6FBFp805S8vB/6IGjkGN+sxosqJ9VXMCFSuPRaFyBZt1BJO5dwu
X-Gm-Message-State: AOJu0YxNcXqLrzMryHyix2AbQUiy9i9eE9NV+YS8dPxSItSSnEvr2fEI
	SY/XMmmWR27QmNCsdKqW4MvuRuZ1k55XkASA6zwpDb/LIkPA94ay
X-Google-Smtp-Source: AGHT+IEh9J9qriykborC9cvtdg6jW2uH5rLRO8ZUYqFCt+o0BxFOMwJd6ftZuQCtvP4mywMSUd08ow==
X-Received: by 2002:a17:903:1c8:b0:1dd:e0a1:3cf2 with SMTP id e8-20020a17090301c800b001dde0a13cf2mr7666676plh.16.1710531946622;
        Fri, 15 Mar 2024 12:45:46 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:c446:74f0:5cd2:d078])
        by smtp.gmail.com with ESMTPSA id t12-20020a170902bc4c00b001dd72cbedc4sm4220775plz.218.2024.03.15.12.45.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Mar 2024 12:45:46 -0700 (PDT)
Date: Fri, 15 Mar 2024 12:45:43 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-input@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: input: samsung,s3c6410-keypad: convert to
 DT Schema
Message-ID: <ZfSlZ18hHHeafmmp@google.com>
References: <20240312183001.714626-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240312183001.714626-1-krzysztof.kozlowski@linaro.org>

On Tue, Mar 12, 2024 at 07:30:01PM +0100, Krzysztof Kozlowski wrote:
> Convert Samsung SoC Keypad bindings to DT schema with changes:
> 1. Rename "linux,keypad-no-autorepeat" property to
>    "linux,input-no-autorepeat", because the latter was implemented in
>    the Linux driver.
> 2. Add clocks and clock-names, already used by DTS and the Linux driver.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Applied, thank you.

-- 
Dmitry

