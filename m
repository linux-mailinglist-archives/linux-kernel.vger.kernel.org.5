Return-Path: <linux-kernel+bounces-123395-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 330128907E4
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 19:03:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7BA41F265FA
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 18:03:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E39E131E4B;
	Thu, 28 Mar 2024 18:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KBYe1IuR"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CB3C130E4F;
	Thu, 28 Mar 2024 18:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711649008; cv=none; b=dyU/VtFhpOR92I+0KQCg0Wd0yrLoGh2OZ2Lh00BbRBDRqACe/k59VwlWrynUaPg4SnDoUD1tikfow0TEBMWka4EjP02Vy7OVsmtpoGqxker0EpIr5b6mUeg+ycnzxkIKLeVMqKp95SxELjQoK1+H7EDwo6+mjny2i4QuRp3cLaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711649008; c=relaxed/simple;
	bh=vB1K3UeOU2FvgT3cwFX6bIQzHZMdAnkhCLXgIqkAx/8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FbOw8XRr/uUoq1XyqT92TUGozdvUVjvrI5qDf8CSs/PkJstqeMw8gbiLTUn17hUIN02+6QKPlxBInFaumPLuEGpynWD4XGzWn2eedcUdjhsjoh3/NcQQ+mkiQWONBiTQaqkN4yBOHP6PFJORKq5BHeSIOp6OMFuxxF/qLu3Uki8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KBYe1IuR; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1e0189323b4so8952565ad.1;
        Thu, 28 Mar 2024 11:03:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711649007; x=1712253807; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=olSW0jWLIrC4vxY5yG21bb3i0NkpMQDJhW3rhvvrLzQ=;
        b=KBYe1IuROmE5QJaTzVoQaJKqamXjGV+ZoaZINvIedkFJbRxlJ/mqbvTh1ZCwQBq6J1
         eKgQi72FgBtA+MbOS8NsYACPBaML3XrszURM3eL0UO5e/wdMVGt08t3GlpbuAOeOZWf0
         tDGJRAJ2AVVIXJRaEiXZSr84rInmQxtYktX3PwhcB/JZBtcdFbtvpo3T6jRGxibfvlhK
         cFKiNTiS6OPpNAnwdgx3MXVP8CSCGlmr3HV16Tklx/ta0wHX3bs5h0xkYPkYVsY0tTOa
         1ebnNtjiXgUf47ieun1IFa8/11CCqgQphZaj1ixRo7tCtCxQ7JdUWJ+Z9CxDe8A2PFDX
         NnGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711649007; x=1712253807;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=olSW0jWLIrC4vxY5yG21bb3i0NkpMQDJhW3rhvvrLzQ=;
        b=Q8eoUXFNkIT4je707nOq0ez1AeV82JMetCUtwr6XaE3onEdyS3/+oZq6VOn/Kj2YWQ
         xzNkRLBc5i2uKjtY/VcdXnWlFgfdPlSiWSXFFbSxZNFsJZuLCIyfDCIkyd79D1Stbe2d
         VMcxSSSE9stv3Pz0kGh29B31l63G6HPjkxcNT8JhCwN/lcpihg32fPe5UNl07dcU+7km
         mgWqqcJh2X079ppDFEjdEgLU97UH/qAjSQsOIni0wuVLACbDl7WhaaQID8NGSWcO7Jc4
         eUtv0uYYbGAd2TJI5ehIgxOoC6soAAkLyL+aMHdpObWQHVBXr8VSUUctUJzuLsCzL1g8
         Ez2g==
X-Forwarded-Encrypted: i=1; AJvYcCXbzyQaPcO3Lp3AuGE2/093BgYKWEpochKA3214kbHkafMshD4X211+Hgfzssu96/UGsLvulQbPrmJe7vcHvqlhbTUAo3sq8E+THOOFIP6gcARjyT778rs3iISrKiZjerTXlkLQ3R5RBZG3nqFDULBhMXzQ5LLsa4z00mgqSGXlRGV7xnek4ijsGPOwnJnpsQiANsiBDI3L7NsS7ATIqb9oyWAwYB8F0Eh+0O0D9jNpjj+KiCp/vXVLGIZAug==
X-Gm-Message-State: AOJu0Yz26g/twb8fwv3x9KV41Zi/J4WF6cgovgebK6LknKetP8h/rbrM
	t/u9bUMTv93778apXMkl56rwXYISdKOK0402OzNrcxhmCnOLW8ZY
X-Google-Smtp-Source: AGHT+IEkQsFT2CQ41glFYLpP1d3wFQ1n1mHU48V+X330fVWYW26kggF6SGZ6JUFwxozMX9FKu+ROTw==
X-Received: by 2002:a17:902:ef48:b0:1e0:e2b1:7395 with SMTP id e8-20020a170902ef4800b001e0e2b17395mr283743plx.14.1711649006562;
        Thu, 28 Mar 2024 11:03:26 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:493e:82a3:49f9:d88])
        by smtp.gmail.com with ESMTPSA id mm8-20020a1709030a0800b001e12013ae07sm1901205plb.231.2024.03.28.11.03.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 11:03:26 -0700 (PDT)
Date: Thu, 28 Mar 2024 11:03:23 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Support Opensource <support.opensource@diasemi.com>,
	Cosmin Tanislav <cosmin.tanislav@analog.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Antoniu Miclaus <antoniu.miclaus@analog.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hwmon@vger.kernel.org, linux-iio@vger.kernel.org,
	linux-staging@lists.linux.dev, linux-input@vger.kernel.org
Subject: Re: [PATCH RFC 1/7] regulator: devres: add APIs for reference
 supplies
Message-ID: <ZgWw66OpLnLPdCn-@google.com>
References: <20240327-regulator-get-enable-get-votlage-v1-0-5f4517faa059@baylibre.com>
 <20240327-regulator-get-enable-get-votlage-v1-1-5f4517faa059@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240327-regulator-get-enable-get-votlage-v1-1-5f4517faa059@baylibre.com>

On Wed, Mar 27, 2024 at 06:18:50PM -0500, David Lechner wrote:
> A common use case for regulators is to supply a reference voltage to an
> analog input or output device. This adds two new devres APIs to get,
> enable, and get the voltage in a single call. This allows eliminating
> boilerplate code in drivers that use reference supplies in this way.
> 
> devm_regulator_get_enable_get_voltage() is intended for cases where the
> supply is required to provide an external reference voltage.
> 
> devm_regulator_get_optional_enable_get_voltage() is intended for cases
> where the supply is optional and device typically uses an internal
> reference voltage if the supply is not available.

So because we decided that we could not have devm_regulator_enable()
because of (IMO) contrived example of someone totally mixing up the devm
and non-devm APIs we now have to make more and more devm- variants
simply because we do not have access to the regulator structure with
devm_regulator_get_enable() and so all normal APIs are not available.

This is quite bad honestly. Mark, could we please reverse this
shortsighted decision and have normal devm_regulator_enable() operating
on a regulator?

Thanks.

-- 
Dmitry

