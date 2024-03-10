Return-Path: <linux-kernel+bounces-98083-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C4008774D3
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 02:39:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98DA11C209A2
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 01:39:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 151221366;
	Sun, 10 Mar 2024 01:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CKXm00mK"
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0845310E9;
	Sun, 10 Mar 2024 01:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710034766; cv=none; b=K3Hf0JWoppiR0vJ1vDOehpqCHCI3+B5k4F5/YyLMVEs+dIcAr/IpG9FzqGah9A36T/NqWCNaZWRLW26SzMq4HJcan4bfzIGyGSf6Qh8+8D/lcU08jMU+DNC9lL9Ejp/F+XK0WnHnjrddlFqv97t+w0BZ/n29USn6j3PLmZO2yOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710034766; c=relaxed/simple;
	bh=Hbv5dKqaLqBrgXClL9twOnok0X7YsUM8U4SrM79+aEc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HAEo4k7b9BL8h61zPICfMhyMZgfO2Rch/81OtEiVl05gtUIZDexN3fwhu95i/tVsyD/WZ4CPvpM3NBUKeekCNHT2RJyXx78p3T8miSIF9UK13S9qZn1O0PqUtytTOLfadNxxaulihNyQ1XTmkJRd/uVtDYKqGrJonxx4JTiPzO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CKXm00mK; arc=none smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-5a1cba5d46fso950513eaf.0;
        Sat, 09 Mar 2024 17:39:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710034764; x=1710639564; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=89dICWtcTgU7rYBclVDfmBzPExpeafeUhsNwlxxomUo=;
        b=CKXm00mKDeW2qxdbGXESAIJMau/mZmTF9uVBQkuv7OnXpn4BBnStryaFYhZZpBh0T7
         0Kbtn7YO0aTWaX37EphV69dx93j/+/EinVXicPkkMlv9bZduv6EJq5OeKj3HlTkATRtD
         K2pCif5RWvAiQ718xk5reP0ohZjMbjqQwlLmowUSL5B0OZOgCkl8/9VXm7KusiutSG0J
         yhEc1VNOsBF0A2WH+ifHCotAg64OjTyXqbNzyxLsVQMecs1p9fQr5Ip04GGcVUMRvssY
         UIieBo6SnB5qWr5eGB+FieMkzdgMhHHDxDE41gwKV0rb7LBtOssT0AdM0g4GH+ZR/PJY
         Q1NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710034764; x=1710639564;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=89dICWtcTgU7rYBclVDfmBzPExpeafeUhsNwlxxomUo=;
        b=X6YsyTnI3Ejky+9BBnAUPNRFIowhGs+jNluZXYOJ/lXeETq7rxrVYqe3HXr4rHIzRU
         QRkirElW4kP7yyDjvyTW9/ugctJPllu+Jw/4ES+SUVt9e7qSwy3y4Lpiqy5CTbRtlXeF
         UWIZxQSZbq5LKBf47ZE+eOAYGj5ggjce24aHR3Ti4VdaEbxNravO5BRfjVJy6S4Xh9oX
         F3RJjkTsj5EA3yFiFEd+MQ91472DKm+iIlBoYsT2IEM/BG1x5+DsRyojDz8inmfMvlgP
         cdVt/lcOrq1WApVwxzGi7i/4MQf/YaP3nT9SHeP7PW6jDXfLm96k3Rtft3e6TYb3TIuO
         ojow==
X-Forwarded-Encrypted: i=1; AJvYcCUq6O7KLfJtTf4ZB8S22CNAM3elolxq+89wJZi7YdLRT1F+aV+NKwGs6yY4F5imRRBFep8CZwKvvH8oW1kueJ6MdKSPbnTbkLGqJ6+U67HlYhZEyqYM46w5iMcxtmib9S16Hj4C69Mxu5spB9Ndz2KdPAhzYHjz5dz6JqAP37Amy6RHm016pqD+VVfLe0Pv
X-Gm-Message-State: AOJu0Yz+eASjh6Z7mUyjkKSWZiInmuIxBEk0C7Gnaa6qw4nbzvia6YGH
	NguVnVW8KbTQlCUvyFcpyabyj/oWjZlHh0IvvwohliLhLuVboC1dMJgWRVI/
X-Google-Smtp-Source: AGHT+IGa8LWghdsW4lGPMtbGDh64RIJVuU6q8Za08bnTmcCJbvG41L+9ZGzUXxOEHKCRwucHSW9QvA==
X-Received: by 2002:a05:6808:3994:b0:3c1:b335:12bc with SMTP id gq20-20020a056808399400b003c1b33512bcmr5386225oib.5.1710034763803;
        Sat, 09 Mar 2024 17:39:23 -0800 (PST)
Received: from google.com ([2620:15c:9d:2:5296:fec3:1fa8:a601])
        by smtp.gmail.com with ESMTPSA id w33-20020a17090a6ba400b0029bb5dc7c77sm1990101pjj.23.2024.03.09.17.39.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Mar 2024 17:39:23 -0800 (PST)
Date: Sat, 9 Mar 2024 17:39:21 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Ike Panhc <ike.pan@canonical.com>, Hans de Goede <hdegoede@redhat.com>,
	Philipp Jungkamp <p.jungkamp@gmx.net>, Gergo Koteles <soyer@irl.hu>,
	platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org
Subject: Re: [PATCH 0/2] map Fn + R key on newer Yogas and Legions
Message-ID: <Ze0PSaOQSJMxL_Ln@google.com>
References: <cover.1708399689.git.soyer@irl.hu>
 <170895405312.2243.4199399921923370447.b4-ty@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <170895405312.2243.4199399921923370447.b4-ty@linux.intel.com>

On Mon, Feb 26, 2024 at 03:27:33PM +0200, Ilpo Järvinen wrote:
> On Tue, 20 Feb 2024 04:39:34 +0100, Gergo Koteles wrote:
> 
> > This patch series adds a new KEY_FN_R input event code and map the
> > Fn + R key to it in the ideapad-laptop driver.
> > 
> > It affects two WMI keycodes and I couldn't try the 0x0a, but I couldn't
> > find any indication that the refresh rate toggle should not be Fn + R.
> > 
> > Regards,
> > Gergo
> > 
> > [...]
> 
> 
> Thank you for your contribution, it has been applied to my local
> review-ilpo branch. Note it will show up in the public
> platform-drivers-x86/review-ilpo branch only once I've pushed my
> local branch there, which might take a while.
> 
> The list of commits applied:
> [1/2] Input: allocate keycode for Fn + R
>       commit: 4e45fa464aeef4e803412b5dcce73aad48c94b0e

I am sorry for the delay, but instead of defining a generic name we should define
a proper keycode for concrete action even if nothing is printed on a
particular key on a particular device.

Please drop this patch.

Thanks.

-- 
Dmitry

