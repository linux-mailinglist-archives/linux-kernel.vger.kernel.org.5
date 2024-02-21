Return-Path: <linux-kernel+bounces-75057-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D27985E241
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 17:00:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 611F01C214EC
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 16:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3C4C81720;
	Wed, 21 Feb 2024 15:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="PLDnYIbI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NRDS+sOn"
Received: from wfhigh1-smtp.messagingengine.com (wfhigh1-smtp.messagingengine.com [64.147.123.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A066811E8;
	Wed, 21 Feb 2024 15:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708531134; cv=none; b=czvR+h90lYSz7xne3E7mVfJClSqQPf2YjVlBuUoXkDbbe1PrNe/NOjQ1axF3+JV/74QsCL0AclD07KEU/rOQZ3XpiMvONOhn6L8WR9fhkn9oDuyuOmjzpf0gF9H4raQ06QNHhQQ0pF4Blug2KZAL8XfQW/JuA1F5/ZkB0+XT/eE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708531134; c=relaxed/simple;
	bh=9ZsTtWFzhawjYmdNQqpK2i1o/zg623ZUB4xUBgHk8bc=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=b7aNOxzlVZrJZYbFLvXXQCdkZOjZnXr4jpDbEvjR3s3F3JkZ9LgryrmtZHU6p0Pe2u7N7PnKYZ/TL0Csxu42GKmhU+9pzfuytmnkEI/M6yKZw6y4vC/tDO5z1lZXyTkp/XTZzL90V4IYIWekXimIXfOmpjBmqzHshRfNz+UzaiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=PLDnYIbI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NRDS+sOn; arc=none smtp.client-ip=64.147.123.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.west.internal (Postfix) with ESMTP id E7C28180039A;
	Wed, 21 Feb 2024 10:58:50 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Wed, 21 Feb 2024 10:58:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1708531130;
	 x=1708617530; bh=+t3h6wUCjPnpK2OpV867PvNULCpK9XQ6yqZ2SEKXuJo=; b=
	PLDnYIbIfHUPd7gPcVEz1ZoDxUAfldsHjjKKQJWkHiflL50JLR1ivoHoEjlrld0S
	mGYLWSv8UGoGvT1+7xxvTTvF//Yw6eXtr0CLCPQ0GkMbX1cknK7M3wnT6xY0wtiV
	aA4DkMcv0UjhTBmXK5Xvii5Gfnp5lBnSHnOYF+jHAz+S5IeBG9nWGAgZxwyJVgU1
	Tn4+U6apJrWa4EMa992Gtp6GLT2N+ho0C7Vtq8pP+kMyXnoNLeEKwT1TpowaTlAD
	bZQdEeE2+2jPTF3o/dXObJqZnGiNgxt31X+tUXiGMR03g8TIwCKtfrTSD5ZcKXrm
	lEiXt/RoBRQbq8O8VWCntQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1708531130; x=
	1708617530; bh=+t3h6wUCjPnpK2OpV867PvNULCpK9XQ6yqZ2SEKXuJo=; b=N
	RDS+sOnqvyZvcB9ONmdQYO4F3xLxDj1hSEZSbjzHthzpbosdwLdaXHHewDSsdRYL
	XjlCKItAFDPg8prrNP1ewBD5OdpxrqPxQdkqJPVkrS7356fuOVlF1XsLOjwkcQwr
	2/AlbRXXetRwpY9EaZfTbHM5qH8iwDW3MePpwLMVhk43UlFU5Qf31lQQUjH6e/N+
	XX06Bgl7UFibrp6eplySYOoCarnZI/VIKXzGx/K1CZRQ9idAiGIxY7R3M3/PSe2p
	9xjVfUosmWPhXWgNDE3g/sCVVfL9BusONofF5jU+moLnM/+9JlObzzSzJVeaZDAE
	4HAUdEdvg5BOhy9pgTjXA==
X-ME-Sender: <xms:uR3WZWqVYdi3cgjXaKodRYjy8G156HdhXuNy69fLaJhD8zACUXfV1w>
    <xme:uR3WZUr2d7-Fb3cGJltt23bb11VnqVsV2psUK7yyiLTxqzdgMi9OXRUSsikq9hUXP
    M_u-5bY541W5uePhcQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedvgdekvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepgeefjeehvdelvdffieejieejiedvvdfhleeivdelveehjeelteegudektdfg
    jeevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:uR3WZbOx8nyhb5p-nEZuWwY-x0GsVzZ8jHDN-GpmnMcuGPv3Xai69Q>
    <xmx:uR3WZV7n444h_yyI5uktVfO2DRErpGqYL5B4tkDi8FYP8Ao6gdmc6w>
    <xmx:uR3WZV6706MdaK5evWRYdgKPrb3P3lOUM7vLgKsKFTXV_Dnq3do0OA>
    <xmx:uh3WZQanU9nb26ZYzybmKq2k4a-eTdaPuJQIuztL60fVFwbfTWUGybosU9w>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id C2BC6B6008D; Wed, 21 Feb 2024 10:58:49 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-153-g7e3bb84806-fm-20240215.007-g7e3bb848
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <7178ea35-da8d-4f25-9193-78dd11902eef@app.fastmail.com>
In-Reply-To: 
 <CAMuHMdXNyU0eBcMe3EhhfahcRo2KtXzwdr+d_6AC-2529R3bmQ@mail.gmail.com>
References: <20240221092826.748e70c4@canb.auug.org.au>
 <CAL_JsqKw9OXb=aOMni1qprzeWDBgmjdJef-6VAjwx0R--D+URw@mail.gmail.com>
 <ac9ddf79-6bc9-4daf-a271-82f8b3bca988@app.fastmail.com>
 <CAL_Jsq+L7uPimQfATs14EWCbqRO1vxDUmPie7=cChTLCf2od2g@mail.gmail.com>
 <CAMuHMdXNyU0eBcMe3EhhfahcRo2KtXzwdr+d_6AC-2529R3bmQ@mail.gmail.com>
Date: Wed, 21 Feb 2024 16:58:29 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Geert Uytterhoeven" <geert@linux-m68k.org>,
 "Rob Herring" <robh@kernel.org>
Cc: "Stephen Rothwell" <sfr@canb.auug.org.au>,
 "Geert Uytterhoeven" <geert+renesas@glider.be>,
 "Olof Johansson" <olof@lixom.net>,
 ARM <linux-arm-kernel@lists.infradead.org>,
 "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
 linux-next <linux-next@vger.kernel.org>
Subject: Re: linux-next: build warning after merge of the arm-soc-fixes tree
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 21, 2024, at 15:51, Geert Uytterhoeven wrote:
> On Wed, Feb 21, 2024 at 3:27=E2=80=AFPM Rob Herring <robh@kernel.org> =
wrote:
>> On Wed, Feb 21, 2024 at 7:00=E2=80=AFAM Arnd Bergmann <arnd@arndb.de>=
 wrote:
>> > On Wed, Feb 21, 2024, at 14:53, Rob Herring wrote:
>> > > On Tue, Feb 20, 2024 at 3:28=E2=80=AFPM Stephen Rothwell <sfr@can=
b.auug.org.au> wrote:
>> > >> arch/arm/boot/dts/renesas/r8a7793-gose.dtb: Warning (interrupt_m=
ap): Failed prerequisite 'interrupt_provider'
>> > >>
>> > >> Introduced/exposed by commit
>> > >>
>> > >>   78b6f8e7379b ("dtc: Enable dtc interrupt_provider check")
>> > >>
>> > >> I guess you missed some :-(
>> > >
>> > > No, Geert separately posted fixes for already.
>> >
>> > I did make the mistake of applying the final patch "dtc:
>> > Enable dtc interrupt_provider check" to the arm/fixes branch
>> > for 6.8 along with the other fixes.
>> >
>> > Clearly that should be separate and only go into mainline
>> > after there are no more regressions, but now I'm unsure
>> > about the other patches -- did you intend the dts fixes
>> > for 6.8 or for the coming merge window?
>>
>> Either is fine with me. My intent was the whole series plus the
>> Renesas fix to be applied together. Anything new that crops up we can
>> fix on top.
>
> If you want me to move commit b4f97d1b5aeb6166 ("ARM: dts: renesas:
> rcar-gen2: Add missing #interrupt-cells to DA9063 nodes") to
> renesas-fixes, please tell me.

Up to you. I have done some merges yesterday but have not started
merging the dt branches, so you can still send an updated v2
if you prefer (or have this patch in both branches). Please
let me know how you decide.

I have now dropped the Makefile.lib patch from the arm/fixes
branch (it was the top patch, so I did not need to rebase)
and plan to apply it on top of the soc/dt branch instead.

     Arnd

