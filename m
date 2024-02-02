Return-Path: <linux-kernel+bounces-50452-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0310F84791F
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 20:08:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34F251C28002
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 19:08:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A24E130AE3;
	Fri,  2 Feb 2024 18:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lfQGRDWS"
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 766111F188;
	Fri,  2 Feb 2024 18:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706900146; cv=none; b=MX9rOnP17QBbfj4B3vISytZfC15FQk1Zmh0NBYDrDkXFflhmyxq975+JrJyccMJghmsq1S7LTV+kk/BdFYhbKvn+fzmlHet08Vyq/pBK66H3Yn/dpueN9EsAHfstL6verdW6Bv/OCjlQtjDsC3TgYjgcyaR6xW4y42gU8i0oYp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706900146; c=relaxed/simple;
	bh=qNjK+skB9hlC484l2a2NsnDNAr9FFz9DVravPTXTiUw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sNZ4ISVwc3wyElDxzFqbLw7hX7meYI1qKjUApMifVeVS9FpcSTyCDP0/yBaD6xkebJM5aWB8cxTwDoulxxq2XgAKkkW+/b20hcp/M341mmIvQ8GZbdgcXhhpQ2+nxIL1cJdQxhCvHeK306rWk0GtZId/ePHbbm3J2O7XAJD1PjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lfQGRDWS; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-5d3912c9a83so1952020a12.3;
        Fri, 02 Feb 2024 10:55:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706900145; x=1707504945; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dIpBghPn6EAAPfQx41ySOXsTfZFua0vsyWol9UoCZkw=;
        b=lfQGRDWSlo9szphvh5giMSfux2bZOdTrjgL/u1gh+npyJbW60J4YJNWg6xCa0MJWXM
         iUCpn0z5yOlDYTFFEc95nGgCb7skiDUtZfjD4u6yhcgyPT0UivDNbCuMU9RZh7lP/OSe
         +SKFyEqXkmHSG35nd1ZlPf2mbc4TncW2RheaK9cAnxc2TQfgmh+AbBrwN+ybDy7xIOuV
         eYdLRQ7yv1UnvFJgIpaQXrxHTXBi0+lR1cu3zk0fHk3BjBEyHDMHPetWSgl/w+DIYuXu
         cOk8ou1CxnG40YJXvbd6POMhZ9WLHDka38ulfVIr6+tC2gOD/z9R5rSCAg2HHMhDcVmO
         sOtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706900145; x=1707504945;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dIpBghPn6EAAPfQx41ySOXsTfZFua0vsyWol9UoCZkw=;
        b=N0n9lehYS5eSDBXEgmIcsOy2C+WVnELnN9+jAQowV231tfeL95D6EweJ4rd+/38lt1
         fk2NZ2S/GMkHFLllaZl0FhVuX7Cy6ukFGTH1Pzc6yHFREo6MLBzLKcxlgfR/SGzHl9bT
         QyI1FHKqQLENHKWue/ei8/deplpp2PBMj8N1NWeL5IYlhoqlOqrhXa1MwrvL0PLP3e3p
         l+QcpoQ9Pb4OQ6QiAQaHmlzZr/18erfccEedkSU/rPoDZ18GCvnduKWLaR7WDLTyAgoT
         aQD9J719y85uBzu+mpuMwsz1T4JLYoLuP5zG51ztECqSb1ZzSfvg5YbQmrskyXS6DJJw
         QNDQ==
X-Gm-Message-State: AOJu0Yw8pxuIHB8M8hSzHV9CWVvLXNfJRO7BU7jVbmSnlgAJynb9gNqn
	rlXrcEKYUMmYRnHCYJbcTARcoxDapguNnOr/8drJ6uLJ+c+NFOQd
X-Google-Smtp-Source: AGHT+IE10uTltyD3d6e214QNdVFvkqQDZYRWvN87GVIUfBY9oCTWGvBXd6HJGlnZriycisEwlZZkTw==
X-Received: by 2002:a05:6a20:4da1:b0:19e:2ce0:1fb5 with SMTP id gj33-20020a056a204da100b0019e2ce01fb5mr5605946pzb.49.1706900144704;
        Fri, 02 Feb 2024 10:55:44 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUfYzrKCXtedfknx+tLRcBiVMJiWsqeZ99Xt0YgBn9JO7iZsGoVB2h0uz1lSk8hl2Jo2KB6uKXYUYkSt8tYJVueC2c9GbvRRA7eRGtSDahtdquPPQHRMFtxuKQaYVK4n3rwlc+JDCUWcI1JfdOaFfUoIdbSXffFZMYmKn1XnmTTqMuT3MyoEonpO1cywpm7D+srU083yftfAfZteAtSeziSgmiwA6oa7Gz5aEPPMmBl6YKfCpSp2C/UrgwZ+uAy01iRBk9ozmxgp2h1+KyVXUme9OTsIScg6+G9lkt4Sb0rkEFIwB/Nmnq3bz81hbaLshYA7R9SIYciqft0m7vlbzKyxKibBMW8lZwb7kCjdkE+QF0//KV682RCZDACK1F3vNMaeUOx
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id fh26-20020a056a00391a00b006dcd6a5ba14sm1982774pfb.59.2024.02.02.10.55.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 10:55:44 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Fri, 2 Feb 2024 10:55:43 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jean Delvare <jdelvare@suse.com>, Jonathan Corbet <corbet@lwn.net>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v6 3/5] ABI: sysfs-class-hwmon: add descriptions for
 humidity min/max alarms
Message-ID: <50d5679b-b2fa-4486-bcb2-19a0ad5bfd80@roeck-us.net>
References: <20240130-topic-chipcap2-v6-0-260bea05cf9b@gmail.com>
 <20240130-topic-chipcap2-v6-3-260bea05cf9b@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240130-topic-chipcap2-v6-3-260bea05cf9b@gmail.com>

On Tue, Jan 30, 2024 at 10:06:46PM +0100, Javier Carrasco wrote:
> This attributes have been recently introduced and require the
> corresponding ABI documentation.
> 
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>

Applied.

Thanks,
Guenter

