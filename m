Return-Path: <linux-kernel+bounces-129675-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FDA6896E53
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 13:38:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EDDF9B2280C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 11:38:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 708D8143865;
	Wed,  3 Apr 2024 11:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ab3c3163"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B04D83D6C;
	Wed,  3 Apr 2024 11:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712144295; cv=none; b=aoRxWSXA4fCMpxrOCoj2xZXPIxggllaIkyV5CySPchpK/cfVeTS8r43AHq82H6HygmqQvRVkjDx0w06O90LVeAHHC7RO2BUHzcBWz7i7EodtAAYMsPJHCBX5dYGSbczMJQ0pYvl5g+sNaZWk2Gjv+vyZBITF0Q/wVi13kJ0grG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712144295; c=relaxed/simple;
	bh=Hnx/pIW0eTpm1FrDUL9ju/6DfPN6qXSSbr9a8Ik9WVk=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=FgO2GhIuDiZqFhnZXjoqvwjss5VYOLh2gLEHpjQhRQ1wAqLGoTDxWuD8/O/sTmch+w+tory2xB/fW5NkJkIkDS9vKPbQ++0vzFqMYXOGeFzQbXW8Yvh4gW2B/2P1bIoi0msPI2CxTu7BAyUuhehbMJ3Ci8VuL9t/+ZEDWpDJd+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ab3c3163; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D983C433C7;
	Wed,  3 Apr 2024 11:38:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712144295;
	bh=Hnx/pIW0eTpm1FrDUL9ju/6DfPN6qXSSbr9a8Ik9WVk=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=ab3c3163UIxLEw3emy7t3UfBNt9wAAeg61GMIbMp95bw4juYfZin9pMQVEMpesbSJ
	 /iRq7ZyFN3MYpR6Ku4DuWZAjq8An57yRKO7KlqYlXWzaH6lWidF+8D30dGIlyZ4aLL
	 rCKtndQRTf236Gx28ZuXSbmJIVTj3bLWmHM5whHUfgqaJAFG5+wkDizIM9qYhJod3s
	 NjH0lRpIz7EpsZsRzI7HlttPIMSdCHj+nT0q91OjW+LfaV/LChF/rUNABF82s5NxPr
	 ke4U4qNlHLb4qQDp+rq4G2IKwMRf0LsDSNqTr/Jc4vTElXHlFUx/z+ePp34nRZpiol
	 Exm+ipJn1Rx/g==
Date: Wed, 3 Apr 2024 13:38:12 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Yaraslau Furman <yaro330@gmail.com>
cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, 
    Lucas Zampieri <lzampier@redhat.com>, 
    =?ISO-8859-15?Q?Filipe_La=EDns?= <lains@riseup.net>, 
    "open list:HID LOGITECH DRIVERS" <linux-input@vger.kernel.org>, 
    open list <linux-kernel@vger.kernel.org>, 
    Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v2] HID: logitech-dj: allow mice to report multimedia
 keycodes
In-Reply-To: <20240222101811.18921-1-yaro330@gmail.com>
Message-ID: <nycvar.YFH.7.76.2404031337250.20263@cbobk.fhfr.pm>
References: <20240130111700.11666-1-yaro330@gmail.com> <20240222101811.18921-1-yaro330@gmail.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 22 Feb 2024, Yaraslau Furman wrote:

> Multimedia buttons can be bound to the mouse's extra keys in Windows application.
> Let Linux receive those keycodes.
> 
> Signed-off-by: Yaraslau Furman <yaro330@gmail.com>
> ---
>  drivers/hid/hid-logitech-dj.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/hid/hid-logitech-dj.c b/drivers/hid/hid-logitech-dj.c
> index e6a8b6d8eab7..3c3c497b6b91 100644
> --- a/drivers/hid/hid-logitech-dj.c
> +++ b/drivers/hid/hid-logitech-dj.c
> @@ -965,9 +965,7 @@ static void logi_hidpp_dev_conn_notif_equad(struct hid_device *hdev,
>  		}
>  		break;
>  	case REPORT_TYPE_MOUSE:
> -		workitem->reports_supported |= STD_MOUSE | HIDPP;
> -		if (djrcv_dev->type == recvr_type_mouse_only)
> -			workitem->reports_supported |= MULTIMEDIA;
> +		workitem->reports_supported |= STD_MOUSE | HIDPP | MULTIMEDIA;
>  		break;

CCing Hans who introduced this explicit check back in 3ed224e273ac 
("HID: logitech-dj: Fix 064d:c52f receiver support").
Should it be made device-specific?

-- 
Jiri Kosina
SUSE Labs


