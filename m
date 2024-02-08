Return-Path: <linux-kernel+bounces-58203-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 045CE84E2AF
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 14:59:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5E692930DF
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 13:59:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E998E77F33;
	Thu,  8 Feb 2024 13:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KeB/kC8e"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2676076417;
	Thu,  8 Feb 2024 13:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707400734; cv=none; b=gzEbOFlyNkpnKvqiZ+6flX5pJmaoC/emODy1s5/LfpCjTE4ZNrPKlrS5tyF2myVwX1TIwE22ycv4N1+MhrinFsj6c7gPWqDeXKi9jJc9TcUwQHUlZIuw4zlq4bxoi3S2K7zhEof3lsNEQLOLjYslwg5h0zKqteQQiUi3sqzVXwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707400734; c=relaxed/simple;
	bh=ll0dar8cNCeW9SvNKADTETzN3jimsD0cr4E8aRV6sng=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eXkmqwAlRtLhIyaCL+qb471zK7QZoobCM+pBWZDqISTTTrd7dmr5WYMxNAT1X4a821sEWu/aUXRMrBXlup6wsnU6OUQK8wPhmgsmhPzF9wwcdqswI4fFofU3m0hPBCrTOFDdc2i2f2Ke7dzyyncAba5bOnIx+1TW3XVGvYEpW14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KeB/kC8e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9CD6C433F1;
	Thu,  8 Feb 2024 13:58:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707400733;
	bh=ll0dar8cNCeW9SvNKADTETzN3jimsD0cr4E8aRV6sng=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KeB/kC8eS9lFq7WL1GePLNR2AttRt0VbcbJGS2fImIqe2w8JqS7qeqX63KbzsHwsb
	 Kuv0mqym8BhobYBLPF2f0UZ1Y8Olje9owlwwa4QnLMxdZzVYymsg1VqdvObnndz/cH
	 U5rTOdtos9LtcuPa+kj173umTLsTL5Cj6iO7O/dyB+ygNtIoDkVYInR/i+cDH3KZZv
	 +a25L/rc4aBUTCleEpmSg+D0EkALXmksk7Oy1zfWy0xViR7ebcoAdAKtWSLhiyGMxv
	 ORR5lTzb5JugyH/P709EE6OjJ4WwXvVFSMk9p3hSJRDnk32Bf1hfjGyFu+g3bL3Q4S
	 t6Pg/RXHwkY0g==
Date: Thu, 8 Feb 2024 13:58:47 +0000
From: Lee Jones <lee@kernel.org>
To: Dmitry Rokosov <ddrokosov@salutedevices.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Pavel Machek <pavel@ucw.cz>,
	Martin Kurbanov <mmkurbanov@salutedevices.com>,
	Jacek Anaszewski <jacek.anaszewski@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
	devicetree@vger.kernel.org, linux-doc@vger.kernel.org,
	kernel@salutedevices.com
Subject: Re: [PATCH v1 1/2] leds: aw200xx: support for hw pattern controllers
Message-ID: <20240208135847.GP689448@google.com>
References: <20231207125938.175119-1-mmkurbanov@salutedevices.com>
 <20231207125938.175119-2-mmkurbanov@salutedevices.com>
 <20231221161011.GO10102@google.com>
 <85c89859-ae03-4692-9c09-5779e4c40eae@salutedevices.com>
 <20240125130049.GF74950@google.com>
 <20240126122310.hrs37vybo2wnxto3@CAB-WSD-L081021>
 <2024012643-safeness-stipulate-153f@gregkh>
 <20240129141339.vvqi5z7ta7jkhvxy@CAB-WSD-L081021>
 <20240205105717.bmppb3xalmmqapqg@CAB-WSD-L081021>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240205105717.bmppb3xalmmqapqg@CAB-WSD-L081021>

On Mon, 05 Feb 2024, Dmitry Rokosov wrote:

> Hello Greg, Lee and Pavel,
> 
> Apologies for the ping, but I would appreciate it if you could spare a
> couple of minutes to decide on the next steps. From my perspective, the
> problems I previously described persist, and we need to discuss the
> possible solutions.

I thought you were going to use hw_pattern?

-- 
Lee Jones [李琼斯]

