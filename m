Return-Path: <linux-kernel+bounces-297-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C0F5F813EE1
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 01:58:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 001DE1C21F68
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 00:58:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD7E4808;
	Fri, 15 Dec 2023 00:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sAJgrFuq"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CA43363;
	Fri, 15 Dec 2023 00:58:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2EF8C433C7;
	Fri, 15 Dec 2023 00:58:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702601912;
	bh=q56iNOgi3CDlqut6FMHVRVsKl4pDRDcxfCKmS0z4LCg=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
	b=sAJgrFuquMte/MZ0qR0ZkZ+lMGS95RuQWoOi+dieylTdd1TPtM++RpJi/l1SB03XL
	 ZJgfdBDOItBWes52UfJ4zGswO1imr/fwpZFToZCpokAiVlXA7SRECdTSkYCuDIyGkG
	 +J9TsKqb4aad/CELeliVvX8xr+8f9YkVzx4O9aeeXjEMP8vk6cVYvp2H/By2K2ZNdO
	 IZ7Rje+t5V/+tPjmNOOAkvzl0TXQOYVgGHee1cBciw+ZaynCTGx0amwbDeLPf/cRDr
	 UhI3eZXNfSLFTSpMqNkFQPwnMX9BkejN4n2v8uv7A04x8Ci1p28wNQ9iElzTpk1+X2
	 bYVuLZsAVX1dA==
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-202ffc46e15so69627fac.1;
        Thu, 14 Dec 2023 16:58:32 -0800 (PST)
X-Gm-Message-State: AOJu0YxHBGoHbQG7sx9WzMI9KvgTG1DNf4gf/CngLxWHpsvDLa1Kgx5z
	L+wAyP9zNQgPPgPqlr5RbDwS4DdwQbe+q0WKNxY=
X-Google-Smtp-Source: AGHT+IElLcw7GHVk+pThxMVyLR3DLJO3KFmq13E+jiAW6K+c6UnopC14Z5fxnwypmim0a9tLv3P0P/hOXSZju/K/t4M=
X-Received: by 2002:a05:6871:691:b0:203:23ff:589b with SMTP id
 l17-20020a056871069100b0020323ff589bmr2654657oao.63.1702601911967; Thu, 14
 Dec 2023 16:58:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Received: by 2002:ac9:7f88:0:b0:507:5de0:116e with HTTP; Thu, 14 Dec 2023
 16:58:31 -0800 (PST)
In-Reply-To: <f9d067e773f1cb3e9d4af19f18e80d7d35a71153.1702587034.git.christophe.jaillet@wanadoo.fr>
References: <f9d067e773f1cb3e9d4af19f18e80d7d35a71153.1702587034.git.christophe.jaillet@wanadoo.fr>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Fri, 15 Dec 2023 09:58:31 +0900
X-Gmail-Original-Message-ID: <CAKYAXd9YiYZBcJNRBJVBoCW3Ase+3zzEhYcDmuDG0mgu=smRww@mail.gmail.com>
Message-ID: <CAKYAXd9YiYZBcJNRBJVBoCW3Ase+3zzEhYcDmuDG0mgu=smRww@mail.gmail.com>
Subject: Re: [PATCH] ksmbd: Remove usage of the deprecated ida_simple_xx() API
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Steve French <sfrench@samba.org>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Tom Talpey <tom@talpey.com>, linux-kernel@vger.kernel.org, 
	kernel-janitors@vger.kernel.org, linux-cifs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

2023-12-15 5:50 GMT+09:00, Christophe JAILLET <christophe.jaillet@wanadoo.fr>:
> ida_alloc() and ida_free() should be preferred to the deprecated
> ida_simple_get() and ida_simple_remove().
>
> This is less verbose.
>
> Note that the upper limit of ida_simple_get() is exclusive, but the one of
> ida_alloc_range() is inclusive. So change a 0xFFFFFFFF into a 0xFFFFFFFE in
> order to keep the same behavior.
>
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Acked-by: Namjae Jeon <linkinjeon@kernel.org>
Applied it to #ksmbd-for-next-next.
Thanks for your patch!

