Return-Path: <linux-kernel+bounces-125697-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AF87892AC9
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 12:26:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF1861F22475
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 11:26:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D426381AA;
	Sat, 30 Mar 2024 11:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=aros@gmx.com header.b="egB7lB5E"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 630B72D057
	for <linux-kernel@vger.kernel.org>; Sat, 30 Mar 2024 11:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711797979; cv=none; b=fUsZm2rDfFySYeBL+geuz/y4TiDFL35n0+QhGvMPiEwEPmrmIRgZmwIyh3CNLI4TKSX1K6GGA0r4Fg1k7rpO0QkrN2sA5OxilyDcwnv0RshdL+JSs8fuSaYsFJHQ9Ds2X4fkjpEq7lFJMf/L9QU/SY/PBAZXEHEkeef7oH6sfps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711797979; c=relaxed/simple;
	bh=G5kwdLxSbDjt8P6jWlC4MHGlp/ObCABkPJCp2khAJCU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=f+GrpZi4ogntvcth9lbLMqumfmQgjFiFnPi9ELa5Ckc+nQfqTo24g+xrNJf9kwLW/CdtVXQ1NALxRuSc6XqAjyt1GmLOmKeaIEICM2FWNFGlZC3NAV12+eLJpG++VgJAc0MJG8TJYfehuumEHyrDWGcbibaoSTxW4Yp19pRbF9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=aros@gmx.com header.b=egB7lB5E; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1711797958; x=1712402758; i=aros@gmx.com;
	bh=G5kwdLxSbDjt8P6jWlC4MHGlp/ObCABkPJCp2khAJCU=;
	h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
	b=egB7lB5EhuvTmTgxg5oPAA0XI4k5FfAS23qX8ll0RFifQzmtsMOqETMqmTsBfFU8
	 hsOrf/6APzwwTo55bUUQGpBMjfMuJT71J2LM9RRk/y6St7bJBj9aU2kwbt3l23L6+
	 HMtIKOJd0L1tnq7DYXywJupQbRreyOUiVvkrHziS81ruC7dbNxrL5u+ebnMBTbJ++
	 rbdEOvALFSfFCbLLFYXFAgRTBl1FX+ys32tRr8ejy9PGmTBLGePpvkDWZELxkfl3S
	 Vh9uvbsd9jVrKqX3Bv9494bOMfMK3j0WqY1H5C4uv53ea4lZzyftbdSsSm2D+V3Vs
	 uzYYb44Zi8u0FJG7GQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [10.12.110.36] ([98.159.234.54]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MA7Ka-1s0wyy0r9e-00BYHR; Sat, 30
 Mar 2024 12:25:58 +0100
Message-ID: <5dbb3ccc-ea7c-4f60-800e-33df10dae8a9@gmx.com>
Date: Sat, 30 Mar 2024 11:25:56 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: workqueue: name exceeds WQ_NAME_LEN. Truncating to:
 events_freezable_power_efficien
To: Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org,
 Tejun Heo <tj@kernel.org>, Audra Mitchell <audra@redhat.com>
References: <cb894653-6e20-4759-8dd1-7b03ae8614cf@gmx.com>
 <9d84481e-6a21-41fa-ae7c-1a9c52fc48ad@infradead.org>
From: "Artem S. Tashkinov" <aros@gmx.com>
In-Reply-To: <9d84481e-6a21-41fa-ae7c-1a9c52fc48ad@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:zQUgXk3XFxl+cepcePwX2teHr0XDJZI/rIeI5QZx/L9stSNFGK9
 QaoSMPU6Rr5ji1ii++rMzem6/88Z5Xxe2Pc7QlSYykvWFtJJuwr36BcXgOX/txI7Rc87ldQ
 hnrjio5nvQvvIN+JotbQHc6vWLaLqOSVzfQ19uH0cDv40Q+pkOof4yoT0aiaPdwIifoIpEw
 S5ThY6ZH1doYIKK6C3iNQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:O3ugeUBMu2o=;LbZvClISQZKgNqtCLpM7IRZWcj4
 /YYyAlLI1mx9HaORdqLaC03rDHcHol7J12qaFHSZ5EnQTbgcAjWA9zpOs1ILC/R0DeIGHJt6F
 m9f2dertDRu43PKX874UlbsDAPxoy9tqMuE2WYXQwgXtOO6gEkiWH6TMHKpD/4Ve9OnDxdU+v
 8JJDyIIxNNHSH4QSwv39dNvQZNu95g/EjFaw4GYzZCYfbuxkij7soiGGD4rKS8R32066dNxkE
 v3x+VPDsFKIHLWyk7OaVM5G4vho1qCRwYiX8LS5ogaGQVPeB4/Ew9C6aeLHsX/MQSkEixOSWU
 82KBwpxa84c9dNh7K76egIYPZouKOXoq3uzhk0l+Fc2a3dQDgHDrzsVIxg3ud7IMpkgDhCrs+
 RgQb4IcPOv9YhsIypD8PQ+c7dbOqYE9p4+lb1JP20wjd9dl86yRptSH0K9OguG4MI0+OnUQyF
 HXSOyO3V3AdF6tfAnLOD9E8Zk9jRS9qzvjTqp9jKJLayu8JieZMvEeYBUmpp15ciu58fAxrFB
 AnNmQIeX0bfpO4J4kOdl8PkNSgQ6ZFg8l9/oHBqbIPOeDhGuT5blFr0qRdLmh1qMwiKISq4Or
 d41RV/TrEJGFJqbUPqhg/3pzqnqvDZvooTSznpKZ9JoLC1YNBOuOH+unJqNtIWsZzxvI5FM3v
 uR0lDxGn1zXmso+ZguMGts81JJwfs7VEeOlwidV0cQY/ebfeWUtpso75nXkTOG8DaWvLF7lDA
 eVyG7p3AkaloBqw6T1aRt+N9RaVLzTZYv5P0EsFwzx7qrffUGkmhIXmgduMIbrW19KfTPjHqL
 SXHA3rKsUmt4JpyLk1SlOdPYSxy8++mheubbyjkczifYw=

Commit 8318d6a6362f5903edb4c904a8dd447e59be4ad1 is not yet in 6.8.x stable=
.

Please push.

On 3/29/24 18:53, Randy Dunlap wrote:
> Hi,
>
> On 3/27/24 03:37, Artem S. Tashkinov wrote:
>> Hello,
>>
>> There's a new warning message in kernel 6.8 which I guess shouldn't be
>> there. Linux 6.7 did not have it.
>>
>> No idea where it comes from:
>>
>> workqueue: name exceeds WQ_NAME_LEN. Truncating to:
>> events_freezable_power_efficien
>>
>> A relevant bug report: https://bugzilla.kernel.org/show_bug.cgi?id=3D21=
8649
>>
>> Please fix.
>
>
> Tejun, should 8318d6a6362f5 be backported to 6.8? or maybe it has been a=
lready?
>
> Also, it look like Documentation/core-api/workqueue.rst needs to be upda=
ted
> with the new workqueue name. Audra?
>
> thanks.

