Return-Path: <linux-kernel+bounces-147295-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C25D8A721E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 19:19:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 495501C211FB
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 17:19:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 564491332B6;
	Tue, 16 Apr 2024 17:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="tUGGNUz6";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="8Re553De"
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34938132493;
	Tue, 16 Apr 2024 17:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.167
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713287975; cv=pass; b=IE7lbJZ2Whco3BD/o9BOKQq83b2bJSK834XvQEy7BcKyRc2I7ppFQWGBW66AzSV6AVZ0YUc5BIj4VBMTGwHgv0rUkBcsdihUV/YXvwRcpI/gL7iwVOUVCVfMFJTwfNOn6h4FehaczjanBaukBWD45tbQAgXDWcwv5aHaAQehhZs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713287975; c=relaxed/simple;
	bh=Azr7ovdYaxV3PlnjjsIAyizZx7zMsRJjz5oo0vl5kMo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y9UTsn3PWuYzFd7UIWcZPj1au/HW2P7NOEEbhy8+g7GuhE8G+b0NpoTf2R13atz36ndQgUyn5jEt52OGeVwi1GQV3tM/Cg4Ct0m+QF288T9k1+BkLnU6PX9yIdsFrOuumBftEw+xAAiUeyVrbYnsp+oX74AlnSvPeO5A3VYaArI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=tUGGNUz6; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=8Re553De; arc=pass smtp.client-ip=81.169.146.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1713287950; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=VYjrR8FNDMNqQJZ1flH9Y/rD9hieKAIvH0HbpU+zeJcSUOQwEualufMNRhsx4lLnAO
    6CCOQmtdF/I35BqaBGt14Bmftm/iMlvdPFVFrYDZta33tN7QomhLknSoV/l4b/G0o8DK
    8+IIMvuiuKi+pogsUk8ilknWsYaG3YR57ySHlTU67Z15WLCXViYhAU6oZJgzZmB2rAgK
    ElR4fpg84nG565p0RycMVYfqRV6NCP5Mk94vEJOUWC8SMCUUqQ/37v9372Dm/DLTMLXC
    Ddnd8RsbN3/E1C+/bxGF6/8J21dMUbCqVHnPa7F+CS+5c0GRv70hSrF7QUCLymVZiSSj
    UkJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1713287950;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=UZNazYxiaUPP62ZqofHCxP4mD8sMhtRghorMzgkk/Zs=;
    b=gLXnXCttLlYyG60NJNPGm+Xp5Xbvu6Plo9XMZ5kbfpeGh9+GuZ1R3ew8e7JjZytxYy
    +SK+wMNCCGs4kpeaZ/qMTd89bYuN0ip99NAP2jyQYpmWZ8pUg/B2Hc20K+xW9e0IsVX2
    9orGlhI8ufrMfgVghLnVsIjyCyRi15U4iey+01KHrbYjwm2KET+idnTJlgbPuTnw7+9/
    652S8wmKeaO/FYxCWEQaqfPconBNMa+WgYm223cvpvLXaXoPiUlU+RzbKzbJJhtiEY1P
    r5aThUOIso3Gm8TA6wYMeoeFtGQGYrlbAqh5VDlhxR5+ALQaj7GbzQBmCucGduEPTf9Q
    60lw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1713287950;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=UZNazYxiaUPP62ZqofHCxP4mD8sMhtRghorMzgkk/Zs=;
    b=tUGGNUz6T13vFpz9+ezMtiFNIURaWR+iWcfWN6sUvBU9/es0JKhD2h50vlTjfOzVkR
    kgrdh9wPcOAagKKdaAB2IQKUbAJeKgSHwcauz+9B4pNV2vIAGPVkOX1Eb4yCFP1jIZw0
    DjGvAJNTsXROBng+mcMZfkmoxxRKTMklJeHVoP53iYGpLZJEvTfZ9tWy8jRlyZ7znjQ6
    yxK+6Up7aKnW4p9VmGTNKoUFWBHRqgaSKB/fwrTK66j8IxVlXJJ0ww62GIb3hEkJvAt2
    EluNeS3c9EOwwUU8Tvjsxx4LOUIkVvhVBok76DSALfS8lSzD8+8XplIGxpCdVUhtDenn
    r9eQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1713287950;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=UZNazYxiaUPP62ZqofHCxP4mD8sMhtRghorMzgkk/Zs=;
    b=8Re553DeDZ5GUPLWwSAt3vpX8+Zf9DSidpB8rfsjmi8ZORdySd5HY+9yrvECcDPNVa
    lk9BQxcVpQ4XX0vQ73CA==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1qCHSa1GLptZHusl129OHEdFr0USEbHoO0g=="
Received: from [IPV6:2a00:6020:4a8e:5010::923]
    by smtp.strato.de (RZmta 50.3.2 AUTH)
    with ESMTPSA id K701d603GHJ9TIN
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Tue, 16 Apr 2024 19:19:09 +0200 (CEST)
Message-ID: <d4a55991-0ccc-4e8f-8acb-56077600c9e0@hartkopp.net>
Date: Tue, 16 Apr 2024 19:19:03 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] Documentation: networking: document ISO
 15765-2:2016
To: Francesco Valla <valla.francesco@gmail.com>,
 Vincent Mailhol <vincent.mailhol@gmail.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Simon Horman <horms@kernel.org>, Bagas Sanjaya <bagasdotme@gmail.com>,
 fabio@redaril.me
References: <20240329133458.323041-2-valla.francesco@gmail.com>
 <20240329133458.323041-3-valla.francesco@gmail.com>
 <CAMZ6RqKLaYb+8EaeoFMHofcaBT5G2-qdqSb4do73xrgMvWMZaA@mail.gmail.com>
 <9f5ad308-f2a0-47be-85f3-d152bc98099a@hartkopp.net>
 <CAMZ6RqKGKcYd4hAM8AVV72t78H-Kt92NXowx6Q+YCw=AuSxKuw@mail.gmail.com>
 <64586257-3cf6-4c10-a30b-200b1ecc5e80@hartkopp.net> <Zh6qiDwbEnaJtTvl@fedora>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <Zh6qiDwbEnaJtTvl@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Francesco and Vincent,

On 16.04.24 18:42, Francesco Valla wrote:
> On Sun, Apr 14, 2024 at 10:21:33PM +0200, Oliver Hartkopp wrote:
>> On 14.04.24 06:03, Vincent Mailhol wrote:

>>> Regardless, here is a verbatim extract from the Foreworld section of
>>> ISO 15765-2:2024
>>>
>>>     This fourth edition cancels and replaces the third edition (ISO
>>>     15765-2:2016), which has been technically revised.
>>>
>>>     The main changes are as follows:
>>>
>>>       - restructured the document to achieve compatibility with OSI
>>>         7-layers model;
>>>
>>>       - introduced T_Data abstract service primitive interface to
>>>         achieve compatibility with ISO 14229-2;
>>>
>>>       - moved all transport layer protocol-related information to Clause 9;
>>>
>>>       - clarification and editorial corrections
>>>
>>
>> Yes, I've checked the release notes on the ISO website too.
>> This really looks like editorial stuff that has nothing to do with the data
>> protocol and its segmentation.
>>
> 
> The :2016 suffix is cited both here and inside the Kconfig. We can:
> - keep the :2016 here and then update both the documentation and the
>    Kconfig once the standard has been checked
> - move to :2024 both here and inside the Kconfig
> - drop the :2016 from everywhere (leaving only ISO 15765) and move to
>    ISO 15765:2024 only inside the "Specifications used" paragraph
> 
> What do you think? Shall the modifications to the Kconfig be done as part of
> this series?

So here is my completely new view on this version topic ... ;-D

I would vote for ISO 15765-2:2016 in all places.

The ISO 15765-2:2016 is the first ISO 15765-2 standard which supports 
CAN FD and ISO 15765-2:2024 does not bring any functional change neither 
to the standard nor to the implementation in the Linux kernel.

For that reason ISO 15765-2:2016 is still correct and relevant (due to 
the CAN FD support) and does not confuse the users whether the 2024 
version has some completely new feature or is potentially incompatible 
to the 2016 version.

Best regards,
Oliver

