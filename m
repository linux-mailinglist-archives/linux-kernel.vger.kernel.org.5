Return-Path: <linux-kernel+bounces-123292-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A09B189062B
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 17:48:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 149F1B22A71
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 16:48:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90FA8135A4D;
	Thu, 28 Mar 2024 16:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="gg0BjxU8";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="P252tgkR"
Received: from fhigh6-smtp.messagingengine.com (fhigh6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0FC538388;
	Thu, 28 Mar 2024 16:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711643999; cv=none; b=YeSpjW72iBDeEA4hjLBh1YdVFcAXu+CxZlvhH64v0e/dQvKaxmOXOpB2SYjuTqzT2mxp5c2b/A2vWl8AQ5Y+fs1PnQ8H5LZkiqzZ612MyWkqJ/g8nKU3CacHvSVtdyS6gg8NPCZCBDajK1O+MAlrhlf4pZLH3wiUOpGf81pkKbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711643999; c=relaxed/simple;
	bh=wb/qSsrG9p00H2YgbJ23G128MXHEa52O+6iF8sj5TtY=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=q3uZ5aI0oJ9iKIfdZtPn7UWcyHVkubWh4vEu8mNYyqPSURkIJ57Uxsmc0ogcIYqkrewMP84G65TSq9MNzW0PxBm1l6SHL9zXJArdI/Ih0zFvdU863RS+bOjkdGcSd/06Mz0AV4ahH0dnlVDvmwOP790N2pjshueyWUZ15igNmYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=gg0BjxU8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=P252tgkR; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 19D5E1140163;
	Thu, 28 Mar 2024 12:39:57 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Thu, 28 Mar 2024 12:39:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1711643997;
	 x=1711730397; bh=aUszvSWxiA8AwwpnjADcGdmlaqvcxRRc2keJGjADuiU=; b=
	gg0BjxU8PF7wrDeOt6Y5eATYhX9zfvEDFJryGM3FP7AW4kzWeWUpBA3JHkR31B1S
	o+rfhUCKwSa3OF46LOGI9ZEv9LpOAuctp4lhvmve/dYt0byJqTMau9JGOrvEpJNn
	BhqYzMiX28wGv8kRplwNab3ZmxW077ysB+UgrO2/TeNtvmjNl9Aaqcm+Pjw9hMmJ
	ewTxMwnmaF93R8ybTZYBPIF/CS224Q6fgMHYHQItyc7lqGz4S2BioMqm8kxfZcRX
	aOy65p2eXBBPXlKRh+YonNkl9ZBrCiWiewZq+gwfahCbHmZBo7S0deYHYRqll2O3
	v6htgafYrusq6SSbapwc5A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1711643997; x=
	1711730397; bh=aUszvSWxiA8AwwpnjADcGdmlaqvcxRRc2keJGjADuiU=; b=P
	252tgkRJqRLht28QLlqUwvcrHXIU5eVMmvtXPt4OY0VLSMjif5s5Uy7LblkJscpB
	pnzdzLn9jYb0iIoJjtFi3+G72Bw5s9PiVxpPv/sPvbfZO2ba939EwqIysGjLigsr
	tBBN4TFt/1FrScYofwBU+nnUtCg7bPRT9BV5+hge1VyCtPrf2+0Iv9QXLqleYy8O
	LNJ8ygqSqdk5fZTWfFKJWyCtwhAM6rP97yfZsQk434BK8CoysODn9F+QOLc5yDiD
	Ifhz6MnXfNMokqfn1dIP4eCF1xoJH+S/r0WdznRkKVz9uRPHsc4YRSfVIGo/QjH7
	zzx+Df5kndBtLaDByuISQ==
X-ME-Sender: <xms:XJ0FZh_qGSFOV6xuzvQjQYgjiuNbHX_scIdkv4_aKCt1GnNS8gxcwg>
    <xme:XJ0FZlul6l4MgvQnW8S8TxKPExyXlIufw6n7BtXUTksesfcRAD_THHm78MEePYIin
    BsPQ0ibIA35qSjL6bs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudduledgledtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeelfefgueeviefgudduueefueffkeelleeijeelkefgudfgueelledtuddu
    ieegvdenucffohhmrghinhepghhouggsohhlthdrohhrghenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:XJ0FZvCBvIuhQGbw6wfmrNS_mOA1m9wAwTnp16NiHEkRhrR-S7YuqQ>
    <xmx:XJ0FZldfJAr9PnAVtMDXWsMRg3Ohlu2mqn6cBs6YxP8vboVblKtUtg>
    <xmx:XJ0FZmOGnJHZWmYnJHn87hCccqcF8HAmrpPl0u6Mp1LeSsmgOBkAOQ>
    <xmx:XJ0FZnnGjN49gJA-VQJ5K6DAWlhfQTcJ_IUrdWtisP4JaboD3Y5rcA>
    <xmx:XZ0FZrxA9XI3f_xAV6-xNT6gLwiSkQ4SSB7b_dlue5OM1q4-ITlQFA>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 9F1EAB6008D; Thu, 28 Mar 2024 12:39:56 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-333-gbfea15422e-fm-20240327.001-gbfea1542
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <62cf1c3c-29b7-48cc-9d52-cd47a6c07aa4@app.fastmail.com>
In-Reply-To: 
 <CANn89i+3FuKc1RsYaciNe3uQMZuJBjSmvC_ueuQ=NaFVzEnyuA@mail.gmail.com>
References: <20240328143051.1069575-1-arnd@kernel.org>
 <20240328143051.1069575-6-arnd@kernel.org>
 <CANn89i+3FuKc1RsYaciNe3uQMZuJBjSmvC_ueuQ=NaFVzEnyuA@mail.gmail.com>
Date: Thu, 28 Mar 2024 17:39:36 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Eric Dumazet" <edumazet@google.com>, "Arnd Bergmann" <arnd@kernel.org>
Cc: linux-kernel@vger.kernel.org, "David S . Miller" <davem@davemloft.net>,
 "David Ahern" <dsahern@kernel.org>, "Jakub Kicinski" <kuba@kernel.org>,
 "Paolo Abeni" <pabeni@redhat.com>, "Nathan Chancellor" <nathan@kernel.org>,
 "Nick Desaulniers" <ndesaulniers@google.com>,
 "Bill Wendling" <morbo@google.com>, "Justin Stitt" <justinstitt@google.com>,
 "Dmitry Safonov" <0x7f454c46@gmail.com>,
 "Neal Cardwell" <ncardwell@google.com>,
 "mfreemon@cloudflare.com" <mfreemon@cloudflare.com>,
 "Yan Zhai" <yan@cloudflare.com>, Netdev <netdev@vger.kernel.org>,
 llvm@lists.linux.dev
Subject: Re: [PATCH 5/9] ipv4: tcp_output: avoid warning about NET_ADD_STATS
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 28, 2024, at 15:38, Eric Dumazet wrote:
> On Thu, Mar 28, 2024 at 3:31=E2=80=AFPM Arnd Bergmann <arnd@kernel.org=
> wrote:
^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> arch/x86/include/asm/percpu.h:127:31: note: expanded from macro 'perc=
pu_add_op'
>>                               ((val) =3D=3D 1 || (val) =3D=3D -1)) ? =
           \
>>                                              ~~~~~ ^  ~~
>>
>
> This seems like a bug in the macro or the compiler, because val is not
> a constant ?
>
> __builtin_constant_p(val) should return false ???
>
> +#define percpu_add_op(size, qual, var, val)                          =
  \
> +do {                                                                 =
  \
> +       const int pao_ID__ =3D (__builtin_constant_p(val) &&          =
    \
> +                             ((val) =3D=3D 1 || (val) =3D=3D -1)) ?  =
          \
> +                               (int)(val) : 0;                       =
  \

It looks like gcc does the same thing, with the broader and
still disabled -Wtype-limits, see: https://godbolt.org/z/3EPTGx68n

As far as I can tell, it does not matter that the comparison
against -1 is never actually evaluated, since the warning
is already printed before it simplifies the condition.

This is the only such warning I got from percpu, but
I guess we could also add the cast inside of the macro,
such as

diff --git a/arch/x86/include/asm/percpu.h b/arch/x86/include/asm/percpu=
h
index 44958ebaf626..5923d786e67a 100644
--- a/arch/x86/include/asm/percpu.h
+++ b/arch/x86/include/asm/percpu.h
@@ -181,12 +181,14 @@ do {                                              =
                        \
  */
 #define percpu_add_op(size, qual, var, val)                            \
 do {                                                                   \
-       const int pao_ID__ =3D (__builtin_constant_p(val) &&            =
  \
-                             ((val) =3D=3D 1 || (val) =3D=3D -1)) ?    =
        \
-                               (int)(val) : 0;                         \
+       __auto_type __val =3D (val);                                    =
  \
+       const int pao_ID__ =3D (__builtin_constant_p(__val) &&          =
  \
+                             ((__val) =3D=3D (typeof(__val))1 ||       =
    \
+                              (__val) =3D=3D (typeof(__val))-1)) ?     =
    \
+                               (int)(__val) : 0;                       \
        if (0) {                                                        \
                typeof(var) pao_tmp__;                                  \
-               pao_tmp__ =3D (val);                                    =
  \
+               pao_tmp__ =3D (__val);                                  =
  \
                (void)pao_tmp__;                                        \
        }                                                               \
        if (pao_ID__ =3D=3D 1)                                          =
    \
@@ -194,7 +196,7 @@ do {                                                =
                        \
        else if (pao_ID__ =3D=3D -1)                                    =
    \
                percpu_unary_op(size, qual, "dec", var);                \
        else                                                            \
-               percpu_to_op(size, qual, "add", var, val);              \
+               percpu_to_op(size, qual, "add", var, __val);            \
 } while (0)
=20
 #define percpu_from_op(size, qual, op, _var)                           \

I added a temporary variable there to avoid expanding
the argument too many times.

       Arnd

