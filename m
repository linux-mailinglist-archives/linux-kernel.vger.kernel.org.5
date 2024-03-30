Return-Path: <linux-kernel+bounces-126255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D2AA289344D
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 19:02:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F4CE1F23F3A
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 17:02:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B42A31474BE;
	Sun, 31 Mar 2024 16:42:17 +0000 (UTC)
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D3E315B131;
	Sun, 31 Mar 2024 16:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=62.96.220.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711903335; cv=fail; b=jv2sRq4sNWN7Jtb3d7/R8nmea+AZUNRE2cJLjHmP1YyxDuyPrY3w3lI+aXPEn2g76hKWxSe74wreu0yLhH6zMvowbah3r7M0bIaIY3KZ02iQqibG3fl5awEr0sZk/Y9s0cjLM6KVPPZcWT+32Ag1MEdhlJWQoQ5f99JphNej4Pc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711903335; c=relaxed/simple;
	bh=MwO2ivguyuiUyc9l7rCbKYehqGPzp/aDLEp3qS8V0hU=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KJw4DS1emIKUV9+/lLpiSAh90oglfqT9etwhgms0fjd88chZCSrsmhXl8Hu+tBp+CVmYayfoUBk7tFnCaAfRkFt6n7wpzEtTBu8exYyvJZRxjTmxO99vueDP/+fsSj6ggKXDE2FBTfdAVDVOppT2KwX+GYWGenMmeNGrzlSte+I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=shingroup.cn; spf=fail smtp.mailfrom=shingroup.cn; arc=none smtp.client-ip=114.132.65.219; dmarc=pass (p=none dis=none) header.from=shingroup.cn; spf=pass smtp.mailfrom=shingroup.cn; arc=fail smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=shingroup.cn
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=shingroup.cn
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id E976C208C2;
	Sun, 31 Mar 2024 18:42:10 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id h6hY7AbppXTb; Sun, 31 Mar 2024 18:42:09 +0200 (CEST)
Received: from mailout1.secunet.com (mailout1.secunet.com [62.96.220.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 6046F207D1;
	Sun, 31 Mar 2024 18:42:09 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 6046F207D1
Received: from cas-essen-01.secunet.de (unknown [10.53.40.201])
	by mailout1.secunet.com (Postfix) with ESMTP id 533EF80005E;
	Sun, 31 Mar 2024 18:42:09 +0200 (CEST)
Received: from mbx-essen-01.secunet.de (10.53.40.197) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 31 Mar 2024 18:42:09 +0200
Received: from Pickup by mbx-essen-01.secunet.de with Microsoft SMTP Server id
 15.1.2507.17; Sun, 31 Mar 2024 16:36:53 +0000
X-sender: <netdev+bounces-83494-steffen.klassert=secunet.com@vger.kernel.org>
X-Receiver: <steffen.klassert@secunet.com>
 ORCPT=rfc822;steffen.klassert@secunet.com;
 X-ExtendedProps=DwA1AAAATWljcm9zb2Z0LkV4Y2hhbmdlLlRyYW5zcG9ydC5EaXJlY3RvcnlEYXRhLklzUmVzb3VyY2UCAAAFABUAFgACAAAABQAUABEA8MUJLbkECUOS0gjaDTZ+uAUAagAJAAEAAAAAAAAABQAWAAIAAAUAQwACAAAFAEYABwADAAAABQBHAAIAAAUAEgAPAGIAAAAvbz1zZWN1bmV0L291PUV4Y2hhbmdlIEFkbWluaXN0cmF0aXZlIEdyb3VwIChGWURJQk9IRjIzU1BETFQpL2NuPVJlY2lwaWVudHMvY249U3RlZmZlbiBLbGFzc2VydDY4YwUACwAXAL4AAACheZxkHSGBRqAcAp3ukbifQ049REI2LENOPURhdGFiYXNlcyxDTj1FeGNoYW5nZSBBZG1pbmlzdHJhdGl2ZSBHcm91cCAoRllESUJPSEYyM1NQRExUKSxDTj1BZG1pbmlzdHJhdGl2ZSBHcm91cHMsQ049c2VjdW5ldCxDTj1NaWNyb3NvZnQgRXhjaGFuZ2UsQ049U2VydmljZXMsQ049Q29uZmlndXJhdGlvbixEQz1zZWN1bmV0LERDPWRlBQAOABEABiAS9uuMOkqzwmEZDvWNNQUAHQAPAAwAAABtYngtZXNzZW4tMDIFADwAAgAADwA2AAAATWljcm9zb2Z0LkV4Y2hhbmdlLlRyYW5zcG9ydC5NYWlsUmVjaXBpZW50LkRpc3BsYXlOYW1lDwARAAAAS2xhc3NlcnQsIFN0ZWZmZW4FAGwAAgAABQBYABcASgAAAPDFCS25BAlDktII2g02frhDTj1LbGFzc2VydCBTdGVmZmVuLE9VPVVzZXJzLE9VPU1pZ3JhdGlvbixEQz1zZWN1bmV0LERDPWRlBQAMAAIAAAUAJgACAAEFACIADwAxAAAAQXV0b1Jlc3BvbnNlU3VwcHJlc3M6IDANClRyYW5zbWl0SGlzdG9ye
	TogRmFsc2UNCg8ALwAAAE1pY3Jvc29mdC5FeGNoYW5nZS5UcmFuc3BvcnQuRXhwYW5zaW9uR3JvdXBUeXBlDwAVAAAATWVtYmVyc0dyb3VwRXhwYW5zaW9uBQAjAAIAAQ==
X-CreatedBy: MSExchange15
X-HeloDomain: a.mx.secunet.com
X-ExtendedProps: BQBjAAoADFSmlidQ3AgFAGEACAABAAAABQA3AAIAAA8APAAAAE1pY3Jvc29mdC5FeGNoYW5nZS5UcmFuc3BvcnQuTWFpbFJlY2lwaWVudC5Pcmdhbml6YXRpb25TY29wZREAAAAAAAAAAAAAAAAAAAAAAAUASQACAAEFAAQAFCABAAAAHAAAAHN0ZWZmZW4ua2xhc3NlcnRAc2VjdW5ldC5jb20FAAYAAgABDwAqAAAATWljcm9zb2Z0LkV4Y2hhbmdlLlRyYW5zcG9ydC5SZXN1Ym1pdENvdW50BwACAAAADwAJAAAAQ0lBdWRpdGVkAgABBQACAAcAAQAAAAUAAwAHAAAAAAAFAAUAAgABBQBiAAoALQAAANSKAAAFAGQADwADAAAASHViBQApAAIAAQ8APwAAAE1pY3Jvc29mdC5FeGNoYW5nZS5UcmFuc3BvcnQuRGlyZWN0b3J5RGF0YS5NYWlsRGVsaXZlcnlQcmlvcml0eQ8AAwAAAExvdw==
X-Source: SMTP:Default MBX-ESSEN-02
X-SourceIPAddress: 62.96.220.36
X-EndOfInjectedXHeaders: 14506
X-Virus-Scanned: by secunet
Received-SPF: Pass (sender SPF authorized) identity=mailfrom; client-ip=139.178.88.99; helo=sv.mirrors.kernel.org; envelope-from=netdev+bounces-83494-steffen.klassert=secunet.com@vger.kernel.org; receiver=steffen.klassert@secunet.com 
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 8AC6F208B4
X-Original-To: netdev@vger.kernel.org
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.132.65.219
ARC-Seal: i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711775345; cv=none; b=gfLWY1ioFi9jl1ZBFjmxmFW2tHmdP96al/rViDheOnyYsGPNiY/6rojsa6KuCViu6ospo8JqIPmrQ5kYhXxI4fWTd13oBUM7loEJ816ctuoV5AIOJRDqdy8LJMFGF588bEGNcNoJZnlMJ+26z+gcXZ2kaQlCf0QR+U0nKFsVYlw=
ARC-Message-Signature: i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711775345; c=relaxed/simple;
	bh=nYsJpAvl6D6Ldufd73Rjy7YF1XYSzElH1fykgREgPxY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nPDDajRC5sef6WYcCenUzFrJabkj3nFiAaNM8jxBguQE+fYD0jUXLYNwIYYdx/DfR8ex7tUilcegtdOsom4YdWhROAmwHDAxg4AfPonb2M1mMwD3xYUyVNldguOl29V8JvaRRyAAWjRH+cUhqKQq6qdlYHWWn1MFfLqI2qghuRo=
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn; spf=pass smtp.mailfrom=shingroup.cn; arc=none smtp.client-ip=114.132.65.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shingroup.cn
X-QQ-mid: bizesmtpsz13t1711775229tdi4p2
X-QQ-Originating-IP: RfTYRleHqifmaUL5vg3HHBAADHtyt3J2efZxDgCsTa0=
X-QQ-SSF: 01400000000000704000000A0000000
X-QQ-FEAT: OtIeQkg1QQHVkELNGhnn3Ao/OxN3u837g2WY2miXs+dKwNICeHodGDXYI+XIN
	MLiksvoY6OK484p/H1Pd7HcbM0rICeev22amIC6/BI2BPXdj7hZR/NjRgIzO0ujc7AJYyuh
	hSs4kN6XesHATJzk7YtHOv0oscVKSJDG1YcCID61KeNwB//v/SP6Vco5Zi0zVzK2CryiHy7
	MDlcbxtiVcvQbWgHR9uJniyBUgkXuWUpSRm9PGge+rsWbj+CoXH7KA5p92J+1tMYPfc3pMS
	a2+D1HW1CQDyFXgH/iGbdQU2wmJ3Udzd7Q8BgYnuoVkISFF2Z3cH4G9BqZDzzOAp62v8M7U
	2sZsZTz6rWN4NWIO+LXnMPEd2Ftx/MDN8OxPXGUXp3ZrWXMIP1dg4Nut1Jfsg==
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 10889329762490604258
Date: Sat, 30 Mar 2024 13:07:06 +0800
From: Dawei Li <dawei.li@shingroup.cn>
To: Eric Dumazet <edumazet@google.com>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<ioana.ciornei@nxp.com>, <wintera@linux.ibm.com>, <twinkler@linux.ibm.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-s390@vger.kernel.org>
Subject: Re: [PATCH net-next 1/2] net/iucv: Avoid explicit cpumask var
 allocation on stack
Message-ID: <4E49057A4198779C+Zged+hXhxE4GksiL@centos8>
References: <20240329105610.922675-1-dawei.li@shingroup.cn>
 <20240329105610.922675-2-dawei.li@shingroup.cn>
 <CANn89iJzuw8_ti4P4tJ_A3Fd0QCjHTBjasbm_J3N8up=gK8Aow@mail.gmail.com>
Precedence: bulk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CANn89iJzuw8_ti4P4tJ_A3Fd0QCjHTBjasbm_J3N8up=gK8Aow@mail.gmail.com>
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpsz:shingroup.cn:qybglogicsvrgz:qybglogicsvrgz5a-1
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

Hi Eric,

On Fri, Mar 29, 2024 at 02:21:28PM +0100, Eric Dumazet wrote:
> On Fri, Mar 29, 2024 at 11:57=E2=80=AFAM Dawei Li <dawei.li@shingroup.cn>=
 wrote:
> >
> > For CONFIG_CPUMASK_OFFSTACK=3Dy kernel, explicit allocation of cpumask
> > variable on stack is not recommended since it can cause potential stack
> > overflow.
> >
> > Instead, kernel code should always use *cpumask_var API(s) to allocate
> > cpumask var in config-neutral way, leaving allocation strategy to
> > CONFIG_CPUMASK_OFFSTACK.
> >
> > Use *cpumask_var API(s) to address it.
> >
> > Signed-off-by: Dawei Li <dawei.li@shingroup.cn>
> > ---
> >  net/iucv/iucv.c | 37 ++++++++++++++++++++++++++-----------
> >  1 file changed, 26 insertions(+), 11 deletions(-)
> >
> > diff --git a/net/iucv/iucv.c b/net/iucv/iucv.c
> > index a4ab615ca3e3..b51f46ec32f9 100644
> > --- a/net/iucv/iucv.c
> > +++ b/net/iucv/iucv.c
> > @@ -520,14 +520,19 @@ static void iucv_setmask_mp(void)
> >   */
> >  static void iucv_setmask_up(void)
> >  {
> > -       cpumask_t cpumask;
> > +       cpumask_var_t cpumask;
> >         int cpu;
> >
> > +       if (!alloc_cpumask_var(&cpumask, GFP_KERNEL))
> > +               return;
>=20
> This can not be right. iucv_setmask_up() is not supposed to fail.
>=20
> Since iucv_setmask_up() is only called with iucv_register_mutex held,
> you could simply add a 'static' for @cpumask variable.

Correct, iucv_register_mutex is a global lock and can serialize access
on static cpumask var.

I will respin V2 as you suggested.

Thanks,

    Dawei
>=20
>=20
>=20
> > +
> >         /* Disable all cpu but the first in cpu_irq_cpumask. */
> > -       cpumask_copy(&cpumask, &iucv_irq_cpumask);
> > -       cpumask_clear_cpu(cpumask_first(&iucv_irq_cpumask), &cpumask);
> > -       for_each_cpu(cpu, &cpumask)
> > +       cpumask_copy(cpumask, &iucv_irq_cpumask);
> > +       cpumask_clear_cpu(cpumask_first(&iucv_irq_cpumask), cpumask);
> > +       for_each_cpu(cpu, cpumask)
> >                 smp_call_function_single(cpu, iucv_block_cpu, NULL, 1);
> > +
> > +       free_cpumask_var(cpumask);
> >  }
>=20

X-sender: <linux-kernel+bounces-125600-steffen.klassert=3Dsecunet.com@vger.=
kernel.org>
X-Receiver: <steffen.klassert@secunet.com> ORCPT=3Drfc822;steffen.klassert@=
secunet.com; X-ExtendedProps=3DDwA1AAAATWljcm9zb2Z0LkV4Y2hhbmdlLlRyYW5zcG9y=
dC5EaXJlY3RvcnlEYXRhLklzUmVzb3VyY2UCAAAFABUAFgACAAAABQAUABEA8MUJLbkECUOS0gj=
aDTZ+uAUAagAJAAEAAAAAAAAABQAWAAIAAAUAQwACAAAFAEYABwADAAAABQBHAAIAAAUAEgAPAG=
IAAAAvbz1zZWN1bmV0L291PUV4Y2hhbmdlIEFkbWluaXN0cmF0aXZlIEdyb3VwIChGWURJQk9IR=
jIzU1BETFQpL2NuPVJlY2lwaWVudHMvY249U3RlZmZlbiBLbGFzc2VydDY4YwUACwAXAL4AAACh=
eZxkHSGBRqAcAp3ukbifQ049REI2LENOPURhdGFiYXNlcyxDTj1FeGNoYW5nZSBBZG1pbmlzdHJ=
hdGl2ZSBHcm91cCAoRllESUJPSEYyM1NQRExUKSxDTj1BZG1pbmlzdHJhdGl2ZSBHcm91cHMsQ0=
49c2VjdW5ldCxDTj1NaWNyb3NvZnQgRXhjaGFuZ2UsQ049U2VydmljZXMsQ049Q29uZmlndXJhd=
GlvbixEQz1zZWN1bmV0LERDPWRlBQAOABEABiAS9uuMOkqzwmEZDvWNNQUAHQAPAAwAAABtYngt=
ZXNzZW4tMDIFADwAAgAADwA2AAAATWljcm9zb2Z0LkV4Y2hhbmdlLlRyYW5zcG9ydC5NYWlsUmV=
jaXBpZW50LkRpc3BsYXlOYW1lDwARAAAAS2xhc3NlcnQsIFN0ZWZmZW4FAGwAAgAABQBYABcASg=
AAAPDFCS25BAlDktII2g02frhDTj1LbGFzc2VydCBTdGVmZmVuLE9VPVVzZXJzLE9VPU1pZ3Jhd=
GlvbixEQz1zZWN1bmV0LERDPWRlBQAMAAIAAAUAJgACAAEFACIADwAxAAAAQXV0b1Jlc3BvbnNl=
U3VwcHJlc3M6IDANClRyYW5zbWl0SGlzdG9yeTogRmFsc2UNCg8ALwAAAE1pY3Jvc29mdC5FeGN=
oYW5nZS5UcmFuc3BvcnQuRXhwYW5zaW9uR3JvdXBUeXBlDwAVAAAATWVtYmVyc0dyb3VwRXhwYW=
5zaW9uBQAjAAIAAQ=3D=3D
X-CreatedBy: MSExchange15
X-HeloDomain: b.mx.secunet.com
X-ExtendedProps: BQBjAAoADFSmlidQ3AgFAGEACAABAAAABQA3AAIAAA8APAAAAE1pY3Jvc2=
9mdC5FeGNoYW5nZS5UcmFuc3BvcnQuTWFpbFJlY2lwaWVudC5Pcmdhbml6YXRpb25TY29wZREAA=
AAAAAAAAAAAAAAAAAAAAAUASQACAAEFAAQAFCABAAAAHAAAAHN0ZWZmZW4ua2xhc3NlcnRAc2Vj=
dW5ldC5jb20FAAYAAgABDwAqAAAATWljcm9zb2Z0LkV4Y2hhbmdlLlRyYW5zcG9ydC5SZXN1Ym1=
pdENvdW50BwACAAAADwAJAAAAQ0lBdWRpdGVkAgABBQACAAcAAQAAAAUAAwAHAAAAAAAFAAUAAg=
ABBQBiAAoAMgAAANSKAAAFAGQADwADAAAASHViBQApAAIAAQ8APwAAAE1pY3Jvc29mdC5FeGNoY=
W5nZS5UcmFuc3BvcnQuRGlyZWN0b3J5RGF0YS5NYWlsRGVsaXZlcnlQcmlvcml0eQ8AAwAAAExv=
dw=3D=3D
X-Source: SMTP:Default MBX-ESSEN-02
X-SourceIPAddress: 62.96.220.37
X-EndOfInjectedXHeaders: 14423
Received: from cas-essen-02.secunet.de (10.53.40.202) by
 mbx-essen-02.secunet.de (10.53.40.198) with Microsoft SMTP Server
 (version=3DTLS1_2, cipher=3DTLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.37; Sat, 30 Mar 2024 06:09:31 +0100
Received: from b.mx.secunet.com (62.96.220.37) by cas-essen-02.secunet.de
 (10.53.40.202) with Microsoft SMTP Server (version=3DTLS1_2,
 cipher=3DTLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Fronte=
nd
 Transport; Sat, 30 Mar 2024 06:09:31 +0100
Received: from localhost (localhost [127.0.0.1])
	by b.mx.secunet.com (Postfix) with ESMTP id 9BC5E20315
	for <steffen.klassert@secunet.com>; Sat, 30 Mar 2024 06:09:31 +0100 (CET)
X-Virus-Scanned: by secunet
X-Spam-Flag: NO
X-Spam-Score: -2.651
X-Spam-Level:
X-Spam-Status: No, score=3D-2.651 tagged_above=3D-999 required=3D2.1
	tests=3D[BAYES_00=3D-1.9, HEADER_FROM_DIFFERENT_DOMAINS=3D0.249,
	MAILING_LIST_MULTI=3D-1, RCVD_IN_DNSWL_NONE=3D-0.0001,
	SPF_HELO_NONE=3D0.001, SPF_PASS=3D-0.001] autolearn=3Dham autolearn_force=
=3Dno
Received: from b.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LZTttGtnumXn for <steffen.klassert@secunet.com>;
	Sat, 30 Mar 2024 06:09:28 +0100 (CET)
Received-SPF: Pass (sender SPF authorized) identity=3Dmailfrom; client-ip=
=3D147.75.48.161; helo=3Dsy.mirrors.kernel.org; envelope-from=3Dlinux-kerne=
l+bounces-125600-steffen.klassert=3Dsecunet.com@vger.kernel.org; receiver=
=3Dsteffen.klassert@secunet.com=20
DKIM-Filter: OpenDKIM Filter v2.11.0 b.mx.secunet.com 6416D202A6
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161]=
)
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by b.mx.secunet.com (Postfix) with ESMTPS id 6416D202A6
	for <steffen.klassert@secunet.com>; Sat, 30 Mar 2024 06:09:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.2=
5.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 385FAB217BA
	for <steffen.klassert@secunet.com>; Sat, 30 Mar 2024 05:09:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D66ECBA28;
	Sat, 30 Mar 2024 05:09:06 +0000 (UTC)
Received: from bg1.exmail.qq.com (bg1.exmail.qq.com [114.132.65.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 418523FF1;
	Sat, 30 Mar 2024 05:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=3Dnone smtp.client-ip=
=3D114.132.65.219
ARC-Seal: i=3D1; a=3Drsa-sha256; d=3Dsubspace.kernel.org; s=3Darc-20240116;
	t=3D1711775345; cv=3Dnone; b=3DgfLWY1ioFi9jl1ZBFjmxmFW2tHmdP96al/rViDheOny=
YsGPNiY/6rojsa6KuCViu6ospo8JqIPmrQ5kYhXxI4fWTd13oBUM7loEJ816ctuoV5AIOJRDqdy=
8LJMFGF588bEGNcNoJZnlMJ+26z+gcXZ2kaQlCf0QR+U0nKFsVYlw=3D
ARC-Message-Signature: i=3D1; a=3Drsa-sha256; d=3Dsubspace.kernel.org;
	s=3Darc-20240116; t=3D1711775345; c=3Drelaxed/simple;
	bh=3DnYsJpAvl6D6Ldufd73Rjy7YF1XYSzElH1fykgREgPxY=3D;
	h=3DDate:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=3DnPDDajRC5sef6WYcCenUzFr=
Jabkj3nFiAaNM8jxBguQE+fYD0jUXLYNwIYYdx/DfR8ex7tUilcegtdOsom4YdWhROAmwHDAxg4=
AfPonb2M1mMwD3xYUyVNldguOl29V8JvaRRyAAWjRH+cUhqKQq6qdlYHWWn1MFfLqI2qghuRo=
=3D
ARC-Authentication-Results: i=3D1; smtp.subspace.kernel.org; dmarc=3Dpass (=
p=3Dnone dis=3Dnone) header.from=3Dshingroup.cn; spf=3Dpass smtp.mailfrom=
=3Dshingroup.cn; arc=3Dnone smtp.client-ip=3D114.132.65.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=3Dpass (p=3Dnone di=
s=3Dnone) header.from=3Dshingroup.cn
Authentication-Results: smtp.subspace.kernel.org; spf=3Dpass smtp.mailfrom=
=3Dshingroup.cn
X-QQ-mid: bizesmtpsz13t1711775229tdi4p2
X-QQ-Originating-IP: RfTYRleHqifmaUL5vg3HHBAADHtyt3J2efZxDgCsTa0=3D
Received: from localhost ( [112.0.147.175])
	by bizesmtp.qq.com (ESMTP) with=20
	id ; Sat, 30 Mar 2024 13:07:07 +0800 (CST)
X-QQ-SSF: 01400000000000704000000A0000000
X-QQ-FEAT: OtIeQkg1QQHVkELNGhnn3Ao/OxN3u837g2WY2miXs+dKwNICeHodGDXYI+XIN
	MLiksvoY6OK484p/H1Pd7HcbM0rICeev22amIC6/BI2BPXdj7hZR/NjRgIzO0ujc7AJYyuh
	hSs4kN6XesHATJzk7YtHOv0oscVKSJDG1YcCID61KeNwB//v/SP6Vco5Zi0zVzK2CryiHy7
	MDlcbxtiVcvQbWgHR9uJniyBUgkXuWUpSRm9PGge+rsWbj+CoXH7KA5p92J+1tMYPfc3pMS
	a2+D1HW1CQDyFXgH/iGbdQU2wmJ3Udzd7Q8BgYnuoVkISFF2Z3cH4G9BqZDzzOAp62v8M7U
	2sZsZTz6rWN4NWIO+LXnMPEd2Ftx/MDN8OxPXGUXp3ZrWXMIP1dg4Nut1Jfsg=3D=3D
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 10889329762490604258
Date: Sat, 30 Mar 2024 13:07:06 +0800
From: Dawei Li <dawei.li@shingroup.cn>
To: Eric Dumazet <edumazet@google.com>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<ioana.ciornei@nxp.com>, <wintera@linux.ibm.com>, <twinkler@linux.ibm.com>=
,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-s390@vger.kernel.org>
Subject: Re: [PATCH net-next 1/2] net/iucv: Avoid explicit cpumask var
 allocation on stack
Message-ID: <4E49057A4198779C+Zged+hXhxE4GksiL@centos8>
References: <20240329105610.922675-1-dawei.li@shingroup.cn>
 <20240329105610.922675-2-dawei.li@shingroup.cn>
 <CANn89iJzuw8_ti4P4tJ_A3Fd0QCjHTBjasbm_J3N8up=3DgK8Aow@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=3D"utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANn89iJzuw8_ti4P4tJ_A3Fd0QCjHTBjasbm_J3N8up=3DgK8Aow@mail.gm=
ail.com>
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpsz:shingroup.cn:qybglogicsvrgz:qybglogicsvrgz5a-1
Return-Path: linux-kernel+bounces-125600-steffen.klassert=3Dsecunet.com@vge=
r.kernel.org
X-MS-Exchange-Organization-OriginalArrivalTime: 30 Mar 2024 05:09:31.6783
 (UTC)
X-MS-Exchange-Organization-Network-Message-Id: c5b01700-de57-4caa-0991-08dc=
5077955a
X-MS-Exchange-Organization-OriginalClientIPAddress: 62.96.220.37
X-MS-Exchange-Organization-OriginalServerIPAddress: 10.53.40.202
X-MS-Exchange-Organization-Cross-Premises-Headers-Processed: cas-essen-02.s=
ecunet.de
X-MS-Exchange-Organization-OrderedPrecisionLatencyInProgress: LSRV=3Dmbx-es=
sen-02.secunet.de:TOTAL-HUB=3D11373.685|SMR=3D0.135(SMRDE=3D0.003|SMRC=3D0.=
131(SMRCL=3D0.101|X-SMRCR=3D0.131))|CAT=3D0.064(CATMS=3D0.001
 |CATOS=3D0.001|CATRESL=3D0.026(CATRESLP2R=3D0.021)|CATORES=3D0.034(CATRS=
=3D0.034(CATRS-Index
 Routing Agent=3D0.032
 )))|QDM=3D11368.155|UNK=3D0.002|CAT=3D0.004(CATRESL=3D0.003(CATRESLP2R=3D0=
001))|QDM=3D5.384|CAT=3D0.024
 (CATRESL=3D0.023(CATRESLP2R=3D0.019));2024-03-30T08:19:05.371Z
X-MS-Exchange-Forest-ArrivalHubServer: mbx-essen-02.secunet.de
X-MS-Exchange-Organization-AuthSource: cas-essen-02.secunet.de
X-MS-Exchange-Organization-AuthAs: Anonymous
X-MS-Exchange-Organization-FromEntityHeader: Internet
X-MS-Exchange-Organization-OriginalSize: 8519
X-MS-Exchange-Organization-HygienePolicy: Standard
X-MS-Exchange-Organization-MessageLatency: SRV=3Dcas-essen-02.secunet.de:TO=
TAL-FE=3D0.009|SMR=3D0.008(SMRPI=3D0.006(SMRPI-FrontendProxyAgent=3D0.006))
X-MS-Exchange-Organization-Recipient-Limit-Verified: True
X-MS-Exchange-Organization-TotalRecipientCount: 1
X-MS-Exchange-Organization-Rules-Execution-History: 0b0cf904-14ac-4724-8bdf=
-482ee6223cf2%%%fd34672d-751c-45ae-a963-ed177fcabe23%%%d8080257-b0c3-47b4-b=
0db-23bc0c8ddb3c%%%95e591a2-5d7d-4afa-b1d0-7573d6c0a5d9%%%f7d0f6bc-4dcc-487=
6-8c5d-b3d6ddbb3d55%%%16355082-c50b-4214-9c7d-d39575f9f79b
X-MS-Exchange-Forest-RulesExecuted: mbx-essen-02
X-MS-Exchange-Organization-RulesExecuted: mbx-essen-02
X-MS-Exchange-Forest-IndexAgent-0: AQ0CZW4AAYQFAAAPAAADH4sIAAAAAAAEAJVV63LT=
RhQ+sq2LndjAQA
 mdzjCnf8AmthM7F0pomWQCoRkSyDTQvx5ZWtk7kSVXlwTTdqZv1Jfp
 E/RJenbXCrIdl0GjKGd3z/nOd27rf27/zPFVxJ1mtVKtvAvwKOJNPL
 Uj7D5rYnezu412gpvdvW5nr/vD2Smub3Y2N5vSBF+mI/sTS/AqChO2
 V628wGUAnc7eztN///r74BRf2leM4wnHH10htX2+Hw95MIjCdNx2gh
 c5tBfyg0dhhIfv3h4dv+4dnn04PTh/03t3dHT+/uDwzU8TvGBRwPwm
 so9jnzs8Qdv3Q8dOeBhg6KEzJpLxhUK6tCNu932GdBYntnOBPMYgTD
 BiTjgascBlLsY8cBgSkGMH9JfGDMfEKEi47SsrBRZessjzw6t2jupx
 ECfMdptTVuiELsN4GKa+S7yu7EmMAu/JlFWPCOHB2XE9bmASZsyZwp
 rqCNLIiUkYeHzQCliaRESEsJroM/uSUpcPOabThA0mhKdglmQuz/rD
 /1By3YjFMaUjb3DOBwFzW6HntfqTvS+WVBm1Wi0lYMCSDZ46l/LTdv
 AP3HqK60uf1udnCtBBj1MVnaEdDBhlu7tLGYpZJDIQ19cbTWo4dJnP
 1EarkePucs8jLgPRKRvzTPrzO8qGU2N8RHvb7u92dhx7i2212/2djr
 e9y5ytrvcMaSZ2t7ev41xEVkcUzDIX+/vY2uluNjvbuC7/PxNb1G4J
 DdplyF0U2r2YJbJKo3FdbDamCcEnG1NpqUU6a/H7lCyqJ6t+kknPp4
 znzqk7FnSyhwfy5Hku2Zk597D+vezSXg6p/mi6aOLro7Pem1e/vH11
 0mjMmmZPxJI0CgS4OH8/pMkVAyqmt88w4oNh0l6IuJENeJyOx2FM00
 097dncb09xztWw32QWBv6EXPg+WV3xZKi0IjbgNONRb5Qm1BND5rtN
 ATQJUxpRMecxH43JkiYHbXys6vEYPbrE9nMjLe+htrh0D8OIrp+keS
 M+8bBx4Id9GnnK3gXagSvjpm6n+4h/Ymg7Dk1otaLuNFH8nBvp4Zj4
 +z5lMB7TRfJrF+1Y8o3TwYCRM1dqvadpuojl74DItxxqlaVprqgmsw
 XfeIIveSwvVEqTcIv9NMFkyGg+oziR19Y47fHot6zs7etOne88JxxP
 cg3xSGYjZ9l4vsSOLsFIKNWzHem7vghAoEuwqDg9ZjvDDCanefMYSL
 Jf5rpg9hVcl0AtUp1lOv/Eo3FPNHHPSwNHXIc9+n0b+EzZSr990Vg9
 uX774eSELs9rp3O+I8Zm5neOI/4pO6VaAShAsQRl+hZBL2qwSi+UCl
 AqgV7QipYGFtBrkawD6GDSvgmWDpWlJkK/rINBO7oG3wihWBb6JR3u
 FKFkaLAGJoGQmgYFQwoVWCE1E6qWJCPNCb+0AqvXMgmEo8OKBfdMKB
 uSDH3pJSamBitgkRq9GhTJxIKaKXdIJqc16bQo+VcECDmycmTu3QhC
 RwWokVpVeCnJKBZDu1uU4dOraaQDBW1DA6DoRLq0ckHmuaLdUkIZ1k
 oSjRQ+G5LRzNIkR6tQW9WqBoABt2dPV2aWWqUEBKdL18XPMhgqS+Tp
 lgxclvv+TZvfUexloIIXTLhvingtxZCWMiFrBdDJ8R0wsjSWqfoVKi
 g8NKBGgCpvsnxmDlxX5VOVLcmCzp2qOipKd0FX/UNtqYpuTHNVNLLy
 WVAl73llApG9ZF7ToLoYMjRjWndLlYOWBVlZqVMz4JYOj8ys6Oqdtp
 wgKZYmfGuKJrdKIvYK+b0tvZiwZoqE0DgYYimTpmLPFFZIpygHJCNm
 qPRKNP0r0SoLaITwkHYeyB1LDkVRprFGxRI4JBuyFR8oHBWp+R+FXZ
 sNTwwAAAEK8QE8P3htbCB2ZXJzaW9uPSIxLjAiIGVuY29kaW5nPSJ1
 dGYtMTYiPz4NCjxFbWFpbFNldD4NCiAgPFZlcnNpb24+MTUuMC4wLj
 A8L1ZlcnNpb24+DQogIDxFbWFpbHM+DQogICAgPEVtYWlsIFN0YXJ0
 SW5kZXg9IjEyMCIgUG9zaXRpb249IlNpZ25hdHVyZSI+DQogICAgIC
 A8RW1haWxTdHJpbmc+ZGF3ZWkubGlAc2hpbmdyb3VwLmNuPC9FbWFp
 bFN0cmluZz4NCiAgICA8L0VtYWlsPg0KICA8L0VtYWlscz4NCjwvRW
 1haWxTZXQ+AQzUBzw/eG1sIHZlcnNpb249IjEuMCIgZW5jb2Rpbmc9
 InV0Zi0xNiI/Pg0KPENvbnRhY3RTZXQ+DQogIDxWZXJzaW9uPjE1Lj
 AuMC4wPC9WZXJzaW9uPg0KICA8Q29udGFjdHM+DQogICAgPENvbnRh
 Y3QgU3RhcnRJbmRleD0iMTEwIiBQb3NpdGlvbj0iU2lnbmF0dXJlIj
 4NCiAgICAgIDxQZXJzb24gU3RhcnRJbmRleD0iMTEwIiBQb3NpdGlv
 bj0iU2lnbmF0dXJlIj4NCiAgICAgICAgPFBlcnNvblN0cmluZz5EYX
 dlaSBMaTwvUGVyc29uU3RyaW5nPg0KICAgICAgPC9QZXJzb24+DQog
 ICAgICA8RW1haWxzPg0KICAgICAgICA8RW1haWwgU3RhcnRJbmRleD
 0iMTIwIiBQb3NpdGlvbj0iU2lnbmF0dXJlIj4NCiAgICAgICAgICA8
 RW1haWxTdHJpbmc+ZGF3ZWkubGlAc2hpbmdyb3VwLmNuPC9FbWFpbF
 N0cmluZz4NCiAgICAgICAgPC9FbWFpbD4NCiAgICAgIDwvRW1haWxz
 Pg0KICAgICAgPENvbnRhY3RTdHJpbmc+RGF3ZWkgTGkgJmx0O2Rhd2
 VpLmxpQHNoaW5ncm91cC5jbjwvQ29udGFjdFN0cmluZz4NCiAgICA8
 L0NvbnRhY3Q+DQogICAgPENvbnRhY3QgU3RhcnRJbmRleD0iNTc3Ii
 BQb3NpdGlvbj0iU2lnbmF0dXJlIj4NCiAgICAgIDxQZXJzb24gU3Rh
 cnRJbmRleD0iNTc3IiBQb3NpdGlvbj0iU2lnbmF0dXJlIj4NCiAgIC
 AgICAgPFBlcnNvblN0cmluZz5EYXdlaSBMaTwvUGVyc29uU3RyaW5n
 Pg0KICAgICAgPC9QZXJzb24+DQogICAgICA8RW1haWxzPg0KICAgIC
 AgICA8RW1haWwgU3RhcnRJbmRleD0iNTg3IiBQb3NpdGlvbj0iU2ln
 bmF0dXJlIj4NCiAgICAgICAgICA8RW1haWxTdHJpbmc+ZGF3ZWkubG
 lAc2hpbmdyb3VwLmNuPC9FbWFpbFN0cmluZz4NCiAgICAgICAgPC9F
 bWFpbD4NCiAgICAgIDwvRW1haWxzPg0KICAgICAgPENvbnRhY3RTdH
 Jpbmc+RGF3ZWkgTGkgJmx0O2Rhd2VpLmxpQHNoaW5ncm91cC5jbjwv
 Q29udGFjdFN0cmluZz4NCiAgICA8L0NvbnRhY3Q+DQogIDwvQ29udG
 FjdHM+DQo8L0NvbnRhY3RTZXQ+AQ7PAVJldHJpZXZlck9wZXJhdG9y
 LDEwLDE7UmV0cmlldmVyT3BlcmF0b3IsMTEsMTtQb3N0RG9jUGFyc2
 VyT3BlcmF0b3IsMTAsMDtQb3N0RG9jUGFyc2VyT3BlcmF0b3IsMTEs
 MDtQb3N0V29yZEJyZWFrZXJEaWFnbm9zdGljT3BlcmF0b3IsMTAsMT
 tQb3N0V29yZEJyZWFrZXJEaWFnbm9zdGljT3BlcmF0b3IsMTEsMDtU
 cmFuc3BvcnRXcml0ZXJQcm9kdWNlciwyMCwyMQ=3D=3D
X-MS-Exchange-Forest-IndexAgent: 1 2863
X-MS-Exchange-Forest-EmailMessageHash: 0EC3E35F
X-MS-Exchange-Forest-Language: en
X-MS-Exchange-Organization-Processed-By-Journaling: Journal Agent
X-MS-Exchange-Organization-Transport-Properties: DeliveryPriority=3DLow
X-MS-Exchange-Organization-Prioritization: 2:RC:REDACTED-af51df60fd698f80b0=
64826f9ee192ca@secunet.com:55/10|SR
X-MS-Exchange-Organization-IncludeInSla: False:RecipientCountThresholdExcee=
ded

Hi Eric,

On Fri, Mar 29, 2024 at 02:21:28PM +0100, Eric Dumazet wrote:
> On Fri, Mar 29, 2024 at 11:57=E2=80=AFAM Dawei Li <dawei.li@shingroup.cn>=
 wrote:
> >
> > For CONFIG_CPUMASK_OFFSTACK=3Dy kernel, explicit allocation of cpumask
> > variable on stack is not recommended since it can cause potential stack
> > overflow.
> >
> > Instead, kernel code should always use *cpumask_var API(s) to allocate
> > cpumask var in config-neutral way, leaving allocation strategy to
> > CONFIG_CPUMASK_OFFSTACK.
> >
> > Use *cpumask_var API(s) to address it.
> >
> > Signed-off-by: Dawei Li <dawei.li@shingroup.cn>
> > ---
> >  net/iucv/iucv.c | 37 ++++++++++++++++++++++++++-----------
> >  1 file changed, 26 insertions(+), 11 deletions(-)
> >
> > diff --git a/net/iucv/iucv.c b/net/iucv/iucv.c
> > index a4ab615ca3e3..b51f46ec32f9 100644
> > --- a/net/iucv/iucv.c
> > +++ b/net/iucv/iucv.c
> > @@ -520,14 +520,19 @@ static void iucv_setmask_mp(void)
> >   */
> >  static void iucv_setmask_up(void)
> >  {
> > -       cpumask_t cpumask;
> > +       cpumask_var_t cpumask;
> >         int cpu;
> >
> > +       if (!alloc_cpumask_var(&cpumask, GFP_KERNEL))
> > +               return;
>=20
> This can not be right. iucv_setmask_up() is not supposed to fail.
>=20
> Since iucv_setmask_up() is only called with iucv_register_mutex held,
> you could simply add a 'static' for @cpumask variable.

Correct, iucv_register_mutex is a global lock and can serialize access
on static cpumask var.

I will respin V2 as you suggested.

Thanks,

    Dawei
>=20
>=20
>=20
> > +
> >         /* Disable all cpu but the first in cpu_irq_cpumask. */
> > -       cpumask_copy(&cpumask, &iucv_irq_cpumask);
> > -       cpumask_clear_cpu(cpumask_first(&iucv_irq_cpumask), &cpumask);
> > -       for_each_cpu(cpu, &cpumask)
> > +       cpumask_copy(cpumask, &iucv_irq_cpumask);
> > +       cpumask_clear_cpu(cpumask_first(&iucv_irq_cpumask), cpumask);
> > +       for_each_cpu(cpu, cpumask)
> >                 smp_call_function_single(cpu, iucv_block_cpu, NULL, 1);
> > +
> > +       free_cpumask_var(cpumask);
> >  }
>=20

X-sender: <netdev+bounces-83494-peter.schumann=3Dsecunet.com@vger.kernel.or=
g>
X-Receiver: <peter.schumann@secunet.com> ORCPT=3Drfc822;peter.schumann@secu=
net.com
X-CreatedBy: MSExchange15
X-HeloDomain: mbx-dresden-01.secunet.de
X-ExtendedProps: BQBjAAoAL1SmlidQ3AgFADcAAgAADwA8AAAATWljcm9zb2Z0LkV4Y2hhbm=
dlLlRyYW5zcG9ydC5NYWlsUmVjaXBpZW50Lk9yZ2FuaXphdGlvblNjb3BlEQAAAAAAAAAAAAAAA=
AAAAAAADwA/AAAATWljcm9zb2Z0LkV4Y2hhbmdlLlRyYW5zcG9ydC5EaXJlY3RvcnlEYXRhLk1h=
aWxEZWxpdmVyeVByaW9yaXR5DwADAAAATG93
X-Source: SMTP:Default MBX-ESSEN-02
X-SourceIPAddress: 10.53.40.199
X-EndOfInjectedXHeaders: 9053
Received: from mbx-dresden-01.secunet.de (10.53.40.199) by
 mbx-essen-02.secunet.de (10.53.40.198) with Microsoft SMTP Server
 (version=3DTLS1_2, cipher=3DTLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.37; Sat, 30 Mar 2024 06:09:14 +0100
Received: from a.mx.secunet.com (62.96.220.36) by cas-essen-01.secunet.de
 (10.53.40.201) with Microsoft SMTP Server (version=3DTLS1_2,
 cipher=3DTLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Fronte=
nd
 Transport; Sat, 30 Mar 2024 06:09:14 +0100
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 84828208B8
	for <peter.schumann@secunet.com>; Sat, 30 Mar 2024 06:09:14 +0100 (CET)
X-Virus-Scanned: by secunet
X-Spam-Flag: NO
X-Spam-Score: -2.651
X-Spam-Level:
X-Spam-Status: No, score=3D-2.651 tagged_above=3D-999 required=3D2.1
	tests=3D[BAYES_00=3D-1.9, HEADER_FROM_DIFFERENT_DOMAINS=3D0.249,
	MAILING_LIST_MULTI=3D-1, RCVD_IN_DNSWL_NONE=3D-0.0001,
	SPF_HELO_NONE=3D0.001, SPF_PASS=3D-0.001] autolearn=3Dham autolearn_force=
=3Dno
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YZ3K0bKgR3tk for <peter.schumann@secunet.com>;
	Sat, 30 Mar 2024 06:09:10 +0100 (CET)
Received-SPF: Pass (sender SPF authorized) identity=3Dmailfrom; client-ip=
=3D147.75.80.249; helo=3Dam.mirrors.kernel.org; envelope-from=3Dnetdev+boun=
ces-83494-peter.schumann=3Dsecunet.com@vger.kernel.org; receiver=3Dpeter.sc=
humann@secunet.com=20
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com C43A3208B4
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249]=
)
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id C43A3208B4
	for <peter.schumann@secunet.com>; Sat, 30 Mar 2024 06:09:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.2=
5.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D1641F22702
	for <peter.schumann@secunet.com>; Sat, 30 Mar 2024 05:09:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D76C79F0;
	Sat, 30 Mar 2024 05:09:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from bg1.exmail.qq.com (bg1.exmail.qq.com [114.132.65.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 418523FF1;
	Sat, 30 Mar 2024 05:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=3Dnone smtp.client-ip=
=3D114.132.65.219
ARC-Seal: i=3D1; a=3Drsa-sha256; d=3Dsubspace.kernel.org; s=3Darc-20240116;
	t=3D1711775345; cv=3Dnone; b=3DgfLWY1ioFi9jl1ZBFjmxmFW2tHmdP96al/rViDheOny=
YsGPNiY/6rojsa6KuCViu6ospo8JqIPmrQ5kYhXxI4fWTd13oBUM7loEJ816ctuoV5AIOJRDqdy=
8LJMFGF588bEGNcNoJZnlMJ+26z+gcXZ2kaQlCf0QR+U0nKFsVYlw=3D
ARC-Message-Signature: i=3D1; a=3Drsa-sha256; d=3Dsubspace.kernel.org;
	s=3Darc-20240116; t=3D1711775345; c=3Drelaxed/simple;
	bh=3DnYsJpAvl6D6Ldufd73Rjy7YF1XYSzElH1fykgREgPxY=3D;
	h=3DDate:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=3DnPDDajRC5sef6WYcCenUzFr=
Jabkj3nFiAaNM8jxBguQE+fYD0jUXLYNwIYYdx/DfR8ex7tUilcegtdOsom4YdWhROAmwHDAxg4=
AfPonb2M1mMwD3xYUyVNldguOl29V8JvaRRyAAWjRH+cUhqKQq6qdlYHWWn1MFfLqI2qghuRo=
=3D
ARC-Authentication-Results: i=3D1; smtp.subspace.kernel.org; dmarc=3Dpass (=
p=3Dnone dis=3Dnone) header.from=3Dshingroup.cn; spf=3Dpass smtp.mailfrom=
=3Dshingroup.cn; arc=3Dnone smtp.client-ip=3D114.132.65.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=3Dpass (p=3Dnone di=
s=3Dnone) header.from=3Dshingroup.cn
Authentication-Results: smtp.subspace.kernel.org; spf=3Dpass smtp.mailfrom=
=3Dshingroup.cn
X-QQ-mid: bizesmtpsz13t1711775229tdi4p2
X-QQ-Originating-IP: RfTYRleHqifmaUL5vg3HHBAADHtyt3J2efZxDgCsTa0=3D
Received: from localhost ( [112.0.147.175])
	by bizesmtp.qq.com (ESMTP) with=20
	id ; Sat, 30 Mar 2024 13:07:07 +0800 (CST)
X-QQ-SSF: 01400000000000704000000A0000000
X-QQ-FEAT: OtIeQkg1QQHVkELNGhnn3Ao/OxN3u837g2WY2miXs+dKwNICeHodGDXYI+XIN
	MLiksvoY6OK484p/H1Pd7HcbM0rICeev22amIC6/BI2BPXdj7hZR/NjRgIzO0ujc7AJYyuh
	hSs4kN6XesHATJzk7YtHOv0oscVKSJDG1YcCID61KeNwB//v/SP6Vco5Zi0zVzK2CryiHy7
	MDlcbxtiVcvQbWgHR9uJniyBUgkXuWUpSRm9PGge+rsWbj+CoXH7KA5p92J+1tMYPfc3pMS
	a2+D1HW1CQDyFXgH/iGbdQU2wmJ3Udzd7Q8BgYnuoVkISFF2Z3cH4G9BqZDzzOAp62v8M7U
	2sZsZTz6rWN4NWIO+LXnMPEd2Ftx/MDN8OxPXGUXp3ZrWXMIP1dg4Nut1Jfsg=3D=3D
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 10889329762490604258
Date: Sat, 30 Mar 2024 13:07:06 +0800
From: Dawei Li <dawei.li@shingroup.cn>
To: Eric Dumazet <edumazet@google.com>
CC: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
	ioana.ciornei@nxp.com, wintera@linux.ibm.com,
	twinkler@linux.ibm.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH net-next 1/2] net/iucv: Avoid explicit cpumask var
 allocation on stack
Message-ID: <4E49057A4198779C+Zged+hXhxE4GksiL@centos8>
References: <20240329105610.922675-1-dawei.li@shingroup.cn>
 <20240329105610.922675-2-dawei.li@shingroup.cn>
 <CANn89iJzuw8_ti4P4tJ_A3Fd0QCjHTBjasbm_J3N8up=3DgK8Aow@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=3D"utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANn89iJzuw8_ti4P4tJ_A3Fd0QCjHTBjasbm_J3N8up=3DgK8Aow@mail.gm=
ail.com>
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpsz:shingroup.cn:qybglogicsvrgz:qybglogicsvrgz5a-1
Return-Path: netdev+bounces-83494-peter.schumann=3Dsecunet.com@vger.kernel.=
org
X-MS-Exchange-Organization-OriginalArrivalTime: 30 Mar 2024 05:09:14.5645
 (UTC)
X-MS-Exchange-Organization-Network-Message-Id: 30801339-1396-408f-853e-08dc=
50778b26
X-MS-Exchange-Organization-OriginalClientIPAddress: 62.96.220.36
X-MS-Exchange-Organization-OriginalServerIPAddress: 10.53.40.201
X-MS-Exchange-Organization-Cross-Premises-Headers-Processed: cas-essen-01.s=
ecunet.de
X-MS-Exchange-Organization-OrderedPrecisionLatencyInProgress: LSRV=3Dcas-es=
sen-01.secunet.de:TOTAL-FE=3D0.005|SMR=3D0.004(SMRPI=3D0.003(SMRPI-Frontend=
ProxyAgent=3D0.003));2024-03-30T05:09:14.569Z
X-MS-Exchange-Forest-ArrivalHubServer: mbx-essen-02.secunet.de
X-MS-Exchange-Organization-AuthSource: cas-essen-01.secunet.de
X-MS-Exchange-Organization-AuthAs: Anonymous
X-MS-Exchange-Organization-OriginalSize: 8505
X-MS-Exchange-Organization-Transport-Properties: DeliveryPriority=3DLow
X-MS-Exchange-Organization-Prioritization: 2:ShadowRedundancy
X-MS-Exchange-Organization-IncludeInSla: False:ShadowRedundancy

Hi Eric,

On Fri, Mar 29, 2024 at 02:21:28PM +0100, Eric Dumazet wrote:
> On Fri, Mar 29, 2024 at 11:57=E2=80=AFAM Dawei Li <dawei.li@shingroup.cn>=
 wrote:
> >
> > For CONFIG_CPUMASK_OFFSTACK=3Dy kernel, explicit allocation of cpumask
> > variable on stack is not recommended since it can cause potential stack
> > overflow.
> >
> > Instead, kernel code should always use *cpumask_var API(s) to allocate
> > cpumask var in config-neutral way, leaving allocation strategy to
> > CONFIG_CPUMASK_OFFSTACK.
> >
> > Use *cpumask_var API(s) to address it.
> >
> > Signed-off-by: Dawei Li <dawei.li@shingroup.cn>
> > ---
> >  net/iucv/iucv.c | 37 ++++++++++++++++++++++++++-----------
> >  1 file changed, 26 insertions(+), 11 deletions(-)
> >
> > diff --git a/net/iucv/iucv.c b/net/iucv/iucv.c
> > index a4ab615ca3e3..b51f46ec32f9 100644
> > --- a/net/iucv/iucv.c
> > +++ b/net/iucv/iucv.c
> > @@ -520,14 +520,19 @@ static void iucv_setmask_mp(void)
> >   */
> >  static void iucv_setmask_up(void)
> >  {
> > -       cpumask_t cpumask;
> > +       cpumask_var_t cpumask;
> >         int cpu;
> >
> > +       if (!alloc_cpumask_var(&cpumask, GFP_KERNEL))
> > +               return;
>=20
> This can not be right. iucv_setmask_up() is not supposed to fail.
>=20
> Since iucv_setmask_up() is only called with iucv_register_mutex held,
> you could simply add a 'static' for @cpumask variable.

Correct, iucv_register_mutex is a global lock and can serialize access
on static cpumask var.

I will respin V2 as you suggested.

Thanks,

    Dawei
>=20
>=20
>=20
> > +
> >         /* Disable all cpu but the first in cpu_irq_cpumask. */
> > -       cpumask_copy(&cpumask, &iucv_irq_cpumask);
> > -       cpumask_clear_cpu(cpumask_first(&iucv_irq_cpumask), &cpumask);
> > -       for_each_cpu(cpu, &cpumask)
> > +       cpumask_copy(cpumask, &iucv_irq_cpumask);
> > +       cpumask_clear_cpu(cpumask_first(&iucv_irq_cpumask), cpumask);
> > +       for_each_cpu(cpu, cpumask)
> >                 smp_call_function_single(cpu, iucv_block_cpu, NULL, 1);
> > +
> > +       free_cpumask_var(cpumask);
> >  }
>=20


