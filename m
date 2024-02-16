Return-Path: <linux-kernel+bounces-68654-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7891B857DE1
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 14:42:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D2378B25F86
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 13:42:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4216712B14A;
	Fri, 16 Feb 2024 13:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b="BR8c2RwO"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F41E712AAFC;
	Fri, 16 Feb 2024 13:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708090933; cv=none; b=Q364CgiFBUDsxKv23tppkHv0UIdxrTDeHzCWxsss5Rx5203Tb8qBPJroVXtPYRUCmnwrwF7FsBcytQgzxnp+HBrryWTEBuABqHl9QQetKk5/HYdl3ZwODyqM3eAaYf45iVdpXBMoDYiEu1RJewH7PG8O7EwqpnesStyj8ZpfqdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708090933; c=relaxed/simple;
	bh=tD1zYe1+sODPTBKxIfW5qY04ux5Tzf4QlUkpNnSpXug=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dCeNs/VShDRZ5Td7gDImMnYeNHFrDBSXO8b1yi4UYaalz83BD+Fqekv/Fn8KFldaQzbvMP6v+4U+w3UnHpnfYDMAEAteZ+XohHflAsU4UStyIuEoq9HHVK7BVx9Hsk5yuKA9LFMMsUI7B3RthGPsETDA9nNEBK1UnwfYqpEb3ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b=BR8c2RwO; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1708090913; x=1708695713; i=deller@gmx.de;
	bh=tD1zYe1+sODPTBKxIfW5qY04ux5Tzf4QlUkpNnSpXug=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=BR8c2RwOHSkUEuFILrqzjUcnajARTCnZxwRmrnlMDnTX9LsR84UxYSjlV7Qnfn+I
	 hX1s977DjWLD/2Vb9x4NmEqkRTBO6Oj/n8pkFR3lIhAe0ggX4tQ7y/+HtBgTDxqB8
	 gehkLIKle5/3jpMNavWd47BWXvVNc8cs60sJdhXX6+2AakVbUIKtPDSffPEAG0WW+
	 IapLTGHEeFai5pCa7l0lT2uWSCDpmtp7Dymn1YdRbyQX4ne13z1ydArgRhJ6lthZr
	 CN/p1Dg5RYMGR0tfNa3IrjQLajzt3TAT8CEMtKx1hgZPCQBxca8FF7ALozjj7wXdi
	 yRSHV0WFFL5WJ65UDA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.55] ([94.134.148.214]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MNKhm-1rKyrb2GLK-00Ol5r; Fri, 16
 Feb 2024 14:41:53 +0100
Message-ID: <0031c257-f2d7-414e-aeda-0680f9a3ba24@gmx.de>
Date: Fri, 16 Feb 2024 14:55:52 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] parisc: avoid c23 'nullptr' idenitifier
Content-Language: en-US
To: Arnd Bergmann <arnd@kernel.org>,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-parisc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240212112129.1076631-1-arnd@kernel.org>
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20240212112129.1076631-1-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:TOdxK94KnGnL2z/ms509e9QXBO+WqpFzLqk/NP8b3jV9TrZx8Iw
 SDb6w7T5owi8oaD/HDBcc/vgqG0MDLe3zFH9oncOC+w+yDyO1EtIfSwBafmRNZVOoyko0DD
 1xUhwlqanss3E4n7dSVzl2SsFiwaHDmq9R+kEzNMJZxUz+9KAsM40Xm5uxrFN9L5nv7/jOM
 GUPYcPk/7H6CemaKrafAg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:0HVKXjsJnJQ=;0DsnHmg3Q5EjtETXlXu1MOAe1Qu
 hXu6+yWhA1P3kEQT5Cu0XNIaZSlfsFOKCoNRjRbeKw6P5rPOe7zBCmrlbcwfc6SlahHhk+I8h
 uiSmU8eTXpd4S878VttxO1552jyxksV10bU0uFUHZqaSuq+Pk6JYkEA1G100VG2En52G+s9HO
 T+RPX9KfPNtKPhpSA/2ykWB+qzDlSNmUQuW1hmFcLqC+4NUTlEHAJNqQcmKzO8b4jFQ0sz/ix
 WYDgXS/zd9w97X6Uhr8wSzRoNdOxm7ZXsFqbsQYVwurGWq6WIpNF+ZwyiSHs7+AWjyRq6hi6b
 129r4EOkEAa1TdpQj40/jydcZaZl5Vg4S5T+heCLJdeGEuq3jFWbNbBF9gApB9uiHd6KnCE4h
 Tbjanu/ElGGIFlWdRDdUROCp629TTguXH/T0rEmxTgHZznmW24VtnNnd9m8Ubxu00Pjd2kzZ1
 9m7Vf2hjq5u6BPMZXhofaQWPeNoGvBQkl/0kvoZYRDIpXMW59QcE3cAhV7IfCl0WWGLkpMOSG
 ojFgSNxiLRuyOdG9Q3+sq5b770kejzS+D3fdmBNn0/TJtUE5xMBm94kkyEIky2U4djWQH7mWO
 y6e45uakUUZDC5AFSJ8ma+qeLtQ7S/zluU/KKsaGAAIC7hcNs7K92LdEzkia20bBphebq0KQp
 CXIB7L03aUxioMMll/1lYPC5yAUhTzkPI9LI7IXAt+eVcMpkRoE267MXFYCaBP0YXjco0y328
 rsbPO+Zu1BMzi+YSa/771Awzb0jo5HyFhzlZ0G7rPdhlUvb5En/g5DrT29qVPZ5NOC6z4b+yy
 jrxnB1xEJgtS/KrBGw+LzBFovNIbCVzuY2V+E9cd324yg=

On 2/12/24 12:20, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>
> Starting in c23, this is a reserved keyword, so in the future, using it
> will start causing build failures:
>
> arch/parisc/math-emu/frnd.c:36:23: error: expected ';', ',' or ')' befor=
e 'nullptr'
>
> Since I can't think of a good replacement name, add a leading underscore
> to the function argument to avoid this namespace conflict. Apparently
> all of these arguments are unused.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> Feel free to come up with a better name here and apply a different
> patch, treating this as a bug report.

Thanks for the patch!
I actually don't have a better idea for the name either, so I applied
the patch as-is to the parisc tree :-)

Thanks!
Helge


> ---
>   arch/parisc/math-emu/dfsqrt.c  |  4 ++--
>   arch/parisc/math-emu/fcnvff.c  |  8 ++++----
>   arch/parisc/math-emu/fcnvfu.c  | 16 ++++++++--------
>   arch/parisc/math-emu/fcnvfut.c | 16 ++++++++--------
>   arch/parisc/math-emu/fcnvfx.c  | 16 ++++++++--------
>   arch/parisc/math-emu/fcnvfxt.c | 16 ++++++++--------
>   arch/parisc/math-emu/fcnvuf.c  | 16 ++++++++--------
>   arch/parisc/math-emu/fcnvxf.c  | 16 ++++++++--------
>   arch/parisc/math-emu/frnd.c    |  8 ++++----
>   arch/parisc/math-emu/sfsqrt.c  |  4 ++--
>   10 files changed, 60 insertions(+), 60 deletions(-)
>
> diff --git a/arch/parisc/math-emu/dfsqrt.c b/arch/parisc/math-emu/dfsqrt=
c
> index 63d339c81c14..e3a3a19b966b 100644
> --- a/arch/parisc/math-emu/dfsqrt.c
> +++ b/arch/parisc/math-emu/dfsqrt.c
> @@ -15,7 +15,7 @@
>    *	Double Floating-point Square Root
>    *
>    *  External Interfaces:
> - *	dbl_fsqrt(srcptr,nullptr,dstptr,status)
> + *	dbl_fsqrt(srcptr,_nullptr,dstptr,status)
>    *
>    *  Internal Interfaces:
>    *
> @@ -37,7 +37,7 @@
>   unsigned int
>   dbl_fsqrt(
>   	    dbl_floating_point *srcptr,
> -	    unsigned int *nullptr,
> +	    unsigned int *_nullptr,
>   	    dbl_floating_point *dstptr,
>   	    unsigned int *status)
>   {
> diff --git a/arch/parisc/math-emu/fcnvff.c b/arch/parisc/math-emu/fcnvff=
c
> index 0530e6127797..61e489704c86 100644
> --- a/arch/parisc/math-emu/fcnvff.c
> +++ b/arch/parisc/math-emu/fcnvff.c
> @@ -16,8 +16,8 @@
>    *	Double Floating-point to Single Floating-point
>    *
>    *  External Interfaces:
> - *	dbl_to_sgl_fcnvff(srcptr,nullptr,dstptr,status)
> - *	sgl_to_dbl_fcnvff(srcptr,nullptr,dstptr,status)
> + *	dbl_to_sgl_fcnvff(srcptr,_nullptr,dstptr,status)
> + *	sgl_to_dbl_fcnvff(srcptr,_nullptr,dstptr,status)
>    *
>    *  Internal Interfaces:
>    *
> @@ -40,7 +40,7 @@
>   int
>   sgl_to_dbl_fcnvff(
>   	    sgl_floating_point *srcptr,
> -	    unsigned int *nullptr,
> +	    unsigned int *_nullptr,
>   	    dbl_floating_point *dstptr,
>   	    unsigned int *status)
>   {
> @@ -127,7 +127,7 @@ sgl_to_dbl_fcnvff(
>   int
>   dbl_to_sgl_fcnvff(
>   		    dbl_floating_point *srcptr,
> -		    unsigned int *nullptr,
> +		    unsigned int *_nullptr,
>   		    sgl_floating_point *dstptr,
>   		    unsigned int *status)
>   {
> diff --git a/arch/parisc/math-emu/fcnvfu.c b/arch/parisc/math-emu/fcnvfu=
c
> index c971618a6f3c..c31790ceecca 100644
> --- a/arch/parisc/math-emu/fcnvfu.c
> +++ b/arch/parisc/math-emu/fcnvfu.c
> @@ -15,10 +15,10 @@
>    *	Floating-point to Unsigned Fixed-point Converts
>    *
>    *  External Interfaces:
> - *	dbl_to_dbl_fcnvfu(srcptr,nullptr,dstptr,status)
> - *	dbl_to_sgl_fcnvfu(srcptr,nullptr,dstptr,status)
> - *	sgl_to_dbl_fcnvfu(srcptr,nullptr,dstptr,status)
> - *	sgl_to_sgl_fcnvfu(srcptr,nullptr,dstptr,status)
> + *	dbl_to_dbl_fcnvfu(srcptr,_nullptr,dstptr,status)
> + *	dbl_to_sgl_fcnvfu(srcptr,_nullptr,dstptr,status)
> + *	sgl_to_dbl_fcnvfu(srcptr,_nullptr,dstptr,status)
> + *	sgl_to_sgl_fcnvfu(srcptr,_nullptr,dstptr,status)
>    *
>    *  Internal Interfaces:
>    *
> @@ -45,7 +45,7 @@
>   int
>   sgl_to_sgl_fcnvfu(
>   			sgl_floating_point *srcptr,
> -			unsigned int *nullptr,
> +			unsigned int *_nullptr,
>   			unsigned int *dstptr,
>   			unsigned int *status)
>   {
> @@ -166,7 +166,7 @@ sgl_to_sgl_fcnvfu(
>   int
>   sgl_to_dbl_fcnvfu(
>   		    sgl_floating_point *srcptr,
> -		    unsigned int *nullptr,
> +		    unsigned int *_nullptr,
>   		    dbl_unsigned *dstptr,
>   		    unsigned int *status)
>   {
> @@ -285,7 +285,7 @@ sgl_to_dbl_fcnvfu(
>    */
>   /*ARGSUSED*/
>   int
> -dbl_to_sgl_fcnvfu (dbl_floating_point * srcptr, unsigned int *nullptr,
> +dbl_to_sgl_fcnvfu (dbl_floating_point * srcptr, unsigned int *_nullptr,
>   		   unsigned int *dstptr, unsigned int *status)
>   {
>   	register unsigned int srcp1, srcp2, result;
> @@ -408,7 +408,7 @@ dbl_to_sgl_fcnvfu (dbl_floating_point * srcptr, unsi=
gned int *nullptr,
>    */
>   /*ARGSUSED*/
>   int
> -dbl_to_dbl_fcnvfu (dbl_floating_point * srcptr, unsigned int *nullptr,
> +dbl_to_dbl_fcnvfu (dbl_floating_point * srcptr, unsigned int *_nullptr,
>   		   dbl_unsigned * dstptr, unsigned int *status)
>   {
>   	register int src_exponent;
> diff --git a/arch/parisc/math-emu/fcnvfut.c b/arch/parisc/math-emu/fcnvf=
ut.c
> index 5b657f852578..2cf1daf3b7ad 100644
> --- a/arch/parisc/math-emu/fcnvfut.c
> +++ b/arch/parisc/math-emu/fcnvfut.c
> @@ -15,10 +15,10 @@
>    *	Floating-point to Unsigned Fixed-point Converts with Truncation
>    *
>    *  External Interfaces:
> - *	dbl_to_dbl_fcnvfut(srcptr,nullptr,dstptr,status)
> - *	dbl_to_sgl_fcnvfut(srcptr,nullptr,dstptr,status)
> - *	sgl_to_dbl_fcnvfut(srcptr,nullptr,dstptr,status)
> - *	sgl_to_sgl_fcnvfut(srcptr,nullptr,dstptr,status)
> + *	dbl_to_dbl_fcnvfut(srcptr,_nullptr,dstptr,status)
> + *	dbl_to_sgl_fcnvfut(srcptr,_nullptr,dstptr,status)
> + *	sgl_to_dbl_fcnvfut(srcptr,_nullptr,dstptr,status)
> + *	sgl_to_sgl_fcnvfut(srcptr,_nullptr,dstptr,status)
>    *
>    *  Internal Interfaces:
>    *
> @@ -44,7 +44,7 @@
>    */
>   /*ARGSUSED*/
>   int
> -sgl_to_sgl_fcnvfut (sgl_floating_point * srcptr, unsigned int *nullptr,
> +sgl_to_sgl_fcnvfut (sgl_floating_point * srcptr, unsigned int *_nullptr=
,
>   		    unsigned int *dstptr, unsigned int *status)
>   {
>   	register unsigned int src, result;
> @@ -113,7 +113,7 @@ sgl_to_sgl_fcnvfut (sgl_floating_point * srcptr, uns=
igned int *nullptr,
>    */
>   /*ARGSUSED*/
>   int
> -sgl_to_dbl_fcnvfut (sgl_floating_point * srcptr, unsigned int *nullptr,
> +sgl_to_dbl_fcnvfut (sgl_floating_point * srcptr, unsigned int *_nullptr=
,
>   		    dbl_unsigned * dstptr, unsigned int *status)
>   {
>   	register int src_exponent;
> @@ -183,7 +183,7 @@ sgl_to_dbl_fcnvfut (sgl_floating_point * srcptr, uns=
igned int *nullptr,
>    */
>   /*ARGSUSED*/
>   int
> -dbl_to_sgl_fcnvfut (dbl_floating_point * srcptr, unsigned int *nullptr,
> +dbl_to_sgl_fcnvfut (dbl_floating_point * srcptr, unsigned int *_nullptr=
,
>   		    unsigned int *dstptr, unsigned int *status)
>   {
>   	register unsigned int srcp1, srcp2, result;
> @@ -252,7 +252,7 @@ dbl_to_sgl_fcnvfut (dbl_floating_point * srcptr, uns=
igned int *nullptr,
>    */
>   /*ARGSUSED*/
>   int
> -dbl_to_dbl_fcnvfut (dbl_floating_point * srcptr, unsigned int *nullptr,
> +dbl_to_dbl_fcnvfut (dbl_floating_point * srcptr, unsigned int *_nullptr=
,
>   		    dbl_unsigned * dstptr, unsigned int *status)
>   {
>   	register int src_exponent;
> diff --git a/arch/parisc/math-emu/fcnvfx.c b/arch/parisc/math-emu/fcnvfx=
c
> index 5e153078d803..99bd61479452 100644
> --- a/arch/parisc/math-emu/fcnvfx.c
> +++ b/arch/parisc/math-emu/fcnvfx.c
> @@ -18,10 +18,10 @@
>    *	Double Floating-point to Double Fixed-point
>    *
>    *  External Interfaces:
> - *	dbl_to_dbl_fcnvfx(srcptr,nullptr,dstptr,status)
> - *	dbl_to_sgl_fcnvfx(srcptr,nullptr,dstptr,status)
> - *	sgl_to_dbl_fcnvfx(srcptr,nullptr,dstptr,status)
> - *	sgl_to_sgl_fcnvfx(srcptr,nullptr,dstptr,status)
> + *	dbl_to_dbl_fcnvfx(srcptr,_nullptr,dstptr,status)
> + *	dbl_to_sgl_fcnvfx(srcptr,_nullptr,dstptr,status)
> + *	sgl_to_dbl_fcnvfx(srcptr,_nullptr,dstptr,status)
> + *	sgl_to_sgl_fcnvfx(srcptr,_nullptr,dstptr,status)
>    *
>    *  Internal Interfaces:
>    *
> @@ -44,7 +44,7 @@
>   int
>   sgl_to_sgl_fcnvfx(
>   		    sgl_floating_point *srcptr,
> -		    sgl_floating_point *nullptr,
> +		    sgl_floating_point *_nullptr,
>   		    int *dstptr,
>   		    sgl_floating_point *status)
>   {
> @@ -141,7 +141,7 @@ sgl_to_sgl_fcnvfx(
>   int
>   sgl_to_dbl_fcnvfx(
>   		sgl_floating_point *srcptr,
> -		unsigned int *nullptr,
> +		unsigned int *_nullptr,
>   		dbl_integer *dstptr,
>   		unsigned int *status)
>   {
> @@ -262,7 +262,7 @@ sgl_to_dbl_fcnvfx(
>   int
>   dbl_to_sgl_fcnvfx(
>   		    dbl_floating_point *srcptr,
> -		    unsigned int *nullptr,
> +		    unsigned int *_nullptr,
>   		    int *dstptr,
>   		    unsigned int *status)
>   {
> @@ -373,7 +373,7 @@ dbl_to_sgl_fcnvfx(
>   int
>   dbl_to_dbl_fcnvfx(
>   		    dbl_floating_point *srcptr,
> -		    unsigned int *nullptr,
> +		    unsigned int *_nullptr,
>   		    dbl_integer *dstptr,
>   		    unsigned int *status)
>   {
> diff --git a/arch/parisc/math-emu/fcnvfxt.c b/arch/parisc/math-emu/fcnvf=
xt.c
> index ebec31e40d01..3b7cc62257d0 100644
> --- a/arch/parisc/math-emu/fcnvfxt.c
> +++ b/arch/parisc/math-emu/fcnvfxt.c
> @@ -18,10 +18,10 @@
>    *	Double Floating-point to Double Fixed-point /w truncated result
>    *
>    *  External Interfaces:
> - *	dbl_to_dbl_fcnvfxt(srcptr,nullptr,dstptr,status)
> - *	dbl_to_sgl_fcnvfxt(srcptr,nullptr,dstptr,status)
> - *	sgl_to_dbl_fcnvfxt(srcptr,nullptr,dstptr,status)
> - *	sgl_to_sgl_fcnvfxt(srcptr,nullptr,dstptr,status)
> + *	dbl_to_dbl_fcnvfxt(srcptr,_nullptr,dstptr,status)
> + *	dbl_to_sgl_fcnvfxt(srcptr,_nullptr,dstptr,status)
> + *	sgl_to_dbl_fcnvfxt(srcptr,_nullptr,dstptr,status)
> + *	sgl_to_sgl_fcnvfxt(srcptr,_nullptr,dstptr,status)
>    *
>    *  Internal Interfaces:
>    *
> @@ -45,7 +45,7 @@
>   int
>   sgl_to_sgl_fcnvfxt(
>   		    sgl_floating_point *srcptr,
> -		    unsigned int *nullptr,
> +		    unsigned int *_nullptr,
>   		    int *dstptr,
>   		    unsigned int *status)
>   {
> @@ -109,7 +109,7 @@ sgl_to_sgl_fcnvfxt(
>   int
>   sgl_to_dbl_fcnvfxt(
>   		    sgl_floating_point *srcptr,
> -		    unsigned int *nullptr,
> +		    unsigned int *_nullptr,
>   		    dbl_integer *dstptr,
>   		    unsigned int *status)
>   {
> @@ -183,7 +183,7 @@ sgl_to_dbl_fcnvfxt(
>   int
>   dbl_to_sgl_fcnvfxt(
>   			dbl_floating_point *srcptr,
> -			unsigned int *nullptr,
> +			unsigned int *_nullptr,
>   			int *dstptr,
>   			unsigned int *status)
>   {
> @@ -248,7 +248,7 @@ dbl_to_sgl_fcnvfxt(
>   int
>   dbl_to_dbl_fcnvfxt(
>   			dbl_floating_point *srcptr,
> -			unsigned int *nullptr,
> +			unsigned int *_nullptr,
>   			dbl_integer *dstptr,
>   			unsigned int *status)
>   {
> diff --git a/arch/parisc/math-emu/fcnvuf.c b/arch/parisc/math-emu/fcnvuf=
c
> index c54978a0ace1..c166feb57045 100644
> --- a/arch/parisc/math-emu/fcnvuf.c
> +++ b/arch/parisc/math-emu/fcnvuf.c
> @@ -15,10 +15,10 @@
>    *	Fixed point to Floating-point Converts
>    *
>    *  External Interfaces:
> - *	dbl_to_dbl_fcnvuf(srcptr,nullptr,dstptr,status)
> - *	dbl_to_sgl_fcnvuf(srcptr,nullptr,dstptr,status)
> - *	sgl_to_dbl_fcnvuf(srcptr,nullptr,dstptr,status)
> - *	sgl_to_sgl_fcnvuf(srcptr,nullptr,dstptr,status)
> + *	dbl_to_dbl_fcnvuf(srcptr,_nullptr,dstptr,status)
> + *	dbl_to_sgl_fcnvuf(srcptr,_nullptr,dstptr,status)
> + *	sgl_to_dbl_fcnvuf(srcptr,_nullptr,dstptr,status)
> + *	sgl_to_sgl_fcnvuf(srcptr,_nullptr,dstptr,status)
>    *
>    *  Internal Interfaces:
>    *
> @@ -45,7 +45,7 @@
>   int
>   sgl_to_sgl_fcnvuf(
>   			unsigned int *srcptr,
> -			unsigned int *nullptr,
> +			unsigned int *_nullptr,
>   			sgl_floating_point *dstptr,
>   			unsigned int *status)
>   {
> @@ -104,7 +104,7 @@ sgl_to_sgl_fcnvuf(
>   int
>   sgl_to_dbl_fcnvuf(
>   			unsigned int *srcptr,
> -			unsigned int *nullptr,
> +			unsigned int *_nullptr,
>   			dbl_floating_point *dstptr,
>   			unsigned int *status)
>   {
> @@ -145,7 +145,7 @@ sgl_to_dbl_fcnvuf(
>   int
>   dbl_to_sgl_fcnvuf(
>   			dbl_unsigned *srcptr,
> -			unsigned int *nullptr,
> +			unsigned int *_nullptr,
>   			sgl_floating_point *dstptr,
>   			unsigned int *status)
>   {
> @@ -227,7 +227,7 @@ dbl_to_sgl_fcnvuf(
>   int
>   dbl_to_dbl_fcnvuf(
>   		    dbl_unsigned *srcptr,
> -		    unsigned int *nullptr,
> +		    unsigned int *_nullptr,
>   		    dbl_floating_point *dstptr,
>   		    unsigned int *status)
>   {
> diff --git a/arch/parisc/math-emu/fcnvxf.c b/arch/parisc/math-emu/fcnvxf=
c
> index 69401797146b..11bc1e8a13aa 100644
> --- a/arch/parisc/math-emu/fcnvxf.c
> +++ b/arch/parisc/math-emu/fcnvxf.c
> @@ -18,10 +18,10 @@
>    *	Double Fixed-point to Double Floating-point
>    *
>    *  External Interfaces:
> - *	dbl_to_dbl_fcnvxf(srcptr,nullptr,dstptr,status)
> - *	dbl_to_sgl_fcnvxf(srcptr,nullptr,dstptr,status)
> - *	sgl_to_dbl_fcnvxf(srcptr,nullptr,dstptr,status)
> - *	sgl_to_sgl_fcnvxf(srcptr,nullptr,dstptr,status)
> + *	dbl_to_dbl_fcnvxf(srcptr,_nullptr,dstptr,status)
> + *	dbl_to_sgl_fcnvxf(srcptr,_nullptr,dstptr,status)
> + *	sgl_to_dbl_fcnvxf(srcptr,_nullptr,dstptr,status)
> + *	sgl_to_sgl_fcnvxf(srcptr,_nullptr,dstptr,status)
>    *
>    *  Internal Interfaces:
>    *
> @@ -44,7 +44,7 @@
>   int
>   sgl_to_sgl_fcnvxf(
>   		    int *srcptr,
> -		    unsigned int *nullptr,
> +		    unsigned int *_nullptr,
>   		    sgl_floating_point *dstptr,
>   		    unsigned int *status)
>   {
> @@ -115,7 +115,7 @@ sgl_to_sgl_fcnvxf(
>   int
>   sgl_to_dbl_fcnvxf(
>   		    int *srcptr,
> -		    unsigned int *nullptr,
> +		    unsigned int *_nullptr,
>   		    dbl_floating_point *dstptr,
>   		    unsigned int *status)
>   {
> @@ -166,7 +166,7 @@ sgl_to_dbl_fcnvxf(
>   int
>   dbl_to_sgl_fcnvxf(
>   			dbl_integer *srcptr,
> -			unsigned int *nullptr,
> +			unsigned int *_nullptr,
>   			sgl_floating_point *dstptr,
>   			unsigned int *status)
>   {
> @@ -271,7 +271,7 @@ dbl_to_sgl_fcnvxf(
>   int
>   dbl_to_dbl_fcnvxf(
>   		    dbl_integer *srcptr,
> -		    unsigned int *nullptr,
> +		    unsigned int *_nullptr,
>   		    dbl_floating_point *dstptr,
>   		    unsigned int *status)
>   {
> diff --git a/arch/parisc/math-emu/frnd.c b/arch/parisc/math-emu/frnd.c
> index 0b0e8493e08a..825d89650c2d 100644
> --- a/arch/parisc/math-emu/frnd.c
> +++ b/arch/parisc/math-emu/frnd.c
> @@ -14,8 +14,8 @@
>    *	Quad Floating-point Round to Integer (returns unimplemented)
>    *
>    *  External Interfaces:
> - *	dbl_frnd(srcptr,nullptr,dstptr,status)
> - *	sgl_frnd(srcptr,nullptr,dstptr,status)
> + *	dbl_frnd(srcptr,_nullptr,dstptr,status)
> + *	sgl_frnd(srcptr,_nullptr,dstptr,status)
>    *
>    * END_DESC
>   */
> @@ -33,7 +33,7 @@
>   /*ARGSUSED*/
>   int
>   sgl_frnd(sgl_floating_point *srcptr,
> -	unsigned int *nullptr,
> +	unsigned int *_nullptr,
>   	sgl_floating_point *dstptr,
>   	unsigned int *status)
>   {
> @@ -138,7 +138,7 @@ sgl_frnd(sgl_floating_point *srcptr,
>   int
>   dbl_frnd(
>   	dbl_floating_point *srcptr,
> -	unsigned int *nullptr,
> +	unsigned int *_nullptr,
>   	dbl_floating_point *dstptr,
>   	unsigned int *status)
>   {
> diff --git a/arch/parisc/math-emu/sfsqrt.c b/arch/parisc/math-emu/sfsqrt=
c
> index bd6a84f468d8..8e9e023e7b2e 100644
> --- a/arch/parisc/math-emu/sfsqrt.c
> +++ b/arch/parisc/math-emu/sfsqrt.c
> @@ -15,7 +15,7 @@
>    *	Single Floating-point Square Root
>    *
>    *  External Interfaces:
> - *	sgl_fsqrt(srcptr,nullptr,dstptr,status)
> + *	sgl_fsqrt(srcptr,_nullptr,dstptr,status)
>    *
>    *  Internal Interfaces:
>    *
> @@ -37,7 +37,7 @@
>   unsigned int
>   sgl_fsqrt(
>       sgl_floating_point *srcptr,
> -    unsigned int *nullptr,
> +    unsigned int *_nullptr,
>       sgl_floating_point *dstptr,
>       unsigned int *status)
>   {


