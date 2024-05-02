Return-Path: <linux-kernel+bounces-166602-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A7BD98B9CE2
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 16:53:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D70C51C22EBB
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 14:53:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9973D153BD3;
	Thu,  2 May 2024 14:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E4Mdz8AG"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9928E64CFC;
	Thu,  2 May 2024 14:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714661591; cv=none; b=XBIMJ56KT/h/VFb4yRiY6q6oA4uOYAvx8Bhc2dUTTdKwxSdjPboi3r9X9/yiClvk7N7cA3HLUdWTflAqfKiweblXqhuln4QfpSPZvo+3XTtsJmL9BOv7z42Jqn23Cny+1NW9yXhDLP98PNS7bLPc/DU0BkQzGFNRt2cAkSnQT+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714661591; c=relaxed/simple;
	bh=FF8pGx2dc2VHiYDV2eOwyg5Y9rGCqFzWeMGJrclJdV8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=luvm5WCSzkaJB/N8m0rso+qWkB6P//a/PBvAs8SpBNxlMxmc1eZ7o1oc4424KJCQVPrf0pe4rZaMsjGHYqUgvkmdxd1GERK3dzHPQb2nf1TRerm/hmS4rehK0/5sUkdIwNIVzIyrZ4GDVi0H93jrvdnT5CBRpd2wS8niyUMrWOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E4Mdz8AG; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6f3e3d789cdso5715962b3a.1;
        Thu, 02 May 2024 07:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714661590; x=1715266390; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:fro:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jCOWJIVfBcfY82OF9T/y3rT+6DOMii/cJscVtNS5GEQ=;
        b=E4Mdz8AGrnYqypCIu4r6J6tKhy4oTHhBaneZbz0JRX7f81AYNDJzOA6bI2IvHr6U/1
         GwXTkK/ZheVgoVUxFPaRpjLobinweMD5an8vuM6MhCgr+Y0ibzcJsM7kcvfZ8Y0EMvI3
         0T3heV+H1WOhvaZ2Fhfhj6HfAaKqyXO0L7VWCILpiNPxQM9kF81Elqt2aqBR75YOeJgR
         Og5Qv978aq3IebVViOBQVypczJuZrillWDLe6YGnCBMds5tGSuGBFjbqUHmfY4rrYUhq
         AlwhF+HKBkx4a/JtAM9YhZT+ZUtHPc+oIJWN09uLWXcka65L9J/1WW8Nc0GkCAF/MR98
         96Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714661590; x=1715266390;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:fro:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jCOWJIVfBcfY82OF9T/y3rT+6DOMii/cJscVtNS5GEQ=;
        b=d6O4E4lY5WidJI2E+YjXxNKlpOeA1ZamEtj7Lqsvvp6ZHXeEs0es9G4fqtzTQO1HGh
         R9p07+eWtJmRiZVeDOLMRAoMx8H+RmZrkKN71EC+ow7hYwD8KT9bFAWh8iyKWoYQVBCQ
         7v90apDyR6eTV7ul/460Abb4+LePQnnjzBvWXGN2hfhOy8c2y6h85qhu2C7zZ9GUMJZ4
         xTkwbEKLKlYZ+jjvgQsgCIWj9jaNCOptNhvct3hfCQQNdcSa8V9uHFryBzAuqpWSBYW1
         0xG3F7iUMv33CHfJvJAbR3ZABwM+4djfsR40o2aNmANfvx3fA9MGGhr1MGdvslzvjkxe
         Ijzw==
X-Forwarded-Encrypted: i=1; AJvYcCXdzESG7czGl8LUfAdE+dScyQQT8bmih7vgnJUS5BuTduygUrJzkcg9favYJaag31QDy+cLp2jq3wsMdbnQsgpnSgqGn/huAHAKgcHkX2nrv2Vn0neU0+Bzys9uryEBE4wrYj5WTvJq
X-Gm-Message-State: AOJu0Yy/21nrryzKRNKUnqAzNZxtXqz75p7LK0eXFEeA/WdQQ9w06+40
	crbtd9c6H3Im1bZd3mlwAdx0l+vK8SHco7ps6d9U/khfsmD3uX5kqapDgP0M
X-Google-Smtp-Source: AGHT+IEf1VjqnsKtnij6yS611bfK2RwYScjpoAkUWveSbz7Xzjj0VYoEaWw8Bwto3HGnS7cpGs9qMw==
X-Received: by 2002:a05:6a00:93a3:b0:6ea:749c:7849 with SMTP id ka35-20020a056a0093a300b006ea749c7849mr3025976pfb.13.1714661589849;
        Thu, 02 May 2024 07:53:09 -0700 (PDT)
Received: from joaog-nb ([189.78.25.116])
        by smtp.gmail.com with ESMTPSA id h1-20020a056a00230100b006ecf00c1dd5sm1304275pfh.120.2024.05.02.07.53.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 May 2024 07:53:09 -0700 (PDT)
Date: Thu, 2 May 2024 11:53:04 -0300
From: jpaulo.silvagoncalves@gmail.com
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
	Peter Rosin <peda@axentia.se>
Cc: =?utf-8?Q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <jpaulo.silvagoncalves@gmail.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Supporting a Device with Switchable Current/Voltage Measurement
Message-ID: <20240502145228.qgocejdzjaaxt2zq@joaog-nb>
Fro: =?utf-8?Q?Jo=C3=A3o_Paulo_Silva_Gon=C3=A7alves?= <jpgoncalves@joaog-nb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240502133623.0000463e@Huawei.com>
 <44f47927-52aa-5248-6ae4-21028076fd51@axentia.se>
 <ad190ae3-48d2-a5db-dd36-d52b1c4cf460@axentia.se>

On Thu, May 02, 2024 at 01:36:23PM +0100, Jonathan Cameron wrote:
> Superficially sounds like you want a mixture of appropriate analog front ends
> and a Mux.  I haven't tried the combination but it should be possible to do
> something like this with 
> 
> An IIO mux via this binding
> https://elixir.bootlin.com/linux/v6.9-rc6/source/Documentation/devicetree/bindings/iio/multiplexer/io-channel-mux.yaml
> (that includes a gpio-mux example).
> 
> Consumed in turn by a pair of AFE devices.
> 
> Then you should be able to just read from which ever of the AFE device you want.
> A sysfs read from
> /sys/bus/iio/devices/iio\:deviceA/in_voltage_raw
> will switch the mux to appropriate place then request the
> voltage from the iio-mux, which in turn requests it from the ADC IIO driver.
> 
> /sys/bus/iio/devices/iio\:deviceB/in_current_raw
> switches the mux the other way and otherwise the flow as above.
> 
> Jonathan
> 

On Thu, May 02, 2024 at 03:49:03PM +0200, Peter Rosin wrote:
> I just realized that it's also possible to do this "the other way around". Maybe
> that makes more sense?
> 
> Cheers,
> Peter
> 
> mux: gpio-mux {
> 	compatible = "gpio-mux";
> 	#mux-control-cells = <0>;
> 
> 	gpios-mux = <&main_gpio0 29 GPIO_ACTIVE_HIGH>;
> };
> 
> rcs: raw-current-sense {
> 	compatible = "io-channel-mux";
> 	io-channels = <&adc 0>;
> 	io-channel-names = "parent";
> 	#io-channel-cells = <1>;
> 
> 	mux-controls = <&mux>;
> 
> 	channels = "raw-current", "";
> };
> 
> rvs: raw-voltage-sense {
> 	compatible = "io-channel-mux";
> 	io-channels = <&adc 1>;
> 	io-channel-names = "parent";
> 	#io-channel-cells = <1>;
> 
> 	mux-controls = <&mux>;
> 
> 	channels = "", "raw-voltage";
> };
> 
> current-sense {
> 	compatible = "current-sense-shunt";
> 	io-channels = <&rcs 0>;
> 	io-channel-name = "current";
> 
> 	shunt-resistor-micro-ohms = <3300000>;
> };
> 
> voltage-sense {
> 	compatible = "voltage-divider";
> 	io-channels = <&rvs 1>;
> 	io-channel-name = "voltage";
> 
> 	output-ohms = <22>;
> 	full-ohms = <222>;
> };
> 
> Cheers,
> Peter

A lot of good information. I didn't know about the iio-mux. It might 
solve our problem, and I will do some testing with it.

Thanks a lot for the help! 

Regards,
João Paulo Gonçalves

