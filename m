Return-Path: <linux-kernel+bounces-70765-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2225C859BF4
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 07:21:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0FCB281589
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 06:21:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09FAE200BA;
	Mon, 19 Feb 2024 06:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="s2IOVqvh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="I0UNMtad"
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B30101CD38;
	Mon, 19 Feb 2024 06:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708323698; cv=none; b=rN/AIp6Cn8d7i8qI3DG5r8eIfumR5IFql7+fCNtf4FWJ1f01juOzkm8ZM4epUIlZB0TRC70o45vrekp4rL17fewzocQvoq45Oj1lvph2UObYgkRDQzhRr2O7p6Xj3d5BzhhaQ2tLgkoM6brfs7D3yuv5tIhUcI2zXS3i/oRm/mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708323698; c=relaxed/simple;
	bh=G5EPwk7arzO6YoCzr0UQc0o9BgPoKKHKNTkh3mzfbZw=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=RDqnc4hc+ngD0j5O+fx/kxC45SHxtDSEmboyAtO83n7V3RBNNS6i9o/RtHPyiAemp7lSe/igx4cPhD16odmw+cC4FOJjhuq5jtEyZ2hBJPG5+eUHlBnR8jBqMg7gsPHcLq1ttcYXvss5Ao46HwiEE+S2bxGXzk7d/xt8ysRrWZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=s2IOVqvh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=I0UNMtad; arc=none smtp.client-ip=66.111.4.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id 9A5335C005D;
	Mon, 19 Feb 2024 01:21:34 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Mon, 19 Feb 2024 01:21:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1708323694;
	 x=1708410094; bh=AQpZrl+IvXCpOpDkvvYnVCKxOiLdnwSRn5oGsD7e3Eo=; b=
	s2IOVqvhboBuC/k3Blx25GcR6KVtm3mDUNExQLXrHtjNamYPHpIoQhVwHQHasUPm
	v2TWbZVN1jR5H5qBxnRnUMCxhhBDRX7l7jOCD6VVdAOGkAvq3sTGtDxDQrC1lBIQ
	kwqyZ3cgqg2UnMdxCzw/KZ4Kq51V2eea1byEeZv74iKUSWY5IvctmFEMIPphNQVq
	VE9uMkBBc8atY1jpnzzhT2DjlRU2KXcCFdDJF6jgvgomKqsrRdT43cs9Ev3kztHv
	MKO+bZZrbiRgBhtYCnbr3oB3RuFwE7g+5iCDhV56HcMsf34kMay71kudbb1wTSs3
	PENBeJgmO7ArXsrHR/htwA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1708323694; x=
	1708410094; bh=AQpZrl+IvXCpOpDkvvYnVCKxOiLdnwSRn5oGsD7e3Eo=; b=I
	0UNMtadwi4o81nJpXjdR2QDYVHJKECqS4U+TdcfkH2Jk5bKaUFeWRvaxw3M1fGY7
	InO79odXO/Soo1M/wG5AstSzDB6BW1eMLmWNQO1n6wtUqHTkh5B96KZHyEIxa/DR
	eNBuoQPGDGL/Stl7/1Koq2kfZ9nZ3cFUF0D0V3evTXQqk00Q6BaIya+zZR9MMeKU
	mLfStzuUdZK3B6pGgS+qEaPMM48VcmnbEmmQHb5BPvGNV9tYEeYfXow4S484W1iu
	j3qeTGKWKWGuHjBlTOs/T8Rql9m1g1vhR5ys9OplzT5Fkfq9JW9hCaTt2G+vp8Wk
	CEKd5lky1Fj1yImlntMEg==
X-ME-Sender: <xms:bPPSZZ1CqCWmce9BxypBS9A_cXXkzrjZxtUrjVtgra3lr0ULYFNuAA>
    <xme:bPPSZQGHLwvK1Gkzy6s3dPYJnaqCuWxK6VY0qKkeKrSf8GMt5V_6iLQQcrKC5xQlq
    saH_oCM4G4AW4WXxCE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdejgdelhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepgeefjeehvdelvdffieejieejiedvvdfhleeivdelveehjeelteegudektdfg
    jeevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:bPPSZZ6508DIIGGowADrsjtVXFd6nvPUma4DYQPbbfD2wmLS554ltg>
    <xmx:bPPSZW1odbny3rkmTdtBoaUa3rub-aplFpsA0wn9J0MGu20JweBjug>
    <xmx:bPPSZcEoj3nAAtnNZ0LEW39bXJt1-iXDaszxjaFI32D5ZH4n5hMmkA>
    <xmx:bvPSZRP-wI0ACGri0c1FS2MaleqXS-hygM8W-n3CUYyQcZ3VKt_8bQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id F18D0B6008F; Mon, 19 Feb 2024 01:21:31 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-144-ge5821d614e-fm-20240125.002-ge5821d61
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <431dd956-ad31-4da8-ad42-34f7380824bb@app.fastmail.com>
In-Reply-To: 
 <fe51512baa18e1480ce997fc535813ce6a0b0721.1708286962.git.jcalvinowens@gmail.com>
References: 
 <fe51512baa18e1480ce997fc535813ce6a0b0721.1708286962.git.jcalvinowens@gmail.com>
Date: Mon, 19 Feb 2024 07:21:11 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Calvin Owens" <jcalvinowens@gmail.com>,
 "Russell King" <linux@armlinux.org.uk>
Cc: "Dave Martin" <Dave.Martin@arm.com>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org,
 "linux-bcachefs@vger.kernel.org" <linux-bcachefs@vger.kernel.org>,
 "Kent Overstreet" <kent.overstreet@linux.dev>
Subject: Re: [PATCH] arm: Silence gcc warnings about arch ABI drift
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 19, 2024, at 05:09, Calvin Owens wrote:
> 32-bit arm builds uniquely emit a lot of spam like this:
>
>     fs/bcachefs/backpointers.c: In function =E2=80=98extent_matches_bp=
=E2=80=99:
>     fs/bcachefs/backpointers.c:15:13: note: parameter passing for=20
> argument of type =E2=80=98struct bch_backpointer=E2=80=99 changed in G=
CC 9.1
>
> Apply the arm64 change from commit ebcc5928c5d9 ("arm64: Silence gcc
> warnings about arch ABI drift") to silence them. It seems like Dave's
> original rationale applies here too.
>
> Cc: Dave Martin <Dave.Martin@arm.com>
> Signed-off-by: Calvin Owens <jcalvinowens@gmail.com>
> ---

I think these should be addressed in bcachefs instead.
While it's not the fault of bcachefs that the calling
convention changed between gcc versions, have a look at
the actual structure layout:

struct bch_val {
        __u64           __nothing[0];
};
struct bpos {
        /*
         * Word order matches machine byte order - btree code treats a b=
pos as a
         * single large integer, for search/comparison purposes
         *
         * Note that wherever a bpos is embedded in another on disk data
         * structure, it has to be byte swabbed when reading in metadata=
 that
         * wasn't written in native endian order:
         */
#if __BYTE_ORDER__ =3D=3D __ORDER_LITTLE_ENDIAN__
        __u32           snapshot;
        __u64           offset;
        __u64           inode;
#elif __BYTE_ORDER__ =3D=3D __ORDER_BIG_ENDIAN__
        __u64           inode;
        __u64           offset;         /* Points to end of extent - sec=
tors */
        __u32           snapshot;
#else
#error edit for your odd byteorder.
#endif
} __packed
struct bch_backpointer {
        struct bch_val          v;
        __u8                    btree_id;
        __u8                    level;
        __u8                    data_type;
        __u64                   bucket_offset:40;
        __u32                   bucket_len;
        struct bpos             pos;
} __packed __aligned(8);

This is not something that should ever be passed by value
into a function.

      Arnd

