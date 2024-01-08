Return-Path: <linux-kernel+bounces-19347-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A9480826BBF
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 11:45:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 294CA1F2241A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 10:45:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E19A14003;
	Mon,  8 Jan 2024 10:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="k21KExxp"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2BF913FF9
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 10:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20240108104513epoutp0272d4d1d601174fd323290c3a17759114~oWVyyHmdR1293112931epoutp02I
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 10:45:13 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20240108104513epoutp0272d4d1d601174fd323290c3a17759114~oWVyyHmdR1293112931epoutp02I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1704710713;
	bh=VI35WOvM05mq91vKfs0YbsSGzl5OBL9IzJJ5SxDZlhM=;
	h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
	b=k21KExxpFnxBlA9rBuzOesZwgWVi2+FR7d7yOTnzqjK9UfwPuuiwUQXxSpw4elGwf
	 BYhJnKWJ4PNesJMVZOc0Q+ip9P5H8Bm6x2Q3A/K90XRpr2KUat9PeSMCjjf1XleJIm
	 r4njCXloX5rVyLvvMGabPK+zshbDu5h4U7GzJ0gU=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTP id
	20240108104513epcas5p42a391cf5e162601bcb85a685294342a3~oWVycyjPX3223932239epcas5p47;
	Mon,  8 Jan 2024 10:45:13 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.180]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4T7rLH4QCKz4x9Q2; Mon,  8 Jan
	2024 10:45:11 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
	epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	5E.F8.09634.732DB956; Mon,  8 Jan 2024 19:45:11 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20240108104511epcas5p33f0e99b590428da7c40fb613017fd656~oWVwhhRoD1632416324epcas5p3H;
	Mon,  8 Jan 2024 10:45:11 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240108104511epsmtrp2309a415f95bbcc9b0599c86300935d96~oWVwg2k_z0363303633epsmtrp2U;
	Mon,  8 Jan 2024 10:45:11 +0000 (GMT)
X-AuditID: b6c32a49-159fd700000025a2-b3-659bd2375ced
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	C1.5E.08755.632DB956; Mon,  8 Jan 2024 19:45:11 +0900 (KST)
Received: from SRIB7IJ5F5BM8F (unknown [107.108.206.9]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240108104509epsmtip1c4f449b93a7a96363ff0dd48efd556fd~oWVu2Ntpd0678306783epsmtip1X;
	Mon,  8 Jan 2024 10:45:09 +0000 (GMT)
From: "sandeep.cs" <sandeep.cs@samsung.com>
To: "'Joe Perches'" <joe@perches.com>, "'Jiri Kosina'" <jikos@kernel.org>,
	"'Benjamin Tissoires'" <benjamin.tissoires@redhat.com>
Cc: <gaudium.lee@samsung.com>, <ih0923.kim@samsung.com>,
	<suhyun_.kim@samsung.com>, <jitender.s21@samsung.com>,
	<junwan.cho@samsung.com>, <linux-input@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
In-Reply-To: <486973921f89f70bcc5d42501eeca3fd105be2c4.camel@perches.com>
Subject: RE: [HID Patchsets for Samsung driver v2 2/6] HID: Samsung : Fix
 the checkpatch complain.
Date: Mon, 8 Jan 2024 16:14:58 +0530
Message-ID: <020e01da421f$c0d20660$42761320$@samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQGnAMfWRo+zFj79MMHZQSbz6pOJPAGgO/sIAfyMtNQBptQ1H7EMH2NA
Content-Language: en-in
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrFJsWRmVeSWpSXmKPExsWy7bCmlq75pdmpBrP7ZC2uT9nManF7gafF
	1iVzWS1uHW9ltHj5YAO7xez7j1ksNk9+xGJx89M3VovLu+awWTxasYnJgctj06pONo8vq64x
	e7zfd5XNo2/LKkaPz5vkAlijsm0yUhNTUosUUvOS81My89JtlbyD453jTc0MDHUNLS3MlRTy
	EnNTbZVcfAJ03TJzgI5SUihLzCkFCgUkFhcr6dvZFOWXlqQqZOQXl9gqpRak5BSYFOgVJ+YW
	l+al6+WlllgZGhgYmQIVJmRn3H1ymrngj3TFn5mGDYzfRbsYOTkkBEwk5v19ytjFyMUhJLCb
	UeLgpG/MEM4nRomf+7+yg1QJCXxjlNhxpA6m4/SxiawQ8b2MEhc2VEA0vGGUWLv6JgtIgk1A
	W2LG32tgk0QEmhklbkyYBLaDWeAso8T5r71gVZwCnhJHfr0AWyEskCLx9eRDRhCbRUBFYmPD
	LGYQm1fAUqJvch8ThC0ocXLmE7BeZgF5ie1v5zBDnKQg8fPpMrCTRATcJF7OmsMIUSMucfRn
	D9gVEgJrOSS2b1rACtHgInFxfjMbhC0s8er4FnYIW0ri87u9bBAN3YwSS28fY4dwZjBKtOy8
	CrXOXuLn6wlAVRxAKzQl1u/Sh9jGJ9H7+wkTSFhCgFeio00IolpF4mnXblaY+d9PbGSCsD0k
	/v9YwTiBUXEWkt9mIfltFpIfZiEsW8DIsopRMrWgODc9tdi0wDAvtRwe48n5uZsYwYlWy3MH
	490HH/QOMTJxMB5ilOBgVhLhlZwxO1WINyWxsiq1KD++qDQntfgQoykwwCcyS4km5wNTfV5J
	vKGJpYGJmZmZiaWxmaGSOO/r1rkpQgLpiSWp2ampBalFMH1MHJxSDUxM0/g3JLmm/n5xT/H0
	21TbDan2PhHVWRZfrL+F89y2MtFSutjtfY7/0Qyty4dbLie91l8V5MIyQ6J68gGvP1UXAuPu
	t6W7yJruv7pb8fzjrrClT0+qTGUPvXcs4lvOkdzfz804mxMPNce/najxapnf2lVv3/tY5Mrt
	sJJXMDBZt2fBC4EZGmFXNFf8YL3B6D/x2enpJd1Lj3I/PqpmyXb9vKBAx0dN0+sbJ1kujf5f
	mf9Pls9rJeurxHaVn8VppgazFok0eB66/qLqy4psA4Oq23bfZ/WxpaxqynsidqzSy+h3UvfH
	JX8vT+2yvRQfFX73wP6YXrYr2Uk72L8utVazeD77/YU1/ZwG017sClusxFKckWioxVxUnAgA
	cpO3+j0EAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupjkeLIzCtJLcpLzFFi42LZdlhJTtf80uxUg/PlFtenbGa1uL3A02Lr
	krmsFreOtzJavHywgd1i9v3HLBabJz9isbj56RurxeVdc9gsHq3YxOTA5bFpVSebx5dV15g9
	3u+7yubRt2UVo8fnTXIBrFFcNimpOZllqUX6dglcGXefnGYu+CNd8WemYQPjd9EuRk4OCQET
	idPHJrJ2MXJxCAnsZpTYs+oyO0RCSmLV9XuMELawxMp/z9khil4xSmx48oMJJMEmoC0x4+81
	ZpCEiEAro8S95afAEswClxkl7q/OBbGFBP4xSuy7bQJicwp4Shz59QJsg7BAksT9D9PZQGwW
	ARWJjQ2zmEFsXgFLib7JfUwQtqDEyZlPWLoYOYBm6km0bWSEGC8vsf3tHGaI4xQkfj5dxgpi
	iwi4SbycNQeqRlzi6M8e5gmMwrOQTJqFMGkWkkmzkHQsYGRZxSiZWlCcm55bbFhgmJdarlec
	mFtcmpeul5yfu4kRHGVamjsYt6/6oHeIkYmD8RCjBAezkgiv5IzZqUK8KYmVValF+fFFpTmp
	xYcYpTlYlMR5xV/0pggJpCeWpGanphakFsFkmTg4pRqYVCZmrKy8+b4iKLSzMttv6plZe9hO
	sy0w0O2711H3zOWbmKisy9Ni7jkGDkIpzzgqZkyZ+P3cvX+Tiu29l6kGFHTMOPD7ccQy6++f
	P/qb5W/ibq/+GZ318rLl1SmsViolM6r8/NaYpvxL0F0vJrLtr3bShMerdj0qfyHa8i0pXbNB
	z3PdnR/83emMm20KHX8+8BfsfHdO7a2Y0UebnzUP2NQkmr6bXGc877Sna4rZMR2FcvWsFBZt
	me8XdjLvLdaaPd/vRJXqlRuc2tqb7t2JlFlUEjyjoqKp8NHTviVK4svs5zR9v37Db1ce/zuF
	x+KvixKvWa5X/vWyslys/3NywPOzETM+Xdtu0b7y77FMJZbijERDLeai4kQAo1SRsSEDAAA=
X-CMS-MailID: 20240108104511epcas5p33f0e99b590428da7c40fb613017fd656
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240108091959epcas5p2559b779424e2fb7c7e268d1b24612b4f
References: <20240108091917.1552013-1-sandeep.cs@samsung.com>
	<CGME20240108091959epcas5p2559b779424e2fb7c7e268d1b24612b4f@epcas5p2.samsung.com>
	<20240108091917.1552013-3-sandeep.cs@samsung.com>
	<486973921f89f70bcc5d42501eeca3fd105be2c4.camel@perches.com>

>On Mon, 2024-01-08 at 14:49 +0530, Sandeep C S wrote:
>> Warning found by checkpatch.pl script.
>[]
>> diff --git a/drivers/hid/hid-samsung.c b/drivers/hid/hid-samsung.c
>[]
>> @@ -67,20 +67,17 @@ static __u8 *samsung_irda_report_fixup(struct
>hid_device *hdev, __u8 *rdesc,
>>  		rdesc[178] = 0x08;
>>  		rdesc[180] = 0x06;
>>  		rdesc[182] = 0x42;
>> -	} else
>> -	if (*rsize == 203 && rdesc[192] == 0x15 && rdesc[193] == 0x0 &&
>> +	} else if (*rsize == 203 && rdesc[192] == 0x15 && rdesc[193] == 0x0
>> +&&
>>  			rdesc[194] == 0x25 && rdesc[195] == 0x12) {
>>  		samsung_irda_dev_trace(hdev, 203);
>>  		rdesc[193] = 0x1;
>>  		rdesc[195] = 0xf;
>> -	} else
>> -	if (*rsize == 135 && rdesc[124] == 0x15 && rdesc[125] == 0x0 &&
>> +	} else if (*rsize == 135 && rdesc[124] == 0x15 && rdesc[125] == 0x0
>> +&&
>>  			rdesc[126] == 0x25 && rdesc[127] == 0x11) {
>>  		samsung_irda_dev_trace(hdev, 135);
>>  		rdesc[125] = 0x1;
>>  		rdesc[127] = 0xe;
>> -	} else
>> -	if (*rsize == 171 && rdesc[160] == 0x15 && rdesc[161] == 0x0 &&
>> +	} else if (*rsize == 171 && rdesc[160] == 0x15 && rdesc[161] == 0x0
>> +&&
>>  			rdesc[162] == 0x25 && rdesc[163] == 0x01) {
>>  		samsung_irda_dev_trace(hdev, 171);
>>  		rdesc[161] = 0x1;
>
>For this block, I think a rewrite using memcmp would be clearer.
>Something like: 
Okay . Thanks for your valuable feedback. We will promptly address your
suggestions and enhance our code accordingly.
And also please review other patch set as well.
Thank you
>---
> drivers/hid/hid-samsung.c | 34 +++++++++++++++-------------------
> 1 file changed, 15 insertions(+), 19 deletions(-)
>
>diff --git a/drivers/hid/hid-samsung.c b/drivers/hid/hid-samsung.c index
>cf5992e970940..cd84fb5e68f69 100644
>--- a/drivers/hid/hid-samsung.c
>+++ b/drivers/hid/hid-samsung.c
>@@ -58,33 +58,29 @@ static inline void samsung_irda_dev_trace(struct
>hid_device *hdev,  static __u8 *samsung_irda_report_fixup(struct hid_device
>*hdev, __u8 *rdesc,
> 		unsigned int *rsize)
> {
>-	if (*rsize == 184 && rdesc[175] == 0x25 && rdesc[176] == 0x40 &&
>-			rdesc[177] == 0x75 && rdesc[178] == 0x30 &&
>-			rdesc[179] == 0x95 && rdesc[180] == 0x01 &&
>-			rdesc[182] == 0x40) {
>+	if (*rsize == 184 &&
>+	    !memcmp(&rdesc[175], "\x25\x40\x75\x30\x95\x01", 6) &&
>+	    rdesc[182] == 0x40) {
> 		samsung_irda_dev_trace(hdev, 184);
> 		rdesc[176] = 0xff;
> 		rdesc[178] = 0x08;
> 		rdesc[180] = 0x06;
> 		rdesc[182] = 0x42;
>-	} else
>-	if (*rsize == 203 && rdesc[192] == 0x15 && rdesc[193] == 0x0 &&
>-			rdesc[194] == 0x25 && rdesc[195] == 0x12) {
>+	} else if (*rsize == 203 &&
>+		   !memcmp(&rdesc[192], "\x15\x00\x25\x12", 4)) {
> 		samsung_irda_dev_trace(hdev, 203);
>-		rdesc[193] = 0x1;
>-		rdesc[195] = 0xf;
>-	} else
>-	if (*rsize == 135 && rdesc[124] == 0x15 && rdesc[125] == 0x0 &&
>-			rdesc[126] == 0x25 && rdesc[127] == 0x11) {
>+		rdesc[193] = 0x01;
>+		rdesc[195] = 0x0f;
>+	} else if (*rsize == 135 &&
>+		   !memcmp(&rdesc[124], "\x15\x00\x25\x11", 4)) {
> 		samsung_irda_dev_trace(hdev, 135);
>-		rdesc[125] = 0x1;
>-		rdesc[127] = 0xe;
>-	} else
>-	if (*rsize == 171 && rdesc[160] == 0x15 && rdesc[161] == 0x0 &&
>-			rdesc[162] == 0x25 && rdesc[163] == 0x01) {
>+		rdesc[125] = 0x01;
>+		rdesc[127] = 0x0e;
>+	} else if (*rsize == 171 &&
>+		   !memcmp(&rdesc[160], "\x15\x00\x25\x01", 4)) {
> 		samsung_irda_dev_trace(hdev, 171);
>-		rdesc[161] = 0x1;
>-		rdesc[163] = 0x3;
>+		rdesc[161] = 0x01;
>+		rdesc[163] = 0x03;
> 	}
> 	return rdesc;
> }



