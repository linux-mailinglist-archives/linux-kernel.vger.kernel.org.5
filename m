Return-Path: <linux-kernel+bounces-56427-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 57A6684CA04
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 12:55:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 149C428902C
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 11:55:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 214B41D532;
	Wed,  7 Feb 2024 11:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B4TA6o+c"
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7D271D524;
	Wed,  7 Feb 2024 11:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707306931; cv=none; b=T2N/yXY8XKE9xvp6Ssi16JgS5NPVG51EVHambZNixbNEef8PXLy+h7etD1jcaBr/RFL5VcNCGUUpP6ljnqGdbb4XlAySu70Wc3jWUjWJGWNY9Hp5ZVKywYlMB5iYpibLojWRl10lqnNsUCydCzvFgfN/pmZhmPE/drOuF6+U27s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707306931; c=relaxed/simple;
	bh=lHf+OWDLZDGg6pLM+bTSB+6Bvo2/35m7PoQGalQGx5o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BcJGr4QqDahcim53ayLJxXHqJOnpu30SPI3AWmi1VN8aa4wRQSoHwuUSo9TMRBoSMM7NGEeM7y0LkXf0oSmdZwLO+QpK7pJT5XRcDcH6dhSitpuWutTf3CFLj6xtCUOGLggaxCkkhQWc3mFHJumi++pBtQtiOZ9y/iDbv9DA1To=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B4TA6o+c; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-68c9711344bso1000226d6.0;
        Wed, 07 Feb 2024 03:55:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707306928; x=1707911728; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TMWJy3Ykt18rUU55JyWersH8Lc1FhDRKaenhhpPJe88=;
        b=B4TA6o+cHBKEidI2bb7Ksby2TpBlbblJfBQNR2kaqXAe+JRHGzEmY6H3lSaoAKQznA
         pFo2AQ4Vlzv6jT8UaK11j3egtpkzBB2VHAT7nYdpqVNzKC/gJoUWYbhINoGAafPkrftH
         Q+zqHz4neqD8FMrbKBRsKwr+xX+YdlJqKl5AAxToqcEqe9Ss/aa/EV2SKtYfVnNSlfdZ
         gW+cMqk58O64BMwU8o/u4HYSxuTEGv6qbEWIhHJaSBZQzl3SmwYQl1kFUlf6CoHLKSnu
         SzmPnxYOZ9AC8ePsfBo3A6Y2DAEYkoS524cG/w2PhWh0KojHV1lRk8ytFDZgWlUxe9av
         /DSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707306928; x=1707911728;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TMWJy3Ykt18rUU55JyWersH8Lc1FhDRKaenhhpPJe88=;
        b=wiYtk6d+J3F+66Lo63rw+R+ZWcTH0WZvrXotkBGFJ4R1stRDuwhWCgSlngLb0d74K8
         TpnnE6Q4dE3ts1fasZD71B85DfCnCVja9D4oKXOjfaxjntTOVsRqxb9BfuB6rNN/tcPt
         WP8aGLfjAtQgDVTDtTmr3UDwgyKX33crNgYtDyz7gwegk1K9/5nVO3nqVlPJ+YhPyqi7
         4+G65KMzrim33R1Tu2gHLyHHB/xflSWvbpsKEysF2ZmXJjg0H6tU0Knv3nf4hrZduWbi
         GeiZk1Z1JT1/gct5BoE13eIBh+UPZ4z8lXpf9MAsuoDAoPr/6wP3nwWSK9/6DJwuKbhZ
         Hc1w==
X-Forwarded-Encrypted: i=1; AJvYcCW2zILPLMQ0Rjbsj3wwW0Ih3J4iJksf9ABVlqDmSHKS4Yl0PJzQnbTU1NiZV6S+m1gYfMgrrOoOkTJEA0UDuhAO6J/uPKeZsAVTlG6hGX/nPfn8tiCm6Lo1nrYrD6t4VoaB3yOPYrhO
X-Gm-Message-State: AOJu0YxhHqpeKYQzC0giWFLAAg3b5lvyivUSefx4XZ283GVltwI90YqK
	syLuBIVS1A5uL9DQRevw20l7pIpx4cd9fsESPbx2HBQv8ZLERtPFPVXpD63G50ZDjVd2aQKl2ow
	PY7rsVqCzh/t0rQBoCbOFIwmCnqc=
X-Google-Smtp-Source: AGHT+IEaKEVeALso9mpbzrfe2iESCrF5uQjBYRgZMns5CCECuRK3cc97D/TtYfARyrGbR40gD84+QW77z/73uxDoISQ=
X-Received: by 2002:ad4:5d49:0:b0:68c:b1a4:ecc with SMTP id
 jk9-20020ad45d49000000b0068cb1a40eccmr4690112qvb.6.1707306928386; Wed, 07 Feb
 2024 03:55:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABXGCsNnUfCCYVSb_-j-a-cAdONu1r6Fe8p2OtQ5op_wskOfpw@mail.gmail.com>
 <Zb6D/5R8nNrxveAP@cae.in-ulm.de> <Zb/30qOGYAH4j6Mn@cae.in-ulm.de>
 <CABXGCsPu73D+JS9dpvzX78RktK2VOv_xT8vvuVaQ=B6zs2dMNQ@mail.gmail.com>
 <e7b96819-edf7-1f9f-7b01-e2e805c99b33@linux.intel.com> <CABXGCsPjW_Gr4fGBzYSkr_4tsn0fvuT72G-YJYXcb1a4kX=CQw@mail.gmail.com>
 <2d87509a-1515-520c-4b9e-bba4cd4fa2c6@linux.intel.com>
In-Reply-To: <2d87509a-1515-520c-4b9e-bba4cd4fa2c6@linux.intel.com>
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date: Wed, 7 Feb 2024 16:55:17 +0500
Message-ID: <CABXGCsPdXqRG6v97KDGy+o59xc3ayaq3rLj267veC7YcKVp8ww@mail.gmail.com>
Subject: =?UTF-8?Q?Re=3A_This_is_the_fourth_time_I=E2=80=99ve_tried_to_find_wha?=
	=?UTF-8?Q?t_led_to_the_regression_of_outgoing_network_speed_and_each_t?=
	=?UTF-8?Q?ime_I_find_the_merge_commit_8c94ccc7cd691472461448f98e2372c7?=
	=?UTF-8?Q?5849406c?=
To: Mathias Nyman <mathias.nyman@linux.intel.com>
Cc: "Christian A. Ehrhardt" <lk@c--e.de>, niklas.neronin@linux.intel.com, 
	Linux List Kernel Mailing <linux-kernel@vger.kernel.org>, Greg KH <gregkh@linuxfoundation.org>, 
	linux-usb@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 7, 2024 at 3:39=E2=80=AFPM Mathias Nyman
<mathias.nyman@linux.intel.com> wrote:
>
> Thanks,
>
> Looks like your network adapter ends up interrupting CPU0 in the bad case=
 due
> to the change in how many interrupts are requested by xhci_hcd before it.
>
> bad case:
>         CPU0    CPU1    ...     CPU31
> 87:     18213809 0      ...     0       IR-PCI-MSIX-0000:0e:00.0    0-edg=
e      enp14s0
>
> Does manually changing it to some other CPU help? picking one that doesn'=
t already
> handle a lot of interrupts. CPU0 could also in general be more busy, poss=
ibly spending
> more time with interrupts disabled.
>
> For example change to CPU23 in the bad case:
>
> echo 800000 > /proc/irq/87/smp_affinity
>
> Check from proc/interrupts that enp14s0 interrupts actually go to CPU23 a=
fter this.
>
> Thanks
> Mathias
>

root@secondary-ws ~# iperf3 -c primary-ws.local -t 5 -p 5000 -P 1
Connecting to host primary-ws.local, port 5000
[  5] local 192.168.1.130 port 49152 connected to 192.168.1.96 port 5000
[ ID] Interval           Transfer     Bitrate         Retr  Cwnd
[  5]   0.00-1.00   sec  70.9 MBytes   594 Mbits/sec    0    376 KBytes
[  5]   1.00-2.00   sec  72.4 MBytes   607 Mbits/sec    0    431 KBytes
[  5]   2.00-3.00   sec  73.1 MBytes   613 Mbits/sec    0    479 KBytes
[  5]   3.00-4.00   sec  72.4 MBytes   607 Mbits/sec    0    501 KBytes
[  5]   4.00-5.00   sec  73.2 MBytes   614 Mbits/sec    0    501 KBytes
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate         Retr
[  5]   0.00-5.00   sec   362 MBytes   607 Mbits/sec    0             sende=
r
[  5]   0.00-5.00   sec   360 MBytes   603 Mbits/sec                  recei=
ver

iperf Done.
root@secondary-ws ~# echo 800000 > /proc/irq/87/smp_affinity
root@secondary-ws ~# iperf3 -c primary-ws.local -t 5 -p 5000 -P 1
Connecting to host primary-ws.local, port 5000
[  5] local 192.168.1.130 port 37620 connected to 192.168.1.96 port 5000
[ ID] Interval           Transfer     Bitrate         Retr  Cwnd
[  5]   0.00-1.00   sec   111 MBytes   934 Mbits/sec    0    621 KBytes
[  5]   1.00-2.00   sec   109 MBytes   913 Mbits/sec    0    621 KBytes
[  5]   2.00-3.00   sec   110 MBytes   920 Mbits/sec    0    621 KBytes
[  5]   3.00-4.00   sec   110 MBytes   924 Mbits/sec    0    621 KBytes
[  5]   4.00-5.00   sec   109 MBytes   917 Mbits/sec    0    621 KBytes
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate         Retr
[  5]   0.00-5.00   sec   549 MBytes   921 Mbits/sec    0             sende=
r
[  5]   0.00-5.00   sec   547 MBytes   916 Mbits/sec                  recei=
ver

iperf Done.

Very interesting, is CPU0 slower than CPU23 by 30%?

--=20
Best Regards,
Mike Gavrilov.

