Return-Path: <linux-kernel+bounces-76351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2804185F5FA
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 11:46:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58F831C23941
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 10:46:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82D7A41232;
	Thu, 22 Feb 2024 10:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bZYz6kZR"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B4313FB2D
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 10:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708598763; cv=none; b=D8OzoFKJmectiYKbSAxqwBaowJwfslIjX8OLVUOwiZk0qw79+bWtZQTTYDYQ0l3oTmkcwDnia0N0X8mw9eoflqewUFsXTkooYv6m8IT1DVwLhSXuQJJs755HdfoY//kIf8Lkb/t2NrN6t+vwvE2ggKwFEAKd8LVRNQKQQAmnBIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708598763; c=relaxed/simple;
	bh=c+Am164OK8KhHus7xwiJiVHp4mqrOSD4BzBr5iW5bb0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y1nFqfLr7wfuuesYCxx0ttjlI/IebSRAMY1BNijjvQVTVDcDGINZZOnSVUlrRa/jMK+61++3I/J5Dqvx2G2cbiPLhfxxIK8fi+pcg15KVphRFHKr+08LADTZ/xEF8unhTU5s6LfSrCuaCSXrdU77Fs2Pf0JJ9Zus2qlla0t+7AA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bZYz6kZR; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-33d146737e6so5079233f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 02:46:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708598760; x=1709203560; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OpytlI5vC3wVN5F9RGMaAAniUyCYbok6OJJykifAV50=;
        b=bZYz6kZRZU/LrIq2ncq8URNhzZM/gQfNHtrAjBiJNAYxxw2gTEO8GbU08fY6kbvVNk
         Ng5GFZKEX197pJsPsy6hyYgGcyr7sx1fwZP72875ZZYluwgnul+GLQxHIqfmGS1yX6Ac
         DCutJjMnX76Su/8aaq53mp0DluYRfpdTwpuwrWZf4Lt6eVuIMLsZfrXOuYU1wFg96YuJ
         Vu5b83JNg9SE/wbS6NyMESaS9IxJjaNzEBZQGAEK5gWDDFV81SBTzw+rCv04Mm12Qfaq
         o3zBX0NpZwavyl7/UwehOK3VdPgEWcBc0cMZxcRoSigJ4oh+eNgKs7STyOKGvTJpRj7q
         bc8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708598760; x=1709203560;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OpytlI5vC3wVN5F9RGMaAAniUyCYbok6OJJykifAV50=;
        b=CPYLsB2AqQy5VhHrMBdGAU/GZC1SnKw2mIODv8NDCQdadazNovINtpmDqUo9DEgOFb
         V0RIDNaDuw0hQqPQyLlMAzg8f9cGNTkxGYUW/8/MQKSY97zkcwbVxg3pGkXrtBmXDCJ6
         Wv67UutXc5wn9YN8Rbno1AYEtmfSYJmPPOLffHtP6PJxLTWVCEA4aDfTDcZEGo0pqPQD
         OhwPzvIdDiI+xfKJK0km+Qfvm9KqNmA/HUmJAebrzG0DFBf877KKjHqQie8rBPoXOLOV
         9qGhpDq4USmdjX+6xkbpkXzrWmkYXBpl1VhksLnLOP79K3RWd1q/L4Fwd6pCeUXaI8Lf
         LU5Q==
X-Forwarded-Encrypted: i=1; AJvYcCVSKycGevBV+FQ2k8eeBAu07waeM+Ncs+ylgOpnd6TSMI7dmC/SaKiJj7SC5J+YyCEaUxjtvXnhDtdC5gFFzi2NLaAL5rOZLsiAzvys
X-Gm-Message-State: AOJu0Yzy66Xe3lZnZbFIOq4ccIqN7D86n8ebbYuXa0h+gYq9GGgCyqKf
	JwRUps9gglWsU+ZXJ3xaZi7B9bajPd9nz0SewZlWabGA5jHgkxrCCe3FY4dM1E8=
X-Google-Smtp-Source: AGHT+IHyFVlvKFVb/JOUH2jIASwAtIlSchBHJRJ7WOo963nkUWqxCW3AwPoDczaPeQvjwxnUcCWM0w==
X-Received: by 2002:a5d:4e84:0:b0:33d:7eb:1a6a with SMTP id e4-20020a5d4e84000000b0033d07eb1a6amr12769145wru.68.1708598759792;
        Thu, 22 Feb 2024 02:45:59 -0800 (PST)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id e6-20020adffd06000000b0033cf60e268fsm19710118wrr.116.2024.02.22.02.45.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 02:45:59 -0800 (PST)
Date: Thu, 22 Feb 2024 13:45:55 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Su Hui <suhui@nfschina.com>
Cc: hubcap@omnibond.com, martin@omnibond.com, xiyuyang19@fudan.edu.cn,
	cymi20@fudan.edu.cn, tanxin.ctf@gmail.com, devel@lists.orangefs.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] orangefs: Fix possible NULL deference in orangefs_mount
Message-ID: <3e4e23ca-5e00-43b3-91a7-690e690279e1@moroto.mountain>
References: <20240222102548.1426561-1-suhui@nfschina.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240222102548.1426561-1-suhui@nfschina.com>

This was already fixed in commit:
9bf93dcfc453 ("Julia Lawall reported this null pointer dereference, this
should fix it.")

Amusing subject...  :P

regards,
dan carpenter


