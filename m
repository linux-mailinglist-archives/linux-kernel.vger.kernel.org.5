Return-Path: <linux-kernel+bounces-111278-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BC079886A06
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 11:16:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED2E81C20F8B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 10:16:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2F5E383B9;
	Fri, 22 Mar 2024 10:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="Y2ReAm1C"
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C70926ADB;
	Fri, 22 Mar 2024 10:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711102570; cv=none; b=AR+wv5zqn0D91qd2/VWbQAAT2yA8RYRr8pD22gWT95pe47bv3M5uWyFqHszfpUcgmqBJbuGDzX4GVzLpqdCj9HnQ72XDyAKwCGDePI3muEwKpTIPu7OtTN+qD7SFQ1WUMK6pgz1+Vwiv0jGzzCdKqrAq+ffK/8Wlf/ir+89QawQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711102570; c=relaxed/simple;
	bh=GadESi8ONSV56erp89XTT+vSta6NjyXh9DD7OG2fFAk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GzhD8K+syW30a0xPXWftCf6RkJwjT81eUQ/qqHiw9tt35KOmjoM10zlyB0S23uFlKscVoDCghNnsxCuTu0zhMPpxFmMCJxiSNVYLqLEY+fkswO+6oitxHZqnXhNhIqGZSJk5tjvDrGQRwSddP1aiO8Eh99nd8GzWamr2JHirGbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=Y2ReAm1C; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1711102564; x=1711707364; i=markus.elfring@web.de;
	bh=YITSdSNKjtGWKQJCqVlDxMIGXLNZSJ1FOmf8VqHMVLI=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=Y2ReAm1Cd4sNe5u0ne9uK6PLGurzdh+kkALmaxx1M8WJ19BTpB/sxYqatqgkFwzP
	 HNF6CiMavemFWZHCjCubLFrgKKREtpcm54KNbLjWzuDbNgiCTymtjqR23i11rdQhb
	 /jsC0CFngbzNkN5VYgk6g9PyNKArXi5Mrpdfnjj+8m3wLJeQ+ifFhl1ZzhMRiju1f
	 9ASJjnPNlrnDdQAZBiLiUD8HpjBHbUSXIl3tqKcquS2n347ya0QQ1U3zAb0PyBpt1
	 cmsN0xV+5bpWjRmzfaTXqNXoLqHvTf/2sVlyTXTYeAwf0dMUTQrJgA9vrYO/Sy0xn
	 tyLUC+DMpTYrbbW5Pw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.90.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mfc4q-1r7vNl0NY0-00jbRy; Fri, 22
 Mar 2024 11:10:13 +0100
Message-ID: <9b09c797-2b01-40d8-9e83-ecb6e25ee78a@web.de>
Date: Fri, 22 Mar 2024 11:10:10 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v2] ice: Fix freeing uninitialized pointers
Content-Language: en-GB
To: Dan Carpenter <dan.carpenter@linaro.org>,
 kernel-janitors@vger.kernel.org, netdev@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org
Cc: Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>, LKML
 <linux-kernel@vger.kernel.org>,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 David Laight <David.Laight@aculab.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Jesse Brandeburg <jesse.brandeburg@intel.com>, Jiri Pirko
 <jiri@resnulli.us>, Jonathan Cameron <jic23@kernel.org>,
 Julia Lawall <julia.lawall@inria.fr>, Kees Cook <keescook@chromium.org>,
 Lukasz Czapnik <lukasz.czapnik@intel.com>, Paolo Abeni <pabeni@redhat.com>,
 Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>,
 Dan Williams <dan.j.williams@intel.com>
References: <0efe132b-b343-4438-bb00-5a4b82722ed3@moroto.mountain>
 <0d7062e1-995b-42bc-8a62-d57c8cb588ee@web.de>
 <7ca4a907-2a9c-4711-a13c-22cbfec15e0e@moroto.mountain>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <7ca4a907-2a9c-4711-a13c-22cbfec15e0e@moroto.mountain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:OPtKNGD3xEcd1Z7sJW7cRkjajBmWMTdxQ7djE0xUhQ1czhFk4yH
 OVOh6h+sux0OGb4dFA5OaxAiv2F5OWxkUlsDdTB4f5Pvtz2WBLmL0CV0DgoYjprq1yAbO5G
 b1/blJMXPlAmdOtqF6VrJzL01o8nYCkjLkbKyX1X5vVNYHTjvXF9uZyFXaI1Skgc3NRMsNq
 SWWI3YTNfkGNTd1Y5yQHw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:HTHlWZPjstg=;x80qYP9/CGxP7aDaVgcrNlTbZCo
 8+g3feTSIdzmhy59CGiNd+Y2CkUnn3bhYyjDFbhgKuFyi2US31K4d4Ssaxf46f6LbTg0mG2VT
 Ab/N2Olz2GjX0FyMg45JwCzWCYE3uD8KY6fMpk12gmaM6V/5MVZwjpKZEWSG5ZNrWLTTucvh4
 QK3vq3Vdj4ySXAb4t0aO61TTUM731MJyrzzSkQTo4+OtNBwkWxj2988EECm13MTv/p8yLdU2z
 Tvuh3H/k1ZQVZRpJIGsZzewOm2nD8xRl96OzPcwnbfPrcblQd2aXfTvhAXJrtfOr+kUiZplDN
 ztRgIs3VeZ/IM7zUAxg/9k/G1gH8hPV/p5sr7/nDRAhsOwzbYPNipSEE0VUoV+C9NDVrr1WzD
 J3gxC7v4YH//04J2kPQG4NYGA+B5e5csAAJbPtw/VuQ4IIeWli1Pxz5gXDxMiwpzd2dCiivtU
 4c4CwlgrN2r/+O8qNKWxwnnOYZrPaaM3Acgk24988vlrWUEGwT3VuA1ZWnNnx8KW5zY4AIQkj
 TN8LcARbvYrz3PIFKLvS5gxFwB3qhL5CY8Pfi9xr6Ya3EmZPJXsCrWt7UNUdxiHrFezfRks+j
 i5RCd4l79gskUd+XK89dCmxsQbpFvxLciO8Bs7alT7ijXgrcyXH+8SqrL3YvswgZ8et8Cj4Kg
 SRs5UcH8oE0TFL7Xd1fPlkRViExswSYDryUW8adaulV5vmf9993ce+YQplB2juw4X/+5hr8Rc
 Pxd8Z2+k0GNykhsagBTe5nrJ1vlFpRZUzmKhdwWd+W6Xag6D6gkUzAxVIBHdTd5DPIAFsOG0O
 tiMMF+iecfcmaEdmBPSHq00WfyvuMa/OjmqXEAy0kMyO8=

> Markus please don't do this.  Don't take a controversial opinion and
> start trying to force it on everyone via review comments and an
> automatic converstion script.

I dare also to point additional change possibilities out.
I hope that further collateral evolution will become better supported.

Regards,
Markus

