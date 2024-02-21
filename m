Return-Path: <linux-kernel+bounces-75016-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D97085E198
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 16:42:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31D232848C9
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 15:42:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DB0780618;
	Wed, 21 Feb 2024 15:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="j7GfqZqi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TOGJOkc0"
Received: from fout3-smtp.messagingengine.com (fout3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 735E380BED
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 15:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708530122; cv=none; b=aLgwMRdM06mYZHYca6KlcDqOAHa4KhUVcEbFDcLCpMduZ66RiRUQspLRfsCLD3e87SetDeA9UekdPYk6I0rCh6thdh7Lv3syG0xwOUIQ/xs4xLHhArxEwvn9/WoZyUpoySIyEQhDV3oqd8q7o8SMNrB8WwQpf06oLYKxZqsQqAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708530122; c=relaxed/simple;
	bh=QNjyzFAK+0FPQYRPSv8eliLqWbki78LLyVo70giiKok=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=ccaTPCk3AgyrPqmmsCVmsRFi1R735trmNVlrhpsacOVXQg312mIArjihujTBMNJI4L4K18sZ3V99ne9OgT0bA+gvBcWLERxnOvyi5roSB32IizOselD3cwrwByiei5UhqOW3vjx05zZqF9eu/3HLcvl8IblidESom82ErV2XiQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=j7GfqZqi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TOGJOkc0; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id 7C7B31380095;
	Wed, 21 Feb 2024 10:41:59 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Wed, 21 Feb 2024 10:41:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1708530119; x=1708616519; bh=3SOuYtscV2
	53CfoXRPBVU4MmlFp7PxBuOoBfx+N0S3A=; b=j7GfqZqiKBWH2r5jayJ4RwTTv+
	Jq2sjrtxvDXWYigKj5zaxkqgbxGUpaCG4IZTwSCdAzxx51CPPFJfP4dtSALpC3oS
	4Z4jw06Q1tgnNcjYukiGHTZd3+Vea+OZfgopnDJaOJpXlO/FAY5axtxA05Ygd1Il
	FbDXtzYvw2RQLJru8/YorSAXmRF/OmkPK+/TyZvC0MxiO2mS9td8SfF0elypXYUb
	ZlyDYrCJuVYRg3oaZaVfMIdQvKhnGeOmGg3SZ9DNQ81Yfyvdpqu6l3h2stf2wtnd
	JsdUCicZ4pDiKuGPq9/65QeVR8BOwmZWhLe7INBicGoJ4VIUB+2xxS/fcYxA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1708530119; x=1708616519; bh=3SOuYtscV253CfoXRPBVU4MmlFp7
	PxBuOoBfx+N0S3A=; b=TOGJOkc0mAJ/17Ewn/A+k88M4FzQsdMz9TRDunQYRMGE
	nrwZ8Lz0Ik99aQrsxW9uPmFqtOJ/4w2gl09cVqII26kyeD4uOYJI9/8kwd0PVU8Y
	L4YweNdC48QBKXCbv5ZDj1GStxLr2fJ6RibTlTaHZucW/N0rtgD6c7bcquzbH7vn
	yeELZr/LlyNrcj51Ir2qbsUHeidB3BM6HxBReOUcGGwPoNrhrWG6IdeoAkhoJq8j
	nOmwbbOtdt6SikIpRLQYZwdQd+CMqK98YiZaA/4M7/E2SxHA2tPPLsgXAPDoun/5
	P9w9cjf7mdSHND+HpL6Q9p/NcJArlaOjh18paXtsQA==
X-ME-Sender: <xms:xhnWZTprflkntv8BVrjfJwldaazH57cVkEO7uWn1zjItQz5xBdAadg>
    <xme:xhnWZdrflxw9Zap76j796nEy-lznFHNynL-NVlAs2sbu1GvGvhjOKVAH5MumVxJol
    rF5C0yfREQ3m0eFNJA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedvgdejlecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeevhfffledtgeehfeffhfdtgedvheejtdfgkeeuvefgudffteettdekkeeufeeh
    udenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:xxnWZQOEIADDLEhXFWIexIt7ABB-JMTDB7yuUbS5h5Am7CqrLuCGdA>
    <xmx:xxnWZW5TGtbWyI5zhzH7KXRz3DjulS32IbeYKNpCNofGib1xEQQL0Q>
    <xmx:xxnWZS4e1lmk5Gz8OzdqIMZjjd2cV61dRqfvN3LlqpP01B9x9eBVsA>
    <xmx:xxnWZRQ_SwRMF_XSSPHbWhxbsjYut1VpeyCX9dEg8HAwD6KCQX9vPQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id E7868B6008D; Wed, 21 Feb 2024 10:41:58 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-153-g7e3bb84806-fm-20240215.007-g7e3bb848
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <56625c21-1b34-479b-b5b2-4c4d8b7a11b3@app.fastmail.com>
In-Reply-To: 
 <fy3wffb2jwv4veo3golfn5olri77clxywbuwuokese7sbobixd@mird5k66cl2w>
References: <20240221141350.3740488-1-javierm@redhat.com>
 <1f28256c-e436-4add-aa67-2cfb2248b220@linaro.org>
 <6scz7iti3tzzrd4ph3gnuc2pvkcbtuuicgfgujh3pa3c34kdkt@bhfa4xbxeu7t>
 <cb8bf006-57df-494e-80f3-947582ec71f1@linaro.org>
 <fy3wffb2jwv4veo3golfn5olri77clxywbuwuokese7sbobixd@mird5k66cl2w>
Date: Wed, 21 Feb 2024 16:41:38 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Maxime Ripard" <mripard@redhat.com>,
 "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>
Cc: "Javier Martinez Canillas" <javierm@redhat.com>,
 linux-kernel@vger.kernel.org,
 "Enric Balletbo i Serra" <eballetbo@redhat.com>,
 "Erico Nunes" <nunes.erico@gmail.com>, "Brian Masney" <bmasney@redhat.com>,
 "Bjorn Andersson" <quic_bjorande@quicinc.com>,
 "Catalin Marinas" <catalin.marinas@arm.com>,
 "Geert Uytterhoeven" <geert+renesas@glider.be>,
 "Konrad Dybcio" <konrad.dybcio@linaro.org>,
 "Marek Szyprowski" <m.szyprowski@samsung.com>,
 "Neil Armstrong" <neil.armstrong@linaro.org>,
 "Will Deacon" <will@kernel.org>, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2] arm64: defconfig: Enable zram, xfs and loading compressed FW
 support
Content-Type: text/plain

On Wed, Feb 21, 2024, at 16:24, Maxime Ripard wrote:
> On Wed, Feb 21, 2024 at 04:10:12PM +0100, Krzysztof Kozlowski wrote:
>> On 21/02/2024 15:48, Maxime Ripard wrote:
>> > On Wed, Feb 21, 2024 at 03:22:38PM +0100, Krzysztof Kozlowski wrote:
>> >> On 21/02/2024 15:13, Javier Martinez Canillas wrote:
>> >>> These options are needed by some Linux distributions (e.g: Fedora), so
>> >>
>> >> How ZRAM is needed? Why Fedora cannot boot without it? Debian, which I
>> >> use on my arm64 boards, does not have any problem.
>> > 
>> > Is it relevant in any way?
>> 
>> Yes, because it is justification why we are doing it. Each commit is
>> supposed to explain "why" and the explanation here is not enough.
>
> There's a why though: it makes Fedora boot. It might not be enough for
> you, but that's a different story. So, if it's not enough, please state
> exactly what you expect from that patch description so Javier can
> provide it.

It's definitely enough for me. It makes a lot of sense to have
a defconfig that boots common and popular distros.

I don't use ZRAM either, but I can see that being useful to
avoid swapping to SD cards or eMMC when that is the only
available swap device.

>> >> I kind of repeat comments from similar patch earlier:
>> >> https://lore.kernel.org/all/fe1e74a2-e933-7cd9-f740-86d871076191@linaro.org/
>> >>
>> >> About XFS: I don't think it is needed to boot anything.
>> > 
>> > Just like 9P_FS, NFS or UBIFS.
>> 
>> NFS is often used on targets, e.g. my board farm, but also by other people.
>> 
>> UBIFS was added recently because one device was using it - you needed
>> it. 9P_FS looks unnecessary.
>
> So all we need is one person or use case to require it? Sounds like
> we've checked that mark here.

I think we want all of the above. We can probably drop ext2 since
we already need ext4, but that is a different question.

>> I was working in distro so trust me - they do stuff differently
>> and they not need XFS in our defconfig for anything.
>
> Sure, but you're not just arguing for XFS there.
>
> What I really don't get is this: this makes the life of people easier.
>
> Being able to test an upstream kernel quickly when you have a bug in a
> downstream distro is super valuable for any distro developper. And on
> the long run, if we don't make the switch from a kernel distro to a
> mainline kernel relatively easy, we're the ones that will lose out.
> Because people just won't bother, or be frustrated and thus super
> reluctant to do that work.

We had previously discussed adding config fragments for common
distros the way we have kvm_guest.config, but if the Javier's
patch is all that is actually needed for Fedora, that seems better
to me than the added complexity of fragments.

      Arnd

