Return-Path: <linux-kernel+bounces-30907-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 90E8E8325CA
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 09:33:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 84907B21DE7
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 08:33:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61D1D1E535;
	Fri, 19 Jan 2024 08:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nl15M8by"
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89ABC6FAF;
	Fri, 19 Jan 2024 08:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705653193; cv=none; b=fOUdJ/7MgID9KBEYZp5LNl1kNNBRKqbA87NJhE6q1WIFV4zMDL1SGLi/7jo3c/dprz0mmDkTRortcwW7IIeBkXg34cu5QMBrNoTILuUIASbKW0sxNP4RHy5LPB88UneAp9FmIOCIoGtJt24y156jXcS2GffFJ0XlNrOck9b31ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705653193; c=relaxed/simple;
	bh=x02Zo5TozJwZXVhDVOAjl++1b8WJv2tMgyiiGfUiNuE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W44n0dUFLcLQK6hFJYPhtXnZuyUZWpqldhJ1oMgAikqCRjrXcaIbOQIKaC9EV8UPtHDQjUO9HYVFHM/fnpLf9+4p1WTNntAHhpp6zy4MvPGvGv6Dq2sld4lKERUqall1dKrTiFfOXZz5dRqPbxKNLAYd0Uh0ZbeX0uSkZoMDins=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nl15M8by; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-5ce9555d42eso479286a12.2;
        Fri, 19 Jan 2024 00:33:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705653192; x=1706257992; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oidjO/sPb4t2zA83y5SntDis2KFVgG2FFB5B51Ra0EQ=;
        b=Nl15M8byzMVm1zQONaqcpfWyayD+lU7sj+7mqfG9ZH0n7UQE/9RNtkfE79h/eIcEgx
         Z/SbDxmUDDJJo0ArXu9QArORaXr3EboYdFJVi9LMvF9gv0T0xR3NGKWF46AWZg09qY2s
         EvBtT9qO+nr5Utd2sdp1idtpmv5XSWmlV/VrJAH4nTUvQkHflXH21SwsJGep9BmF98xj
         tTBckXKvP3+zd0oH16TVN8e/bUb5cb6nXU3eKBAY6xWAar5PF8qdPCQdvHa2/M9bUhqg
         DlS1Htkzr0xfDxWD20AqV4mjmFaBzD9krRmBbGIMKj5L/gIHO0o2CmOVT4nfxAklmic3
         TMVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705653192; x=1706257992;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oidjO/sPb4t2zA83y5SntDis2KFVgG2FFB5B51Ra0EQ=;
        b=q3bneg69hhAs6eJaCFl4AYhfqDHXRzwW4Ez6NV3jQPPyNMqQgCEW4MDAtAaLipdIAL
         JqKp6TI0IhGw+sdfZKgR4NDLx7OsUlZ/A0WZfgwy8grWeREL9ZIKUUUFBtLmNtPnXk6i
         Le4ROzooLTWTpftrop1tQ4YvgbeWwypSbJResZXT27qFHxfCOsZBa5KvF9b7zFrRCwyd
         VDIi4GLXJbmu3Z8X1y8MKslp1Vrq+m7LMaj44rtltdiPD+i6/IULvdLlI4Ef1Bxs0yI6
         NgYWxsOV5Sjwwzn3dnLX+puNaAamYZ1K4gGAmvvSfhNcacHA+zVEAwb9kOVGBl1Zt/Ss
         KjUQ==
X-Gm-Message-State: AOJu0Yzbm7a2wPjgLzmhRkCw2mADFMcKgWE1Kwq5loEMZEHkvOTVKiGs
	y5Wg0/ZoPP5sxKKZYjNha4AjN2NYy2d1l4RaTEFCVgjbTgVYyZup
X-Google-Smtp-Source: AGHT+IHJNgm020XLP4RRk82IlLsGAK0OfkZGDf3m5KrEq8DDKjRmUREQeWSNBeiXlWie69//8el1qw==
X-Received: by 2002:a05:6a20:3950:b0:19b:5b1c:a36e with SMTP id r16-20020a056a20395000b0019b5b1ca36emr2591577pzg.119.1705653191732;
        Fri, 19 Jan 2024 00:33:11 -0800 (PST)
Received: from google.com ([2620:15c:9d:2:f04f:73f4:b79:a70c])
        by smtp.gmail.com with ESMTPSA id fh35-20020a056a00392300b006da1d9f4adcsm4557586pfb.127.2024.01.19.00.33.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jan 2024 00:33:11 -0800 (PST)
Date: Fri, 19 Jan 2024 00:33:08 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-input@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: input: silead,gsl1680: do not override
 firmware-name $ref
Message-ID: <ZaozxDuUf1p5OhUB@google.com>
References: <20240115182057.1610195-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240115182057.1610195-1-krzysztof.kozlowski@linaro.org>

On Mon, Jan 15, 2024 at 07:20:57PM +0100, Krzysztof Kozlowski wrote:
> dtschema package defines firmware-name as string-array, so individual
> bindings should not make it a string but instead just narrow the number
> of expected firmware file names.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Applied, thank you.

-- 
Dmitry

