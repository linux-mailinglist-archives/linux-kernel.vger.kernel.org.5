Return-Path: <linux-kernel+bounces-25117-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 419A782C822
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 00:54:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98386286EC4
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 23:54:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C125B1A707;
	Fri, 12 Jan 2024 23:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="ne+qwFOf"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02F0A1A700
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 23:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [127.0.0.1] ([76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.17.2/8.17.1) with ESMTPSA id 40CNrvsx789459
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Fri, 12 Jan 2024 15:53:58 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 40CNrvsx789459
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2023121201; t=1705103638;
	bh=gH4soseRQx7ypeoG3GSm/+9iCRgHKMfoyURA2wVuEl0=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=ne+qwFOfd4yOghEBim5JYmqONoRT6X2IQDh9ICseBbmtg4HhZEn9xEZ8Ty/5i+4GT
	 fCoY3oHZRtJw+6cq3uVvoHYwShxRxePHkFi4+ojJg4I1+YSQ9RAzSlsBjwDCl3M74w
	 obrZME5v7Sx8S1/e7pPKDEHuw/kbUgJ64/WZ/7tqebaE9ZeF6pFJ+aFs9UYRF8KqQl
	 CKRmyYx0zLwJTfqhN9rzyXXGNvcqPOZu3ehM9bPhfOdkNplDkTePGU396dmkhwxOei
	 HfnjwWZ+Sp61X4Zy0EB/0ecppwXMKY8o25bYaW5dqjN4burA/PRFD82Q45QyOWNb6F
	 r8sMjnJvloLYA==
Date: Fri, 12 Jan 2024 15:53:56 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
To: David Howells <dhowells@redhat.com>
CC: dhowells@redhat.com, linux-kernel@vger.kernel.org, pinskia@gmail.com
Subject: Re: [PATCH 00/45] C++: Convert the kernel to C++
User-Agent: K-9 Mail for Android
In-Reply-To: <2153666.1705049523@warthog.procyon.org.uk>
References: <49231a98-d39f-4920-8d9f-e60aa014f518@zytor.com> <152261521484.30503.16131389653845029164.stgit@warthog.procyon.org.uk> <3465e0c6-f5b2-4c42-95eb-29361481f805@zytor.com> <2153666.1705049523@warthog.procyon.org.uk>
Message-ID: <2604C18A-4DF1-443B-9A31-F52666C80BE0@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On January 12, 2024 12:52:03 AM PST, David Howells <dhowells@redhat=2Ecom> =
wrote:
>H=2E Peter Anvin <hpa@zytor=2Ecom> wrote:
>
>> One thing I forgot to mention that would be quite useful is careful use=
 of
>> namespaces=2E
>
>Just be aware that the use of namespaces would make the kernel image bigg=
er if
>symbols are included=2E
>
>David
>

If we can leverage data compression it probably would be a lot of space du=
e to the highly repetitive nature of most symbols=2E To allow for random ac=
cess that requires a bit of sophistication, but nothing that couldn't be so=
lved=2E

