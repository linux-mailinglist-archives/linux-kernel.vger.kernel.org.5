Return-Path: <linux-kernel+bounces-108900-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B7979881193
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 13:19:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C39D28595C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 12:19:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AEDE3FBBC;
	Wed, 20 Mar 2024 12:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="ey69IQD+"
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD4173EA98;
	Wed, 20 Mar 2024 12:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710937162; cv=none; b=KMpiOBgLAMETMEr0XaVE0Jr1IRxGU6OilG062zoa0FCnNRAsyQtuQ5n96OrHIM6qidS6oElrFa4NI+AftueevzFchHfnXm9gq868pzVniClViQcbppzU1BglxnhIv9xWB4ZTKxc6Ckf6UYzr0h+bBRSkq4WpvRd5YgRld91KaKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710937162; c=relaxed/simple;
	bh=lRT9oSTfLR+JQlZUwPoWrQebKedyDM3ti0p4qPc/OEY=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=nNaRyxB2XFrYgqu1Q3JuHjgXPen0CYJVdm/kYuLoW+x0oW0W4sQgBoue/CZje5BZ5lWuINHN6E4nhwh7HrBlYAc0x6gAG1IToqoL706IbPk+xz+7t2amzQAi6MTCzDSoJYSwcLmsGhiRxbR+VBk6OPXfa8tvY9Z3541VAhi2ImM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=ey69IQD+; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1710937128; x=1711541928; i=markus.elfring@web.de;
	bh=KhP5z213JRHgg+2Y4l04p0agR635gtrVnTmlg2I++II=;
	h=X-UI-Sender-Class:Date:To:Cc:References:Subject:From:
	 In-Reply-To;
	b=ey69IQD+cdUgDYt2KtdYDS6PfEx1U3euVUDVZQd/I3lnASEWs2+7iDm8CTAAXG+c
	 V907K5kHdsPrLxJ2DVHtBBzI1Wq8lwQ40+w2s7Qec3kJmhT9goNqPphA5lAY+HI6M
	 CZW3YFtxbaK4PPFPgig47U7fz9lEm4tU5r4qTtmzWHfiE0CCyQHQvOdxyNckBl+ha
	 IJOD63OrVpIKSAZiqod03i1daYuSVRGSnqLZZMDMgGJGqls8pNEqau/ijaBFAePYn
	 ZHQnu5jyoobtE+z4aNDmxFc+l+nZK3/xh4HwE44TLdIdFKmbCLXvjb+rGSOTVGRMp
	 JHUi//IsZIr0l0/AHw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.90.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N9LIc-1qjpQC2DWG-015dwE; Wed, 20
 Mar 2024 13:18:48 +0100
Message-ID: <4b8ee072-70bc-4a0a-8e43-e244f8ee2f22@web.de>
Date: Wed, 20 Mar 2024 13:18:33 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Dan Carpenter <dan.carpenter@linaro.org>,
 kernel-janitors@vger.kernel.org, netdev@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org,
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Jesse Brandeburg <jesse.brandeburg@intel.com>, Jiri Pirko
 <jiri@resnulli.us>, Paolo Abeni <pabeni@redhat.com>,
 Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
References: <77145930-e3df-4e77-a22d-04851cf3a426@moroto.mountain>
Subject: Re: [PATCH net] ice: Fix freeing uninitialized pointers
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <77145930-e3df-4e77-a22d-04851cf3a426@moroto.mountain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:PTUuB43Z3DS7y5k1LlzvJWE5GpgoYr2z888JWO4A8Mid5gKORZl
 MkpJK4sPj0ibCEfU/Pw4f5+CIFy2gNMghqQLHOhx/qdJ2joepGCvIS4FT/vzNi3ZISYJm5m
 W0rWME1EqkcsjFu2+pZtTZTKhWraCRg+epsZkoQ6DCHkmtw8Mxj9kbPwzJj8jb9ofEii8JW
 9eLlGudzZsRxA81ao1Igw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:soozx22Hh6Q=;7yVwJkmtUEyeQXzSrPhICqaGpWL
 wbPjm8iTqr9BUqyukACz4OdGv9m9vWc3/fg29pK0KYzZZsDLtEvH0ZrLwJFZP48im70E3QMh8
 D+g2/gtmggCoy70i5gd0tQMWyrix8wTEIPRATPDCqtwdr1aockW3cszBmSfN3+g9fgUJEr03n
 X2AZXgrXdislMFF9cKmCiuxQUib6tkR5jLqQ/jT3eEK/3FbAVSsz94RsiMGpfbPaczIM0E5AZ
 L3bwe2yFjjVrZkOg/oBVqXfrC3+J1T//XU18zo2T0b0AjqgZwRVbXVSQQj+Ms7IbmhuvlNw+/
 fveFWGbZ1sMyvO9A5fma3wCii4WBsBBly70rIpn9021AXkNkNIXgw3YWRsS5ytNUtqJDacZdQ
 oxtzxCA0eWVlZYEpGByshiLpTEX9anZf20Q8icqiwfFUEeDU7a0jdKODkHo+n2wSPUyBko6LS
 2AHZ+k48/WmQHiXsW5u2RTZuqJTcXJE5yln/0Lw4ujuU7nlN4faOW9g+mFNWp1kNyFNx5sCgY
 Yb8YfPFPED0KE8yRRm5xbEuB3U/ggpVTOvgB00yuUdmTGsbisqimEEnfbgurwAa0x+M3eSKNu
 1GKcJZqia2LYnli/+5Yyysb7oy5LonCTHWVhOtcNKw2xuF9gdmdFcWDscJsN3ch8Nn8jRXB0b
 tz57Ae48zbuB0FHfO9Zg+ebV4uho2nVHhkKsF06LOfd462kDywP1pSssWQZupeUu51OSNV9PG
 KabbQuuIq0xxf0CNFfT+twKeG13Z+yZddKXnl8gNE2b3wFBvooJ2Xvqgyr8CBJbow1ahPmu4B
 8WEuUavjN7uJsok8ZYho4JjUckMm8s/fThJNp3TJv9U6Y=

> Automatically cleaned up pointers need to be initialized before exiting
> their scope.  In this case, they need to be initialized to NULL before
> any return statement.

I suggest to reconsider such information a bit more.


=E2=80=A6
> +++ b/drivers/net/ethernet/intel/ice/ice_common.c
> @@ -1002,8 +1002,8 @@ static void ice_get_itr_intrl_gran(struct ice_hw *=
hw)
>   */
>  int ice_init_hw(struct ice_hw *hw)
>  {
> -	struct ice_aqc_get_phy_caps_data *pcaps __free(kfree);
> -	void *mac_buf __free(kfree);
> +	struct ice_aqc_get_phy_caps_data *pcaps __free(kfree) =3D NULL;
> +	void *mac_buf __free(kfree) =3D NULL;
>  	u16 mac_buf_len;
>  	int status;

How do you think about to reduce the scope for affected local variables in=
stead
with the help of a small script (like the following) for the semantic patc=
h language?


@movement1@
attribute name __free;
@@
-struct ice_aqc_get_phy_caps_data *pcaps __free(kfree);
 ... when any
+struct ice_aqc_get_phy_caps_data *
 pcaps
+__free(kfree)
 =3D kzalloc(sizeof(*pcaps), ...);

@movement2@
attribute name __free;
@@
-void *mac_buf __free(kfree);
 ... when any
+void *
 mac_buf
+__free(kfree)
 =3D kcalloc(2, sizeof(struct ice_aqc_manage_mac_read_resp), ...);


Regards,
Markus

