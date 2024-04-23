Return-Path: <linux-kernel+bounces-154853-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E10868AE1FF
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 12:23:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9727B283187
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 10:23:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F04DF63102;
	Tue, 23 Apr 2024 10:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=aros@gmx.com header.b="iBTSr7xy"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B46461691
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 10:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713867824; cv=none; b=PXwcXMEwaDi9CbwBh0KHwlLroWYttZzk0TvvDXwDbydkcnVXJvH0hzjv8t0e2DDOH5G8/d68tgC8DG7ih78vPfENngdGNEGGhqlPUvIdbDMd3B4IdIh1wV/scHBU8sgx5Gw2tZRevkflzRf8kBA+TgoNYr1bF4Z9VRGZjiVpEN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713867824; c=relaxed/simple;
	bh=KeXFMDzJDaRepCzVh+u6BzAsLeekej3CPN+2oFPfzlk=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=J7AT5amUfqsorwaBbza+X9zZZ7uo6HAVHR5q+RgyOyX4JnHsQxNsPwbQVWwf1orD9nTknhRD3s2zIMs2AbI4YEwNaZeILivjfwdWVRs8sJMXDY7QPkHa/zsmPYLlSzkG12u/aG/jsbBUSyiraiN+LGrDBQUcXJfsoAdD6VWgfnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=aros@gmx.com header.b=iBTSr7xy; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1713867816; x=1714472616; i=aros@gmx.com;
	bh=KeXFMDzJDaRepCzVh+u6BzAsLeekej3CPN+2oFPfzlk=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:From:Subject:
	 Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=iBTSr7xyaMlataPrRcDzRAz9JoXJMuDPVoFguktKX+c0tlRwfaNv7dACHOqkrHCh
	 +0Lh9xsofFPCqP6KnK+KkVnFJN2HbVtFBLsgQNOknHGkx9Loftz7E5gyR35qzcGI5
	 CCZMp1jSxeVdlvQY2p6e25auAwzh1U/jpR0k5ve8Midq+L6kAgYM1TDto1zeZOGXy
	 wfhlGvCwjKi52SCpDm8oVKlztgK8eW2xCwke1gCT7chSbyuDZFkBhpNaztu+Qs7N8
	 8RF/zUfBAeA9XQNMj8ZxGutpvLEc+6KvV4NLuhFVuOWgqPhnJShMmW5dW/xPiX07q
	 N9lTdZvm9p86CLUxUA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [10.18.110.17] ([98.159.234.19]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MbzyP-1sYXWp1xF9-00bTOB; Tue, 23
 Apr 2024 12:23:36 +0200
Message-ID: <6574fc0f-8a24-4aff-8a1b-dbf960b6375d@gmx.com>
Date: Tue, 23 Apr 2024 10:23:34 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 chris.lu@mediatek.com, deren.wu@mediatek.com
From: "Artem S. Tashkinov" <aros@gmx.com>
Subject: BT_RAM_CODE_MT7961_1a_2_hdr.bin is missing in the firmware tree
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:2ui9g/KLAT9/W77b8Va5uVR+bAEDfFN1umwSq4xAyqqDDnVmfeA
 f8xmlOsVlzl67iQZOLrDzr+0sKYEjCg+nAsOVQeAVDnOrUDUNA/sa2HdhWLncyAJ6/pZpLn
 5MypCF1wjdl58MuzunipmyAjkk8OIP9CLRmYsmvUA4Ug4LLWcwNN9dFerYAdpmawTClCsiz
 NzUXBFeEm4D75Y28S0DlA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Cww+QVo+VFQ=;KaHjmWCNg0gBje0kcUdOvyugeOl
 xVD0lEqZw+PMMF6EMCUaSiMcDN3A8gKtbQa5NTUCSX7oM9dzgUUaIlRWhvuYtFQBW+LiPgxl3
 vqfrWBcTIBZIXC1Fv16met+JDJTDmCyY+RiYPJaPalRJulWlZA8zqcMSiOxbkoAhR5BO00Rkm
 CGJeNd0wRARWMvRbOo4Cf+BSQdcWmipL33of1GE4Jayd0dPjV45J75Kruukn+nR9DGt9hAZy4
 pdAt22znPxaOW/q71sO5O76pYt+WD1DVi3pczuA9SY32ehmFqfxM/IK4SW4iObotK2WUg9LmQ
 pMiGa4SysJ8+QWgCKyK8UWmCeYe6RL/dzrgYNQIY2QKHnEFEtn5GvLx4lB29wwic69uA/1JOp
 Pt9hDYwgiAN2pXezq2xFe71NWsQNZtv7lkM/WOeWtiNaBc9PAPVju/UdNllahQ/LdFrLpBpzn
 ZcEv5WjrAJyhopFwCf5SbQviIrnK+8oEPjPye8rbT9X20TndgCIX+G/FpHhH1kaB6SZEYvENR
 n9O9GNha9oNriWSYwptE9q9xVs1+2O0+2W3eSQse49gHXg2pSmklB8UPi3BuOtMcw7JhxLhVG
 2ikNQUfgtaPhL5QvWCx+yPHb3YLFEkbj6YsAkHLeK+tuhcibQv7KUyEsFN4xFd6yzqklq5vXc
 9HYWEoCpodGuJNHPmCdmBktu2HU8subtchvkc1RjXeqtP0MgJuKRcmy8aBn8DLzBANv5tKiRY
 o82b0usmDV3880LX+BdEJ3o2m3jDWObzHjkQwNp/Q9M9fJMqpEYduBE+DIkvbaRAi0fBGFIwZ
 MyXtQ8GPKiXLqZat6MR7T0jQgpwNrijV5iMyAdwcUUI4E=

Hello guys,

Could you please push this firmware ASAP?

It's been reported to be missing:
https://bugzilla.kernel.org/show_bug.cgi?id=3D218757



Regards,
Artem

