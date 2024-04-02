Return-Path: <linux-kernel+bounces-127469-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AD70894C1E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 09:05:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6ED5C1C22211
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 07:05:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7245336AF3;
	Tue,  2 Apr 2024 07:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iOveFKgX"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D77DA339B1
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 07:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712041515; cv=none; b=NhBle2uMVJqRDReh+dPI+0bsJM5FDhF2j9HICzUQPShthJzFi12oqqykdZiKhqnD+y2huQD7oCY338vvCQFuUsIGOsYJGd1L3zl9sZt7AbNseo6wVXHcAHpbcmy5i6TBIdJ2KDT1mXK3oIkknOcIRQ0fH2Fpi4DJgRwO69y2CaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712041515; c=relaxed/simple;
	bh=LLCKE4A8nyzm0Hlt56n70RBLrr3fo5016WuImie0DPY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mdvTz8aqGBceY6BWbzUFLybxWBb8eFEepqcN6N4TL2HiVRTFF2DR+p6uxF7Kx9Vw7JcrmMXMUKY0iiGfZ5dSEjvox5f5GroV1q6hVliPbMBKPzKqCHeCXi2QIwGjM/ENe3aVTYY+h4rDYHeV+kcbZIH1dq/Z55h0jtozaDdsV9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=iOveFKgX; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a4e39f5030dso441819166b.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2024 00:05:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712041512; x=1712646312; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JYwBryX2K8ODu6f2N4BEpdau6lQG6ZayVMvLvmJsgP4=;
        b=iOveFKgX4KpqVrUg+j/onJUvzODOFsbDXczm7qUgdKyCXDh0AYZhVbmKHcYiN7ytRl
         EroFxj2uC/0OLGmtNwQHhkmyIf9xQnKnXqsNLNCeEovyPXqzekHtZ7JndEFWhvHBfxT4
         JpebqL4sJVeKj6CKANyz2817Mwtax2v48QGN8y5uEaBdGIdVln2CSaAA7Z9eOPQuHAfX
         ATPXkK/u0qs4oaZrR2Kp8Nrbj4oBsQXnn+EiL7xdZ18LLjWvkJNE50X0eyGUC/1fh468
         yw0VyJpvO8LEfg26QbBF0KSZeijOk1vw3dh8Wxr0brlWZ78s7SuT9jvgyfCXS0SOetEr
         O42g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712041512; x=1712646312;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JYwBryX2K8ODu6f2N4BEpdau6lQG6ZayVMvLvmJsgP4=;
        b=Q3Df1aKSNVMg/I/lDnd3hJt5EgUssNU4VZmRplCPiaZbV/1cmEY/Y7AD60/kVaK+Fg
         C3KI7FJ0oMPHMqEvRSgG6o9stpCWpQ8ObWAKrzhqhJIxk3ztgvkavKwDER5kGdx9xaI3
         lIATY0ZOB1jZS9sqHYskNSPwJXCqP9CJ7c0sK/XeMDwX8MrNfxZtk468d8D1QdP9+K3f
         FHSG58DE0TqFWCse/tQMxbh8VwKuc/bkzXASoyBKDsJOya27VmJMy0UNpnNCV3U8bBAi
         2rvso62B0N02nxPmQH4nGZ0PPMl1slD68V2gAEwkGUyiXeLTqOXRieP7uueECCYei06B
         PXGA==
X-Forwarded-Encrypted: i=1; AJvYcCUg8yJcL/tr+v5dZATDL1+Ht1QCx3JtP2EhsdnocHwcyQFUhY1XGOU64gRkDXHXu4iQUSMsUqoVdR/5GcZ2wnmNSTqKrJobdgVBzPKS
X-Gm-Message-State: AOJu0YwjZ7mN7oZoV50DJBkH1zSPS95pF4iTaLoLnTG3evWLqqBspXh3
	YQxl/sEjqYDINqbjwJ1z6XRf9mVXkOwi87AtavPMVXFZ9tmIRZsuGIWzdQ219K0=
X-Google-Smtp-Source: AGHT+IE4i0uE4zNMajZPn9EDb6fr5Exl+ezBg3jCQtWEO1B/zUdsRoEB2jy2LtigWsB2ZUsWxOxE8g==
X-Received: by 2002:a17:906:b047:b0:a4e:d27:30ab with SMTP id bj7-20020a170906b04700b00a4e0d2730abmr8456776ejb.59.1712041511989;
        Tue, 02 Apr 2024 00:05:11 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id wv11-20020a170907080b00b00a4503a78dd5sm6189435ejb.17.2024.04.02.00.05.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Apr 2024 00:05:11 -0700 (PDT)
Date: Tue, 2 Apr 2024 10:05:07 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Meir Elisha <meir6264@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Yang Yingliang <yangyingliang@huawei.com>,
	Ruan Jinjie <ruanjinjie@huawei.com>, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Staging: rtl8723bs: remove spaces before tabs in
 rtw_set_key()
Message-ID: <e26e8d4b-ce02-497f-a015-c2d2eab9bda2@moroto.mountain>
References: <20240329150953.17350-1-meir6264@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240329150953.17350-1-meir6264@gmail.com>

On Fri, Mar 29, 2024 at 06:09:53PM +0300, Meir Elisha wrote:
> Remove spaces before tabs in order to improve coding style.
> 
> Signed-off-by: Meir Elisha <meir6264@gmail.com>
> ---
>  drivers/staging/rtl8723bs/core/rtw_mlme.c | 36 +++++++++++------------
>  1 file changed, 18 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme.c b/drivers/staging/rtl8723bs/core/rtw_mlme.c
> index bfb27f902753..5a506fe4698b 100644
> --- a/drivers/staging/rtl8723bs/core/rtw_mlme.c
> +++ b/drivers/staging/rtl8723bs/core/rtw_mlme.c
> @@ -626,10 +626,10 @@ void rtw_add_network(struct adapter *adapter, struct wlan_bssid_ex *pnetwork)
>  
>  /* select the desired network based on the capability of the (i)bss. */
>  /*  check items: (1) security */
> -/* 			   (2) network_type */
> -/* 			   (3) WMM */
> -/* 			   (4) HT */
> -/*                      (5) others */
> +/* (2) network_type */
> +/* (3) WMM */
> +/* (4) HT */
> +/* (5) others */

This comment looks weird.

>  int rtw_is_desired_network(struct adapter *adapter, struct wlan_network *pnetwork);
>  int rtw_is_desired_network(struct adapter *adapter, struct wlan_network *pnetwork)
>  {
> @@ -1052,9 +1052,9 @@ static struct sta_info *rtw_joinbss_update_stainfo(struct adapter *padapter, str
>  			memset((u8 *)&psta->dot11rxpn, 0, sizeof(union pn48));
>  		}
>  
> -		/* 	Commented by Albert 2012/07/21 */
> -		/* 	When doing the WPS, the wps_ie_len won't equal to 0 */
> -		/* 	And the Wi-Fi driver shouldn't allow the data packet to be transmitted. */
> +		/* Commented by Albert 2012/07/21 */

Nobody knows who Albert is.

> +		/* When doing the WPS, the wps_ie_len won't equal to 0 */
> +		/* And the Wi-Fi driver shouldn't allow the data packet to be transmitted. */
>  		if (padapter->securitypriv.wps_ie_len != 0) {
>  			psta->ieee8021x_blocked = true;
>  			padapter->securitypriv.wps_ie_len = 0;
> @@ -1916,7 +1916,7 @@ signed int rtw_set_key(struct adapter *adapter, struct security_priv *psecurityp
>  	u8 keylen;
>  	struct cmd_obj		*pcmd;
>  	struct setkey_parm	*psetkeyparm;
> -	struct cmd_priv 	*pcmdpriv = &(adapter->cmdpriv);
> +	struct cmd_priv *pcmdpriv = &(adapter->cmdpriv);
>  	signed int	res = _SUCCESS;

These declarations look bad.

>  
>  	psetkeyparm = rtw_zmalloc(sizeof(struct setkey_parm));
> @@ -2021,8 +2021,8 @@ int rtw_restruct_wmm_ie(struct adapter *adapter, u8 *in_ie, u8 *out_ie, uint in_
>  /*  */
>  /*  Search by BSSID, */
>  /*  Return Value: */
> -/* 		-1		:if there is no pre-auth key in the  table */
> -/* 		>= 0		:if there is pre-auth key, and   return the entry id */
> +/* -1: if there is no pre-auth key in the  table */
> +/* >= 0: if there is pre-auth key, and   return the entry id */
>  /*  */
>  /*  */

Bad.

Nobody really cares about spaces before tabs.  The more important thing
is that it looks ugly.  Focus on what matters more.

regards,
dan carpenter


