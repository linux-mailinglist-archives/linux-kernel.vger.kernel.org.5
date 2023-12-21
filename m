Return-Path: <linux-kernel+bounces-8106-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D76F81B23D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 10:27:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 135E41F21DC8
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 09:27:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44BCF50241;
	Thu, 21 Dec 2023 09:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GJ7eYtZl"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 749374F8B5;
	Thu, 21 Dec 2023 09:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1d045097b4cso3737425ad.0;
        Thu, 21 Dec 2023 01:17:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703150265; x=1703755065; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Zy5fYk5yDFfc5MecTU/b1uM8JTuFAaLBpt7UpnKQhPg=;
        b=GJ7eYtZl5fkJaYKWVtAKMGTapD1PaNl1UDI61nsvPIPzwLiCcAu/pvYWc2zqShQzfk
         fMnVHlwV0Y5n0yXyv4B2c2dyxnAIkVE0W9IfvPDZY8YFi6D/itwP92qtYCavYzd+fSPm
         c2s3N6JJcgB4HHyxhfGloEMz3Yos5SB6p8/vORKEVMNR5PmUoTl7OcdBZdpJ2WcSyHpu
         7edAvEqg4wNPh7jJUK+XsWHZM0WfM3TcrwhGmdbh/6rar81TblcVCBFLvAzVTVUQXJ55
         L7OsQsja+EzVw87kFPwYrvfhO0V7KPtrnh1r/oxSghVv3fbwGwe2tpgO/rYUWdm7Aqnm
         jj3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703150265; x=1703755065;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Zy5fYk5yDFfc5MecTU/b1uM8JTuFAaLBpt7UpnKQhPg=;
        b=hUz8rpuam1AmK7FRPEzTEeICyQ+94975fb86jMuZGz6+taIMFF3SmhIL+F9gOEOBZL
         O5IvtJ1RSgYP9iui8MPIZmzLtxH9cwcY6oCqTbY01pFTMlEkv55ApP0U3iexgjkb6tU6
         CZbwF4CzoU7zSP1efVNQgD7KEemGn/RXc6CUeRGcqIOCLUd30UzjOCSWoMU0h1dyOMmm
         gRfZKi9CEhMvDnFb62rYA/IY+GnOQ+ySmhZtwLdMx/DP5Ys8SF+HMwalMZPhVsdXjaqh
         tl26VU6TyMgG7/cQR41+8sMs8HAeozTv0vhBAb/YW521AoTz4vbqGjFYsD15FODMQp/G
         8vJg==
X-Gm-Message-State: AOJu0YxEI+y9XYww+3WPAje03MCVpNI5BXQ34ixHxxJ4a2cyu91veuD+
	TpIA6JjrDqWnDq/fYrTNkMxqFAVYpbX4Pw==
X-Google-Smtp-Source: AGHT+IGJwATCU53PsVXUBLoFjApVwkYLAw1meIU+j4poFsW15zB8XY5w9vKHGO85ifAtXUYKuACnnw==
X-Received: by 2002:a17:902:da89:b0:1d3:c202:3d4 with SMTP id j9-20020a170902da8900b001d3c20203d4mr4807069plx.15.1703150265495;
        Thu, 21 Dec 2023 01:17:45 -0800 (PST)
Received: from [192.168.0.106] ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id h15-20020a170902ac8f00b001bc930d4517sm1144692plr.42.2023.12.21.01.17.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Dec 2023 01:17:45 -0800 (PST)
Message-ID: <ba2ac330-d977-4637-93bc-99ee953faab8@gmail.com>
Date: Thu, 21 Dec 2023 16:17:37 +0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 0/2] ISDN/mISDN maintenanceship cleanup
Content-Language: en-US
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Networking <netdev@vger.kernel.org>,
 Linux Kernel Janitors <kernel-janitors@vger.kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Kees Cook <keescook@chromium.org>, Jakub Kicinski <kuba@kernel.org>,
 "David S. Miller" <davem@davemloft.net>,
 "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
 Justin Stitt <justinstitt@google.com>, Kunwu Chan <chentao@kylinos.cn>,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 Nathan Chancellor <nathan@kernel.org>,
 "Steven Rostedt (Google)" <rostedt@goodmis.org>,
 Karsten Keil <isdn@linux-pingi.de>, Karsten Keil <keil@b1-systems.de>,
 YouHong Li <liyouhong@kylinos.cn>
References: <20231221091419.11764-1-bagasdotme@gmail.com>
From: Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <20231221091419.11764-1-bagasdotme@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/21/23 16:14, Bagas Sanjaya wrote:
> When I'm looking at simple typofix against ISDN subsystem [1], I find
> out more about subsystem activity. It turns out that the subsystem
> maintainer has been inactive since 3 years ago. And also, when I test
> sending "Lorem ipsum" message to the subsystem mailing list, it gets
> bounced.
> 

Oops, sorry not adding the link.

[1]: https://lore.kernel.org/lkml/20231221024758.1317603-1-liyouhong@kylinos.cn/

-- 
An old man doll... just what I always wanted! - Clara


