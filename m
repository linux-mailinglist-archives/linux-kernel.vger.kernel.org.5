Return-Path: <linux-kernel+bounces-105442-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C134D87DDE8
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 16:23:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CFFF2813D7
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 15:23:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DA401CA96;
	Sun, 17 Mar 2024 15:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=erick.archer@gmx.com header.b="eT598qn6"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E6751C69D;
	Sun, 17 Mar 2024 15:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710688982; cv=none; b=HJGXLrP9ViDQec/gjngRWO8/dRZ+c/maT9YzL6bTCA4Hnt+9IEW3ZT59AF8Y+FebhTLG/aUZ/8rDIMslQDkwcI4sAHF53R4MiOZZ26N75UqeCbf4SHhZg+Tuuwl0fAyj+zPGb04uJqlCitwzrsQXAa3KimexFBr70orCXc98R2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710688982; c=relaxed/simple;
	bh=lh2MHlp2ckMexGLnsmI0DncTe+skZ/F6FnmSJx8LNLs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RK83rpNctP4II4tII4p5H4995WRfuDwDZPOQErm96VcCvgHOG6ncPlwLpByUELdbt01EXXMn+dq67zsYkZ2Ce7yAhtsMIrQfIHi2BNCWWXuxKUPLrqahOtMvIZ3bwRtknhVQVD/LubF14qSaNQ+G9tAKDIl0qR01jjAvoxTD1Rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=erick.archer@gmx.com header.b=eT598qn6; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1710688956; x=1711293756; i=erick.archer@gmx.com;
	bh=4HoP6GUCEhqxSXr5hp5FLvKgj6o9jMRN49ibj6948Ew=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:
	 In-Reply-To;
	b=eT598qn6JeaalM1r4RmXQVJsmphHcUe+tbZgBvsuB+pTv9mgmkiMaxTskuJdh0zS
	 nqK8sthFLkA7kJzqFWFbXkF83/NF/A5DMyS8p+bsyPaVT4RG51Q9aporhnCyIFmAQ
	 f6LB18Bg7paBwc6hwNdLWKCERU6YegLoPb7bNCF/y0I72DAU+J3xN3N55r9eByVXr
	 DkR1CW/z29wWfEJs/vmFnjk6QsppFXTJ2y6gvgQNU1UcYwPWajOZTEaaaHeBFKG0M
	 3wlj+IYLP/Z35RvqXdvL4M7NV4XIXduIZgYK04fp+QHpYZnUTpFtmiEfnaud6GZxw
	 XugVUNgl3RZBtSwaVw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from titan ([79.157.194.183]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MJE2D-1rVi8V0wYd-00KirB; Sun, 17
 Mar 2024 16:22:36 +0100
Date: Sun, 17 Mar 2024 16:22:25 +0100
From: Erick Archer <erick.archer@gmx.com>
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: Erick Archer <erick.archer@gmx.com>, Kalle Valo <kvalo@kernel.org>,
	Johannes Berg <johannes.berg@intel.com>,
	Kees Cook <keescook@chromium.org>, linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] mwl8k: Avoid overlapping composite structs that contain
 flex-arrays
Message-ID: <20240317152225.GA2850@titan>
References: <20240316150712.4633-1-erick.archer@gmx.com>
 <cfc4c4c0-83f8-437c-8146-6b86968db67b@embeddedor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cfc4c4c0-83f8-437c-8146-6b86968db67b@embeddedor.com>
X-Provags-ID: V03:K1:iJSmX0g5bCjMfunDwDcxRBemvxA3sjELLaorhmxZxOOKFPz15cS
 lexxXL/fS6hfnoKdd1Cjbc3I+zLkWqQjp9BOQoyN47U33mu4kUE9z2KWxBheNIUAJ4DMO1d
 1inSFW3Gr1pCDnRRIF6M2y2x2PUpSP2njBglcxgOSg9RK6iVz+vgy9L5mTrnl1e3ctEP1Ao
 q+hv8SV7isarp9OwLkLow==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:HvsWI6BjGPo=;J4J2pYE0PSII/hrBc70lKcFg4X2
 am2ZTLIRcO582PnieP8iYg6pWc0G2ahvPVjvdMpZlXt5I7QsURD+MmauSXbshn1CUmu6iNrsJ
 vcjoz/7afePOcAJPnWg0MdpW5PDkZ0Na12JY+UpYcx7bpMc2vExKI+AKVVtKRmr9r+yoNXXDq
 Uv2PXagj10MOcMXOLTlOg3Yqma4Xyys8Gvj2hOqFQhSUoJHQnojV5jrw3YkfIMKQfSztCq75r
 jwU2fUtzto/Oj9rd8iqqg4EVzXNSiAvLHN4F4t2ke6W7mUj/zo0d7dBW3/fyI/6dYqKP/Nj8O
 evX10tzKMZNKhxV9qX+IVaBQZipZu8uBIkecZ4+CBfqPSDsAx/WpVG4iNVL6+zv2DEHbTTP5F
 Zl4N1fs/kG4gFG2r26qOkSLbPqfv8HXpF1nRTT1pjB7rld8xd9tK4WJQwUGubmmIutS1VOr11
 GiBl73Acp8+z55qLtbvAm+YiUxaOeC91vcRTOwW0UdUM59Wc2EqCcJWs46zvIWDQReJbxskt7
 Eh/kV5LlSP+BYcRVpmwZ/HGUB6lljDhyH5vXtF5V7cyvyMiLCcSFpt1C3QyWFCTJl29CYantk
 KGbyrczaZWP+YDhEFxAmjcQGtDAq822pGRRpXFYZVD12zxs89UPI+el125bAWTs6I2YEoNOLk
 BLjHloSAQ8rOk/v3lwNlTl5N0hAEZC9CZO3wpIojnHgTbOiocNvD/JsW/5/rbR4cffp1djk1H
 QoWHZuoVGpWsKFgsfhiSj5smrihe4EcJjPzIiig645MB7ZWJvtmhW5fPdQvgw0A4jeAmGBTbq
 5l/HTJr2EZZgeihSwgVlAde4TA2Y91L4kAyjPpCWJ1t4M=
Content-Transfer-Encoding: quoted-printable

Hi Gustavo,

On Sat, Mar 16, 2024 at 12:59:11PM -0600, Gustavo A. R. Silva wrote:
>
> [..]
>
> >
> > Link: https://github.com/KSPP/linux/issues/202 [1]
> > Signed-off-by: Erick Archer <erick.archer@gmx.com>
> > ---
> > Hi everyone,
> >
> > This patch is based on my understanding of the code. Any comments woul=
d
> > be greatly appreciated.
>
> Thanks for looking into this. :)
>
> I'm currently in the process of trying a general solution for all these
> composite structures without having to use two separate structs, avoid t=
oo
> much code churn, and continue allowing for __counted_by() annotations at
> the same time.

I searched the mailing list and found several of your patches:

Link: https://lore.kernel.org/linux-hardening/ZfCXBykRw5XqBvf0@neat/
Link: https://lore.kernel.org/linux-hardening/cover.1709658886.git.gustavo=
ars@kernel.org/
Link: https://lore.kernel.org/linux-hardening/ZeeaRuTpuxInH6ZB@neat/

In all of them you use the `struct_group_tagged()` helper to solve the
overlapping scenario. Great proposal ;)

> I'll be sending a bunch of patches once the merge window closes. So, for
> now, I think it's wise to wait for those patches.

So, are you working in a patch for the "mwl8k"? Or do you prefer
a v2 of this patch based on your proposal?

>
> More comments below.
>
> [..]
>
> > diff --git a/drivers/net/wireless/marvell/mwl8k.c b/drivers/net/wirele=
ss/marvell/mwl8k.c
> > index ce8fea76dbb2..57de32ba4efc 100644
> > --- a/drivers/net/wireless/marvell/mwl8k.c
> > +++ b/drivers/net/wireless/marvell/mwl8k.c
> > @@ -586,13 +586,17 @@ static int mwl8k_request_firmware(struct mwl8k_p=
riv *priv, char *fw_image,
> >   	return 0;
> >   }
> >
> > -struct mwl8k_cmd_pkt {
> > +struct mwl8k_cmd_pkt_hdr {
> >   	__le16	code;
> >   	__le16	length;
> >   	__u8	seq_num;
> >   	__u8	macid;
> >   	__le16	result;
> > -	char	payload[];
> > +} __packed;
> > +
> > +struct mwl8k_cmd_pkt {
> > +	struct mwl8k_cmd_pkt_hdr header;
> > +	char payload[];
> >   } __packed;
>
> One of the problems with this is that `struct mwl8k_cmd_pkt` is candidat=
e for a
> `__counted_by()` annotation:
>
> @@ -592,7 +592,7 @@ struct mwl8k_cmd_pkt {
>         __u8    seq_num;
>         __u8    macid;
>         __le16  result;
> -       char    payload[];
> +       char    payload[] __counted_by(length);
>  } __packed;
>
> and with the changes you propose, that is not possible anymore because t=
he counter
> member must be at the same level or in an anonymous struct also at the s=
ame level
> as `payload`.

Ok, I understand the problem you raise and I agree.
Anyway, thanks for your comments.

Best regards,
Erick

> Thanks
> --
> Gustavo
>

