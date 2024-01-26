Return-Path: <linux-kernel+bounces-40597-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51EE983E2FF
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 20:59:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DEC62875A2
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 19:59:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9C332263A;
	Fri, 26 Jan 2024 19:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=linosanfilippo@gmx.de header.b="qSh8rlp+"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 746AB225D8;
	Fri, 26 Jan 2024 19:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706299156; cv=none; b=gZNEIqstirYQAjkKs1P36tQnwLwaQmXEPx+v95yacZz2+ofFsIJAVwMa46hugsTnhUJt4hUpbm/7/H6EMUF4e3zqbYfMmfaK1y2SBfiYwsZx4k1GLb2PuPEPqlsuicuwU+izV6anRA32O9N3DeEbHKBxqxI7yYWqxm/7DGbXdpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706299156; c=relaxed/simple;
	bh=cRzLRQLkoT/9QCSn+btL5/4YZw+PC8W1ychaTIgW3/Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WmFhM8mmBXTd2zmKzT+Nxqdiql7Ro5dZVbxwgExAZwqSuUHx3rtbcS19nECpJ6CrVpz8viExU8sc95qn4eiCV7BnsIDUSmAuFjCdMMfc5rf1o86myqFZAn04hLDSLwug21AN9HaSs3ESmzdGFScIMm+j6cjD29ENtJ3NAlRhlPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=linosanfilippo@gmx.de header.b=qSh8rlp+; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1706299131; x=1706903931; i=linosanfilippo@gmx.de;
	bh=cRzLRQLkoT/9QCSn+btL5/4YZw+PC8W1ychaTIgW3/Q=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=qSh8rlp++h2UL10nO3ZC6Qhyxh9m8pn53Dt2WTcaUCG6k2bApgwssHd7NIk2TbJu
	 Zo+WfXtE43EucUy+yKr4BsJwqeUhv3wR5vBPogtcDFRli3mBozrnOjlCiC9AQEbxU
	 kZOaOHbQk2zzeWftCh+zfCUDsvU1vc0oBF2sz2ajn2p1gVqdOC3JMFGj0YJ491/1X
	 IewEf1Q86xDFWDbd73UKUmIxzeGVXY0vrerDckSb6CVGzVb5rX5kjIFQpuiuOetRr
	 xqKhgMmKn9aGI6p9So3ssYKk+pmgsU9oGGjMQJNQ+93AiQEQgqKTaj8VwYhYLk2VO
	 FqIqODPwHgvKNctyLQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.2.42] ([84.180.5.12]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M1HZi-1rWCAb24XC-002rBK; Fri, 26
 Jan 2024 20:58:51 +0100
Message-ID: <098216ce-50b3-43e4-ad1a-42228c58b761@gmx.de>
Date: Fri, 26 Jan 2024 20:58:47 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/6] serial: 8250: Support separate rs485 rx-enable
 GPIO
Content-Language: en-US
To: Farouk Bouabid <farouk.bouabid@theobroma-systems.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc: Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 quentin.schulz@theobroma-systems.com,
 Heiko Stuebner <heiko.stuebner@cherry.de>
References: <20240126-dev-rx-enable-v5-0-5d934eda05ca@theobroma-systems.com>
 <20240126-dev-rx-enable-v5-2-5d934eda05ca@theobroma-systems.com>
From: Lino Sanfilippo <LinoSanfilippo@gmx.de>
In-Reply-To: <20240126-dev-rx-enable-v5-2-5d934eda05ca@theobroma-systems.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ZxMRSpxhrKQNxRQVUQyrIc8UZwPVseB5XxzkFHOXhcCiL9DaKQ+
 LoOnRpzN6nc+kk0LwXWXCb3q9omGjK4QqK46ZFM0pFBpjurJ/TMUaSzMcmatc0t9IbB9XOh
 m1ipbp6DGASgrgCICC1hkD/Y8kCDX4irts5qeyO66IAzHcPlYv6DS3ZjdhWxeD2n51USWjY
 8oC2bt2tH1AFA4e+qXYQA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:gDeFAUjQu88=;LyErTh1wbmp4ZgUkN2hipgHtJip
 Doasra58RavpqzDzDkRpATvXg2UWTEIs8FY3wGifrBGjoG8OZ7XWkAWj7S7d/CqD8+XJozQgg
 GXbN1lSKKAMwvlFtJwrC+mFYX8f9AMByLl2inW33lRUHV9zt/ozkAczOIukrBYMdJzhUfK8bL
 EIGpYZwCLKi0NxwE8nq/9OkiEXlqk0+paRlr8cewb4fRcpOIan4Anozb6PqsnRgPM7QcZM1w5
 phyRqULFK7WdO06b0nSRXe8Z69HjxoqSFMIDRgm7ZqOg/KsAzJwjqvNSNTa8A4WjuHRUWZVKo
 c9TO5w3UiF/SWoftSN1wEIps/d5YTOJK5ouPrcGnKItZgekoSQO0Z5q2ZX9i7UoEClgtz9sMF
 M7KlxJ6CU7jSybRv7cdD+jrEFeYH4TnHVhHqOxpmEmyCw1K2h9QtRzGbZPIMxOGkjVI9avub4
 XPM72OdUCP/zGxht5V6HyqM5VnyXRG/FKVkLjgIMs5E934N0qA6sCIsR68mnHe59QVZSFLSBD
 y4JQlMFaKZXKTyK5oKXiwFZ3z21/pzKdYxP/bjUhhR8tZl2Iw1tiRXSmUShk3VGHgy/6a3Sqo
 RrvNboGzXBaKmIGtWy+0pFe/Vf6zw+DqHQ9DeMI/hKuUtUQzdeXJDkD2xoPe96RBFtsaFOKsf
 Yu1eHFHcKnaYFfZ8Mb1pEmUTA3pxvgARx+kYLJcV44D6tr+oVHzAc1D0QezjC+PLc+7yXAw+k
 G8JHOYNegYJQvUWoE+gaYbLp8iuUTJdGnbMza8NU1YRui2utEERA+ahnOvfgMNDHBL0vjhVVz
 B4Qls2sbQGt/NGT3zpmWbYlj7mVj+Bi6Xcil1giY1tGYTc4ZKebGHZYJPk5sApQEJRazuVwRw
 pwm/TpmUMJawXcDQ7pUOztJSnzRN4QDqO3ZRdvZ7D4al6Lh+479MaZHfTDUiC0zzObA4F5qDd
 SW2XOQ==


Hi,

On 26.01.24 18:27, Farouk Bouabid wrote:
> From: Heiko Stuebner <heiko.stuebner@cherry.de>
>
> The RE signal is used to control the duplex mode of transmissions,
> aka receiving data while sending in full duplex mode, while stopping
> receiving data in half-duplex mode.
>
> On a number of boards the !RE signal is tied to ground so reception
> is always enabled except if the UART allows disabling the receiver.
> This can be taken advantage of to implement half-duplex mode - like
> done on 8250_bcm2835aux.
>
> Another solution is to tie !RE to RTS always forcing half-duplex mode.
>
> And finally there is the option to control the RE signal separately,
> like done here by introducing a new rs485-specific gpio that can be
> set depending on the RX_DURING_TX setting in the common em485 callbacks.
>

we just added the rx_during_tx_gpio to the serial core.
Why cant you use this GPIO for your purpose?

Regards,
Lino


