Return-Path: <linux-kernel+bounces-14467-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EFDAA821D68
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 15:08:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A16801F22D3A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 14:08:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F35BF10958;
	Tue,  2 Jan 2024 14:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b="IVaBv7+A"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail.tuxedocomputers.com (mail.tuxedocomputers.com [157.90.84.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AC1510957;
	Tue,  2 Jan 2024 14:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxedocomputers.com
Received: from [192.168.42.20] (p5de453e7.dip0.t-ipconnect.de [93.228.83.231])
	(Authenticated sender: wse@tuxedocomputers.com)
	by mail.tuxedocomputers.com (Postfix) with ESMTPSA id 28E662FC0048;
	Tue,  2 Jan 2024 15:08:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tuxedocomputers.com;
	s=default; t=1704204492;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mvn3w4e1IYla2d0uIR1Jhj+rox2L3HFlMPKxi/ngIPQ=;
	b=IVaBv7+AVQIlli4R2WJl8H0AqUmy+SSFYj9YGXlUaPETwL8dRJwyfOBDmsZVnUcut7F5xg
	oPjN+8j3e4cFfUE6XtetJ0mMnxnl7EC7k1LRRY1cL70sbnUb1d4n3C5QgCRfUMuoLOiPyl
	nzMBlYgMGcFEGKeEZJZ+Gg5F6EuODss=
Authentication-Results: mail.tuxedocomputers.com;
	auth=pass smtp.auth=wse@tuxedocomputers.com smtp.mailfrom=wse@tuxedocomputers.com
Message-ID: <19a39ca1-ca72-4ee1-96e9-c55541e67aa4@tuxedocomputers.com>
Date: Tue, 2 Jan 2024 15:08:11 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] i8042: Use new forenorestore quirk to replace old
 buggy quirk combination
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
 Hans de Goede <hdegoede@redhat.com>
References: <20240102134833.68646-1-wse@tuxedocomputers.com>
 <20240102134833.68646-2-wse@tuxedocomputers.com>
Content-Language: en-US
From: Werner Sembach <wse@tuxedocomputers.com>
In-Reply-To: <20240102134833.68646-2-wse@tuxedocomputers.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

Am 02.01.24 um 14:48 schrieb Werner Sembach:
> The old quirk combination sometimes cause a laggy keyboard after boot. With
> the new quirk the initial issue of an unresponsive keyboard after s3 resume
> is also fixed, but it doesn't have the negative side effect of the
> sometimes laggy keyboard.
>
> Signed-off-by: Werner Sembach <wse@tuxedocomputers.com>
> Cc: stable@vger.kernel.org

Added Hans to the loop.

As mentioned in the one on one e-Mails with Hans I wrote a new quirk in [Patch 
1/2] and tested it on the device in [Patch 2/2]

At least one more device will follow which has negative side effects with the 
old quirkls, but I currently don't have it at hand for testing.

I wonder if devices where the old quirk combination did not cause issue should 
also be switched to the new quirk, if, after testing, it also fixes the 
unresponsive keyboard issues?

Kind regards,

Werner


