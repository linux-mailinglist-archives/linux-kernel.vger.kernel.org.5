Return-Path: <linux-kernel+bounces-120240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6020D88D4BF
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 03:45:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 850BD1C24B0B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 02:45:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFC58219FD;
	Wed, 27 Mar 2024 02:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="Z1fhMWe3"
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E64C22612;
	Wed, 27 Mar 2024 02:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711507502; cv=none; b=f9bjsWWC61qukVQcmzx49oaw2zk/kkHJeO0lZVIKJJOdB8kfhKfi/kVG9ojc3DAeC1oUVnu2aZ3yKePtRz7PjZHtMxeRwXC1Bw7s8w9U1OO1mM0f/DSQFL0ZN+Vgb7or7A9fVUHmZMBHCsd2cRdzj0CsasagPnQv6mdBjMtyxNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711507502; c=relaxed/simple;
	bh=ZlGdXtQ6a+IU1Vfo0LbtA3kntZ1k0nC7uGGUg4o2CX4=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gdtrb5t8Rv9yQaKfcN1rOX8Jf/IYK4vq51RJP6VswB+fzi+7Q6ABJazXwE86Q46+zHw9wlS+bKIBkwopuYA9t9MXz4RAWSlYcvzmTEvm5R9PRj0Tzl/5q/ndSgyt71TFeJyK+G7pH6gocpCRIg6Le1Do+fNxu3TQHyqPwU8sEnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=Z1fhMWe3; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42R0kKqf016499;
	Tue, 26 Mar 2024 19:44:36 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	date:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=pfpt0220; bh=4QmuyiaIUaiEOsuL4SrT2L
	gGji/ehcezRApAST7UxxM=; b=Z1fhMWe30IsR8B4KIKc9ygGeOg/EdgzvFxkjn/
	0kl1wXaFIvVpOugHlGA13cXVKDPhUA+zWeQIQHSdlzcOf2m2Tk/mh6k9zaf0Ls/u
	R/dgor2G0klECE9We2nD0wbNvc5nyiVMhbwFKsMjFMAbiiCxuQybZ3J3g8o4CuLK
	425P8DMZVrQlXZbzR5QxPA4apbABCtLBUkCAsWwQk7R4N1Eob1rwXS0xH9uVL+NZ
	xc6SUCvGZGxdLgCTvGXWKCgGUIeBgjOzlyqoZxz4mUbLFiXjcTaci977x5XK54f2
	0L0WubXlsL7BCf0PTnnsGYa/u0xCLbfLa0zHxmFXTkAwTZKA==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3x3hy1wvk0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 Mar 2024 19:44:36 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 26 Mar 2024 19:44:35 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 26 Mar 2024 19:44:35 -0700
Received: from maili.marvell.com (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with SMTP id 10D783F70BE;
	Tue, 26 Mar 2024 19:44:31 -0700 (PDT)
Date: Wed, 27 Mar 2024 08:14:30 +0530
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: Nikita Kiryushin <kiryushin@ancud.ru>
CC: Michael Chan <mchan@broadcom.com>,
        Pavan Chebbi
	<pavan.chebbi@broadcom.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni
	<pabeni@redhat.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <lvc-project@linuxtesting.org>,
        Michael Chan <michael.chan@broadcom.com>
Subject: Re: [PATCH net-next v2] tg3: Remove residual error handling in
 tg3_suspend
Message-ID: <20240327024430.GA1370891@maili.marvell.com>
References: <CACKFLikPmtbkvVFerB0WNvLN3w=ia_vd6fUAo8iWpAqNsegMaQ@mail.gmail.com>
 <20240326183544.488242-1-kiryushin@ancud.ru>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240326183544.488242-1-kiryushin@ancud.ru>
X-Proofpoint-GUID: 4AGsAVgXVKnoWQzwul2W_gl7X67FMrx-
X-Proofpoint-ORIG-GUID: 4AGsAVgXVKnoWQzwul2W_gl7X67FMrx-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-26_12,2024-03-21_02,2023-05-22_02

On 2024-03-27 at 00:05:44, Nikita Kiryushin (kiryushin@ancud.ru) wrote:
> As of now, tg3_power_down_prepare always ends with success, but
> the error handling code from former tg3_set_power_state call is still here.
>
> Remove (now unreachable) code for simplification and change
> tg3_power_down_prepare to a void function as its result is no more checked.
>
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
>
> Fixes: c866b7eac073 ("tg3: Do not use legacy PCI power management")
> Signed-off-by: Nikita Kiryushin <kiryushin@ancud.ru>
> Reviewed-by: Michael Chan <michael.chan@broadcom.com>
> ---
> v2: Change tg3_power_down_prepare() to a void function
> as Michael Chan <michael.chan@broadcom.com> suggested.
>  drivers/net/ethernet/broadcom/tg3.c | 30 ++++-------------------------
>  1 file changed, 4 insertions(+), 26 deletions(-)
>
> diff --git a/drivers/net/ethernet/broadcom/tg3.c b/drivers/net/ethernet/broadcom/tg3.c
> index 04964bbe08cf..bc36926a57cf 100644
> --- a/drivers/net/ethernet/broadcom/tg3.c
> +++ b/drivers/net/ethernet/broadcom/tg3.c
> @@ -4019,7 +4019,7 @@ static int tg3_power_up(struct tg3 *tp)
>
>  static int tg3_setup_phy(struct tg3 *, bool);
>
> -static int tg3_power_down_prepare(struct tg3 *tp)
> +static void tg3_power_down_prepare(struct tg3 *tp)
>  {
>  	u32 misc_host_ctrl;
>  	bool device_should_wake, do_low_power;
> @@ -4263,7 +4263,7 @@ static int tg3_power_down_prepare(struct tg3 *tp)
>
>  	tg3_ape_driver_state_change(tp, RESET_KIND_SHUTDOWN);
>
> -	return 0;
> +	return;
>  }
>
>  static void tg3_power_down(struct tg3 *tp)
> @@ -18090,7 +18090,6 @@ static int tg3_suspend(struct device *device)
>  {
Please address Michael Chan's comment to make this function return type to "void"
instead of "int"

>

