Return-Path: <linux-kernel+bounces-110630-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3D4988617F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 21:11:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B57B284983
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 20:11:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5C58134CC8;
	Thu, 21 Mar 2024 20:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="Ohj113M2"
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 712A156B98;
	Thu, 21 Mar 2024 20:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711051905; cv=none; b=OMeC+fpjwAN0DtJvflQnKjYQkXZvQ3RDU526dBw4g9SekL+ksvjD2UwRKMmg3bfGYLBQ1ooMpfYp21u53TfO2blYd4v63cteyhsrgONBL5cHvGpyFyZ2qc4yThjH8qp8IvS5gmvzauKucd/rY7crjEFbevjrTbaJSutHpeA8ZD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711051905; c=relaxed/simple;
	bh=/2XDIlMNYS8/iY2ARJ5Fld7/GNYjUZk7UV6XTc7Kqsk=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=eq8tuzO7t1c+wAwKD99wDP6dImS7hpEux7D+5MMcdxxUPEa2hTNCf6B6KFOn7Qg/Pi2r63H+AnNKAdyv/W8uXdq4i4n5ucxFJGFrZFyxx6tGVA8nmgHGVFDi7R8p3r4G6UdHdR4JZD3QDlJobTvIOhum/dYrtkbepxS4EiscCwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=Ohj113M2; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1711051895; x=1711656695; i=markus.elfring@web.de;
	bh=HP94er+kV3GasVjf02u3F9ZYkvcXZGx9D3xC+m1al/k=;
	h=X-UI-Sender-Class:Date:To:Cc:References:Subject:From:
	 In-Reply-To;
	b=Ohj113M2xWNnZpo7zw6o3IRAbBcp6R/t4iips3r3U920IM3MjiGXBn15VjlXyh2b
	 iszYGr5qT9m6SsC5r3viqzQ9GkIs8+AXPkRcTvMgiH75mFEhvOEDNx0ezD/Vb0Fdv
	 hP3Qm3UHC+pZCytnyRUinD7w+2QmtfOhHzykHXmw1X/8N17Pnsgd3V9J27LDUjWiL
	 K7GmKt2QTfjYy3uQJlDFW9AyGDsa3WUt2izVju3+IIdqmBEuwN+PHfVKl/UkUEOLW
	 TsDlKXLFuIgcSXUqRZv0v9Ps+OQctuJnMr5MSwlYBUNzXWuN3q45rrlW5ZIkXDFfL
	 L+RW7rMXRujdp9jmXg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.90.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M8C07-1rjnlJ0KNn-00CkW1; Thu, 21
 Mar 2024 21:05:38 +0100
Message-ID: <0d7062e1-995b-42bc-8a62-d57c8cb588ee@web.de>
Date: Thu, 21 Mar 2024 21:05:35 +0100
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
References: <0efe132b-b343-4438-bb00-5a4b82722ed3@moroto.mountain>
Subject: Re: [PATCH v2 net] ice: Fix freeing uninitialized pointers
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <0efe132b-b343-4438-bb00-5a4b82722ed3@moroto.mountain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:f30MnlCTiWPDt1zm7PlXXn3w8Vl/ZOlATngou/8kstVjQ3Vtjmc
 NwEr7iAZYqjF/kCilniZdpv/ZLPs3A65OoLDtTMhNEIpAf2F3c8X9j/zin2Z/6rxkVK/bL3
 Wd7ZA7beckUcLMwzclkVVdoZI80PLUcb7qXLoHdtCIh0JsPV3Ctj3JBF/3V2PoYrWqycho0
 7onxYACnS19+yZ9c1V4Ag==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:X2SR5Bg9eus=;EsgC33vWFTVn58hHEBNEPF38Rrl
 CULKBP/GMFGAZzCkl/I+QKpv2zx/UmKeEXzWhzA8tkpmH4pA05yI58gXd8aPMlQRo+vXZ0g9e
 3vdZ9gUpf1OvJ5ENRAHCnG+NQZabvdjqV/6JwkdcO06hQYZqEUL6w1svA2UmD8fTX3L7eDuSy
 GthD2D2GbGCQN3t4gIypBIGb1bD0ATnGsIL1qSaVEr34JZtp2H8QZYootESVtgminvoM5ZIHz
 CrETzHiOnDA9HSVpijq0dh7Gk29iyNk4CjyKBx2nnC9Oa6+HuhEiE8VKNKOkQLKscw5S+rz0r
 n+IRXcV95zmeKDKKr7ICaj6oRIXfJ+SuIf6YBEZhjK16xQ3bhXUKRpvl6WFKxw1ibBrrg4r7N
 JOdj2N9961SHi9BJsH0gKdka+QsUM93IbN1Mjy1d/mv4lKZmx83TDciQVgF71Dq6lFkwWPye6
 YHPXzvmcQmPRvgCyNmGBhyKcMlw9E4Pf9b1ABrq8Trf2psGZHrDUtWCN5pcMP+NoSkVJwqTGm
 kRAYADbhG6fDuduIZWi3kYTWSMmF2E+HnN6xHjox+VRGFx+0Mrg8APJrVR55AnRpmaIwK6fPF
 /I891Y3iTsB+qN2zup5tfSw072LFbBWBYq/BNwxDYuSOH17vkWLoEhpG6bKy5vvoXGMNl9qY+
 IDt5KkknnGPMuSGwxczBT4PZeQIYsQHf7tuaPt24XxSofTBQNJ87zdG4pp2OUNzAC2xDjAoqf
 Cx/ojIX9EGvYib8qjgKvy8asvEyUZ9e9uzCh7kkNekla2o60ns7KRvW17qUhZZl9DFw0jvI0Q
 oUSTbhHJflD2aEv7pc2aOHIYjEEoYQLDzH960/3o/GttE=

> Automatically cleaned up pointers need to be initialized before exiting
> their scope.  In this case, they need to be initialized to NULL before
> any return statement.

Will any adjustments become relevant also for this change description
if scope reductions would become more appealing for affected local variables?

How much can a small script (like the following) for the semantic patch language
(Coccinelle software) help to achieve a better common understanding for
possible source code transformations?

// See also:
// drivers/net/ethernet/intel/ice/ice_common.c
@movement1@
attribute name __free;
@@
-struct ice_aqc_get_phy_caps_data *pcaps __free(kfree);
 ... when any
+struct ice_aqc_get_phy_caps_data *
 pcaps
+__free(kfree)
 = kzalloc(sizeof(*pcaps), ...);

@movement2@
attribute name __free;
@@
-void *mac_buf __free(kfree);
 ... when any
+void *
 mac_buf
+__free(kfree)
 = kcalloc(2, sizeof(struct ice_aqc_manage_mac_read_resp), ...);

// See also:
// drivers/net/ethernet/intel/ice/ice_ethtool.c
@movement3@
attribute name __free;
@@
-u8 *tx_frame __free(kfree);
 int i;
 ... when any
 if (ice_fltr_add_mac(test_vsi, ...))
 { ... }
+
+{
+u8 *tx_frame __free(kfree) = NULL;
 if (ice_lbtest_create_frame(pf, &tx_frame, ...))
 { ... }
 ... when any
+}
+
 valid_frames = ice_lbtest_receive_frames(...);


Regards,
Markus

