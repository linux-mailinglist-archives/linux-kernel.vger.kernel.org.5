Return-Path: <linux-kernel+bounces-101548-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC72B87A894
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 14:39:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E8EBB22085
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 13:39:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5E694437D;
	Wed, 13 Mar 2024 13:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GYgcaqBQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 185CD4087C
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 13:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710337164; cv=none; b=l/q5Y7q90R5lwOmX7zxGIQIoxkupS/s5tYx1CykQjQ2yY/lZfKzHPbMwsUJkYXA+SyQ0kCFPw7QiOoTlcpnCB48iux8kjq8ZoULyHe0gO0qWyzjvqEI0qaNG+1F1M3tXHf8Ey3nHOKwP/4qEfHbHG/AoYNuWedZA2Mex6tbCeaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710337164; c=relaxed/simple;
	bh=Xhj8PeGA+xn3RlIFxAyzyjj2VoYDNowf7/GzR0mzkcI=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=tylBnWUucYyJJyuGLai+Qwee8svm7YpVhBziAyof5CKsO5V97JIY7/5AkfGbwJnuqLevBDKatCDFPYtntFpl5RqEwg9mKHVzT0wmRDhlCgOHCbk73bwMMJQKGodVcDEa08Ch+Wp3pZS+G5ObtuN1YsIDE4xNDGT3FSe+jCYLQbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GYgcaqBQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 669B3C43399;
	Wed, 13 Mar 2024 13:39:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710337163;
	bh=Xhj8PeGA+xn3RlIFxAyzyjj2VoYDNowf7/GzR0mzkcI=;
	h=In-Reply-To:References:Date:From:To:Cc:Subject:From;
	b=GYgcaqBQ3otWLI05Cxd8FbyYoePrktfKd0g+YxsNPY8VT57VOLfFEKRereujisEul
	 AdsarZigeT6DDq7KWx5jHtIgG1460AeYRrDh7WkzrwtwaZm/oQkSwVRi008XilA+LN
	 KZfdMOomVJlsXf2EOZ+gKhE1F3boucYUbnmGkEIPfyc9ckzcSPX+nt/JMoKw7uNwjz
	 tJ/vllKjYHMRg5i4HoSkwgUuK6jGIxIHGzPz/bkzfXLhfEjDCjgX40MaANvWGGg+am
	 IF1Q5N8t7BhRzJ3hgU1wIaNIVh26ZhhiUFILSRQ1NhsIRgHFYrtYsM7NSnbza1S8Rn
	 TI0YVlIJA8UwA==
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfauth.nyi.internal (Postfix) with ESMTP id 50DC9120006A;
	Wed, 13 Mar 2024 09:39:22 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Wed, 13 Mar 2024 09:39:22 -0400
X-ME-Sender: <xms:iazxZVjjBTP9gjRDwv5yMgdIsEgM9WQpwY9IO0jM1PczrBFbytnxPw>
    <xme:iazxZaD42DClgIDIfbfUopTidRGiisdd-avVz6omhLD_TcpZP61fMvTdk-zJE2T9i
    LqShiEbJigYyzM4LNk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrjeehgdehgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusehkvghrnhgvlhdrohhrgheqnecuggftrf
    grthhtvghrnhepvddttdffjeefgeeggfelfefggefhheeffefftefggfelgeduveevtefh
    feejveeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    eprghrnhguodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduvdekhedujedt
    vdegqddvkeejtddtvdeigedqrghrnhgupeepkhgvrhhnvghlrdhorhhgsegrrhhnuggsrd
    guvg
X-ME-Proxy: <xmx:iazxZVH0oaZVp7GUugBinV1Qq5kQ5vD1wHyw-0dVDA0sRu-TzT3tFw>
    <xmx:iazxZaQ4BTI4BBQPJTJp3WaNB36yjaBtIo9kiZuifrtf0xtuSbyGdw>
    <xmx:iazxZSw6kKhhTEAu4420A52rgPsP3NZYuzFxWyAxBhT5YN_Eg2ZROQ>
    <xmx:iazxZQ7pIqN8hcyrOrVE-Ittl22kGRrJ6sf5_OH_Uhxs-mgSpconcg>
    <xmx:iqzxZdzq8bPaYCo2DJXhNoanwZ55mrNjLQQAU8JBrEmFYgf330-HfR7DFgk>
Feedback-ID: i36794607:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 47790B6008D; Wed, 13 Mar 2024 09:39:21 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-251-g8332da0bf6-fm-20240305.001-g8332da0b
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <21cd0f32-c94b-4b2b-8fa6-ebe12756b0c4@app.fastmail.com>
In-Reply-To: <610231c3-c3ee-e543-1a8a-8e1098ee6a7c@huawei.com>
References: <20240313084707.3292300-1-arnd@kernel.org>
 <4f945f4a-ac29-3ef7-9e15-123962f2a0e9@huawei.com>
 <e0684202-6926-4bd1-86f6-2bb682524712@app.fastmail.com>
 <1a12c8ed-0cb5-5650-24a2-84b021c444c3@huawei.com>
 <b08aaae4-8c69-47eb-9658-5f3f5c8e4056@app.fastmail.com>
 <610231c3-c3ee-e543-1a8a-8e1098ee6a7c@huawei.com>
Date: Wed, 13 Mar 2024 14:39:01 +0100
From: "Arnd Bergmann" <arnd@kernel.org>
To: "Zhihao Cheng" <chengzhihao1@huawei.com>, "Arnd Bergmann" <arnd@arndb.de>,
 "Richard Weinberger" <richard@nod.at>,
 "Miquel Raynal" <miquel.raynal@bootlin.com>,
 "Vignesh Raghavendra" <vigneshr@ti.com>,
 "Daniel Golle" <daniel@makrotopia.org>
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mtd: ubi: avoid expensive do_div() on 32-bit machines
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 13, 2024, at 14:29, Zhihao Cheng wrote:
> =E5=9C=A8 2024/3/13 20:21, Arnd Bergmann =E5=86=99=E9=81=93:
>> On Wed, Mar 13, 2024, at 13:10, Zhihao Cheng wrote:
>>> =E5=9C=A8 2024/3/13 19:53, Arnd Bergmann =E5=86=99=E9=81=93:
>>>> On Wed, Mar 13, 2024, at 12:29, Zhihao Cheng wrote:
>>>>
>>>> The way it usually goes is that someone adds an open-coded
>>>> 64-bit division that causes a link failure, which prompts
>>> I'm a little confused, what kind of link failure? Could you show an =
example?
>>=20
>> The open-coded 64-bit division without using do_div() shows up as
>>=20
>> x86_64-linux-ld: drivers/mtd/ubi/nvmem.o: in function `ubi_nvmem_reg_=
read':
>> nvmem.c:(.text+0x10a): undefined reference to `__umoddi3'
>> x86_64-linux-ld: nvmem.c:(.text+0x11f): undefined reference to `__udi=
vdi3'
>> x86_64-linux-ld: drivers/mtd/ubi/nvmem.o: in function `ubi_nvmem_reg_=
read.cold':
>> nvmem.c:(.text.unlikely+0x2d): undefined reference to `__umoddi3'
>>  > The idea is that gcc expects __umoddi3 to be provided by libgcc,
>> but Linux intentionally leaves it out in order to catch accidental
>> 64-bit divisions.
>>=20
>
> Thanks for explaination, which means that do_div is used for 64-bit=20
> division to solve the link failure caused by missed libgcc. Since=20
> parameter 'from' is u32, there is no need to invoke do_div on a 32-bit=20
> platform, you just want to stop the wasting behavior on a 32-bit=20
> platform. Do I understand right?

Yes, correct.

      Arnd

