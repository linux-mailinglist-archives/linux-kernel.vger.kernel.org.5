Return-Path: <linux-kernel+bounces-159803-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36C6E8B344D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 11:39:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E69E9288F33
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 09:39:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 210E613F450;
	Fri, 26 Apr 2024 09:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Y1PtMS6a"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB82C13C9A7
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 09:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714124334; cv=none; b=SPSWXbuUuC/Grh8XMO4nhVrCaxnhbH9q+21vPAS/AqIiqL3BfMeIT017gYh7b8d/Bf7IZcnZSYeanlA+q6CoJpGCir/MjKIDlKlgrJKztUOH9WooPtKjksHw+Z8zrs6jrR3fAbiG+WD13lzcwp2r0E1OzgIdLNzmfSqDGWBhZM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714124334; c=relaxed/simple;
	bh=PuFTf1AFlRWPLS/KPnaj9eb2KIiGnxPhqAOjpFztONc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=duVYqWLuxCGn8omwDYfd8+dftqf3DeYCnDkCGnqym5DLNyrOwdIDBYEjB54WlYZKPZ9dVzMn/e2h92Tccvyw9haOoFdTO8IiDvo6TdtrmYmolKD7qZ0jU5QgerHJP5trBSEIzgwP025zjIyf/1kTTKB5ABWy8TVQoy5QJ6/a3h8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Y1PtMS6a; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-41a1d2a7b81so16952955e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 02:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714124331; x=1714729131; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9nIVCK79GHj0GYtUEHyinljVAWRX71EOlK/nPokKfxM=;
        b=Y1PtMS6aI+m+ST5J/EIkvPOg5HQJaWetSytwZWW4dO2tsyGQ7nshRqK9YaZp+lprA7
         K9PZaA+gkky489YaojQxkDR+NfgcRA5S711nflsCHPnesexlw7GcsSPB4inoZznkY7fM
         JPFT1uCqUR01onwR4sydDX05Yl7O0Vb5Uud70GUyOMd8WpQCl62GyVYs/xbHjC42eDZ4
         ugBZ7FpzUylLyuoVwBAJ4A86oaJByszHC+VWX67qhOpg3Ls4imMsG88nmYEv2V+A1XgR
         2y1NddoDClDjkAS4UrJgvy016rVArizBNMNgOoCidfT1+d9P3u9+nE7bWxFEL/X5myBC
         nRQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714124331; x=1714729131;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9nIVCK79GHj0GYtUEHyinljVAWRX71EOlK/nPokKfxM=;
        b=NilmfHfMZnEaLFUyiXnTKtxQv0byKccK10DTdXrarapNKsemxWEbEgnuVbRhWRPgd8
         uPcXjMhlC5AS5kg/t24jMoZOj/mtHTtcCMHtkxBqIlN/+xs2LNtdYZq0R7sX3GOKNu+m
         /55gM0sZPXW3sWWg2SwVjBhDeb+crHBIPnJY5a0DSXvAqwZfRucbR20pILay6/bafmzM
         wyp2Znga8btFu6YNAR5toJ9qJsZApPo7O/0bqjqAK+u7jxifCSsSSYLGntlYAbELWfsx
         gBNcxeZ7ytPoFTRJ0KfgYZ1K8pMLywCiLKNsbkpxlav8dngOxRxsv1Y6LR2VXnM0i1Jr
         XegQ==
X-Forwarded-Encrypted: i=1; AJvYcCWswlRLo8QUS00b791BT9CWzNXo1hcWP70FANSCduklrlue5yZy7NEEtf4iEd7IyC67lFWlx2YN6BtlddSaLgFuIhGoriHxTMk2FCSb
X-Gm-Message-State: AOJu0Yy5Rwc0dV8Qt+GMK6/LrhnpXHGIjZ4XEtxCmtEqbj7LGGmB4mGZ
	3mwaitlyaaMteGavi6NN3tC1OrCE7OsD5wkqFYFUP561V8/pJmkQYFk/BMAAiQc=
X-Google-Smtp-Source: AGHT+IFyrLVXYhZdFZZ13tOyusYkBJr5UHYai5KWEBZnmnl5mj33KLQmr+8FZdbnGnNZCINzO1P/6Q==
X-Received: by 2002:a5d:5f53:0:b0:346:f935:e828 with SMTP id cm19-20020a5d5f53000000b00346f935e828mr2505531wrb.5.1714124331106;
        Fri, 26 Apr 2024 02:38:51 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id z4-20020adff744000000b00343bd6716b3sm21932964wrp.99.2024.04.26.02.38.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Apr 2024 02:38:50 -0700 (PDT)
Date: Fri, 26 Apr 2024 12:38:47 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Sungwoo Kim <iam@sung-woo.kim>
Cc: Markus Elfring <Markus.Elfring@web.de>, linux-bluetooth@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	"Dave (Jing) Tian" <daveti@purdue.edu>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH] Bluetooth: L2CAP: Fix slab-use-after-free in
 l2cap_send_cmd
Message-ID: <dd466a68-f3ae-4dc1-8389-6adc463735db@moroto.mountain>
References: <20240426072006.358802-1-iam@sung-woo.kim>
 <964b0005-3a9d-499b-91d3-171a3c917b4a@web.de>
 <CAJNyHp+WFONaNbZVK3tPcT=9obEiuE3MvQzJK++HP-ffNdfX0w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJNyHp+WFONaNbZVK3tPcT=9obEiuE3MvQzJK++HP-ffNdfX0w@mail.gmail.com>

Please just ignore Markus.  A lot of people have asked him to stop
commenting on commit messages but he doesn't listen.  Here is a message
from yesterday:

https://lore.kernel.org/all/2024042547-shimmy-guileless-c7f2@gregkh/

1) It doesn't matter at all if there is anyone in the To: header.
2) You are allowed to ask questions.
3) Yes, the commit message will need to be changed but first fix the bug
   and then we can worry about the commit message.

regards,
dan carpenter


