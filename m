Return-Path: <linux-kernel+bounces-4954-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D7DB818453
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 10:23:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03D161F25200
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 09:23:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 477E414270;
	Tue, 19 Dec 2023 09:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="aSsyqycr"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C940134CE;
	Tue, 19 Dec 2023 09:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from [10.10.2.52] (unknown [10.10.2.52])
	by mail.ispras.ru (Postfix) with ESMTPSA id B760040737B5;
	Tue, 19 Dec 2023 09:22:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru B760040737B5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1702977765;
	bh=WWF3YNN11SVW5+0GW8dd87ugjXyC0t8VZ4S66eU8nMM=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
	b=aSsyqycr9637ZJHqGmTHoneiXjdKNN//qnfowNxnUnIU2BkqvI4HVWVUUij9yRw/0
	 Q0ZXcOXun023inqmtrFk/txM1r/17/P0FGQzGkhpR7tqdo7ubsfU16TcEz923tCVXa
	 kbIR1ajyx02GxNRGHWk8jYm/b4RMkU1hGa0W7sro=
Subject: Re: [lvc-project] [PATCH] linux-5.19.y: net: fddi: skfp:
 Uninitialized data
To: =?UTF-8?B?0JDQu9C10LrRgdCw0L3QtNGAIEM=?= <alsp705@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 lvc-project@linuxtesting.org
References: <CAGMq193upjidhTnr8hK6cgbVpP9tNQh-YvR2GJN_2cxdDOYnPA@mail.gmail.com>
From: Alexey Khoroshilov <khoroshilov@ispras.ru>
Message-ID: <c68bc048-3a57-c95b-dae5-555284ec2122@ispras.ru>
Date: Tue, 19 Dec 2023 12:22:45 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAGMq193upjidhTnr8hK6cgbVpP9tNQh-YvR2GJN_2cxdDOYnPA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: ru-RU
Content-Transfer-Encoding: 8bit

Dear Alexander,


On 19.12.2023 12:00, Александр C wrote:
> Uninitialized data is read from local variable 'word_val' at pmf.c:1302.
> 
> Found by Linux Verification Center (linuxtesting.org
> <http://linuxtesting.org>) with SVACE.
> 
> Signed-off-by: Alexander Sapozhnikov <alsp705@gmail.com
> <mailto:alsp705@gmail.com>>
> ---
>  drivers/net/fddi/skfp/pmf.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/fddi/skfp/pmf.c b/drivers/net/fddi/skfp/pmf.c
> index 563fb7f0b327..3f24fbd82a73 100644
> --- a/drivers/net/fddi/skfp/pmf.c
> +++ b/drivers/net/fddi/skfp/pmf.c
> @@ -1084,7 +1084,7 @@ static int smt_set_para(struct s_smc *smc, struct
> smt_para *pa, int index,
>   int path ;
>   int port ;
>   SK_LOC_DECL(u_char,byte_val) ;
> - SK_LOC_DECL(u_short,word_val) ;
> + SK_LOC_DECL(u_short, word_val) = 0 ;
>   SK_LOC_DECL(u_long,long_val) ;
>  
>   mac = index - INDEX_MAC ;
> -- 

Something is broken with your e-mail settings. The mail is in HTML, not
in plain text.

Have you used git send-email to send the patch?

--
Alexey

