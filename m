Return-Path: <linux-kernel+bounces-144036-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 120EC8A411D
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 10:03:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BABBF1F21B66
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 08:03:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3AF92232B;
	Sun, 14 Apr 2024 08:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="TIReNNVB"
Received: from msa.smtpout.orange.fr (msa-215.smtpout.orange.fr [193.252.23.215])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B1BD20DE8;
	Sun, 14 Apr 2024 08:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.23.215
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713081805; cv=none; b=ktvgK0SXPdPeVlrPA8bpBnet9t00/jDuesCmL2JTU2D388ycTRUk+rGFlExKzKvjWuZV82+gwEkN0wEbHWkriDXouVfghl3zO027670gRZvyFA63OEdIDrlpuyEAf8PpLgAwntuby8PQudG8gecLytH0nn7cWqLb7KwLMKy0O5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713081805; c=relaxed/simple;
	bh=ZgdTR3mDDZBEx9fgnIcZGTrSMVKCA1raa3F6SrKzjqc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tdiTE0iZg4C+oBze/o7MMjfSJFn7KuYURILGQ7lqFNxqn26GoqvH0sYp6M+O1WO0X6KYCYEpWZ7orBnw1+sAmC8+IoTwIcpL8pZD/0QosJbWP2+pNE6Lub16DAVUXtMXBE2hmE2S66AGA2HdR8NRK1GfUEQaERKuh+33kdX1+ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=TIReNNVB; arc=none smtp.client-ip=193.252.23.215
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.18] ([86.243.17.157])
	by smtp.orange.fr with ESMTPA
	id vupUrbnUxReGpvupUrYOs3; Sun, 14 Apr 2024 10:03:14 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1713081794;
	bh=/EkCWI000WjErTLksVvS3KM3IgVVa6QzMO2SEgMZi3k=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=TIReNNVBjOjOl2krc105GJvTnNDykkW8fVUJ7UZhaNqn9h9VtBtKHn+bw6l1hbIXI
	 9kH+odrq6fV0aC8H03Yra4RlTUPpeJ1sqwWXj3TpaJZdRMQicnSu3vibO1YJoKhCl8
	 xg6GJApFPfpIpUf+vbg4f2pnhSW8B/x9u8GDuHxqVOMDrQFhR5MG83/FM0/L86HXYV
	 QQ4g5iQ5oxRfTWl2Jocg8sU85D5742BvpAs1NtSafy7QYAvpa/yICs9klSnoI8mc3R
	 OtAgXGsIeYqBMCy/4f12ZhOPDDddLpfXMljgbxOFHGrH0JrxYEU/xyTmVdYjbXKqDv
	 y8Le9PMhci2Zw==
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 14 Apr 2024 10:03:14 +0200
X-ME-IP: 86.243.17.157
Message-ID: <79bef664-b191-4905-896c-afab341b982b@wanadoo.fr>
Date: Sun, 14 Apr 2024 10:03:07 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] hwmon: (max31790): Support config PWM output
 becomes TACH
To: Chanh Nguyen <chanh@os.amperecomputing.com>,
 Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Justin Ledford
 <justinledford@google.com>, devicetree@vger.kernel.org,
 linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
 OpenBMC Maillist <openbmc@lists.ozlabs.org>,
 Open Source Submission <patches@amperecomputing.com>
Cc: Phong Vo <phong@os.amperecomputing.com>,
 Thang Nguyen <thang@os.amperecomputing.com>,
 Quan Nguyen <quan@os.amperecomputing.com>
References: <20240414042246.8681-1-chanh@os.amperecomputing.com>
 <20240414042246.8681-3-chanh@os.amperecomputing.com>
Content-Language: en-MW
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20240414042246.8681-3-chanh@os.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 14/04/2024 à 06:22, Chanh Nguyen a écrit :
> PWMOUT pins on MAX31790 can be configured as a tachometer input pin by
> setting bit[0] in the Configuration Register. When the bit[0] of a channel
> is set, the PWMOUT pin becomes the tach input pin for the channel plus six.
> 
> This commit allows the kernel to set those pins when necessary if the
> maxim,pwmout-pin-as-tach-input DT property exists.
> 
> Signed-off-by: Chanh Nguyen <chanh@os.amperecomputing.com>
> ---
> Changes in v2:
>   - Update the vendor property name to "maxim,pwmout-pin-as-tach-input"   [Rob]

..

> @@ -528,6 +532,33 @@ static int max31790_probe(struct i2c_client *client)
>   	if (err)
>   		return err;
>   
> +	if (device_property_present(dev, "maxim,pwmout-pin-as-tach-input")) {
> +		err = device_property_read_u8_array(dev, "maxim,pwmout-pin-as-tach-input",
> +						    pwmout_to_tach, NR_CHANNEL);
> +		if (err) {
> +			/* The maxim,pwmout-pin-as-tach-input is an array of six values */
> +			dev_warn(dev, "The maxim,pwmout-pin-as-tach-input property exist but malform");

Nit: exists
Nit: malformed or "is malformed"

CJ

