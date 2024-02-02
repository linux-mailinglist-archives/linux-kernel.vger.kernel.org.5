Return-Path: <linux-kernel+bounces-49404-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 468AB846A0E
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 09:01:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 785961C2A275
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 08:01:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BA3C182A7;
	Fri,  2 Feb 2024 08:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JaDiqhMm"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B767118030
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 08:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706860838; cv=none; b=R1PD3q6wvQ7BhZs094nY9rceyVuhbfz8bL5SaG1yQnm1ZpqP6arKhlvcUyNsFQJN1h7B74FHjTl7Z52NuslZii6oJ50Tr1Z9WcWAufT0hOmCjlJlKqUyVberDSAaHmwdwOjfW2hOCR3xQ+tpKXvKZHHy+REPErajHT/OdvZnWWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706860838; c=relaxed/simple;
	bh=5C6mtoK2qwsl7ZgvWbaVivd7y93FRbznXiXFi9bZTPg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EUjjuwWtBb6rRNs5Ug+MvN6gHzCRr3TnGhGTMA16LNCrKXBCXGrWFrD7jPDfyM5ajUbsKvMJ6d7+Q8Odb9SnxCqbyBVMSohDOrzMtUGfPQ5aqnGi7+DpS2M/VlagM/l5yf+AhFFj1hjQPszROsiKGxqUhPT9L+kPLuNqVufZAvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JaDiqhMm; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a36597a3104so248981966b.2
        for <linux-kernel@vger.kernel.org>; Fri, 02 Feb 2024 00:00:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706860835; x=1707465635; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CH9v3LCO5nHQUt3/kuRRJfaPWt0ulylMcQsh3OeI2hY=;
        b=JaDiqhMmUI3b13sypbzF/cq6xk3dIoV0Q2PIaej9tUQrZVASGC/0BEEz5HhE8NNJOT
         sgzprBSc63pPAiWjjkcOM7NVE14D515pKOFF+Vdax1QClHdimXZ8S9XKMwmpopKUHIUB
         qinEWa/D/u1Cy7dNQIaP7SIcj/upIJsFWoen5twhQdN16SJWk6tqu0txvYvk7A7reyeZ
         3ozfDdn+WcG5CzlRQz3iH12dH9WWVFFxPOkEPv6Hm8vvykZOdFQ9l+xOEjFzlTQSBeM4
         gpl+bGXfCnth9ZuodyIQXsGAshRMcoG/IlFkAfrR2c4YrQYS/LJuO4K5fOuhmLmoQ1Cw
         CcXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706860835; x=1707465635;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CH9v3LCO5nHQUt3/kuRRJfaPWt0ulylMcQsh3OeI2hY=;
        b=TWanjjDHvjqKP8bTXabs9M/ZwQlJVK49QkaOdtGovgfbFTazWUqwEqQmMsdDJCKGtk
         CWvv4mu9s7OR7QleaIynfA7rEUD2rB+dW+p+mp7DmwMzkSG+GWti/vC1odzYZ0CsfxZ3
         7WkawnnSl9xzcWIEDHnTy5lqLJXYasDZuMYDFIAch7HCp068WBV8XtALd5cLqVIa1A5U
         ND0pXyA3aZD03ZwG2shnoPnjGAVAlG59QCa+H6mIQF07s95HZnxBUUS8Iv6+GUw1yE6O
         6wGG9ZZZtM+xJ7QmMJ2ivdGxnNEmruikdMFyAm+rD3VSSj4nGB+Qed6XkMve6T0pc8JL
         Wlxg==
X-Gm-Message-State: AOJu0YxhNq0RKmhKkka0PehlTCdk10hegUXPlujnoXjxjB8wfd+KB0YN
	ZlaPj545aMiO8x0h0GwQpf59AXS+JlUZt85G3AzNdfm345+MlnzI6emVC3LAdsgY5nau73DqJiE
	O
X-Google-Smtp-Source: AGHT+IFAaPKR1CV3s/S5gqowYd2TGEghpCGQ9spaAICaF6GW8iRHbkjrt0f9pwME8hYTpTinDKLeqw==
X-Received: by 2002:a17:906:9c43:b0:a35:8d47:70a with SMTP id fg3-20020a1709069c4300b00a358d47070amr746597ejc.36.1706860834910;
        Fri, 02 Feb 2024 00:00:34 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXwZSz6WlkQqMIGhBTSJkaR/WejvNIGOorNU8wowqgR+ymm10on/sT8ADGPlGMt9oYdwF50Hs1+VSLfug5897nSJuq3elGM2rqS8v1sJya/LMUhTB/Tjl6odIuzanZp/gTSDNqO7IYDv4xpWtJMfYx4YAf7jJH4nvHLsiYFyc7lNYHbNys67r2DzxnP51lH5P2Ohpe7rdmZBOi277IMxQpY17SRs3KEBKSRBNOS8NLti7wPV5C43e0BwKCIrrtjZeBCD8tEo3npDB5cRQ==
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id ti8-20020a170907c20800b00a3617097f49sm603096ejc.101.2024.02.02.00.00.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 00:00:34 -0800 (PST)
Date: Fri, 2 Feb 2024 11:00:27 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Meir Elisha <meir6264@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Hans de Goede <hdegoede@redhat.com>,
	Ruan Jinjie <ruanjinjie@huawei.com>,
	Yang Yingliang <yangyingliang@huawei.com>,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/4] Staging: rtl8723bs: fix else after break warning
Message-ID: <9f3378b0-916d-4213-9696-854c970ab383@moroto.mountain>
References: <20240201140459.438479-1-meir6264@Gmail.com>
 <20240201140459.438479-5-meir6264@Gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240201140459.438479-5-meir6264@Gmail.com>

On Thu, Feb 01, 2024 at 04:04:59PM +0200, Meir Elisha wrote:
> Fix checkpatch warning:
> else is not generally useful after a break or return
> 

This commit message doesn't work.  It needs to explain why you didn't
just delete the else statement and pull the code in tab.  And, honestly,
that's what you should have done...

regards,
dan carpenter

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme.c b/drivers/staging/rtl8723bs/core/rtw_mlme.c
index b221913733fb..c99fa5f1716a 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme.c
@@ -1552,10 +1552,9 @@ void _rtw_join_timeout_handler(struct timer_list *t)
 					continue;
 				}
 				break;
-			} else {
-				rtw_indicate_disconnect(adapter);
-				break;
 			}
+			rtw_indicate_disconnect(adapter);
+			break;
 		}
 
 	} else {
@@ -2103,12 +2102,12 @@ signed int rtw_restruct_sec_ie(struct adapter *adapter, u8 *in_ie, u8 *out_ie, u
 	}
 
 	iEntry = SecIsInPMKIDList(adapter, pmlmepriv->assoc_bssid);
-	if (iEntry < 0) {
+	if (iEntry < 0)
 		return ielength;
-	} else {
-		if (authmode == WLAN_EID_RSN)
-			ielength = rtw_append_pmkid(adapter, iEntry, out_ie, ielength);
-	}
+
+	if (authmode == WLAN_EID_RSN)
+		ielength = rtw_append_pmkid(adapter, iEntry, out_ie, ielength);
+
 	return ielength;
 }
 

