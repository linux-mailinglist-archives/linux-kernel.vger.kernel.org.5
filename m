Return-Path: <linux-kernel+bounces-72157-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0986E85B029
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 01:59:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86A9B281802
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 00:59:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66B0A10785;
	Tue, 20 Feb 2024 00:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="N96PZDa4"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31511523E;
	Tue, 20 Feb 2024 00:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708390785; cv=none; b=utldTriHMkb56z9YZbbnwF9w/Bgq/b8kp55vADWpypEsCghqj1wuA9PaXcv6GEE6zZya3HCHJJt6yjcBfEVx0Lot4XHOWE/BpSUaHUJgktQJfHkNkw/vD8B0cIl7Pxo/MtXS+EJTwuxcvq/E2jUTrCj4F2Dwg8HkQKqjCPhxQfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708390785; c=relaxed/simple;
	bh=G3cayVQtI2p/f+MLern2VJrT9ZieS6kNRzoeSncEHak=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=cwM2urVDrr6G4PcNr/TO3UZf2n56jocm3wqY4H1pWsC1OpfpdBiu6RIHb2Ao7ngtVh/NqZxM1NHTRz3ZSU1Qy+ipQQGhSugUE+vhI1Jcccb76nqr3UpQ5wJ/MH0jDJhAUDg9JKZa5OFexjDdxKEiSbcgMVIP6otOe4/Kg4HRPyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=N96PZDa4; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1708390772; x=1708995572; i=w_armin@gmx.de;
	bh=G3cayVQtI2p/f+MLern2VJrT9ZieS6kNRzoeSncEHak=;
	h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:
	 In-Reply-To;
	b=N96PZDa4Jm4cUWuFaNH8dgI0lw2CEQInwhrSZSyXuOMZZkQk5f5AvdE1pZZkNIOL
	 XtISAaUWtKMLLr4Nj92yEydjoNu0qf7pSewiVkBDzcXE4JVLumy9yp79lWNOVlgu7
	 57KM0jb+3cw1tbV/v8wCeLA/ASzwX1wd06BP5JleqNqyyvUVvhdQlAuBAQMwhGcDc
	 sdlW8xbQJi4k48csHUf4641qJmZsvCI1mk3MonwIW3g7n3/3rlQeMa9hXXb0uRSpD
	 cDLxjGDS7gjVCDm94V8kcsUDvCSKTsX/aW0DsdroB9sHJBq5sMr40v4r5PAcFHKIw
	 Qife/LS5tDcWgPO7gg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [141.30.226.129] ([141.30.226.129]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MFsUv-1rj3IR1qUp-00HLYM; Tue, 20
 Feb 2024 01:59:32 +0100
Message-ID: <dcb7c031-b920-4774-a1a9-fed8813390d0@gmx.de>
Date: Tue, 20 Feb 2024 01:59:31 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/5] platform/x86: wmi: Check if event data is not NULL
From: Armin Wolf <W_Armin@gmx.de>
To: corentin.chary@gmail.com, luke@ljones.dev
Cc: hdegoede@redhat.com, ilpo.jarvinen@linux.intel.com,
 platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240219115919.16526-1-W_Armin@gmx.de>
 <20240219115919.16526-3-W_Armin@gmx.de>
Content-Language: en-US
In-Reply-To: <20240219115919.16526-3-W_Armin@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:sqkIpJjdLNN2Xz06dHyvYiwdLRxSaaC+nOOYYDBNIAH1UdJXlcm
 Fyt2eRQfFqI2DetR+q4c9kAThnCMkh01nMYeDsAYuCTSIOUS3dV3RI4ypOKqOMLI0Q+CMYI
 x2NHFPhZiCCJ3IXz7Lbb1Zt04T0ZZJs1eNDx4lsm5oWTLy1LSbZNvf1auaoT1PaS+NFDpGE
 3c4+oJRk4+q1v0yRRiKpw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:7SqeUlqk4VA=;5AV9YYWdZnzubOew+N7PFf4aHg0
 J7yzM9cs5VDxDlai0ldqt+5ikA4E0W89YMXYDYQjn64sVUhdimzn9Y1MK+bLc/zhK/211jLPj
 rinsblAyQvGJ/ukE547b7KsIIMxbSvthzsClprk+1KsPUKqPwZQRn5yBjBJcJ8/Y/8lJtgP/L
 CCx5htxJvpIWjKIGVZiM+ou+jNpSY9H/f1+s78Xrl2GW8OB+JDHkqAbSfDadqI/Cc2Fl8SKQV
 BcovcHNkbl8qc6XsIDVYSnZyTbrtGzT2uoNtxgBZwCtWodVdTcPW2Y21V4XddkuTk8bmyEdrI
 IxYCBxtgHFUY+dh5rPoXK5Id4wPn9nqBc6LU9fIuiVVEAVxQlvPbB7Fh/NMNOVGi1c6/FTjue
 6rILcjje5Ah8y5OKjShxC2NlcRHBLcZlUcQEFke1Hd8LcKR58VVWfzOvEX6f+PNQiXTR/9vsR
 z+wuBCguwwXXkMSg7pymuEaibbDUJmDpoCHZkrNXy6Ldecyy8M1PLGJPXdooJjoH66X1DvI03
 v2TZcjpt2jSZOIwFI7o0qWTUY+wzuif4zE+LZvYH32cZ/S6UzWEN13+0FmUrezOGmCCGzD9Cd
 cY3gH6+KUoJRb2OOvYH3rjWroPwGTBx3ejbbbsLjTPhMVo+Mu+PHqc7ocCmEIevRLa5nX00BH
 XGPNTPAupE0nN8mgCuTq3of4Al81bdhvXbJ312lohcGk52c8M5AkFQD0UHmZt0CKQUb93jY9I
 +B5mkNlnlGnReoyyGwRlN90ZPT7YWPhbi/rz3zMGeHlHVsBcFH1eueYWYeLGpyCuz5NRkC4oQ
 bmG7PkRJldvdWOAbYdBXF2K56+w79jYnPkGHT5i3LY0Wo=

Am 19.02.24 um 12:59 schrieb Armin Wolf:

> WMI event drivers which do not have no_notify_data set expect
> that each WMI event contains valid data. Evaluating _WED however
> might return no data, which can cause issues with such drivers.
>
> Fix this by validating that evaluating _WED did return data.
>
> Signed-off-by: Armin Wolf <W_Armin@gmx.de>
> ---
>   drivers/platform/x86/wmi.c | 11 +++++++++--
>   1 file changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/platform/x86/wmi.c b/drivers/platform/x86/wmi.c
> index 8fb90b726f50..d0fe8153f803 100644
> --- a/drivers/platform/x86/wmi.c
> +++ b/drivers/platform/x86/wmi.c
> @@ -1210,6 +1210,7 @@ static void wmi_notify_driver(struct wmi_block *wblock)
>   {
>   	struct wmi_driver *driver = drv_to_wdrv(wblock->dev.dev.driver);
>   	struct acpi_buffer data = { ACPI_ALLOCATE_BUFFER, NULL };
> +	union acpi_object *obj = NULL;
>   	acpi_status status;
>
>   	if (!driver->no_notify_data) {
> @@ -1218,12 +1219,18 @@ static void wmi_notify_driver(struct wmi_block *wblock)
>   			dev_warn(&wblock->dev.dev, "Failed to get event data\n");
>   			return;
>   		}
> +
> +		obj = data.pointer;
> +		if (!obj) {
> +			dev_warn(&wblock->dev.dev, "Event contains not event data\n");

I just noticed that this should have been "Event contains no event data\n". Should i send
another patch?

Armin Wolf

> +			return;
> +		}
>   	}
>
>   	if (driver->notify)
> -		driver->notify(&wblock->dev, data.pointer);
> +		driver->notify(&wblock->dev, obj);
>
> -	kfree(data.pointer);
> +	kfree(obj);
>   }
>
>   static int wmi_notify_device(struct device *dev, void *data)
> --
> 2.39.2
>
>

