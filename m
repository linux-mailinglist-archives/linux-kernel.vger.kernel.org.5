Return-Path: <linux-kernel+bounces-45988-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 229EF8438D0
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 09:23:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0E401F26D07
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 08:23:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DEF55BAFF;
	Wed, 31 Jan 2024 08:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="omV54Azr"
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D428C5820A
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 08:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706689405; cv=none; b=dELP2owMIry03+bj6niuOp+eh0hzPuq4X0Lk+ssHHz8qUqAuKW3PFRpAD+/tVHycXNfPbm6n8lDUYnjwNXE0wcX9iAz85M/99i1og9WyZLENX3H5uRqqSQc6tq10gq0+byBU7DY2dGsE3r5frfDm8P/4uPyNQcxYS0azVARTwvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706689405; c=relaxed/simple;
	bh=nBU5GIbHBpl22p3MAZ75n0AGDakCxqSHTQMAC98VDOQ=;
	h=From:To:In-Reply-To:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:References; b=s+nVNo35De4mAxsCuC5WNq6pNzz9Wk5T6q+/qRm3ZVlxygzehGSwme54/KyGtvWxGI3iNCqMsouubO9/7b48Hgqwot9zrXxa4Rm28+sA9g0RFnSdnXO5hCunJ9qvhF41T8CBtN5zJA8Worxl123NB/3SV3j07rsS1LVT5frqkmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=omV54Azr; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20240131082314epoutp02d97d516c5b8ae450b3a6e975cac90e03~vYPZVtV6b2907429074epoutp02z
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 08:23:14 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20240131082314epoutp02d97d516c5b8ae450b3a6e975cac90e03~vYPZVtV6b2907429074epoutp02z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1706689394;
	bh=nBU5GIbHBpl22p3MAZ75n0AGDakCxqSHTQMAC98VDOQ=;
	h=From:To:In-Reply-To:Subject:Date:References:From;
	b=omV54Azrk6eywNcCUkJgEDELJQfPTJgwGG63FitI+N14hmQT0oo+ZpQbj6gkOoIJA
	 rtSN2yUCxK7LbhxJb7tavGEH433z+gmnY9mvaoTWMxyfE/0XXuJpmdhLAiXGwGkO+W
	 yNNASBYI/qokH7jiWlH118rnbClKd9bDCCVCwUIY=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas2p2.samsung.com (KnoxPortal) with ESMTP id
	20240131082314epcas2p2442dfd97e8db4c01b6d4d9fb5dd63958~vYPY7prZ32644126441epcas2p2S;
	Wed, 31 Jan 2024 08:23:14 +0000 (GMT)
Received: from epsmgec2p1-new.samsung.com (unknown [182.195.36.100]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4TPw5s5Dq7z4x9Q7; Wed, 31 Jan
	2024 08:23:13 +0000 (GMT)
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
	epsmgec2p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
	6F.2B.18994.1730AB56; Wed, 31 Jan 2024 17:23:13 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas2p3.samsung.com (KnoxPortal) with ESMTPA id
	20240131082313epcas2p3f802bae1d9682b8df442891fcb27d073~vYPXr6Xw51750117501epcas2p3D;
	Wed, 31 Jan 2024 08:23:13 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240131082313epsmtrp23cb8f2e48d962f52edc681e6e6ae9765~vYPXq6Ykm2025320253epsmtrp2e;
	Wed, 31 Jan 2024 08:23:13 +0000 (GMT)
X-AuditID: b6c32a4d-743ff70000004a32-63-65ba0371b252
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	D6.E4.07368.0730AB56; Wed, 31 Jan 2024 17:23:13 +0900 (KST)
Received: from KORCO118546 (unknown [10.229.38.108]) by epsmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20240131082312epsmtip233b17a2b4a83802cf2587f391f35b4d6~vYPXdS__p0197401974epsmtip2r;
	Wed, 31 Jan 2024 08:23:12 +0000 (GMT)
From: "hoyoung seo" <hy50.seo@samsung.com>
To: "'Bart Van Assche'" <bvanassche@acm.org>, <linux-scsi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <alim.akhtar@samsung.com>,
	<avri.altman@wdc.com>, <jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
	<beanhuo@micron.com>, <kwangwon.min@samsung.com>, <kwmad.kim@samsung.com>,
	<sh425.lee@samsung.com>, <sc.suh@samsung.com>, <quic_nguyenb@quicinc.com>,
	<cpgs@samsung.com>, <grant.jung@samsung.com>, <junwoo80.lee@samsung.com>
In-Reply-To: <92463403-ea32-4545-a466-21243cd454e2@acm.org>
Subject: RE: [PATCH v1] scsi: ufs: core: Remove the ufshcd_release in
 ufshcd_err_handling_prepare
Date: Wed, 31 Jan 2024 17:23:12 +0900
Message-ID: <000001da541e$bb358590$31a090b0$@samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQH1h0Q8JIMtOyfGxnoTUCtVKJ9etQJjCVVCAjugl6QCof4DrwJoFjdRsG/Y62A=
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA02TcUwTVxzH8+7OayGpuR21exKn9TZF2MC2A3ps1CzBzToUUZfNuCXdUW7A
	WtrSKwxBF2ABoQQEo3O0YsQ50BphVCBQadQi4haY2wDpWADNBq4wlQmysQW2lmMb/33f9z7f
	d7/ve3dClLyDhwozDBbWbGD0FB6MtXWFKyOzUBcrK/5sC33vTBtO++YHcfrG/TKM/nR6HqV9
	nnD6z4UmAX3O24bQroVPELrV24HRP7R0Y3S/6zROlw+143RDzyJCn/ylR0BbR7yA/mLxIfYa
	oe4fSFRXnbsO1L83leLq38aHMXV158fqyhYHUM8416uPXi9HkoUHdfHpLJPKmqWsQWtMzTCk
	qajE/ZoETUysTB4pj6OVlNTAZLIqavuu5Mg3MvT++SlpDqPP9lvJDMdRW7fFm43ZFlaabuQs
	Koo1pepNSlMUx2Ry2Ya0KANreUUukyli/OD7uvTjx942VRG5Q/1ToADcFllBkBAS0dBTeAGx
	gmAhSXQCWFW4iPKLJwC2zlzD+MUcgM6uC7gVCJcilz5/h/fdAD69P40EtiIJH4CXKz8IaJyI
	gMcetuABSEy4UNg82oAFHgQRr8Ly5jtoQIcQWjg4d1IQ2BQjNsHei2TAFhFxcLayHef1M/Cr
	mp+XoijxIqyvm0L5saVwfrx+VSAqJpLg5ZLneEQM7WUlSwUgcU8I3ZM1gOe3w5HRWwivQ+Bk
	T4uA16Fw5pF7uRcHbXX5fLYAQI/dtsy8DG0TR0GAQYlw2OTayuPPw5vDy5OthqVdC8u0CBY0
	/yXgEREsLSF5m4K9tT8u2xDesOurAGVbUdG2oqJtRRfb/689CzAHCGVNXGYaq1WY5JEG9qP/
	7lprzHSCpS87Ync7mGpaiPIARAg8AApRSiy6uL6DJUWpzKE81mzUmLP1LOcBMf5zr0ZD12iN
	/l/DYNHIo+Nk0bGxcqUiRqaknhWNFtemkkQaY2F1LGtizf/mEGFQaAGi3ng196cJeeOjuLUq
	pqyrQpwnSXEU7itb1TDdc1znWGebT5nFTmm2Dc/NH5Z4rOMTfXs3jQTX3ZVUdHiDHwzsKr6J
	oo6JrksbclKUT5NI8u+3Buo7i47cyj9gROx7vn+MTw6Hfbu3tn9s7AVONrZT8no303Zi3eYI
	GbaTyNvRyJzHfbcV0jfFchCiXcxSfdc4dC23UHM4/pv9fxzpO3iGWC0p1bnBWUVYwkuD+5Si
	XEW+0QIde34Nu1tzpSpv9nF1hXXI5y063+v+emSzb+OaQ8U+85dX7XTOg+5TjXpxyIE+GxmS
	+GES3XriypOoog3l71UnvFtrd7owZ1bjloy1FMalM/II1Mwx/wCl+whXYgQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrHIsWRmVeSWpSXmKPExsWy7bCSvG4h865Ug1PfGS0ezNvGZvHy51U2
	i4MPO1kspn34yWzx8pCmxa+/69ktFt3YxmSx628zk8XWGztZLG5uOcpicXnXHDaL7us72CyW
	H//HZDH1xXF2i667Nxgtlv57y+Ig4HH5irfHhEUHGD2+r+9g8/j49BaLx8Q9dR59W1Yxenze
	JOfRfqCbKYAjissmJTUnsyy1SN8ugStj/jP3guf8FQc7p7I0MC7k7WLk4JAQMJFYvTi8i5GL
	Q0hgN6NE1/QjjF2MnEBxCYn/i5uYIGxhifstR1ghip4zSlxZs40FJMEmoCXR/3YLG0hCROAc
	s8TJjS9YIKqmM0lsuNPAClLFKWAt0b3xPDOILSyQKHH//UlWkNUsAqoSZ1YKgYR5BSwlvvTt
	YIOwBSVOznwCtoBZQFvi6c2ncPayha+ZIS5SkPj5dBnYGBEBP4m1bbIQJSISszvbmCcwCs1C
	MmkWkkmzkEyahaRlASPLKkbJ1ILi3PTcZMMCw7zUcr3ixNzi0rx0veT83E2M4CjV0tjBeG/+
	P71DjEwcjIcYJTiYlUR4V8rtTBXiTUmsrEotyo8vKs1JLT7EKM3BoiTOazhjdoqQQHpiSWp2
	ampBahFMlomDU6qBiSfZ/O+y+cxr8g+0VP98/2SJ75Zb352ET65QaV1ZmpbFttd/i95SUYer
	bxeez52/2NHLqT/1wz+9lFVvKhVK9k0Mz1Pv/f75Q/HEs7eN1+2/ekf33+a1Z1Ytdor3bWE4
	FLX6AGvY7J+F6TsXm6fMMtmrtkdFZOKnd6ZcXI7fb/umVU3qqlZ6sCs674P7SufTi+WOrOC+
	3MQrWHP5npqMSIpc9rd5rpIJKfFKlwR7+kKeTJ9x5Kb85otuDY7bm+5FT7tzf/67T2HWKdUC
	XMYXOlvKJ7wWOxW/O2sh81XraaIf2H+WNCY9U9I4Fyh77bTXvZnpazwtZvK37M7fFydVe2f5
	TtcgnpXdmxSO+hX+u6/EUpyRaKjFXFScCACgLk/ZQQMAAA==
X-CMS-MailID: 20240131082313epcas2p3f802bae1d9682b8df442891fcb27d073
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-CPGSPASS: Y
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240122083204epcas2p26a1bca522e201972ca072e0b24d23a52
References: <CGME20240122083204epcas2p26a1bca522e201972ca072e0b24d23a52@epcas2p2.samsung.com>
	<20240122083324.11797-1-hy50.seo@samsung.com>
	<06e0ae57-f567-4b90-ad68-4ae73909c29e@acm.org>
	<017501da4da5$405e5ec0$c11b1c40$@samsung.com>
	<92463403-ea32-4545-a466-21243cd454e2@acm.org>

> -----Original Message-----
> From: Bart Van Assche <bvanassche=40acm.org>
> Sent: Thursday, January 25, 2024 1:17 AM
> To: hoyoung seo <hy50.seo=40samsung.com>; linux-scsi=40vger.kernel.org; l=
inux-
> kernel=40vger.kernel.org; alim.akhtar=40samsung.com; avri.altman=40wdc.co=
m;
> jejb=40linux.ibm.com; martin.petersen=40oracle.com; beanhuo=40micron.com;
> kwangwon.min=40samsung.com; kwmad.kim=40samsung.com; sh425.lee=40samsung.=
com;
> sc.suh=40samsung.com; quic_nguyenb=40quicinc.com; cpgs=40samsung.com;
> grant.jung=40samsung.com; junwoo80.lee=40samsung.com
> Subject: Re: =5BPATCH v1=5D scsi: ufs: core: Remove the ufshcd_release in
> ufshcd_err_handling_prepare
>=20
> On 1/22/24 18:38, hoyoung seo wrote:
> > When err_handler is completed, active_reqs becomes negative because
> > ufshcd_release() is called again in ufshcd_err_handling_unprepare().
> > I tested it while printing the log, and if I misanalyzed it, let me kno=
w.
>=20
> Please repeat your analysis. I think this patch is wrong.
>=20
> Thanks,
>=20
> Bart.

Hi,

I do not understand. why you said my patch is wrong.
If ufs entered suspend with hibern8 state then the hba->clk_gating.active_r=
eqs is 1.
After that run wl_resume(), ufs drvier send hibern8 exit command.
At that time, if the command timeout or error occurs, the err_handler is ac=
tivated.=20
Then the active_reqs pair may not fit.

So to sum up, ufs_release() is performed 3 time.
(wl_resume(), ufshcd_err_handling_prepare(), ufshcd_err_handling_unprepare(=
))
And the ufshcd_hold() is performed 2 time(__ufshcd_wl_suspend(), ufshcd_err=
_handling_prepare())
So the paire of active_reqs is not correct.
So I deleted the ufshcd_release() in ufshcd_err_handling_prepare().

The ufshcd_release() was not called again even in the pm_op_in_progress sta=
te in 4.xx version of the kernel.
But now if is_sys_suspended is 1, then ufshcd_release() is called once more=
.
I don't understand why this is added and the pair doesn't fit.

Please check it again.
Thanks.

Seo.


