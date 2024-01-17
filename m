Return-Path: <linux-kernel+bounces-28852-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BEBC88303C6
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 11:41:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 705F91F25580
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 10:41:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81F6D1C28C;
	Wed, 17 Jan 2024 10:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="gCJ4kmmz"
Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5971C1DDC9;
	Wed, 17 Jan 2024 10:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705488078; cv=none; b=ZTRWpdX2ewlZTOozTt2NfoK7t8FrJZBLd2cdCb2DG2/T8d97vyBNYSScBRuSzmEewk1SuRYSKtCJMvLes2zWs/2v0vQTwkDTHdOBTuN7s1Wl02MGHz/pj0dzcMkmHjd8p2+ok7U5PgxrxqS41kBODa3hqssl7zNG2TgWjJyCUC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705488078; c=relaxed/simple;
	bh=vJqkCYXJxdgrKwi1w2Jjol0tYLSav4W0xcsFJVVuKzs=;
	h=DKIM-Signature:X-UI-Sender-Class:Received:Message-ID:Date:
	 MIME-Version:User-Agent:To:References:Subject:Content-Language:
	 From:Cc:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-Provags-ID:X-Spam-Flag:UI-OutboundReport; b=FoKHhy8BjJGAgyFTpJcv40J8qqjujhcTcwjczeW5RzK4PGuaPN5zWvxJIGZYdHg6QMOvrTi2U2ivXsTRREDQpqtFOfhbwWJETla0uSz//0PQhmMaWWTE5heeB11g1Zotsp1MPmelhleEyJuH2B2LhodJj7MTJ+42m5LdERMNYno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=gCJ4kmmz; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1705488019; x=1706092819; i=markus.elfring@web.de;
	bh=vJqkCYXJxdgrKwi1w2Jjol0tYLSav4W0xcsFJVVuKzs=;
	h=X-UI-Sender-Class:Date:To:References:Subject:From:Cc:
	 In-Reply-To;
	b=gCJ4kmmzLFuW9q10d5VlkqRSXfsWhY1BOy4mZ1KZqwZSmsmcey/Wru0Ji7i6RCu+
	 5RjDMXuku7/D3SoymJH0hL90nQcJVq06x7EPvwHNQpYUzsFeyLFA1t7qJ2L011T0P
	 sttEf0pKEjfy+QlGzksncaZ5bM/qRhJ3ACU91tPjFONtt00/nrtZy4tlb/uWC6gnQ
	 QXTNai0u1aqCLL+4hM4zTmeblB8HEur3q+2xEFrahf3mIQ1PiVeCcQC+4rOiTVX47
	 3vjodOG6/c1AGm35XGR6Dmrqke/TMy053GHtw6K7Kff0+DDZyJuBRjvf/qktobjRV
	 T8UjpDuvPD+ByaVPlg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.84.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MF2gW-1rNpMJ2Ney-00Fk11; Wed, 17
 Jan 2024 11:40:19 +0100
Message-ID: <3e0c7008-417d-4549-ae0a-7f8d26522117@web.de>
Date: Wed, 17 Jan 2024 11:40:09 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Kunwu Chan <chentao@kylinos.cn>, xen-devel@lists.xenproject.org,
 kernel-janitors@vger.kernel.org
References: <20240117090018.152031-1-chentao@kylinos.cn>
Subject: Re: [PATCH v2] x86/xen: Add some null pointer checking to smp.c
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel test robot <lkp@intel.com>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>, Borislav Petkov
 <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
 =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org
In-Reply-To: <20240117090018.152031-1-chentao@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:JaLRwvXgJjiefll0Tuwas9XKSthWswOnaJewGiQBlyjTcPN9V2f
 hcrT9hCDF4WMQbUTC8k8ldktcIrVPniJAn+SXNC0BsbmiJJp3ojo24Oib8U7MUU+sBdD0Yu
 9c2+NUGv0VOR/06RxZoAV6HYBZVNQWN89GhXqQ6KI3r7QMKbUFyIENEbq7fU76dv24P0270
 O6iv+fKAQp+KD0B1eJeiw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:YvfY7JRbdYE=;mP4N+bwOpR1xsAuYUabDW0+JE/C
 AE3sP6atgL4o5w8kpHZI1+fNDuODzzspTSsZR7Ts2xw+W8gyXyG1AU9oeO8z2bx51b+YDZxEc
 MbwFGMGq2pX3mvIDaFzbYKAXE/lHYKT/46vU02RCllriNMVeBdckIzK5GJnmy5BhwV9obgmBU
 uMnG0nxdznUdK5vArhi41S8rswOBBjA+p5BXIMTwuElcMviIZDzAgwaafC7M3oRl7yOEhXGTj
 kl387WORzaxMA5yuQk0SH089zXvB0kDj25tXAy50rOLWbGnPMeoU+UBwkwuMUrPR+fLAckcAQ
 5iezZjgPUvQOJrDOCGqLBm3U0KcSfDlOjBB/zGrIPGKsZ/USoc22ulDNOmT+q7G5NlWoHU2/S
 Q2jcDKj+XSwagdZr3XoaA+ntcEd90yizsoxwOHIdbnKxrYJ2gjeGocUOh1468GgeBXSIBNGB2
 Hc50BeWZWY+7fO7z7MBIYuWNPJTMhx/XS5uYn0x/8yLmq4WZFNc4mMRi4VkGrPHlpi42INqOj
 Iy+FP0U7hHYRqyu5biKL3OMOaiuhvlWKO5uTYiPRinKgQW9YZbbe12zJq4A6Pt+LM1EtpfBfm
 2r+23QPpCOME0xqwxvqai/69Nhxpxk9+MIVgx4qcnj+YfvhNimWMcfCBBO1s1EtwBmRVEUpgO
 SmQLEwYWfc2cV5bYz1T5thQLt2Noez5tEFErKazzhFyWhoi6R6jbgiAA7IXO3arCEQ9jxYMDF
 W5WS9MZKEiWQ99oQBTjVxcJ1AVBiX3Z+olPFFpLww+Dn/e2q74nF6G/dUQcFSKqFEdWHgJYOe
 ViGCTUON4npiWlzfq/oXAYoWsPa+0AnfUc7bevojJ/udgrqE89563O9spHpPWxCl8KHVFlm4Y
 wfzUoxVF2hfAH6Siuqg7QOkBgCXbJbZKUlgqEx5fjzd8GRqpuO4HdA0YWzg7NHcsdBMym5Xz4
 iEsT4g==

> kasprintf() returns a pointer to dynamically allocated memory
> which can be NULL upon failure. Ensure the allocation was successful
> by checking the pointer validity.
=E2=80=A6
> +++ b/arch/x86/xen/smp.c
> @@ -61,10 +61,14 @@ void xen_smp_intr_free(unsigned int cpu)
>
>  int xen_smp_intr_init(unsigned int cpu)
>  {
> -	int rc;
> +	int rc =3D 0;

I find the indication of a successful function execution sufficient by
the statement =E2=80=9Creturn 0;=E2=80=9D at the end.
How do you think about to omit such an extra variable initialisation?


>  	char *resched_name, *callfunc_name, *debug_name;
>
>  	resched_name =3D kasprintf(GFP_KERNEL, "resched%d", cpu);
> +	if (!resched_name) {
> +		rc =3D -ENOMEM;
> +		goto fail;
> +	}
>  	per_cpu(xen_resched_irq, cpu).name =3D resched_name;
>  	rc =3D bind_ipi_to_irqhandler(XEN_RESCHEDULE_VECTOR,
>  				    cpu,

You propose to apply the same error code in four if branches.
I suggest to avoid the specification of duplicate assignment statements
for this purpose.
How do you think about to use another label like =E2=80=9Ce_nomem=E2=80=9D=
?

Regards,
Markus

