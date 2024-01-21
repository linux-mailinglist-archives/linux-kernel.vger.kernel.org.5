Return-Path: <linux-kernel+bounces-31965-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14E31835477
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 06:13:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E8598B2198D
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 05:13:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD10636132;
	Sun, 21 Jan 2024 05:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WMdqzx3j"
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97DEA125D5;
	Sun, 21 Jan 2024 05:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705813978; cv=none; b=usHannDFN5aztLJ838zTuWrHIlqXoan5sDyATOq1Zm5vJGAisOtjF+zgeqWRz9JWzT3ZjVqNGTSrCOzSQJkWqiEf9hEuTu8TlubKslAKGL8nDubBfhC6DgZ3GYK/OB7mh0vDE9sUh7EbY34ZN+xt8ddWDlegLjnaxE5j5G8lygM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705813978; c=relaxed/simple;
	bh=mQOJsuXd23AShkPMtF+epCUjAeTRLskXisXs5N1GcX4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fqBsazBKVeCJn2rdbT3M6QPfxpy33u/Dm5fB4cMfKPCFvUNy6COfLqXT3O4im9VB5zu4y5WR5B+obBpfEZMoZxMC0hfifszTjnbXK2j9eJsQCnmCY9y9fyc4Ezr13i10D2vsQbOWH8wS62Dj7HC2iz7gQmZe8vXfGHGQEbH3+t8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WMdqzx3j; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7831389c7daso203874985a.2;
        Sat, 20 Jan 2024 21:12:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705813975; x=1706418775; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/Wp8poTTbfuGxBjgvA7+dH/hoiaU34wutNBSdFFLmWg=;
        b=WMdqzx3jjADd7d+Kb35WggYOUnIYlXuSc1JcTfe2nPx9tctNBOcke2tH2my74gasLm
         YSlCagQ6Ji8f248yu/04/1hQgZSa4qBG9ZVnYWQIrmEBguDnGF1t7JRKwlQhVFuVDYVx
         Tnh+8vZTHVryCKaXu9q4iq9VFWyp2MDBvr0eiOTE3g/ym8eP/s1DoGtjGue0hiuCJ0uK
         OXdiZGOeKmJPXn89OdJDqnK+p1AXUvyluTlYMfRE4nXpw6k+JSgJDRx+jjltS9+L4nic
         V7E/DmOs3fCiQkO5RNYV1P6KkWsyisyFvluqC14nbSzikA773FyXx7BFTfLn7b8WQwvD
         D6Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705813975; x=1706418775;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/Wp8poTTbfuGxBjgvA7+dH/hoiaU34wutNBSdFFLmWg=;
        b=hU6/qJDlZRwP8JZwQ6m2doTZYAI+rJ8cSt39QB5UvE+gfUSB1eWf6hKDYU0Es6neVL
         MI+0WpO0rTMVkVS6ogVTTVlyJ0utl5o74jgWLabDwPuaM9bCNbBsF1tsr64HpmCSjhme
         vTjMNP0zh7oAdHzs5UtF8WkMw4fiqlcPiHNkLrrWEMZ5hcS3KzZCTfKnbpOaAJEyrS7s
         uvLDqJvlS43ev7Y/TLDvYS6YM6aoVAldFS+j5xdpnRZ54scNAWs+85Qx8zR0fEJQ7Xev
         JckQtWYTCiEobJl/Tw2KyNKwJbo7ca1plcojbR6lxbfDC65bWXA596OL7XIfS/a5UH/i
         mzHg==
X-Gm-Message-State: AOJu0Yyj3uyhX7l5IulpEG/G/v4AZPbZ4LzUcu7h8HTfC7weqPOUV36K
	dBwPCKx6aXHpKQZ9saOADlZf9ntOm+pQ8c1WlpHcHWvbjTmJbg3SvvydQPtL
X-Google-Smtp-Source: AGHT+IGHPPNEhj5kLU4qXLxnUNeSJomQCUQ/1gbWqrC/sFhv/QJSLElbwgCdFTtG7TW7kaMcVzhRbg==
X-Received: by 2002:a92:b706:0:b0:361:98cc:594a with SMTP id k6-20020a92b706000000b0036198cc594amr3467846ili.79.1705813496193;
        Sat, 20 Jan 2024 21:04:56 -0800 (PST)
Received: from google.com ([2620:15c:9d:2:b227:ab83:6b35:c967])
        by smtp.gmail.com with ESMTPSA id e12-20020a170902ed8c00b001d5f0daff2bsm5265363plj.59.2024.01.20.21.04.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Jan 2024 21:04:55 -0800 (PST)
Date: Sat, 20 Jan 2024 21:04:52 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
	Jeff LaBundy <jeff@labundy.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Rob Herring <robh@kernel.org>
Subject: Re: [PATCH RESEND v2] dt-bindings: input: touchscreen: goodix:
 clarify irq-gpios misleading text
Message-ID: <Zayl9KC53pFWk5_Q@google.com>
References: <20240102081934.11293-1-luca.ceresoli@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240102081934.11293-1-luca.ceresoli@bootlin.com>

On Tue, Jan 02, 2024 at 09:19:34AM +0100, Luca Ceresoli wrote:
> The irq-gpios description misleading, apparently saying that driving the
> IRQ GPIO resets the device, which is even more puzzling as there is a reset
> GPIO as well.
> 
> In reality the IRQ pin can be driven during the reset sequence to configure
> the client address, as it becomes clear after checking both the datasheet
> and the driver code. Improve the text to clarify that.
> 
> Also rephrase to remove reference to the driver, which is not appropriate
> in the bindings.
> 
> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
> Acked-by: Rob Herring <robh@kernel.org>
> Reviewed-by: Jeff LaBundy <jeff@labundy.com>

Applied, thank you.

-- 
Dmitry

