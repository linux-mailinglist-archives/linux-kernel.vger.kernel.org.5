Return-Path: <linux-kernel+bounces-163728-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ADC68B6EDA
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 11:56:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C58FEB20F14
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 09:56:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94ADA1292F2;
	Tue, 30 Apr 2024 09:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="WP3D70cO"
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54F56128816;
	Tue, 30 Apr 2024 09:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714470955; cv=none; b=Qj0Xk3TuljMrW6YqLUpAiElFULMVeR/9+Hfwm87HUeo7ywJIA5b0ynETJBvmKCK5PrQ9MXXqmRtBDE1MxiwoVrig/OJDWhZFuHz6wT8JzJehTQ0OQGVar6wL7pcCg9/icDsFq+6VLEdmR8Yno3Q4WCCCCc9pCcuHQWSjLiSW7Dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714470955; c=relaxed/simple;
	bh=+PUXHtgYh9FKYDiZd8KDZ2yAOK6C6Lie2+Mixx+MvJk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GyMIZxmMRbmAX8hcpwUT7i2NOIEz2AtY0BWTJmwRDEtpd/YZhA4Uo787xHSQlGMTgqZF6UsADV/gTEcfJzqr3wkzuAGArJeMP1MwKsorSxwIbKZLlBCcvxypmfKo6BS7uoKx3PyCYLWttKZjnVrEhfrxqdSdF4HKrW+DGgcHJ0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=WP3D70cO; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1714470934; x=1715075734; i=markus.elfring@web.de;
	bh=N7SA7MPcICDmmkKmu7E2XaGuN9QOw+7JhRdGPcVHTYI=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=WP3D70cOsvnaFmUPf9hOCxO9Xt5zfEGk69OfK3Egf8X9Sgk12WTlkjfCrY9ZRQu+
	 ryIMS5GgWmQrhLPYV5csvdEHRo18+I0G82cgnJMm35v8uuic18GvcmsBGVBwulU07
	 M1IqWFJGUXc7kypCbMOXQZJwlM3cCR+UjYW8XexY5bxgob6pmPBm05zBnuvQ5IXAJ
	 NxwNK8JpWu5dqPT7t71BnXZDENGEMFEwDQGooQGHnxc2lJf7nGsPV+J9ECAbkb9gb
	 06Vw/clP0uhAHN6p8g+uSv6j8PMktGlPP6Auswfu+v6eV8ZVkjTeBhuu/TIVyFrhK
	 t4rtHZQbYwdiHpAd+A==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mfc4q-1sYdBO1FYe-00mAqT; Tue, 30
 Apr 2024 11:55:34 +0200
Message-ID: <54e83ce6-0f9d-45c2-92c7-a41fdb812314@web.de>
Date: Tue, 30 Apr 2024 11:55:31 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 1/2] scsi: qla2xxx: Fix double free of fcport in
 qla24xx_els_dcmd_iocb
To: Yongzhi Liu <hyperlyzcs@gmail.com>,
 GR-QLogic-Storage-Upstream@marvell.com, linux-scsi@vger.kernel.org,
 kernel-janitors@vger.kernel.org,
 James Bottomley <James.Bottomley@HansenPartnership.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Nilesh Javali <njavali@marvell.com>, Saurav Kashyap <skashyap@marvell.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Himanshu Madhani <himanshu.madhani@oracle.com>, huntazhang@tencent.com,
 jitxie@tencent.com
References: <9c711441-6e79-422f-9405-ee271929e77c@web.de>
 <20240430091144.10744-1-hyperlyzcs@gmail.com>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240430091144.10744-1-hyperlyzcs@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:M4mgAuj24p5GXrYB+rUdjCKuxKH4dN/z01KrH1d3E0ue+DGv4aW
 ciE0r0Po8gooDJByIU2N0O4m+E4NnnFzhkomcnsUpvF6HpBKkC4GBM+9Te2RREyDamkgXyo
 /EJjYbd6S27KVLeB51UXi7S5aINbNVvnqe8dvsG5pPZ/JU8uY4WDtrKza/j5jQ2/MoMTjGT
 A0/ze+laE4ct9UkDmaGgA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:xnnnl6+YVLE=;xeE/n0XHGDxpJQ0CevP9kGdutxS
 g9btpkvaRhOiJE77U3pw5fnljnnFQH5pYAiN57vcaB0xwO/ye21AA3dpkRmyQnEUMKjDa3hzg
 YNMLArheBftq8dfeDGepO6hKgjf1iI0BMwQ0236O1g4lPjR0UgilvYWEzC2J4stt5ywAJ5ItS
 kRsGiBJ4sOq7V6Vm2ef0FHjA5V1fB1ojNMh4MX0SL7YCvSkMY2v/P3Ie7a2bBTWL9/5ykJked
 B4/2KtCI6/awJROqlVzPJuoVnpO1tMkp0HD4cv6Bs1iyArwZK/I1dt8usaLUMWFP4/2ywx1D6
 JXXpmgVA8J+qI0kfWoK0/NwctXyn1L7J+i+0SFz/AedV65ufZySDqiibDLCMwty31Kf6hQrTt
 6sIFwnTkBeROeaE5JQrY86FLt9PcnyZRgqN9ktaEz1KQMNe0U/OfF2CDZnD9Nj4ZUoQWLmQwa
 Y/yP33X1P7ScmoJETMjT2FQ4kDe9anKrLsWz0Gi9O1L7elMAEwfD1DYxXfd7mLIcvlYuoiXHM
 EgwbOofMXMGPDX23RS/1MO4Q3seL8V/MsOX8myvcL67IOymIgBTETFxlQ8vGMzFOzDGE3DxKu
 UQmyguuJ8cXH/exswoBFtTg7qdm/VXO1EP2VoUypNzdV4VPVI73KliEtcU6152Z5oWu28Ljsd
 gpnUkuwhjgKbGDuH4mr2+lFi2se7Jc1MGBFeoHHgMfwNvERfDtTAXE3pVLJHokP0/GsdXuTyo
 bl9SAx0xtRoQOcJ98p+PTl14BTnbsWLKNAKVQVMgU0fi7GRiioHls6AsdWFOtupXwWG0xUD9t
 leX0Wk3PVCqeiNvGOK4cTRKZk8fTtR/L+Tdi0koODolGA=

* I would usually expect a corresponding cover letter for patch series.

* Would you like to add parentheses to the function name in the summary ph=
rase?


> When dma_alloc_coherent() or qla2x00_start_sp() return an error,

                                                  call returned?


> the callback function qla2x00_els_dcmd_sp_free in qla2x00_sp_release
> will call qla2x00_free_fcport() to kfree fcport. We shouldn't call

                                     free =E2=80=9Cfcport=E2=80=9D?


> qla2x00_free_fcport() again in the error handling path.

                                                    paths?



> Fix this by cleaning the duplicate qla2x00_free_fcport() calls up.

Would the wording =E2=80=9CThus delete duplicate qla2x00_free_fcport() cal=
ls.=E2=80=9D be a bit nicer?


=E2=80=A6
> ---
> V2 -> V3: Improve patch summary and provide a patch serises with two sep=
arate update steps
=E2=80=A6

* How do you think about to avoid the repetition of version identifiers
  (according to the selected enumeration style)?

* You would probably like to avoid another typo here.

Regards,
Markus

