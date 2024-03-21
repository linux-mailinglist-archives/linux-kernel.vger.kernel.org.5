Return-Path: <linux-kernel+bounces-110530-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E20D886031
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 19:00:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FB5C1C21CC3
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 18:00:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E8871332B3;
	Thu, 21 Mar 2024 17:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="eMpurxo4"
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEFF510782;
	Thu, 21 Mar 2024 17:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711043995; cv=none; b=JbFKlpU0A1Fz4u5dGG1XlJdCdBA0fZiiQ4AcqFkGNKmULcdILWBZZ/Ge+Mjtcl9R4ty6dzW0lTGig8/VDp7w5DL5Q/x6eeTiADTaTRQBTGPq/IqQorcNCOgIrdyEHOj8zw99/oM+Dqe3b9HsEbZP7tIAOuUvZj6Dqekpckc5LuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711043995; c=relaxed/simple;
	bh=SPQqvu7gSj1oVEVwxnTx7k/xiflKqOqTa+gR+LZK+/0=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=RlasqtOLdtUaeuS3DQSgZI3Z24rneQuwqVyl0GbfJsALCt06qS31t+DECV5zdPOVNlpX3Ij7V0PXOQ8Oa3nJcG5JoSJF+EXAO3wRyGSwIQqiC3l5G8faSWrMa2i7L93xQFtcOPeyUumJQhCVdiBKYJDz0IBTukXRXT/1Tht0Qzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=eMpurxo4; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1711043959; x=1711648759; i=markus.elfring@web.de;
	bh=XR5rc0S/5gMcNC+NgBpFr5aoRAVSFdliYHhVZzy6GVk=;
	h=X-UI-Sender-Class:Date:To:Cc:References:Subject:From:
	 In-Reply-To;
	b=eMpurxo4WYsPqzxQpHNncXlDFu5GnyxgrWNW5gvC5pCDx6hMeIIFiYzRct+v1j3U
	 TPMf0o6c5ASgvnvcEdQT6fgrb7DH/bvwv9nEXL6/rUv2dK63GqbC133HkQcHyj2Ie
	 LsACVgMLv++/t5cEjL2t8TCovvYVQsWzdhO4b5gykAWxJHlHl5xydXZFIIzMOiWX+
	 qPvdNEhjUVBceNxRAyhsESXZsSRr2OcQhOt7P+EK0WlC7+rIxzOs43eAfd031QzYQ
	 YeZAAORJxTQ7T7jSWms1J4NCsaKc669uh8s9rP69Oi854WZSkG7zo+x2adkjz0hmx
	 lFrjk9mt5bI9ln6PGA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.90.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MRW6L-1rQRxD46UP-00ScjT; Thu, 21
 Mar 2024 18:59:19 +0100
Message-ID: <d2b1f3bd-42f1-483b-916e-3735b39a30e1@web.de>
Date: Thu, 21 Mar 2024 18:59:00 +0100
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
Cc: LKML <linux-kernel@vger.kernel.org>,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 David Laight <David.Laight@aculab.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Jesse Brandeburg <jesse.brandeburg@intel.com>, Jiri Pirko
 <jiri@resnulli.us>, Jonathan Cameron <jic23@kernel.org>,
 Julia Lawall <julia.lawall@inria.fr>, Kees Cook <keescook@chromium.org>,
 Lukasz Czapnik <lukasz.czapnik@intel.com>, Paolo Abeni <pabeni@redhat.com>,
 Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
References: <77145930-e3df-4e77-a22d-04851cf3a426@moroto.mountain>
Subject: Re: [PATCH net] ice: Fix freeing uninitialized pointers
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <77145930-e3df-4e77-a22d-04851cf3a426@moroto.mountain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:V0HP89HbmD0ouUhnwO91mCsXsGnWuF9Bmjam4+ePUedUat+hJTu
 peduW2zPMrbVMSOjYTSiZ9VUQRXVQD/OSjGIoSvIlqQw5j6p9os+Yh5e+zu8dkF8+Qn52US
 wibyD2ex+TpHUo/dpIttenN+pa+cRpaXIzQhG/5xgbncTdLxzQMDwtu4r0MpCxmBOil9lgk
 WDO6m4DWr7vtaR/w62YGA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ef4Cgvrsg1o=;4P9FsdrJsJxQT1ku7Gz2lLdcq61
 EZkI2lWIdGsgSZ5MbhAqZBOL+EnWharMoVZ+xPbsvQIc6CVDwzgcW39n480XB1cKkRQi6Gq1U
 W1wHZ05htUX9ZAK3DaMtnYojjhvJGvCJ6qDas5E5dxbLdxICJd03hH1zVHXI5dS8YUwOYIhC3
 efCvKQv3Hk7QyplKJo6Cz1P011HyucsHPvxUQYnUgwi0CLsL/HkqN/sQvIb9haa+DjSlEbKmL
 HytjTgyCXLOwv1SjE0Xs3mpHJP7pfSn65b4c9fimokmb3B6cOaI/t13VRD527ksXt8JF2NlLQ
 6Pz8QPV6pZkV+9aY2Ii7WB6L3qqIY40F69HATCbtrQCGsawB2/6FhpnVZzGWdfu6hMXytTOeg
 Xy2LgQg/K1cGZjtiPbhUwQlEew6k6v6Hbegirs95O3zK7YWlLCG4G5XrP9DA6N9K/sT0bdrz5
 3krBz2eR6MGIbuHLUf2QHqZRVLg9SJOiiU1kP91iZTqC193r+cL1FraKo1Pg5m4ca9XZzVXOU
 70d1y703E2j44iRRr9kBiFj6VoCZc4cpejG7jL6MSOe1Hpz0CT9tT+kvDV3oFq2OfFba/J/cx
 OhcwxSVFz74HgXSC+74RU+dqLhxTIiFTdyK7EYtlDJF48PQ7ByTLrPWSNRbq9C3dxONhzIjsu
 qDy31Gu4SFl5jsWmQ2fq34Mo3pkoOSRk01BX5xMjsoxxd5gucXCC0K0NuP1LA10mq6NnsnACE
 +m3PiSZXlfn8h8DH5AXYUSJC8XTz0RMWeqHZZNEeoopAL6y2w2SsoUzt18hMNzYn6x2Ibr1hU
 VuEjrbmTiSjoudiKLgEL7n8j5TjHsF1Z8WyqwiEwO+PTw=

> Automatically cleaned up pointers need to be initialized before exiting
> their scope.  In this case, they need to be initialized to NULL before
> any return statement.

How will development interests evolve further for such design aspects?


=E2=80=A6
> +++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
> @@ -941,11 +941,11 @@ static u64 ice_loopback_test(struct net_device *ne=
tdev)
>  	struct ice_netdev_priv *np =3D netdev_priv(netdev);
>  	struct ice_vsi *orig_vsi =3D np->vsi, *test_vsi;
>  	struct ice_pf *pf =3D orig_vsi->back;
> +	u8 *tx_frame __free(kfree) =3D NULL;
>  	u8 broadcast[ETH_ALEN], ret =3D 0;
>  	int num_frames, valid_frames;
>  	struct ice_tx_ring *tx_ring;
>  	struct ice_rx_ring *rx_ring;
> -	u8 *tx_frame __free(kfree);
>  	int i;
>
>  	netdev_info(netdev, "loopback test\n");

How do you think about to reduce the scope for the affected local variable=
 instead
with the help of a small script (like the following) for the semantic patc=
h language?

@movement@
attribute name __free;
@@
-u8 *tx_frame __free(kfree);
 int i;
 ... when any
 if (ice_fltr_add_mac(test_vsi, ...))
 { ... }
+
+{
+u8 *tx_frame __free(kfree) =3D NULL;
 if (ice_lbtest_create_frame(pf, &tx_frame, ...))
 { ... }
 ... when any
+}
+
 valid_frames =3D ice_lbtest_receive_frames(...);


Regards,
Markus

