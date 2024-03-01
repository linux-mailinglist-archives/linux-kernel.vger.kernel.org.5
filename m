Return-Path: <linux-kernel+bounces-88622-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E7A3886E451
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 16:29:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6D6D1B215EE
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 15:29:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DB7F6EF1F;
	Fri,  1 Mar 2024 15:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="y/Ct6uB6"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAB156E5EB
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 15:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709306972; cv=none; b=EQpsNdroYS24XwuFZTUNnDPStxHNhTEm0zVsVtkc6UADNy7KIYZEn/kg8PXpzURQs5bAO7LOitlGluluyt8niMGqmzDqQhVhR5EmmvgldtdZARsDmy3FHzyhmZBXs+jDU7a8pqGTpq9pXrUbx5hgniX+GuWhtMi519Eyja6tdvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709306972; c=relaxed/simple;
	bh=UpbU7hO7PgZpThGtfOUVUaIkjG5Jg/+Nv9/mNDW/57U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vEiaiZCONAzBywO4wBBMHqZg7H9oOKkh2CprW9qUO3ZG2yf/131vxa20sfzj6RnB7GFbecKlVrLPgad7h5oBD+SzJ3zWdy2iXyZLTthBA/5i1ApO1GNFOPOAGSUSfc8/HFSGtYGqVvmUR5TEQus1tidB1prDIeT33immQHhs3Q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=y/Ct6uB6; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5658082d2c4so3368859a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2024 07:29:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1709306969; x=1709911769; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2MZ2yOTO+KIB8siKuGMOdBUlhOc6wSKQHzvOaxRX3JU=;
        b=y/Ct6uB6QO5j8G6f2bPb6YwNXYIzuJNLWxoeYPlpjHNrmJoc8ZuHRhN3bSkCNL795m
         P38GwsgUAQbhhD9JkicHvT37H3ApLU/Ngu9lnJb+N7pp8BNuFygp0+Pm6/cHLcqE/bsZ
         2h7sRgnY3Rxu2Kfb8gmvn2LhfCPr8QDAoL/qPW/lxA5XRecYBJc+o7TIG5T1qH9Q/7Ph
         87XUT2jtjyOUrptYcLxBTv9pTON441DGM0ktxZnfH22BRlWpwycU6JKkz7WHj1UdktLx
         6ISJLRK5K+fhwYarQKLptGwxg3bVXaSCl9zT/XGXXil/n5DtoidfuVgm99yU1Jv8yh2w
         iR/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709306969; x=1709911769;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2MZ2yOTO+KIB8siKuGMOdBUlhOc6wSKQHzvOaxRX3JU=;
        b=dzHQ8nG4NzzwyFykSQ4Pgli/94i7novScZRYORMV/Jn28OgrPKvWRynsJB8HmsNX9n
         ew9rw0GUclkp/H9gPSV0zhsgsBIAbL58tMXCrinHo4djHHPe3D7wJRVwC2LSG1ddo+Tu
         jg2A5sBBYLpRO1zVap50IN/YKSH4HKkK9u7PSL7itu7R92ooSMKs3Onm5NPSHMSIKJw7
         EdKBVVLJ350AnU13EitlGnpSTO/HwR3o3DLE+BHLZ3dVTHjPK/nC8srbMdEk7MTh3vOb
         dgECTZKvlrAdP24hc59qrq8O+6+0eD3bgqhMKbwFTHEKt/uwJtqrhJfd97RiFAHEGHqY
         NK6g==
X-Forwarded-Encrypted: i=1; AJvYcCUuesGY/rOrsLedfoOxQSAifD/nKjQ2abaGU1W0/VmdeS4fw65b62vY54i96c5irZajKbxTqmV1GfJy7F2Q5cXVYVp2e5Yacs2SGFVh
X-Gm-Message-State: AOJu0YzOMMU4Td3XTMfV1NKeSRho4EXyVKCHuA6YtqO0NxVw4AwMcUVQ
	LGoAxDH1ca+RNVyGc6sdtxwwXOTvTlhWhsWLZJmifZS6C87AMgWA8mYQIGt5ElA=
X-Google-Smtp-Source: AGHT+IGXmTvmpDOBogei2NKEGeBxe8GHXKdXl6gK0nD5jHjKOOE0e/RY97L7Ob9/n6gWA62fsQQ0Ug==
X-Received: by 2002:a05:6402:3493:b0:566:f67e:3f72 with SMTP id v19-20020a056402349300b00566f67e3f72mr131359edc.12.1709306969059;
        Fri, 01 Mar 2024 07:29:29 -0800 (PST)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id fe1-20020a056402390100b00566a1b8614esm1579691edb.58.2024.03.01.07.29.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 07:29:28 -0800 (PST)
Date: Fri, 1 Mar 2024 16:29:25 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Lena Wang =?utf-8?B?KOeOi+WonCk=?= <Lena.Wang@mediatek.com>
Cc: "fw@strlen.de" <fw@strlen.de>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"pablo@netfilter.org" <pablo@netfilter.org>,
	"kadlec@netfilter.org" <kadlec@netfilter.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"netfilter-devel@vger.kernel.org" <netfilter-devel@vger.kernel.org>
Subject: Re: [PATCH net v2] netfilter: Add protection for bmp length out of
 range
Message-ID: <ZeH0VdU-q_UyX0t0@nanopsycho>
References: <d2b63acc5cd76db46132eb6ebd106f159fc5132d.camel@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d2b63acc5cd76db46132eb6ebd106f159fc5132d.camel@mediatek.com>

Fri, Mar 01, 2024 at 04:12:24PM CET, Lena.Wang@mediatek.com wrote:
>From: Lena Wang <lena.wang@mediatek.com>
>
>UBSAN load reports an exception of BRK#5515 SHIFT_ISSUE:Bitwise shifts
>that are out of bounds for their data type.
>
>vmlinux   get_bitmap(b=75) + 712
><net/netfilter/nf_conntrack_h323_asn1.c:0>
>vmlinux   decode_seq(bs=0xFFFFFFD008037000, f=0xFFFFFFD008037018,
>level=134443100) + 1956
><net/netfilter/nf_conntrack_h323_asn1.c:592>
>vmlinux   decode_choice(base=0xFFFFFFD0080370F0, level=23843636) + 1216
><net/netfilter/nf_conntrack_h323_asn1.c:814>
>vmlinux   decode_seq(f=0xFFFFFFD0080371A8, level=134443500) + 812
><net/netfilter/nf_conntrack_h323_asn1.c:576>
>vmlinux   decode_choice(base=0xFFFFFFD008037280, level=0) + 1216
><net/netfilter/nf_conntrack_h323_asn1.c:814>
>vmlinux   DecodeRasMessage() + 304
><net/netfilter/nf_conntrack_h323_asn1.c:833>
>vmlinux   ras_help() + 684
><net/netfilter/nf_conntrack_h323_main.c:1728>
>vmlinux   nf_confirm() + 188
><net/netfilter/nf_conntrack_proto.c:137>
>
>Due to abnormal data in skb->data, the extension bitmap length
>exceeds 32 when decoding ras message. Then get_bitmap uses the
>length to make a shift operation. It will change into negative
>after several loop.
>
>UBSAN load can detect a negative shift as an undefined behaviour
>and reports an exception.
>
>So we should add the protection to avoid the length exceeding 32.
>If it exceeds it will return out of range error and stop decoding
>ras message.
>
>Signed-off-by: Lena Wang <lena.wang@mediatek.com>

Missing "Fixes" tag, again...


