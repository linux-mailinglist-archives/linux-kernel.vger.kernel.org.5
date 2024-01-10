Return-Path: <linux-kernel+bounces-22744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7935282A268
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 21:38:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10B1E28B034
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 20:38:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 973D84F60E;
	Wed, 10 Jan 2024 20:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WZ4qXoCT"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 517094EB42;
	Wed, 10 Jan 2024 20:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2cd61dd39d9so32075991fa.2;
        Wed, 10 Jan 2024 12:38:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704919095; x=1705523895; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4HijGEv5O6Rg6COZBqqJMkL7r/71WgbM9Y/yBBvUJU8=;
        b=WZ4qXoCTSMrTi2FYnRaLg0SPuQh7/iQcnv6W4xMLTJfu24xAx66Qmxr+T81QzEbXiD
         F/etByaa0GYQ9S5jctz0wVqGdNgufksgX9/lWPi51GwYCiVsvODjlCXl2cuDvE5tCWkW
         +U+pfE/QYiQ8P4Xecd655X7+Ibwx9z2mujbAQk34+cLQp6ljzwrhOm2aohu/+c1D5i+I
         9eXcGwzCTjY498tR25HXEzk6gC3zBaywnNYUtqkQ8zgNfOWlAxr/tFZ8Mm9vQbblgiHK
         tiGu16Ezt8pHqYP5S8dysfIUZNx/oAdoQ2ZQpG0yFwkgUkdSg7UMLmJ+fR+SVTppJGmE
         Cm3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704919095; x=1705523895;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4HijGEv5O6Rg6COZBqqJMkL7r/71WgbM9Y/yBBvUJU8=;
        b=Yt6j0DbIsnfre9NvYzuUX9Re+Svi9GHzeHPRWErURJoCpyq3ntOodZLJtw4wfaYt9E
         LTuw37y+2iLauKXX1mrqKAKe4/Y2v7/6rYpghDB43ZfmyTU2JoBUK00WtjCGm/Cw5gtW
         ANrTz7XdbIz68HatrRoQaA9M9w/dmtGaPFoLlM5vtGoMVfaTPByQQ8uN3AZquTPGgt9a
         WUcKROAG2sIjocH5InCqIS6yguJqcio1ASbXPgtTf9VNS4PNXQVcVcJ82ATkiYdTOsjh
         fx0VTFVgUyNTbfD+2QUOQ6kO0A7Uc1aTbtUegNuNHZyqK4hRgERTpnUw0ZDDZxlRZ2MR
         50ig==
X-Gm-Message-State: AOJu0Yw7Wj4h+TmE/HxjWLHI+2UeHUzOYR3EIpBZPmpKeSlQitaxHH+L
	bmJrD6nxTdF1PQu6/MMJxYdQNBsMKMw=
X-Google-Smtp-Source: AGHT+IHUWOD6ZPZPWP5+JAG0s2SVFqjmxfdVjr9dNMtbi5+wOshQEQs92Ns0pcr9h0LXrqQsoQHfyw==
X-Received: by 2002:a2e:9898:0:b0:2cd:5530:2505 with SMTP id b24-20020a2e9898000000b002cd55302505mr75209ljj.28.1704919094726;
        Wed, 10 Jan 2024 12:38:14 -0800 (PST)
Received: from [192.168.1.105] ([178.176.75.65])
        by smtp.gmail.com with ESMTPSA id t21-20020a2e9555000000b002ccc6f06e2dsm865183ljh.128.2024.01.10.12.38.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jan 2024 12:38:14 -0800 (PST)
Subject: Re: [PATCH] usb: gadget: fix max_segment_size malformed table
To: Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc: Krishna Kurapati <quic_kriskura@quicinc.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org,
 Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
References: <20240110203558.2638-1-rdunlap@infradead.org>
From: Sergei Shtylyov <sergei.shtylyov@gmail.com>
Message-ID: <9b22d817-c0d9-4e85-cda7-7843907a70a1@gmail.com>
Date: Wed, 10 Jan 2024 23:38:12 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240110203558.2638-1-rdunlap@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit

On 1/10/24 11:35 PM, Randy Dunlap wrote:

> Sphinx reports a malformed table due to the table begin/end line
> segments being too short for the word "max_segment_size", so
> extend them by one more '=' character to prevent to error.

   s/to error/the error/?

> Documentation/usb/gadget-testing.rst:459: ERROR: Malformed table.
> Text in column margin in table line 9.
> 
> Fixes: 1900daeefd3e ("usb: gadget: ncm: Add support to update wMaxSegmentSize via configfs")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Krishna Kurapati <quic_kriskura@quicinc.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: linux-usb@vger.kernel.org
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: linux-doc@vger.kernel.org
[...]

MBR, Sergey

