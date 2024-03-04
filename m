Return-Path: <linux-kernel+bounces-90198-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D1ED86FBCC
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 09:25:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DBF61F2225A
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 08:25:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C4AB171BC;
	Mon,  4 Mar 2024 08:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="O9YoCm5w"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EABEF171B8
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 08:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709540717; cv=none; b=JLn++M7s9jlMxqo8dDUj9LRit4iETGme5fViC5MK6L3FVhv+O/QzDEn3kq0HkIyh2rkoKe8Vt4/9t7h2wBJH9bEx9TDWIpzOWyRIH5dfHyfTHKnU2gPITjb2J4xxwyqMX5wLE57J9EV3YM9cgtxioCrp7wtdkdKdrcFQeo/SPyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709540717; c=relaxed/simple;
	bh=PA43H0l92iEdSQLpl7NEJdLZAEyAWSnu7uYqTERALdc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qnNXlFrYT/sR+XELPibDR+Uv8NL3s+g21dm7XRE8hQI3VmwJQkxnIX3cv5vqu7P0UbOnh63Vg4ibYgxFaUXcaLGezvgV+k6hW5oyBnW96F5XXnh5YGc+lmVBanvU9wvkxQLlAZXuNCz804/5MfrA65RPq5nN2h8W4KXZK5gWm2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=O9YoCm5w; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-412e784060cso838625e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2024 00:25:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709540714; x=1710145514; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=G1k8H6YNmE9fVEof3VA99d+GcsZvQR5zaYJWZxNgnyQ=;
        b=O9YoCm5w/QjPPiYEwk9W7neaCnePg6F+wx5b+8/LmXb6HfwaYdmlikTdSpgvtkUu2R
         v9SGlrJksd6vSLljp4eYIPTYQ90wtTOrZLAeF02rGYSU0VUciPS4S2MkEs+1jWz4Hv4D
         BMnVApPtDWGogvNG1AqTSZQgOeRhaCQxRhyM+OQGsnzQ5YHbHXB0W+R4hcAb9vG/Micv
         dOVS5+ZX3YIIBLNY36ffStHClBFHJD4mh9gNS98lik3R0zJpltY2w1exPxAIUI5HjC5t
         Td+9h/QaoS5Nm1kEaslMj+ZFkHZmjABZtvpKQhsPx91nlkF44M7jN/IYBr/hN3bnjEn0
         IxGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709540714; x=1710145514;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G1k8H6YNmE9fVEof3VA99d+GcsZvQR5zaYJWZxNgnyQ=;
        b=fnMNwZxhf4dJy1xvjgHtBIU02NGvnJrOYA8+JrwmaURVyP83socoAGCBgtRbcXUzKg
         v3iplPrt5+fhLthu71uNMgv9LALr8zBYy5dEsX1Xn+l1Pcg40upAXIQO2s+56h/v217L
         6OF4ogt/pGqNtRd6dRYvAQK6g0cgXjgazE7LxGDORA1/laIpOEMQDOFDWV06G7tRK29H
         xhz/mpLY1IOv5OGE+Fr9/nkwrVIEb+JatIsK6NzHoq64q/wFMA35nRihCSJmc3Q7E4pP
         3S5wHJcp5P7zND6Ys2tr/WdoRhX9blS033xnq3YxSGhwIyGGASEioQRkoxVjP4LJd2Yt
         cKAw==
X-Forwarded-Encrypted: i=1; AJvYcCXrP2B9z0YqB36NAuFcXHbiKoTmFcs8NSfV/FQV12IfsFoe1zrAj9zPnOJqSTXebwv070QyVDT5ZGK7poRcHub2/FW5b0OOiJPS9QrK
X-Gm-Message-State: AOJu0YyR3HPkSEq6GJAW5v23hXC8Gx6VZoUuDG7BNUSndoHclRAzuFs6
	170bbRMRtW20NWhHY8McvhOVyY4nlrXEcWDL4qKxvO9L1Rz7VdNeLE8SwhoaPak=
X-Google-Smtp-Source: AGHT+IGRYYV2sBVydhBNDWXMz41tOoAB8DFTf7PFILtuT+3zsdGozNazJl76p4ctyMkytSLGw64LLA==
X-Received: by 2002:a05:600c:34ca:b0:412:c790:5a8a with SMTP id d10-20020a05600c34ca00b00412c7905a8amr7713599wmq.15.1709540714327;
        Mon, 04 Mar 2024 00:25:14 -0800 (PST)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id h9-20020a05600c350900b00412de55135dsm3950291wmq.41.2024.03.04.00.25.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 00:25:14 -0800 (PST)
Date: Mon, 4 Mar 2024 11:25:10 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Aman Sharma <210100011@iitb.ac.in>
Cc: Gregkh <gregkh@linuxfoundation.org>, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] Staging: pi433: Updated bitrate range from datasheet
Message-ID: <1440d44b-c16d-4307-9457-5c3ae44716ff@moroto.mountain>
References: <91454ef9b4a12f01e13d69b675d81aff@iitb.ac.in>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <91454ef9b4a12f01e13d69b675d81aff@iitb.ac.in>

On Mon, Mar 04, 2024 at 11:23:40AM +0530, Aman Sharma wrote:
> Updated bitrate range for FSK and OOK modulation from the RFM69 Datasheet.
> The values are mentioned in Section 2.3.2 of the datasheet.

Have you tested these as well?  Sending untested patches is not
necessarily against the rules, but it seems like maybe you have this
hardware and can test it.  Could you please talk about what testing you
did?

> 
> Signed-off-by: Aman Sharma<amansharma6122002@gmail.com>
                            ^
Missing space.

regards,
dan carpenter



